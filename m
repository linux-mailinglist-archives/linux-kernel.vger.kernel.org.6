Return-Path: <linux-kernel+bounces-353596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3F899301D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 301291F22BE1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC16D1D90DD;
	Mon,  7 Oct 2024 14:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A8VSwc/D"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CA21D8E1F;
	Mon,  7 Oct 2024 14:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728312822; cv=fail; b=mSjKdrCp48he84KT2I6kFjjFAcy06HYhMG3wrpZ60BvipJkPLpaeBSNdAFlBp/67kPFUJn6rvqvs0psQMaC4AA+iPCpEp00gUZgllva3Ugk5759JGItKz9MhJIsYYBnU3U7nB1uKoVzJP+Lm0l7X2UcwcAFqHDBYupr9RfLaTaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728312822; c=relaxed/simple;
	bh=gJ+jH5fCLtnRbxTz2tfHGGaZE1fugOPo8M4IDAaVdjE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gOy1dqMvzGAUw1i5rZdDoaXANumlL9PVfeuyBceYa1a5uJ4k1Pzr7kL+Qv2ZReUGBN7bfqfHdcANQ4teXn7Jf0MWMqpdP+UK4+vWn6y73umQl6s3D09Nmskt4dMbBepAY4Rwp19SzXJveuNvUBrwZ5zEQku/oZ2xPtcO0sc4iHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A8VSwc/D; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o515OrtG8YB4zQUMOzV2+ElKnRojz1UWfcioYlpa51pPU8pcPEM8niDst43W4g/WekqestOfmXw/hd7fCOJs9iL2LBGn3sdaEQMRkPB6w67KISvSDEdVNUYRhWowKv3eX2wUOBxS9D/DGpbdD831f1kBMMG7PrvF2/eBEhQ46seaPRtl7oeXr5XHTTwxf8NXWE9RJyb40k1tBvlArYOZqwc3WDFOlaUQucjcUqJ7Q6vuQT+TpLznzOtzVEdDujsH3NWPZ9WY10xHHfAHYSI2ItH9rM9y2myIkjrSaCUYJYSYEWeu5BUfxlXoceU1cDJ7wCD4pDhRSf7e9J+DxV3CeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXWo0zRdAJERgCCGeA1KGfy/xXq6ZPlMHUij/78qTs8=;
 b=q6q3OW8HKDduuiCh8mv5rkniq++G26Z26hDlPZ1QVfE/o+uxVgKPRjTCujue0tNr8eGJ3sIrgor5+BReknZ9RVm7rTHmz/gfN020w65ZgyHURs7SCliYvZK85d57eBwxgIA/hEo7i6S/FT0O/B+K7035sAflQ42kBq+InDTjBy+6CpKsNl9sMS6bQhxnZPTi3pYNTvkBLu9cRNFjDBJz14dTecjw4FOm3y6w0lCgcCsNS9bZ0vHj8/28KH4ER0zRCoe1kInd11MKFtWlquWjTIGkoxFEN1NGOsJjibsNIM2QCc8zZ4Enwrsns4XB7c2oU22J5ra5JXqvSKdyc43CIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXWo0zRdAJERgCCGeA1KGfy/xXq6ZPlMHUij/78qTs8=;
 b=A8VSwc/DvxvBsEdu5TXkVFHK2J3jxbiXjtkmFwByMdY5mLo9LN0Y0ebjDujeknq/iS22zq+P+NfHFMSCvTzqmV14iC87rrDXZnI7x/9vcKAJCwi7Y5OOte4K8F3CMPOOmA/kT8Ab0jLwNMBc4/CMn0CnTB5J+O4trE1CSEMWqh4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 14:53:37 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 14:53:37 +0000
Message-ID: <a2449e98-1258-4308-b246-b755e7a3708f@amd.com>
Date: Mon, 7 Oct 2024 09:53:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] platform/x86/hp: Avoid spurious wakeup on HP ProOne
 440
To: Kai-Heng Feng <kaihengf@nvidia.com>, Hans de Goede <hdegoede@redhat.com>,
 ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org,
 jorge.lopez2@hp.com
