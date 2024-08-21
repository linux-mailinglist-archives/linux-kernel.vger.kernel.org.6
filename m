Return-Path: <linux-kernel+bounces-296105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E6895A5AC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 22:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6DC41C21D9F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 20:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8982716F282;
	Wed, 21 Aug 2024 20:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T7zP7pu1"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE1E1D12F4;
	Wed, 21 Aug 2024 20:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724271081; cv=fail; b=REO+4RgDDZWPRK1fjCPhEzwzC0EWunagC1QJ/QoxTRrMppeL/Yvgdc8JNugRCjXgZmGCDStf6E9gkjK6B1u4e8/Nnew6ibU/JsXQ3xSVzbGNkhP5kJlw5AdHHUQL91/JjcMAuR4CYOIL2kCq2LJFI4fxamyoC/jWhUyrc/5VCdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724271081; c=relaxed/simple;
	bh=CD9tyOHQCNLfD9Y36JPC95ZOBDcK8Ud/Xbtinx7D6kY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P3wlCDO8H0yEmgjYq86rhd/Enzphil9EmBcZuCnIesaGmwpoe4SsGkZE+ZZUSzdduIey7lrwpukpLavEbgr8gA4Uw6rEWbog5tbnriTsq0shZEoXDdt4wJP0KDLoFzsu4lA6AhB9kfU2TvGd9WeMWPCjKygVJqzKFQl+G87vaoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T7zP7pu1; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KCS8MrnAhF9H72kcvTBkMU2V4bC2eChdwOXPpQ1U9SbsSdVFruPZ9VPNLKvN8klxcgcbCD7vTsZ32Il9Ryccg28dh491UO0iWd8uluqRIjpomLVKCf1H1anCGvsFLgiXTJ3XuQRsNzj2QhZU4V8q+7MB/xjkIOQ/Zu/CvYAr+7uoYjeD4UzasefD0csZrnGF0mXNe4n4VrdNuqNRFym71//iGuUauTCn8Oup/1Q4UJbYZEHGHTo4s9ReywXIgaBs7KIFG2r4XZKYTb05gfAEBEZxp40X/U/zPxOV/VRNKKGN9xZmxrD/RYnrtXoDlCUaK7GHJ3BvQ6FbHxxCdujrig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/okjKMDJus9pMdgxSVyFvw1BAa+8+HwVj5Kaym1zMM=;
 b=N9oEkYcmG7550K2emfNEIvwPlCYTOJ31ESOoQdW6QKNOseAXgyVdBdvfhZBqk7Qiw+PZbM5MC/gFhvvLs4c5lmQ7pcXPpsfY2/D2l3Yqh4wQiIp90El2RSpzSATvDqrb50ojztBFCmxC90BZAJ4kcEJRdbKAFxkmqNvuzC1AkG6JIjCJPQxR8aNHLtVowZ05mumhLkwrVJ1jv23et11aQpJoAlOyq6/5NV9uzA6ZGDQGOWN4nVInI+uiS2D2ZD376TKZgFVR3kA3j/lpF6aoVwXmoVh6VgE60iRol2zEB9Fp44C3r/n3T9ejFj6Fj9cSSwFY0QIldJmdp1rwv/SfsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/okjKMDJus9pMdgxSVyFvw1BAa+8+HwVj5Kaym1zMM=;
 b=T7zP7pu198LlYvrEpUhd9SLAnlJ9Q/UbbgB+7IBGBpV0WfoMsnYRPpi7s2vrl5YX6p57yBp+sQ355/Pd0AwzdSDs4fI0Tz0WrXg69f4OSkJghUTEfR/qQW+o4QW/eRH/6WlgYlFKhDB9RivY7nlSxBmzU6SLRcA0BkGIt6Z5ZZE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA0PR12MB8747.namprd12.prod.outlook.com (2603:10b6:208:48b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 20:11:16 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 20:11:16 +0000
Message-ID: <d8259097-3ccb-4989-aa1e-6b5c564240f5@amd.com>
Date: Wed, 21 Aug 2024 15:11:11 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v6 22/22] x86/resctrl: Introduce interface to modify
 assignment states of the groups
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1722981659.git.babu.moger@amd.com>
 <30a946c5ec042e66db675e9e57fe2cff971f570e.1722981659.git.babu.moger@amd.com>
 <d4873add-ac24-47dd-be45-28af3698c334@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <d4873add-ac24-47dd-be45-28af3698c334@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0023.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::36) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA0PR12MB8747:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ab95383-415f-4ad6-bc40-08dcc21d6980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cnUzcVhBSk55OFdCZ3B6RURsRGhOZ0FoNVJNbGtRYVRobkh0VWZRaE9CUzQw?=
 =?utf-8?B?TTVhUWpTU0JKdk1halVyNnFvbUVXOWtzaUFMMjF5aHh0T3F4eWhkNmdid1lQ?=
 =?utf-8?B?SzNIa1NzZGJIdmtCSGN5ZjRZcGtBbTBDcFVGQksrb3hyQUZFM2k0bFJkaUwx?=
 =?utf-8?B?OG85UGRjZ09uTzdabVZJVDZIQ1NmWEV0Qll4UjViVzkya0cyZER5ZVFLSU0v?=
 =?utf-8?B?WnJFcnRLR2Z5Q0dJa1VnRlQ3NlVOYXVJWkc4NzVjUXo5dWNoUEc1azVuaWlC?=
 =?utf-8?B?cU0venQ5RVg5VkxqRWpWRjFLeFlTT2FjVHl6SkpqckFPQ1JQMmZ4blkzcXNH?=
 =?utf-8?B?Ylp6OEdWQ0lZaUowekVnSVdVYXNNaC96S0grVVIvY0hMSUY4Um5VL0RGa2gw?=
 =?utf-8?B?MnRBZmZxeS95UEYwNStRQk9wbDB3TDRhMWd1KysyRHc4SXAzcTFVOHczemZq?=
 =?utf-8?B?Q3J2VDExVWoycXYzNlZIWnVuY3NwVXl6aG9iT3g1RWhKVEZ2TnowaVljWU4x?=
 =?utf-8?B?dVgyZXd6L05vT3BOOENJK1ptNWdjcWV0bVZSem9sMHZPNFJtUmpSNEtYV2cy?=
 =?utf-8?B?YzZYVHVwZG5ETWF1VkdCYXRpRTZvNTdJS0JnM051WDRELzVNU0UvWEJTSzFp?=
 =?utf-8?B?aklhSW4yOE1rU0ZheGJkelV5YzdYVFhEbE9kSUpseDFKbk42UTkvclM0VVk5?=
 =?utf-8?B?YmYraGpNTjdsNEJFQTlvOENic2pSVHZlejROUzZZS1poWmxiSWd2cEQ5QXZk?=
 =?utf-8?B?VEgrQkNnQWo3SnJWQ3ZLNFMwR0Ztc3pSa291clU3VEgvYWRpdUFPeVBsR3Nn?=
 =?utf-8?B?L1RLc0puc2F5OHliNVFzSkhqSmdNbzhXaUVqcTFMZnJSZG01eTJOTFNkL05N?=
 =?utf-8?B?Z3ErUGJDaHc4TUFMRlpmRGNRYUtuNWhtMDNqMWZCaWZVdU4rMzZ4c0ZOVXBZ?=
 =?utf-8?B?VWI4eXdXc1VGcjFNdDVYek1JYTJPZmMwamZMZzRhRnEvZlVMR05FZXprU0xC?=
 =?utf-8?B?ZzcyTjBqYVZ3SzJiRGJyVHN1UlBTMUZNYjR2Z3VuZ2ZGZ1hKSndibUp1eTd3?=
 =?utf-8?B?aUt2K3Z5eVdVZ3NBbVRrd0xaL0dFc2Y3Y2p1VndhN080M09icTRldE1TLzZt?=
 =?utf-8?B?UldkT0draG5hckxsTDdwOXB2d05yRzdYOU9RamdMZTRqNk1ta3BNZVdyNFdp?=
 =?utf-8?B?SFFwR2x0cm92QUY3UHNYSVM4SXJPL2xDT0lSMkVHbTI5bzJ5b2FnbzNnSHc1?=
 =?utf-8?B?U3FnTS80ZGtIbkZnZDZPeUljSTh6U1RUa3YrRDlESk9vVmE4aXp1ZVFxbEk5?=
 =?utf-8?B?UnUzRzBINUVlYjZwNzh6SENUeU16Vm9BSk1sTUZRY2ljZ3lzQUR2NmRQVVVp?=
 =?utf-8?B?cytLVmw0bDNyUnN4aVE5SVp5R2NPRFlWTTM0bEhJQ1QycUswRGFHejZML0hZ?=
 =?utf-8?B?VHVIRXM5UU9EZS9WSUJ1emRvZDdJWFUwUjc0Y2lka2FUK25IZE1ERDF6TEQz?=
 =?utf-8?B?VXVTR0YwVC9JclFrTDdpRXFGRStWYXJ0WUpaYUpNbzFEVzNUTlJaMHkzV0F3?=
 =?utf-8?B?YlhZZ2F3Nk5NZVVNRks4NFpzZFNaZWpxcFowR25NSlB2RGUzOWVsMlFqMGVC?=
 =?utf-8?B?VGxaRXZUaWxSQU9vQ0FrQW9OT0ZESUdLLzBPNEZsS3EwOFpRWjF6d1Q0b3U5?=
 =?utf-8?B?NDQ5djNKTzFIclpveHRvZDRYMFdHWWlPRG5UR3BmQW1xM0s3OThJbXlvaVYv?=
 =?utf-8?Q?VNiMgtrqoUm2vQKav0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDFOazJXRFBhc0xsM3g1Y1BUVDIxZzVNZHBObmQveWdFQm9SVmNpZzZxWVh3?=
 =?utf-8?B?cy9JQ1h6WkRLUG5oQkpwUGp4SHRLOWpsOVlnNTAzQlExSXg5RFc4cGZFZVpk?=
 =?utf-8?B?RGJDOHErM25GY25SY2VmczNQQkd0ZzI2VWxsaHRYbzJuSEttSE5DTUVLK284?=
 =?utf-8?B?aVJZTXBUS1c5SG1MZFpFL1FVbTdtMUppUE94YzZzRkdKb1g4MzJEbUNPa1NB?=
 =?utf-8?B?RktGb1FhYVNydkFTc1JMWUdJRkNzdThCQTNLVnRLK3BMWWRROHZlTXVZVE9y?=
 =?utf-8?B?R0s1VjRHYVpOdFhKMzNxeEhXdlEySi9UVFJsQVNwUGM4NFNzZXJIWk1mMkxN?=
 =?utf-8?B?MW5Ld0FURHl6R1FsTGp1bkVlODlkL0h5YWNQVnUzbWxHbFZHTGNQUzZremNh?=
 =?utf-8?B?WGZvclIwZEt1dlNhT002dGxGNWdtL2p2bndqZzZZdG5kdi82ckxrVkUrbUVu?=
 =?utf-8?B?VXh3aVVVb3pSenh2NVhueWIyZDcxOWtNSExTWXdZSVBqVmxJRjg1UXFjODdB?=
 =?utf-8?B?elBJOXVUOGZ3RnpYM2YweFQ2YUF2YzNaVGtIOTg5Zkoyekp5QUtxTytHMGF5?=
 =?utf-8?B?TmZkaHhUaWVwNHcwb1JSK3o4dW1zZ0J4ZjdDdjVEYVQ3cEdDM1BJenMyRVhz?=
 =?utf-8?B?K0d5TXdWZHA0Tmx0RGo1aEx1MUNiaEVvb1gvckovWndLTkdjYU9ZbzJWbHFu?=
 =?utf-8?B?bU96czB1c1BlRnZxaGRpOVJlbjhiRXprRDRkWVdDYlVEdmVLUjZjYmhVaEZT?=
 =?utf-8?B?OFRaWjhJUm5hSVlmZ0t5NktKWU9URVBOeTlQZXJjaXlmWUxqWXY1T3o5dWt3?=
 =?utf-8?B?QSs4aDdBK2VMR2dSbjVjUUFEL2FKTTRUa3BmRW1naDQ2R0N0ZnlvclI2ZWFT?=
 =?utf-8?B?OGhtajE2Y3NOUDFMdWU1WFBPOHBQY0h4L0dGOEV6dmo0K2VoSlNCejF3V1FY?=
 =?utf-8?B?VGhDUVJjdGl0by9qRitEb0NhRm40T2N4SGZxOWlIUk42NGxwUkV2djJtM2p1?=
 =?utf-8?B?Vmw2THM3VVI4MUZnOVRydEtlRTd2d1A2QkxSaCtneUVjQUdIMlBidEc1ZDBy?=
 =?utf-8?B?TktUMnNnYUdtR2hNM3JoSXVwTllISHRNeHcyc0V5Ukl5MnMva1JqZjhTSFc2?=
 =?utf-8?B?NmNlQmd5ZzV0bEJIM3N4QWVTbTZ0NExvcHNXdGlsekxBSmVDbHhPejgrbUhM?=
 =?utf-8?B?UFQxNlFtWWh2c1U3aVBZU010U2NMa2tqa2daRzA4TExueHBmVEJSZncrYVNu?=
 =?utf-8?B?QnptRWVQenV3QUJyUmNtd25uNTN3QklwdFYxbWhqd01pcUNQb0I3NkNXVS9U?=
 =?utf-8?B?bEdNMmFGdFdwUmhqbEs2d3pMYy9xUm5icTZhUjRFamRRQm13RHlFdVpFUW5z?=
 =?utf-8?B?aUg3Qll6QWxnVlFnYzY1MDRZeWYvNzZ0dzMxaUcvYmwwSVpOQ0s4R1oxUWxq?=
 =?utf-8?B?aFNOY296L1NXa1ovcW1lVDlHNjJtTStrNjZWMjBESnVFYi9CRDRId1RxMXZX?=
 =?utf-8?B?eFNPd0FibXhQeVlaQStyTHBQejMxS0lZMVhpY25QTHhwTHRqTE1aeFZJRS9H?=
 =?utf-8?B?NDNOUG82MlQwRGRlbWhyVWVOQW1GaTRER3BEWHRVRnBqM0xxMWZOSUhYWWRY?=
 =?utf-8?B?Z1Z0SkRvcmNUcHZ1VGxIRTBVZ2NaSW5OeHpSWlF5L3RhSm51cTFCN2xGMEEy?=
 =?utf-8?B?MUY4TU8wQnJvYmd1Wmw0eWtkemxqTmd5bzgzMURlSkNkQ3FmT0FwVkZoaFpI?=
 =?utf-8?B?eXRGeHZjQm93bzE0QlpQMkRuMmhCVklWbnF5SmNnbk9Sc00vSVhtOTBjS21M?=
 =?utf-8?B?QUM0N2NGbmZjalozYlVyQVRYcERCL2czRFlEZTBIb1RWL0dPd2NqTm03RTE0?=
 =?utf-8?B?clZnNGFoWVlkeWFyQ2VFQ0RlclN4MERIVXRVVG9tYjRubGpReWxTV3E3MndQ?=
 =?utf-8?B?OUdQOGY2eDZUS3hHRHplM3Y5Tk9LSGYzNkdWSEtXK2MxbXY1RmgyekR5a0Z1?=
 =?utf-8?B?MFR6bGIvZEhUMXd6R2FVbEhJbTlWcWtkRjk1TWFBMGhDOVhjMDJ3YkRONkJO?=
 =?utf-8?B?SVNUY05SREIrS3JSZTE2eE9nc3BkdTJKZkkvajhRNmpTMU1DQlBBdFQ2dlA2?=
 =?utf-8?Q?10rs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab95383-415f-4ad6-bc40-08dcc21d6980
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 20:11:16.1030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OnMxsFPzDxLX6qEwQOXNYLCnboXrfDv9ImRHIFduqNOVZ8Nos1MkieuO5mPRCaus
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8747

