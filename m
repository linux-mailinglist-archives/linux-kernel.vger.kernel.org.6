Return-Path: <linux-kernel+bounces-183418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD838C98C3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 07:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DF072817D2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 05:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF3E171AA;
	Mon, 20 May 2024 05:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="deDb015V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mpMUbDRJ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FD32F37;
	Mon, 20 May 2024 05:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716182651; cv=fail; b=nHS9C9DBcfPSTpl646nYd162IcH95s1SNeSCsCQfLD4yoYHFuISwi2VjaTTwFt2LxAULIde3QDSIH4ZdK27rRYG5gBmxOSdzkMnMaA7WMoJz5HYdXZDaCfc3SQWE+CyXxmAOqdR7AxcD298bJiANcP6daZtTWupNTOh1ocZdJA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716182651; c=relaxed/simple;
	bh=EhH3p46d/8tUyih2DWL3xco/ttRBLgcKqAl6DCkfw+Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tgBgGOVnbXmmypTZS7zTqOSwuFXtDt2JCcOykwak5T95+aI4LCevcLOV11pXoYGukzS9ZB/reCXCHUYIUFuhULS78G0skEAEVdNhoIVVNlhcdUuMKtr5lLOGdoJZjsQBTR+RJd/nEL6cXjAm5Ca7tdKsAYMzhx1uSuSfIub+bGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=deDb015V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mpMUbDRJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44K5JLYA020541;
	Mon, 20 May 2024 05:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=wv6vJEeOEED7iCIjdiR2GhBV/ERyen+yT7t/Bmu9Bug=;
 b=deDb015Vyh8o+PIzIv1m4tw//lHtY+wlbBYMA5WE3yAOrSIpNnGv3t9f6/QM35uz0+IR
 StSDLvaL1L1Wg3hYkN2KavDnQ5Erf2Zd00U1D52O3ILMdI5912U1l5ZwU0E8CZzZlj+1
 DIE5PomiU43dEL7S5yC2A4feWbMXvg1/QJjoy96TDGUjIAWmL7/NmCR2Xo25zYB7zZk0
 csiGgJ0MhwQqqOoS3JI1uXZv0rySGy9oPNWkx0Lg1xIbjpc8XxuF3gsoxhxXdlkRIR1o
 JTJ6Qp52hrDLK6YLAjPbCJJX3KAHB4n6jYgR3bqYEWuGJShltwdKqfQTBSDmzCGd62vt +w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6jx29vmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 May 2024 05:23:47 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44K40mK0004984;
	Mon, 20 May 2024 05:23:46 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js5vkxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 May 2024 05:23:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vmcdbj9ao5jTN/1jDFm89hRY5nsCQeKf2MafIK/gd577D72FyE3CK0BTiKGUW5KOqe+4R34/ynyuwQZe/NBcGAFjlGx1EyUz3xNGNVWEy39uqAloFPTdhV9Lff4RypnK/WmAHQ9u6DEnoI574BzYaoVeUOulV/xzGguhK8xmlPzG44iUi4n/X18uWXq+801eGabbcr9s9tQsBR42s3EJJMcp+ppXyuxUT/NLbD70PuppIhc6p3Xd8bL8nHAHEnPmc079l/NVGfwgGfRNBbwXHN/uysj+WgnxmbQS8Thi8tbmbDEtyRGuZnD33YaJJcH9Gjp7gCJXypvhXt79z/hq4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wv6vJEeOEED7iCIjdiR2GhBV/ERyen+yT7t/Bmu9Bug=;
 b=Fza+GOuPgGaaO0Rr2p5LaEd1bTC4BmBvqX/MCx0BOI2noanLRFq3tlh01ieUhSP9/8VdK6FcKJVMJ2Pvo9deXpChzzl24GyMw5NRtKojIYlbnEh5T2iDpdz7KB+41ZWiKADpumtjehTCi2aYm7znjMUXIeHnHP3+wLWdL0ip6IYtPjt7/7edqYE3JrxijXBr3xoCbSR3WfO+VEFnsgu3Gj/HHso+bDfNsWs/W1WiHmyw0WnJUPud1TnABltWKShuaohQL+yUYI0om0ao46+jjC8jTwby1JwOsAMtr6N+sKkX2CZVdzxbAwD+hPk6a1bY5p2rOKtvOsHLZUEs1QXSDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wv6vJEeOEED7iCIjdiR2GhBV/ERyen+yT7t/Bmu9Bug=;
 b=mpMUbDRJEvOs5jYVBlEZAKSixH6/U6ZC+wN5IaWxpbbkePrJv5eG2pIMvKgzzL7OtZ8sjQRampm0JZGw8MZ22ipkY+Rc5zVsO20BFbtQVlTjuu96F8Nlr2K3Jh0GSpLmpAU7tp/bCjeQTXlLAxQ62JH6NSNoit80sCaZN3iIWn8=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by IA1PR10MB6123.namprd10.prod.outlook.com (2603:10b6:208:3a9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 05:23:44 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::309b:26bb:11d5:cc76]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::309b:26bb:11d5:cc76%7]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 05:23:44 +0000
