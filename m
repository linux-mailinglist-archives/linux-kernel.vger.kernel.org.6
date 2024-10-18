Return-Path: <linux-kernel+bounces-371805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAD19A408C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CDEC1C20E7B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8FB1D9686;
	Fri, 18 Oct 2024 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G+LH0boz"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348D4179BD
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729259769; cv=fail; b=LpHrj+hdSiu5yGSknQMSa7t+KUVwGMjSXrIru+Tt34PLvxU6Vu1dPPUre5hCDq6mbcWFamruKS6Vr4gY+fgriIwGsM1KEvkDuC9hHE2mJ/2omNKBtb/63WJH6AGbuaNunjyfxOeOqwBSe6RqyiBZ780LFCApPTAYET9Or/WzH90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729259769; c=relaxed/simple;
	bh=ksdRkP3aKbMwl/tRwnE713AeiPimmyGkpfzdvG2sLGQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Av0NRjzxjoFri7VB1JJPO4c1saWWBvmOwcx99y/hH9u0G0zdFElgBVWw8nc9seodmgMpGnhsdgEgH2i+sk8hI8qJXX13CkKKnwVDL4wzEwY80svQB2sbUymVXIlonN5ZPZvaX+keQqZO6ayucPe3NpfdL1NaLT/DE11rRBNlVLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G+LH0boz; arc=fail smtp.client-ip=40.107.237.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pi8dlGRDZ9HIKo4wKfhGMqcqcAY+o9bnTd/HEBsjpfKZtCutit8R8Fu+9uljgerdEYtrZybot1xQe9DSm/+KI7vQP/Q6ZYEunWOzdHRrG/88HWx5qtl45ftxG1JzJSpil9hBpVxTSjuUj25OGkp5+f4BkDChK0e3KML2mf1+bkN3DRsHf/HFNqlsUpu/InHYOb3Yry1yrEPRYSILxuWOgrUrC5j1GN5QNxr+YxOuxRg337kjYjsHTlQ0AqZtTn/ORocM7wiWF+sNCMFNskOjqZDCQ4k15kOXYYGRaypjCrrPIggES74JvFeIvb2Ts9RgAcVFuHnWx0kGd/MVbiariA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIOgJRYPUqY4Y33sFhzvLbFaCZ5DKpJ+OaPwzQJhq1E=;
 b=b9IOc7Zx16bamj/8wpXLyMFmcMD9qE6a87ZN+xHqQ/wOO4DEOtwJEhdjYCzg+DUY21nSj/zV3JB+f/WCMJP5UVpe4YmIMSAQ8ezF0DePN81MUMtm4fW3HDCGuHWfkJQFLzCWdKJ8DNtA2gfNi6R+RdDpBQtfJfsZsEPWYu1lry9xA21Pu+FupsrYAng2diecgIpVb6haVmh54/+Z18JRYUXcZNZZDpQC86HxCOrg+sezoPYBkmw2JU1gSqvahcWECV4pCIUSGPgm1eOysn6CJPvXdRjTxcaNUMDnuYQCjc11Es7VfjxhhpMLV/vkHTxrfiNgHaoAshsvHcCqezACfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIOgJRYPUqY4Y33sFhzvLbFaCZ5DKpJ+OaPwzQJhq1E=;
 b=G+LH0bozHD0tNhY9hFpwMpHS098UdnZuvCKU2KlmFt8KoIDlNgR9fZikdzDk/tLEL56d5x28ajyjkUvBSpU4kgoxpJUGYK7NerH8mJ/nAz5gB0+GkoCAbfRosW3ScF8UDiCAkoOtNs2yhVl2rbipWMQKCXJDhqcjfDNpYxCilTI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by LV3PR12MB9118.namprd12.prod.outlook.com (2603:10b6:408:1a1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 18 Oct
 2024 13:56:02 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8069.024; Fri, 18 Oct 2024
 13:56:02 +0000
Message-ID: <650dcde5-4644-b790-60e9-ab66d7ca5b0b@amd.com>
Date: Fri, 18 Oct 2024 08:56:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 6/8] x86/sev: Treat the contiguous RMP table as a
 single RMP segment