Hi Reinette,

On 8/16/24 17:33, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/6/24 3:00 PM, Babu Moger wrote:
>> Introduce the interface to assign MBM events in ABMC mode.
>>
>> Events can be enabled or disabled by writing to file
>> /sys/fs/resctrl/info/L3_MON/mbm_control
>>
>> Format is similar to the list format with addition of opcode for the
>> assignment operation.
>>   "<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
>>
>> Format for specific type of groups:
>>
>>   * Default CTRL_MON group:
>>           "//<domain_id><opcode><flags>"
>>
>>   * Non-default CTRL_MON group:
>>           "<CTRL_MON group>//<domain_id><opcode><flags>"
>>
>>   * Child MON group of default CTRL_MON group:
>>           "/<MON group>/<domain_id><opcode><flags>"
>>
>>   * Child MON group of non-default CTRL_MON group:
>>           "<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
>>
>> Domain_id '*' will apply the flags on all the domains.
>>
>> Opcode can be one of the following:
>>
>>   = Update the assignment to match the flags
>>   + assign a MBM event
>>   - unassign a MBM event
>>
>> Assignment flags can be one of the following:
>>   t  MBM total event
>>   l  MBM local event
>>   tl Both total and local MBM events
>>   _  None of the MBM events. Valid only with '=' opcode.
> 
> (please note comments in this area of cover letter)

