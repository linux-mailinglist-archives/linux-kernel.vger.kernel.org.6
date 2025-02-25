Return-Path: <linux-kernel+bounces-530418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE884A43337
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 03:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AA6D3B9093
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 02:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE70149DF0;
	Tue, 25 Feb 2025 02:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W/7FILt2"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CCA433D1;
	Tue, 25 Feb 2025 02:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740451189; cv=fail; b=mcKqJ5Tg3o8FD7p1yh5/bIri4OvovVnuyLbhQuIYfWBgkIJV0N53juVSddlEw/d2jDSVDTzFx+H12PY6capx4pphdMdxdbX40O10qhZCpUUCHVF/mWYorYDBVHxfRGv9dv8XDFK/9PrzHbGfazAp2iH4yAENVwepbUiLpjxfPO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740451189; c=relaxed/simple;
	bh=hr1PtAZ42scjVPaAN7OWZiuvIlWBOmNtMXHANRDI83E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FXB/4XjO3ipbjndJ0tI+yT+djWIPqqmi174vQGFAXefBSdH9sj57wASSDKMYDVPhnRK5Z0jRStS1UjITU2h00zo36EvL0GHpEa+o6M3LuV4Zcp2kEACWjzck57d+ZP/olNM+hnPJ4LK58BdingdHaO06B96bE5NndliIhQ3zXZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W/7FILt2; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aN9+nxd7m9eTOinNLkDBoanEZmI3pipPq/V3hZuY0Cqy8sizozmAB7yay21tU01KHSeSz+ITWUO/SPzDH0zAFDGMLfTOHBYeQHr5UcumQB1JYgattT2Erk1zho/8FOvbhCDwo2fpcRMSBYLRHRtWrW9SwTD1D4n3iazk04+j5DrtqaxmeUbJig4lLUMzAkVDH9qPPQ5aNiRQCHgmtBZcR0HbIu3Z2YlPPoXQMdpBYlHYaU7PG2bb9duFc+a5zufN0Sb988alGq4Maj0g14EH3pcbd75iOyV7acQ+J3KVUciV5pqkbgMu+qPBhoMIfM872tRAOeANs0Lgffa1Z1WNHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqOaKc4eJn7XazPugE9s8ekp5HVnXVgRlinylc48MqA=;
 b=ssu9BZwzoLyeBxM6o4VBI6UjwbSdbSiUJTaBI/AyNX+m8eV+DRgMcyVwZaTEbezeMvPRUBysU//KCv7njKDoSItsy2F5PwbAb7Y/XQWucZ3gDwfXcQ8l8HbIUd+pYf3QY6EdKIBL9zYYFaHxsjX9CriCdeZS37ODPknLpJ/pH6ymLxNeYLuYHrCHfsEqFfxJksqGMwg4gS2xJlmH830PE8uNq1TXgMiyr3o/gkTDfMGFS4wKEG/Ne6sFTd8+kdYaCCqpSxPFjgiBQADJJy0z7a4xK0Bpd3baIqrfbzuifAb/mePj6IBFKjc4cLU50bjnq8frbeh8XruA+eaIEYF33w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqOaKc4eJn7XazPugE9s8ekp5HVnXVgRlinylc48MqA=;
 b=W/7FILt2DLvB0+X1zFRxAA3axIL4GQeEMkdnZ/6jxr6emACaFKkD1Cuwo8t+YEu9QTatnOEmooj2doTkeIurrgCt5eCPASMiMK/V13t0BLtfC3tobEifiD+kjHr/E8+BYyJufyai4U8SIWwc77l5IM1qsXNqQRsAB3HePpznPPk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL1PR12MB5804.namprd12.prod.outlook.com (2603:10b6:208:394::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 02:39:41 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 02:39:41 +0000
Message-ID: <7a958091-84a0-4ec5-bd4a-3e5f973772e0@amd.com>
Date: Mon, 24 Feb 2025 18:39:39 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: asus-wmi: change quiet to low-power
To: Luke Jones <luke@ljones.dev>, platform-driver-x86@vger.kernel.org
Cc: corentin.chary@gmail.com, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org
References: <20250224223551.16918-1-luke@ljones.dev>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250224223551.16918-1-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:a03:254::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL1PR12MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: e8f3fca4-c264-4427-7724-08dd5545a7b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDdzUDV0RzVwYWhBSjJnUDd0NVkyRHg4ZHpiOEJGTU9BdmlLUzhkdjlmazh1?=
 =?utf-8?B?c0FXTVZzbVY2S2lqNFZYbjg1ZTBUZmN1b0Z6RUdrQzRtWkhONDRSSzNCSXdV?=
 =?utf-8?B?bEY3Ry9CTllkUloybnV3WlQvUVNQMjZaNG4xZTlVTndmVzEyK2JBbGlOMWdj?=
 =?utf-8?B?U3RuSHN3dERaL3Yvd1BndnhqbGVzMWQxY0hDT3BWanI0OXpjbVdYeE5uQTQx?=
 =?utf-8?B?bmtNVWM5aFVYWVBjeHYxVjdsbmdranVlNXR6aGltVUtyRUt2WHErSFBNN3kv?=
 =?utf-8?B?VG50YUNPN2hGK0VXMHA4a1FjUWowOSt1dUt2aWhQdE13azgrTWtaOXhuVkNY?=
 =?utf-8?B?WElWWG9wRVYzMlhwL0sxd0dBMjlmQ1lFU0dVVzkrUVYxc2RvNURLS0RITE8v?=
 =?utf-8?B?NXhDVlFNcENITzJGcU1QRjJrb012UWdzMDNld2RVOUs1bTFHYkkraHZJSjhq?=
 =?utf-8?B?THl1ZTIzamhwaldWYk5Hc0ZvNEVVY3BYeHcxR3BiWDdkZXFwaVlOaUdwdVJ1?=
 =?utf-8?B?YkFlV2xiUnBTa1NhVStzUG9mTTlmMFI0Wlc5UGJvUEVoaDNiUllVcitsQlJX?=
 =?utf-8?B?ODZub3JlV2ZEVE9pMXZDYTRCazFFZDh0dXlGTGw3VmpvditvTitpNmFGd2tw?=
 =?utf-8?B?S2tLdXhyVDFIQjFKd0dCRGViOWR5NC9wQ0VpZDVWNURHakRCYm9Qd0VUR1k4?=
 =?utf-8?B?bnF4T1dWblBuRzRjQ0lZNUVRamdTclo1R04rVGdEeFZIMXNsTjI2MUUxRldU?=
 =?utf-8?B?VWFrUGRvcTVnQWttWlZRd1ZER3YwSWxVdVRxS2wvZTlvVkVHelcwVDQ2MG90?=
 =?utf-8?B?dGRLa2Jra1lFaTg1ZjlVOVVQVUtnRVFoSHFibWgyNHlRQ0RYQlI4bGRsRExC?=
 =?utf-8?B?ZnhUcUl5K1V2Tnl3QjNVaEF6RTdTb3N6R285b2Y3S2Fqa1RoRStKTE92Y0Rp?=
 =?utf-8?B?ZU9seHptWHFiWFZkYnlSY2tULy9WckhJaXpUMmY1bm90b0twRjlqcmNjOVpQ?=
 =?utf-8?B?U2JCSGpxcjlhYU1vYkpIRnRiUlJzbzJkTXpHT0g5YWt6K0o1SUovRGIzUk9p?=
 =?utf-8?B?YytnQm1CaFhhblRWNld4a0RyV2l5elJld2szTnI2cU5VUDZKcjk1U3NmTitk?=
 =?utf-8?B?VDFYeFlpNThEeHFoemVFT3RLakFKaVF3NXJiTlRWL09ad2lYR05hMGZ1NkZI?=
 =?utf-8?B?cUhINmNWSDI1SUxNa0VIM1VBKzVDZ0JSYm1zSUUwZEk3OFg3blNMbUhETmNk?=
 =?utf-8?B?dmV1c0s1dDl6UnpsNUFxMC9CUzlMaGJwNjJnVW5ySFRaY1hTNjFlYkZMYUZP?=
 =?utf-8?B?WW1XQ0VsQ0JmM2U3eTc3TUdjZGd0VEFqbzlTTVg5dGRJWHFEMXdRSm41OGhq?=
 =?utf-8?B?NlI3eGlBR3ZQbk1xK3JDeDVDOXpjTDNZazgzWFZrUE1zK2I2WmhPejdQR0Uy?=
 =?utf-8?B?cEVuTHAwSTNGRTM2cTN0Wml3NG92cHlZU3N2RDQySUJ2NnZIM0l1ZUlRaEw0?=
 =?utf-8?B?Wm1OR2tHanJpZkt1Si9LM0sxcEpPRUVmeGhrbVBpa2tZQW82K0VqeHA1TE5G?=
 =?utf-8?B?cFQyZmRMWVp0RDRucHd4aU5GeFVlUEVqcklaYllrWlF4WktRMzE3SFNpVXUv?=
 =?utf-8?B?R244VmdQV2ZWa2xsRnJoZVZvaHB5SENjMUJSRGxPV3BJb2dxN2ZUVGx1Ujcy?=
 =?utf-8?B?R2p1ZWp1dWpFeXlXKys1U0tWQWhUTVk3UUpwZHVXSHd2bnBTV1BjTlVyWnBV?=
 =?utf-8?B?OU0wampielJXRjFwRWYzVVkrQ3J5eFJ3S2N6SVBSbWhEMDYzbGVjYXNEWDFB?=
 =?utf-8?B?bWNNMEJSWGRIQXhaUWQvZGsvVnVpM2lBc3RtRzJoUTJWOVVmTlNrQU9CV0tG?=
 =?utf-8?Q?31DENCE7zo3A/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFRJQkdYcTNqZzhud3IrTTAvNENwMERlYnprSDQ3TlpQRS9lbjd0bkhkMHpv?=
 =?utf-8?B?eDFBbHZJQzFCT1J3NWs0dFRDSHhzejJpbnFUMGRuRmRFbnhOaGREMnlxTU9N?=
 =?utf-8?B?VmdpUGxKUTBtNmN0aGQwUnoveGp2OFF2UGRrMVlCbVJ4Um1tZnNsVTBmNS8x?=
 =?utf-8?B?NlFIbnNQaW10bStnMjZzbk4xbThJNEl2WTRnc3pUS1lqd0VoUmVQQjU4NTRR?=
 =?utf-8?B?THU5TGt5L0pUZU1Ld3FuKzhXcEtIM0p4NXdYeXZTckJYT05TRzVnUGJHY3hm?=
 =?utf-8?B?Y0V4UVdQWXFjMDRaVGxRNFFRZGFkZGJxSkJzYk1lWlRDRWYwSVlheXozQ01W?=
 =?utf-8?B?N0lpUy9PcjJxejJuTU5tdUs1QnNnOWYzeVdmbnFkcnNBZThvVXlGenB6c3hy?=
 =?utf-8?B?T3hsL1pyTUM5dDVLeG5QVTZFWS9mVlVzLzREejZNUWw3enBTVEs1WVBhK0N4?=
 =?utf-8?B?K29XUHZuWmtnYVVsa1RhVmJSaWlmODZaaTUzWXVETWZiMjZNOEZWblFSc2NW?=
 =?utf-8?B?b1ZSMUg3ZUZhdzBRL0NuNHA3SmFyN1ZWb1NidCs5aFE4bnI3MExqaEMvcW8z?=
 =?utf-8?B?ck9zL3hWTVJkS1dTSXdaNVVQY21VUW9VVkNHVFliZ3pyck9sd1hFNUlzMytl?=
 =?utf-8?B?dE4wejB0V0hrK3VtUENZSTBtdzNBeFM0VFZxTFBLc1Q0STBSQ0ZPekJyV2lY?=
 =?utf-8?B?TWhXOEVWdzRkalRla3BXV2xqUmorTnZxZ2NoNjVPV0tqODJMeTVwN2MyWjZS?=
 =?utf-8?B?N1laN2hFc2pqckZqUzBKclkwY0dzNjZIeG92NnFiTUgwalpONEJmVWlTMTkz?=
 =?utf-8?B?Y2J2eEg2WnBVczRDM1hpbGw4L1l5N0U0K05XVnZvbTBwSittcVRMdmVxb2hn?=
 =?utf-8?B?MGVCQkpibEQzdnY1endCTWRNYytkMTVIY3hLSDZrejNaeCtjekZpdmMyM0ZZ?=
 =?utf-8?B?YW9ZcjUrOWlVQ0tRbDJIQVBwZXFzalJZNk1BTm9vdDduNWN3Mll6c3cwUFpS?=
 =?utf-8?B?eTNMbnhhWGdjTTFMVHRFdXlOa0V3dFpFcFZFbTFaczVOK2xkZUxJR2h5VGd4?=
 =?utf-8?B?SzVYZ0RBZy9Ya2VWUjljamtiSmE1Zkc3RC9FNTlNK0ZqQVREWGMrclZKNmVj?=
 =?utf-8?B?WWllMFY0UFJvb2VYQlA2UmN2SkRzK1M0NlBORHNydTEwRlpUZTh0bEI3cEZs?=
 =?utf-8?B?WnZwNG5sOEdpK2t1cm9WZHB6SzlmRExQSnJOcFdsZElJNWpIVkNiYWpubGdC?=
 =?utf-8?B?NDhiaDFWMXM3bS9LT0IyZThKZlNVZGxlMnVXcWNiUjB2NUw5aGdJSUlKK2tN?=
 =?utf-8?B?b2t4aDBNSlNZNXVNQ0ZFU3Z3ZVQxQjhQQzRZQS9talFqemZYaGVuZ2ZjT3Av?=
 =?utf-8?B?cFVuUmd6OXRKM2VDY2xXdXRINE40RVg1WFhTa2JCQ3VtdVJ1d3hpbHN6SmE5?=
 =?utf-8?B?SFJnMDdIMmphSkdEa2hhUUZUV1lic3BHdVd0VXFXR3ljcnpjb1J2LzN3QlVN?=
 =?utf-8?B?Zk9WSUdMOVNZeWIwTU01bndxSVVpYjBMMGpxTVdzZGd6Y3FqM2QxSlpaSUVp?=
 =?utf-8?B?ODYwY0kzMFNFWHd1UFN2bk1xbHlkTWdyTzJPZ2ZIWEwyUXlvcVNDaGhDWTRw?=
 =?utf-8?B?eGFRRDRoZXFHbjdRcm9lL3ZsOURHUVpmdUVLMm5xQUVLZ2pVQmNwRm9BR1pj?=
 =?utf-8?B?K20rMW9sUWJFdlM0SjRaMWhIeVN2elF2cVVTTEdFWmZCSVpuRmUwcCtzbHhF?=
 =?utf-8?B?VjA1SkdUbmZqbkdvKzM0NUM4SnpraExOU2h5bEMrN1NBNjV1ZE0ydUtvNUts?=
 =?utf-8?B?ZFFQT0dzQlUyMHFEZ0VoTytkcUszQVpDUGdCRXlIQmNWMzVOS0hjOVNRUkpq?=
 =?utf-8?B?enNabk1kcW91c3RNRW04bURXblpOL2lNMk9Rb284RWJlbWpBSmMvZ1pvWGhy?=
 =?utf-8?B?MXlzMFp3Z0FKOEtXSzVYNVNBMXl1Y1hYTC9yZHZUdVhGWG1WQkttUEJGM2h5?=
 =?utf-8?B?d1poeTVhL3ZzYWNMYlRMcHpnNkwxYkoraVFnTVNjOG1tMHUvZGhOcmhaRG43?=
 =?utf-8?B?L1UyVmJ6Y0NmcHRTVUtqTHJmOEl5VThtVEhWaTBBOWc5L01Uc2xpNllFTW0z?=
 =?utf-8?Q?IKXHGaG3squLvpzlOKedjDTrI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f3fca4-c264-4427-7724-08dd5545a7b5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 02:39:41.2805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k4Z849yUzNNnatQ357Vyd+L8q2OkhE+9WP1PvgicqCZD+GIHkLlQbe7BocFPzg2Uy/rJT9x0YUPdBp0eLzOnow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5804

On 2/24/2025 16:35, Luke Jones wrote:
> From: "Luke D. Jones" <luke@ljones.dev>
> 
> Change the profile name "quiet" to "low-power" to match the AMD name. The
> primary reason for this is to match AMD naming for platform_profiles and
> allow both to match. It does not affect Intel machines.
> 
> The quiet profile is essentially a low-power profile which tweaks
> both TDP and fans - this applies to 80+ ASUS laptops.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

IMO - this should have a fixes tag since this should probably go in the 
6.14 cycle too.

Fixes: 688834743d67 ("ACPI: platform_profile: Allow multiple handlers")

> ---
>   drivers/platform/x86/asus-wmi.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index d22748f1e154..de19c3b3d8fb 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -3945,7 +3945,7 @@ static int asus_wmi_platform_profile_get(struct device *dev,
>   		*profile = PLATFORM_PROFILE_PERFORMANCE;
>   		break;
>   	case ASUS_THROTTLE_THERMAL_POLICY_SILENT:
> -		*profile = PLATFORM_PROFILE_QUIET;
> +		*profile = PLATFORM_PROFILE_LOW_POWER;
>   		break;
>   	default:
>   		return -EINVAL;
> @@ -3969,7 +3969,7 @@ static int asus_wmi_platform_profile_set(struct device *dev,
>   	case PLATFORM_PROFILE_BALANCED:
>   		tp = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
>   		break;
> -	case PLATFORM_PROFILE_QUIET:
> +	case PLATFORM_PROFILE_LOW_POWER:
>   		tp = ASUS_THROTTLE_THERMAL_POLICY_SILENT;
>   		break;
>   	default:
> @@ -3982,7 +3982,7 @@ static int asus_wmi_platform_profile_set(struct device *dev,
>   
>   static int asus_wmi_platform_profile_probe(void *drvdata, unsigned long *choices)
>   {
> -	set_bit(PLATFORM_PROFILE_QUIET, choices);
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
>   	set_bit(PLATFORM_PROFILE_BALANCED, choices);
>   	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
>   


