Return-Path: <linux-kernel+bounces-371739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 258459A3FA8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B77D9283AA7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17A8374CC;
	Fri, 18 Oct 2024 13:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xSB4cwHG"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E3B1D545
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729258234; cv=fail; b=ZgdDTTBtIUA8eWJOtZaGCS++DqzfSx0UhPGbqginTzhjXNECrMEkajHIGP2q7U3iHXR4jitV2V2tt0TA3sJ9opKxbsBmhjzrICfUkMM3F16WjpCpNWwAg4zAiYRqoQf1UKYFAOO0BTr+j5lCB+LZPtS1tVVxGLMvkAhdeIf5Tgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729258234; c=relaxed/simple;
	bh=0d8rk8IQKycth0klyZagYFkfb+Q2Gmq436/rBnfhFlI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LCdXtimVRY4/3gK48pBOD2+KP4TS6oLZ/Wq0SgEgdJdXvF+6xi2n3zxwQxBxS7lEVDBDYi+otuaRPkHOxwAcTPLGqW7njrs+jvVa7o41rQT2Ny1phHez+acwgGC1Vlq8HxuKIhsbsl9S16DbeHJlwI7Qz7woFS6619aTcd5PGyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xSB4cwHG; arc=fail smtp.client-ip=40.107.94.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qzzuMBCW2wNp+4DYw+0lD/IRYc6gNU0z145MmFZxXPDZ1Hlg3KmPUbJLn/LqYJDP8P91sPSugjdOiIAwczXDDXmkKj5uI6ohSbj5+1wwKe5OiaCYRZvGRh8mjycWslO63NJYrJKg3xYckXTUAeqoOwRNEyTHiHBGcpQIAl+7pFYyZG+6h4NA477mjEzJSB0hjSrxxOUBCBsUmnJ4Bx4EMbY1KtjahsQX1MqnsgklymMYibPoIhBoK6mbLT7zJgfKrdBsRwGcW7HXhZbMGw6zkeUG2SqtAgDMpf+xx5l6JZFx4WSAs2btU8sKOm2UeIyz769yFnFN8InCS18N48WBYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWVnpjdgnAtjvez71CfNPj4z+t1/+IJ+wlPDPy+2dho=;
 b=ju0LlCstpzAk+6OEOhDcIJHypKGQjUVnTkcQBsnFSQXo86P5cR+PA29C1ufhKOiNomWg/fkhn2Gqbz9gPsTFC0mp8TtEIHw95UKLg0DgSRCiDkwXK7zIpkdGA1TDE7OtVfsP6sCCEWzPF2cFxRMGaSBCaAqkNu69OQv/vf7Q2B1hqNlRg0e/hNoXh1Ofp2Tt6ylcReZOIAMVRcsxJ6Smz5kCT8gCrCqmrBiTzcXU0QvalZGwNJDRdtl1rGA2LlXLIVgJif8oNOuT+ZDcJjO8obzSujFaayDx4oDD63E8Yrk8EgPqvBWlTttEExqRnA1wvil6+2cXMxy+xlzd7ozv3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWVnpjdgnAtjvez71CfNPj4z+t1/+IJ+wlPDPy+2dho=;
 b=xSB4cwHGuHvcIFGb2+fMSXE5TAp3MHdT3P/Gypn+R5lN7jYYT1lPnWPhnOkyqLqNB4AHVlx/vJK0osDTcQBfW/JtL3hc1Fy0DiWN7XOlVucaXEtM3blf1jd9CFC5LOerTcpboEUmfbcNn/fHel/ENG420Kl7UATlCFRQHkW5N1g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by MN0PR12MB6221.namprd12.prod.outlook.com (2603:10b6:208:3c3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Fri, 18 Oct
 2024 13:30:29 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8069.024; Fri, 18 Oct 2024
 13:30:29 +0000
Message-ID: <89641965-5f0d-c5da-2399-13b18669ea85@amd.com>
Date: Fri, 18 Oct 2024 08:30:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 3/8] x86/sev: Require the RMPREAD instruction after
 Fam19h
Content-Language: en-US
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1727709735.git.thomas.lendacky@amd.com>
 <a8aa2542fb1b65371ca08ce2be40a5179aec6dca.1727709735.git.thomas.lendacky@amd.com>
 <de96cad3-6591-4084-b02a-e0b2c27c525b@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <de96cad3-6591-4084-b02a-e0b2c27c525b@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::8) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|MN0PR12MB6221:EE_
