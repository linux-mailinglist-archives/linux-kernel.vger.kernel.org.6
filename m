Return-Path: <linux-kernel+bounces-254707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC77B93369B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B22A284AF3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 06:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31382125A9;
	Wed, 17 Jul 2024 06:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vIw2stb/"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2088.outbound.protection.outlook.com [40.107.212.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FDF101C8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 06:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721196325; cv=fail; b=Ay1k0AQxNEjq8Uk2c2E+DJ3zk6wY0bEfe62haxbHxv4QDRbO4xYkFsP00vIrz2Lz3QPi1VdlSnj2KpaF/i3gQLsNoSacAJyG0mSSo8m74uZXl4uqKy2+Jdt9djIXH5ccUeHuuqTIlAyZI4heIfGifADXOGo8On5meoc2x16iHHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721196325; c=relaxed/simple;
	bh=gJsu4RSymddkIAZ8uyhofr6hOcEBxiSoUjr+cFTG6tw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=coOPsSjpelUbnUF64aadnjdfdvLTA75Y6OHpll7fRIwiUGrvMVcJxn7MH1DDnS8Yb7qjN+ZnmFqHbVzBt4hxvXC/mPqeUnwarapGzCCuCgEE0TnRJ5G1TBKn29H+n/3GCPkP+3gtGIDS0P1+ays6qyzOJgS6RdRRcPgDXpPV4Pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vIw2stb/; arc=fail smtp.client-ip=40.107.212.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jk2tqgrT/Xwr1PHuFrhUEaeO+fMrgmA3A/tNBHGMUbbgzNnfv8N4EYpIwSdIwM3AwX+Gyid9iwD7akPq0gQJizIapB1aYpu/dQT7rYdH8q9a/DmsPgaiSo81j+YDsvfI8gSOpe0YeXo+xjTQLsZ9np5sFpkpKtSCjPS/HWuoTZhtJFnyl9cxm++nvV1TR8GyniZbnzqoNb2OoYYVuvr6O+BkAY9kM3G0aiid7DNnpJW8mAVW/v1vLv3oLNrgimnlGaK00YacHdtpsyKK4nHZAqs2oD9vdkeEU1oSVXuT5il2XxB3A4hYYd340qqG+u8FcOMUdb72aHnzsqyi/pI0Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Im1f6ULEPugdWn4b+a8zj07yn4kAMgSfmYrxoigxCc=;
 b=bP3ZPoHX9cuHTw8Sb5kdII+hp/40Q4J+zJuyi8WZf7NszWzgMT5BOJVvdbmfZk5rqCKU7xC8uvm4F0DRcbvsz+XfugcxapPn57OiO/kdLVAK13Aam30y8DlQ/OVTOPmY+V1DqUXYt2iXztkmUSHiYS+gFZtR3Zb3I7TRGGogtRxiLiLSO6GIRVNSMCoRJRfhtk0FYn2x+MdmOWS+VU4qMhy53GcDg1nlhDSii6+Lmx45giiOCWKrHDa0JMUMqcTrlaagechG+vZQUgoa2crMpkQM+KzjRg1r8iKgEXxwgt9qDe3shWEdzwoxiG4LnIi+WI4caAjVAh+4mFmT7bKYdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Im1f6ULEPugdWn4b+a8zj07yn4kAMgSfmYrxoigxCc=;
 b=vIw2stb/sasNmD507dNuMQKqCsgCI2NFlzSzEa9yDUK/aiil6vYQorg9fnBBtjA7MW9KwHZzxba0EH+3pDCJCUeQfpbUGN1pxypMo4CoYfj4Vdj788Fkaz6eRryRDzFrmRU+mvBVw9/mbEM2xKc+m6CJ5d3WGmoCcoJr8ifzk4U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CY5PR12MB6323.namprd12.prod.outlook.com (2603:10b6:930:20::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 06:05:19 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 06:05:19 +0000
Message-ID: <2a7503a8-39e8-4741-b38a-40c3bc0a2ca8@amd.com>
Date: Wed, 17 Jul 2024 08:05:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailbox: zynqmp-ipi: Make polling period configurable
 from kconfig
To: Ben Levinsky <ben.levinsky@amd.com>, jassisinghbrar@gmail.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 tanmay.shah@amd.com
References: <20240716215037.3667214-1-ben.levinsky@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240716215037.3667214-1-ben.levinsky@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0262.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::29) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CY5PR12MB6323:EE_
X-MS-Office365-Filtering-Correlation-Id: 179a3d94-40ca-4e1d-2c83-08dca6266fe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkxTUGtGZEdGQTZ2RXQ0eWRucFN5Y2VkYTNtTmNCeVF4S2hFbitaL0xOVVE5?=
 =?utf-8?B?VFNNMGhDY29hNFhBdndPdVZqY3Jic2tGdTlvRWhoKzBGS3FVOS9KVlkrT2I2?=
 =?utf-8?B?RTdrcEY4YmRRcU92cFp0d1pKOTVIcG9oZzlTSnJkM1JyaUdUcHVmbXg2ajhK?=
 =?utf-8?B?YVhEcU9MUDRsOEc1TlJzTFBDREN2Zk5uSnZMTlFpaE1ERnhqZzJRS0YyVHhM?=
 =?utf-8?B?L0dmV1ZxdXRqZElWRE44RU5mTUdnSUNrZjRLcnpiMEg1cUpDa0pOTzVpbFRP?=
 =?utf-8?B?cTFwM2RlY1FlblhJQ2laS28xcm9HYUNOZFkzZTFydzIzeHkvRmJObmMvTUR0?=
 =?utf-8?B?ZFdjWDdFVWdXVFBMT3RtR3pYVUNyTXZIbHM3dHpCNjNvRitTbTRqSTVuaGhi?=
 =?utf-8?B?QWtmRmpQS2xFQnhRd0dXcjRrUndOaDRienhXcW4yc1dDVUN1c0h0Tnd0ek5T?=
 =?utf-8?B?dFBBT3lrNVhnUG1CYlppTFhXdlFPRndreWhGamcyaVltcnFSS1ZFWVN5bXN6?=
 =?utf-8?B?Y25ZV1BhQ1NwbGdGS1ZleWFhY0FMMnJaRGZqc3ZCdU9PVnNCMUs2VDY1Mko3?=
 =?utf-8?B?eVJ2cU1nM202aFJRejlOeWVwOWhGNmZCZFhHTlFyUHFmQUtQc3Rtckw2a214?=
 =?utf-8?B?QzN6SWQ0M0x1WFpMSk5aR0FKYlFFOGh5d1QzOVI1ZTFSamdIbXZaY0Y0N0hO?=
 =?utf-8?B?alJGd1dSTVNXRGZGMTdiOHdlRlRQZCt0WnBjR2RiQm9tOUVPSnZHTE1RUWRP?=
 =?utf-8?B?ZGlYbXN3bzEwaUJJdGcwaW5OSTJ5UnB6Z2psVTdMT2N6Rkgvd1N2bTVGS3pD?=
 =?utf-8?B?UldjV0cvQUp5bmFWSWw0ZVBGNS9HRG0vMktzRnVSYm5UZWlkN3NMNlowd3Mv?=
 =?utf-8?B?ZmZOUHpqK3hmYmRJNnBIQnF3di84ZmI0NXhUbkhoWWRYU0l4UjdwdVo2WW5h?=
 =?utf-8?B?TE1kcFNqVElNcEl2eEt6V2xDSU4yL2RJZXEwN2FBUGJmQ1d2NDVLZ1lNR2Q0?=
 =?utf-8?B?YXB2REZZVE5kZm1jSGY2M012OXI0UmJ5TENadjVBcXlmcldOOFVFOEtpMkpJ?=
 =?utf-8?B?NkNOSkkzWGk2NlBPaS8vd052MEQ0ZFlpaWRaUWIveWlpWWFnRHZ2V29CTU5I?=
 =?utf-8?B?dElZenNLYkhsMVJPbW1jSVBwYk9uVGNpa0N4Qm9uNk1DVGxEeUpZZVNsRUZv?=
 =?utf-8?B?bm1rd1B6eEtGQjVLaTJMVUJ2K1RIT2VGbW1tMGJQSVdqYWV3SkJaVEtmV3lW?=
 =?utf-8?B?ZUI3ZFZKTUhIdXN4Q3dJdHRDTzlRdnpLSmZzYWZZM2hicTI4N1dlbG5PREVt?=
 =?utf-8?B?TlVkY1dUbC8rOXI5YmlIMDdCWEdhM3FaZG1NUkdXVG1saUd2VzZod0tTZ3d6?=
 =?utf-8?B?cCtscVY3MXM5U0ovZE9jYzd3Mi9iMGN2YUgzOW1CcXgySDY3SDAzNTBxK096?=
 =?utf-8?B?VGVmc0xFZDJsRksvaXJkWmsrdU9VVGNOK1NGQmNZM1EydkNjL3RTemdDdG80?=
 =?utf-8?B?ejlLTnJzVEpOL3RMaHBhVDFXb3RHa243M0R5bERJR2NOM0owbU9YRUtCbWR2?=
 =?utf-8?B?cU8wNGpLRmxDWkpJVVBBNld4bVZqY3ZFeU1UeXJvcmNOdG9KZ2Z1aHVOZFpt?=
 =?utf-8?B?NUJHYXAwUlg1a04rSGxOMWF0QTV3aEJNdWlueTU0djM1YkxhV0ErQUh6ekVG?=
 =?utf-8?B?VHF3WktEUlhQQ2FBcy9rN2ZRMFJERlpUUzNyRHhCb3ltTG1EbThadUQzQ3N5?=
 =?utf-8?B?ZGRzb1FYK0UwVm0xSU83WTNZd055WWZxdGJwd28yMkxSYlV4SnJpVjdXZEhp?=
 =?utf-8?B?dGZxM1hhTkNNeEsxVyswZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGtZWTVMKzNodTlwYk9YelVOZ0VtYlpuanI5ZmhiazVKWCthVTJJNElrRjB5?=
 =?utf-8?B?anNLUHBGTzdwaEFXNXl1am5YVmIrU211TEN5NkhwSGlrNERHVDVjSkNHNUdh?=
 =?utf-8?B?VENzaFgrS2ZsbUxLUS9DelZybHFUaFArZHdEQ2pucExKbzVYeHRIL0VPOUJs?=
 =?utf-8?B?eStvRVdpK1FmWjNjbTdmcDZ3LzdvN3dmS25DR1UvTjlHQlhXYUQ4Q0JZV1lR?=
 =?utf-8?B?ZUhMcGpCZzY0eU5SbnFKT0F2bFBrR0t1OTVvaVk0MGUwUzFDdWlDZ3ZRL1pW?=
 =?utf-8?B?MnEwbUVZRlpPMUZEUytHak5RSWlYMlFKS0Z2cC9DK2d5UFhPRTZpUURuSVJQ?=
 =?utf-8?B?UmxkVlN6WURNeEdXbmtRNElXV2V2UWVaa0IwWHRaMktpNDhyV0t6Q1dIejJp?=
 =?utf-8?B?WEtiNWk0YjRubVhOaldLSFBBRENTRzVnUGVHYjZydENzSlNCNlEzNzNqRmp0?=
 =?utf-8?B?OHhLMm12ZHl6eXMycFFxWEUxVGNpbDdxdWZ1Ump4cjRFd0NESlBEYkptR2FF?=
 =?utf-8?B?aG9xS1QwYk80cVBIdmVULzYrT3dTaDJxdkhBV3U3eHpOV2dTRU14UHdNSWdH?=
 =?utf-8?B?NjFUWUViSXZ2U25TTVdQVXFPTVhKS3czTCt4WHpPM0poL1d3bTZEdFZJSFdF?=
 =?utf-8?B?UGMxdTZ1S0pndGErOEJnU3hGSlRRVjVuTUtBcGRxTWRPRllLYzdrZTVIWnJr?=
 =?utf-8?B?UFhsSEg1THlBb3NaUUR1WmlQZWxxdldTdGxsZm5UZW1vNmlQOGpUVmJ6b2Rk?=
 =?utf-8?B?cjRFQ3RRVkJEeG50TjUzOG9WdHUrUEd2SW1ORloycVB6OWxJc0JTYzRnVVRw?=
 =?utf-8?B?YURpczZiZGN3YmNuRHArS051cjBsUlF4QktKb1o5aTJhemxHUjcyZ0dnZnAy?=
 =?utf-8?B?VnhXSzRNZ2c0cEpqZkdEMTd6NTNlZCtPd2poRE9sTUtDZ1l6S0RpMmFRdUlN?=
 =?utf-8?B?RzlLRTk1cDBpaVV6bHJYZmowd1FzNWZENWw4ek5ic2RuV2tGV0RPYTRmSVlt?=
 =?utf-8?B?ZmtTMk1wOTM3VmJvcVdqREZJakdNRzh5UXZSZXhWeFN3NmdFRFJJS1NPWUp0?=
 =?utf-8?B?aVphUFhWWUdnUzhmSlhFWmEzaU9DcWNFZmlacStuMnlXUTJvd2FoY2QwOGdL?=
 =?utf-8?B?ZTYvZTNPT24zZ051N3M0dUV0UjZzQStrTlM5aVRLWnhuUlg0Y2ZHMFVQZ1hh?=
 =?utf-8?B?RmgxRTZncXVpUC9NdkhORnNGNEgrU2svUHk4SjhFZ0hzQlhtd05yNEM2bHVi?=
 =?utf-8?B?YmFDUHgrUEpuZ0tNcFVqRDNNcWsrclUwd0cyU1NJZFFkOWMvcml5cXY3YWxo?=
 =?utf-8?B?a20vYW16aTkyQ2ZXbVYrTHdvQXpmZmZtVGVHSDlUb1ZhK2VtckUydkdma1c3?=
 =?utf-8?B?UndoeE15R1BwcmxvRXU3YlZ2Qk5CYWlPMWU0V0xhUjI4U1p1SzJUQXBKVm9J?=
 =?utf-8?B?aCtQYTJmSmtNd3lLdTZWRjJsaUcwYkxwcVNSeG1rbTV3YmV1ZWErZktROFp2?=
 =?utf-8?B?VW5mT1JValpwTGlkd0YwUDQyRG5EcGl1bHkvajBEQmd6d0IwbmxScjY4VkxF?=
 =?utf-8?B?WG9WT2lIcWRWL2svbFQ0WHByOGJORHR1WERrNWVSNW9Jd0xiQjBXL0Uwc2VR?=
 =?utf-8?B?WmVNMVVRT2Y4Q3R5dzV0eDNON0lEN0tSc25yUTd2N1orbVF6NzhBbzdjR0Fo?=
 =?utf-8?B?ZFpsUnB0WkVuK1lwT3VHb1NCNTBpbnNoMmgvd3FiVzE0UXVDRW05c3RBQzlu?=
 =?utf-8?B?S04rUTYwTWxGWDF3VDhpS0tVQm50N2UxRFVFcmtkUlZKYXRXTk1hSkp5N2lS?=
 =?utf-8?B?M1hSWHM3c2MxNnNvTXkrNS9JWDNMVHBwdFhwRzN2Z0hwa3pDR2xGakRFMFlO?=
 =?utf-8?B?bWVTcE9pS0xtTHRIMnRzVi9INUJwYWkvVm9kLzZGNGNGRVczM1FTRndFUmND?=
 =?utf-8?B?L3k3MmU5UllUL1QwVkNoODFsdWppcE91SlpYRjF3MkQzVTRxdjlSSW9kSWRj?=
 =?utf-8?B?a0NESWRxU1MzWVFIME9sbmZWc0FrUmVPRm16clR5RTl5VEgwL2x6OUNITDZQ?=
 =?utf-8?B?Wld0T2V3c0V0NWx3S2h2ektoYVZMMlk5MnMrMjBzNDcrdWhGUWtxQ01SV05V?=
 =?utf-8?Q?YUzCBlYpbujF+zfxGKIPgeoAR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 179a3d94-40ca-4e1d-2c83-08dca6266fe1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 06:05:19.7992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pG+LXdyYQSULwasPn9YF59gR5KZMcKjlh60cm+PDfdmxvruBU4TZWg7P9f8kPh0v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6323



