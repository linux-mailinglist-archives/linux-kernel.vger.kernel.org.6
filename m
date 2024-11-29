Return-Path: <linux-kernel+bounces-425209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7479DBEE4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 04:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85E38B20DC9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 03:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEBE42AA5;
	Fri, 29 Nov 2024 03:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="KacfLpah"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020094.outbound.protection.outlook.com [52.101.85.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49CD1C01
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 03:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732850498; cv=fail; b=joOJb6Ik+XAgM/kg260O/j0HQOn39NdePsdP5sbm3Oo1cERMUZtpI3L4SkKWFI9kJX2IT1ArvF/HhreZk/AMrS2jBLX9N1OcRu0Ao36i6lz40rxoDgC2zwzRCWCkcn6MNFXoFrHAiMhUY6JeW8eMItGSiugzOdAtAUAHF1K6L24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732850498; c=relaxed/simple;
	bh=Y60oGfAr/tD6v9OSy5A7sX+SMXx3h8AS7szWuZGMaiU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Myg6bplmM6W3U+meCNokT6Lcd2AeTTHfy75CuGjtKlkJb2jR6BWBABDIf2b2xpXEsJ5p1wrpDTTiYNUN/7n6NiHsxt5o0B6/9CtG9EDARug1aAjGufIsmJdA+eBpHp9E1q0EnSpoi+bQeWKIZoZI9UWvEGHHn0/uXy2DzXv3JaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=KacfLpah; arc=fail smtp.client-ip=52.101.85.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igzQLl4UX30BLYQufhe7Zyy+GLyrR6BFFdr6JZTgRkZqx1baaSBZiNoGc6BeiWqB3EvKClA0Yf8fVSvBbBJjx/KtTdj8hrIGQsGZBqVb01R9fka43du9Z8P/o1D0ui2fP3BwqyH9+B+s3CuQ1thCKBDHfKrTuVj7WPooaUOlZ9TjLyiSGpH/Oq+N4aM873QImTGB6oQoOlL/824Nuft+1MCw23IoegFwQgdwY8AJIOMeqjb8LNlKa++ju1tVbGeUmgKuG9J3C5TZQmS7x+9iOjblOBT0+PgGzLABdxlaz1r2iOg+9ElDIVyxnaxDj5AnBfu2PsS8BorgJ1u5SNlK/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DZH7h89AHY176dq6x/6IwxYg/pWID691vxgQC+lOqk=;
 b=vKJf9pfNEDqSt0CPw+OkjbK+qiwWxP7sgeDbTzOosBbBuGh3xLXg9v801hY/7Dr/DqdqIDoTrJyJAO7JTfRwKUItH8Z/COmqo6XdO0tU0rgStduopmO7kqvpD6WFDZRdeVHDpH8ZyWk/CfPznFDFQFh7lgoBHmhCZMJj/b4CZTN4cWb9H9146T0lyJEZ7qDjF14QYHx462QNsfiPmZ6pCtemz77FlIPEe2du+iHdkWSfmu2sLyCrmPGBMOSQHSrcbV/lZ8JLcUHoOeuQSUVzpbzAjYWURWN5d283ooxeWHNMxTPlJYG0SoBQ03+pTnq149T2Jq8MvBQ8TX+o8KcVLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DZH7h89AHY176dq6x/6IwxYg/pWID691vxgQC+lOqk=;
 b=KacfLpahxK4ngYq+OQHybHR1ADhrM9F7W1DpHFSGGheboFqcYhWN440ioaljAX8aPjmitVI6+ncMhIheoF+ip6EOn72KKXUH2QwjJ04yNwTJZH7Ig3hU3VxJdfqEHHdwK6oxFK2gBxfHypgmgC0XWzkWFbjn5houYBa1leaH4wI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ0PR01MB6445.prod.exchangelabs.com (2603:10b6:a03:2a1::14) by
 CH5PR01MB9056.prod.exchangelabs.com (2603:10b6:610:20e::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.13; Fri, 29 Nov 2024 03:21:31 +0000
Received: from SJ0PR01MB6445.prod.exchangelabs.com
 ([fe80::223:9849:bfff:b119]) by SJ0PR01MB6445.prod.exchangelabs.com
 ([fe80::223:9849:bfff:b119%5]) with mapi id 15.20.8230.000; Fri, 29 Nov 2024
 03:21:31 +0000
Message-ID: <3deb3671-64df-4dd9-a539-3d41009f9875@os.amperecomputing.com>
Date: Fri, 29 Nov 2024 11:21:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] sched/fair: Fix warning if NEXT_BUDDY enabled
To: K Prateek Nayak <kprateek.nayak@amd.com>, peterz@infradead.org,
 mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc: dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
 patches@amperecomputing.com, cl@linux.com, christian.loehle@arm.com,
 vineethr@linux.ibm.com
References: <20241127055610.7076-1-adamli@os.amperecomputing.com>
 <20241127055610.7076-2-adamli@os.amperecomputing.com>
 <670a0d54-e398-4b1f-8a6e-90784e2fdf89@amd.com>
Content-Language: en-US
From: Adam Li <adamli@os.amperecomputing.com>
In-Reply-To: <670a0d54-e398-4b1f-8a6e-90784e2fdf89@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0132.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::36) To SJ0PR01MB6445.prod.exchangelabs.com
 (2603:10b6:a03:2a1::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6445:EE_|CH5PR01MB9056:EE_
X-MS-Office365-Filtering-Correlation-Id: d6d929f7-ac1b-4705-c4bc-08dd1024eb11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aU16ZENWZEQrSkFOc1RlYjg1Tm5EcXQvdWtZMEFWeHRPeHVPUFNmMGRRck5K?=
 =?utf-8?B?OWhvZU5nL3lMVnJDajhtWEs3MXhuVm9FRGM3SHVQR1YxYkJ6MURmTnNOemlj?=
 =?utf-8?B?aG8zaC80RGM0OWZweTNNWjA4L0JEVThHMWlYWENEZXMrM2Y2c1k0Z2wrZ3Bq?=
 =?utf-8?B?Y1BjK1hmeTFCcnp2SnVhL0twMERGa0Vzd3RYZ2JVcTk2OUZwUzFLaXpPeDVF?=
 =?utf-8?B?bUE4QzQrSUFYc3BLT3N0Ly9wVGdON2cra3Y1dGhvOHArNnFzUnV1YXE0enFX?=
 =?utf-8?B?bzJJL0FoU0xqRVFzWXRsc0c3MlIyNkFBWm03aGtEajZxdzVaVXlhclRZTG5E?=
 =?utf-8?B?Nm1tZXFpcmZCWlpxU2twVm9DYlJYeHJwQTVmNUxiMVRTRDVKN2tzNDNZWUVs?=
 =?utf-8?B?N0lxRmorZjNQY0dpZ1FZekE4SXRiblhKZDRTWldYRUVGZVNvSE91RnNkRkp3?=
 =?utf-8?B?dTMwTXlrbzEwUDRCcFRYdnN4RGtVTkNDamJnaWt2ZndBekp6NkRhdXQxd2Nv?=
 =?utf-8?B?TmNvL3U0U081RGp2cWVGbHZSMGlmRWhTUWxTTFJ1bkVxdEhOQXRIaHJmSWVo?=
 =?utf-8?B?bGJvakZpamd1ZHJkWnNWM3JiK1V5U21wazRaQjc4Z0IvTk5oSjZwSnE4TkRF?=
 =?utf-8?B?bEltc05CMGRiYmEwckhPTjhLK1pnMHMwY3cyRU9EeW1UcDkvK01aYnZ5UVM1?=
 =?utf-8?B?bGY5VHowRzFFT1FjVDBnU1c2akMwM3gwTnF3TDhmOVpxYWplclRJbFNYTzlZ?=
 =?utf-8?B?ODVzQitXSkhNVmJIV085cVNEU3BoZmthTmtEY2xsMGFlRHMxL0J5bE8wcFZV?=
 =?utf-8?B?RUdMdU14b2NLY3MvTnBLRDRRVGNsTjl0WVUrM2hXZS93RTBnaUoyK1E4N2tZ?=
 =?utf-8?B?enVibjFWVHVDVFlmaFNBTXNiZm9CenBsUHpTdDQySXBNd1lKRHQzZjdkMWda?=
 =?utf-8?B?OVdQNVErVzFIcngrWHgwODM4WE14b3V0aFd5d3RxWjlQcjhWMXJXMXJtbnkz?=
 =?utf-8?B?a3VUMEQ4NEdrRFR4cHZOYWl6YktkKzQ1ZWM5Wks5ZWpCb3I1bWlOUnMxVzkx?=
 =?utf-8?B?ZEZWUzlmNkZtbzFzZGhWeVJ5eSs4WW9MZFByVTFoQlg2cUR4MktpZldJQlB1?=
 =?utf-8?B?cXNvWHc4UVVqa2l3TFcwNlRBVDdWaDZBMnM0V1E1QTJhWDNMUnJMcy8xQjdO?=
 =?utf-8?B?V05zcXpvbXZESmI2R2pxeERMVStNRi9UaXM2bmpGdS9ZK3lsc1lDMzRJRmF6?=
 =?utf-8?B?WWk2YzloYjJqcnF6SWFRWWxsQzVhMnlnWUVzckEyZU5CazJOdHRnVzVwOUlw?=
 =?utf-8?B?UHBzSWlKY09HNWY4U21Yb0NCK0t4NjQ5SW5GaXh4WGI4U1VsL1RMVGVzOTVL?=
 =?utf-8?B?RkI5dnNZZUJYdUZ4RGlWVXE2UzJZQ1I1RlhIRjd6RGZTQVpJU3RYa2N0L285?=
 =?utf-8?B?bnFTTXFsQytLYURYR2gzeTJ1QnY1MGtFTFBGZXFZK3J2cHRmVUp2Mzd3SDM0?=
 =?utf-8?B?WmdwaUhUdVplVi8rcmoyNlRWaHRDeGpCQVZNdzRUWElGd3RsL1hDMFdCR0xm?=
 =?utf-8?B?UHV1djU5a0NwNTRjUWxWaFprQXVEMEFLcFduK2k0VGt5aFBuNUZpTmhvR1dB?=
 =?utf-8?B?K2VpckEwNjlVemsybU0vMjRuNmtSellha1dwdmt2VkdjdGVOZGh3Y3lBeWl5?=
 =?utf-8?B?bWdKYU5laThnaEpXbmlicExvcHMza29hWlgxQ25IVUI4NUtaKzZzbHBOVUlZ?=
 =?utf-8?B?UXNkYWxqYzRDMFJqT2F6RTRiRlYwZVlTUFhRdGRYNXNFdUxGVE1wNlJmbDl3?=
 =?utf-8?B?c1pZVlFmaFJXdXNPaW5mUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB6445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUFUMFIycUhacXlSUWNJMWVkVjF6VWdBU1JOYjRIK0V0U0pHVmlXcCtzbjZG?=
 =?utf-8?B?azI0QWdoeEdxaVBFOGtjZWZPMWd1NkM1aisxODMxcHpvVDFNVXZYM1hzeVJl?=
 =?utf-8?B?eDdrYmhvM3piandiLzJFMXh5dG5yMHQ4enZiVzBYOUJWcTkvNlgxcGkzdzNH?=
 =?utf-8?B?NG9FVnBJaCtYTEJwdUx6NlhsVWlJTUJpS3pYeHQvUGpEYXlsSENLTmtOa21G?=
 =?utf-8?B?emJRcGhLNC9YK2dVUWJlUDlzOTdacVRSbDRRWE5NQjJiMjJDZGtDeGIxK3dV?=
 =?utf-8?B?blBQYzN5RUpBd2hoWjczaTlTdVBTMXlHZjJkRlQxUDRhb3pSanVDbnVrTkJi?=
 =?utf-8?B?VUtzSUNtSm1nTXAxdnE1U2VLS1NXblM2cHo5a1I4Vk5uV2ZVSjdIOXdDS1Z3?=
 =?utf-8?B?SG0xTmVsNGZNVnBKVWZ1ZzNGbXc0L2hWeWVjNEo2YkVTaWQ1OEZaQUhRMlJC?=
 =?utf-8?B?R1huYUxZNVhZU2RBSVZSYlk3SzUvV2xRaTJER0JlZkNOdldxdE9xZ1AvSmRS?=
 =?utf-8?B?Ym1QK3BWSnBSeHp6dFBlUlQ5M1crWEVpdXdtaVhjZEU5bGZZcUF0VVdEQWNR?=
 =?utf-8?B?WE9SU2JVdXFqZ3dLSHZPSG1OWU1Ic3ZSUXdBZkRFVk1OMGNXT2daanpiMkpH?=
 =?utf-8?B?Qjk4WklVQ2d5SGcyZk40OWtVR2xuK2NZNWNIemJqMWt5THoyK1Z6TXZnQkZm?=
 =?utf-8?B?MWVhUTJYSE5KdWV0dTZjc0kyVXg4VTRhOWk1OTJDQVlka1lkR1l6V1lMdVFO?=
 =?utf-8?B?dG9NeUVYcnFvcm1GWUpKeUd5Tlltbmtoang3ME8xaXZhQkFPMjhSY25KVC9W?=
 =?utf-8?B?TXhMTnRuLzhFVnlnOEpVTmMyWTV2WjRjbkVUWXhIa2p0N3QvRjd6Sk00dFFa?=
 =?utf-8?B?cWZNeHBkR0luNS9UWkRjd3d1WjZwbUF0cjNJcDdLU0wxd3hYdHJDTGpCKzA4?=
 =?utf-8?B?ZnRXWFJuZHNFVjM5SXNhVGZvbUhid0JMSWpzRmJwaHF3UVVRaE12eWpyK0pH?=
 =?utf-8?B?bnVLZEE2T3YyL3hLeTVGbUVqa01qL056bUlWZmxFZ25PV2lpWXgvaXdpM3ZC?=
 =?utf-8?B?QzNWUG51RUtiV3AydHptODNCZHFSRGQ3SW9hcTFOZHFVUytDY1JFYkhiRVVv?=
 =?utf-8?B?SEhzd1ZEdUFCRWRGUHhDOXlYei94Y3NWdngxYkliNHJZQ2ZualhsVEF6eDBH?=
 =?utf-8?B?c0EvWHJxYTFYY1RnT3VpbGZnRG9GckV4dGNGeW1VVVNBejdETDViVHMxbEht?=
 =?utf-8?B?M01vazg2T2MxT2xld29zKzJ1UFBXWlNPS3Jjclp4b0xSVEtoYld0L2MzNmJS?=
 =?utf-8?B?VEV4RVRYZ2d3elc0NjdkVzNNL3BhVWczV3lMb08wYmhJZ1EzaWFqeUxEWnNC?=
 =?utf-8?B?WWFDK1RuMDA0RFJUajh4WUxhZ2p1V3BCaWVsSmxLZ1VMdnArVEJiRkJwcWUx?=
 =?utf-8?B?SHd1YkJYL2tJYjdoT3FkaG56cHl0RElPUUsvT2R3QWorT1R0TlQ2dks2aWdy?=
 =?utf-8?B?NTdKYjY5TVlLT3hHdUpHN3NuWWY5YUE1SmdRQ0JmQWJldVRNSzBwTndQZUVQ?=
 =?utf-8?B?K08ydm8zVWR4RUc3RjNjOUorcnh4OW12OUM4N2crYkJYT1EyRnZLWWlSbExX?=
 =?utf-8?B?KzRyU3dtN3plSFpyM09IMklCWWZDR2xGK0xkTG9tQzVHK29BeGRFWlNBYjBs?=
 =?utf-8?B?Y0tlTm9ha2hKN0dVYkFvbGIrTG1EUUJkd3IxanJGK2xPOEVjWFRIMFpkSFRj?=
 =?utf-8?B?MWg2a2ZTeTl0UnVwak5KVHdqbVdFOG1DeHJ4YmgvUjlzWElFMmtlbVlnVGk2?=
 =?utf-8?B?YWpGZkRjd09PdFdsTkh4TWlWYW5valhTZTA1amdKaTMxMHdOWW9QSU5QMkhE?=
 =?utf-8?B?bk9JNFBOS1FaNjlWelFya1p1cHpsZGVCdEdjbThqNWIyNzJhSklhTVFTLzJJ?=
 =?utf-8?B?QmwxbHRqMkt6OTArYUhiYW1LajdJNWlVWFV4QzJ5SnVFTlZoNVpSWUZXK1hQ?=
 =?utf-8?B?WWdveUtzMjYvbVFJbUdsWFpaS2xTbGt4ZTV6UC9LUjRnaFVYcHFKSkpQQTY1?=
 =?utf-8?B?Q1l6aStmNHI0akIrZ2ZEc3FNQnRWcmV6TkJhQzRtdWpXZG5PTUpqbyt6Znoy?=
 =?utf-8?B?WHY1MjZpcFFPSjlSQW02ZW1scmxONEYwSFVLZUFwYnRoQ25aTndyMFJHOUha?=
 =?utf-8?Q?6hH4ZIAY8nLHGbmhyZeLd8c=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d929f7-ac1b-4705-c4bc-08dd1024eb11
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 03:21:30.9707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3CUOz2DxPNZY3WMXT7BYGGT75+HUiZEHH1mkYiOKIT9+u3AxLtdb06Fa50yI0gFluOuH6jSYzZ+QPOpnYb4tc9S1C0UI8FAJsjoV5rsnZcJdpSLs02VHBKfaa3APn0dB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR01MB9056

On 11/28/2024 3:29 PM, K Prateek Nayak wrote:
> Hello Adam,
> 
Hi Prateek,
Thanks for comments.

> On 11/27/2024 11:26 AM, Adam Li wrote:
>> Enabling NEXT_BUDDY triggers warning, and rcu stall:
>>
>> [  124.977300] cfs_rq->next->sched_delayed
> 
> I could reproduce this with a run of "perf bench sched messaging" but
> given that we hit this warning, it also means that either
> set_next_buddy() has incorrectly set a delayed entity as next buddy, or
> clear_next_buddy() did not clear a delayed entity.
> 
Yes. The logic of this patch is a delayed entity should not be set as next buddy.

> I also see PSI splats like:
> 
>     psi: inconsistent task state! task=2524:kworker/u1028:2 cpu=154 psi_flags=10 clear=14 set=0
> 
> but the PSI flags it has set "(TSK_MEMSTALL_RUNNING | TSK_MEMSTALL)" and
> the flags it is trying to clear
> "(TSK_MEMSTALL_RUNNING | TSK_MEMSTALL | TSK_RUNNING)" seem to be only
> possible if you have picked a dequeued entity for running before its
> wakeup, which is also perhaps why the "nr_running" computation goes awry
> and pick_eevdf() returns NULL (which it should never since
> pick_next_entity() is only called when rq->cfs.nr_running is > 0)
IIUC, one path for pick_eevdf() to return NULL is:
pick_eevdf():
<snip>
	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
		curr = NULL; <--- curr is set to NULL
<snip>
found:
	if (!best || (curr && entity_before(curr, best)))
		best = curr; <--- curr and best are both NULL

	return best;  <--- return NULL

>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index fbdca89c677f..cd1188b7f3df 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -8748,6 +8748,8 @@ static void set_next_buddy(struct sched_entity *se)
>>               return;
>>           if (se_is_idle(se))
>>               return;
>> +        if (se->sched_delayed)
>> +            return;
> 
> I tried to put a SCHED_WARN_ON() here to track where this comes from and
> seems like it is usually from attach_task() in the load balancing path
> pulling a delayed task which is set as the next buddy in
> check_preempt_wakeup_fair()
> 
> Can you please try the following diff instead of the first two patches
> and see if you still hit these warnings, stalls, and pick_eevdf()
> returning NULL?
> 
Tested. Run specjbb with NEXT_BUDDY enabled, warnings, stalls and panic disappear.

Regards,
-adam