Ok. Yes. Will test differrent cobminations of flags(like _lt etc..).

> 
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v6: Added support assign all if domain id is '*'
>>      Fixed the allocation of counter id if it not assigned already.
>>
>> v5: Interface name changed from mbm_assign_control to mbm_control.
>>      Fixed opcode and flags combination.
>>      '=_" is valid.
>>      "-_" amd "+_" is not valid.
>>      Minor message update.
>>      Renamed the function with prefix - rdtgroup_.
>>      Corrected few documentation mistakes.
>>      Rebase related changes after SNC support.
>>
>> v4: Added domain specific assignments. Fixed the opcode parsing.
>>
>> v3: New patch.
>>      Addresses the feedback to provide the global assignment interface.
>>     
>> https://lore.kernel.org/lkml/c73f444b-83a1-4e9a-95d3-54c5165ee782@intel.com/
>> ---
>>   Documentation/arch/x86/resctrl.rst     |  94 +++++++-
>>   arch/x86/kernel/cpu/resctrl/internal.h |   7 +
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 315 ++++++++++++++++++++++++-
>>   3 files changed, 414 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/arch/x86/resctrl.rst
>> b/Documentation/arch/x86/resctrl.rst
>> index 113c22ba6db3..ae3b17b7cefe 100644
>> --- a/Documentation/arch/x86/resctrl.rst
>> +++ b/Documentation/arch/x86/resctrl.rst
>> @@ -346,7 +346,7 @@ with the following files:
>>        t  MBM total event is enabled.
>>        l  MBM local event is enabled.
>>        tl Both total and local MBM events are enabled.
>> -     _  None of the MBM events are enabled.
>> +     _  None of the MBM events are enabled. Only works with opcode '='
>> for write.
>>         Examples:
>>       ::
>> @@ -365,6 +365,98 @@ with the following files:
>>        enabled on domain 0 and 1.
>>     +    Assignment state can be updated by writing to the interface.
>> +
>> +    Format is similar to the list format with addition of opcode for the
>> +    assignment operation.
>> +
>> +        "<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
>> +
>> +    Format for each type of groups:
>> +
>> +        * Default CTRL_MON group:
>> +                "//<domain_id><opcode><flags>"
>> +
>> +        * Non-default CTRL_MON group:
>> +                "<CTRL_MON group>//<domain_id><opcode><flags>"
>> +
>> +        * Child MON group of default CTRL_MON group:
>> +                "/<MON group>/<domain_id><opcode><flags>"
>> +
>> +        * Child MON group of non-default CTRL_MON group:
>> +                "<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
>> +
>> +    Domain_id '*' wil apply the flags on all the domains.
>> +
>> +    Opcode can be one of the following:
>> +    ::
>> +
>> +     = Update the assignment to match the MBM event.
>> +     + Assign a MBM event.
> 
> "Assign a new MBM event without impacting existing assignments."?

