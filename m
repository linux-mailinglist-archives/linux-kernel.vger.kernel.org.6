Return-Path: <linux-kernel+bounces-365911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1441399EDCA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6389AB23B75
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEC714F117;
	Tue, 15 Oct 2024 13:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qw5Zq6Xj"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2042.outbound.protection.outlook.com [40.107.96.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0251AF0C3
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 13:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728999397; cv=fail; b=ev48NwuaWYDk0sVH1q+lAqJFgtkgar79lSb1m3IAQeIYDnF+Am0QkUDT9pxWaEol/CqZmabmc6iJYybk46kHmEEsLg695cEUZhaf1JQT7sORFKef0NFR5VK8ShXuiPSPzYXMy4pBILnNM84gGzO2ROilxWiz4AE6tkkUEaBgogI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728999397; c=relaxed/simple;
	bh=I5KuDhZVUhkOTOLLJgEX2sWTK6GzKaGh8SVmwAWM4/Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f2GFDkmmHLVm9dTfBhEgb0pOb4Be/kYDX8Of8RSIRDl16k6tD9fbZBnofSKdq2FzKiDxjfncRgJmv50ppboeLdbTZViUdE1yWBu3aWdl1XNDIioOn8n+A6Yt2Q3nNk8N3mzopNBIG+vQOfJWATgbWlL2lJsArAsqpvnj9waOLFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qw5Zq6Xj; arc=fail smtp.client-ip=40.107.96.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pN6GK0WW+E4Pl3OBJMi44LRsXJYE3QFMbm5p6htASX0YCbzafKFXwMLkJrGlExeKhd7eYo7X9NncRK1x9vQOHyN5ixKzWv8cSNG4HAXlpjNPQ2rxD7+ijM6YRGfVbvf/cUWOhh1BQrpsjJrJM1zy298h9IH6vodyrHxX7lA5J+f4R8Hpl3BlOTComQ8x4NZe8+91PhTjsirDI1U/Z7GVOSQEEL0gtzHuwHggktZ58VRXI8uvNp11BopsgZqsQsqV6AzJJz+GjijsFBW4AgF7Xs0x9O2o+wkPPadC5rBvcybTpSpJjChOx5bV2uUE+CkG2Jv7dYuedI4LIp/Pxfu3RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjyyejfUJF//WdfT8Hvr9bUtql2HO7+Lyd+nz0jkbJw=;
 b=aSLBbgsMjHN01fIZrrK2QD86zgTOf9I3fsHMv5lwXCJI/ckO6PNt0GY9FOnF+e+TsC32oQD6EwQKsxu7Mn7bS32VhoCOSiHWcGkKeim6K9DqL+ZRPSY+EGpo/eG1u4p5gr6tBVGB74ACK8FSF59Cwndco/7t5F01jPQnZfBHx2Ml5dOumjpJ+amPcAnlEaqIfXa20rZ6ntrbSsay5uoQitrbZ6vMGLC4NSfosthUIOtB4dqFcgcXUMKDLd8KnbPCdOj1qq2vHk76lQHLuNR48ab2BxCC1sVIJP0HPUidWKxfFQCyRLsht6lhyQDVIir+Jk4wjTaUyVdBs+XWmHZVFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjyyejfUJF//WdfT8Hvr9bUtql2HO7+Lyd+nz0jkbJw=;
 b=qw5Zq6XjnsIlaSALFaEWOiSLd8tdvOoDNJEmYmgGUybZ/8eFfP+jIFD7hZuzJ5+Oj/3CB+LKQdZ2c1AaOoGFEr3NTrvCaVWkSPus9dJeINW9gkTyaDu/R0Ut1cofaqW7J1tqAxI0+Ya8ntMQcnQLF/5bFV6Bdpf7oJWLFJoRd5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CY8PR12MB8364.namprd12.prod.outlook.com (2603:10b6:930:7f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 13:36:32 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%4]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 13:36:32 +0000
Message-ID: <49fd4eb5-ee7b-45f5-a40f-dbfd793cdff4@amd.com>
Date: Tue, 15 Oct 2024 19:06:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] perf/x86: Relax privilege filter restriction on AMD
 IBS
To: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>, Mark Rutland
 <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Stephane Eranian <eranian@google.com>,
 Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das
 <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20240905031027.2567913-1-namhyung@kernel.org>
 <20240905031027.2567913-6-namhyung@kernel.org>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20240905031027.2567913-6-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0180.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::35) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|CY8PR12MB8364:EE_
