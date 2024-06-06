Return-Path: <linux-kernel+bounces-204935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDC78FF52B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 21:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 253032895B1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 19:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79365FB9A;
	Thu,  6 Jun 2024 19:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VyIyNWw+"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B0A44361
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 19:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717701345; cv=fail; b=B6nw+VflDivwG/00X33GnzktSNzn7pP81dCq7J/9UDWVcQIqmvfjobLTjGFOv5KVnbSpqeJPxx9+7XOsJcCvJM20N/QPFTb7oL0cxk30oRUKbJznjRvPvmXcAxD4dvh60JuhZBSt44tADelnGooEkJ5lpUbW0NYFtV0446esFVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717701345; c=relaxed/simple;
	bh=NXOpJkYkgxPDEGFNHIGNdvl2mMK/+pdpoNlOqKEj1RU=;
	h=Message-ID:Date:From:To:Cc:References:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=pmbowbtbE4l8bHh3dfOyyy8DD1WhEBktC0/U2P9ML3cKi5j2V9nDIDFghTAErdW9W3uucLuwoQr/1+6yZ6egM7p9yKOlwBkXoL6txjg2eBgmoT99gQnB2mJ29rJwqGOOcrETu1Jv0XP0+/fnW2/uwljXF/uUBOGYNpyaWX8sLAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VyIyNWw+; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIchHPs7ieXqqiBVpLFuchBvgquY2+WUJQunTn2OULKDY27VNR9wTmUmzcOYdsd0lQTxGisNfmPuDWSzCcm+ZDQEEtBQF6SyZ6coURg4WbmkHeqmlx8YFQILIJ1VDYJSFJSqnG2vtamqHKCMVBlRzg4NukqUGbm93ht3vWxu0QpUq0jTofU9ztioMzSfV6x7wivwSuOwmliQ6PRoDj29XBMEGZCzGPPZpLlKY6wQ178s9V44icTLEebrucTE7z0mCsKh+v3XQpHFVg3ZZ3Egsju6LlgcbOMR2Ayk+abbfGvIWKKIJbGBetV51xF5xMUI4IiLoWtpf3tItVeZsCfLkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fe/diOsHVk/oqeir70SPxgQ8k44Q0PFye9GSeDY6D7E=;
 b=aLu8aneUqbk+F7uw7VPsbfqS4dvhtBFVezZ76x/SNMs53jtm1Z9gm+KVqNH7R33GuMFsPO5V2cPmVWanFZRYYt0qzdj1t/Mx2fNAbx12ssk+r+JGt1zuLsKVtvjfm9AyMahst45l0sT7kVE+DPnNtrUuY3foEWKftJ8MSWpaX+1eAWUavTjIDdb29yIB2OwzmeU+dBmAGtO6flXKHDl+WKzFZf5dDHqFnVwejZrAiD1btAaHKdNLT9sTqz63pFrkNGy6vsReB9lPdZJugHmNuI9pgJoUoM1dK5fkRmlUOX148TrBFnKQ7PjezruGXslZKRsudeOabJfgOWdAQbHoDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fe/diOsHVk/oqeir70SPxgQ8k44Q0PFye9GSeDY6D7E=;
 b=VyIyNWw+EWXXTC2V0KBwOgvz0kAkmsQ/2bNHHEUFrIIznfz8mxZrEJKZzPnmGLxehcpri//HPvxBgKnA7s1E7fr6I0KBZfd6gIveG9p67UQhT9/H5v/zUb2BdOTxUD3t8BCyXPSPIVQkLDh4xSgsdSfA1KmNNPVFRpaDjy8gj4U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by DS7PR12MB6006.namprd12.prod.outlook.com (2603:10b6:8:7d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Thu, 6 Jun
 2024 19:15:41 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%7]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 19:15:41 +0000
Message-ID: <f00f2767-c113-0953-9869-c9696da677f0@amd.com>
Date: Thu, 6 Jun 2024 14:15:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From: Tom Lendacky <thomas.lendacky@amd.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev,
 svsm-devel@coconut-svsm.dev
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1717600736.git.thomas.lendacky@amd.com>
 <965015dce3c76bb8724839d50c5dea4e4b5d598f.1717600736.git.thomas.lendacky@amd.com>
Content-Language: en-US
Subject: Re: [PATCH v5 12/13] x86/sev: Extend the config-fs attestation
 support for an SVSM
In-Reply-To: <965015dce3c76bb8724839d50c5dea4e4b5d598f.1717600736.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0135.namprd02.prod.outlook.com
 (2603:10b6:5:1b4::37) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|DS7PR12MB6006:EE_
