Return-Path: <linux-kernel+bounces-441438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E499ECE62
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D604188D64A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8E124632C;
	Wed, 11 Dec 2024 14:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HHaJMCYX"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2065.outbound.protection.outlook.com [40.107.96.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20602246320
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 14:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733926462; cv=fail; b=OgC971FwyvoA5HYcSF7XhZvyS7n8c0xJJ5t2vdRUZqomNKfqnKKuCkSRP/+nG4aFUR7HUwLHMA9y41h/zYr3wkZrLXvIgIBVEBr9mAROXghjM6Q152gcFHSxwt0xOKw+Gs8wfhqVVh7PAxVDqOrhyLG6qpwRHrxTLQwR3dQAe/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733926462; c=relaxed/simple;
	bh=6s2JIE1VUinMHD5LGS0Y6HP74a0JoUbXr1o2uTpPRaU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=psrLxw8F5uMYHuu9nOLHlNmpjlMhhTvCWB1s0TcXOebfwRMUb0F4nkWz6yVJcyMzIRpG/A529wqWM94lvR5mclRzxQudSng0JdxXngT6UemsULO56JhlWQ+vcaSo0lh3J0WDor9O8N85MVe8XRsbbEHrWKEdD6Yi8DQwzHh2TPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HHaJMCYX; arc=fail smtp.client-ip=40.107.96.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EwQ+8+auCtpF2vg0rns7nIsdF/X0O6PDuLSinqbEcKELSosDOeFXkbU4L+ynQlvdnxgbjvj9AY8bxuuuXvIQVd/DmVVlwSXtIgx+nsnFKxb6lZQvCI8flxIar8kh4zbOYQ1Km7EEoxhEfU4DM52HJ/4GodbvmIYD7TT9buhQ/YwZbUWrBDQiHZSVnFCF1be5u1vhDTj2hkH5NE7TBc+Nsi30TydH47sPhxpX/wLlQS20h3LUp2vL9XtEWZV0MbgGHP32QLCMNKsy8z/GFkzmX6yPPewYM2dXnw+imbjYfAigkuhE21Yx4X4YDJze1x+dJbySiku6F8vNDWtAhFg1Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osb+7ZMM94I7GRa74wUBuEQ8fzIfNxDtwv+d9pPEmZA=;
 b=t2NExsyavBdVx3IdMBiWD0g+T/a7Z7yv4V1n8RD1ZyXe2U1wodmCrfeozxA8MjqZW6ehdcUSmdQsp3ZacjOO5XqgktexunDGCR5csvnYwESqWASqBeNoFUCY1d4T9klaz29bTOcQple/nKNh+QuM61cQreBruhKmuGXLrm2zqN0uFNMc7MZKVaDQQoKU3y3nbiHGbrhnzfbuL8lf6/Aofu2eDnNu4bNTxmHIHu1u2LwIQyaA89M1yKuZ0dthjM7XJ/qJyUEa9SbDuny2m4iTPu8zdV0Y8MB/t1oLE14hR3FtQTwrvIVqHQ8417W5LGATZ31mGUroSOcn6ltsKEUX/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osb+7ZMM94I7GRa74wUBuEQ8fzIfNxDtwv+d9pPEmZA=;
 b=HHaJMCYXkW/ArRQnNxUS6YUCxUDZRf4+J2aFLIKVXgfXXrHL+keS/HJnRuetd9mwAMpnhrHg1f4CTfmzCgSgU0Wj1++LSffwStx5QJr33oB3JcV/VZzmysJ2QmxByemaoSFcUM8t5Dk1hiR4OK4EJHZ+etpsKLFzcAVCpNHEfSU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA1PR12MB6651.namprd12.prod.outlook.com (2603:10b6:208:3a0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 14:14:15 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 14:14:15 +0000
Message-ID: <66ba0a5b-dba5-4162-b83f-2058b0dce3f8@amd.com>
Date: Wed, 11 Dec 2024 15:14:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailbox: zynqmp: setup IPI for each valid child node
To: Tanmay Shah <tanmay.shah@amd.com>, jassisinghbrar@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20241112170612.2577383-1-tanmay.shah@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20241112170612.2577383-1-tanmay.shah@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0020.eurprd05.prod.outlook.com
 (2603:10a6:803:1::33) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA1PR12MB6651:EE_
X-MS-Office365-Filtering-Correlation-Id: b0d77c05-5143-4cf6-dde4-08dd19ee17b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXlOU2xDWlNrNW4yb091TnBjYVB2SW5kVU9xRTlxako0V01MdDhUblhTdVBs?=
 =?utf-8?B?cm4zWDM4bFdrMEEreWxwNnNIUGZNT213ZUZRZ1NESnE3VjlzNU5xMko1dnBq?=
 =?utf-8?B?VEp3RjdsZWN1b09vQkVvdmpZbUVqY2hURmZuOGh5VEovOGIxemdudWh0d1l4?=
 =?utf-8?B?ZkJGb3VueUJKNFdHWHhzNVRvTGd0NWtFMlFESWFNUkVQTklJSDRiM09pTVI2?=
 =?utf-8?B?RnZIQVZaeDJmMEdzVWJwYnJUeXF4Q1BlUWxZaEwwNTJZZHZsd0dlZm9RbEUv?=
 =?utf-8?B?SUwzOUZuV2d6bGQ5VFE0cG9vaXR3N1hLZ2l0MWZ4K3NybTIxWk9ZaUUxTVFz?=
 =?utf-8?B?U0hmVnpydmhsWi9FQTlmY1dvRjJKdkQ2cm95akpINWhydUY2VWZZd25vUWVU?=
 =?utf-8?B?cEwxRjhQU0RnVEY3cHNZYlk2Sk5ycXJNSWcyTWoxUnZlWnZKa3dpYVJQRHNp?=
 =?utf-8?B?ZGdqaEZhbS9ZRlRWYVFabGdHSW9XS0pmaWZHT0VFQTFNOUdNMURXc2lMeU1E?=
 =?utf-8?B?L0U1T2RJTlFRUjdXM25qY3R5OW93SmpMWXd3WnRyckhzNUJ1SThIQkR4c3Nw?=
 =?utf-8?B?c0xYdTVnWEJxVzVXazFZamFoQzA5T1Vua0ZxSHFOYWFuQ2FycEZ3WnNsRCto?=
 =?utf-8?B?NTlldTJ3NFFheHdjWHBka3F1bmtuc3J4MkxrVC9NQUZ0MVpVbkthb1VPSExx?=
 =?utf-8?B?WVFPeWxPeTZnTGNqV05aSHZyUkg0RWRvQXhub091OUp1L3dLSlRIQWxkNFYw?=
 =?utf-8?B?dTVTLzBSZUNkamUxUWlQOEZvZDRiMVE5NlJhdmdhV0lrTlBQSTArN2hhVCtT?=
 =?utf-8?B?L04wSkw5U05wKzJyM0ZtazBJN25HeXFtNzlqTTNxSGRnQnJTK2lZQk5jbGpC?=
 =?utf-8?B?Z0krOFVDT2p2MG1uTllsRm9XeS9hOFQ3bUZuNzBqdU53aFA5d3RuV2pIakVR?=
 =?utf-8?B?TXJDYXRLa1pvNFV2cy8rSGpzc21LMjhYRWlCZllsUitiajhXalQ4OVRZU09u?=
 =?utf-8?B?aEorU2FMRlNkcGJVcTQ5VzVYNGFpTytqZWtlRXRLbzAzUkZtQWN6d2UvWDl6?=
 =?utf-8?B?WFNQNE1DVjlqNUI3enN1QzNSbUVjTXREbVBPUW5YT1c2Vlo5K1lPVUlaY1d4?=
 =?utf-8?B?NXF2YmFvbzlLVk5vY3JUSGFRNFZUQklkM0IxMGFUSTZpOGYxMlFoTjZrZWo0?=
 =?utf-8?B?TnZVMzRHYy9MZkNlNkMvMGxtdzZtbjNJdk9uWGZLeTFuSGxSWWp1a1RxT0Qw?=
 =?utf-8?B?bkg3NGNEbW5UQmNhMjRMc1FhUVpkU054Y0h1T1dEODYvWU0zVFdEU2RuVGls?=
 =?utf-8?B?blZnSTliTG03RzlxRU1mNVpRelJMOWJnYmM0dUJvbmd3ajRtakE1SStyR0xG?=
 =?utf-8?B?cGV3VG5oUmU4cmVqNVgwRHhSQ3ViNW90VFlZbTVzRnloRlMzdHpBRW1pSVQr?=
 =?utf-8?B?S1lIYUxReHFHUE1XOTEzOUFXaWJkMDM3d1lFcXVFY1RacUtOY0kxN21pSU1r?=
 =?utf-8?B?clk4Y0FDU0ZWZWdpTkpTdVFmTnh4SVNrZ0g5bWpQMFprUUZsMk1KSlMyWnYx?=
 =?utf-8?B?MS9JbVB5dGlsUWRSK2VFTUlZdjl3bDJzWHBtaXZSTUErM3dLWTFNTnRGNnlG?=
 =?utf-8?B?WWUvV3FrUXhtZjgvMTZZVFZXZENvN2R5MWVLRFF3cnh4ZXNnS1NpY2xKR1BG?=
 =?utf-8?B?ZkdtbFhVOEFSYjJ3SHY4NkhWaVY5YkVQUDErOTFYRTNuNXNVZGtsRVRKWmls?=
 =?utf-8?B?d3pSeWpWdk92bW9zYXpNT3MwUWJTMzduam1pemRHemxvbStJNkZmME5kQVdB?=
 =?utf-8?B?SW9xb1ZZdlpnS04ramNrUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzBpV2k5OXpKRUhDMTFWK3NWcXQ3TExpQzlMTnFhcXhqYzBxWVJGVmhSMS9N?=
 =?utf-8?B?aHlmM3J1VEtLTkY4WmVGamZrUnFqb01RNTdhd09ZYmEyc01TeXVjaEVWMng1?=
 =?utf-8?B?a2NiVFVhOEZhTHdCU2V3NHVoaTlGOS8wZWJjLzZxcFk5MTRVc29xN0c4ckMw?=
 =?utf-8?B?TDlTTmZCWUsweG0weFlINzF6RHF2Sm1BSEJMbzVQaGNJSlhOZmNnNmpLalR6?=
 =?utf-8?B?eGdwa0VvSU1VNG9HV0VQM2hWR1JGQ29JMS9lS2N0dVpnTkpjR0ZFbDA4VUl2?=
 =?utf-8?B?bWRhL0ZDSEN0cXBLSlArL2hHc3pZWEVGZmMwVlNTUjhlWG5pYUttMmE0YTdC?=
 =?utf-8?B?dnhSU1Bnanl3M2svZXozVzBKbmhUM0UwQ2ZHZm1vejVodW5tRTNwQ1c0SHFI?=
 =?utf-8?B?UTZNdHJ0bjdQS1hmelFDQkpHZlNUeHRPVlhnNnQ3enJvbDBDOUh5djFiejl4?=
 =?utf-8?B?bDlIMlRoRWI2V3hMREFUdllqSE1nM0xPWGxIaTF3em5BVEorVUQxV3ovWGV1?=
 =?utf-8?B?Z0lGcnVzL2xCUDdHL3ZUNjAwd2ZPN0tndUs4Y1lWU0VTZjh0aFpac2YxYVhI?=
 =?utf-8?B?YW0rSmdZQzBtc0dvTEdXb0hNYUVUTENORjArRDF5UVk4ZXpibjFteWpRZnM3?=
 =?utf-8?B?T1RlRjlQaDlBaUYzRTBhd2pBejR5dGorZzZHaTgxMzl2NnZSejFpOUV5cXM1?=
 =?utf-8?B?aG43MldGeU9xT2hNNWJRc0EzUmRlSHdaZkV1UVordFBqZ0dxYndrWHRaVWlu?=
 =?utf-8?B?K1NSTk0ycWhLUGhTUkdKYk92K09VMmdYbTYvc2UxeDN1aGkvR2NHelhmRTBI?=
 =?utf-8?B?c2ppenpMMWdGOEhuMDMwc0NMcWJjdTNKeWRNTGF3REQxU3dYK3dBT2JSSlFQ?=
 =?utf-8?B?S0ZCMmREa1ZUWlFvNFpwa3NySS9ScXRycG1BNU1wdEhaVy9ScE1BZXhBTm8w?=
 =?utf-8?B?QVJYKy9YNFFWOVZRRHBQbGx5MFpKd2FKU3Z1Q1FxSU41OWJwY2ZLS2V2Ynla?=
 =?utf-8?B?aE9yTUQ2TzVCelhueXU1RUpRaFJTM1R6OXdWWEk1aXRTaEgwck11ZXZSV2Np?=
 =?utf-8?B?dG9JRVBCQ00ycGhJNlBYMVVtam1RSUk4QlpMK1NLVWtrMnhlMUUrQm1lQU5D?=
 =?utf-8?B?cDRkcUx2eVhVeUJkbGhsaG5WMnBZOHErU3R1OWV3MDJOV016Sm5WSUlVczhY?=
 =?utf-8?B?NldWdDd6eEMwRHpuVnpqT1U3RG1xN0RRTmUrMjZPem42eUFDbyt1c1FCT3ll?=
 =?utf-8?B?WGlnbndCQU1FSGZYVVpYbjY4UDdTeWs0ekxKNXNXY2VPSGplNzJ4MTRLQkVW?=
 =?utf-8?B?WVJyV2xPRUhzTkFPR25id1h6SVpmcXQwV05hcmtrRXQ3dmZ3RlJxcWQ3Yk0w?=
 =?utf-8?B?ZURvUCt6a09MYXZITTJVaEpnTTF0VWc2TWZpbkVOakxGalYrOE16RnRoK0RC?=
 =?utf-8?B?dzIxM25heUFNNVpwWWU5R0pDY3JoRDVKUFN3RWpSS2V3ZEh3eFpXUEsvOUFs?=
 =?utf-8?B?a1A4ZXZJZmRjaW1BVUd3eGRncEVRMG9zQlJvTHJiMEdiSEgyVklEWEhkN3BX?=
 =?utf-8?B?a0JodVlyaGFJNXBmaVdsOUIzVTYxNXVqSzI5cGNyYWp4NzQ2Q3ZTNC9RM1pI?=
 =?utf-8?B?YXNWMHlRZDBpeTVBcUpGWFF4Y0tZcHRxUGpiYUwyYnhpa0lGa0czdC9UdHBw?=
 =?utf-8?B?Y0VlVUo5MXBZQlJsUk05bjBTbG85VnE2alg1ZVE3VEdKMnV1c1RzVDBrc2VG?=
 =?utf-8?B?bm1xQ2NKZXdOM3k4Y1h2a1dFbVRwZ3RFNURqL1VET0NjZDI0b2JrbTE5Zlo1?=
 =?utf-8?B?czZmYkdnR0RxZzN4UmYzR2FvTUVKQW1iRDBEWXpCSXREY1BhaXVvR1l4NE96?=
 =?utf-8?B?ejU1UmRjZWZlRlQ4R2ZWN0RsbWo1aEJKK2p4ZkhlVG1PeDdVUWw1V2c2QTl1?=
 =?utf-8?B?N1o4NzRHNmxzMlM4YnlEWitaWXVieDFWdjFtc3FkOFRhdXpWYzNQOGxMeTZn?=
 =?utf-8?B?WVdIbjdaRUkrNGpUa3gxV1JtVW9mNXZyTEkzR0VNcENlREYxRWpSQjUxVzZl?=
 =?utf-8?B?Rm0zektNYTJvNXdwd3d5UThxRW9MQTF1VWdCdlU3QTlZRmF4NFV5eEhWOFZ1?=
 =?utf-8?Q?xzONw+psmJHSIQxRZaz+nx7lF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d77c05-5143-4cf6-dde4-08dd19ee17b2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 14:14:14.9638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fv2M564tdP9bLvQTFkUddvpuSzXcazmA+YinS5iQEyV8cyJjn7murz12iwm+Q2NT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6651



On 11/12/24 18:06, Tanmay Shah wrote:
> As per zynqmp-ipi bindings, zynqmp IPI node can have multiple child nodes.
> Current IPI setup function is set only for first child node. If IPI node
> has multiple child nodes in the device-tree, then IPI setup fails for
> child nodes other than first child node. In such case kernel will crash.
> Fix this crash by registering IPI setup function for each available child
> node.
> 
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
>   drivers/mailbox/zynqmp-ipi-mailbox.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
> index 521d08b9ab47..815e0492f029 100644
> --- a/drivers/mailbox/zynqmp-ipi-mailbox.c
> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
> @@ -940,10 +940,10 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
>   	pdata->num_mboxes = num_mboxes;
>   
>   	mbox = pdata->ipi_mboxes;
> -	mbox->setup_ipi_fn = ipi_fn;
> -
>   	for_each_available_child_of_node(np, nc) {
>   		mbox->pdata = pdata;
> +		mbox->setup_ipi_fn = ipi_fn;
> +
>   		ret = zynqmp_ipi_mbox_probe(mbox, nc);
>   		if (ret) {
>   			of_node_put(nc);
> 
> base-commit: 28955f4fa2823e39f1ecfb3a37a364563527afbc

I think you should add Fixed tag and also cc stable@kernel.org

With that fixed feel free to add
Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