X-MS-Office365-Filtering-Correlation-Id: 27cb5011-855a-4726-e26e-08dced1e61a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXJDQVlkb25qWHdkT1dOZXpJdE51ZDJOYU9YN3dwWS9kTjVpTHY5STloRVpn?=
 =?utf-8?B?NHZiMXA1NVgxcnVSQWJrSWlmZGVPWElnblRMZlFLYXJSV2VNNmN1d3pkdVoy?=
 =?utf-8?B?U1V3Mkh0NUx4RDQ4anhXVDNMWXRCVStxSkZyMG9vQ3E0VEl0ZkxicjZNQzI5?=
 =?utf-8?B?WG1UZHdUQ0tMMEFZelBDVWFJRWtCZGNWRGpodm1TTzNFbmxVNmdzM05qRkdo?=
 =?utf-8?B?QUpSTnozK3grL1BWN0ZxRnpDY3g5ODA1ckRSVXJ5a2VtSm5vS1UzVVVjeHBt?=
 =?utf-8?B?LzZGTG1KT295czREY3c4ei9GU3VOU1krc1EwTEk5WnBja1cwVnZndkNXRFow?=
 =?utf-8?B?VHBhcjd6NFAwcUNNeHJPc0RNRkwrWUdhVzNZUXVITFhncGpFbHk0QThPWWVU?=
 =?utf-8?B?MUpQbVpCMVR6OGFkamhmRUZLSkRHczJ0RXdJZkZ3VFNseW8yYUY3eTBoMys3?=
 =?utf-8?B?QVdRN0VxUzN3aE5MT1lzZ2xYbUZsK1dmTGVnQ0c0WXVZcXhTRWtkd2ZLVjcr?=
 =?utf-8?B?cnpCMTB2SjI0WWxMN1pJOStXRmg0aXBSNUpicENHSC90ckpIc3RNVmVzb2RQ?=
 =?utf-8?B?Wk9KdklrS1QzNjFjbEFSWXZJRXhYQzlOWTlOZVhYUFZRZ0dGKy9sN01wYTA2?=
 =?utf-8?B?SEdiWkRwa3FSTWVYcnN3bVBMZnF5T3dRV1FRVm9VM3JkSmNsb0t3WkdtT21I?=
 =?utf-8?B?VXFjSjIyYjNlNitMb2VkN2lLcy81R05JUklvWEFsdHdRZkNaa1Nud0w0TUt0?=
 =?utf-8?B?V0VHU2N3VmxleGRoM0pjclY0OU5RSUtmMTMzUjhEQzFOQ0tUTDY3elE1S0Nv?=
 =?utf-8?B?UHRFQ09NbitLNys3TnAzVlVjRkdWVlhBOG1HeEF5TmU1R1Y0TjJYTGoxRHgz?=
 =?utf-8?B?Q3Jid25ubnBEM2dqSjBsSSt3cWVnb2dHWXVMTEVFaDNBcGR4QjJtRzhTYTBr?=
 =?utf-8?B?d2hzQk9oRDVhcXJaUk9WZWRlMkhUa1IzR1NjTitkTHovWDFTdHV3a0RIOUxX?=
 =?utf-8?B?bEVoZUdnZTRTdmQ3bU5BSmxuUXFmM1I5RFBtYUhMK2c1Q2JiaFZOM0M5Nmtl?=
 =?utf-8?B?NzBTcFBTSFd0TXFmV3NpaFJIRXJnKzJEUk5hZkhtbmFSL1FaV2dVODhDVFJD?=
 =?utf-8?B?MDF5WFl6RG1RY1BzcGxaTlNNVzRLa1JTb0RWWUhyTDNGY2VEeFNJSkRQUVFY?=
 =?utf-8?B?dUM0S1NicDQvZjRhNC80WVZkWnBzTUVaMWxPU0pleVFZVTZ4Q1FvY3NzOWVu?=
 =?utf-8?B?cUQ0Nm11LzQ0UTc5S1c5d052R2V0dk9UbzdsV1NpN2Q5RjhDc2IxRlRjd0w4?=
 =?utf-8?B?eVdScDhzUnUwMEdLTEd3RzVaT1NNdEp4SXJoSTBwdXJsaHorZmErS3M2VWFk?=
 =?utf-8?B?cUxZcm1lUHNBWGlQRWJYMDlFRWVSRWFvVzBpTThZK0c1VHVVNFJTRmszRXcw?=
 =?utf-8?B?dEUxak44SmhUaGJGb2lxN2FseGpOblE2M2ZXNVE4VXFMeml2UGk4QUk2NXF1?=
 =?utf-8?B?ZStRd09aZjVEbXNsVzVZSnJRSHpUWHJvL1hqSG9NbHgxdm85Mk4wb2tJYlNZ?=
 =?utf-8?B?enJlRnAwajZ0d2hBbVFSMzFwVDZFWnVWd2R6ZENLRm9semZabUY5aUxHdGFE?=
 =?utf-8?B?QUZCKzhPU012alNhRm8xbFZ6Q0xPVUFvMit0cnIrcEVBTHZXWVVmRm1EelMx?=
 =?utf-8?B?djZpZkp4Wk4zcSs0MGlEN2FSUmRIZ1JtYUREMWJFak4yWFArVUZEdEZnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2RPam1Ra1lJU2tiazE3TkRMS1FFMFQ1VCs5dnVJVUp5Q0NZTzQzM2J2VDdX?=
 =?utf-8?B?aE1wb3BXVkNKUVhjSGl2SjVadFFxLzlPWWlRR2UyenZjQ3RhOWFDaUppL3JM?=
 =?utf-8?B?YWplYit4TWVXNjdwb2VxUEpXZjk0SlF5NllSWURWKzUreGJYeitBa2wwcEQ2?=
 =?utf-8?B?cjNxRUhuQjFuUEp4Rnl0am1YcllpdEZ0ZS9CUTZISFhWWGhhRUh0c1BBK3Br?=
 =?utf-8?B?RFAzZlpoWVNLbXlIT1BFVzRJeDZPeEQxbVNhTVZmcnF3V0ErSFRHUVZIWlRG?=
 =?utf-8?B?a1UwbkwvSVptdTk1ZlV1dVFjQzlpZ3lKbFkxVUFoOG9wN25RRk5FSGN6YVdr?=
 =?utf-8?B?a1hpeFhLbzFnUnJaU2gwaXpQcXhGek9BYzFXdTNQVmpLNE9tbnVXVElISkFY?=
 =?utf-8?B?OFcwSnU1eWFMMy9WcnJGL3lrNk9TL3ZSSndyNlhiLzFCZU93bzgrdE81blU0?=
 =?utf-8?B?MzZqajRmczVzbVF0czJvUVNFM3B1WjMvbkkyeUVrbHZvVW8vYU10NFBPVmov?=
 =?utf-8?B?ZVVwcEVuUUZSSjRFYWY5NVE1UWlFdlluelNoUEpVTG53NzRqcVBoekpnTGdt?=
 =?utf-8?B?VTBIRVoxaDI3Q2JvVU5JYldPbStGejlWdlQ1WG1CYURlL0txZkR4N2xzVzA4?=
 =?utf-8?B?b2UrU2Z6dFV2MHlDK2prbzk2M2tyamsxak9NcVdXSUtYRFgzaFcrcEh2UnRC?=
 =?utf-8?B?Smg2SEQ0c21mN2o5R1JBOHE5YjkxWnQ1TUR6c3ZmQlFCUk5KWFRtZzVVcEo1?=
 =?utf-8?B?SjZNWENTWUg2YU5jRmloaHNiTXM0b0FIMDA3a2ttM1RkMHZiZ0NCRi95bm5p?=
 =?utf-8?B?SUUreWlON2JaTlpucGplYjFXbk82N0JFeHhlaHU4djA1VXc1b0RnVFZ5Y3JR?=
 =?utf-8?B?V0QxYkh1eTJ4U0pwWW80S1VuemwzMjZxNVdscFpiN2FnTjV6MjBaS1FPUDFo?=
 =?utf-8?B?TWttZFB5akhDTFpUYWdEMGszMUdtMWRDQ05JZ243QVJLSDAzMVdTVmRBVks0?=
 =?utf-8?B?endFeEhqZDJuNEV0YU5FZHUyNmZpa0hoZ0hUODFsNlhnSEpaYzlOUXVCSHhh?=
 =?utf-8?B?Q0lSWGNSMWowRkZlK1dVQVhTYks5OEc1ajlJZmNzRVUveG5lQjU3czZEbEJv?=
 =?utf-8?B?RjBPNUdxeWl6b2Y0cFJhSVEvV243TE1pMUhraGRiRkk5WDMydGJocFE5NVNj?=
 =?utf-8?B?R2xYWGN5cDU4OFNkVEFGNzVab1FZMzdGQWJNMS92SmxmWGkyNlpsdmt3SnFF?=
 =?utf-8?B?RjJ0bkltWHplSFhyMXkvSEtQdWd1OEFtZnJ5ZGpjNGFkbkNnK3VVbWxaSlds?=
 =?utf-8?B?UTZpSmRUVXB6NWp2cFJ4OWxrY3k0YUFYL3hYYUszcFlnUzFyQkRjTW0rcHYv?=
 =?utf-8?B?Z21WQmJJK0pLUDVhbUY0R1IwRWhvdmpBNWgwR0ZHRVRZZmFnTlh2cWE0N0pm?=
 =?utf-8?B?K1MzWEY1dVpsYWNkMWJTZGNoUDhrdU1xWHJ2TDQ1eno5MjZ6V3FpSnZBQVpP?=
 =?utf-8?B?QUVBQUFCRS90blVOV05BaDA1Z2t3SjErR3YvOVpKOStTK2ZicDVCT1ZWdkdF?=
 =?utf-8?B?MkxKc0xYN1dnM2U1bDl1SldUVlpIMDFha1ZYK0g1UWxuNllWTGF6UVdxYUFS?=
 =?utf-8?B?WGkvR3F4TXlUWHh0SmNrcllQVUJ4TXdVazZoMU5kQWgvM2o3UFpHVzVNVWth?=
 =?utf-8?B?U252akZhaGNmVUxhaktZWUFzRFFKTWhzQ3RDNklHUGgrcHZ6ZWdTM2NOTHp0?=
 =?utf-8?B?a1dCakdHV1NhSDJsWEUzWjFDVjJVTlJkaUllaFl1NWZlc2w3N2hxTWRKYnFZ?=
 =?utf-8?B?MDBuQTFxS2pmNW52RGxnN2F2N2JzejZHY1JqS2ZSV1RuRWpHdXk5Nmw5OEJT?=
 =?utf-8?B?Y0MxVU9DS2phS2grYTVCZG95VVNCaEtSUDlwaEdsREtuNXRZZlNGRnl3V2t6?=
 =?utf-8?B?UzlBalBObUl1endYUVg1QzJyR1RYZzJONzIrNGxxWWpVekhSeFg3emU2R01D?=
 =?utf-8?B?TkdIbFR0M2NTMisrRjczU3dXQ2Npa1lXRXBndkh5QkMzWmM1VldtRVkzUnVI?=
 =?utf-8?B?UkxJSzRxZy9IdDl2eG1OTVFzdUx4VTI4OXl5cVJubUsyc1dqN1gwTzlxUmFa?=
 =?utf-8?Q?6o2E2Y2nrRIhNXvKS4pKsCMte?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27cb5011-855a-4726-e26e-08dced1e61a8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 13:36:32.6645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cXRfJX5Xx9zy54T3ATzWI25ofNvpI5mwEvkVoawDflyn8xQVlItYjKiLZ9V8PtYhaN2KJLmJGkp6Fn5v/qaZxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8364

