Return-Path: <linux-kernel+bounces-510159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D847A31903
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 23:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 231977A2372
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A4D27292E;
	Tue, 11 Feb 2025 22:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2ce+p/6a"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17A8272905
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 22:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739314161; cv=fail; b=ecWUpE5x8w1uEW/eNnmY5Hb/VcC5ejSKfwtOceLPK4aFObJmWqjw1A4lPCmG+VjIgszKPMZogyFInQnSNvRxMCHYLuT8bTtsjKwVTCpnofAO3Ks5pyLKm02xEedOnf1pwiaOe/mylJqL+FDTG0wzBxv/uSgkFN9NyUqZLBVyAOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739314161; c=relaxed/simple;
	bh=jZYsqdlRviTENSd5j3/UO4FQ2/05YP8dKCdKqSrmIGc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GLV6pEfXU2DTl6lZVjxONYGYDRZHPoHIgkDIqwH6z2Lhf8LoG7PbFOoUYu6yAPlA4fKPbwBQQ8LDUnknJKpTblqEAU3rih0yMb8QDJ3Ol+fpUWMSxnHGBWWXA92IQf4aJB9XrZmJQjOlv6b681Jkg+MLm68XocL8bj1ET/RjRHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2ce+p/6a; arc=fail smtp.client-ip=40.107.93.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uagxWrFOVveVFeGUdHI1dsOzInWrmwSolrc2uc0yRPZ96YV3qEpeyOpDSijm9jJ9wMa925qWbbMjWJTx1ZESiSEgiRFH4oTwpVU0lNni/DQoTyZhlFetHAqB5boZN/JcmTBoJBkiEakGNd9L+C4NPGaW8IUwzIQ080ynz5kPbUVU1cNA+IHyvrOlKKUAJVXIzs9vzbN80rjE/jnEXA9IWJ093VP+MnWmPjdg/IwVoyttvO+teNBPW2r30k8iK4KBmW5hyCxThqjoueSi1R6goKoMtzeyqGk1D/lmI2A/dpnGSqpIjADMBe/MfGPQbicyVKg/ZWnNMySPiX98dVIjSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZYsqdlRviTENSd5j3/UO4FQ2/05YP8dKCdKqSrmIGc=;
 b=lVsO1++TVigpamuRR5LTsNlGdcSS2U2CWLJUyXolIuunnD8vpJcHE2EwuwyuMdpRFFSIe51rcCwUvJnLvy7eXp2wd/9qHaTZ/cuU8kBSdOttVO8TJ7usKX2ABckaATsAInqBYpuusdZtcGeXYPRrDz1Jl7S3enuBJzdSiTuG10YrXIhU/XCb9HOaDuA9pDcFhcFNrxDuQBb/sl2xoYYNkRZDMj7IhaubMke7js+dK2Cbl4MeAB9Z34KogCIhferIeRYWI5+s98N7Hm3ELWefFtzZiujKF9cO0Ji1xtXTRMu+k75mjIlH0deoRItzLLfZtqDzlAfnsKzQryK2LSpjYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZYsqdlRviTENSd5j3/UO4FQ2/05YP8dKCdKqSrmIGc=;
 b=2ce+p/6asYOL3Dpcs+G/aLZCMTja+pLu8sYVS1VGeAq6dp/5Tvikv30YSk6iFj6ShmCri+yk1hfGsXtgKbaO4TEqUz/DE3uzhjiXj2sW83KWu2PYkSRGCuql6sxI6FJm1AF2Hpm7Dq8CY+U3J4X2PCJH2irXYOHsz2fKSMMQWx0=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by DS7PR12MB8346.namprd12.prod.outlook.com (2603:10b6:8:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 22:49:15 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%4]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 22:49:15 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 07/35] x86/bugs: Restructure rfds mitigation