Message-ID: <056695ad-fbb8-4ca2-a1c6-07082af6fed7@oracle.com>
Date: Mon, 20 May 2024 10:53:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: ISST: fix use after free problem in
 tpmi_sst_dev_remove()
To: Su Hui <suhui@nfschina.com>, srinivas.pandruvada@linux.intel.com,
        hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, nathan@kernel.org,
        ndesaulniers@google.com, morbo@google.com, justinstitt@google.com
Cc: rui.zhang@intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kernel-janitors@vger.kernel.org
References: <20240520021934.113877-1-suhui@nfschina.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240520021934.113877-1-suhui@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0019.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::6)
 To PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|IA1PR10MB6123:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fee8b17-d1e8-4c69-b5e2-08dc788d046f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UldZdmFDVkhwMGJNYjNHZDZOR0dQRVNFNnVzdjNFVjZzSGhkczhWWGpSSWJz?=
 =?utf-8?B?Q250ZlpYeUhKM0N2eDNPanpDcFhmc1hvK1dpY0IwWXdTR1c1bFBwdkZCeE9C?=
 =?utf-8?B?NDFRVjd1c2l4TFVFTUp4WWl5REF6TlppdG1iRTdva05pdnlHNDB3YWtXZTFw?=
 =?utf-8?B?Zjd1ZDZ2SktTcGsvMkI1ZVdrdjMzdVI5RDcvU2VFR2Z2MXpUbFdOeCtxUWll?=
 =?utf-8?B?VTFuU0lDTTJxTDBWWUVjUjh5dWdjeGpiajFOV1prUlhocVVRYlNLc29Yd2FR?=
 =?utf-8?B?L0hJWjN3VUdQeWVNZk15VDhNczFQc1FLWUZyakUzODZ1aW90bGhyRlFPTFdB?=
 =?utf-8?B?OVc5ZklBRHZnN1RGSTg1OTRYV0VEQXBBY0k5eHk2RTM4b1VaWCttTlcxMEhp?=
 =?utf-8?B?dEptTjJ3YldzczE1eitBMWdkM2tTS2tuZ2lNakhJbDV0UVkwS1lPa1BiRTV2?=
 =?utf-8?B?ZkwwaS9jRzZ3cDdpVnNSR3p4QnNMY1BCeHF0dXpiaGl6OEFrMUFoWGIvTkg2?=
 =?utf-8?B?aFZUUW5HU3R2UjRDYWVDTlE4bVh6MWI0M0svQ3laaFBZYzhNaVIwRVY2S055?=
 =?utf-8?B?cDh1VHBQQ0ZKaS9vODFHYVppVUpqK0RzRU9QU0ZZOUZ0YW96TG9xcFppLzla?=
 =?utf-8?B?b0VIcmJ4eHZINnY5bXdYTDVUY2tJNlFpSFJJaW53ZGZ2RjhGVHpyWVdXMGl2?=
 =?utf-8?B?QWxzL3kyZG1vakF2N2JqczIwT1VncnZsSGs5ZE50MXBtZE9qUjE4MzNRYmhM?=
 =?utf-8?B?bXRuQ0hUYzVEY2o4UFFYUFhKTWxwVC9GM1FsWGRNMHRtVHJVdE9BS1l4R1Fa?=
 =?utf-8?B?dUVlK3VGTTlpRCtDSGRCVW5zTjBpbm4rcTkxVW9IQTErL3p6ZkR5b2Vta2hC?=
 =?utf-8?B?NEhqelZWNlpHTmNqV2VGV3pRVTJOdk14YThyeEIwL29MVGRzWUI2dFBCWm0v?=
 =?utf-8?B?WWVaRnBvSjdUTkdyZ1BjaWlwd3FsUzAyRlZCVkVNU1k0NURyYjhwNGR4dnA4?=
 =?utf-8?B?OG9mYTVhc3ZtRkV6WDUxeHdROVFhc2haOGFXUXI2bDJhWjMvdTZDdGFzNXZP?=
 =?utf-8?B?SXJDMC93UnRaVTRQOCt3YXRudzFhNHNjS1pQamI5Sjlzb0RwKzNlWHZONGd0?=
 =?utf-8?B?ZWk0TkFKa3NPNFBMb0JoalM4UTd0UjdJMzRZNXcrTE9mVGdySkozMkNML0RL?=
 =?utf-8?B?OHVsZ3FvSXQ4T1Jpa1g0dnY1L3BqdmI5ZXFXNG5RR0JxK1k1Zis2RkNxS1pi?=
 =?utf-8?B?U3FXWHhGRCsxa2V3V2lXMGNsU0VnOTBFWlM1a1lVZ0VNWCtOcTBrc25ZWFlM?=
 =?utf-8?B?R0R4YkZmbG5YU3puTVlwNjJSNzd6T2lOYW9jcDIzWFZpRysrUkNrdStKV1FM?=
 =?utf-8?B?eUFDbGRlRTBHSEliMUZ1MlNOeTlNUVE4UE00YmMwaXJYTEZSSStJa2N4Snlx?=
 =?utf-8?B?K1B1eUZXQTRKYkpmTUdPYzJrVjZJeW1kWlZqa1FhalNJWXB2YWtJVEp6a3Y3?=
 =?utf-8?B?RUtuRTlzYitSemw0YmtsRGFzSXVMWit5L3I4WE1qQXdFNWtnejA4SDlVRHdy?=
 =?utf-8?B?djlSNHBKT2o2MFhuVjlDQzkxd1hMY0Y2MXRBV2ZRN2RKWEJJWVNTM1huV0hX?=
 =?utf-8?B?eStUbXdEOEhPckw4TFZ2UzdrNDk3bEE9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K2ltY2w4cE0rTllzcGlkbHJxVGJmNmZ4NnJvZlI3NHZsMktYck1FcmZ5SG5E?=
 =?utf-8?B?dVhDbUFkMk1wZmMzUWJmYnV5Y3VzejBjd1dsbE9oNXlieDdxRTlnZ3p4cEVS?=
 =?utf-8?B?NlR0U0RUQVJDWHRjVGRaeTJrNStidHFhbUtES2dWWkU4WEJYWng4d2RnS0Vk?=
 =?utf-8?B?SFVzclRuWVM4RDUvSzEvUCtKUlUxKzJjODdjSVJNd1FDdVc2OWFHTmZMYzRl?=
 =?utf-8?B?Mm8yMmJocFBENDh2b1luK0tMQktueDlYRTB2TGQycUtyL0E1OWQ1NzVGUWNY?=
 =?utf-8?B?L2JEcXlYamVhQ1Myek0rb0ludlN6VXFpU3JFdFVXMnkvT2F4TkZVUUdNVndr?=
 =?utf-8?B?N0JhVlRqYUU1UEs1b1laWUlJbUhSV012RERnRVUxWGpvMzd4QXAwUVhSM09D?=
 =?utf-8?B?NEQ2clpEUVc1emNWSGJPVGd5dm9HMk1YMTZYWDNtT1dwMXBJeGVzYXUyR0Ex?=
 =?utf-8?B?U2dxMWNSRTNoSndFUGdjS2dFYysvSHNRMWdWaWRxeVA3T3hsaEVIWnJHTEZ1?=
 =?utf-8?B?MUViS280L2JIK0pYcmJLYmJPSGJoblNlTFhHMFkrc0kxeU1tdkY1K0FxS25O?=
 =?utf-8?B?SkpJVE83d0FvaHBLUnZGeFRleWFHS01Id0Nkd1cvdE1qNkl3eW1LZUpXbzE3?=
 =?utf-8?B?WnlHTVF5eXlidW9TTWpNT2dIZTV2K00yRmQ3SnpIWk56SSthMHFNUUp5UUdC?=
 =?utf-8?B?YURzMWYxcmxHS2lqUUpuOElXbDFLQmttZmlydlBOMy9tK25sN1BVWWFzNk9Z?=
 =?utf-8?B?cm9jb01HNVZWa2NMcjE5aHFNL3ZRUisxL3RwUkZoV09oLzNUeWVJRE1ubjA4?=
 =?utf-8?B?WFl5bWNTYXZsS3VFaUJvN3FoVWJZMnlUN2gwOHNEazhXZzlhcmhncmJzTEFm?=
 =?utf-8?B?WDcrWng0ZUF1OTUvRm04V2hMUXF5S1pTYnNWcjdoc1U1U2dtYlM3V2hUMmxp?=
 =?utf-8?B?OFlxSTA0YURtWExIMmpkT1ExZEllbTcvMXFiV2JZNkF5MVRFamQvb0NOVkd3?=
 =?utf-8?B?dWIyb0pRWlZZNGhrS2ZVN2dJS1BpRlpBQnAwaDUzazdVS3JEbzMyMytkbU9X?=
 =?utf-8?B?blpNekJSOFNHQUJPRXRYRHN0VXYzS2JQSGw5eFJOa2RwVjFJVWw5WUl4cGdi?=
 =?utf-8?B?bjBpL2EzT2xyT1ZodVI0RnJDSnFBaXhBZXFzanJ3RndBUTdPQVdaVys5TGJK?=
 =?utf-8?B?dUVzeG1mVjA1R0wyUFVkWEx1THVDaEpDanRjT0ZnR2VHYlhYL0JEdUFpdC9T?=
 =?utf-8?B?MUVWbXl6OVZwcFZQaGVpQy91ajdzNWMrRU1sU1czWkpKRHNGeU9UcG83c2tj?=
 =?utf-8?B?dUl5YzNPc0l2ZjY0YWlraklhSSt3Z2FXb25oRmd4Vmp6YkpabUY5bjU1K2JE?=
 =?utf-8?B?d05La1ByNjNEbVZIRmx2V1RCTFQ0d015NU81SDduK21URkp3blQrWStoUFg5?=
 =?utf-8?B?U1h3R2RMT1F1RTBiLzB3S0ZQWGU1WkxDYkYrcmtWRVVOLzBPMThlN1RFa3ZV?=
 =?utf-8?B?Uml1YjV1eUl2WXAzaFZHMW03ak4rM0ZiNmh6L0ZXaVRtNXR2cmswWmdLVFRr?=
 =?utf-8?B?a2NRNm5OZm9yTTZyR0hONkJVYWg2MTFNK0FNSldPTm83bHRGcTRVRXdGMUpj?=
 =?utf-8?B?a3VKcmM2LzVOYnNSUFFjYVRWMldHdUluN0dMOFYva2VLRDZoanZjMHNORUlY?=
 =?utf-8?B?TGhyUk1ScjQxYThXNUluYnoxblA1NkZzQ1p4M2ZZWE85SEpGNkUrcDVFd3gv?=
 =?utf-8?B?UlV2aElRbVhWcXhvZklpbEJDN2RQdEJVZGxyS0NOQ21qUjdHNjd3d0YzUTND?=
 =?utf-8?B?aTNnR2E3M2ZBTysxdFVobFNESFFVNGJSS29rd2cvaTFidWNxbmxjclJERDIr?=
 =?utf-8?B?SnJhUU9pU1llcXpTRjJTZFdNNk1pcXZWRGRxaFY4bHo4cWlUamtnL2ErQVZp?=
 =?utf-8?B?M1NVUXVXaUVYcEN4aEdITmJQZmV3Qk1uaDVuVm9KOTVSWlV5dVQzNjVKdXdq?=
 =?utf-8?B?aEJiL2tsclpkdFB0WS9hMVJXMkQrQ2E1cGVPY3Q1RE1idG03Y1YxdDRZUDF0?=
 =?utf-8?B?Unc2UDFpZmJQbjRtdHhMdDFHczJjMmZIWHlWNHRwUkVzVkZnYXlXdzdJYS9F?=
 =?utf-8?B?OHZpby96TVNFNEQwcmJlNnFVRjNVbVlwZEV6NHcwUktCR2kwVmEvYWp4Zzdk?=
 =?utf-8?Q?3hGOakAszqtxSz5f0YNTfLg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	sw9WVfsjEhuAHs+LgrdC/Gei7r3gJJO/x0mXlmmpIZizxOS4ymrrMDFjcfGtrR8AU1DdjQhoxCfDdbmmY2k7BILvatspY6QBdb6pbROy2JM3QZvpLnWKqlXEOhMI7yXH3kA7fnZw5h97jvQ0GdB664vXIzLaXxrhvX9IAR/shrfhbLJmsXeyIoIwyi+eajCERnU/TgXZicsCowubhUH6B9JPSCFgPSbWXTLpvCz08PMz+KKLWesuEiym57HXHPnuHjmfLfznEoFCMOLNPDz5GS1DzCQqlWI1Ct+epf/kcEsRun8Nbix7Pcp0RaNKylQQB8jl8ppGhD0Q3GFrxumD3Hma/3TEIcFf1tcEqbMjIrr0+CndDHF604nEDt4Abv61a7np6Ru1tKHnpY76J+ta6UCmSZyFDU5E6IZ2mkOanMnnzc1UR+p1EgS2rE+YA9uiiGI2yPKoE1EPokGfaNBE3dIOCREgUDrfwmg3PVdf/UGfl4eItI1XnkL8a1or0mON67DZqZVfKWuYShxIXXFxTTtmjpWCHP+3d8LE8NVOBIQ12jfH1NrASt3pe91/Q0IbItbmlgSIGqsIe8Thrpr9Aym30b2uhxna7bSPunAcMuA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fee8b17-d1e8-4c69-b5e2-08dc788d046f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 05:23:44.2741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YfKq90UtudOx5EEA9xNoe3yhayRRmS2M8LQn5eK5qLCAjaKM/GLPnfCDxa2WyQwrok5jpq0XeYjtPOFxNdkrXxeD80omD5TtKhSVeQFD+HBx0hw6/TRo5JsuyH+miaW/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6123
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-20_02,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405200043
X-Proofpoint-GUID: w9YWtw7XTE5YleQBp5u-8iNz_VvTsKvy
X-Proofpoint-ORIG-GUID: w9YWtw7XTE5YleQBp5u-8iNz_VvTsKvy