Cc: acelan.kao@canonical.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20240906053047.459036-1-kai.heng.feng@canonical.com>
 <87d40775-9bd4-4f22-81da-4e670236c15e@redhat.com>
 <f6b62a45-c44f-492f-8f79-96b4fd54555e@nvidia.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <f6b62a45-c44f-492f-8f79-96b4fd54555e@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0068.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN0PR12MB5953:EE_
X-MS-Office365-Filtering-Correlation-Id: 37581294-8e5b-4189-0ec3-08dce6dfd321
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUJSclVZVlphOXk5NHp6azJBa284YytOckZlNUhrVVRoK0Q2SVNXNFN3MXJo?=
 =?utf-8?B?RGVUQmsxbi90emJSaHhjNU9ydTIrZXRrOHBWWGpTM3FTUG5pU0Z6bHI5UWhW?=
 =?utf-8?B?bld1cmVSZzJYTGJoMEp0SFl1YlpXTlltT0VFam1PZnpMV3dVSnE1WGVLeUNU?=
 =?utf-8?B?d2xSY053dHhvdURmL0RFUVVjdGNRVGRzbDdPRTJNUWFXd1NEQmJPa1ZaVlZH?=
 =?utf-8?B?cHZlR3hxYTRjaHJmUk5pMXg3NDNaaVk1SlpaNk1Ta2Q5UGIxU0Fvemc4NkU0?=
 =?utf-8?B?QVVqbjFSNVJacVczUnZmcnBzYVRidVBOWlIyVkpUK1cwRlFTak83NVBKMkU0?=
 =?utf-8?B?YXlBSUFCU01ha1pkWHN4TjFpZU5DNmtqOWZMN2JjTkdQaXdOZFFHQmk4N2dI?=
 =?utf-8?B?cjRaOWg2Q3NDbUFMNnlSeUpETkY0eE9Wa1VWcTJ5Q013TWwzbEpsTHVmRUtQ?=
 =?utf-8?B?UjFscERGMVRmYTZrTEU3RW84NVNUWWRWUFNSdUUvYXMwK3dHRGxNUzhtZjdj?=
 =?utf-8?B?YkJOY3BKdE5aRDArd0t5ZDducUtkdHNoK1BOajYxblpSZm01TVBQVWZtRUVE?=
 =?utf-8?B?dnBkSU4zakp0NloxdlRDNzRLNktzNFJQRm10bzYyUThldE9tR1R4Mi9ocit2?=
 =?utf-8?B?WmdBenAveS9yMmhWSFJvZmdSR3U0bVE4eFd3NUMvcEY1Yi9RMENyYy9URXJH?=
 =?utf-8?B?K3V3ZmlBeTVxWkRHZExPR0pseXZBNVJyNVZESitlTHZmTmx3aVpKUHFESlNw?=
 =?utf-8?B?TUlrS1JFY0tjKzZsY0o3N0VoZzlwMW9Wa3p2eXZ5WUJTZitPQ2pLZHMyMzZW?=
 =?utf-8?B?eGNNeWRDa3pPNXNlSWJuVlhjTkQrZ1V1SWZBK05SdVYwSDMyKzM4U3hnWHdP?=
 =?utf-8?B?dmJJdTBOVXNDclJzamVibyttclNZaE5ScUd1M2ZQTFhCZDZXeC9OUHVmd0JU?=
 =?utf-8?B?ejFxZ0RjZGRBdnZTenRxb3ZQV090VFB4K3ZGMHgvdWR0WEhoemFYZlBVVW9k?=
 =?utf-8?B?cm1YcnZ6MncrcG9nSGt6ZmJFYVlnS2gxcEdtM2JHT2UwYlN1TGttNlRTRnIx?=
 =?utf-8?B?WXFIUlp3eVozV290OTFwcjFha043LzRLZDRrbTdydVR6TXNROTU1S2t6K0VK?=
 =?utf-8?B?QWJDV2hHV3dLS2VBR2J1cGVyaExJd3pLNTlKZnJaLzZBcnMzUmdhRkZHTmxM?=
 =?utf-8?B?ZFBWblpMRm5xKytlSURlUlF6RUxKbTc0bWErWXljSi9BZlVUNVMwYlpuR3E3?=
 =?utf-8?B?ZGYxaFMzeDJmZXRuTWtBQnY0MUk0ZjN0UlNsOUw4UE11aUR6ZEFqSE1jaytk?=
 =?utf-8?B?cVpEVTNDOXVXOW9iaFBkdVFkTHRmN1ZwanJReTZQUW1GQlpiaW9YcUY1WFVn?=
 =?utf-8?B?S1MyUkpHOWRvYmFibmZoVEZCcEhjM1QvWVhwMDA4OVpUMFQrYWVHWkd0eW5y?=
 =?utf-8?B?ZDV3OE5ZZGMxcDdUSHdkcVdxdUJNcFQwUFZxR1ppL2Z1Sm00VHpXQmhLQ25P?=
 =?utf-8?B?NFViZThBTld0TnZyZm55YVF0QTIyL2p4TThPVEVIdVBhRzE4bFBMOWJZZGw1?=
 =?utf-8?B?VzZSVUR1Vm5nbGdkTkJ4bTcydmV5dzcvbHZuMDA2bUY3YzFwOTBwdEFYYTQr?=
 =?utf-8?B?V3EzU2NWTFdFcWZsdTRqSCtZUHpPcDRPSVlrN2VVTzVUSDAwVGNSUTY3dWJU?=
 =?utf-8?B?MmFMa3cwOU8yeS9iUWVDVEViMDFWbEU3a0E2QUNWcEV0ZkdVQ0o1VHBPQzhG?=
 =?utf-8?Q?wdCvKt0KyVSsx04FIs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1VXRG5YZkt3WmlqazhCUHB4Yjh3N01OTDZyNHNacy9jdDYzUnh5ME9ZNkNn?=
 =?utf-8?B?a0dKRytESCtiQU5oMGc4dmNML0tUTXIzT3ZCeWY0bjBsNFFQQVNNVGdVQUhF?=
 =?utf-8?B?eXZEcm9mdlF6eUNmR1RKeDJVMEkyYWJ3UnVQT3VxZnArMGkyVmpDdXFScjRT?=
 =?utf-8?B?Z3JqdWpYUzZpQkhkREVlWFFpdUVKcVJud2pVNjlnRExLNkhUa3duRVlIRVk0?=
 =?utf-8?B?djU1cmxRK2RJSlFlMzZBb21jVmpaa0VGWERCM1FCeDNqNDFEOHN4dXpkS3hi?=
 =?utf-8?B?YjkxVVBFNmVHZmVWN0VqckxxUnNKb2ZRcUhVY2Q0ajRVV0dtbDVEWUFOSzJ2?=
 =?utf-8?B?RW9UZWhVSUkrc0UreTYxa1N5RkJ1ZFdyUDZNVGptaUtBZktpVjYwTXBKYTJJ?=
 =?utf-8?B?aGp2M0NqRmxsdnkyZ1RleVJuTnV0MFd5ZXEzc2VuR1VhZC8rcVQwVldzbTlJ?=
 =?utf-8?B?WEw5ZTFmcjcrRzJyWWtBdGtaanpqQWRJMy9FTUJ4cXNVamp3citMaUQ3Z253?=
 =?utf-8?B?NnFoL3FqNmFRczlkQVRuV3U1UDRGajRiK3Z2ZEl4enFtT2gyZXByZEtPNm1m?=
 =?utf-8?B?dnR4UzV1QTRTQ1FFUGNpQ0VyS0xrR2ppcXpxWlU2VGFIWUFCcERxOEc5OVlw?=
 =?utf-8?B?K1pyQjdQSjhDRkdTYnhFTkZ3M2dmWmt3UDAybDVnT0R6Z1dieHBqTEwyemVy?=
 =?utf-8?B?NFFZRTNkUWxGTEFTdkhaNVJUT0taRkFSNno5Y1lXa0lTREx4TVN4Q2Y2aXlW?=
 =?utf-8?B?WldYUHpkb2RtbldPL1J3WXJxdGtUanIxZG1GNy9JOTQ4QnBieEFRNU5WMmJq?=
 =?utf-8?B?T1Z4cTRFVml3MTFWV3Zxd0RsZG9YdUgrcCtjd1VoZDFRMGFVQ29GSm9SNURo?=
 =?utf-8?B?dk1mdEpvUCtoRnR6Z0M5cEV2YzluZTRPUC95OTF4Ty9rSjBGdFdTL0RFVVFR?=
 =?utf-8?B?RFMrOUljTVhJb1BVWW9ZRUgwWjh5RDFleDFqR2t1bkgxZDdjbndKbkRWcjVN?=
 =?utf-8?B?UDVPRnMvOU9FOEY2c2VtemxlcVNvbzByY1VieUlneVlBb1ZyQkZFY0plQzNF?=
 =?utf-8?B?SmRNdlB0VmJiT0NiU01BWHRJVWJ3ZUxLSHQ3cGw2eHZ5TjlsNzdkL2ZCVHJy?=
 =?utf-8?B?Z2s5ZElVcE5NNmdmYmxGSTlYdEc2WlhXTGpua01yYnBaaVlMWkwwT3RSY3A2?=
 =?utf-8?B?YnJrelUrOFF5d2JQYkZRRm1VR1RSaURmRmV3UVJubEhtU3cwcmJJaDNaUFBj?=
 =?utf-8?B?MXBuOG41QzlFbGpoaE94OXg3cXlkSUxDejV2R0VsOTFHOGg2aFA2bHhRc2k0?=
 =?utf-8?B?QTVrWG9pM09xeEVUUlArdW5KWmFRcHFCMEpVM0cvYmRRbmJja1Jwa0tiTkdx?=
 =?utf-8?B?TzUrRXUzbHZTMUNSOEFLYVV4WEVQeUMrU1AySGNkNTFZSlNwT3FqNklZdUZi?=
 =?utf-8?B?ayt1UjhLWEgrUW5wd1dJZC9BOXZreFFTVmRTdE1CVFB2MVRaNWJKRmJQak80?=
 =?utf-8?B?WTVBUVk2NlAxTTgwSkZ6MXBETG4rWjJ6bmJxQWxkcVBYdmEza0xMZ3ZzV1RY?=
 =?utf-8?B?VmJ0endvNCtCeGZSWEhzUkEwMlg3cnZNcTA3eHhKQk9NbVYvbjk3UlZXSExr?=
 =?utf-8?B?OTh5MXV5OXNHU1RueGVDeGg1SytqVGt4Vjc0ZUZ2Tnd4cjZ4N1U1OW1VR1FR?=
 =?utf-8?B?VEQrZGxwNTYxekNjYmpkZW81TzJkMGVxUG9kd1hZaUhpU3NGNTFEOTJpSDh0?=
 =?utf-8?B?Y1FISHVEcjVWZVdudmt5WTZ2WVVtMllybXFrWHRHWUR0dm1tL2R4NE5nTW1l?=
 =?utf-8?B?emppZHJQdDNHQzlmNG5RTUh1cjB6V3N4dk9OZTVEQ3p5WEViQ21yZE44UjJW?=
 =?utf-8?B?dzE1bXV1bUQ0ZmpTdE11RE41SmJITjR3RTlTL1VKRUE2UmlTdjVEQ2VnOHhh?=
 =?utf-8?B?b0RsZGJSdk02ay9DcXdhQlRsbkFOKzRCVmo4L0lXM2g4Y0Z1dXc1Z2tXazQr?=
 =?utf-8?B?UEl5TE9SU3dQc01WU1U0NmN1Ymt6cUpXVGZuVlBUcEQ4eW5sNmkrZU5Ldis3?=
 =?utf-8?B?Tzk0SUlZZW5aNVFnZ0ZaVGRidUN5cmpVY2l1ZThNb0NicDl4cjQ3Y0g5cXY5?=
 =?utf-8?Q?YlpomsENgtwvcho31W0z7iBYH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37581294-8e5b-4189-0ec3-08dce6dfd321
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 14:53:37.5077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rYxIIpXV67e0UoH3E+amiuFbuaEIirk9keQUfFjeHVKj/Cr2vxI4BzvcHziUMUT/0uWe3/COcT46KvJnhBiIhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5953

