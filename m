Return-Path: <linux-kernel+bounces-336301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC2F97F1D6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 23:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C37C2B20EFC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 21:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CF57E563;
	Mon, 23 Sep 2024 21:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PvL3f3O2"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F16482D8;
	Mon, 23 Sep 2024 21:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727125435; cv=fail; b=l8gSzV895HsYH4SAljxV1RDaRBCvpw1wqKB8iVRPAPB1uu6VBalcTvDLRRJtitXGt9PtQVJd3AZHDrfpBiNCW11v7HBo4pWrubTfSaAO7wmppnXAhb4fj86CaDh2fd/t4sxjmhHYwvzepQI52sJHxLGtl0SpJAddFsrNE0oK4Lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727125435; c=relaxed/simple;
	bh=aeSAeQPQHof38iLEtfJX6W/JPnf23N/Kj3bo1H1a1Ss=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NG4jJE1OQ2UK/v4A4S81mF96cd+hDdNc13OrCrSPQCFH7YBrZNtsaBmnwhhr/kkezMWZot61BNRFQ+c7QeN8Z6+zBwR8wsG+nRSw1yWS7tb6HflIhaRbezyP2qKgMoFHPn6Oih1zUS34BZpK/xrV3L32u/K5juWLEJu8WI39kgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PvL3f3O2; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKZvx1qylv0UqURJoaoSAmgHeW7kvW/2aAObmvef4El7ZHwBIYLYOh1iqJELtuTdieOPXdNk7DWtuLSe79bxxWAqNSOzphtpQsBsg2cShC7Ng42UR25VNO4dJqtJ/DWuIVprQdAgqPUx6gHu/ahjcGBZXC8PdXpqNBfPmdDC/qMMfOx8Slj3Q5Shs0LLLnPDfvRJcA46jhkXO+o1FngkS1k4V+Fd4XTecD5vxKICnVFv+u7VYbdYKcdjhVZVjB4RWdpPXFsIwCJHqugbeTwpH9A8C1f5s37f9p0p7JZhAZMxI6TTD8ktN7fmRQBcvb4i86UubPSmvJQX36KWaBU4Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJFwJy+djDATHaSdhuslDj1i364MaZAFrxLkk6Tsou4=;
 b=q0DPzWO//KuWu04QlrqbnT3nXqEDhYsITSnDXsnHsIVD3KtFYD+L7X/VR25gdHihFCY/oJVLTM+fSiXiRv9NW0CeGonFyUJNlZx6sIQsh8N68Y39uHmPEVizQ2SQPUraONoMq3DKsVZgaNCkg0lXA28gOxdw77X+lltM9lB+zrQtF6+qlTnATsGL2r+6Mw7+DGm8gY1tqHDObxJR3k5fPjKqJQNXJ5oKHWbUKCJjiMqRJy7XhsRPdW1p7dUbLR7DgAwI7ysc2vl1HGy08lPrbY+FBgtk6BDn0cgQtx16oONl5gmfcNXeCrArncAH/CheVoY1a73FLWgMxL4UAJEpxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJFwJy+djDATHaSdhuslDj1i364MaZAFrxLkk6Tsou4=;
 b=PvL3f3O2NBF6IXlhrG1JnmZLgNCHcbMUHAxztRiXS3PazD14Y8+WxAjk4WbjYUqH3JVTBKYvgRtmmNW6Wqly10BEI6OxT2ltdAiRWKPiZy2CKGPQZpIFzh5S4hDYK77rpJ+KihWsQCJORPzfOlMBHGk+en/LwCV58zXKvkyrI9I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.23; Mon, 23 Sep
 2024 21:03:51 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 21:03:51 +0000
