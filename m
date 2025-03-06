Return-Path: <linux-kernel+bounces-549950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 236F6A558E7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 230093ACED8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA2B207A31;
	Thu,  6 Mar 2025 21:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZDksCtRX"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF3B151990
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 21:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741297054; cv=fail; b=mmwLT6KdSOpFP8LFmjgEHr2WghdEl0eSyBWgMeDxGXGjATbCXWd/q+5uUARPSfsE7YRA/tx5oOZkLhCxc9zlzGALAgUuWNtog67gxE+eZL/fKvP6LA3STdlJhLhyY2/zhl/jpRmMUcqINQL5UfqFRlYoI0RFELqJPVkHJ4N90P0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741297054; c=relaxed/simple;
	bh=C4tshboU4k4/TkhzIKBYTJWdZUPYVI7mPzfu5Y+m+ow=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VgM55aiKPNSZpHxhhylWLR6rhrqTFucf3MLRdjlQvNOllHVZ36DdRF+NC7JuWlxsQVdepMLiy+6d0jiCRZbC9QBjpKLI3W9Iwg++DccPQ8ugx0JZOe1sM9DPVWYwbpRHDtjc0NbCbadm8umZtjXZ3n1azbH/PuzlQwRbK05JSUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZDksCtRX; arc=fail smtp.client-ip=40.107.94.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kGvPs+5F7J0JyrjTr8gkFIRkb2kgFEiOdCdACF6PzhU2QpDVEeDGnhgmdWylIrR5GeZrAJI+fnOf8aU2eKxIsuNNDF3m4BEBmaBhZqzYURmyoTAnNereZ7HgCh7WD77tI/WVClTmOOpJh5lTuaICW8+h7kNrN0keyQKdpH1+Sscr8gyqKMHCuwFc4EKwzDxi+DF3BWcQ0ILhnKkPJk3fkWaLWRlIDV8w6/Gad/ch7AxZQzz84OtykoUyg7gF+U/yVpLCmhimPqqVR3jrYl+EHsOZHcFlw0f8qVsBEw6kcZavzwZrXuOJsCRcNMtD7HRFdhqVesQqqShF3f+44P9RBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4tshboU4k4/TkhzIKBYTJWdZUPYVI7mPzfu5Y+m+ow=;
 b=Kl8dWjLyuWR4Naxqyar0kgtsFlCHS+yMy/OKOBwZocdPvfFJ1RPf5fWXiJDjHSoL5WKQvBkYvgXuRK52HbFOTgpnXsuPy8R26Oh9W5TgyN3ZiBuisUDSlWN0uGloP2RoZDIGfzgxfmxAurJsx1pj/LRHm5P+bZ5n8PyijJVrterinTXbzGq0JNImLta+iGHVQhjvuQli0QWD3AkvFdA+3vFJL9icTRjOg2hjnybHf0upN+PgyvAEa5b+k0gGQSsgYX9McVSpHactQuhF4FallpR0Luzx+9BnCehHU96PsPv2Bz6zBPeRmEr3HFknLRx+m2eR1lDi5SiZf8/PsjkXOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4tshboU4k4/TkhzIKBYTJWdZUPYVI7mPzfu5Y+m+ow=;
 b=ZDksCtRXJwq12a/coO3l1OCSlQvOqZRHq9/FQHM5VfkzzXtTwzvwpzJjjMIaupsul29JjLpldQElfnw0t5AzR+3uXCBVfl+BOuPy7/ifpFd4O5yzrhxL0M+uPA9gNvBNfeDl7iXUJ6o2PNpbehexiLE1phG3qh0KJN8Y+IfEhOzBQHw5npS+3Cgc/ep/PKRyYBueQKrudDpHOwGOe0NUIVh0vBcf65WSd0f/NJASsqSMLcYEjc/RqYbWTbLXH1/XAqpnwmALCctFMzxie6fmGQFmpnv6TLSjTFso8R5VAzHTbh1WVwbYZZEEOwg/WN6POfR6DVLwPICFwERieteANQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 SJ2PR12MB7961.namprd12.prod.outlook.com (2603:10b6:a03:4c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 21:37:30 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 21:37:30 +0000
Message-ID: <074280aa-1e18-48fe-a802-9e6ec4bd04b6@nvidia.com>
Date: Thu, 6 Mar 2025 13:37:28 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 27/49] x86/resctrl: Move RFTYPE flags to be managed by
 resctrl
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-28-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-28-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::14) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|SJ2PR12MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: 128840a9-2ef6-400b-1aa6-08dd5cf71930
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVZ4eXhPVTI3M1F6dG53MzJZajh3R0JDV2txb2FnVG9SclNDeDlPLzRwUTAy?=
 =?utf-8?B?S0FSdElEWndWajU5MXZrVGoyZW9yTzJFaU9tb0VVODlhZldqQk1rYUFwZHEv?=
 =?utf-8?B?WDkveEVMZkN6RnZzWmpaemZpbzVCMEtnaVFjbGVYNXdPakxqOXBSdFZjRUM1?=
 =?utf-8?B?RVdxVEpjV1ErcFlCOWRnMFJmSG50TWh4OGVEUndXbURCRGZld3I0ajRsWWF1?=
 =?utf-8?B?SjBuOE1MUVdDUXpHT08vMHFOYkRyY3V5dmxBajBNVncyNXpzMFFWU0NNcFZ6?=
 =?utf-8?B?REZ6ckpPSGRoODRLenNsczVoMmRQZ1JsVS9hTHhTWnhraWUwMEUzZ0gvMWdk?=
 =?utf-8?B?WVZ2Zy9mTkhycVRYUmhCNTJyVDBTcHgyQkNQZ3pWQlMxa0lwenB2OGNtakdl?=
 =?utf-8?B?V05iWUdZYnB5L2xwQzBOMnVxSDRCY0FabitpK3dGRFhseklNNUp6WU12SUFQ?=
 =?utf-8?B?Z0JlcCtDM095T3JRTGcxT2ZXOEFrOWUxS3FhUUxhU0xwRjhjcnFhblpMdGd1?=
 =?utf-8?B?SnF5TU5Yb1JoZ3VtZS9VSExhUWlCaG5uMG12djhzMEwxUjRXVGtLMHhyQWh1?=
 =?utf-8?B?dGZnUjNKN3FidWllUk4xOFB0SmdLdWpSWHJLOE9RQ05meHRkbkVtOUZaMXBw?=
 =?utf-8?B?djlCcVVzeTZWTEJqS2llRjhaaFRNUUw3cmlOUEg0UXpCcjFESUY2UEFlZTBY?=
 =?utf-8?B?K3ZhR2JjOW5CNHdxYWZvU1pvbkhXUjlmRzBvKzhMT1FQTTdtdGVabnVjSmZE?=
 =?utf-8?B?d2hxVC9FbUFHVUZML0RVOHV2eGhjKzJ5aC92Vlh3UGY5NGtHbGhUV1FxMUMw?=
 =?utf-8?B?NGJmSjdzQW5HaHJSMTQ5UU9LckpSVXkyK1FFa2h1TFAxRW9mc2E4bWliN1Q3?=
 =?utf-8?B?eldSeWVzbkdhSXlsZ1VWcVBCOFdqbThYdUhodVBzUG14QVdpSDNsOWpkcGpv?=
 =?utf-8?B?NG52MzlzSHpScEFVMjMxQWNqRUFIOTlBOUNNNWs4ZFFTOHlHdWw1RGtNQW93?=
 =?utf-8?B?M1ZzazAyWXcxY3pXNlNnNnNFemdsU054cktTanZGNHlKeElDWUo2MGZSTmth?=
 =?utf-8?B?ZlRDN3IzUEpnOGRCbzVxWU5NS0lhMFpYZXRiT0p2dFdUWElwRm1ZMWd3c0JE?=
 =?utf-8?B?c2FncjlETEV5QmtvblhPZE1KTWlhaStGUnFOcWpCKzV6ZFlEVzdMM2VMZ0tO?=
 =?utf-8?B?WDcwelRjU1pxZ2QwWW9IR2g5dHFGWUhTaWZCbWNybXZxUzhweENLN25lcG1X?=
 =?utf-8?B?RUhMWkNZenFvRDMwelozb29YbStNZy9ndTMvdDFDT1M1ektRa05SQ2cvTHBu?=
 =?utf-8?B?UmY3UG5yclpRbmFOY0dEN09VL1JnOXFiSGczVVMyRHd2NHZhdjRLTTlwcERz?=
 =?utf-8?B?a0wza2lsM29ZeXlGdmRRYUdRc2ErNCtwY0cvN3BmbmpjckxZSWJmRmdpNnhU?=
 =?utf-8?B?cHcva3lpaC8zQ2tBOElHMVcxaHFnY0JYYlJ4QmRVeGFUcjVwRE9xWkR3U1lo?=
 =?utf-8?B?T1hUQ3JlRFptQTlRV29CZnlqdTZUSFJxdDZXQmhLSnRYWTgwSlpYK0h6ajYv?=
 =?utf-8?B?MjkzTWJPNGlvOGQ3RFVvVCs2SkNabVMwYUdybm9IRys2T2IyNitZeWN5UU5Z?=
 =?utf-8?B?TzRRL2U5SzhlY0ltVGx6Z29jM3Q3aUZGak1HcnBQcWJzTjJKRmUvczRXUFpx?=
 =?utf-8?B?Mlp6OWZ3OW9HUTRySTh6a2lSSG5OcEJMU0FtakZOR1hVSStHR0RzQmQyd0Zy?=
 =?utf-8?B?TE14ci9lallDQ3M3V2ZWR3E2TFZuNjR4cnJscDM0RTJlVy9IM01YR2M2VHBj?=
 =?utf-8?B?SlpMWFpvcndmRDdnb1d0akVHK1NMbTdzOEE2RitNYXN3Z2xxdmFSTWJ3TTN4?=
 =?utf-8?Q?mSlro4xi7hj7u?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHhLWE93VTk1Z1FKMzZ4ZGRnWjJVMGFJbmp6bjBJV0xybXUyRERNLzRBVW5D?=
 =?utf-8?B?TnNINGQ1ak1CRTgwY3VtU01OU1V0KzBYd1ovcTg0OFRSencvT3BXOUJFWVRu?=
 =?utf-8?B?LzEwT1kwU3ZoOHBENEhmQk1QbTBWcGJuSjA0clNiUExvU05vQjlYWlQ5WDZw?=
 =?utf-8?B?Vm5kVTVZdFUyNlVWZGhrZVF0QVVZeTFjWHlpempqYlJPdjVVKzk2UlF4VUox?=
 =?utf-8?B?QVhwbjAxdStiWGxVdHp6OFJVSUFXaDY3RS96VlB4RGUvT1VVUlM3OXNIeHNC?=
 =?utf-8?B?MksxY0ZuWDdVUHE0aElnN2hZUisyY3MwNUEyVGI0Z1BkSm9tZWhIVmIxRlFt?=
 =?utf-8?B?U1lPUEJ2czJtN29mL2ZxQy9ycjQrZGphQlNIaS9xUHdrUGd5ZzVmQndkdERo?=
 =?utf-8?B?SUxnMGJ3c3JOazU4WEhnSENVcXl2TjlacVo0aWZXZlR3YkRRczNQYzlZdENV?=
 =?utf-8?B?QzU4OVpvQ293Q0U4YUU3d2FYK1NlQngxcXE2Z00rOGZUQ25HUTV2MFBUZUpH?=
 =?utf-8?B?T2kzQTdjNEFDNlZJVDV3NXdJd00yb2QybUZRNjEwOHhIVkMzK0x2Q1c5bmRO?=
 =?utf-8?B?eHhmL21Ra0tBbytwbDJON0lNMUpoM2l3MHp0NndQUmJZTElvY05rWDBHN2Qz?=
 =?utf-8?B?dDZWVk90RGx2UDJJT3NJeDNBbmY1VXp5ckNJNm9rY3EwcUpGK1cvVCtPU3Jj?=
 =?utf-8?B?OUdMaUNnZjhsYytqK3FYdzdkaUVyMWhjTzVWV01HU1BWYzVvdHBTVEl3bTlQ?=
 =?utf-8?B?MTVsUUFXRGR0aGdPdkkvbllHb05DdGo4Zi92RGhtWTVHczNtMFA2UzZJcTB2?=
 =?utf-8?B?WUpTRlBKaHBEekZCb2R3UTUxS0x5NVc1cll0U2I1eWhHUTl5dzBzTDIvV3kx?=
 =?utf-8?B?dTlRK0ZBdm0vQlBTZnVSU2lTTmdlMWF6UkoyRVRuZTZNM0F3NGtHTjJzbXVC?=
 =?utf-8?B?Vk5JcUk5RFo0Y3V1aUhUcmhRV0cvazBYL3pJZzR3bFhVZFRCYUZoeEM3bEpK?=
 =?utf-8?B?OGFkZU5Sck0ra1N3NFEzVzNLQTd0VzgwVzRHcExaTkdLUmlYME4vZnhvekRx?=
 =?utf-8?B?MG9abjBEcUR1SFJlZlRuQ21QcU5UUC9PdFVXME1wNFdpQ1dVL3ZJVElBS0F0?=
 =?utf-8?B?ZVk3ZHR2ZTJySW5mSk1pdmlTUy9uOGRibW52Yng4ZnNONGZONjhIMU1lZThR?=
 =?utf-8?B?alV0Q3lyRUQrbk1QLzVsT1Z2a3E0V1VCcFhocjZaeDVVSjBiZGc3ZkpjT1pP?=
 =?utf-8?B?MWM4b0JsMU9TNDZLMlRuV1B2SFVJbWdkWnZMbnFtcmJWd2Z0Q3hBMEVpbjgy?=
 =?utf-8?B?MFZrSW9VMjN3eGkyV2VqQ3R3RkdFbFR2TnF6bDJucXNFenVEdVJkRG9MVVU2?=
 =?utf-8?B?eUNncndtZ29lM3pHdUwvUDR1c1J0L3VlNnZNcjF2MzJ4b1dINGVXRnBxTHRt?=
 =?utf-8?B?N2dHMjNwakNITmtDc2xpTTlHSm1Xb29Gd1ZRVi9HNFExWUJ2aU9zOXhVdHI3?=
 =?utf-8?B?dndwTEVGL2VIOTlYN1hEMzQ3Yy9lSTgxVEhDbFZFRWZzdWh5dExhTnhrTEFh?=
 =?utf-8?B?REJpc09zSFgvUER1NitMdFJuUWp0UXB1eG5teCtpUTlIZ1hsK1E4VDd1WVhk?=
 =?utf-8?B?U1ZlRE1LSnQ4SXhCeVAzbndPS1A4L2RCSXljanhRSlJDK1Jhbnp4eEgvWk1N?=
 =?utf-8?B?d0o0NjlWTW9yeHRHdVlNdjdoR0JaU2MrRURsV3BraDJaOGFpS1JlSnlkUFR5?=
 =?utf-8?B?ZDdDY1kyTHdVQkVGUndOUnBtaThheC9ZNFlwQ1pwbjFBL2FXMUNpZUpGc2Z4?=
 =?utf-8?B?eEdFQXBNaVZoMHhOWlMvVW1BOEt0WkdtbUpRbFI0MjJ0N0JnU1F4dXpyM2tp?=
 =?utf-8?B?aGlta1V0elhaNFZTcytYVk01a2JVZW85dTAwbVl4bWRFTE9XMlUxWVQ2OTlV?=
 =?utf-8?B?b09lZzVUWmR6QlFRSUovUHlCRnlVV2xSdHM4d0FxdmpqRWlYQ1JFNm1JTERX?=
 =?utf-8?B?S2liNTlWNDJaU0Z0Y2EzYVB2cmRSbGk3eGRhbi8yVThNZDBhZmpKcTNEV3FE?=
 =?utf-8?B?ZkdCNEVMRGVqTC9tam5vU0VHQUFXZ0lnbmRZZlR2c1FZTjhGaGd2Q3lIZFNo?=
 =?utf-8?Q?DLWxJndjWyaE3gvVATsytnA5v?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 128840a9-2ef6-400b-1aa6-08dd5cf71930
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 21:37:30.7244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IDyIH3jqUCOy+lwjdDZoxC6IQvI8D5TLt3dzY9EOErR7m/xm/wwHgEtrgU8bQ478og7PvAC5eFSnZdRvJaiVBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7961


On 2/28/25 11:58, James Morse wrote:
> resctrl_file_fflags_init() is called from the architecture specific code
> to make the 'thread_throttle_mode' file visible. The architecture specific
> code has already set the membw.throttle_mode in the rdt_resource.
>
> This forces the RFTYPE flags used by resctrl to be exposed to the
> architecture specific code.
>
> This doesn't need to be specific to the architecture, the throttle_mode
> can be used by resctrl to determine if the 'thread_throttle_mode' file
> should be visible. This allows the RFTYPE flags to be private to resctrl.
>
> Add thread_throttle_mode_init(), and use it to call
> resctrl_file_fflags_init() from resctrl_init(). This avoids
> publishing an extra function between the architecture and filesystem
> code.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>


Thanks.


-Fenghua