X-MS-Office365-Filtering-Correlation-Id: d19dc8d8-6a13-4d6f-bb28-08dc865d0e57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2FkL1RQZXo2b01ib2JrTU5uRTBqSHdSanFoOGcvS1RBaUo2c2xWRHl4RDhz?=
 =?utf-8?B?aFEzQjR0VjdDTUcvUnB1cmYxd2JnU2pmZGRHa1FhN2R0elBSclNocU9iSXR4?=
 =?utf-8?B?aUIyMzVLVmFtQXdTYmVCMHRyWUxYTGNFNnZza1ZLQlhpdHoya2RvdTdsWDBR?=
 =?utf-8?B?Tjd2WGdRdlBtYXNNeVBiellXTDcvOFE2SkJHMGRvQVowenlUaTYwQmg4L09p?=
 =?utf-8?B?UUlDK3gvczBQc3YwdnRLZ0ZpYWxiWkdyRGlRRXRBN0cxWGZ4K2oxTlJFNE5G?=
 =?utf-8?B?MXF2MWp5STVKd2xoMllkUjdxNVFzcGhKRGxIRGZKTU00bG1LaEVJbzlvSTJN?=
 =?utf-8?B?dGQxbHNUT2RVV1pQS000aE9LYy80enNpS1BMSDBycktvVzNmRjVCTWhrckpV?=
 =?utf-8?B?KzA4SFkvajYweDNBOEYxYTlIaFZ6YWRERk9TRi9yVSt4cnFpN2RZSnN6bHlQ?=
 =?utf-8?B?K0s4OEFwTE8vTTNRYTZ5Q0p5cnMrQnBURFZDUUhhajU4T2d5ZkYyQ3NlOGky?=
 =?utf-8?B?R2JhYktYUmdEY3Nwc1hDNmxhMjFRQ2JYUFRlb2czanFVaVozRTJ2Q2ZJUDJG?=
 =?utf-8?B?M0NtTExZVWtJOGg2dXllYzJSNjk4VFoxZURRcFIyQUpzV0Q2ZTR6NjZMZ0k3?=
 =?utf-8?B?NHZ6d0hKdS9TWFQ2ajFERDNkWks5OHgraTR2bHl2MTduMFVKWGtBMU9WR1pX?=
 =?utf-8?B?Mm1EOTBUWW9LaXNjajVrVHNkSUV3Z0JUYW84RktMZEdKcVIxZHRNL0ROR3Ru?=
 =?utf-8?B?QVRUN05WMVlSTkVsSWdQejJUK1VxYitjcXlDYXE4Y2xOUkhmSEYzdGJSQXlW?=
 =?utf-8?B?WXF4TUplKzN1SUEzbE9kdkRHM3dIU3RHYm5oRTNVcUUrbkFKSS9veWo1YzhE?=
 =?utf-8?B?VktyU0pKRVphemg2SHZiVG5LT3hCaWxFaEZyWXNMSzQzR245V3RmK3lsVFVF?=
 =?utf-8?B?OGp5d3RFTk5oeDVZVG5qYUE3bzc5Q1JzcHd5bUFqejhSdXdvYktCSFFQRTFi?=
 =?utf-8?B?Ry9MZmFFSFI3eFFqNWVUQ3hHY3JJcysrUzdEZlVReVBsS0cyeWQ4NUJCV1E3?=
 =?utf-8?B?STFlZkJ0QTNrZFZkdzQ1b2JoWVczS1lMRkFkN0w1ZjVWSVVWTlpCNWVxK243?=
 =?utf-8?B?TDhkK0c3OTZqaDh3bFZTT1lKaGRIUldVVVBsRXRPL3RnVUFxOXJXQmJ5SFJr?=
 =?utf-8?B?NnNhc0hMRWdsdmc1K0NoUnpodzNvMTh5d3gybVhueHVKNjI3d2ZBN2prUCtG?=
 =?utf-8?B?WnRUbDVTb1hzU0NmdExZbUN1VjVtOENnYzRzYXJPeUVZTjJLd1VtbWFDOWE4?=
 =?utf-8?B?MkpKZzZHTnJ5SjlyYWxDSkVycGdBYUdhWDJQNWdoaENtVno3TE5WZitjcGhx?=
 =?utf-8?B?VTNQVHdTUTNNdjUrbzRlcXlkVDlMOE5MVE1WVWgvcU9KblpaUGhSa2ZiNW5N?=
 =?utf-8?B?VmMzOXdpbVBzblJTYzE5UEVFc0w5U2ZoQkpFUXFOc29FU0hZWGZLSWNlOWgw?=
 =?utf-8?B?TGE4anhqSGM4dHpoOTRJUWYzZEgzc3VmMXJOVjJPdExmOEZKckNYUVRnWm9u?=
 =?utf-8?B?MllZVUhISEl3MlU3NVNBcndnYjRhRHNRdHRvaGtCQlI2SEF5WUtaR2k5QnNZ?=
 =?utf-8?B?N21meXhRb0MxWXZrU1lKYUxEYTVIL0tidjFISVR2djROSmZKYVJ2TS9mRDJp?=
 =?utf-8?B?bVQ3eVZYNFhqL1h0WXBWeTF4Z21jaWZybzZYaHBmdDJxa0ttR2JjeG9hMEty?=
 =?utf-8?Q?rzO8ha/00dMfsJnLHRrxHPBp9PWgdyqi1jRuWjM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzVwdkR2SXQvcENhdE1ockN4alZNZWU4RlJNdlplVXlhMEVZcXJ4MTlmSTR5?=
 =?utf-8?B?NEM0MjVRYm92eUdzVjA2cFNLSG15Qlo2RmJrZFJlbFVSZENZOS9uaEhKc0Iv?=
 =?utf-8?B?S0NTaS9OTTFwZWJaWXNyU090SitCWmVLQUN2a1AvUFNoMGdSeGFGdSt3TDgw?=
 =?utf-8?B?VXd3Z3FBa3daRkg4eUVUZCs3aXBqVFhCbFNVUHB2Yzd3akMwVmg2b0FpV2k5?=
 =?utf-8?B?Q3JtVDNpODhQR3NFaEc1ZitrVXc0ckMzS3lrSCt0S3piQzd2T3BzZWpEd3ZW?=
 =?utf-8?B?SVRjU01pT1U5RHZUNW1uWE1GbmdsS05GMSt4U3RkTk5WaHExb2FTN3c0RVE3?=
 =?utf-8?B?a1RQdlgwOE8wNzBMNkl4azloLzYxV2RZTEk4QVRwbGNBYkpGU2hReFZCWGhM?=
 =?utf-8?B?TDlIZlZJQkFuMjZpL0p6Y1dNaXlpMTJMUWZBOGdVV1pzQlpveVJBNXZHM1Q4?=
 =?utf-8?B?bjcrQVBHWVBDVEtNQnBxU1lkWVZmYmlwb0gzaHd6UlVLTk9aS1cxVnZhTXRM?=
 =?utf-8?B?c215QjNNRXRGOWhsUkREZlhhSmxRNTNlcXFaRVA0eit2NnNuc1RrKzlaUDFQ?=
 =?utf-8?B?aEFwVkx6d2hKdlhXTTM0QzYycVpaQ0gvS2JmWGl4cVQxaVk5c21tbFVlbmFD?=
 =?utf-8?B?NEI5dVFxMlJaR0NDTEJEMTRBNHZidnFVZ25xamduKy9IUXY0ejJOQ0hYZkZZ?=
 =?utf-8?B?SUR3WFFDcVE4MDZaeWVaWmxla3JNS1NSczR1WS9tRzVabFlPWmhzUFRTUEJn?=
 =?utf-8?B?M2FWT2RTelcvYTdYU1ZKMEpON3QxS1prWGcxbitCcmJOQjlGb0phVW9JU0Z4?=
 =?utf-8?B?TkpIbWZmR1pvNTI3cTFjL283QUs2QlVZcXVBU3VQWUJLMnJuZDBWRVJXTjEw?=
 =?utf-8?B?SjRLclpxbXRkWUc5allweUxjUXBUSjZNZEQwazJYdk1nQmFnVkJETEtwbUVn?=
 =?utf-8?B?MlhBK1kxSWllRk9Qc3FIeS9nT1RkbHFIbnZhWkMxWmhmTksxMWg1ZmU0Q3F6?=
 =?utf-8?B?TUIwck13czhvNUllbWxsdG40SlpvaERYa1VQTGI1ck14NHFTTlFEeU15R21M?=
 =?utf-8?B?MWFEWmtnamNoVENLZ2JxaC9pZUpjYXh3L2FobFA1SVlVUm5jb3FzOUxYc3Ux?=
 =?utf-8?B?bFcvTzNXMHIxdmVVK3phQWxkM09JMm56VE1FWkhMMTh5WCt4Y2krdmlLZDQv?=
 =?utf-8?B?dEVhcHNTNmxQN3p1aWV5Wi9wc1g3c05QTHl4SVUyTjRJYzRnV2ZEZThwOU1E?=
 =?utf-8?B?Z3JSdjlna2Z5emZzN1lkS3JPb0NwTGtjaGl4WXp5d1JScWdYaTM5RUJjYXQy?=
 =?utf-8?B?b2E2YTV2YUNVdGkycnFYTXE5NXdjbzhRMGhLY2ZoNnVLcDJpY0NrWWg3UG5N?=
 =?utf-8?B?R3Fjc3YyTDREK1RoUmkzNDVrZ1ZUUkx6NGVwRDAyTUFtdFZ1WlBEeXBaa3lI?=
 =?utf-8?B?aVJvUHFicHNtazRsengzRGovd2c5WjV1RE1vZWVCNEpPa1FDa0Qxd0lFWVJK?=
 =?utf-8?B?MHZ5VmFYNVpYS0hSaHI1a212V2Z4L1lmM1BURGQ5eHN5cjFvRE1CVzN5amJ0?=
 =?utf-8?B?bjRBSFhqMGc5c2dNNjhFdkgwVWFSMjJnLzVyd2M3R1dKUVpaOS94L1ZQMmYx?=
 =?utf-8?B?YVAxdVpNOGhTYkNTU3lxQnY4MlBKa2VvOW4yVkdmL0x4cmRjNWZJSjVUUHhl?=
 =?utf-8?B?aVlwUlJTNzdtVUpJNWN5cVdCVzUzSjZ2bDhYdGhzMS9XR1oyOGt4dy9Nc0dM?=
 =?utf-8?B?anZpblpkSnRzQm9TMlZGR1BIT2p0dmVHME1LR1BkVUNNQlhXelRsZEVna00z?=
 =?utf-8?B?VVJjdUJQOVRlYnJudFF2N1p3RHF1TEdiTjluckpscDhuN0hqT2RpUkR2c3Vj?=
 =?utf-8?B?WE5ibmNxQWx0djN6WUV5blowNWcyWHhMNm5qTjk1eno3dXNCYjN4Y29wOVJ5?=
 =?utf-8?B?TDBlVlNtSHRKempTQTZBWExQVE1SNCtMaW1UL0pvclZmZStoQmpQYktIMkJM?=
 =?utf-8?B?UWl3cC9YRXRRdVJGQUxMRGtDN3BSS0xQaGNILzg3bitRT2FObDd1ZU1kcHhz?=
 =?utf-8?B?ejRrWkxuN2ZXamZzL0NnZXNpLzZLSTRrREFxWmc2OVM4WWE0Vms2Rnkvc1I4?=
 =?utf-8?Q?gzUPYelXMW5WzAlsX3hsqtIuK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d19dc8d8-6a13-4d6f-bb28-08dc865d0e57
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 19:15:41.2095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DcTOQZEUnq6QiBjunKqEDDnmAbX0EKdyeUmNVWkVce93WlmEaO/bV3pd1SmO1R82EZGWX/06i+cQI2y0yKHmhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6006

