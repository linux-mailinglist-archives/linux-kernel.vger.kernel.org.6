Return-Path: <linux-kernel+bounces-176020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF4E8C28D1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 18:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A93AB2330E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 16:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B646F12E6A;
	Fri, 10 May 2024 16:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="KVomNN4n"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2114.outbound.protection.outlook.com [40.107.237.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3790A53A7
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715359080; cv=fail; b=uLvk4vA2r7Pzpy0qALQhfXYaHf39I9+Kqf5xKcitHd5erOX46Jl/Z1N6lF+bmbtmLkJsNaRv8TjJ/eMbhIiGHwROtqmPk8qhAXQbQucxIZQp0SZ2a6ft/YZMXmXh1wcMtXqXKRyMs0Z3VZfGTFnq3xw2ehn17ZdgNtA7A4nncdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715359080; c=relaxed/simple;
	bh=SBB8qUsE7pNI2vcJVLmNBaKIHxEhfjcgKVKURvzfXsk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TTBRgm2XFhrYdUiwxcotGPvldpKZwLNBKXNLVfa4js0rHTa2t3wVccwlBDU5Fm4c20fg9WquwTrAWqe2W5dlUaemArapYIy9QGfF4Mx43KGqLjYMbJE3a9pUG62VpuXEP2NwjBRoXYGQ30RnXkcfuQcqqtfFZDXn8dYgfqce0e8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=KVomNN4n; arc=fail smtp.client-ip=40.107.237.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+nlhsAjopUxH6ODHxY/HbEvhWT3pkhv+I/ujho5VJ1KagHlr4tH3LR3HWGymaD4fcfdADbNbu8jHy0vuTw5mNzcB/OEDV6a5vpL3KuAf0b2eWTSuHdpdsptY82WfKItA9ewQ1n7A8bck4Nf0t/Np42nDhZtXgjYlzgTEeYj+agRVrrNNO6t4CDXL48jgMGcLV7bq0vaCEoyMHYus1NV3sYOy9C5HXsIg5R946Yvw8HQa7z6B7OlhgsiI02vN4rAfnkFKpLkgkt36MqAMuhXg+TotaBml1kAHpvAyvS1WMueWumIU8n7Er5tEawCA5kDMVZVV1LLAkSGSeazvLdjuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJI/g6Eu0Gc/p9TKLQxgWr0lfPnahqSlXqVC94HFWDM=;
 b=AP6Shatykk1NG8jsdnOE5DLwPkYscy0L7a8YaM+T7pg5XS/w65iW9ULk/fXxZIz9Lk8ikd+ecAYQmfjhOGNnEI8HrYV3Tswk/mdE46SA9Xj1bPCzTsfN1GVVOCr9JCh1/ToALKh4j2ZPO11D77chDF0gOUnod5o/co8tMw22jBVp8IUUz5FpHBPPIJ/aiyNRBvSLmhMEDwOsxZjenVwjRarcEg2icpzpHyOWPtj6nlnqhcK3Pywjjy4qG9DeagSHdGJ8OYAK4xvUYjssG/2MUIb1rrHSYWwkmaozVON0S4rigz3tPQZCymSzpzBo8f9EOmKgsOqYPLWq5PIcZrnF4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJI/g6Eu0Gc/p9TKLQxgWr0lfPnahqSlXqVC94HFWDM=;
 b=KVomNN4nLY4w6jb2Tz5GhN2ZapWrW6AEeCtAagxpTFtaDQIhWAQv8HZiDK0BDTAeess7TpHiSUqgZOHseh2OLntpjzXc/utw8MEEFWO51Y/3SvmwZgEArTTfgvAD7QNLhKPAyiYqe3aJKXHNLlA5PKYmh3vSL7IfracpXfMeu0Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BYAPR01MB5463.prod.exchangelabs.com (2603:10b6:a03:11b::20) by
 MN0PR01MB7705.prod.exchangelabs.com (2603:10b6:208:378::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.49; Fri, 10 May 2024 16:37:55 +0000
Received: from BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955]) by BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955%4]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 16:37:54 +0000
Message-ID: <94061532-66c2-49cd-b7ac-92389b88367b@os.amperecomputing.com>
Date: Fri, 10 May 2024 09:37:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: mm: force write fault for atomic RMW instructions
To: Anshuman Khandual <anshuman.khandual@arm.com>, catalin.marinas@arm.com,
 will@kernel.org, scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240507223558.3039562-1-yang@os.amperecomputing.com>
 <c9c3c0d5-bb61-4eed-8b89-b0341a2c6f5c@arm.com>
 <bb60d304-3341-472d-a4ee-d31b4754c39b@os.amperecomputing.com>
 <5e6158aa-09d3-4665-878e-17358aee10cb@arm.com>
 <328c4c86-96c8-4896-8b6d-94f2facdac9a@os.amperecomputing.com>
 <42837c05-c111-49fc-bf19-e690608f66da@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <42837c05-c111-49fc-bf19-e690608f66da@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR08CA0030.namprd08.prod.outlook.com
 (2603:10b6:610:5a::40) To BYAPR01MB5463.prod.exchangelabs.com
 (2603:10b6:a03:11b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR01MB5463:EE_|MN0PR01MB7705:EE_
X-MS-Office365-Filtering-Correlation-Id: e9459ded-f161-47d6-0864-08dc710f8ab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1lWelJFVFc1cW1acE8zdFNjOW14WDl4MUNKQkZ6TW4wbVRwcGlpb1FQY2xv?=
 =?utf-8?B?ZW5KVG4yS0pCV2d0UHVLOFRUZTBtZkJlMTVaOVI2OUdrNlU3QVc1SStMUExX?=
 =?utf-8?B?YkxPSUNXTG1XT2QyMVpCUndyVlV6QktwaXVhM0dkQ2Vtc3ZJVTZ5Rmg4dnk3?=
 =?utf-8?B?Ky90RkZtU3dPVnUvemIvSHJHWjBDMGF0Y2xCYTRsVEtnQ0s2YmJEWUZIVm4x?=
 =?utf-8?B?TWlOOVVCSC9lVzlrS2s0V0k4M3BJbWsxVFFRWE9pck4yQWpsSnVFbTRBaHNs?=
 =?utf-8?B?TmwrVG5aT2kxdGJ5Q0NyeWZob1RRZThIY3JRQVk5YlhGdEdZL0ZGaVNqS3NF?=
 =?utf-8?B?L2xPNDE2amhTWmFTOVEvL2QvLzFiTFMvUW4zRGxkNTBGaW9YQmFmMk1LMHpw?=
 =?utf-8?B?Mis5S1FZQ0lxTzFkV1E1TnFLTVl0TVdsMldqM3pQS2puUHdlQS9GOTBYL1hz?=
 =?utf-8?B?QU1IL01JSUplbTA0U2dvcmFRSXZuVkIzSHY1Tm04SmU3UjJrWVI5aDBuZWVG?=
 =?utf-8?B?MDUwRHB3a203aXUwMGNONnluR3lnYkVZblNLUUVsVlhxTTR3QXFpK2prdC9l?=
 =?utf-8?B?M0dZRW54MTk4MVNSSEppWkgvRitxcTFtMWhzcHgzSjRrKzdkcUI0S3hjY2dp?=
 =?utf-8?B?TUkvSWN6WFh6K0N5S21lQTFpQkx5Q091WkVZTm50cUNrb0VXeHllY0ZCUVNv?=
 =?utf-8?B?ZWVIQmtSb2RVaW1HMmlmNC9XdzBaKzZZYTV4cVAyYlZ3K3A4ZzdIUlMxTEtH?=
 =?utf-8?B?ZTRhMkJjaFVCNFRlazlZeVkzUkMyWjg0dHdFMEQ5QkdJd3hDTE5sOWxEN2gz?=
 =?utf-8?B?VkZyT3hhVDU4TXRoNUQzRC9WOWsrTjFmdFFUUGVscmxZaGJPNGdKWTVzWXBI?=
 =?utf-8?B?dzVDQVE4V29zdUtjdW0xcWoxWjd0Zm53NEhwQXFFa0J5NnVSanpFa0xodmdO?=
 =?utf-8?B?VTJMUGhRdFZvVGdic1NEZWVvK21PcUFxVlRMbU8vYWNQS1hCODJxUU54ZUt4?=
 =?utf-8?B?MStJNlA1NlpFc3dJZXI5T3BvZ1V2cW12dzRCU0YycW94Sk5LZEJhU0F2WktI?=
 =?utf-8?B?OUZWNmVlY2YwcFhxTFdBUUljamNIN0NiMEt0WUppM0NYM3pKMUpwdVptaXAr?=
 =?utf-8?B?TXhkek53emhtcjlOUmtJMHVqdENpTW10OWVvTlZFcm9JOFhTODNxbmZnUnV0?=
 =?utf-8?B?Z1dJUHl6VS95dEVMWkRhVDVZM0tEcFMzVFJpd3c2OHlGcmJvUVVqeHp2Qm1O?=
 =?utf-8?B?dTBEUS9nM29BVUJUVXEwdmRIUXVJaFBvR1gzUHZ5NEZ3c2RNQTk5ZG9EdUph?=
 =?utf-8?B?TUNNblMwMDJKQURNQmUxWHFuK09ZSFE2RlJjdTdhZ0FPazlNaGt1ZlJ3NHRQ?=
 =?utf-8?B?dEFrN05tT2FaSVJnSGRaR2k2bjlTNW5CSUpiSm5Oc3d0SktGZ3dxRkxBVnNw?=
 =?utf-8?B?WTVLSFhYb205ZkduNTlEK2pLclFKR2VnaGhabXZ6T1NvODg4NEVDZnNHUUU5?=
 =?utf-8?B?blFhTUdyQkJDTGFlVUFPeGh6TUFscDNvUHBZa2FycndrL29kZHhCc0gxOGV3?=
 =?utf-8?B?Y0hCdU9FYytiYVJTbnlIWHVCUDVIRmRMYUI0dDdqRUxHSW9HRW03ekk1QnF0?=
 =?utf-8?B?akFMWWlaaExUTHlNeEFFbER6dFBPQWhwQ2FjWlczVGVSRGJuVWtzNUJHVnE0?=
 =?utf-8?B?WmNnZUwrV2NQNTZQNzVBNm1NdERyWitNcnVPS0NPdzVsTDNqSmtOcTNnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB5463.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THdmZUdpZFZHdEVYemtrbGd5TFpDSTc4dVBGSUl0VUNrdzljbDFxWTJrU01B?=
 =?utf-8?B?S0dIRWwvMjZRMFExZVVYZjZDUUtONzNYbENTZEs0UEFmRHNHdHc0ZFluWERm?=
 =?utf-8?B?eitDa1ZtVDJ2TUxUQitrMG5uVnVCdnJxSUxDSWtkOWt3YzBrUlFjUkhYMXZm?=
 =?utf-8?B?Vk1oSXJ4WUhpZ0NaMWhyWFF3MHJkY20yNnU1NEVYdElEb1NQY0cyUmdvVEFz?=
 =?utf-8?B?NGxhL2ticCtKSkxMSG5zeGIrSjdDRFdqbGZhdExsOGU4UnJVU3JVN00vbXFx?=
 =?utf-8?B?cXNFVWhxRlpTNzhicElldTdSVHRXemJLa2RHMUpDaVM4ckFzMGxvWUZLT3FO?=
 =?utf-8?B?aGpDeGVJNi82N3pRZHZ5MmVMRE14eHdLS2xaak9HaFZsbnpJUHVqRUJaT3dq?=
 =?utf-8?B?TkFEM0w1dTB6aUZ4bWtIY2dJMXZmcTNmMGdxbzFSdWVkQWl1am1FQ1dhSGhB?=
 =?utf-8?B?a1d2Y1dpNzRGcFJPL21vWFhSWG9TcmNNcFJGQ1JYVk1Md3E4SDhRQllpWGF1?=
 =?utf-8?B?K21vcm5zcStjN255SkFmdGVlRlpEQjdORFgvZGJFUnhtaWFiOGFXTldmUmJE?=
 =?utf-8?B?R3ArWU96MzZaU2llZUpkdlFneEl3ZFloRXVFVVNhQTRvcTVHclFLangrWS96?=
 =?utf-8?B?TVYvam5KaFRpNTRmbkpyZ0xnQmFkL0VBMmUrcjYwZjl5aVRrRjJob1I3QStD?=
 =?utf-8?B?OEl2ZnNDUklXQXVWRFFWYTYvTmduaUFzL2ZjYVFJclpoY3kvVjI0SHN3Tits?=
 =?utf-8?B?K0xOVE8yL1luREVkODZ3RGpQRWpjamcwTmRRTFRjekdSd0Q1THJsUFZVcWJa?=
 =?utf-8?B?SEQyWnc5dkhWbTJrQ2tQQVdCMGlMS3Nmak1ZRWh0aHBocUZoZ1RuRzYveUM3?=
 =?utf-8?B?cHo4TVE3aDYvUDZqL1ZjUVRsNnpSSnNYYVAwQkJhNFNQaEdtd21aeURqWGdY?=
 =?utf-8?B?alBaYjNEbmFnbHhjVkp1cmxVek9OT2ZVeXVESklySFpwa3pSNHUvVVNiM09h?=
 =?utf-8?B?RThQMjN5VzlwU1JWenk5VjdCNzY4blc5U1FpV3FGaGtSSVd5RTFCdHlqOStl?=
 =?utf-8?B?Z1lKRk83TC8yNHUwNzdxOEhZYUF1TURxWFFySVpTSm9uSm5KaXRFczVMUS93?=
 =?utf-8?B?c01QN1UvZEE4QkJKZHdHcmRiUjByUVF6Tkp2Z2RoQzZYRUVrUjZIdmxTRWZO?=
 =?utf-8?B?Ulp0STFwQXgvb1VxQ0xGRGE2cWkvclRDMzh4OWVScVFlaE5HWVNKUWhzSzJo?=
 =?utf-8?B?bWxnMFMySEZIeUNZVkI3aFdzOVZzNGc0QlF0N0cxRnhhU3RTUVBQaWNhK0ls?=
 =?utf-8?B?eCs0YXJ3WHFGRDdjZ29kR01ISnQxR09zYmszcWtjK1NBUmlBQTU1Rldxc1VF?=
 =?utf-8?B?aEs1dDJIVk5ETTN5VkZxRHhyRTZSM0w5K3g5TVRCOEV0bkhPWFJYdTFoUVp3?=
 =?utf-8?B?NlkrVlBVTjNvZlJUOTlFNHlZNWJaNmhVZXhKWFJVd0xIbXArc2RCVEJodEtw?=
 =?utf-8?B?cDB3OVlFeTRwQlRBT0pFb2JobW04TGZPY0pMMlplaGlyeDlMOXJYdjhaYmJ2?=
 =?utf-8?B?cjVHblhDMEo0Q1JHdzJ0VTd6Z0EwZExIbFVUcUIzbVdxMk44ZFhlVW5HRWxo?=
 =?utf-8?B?Y0tqb1RsKzBOeHN2cVNXOHc3R09XZHZva3RxRU96MkcyODFmbkMxelhtTHVU?=
 =?utf-8?B?dDBZdVR5dUk3YUJreEx6V0tqenNwOUM4L3MvdVVvUmxjNVVGbXh6YzY1aElD?=
 =?utf-8?B?cjJDK1Z0Tm1VWVVOcFJhVDlDR210VWs5YVJwMkdlZFR6UmZ0NTZoWFRNbkZy?=
 =?utf-8?B?R0w5ODVMcFM3c05SbEVnczZFYm12NmdxTUppWmdTNEtKd3RYdmp1VjlhU3B4?=
 =?utf-8?B?ZEFTNUovU1ZlcHpBa1hrb2U5bVFlWTRoNFRpd0JYdG5EY1gwR21VUUoyQTBB?=
 =?utf-8?B?V29mdmg0V2FRTHdPNERWNzljS1E3YVZPT1VWSEdDeHdXZ3dLVkZpc2JzMzRy?=
 =?utf-8?B?Y0pyU3A4dFRHYnVyaWRSeTI4TEU0Ym5nSlNxajUvVDlibjM5RG1oMUtUNVI5?=
 =?utf-8?B?Q0I4VHA1cHJrc2kyaEk0MTlwRnA2RnlVK1JHUzk1WXBvejRjb2cvT0FVTENk?=
 =?utf-8?B?STB6NWxLQ1Y0NXF6V0ZCMmhwNTVtNmNQaUN6UmVlQzFoUjBHME1DVTlvVXdU?=
 =?utf-8?Q?ujE8ytAGgCWJFieAARyhaw0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9459ded-f161-47d6-0864-08dc710f8ab0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB5463.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 16:37:54.7061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vjq6is3YJurNERC10lg1zVVNBFxCK9ULpqKHadLO75rqmTPaVZP04VOiVTUsPPkdr8+mF9/r6DHyXEjGWDmNfQOTRBQ8mkjXQT3/Xyc+NrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR01MB7705



On 5/9/24 9:28 PM, Anshuman Khandual wrote:
>
> On 5/10/24 03:16, Yang Shi wrote:
>>
>> On 5/8/24 9:31 PM, Anshuman Khandual wrote:
>>> On 5/9/24 00:07, Yang Shi wrote:
>>>> On 5/7/24 11:45 PM, Anshuman Khandual wrote:
>>>>> Hello Yang,
>>>>>
>>>>> On 5/8/24 04:05, Yang Shi wrote:
>>>>>> The atomic RMW instructions, for example, ldadd, actually does load +
>>>>>> add + store in one instruction, it may trigger two page faults, the
>>>>>> first fault is a read fault, the second fault is a write fault.
>>>>> It may or it will definitely create two consecutive page faults. What
>>>>> if the second write fault never came about. In that case an writable
>>>>> page table entry would be created unnecessarily (or even wrongfully),
>>>>> thus breaking the CoW.
>>>>>
>>>>> Just trying to understand, is the double page fault a possibility or
>>>>> a certainty. Does that depend on architecture (please do provide some
>>>>> links) or is it implementation defined.
>>>> Christopher helped answer some questions, I will skip those if I have nothing to add.
>>>>
>>>> It is defined in ARM architecture reference manual, so it is not implementation defined.
>>> Sure, but please replace the "may trigger" phrase above as appropriate.
>> Yeah, sure.
>>
>>>>>> Some applications use atomic RMW instructions to populate memory, for
>>>>>> example, openjdk uses atomic-add-0 to do pretouch (populate heap memory
>>>>> But why cannot normal store operation is sufficient for pre-touching
>>>>> the heap memory, why read-modify-write (RMW) is required instead ?
>>>> Memory write is fine, but it depends on applications. For example, JVM may want to "permit use of memory concurrently with pretouch". So they chose use atomic instead of memory write.
>>>>
>>>>>> at launch time) between v18 and v22.
>>>>> V18, V22 ?
>>>> v18/v19/v20/v21/v22
>>>>
>>>>>> But the double page fault has some problems:
>>>>>>
>>>>>> 1. Noticeable TLB overhead.  The kernel actually installs zero page with
>>>>>>       readonly PTE for the read fault.  The write fault will trigger a
>>>>>>       write-protection fault (CoW).  The CoW will allocate a new page and
>>>>>>       make the PTE point to the new page, this needs TLB invalidations.  The
>>>>>>       tlb invalidation and the mandatory memory barriers may incur
>>>>>>       significant overhead, particularly on the machines with many cores.
>>>>>>
>>>>>> 2. Break up huge pages.  If THP is on the read fault will install huge
>>>>>>       zero pages.  The later CoW will break up the huge page and allocate
>>>>>>       base pages instead of huge page.  The applications have to rely on
>>>>>>       khugepaged (kernel thread) to collapse huge pages asynchronously.
>>>>>>       This also incurs noticeable performance penalty.
>>>>>>
>>>>>> 3. 512x page faults with huge page.  Due to #2, the applications have to
>>>>>>       have page faults for every 4K area for the write, this makes the speed
>>>>>>       up by using huge page actually gone.
>>>>> The problems mentioned above are reasonable and expected.
>>>>>     If the memory address has some valid data, it must have already reached there
>>>>> via a previous write access, which would have caused initial CoW transition ?
>>>>> If the memory address has no valid data to begin with, why even use RMW ?
>>>>>
>>>>>> So it sounds pointless to have two page faults since we know the memory
>>>>>> will be definitely written very soon.  Forcing write fault for atomic RMW
>>>>>> instruction makes some sense and it can solve the aforementioned problems:
>>>>>>
>>>>>> Firstly, it just allocates zero'ed page, no tlb invalidation and memory
>>>>>> barriers anymore.
>>>>>> Secondly, it can populate writable huge pages in the first place and
>>>>>> don't break them up.  Just one page fault is needed for 2M area instrad
>>>>>> of 512 faults and also save cpu time by not using khugepaged.
>>>>>>
>>>>>> A simple micro benchmark which populates 1G memory shows the number of
>>>>>> page faults is reduced by half and the time spent by system is reduced
>>>>>> by 60% on a VM running on Ampere Altra platform.
>>>>>>
>>>>>> And the benchmark for anonymous read fault on 1G memory, file read fault
>>>>>> on 1G file (cold page cache and warm page cache) don't show noticeable
>>>>>> regression.
>>>>>>
>>>>>> Some other architectures also have code inspection in page fault path,
>>>>>> for example, SPARC and x86.
>>>>> Okay, I was about to ask, but is not calling get_user() for all data
>>>>> read page faults increase the cost for a hot code path in general for
>>>>> some potential savings for a very specific use case. Not sure if that
>>>>> is worth the trade-off.
>>>> I tested read fault latency (anonymous read fault and file read fault), I didn't see noticeable regression.
>>> Could you please run a multi threaded application accessing one common
>>> buffer while running these atomic operations. We just need to ensure
>>> that pagefault_disable()-enable() window is not preventing concurrent
>>> page faults and adding access latency to other threads.
>> I modified page_fault1 test in will-it-scale to make it just generate read fault (the original code generated write fault), and anonymous read fault should be the most sensitive case to this change. Then I ran the test with different number of threads (1 - 160
> Right, only with read data faults i.e (!FAULT_FLAG_WRITE and !FAULT_FLAG_INSTRUCTION)
> code path enters the pagefault_disable/enable() window, but all others will skip it.
>
> because total 160 cores on my test machine), please see the below table (hopefully my email client won't mess it)
>
> Thanks for providing the test results.
>
>> nr_threads           before                after            +/-
>> 1                      2056996            2048030        -0.4%
>> 20                    17836422          16718606      -6.27%
>> 40                    28536237          27958875      -2.03%
>> 60                    35947854          35236884      -2%
>> 80                    31646632          39209665      +24%
>> 100                  20836142          21017796      +0.9%
>> 120                  20350980          20635603      +1.4%
>> 140                  20041920          19904015      -0.7%
>> 160                  19561908          20264360      +3.6%
>>
>> Sometimes the after is better than the before, sometimes opposite. There are two outliers, other than them there is not noticeable regression.
> This does not look that bad, but will probably let others weigh in.
>
>> To rule out the worst case, I also ran the test 100 iterations with 160 threads then compared the worst case:
>>
>>      N           Min           Max        Median           Avg Stddev
>>   100         34770         84979         65536       63537.7 10358.873
>>   100         38077         87652         65536      63119.02 8792.7399
>>
>> Still no noticeable regression.
> I guess to make things better, probably pagefault_enable() could be moved
> before aarch64_insn_is_class_atomic() which might not need page faults to
> be disabled ? Also what about non user mode atomic instructions, causing
> similar scenarios ? Because get_user() will not be able to fetch those.

Yes, you are right, we can re-enable page fault once get_user() returns.

We don't handle non user mode atomic instructions. Is it a problem? The 
kernel address space should be always mapped or mapped for the most time.

>
>>>>>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>>>>>> ---
>>>>>>     arch/arm64/include/asm/insn.h |  1 +
>>>>>>     arch/arm64/mm/fault.c         | 19 +++++++++++++++++++
>>>>>>     2 files changed, 20 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
>>>>>> index db1aeacd4cd9..5d5a3fbeecc0 100644
>>>>>> --- a/arch/arm64/include/asm/insn.h
>>>>>> +++ b/arch/arm64/include/asm/insn.h
>>>>>> @@ -319,6 +319,7 @@ static __always_inline u32 aarch64_insn_get_##abbr##_value(void)    \
>>>>>>      * "-" means "don't care"
>>>>>>      */
>>>>>>     __AARCH64_INSN_FUNCS(class_branch_sys,    0x1c000000, 0x14000000)
>>>>>> +__AARCH64_INSN_FUNCS(class_atomic,    0x3b200c00, 0x38200000)
>>>>>>       __AARCH64_INSN_FUNCS(adr,    0x9F000000, 0x10000000)
>>>>>>     __AARCH64_INSN_FUNCS(adrp,    0x9F000000, 0x90000000)
>>>>>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>>>>>> index 8251e2fea9c7..f7bceedf5ef3 100644
>>>>>> --- a/arch/arm64/mm/fault.c
>>>>>> +++ b/arch/arm64/mm/fault.c
>>>>>> @@ -529,6 +529,7 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>>>>>>         unsigned int mm_flags = FAULT_FLAG_DEFAULT;
>>>>>>         unsigned long addr = untagged_addr(far);
>>>>>>         struct vm_area_struct *vma;
>>>>>> +    unsigned int insn;
>>>>>>           if (kprobe_page_fault(regs, esr))
>>>>>>             return 0;
>>>>>> @@ -586,6 +587,24 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>>>>>>         if (!vma)
>>>>>>             goto lock_mmap;
>>>>>>     +    if (mm_flags & (FAULT_FLAG_WRITE | FAULT_FLAG_INSTRUCTION))
>>>>>> +        goto continue_fault;
>>>>>> +
>>>>>> +    pagefault_disable();
>>>>>> +
>>>>>> +    if (get_user(insn, (unsigned int __user *) instruction_pointer(regs))) {
>>>>>> +        pagefault_enable();
>>>>>> +        goto continue_fault;
>>>>>> +    }
>>>>>> +
>>>>>> +    if (aarch64_insn_is_class_atomic(insn)) {
>>>>>> +        vm_flags = VM_WRITE;
>>>>>> +        mm_flags |= FAULT_FLAG_WRITE;
>>>>>> +    }
>>>>>> +
>>>>>> +    pagefault_enable();
>>>>>> +
>>>>>> +continue_fault:
>>>>>>         if (!(vma->vm_flags & vm_flags)) {
>>>>>>             vma_end_read(vma);
>>>>>>             goto lock_mmap;