Content-Language: en-US
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1727709735.git.thomas.lendacky@amd.com>
 <3a9a4f94fefe3b4ebb23a7dd3d33d9fd7a344ce1.1727709735.git.thomas.lendacky@amd.com>
 <4692a0c7-3eef-45c1-ba06-fa01b4f01d74@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <4692a0c7-3eef-45c1-ba06-fa01b4f01d74@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0080.namprd13.prod.outlook.com
 (2603:10b6:806:23::25) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|LV3PR12MB9118:EE_
X-MS-Office365-Filtering-Correlation-Id: e94cd6f2-f3c8-412d-5e5b-08dcef7c9a40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzZjeWZ6N0x1WFR6K0NORUxhY2pLaVFQNUo5bGFnRGtJYXNodDFWU2pETU5J?=
 =?utf-8?B?TVZCZTFDV3JhK0NGamhQUnlaWEhYWi9Qc1J4NmVGNmI0R0QzUnBxWkpEazcx?=
 =?utf-8?B?bXd4d1ZrWEpWejZ0eHI5bHFYS0pHV0pGc255QW1vemJBRmdkbHJ6VldQaVdK?=
 =?utf-8?B?RjgzR0VJT2EwSTFWRVROU1ZhNjFRVk5jbk1kRUNKMmt1WjNlU1pzU2lUSnZi?=
 =?utf-8?B?YUdBMFJjZGpueUUyRHRpbW14TGpsWHpZR2hzVlltdCtaT0lIaTNwM3g3d2VG?=
 =?utf-8?B?amduY0ZSeXoxeWdhOUZDaTBrWWpQZ25sbHN1S0tZWWZmN1JDaWxXYzdiN01R?=
 =?utf-8?B?aXNFSTgrMENuUmdTbU40Y216L05vNW9vemhrTXRaayt4MjBNSlBteWNMRjJ5?=
 =?utf-8?B?b0VJb1p0VGg5TDdsUXJlMCtzVVBuUldJdkhZSG1mYkRaQ09WbGNsM3JJaDVy?=
 =?utf-8?B?OVc5V25oMDlxRGN2UGFxaU1GZ0h4elVMd2l6WGhveUF0bmJCaHZ5T2dTdEQ2?=
 =?utf-8?B?dFpsOTF1Rjd2U3NwVjczTjJzMzBqQXlpcGY3eTBsY2t2bXBsa2xjblVmc3hC?=
 =?utf-8?B?NjVVUmtTb2JTZ2xpb2hrQ3pRL2dtWjFKdlBTcVI5Tktod0V0RVZGR1dxbnRM?=
 =?utf-8?B?SGhLc1lZZ2k5bm54MVRkYy9WWGNBU3N2OXp4aGtkb1lQbmFqWUE0eXhudlUx?=
 =?utf-8?B?Vkp5enJwTWtxVFJBK3Q1NE0yU1JMb0ZMNklBbVk0eUFiTCtPRnRWUlc3L0kr?=
 =?utf-8?B?T1NQd2xUN3VKc0JoeVgzc1ZKeWptQTB0UE9KTVcxNG05TW1IUGtWSEFBQk5S?=
 =?utf-8?B?T0Y0Vk5GVk1RWGtMcTJkdUV6L2ZLK1RhcmVoQ3hzUG5DRllxOFVySEdxN2RU?=
 =?utf-8?B?V0MvTmM0aU02bldGS1k5N2QvTEwza3hIOUhaS2dEMWVIWE5PWnhsZ21JY3dG?=
 =?utf-8?B?NTloV1BGbkl6b1czenFmVmhCb3FEMy9RUVh5SEkzUDBac2NGYmcxcy9ObWY0?=
 =?utf-8?B?V2EzUHAyTW5tc29Xc2RPSS94c3FNcWltM1cwVnNOVS8raHBQRDR0SFBKSXdI?=
 =?utf-8?B?TDJnZkgxY2o3cUsyTWhGdVZpYXErTmdwaHJ4MDNuc2ZZUXZDTEl1SUExaElx?=
 =?utf-8?B?alh0TFU2Sk0ra0Nyc1RtQ0lnVEhLZFc4a2JBdjNQMWtscm1KdFQwcDhYVmUw?=
 =?utf-8?B?Rk9MRVlsQkY0YVlQeGMxRWRxd2RJeWhBY25sZEpRY1JDMk1QdWpidUVmZ09q?=
 =?utf-8?B?cWI3dlBmUFEwaWN0dnUzVHorYmNiSW1QOEdmQTIzcm1IQVRVNUZUMHV5cnJs?=
 =?utf-8?B?eDZ3WUtmcTFlVDRBZDlDZnYwTlQvNDN2M3dEa3M2OXJUbG1hVFBBdDViUmVN?=
 =?utf-8?B?Z3Y2YzJuMW1rYjBmUTUvVkh1ZjlneTZZdU9yM1F0blhJbzJTY0xPSFN0M2pW?=
 =?utf-8?B?UXV6NlJJY0wrNU5VVjNXWk1KSFUxRWZZR292RnNNS3djQUFYYWJ5d296NXYz?=
 =?utf-8?B?dXMvRUtac3k4VW80eGdVeE9Wd2lWZ3hyVnZtenF5NTN0b3NZWVNFVG1mQkFL?=
 =?utf-8?B?NkJXU05NTGJuWlg5cXU4REk0dFF6bEgxVFl1dy9lMmlucUQxb2ZUWFFwS05L?=
 =?utf-8?B?SzRiaDNIM2M2ZG9IK1dxdXp4QUx5NmQreFA2Um9LUEFWdlZrMXNsOWZWMWVN?=
 =?utf-8?B?eU9xenFhdDFuZUh6RDFZOWN3VjRJOERiTnBwVDIrcWhpelhWMXE2SDlramI3?=
 =?utf-8?Q?CuyJCKeuVMC3fqw3qvu4/+1h4K419Rf3+WXOi+M?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zjl0Ti9GdDk5THhhbXpkT04zSW5rVDNSYVBRQzdHemdxaGlpa2dUSHN5ZVVp?=
 =?utf-8?B?ZUxaN2tXcFpUSVlYbERLRzhsb2RDWmJQd1E4UTJrVWlUSFlSNllKOVUyUHN5?=
 =?utf-8?B?Ym9yQkc2dWQrdUFjN0ZoUlk2VkdpUFp4OVl1N3NWOVFZTTdQdFdPSUNqYVRI?=
 =?utf-8?B?NDFCdXV5SE13OTRMRGc5em9Ob2VWWjdkaGlJU05lSUppa2d2Q0g2U0NpOEIy?=
 =?utf-8?B?YUp4OGNLaFo2MkVjRUdmaFJ5MVpaN296Skkyd2FDSUZiYWdJTEowY3lZMmFo?=
 =?utf-8?B?bVp1NUUyTGZQVGEydWc2TllDYjhpRkNMcUg2Y2Z1Z3BOb0ZLM3RYQi9iOVQ2?=
 =?utf-8?B?WU80Q0gwMEJBRXFaSEFjeUUxMEdmZ3J1UTdkZERhS0g0NzBLMG5qem9GRzhY?=
 =?utf-8?B?Z3Z0bXNDUEtobjNMZHhOaldTRUQxT1ZZbEtlZTAwdS9zWklVWTdlSlpNTE9Q?=
 =?utf-8?B?V20xQlE1dUpVb2MzVEZkSDZPREt4STRzZ2xNMitvcENrTTZMNTNJTFUveEtl?=
 =?utf-8?B?SU5WejdmdFg0MTF6dXdVcHRWcUVJMVlCWFoyMUJZWEt5SmZpQjRiWEN6WW1a?=
 =?utf-8?B?Q3Z5QUdEeW5oYVpzeW5IM0REM3d1MU1FQXBBTDMvMjNSSWFZbmZ6SUpxMHhx?=
 =?utf-8?B?SSs0SzhoQ21IbUhLQXRuRk1MT1d5WUozanN6TUU3ekZlTkFqdzNTSkZYdk44?=
 =?utf-8?B?YVg2WG0xNkR2VkZpbW4yRHkxNXdNR1dFSnR1ODFNbEFEL1NTT25xR1prMy83?=
 =?utf-8?B?ZUc1VnB2VGovdHpTWUlYbTl1MHRqSXUxNUFaR2FLNW1WdldXNWFBbVJCNTNE?=
 =?utf-8?B?bkFIVGF5MTg3dnJCcTB3R21IR2pqZ3BmRkR2Snl4TGFUdFoxZ3dIenpjQ2gw?=
 =?utf-8?B?M2VKM29KMHpNQjFBaTFZNVZGR1lDUXRvd0pTWGpmVzNjbkFpeGxnM2c5cTlm?=
 =?utf-8?B?M3BjNGxETWN4SEVrNTMzWXNnSXFnK253dUlTWWc1VWFRQU53ZnI2QlFRUnRt?=
 =?utf-8?B?ZkYzVk40dEczK3A4WnFDbDI5RmtjK0U4ZDM5T1BYODZpV0N2RW0zdURDWG5t?=
 =?utf-8?B?UXBvU1ZrM3dOYnI3SndxY3Y5T2UxeHc0cy95ckl6Z1VzekVjQ3VqNndWalJS?=
 =?utf-8?B?eSsvc2ZWeFVEOEpVQ2dRN0d5dGplWk9ZRTBRNkNWb21UYWFhbWlFeCs4Sy9M?=
 =?utf-8?B?RlptVXB2VGRNVzh3TnpTcHVjcVg5ZHFhYnFDWG9XR20wVEM1ZFdsTklxbDlJ?=
 =?utf-8?B?K0RWVWwrNlVKT3JMRnlrODY1WW12Tjg1STlnWnZBOVh0SHk1eml0ZWozc3lu?=
 =?utf-8?B?MlB1OTU3dSs5cFRmV3duTzZTcE5VRWJhZDR6MVQ5ZG5HUWlpbnQyY2FaU242?=
 =?utf-8?B?TUhmMncvTjVkcHV3UFV3TzNrdDZySXAxNEtBN3VCcnZWYXFVdEUyZ1FiWGN0?=
 =?utf-8?B?UzdGaGlFamZMUm1nbytzbWJralBoRE14L1JubXBCWVBhS2NVMWI1R3VYTFlw?=
 =?utf-8?B?Tkk0dlNXYkVGU2xGRGRaK3kyaWl5REIzYlF4N09IZmtodHppcCtpdExYaUtY?=
 =?utf-8?B?dnNtRGUveEdqRkxyOUF6WXU5aGpQUW96ZUxTcmpmS0pUc05LVHpoTXdVSHdZ?=
 =?utf-8?B?Q1FHYjVmOVN3TTNpUG9YL2xSN1AvL2JwbnhDRkNjdUxpOWlRaWZEbUQyTGFi?=
 =?utf-8?B?d1JyQ1hldHE5ZHlEM2VnbWlDdStMdkY0d2F0TytQdlIvMEhHald1RU50ZUxP?=
 =?utf-8?B?NGplazljQlljejNpQTJQSit4OWMyMjNZMk54TzN3QTlvU0ZzbkN0WGsrcytn?=
 =?utf-8?B?Ymoza0VrcDRBTm02dDk5VzNlQkVZWEZuZTRtK2dGK2RidTJ2c2YwME5wbWU0?=
 =?utf-8?B?Zm1CZEVLd1FTU1grNE1YSzV5UXM3Q2pLaGdtcytUdU8zb0U0bXZkdVhSSXps?=
 =?utf-8?B?ZFFrZWJ4cUVhVEtMSTJxcWc4Z0wxOE5vdWgycU9vSTYvZjk2Y3prVVZDbmU1?=
 =?utf-8?B?MG1yNGZJQjZORnNoUW9KTmdvd3RBbU5OMU4ySzZGVmJuclRkWSsveHNuWnFp?=
 =?utf-8?B?SFRKZ1VCRzA2TDJTd3NFUkVNVEkxTEJIMkVEMml2ZEgyS1Q3dWlsY3hHMEw5?=
 =?utf-8?Q?oax/TieyNAsNpHQxcX185FIEU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e94cd6f2-f3c8-412d-5e5b-08dcef7c9a40
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 13:56:02.4541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sypfqPJlWh82bQurtTmN4wpCBxB/I3DmIpW2NUWY/0WtGWEwRgdTkM4K+I0od/U1S3RuVOFqHbNAsaMIFEdfbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9118