X-MS-Office365-Filtering-Correlation-Id: 617646c2-535c-4a14-1a56-08dcef7908a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDhEMXczRTM3V3pCTWpaVmlib1pPU2E3MjZsdTZnTW9VTVRzQkZBRWVvSUlI?=
 =?utf-8?B?WEVWcWVkTjRzdFJ6MjJ3aGRhaHlkOWJ1dHJzNVV5b1JYV0lheitiWElLTTFw?=
 =?utf-8?B?RWdlaVVoa05WbjVta3dtVWJ4MmpBUVJWNzNIUGY3Q0tEWFc5TjNkanQzK3JV?=
 =?utf-8?B?TG85UTRsM3c3c1VhRUQrWDZkSDhmYUdaN1h5M1hLNkFqTlM0b0hJaTQ5Rjlm?=
 =?utf-8?B?cDNZVXJnZkROakpBYW91aE90VUhaQldnbEZHbWhzdkVkNzZJNkVvOHBueGlL?=
 =?utf-8?B?aDFsTXRPWlovZHJYaHBYeU53ZHg0NzdJaVBMZ2pxSVYvVE4xQ3c1M0QxcjlL?=
 =?utf-8?B?VFpWa1BUZno3cVdOcm95ZE9mN1FjSFg1bUdyblVpWHZqUnNnemswdlZBM0hR?=
 =?utf-8?B?dmcwb2dyNDgvY1lQV0JqcGlQYjhaeVpFdysrTm9IZ1hsT0FHY09YbHhEREcv?=
 =?utf-8?B?NmkycDd1bStjYnVMbzVSTDdOTmVNZXF5V2tsYng3bGVUNzh6RVd4Z3IrQTFF?=
 =?utf-8?B?WFRlM29tUFJvUHBoRm1PdzlVc0JZTnNZNmd4c1puczYwUGRrZG1PWDU5NHpN?=
 =?utf-8?B?bVF1ZUx2WjEycUMxL08va2k3VUZYQjNXdU1iUUVUZ21NSUZNSmMxZEJLWXJC?=
 =?utf-8?B?aWVYZ3NRcTFWb1M4VmJHcTVlOGIzS3NRQzNnbHllWDVEemw3WllnTS8vSmZ3?=
 =?utf-8?B?OUY4M3FnbG5oNzhpM3krb3VaNFVscXpHUHFFSG9DaHRCNGpTU1VTQTl2bWxa?=
 =?utf-8?B?MmhzeTc4RVdYdWI1dEJBelNwNTBmRlJsMnUyc2xKTjZMaVN4Ly93Tkt0NUg3?=
 =?utf-8?B?VkFDUjNOTk9TRVlWcDJyZ2cxQ2FVQmVmcDk3Tk1vcmQ4YWhpT09VOVRVSW53?=
 =?utf-8?B?OUZlQk11QzRLOERGR1ZVb3RQdUFoYTB2TkcvMURXaUM2STY1a1d5RmVpOEt1?=
 =?utf-8?B?bStrZVM4VitFOFZ3SVpRT0lzNS96UE5XUE1meStUdjBPYm4vVENvcWxBQTRn?=
 =?utf-8?B?Ky85YkgrVTRYcTA0ak9zaDN1QkZPa2grNG41eFlHRmtWMFBJeEFCSTI3WUpL?=
 =?utf-8?B?cjlRZFg5MWVHNnlZbWlTT2lmdnZVUng4NUt5bGFDUXFzdHo1ZE1mN1Qxd2d6?=
 =?utf-8?B?MWpVRjNuOWNnM2YvTjFjUWx1WVQ3cjkzcUZDT0pLOXhLNDdva1JBVmFDYURG?=
 =?utf-8?B?TkNpYTN6anR5SUYzd3pOckVqS2F3THVGSThBUEQvWWRYVVkwZmlvZHo4TjEw?=
 =?utf-8?B?TjZHRzl5NnJ6RXNad3FPM3AwWjNWbEtDbVdnZXFCUncvQXBpampQMEwyYlRj?=
 =?utf-8?B?bXdXR0NNcGxUTVk0WHVlWHR5SjZtVUFMR3JVY1VKbS8vcW1ScFRZNFFRQmhC?=
 =?utf-8?B?d1dqb1pEa0tDNHZjKy81a3FhQi9OWSszQTJuWm82TEFqSllnUzRtU0FYbGVs?=
 =?utf-8?B?VlN6N1hzZ2taczEwb1ZjOUF6UnJGemh6dkdscXJkQUM2YjIyNCtFL2lzOXB1?=
 =?utf-8?B?SDc3MWloaExHVVdTRWl3a2I5MnhLQmd1K24wTks0UGpES3ppaWFlemZkT2th?=
 =?utf-8?B?UVdRQ3d1cFlSVU1zTk15OGdQWUlzeWxnazY1TGtWcnVUNWd5NENDanZtVVZX?=
 =?utf-8?B?THJHRVJMdzQwQ3RlUGVCS0wrZzNDZ1JtaS9xRDVPODBvb3REbUJnR2t1UWdP?=
 =?utf-8?B?VWVCRmlVZmRUNE1aY0Q0Z3J2US9LVXRBdmxkekxTVnJvNzJJTEJuMXJZU0JV?=
 =?utf-8?Q?ltrMNrG8Xq5hNwx/YsegB0SwKaoLTt+CffDgXTD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXhXWWJGbTExTm8vMmxyZ0ZuVDVxcjFOL1cxV25rSnkwbDlNWDRENythMHBl?=
 =?utf-8?B?eWdyQnlrMjhyUnBlT01FTnVzZHJCdW9oQzJZd1NJd0hDblhIN1d6ejNZZ0dX?=
 =?utf-8?B?dlNJMStsSzhLbENhRm5xanVPd2I3alBkMzdFbDFKZkczQkIyMWF6bVZUU3NR?=
 =?utf-8?B?RXZaMVo4SkU2RTUybGJJMCtlQkJ3QTJOa1JRQXZYSHBSYlR6bEFDRUdEa2VE?=
 =?utf-8?B?ckl0S1QrNzF0dWZuRzhpTXBqbHluY2wvbFJJK043QjdudlIyVGlqQ1F0ekNI?=
 =?utf-8?B?NDJyUTVuanZBaHU4bWE5NEJYaVd4RmNlOGtIUnVEZFhXdTVOTmtGOUlEUkxS?=
 =?utf-8?B?US9PUk9WYk15Ukp0dDBtQUE5TGZYMHBTRFVndVFJQ1FwbWJQYnFRblhDVjdr?=
 =?utf-8?B?ZnR3TUhuMTZtVHNwMmRGUEtmc1pac2lpWTNEWExJUW1jNGVIS2FDUEp1ejhj?=
 =?utf-8?B?eWoreDhxSGYxZHFxcHFhREdTTVN2MFFma2hmUVEyNm9GTmNmSFpzRWNrMXNs?=
 =?utf-8?B?YkE1MU43TFB2ZG5mdGlJV0xsQlFoTjA5Ym9ad3Yyb0JGYnVVSEV3QzNwbXZQ?=
 =?utf-8?B?N2dsZktFNlk1MWFIcUVjdCtwT3JGV1FUdnpzbVV1d3RvYzFEUWhVaGpzRFlq?=
 =?utf-8?B?YlByVmpuOXl5YjM0YUJoWFlYZVRsK2xBZmNWa002cmtqdUk4S1lTRmNkUmpW?=
 =?utf-8?B?clpnMnRqV0F6WUhtVEtRWGJIb0diTzZxd2pIbTBMdFVNcGJWekJaTVJJR3c5?=
 =?utf-8?B?ZTM5T2lDN2NkZ21pK3BuQXdPaHJaQUdFem8vNzN4aFNCQTRUaFBDZ3ZkWEsz?=
 =?utf-8?B?bnlQTi91MDhCdVBoY1FGeEFaaWFUSUZPaldOT3RIamFXVVNYSDhwRWxDeENP?=
 =?utf-8?B?UnE1aWdTY205WjZ6WSt5UWJWZmtCLzN4dHcyQXVvVGl2bWVNbGRqYmdreGdp?=
 =?utf-8?B?dkIvakQ1d3RIQm00UWhVZ2VZT2l5MFNqMTdiZmVCV3R4RFNpK3dnSWZlQnNS?=
 =?utf-8?B?VjRYSkVOWlNFQUlmUE4zci8zUmg0TkVtUnlMYXVQYzBoSG4rVHpwUWYxMEZu?=
 =?utf-8?B?V3NLb2U2cnl1QkVKUFBZZkY2VG15dkcxK1JMN1B2Q1RjTEVWdlBNenF5Nyti?=
 =?utf-8?B?TXZzUDExMzZPKzdDbm85KzlIak9OS3RCWkt3Q1FocDFMNjVrNjdNSDVzWUl2?=
 =?utf-8?B?REhPZUs4QXhSVTZzL1EyeEVLQ0VVTWNRa0p1c2NHZ1JlSDJRY1IxVlE2QjZ2?=
 =?utf-8?B?UHdISHZsMGFBYWxDeHdSd2paZmpQUE1Ld0thL1ZLVmpucldkdXcwdlY5cCta?=
 =?utf-8?B?MmY5TVZIQ1hVdHVQWm1jeE5KVWRFN3NqUEgwdFBIcE1TSElLbVNtelhnbllS?=
 =?utf-8?B?blYyL3VPb1lQeWRpb055SlZ0VGt4WlBROGN1WXJJaEdsdTdrRlpDcGs0V0tD?=
 =?utf-8?B?L3g1d2RucDJ3ZEZTN2hjT2pMekt2ZWVhRzdwUXlZeWxTaCtyMk9OME5Od0JK?=
 =?utf-8?B?d2lzeWhtcEVPeUlRZUVXZEFsRndMalM4NkhKRmM5ZlhDTFoyMTUyLzVuRUU2?=
 =?utf-8?B?amY2VU8zMUZvL2gzYWhBQ2VHbTVUbS9oWENzdFBISkFGSmRTY2o2a1VIRDRY?=
 =?utf-8?B?VEdzNDk2UEFPZ2FGdVFjeFhKcFRnWk85TzRCSzNaNzNCajh0bTZIdU5Xb2gx?=
 =?utf-8?B?NVVyWk1tRi9WQnJlRjhvSW03eG96UHNXeDdvVHdFVlYzZWx5Y0Z4ajdPZUVM?=
 =?utf-8?B?clo3RTZmMU1hakxWTXpRL0JYMUNySDBKZU1QUnIveXdCVCtxeXV0WERsQ1JJ?=
 =?utf-8?B?Y1FUTkFMZlZNcVg2QkdGWGpzZWc0ajMxT3RLYmpncnlZdm1QdGFZdDJSVEc4?=
 =?utf-8?B?eU9lZXk5V2I2TDJhS0lmd3Q2Z2E5ZjJCc3Q0aW5xY292aTNxSXptNkRTOXNC?=
 =?utf-8?B?L1ZsQ1oyOGgybmlYa3Y2Y3A1MWI0SnA4WUNXS1Q1aEV0RmwyNUxHRng3OVZu?=
 =?utf-8?B?OFh0c1lTQmhzck1BUndtbjV4MW5rQkZCc3BOZDJCVlJ6Qk9UQ0NOcDlvRGlQ?=
 =?utf-8?B?WEkyTDMvMmlnTjdtR2VqTGZWL1VtOWovbHE1VXN4NG91V2lENG9DQkc3OUJY?=
 =?utf-8?Q?i4U6jaX2M/vfEYmk+dw313EYT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 617646c2-535c-4a14-1a56-08dcef7908a1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 13:30:29.7016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1T0YKSf9CzB8sjkRy7aeAUPHn7GIVPjD2+mXovueNygapdj8ozj1zNBmPGCGkO1e2mCsdPTpPeUDAT9rYP22Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6221