On 7/16/24 23:50, Ben Levinsky wrote:
> The polling period for ZynqMP IPI Mailbox is currently hard-coded to
> five milliseconds. To avoid patching this when modifying the value, the
> value is now set with default that can be overwritten from kconfig
> prompt.
> 
> Signed-off-by: Ben Levinsky <ben.levinsky@amd.com>
> ---
>   drivers/mailbox/Kconfig              | 12 ++++++++++++
>   drivers/mailbox/zynqmp-ipi-mailbox.c |  9 ++++++++-
>   2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index 3b8842c4a340..c87a92400616 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -259,6 +259,18 @@ config ZYNQMP_IPI_MBOX
>   	  message to the IPI buffer and will access the IPI control
>   	  registers to kick the other processor or enquire status.
>   
> +config ZYNQMP_IPI_MBOX_POLL_PERIOD
> +	int
> +	prompt "ZynqMP IPI Mailbox driver polling period"
> +	default 5
> +	depends on ZYNQMP_IPI_MBOX
> +	help
> +	  By default the Xilinx-AMD IPI mailbox driver has a polling period
> +	  of five milliseconds. If this option is set then the provided value
> +	  will be used.
> +
> +	  Leave as default if not sure.
> +
>   config SUN6I_MSGBOX
>   	tristate "Allwinner sun6i/sun8i/sun9i/sun50i Message Box"
>   	depends on ARCH_SUNXI || COMPILE_TEST
> diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
> index 4acf5612487c..df540e2b9dbe 100644
> --- a/drivers/mailbox/zynqmp-ipi-mailbox.c
> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
> @@ -64,6 +64,13 @@
>   
>   #define MAX_SGI 16
>   
> +/* Polling period in milliseconds. */
> +#ifndef CONFIG_ZYNQMP_IPI_MBOX_POLL_PERIOD
> +#define ZYNQMP_IPI_MBOX_POLL_PERIOD (5U)
> +#else
> +#define ZYNQMP_IPI_MBOX_POLL_PERIOD CONFIG_ZYNQMP_IPI_MBOX_POLL_PERIOD
> +#endif
> +

I think it would be better if this is module parameter that you don't need to 
recompile the kernel all the time when you want to change this value.

Thanks,
Michal