Sure.
> 
>> +     - Unassign a MBM event.
> 
> (similar)

Sure.

> 
>> +
>> +    Examples:
>> +    ::
>> +
>> +      Initial group status:
>> +      # cat /sys/fs/resctrl/info/L3_MON/mbm_control
>> +      non_default_ctrl_mon_grp//0=tl;1=tl;
>> +      non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
>> +      //0=tl;1=tl;
>> +      /child_default_mon_grp/0=tl;1=tl;
>> +
>> +      To update the default group to assign only total MBM event on
>> domain 0:
>> +      # echo "//0=t" > /sys/fs/resctrl/info/L3_MON/mbm_control
>> +
>> +      Assignment status after the update:
>> +      # cat /sys/fs/resctrl/info/L3_MON/mbm_control
>> +      non_default_ctrl_mon_grp//0=tl;1=tl;
>> +      non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
>> +      //0=t;1=tl;
>> +      /child_default_mon_grp/0=tl;1=tl;
>> +
>> +      To update the MON group child_default_mon_grp to remove total MBM
>> event on domain 1:
>> +      # echo "/child_default_mon_grp/1-t" >
>> /sys/fs/resctrl/info/L3_MON/mbm_control
>> +
>> +      Assignment status after the update:
>> +      $ cat /sys/fs/resctrl/info/L3_MON/mbm_control
>> +      non_default_ctrl_mon_grp//0=tl;1=tl;
>> +      non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
>> +      //0=t;1=tl;
>> +      /child_default_mon_grp/0=tl;1=l;
>> +
>> +      To update the MON group
>> non_default_ctrl_mon_grp/child_non_default_mon_grp to
>> +      unassign both local and total MBM events on domain 1:
>> +      # echo "non_default_ctrl_mon_grp/child_non_default_mon_grp/1=_" >
>> +            /sys/fs/resctrl/info/L3_MON/mbm_control
>> +
>> +      Assignment status after the update:
>> +      non_default_ctrl_mon_grp//0=tl;1=tl;
>> +      non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
>> +      //0=t;1=tl;
>> +      /child_default_mon_grp/0=tl;1=l;
>> +
>> +      To update the default group to add a local MBM event domain 0.
>> +      # echo "//0+l" > /sys/fs/resctrl/info/L3_MON/mbm_control
>> +
>> +      Assignment status after the update:
>> +      # cat /sys/fs/resctrl/info/L3_MON/mbm_control
>> +      non_default_ctrl_mon_grp//0=tl;1=tl;
>> +      non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
>> +      //0=tl;1=tl;
>> +      /child_default_mon_grp/0=tl;1=l;
>> +
>> +      To update the non default CTRL_MON group non_default_ctrl_mon_grp
>> to unassign all
>> +      the MBM events on all the domains.
>> +      # echo "non_default_ctrl_mon_grp//*=_" >
>> /sys/fs/resctrl/info/L3_MON/mbm_control
>> +
>> +      Assignment status after the update:
>> +      #cat /sys/fs/resctrl/info/L3_MON/mbm_control
>> +      non_default_ctrl_mon_grp//0=_;1=_;
>> +      non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
>> +      //0=tl;1=tl;
>> +      /child_default_mon_grp/0=tl;1=l;
>> +
>>   "max_threshold_occupancy":
>>           Read/write file provides the largest value (in
>>           bytes) at which a previously used LLC_occupancy
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
>> b/arch/x86/kernel/cpu/resctrl/internal.h
>> index ba3012f8f940..5af225b4a497 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -46,6 +46,13 @@
>>     #define MON_CNTR_UNSET            U32_MAX
>>   +/*
>> + * Assignment flags for ABMC feature
> 
> (this is resctrl fs code)

Ok.

> 
>> + */
>> +#define ASSIGN_NONE            0
>> +#define ASSIGN_TOTAL            BIT(QOS_L3_MBM_TOTAL_EVENT_ID)
>> +#define ASSIGN_LOCAL            BIT(QOS_L3_MBM_LOCAL_EVENT_ID)
>> +
>>   /**
>>    * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring
>> those that
>>    *                    aren't marked nohz_full
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index d7aadca5e4ab..8567fb3a6274 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -1034,6 +1034,318 @@ static int rdtgroup_mbm_control_show(struct
>> kernfs_open_file *of,
>>       return 0;
>>   }
>>   +/*
>> + * Update the assign states for the domain.
>> + *
>> + * If this is a new assignment for the group then allocate a counter
>> and update
>> + * the assignment else just update the assign state
>> + */
>> +static int rdtgroup_assign_update(struct rdtgroup *rdtgrp, enum
>> resctrl_event_id evtid,
>> +                  struct rdt_mon_domain *d)
>> +{
>> +    int ret, index;
>> +
>> +    index = mon_event_config_index_get(evtid);
>> +    if (index == INVALID_CONFIG_INDEX)
>> +                return -EINVAL;
> 
> (wrong spacing ... see checkpatch.pl)

ok

> 
>> +
>> +    if (rdtgrp->mon.cntr_id[index] == MON_CNTR_UNSET) {
>> +        ret = rdtgroup_alloc_cntr(rdtgrp, index);
>> +        if (ret < 0)
>> +            goto out_done;
>> +    }
>> +
>> +    /* Update the state on all domains if d == NULL */
>> +    if (d == NULL) {
> 
> if (!d) ... (checkpatch)

ok.

> 
>> +        ret = rdtgroup_assign_cntr(rdtgrp, evtid);
>> +    } else {
>> +        ret = resctrl_arch_assign_cntr(d, evtid, rdtgrp->mon.rmid,
>> +                           rdtgrp->mon.cntr_id[index],
>> +                           rdtgrp->closid, 1);
>> +        if (!ret)
>> +            set_bit(rdtgrp->mon.cntr_id[index], d->mbm_cntr_map);
>> +    }
>> +
>> +out_done:
>> +    return ret;
>> +}
> 
> Please merge this with almost identical rdtgroup_assign_cntr()