Hi Namhyung,

On 05-Sep-24 8:40 AM, Namhyung Kim wrote:
> While IBS is available for per-thread profiling, still regular users
> cannot open an event due to the default paranoid setting (2) which
> doesn't allow unprivileged users to get kernel samples.  That means
> it needs to set exclude_kernel bit in the attribute but IBS driver
> would reject it since it has PERF_PMU_CAP_NO_EXCLUDE.  This is not what
> we want and I've been getting requests to fix this issue.
> 
> This should be done in the hardware, but until we get the HW fix we may
> allow exclude_{kernel,user} in the attribute and silently drop the
> samples in the PMU IRQ handler.  It won't guarantee the sampling
> frequency or even it'd miss some with fixed period too.  Not ideal,
> but that'd still be helpful to regular users.
> 
> To minimize the confusion, let's add 'swfilt' bit to attr.config2 which
> is exposed in the sysfs format directory so that users can figure out
> if the kernel support the privilege filters by software.
> 
>   $ perf record -e ibs_op/swfilt=1/uh true

Shall we add an example in tools/perf/Documentation/perf-amd-ibs.txt?


> +static struct attribute *swfilt_attrs[] = {
> +	&format_attr_swfilt.attr,
> +	NULL,
> +};
> +
>  static struct attribute *fetch_l3missonly_attrs[] = {
>  	&fetch_l3missonly.attr.attr,
>  	NULL,
> @@ -598,6 +604,11 @@ static struct attribute_group group_rand_en = {
>  	.attrs = rand_en_attrs,
>  };
>  
> +static struct attribute_group group_swfilt = {
> +	.name = "format",
> +	.attrs = swfilt_attrs,
> +};
> +
>  static struct attribute_group group_fetch_l3missonly = {
>  	.name = "format",
>  	.attrs = fetch_l3missonly_attrs,
> @@ -612,6 +623,7 @@ static struct attribute_group group_zen4_ibs_extensions = {
>  
>  static const struct attribute_group *fetch_attr_groups[] = {
>  	&group_rand_en,
> +	&group_swfilt,
>  	&empty_caps_group,
>  	NULL,
>  };

Causes:

  # dmesg
  sysfs: cannot create duplicate filename '/devices/ibs_fetch/format'
  Failed to register pmu: ibs_fetch, reason -17

Rename rand_en_attrs[] to fetch_attrs[], add &format_attr_swfilt.attr
to it and remove &group_swfilt from fetch_attr_groups[]. And I guess
it should work.

Thanks,
Ravi

