Return-Path: <linux-kernel+bounces-562786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21ABAA632ED
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 00:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 021F6189229E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 23:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B9F1C6FE1;
	Sat, 15 Mar 2025 23:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="US/Altb0"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838912E338B
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 23:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742080954; cv=fail; b=Yxo7b6MU2N1oKzD8qQnenMJ0iCkYyY2KV6uzSf9FdmpEHRardqh8YBnQuBKXXbMDIzP8Xtk2SbySy8lKUSd7IUxD15bO5j2qoIRccIy2zQgH6CaIAcg2+FtOgMaIcD+kO0svegZ1iIPGjaDOQWa23ZB2FtqEdgcl3Xn6kxy5tHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742080954; c=relaxed/simple;
	bh=MQxiZ4jHp0kiUzvDn00nW2oWqTPhMcxh4CiV0mSP9I4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hy5HU2WYbSal7XXtc9bjrZqFUsluvpXIjgkfSN0oaiIqMQSDKIVpXHmdvt1X7yc58EtalTItYGv8ZnDIbRYiHX62T9HOljZCVvSfGn8z4FC8jmX4Mv69LtixLiOsM+YT31/MPqV6kvAW1swy244DZh3ri2JXrU+EW3uGAIOLaPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=US/Altb0; arc=fail smtp.client-ip=40.107.100.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ystwF45TkpiYJmKPPBex2G6AznSigjBbJ8BpXkL+3KO3ktv45ILc399zo9Tiyv0GXxU4+4x3ohHdE4Wi+S9QoFOoMYU3fSTSzhiZTq6DRjZqtlUFK8f3vraZ0qI9/UF760GAsje7FnsWWbBsJPggNE6oAwV8JaVd1ukzYr9Pwt/lverJJct7+NACOG7l0hnb9ZLHVTWpbtBTUfUX1008Vh9//s14r8tcV+BZmJPZmW4ejvT9gsEt4oTsFKek8btZu6jd3i/+O3CHxnOgeZL0sCxNtQK7MKIh1NtN5u8giGBWt8vCQX63vOBAmlCQ8DwqnqRyanAwLpSCF196iCAp8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FErQhaEKFbkW1vmQJVH1KKOf7HYoarLEhRxkbUtb5Qk=;
 b=Rc+sWnT5UVpCzfxlFCMdRRYT2XZOPq7tmzPTE4z+iwd5KbNj21ZBAKdgB8aeWqeSvA1HAQNoSVkst/2BL58XplXO/1IR1aEvuOJpllCGp93nSSSTpX510tbrBmVWj7aU88hfERQ1IWbB2PL1d+tSE6ryJAS9it0NRlvxpxZvh0NFQ0A8DUfUxD3SsEiEZxYIQlHpuLgXzXJwElDXY9U7xopVLhWf8Hq1EnVTzF0xI8KCI9hN+CzAbATIycnMILrF2oSHC3u9+7Ci/aIHq/dc6PYu7GnpPeBXF5NzAuCv7gelGUt9fhbRORLq+LWo9qkS9CzIUrIiiccaVERYPzuWPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FErQhaEKFbkW1vmQJVH1KKOf7HYoarLEhRxkbUtb5Qk=;
 b=US/Altb0fBlJLj24RZMoqZ5Pd976rjQWEvHQvioo5IyeCjpkvVp0OGeVAeznEA/4dsg+aZFAFDdqWoDsNcZCQBUH/lhSwOG/3uxrY97rcqbAERvT74N1XzUCpDr3v9sZRDkbLqmyIVVTvvXwoPxdDGkJujyDySiKAEx4fHm5AZpa6spfLKSeDhxzDcDfOitcR2IUybuG4gma40YcqaoF5zUkdzUQ9EncgCqSXNZx8mF8TF7psDCcfJcQNRRixYFPVVIkAsx45qniPxagC1NC5ZcY+FGSEqo0cA3/shsPu9mk5mRYoR9/+AUkIDc8ShUL25VpJ1A02G/HKIkH2EYvBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MW6PR12MB7087.namprd12.prod.outlook.com (2603:10b6:303:238::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.31; Sat, 15 Mar
 2025 23:22:27 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8511.026; Sat, 15 Mar 2025
 23:22:27 +0000
Message-ID: <07c0ee36-8e27-42e7-91bd-37918eb9638e@nvidia.com>
Date: Sat, 15 Mar 2025 19:22:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 8/8] selftests/sched_ext: Add test for sched_ext
 dl_server