Message-ID: <666aa4ae-141f-4625-909a-d905e8f1c66d@amd.com>
Date: Mon, 23 Sep 2024 16:03:46 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 15/24] x86/resctrl: Implement resctrl_arch_assign_cntr
 to assign a counter with ABMC
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
References: <cover.1725488488.git.babu.moger@amd.com>
 <2796f9514d9763d40dffbbfe651541d28bd4d995.1725488488.git.babu.moger@amd.com>
 <710c3d2c-ef18-4534-982c-a62761a09f96@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <710c3d2c-ef18-4534-982c-a62761a09f96@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::20) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MW4PR12MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ba60828-11c2-4bef-14d8-08dcdc1339c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkhTNmJyUFFmUmtianpENWZNbHlHUzNuRUlBU3NENmdSYWpXNi9WS3VVVDlJ?=
 =?utf-8?B?V0swZ3ozanJ5RldVcXlYaG5oUEc4RkFXS2lMMGJsLzRDdmpuU2lpdjkxRDNh?=
 =?utf-8?B?V3dleGsxMUpNaVdhbzFSN1RyOUFFS00rdmRrZTZBL1R6NlpHUGp4SVE1LzRn?=
 =?utf-8?B?MWY5azVVUk9lOHY5c0FBRjdhcVdBN2g2ZGxYWUY4cGtkSUNWZWYybnpSa1JH?=
 =?utf-8?B?UnBTU3drR01CdlJENGUyWHhFemFEcE5KSjUrcWlnS0JkNW0vaUM1UzRnc1Vp?=
 =?utf-8?B?WExKUWVnVHQ5c2FSU09vblpVUjZlODg5WjB5SlQ1RDJUQVJwQmlMNXFRVVhQ?=
 =?utf-8?B?Mi8xbmZLOU4yR2NUNkV1cWVEYWZhOUswK0IvOC9hRm9hMnhCNDFoN01sMERK?=
 =?utf-8?B?cnRLYXFoSjFIV2JSSnA5Z0RORVhHN3hyV2pwMDgrdmRoc0w3R3ZhUmYydjlT?=
 =?utf-8?B?NGVaL3Y1MFR2eldlVExzTjdTL2NPWmxUR0xEZldDMXdBZE1BM1hWbDFQaU1H?=
 =?utf-8?B?ZlRYQy9SRnd0cDQ1eHBjdDJjcWlxcHFHU21nOWlaNEFuRmZ3V3dXVUFzcHNn?=
 =?utf-8?B?M2dSb1pZUEIyeWNQcWJCOXF1QTQzZytzTXBRUnJwUmVmZmM2OW9lWmNmWml2?=
 =?utf-8?B?MTVLMmdwdmhwWHVJTXNNZzdFK1UzaFZ6MFNGd1dvbUI4SmpVSFhlRGt4TFJO?=
 =?utf-8?B?WFIrZSswaGtsMWUwV1hTNWQ4Y2FHcndSaHg5enJObXdPbHZ4S2lNa1ZRWHZu?=
 =?utf-8?B?K2VsMmh4bGk5bG5kcVBZcTBSUjd5MUxEQW1UMElNeDNkUFg3OTlrTnJXcnE1?=
 =?utf-8?B?V2dRTmQ1MDlrUWVtWDFKQ2pacVNZQk1nUW1ZY1VzTHBMWUZOTWY5d3Ryc3pS?=
 =?utf-8?B?LzRWeFpmM1RINzBSdnZUTWliQmswMjF4L3o4SW90VHBLRC9QQXIxU2VzeTN2?=
 =?utf-8?B?aVZaM3o5VkVUd2RodlN4dWtxSkkrYms4V012YlRFV2x1UUZ1WGFtS3krRmxp?=
 =?utf-8?B?aERteFY0VjcyTzdzclFOZUQyNm1xYkZ6L2c2bjY3RnhtN05panRydndOZjZO?=
 =?utf-8?B?b3RKVFdKTEpzRHg5RWsvTXpQcUd3TGRtTS9pT2lCSElYOVdzaDZ1a0V4MHcx?=
 =?utf-8?B?Zm1ENE4rMXprOEdLSUhvYmpXeUh3YVluSHU3d3k2cmpHSktzZkorSTlGeDNV?=
 =?utf-8?B?WkJSWXNoTjluL3c4RGZVYW9adFJUemdrR3RmQmdpcW0yQmVVbUFYR05nWDNR?=
 =?utf-8?B?KzViaklzLzV6NlJKbmxYUlVoNUZLeXFaOGhlNmFQTDRoOHBwM2VudU5yVkla?=
 =?utf-8?B?RHE2WWVVbjVOSERiaVhhWTFQYmVKSnhwUEpDZzJvRi90QW9xMWlLQnE5a1Jz?=
 =?utf-8?B?K0VFeTR3VDZHRm9PUzU3aGpqeDFvclZFUURMTjhpalpaN1RoTVhRa1UweWtS?=
 =?utf-8?B?L1VNb0ZvdXhhQUpqd1NYaU1NUmZoSDJLSVRyMHAyYnV2VXJIdytNTWV5dTYr?=
 =?utf-8?B?RTVwUEUxZlVwNlp5TlRLSUp6YzdGT3NwMG52dDBpWlc4eGZPaWpCU0hSbDB4?=
 =?utf-8?B?TWRUVmJjaURNbi9JcHJhZ2d5bGhnbzJvay9kOUFOUWlXcDFoZHFxUkZpbEUw?=
 =?utf-8?B?S3BrQnEyMGJ6U3NFc2liclR2NVorZGJHZm1YbFNRM1docE9JZ3p2aGZTYXpk?=
 =?utf-8?B?YWZ1Ri9VYnJSZ1pMZVZaa3lZUzFwVEJ6eU9LcnBFaHlUTEpYR1hRM0RnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enFmM3BIMXNJVEpyMHBHQ0owTkloM3BKdDY1S3NXUmdyM1JKcE9pS2swdUxJ?=
 =?utf-8?B?cFh5c083R3l3dkxQaldBZVhyL1V0S3JpVld1MXhJcGtIa2hEaTJDOTZORFZu?=
 =?utf-8?B?ZzdOWXpKU3loUUUrMG16SDdpRjJLbE9RbytqdGZ0T0NKaEhpWkRMUElLRlY4?=
 =?utf-8?B?T25uSmFOd2ptZDRSanltR3NxdmVaeFp2MERHY1RRVzMwTTJGcTYzT2ZxYkl2?=
 =?utf-8?B?aTViL0lQcVNpc1U2MmlLcnN3MjRnUTdPcFdsRFZoUlRXd1ZjbUdweTNJeCs0?=
 =?utf-8?B?QkN6VlhWQ3diRy9scG9wQmxTZWtOZ3JyL1RIeElsM24yRnVVRUdKNDJkdzM0?=
 =?utf-8?B?Rm9LN0c2UlY0QisxaDhWNkNRSnNqZGc0TFNRczFQL0RhNGQwd3JzOU5sQklM?=
 =?utf-8?B?Sk1Odk5NMHpSc0xKbThyd3NNdHFDb1A2SXdzM0ZwZE5JQzd0WXlYZkpxalRM?=
 =?utf-8?B?cDJUeDFZVitmWmUyRkozeFFvRGhuQ0IxS1daYWF1VVQzQURuc2JuZHFOYmV2?=
 =?utf-8?B?Um1FTDcxeHRRaUNacFhhdjZHeU9QK0JrNTUyZjR2YlFXZ1lWV0pMNlZDUVJD?=
 =?utf-8?B?TVdBYTBONFdZcUN0ZEN5c1JIeW9lM2NRRGQ1ZHdZS0s5bFdMbnJoNnI0T2hD?=
 =?utf-8?B?aVBlY0w4UVNqVStVY0hhSTFvQWlGSWZnbTNMWDdGV0VSL2pOU0c1Tkx3MzY4?=
 =?utf-8?B?TXM4cDdOYXEzQm5TRDE2ODIycHFUOFkrWEI2NHpvbzVzL3NtdWdOSng3cnFt?=
 =?utf-8?B?VlF2WHBqNFNsbUNVanY1SmdWei9neEc5UGNETmtNTURJVW9XdmQ3TGZQcURE?=
 =?utf-8?B?SWxHNko2WlJvd1dCU0JhSG1OSVdibzZNcVdVdndFVExFeFd5S3hJWGRLbjYz?=
 =?utf-8?B?a1VZYWpqdVhob3p2OHJQSkROeEJGSlIxZE50U0hYbFQwTHhaUEJVZHQ1ZlZM?=
 =?utf-8?B?UUc0em5peDhWcEhEN09WTXNFeVN5RHJaQUZ3RVAvWHo1SDQxclJ2UnZHZ1JT?=
 =?utf-8?B?c3NwUysxTDBLYkhUdEF0K0JlK3hiSTVuYVJhOXlZUFVuK1B0aG16OU9PODRS?=
 =?utf-8?B?UEpqM0ptQjVNeVFlZ0RUMnJ3c05KYVM4blZ4cHI1VnF1RllRQ2c4L0U5RkpY?=
 =?utf-8?B?eXB6RWpLcE44NWsyZjhYQ1A2aGQxQ3hNL3FDY05NNjhNUUdXVWNLN2J3ZERs?=
 =?utf-8?B?Yjh0R3Vsa2RydHBTYjNMNW1yRVJBbG1vY3FMMkxmb1BXZ1I2Tm5tUFc0VFJJ?=
 =?utf-8?B?YTBEWUtIRmhmOVpoenlvcndKNnFoTEM0cGMrRk5UUE56aU9GMTBPQnFqNzFJ?=
 =?utf-8?B?aGI4RFBibjUwRkZuQTZwbERjb3RvUWsyNTFrSXdnQWJGZUdFL1FISGRlamFS?=
 =?utf-8?B?NFRMM3QvUjNXL1ZrYk9RS1VjUkpLLzVpaFJvOG4vZjRmK3hQb1AzTmc4R2dn?=
 =?utf-8?B?SnBCd09SRnhFWVNFT3BtTWhqcFFqWkw2cFNPbGFkeXd0V3FQaEQzeUhLTDBB?=
 =?utf-8?B?NWdPWk1NWVROcjdXMUQySmpVNEhxeDNIN1htbFNyeHgyVVBSYVpwYVA0ODlK?=
 =?utf-8?B?aCtLeU4vZkY3OGFIRGJ6WWNmRDRoUzJUREh5VUJlUEY3Y2RYbVp1R3ZaZ1ZD?=
 =?utf-8?B?NFpKbkpjTWtWaEhHRUVUMnFPbHhBYTdFaWplbkRFUTZwaWxMNXNtS25tOFNr?=
 =?utf-8?B?N25KVjlEMFE3Mit4azA5eXNhRmllWFl0ayt1TGFiTmxEaksyTkNmNTlGOXBM?=
 =?utf-8?B?VFZ1VEFCZno0ZVJNbEszNS9BOENpRzZnUVZIRVJWbzJKdmFHWDArYzh2d1JX?=
 =?utf-8?B?ZldqZHdtUUlEWFhvYXZtRWc0QnpKVHJmeGlwcXJZSWdpNWZYTnFtOEhUZ0hl?=
 =?utf-8?B?QndwYS9iREdTaU5NTWhzVnMxZzhpUnlHTzFZc0VhOTBXRXNOY0l3TEpKQ04x?=
 =?utf-8?B?bzYxZWJmM0tCMlZOTFRJY0xBV2tiRzJLdTFiMHU5TUFKK2pLN1ZUK1dsVjZH?=
 =?utf-8?B?M29weDZtUlhxNnhlTkZIQTUrOWo3N2ZGMUZhZ0RwTkV2Zjd0d0FZWlBudVgz?=
 =?utf-8?B?RVZmVmcvTHBianRSL3RGWkVzK2ZDdmN5NUpoUkxaTnRrOUJ0NSt5UzAxNDVR?=
 =?utf-8?Q?LOfg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba60828-11c2-4bef-14d8-08dcdc1339c0
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 21:03:51.2558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qwyLh3+ys5ihIBEFnj/bBT1bDWufjoMTkwA50bq83vyZQ9lk7TsUNso1lhhiO60e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6873

