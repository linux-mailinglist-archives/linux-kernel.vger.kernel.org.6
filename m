Return-Path: <linux-kernel+bounces-442667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6769EE009
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F206A188411B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 07:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38CE209F43;
	Thu, 12 Dec 2024 07:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hg82EHMi"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9CC13BADF;
	Thu, 12 Dec 2024 07:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733987572; cv=fail; b=fJlM/yU/d79dRgFJTqtEJusIdUd27Yz3PFm+inRGBuwleTeSdsLvUOqZ31qtq1xxKKx2K749R0SfUURFnsjUd4ul12DLqhOuFUx2YzyJUlB9GxJTex9cxmLe7H6kWa2292rs9mVV9/5CTz4uh3GM9Xn3OfSfzfM4ke5iTOSm22I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733987572; c=relaxed/simple;
	bh=xd72HBKhWY0j1XLT27y+fO7ZCStBnD6pfVWVqyFYsC4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VqcambSHfXJyUyK6NA4CiE8Nin5jLrTXGOdzb8Wqzg276g8FiBfpvJ0pLYZhwURkNKJ7eoAD3rDTCxlRv8kWpjskZKPA7sEQ1f7ai0stMhLYm7pLZvHDgVdOdJujNjzCOj9AyXmvIQKO1DyQ6FE8flgkxCC7P1IX+tA+FRWL5WY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hg82EHMi; arc=fail smtp.client-ip=40.107.95.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rGKgIwN5EDWG00r1hIEe+DG5WKn7binbhwKo7qA0ZDuyd96220sTC+seIUxW1TA0PJ8uX1I2/chFxYGNOuB7tvbhU6ADqAfu7UJUMi4ONC6ZSRJpjj+f+OCeyW5vgGcAsFI/UKWhEdQZ1KAKSV9KUsja+ssczJvWlEZ0adxhkavoJOBY2GFKVth/S8DuoNVB9N9amrEjfeAZbtsi3qsN1cupKtytlHXFtCKq7a2OmGrELEo2rEl3D8hdCid/8FUcs4G3c2b2BEnDU4PsH4Moa7WQyjlFTTFu/g+ELDpdMEnuSCMwyvwVEXCPR0ispWi++FB1SVGFZtwMiYS0FYcBqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOZQhLxfwLKyiN/87mSIGoz/thge2aQc4kb6bTHZJIQ=;
 b=ScZ8o1fH2Mscpp1Tr7OG+FxPT4g5Kwav46/7Vz9E8ZkIbwMnz46Ev6P5j90WYRHAkoSfUpDAGh+Xqu5CNV2fBogYHpog2UkYBspVb5UhN5yDFScUUecLPtq/gBCuLiXRVdUkOk8qdQ+qvmBDcnWC9POZoVqf+A63S3ZyErgwKrn6d5PJsGXG2mINH7YULFsyLvkyNDT+sEhOkQjxRLRRTi2te6jtWHBe13HatGGKtlT5a1QIgfTadJ1Lgqq1NXLm0C9v7FJ8tVdLaSXr3D0XrH+a3xAfyaehEEkn2y1Qm45Uq4SP+rK7st56+A6yL7C9ssE08h2whfwUXFBDbacoLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOZQhLxfwLKyiN/87mSIGoz/thge2aQc4kb6bTHZJIQ=;
 b=hg82EHMi2TnJ4S54pTnVdsFHAIvzZYeuqqaboCySsOEochUrOwlEeurfVXw2Iti4XrHthJJ8b35PMxfokGhitPFj+iwmFkzOpdi2eWpMRNQcoKvIso55RzQ9EpZeN8YDlmiXTewVabZc6QcswCmReS2tZxSSKY9uqTiRv9fMUew=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM4PR12MB8449.namprd12.prod.outlook.com (2603:10b6:8:17f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 07:12:46 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.8230.016; Thu, 12 Dec 2024
 07:12:46 +0000
Message-ID: <0335793c-4606-43dd-b1ab-8f67785f5629@amd.com>
Date: Thu, 12 Dec 2024 08:12:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/15] ARM: zynq: Sync DTs with U-Boot
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: "moderated list:ARM/ZYNQ ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, michal.simek@xilinx.com, monstr@monstr.eu,
 git@xilinx.com