To: linux-kernel@vger.kernel.org, Andrea Righi <arighi@nvidia.com>
References: <20250315022158.2354454-1-joelagnelf@nvidia.com>
 <20250315022158.2354454-9-joelagnelf@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20250315022158.2354454-9-joelagnelf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR14CA0020.namprd14.prod.outlook.com
 (2603:10b6:208:23e::25) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MW6PR12MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: a0811f19-4002-47ba-2e02-08dd64183fec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0pTWVpQSzhWT3NycDcwKzg3ZVkrWHZGbkF6emhBcWxRckxIRkRJbXJaTWRM?=
 =?utf-8?B?d3JZZnQ4WlovMk1aaFNqOXdUNjlZTytZUDEwa3ZKbGh3MkI3SkxVdUMrVHBy?=
 =?utf-8?B?a3RwYS92YS8xZ1pTWXZjU1RTUm51VmF1NVhkT3o2Z1pTVCtTc3pjazhSa0lB?=
 =?utf-8?B?MzZ6ZmhNdTZkVTNmV3BNZFU2Tm9YRE9LKytNVHV0a09jOUt4T0JlZFJCcUt5?=
 =?utf-8?B?UTNEemVESW9vU2tJM3pBK1JUUEduS3YrcXRlQitSZ0lRMWJvQlBoSDU2U1NM?=
 =?utf-8?B?cTYrQlFZM25yMVVBR0NWZGVHeFRpNW51THRJckFudVNKclJNSEJlSlREeFUw?=
 =?utf-8?B?WFVtZHhnUTU5d1FlWUYvSTVjeEFWNGM1VlBUS1FDSy9rS2NlSmlNZUwyWWJD?=
 =?utf-8?B?cU5vV0tiK2xMOGs3UEtVSGtzNDY2clowV3BsbVFXcFJiQVpHbVVSczlvOHJy?=
 =?utf-8?B?YkM0cUk3cHFkbmhrZ25CNnhrRGhpR2M3bXUxYUgyUEtONHlBdElieU5aR2Ny?=
 =?utf-8?B?WXJDN2E4YWdlTFpqRlY5MVdJczV2NU5TS1ROSzdGcFFKakU4ekRneGdadzJl?=
 =?utf-8?B?MlZwanRBYmNHN2ErUnNTNUNuTnRJQWhEQ2VqRVRCNUxHNTYyaFVmMFhXM2dT?=
 =?utf-8?B?VzJGMUJ1cFdoVEJuRlFRYTYrTFRabTlrZzB0Rjl5eXF3KzhpNlBTWVZCZyti?=
 =?utf-8?B?Qzc1WlpOQ1NsdHVBZHR0MlI0YjFITjIzSThORmZMTkwvZk55MENnOXRSaWEv?=
 =?utf-8?B?enhaK3hSWWhiVmdsVE1EdG80NkxaRTZpQ2x0a1Z2RCs1b0VwcXlQcmE0TEFl?=
 =?utf-8?B?OWhrOWhoYzBkMFIrQVZOLzRxank3NmVKNXh0RHVsakdvN0orOEV1Y3lqdWlF?=
 =?utf-8?B?c2FGVUo5OHdTb0xldW1HVkp3M0ZhZWpMc1p6VHZ6dEZTcjBNa3FsOVk2bHNh?=
 =?utf-8?B?RksxVjdCWnlUb2diRFpGN01aVGhPbGtrWmJEeGxuOWpJWnZ1eFZhOXNuZUhQ?=
 =?utf-8?B?UHc2QTJQVHJxNmlsQXpaMXRidDhmSElSeVVOU0NzTjA3QVpybk5KRlpGczFl?=
 =?utf-8?B?OEtSMVRQQSs3RDF4QUIwS2kxeFRBRVY0bS9pUDlWcGxVOElLRk54TmhXSDhD?=
 =?utf-8?B?Q0EyVkpXZXVDMjhNSDBRU1NUckNBQ0xWT2xESE9CSHd0MjgySHJkZElUcjJp?=
 =?utf-8?B?bENFTFRaZjFVNVB1VTF4a2FBekFWMk8veExkN0FUNWVQMythV01OUXZpWDc1?=
 =?utf-8?B?dU5RZ3pZczdyRDJxNUduQ01vRTZOcHVhL2xTTyszRDEwZ3FlSVNvZjFBZGpj?=
 =?utf-8?B?Rm83VHNUakJ5aGxzSkpEa2NCemhoUlhUam8xbzdiUHBhUHBiNHVlOXM4YTlC?=
 =?utf-8?B?R1h5RjkyaE5RR1lTRDdRcm1aYWVPVU1FYlpxTXIyYlNrWDJqTklQNktvWVZv?=
 =?utf-8?B?bTgvZGpUN0s1Q0dpOXlYRWJpQ0JJcG0xQ0pjWmtHYzZHUUVSbzNYZkN4OEJ2?=
 =?utf-8?B?Ym4wTDU5MVZOUXRxYjN3UnliUGlRaFNjRGdrejBrNm8xVWpORk5MNlliVTV5?=
 =?utf-8?B?WHkvNXE3ZDBUamg0cmIvZ284SURMQ0NxKzd3NlJnUGFGdXZYdDc0T1prNnVN?=
 =?utf-8?B?M2VNQ0JLTkxBWWdiSDAvMlJpUzRWV2JjV3Z2MVRtRitqM0dMTEtrVi9ISU85?=
 =?utf-8?B?RUIwVURHN1FDSWpYcCtZeGJsc05TOTZzM0ZGTmZFcWRjTWkzUWhhOHltM1Z6?=
 =?utf-8?B?MmpOYUJEcnpZVURjR01jUUJzZjUwczJVVCtTVjZqQnhkMUtGK2Z2Y055dHNY?=
 =?utf-8?B?SU5TVFNEZEFReTRRd1hDN3dPSVpyVThqeS9vbFhRaTBnbmhhZUphTG16Q3Jx?=
 =?utf-8?Q?iKepe30fn2F9w?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVE0REdDSUFoTVF1SWVSZDNWY2Q4MGRmTk5raGIyM2ZTdlZTQjAwZThYTmhB?=
 =?utf-8?B?aW9FeGlwS0pvV1JuRkZ4dk5jaEtMbHpwRUhyUmhsMGFuTE9HNHdjOFNmaHd3?=
 =?utf-8?B?QVBSUjQvV0M4N202Tjl4YlBpT3VDMS9KNHlMQ0doZEFBWHJ3R2pwMlZOa1Uz?=
 =?utf-8?B?VHYrTmE2VFVxcHNEb3dnRmk1ckRWQ2dUMllsM3VCUy84TytETWNYRm1OVjh6?=
 =?utf-8?B?d0k4eE9NOTlHVWlWUWFIQVZNc285OG55NTR2NlBLNnRxU3g3SWM4ZWhITGxK?=
 =?utf-8?B?aW95YkZ3aTlHck9WdE02NmN4bkZlZW9GQllma2VDZ0RwTk1hWitLaG5BeWh3?=
 =?utf-8?B?VjROL0ptUll5QzViTTNRL3lmaUpDQlZ0WmFzWjVxYWhqVzRNM2tYdDNBdVhN?=
 =?utf-8?B?Nlh6SmMxWGcxdGVnTElFZWpIOUZlZUNRMXF0c2JlcU1rWU9aaFJUczhkZjB3?=
 =?utf-8?B?Q2ltTGY5REtBTk5KaE1oc1BkRnFHaUtuaTVha2o3RmxtSlVMRjJLaWF4QkVa?=
 =?utf-8?B?STZIc3E0VUxrbXF1dDIrQUlpaEx1cFF4ekRkTXVHMHp6ajlPdlYyUk11WVAx?=
 =?utf-8?B?bXlOS0pmSjQyclN4Zm5kdytGaTJFL1dtV1RsWWh3NzZXZHY2TWJ3QktqeHh4?=
 =?utf-8?B?Uk95M200WXlDa2I5VnB3ZXY4cDdVc2dTT1BNT0JOdzJEVEZDSTV6MFBhdENu?=
 =?utf-8?B?dkt2bXpHWkMxdENCengraXVlNnp6eGZORFJTRVo0ZmVxaVFOSE1MblFKVkkz?=
 =?utf-8?B?UXFKY0F0ZEpUZFZseEtuTjNpSEFJZkw4WEVGN2hmTUxtQmpIQ3dQc1BvNDFw?=
 =?utf-8?B?VzZPSTYxUFU3VFBaNnJwS0E5Z2lacndjU0haZm5MSk5wd2JCMm42bXl5ZU4w?=
 =?utf-8?B?QXR5c1V5aXRBdUZMM3ZXcVcrM0lmODJxWjhUOFZLSnFmRUU3a2ltbnhmNUNF?=
 =?utf-8?B?MFoyWGV0UnI3TWdvN0pTbnFJV1dVM0dPb1J4MmlkeUhGK2RxZVYvVHlReTNI?=
 =?utf-8?B?Z3k0RkxCZEZqdVZGK3FHdWZlYTdxaWxZL1RCc21zb016UE9MYXVLdWl3UUV0?=
 =?utf-8?B?TnJ0T0YyaTVyUHlsUmUra0xjM2dTTXNtckxjSFVOd3I3bitRRFVidWVzL1ph?=
 =?utf-8?B?OHpDdUFPRWVXS2xOdXRUYWEwS21HYjJqS0x2bk5UbC81SzVFTGFReG1JRmZ2?=
 =?utf-8?B?OThkamVIekxpL1BwSnlYckk4azZXV2N5SW9hS2VmaWFTZ2I2RWo1NklKakdU?=
 =?utf-8?B?cTdYQlJjd0Q1VFJTd1lNVVdVOTIrWWxzV1BHK0ZEQXVENkg2VWplZWIzdnF2?=
 =?utf-8?B?QTA4SkZtNTZVOWUrZU1aWUt6WjNlUkdSVjFLRkNEWkV2S0I2aEFtQW1lYWVS?=
 =?utf-8?B?c2ZJeDh5c2tVOUJXL3k4QnZuMlBMN0h4VG45Q2tNUFNmOHZqRE52RjNTdHFM?=
 =?utf-8?B?czF6SHRmeGZnRDNmZkVDbEFnT1ZsUlIvTGhzazBPRzltZUlnbTZzQmZzcDdu?=
 =?utf-8?B?L2xVQmdJYXJxSUorVERPMVhjeitaL2hJRkVNRG5KaXdsN2JmUlg0ZVZuUm5G?=
 =?utf-8?B?Y1lpVXlmc0hSRnEzTUVrZVlDR3dubzRvZW80Lzl0UUNVZk5qZWhySHBWclNs?=
 =?utf-8?B?TkVnMXlFSEJnR3EvYnVLV29NUWZURURCMWhEVE5LUElkSlFZcEdtT2F2ZWpv?=
 =?utf-8?B?d1ZoNmZQMGluYkFIUjVBaEVWM3dPRkhGaWdWVEdGaTdhTEpubVhlRisvT2ZC?=
 =?utf-8?B?UlZiSU9CREZ2ZWlCSHE1OXUrOGZ4bnN1KzJoa1BBdjg0ZGpSeDBwZENrL0hx?=
 =?utf-8?B?Q3BWSWMvaXZ3WmdXeUpsWCtZNmdOem1HdnpjQlhqRXpWaWI0WndvVmJpanc0?=
 =?utf-8?B?VGtWYmJMMGcySDB4L2ZKZUFybm5UYnRMeXhxdy81ZUJIQmVKcWpHNHpib2xk?=
 =?utf-8?B?eFlDNUFrS0s4OW9Rb1NVUDY2czJiZFZ5YmM4NktxQk5YTWVUQWdMMWxiNGp6?=
 =?utf-8?B?ZkRCRWg0SDA1RG4wb2pqN0JycDZlRmw4SjVSOGNMNTM5eStJelBrVGhyaElQ?=
 =?utf-8?B?L2wzZ0NMTTFLQnZNSjgyZmZQcmRyQ0hoTHU3RTBrVnc2ajVFREhxN3dMTlJU?=
 =?utf-8?B?dE84VFZVc1c2WHFUb2ZKTGF0ZHJYRDA5dGsvSVM3Q3FDem9NdmRIbXZYU0pi?=
 =?utf-8?B?MFE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0811f19-4002-47ba-2e02-08dd64183fec
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2025 23:22:27.2523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tIdw53JHckJ7aJ6J2Xw2WfhctyyaGigAJFwtG411RlagkGQ7ZmXs4zMfu++qvfs4qZKWoH01u95J+KJ/+qi4CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7087