Yes. Sure.

> 
>> +
>> +/*
>> + * Update the unassign state for the domain.
>> + *
>> + * Free the counter if it is unassigned on all the domains else just
>> + * update the unassign state
>> + */
>> +static int rdtgroup_unassign_update(struct rdtgroup *rdtgrp, enum
>> resctrl_event_id evtid,
>> +                    struct rdt_mon_domain *d)
>> +{
>> +    struct rdt_resource *r =
>> &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>> +    int ret = 0, index;
>> +
>> +    index = mon_event_config_index_get(evtid);
>> +    if (index == INVALID_CONFIG_INDEX)
>> +                return -EINVAL;
> 
> (wrong spacing ... see checkpatch.pl)

Sure.

> 
>> +
>> +    if (rdtgrp->mon.cntr_id[index] == MON_CNTR_UNSET)
>> +        goto out_done;
>> +
>> +    if (d == NULL) {
> 
> if (!d)
> 
>> +        ret = rdtgroup_unassign_cntr(rdtgrp, evtid);
>> +    } else {
>> +        ret = resctrl_arch_assign_cntr(d, evtid, rdtgrp->mon.rmid,
>> +                           rdtgrp->mon.cntr_id[index],
>> +                           rdtgrp->closid, 0);
>> +        if (!ret) {
>> +            clear_bit(rdtgrp->mon.cntr_id[index], d->mbm_cntr_map);
>> +            rdtgroup_free_cntr(r, rdtgrp, index);
>> +        }
>> +    }
>> +
>> +out_done:
>> +    return ret;
>> +}
> 
> Please merge this with almost identical rdtgroup_unassign_cntr()

