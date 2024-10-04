Return-Path: <linux-kernel+bounces-350760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C277399092D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324C21F2170C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01FB1C878D;
	Fri,  4 Oct 2024 16:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="s/SFRmif"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020082.outbound.protection.outlook.com [52.101.56.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F7C1AA7B2
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 16:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728059382; cv=fail; b=fi3hQ5CdZqffFm86tNymJkjE0YDInXDUXY90IMoQYFoqUbmd8bOt4y3N4Nlk0obpyjmaRlG/Di9tawNZIy1JjAhj3Jinvl7NVaPxCiw/VCwwdoYJ3t+li0B5b+GsY7NyV+VA0C+uxbGUlGpupyPC2Dj0Uks6qZnUJi04gN1eZDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728059382; c=relaxed/simple;
	bh=4KYydhXChZ+iwgModHttC9/Swr0TPBv2v6bBM7C2hkk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qIGRnIOTOxNoSWUd9xBWCGanLnPVGE6h18s8Sislc6gOzr09YdfL9aPDySfHxQ+Pgqdy4cNVSwgFMFRjYgxyHrZ1k1779B8YhfiMz3c8Dil8ZMb1v1QmIMzYAIFm9oZ7iOi0pxTplCblYp05hDAivDKWJyzeTjlQ2mxU4bs40+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=s/SFRmif; arc=fail smtp.client-ip=52.101.56.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uG7GcGvZoXc/OvsKsGy/ZJKVRhOVso1wlMul2iMGthLwN7oTYBl4m7gYM5FM3HAEhcIEMU75dFyq6/akdkLunqwg7wRSmokOlvsi/0rN6rXSzMlnqCEpNNomoYhpbPfcQ7pe7J/XFQJXUrqEejms4m+uRUafeoUiXOhzSF2JOXi+Ub9q63bI51pDOBJolukm0uiT22c3HoE+/fmMR4qp5jvB9KB9r0zI+JBFkxPICSM0rk9GXj+sONOZAJeVDqk1EYA29E3bZTTdDYHXVwGQ07m26Kb0j7pX7L2Ot8hxafr/o3Fg5GbXmvQnWiLO5WzH6Fu+Fyv0zKIPtc530S13Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KYydhXChZ+iwgModHttC9/Swr0TPBv2v6bBM7C2hkk=;
 b=j+TVoMjXmmttKxW57f+UkZ7dAm/3HzNU1eXZ5RVwflKjEsGZ/KX9Slf3dccSlzi77YVqeMAuNOdrLIIDOy8hJvJkpIaK8XyX9Dyx4JXHcUTd0Cl4TC2UnU9MXcH1o0bMMA6DRYq7MQ+t9QkS3g3aVQT/oFe2T65tzZV17AvV9ZnRU7GCQUWFXDRgNCEeERVBUF+rxDSqFSNBvK5vzNxuiDw3CqXmUTd11IPovOl8QWB1KMaGKAr8Oi87IMfFej5A2wXfgQ32jNXUdXwrsDiyR/pkiEKDrsKC36dHuRgsnWRUPnlUpdxKruJ/5BysF4NkoM1H+u4nfewbthDyew3Fmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KYydhXChZ+iwgModHttC9/Swr0TPBv2v6bBM7C2hkk=;
 b=s/SFRmif1D4aODL20daLV2q34pd2twL0lC0O1A3ZMdAfHY6kNvwobxn0psDQkgQPbPZ2l2R1oXm2cs9/+lykAAvTk63RmGeokd1aAJiJzml5/1tThF+25I1zltRBqoH8iy68ItCK3BtZpf3NDdR+3XnH2oeCcTGvINzrfQ/Mygg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 BY3PR01MB6675.prod.exchangelabs.com (2603:10b6:a03:360::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.34; Fri, 4 Oct 2024 16:29:37 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.7982.022; Fri, 4 Oct 2024
 16:29:37 +0000
Message-ID: <7ad66e5f-d6f8-4144-8ab2-d4ea499e2665@os.amperecomputing.com>
Date: Fri, 4 Oct 2024 09:29:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH] iommu/arm-smmu-v3: Fix L1 stream table index
 calculation for 32-bit sid size
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nicolin Chen <nicolinc@nvidia.com>, james.morse@arm.com, will@kernel.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241002175514.1165299-1-yang@os.amperecomputing.com>
 <Zv2ONA2b3+kMAizm@Asurada-Nvidia>
 <1c9767e1-4d05-4650-bc14-65a18fc63cc2@os.amperecomputing.com>
 <Zv2diJDU6v60hKtU@Asurada-Nvidia> <20241002194004.GT1369530@ziepe.ca>
 <f28cab76-8030-477a-84b1-461dc02451ff@os.amperecomputing.com>
 <20241003111603.GU1369530@ziepe.ca>
 <43c2227a-71c9-4cbf-bfec-5a2fbf698f27@os.amperecomputing.com>
 <20241004124343.GE2456194@ziepe.ca>
 <26ee77f2-720d-4e16-9f6c-fa15fd13d305@os.amperecomputing.com>
 <20241004161408.GJ2456194@ziepe.ca>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20241004161408.GJ2456194@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR17CA0004.namprd17.prod.outlook.com
 (2603:10b6:930:17::35) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|BY3PR01MB6675:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e54e298-280f-4072-bba4-08dce491bcdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkxLUWhQR3dBQ0JFQXpSemNsOGh0dlJrNlY0Nm5RNmdsRm11YitHZE0vVi9K?=
 =?utf-8?B?RWFTV0FnUGNtQWorQmZjZ2JFYlVRaXVZbVZKTkVSaE5LTXJRZ0RYVVZ5emtU?=
 =?utf-8?B?Ukl1VnRLdk5ZYXQ2TXUyRTFIc1VTa1U4T0tTYUNaSXc5aFluNHlmaHhuL2oy?=
 =?utf-8?B?VTgwclp0ZlRXd1ZmQ09XWk5WVG9tSTFBa2ViZWpiK0dEUXBWZFJHRnNoNTZJ?=
 =?utf-8?B?MDdOUDU0dzV4aitpSk1oT3NqRVEyc1IrdDhUYVI0N0VqM3EzcjIvUjVxN2pm?=
 =?utf-8?B?aDlHWE9zZnExcGNjamJob0d4RWdicWhib1RZTHhScXcvOTJkQzhBWUVLMHNz?=
 =?utf-8?B?UldKNVNzOUdsalZSMU1SRTR1RWVnMTNDdEtXNU1YZXhZamZuOTdTZUg3cGd3?=
 =?utf-8?B?U0ZJd0FBbkFRR08zS0NsalpvZStobGtWYW5KZkxRRmloOGtrQ3NweCsycmkw?=
 =?utf-8?B?cGtLV0c0UEIwQXU0eTU2a2pCRzcwVGhlaVhEdmVzZjl3dVFuSUFQNUppKzFV?=
 =?utf-8?B?UlJpRWpyb25uTEJXb3JLamZ3S1h4Mm5uNTZUOXNLc0Fwb2xrM0NuVjcrcHRy?=
 =?utf-8?B?MGJMcTNiTHdFT2FXYXlFSW9SdFZUWERvcEZsZWVubFMyNDQ4VzJTcFJVRFAy?=
 =?utf-8?B?WEQzVW1ibzRpdzd6a0l3dlQvcVlYU1VpVmIwaW1DSm5wbzNSYlZ5U2xhRjlU?=
 =?utf-8?B?WGZPdWFoc0dYNHdwUnFJcFBHWDl2YTYwQ0ZIbGhTMGRGVG5xd0hkV24zZGkw?=
 =?utf-8?B?cjdQNHZLK2N1OTJQbHVUMDU5Qm5ORFJtNElnMGVNMVprWkVvRUVKZUJ2NHAw?=
 =?utf-8?B?cllac2lSRzBLMUxUMGRuaklybmdoVWFCaExzV2kycjZvMk53REJiOCs2NmR6?=
 =?utf-8?B?UVFxME9SazZPeU1lNTZ5T0xzaXVNc0gzMlpkQVBseDFSSXRmQVN1V0hpS3pT?=
 =?utf-8?B?Z3N3MW9mNGc1Z0hmUG1GYXpqc1QvSGZkVy95a05vZW9zN21OZGVGOENVaG1E?=
 =?utf-8?B?U0doWXYzRFRJOHloRDE5MjNMOXNMdS9HZzJjWk51TzVSS056djJURmYyamlH?=
 =?utf-8?B?T1ROOVVhRXcvMk1qaTVmQ3hVYjkrMC9pNTRNRzkvQ3RYemRQQzJtZ05rZGx6?=
 =?utf-8?B?K1FvMG1USmt6M3NRMWJUWWVJMURWQ2M1NVRIQ3VRc3I4b0ZJU0I2QlkxL2U2?=
 =?utf-8?B?cEdybCtQTkZYblJRK0Q3OUl2OVNaQjZoMlV0Tld6bWFVVlhyL0hhZmVxdGFh?=
 =?utf-8?B?V0d3SXFHbGRIenMweHdjTW9MSTlIc1ppWlN6MDVKRGdBRjhobGUyRFB3em41?=
 =?utf-8?B?QWh4aHNjakdEZXVxaDg1THF0OGlXS3Z5K0pGRnpiekZncmlXbE5nQ1htcUM4?=
 =?utf-8?B?bDMwY0ZWbHdqeUVQMTZPRUlQTytIbHE2Z3l1Q3lZWWMwdm5VbW1lU2VLZXQ0?=
 =?utf-8?B?VXNXelFRZkZWWTU2UDRmL3FGMFpKbUZFcmdHYUNqNG5Pb214Vzh4Tm02bEhy?=
 =?utf-8?B?Nnl0WWpDSjh6S1FLWGFDS2xiSy9TbnEyakgxMWE0ZlF2U2hKTEY1WUcrMjZs?=
 =?utf-8?B?K3VZNlZYVXB0Qm5oRnBXTU1XcWYrNXZHRmZ1cXBIQnp3Wm1wNDBVTi9uWU1k?=
 =?utf-8?B?SjVjaGxpNWZNdHppL3h5TGJLSkdoeTlKQ0J5T25RMXJOV0pSYUJEOXpuZ3Rn?=
 =?utf-8?B?cUFLY1FQZ08rb2plbXpvVktvRUE5UDlHZ2dSdGdXMlFJekF4L3RRdyt3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SCtFK3drK1o1WkxxMUV6anU4eTQyQUFzMFY3UVVQamRSYWtIcXlXalh0dGJG?=
 =?utf-8?B?YTFCdnI2MUxKcUxvOXJxNFNSODloWTA1QzNreDZhTnY4d2s2ZWZYbkxKcllq?=
 =?utf-8?B?WnZoQjJ4QkJiczFvbXU2bkZMTUZMNm8wRWFqM0NRcHE1dEpCb2xMK0Y5N1JJ?=
 =?utf-8?B?ZTk4NzNRS1pNMzJLNXppYzlBU2w3aURCOVBrUkh6SXp6em5aWGk1UnJNZ25z?=
 =?utf-8?B?bTQ0Nmtjd2dQVDhTenBhd2xLYkhvNVlQZW5BWjZjajRpcTJKOFVsaWRkWlcv?=
 =?utf-8?B?b0JNSVovSW1aZDM3ZVNvc0RycEU5Mmk0cnMyTzRJV25iWEcrdVZkRkpHZDVt?=
 =?utf-8?B?QnBVUzFQNWxaYW5KMytMNEthOW9TT0pKb3NjZHhlN2t3b2J2ejQ4a1A2U0NW?=
 =?utf-8?B?aGU1NktFVE53Mi9KcWVybnE1SU92ZUhPOUgxQVFQR3Q1V2ZqUCtxUVBKUjN0?=
 =?utf-8?B?aWovVGxDMnAwbnY5M2RqYW1jdGlJd1hMMlJzdnRBZ3JXcTlkYlZlZXdYalJK?=
 =?utf-8?B?UTRQUmR1S3dDMHVWMVRvNG1ycmtzRHU0SU8ySHZ6Vmt4UkQ3Z1BLajZvTkNC?=
 =?utf-8?B?dzJycGNlMXJaOGY5N3REOGxFcERhc2VkN0c5NlBacENvcHdMWWR4RDJMcCtt?=
 =?utf-8?B?dkxmeWhGMEkrVlNsZlRQRmNOSEdpY0JIZldwekpJSy9DTk1tTE56MXNoQXdH?=
 =?utf-8?B?QmNCT3NCWUFlWVcvbDhQaEphMWZVaFFtdVFVOU5lSVhoS2NHdmVLOTZ3cjhD?=
 =?utf-8?B?VjZtOGZYSEFUSzZ2WHlCNTNhb1BWdnpld09ZYmJweE5YMjVCR1JyWFUwTkVn?=
 =?utf-8?B?OUR6RVlhWGtMMHFQVFZuTjVzSWpiZ2ZRc0xyTGlmQWE3OEoxVkxkdUVKVzcw?=
 =?utf-8?B?ZVd3cGhWelc1VC9hZmF1cFp1bTFBVkRRcWdkRlNXd3psNnc1UFhRNWV1VGkx?=
 =?utf-8?B?VGU1SGxUaE9TVjUzaGVRaUs3VTQrQTlUZXo2cC9Pa2tNZ2x3a0dQZEwzRklj?=
 =?utf-8?B?R2RrQTlEbmZoUUZSYjlaamFwRGo4ZVdYWXBQT3gvTU1QTnNldytaOVNoYytG?=
 =?utf-8?B?WWViZzBDa3VmT0lxUm5tUVFralZGamNxVm9DcXJBdlFkVVRxd0pKRkN5M0Vh?=
 =?utf-8?B?Umc3azNyL2dmN0MvQm5iam53WHdYMEtOQ2Z1MnZBR040a3JoaWN1c1ZiZlY5?=
 =?utf-8?B?bVRUUW5KK21Tam9DZHZZcUJMVHNaSEoyTm5wTmxwRmVVbkpJM082YkJkZmFJ?=
 =?utf-8?B?MnJtZFoxSDBsUUNQQmU1SVJBNUVLNjcyZ092UVducFlEVnpFTmVqdFRLWHVW?=
 =?utf-8?B?SG1kb0xvb0JuYnFneFNpdE11dXl3d1E4ZS8yVzQ0N1k5S3ZEcURHNVZIOENU?=
 =?utf-8?B?YmZNbUlyYkg4NTYxRzE2eDdRclZsbmJnSHVDZGlTazlMaHFQak1RZ3JCWUFG?=
 =?utf-8?B?aWNySVc2Nk8yZFF4S0ViQUlEVjZnSGlKVktzTU9uemtyWDUveHNYbHhhYVR2?=
 =?utf-8?B?VDNKdFl3V1dkaFQxRStpeWdKcjdsSEI5S2lQNmRXVFZKcXhKc3l0RHA4UW10?=
 =?utf-8?B?L2gzV1lpR0lCY01ERE9SdG54NGp2ZkNEU0RUSzl5dWp6VjdPVFZkM2VqeTlL?=
 =?utf-8?B?SzZVeXBEN2ZVelA2aGdUb2dkcXJkR1Q2WHdoRGRSTHhzRUhTcjJydGZVR2NQ?=
 =?utf-8?B?WFVMN1o3ZUtETFJERngxRnJaZmxlVHpjWlZEV1BNK1NLMTZzNUtBT3ZaSWZG?=
 =?utf-8?B?QTI3U3d3aDN1VkFqaDVkZEE0Ymh2aTNjaGlmaDVMczkraE5RMnVoU2xHTXJT?=
 =?utf-8?B?aXAyd1JZeG92Z0ZOeTRjMXRON2hYN1VJNlh0R1doNVdVNmlKYWtuL3hLbjFJ?=
 =?utf-8?B?b1FPWk5YR0pQYy9yNjhwQ0toVlgrczlhVi9qY3dyUUsvL0VyMUE4YWJPT3VU?=
 =?utf-8?B?N0ZzVFlBMnFkYlJ5QVBpVXBWakxTM0hENmdHWlRwUStlWktTWXJHQXhkTFpD?=
 =?utf-8?B?OUJxQkFQNXpkNGNtaWs0ODNyMGFOeloxRUxZR0NlU3ozRXoyb2dpSG9qTktF?=
 =?utf-8?B?Um12U0JQWExLWjZENDRyZXU0L2lxQVBSeE5RTUJuK09VT1hiV2RraUpjS3JU?=
 =?utf-8?B?NDFRYVhTaUI3REJsN1NtTWgra0NlUm9sZVNPamhDeHFybjFqRElaSW5kLzY0?=
 =?utf-8?Q?Tk+eSbPMpDrokWRfagcTN4E=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e54e298-280f-4072-bba4-08dce491bcdb
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 16:29:37.0880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dhfk7vJI5deffbsQ5zpjy8HXj2ZlP7DJl6cV/50LfdfPnCzUaLea56obuic0ahqUQq5rHsOhP5MrO7atwM1p5VuDj9HghEZ+4dt/Bddy88I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6675



On 10/4/24 9:14 AM, Jason Gunthorpe wrote:
> On Fri, Oct 04, 2024 at 09:05:46AM -0700, Yang Shi wrote:
>>
>> On 10/4/24 5:43 AM, Jason Gunthorpe wrote:
>>> On Thu, Oct 03, 2024 at 08:31:23AM -0700, Yang Shi wrote:
>>>> If I understand correctly, the check is mainly used to avoid the u64 -> u32
>>>> overflow. This check guarantee no overflow. If some crazy hardware really
>>>> requests that large memory, the allocation will fail.
>>> Sure, the kalloc will print a warn on anyhow if it is too big
>> Thank you. Will spin a new revision.
> Oh wait a sec, it is not so simple, the 31 is too big because the
> multiply will overflow or truncate to size_t too. This is why I picked
> something lower.

How about define the size as u64?

  static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
  {
-       u32 size;
+       u64 size;
         struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
         u32 num_sids;

It won't overflow and the large allocation will fail anyway.

>
> Jason