This patch triggered a build robot warning, adding to thread for tracking the issue:

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git
sched/scx-dlserver-boost
branch HEAD: d4faa4aa813acff703cea3c301bb556f69b5210c  TODO_BEFORE_SUBMIT

Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202503152220.gAuzob4W-lkp@intel.com

    tools/testing/selftests/sched_ext/rt_stall.c: sys/wait.h is included more
than once.

Warning ids grouped by kconfigs:

recent_errors
`-- x86_64-allnoconfig
    `--
tools-testing-selftests-sched_ext-rt_stall.c:sys-wait.h-is-included-more-than-once.

elapsed time: 1448m

configs tested: 93
configs skipped: 1

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250315    gcc-13.2.0
arc                   randconfig-002-20250315    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                            mmp2_defconfig    gcc-14.2.0
arm                        mvebu_v7_defconfig    clang-15
arm                   randconfig-001-20250315    gcc-14.2.0
arm                   randconfig-002-20250315    clang-21
arm                   randconfig-003-20250315    clang-21
arm                   randconfig-004-20250315    gcc-14.2.0
arm                        spear3xx_defconfig    clang-16
arm64                            allmodconfig    clang-18
arm64                 randconfig-001-20250315    gcc-14.2.0
arm64                 randconfig-002-20250315    gcc-14.2.0
arm64                 randconfig-003-20250315    clang-16
arm64                 randconfig-004-20250315    gcc-14.2.0
csky                  randconfig-001-20250315    gcc-14.2.0
csky                  randconfig-002-20250315    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250315    clang-21
hexagon               randconfig-002-20250315    clang-17
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386        buildonly-randconfig-001-20250315    gcc-12
i386        buildonly-randconfig-002-20250315    clang-19
i386        buildonly-randconfig-003-20250315    clang-19
i386        buildonly-randconfig-004-20250315    clang-19
i386        buildonly-randconfig-005-20250315    gcc-11
i386        buildonly-randconfig-006-20250315    gcc-12
i386                                defconfig    clang-19
loongarch             randconfig-001-20250315    gcc-14.2.0
loongarch             randconfig-002-20250315    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250315    gcc-14.2.0
nios2                 randconfig-002-20250315    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                randconfig-001-20250315    gcc-14.2.0
parisc                randconfig-002-20250315    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250315    clang-21
powerpc               randconfig-002-20250315    gcc-14.2.0
powerpc               randconfig-003-20250315    clang-18
powerpc64             randconfig-001-20250315    gcc-14.2.0
powerpc64             randconfig-002-20250315    clang-18
powerpc64             randconfig-003-20250315    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250315    gcc-14.2.0
riscv                 randconfig-002-20250315    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250315    clang-19
s390                  randconfig-002-20250315    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250315    gcc-14.2.0
sh                    randconfig-002-20250315    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250315    gcc-14.2.0
sparc                 randconfig-002-20250315    gcc-14.2.0
sparc64               randconfig-001-20250315    gcc-14.2.0
sparc64               randconfig-002-20250315    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250315    gcc-12
um                    randconfig-002-20250315    clang-18
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250315    gcc-12
x86_64      buildonly-randconfig-002-20250315    clang-19
x86_64      buildonly-randconfig-003-20250315    clang-19
x86_64      buildonly-randconfig-004-20250315    clang-19
x86_64      buildonly-randconfig-005-20250315    clang-19
x86_64      buildonly-randconfig-006-20250315    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250315    gcc-14.2.0
xtensa                randconfig-002-20250315    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