On 10/6/2024 23:22, Kai-Heng Feng wrote:
> Hi Hans,
> 
> On 2024/10/5 10:25 PM, Hans de Goede wrote:
>> Hi Kai-Heng,
>>
>> On 6-Sep-24 7:30 AM, Kai-Heng Feng wrote:
>>> The HP ProOne 440 has a power saving design that when the display is
>>> off, it also cuts the USB touchscreen device's power off.
>>>
>>> This can cause system early wakeup because cutting the power off the
>>> touchscreen device creates a disconnect event and prevent the system
>>> from suspending:
>>> [  445.814574] hub 2-0:1.0: hub_suspend
>>> [  445.814652] usb usb2: bus suspend, wakeup 0
>>> [  445.824629] xhci_hcd 0000:00:14.0: Port change event, 1-11, id 11, 
>>> portsc: 0x202a0
>>> [  445.824639] xhci_hcd 0000:00:14.0: resume root hub
>>> [  445.824651] xhci_hcd 0000:00:14.0: handle_port_status: starting 
>>> usb1 port polling.
>>> [  445.844039] xhci_hcd 0000:00:14.0: PM: pci_pm_suspend(): 
>>> hcd_pci_suspend+0x0/0x20 returns -16
>>> [  445.844058] xhci_hcd 0000:00:14.0: PM: dpm_run_callback(): 
>>> pci_pm_suspend+0x0/0x1c0 returns -16
>>> [  445.844072] xhci_hcd 0000:00:14.0: PM: failed to suspend async: 
>>> error -16
>>> [  446.276101] PM: Some devices failed to suspend, or early wake 
>>> event detected
>>>
>>> So add a quirk to make sure the following is happening:
>>> 1. Let the i915 driver suspend first, to ensure the display is off so
>>>     system also cuts the USB touchscreen's power.
>>> 2. Wait a while to let the USB disconnect event fire and get handled.
>>> 3. Since the disconnect event already happened, the xhci's suspend
>>>     routine won't be interrupted anymore.
>>>
>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>
>> I was wondering if there is any progress in trying to come up with
>> a more generic fix at the USB hub level for this as discussed in
>> other emails in this thread ?
> 
> This patch fixes this issue and IMO quite generic:
> https://lore.kernel.org/linux-usb/20240906030548.845115-1- 
> duanchenghao@kylinos.cn/
> 
>>
>> Also have you seen this series:
>>
>> [PATCH v2 0/5] acpi/x86: s2idle: move Display off/on calls outside 
>> suspend (fixes ROG Ally suspend)
>> https://lore.kernel.org/platform-driver-x86/20240922172258.48435-1- 
>> lkml@antheas.dev/
>>
>> ?
>>
>> I wonder if that is relevant. If the touchscreen gets turned off when
>> the GPU enters D3 then this will not help, but if it gets turned off
>> by the system wide Display Off call as described in that series then
>> that series + extending patch 3 to maybe also include the HP ProOne 440
>> might be another (cleaner) way to fix this ?
> 
> The series won't help. The display was turned off when i915 turning off 
> CRTCs, so it's much earlier than the LPI's Display Off.
> 
> If the the touchsreen is turned off by Display Off, then the issue 
> shouldn't exist at all, as .suspend_noirq for xHCI is already called.