Sure.

> 
>> +
>> +static int rdtgroup_str_to_mon_state(char *flag)
>> +{
>> +    int i, mon_state = 0;
>> +
>> +    for (i = 0; i < strlen(flag); i++) {
>> +        switch (*(flag + i)) {
>> +        case 't':
>> +            mon_state |= ASSIGN_TOTAL;
>> +            break;
>> +        case 'l':
>> +            mon_state |= ASSIGN_LOCAL;
>> +            break;
>> +        case '_':
>> +            mon_state = ASSIGN_NONE;
>> +            break;
> 
> It looks like this supports flags like "_lt", treating it as assigning
> both local and total. I expect this should remove all flags instead?

This is a cobination of flags.
"_lt"  This will assign both local and total.
"lt_"  This with remove both the flags.

It seems alright to me. Do you want me to change the bahaviour here?


> 
>> +        default:
>> +            break;
>> +        }
>> +    }
>> +
>> +    return mon_state;
>> +}
> 
> hmmm ... so you removed assigning mon_state to ASSIGN_NONE from default,
> but that did not change what this function returns since ASSIGN_NONE is 0
> and mon_state is initialized to 0. Unknown flags should cause error so
> that it is possible to add flags in the future. Above prevents us from
> ever adding new flags.

May be I am missing something here. How about this?

enum {
        ASSIGN_NONE = 0,
        ASSIGN_TOTAL,
        ASSIGN_LOCAL,
        ASSIGN_INVALID,
};