On 10/17/24 23:26, Neeraj Upadhyay wrote:
> 
> 
> On 9/30/2024 8:52 PM, Tom Lendacky wrote:
>> Limit usage of the non-architectural RMP format to Fam19h processors.
>> The RMPREAD instruction, with its architecture defined output, is
>> available, and should be used, for RMP access beyond Fam19h.
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>  arch/x86/kernel/cpu/amd.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
>> index 015971adadfc..ddbb6dd75fb2 100644
>> --- a/arch/x86/kernel/cpu/amd.c
>> +++ b/arch/x86/kernel/cpu/amd.c
>> @@ -358,7 +358,8 @@ static void bsp_determine_snp(struct cpuinfo_x86 *c)
>>  		 * for which the RMP table entry format is currently defined for.
>>  		 */
>>  		if (!cpu_has(c, X86_FEATURE_HYPERVISOR) &&
>> -		    c->x86 >= 0x19 && snp_probe_rmptable_info()) {
>> +		    (c->x86 == 0x19 || cpu_feature_enabled(X86_FEATURE_RMPREAD)) &&
> 
> Maybe update the comment above this if condition with information about RMPREAD FEAT?

Yep.

Thanks,
Tom

> 
> 
> - Neeraj
> 
>> +		    snp_probe_rmptable_info()) {
>>  			cc_platform_set(CC_ATTR_HOST_SEV_SNP);
>>  		} else {
>>  			setup_clear_cpu_cap(X86_FEATURE_SEV_SNP);