References: <cover.1733920873.git.michal.simek@amd.com>
 <173393224728.3091150.11085112233542602601.robh@kernel.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <173393224728.3091150.11085112233542602601.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0212.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::33) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM4PR12MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: 76e4596d-936a-4c4c-421c-08dd1a7c6103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1ZJYkdlOUYxemdWT2JrNXBoSEdabGM1T1dZbEpQZEZzaEFqTWRhWm9oeE12?=
 =?utf-8?B?UEtJZnlScmxuQmJNRGFGMG1LSVU2SThxV3dxcjh6MTZtK3d6YkM3UkZoUGRO?=
 =?utf-8?B?bEV1NXJaeDZ3MmUvME9HalpzUFZ5TlAyb255MEVqbFBYTjlqNk85TXExNzFL?=
 =?utf-8?B?WmNRUXlNZjNMS0tTcXE3S2lvRERXZC8yb2luM0MxVDJGUXhESGovNm9hN1lX?=
 =?utf-8?B?Q2Vqd1VJaE5qdzA5TC9JMnNWM0Q1SEdFYzZzTGV1cVdiNk4vZVJJRk5oQnNp?=
 =?utf-8?B?VEJORVYrTVBZOGRUOFpTRFNBTWthYlVRbW91QlRFWXh0cDdGb3lTYnEwOVhm?=
 =?utf-8?B?WFpOVUQ1MjQxVTUrTUZsVFBlWVZRMjUyWi8zeHZEc3l4NGc2TTRHa2doTUNT?=
 =?utf-8?B?N2phdmhjMTFyOU85ZnFMT1dyV0lrbXNOMUtwWU5QenN2VHpueDZ1RTNHOUtR?=
 =?utf-8?B?MTdKOThjQjcxVEtySVV2ZnhFRVYwZG1YamluclVSVHc5aEZZRlRHVU9uU2xl?=
 =?utf-8?B?WGFDcmlTa3ZFVkJmUEQxWUFIME1hSGY3aHFCbi80ZCsvNFJRNjFEd2IrQU1B?=
 =?utf-8?B?VDE0QVN6SGZlK3N5RGd5cVl6czlGSEZWcW1qbjg4N2NHbnJjamFnMzFLd1ZC?=
 =?utf-8?B?eHJ0MnVTaEFqdHJqZTBDNHpKSHJZVUt4Mml2YVh5ZjFGTkNJLzhGc1hoZkVV?=
 =?utf-8?B?QXFYNDdnU1MzQkhiRlJ4Rm9veHQ2Vzk4NEFmWTdqQWlqelpJZFlCbXVGTEls?=
 =?utf-8?B?UHhMcmR5T2dkUHkzNU9GM0htN3NRVi94MURJUHc0aDMwRndCQmpmR0dXa29C?=
 =?utf-8?B?NU5jZXdZR05Yb1JLbFZWQk45Vmx6b0xLNC9kMml5T3IvSG5JV3dUaStvQk8z?=
 =?utf-8?B?N2pnRCs2MFV0SG9MQ3NMZ0ZKTE5HZjBDckQreHhwdHlHMUdEcVVmc2hEOStE?=
 =?utf-8?B?RmpIK0hwQ1pDWkZ2OUtCQ2Q4K084aVM2Nmo0R0cwaldSWWxYZGZQWmlLZms1?=
 =?utf-8?B?UGZDSGZCQUhDcitNSXhpSHRacm1TMlJhSS8yVmRRWFV3dXRTblZBZCt5dzNO?=
 =?utf-8?B?REtUNDJtSWhaYXB0YzdXOUtvNGY2YTFEY3VoVmpSTTAvc2FGNUxVYXEzSG5u?=
 =?utf-8?B?RFJaQjcyYzRBSHlvbko3a3JBbjBIQXp3UlpMRFdJQXFseTBpdWpFY1g1a08w?=
 =?utf-8?B?NGhtbDg0eVBmTEZ2RUNBR3R6UHNEODBxQng1clBMOU1kSFdBT0wvRXN3cWJi?=
 =?utf-8?B?d1JuQi9xdktmRSsxZGFmanA5cEJjRFBhMjRWT1NrUGJPaVRTSk5MNzhXUXIr?=
 =?utf-8?B?RDM0enNocGZHZWMwaFBBYUZtM2cyemVuZjRGaEZtakVVTHpFN3BVZjg1dGFF?=
 =?utf-8?B?T1NLSzVjeDZyczBLY3ViZFJCSE5IWjJBcjBKNHdxSEtLSElVbmJLVFdyeGgx?=
 =?utf-8?B?UjYrTnVQZUsvVGtHOS83TWRzMStHYnRCbEFtUi8vaDJuZVNCK3ozNWtFSi83?=
 =?utf-8?B?akJ2MlpqRTdScXdQcHZRbkgxMWQ3d2VkSGIrektyWHJBTlNsbjRxTEhjZndN?=
 =?utf-8?B?dUIyeFhmTU5aZWpWWENleTBlUCtQZ0thcWkzL0JIU2s0SUpXSXpkRGxsOTVJ?=
 =?utf-8?B?YURBSW53cjF2YkphM1FiL3NPeUxYb1NaWEg3aHVYNkZlOGZlV3loZUUyWUl4?=
 =?utf-8?B?NElkR0p5YjFYeXJxZFJUS3ZYU2NERGNsZEtmZk01WGVMZk0vY1NpM2VaWEQ3?=
 =?utf-8?Q?uIhIQqnf9SBm6324yg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlVaWHF4WVdpVzViQko0RXFMNlg0ZnQ0dEpNSlk3b0F3ZGFxR2ZwWnJLQTNr?=
 =?utf-8?B?RCtzUzZTQkUzTk43UmptSjhIQS9pUEplNTVOdkVLUTJiRXNnaUdPam5Wb21G?=
 =?utf-8?B?OEF5UHhEbkxlamtzWUVVeE9ZVlJ6R0pMRXRoSjNxYUJyOVVjY3J3bG9zZ0Qx?=
 =?utf-8?B?Z1ZnMm5qejFnSmlIcEFsL09Za1ZtQlBoN3JPWkNKL3hyTGVJbXVoRUJkcHUw?=
 =?utf-8?B?WDZPc3pvdzhXNDkxZ1dhY3puU0Q0ZSs4Umhrc3lHTkpwVzAxUG1tbkQvNkQw?=
 =?utf-8?B?bko4VWc4RlVzYXdsOWpEUm5sc0FXdW1BOU01YWxUbmNmTlczWDNkZ2Y0ZnRF?=
 =?utf-8?B?R1ppcWtGR1QvcFBoVHR3M0JYb1dCcE5GaXA1L2tRbmdYWHk2YW4raE5vcE15?=
 =?utf-8?B?SzhlSWlGTEM0ZWtBOWJDMUNCdW80NC96M29pYmFxejFVb0ZzMUEyd2pGRlhI?=
 =?utf-8?B?MmpyUnJFYVNQSEZNMUN0eHhOZ0JsRE1YQWVwcTdtTXA5OTY1Q3A2b1ovaE9R?=
 =?utf-8?B?Y2lzOGtYeCtXSm1uTUVLYmhZSkpIV2hLQ0cvQjNla3p2S3VIamFKTnZEdjhn?=
 =?utf-8?B?U2dTZ1J4a1I5UExhUVoraUZxcTA4alpNa2Z2VTIxWkJwYkVzSjhkeUZrQmZW?=
 =?utf-8?B?aUNvU1g2TzB6cjJ1QitmTGdpTUlUYkV3eXBIcUJJOUFCNmVJem9JS2ovVHA3?=
 =?utf-8?B?Vks2SmZiQnNpS0sxNDhPb3o0UUFlMWkwdGkxSzFJMkUxN0FzRDdXaDhlSkxC?=
 =?utf-8?B?aEVoK3BVaHFHcjZQbUdoWEZlOVN3YXJNbjVseVN3eklZc0tKeTZpaHNJcWtI?=
 =?utf-8?B?MHBiUXdtcWJLaDRLdVRZc3FvbVZXL0tyRFlwMWRKT2QyRjlzRUp5ZlM5S1Js?=
 =?utf-8?B?Z1F4cGNmSjZZSUVFNThoZGFXbFRpODBQd1duMjZkOE42UlRSYnRMUytjSG4r?=
 =?utf-8?B?ZXdFZUVjelNzVDBER05TN3hQUnJxNzFEaGRwUnFoUS94TDF3cmpnUU9qYnl2?=
 =?utf-8?B?L2ljZ2dDNWdhZWNBUC96Rml4aC8waWtuV0NxcUlnK3h3OGdqQkUrbzlrMGx3?=
 =?utf-8?B?V1g0cnE4ZDIycXVTc05xWlg4bGt1ODd0SVJ2SVhnQlBZOXRIQTcyYUVnaFRZ?=
 =?utf-8?B?SzY4c2hpRHYrbi85QTQ3WEVLT0xPTHcyaVNRa0ZmeTFETkhlNXJCYk5TQy9h?=
 =?utf-8?B?ckNGSzlzY3NCOEVGUXN6U1hOZWw5ZlVobXI0Q2pnVzBoUkNobUpMenRCeVJH?=
 =?utf-8?B?d0Z5T2dPOWF2d1RzekFsRE1YcHM5bjZLQW53TFBFUHdZaDRoUnNtR0xvUUV5?=
 =?utf-8?B?WDk0Vld4MXpmMHh5YTA1RFN4U0dDa2hPZVpaU2dGQ1pIdVNzN3FhNjI5d1dv?=
 =?utf-8?B?NnptN1RGc1FMN2I1c0YvaVVrMTRLaDdsbmM3OHBIdXNKQk9jVHovUG0xS1VJ?=
 =?utf-8?B?Sk0zQVJrMURPaHNCcmhrazR1TmxQMEVxbFhFeXZYVnNMcjU5SlB5TUo3Nnlk?=
 =?utf-8?B?L2JYdGZEc005YVIzWFhaeDJ5cGhCd1lveFhjUG92VklxanUrcjRsYksya2RH?=
 =?utf-8?B?YVUrN3E3cEx4cmV6T1VFVXlKaHhXSHIreXR2S0NDRHBIWWVJalZXaTEzT1RO?=
 =?utf-8?B?SVBjVE1xNnFwcjFQUmh4Um4xQjhiUCtxREFDUmNjUUNLVmI0SzdVSDNPbkpo?=
 =?utf-8?B?a0xmT1RGYnlzMElUSm45SjlyRGlHdzRnT0szc0N5U0hpdUl1RnFwcTE1ODVj?=
 =?utf-8?B?SEw4elV4STkyNnVhMlM1TE1STGJzcHEvcC9PT3R1QlU3VVdOVjlycGlNckpQ?=
 =?utf-8?B?MDJxU1p4b2lYOWtYRXJYY2NaNkJxR05ycGdyWnVQemxnNTdvSm5YUFNSTDZN?=
 =?utf-8?B?S2xNVlBSaE5ZZ0JneUU3RHBha3o3T3lkNHIyajRvYU5wQjBXNFhJNWh0TlJM?=
 =?utf-8?B?YVk0aDdrckdtRW5rcWdhRFRRdmRxa0FDaXpuVFQzQkZiUXNuWVBvTFl5U2hX?=
 =?utf-8?B?ZWswdGxQRXBvaitZWCtsSkJZMWwzUWZFWHhYTXVFR3ZvRWxlTUE4Ukk4enoz?=
 =?utf-8?B?K2d4YzVaRE1BK0dCZ1R5ZU5CM2gwY3lERTh0eE5ZWWp6UFBFTFp4ODBsOFJB?=
 =?utf-8?Q?mUovWafTOPdKkvkNAD+C4+WAu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e4596d-936a-4c4c-421c-08dd1a7c6103
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 07:12:46.3290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ym84sGmL3kylb8ZC+R1/Q9xC2j41hjeoNw5Hl5X5pCkOm9jmkpcMTDUmxi5Muxge
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8449