On 6/5/24 10:18, Tom Lendacky wrote:
> When an SVSM is present, the guest can also request attestation reports
> from the SVSM. These SVSM attestation reports can be used to attest the
> SVSM and any services running within the SVSM.
> 
> Extend the config-fs attestation support to allow for an SVSM attestation
> report. This involves creating four (4) new config-fs attributes:
> 
>    - 'service-provider' (input)
>      This attribute is used to determine whether the attestation request
>      should be sent to the specified service provider or to the SEV
>      firmware. The SVSM service provider is represented by the value
>      'svsm'.
> 
>    - 'service_guid' (input)
>      Used for requesting the attestation of a single service within the
>      service provider. A null GUID implies that the SVSM_ATTEST_SERVICES
>      call should be used to request the attestation report. A non-null
>      GUID implies that the SVSM_ATTEST_SINGLE_SERVICE call should be used.
> 
>    - 'service_manifest_version' (input)
>      Used with the SVSM_ATTEST_SINGLE_SERVICE call, the service version
>      represents a specific service manifest version be used for the
>      attestation report.
> 
>    - 'manifestblob' (output)
>      Used to return the service manifest associated with the attestation
>      report.
> 
> Only display these new attributes when running under an SVSM.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>   Documentation/ABI/testing/configfs-tsm  |  63 +++++++++
>   arch/x86/include/asm/sev.h              |  31 ++++-
>   arch/x86/kernel/sev.c                   |  50 +++++++
>   drivers/virt/coco/sev-guest/sev-guest.c | 178 ++++++++++++++++++++++++
>   drivers/virt/coco/tsm.c                 |  93 ++++++++++++-
>   include/linux/tsm.h                     |  19 +++
>   6 files changed, 431 insertions(+), 3 deletions(-)
> 

Here's a small change to provide better error detail that you can squash
into this patch if that's ok.

Thanks,
Tom

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 655865164705..e32ac31e0630 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -886,7 +886,8 @@ static int sev_svsm_report_new(struct tsm_report *report, void *data)
  
  			return -EINVAL;
  		default:
-			pr_err_ratelimited("SVSM attestation request failed (%#x)\n", ret);
+			pr_err_ratelimited("SVSM attestation request failed (%d / 0x%llx)\n",
+					   ret, call.rax_out);
  			return -EINVAL;
  		}
  	}