Hi Su Hui,

On 20/05/24 07:49, Su Hui wrote:
> clang static checker (scan-build) warning:
> drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c:1614:24:
> Use of memory after it is freed.
> 
> Using 'tpmi_sst->package_id' after releasing 'tpmi_sst' causes this
> problem. Change the order of releasing 'tpmi_sst' to fix this.
> 

This is fixed by me already.
Ref: 
https://lore.kernel.org/all/9293c51c7d502843bfff90c5664be00bfe112e8d.camel@linux.intel.com/

Thanks,
Harshit
> Fixes: 9d1d36268f3d ("platform/x86: ISST: Support partitioned systems")
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>   drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> index 7bac7841ff0a..7fa360073f6e 100644
> --- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> @@ -1610,8 +1610,8 @@ void tpmi_sst_dev_remove(struct auxiliary_device *auxdev)
>   	tpmi_sst->partition_mask_current &= ~BIT(plat_info->partition);
>   	/* Free the package instance when the all partitions are removed */
>   	if (!tpmi_sst->partition_mask_current) {
> -		kfree(tpmi_sst);
>   		isst_common.sst_inst[tpmi_sst->package_id] = NULL;
> +		kfree(tpmi_sst);
>   	}
>   	mutex_unlock(&isst_tpmi_dev_lock);
>   }