Just FWIW the original PoC I that I did [1] that the series was based on 
did it in a DRM suspend callback.  I don't think it materially changes 
things though because you still would have to get the device ordering 
between XHCI and DRM correct.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/log/?h=superm1/dsm-screen-on-off

> 
> Kai-Heng
> 
>>
>> Regards,
>>
>> Hans
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>> ---
>>> v3:
>>>   - Use dev_dbg() instead of dev_info().
>>>
>>> v2:
>>>   - Remove the part that searching for the touchscreen device.
>>>   - Wording.
>>>
>>>   drivers/platform/x86/hp/hp-wmi.c | 59 +++++++++++++++++++++++++++++++-
>>>   1 file changed, 58 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/ 
>>> hp/hp-wmi.c
>>> index 876e0a97cee1..92cb02b50dfc 100644
>>> --- a/drivers/platform/x86/hp/hp-wmi.c
>>> +++ b/drivers/platform/x86/hp/hp-wmi.c
>>> @@ -30,6 +30,8 @@
>>>   #include <linux/rfkill.h>
>>>   #include <linux/string.h>
>>>   #include <linux/dmi.h>
>>> +#include <linux/delay.h>
>>> +#include <linux/pci.h>
>>>   MODULE_AUTHOR("Matthew Garrett <mjg59@srcf.ucam.org>");
>>>   MODULE_DESCRIPTION("HP laptop WMI driver");
>>> @@ -1708,6 +1710,14 @@ static void __exit hp_wmi_bios_remove(struct 
>>> platform_device *device)
>>>           platform_profile_remove();
>>>   }
>>> +static int hp_wmi_suspend_handler(struct device *device)
>>> +{
>>> +    /* Let the xhci have time to handle disconnect event */
>>> +    msleep(200);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   static int hp_wmi_resume_handler(struct device *device)
>>>   {
>>>       /*
>>> @@ -1745,7 +1755,7 @@ static int hp_wmi_resume_handler(struct device 
>>> *device)
>>>       return 0;
>>>   }
>>> -static const struct dev_pm_ops hp_wmi_pm_ops = {
>>> +static struct dev_pm_ops hp_wmi_pm_ops = {
>>>       .resume  = hp_wmi_resume_handler,
>>>       .restore  = hp_wmi_resume_handler,
>>>   };
>>> @@ -1871,6 +1881,51 @@ static int hp_wmi_hwmon_init(void)
>>>       return 0;
>>>   }
>>> +static int lg_usb_touchscreen_quirk(const struct dmi_system_id *id)
>>> +{
>>> +    struct pci_dev *vga, *xhci;
>>> +    struct device_link *vga_link, *xhci_link;
>>> +
>>> +    vga = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, NULL);
>>> +
>>> +    xhci = pci_get_class(PCI_CLASS_SERIAL_USB_XHCI, NULL);
>>> +
>>> +    if (vga && xhci) {
>>> +        xhci_link = device_link_add(&hp_wmi_platform_dev->dev, 
>>> &xhci->dev,
>>> +                      DL_FLAG_STATELESS);
>>> +        if (xhci_link)
>>> +            dev_dbg(&hp_wmi_platform_dev->dev, "Suspend before %s\n",
>>> +                 pci_name(xhci));
>>> +        else
>>> +            return 1;
>>> +
>>> +        vga_link = device_link_add(&vga->dev, &hp_wmi_platform_dev- 
>>> >dev,
>>> +                       DL_FLAG_STATELESS);
>>> +        if (vga_link)
>>> +            dev_dbg(&hp_wmi_platform_dev->dev, "Suspend after %s\n",
>>> +                 pci_name(vga));
>>> +        else {
>>> +            device_link_del(xhci_link);
>>> +            return 1;
>>> +        }
>>> +    }
>>> +
>>> +    hp_wmi_pm_ops.suspend = hp_wmi_suspend_handler;
>>> +
>>> +    return 1;
>>> +}
>>> +
>>> +static const struct dmi_system_id hp_wmi_quirk_table[] = {
>>> +    {
>>> +        .callback = lg_usb_touchscreen_quirk,
>>> +        .matches = {
>>> +            DMI_MATCH(DMI_SYS_VENDOR, "HP"),
>>> +            DMI_MATCH(DMI_PRODUCT_NAME, "HP ProOne 440 23.8 inch G9 
>>> All-in-One Desktop PC"),
>>> +        },
>>> +    },
>>> +    {}
>>> +};
>>> +
>>>   static int __init hp_wmi_init(void)
>>>   {
>>>       int event_capable = wmi_has_guid(HPWMI_EVENT_GUID);
>>> @@ -1909,6 +1964,8 @@ static int __init hp_wmi_init(void)
>>>               goto err_unregister_device;
>>>       }
>>> +    dmi_check_system(hp_wmi_quirk_table);
>>> +
>>>       return 0;
>>>   err_unregister_device:
>>
> 
> 