Hi Reinette,

On 9/19/24 12:13, Reinette Chatre wrote:
> Hi Babu,
> 
> In subject, please use "()" for a function.

Sure.

> 
> On 9/4/24 3:21 PM, Babu Moger wrote:
>> +/*
>> + * Send an IPI to the domain to assign the counter to RMID, event pair.
>> + */
>> +int resctrl_arch_assign_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>> +			     enum resctrl_event_id evtid, u32 rmid, u32 closid,
>> +			     u32 cntr_id, bool assign)
> 
> Looking ahead this is also called when config of existing assigned counter is
> changed. Should this thus perhaps be resctrl_arch_config_cntr()? 

We have a matching resctrl_arch_assign_cntr() and
resctrl_arch_unassign_cntr() pair.

If we change resctrl_arch_config_cntr() then we need to change
resctrl_arch_unassign_cntr to resctrl_arch_unconfig_cntr().

Should we change both?


> 
>> +{
>> +	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
>> +	union l3_qos_abmc_cfg abmc_cfg = { 0 };
>> +	struct arch_mbm_state *arch_mbm;
>> +
>> +	abmc_cfg.split.cfg_en = 1;
> 
> Just to confirm ... a counter remains "configured" from the hardware side whether it
> is assigned from resctrl perspective or not? It seems to me that once a counter is
> "unassigned" from resctrl perspective it needs no more context about that
> counter, yet it remains configured from hardware side?

That is correct.
When unassigned, we are setting cntr_en = 0, so there is no counting. But
in hardware perspective it is still configured.
-- 
Thanks
Babu Moger