static int rdtgroup_str_to_mon_state(char *flag)
{
        int i, mon_state = ASSIGN_NONE;

        for (i = 0; i < strlen(flag); i++) {
                switch (*(flag + i)) {
                case 't':
                        mon_state |= ASSIGN_TOTAL;
                        break;
                case 'l':
                        mon_state |= ASSIGN_LOCAL;
                        break;
                case '_':
                        mon_state = ASSIGN_NONE;
                        break;
                default:
			mon_state = ASSIGN_INVALID;
                        goto out_done;
               }
        }

:out_done:
        return mon_state;
}

Then handle the ASSIGN_INVALID from the caller.  Is that what you think?

> 
>> +
>> +static struct rdtgroup *rdtgroup_find_grp(enum rdt_group_type rtype,
>> char *p_grp, char *c_grp)
> 
> rdtgroup_find_grp() -> rdtgroup_find_grp_by_name()?
> 
>> +{
>> +    struct rdtgroup *rdtg, *crg;
>> +
>> +    if (rtype == RDTCTRL_GROUP && *p_grp == '\0') {
>> +        return &rdtgroup_default;
>> +    } else if (rtype == RDTCTRL_GROUP) {
>> +        list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list)
>> +            if (!strcmp(p_grp, rdtg->kn->name))
>> +                return rdtg;
>> +    } else if (rtype == RDTMON_GROUP) {
>> +        list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
>> +            if (!strcmp(p_grp, rdtg->kn->name)) {
>> +                list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
>> +                            mon.crdtgrp_list) {
>> +                    if (!strcmp(c_grp, crg->kn->name))
>> +                        return crg;
>> +                }
>> +            }
>> +        }
>> +    }
>> +
>> +    return NULL;
>> +}
>> +
>> +static int rdtgroup_process_flags(struct rdt_resource *r,
>> +                  enum rdt_group_type rtype,
>> +                  char *p_grp, char *c_grp, char *tok)
>> +{
>> +    int op, mon_state, assign_state, unassign_state;
>> +    char *dom_str, *id_str, *op_str;
>> +    struct rdt_mon_domain *d;
>> +    struct rdtgroup *rdtgrp;
>> +    unsigned long dom_id;
>> +    int ret, found = 0;
>> +
>> +    rdtgrp = rdtgroup_find_grp(rtype, p_grp, c_grp);
>> +
>> +    if (!rdtgrp) {
>> +        rdt_last_cmd_puts("Not a valid resctrl group\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +next:
>> +    if (!tok || tok[0] == '\0')
>> +        return 0;
>> +
>> +    /* Start processing the strings for each domain */
>> +    dom_str = strim(strsep(&tok, ";"));
>> +
>> +    op_str = strpbrk(dom_str, "=+-");
>> +
>> +    if (op_str) {
>> +        op = *op_str;
>> +    } else {
>> +        rdt_last_cmd_puts("Missing operation =, +, -, _ character\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    id_str = strsep(&dom_str, "=+-");
>> +
>> +    /* Check for domain id '*' which means all domains */
>> +    if (id_str && *id_str == '*') {
>> +        d = NULL;
>> +        goto check_state;
>> +    } else if (!id_str || kstrtoul(id_str, 10, &dom_id)) {
>> +        rdt_last_cmd_puts("Missing domain id\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    /* Verify if the dom_id is valid */
>> +    list_for_each_entry(d, &r->mon_domains, hdr.list) {
>> +        if (d->hdr.id == dom_id) {
>> +            found = 1;
>> +            break;
>> +        }
>> +    }
>> +
>> +    if (!found) {
>> +        rdt_last_cmd_printf("Invalid domain id %ld\n", dom_id);
>> +        return -EINVAL;
>> +    }
>> +
>> +check_state:
>> +    mon_state = rdtgroup_str_to_mon_state(dom_str);
> 
> Function should return error and exit here.

No. This is case to skip checking for domain when '*' is passed to apply
assignment to all the domains.

> 
>> +
>> +    assign_state = 0;
>> +    unassign_state = 0;
>> +
>> +    switch (op) {
>> +    case '+':
>> +        if (mon_state == ASSIGN_NONE) {
>> +            rdt_last_cmd_puts("Invalid assign opcode\n");
>> +            goto out_fail;
>> +        }
>> +        assign_state = mon_state;
>> +        break;
>> +    case '-':
>> +        if (mon_state == ASSIGN_NONE) {
>> +            rdt_last_cmd_puts("Invalid assign opcode\n");
>> +            goto out_fail;
>> +        }
>> +        unassign_state = mon_state;
>> +        break;
>> +    case '=':
>> +        assign_state = mon_state;
>> +        unassign_state = (ASSIGN_TOTAL | ASSIGN_LOCAL) & ~assign_state;
>> +        break;
>> +    default:
>> +        break;
>> +    }
>> +
>> +    if (assign_state & ASSIGN_TOTAL) {
>> +        ret = rdtgroup_assign_update(rdtgrp, QOS_L3_MBM_TOTAL_EVENT_ID,
>> d);
>> +        if (ret)
>> +            goto out_fail;
>> +    }
> 
> Should unassign occur before assign so that unassign can make counters
> available for
> assign that follows?

Yes. It works. Just tested it.

> 
>> +
>> +    if (assign_state & ASSIGN_LOCAL) {
>> +        ret = rdtgroup_assign_update(rdtgrp, QOS_L3_MBM_LOCAL_EVENT_ID,
>> d);
>> +        if (ret)
>> +            goto out_fail;
>> +    }
>> +
>> +    if (unassign_state & ASSIGN_TOTAL) {
>> +        ret = rdtgroup_unassign_update(rdtgrp,
>> QOS_L3_MBM_TOTAL_EVENT_ID, d);
>> +        if (ret)
>> +            goto out_fail;
>> +    }
>> +
>> +    if (unassign_state & ASSIGN_LOCAL) {
>> +        ret = rdtgroup_unassign_update(rdtgrp,
>> QOS_L3_MBM_LOCAL_EVENT_ID, d);
>> +        if (ret)
>> +            goto out_fail;
>> +    }
>> +
>> +    goto next;
>> +
>> +out_fail:
>> +
>> +    return -EINVAL;
>> +}
>> +
>> +static ssize_t rdtgroup_mbm_control_write(struct kernfs_open_file *of,
>> +                      char *buf, size_t nbytes,
>> +                      loff_t off)
>> +{
>> +    struct rdt_resource *r = of->kn->parent->priv;
>> +    char *token, *cmon_grp, *mon_grp;
>> +    int ret;
>> +
>> +    if (!resctrl_arch_get_abmc_enabled())
>> +        return -EINVAL;
> 
> This needs to be protected by mutex.

Sure.

> 
>> +
>> +    /* Valid input requires a trailing newline */
>> +    if (nbytes == 0 || buf[nbytes - 1] != '\n')
>> +        return -EINVAL;
>> +
>> +    buf[nbytes - 1] = '\0';
>> +
>> +    cpus_read_lock();
>> +    mutex_lock(&rdtgroup_mutex);
>> +    rdt_last_cmd_clear();
>> +
>> +    while ((token = strsep(&buf, "\n")) != NULL) {
>> +        if (strstr(token, "//")) {
>> +            /*
>> +             * The CTRL_MON group processing:
>> +             * default CTRL_MON group: "//<flags>"
>> +             * non-default CTRL_MON group: "<CTRL_MON group>//flags"
>> +             * The CTRL_MON group will be empty string if it is a
>> +             * default group.
>> +             */
>> +            cmon_grp = strsep(&token, "//");
>> +
>> +            /*
>> +             * strsep returns empty string for contiguous delimiters.
>> +             * Make sure check for two consecutive delimiters and
>> +             * advance the token.
>> +             */
>> +            mon_grp = strsep(&token, "//");
>> +            if (*mon_grp != '\0') {
>> +                rdt_last_cmd_printf("Invalid CTRL_MON group format
>> %s\n", token);
>> +                ret = -EINVAL;
>> +                break;
>> +            }
>> +
>> +            ret = rdtgroup_process_flags(r, RDTCTRL_GROUP, cmon_grp,
>> mon_grp, token);
>> +            if (ret)
>> +                break;
>> +        } else if (strstr(token, "/")) {
>> +            /*
>> +             * MON group processing:
>> +             * MON_GROUP inside default CTRL_MON group: "/<MON
>> group>/<flags>"
>> +             * MON_GROUP within CTRL_MON group: "<CTRL_MON group>/<MON
>> group>/<flags>"
>> +             */
>> +            cmon_grp = strsep(&token, "/");
> 
> Isn't strsep(&token, "//") the same as strsep(&token, "/")? It looks like
> these two big branches
> can be merged.

Sure. Will check this.

> 
>> +
>> +            /* Extract the MON_GROUP. It cannot be empty string */
>> +            mon_grp = strsep(&token, "/");
>> +            if (*mon_grp == '\0') {
>> +                rdt_last_cmd_printf("Invalid MON_GROUP format %s\n",
>> token);
>> +                ret = -EINVAL;
>> +                break;
>> +            }
>> +
>> +            ret = rdtgroup_process_flags(r, RDTMON_GROUP, cmon_grp,
>> mon_grp, token);
>> +            if (ret)
>> +                break;
>> +        }
>> +    }
>> +
>> +    mutex_unlock(&rdtgroup_mutex);
>> +    cpus_read_unlock();
>> +
>> +    return ret ?: nbytes;
>> +}
>> +
>>   #ifdef CONFIG_PROC_CPU_RESCTRL
>>     /*
>> @@ -2277,9 +2589,10 @@ static struct rftype res_common_files[] = {
>>       },
>>       {
>>           .name        = "mbm_control",
>> -        .mode        = 0444,
>> +        .mode        = 0644,
>>           .kf_ops        = &rdtgroup_kf_single_ops,
>>           .seq_show    = rdtgroup_mbm_control_show,
>> +        .write        = rdtgroup_mbm_control_write,
>>       },
>>       {
>>           .name        = "cpus_list",
> 
> Reinette
> 

-- 
Thanks
Babu Moger