On 12/11/24 16:54, Rob Herring (Arm) wrote:
> 
> On Wed, 11 Dec 2024 13:41:19 +0100, Michal Simek wrote:
>> Hi,
>>
>> over years there were some changes pushed to U-Boot which were never merged
>> back to Linux. U-Boot introduced new option OF_UPSTREAM and start to sync
>> up DTs from Linux back to U-Boot.
>> This series is addressing differences.
>> There are still 3 more differences but they should be addressed separately.
>>
>> Thanks,
>> Michal
>>
>>
>> Michal Simek (14):
>>    ARM: zynq: Remove deprecated device_type property
>>    ARM: zynq: DT: List OCM memory for all platforms
>>    ARM: zynq: Mark boot-phase-specific device nodes
>>    ARM: zynq: Do not define address/size-cells for nand-controller
>>    ARM: zynq: Wire smcc with nand/nor memories on zc770 platform
>>    ARM: zynq: Add ethernet phy reset information to DT(zc702)
>>    ARM: zynq: Define u-boot bootscrip addr via DT
>>    ARM: zynq: Point via nvmem0 alias to eeprom on zc702/zc706
>>    ARM: zynq: Define rtc alias on zc702/zc706
>>    ARM: zynq: Rename i2c?-gpio to i2c?-gpio-grp
>>    ARM: zynq: Fix fpga region DT nodes name
>>    ARM: zynq: Enable QSPIs on platforms
>>    ARM: zynq: Add sdhci to alias node
>>    ARM: zynq: Remove ethernet0 alias from Microzed
>>
>> Sai Krishna Potthuri (1):
>>    ARM: zynq: Replace 'io-standard' with 'power-source' property
>>
>>   arch/arm/boot/dts/xilinx/zynq-7000.dtsi       | 33 ++++++-
>>   arch/arm/boot/dts/xilinx/zynq-cc108.dts       | 41 ++++++++-
>>   arch/arm/boot/dts/xilinx/zynq-microzed.dts    | 10 ++-
>>   arch/arm/boot/dts/xilinx/zynq-parallella.dts  |  1 -
>>   arch/arm/boot/dts/xilinx/zynq-zc702.dts       | 87 +++++++++++++------
>>   arch/arm/boot/dts/xilinx/zynq-zc706.dts       | 67 +++++++++++---
>>   arch/arm/boot/dts/xilinx/zynq-zc770-xm010.dts | 39 ++++++++-
>>   arch/arm/boot/dts/xilinx/zynq-zc770-xm011.dts | 31 +++++++
>>   arch/arm/boot/dts/xilinx/zynq-zc770-xm012.dts | 35 ++++++++
>>   arch/arm/boot/dts/xilinx/zynq-zc770-xm013.dts | 41 ++++++++-
>>   arch/arm/boot/dts/xilinx/zynq-zed.dts         | 43 ++++++++-
>>   .../boot/dts/xilinx/zynq-zturn-common.dtsi    |  8 ++
>>   arch/arm/boot/dts/xilinx/zynq-zybo-z7.dts     | 10 ++-
>>   arch/arm/boot/dts/xilinx/zynq-zybo.dts        |  9 +-
>>   14 files changed, 404 insertions(+), 51 deletions(-)
>>
>> --
>> 2.43.0
>>
>>
>>
> 
> 
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
> 
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
> 
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
> 
>    pip3 install dtschema --upgrade
> 
> 
> New warnings running 'make CHECK_DTBS=y xilinx/zynq-cc108.dtb xilinx/zynq-microzed.dtb xilinx/zynq-parallella.dtb xilinx/zynq-zc702.dtb xilinx/zynq-zc706.dtb xilinx/zynq-zc770-xm010.dtb xilinx/zynq-zc770-xm011.dtb xilinx/zynq-zc770-xm012.dtb xilinx/zynq-zc770-xm013.dtb xilinx/zynq-zed.dtb xilinx/zynq-zybo-z7.dtb xilinx/zynq-zybo.dtb' for cover.1733920873.git.michal.simek@amd.com:
> 
> arch/arm/boot/dts/xilinx/zynq-parallella.dtb: ethernet@e000b000: ethernet-phy@0: Unevaluated properties are not allowed ('marvell,reg-init' was unexpected)
> 	from schema $id: http://devicetree.org/schemas/net/cdns,macb.yaml#

This is not issue caused by this series.


> arch/arm/boot/dts/xilinx/zynq-zc702.dtb: ethernet@e000b000: Unevaluated properties are not allowed ('phy-reset-active-low', 'phy-reset-gpio' were unexpected)
> 	from schema $id: http://devicetree.org/schemas/net/cdns,macb.yaml#

This has been reported by Andrew already and the patch will be removed.

Thanks,
Michal