On 3/14/2025 10:21 PM, Joel Fernandes wrote:
> From: Andrea Righi <arighi@nvidia.com>
> 
> Add a selftest to validate the correct behavior of the deadline server
> for the ext_sched_class.
> 
> [ Joel: Replaced occurences of CFS in the test with EXT. ]
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  tools/testing/selftests/sched_ext/Makefile    |   1 +
>  .../selftests/sched_ext/rt_stall.bpf.c        |  23 ++
>  tools/testing/selftests/sched_ext/rt_stall.c  | 213 ++++++++++++++++++
>  3 files changed, 237 insertions(+)
>  create mode 100644 tools/testing/selftests/sched_ext/rt_stall.bpf.c
>  create mode 100644 tools/testing/selftests/sched_ext/rt_stall.c
> 
> diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
> index 011762224600..802e3d8d038f 100644
> --- a/tools/testing/selftests/sched_ext/Makefile
> +++ b/tools/testing/selftests/sched_ext/Makefile
> @@ -180,6 +180,7 @@ auto-test-targets :=			\
>  	select_cpu_dispatch_bad_dsq	\
>  	select_cpu_dispatch_dbl_dsp	\
>  	select_cpu_vtime		\
> +	rt_stall			\
>  	test_example			\
>  
>  testcase-targets := $(addsuffix .o,$(addprefix $(SCXOBJ_DIR)/,$(auto-test-targets)))
> diff --git a/tools/testing/selftests/sched_ext/rt_stall.bpf.c b/tools/testing/selftests/sched_ext/rt_stall.bpf.c
> new file mode 100644
> index 000000000000..80086779dd1e
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/rt_stall.bpf.c
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * A scheduler that verified if RT tasks can stall SCHED_EXT tasks.
> + *
> + * Copyright (c) 2025 NVIDIA Corporation.
> + */
> +
> +#include <scx/common.bpf.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +UEI_DEFINE(uei);
> +
> +void BPF_STRUCT_OPS(rt_stall_exit, struct scx_exit_info *ei)
> +{
> +	UEI_RECORD(uei, ei);
> +}
> +
> +SEC(".struct_ops.link")
> +struct sched_ext_ops rt_stall_ops = {
> +	.exit			= (void *)rt_stall_exit,
> +	.name			= "rt_stall",
> +};
> diff --git a/tools/testing/selftests/sched_ext/rt_stall.c b/tools/testing/selftests/sched_ext/rt_stall.c
> new file mode 100644
> index 000000000000..d4cb545ebfd8
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/rt_stall.c
> @@ -0,0 +1,213 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 NVIDIA Corporation.
> + */
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <sched.h>
> +#include <sys/prctl.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <time.h>
> +#include <linux/sched.h>
> +#include <signal.h>
> +#include <bpf/bpf.h>
> +#include <scx/common.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +#include "rt_stall.bpf.skel.h"
> +#include "scx_test.h"
> +#include "../kselftest.h"
> +
> +#define CORE_ID		0	/* CPU to pin tasks to */
> +#define RUN_TIME        5	/* How long to run the test in seconds */
> +
> +/* Simple busy-wait function for test tasks */
> +static void process_func(void)
> +{
> +	while (1) {
> +		/* Busy wait */
> +		for (volatile unsigned long i = 0; i < 10000000UL; i++);
> +	}
> +}
> +
> +/* Set CPU affinity to a specific core */
> +static void set_affinity(int cpu)
> +{
> +	cpu_set_t mask;
> +
> +	CPU_ZERO(&mask);
> +	CPU_SET(cpu, &mask);
> +	if (sched_setaffinity(0, sizeof(mask), &mask) != 0) {
> +		perror("sched_setaffinity");
> +		exit(EXIT_FAILURE);
> +	}
> +}
> +
> +/* Set task scheduling policy and priority */
> +static void set_sched(int policy, int priority)
> +{
> +	struct sched_param param;
> +
> +	param.sched_priority = priority;
> +	if (sched_setscheduler(0, policy, &param) != 0) {
> +		perror("sched_setscheduler");
> +		exit(EXIT_FAILURE);
> +	}
> +}
> +
> +/* Get process runtime from /proc/<pid>/stat */
> +static float get_process_runtime(int pid)
> +{
> +	char path[256];
> +	FILE *file;
> +	long utime, stime;
> +	int fields;
> +
> +	snprintf(path, sizeof(path), "/proc/%d/stat", pid);
> +	file = fopen(path, "r");
> +	if (file == NULL) {
> +		perror("Failed to open stat file");
> +		return -1;
> +	}
> +
> +	/* Skip the first 13 fields and read the 14th and 15th */
> +	fields = fscanf(file,
> +			"%*d %*s %*c %*d %*d %*d %*d %*d %*u %*u %*u %*u %*u %lu %lu",
> +			&utime, &stime);
> +	fclose(file);
> +
> +	if (fields != 2) {
> +		fprintf(stderr, "Failed to read stat file\n");
> +		return -1;
> +	}
> +
> +	/* Calculate the total time spent in the process */
> +	long total_time = utime + stime;
> +	long ticks_per_second = sysconf(_SC_CLK_TCK);
> +	float runtime_seconds = total_time * 1.0 / ticks_per_second;
> +
> +	return runtime_seconds;
> +}
> +
> +static enum scx_test_status setup(void **ctx)
> +{
> +	struct rt_stall *skel;
> +
> +	skel = rt_stall__open();
> +	SCX_FAIL_IF(!skel, "Failed to open");
> +	SCX_ENUM_INIT(skel);
> +	SCX_FAIL_IF(rt_stall__load(skel), "Failed to load skel");
> +
> +	*ctx = skel;
> +
> +	return SCX_TEST_PASS;
> +}
> +
> +static bool sched_stress_test(void)
> +{
> +	float cfs_runtime, rt_runtime;
> +	int cfs_pid, rt_pid;
> +	float expected_min_ratio = 0.04; /* 4% */
> +
> +	ksft_print_header();
> +	ksft_set_plan(1);
> +
> +	/* Create and set up a EXT task */
> +	cfs_pid = fork();
> +	if (cfs_pid == 0) {
> +		set_affinity(CORE_ID);
> +		process_func();
> +		exit(0);
> +	} else if (cfs_pid < 0) {
> +		perror("fork for EXT task");
> +		ksft_exit_fail();
> +	}
> +
> +	/* Create an RT task */
> +	rt_pid = fork();
> +	if (rt_pid == 0) {
> +		set_affinity(CORE_ID);
> +		set_sched(SCHED_FIFO, 50);
> +		process_func();
> +		exit(0);
> +	} else if (rt_pid < 0) {
> +		perror("fork for RT task");
> +		ksft_exit_fail();
> +	}
> +
> +	/* Let the processes run for the specified time */
> +	sleep(RUN_TIME);
> +
> +	/* Get runtime for the EXT task */
> +	cfs_runtime = get_process_runtime(cfs_pid);
> +	if (cfs_runtime != -1)
> +		ksft_print_msg("Runtime of EXT task (PID %d) is %f seconds\n", cfs_pid, cfs_runtime);
> +	else
> +		ksft_exit_fail_msg("Error getting runtime for EXT task (PID %d)\n", cfs_pid);
> +
> +	/* Get runtime for the RT task */
> +	rt_runtime = get_process_runtime(rt_pid);
> +	if (rt_runtime != -1)
> +		ksft_print_msg("Runtime of RT task (PID %d) is %f seconds\n", rt_pid, rt_runtime);
> +	else
> +		ksft_exit_fail_msg("Error getting runtime for RT task (PID %d)\n", rt_pid);
> +
> +	/* Kill the processes */
> +	kill(cfs_pid, SIGKILL);
> +	kill(rt_pid, SIGKILL);
> +	waitpid(cfs_pid, NULL, 0);
> +	waitpid(rt_pid, NULL, 0);
> +
> +	/* Verify that the scx task got enough runtime */
> +	float actual_ratio = cfs_runtime / (cfs_runtime + rt_runtime);
> +	ksft_print_msg("EXT task got %.2f%% of total runtime\n", actual_ratio * 100);
> +
> +	if (actual_ratio >= expected_min_ratio) {
> +		ksft_test_result_pass("PASS: EXT task got more than %.2f%% of runtime\n",
> +				      expected_min_ratio * 100);
> +		return true;
> +	} else {
> +		ksft_test_result_fail("FAIL: EXT task got less than %.2f%% of runtime\n",
> +				      expected_min_ratio * 100);
> +		return false;
> +	}
> +}
> +
> +static enum scx_test_status run(void *ctx)
> +{
> +	struct rt_stall *skel = ctx;
> +	struct bpf_link *link;
> +	bool res;
> +
> +	link = bpf_map__attach_struct_ops(skel->maps.rt_stall_ops);
> +	SCX_FAIL_IF(!link, "Failed to attach scheduler");
> +
> +	res = sched_stress_test();
> +
> +	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_NONE));
> +	bpf_link__destroy(link);
> +
> +	if (!res)
> +		ksft_exit_fail();
> +
> +	return SCX_TEST_PASS;
> +}
> +
> +static void cleanup(void *ctx)
> +{
> +	struct rt_stall *skel = ctx;
> +
> +	rt_stall__destroy(skel);
> +}
> +
> +struct scx_test rt_stall = {
> +	.name = "rt_stall",
> +	.description = "Verify that RT tasks cannot stall SCHED_EXT tasks",
> +	.setup = setup,
> +	.run = run,
> +	.cleanup = cleanup,
> +};
> +REGISTER_SCX_TEST(&rt_stall)


