Return-Path: <linux-kernel+bounces-395281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D779C9BBB3E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 18:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43889B221AA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09381C4A35;
	Mon,  4 Nov 2024 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IU1X9ziZ"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5AB1C4A0E
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 17:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730740508; cv=fail; b=kcHB77tkuS5XpostAMy2bG0z4w7xA5HwEjNsem2nx2xKsJIE+y1l9XDfg45Y/0COBGR6Cfr57HqXOf0qieUeDCfuoF8jcKySA/0/Ms8N6xxFm+jMtfS+zVCzXjdOH2pdINEfpR+oU5ZDp32+F/e+ttct/GpgaV80Ke07o026NGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730740508; c=relaxed/simple;
	bh=6IP4Nrh9QPX+e93hb4OdrRKpNAjH6B7RLr4ypmZAwwU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V0FSqi/eBXadYl8d2JBrPXWuCCZC8PRx8oa8j9qvfU7UyTaFsD4qS3DAPifVN/xw4/d4tVbUj5Kv2aYdj0YdjfmFHV8Ino1AlF4ySTRHp/tZxDoX0Kbk0iy/2IVjW1qoJz6g5anKjO/xB9aS2ehm9biPxC6tilMMFBxwoIWZNRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IU1X9ziZ; arc=fail smtp.client-ip=40.107.100.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APWZudWI35IS5vXawXV8n6X8wddikd33Oi5GF81Mi56OaOpGo62XXKIlRh1NV4+Yy0pBtxVSf92Oeg2QfOXHpb83m2SsjFq2dhRAlztv0UmIL18q1hVMbrxop4rzJcq52ZxH1kDQoaddB0TgZCEuDkTxHjWL1gGM8uXdrWkPHsb70tespJDGpYGBFPlJUPhzx8SGIqsrpi3gUmEjhzy4yC/feleSqvWmO8cWPmIOGwxOY4hqdy0/wA3TS8ihpZYkHVu1eszFMH/N+ZrubcHxnVbKWr6XE2TSafBQmj3LcozfuNR8HiVwrIfzy0qbQK5Hq5uPHM3kQWjUVc1U0QtYvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpAbWWb4QrRW3te/DBrRRt6YEvt/ocwE7KoZOP04PfA=;
 b=kS1DEIj+q3XIlrfb8gmEbr/a58r/U0Li8bBSir7oMsSAYdNL0uckZBZnKDNegulAyQfQHgEacHTTTaohzO0SRzUOR3r2mGrshWgnXPMA3xhVv5h/yA4dBVZUSvJUtYViLledowb+e2hSxO+yjOenOfHPzOqMWz01tlX+KNUM9Qn0yLw+e7HczSqM921Y+1s0WGbvVaa5rd1zzeP1Of7w573A+CPgn6VNOCjEGpQ03Kfw9Z0R1aVZBNGFb/zVyFA2Q4Ie0SW5021FfnvJBrGk2U0SPQagcfR+cWTUNSFd96I6HpDL5iE2TVYehgd62o/rUbomMDWTm7Piqhn/BkEtnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpAbWWb4QrRW3te/DBrRRt6YEvt/ocwE7KoZOP04PfA=;
 b=IU1X9ziZPzAdjJ0Atn47mDuIHL8/wC9ZECh+NW/3EaHina1RRArqH6Oc4V+hSBjS23pfuWxHc/a8eoa0Up9kSwI3yoe9oXOdb1UeBtxjjWu1UvRf6Mg/MgBk42HmnnzJJrnghHaE/pgCU+tXbpiOpqnuvmOSxTFzJhmz5qutJPc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by MN0PR12MB6152.namprd12.prod.outlook.com (2603:10b6:208:3c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.28; Mon, 4 Nov
 2024 17:15:03 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 17:15:03 +0000
Message-ID: <bce956f3-c964-6a41-6add-86c9dbea48dd@amd.com>
Date: Mon, 4 Nov 2024 11:15:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 6/8] x86/sev: Treat the contiguous RMP table as a
 single RMP segment
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Nikunj A Dadhania <nikunj@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
References: <cover.1730143962.git.thomas.lendacky@amd.com>
 <6118c46de2b2260b72dd3ed4421e5e08713fd47a.1730143962.git.thomas.lendacky@amd.com>
 <20241104103353.GQZyijEalUocS_yG5r@fat_crate.local>
 <79be2e29-6487-dd60-9b6f-3daa48a2e93f@amd.com>
 <20241104170514.GGZyj-yvIHo8Y-eKpj@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20241104170514.GGZyj-yvIHo8Y-eKpj@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0045.namprd12.prod.outlook.com
 (2603:10b6:802:20::16) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|MN0PR12MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: 01eb62bf-6176-44df-a80f-08dcfcf43840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0FTenVYMDRldnJZaXNTSnVYLzNhalZxTjUwZ21RR0pWYThyVE4rNHowVEtP?=
 =?utf-8?B?eUltUlRjZzdnejhOUjFPbENEU014MWY5UEdraDRxeVBYaE14VmsyaUNGemtx?=
 =?utf-8?B?Wlk2c3RaZ2IyY3Q2YUthQmx6Q2JKK0NDZW40RmZTeEhYQzhHYmp6elhUNFBK?=
 =?utf-8?B?NCtvSkFTTnNhVm4zZ0p0NVorUEpRbTdTVXFnazhTai9sTG1mWll2eFV6UldY?=
 =?utf-8?B?SDRIQUlZbnZKNmpqSzhzUHhkNnR2V05kK2VDOXNtUkpheGlDZUxYRnFqNVRz?=
 =?utf-8?B?RnJJekNXVUZ0VUp2TUlTaVYzanMvMmtSK3U5dmhZbFpzUFhGdDNjOXBZRGNr?=
 =?utf-8?B?M3lCamdVUGx6bng1RXZSbWVGRXBjZUdCMnNUK1BjNmlYeFJLR2dTM0N0QkhG?=
 =?utf-8?B?Ti9BZWxmUUdPa09lT3lpY1pEeUF5VHAvTDF2Z2FrbktZbk95NXYzRE1XUUhw?=
 =?utf-8?B?VVErMUhORVJYTFFpTEErK0l2K3htTEJNY1padTE2aHcwVm5hcGd2a2hhT1ds?=
 =?utf-8?B?VmJ3MWMzK2xDZmRveENIQmFRUFFjdlZJdXhmeE82b09qODFZTnNuR0xZZzdQ?=
 =?utf-8?B?M3ZIQXM1R1UzVUFPc0RGbHMvc0xuckN3ZHZzenJJWUZjUENnOWRlN0NBRjBs?=
 =?utf-8?B?dTMrN1Y1eDM5aUFXOUFyZlRBYkttY1ZFMXlZZEFEejV5WVFNclV3bEVJZFg5?=
 =?utf-8?B?cTZTWmdxY1RvOXB2WHptbytYaVFYRWdmbnRPdU5uSUoyZno5WDI3cUY3Nkdn?=
 =?utf-8?B?SFlSa1ZJL014Z0VNMklEakFieXlvdWtJSkRFVmlyS0VWbWRuajRETVFZWnZS?=
 =?utf-8?B?b1pRRWV5MkFjOWgyQVhzWER1ZmFvL2lVaUZPR1EwMXdzY0M2Q3FpYXFSS3hl?=
 =?utf-8?B?c2xMVnk4ZVRFZDZpdXU2aEc2SERoSDlXdlZDS0RVUmJndU1xVVB6SlEyWVFz?=
 =?utf-8?B?SFNGcE9hdGhuZnptVzU4enYyNHIwaDVLNnhZRTVhcmhZd0dpT0ZHaXlxclN3?=
 =?utf-8?B?ZzlFWTlhS2dqS3dXYjNpc3BEK3hnb0l0aUVkak5XTVdyaVpIcXFsSm1JZTBq?=
 =?utf-8?B?Q0Y3RXRFSmVYeFJlM3hlSXdiZGdMbjB1V1A2STRYdlpIeWVGQm5MbFc4YXdJ?=
 =?utf-8?B?RkpPaEVqUkpiWTU1cEdRREh5ZkVNYmlpOXlPeHBLR1Fna0RIanlLY3pncTJS?=
 =?utf-8?B?TXMwNTJKOTBRT0YwNDZPT2hOdStyMHY4ak5KRmhwUDN5SjlIczB3dFlENDU1?=
 =?utf-8?B?MXVFT3pGenhQejh3aFMvb1h1M1g1USt4UHBpRzIydDk2NkNPQ0RER3FjNVFC?=
 =?utf-8?B?Yk4wNUlPRUsxeStQMXJmMklBVWZONEMvMWgvQmdUdUl5Q1lVTnhZaU5iMjY0?=
 =?utf-8?B?alRHZE1Pd3ZQbHp0TFo5OTZjMkdqbkZYVkRpRFJmaEVjQUFoN2VrdXpXYm1U?=
 =?utf-8?B?ZENuTDRPZEdoNmIwV2lWaEpYb0VUdklZdDZEdTFQRmQwRGMyL0Z1REFpK3hZ?=
 =?utf-8?B?RjExa1BEamVrdVVyYkN4Z08yZjhvbngwK3lTRG1mcHFzWjNJZUFiTmlHU0Jk?=
 =?utf-8?B?V0NvSXNTZnpleUdFU0JUQ0lkV1JFQjBVL2ZQSm9kS1AxZEJBVzhEZFU5WFI5?=
 =?utf-8?B?ZDNVQlM3Umt2TjlRcHpnQUlhbWhiZTBSTldTUzlDUFVOVW5FQTBoVHR2RUVH?=
 =?utf-8?B?a29vc2R4MkR4UWMveEZkZkxiQlBTRFlhanozNVQzZC8zT3lVb0piNnF4TGIr?=
 =?utf-8?Q?/WfChNVzdoBfv2HMPtL33JcAEW3WZEIrbqFdZAX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFJQc0RvaHl3ZS9MeGJ6MjR2K1JSY0JsSU9NQXRuc1F2a1BiZW5oeTlmcG9Y?=
 =?utf-8?B?SEg0ZWMva2MyeEtCd3V4U2JTOEhrbFgvRHBlWnVnRHpnNXhuRjA5VE03TTVk?=
 =?utf-8?B?UDVMaXVsZERaL1E1SlF3N0ZNYlAvd2l0VFVtbHIyV3dCOU85QkRkUEFpZzRP?=
 =?utf-8?B?UkQyekZucFN2a1c4L2pmdlBqeTVSSEtXR3JwVWFRWTFEQjZOb2hWRWVUZFNW?=
 =?utf-8?B?WG00TDFpTWVYU0U5eFFEY3pOdGt1OGJQc2dkUitHMGFYMW5lV0ZidVgwbmZE?=
 =?utf-8?B?RENEWjduLy9QTnVuaU1CMDJCeVkyZGhYUEZhT21HTE4vZllkKzhKc1ZwTlBW?=
 =?utf-8?B?NUZPNzNaTFZQaWYwZmF2Rlc4UDFHU1BEc2kvdkh3QkZuR2hjSjdMODk5SmJ4?=
 =?utf-8?B?ZVUrL2FpcFp5ZlpuWHhvL3dRbGszTmFrTGMyYkpZcVJmTWFsUkFmL1NrRElE?=
 =?utf-8?B?RjYrUnZ2SFVDK1dNVTgxT1paa1JzUGhnemt1TFN6VmxBMTZCVUxzRG8wQVJk?=
 =?utf-8?B?SXpLNnpMRWVxQkJtM1JuakZsdkpITk9TNGJreXdVU0NpUnlIOW9OdXlVNllz?=
 =?utf-8?B?ZC9iZi9iS08xdGw1cUl2ZG96ME1UUjViaVZrZFNHaTJ0UVcxMkFGL0RzNFJU?=
 =?utf-8?B?WGNmakNFeFhKb1dXUUtUQStoTEpuTmhUcDd4UHBDRmFCL3BiSXh5UTYrWith?=
 =?utf-8?B?c1JFZVpMSFZwaUJFRXorQVZJMnRDYUVMbklzSWFQVXRpY3M0OFVzVUFNY080?=
 =?utf-8?B?NzhiVUtXMDkvNTJFWjAyQUROY0FxMzM2a2tyczNsY0QxMzg5ZXZkTE14Q1dw?=
 =?utf-8?B?YlgwZi9uUXcxWmJERXpRVzVwUlB0U0NTT2VkenVMQmRST0RJZitIZHBvZnpE?=
 =?utf-8?B?b1FQbzBabzFtVmVPaUFOU3V0bExqUnV1STFNQzdQd0M5aVBQbllsdk84d2cv?=
 =?utf-8?B?azR0Z0FHTFlVdXZZYXFvemlneEJpMU04azVKV1JrRy9IQ29Pek8yRUM3S2VW?=
 =?utf-8?B?RGhQUkZ3a2dOK0tNb3lhMHZrd2RZaHlaSUlEczNOL29MSU9WOXJaNmhrVDhr?=
 =?utf-8?B?QjNBU1REK1BMZFZHd3lrQUxrcEY3VEdkeHpMYkFYT3dlNXJpT3VIMGlQQXZ1?=
 =?utf-8?B?SlhZYWR2alNoNTQ1cnhLNXdWZGtOMGJnSS96WE5mYjRCOUJYZWg2dWlsb2Zl?=
 =?utf-8?B?RUpCN1RFZExpdy8rdDlDV0ZwSnFoRXYvaDVrUEZtdkFKYzhrdXFhcDBCSXRw?=
 =?utf-8?B?aGluTWFBV2tWTzRSODhGMm5GNGhKVEJxTk95TkpYcjhseHFacWFNUDVOcHFl?=
 =?utf-8?B?NnZNc0NNZGJrOE93eFUyVGIvR3Zpc2xYM3FjcmR1S3JRc2NvcXkxOXlnSmIr?=
 =?utf-8?B?RVJSL1YwUjlzT2ZFVUhxVWxUNmRMWUVic0o2V2FVWm9UUWtqMzlWeVlqRWtU?=
 =?utf-8?B?TkNtODRXQTBvdVVHMklvUXQwUllZaDNDb0JEcHFpdktUTEJaQytKM3ZwVFV3?=
 =?utf-8?B?WEV0UkkvL0VQZlA0cmV4YlBLVWhBWFVtMjNjV1dld2s4dSs5aGZHK1kwOG9X?=
 =?utf-8?B?cXZuNnAzWDhUVmMwK2ViVnlwK0I3T1hIcjFzMlFHK0FHRnhReURnTjlkZWtC?=
 =?utf-8?B?bGtuOWxRL2Y5NUk4Z2IwRURocDF6MmRuN3Nic2RpdHlPQlBUMjRpQ21qZzcw?=
 =?utf-8?B?cXE4cUdheFRLbnR0U29XRjhNZjlCczUyamhLeEEyYVI5c1E5dWo2OVBLcWZt?=
 =?utf-8?B?ZXBLRGZuT21sd21Pd2RUZGE4THRISXNaTU9Ka2x6bnkvZW9GNy9WMG84enF0?=
 =?utf-8?B?NnhLR2FDVHlralFsODVLMnFJNUg5dE1IajNYaEZTdzNKa09aYVRlclFHY2Z6?=
 =?utf-8?B?L2wxR3NxbmNWa09YZlhEUmpNTjM2NFlIazRteGV0NGlpOGJ5bUtVcGZ5K1hi?=
 =?utf-8?B?VWdBc0VRTE9yd2p0QjRUSmF2VStEczJjR0liTk9TTVlEL3FBSmFEUVVOM3Na?=
 =?utf-8?B?WHMvYm9EdmVnK01MYXB0bGR6anArVzE0Sk5xbXRMQy9Ob003MU5VQ1VIYW0r?=
 =?utf-8?B?d3JrTTJVcFl2OFFRMEw1QVhsTUx4ckVzT25ITk9oZjdBY2l3dDl2eFZ6cDlo?=
 =?utf-8?Q?Ct5Vy/GTUlEp13BlW0kIogvBy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01eb62bf-6176-44df-a80f-08dcfcf43840
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 17:15:03.1519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5MH7+AyqJWecN4Bjq2Rz9nL/ZRZ8V0STUBG6slkc83sDG00bPBSK0xCsQvnp3GXbgg3EFx/gQ1UCe2dUR+QS+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6152

On 11/4/24 11:05, Borislav Petkov wrote:
> On Mon, Nov 04, 2024 at 10:03:22AM -0600, Tom Lendacky wrote:
>>>> +static u64 rmp_segment_size_max;
>>>
>>> This one is used in a single function. Generate it there pls.
>>
>> It's used in two functions, alloc_rmp_segment_desc() and
>> set_rmp_segment_info().
> 
> You can always lift it up later if it is needed more than now:

Will do.

Thanks,
Tom

> 

