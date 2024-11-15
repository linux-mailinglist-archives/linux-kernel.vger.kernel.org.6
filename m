Return-Path: <linux-kernel+bounces-411215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CB19CF4B8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA59D1F22C5D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B621CF7A2;
	Fri, 15 Nov 2024 19:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eoo93gwP"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C083F13D297
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 19:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731698424; cv=fail; b=oUn6Zq6TV4rAbWnxjrs5rfhkqCKf1GhjhILQVHeyReqZ4CZtOUXi38RsNwjqCZ/HYPEfKEdLZ7fHdOwtjk5lkDAHdbxbu721qZmh3SDkIh/YdzPLYvfYJR+dJBCaNM/zGxOkDJ73zO9ad/+xb8CdM19dbjVbuiN6Tj3hz1pVl/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731698424; c=relaxed/simple;
	bh=y258Q2Sw5A0VeKY49X/WACXkQjP9Zi5cgcfDPLUTMrA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TprL66N4zExOvjtl6Inm/jZLIG76j3xJ6Ynys/SeKnwdf01IJn86bhtSDHsLk66442EY6+0+h/rL3MAZgJvEpLvqdWx4ad81kKqE0IOax9Mt0p8//+5hLEwVT90KFF0Wta43DMYjXL8V52aG1cZwUVM+2dgyZl2M/G18jFtVw8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eoo93gwP; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ea6QNC7+Ul9PTv2QJti82x9NbtyLF0234NSsmJRAuOslFnuhpkxsbsfC1ahekI/7AzshGc1ouAjCG7o2BYKIzJwIULyf6qZL8wFeQ5tlOW2+9FRAherefggslL9G0+tBKgSv9nm6n4x0IPPiiORdD/Fbz2aahaCza4HKJ3TK/AWsb8kbHj+GeIOpFguNlgGyBXfUE5Na3Hde3EJuiZHzisL9tSYOBsJvhTKnPJBlSAu1Lud39cjcr5Jfkaviu9kvC3XfbuEM1DEd+uYwNTxDwf9peHP7XUUF5aUsqP76H+BNxFVpm5H/dxPtyCNpaa0leK8+jzlwBRTWxss7Nm7IWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=352wSFkTVzp4tYZb4vDzbvO7ddurmiVPDalBBzCUtAQ=;
 b=cLLZ/XAiYwmvF6K8rTLjIIk7vCo9Pbj0MMtFgEM4IXZrnwGCkhZKwVZgLC3Xkhyt6wTWzTPTWmdqczv7uJm78sp+J2UdtNt2xMufG8J+V635bX5JtdID3z2khbduV326Nmpl659nybhQKWiSX+xvjlGGg4jaO0xtCESzQ5ITgA5GT2xEdUdzpSXB0Jb8YmLAcewl3vmbjb7EE5ExpTzuSKITrPZRiRNfGkB5ITAEkPnfIRJ3Wo3vw46HkNPc7A8yWbeW23Yi01JxORwTr7cXtPY4TLqHAxnN4UNDbd3NTtwj+R3O9vmoIKyKhpDFhXliAnnJGtVaMMyIZGjNnVTNcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=352wSFkTVzp4tYZb4vDzbvO7ddurmiVPDalBBzCUtAQ=;
 b=eoo93gwP8//pii5BsmDRpSGJcYUxJwpuoqegyfYrlqLTELeVa5WGhjExDr+1LbGIAqUidEQP5nMwwR45ErgwXLheHMfKunPqJGBllTup8myId0j3gyl8LYvxL/mJi4riqgr/0hqbKLGIU6cr+6FhQ24ccJ71Gjh5MoVt6EDbfhI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by SN7PR12MB7345.namprd12.prod.outlook.com (2603:10b6:806:298::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 19:20:18 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 19:20:18 +0000
Message-ID: <b243110f-d233-0b62-864e-2b6181663d29@amd.com>
Date: Fri, 15 Nov 2024 13:20:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] arch:x86:coco:sev: Initialize ctxt variable
Content-Language: en-US
To: "Ragavendra B.N." <ragavendra.bn@gmail.com>,
 Ingo Molnar <mingo@kernel.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, ardb@kernel.org,
 ashish.kalra@amd.com, tzimmermann@suse.de, bhelgaas@google.com,
 x86@kernel.org, linux-kernel@vger.kernel.org