Thread-Topic: [PATCH v3 07/35] x86/bugs: Restructure rfds mitigation
Thread-Index: AQHbfBScbn+B2tJzmEel9xjFi/2QlbNCth7g
Date: Tue, 11 Feb 2025 22:49:15 +0000
Message-ID:
 <LV3PR12MB92654726906761BD0BB1FB3B94FD2@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20250108202515.385902-1-david.kaplan@amd.com>
 <20250108202515.385902-8-david.kaplan@amd.com>
 <20250210233624.aj4tmhzhryx5jkmd@jpoimboe>
In-Reply-To: <20250210233624.aj4tmhzhryx5jkmd@jpoimboe>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=9aad712e-88aa-4e00-bfd8-c2d5064b525b;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-11T22:48:59Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|DS7PR12MB8346:EE_
x-ms-office365-filtering-correlation-id: 852cdffd-05c2-441e-cd30-08dd4aee4fcf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SzRPMHVsaktPYis5OEU3cWVZYk5WSmdERG1rMmJ4REprTHVpUTBMK1R4c29y?=
 =?utf-8?B?SHo5S0hkYlBhNDNCYkJiaEpqUFc5L2N3Q3k2dVRhQ1BkeEVvN0pFbHhRRlF1?=
 =?utf-8?B?MW83NitBVHpnUldEN1dGall5WThNaDE3WFYxVU5qb2lwbHJCY2FaMlc0SGZr?=
 =?utf-8?B?RXViWUtaZTdEK2hVOGVWSFNISERIZDRFTThaWDhaK3pGUm5zbnBtd0s4QkZB?=
 =?utf-8?B?K3NwNWQ5eHlGZ25qY3AyR1E2QmUxNVA2em5adngrN05QSXlPd0JaS2I3RmJt?=
 =?utf-8?B?c0RDa2JpTm0vTG1TaTk1VGNBbTZwVW5tL2xtbEZFS3hNY2VQaXNKRGlBR0U1?=
 =?utf-8?B?OHdXemlaZE5sa1dxUVU4UDRZbFgwbkl6dVg3S0ZHeWZreDNNM2ZSRTFIak5t?=
 =?utf-8?B?OEdvcWdwdjNIV0xxcTQ0TVdZWTNreVdRcFFrRUYwN0taelZWWUNKQ1dJcXVW?=
 =?utf-8?B?MGc5VUo1NjdnR2RDUys1Q29zaDRUdTZwUkZadVF4SEtRVzIvSlB0dm9qTmFK?=
 =?utf-8?B?VFZKU2RjYjdIMDR4Z1pWTDRjRnEzYXhaVDJRQU9lanZRSHZicFpiM25OMDhq?=
 =?utf-8?B?VCt2WUdFRkE4NjJudUUxTi93MzBoazZ6ajhSMTJLT1BuejdiR3dtTXF1dGRl?=
 =?utf-8?B?UXBONEdZYVhxUExKRkNOeEZPZmNmd2E5TWhuRGJ4dzByOFl4TWJ0VkZabTIr?=
 =?utf-8?B?ZGxYR0NoU0xldVI4RlJmcjYwdU5rbmtYdmFNWWdyTEJjeEV3MWkxT2FRT01j?=
 =?utf-8?B?em1TOUh6R3U2anFoeS9GTnp2K0pOQW85YUVWck1XMXNHRlNlQ1FTWmNNdnQ1?=
 =?utf-8?B?RklSTmNhTm1YZ2x3RHppU1lWT2lVdFNKY21XSmlvZGZFdy9sNDVRRmNEZTdv?=
 =?utf-8?B?Yzh1SUZRdkF3QnRZS1R2dEpHcDJxeHRiVngzbm12Vno5M3N0czkxamF4MmRn?=
 =?utf-8?B?S2ZwQXJPYVljRjdHNjNlSlNFWVVoRGlwYVRoaGQzQnIzOHlhWk5lWjdjVmFa?=
 =?utf-8?B?clFRWjMzakJTMk4wMEQ3aVNlZXU0L2dTZHI0M0JrOWc3QXpWREFVRWQwUDZ2?=
 =?utf-8?B?Ry9VbkZrUEN6VnZYZjVPWnNGRnhlREZUU3RLcDVoaHhsdDc1T3ZoTG9TK3lB?=
 =?utf-8?B?NWtpK1pLSkp2cGVQTnQybDBDajZpYzU2SEtEN0pnSEVtVDViZG5aMlpHV1VQ?=
 =?utf-8?B?NXhNNTVIVmVXUjgwTjZHbnR4Ulh4TXkwZHBrYzh1bjJWb0YrOXhjT0gxdDQ1?=
 =?utf-8?B?RmlwRjQ0UVpOTElIbSs5NExGREswT1V0SFNJTXBCSWNIeVlBZHJ1aTAyUmtW?=
 =?utf-8?B?c2RvdkRJeFlUenU3Vm5iNzFwZkZJckF4MmlCeUpxTWVWcit0bW1TY3VHZ2VP?=
 =?utf-8?B?clIrNW1ZZ2VnallLZTdVZ0duOWZESkhlSGFLZDF2SUQvR2xSck9Sd3FDSEla?=
 =?utf-8?B?VWJ0Y0lXVFdJa2pxdndvMTd0U3RlSGNvNWpyc2h1KzhvSnBRMXd2QVArd1hw?=
 =?utf-8?B?QzA4VzE3UXM0NHFkazNiLzFDZ2g0YzVEbzNyN2NUVE1Fd2Qrd3l4cUNUbTNH?=
 =?utf-8?B?d05lby9VQTBGa3ZveEkyUnFvRW9FUlpuRWJqVlNJck12R2NTck5vdGx2SW9w?=
 =?utf-8?B?UXhYMTJIeEFpV1lHNy8vSWN2RFhDZUlra1ZwSGRYc3B4NUtHc3c2WmR2ek40?=
 =?utf-8?B?c1hUamxjOVBGeVJXTXRwcVh3S2hvZmxydVc1WjZhUk5UQkpjNmRmT3pxRHlE?=
 =?utf-8?B?OW45b2IrTDU1MHFEby85ajRpK21VdUtzdnZBdHBZS0c0eVBBbE5UbDZ4bVEv?=
 =?utf-8?B?QjFpMDd6MDNIaHVkbWV5V0FVSVhBbVdPMktxVmtGQW9BVGYxTHdlczhhNTRt?=
 =?utf-8?B?ZjFZaEQ1UlBBYmhyaGl1NHNjUzZpMU1rL05iNExVMzd1QWdBdXN0YjViNG9O?=
 =?utf-8?Q?TFwiYztOaJGw10osOExlgXlgNLHIgzbt?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OFIwOGMvQlcvS1FSNzJIQng5ZnAvL3lFajVaRFZnTkhOa0d3TGpsV2tHZjhr?=
 =?utf-8?B?M3M4NGwxbTU1NEQ5MkV1QUd0NVhPMmp3ZkVNTlNSZEZ3RzcrdVBHbzF4NzlS?=
 =?utf-8?B?T3RTeWRKc08vQVRjZFBkSno5ajdHY3I0TC91TmRDcFVaSk5XWmNkSEd6TGVw?=
 =?utf-8?B?WldhSzNYMlRqQ1FqaWNyeDdLeXZBaXo1SVFvTzc2UGt3bEtQMVZ4VHY2U3JW?=
 =?utf-8?B?VUtqZjF6MGRJT2tlc3FZbVVDRlcydW1XdVFJTjQxNVlBMlNJN2hpYlRLZG12?=
 =?utf-8?B?cWViZHYwaC9HVjNNMVkrTTlRVjZoOWdJTEx2bWEzZEZoeWs0NjRLSHZzU0sz?=
 =?utf-8?B?VXh4VlNPMHJDcW9vTHNvNElkeGpBcklDQ2xnakxmRmpXckd5bW4xWi81a0I0?=
 =?utf-8?B?a0phNUpNdVo3SjBHT1FueWRiMkdtbUxZVGRmajRHOW9GZzJoOFdVY0xBQ1pz?=
 =?utf-8?B?MWViWUkzelpjY3J1dTdTM3gxSTZlVkRoQnpQUzQ3cG81aHdnQ1k4VlJJdmhB?=
 =?utf-8?B?ako2azdpMVJ1aGlCd3J1OTNHVVBKcVc1bm9URm9iZW5NY291K2V5ZG96RjFB?=
 =?utf-8?B?dHZmeVBiMVcxZVlHNkUrSXRxQ3JzYnRQSG5EbHU1bElIUTQzVm0xbVY4eUZu?=
 =?utf-8?B?Z2pIK1VSTjZPcGRpbXJCbkVjWmFiYkl4R1J6Q2lEcFQ2OS8waHZDNkd6aTZW?=
 =?utf-8?B?L3o5T1pTUlpiSTI2WlhKNjVabkJIaVhJME9LRnJWc3k2RHMxelJnWlVzK1Jp?=
 =?utf-8?B?WS9TUFBMS3puZC92Ukl0K2FDeVR0ak9uM3E5dUZkUXBlMk5ZK1A3N1p1Y2VV?=
 =?utf-8?B?ckpmNVE2aXJPbzY1VUxuemFTNytTSlFGZ3Y3M3BVaW5BdDlXYW1WcGVraVpJ?=
 =?utf-8?B?ZVdtbFJmeWRXTU51QlBXOXJlWUExd3dpcGdSb0tRR0FIRzBhakt4RStBZEEy?=
 =?utf-8?B?Tmh1Y0JRS3JOT0tybU9KcWZ5V0dQN3RyWmJsZ1ZxK0dyRVZWaVByeCt0ajNM?=
 =?utf-8?B?aW1YTUIxSlJsVlNCZWY0WC9IM2c4aVB0ZldjOXZ5SGZiZ0tzZXNlTHozRUZD?=
 =?utf-8?B?bFdvRkdFOFY4NnJKNkd0enEzQ0xZMlFXVEVNYjBHd3p6Zk1JQ3NiZHdWQ3dO?=
 =?utf-8?B?MldabjdYQzJMSFpxVUdEeWFFeVl1OGpGR3VIR2wyWVJ0NGtxeW1RR3BwVklK?=
 =?utf-8?B?bmg0eUVkVXZ4U2ViSU5NOUMwUHNFTGE2K01jbitiRkR6UHB2YXlXOFVsRDlm?=
 =?utf-8?B?TjNwWUtlbFRhbUdYT2lRRmhuUS9KNkkxUm5oU2dDVjN0QmxHK2xiaGdkcnhG?=
 =?utf-8?B?R3hqS3BwMHFGbCtJQkZwNUJXQ1hHZnMvbkFHbVN2ZU5YNjZ5UDdlUHRObmxB?=
 =?utf-8?B?QVBlNGgyL3ZEa1IxZXNUN25QZEV1bzRkRC9rTGxJcEpMR1UzNVd3OHNSaVdH?=
 =?utf-8?B?VSt4UWJtRGIzVDhwOGFqeWsvckdoMG1MZFRYTW0rTGl4UklhUXBzTzRHTmd1?=
 =?utf-8?B?dHc4S3NONlJYR2ovOWpzMlY0YmN6Q0tjd3BDTWZBTmpicVlKTmdDenNYU0xX?=
 =?utf-8?B?TENoUDY3RC9mMFdBT1NYQW1XWS95cjBrQncyLzJnNnA0UlF4b1JUTzVncDVK?=
 =?utf-8?B?a3d0VFh4a3BHMTd1T2pROHFzWlR2NVJYYmN1VEY0aC8zaVpDNFVqM0Jpakwr?=
 =?utf-8?B?RkI0eUUwY2Rsc0FVdjN5MHRLanhSR1VwSHRlWkc1eW54Qi9QMHdIM205WjhQ?=
 =?utf-8?B?eXFDS3NWSUxFNDdEN1FaOTJhdWNTWVYxb0lIaGpibnBtOXFLV1hkVWk4RTVS?=
 =?utf-8?B?Z1ZtTmRMenUvVG8rM21sVVZqdUk1Y0dSbkRac1FFcnVhaURxa1VxUkpRQTVq?=
 =?utf-8?B?MUMwUlZFYVNrMURZK0E5WTBraGh2RWxWVTYwcmFCMnUwOWJoQzFYK3ZoTDZI?=
 =?utf-8?B?eG9NMmoxbE5kS1E5MnNIL2pJakNaSHdxbC9uMGJEQ0ZYNnM2K3lUazVXMmFB?=
 =?utf-8?B?OXUvcjVvSGJvUXNtZG1WOXZKK0VOcDE5emlrSG9tc2k0UDVTZkR5Q0hHeEs3?=
 =?utf-8?B?VXpsdEN2S21EZUFaWFErV0JuWG9iRmVkT0JpWWdXbDEzNXU0dDF4c3V4WGJN?=
 =?utf-8?Q?32Ls=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 852cdffd-05c2-441e-cd30-08dd4aee4fcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 22:49:15.7601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yoRLzF2FB9rzMdxFsMIk6ntC1pEdZyDAbGBFOlstvXhBUSL1pdhuuUqWZLICW4Q1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8346

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb3NoIFBvaW1ib2V1ZiA8
anBvaW1ib2VAa2VybmVsLm9yZz4NCj4gU2VudDogTW9uZGF5LCBGZWJydWFyeSAxMCwgMjAyNSA1
OjM2IFBNDQo+IFRvOiBLYXBsYW4sIERhdmlkIDxEYXZpZC5LYXBsYW5AYW1kLmNvbT4NCj4gQ2M6
IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPjsgQm9yaXNsYXYgUGV0a292IDxi
cEBhbGllbjguZGU+OyBQZXRlcg0KPiBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+OyBQ
YXdhbiBHdXB0YQ0KPiA8cGF3YW4ua3VtYXIuZ3VwdGFAbGludXguaW50ZWwuY29tPjsgSW5nbyBN
b2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+OyBEYXZlDQo+IEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGlu
dXguaW50ZWwuY29tPjsgeDg2QGtlcm5lbC5vcmc7IEggLiBQZXRlciBBbnZpbg0KPiA8aHBhQHp5
dG9yLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2MyAwNy8zNV0geDg2L2J1Z3M6IFJlc3RydWN0dXJlIHJmZHMgbWl0aWdhdGlvbg0KPg0K
PiBDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJj
ZS4gVXNlIHByb3BlciBjYXV0aW9uDQo+IHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tp
bmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQo+DQo+DQo+IE9uIFdlZCwgSmFuIDA4LCAyMDI1IGF0
IDAyOjI0OjQ3UE0gLTA2MDAsIERhdmlkIEthcGxhbiB3cm90ZToNCj4gPiBAQCAtNjI3LDExICs2
MzAsMjggQEAgc3RhdGljIHZvaWQgX19pbml0IHJmZHNfc2VsZWN0X21pdGlnYXRpb24odm9pZCkN
Cj4gPg0KPiA+ICAgICAgIGlmIChyZmRzX21pdGlnYXRpb24gPT0gUkZEU19NSVRJR0FUSU9OX0FV
VE8pDQo+ID4gICAgICAgICAgICAgICByZmRzX21pdGlnYXRpb24gPSBSRkRTX01JVElHQVRJT05f
VkVSVzsNCj4NCj4gQW5vdGhlciBzdXBlcmZsdW91cyByZXR1cm4gYWJvdmUgdGhpcyBvbmUuDQoN
CldpbGwgZml4DQoNCi0tRGF2aWQgS2FwbGFuDQo=