On 10/18/24 00:59, Neeraj Upadhyay wrote:
> On 9/30/2024 8:52 PM, Tom Lendacky wrote:
>> In preparation for support of a segmented RMP table, treat the contiguous
>> RMP table as a segmented RMP table with a single segment covering all
>> of memory. By treating a contiguous RMP table as a single segment, much
>> of the code that initializes and accesses the RMP can be re-used.
>>
>> Segmented RMP tables can have up to 512 segment entries. Each segment
>> will have metadata associated with it to identify the segment location,
>> the segment size, etc. The segment data and the physical address are used
>> to determine the index of the segment within the table and then the RMP
>> entry within the segment. For an actual segmented RMP table environment,
>> much of the segment information will come from a configuration MSR. For
>> the contiguous RMP, though, much of the information will be statically
>> defined.
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>  arch/x86/virt/svm/sev.c | 195 ++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 176 insertions(+), 19 deletions(-)
>>
>> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
>> index 81e21d833cf0..ebfb924652f8 100644
>> --- a/arch/x86/virt/svm/sev.c
>> +++ b/arch/x86/virt/svm/sev.c
>> @@ -18,6 +18,7 @@
>>  #include <linux/cpumask.h>
>>  #include <linux/iommu.h>
>>  #include <linux/amd-iommu.h>
>> +#include <linux/nospec.h>
>>  
>>  #include <asm/sev.h>
>>  #include <asm/processor.h>
>> @@ -74,12 +75,42 @@ struct rmpentry_raw {
>>   */
>>  #define RMPTABLE_CPU_BOOKKEEPING_SZ	0x4000
>>  
>> +/*
>> + * For a non-segmented RMP table, use the maximum physical addressing as the
>> + * segment size in order to always arrive at index 0 in the table.
>> + */
>> +#define RMPTABLE_NON_SEGMENTED_SHIFT	52
>> +
>> +struct rmp_segment_desc {
>> +	struct rmpentry_raw *rmp_entry;
>> +	u64 max_index;
>> +	u64 size;
>> +};
>> +
>> +/*
>> + * Segmented RMP Table support.
>> + *   - The segment size is used for two purposes:
>> + *     - Identify the amount of memory covered by an RMP segment
>> + *     - Quickly locate an RMP segment table entry for a physical address
>> + *
>> + *   - The RMP segment table contains pointers to an RMP table that covers
>> + *     a specific portion of memory. There can be up to 512 8-byte entries,
>> + *     one pages worth.
>> + */
>> +static struct rmp_segment_desc **rmp_segment_table __ro_after_init;
>> +static unsigned int rst_max_index __ro_after_init = 512;
>> +
>> +static u64 rmp_segment_size_max;
>> +static unsigned int rmp_segment_coverage_shift;
>> +static unsigned long rmp_segment_coverage_size;
>> +static unsigned long rmp_segment_coverage_mask;
> 
> rmp_segment_size_max is of type u64 and rmp_segment_coverage_size is 1 << 52
> for single RMP segment. So, maybe use u64 for rmp_segment_coverage_size
> and rmp_segment_coverage_mask also?

This is 64-bit only code where unsigned long is the same size as u64 and
is typically preferred when dealing with numbers like this, which is why I
use that here. It does get a bit confusing because of the use of u64 and
unsigned long but I tried to keep things in sync between usages of the
same type as much as possible.

Thanks,
Tom

> 
> 
> - Neeraj