References: <20241115003505.9492-2-ragavendra.bn@gmail.com>
 <Zzcp75p3KTFRfW5O@gmail.com> <ZzeU_OXCAzMSOU1G@desktop>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <ZzeU_OXCAzMSOU1G@desktop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P222CA0018.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::27) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|SN7PR12MB7345:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e1c54f5-0dd3-4f52-1168-08dd05aa8a68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUdrQ1FMdFIzb3lHQjZKK2EwcVFDN1lmMWVudktneE1FWTMyU3VYZkRoYVhi?=
 =?utf-8?B?cjc2K2g1UFZDTFg4dHZvMzBwY0Q1Z3J4Z1VxdlI0T2htdDQvWGRIU3IwdFNN?=
 =?utf-8?B?bTIxZzRxc2pHUTJVTnUvZnZkUGsrSmd2ODNpMlpWYWk5VkYyeDMzdkZ6VDRr?=
 =?utf-8?B?M1p0QWg1NHhvLzV0cWdTZkRPbmJoV2ltTERIc3M5L3c1UkRsYzBRRDFOdlVz?=
 =?utf-8?B?bWVYdndxNHA4ZVMvVGx3M1pIQVR3SmYzSlVxbzhoZkl2UGNXc0ZKVFdXNWp1?=
 =?utf-8?B?UUxjT3ZyeVg3R043NEhFN0lKY1BpOTBCOVFSdldSa2NrSForL2NvUGZsOWJH?=
 =?utf-8?B?SzdVZklUYUJCSFNuam05TWdSc205YnlmNkZuS0NxdzVSN3IvWUVIVGxQb0JU?=
 =?utf-8?B?VzFBT0l1OUxBSkR6RUdqVlptejhIcXdrTnRLN1F5K1Y2ZUxjQXc1K0hyektP?=
 =?utf-8?B?bjJoZ0JINEkxZmpmby9PbXo4aUMrSnRmZ2Q0NklQcHNEZTNka1pmUFRNMW83?=
 =?utf-8?B?aWU2Znk5WjV6TDFQMlF5MnBEb3FxSm50UVhTYlVqSWwvYkgvZ050M01hS0JM?=
 =?utf-8?B?WEZ1d2Q3b2d4ZWNOSzk3UWwrR2dpZEtLaHZqY3dFNys0c3lvR0taTjZpU2NC?=
 =?utf-8?B?YmdoOExXZFR0ZGN0S3A0TExLODBPTXhjUjRncVhqaXhVelVHRG9MY0RHK05i?=
 =?utf-8?B?VFlhSlN3ODJvMW53MEZqN1JZcDVrZ0lJcTR0T0VFSUw2WWpiaWlYZjFTeEdS?=
 =?utf-8?B?SFpSVFVJVDZlZ2taalprSWQzUHlMenRtelZVUlRZQTRmNEhNeTVLQWdNQThB?=
 =?utf-8?B?WEg1RlZFNElEb0Z3NDhMb3JEZ011T01vb2VZaFVzQzl5d29GNUhxUFJMb3lv?=
 =?utf-8?B?N054YnNyR0dlcWdQMzJuSnIvNmhDa3c2NUtpUE1GNFJGenlpb2l6MGVUT3hI?=
 =?utf-8?B?T1kyZHJha3M0VnpOakFYaFB2Z2grUnJWWmkwS0ltL3NXcWJzZ3E1TEFiaWRH?=
 =?utf-8?B?TXk1bVVidDBYK29QS0FaOVltY2ppbysrOERmdk43MTJOYll0ZXFxT09mT2Jt?=
 =?utf-8?B?MS9kZjBHblc1bG4wMDZpcEJnOTdoNm55U2lzYVR2TEVYSWZVSjZqNmQrbmdx?=
 =?utf-8?B?WFVCK0txTk5lU3hXY1ZqdnU2SEU0eC9zWVJKK3lJSVZCR2crdEN5Z213NnZT?=
 =?utf-8?B?aTJ2YVVldWZEbjlqVE01bVhQMkRGeVVEcThOckYzYkE2TURacHVEaUd3cGhI?=
 =?utf-8?B?T3pWWFVHcHRUVnlENVhtUDF4aEUrZzRicjZpSUNqQnFXcjdyTEViMXcrM1Rm?=
 =?utf-8?B?YWVWQTVFS2JHVkYveVBFazJIeERLNVh4T2xtaFBXNXBQYVZFVmNKQXJPK1lB?=
 =?utf-8?B?dEFzOTdybjBWQmsvMWdzUlI4MHM0V2Uwa3VPWmwxVEV3aUx6bGJRclZqYkFP?=
 =?utf-8?B?eDdJaTdJQ05ZRFNUTVpiTHRpRlhRZS9Nd1Q1RkxrS1BvLzVIVkxhUUwxRVZn?=
 =?utf-8?B?eVVET1psS2ZseEhPSE1Fa1ZiejZUdlVBdXNOM0FDOENuVHJsMmpSdStVUGZI?=
 =?utf-8?B?dmhuLzk2cTNiL0JoVFl5N1JNWGJHMXdoQzZpV0FwazM3Z1NKK0hQdVJ1RThR?=
 =?utf-8?B?TVJyajl0a2lGS1U3SG8yNExGRzdFS3ByeXFpQ2RNSlUxYzZDOHVaa2gyNE5X?=
 =?utf-8?B?cmsyMkpBa3FVN0tudk8wdGlzc2VldVdadThyeHhjcVBOVksxZnpPN2RvUW51?=
 =?utf-8?Q?RI+bxboGfC8XHWBc0DOCOr0hDXCv3i7G1fB7OCE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3piRVY4UE5VYS9IdHozekZLOTFFMEZVcld1bmI2SU0wNHFYMzgxTTBxTlZz?=
 =?utf-8?B?aUpsUUozalM4cUpDc2kyNFhZYUZaYU5saE9OUWVBc0ZubzV1aHRKOVhvY3U3?=
 =?utf-8?B?NGFHUUZ4RmR1b2MxNXhXWUd3a1RoazFGYXRUdHBsUCtyNkFFL2RFbUFxSTRl?=
 =?utf-8?B?T09RUjN4ZWtuc1g0NVAzL2xnYzZ4U0k1b0hUYVZjV2RjT1EwekdaWTY3UHFK?=
 =?utf-8?B?YjVKOHVsWFVCcXZjRHNBN1Bzd0hCT3pnOG5zVE9XYVoxR0gzKy9ieForS3JV?=
 =?utf-8?B?MlN5b2Z3VmZ1bEU4aEdta1FGaEdtY1JsTllmendVWjRCTkZlRURqMkR1M3hS?=
 =?utf-8?B?V003bVhMeCswOGl1S1lqTGxqdXVLZXVsWmY3ZEh4RG5VUVpvKzJQTHVleDJZ?=
 =?utf-8?B?UGdmcWFMbDF4Mkt3ZDlZVmp4SE1mRnhWWkVSZ0YzOEpuUTdaYTZXQW9ybFhI?=
 =?utf-8?B?QXp1VFRWUVhkSzZNdGVRRmRmS0d4aDBxWXdRWEJGWHFLbVlnVldsbk9ibmor?=
 =?utf-8?B?Y25GMk1aSGovN096REhVczQ2bE5TRnhvOHlaTkQwdnRlT0RadXU5aUlkcWJ4?=
 =?utf-8?B?U2VERWdkRmlBUWhBZ1QrYUJpSU1oOGQwcHNwOGFXd2pwaU5PRW1VSTg5Qngz?=
 =?utf-8?B?WktjcTV4ODZjOG1WQ0cvbUtSaktpVWNpSk8xTkozdFI2elZMb2hEV21jMlhU?=
 =?utf-8?B?aWlyK0hyRWp1VmtnTmFLOWhRNWJHeFk0U09ldUVKbE9ac2NhcTlVeG44a3Ri?=
 =?utf-8?B?bFZmd0V0YXdBZjB3VWlzdXVKVFpoTUZYQUg1ZmdxSDlodDRFb28rd2ZaQkNj?=
 =?utf-8?B?bUNMN0NPbW1NbGZSS1RLUHRaSXNRVHRGcTZiazdMN2xKMU9ocUxmVytmQVNH?=
 =?utf-8?B?dU56NjhLVmM4WlhTcFFWV291Z2lsZGRCaTRwK09XM1NNUy9LYmtwYW5TelB2?=
 =?utf-8?B?UVNxZTI4dnI5YkJ3SjFxM1BudXBqU2lhM0hQR25iZzZ6V1VzNDBZMkZtaW52?=
 =?utf-8?B?RGVmNzlQSEorbXR5eWZNS01EcHFvYkRwVC9CYlZLb2xxNGVUZEdRT29FVjZG?=
 =?utf-8?B?TWNZbkh6K05jd1dycTd0MlBhbnVUTHBJaVJQOE1lSEJFY2ZqYXhVR0RBc2kw?=
 =?utf-8?B?cWtTYlN5d0hEOEVtazZIS0NlSDg0T2NMaXNEb2FMZFVwVmJmMjkySXljZThL?=
 =?utf-8?B?ZERuN3BYa2xFYWk3WHArTUdHQVN6YVQxWWU4ejk1ZlAzUWJWZlpiSlp5Ymlv?=
 =?utf-8?B?UkovYndWYW4vblpIbGRNajQ2MnpCL3kxS3A1N2tCZTJ1NFZwK0llaUFMRlQz?=
 =?utf-8?B?UU5TYlBWeVcrMEllendNR0pYcXZOKzBFblVXK20vSTdCMjBvSGFONll6VEdM?=
 =?utf-8?B?OXprcTF0UisrNjlTZlUrZkMxdGY3SGdXbXVYTjgzZ0RKa3ZwUkZYZWliazMy?=
 =?utf-8?B?ZW11WjZ1SHE2YmlYQW9BeE0zY0pRd1NKL2wwUTFFcGVIKzNmZTN1L1AvdjZu?=
 =?utf-8?B?TXJ5TkNqTU8yaGxaMEN2RFh1amZGT2tXbXUxeUR4NVEwZ2IzY2dKbUxiSGcr?=
 =?utf-8?B?a25heEF2NEpLN3RnWlNhVTBBUUN5VGRLSFcyaWhHaVh3WmE4T1pRTXF5VlZh?=
 =?utf-8?B?bmUzclVZalJJMHh2a1ZNNUxXNjV3c2tqNzErYnJFZXJLcTIxSnRDMUNldnBS?=
 =?utf-8?B?MTE2VklpV052WUZ4dmZvVHhOOXgydU9zRXVRd2RhYmlKVEN1cEp6V29LMkVq?=
 =?utf-8?B?WTZGV3BGMHJaQjhkYkV0QmYzaEZzZWh6WVk0YjRYMjBiK3NEWlNYWlBUaENz?=
 =?utf-8?B?SzJoQ2RtVG5oM0NodjF0aGpMOGNESmVUOWFDUUhiYU9aSjErM3lTeGkyWjY1?=
 =?utf-8?B?SUVBbjBKOUFLYzl1NDBCR3JsTnJWa1FGSjQ5eldJZUFtTXZaN2JjbHRHOGp0?=
 =?utf-8?B?UkltMElGbVdzUTFiRURkd3gyNHUwcXNWRm1Sd2M5cHpTTGNYa2Y5OXBvaWRS?=
 =?utf-8?B?TmJNbWtvU3Y2Ti9nb2JhWkhkSmtqc2NJSHJhQS9qSHJNQzlkZ1JJQUFmSnc1?=
 =?utf-8?B?ZHpnaVp1RlZUOVFsUlNlb0MwM0FEazdLTE9zSDRtOTFFclF1RzBRZ2k1V2pj?=
 =?utf-8?Q?7Ejzph2cEhbJ4Luk03+yUMYjD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e1c54f5-0dd3-4f52-1168-08dd05aa8a68
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 19:20:18.2963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /lRVPx4ajHtKq9YK/3HAbqXJPAXR+WIzkL0UPhC3V0ZPuB9XfpW0xf1mGBNcjjopwYg9oT9kC3hdEoaPjSkZdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7345

On 11/15/24 12:37, Ragavendra B.N. wrote:
> On Fri, Nov 15, 2024 at 12:01:03PM +0100, Ingo Molnar wrote:
>>
>> * Ragavendra <ragavendra.bn@gmail.com> wrote:
>>
>>> Updating the ctxt value to NULL in the svsm_perform_ghcb_protocol as
>>> it was not initialized.
>>>
>>> Fixes: 2e1b3cc9d7f7 (grafted) Merge tag 'arm-fixes-6.12-2' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
>>
>> This 'Fixes' tag looks bogus.
>>
>> Thanks,
>>
>> 	Ingo
> Please feel free to suggest the valid tag as the file was renamed and I am not able to fetch the correct commit id.
> git log --oneline arch/x86/coco/sev/shared.c
> f50cd034d24d (HEAD -> 1594023) arch:x86:coco:sev: Initialize ctxt variable
> 2e1b3cc9d7f7 (grafted) Merge tag 'arm-fixes-6.12-2' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc

A quick git annotate arch/x86/coco/sev/shared.c shows that function was
created with:

34ff65901735 ("x86/sev: Use kernel provided SVSM Calling Areas")

Thanks,
Tom

> 
> --
> Thanks,
> Ragavendra

