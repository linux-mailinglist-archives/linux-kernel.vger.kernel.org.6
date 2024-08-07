Return-Path: <linux-kernel+bounces-277880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B251E94A797
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75151C20E3B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF221E4EED;
	Wed,  7 Aug 2024 12:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Ac6prQqC"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2138.outbound.protection.outlook.com [40.107.96.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11191E2861
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 12:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723033051; cv=fail; b=hED+vzSH8ixlLW3d5EzkIlUwYZVlzZ+uJt69/8WksYCGkgz8m4VguTMb3MYhfJjSz2HHJYtqWRyi81T9ukxYCmMsF3lHnBh6NwOaXK4+fnj4BX5JStu7prgvj5BwJP+acrbFKyZqYLRK4YOtqqec818guhyPhbgdY2FtLDc2TY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723033051; c=relaxed/simple;
	bh=5gDS5dDvghCB5thd6IjsnDmqtwOwVwy+KEhf/nAPgNU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Arppa2NW+AqWC8Vqbp4UXeDoo4z3/7pJ3BI/Bha8uP3H+BYcH6DoyqddVD8nYq4l9V0lr0k7fD1QP0QjTieDR5E721E7YT7NWx1H3QoS7P+P67kw0rvGI7Ok6bysIhalUvSYwwSI+N+p8/dCpG1V0a29yvZQuglLdErRhafgpEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Ac6prQqC; arc=fail smtp.client-ip=40.107.96.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJOPbZIphm2ELt4o+AMCA05bq/ng8Y8CHt+nH7+Dp1Fuj42uLP6zpM0yH48zJZGukUzdZxt6kFxVk07e21kEe80tDjnNqE0m9odf8XUm9vWXdCce6+lWqbnO25gObuWXKp+SSMlgGJ9znlOgoBVO+HFigCrsZ4vqr6IDtvZcqB/D0tgn6f4c9SiXz/Hvv4naSVYp3WKBPd/StZlRMeHtLRKB3T6NwffGW1eeDhWZX2nT7uU2iGRsNBs9ZQayap0Rl4RFVR8yfLnUJyjUtGwC2PWMb5zYOl+sVeBUhT9/KYz0aOqUGSlAmQrxXpqXXB2kkUglCUlLeUno0o5UzxtsAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTmUtgh5iyr4IzSrjApQPWkJrPDI+dNKH3brxfTW18Y=;
 b=oThMHA0GIzZvlFAR4NtrZLt+FaRC3RLjq8yNj1sNs7a69ocx3hekzZ+0u/gM5gUHLKDCuYy8wkUpUcRMhDJFnBwS+Gs0zUzC1fYWMYvKH772gwVeKam108a83k/UZXLIxye7Odg0pyzpbCcPyr4oPSCKcnhyKqDAvXyCOFJH0NKRieCzF30DQQkg5rWPbwGz9UEFmN3LfjDCT9uaN7tNT30mGDqbUnmgvlp0/5MfScJFjhNHlrOvkH+l1HKLpoWHqUQELO5IPZEjijVoiqlceBvZ8txtfibq0Z+et/XsY9CnowZRS1eMvXFVcWDgFE2O343pKmD98Zz8YRomNABQaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTmUtgh5iyr4IzSrjApQPWkJrPDI+dNKH3brxfTW18Y=;
 b=Ac6prQqC0Nr5WlaRLPgkybm5go7GE8Nlo7zmntNYCgRrKh8GGycHG3hh8SIXxKl5nhHpmNJrmyviyKvS0Hom5oWFIuSBsAeA8V/rp2hEPdSjIPmxi+8Sf+N78/NZofTjcrN1gY7wFBR2KZvGTklvjdbOHQKXmf37jloDYR9mVsY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 DS7PR01MB7757.prod.exchangelabs.com (2603:10b6:8:7c::19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.13; Wed, 7 Aug 2024 12:17:23 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%3]) with mapi id 15.20.7828.021; Wed, 7 Aug 2024
 12:17:23 +0000
Message-ID: <3d7a6f93-0555-48fa-99cb-bf26b53c2da5@os.amperecomputing.com>
Date: Wed, 7 Aug 2024 17:47:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf scripts python arm-cs-trace-disasm.py: Skip disasm
 if address continuity is broken
To: James Clark <james.clark@linaro.org>, scclevenger@os.amperecomputing.com
Cc: acme@redhat.com, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 darren@os.amperecomputing.com, james.clark@arm.com, suzuki.poulose@arm.com,
 Leo Yan <leo.yan@arm.com>, Al.Grant@arm.com,
 Mike Leach <mike.leach@linaro.org>
References: <20240719092619.274730-1-gankulkarni@os.amperecomputing.com>
 <7302367c-311f-4655-9a83-3c4034c50086@linaro.org>
 <6920de94-a9c8-47f4-840f-391d1ec85c0c@os.amperecomputing.com>
 <8f6f221b-4c9a-42e1-b8ce-1f492caee184@linaro.org>
 <0a697a54-5dd8-4351-a651-991724690db2@os.amperecomputing.com>
 <ce4af204-874f-404c-a7aa-42dc6693d072@linaro.org>
 <a197123a-be59-4052-9615-cac79ffa357a@os.amperecomputing.com>
 <543813f6-cb1f-4759-b26f-75246750814d@linaro.org>
 <f72038a0-c6b5-4245-8515-3b735ca38cbb@linaro.org>
 <ae1b2d8c-588a-4f0a-b3c9-c869f8dd0f25@os.amperecomputing.com>
 <00fac24c-d664-4ebb-8c60-f4697b7f76c1@linaro.org>
 <8b53a424-19f7-4042-a2db-e1c5d051f9cc@os.amperecomputing.com>
 <6adf84fa-b755-4d7a-957a-9bf01e442238@linaro.org>
 <d71dff17-6f1e-4a67-89c6-7ecc86af0f3a@linaro.org>
 <6f535bb6-2cee-48e6-93f1-ea19887bae74@os.amperecomputing.com>
 <027c76a9-9bd4-43e9-a170-8391a0037291@linaro.org>
Content-Language: en-US
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <027c76a9-9bd4-43e9-a170-8391a0037291@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0061.apcprd02.prod.outlook.com
 (2603:1096:4:54::25) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|DS7PR01MB7757:EE_
X-MS-Office365-Filtering-Correlation-Id: 672476a0-d947-4975-d1d7-08dcb6dae44a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0pYUjBaYzNxL0t5czhrMlRXU1A0eGhEVFJ5RFV2K1dvK2I0OGprUHFaalEw?=
 =?utf-8?B?MjVEcGM5S29QSklqZ3h5RkFNcG9CdDJvQ0piNDVFUUIzQTFyUE5sbnh1cmpM?=
 =?utf-8?B?Ly9UL2NraGc0NlNYRHNmamNRd1dxWTY4bVhRaFJzSzhCZGc2ZEJVNGpORlRw?=
 =?utf-8?B?RnlDRlRNUERmTFZ6RnN3QVpzM1hLOXlUOENzWHpDVDVzbnZuNWFtdDR5allo?=
 =?utf-8?B?QStoUyttbWJ1cS9jVGRNSU9jcWRpVGk0bDBaUUU1eU9IQlFVVVdNaGk1dTlV?=
 =?utf-8?B?cThiUmpRRjdIRTRJR3RKN0FLaEZIbW5OSUNkd2JzWThhOTFQTnNZTThqYTRk?=
 =?utf-8?B?dlBlQ056K0FMbHM5TXAyVlh3eHNSc0lSUU9CYWVNV1FkdzE1TWlVRm8zN1FV?=
 =?utf-8?B?bjFBZ2ZlMEEwZENGSnBCYkJiaWRmaE1hdVhjd3JDQ1k4ejNpd1dSSUIxSEdy?=
 =?utf-8?B?dmZrQjh3QVBQa3lwc0JvNTdmaWhuWDh4KzRLZWRCV2tGMjVvaUFHT0MrT0JK?=
 =?utf-8?B?VkRIMEJSdElWb0dyUkpMVjhPTDVHR1NlQzBzUWFmV2NtMWMvT1RFWDNyRGlP?=
 =?utf-8?B?ZS9DWHlBODAvMVRmeFk3ZGZtbGlpVDZxUlVSSkpqT3RXcXJlcE9Oa2hSbEpC?=
 =?utf-8?B?NW9oVytPd2ZVVnR4ZnRtMXBRU0l1TStVUkcveENuT0VLSllsNmhHZU9DQ2JF?=
 =?utf-8?B?ZGFLbWIwTk02bm42UFZVSlgvM2NrbFBiR1lDMm03YWtyQm9MRzJ3WFl2Z1Zw?=
 =?utf-8?B?dllQTFd0RCtPeWRtYWJlSmV0bDRJME55dURJUTZVZVVyZDF3ZmN4MGJ0T3hj?=
 =?utf-8?B?VUszOTlVUzVWSnhmUkVSZW5tTXZaQmVoZmdlSVZhNVZqQWZaUnliS3ZPTmZa?=
 =?utf-8?B?b3hFYzdGcTR4VXIxWTlPRWFQNWtramJvTnpwajg5NThKakduZkFUQ1haTGIz?=
 =?utf-8?B?UElHWGFXWWRiaFYvU09HNVAxdVNYSTlmQ2RBUTFCTnB3WUtlVnEyc1VwSWFH?=
 =?utf-8?B?ZUo3OUZJOGFHeWFPSUt4cWlCdDVoeUdsdlluUHB6SnpHWU9BN2M2RCsyUGlz?=
 =?utf-8?B?RTIvQTFOSVEyeFk5OEIxYUgwUXBzR0w0bEp6V0hGbkcydm1uak5zYXVvWWJh?=
 =?utf-8?B?RSs4Q25TTm01V3UydGpTV2tLSHM2aTErNnh2TVprclJzYklMVExWUnluVGpD?=
 =?utf-8?B?aWIyMk0xK3ZZbFZZdkhFUkFRRUFmNkZhWHovWFRTRlp1VitYb1BXays5Smlm?=
 =?utf-8?B?SGRKM3ZZdlNhNWlNS1NuTmk4c01RZ0Q1OUdHdFUxdEVPUUtqM1JPZjJLazRI?=
 =?utf-8?B?cWlnaHJDMlJhSHhOemRnWlFobjhRMy9QQzZJRGQrbExZRDczejJtTnZaaERp?=
 =?utf-8?B?NzFEL3c3WFpSeFQ3QTVsK3I5MVh2SWhKVXN6elB2OC9rUWZDcHI5QmRReHRK?=
 =?utf-8?B?aCs3YVhEK2V6WktmSkVuaDFZK056Wjdnak1FWEYxN2F0WDZWanZQR2RnN3pP?=
 =?utf-8?B?SHBLOVl2K2FIanA5V3VIaDhHNk5maCtwdlBGV1RIOS8zSlN5bVE1UmdpS3hU?=
 =?utf-8?B?dVpzZjlJamRFSlhCRUg3WkJKTVlheHBJRWV3bzc3VVNvRWEyQlJ4eDR6TUNU?=
 =?utf-8?B?SUpoNEoyZ3ZpS29SaDV6Y2d3MlZzL01udlNHSlFUUno0ZU9tQi9IUXhtLzFW?=
 =?utf-8?B?R2tFcXdFOXRpdmR4bk1ZNnZiY2Y2dnVBeFVRdWZYL1F3TEVzS214U3M0RmJw?=
 =?utf-8?Q?uSMN66IBq3LLEYz3cA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0taSGRqRytiV0FKQllsMTNhMld6TVRhcFAvZm9YWGFQdWE4VUladXoxbGcw?=
 =?utf-8?B?WlVhNWdXRnFMQUtGS0ZzR2hmN29TNFlHRzlHRUxYREwvVkhYRUJjOHRobDBu?=
 =?utf-8?B?NWhCRC9UeHBaT1BrVERaRjlLbWlpUUtKbmNLTTJhbjdYZjhoc2VQSzNwVXJn?=
 =?utf-8?B?YjU0NUkxNmFOQVNpbnRkbG9uYWEycjk1cTVwaS92aW5NZ1k3aW1hcytxZ0Mr?=
 =?utf-8?B?dGZHYmFjMEhNT3IxVHdLLzRDbkVJeDRCeHIrMUdtQ0NMQlA2a3RhT25FQWE0?=
 =?utf-8?B?cjdlSVdJTnpvTVNtNVAwcmw4S2FmdW9wSzlEYjhrTWJVaEVCRy9SclJHcGdo?=
 =?utf-8?B?VkE2RU92Um9EOHJRdVN2QWN2eWVQeXJCdDRlbEdISThQaTJhNzFyd0crR2Rz?=
 =?utf-8?B?eWRVaTFxWTF0WmRUVmIzWVZqMFlWalpyMDQ0cXBKSFR2ZzRsWnowMnNJSHZh?=
 =?utf-8?B?cDhwbG1raU40NDdrRHdFS01oZnhoUnZGeW9NdUdmK01wR21QbS9HRFJlb1lj?=
 =?utf-8?B?d0hzVXlhaERsS21LZXZBaEdHak9WM2VOU0Fob3llMDVMMXRlaGpCQzZ3Rzdn?=
 =?utf-8?B?VXhpSzdJQmRCOU9RV09PTjZDYmhrMDBEOHRJZmlTcUNSdWhURkdlMUhGYUJj?=
 =?utf-8?B?R1pwVnNJZnZlaElsYTd5amxkMnBOZGtVKzFUT3dMV2ZsZkZCeUkvaWxJRUY5?=
 =?utf-8?B?c25tUU0vcm1wT2FhaVFzTzdOdUF0ZERQbS93RTlBQnZHTm5NMzhrNjFrN0FP?=
 =?utf-8?B?cFBVWHFkcjViM2szeWMvZm1IY0pXUVJsRGJUTnIwQ0UyekppWkI2ZDZJRDRt?=
 =?utf-8?B?ektYclo3eWJDZGt0WGJaOURGOW85OHRSOTh2em9RZTFMS2cyUjFRQmRNSjQ0?=
 =?utf-8?B?UlQyUWdENkNiNHNSa3o2c3o0SDRpTkdaWEJTTGJLMXptek1ac2hhUzJ5c01K?=
 =?utf-8?B?eUxFaURJeHVOem9sY2FFb1JUcUJsUnh4c2tsTHIxUlAwUm9sNGs2a1dZNTdm?=
 =?utf-8?B?RGU2TGdiUkh1UDF5dGJwUjZsZVBYM1Q3OHVaWUlLTWNMMVFTQk81UzFHMGhT?=
 =?utf-8?B?L3pPWmtjNUdFU09yYlBORjFDTVhuYlZkOUNNeUhPc1lybUtpYU1vTE9wcjM5?=
 =?utf-8?B?cnZXMU1qR0VXS2JyMGx1V2pRT3dvNjE1dm5Wc05XN21aeis2cFdXc3ZHbHdQ?=
 =?utf-8?B?cjE2bW5FQW1XWG9OUjhRQkoxYy9MSWs4Zm1YZzY3YzVERURLa1UzbVpuS0F1?=
 =?utf-8?B?T2xlU3dUYnpTOHNUcll3VEhLVmo3eFpoN1l0SHJ1V1hIbm5wT3pBZkJYQllY?=
 =?utf-8?B?WHluUWl1a1ZMMDZmb0lWMHZTWm43WURwRzZxYWNrMXV5ME90UXRQMFRFU09n?=
 =?utf-8?B?WDlEQ3FSN2NqNEtzaXA1eHpyT1ltWGNUdDZJdi9lOG9YZ25sYnVxL040K3JF?=
 =?utf-8?B?cTU2SUhIRkJ5bnpQTkIyMWd2cWZsWDFXQkFLWHpzSzJVaWVtR3pqOUdEc2x1?=
 =?utf-8?B?elJsUkJzdThWWTNWTzR0c3B2eWN2Y1ZiRXJFVTBqTFpvMDB2UzJEa3F1ZEVv?=
 =?utf-8?B?a3NnZnhBYk5CalhRWmhIdVcyLy9LU3JYTkkxbTlmRGkrSUZxVksxVVZydHVk?=
 =?utf-8?B?TlJuRHViVXpsWFhKbFNMemk1SFJBTGJzRmFYYlZnQ0pIZ3NkN24wUTZ0cXdB?=
 =?utf-8?B?Z0o4aVhHMUx2V0dIeTRodmFHNHV3OEtIUHRoMHpXYVdkSkRrRkxIOFlkTDdk?=
 =?utf-8?B?QXpnWWdhb0c1bUpGdmllbmpzR085SGZKNUIvd2xXOGpTVmZwSkhFSzdHVUdk?=
 =?utf-8?B?RGtyN2NLV2F1Y1phRG9Fd1UxL0VFZkhTNHJWb2E2aG5nTzM4U29wMkplb0VF?=
 =?utf-8?B?MWJsQ2diZGxYdVpaaHN6RWxsQ2l4UVJDMWxUa2lYbzVZWC9xTnN2ZVBUaWpv?=
 =?utf-8?B?US96TllUamExa2ZhU1NDOUJIV0FJeDhGUkFKSTdHWmhBZHd1NmZ1dG55UXo2?=
 =?utf-8?B?UG1Wd2owWWd2cUVEaldFY0dVZlZoY1V0NWcvaFAwNjJvTzRRSVF4WkZQMTkw?=
 =?utf-8?B?bnd4dUlKalMzRkRmTEJVMHBOcUlLTFg3b2tuNVdteE94TnZISW84T2N4cTk1?=
 =?utf-8?B?TTM3ZzJyNzFNTzZUeGs2dDhkRmM4VDAyaXFuRDBBbjIvNGc2aHgxVFMzTmZV?=
 =?utf-8?Q?8xP/kUPzsYuJdsN08SVQt6E=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 672476a0-d947-4975-d1d7-08dcb6dae44a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 12:17:23.2092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JnUSxToqprGx/xpBDFMAqafRY77ZWZ+w8jtFa9VCZXk39rOz635FBxKNS6J9Tsc8sTSN+H1/1ZbfpAWcPTYfsn1nvTqOhVtCZQTEz0ffc4s6T55jj1ZzXZHv1qTpA4Fg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB7757



On 06-08-2024 09:44 pm, James Clark wrote:
> 
> 
> On 06/08/2024 4:02 pm, Steve Clevenger wrote:
>>
>>
>> On 8/6/2024 2:57 AM, James Clark wrote:
>>>
>>>
>>> On 06/08/2024 10:47 am, James Clark wrote:
>>>>
>>>>
>>>> On 06/08/2024 8:02 am, Ganapatrao Kulkarni wrote:
>>>>>
>>>>>
>>>>> On 05-08-2024 07:29 pm, James Clark wrote:
>>>>>>
>>>>>>
>>>>>> On 05/08/2024 1:22 pm, Ganapatrao Kulkarni wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 01-08-2024 03:30 pm, James Clark wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 24/07/2024 3:45 pm, James Clark wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 24/07/2024 7:38 am, Ganapatrao Kulkarni wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 23-07-2024 09:16 pm, James Clark wrote:
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> On 23/07/2024 4:26 pm, Ganapatrao Kulkarni wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> On 23-07-2024 06:40 pm, James Clark wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> On 22/07/2024 11:02 am, Ganapatrao Kulkarni wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Hi James,
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On 19-07-2024 08:09 pm, James Clark wrote:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On 19/07/2024 10:26 am, Ganapatrao Kulkarni wrote:
>>>>>>>>>>>>>>>> To generate the instruction tracing, script uses 2
>>>>>>>>>>>>>>>> contiguous packets
>>>>>>>>>>>>>>>> address range. If there a continuity brake due to
>>>>>>>>>>>>>>>> discontiguous branch
>>>>>>>>>>>>>>>> address, it is required to reset the tracing and start
>>>>>>>>>>>>>>>> tracing with the
>>>>>>>>>>>>>>>> new set of contiguous packets.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Adding change to identify the break and complete the
>>>>>>>>>>>>>>>> remaining tracing
>>>>>>>>>>>>>>>> of current packets and restart tracing from new set of
>>>>>>>>>>>>>>>> packets, if
>>>>>>>>>>>>>>>> continuity is established.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Hi Ganapatrao,
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Can you add a before and after example of what's changed to
>>>>>>>>>>>>>>> the commit message? It wasn't immediately obvious to me if
>>>>>>>>>>>>>>> this is adding missing output, or it was correcting the
>>>>>>>>>>>>>>> tail end of the output that was previously wrong.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> It is adding tail end of the trace as well avoiding the
>>>>>>>>>>>>>> segfault of the perf application. With out this change the
>>>>>>>>>>>>>> perf segfaults with as below log
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> ./perf script
>>>>>>>>>>>>>> --script=python:./scripts/python/arm-cs-trace-disasm.py --
>>>>>>>>>>>>>> -d objdump -k ../../vmlinux -v $* > dump
>>>>>>>>>>>>>> objdump: error: the stop address should be after the start
>>>>>>>>>>>>>> address
>>>>>>>>>>>>>> Traceback (most recent call last):
>>>>>>>>>>>>>>     File "./scripts/python/arm-cs-trace-disasm.py", line 271,
>>>>>>>>>>>>>> in process_event
>>>>>>>>>>>>>>       print_disam(dso_fname, dso_vm_start, start_addr,
>>>>>>>>>>>>>> stop_addr)
>>>>>>>>>>>>>>     File "./scripts/python/arm-cs-trace-disasm.py", line 105,
>>>>>>>>>>>>>> in print_disam
>>>>>>>>>>>>>>       for line in read_disam(dso_fname, dso_start,
>>>>>>>>>>>>>> start_addr, stop_addr):
>>>>>>>>>>>>>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>>>>>>>>>     File "./scripts/python/arm-cs-trace-disasm.py", line 99,
>>>>>>>>>>>>>> in read_disam
>>>>>>>>>>>>>>       disasm_output =
>>>>>>>>>>>>>> check_output(disasm).decode('utf-8').split('\n')
>>>>>>>>>>>>>>                       ^^^^^^^^^^^^^^^^^^^^
>>>>>>>>>>>>>>     File "/usr/lib64/python3.12/subprocess.py", line 466, in
>>>>>>>>>>>>>> check_output
>>>>>>>>>>>>>>       return run(*popenargs, stdout=PIPE, timeout=timeout,
>>>>>>>>>>>>>> check=True,
>>>>>>>>>>>>>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>>>>>>>>>     File "/usr/lib64/python3.12/subprocess.py", line 571, 
>>>>>>>>>>>>>> in run
>>>>>>>>>>>>>>       raise CalledProcessError(retcode, process.args,
>>>>>>>>>>>>>> subprocess.CalledProcessError: Command '['objdump', '-d',
>>>>>>>>>>>>>> '-z', '--start-address=0xffff80008125b758',
>>>>>>>>>>>>>> '--stop-address=0xffff80008125a934', '../../vmlinux']'
>>>>>>>>>>>>>> returned non-zero exit status 1.
>>>>>>>>>>>>>> Fatal Python error: handler_call_die: problem in Python
>>>>>>>>>>>>>> trace event handler
>>>>>>>>>>>>>> Python runtime state: initialized
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Current thread 0x0000ffffb05054e0 (most recent call first):
>>>>>>>>>>>>>>     <no Python frame>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Extension modules: perf_trace_context, systemd._journal,
>>>>>>>>>>>>>> systemd._reader, systemd.id128, report._py3report,
>>>>>>>>>>>>>> _dbus_bindings, problem._py3abrt (total: 7)
>>>>>>>>>>>>>> Aborted (core dumped)
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Signed-off-by: Ganapatrao Kulkarni
>>>>>>>>>>>>>>>> <gankulkarni@os.amperecomputing.com>
>>>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>>>    tools/perf/scripts/python/arm-cs-trace-disasm.py | 10
>>>>>>>>>>>>>>>> ++++++++++
>>>>>>>>>>>>>>>>    1 file changed, 10 insertions(+)
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> diff --git
>>>>>>>>>>>>>>>> a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>>>>>>>>> b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>>>>>>>>> index d973c2baed1c..ad10cee2c35e 100755
>>>>>>>>>>>>>>>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>>>>>>>>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>>>>>>>>> @@ -198,6 +198,10 @@ def process_event(param_dict):
>>>>>>>>>>>>>>>>            cpu_data[str(cpu) + 'addr'] = addr
>>>>>>>>>>>>>>>>            return
>>>>>>>>>>>>>>>> +    if (cpu_data.get(str(cpu) + 'ip') == None):
>>>>>>>>>>>>>>>> +        cpu_data[str(cpu) + 'ip'] = ip
>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Do you need to write into the global cpu_data here? Doesn't
>>>>>>>>>>>>>>> it get overwritten after you load it back into 'prev_ip'
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> No, the logic is same as holding the addr of previous packet.
>>>>>>>>>>>>>> Saving the previous packet saved ip in to prev_ip before
>>>>>>>>>>>>>> overwriting with the current packet.
>>>>>>>>>>>>>
>>>>>>>>>>>>> It's not exactly the same logic as holding the addr of the
>>>>>>>>>>>>> previous sample. For addr, we return on the first None, with
>>>>>>>>>>>>> your change we now "pretend" that the second one is also the
>>>>>>>>>>>>> previous one:
>>>>>>>>>>>>>
>>>>>>>>>>>>>     if (cpu_data.get(str(cpu) + 'addr') == None):
>>>>>>>>>>>>>       cpu_data[str(cpu) + 'addr'] = addr
>>>>>>>>>>>>>       return  <----------------------------sample 0 return
>>>>>>>>>>>>>
>>>>>>>>>>>>>     if (cpu_data.get(str(cpu) + 'ip') == None):
>>>>>>>>>>>>>         cpu_data[str(cpu) + 'ip'] = ip <---- sample 1 save but
>>>>>>>>>>>>> no return
>>>>>>>>>>>>>
>>>>>>>>>>>>> Then for sample 1 'prev_ip' is actually now the 'current' IP:
>>>>>>>>>>>>
>>>>>>>>>>>> Yes, it is dummy for first packet. Added anticipating that we
>>>>>>>>>>>> wont hit the discontinuity for the first packet itself.
>>>>>>>>>>>>
>>>>>>>>>>>> Can this be changed to more intuitive like below?
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>>>>> b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>>>>> index d973c2baed1c..d49f5090059f 100755
>>>>>>>>>>>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>>>>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>>>>> @@ -198,6 +198,8 @@ def process_event(param_dict):
>>>>>>>>>>>>                   cpu_data[str(cpu) + 'addr'] = addr
>>>>>>>>>>>>                   return
>>>>>>>>>>>>
>>>>>>>>>>>> +       if (cpu_data.get(str(cpu) + 'ip') != None):
>>>>>>>>>>>> +               prev_ip = cpu_data[str(cpu) + 'ip']
>>>>>>>>>>>>
>>>>>>>>>>>>           if (options.verbose == True):
>>>>>>>>>>>>                   print("Event type: %s" % name)
>>>>>>>>>>>> @@ -243,12 +245,18 @@ def process_event(param_dict):
>>>>>>>>>>>>
>>>>>>>>>>>>           # Record for previous sample packet
>>>>>>>>>>>>           cpu_data[str(cpu) + 'addr'] = addr
>>>>>>>>>>>> +       cpu_data[str(cpu) + 'ip'] = stop_addr
>>>>>>>>>>>>
>>>>>>>>>>>>           # Handle CS_ETM_TRACE_ON packet if start_addr=0 and
>>>>>>>>>>>> stop_addr=4
>>>>>>>>>>>>           if (start_addr == 0 and stop_addr == 4):
>>>>>>>>>>>>                   print("CPU%d: CS_ETM_TRACE_ON packet is
>>>>>>>>>>>> inserted" % cpu)
>>>>>>>>>>>>                   return
>>>>>>>>>>>>
>>>>>>>>>>>> +       if (stop_addr < start_addr and prev_ip != 0):
>>>>>>>>>>>> +               # Continuity of the Packets broken, set
>>>>>>>>>>>> start_addr to previous
>>>>>>>>>>>> +               # packet ip to complete the remaining tracing
>>>>>>>>>>>> of the address range.
>>>>>>>>>>>> +               start_addr = prev_ip
>>>>>>>>>>>> +
>>>>>>>>>>>>           if (start_addr < int(dso_start) or start_addr >
>>>>>>>>>>>> int(dso_end)):
>>>>>>>>>>>>                   print("Start address 0x%x is out of range [
>>>>>>>>>>>> 0x%x .. 0x%x ] for dso %s" % (start_addr, int(dso_start),
>>>>>>>>>>>> int(dso_end), dso))
>>>>>>>>>>>>                   return
>>>>>>>>>>>>
>>>>>>>>>>>> Without this patch below is the failure log(with segfault) for
>>>>>>>>>>>> reference.
>>>>>>>>>>>>
>>>>>>>>>>>> [root@sut01sys-r214 perf]# timeout 4s ./perf record -e
>>>>>>>>>>>> cs_etm// -C 1 dd if=/dev/zero of=/dev/null
>>>>>>>>>>>> [ perf record: Woken up 1 times to write data ]
>>>>>>>>>>>> [ perf record: Captured and wrote 1.087 MB perf.data ]
>>>>>>>>>>>> [root@sut01sys-r214 perf]# ./perf script
>>>>>>>>>>>> --script=python:./scripts/python/arm-cs-trace-disasm.py -- -d
>>>>>>>>>>>> objdump -k ../../vmlinux -v $* > dump
>>>>>>>>>>>> objdump: error: the stop address should be after the start
>>>>>>>>>>>> address
>>>>>>>>>>>> Traceback (most recent call last):
>>>>>>>>>>>>     File "./scripts/python/arm-cs-trace-disasm.py", line 271,
>>>>>>>>>>>> in process_event
>>>>>>>>>>>>       print_disam(dso_fname, dso_vm_start, start_addr, 
>>>>>>>>>>>> stop_addr)
>>>>>>>>>>>>     File "./scripts/python/arm-cs-trace-disasm.py", line 105,
>>>>>>>>>>>> in print_disam
>>>>>>>>>>>>       for line in read_disam(dso_fname, dso_start, start_addr,
>>>>>>>>>>>> stop_addr):
>>>>>>>>>>>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>>>>>>>     File "./scripts/python/arm-cs-trace-disasm.py", line 99, in
>>>>>>>>>>>> read_disam
>>>>>>>>>>>>       disasm_output =
>>>>>>>>>>>> check_output(disasm).decode('utf-8').split('\n')
>>>>>>>>>>>>                       ^^^^^^^^^^^^^^^^^^^^
>>>>>>>>>>>>     File "/usr/lib64/python3.12/subprocess.py", line 466, in
>>>>>>>>>>>> check_output
>>>>>>>>>>>>       return run(*popenargs, stdout=PIPE, timeout=timeout,
>>>>>>>>>>>> check=True,
>>>>>>>>>>>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>>>>>>>     File "/usr/lib64/python3.12/subprocess.py", line 571, in 
>>>>>>>>>>>> run
>>>>>>>>>>>>       raise CalledProcessError(retcode, process.args,
>>>>>>>>>>>> subprocess.CalledProcessError: Command '['objdump', '-d',
>>>>>>>>>>>> '-z', '--start-address=0xffff80008125b758',
>>>>>>>>>>>> '--stop-address=0xffff80008125a934', '../../vmlinux']'
>>>>>>>>>>>> returned non-zero exit status 1.
>>>>>>>>>>>> Fatal Python error: handler_call_die: problem in Python trace
>>>>>>>>>>>> event handler
>>>>>>>>>>>> Python runtime state: initialized
>>>>>>>>>>>>
>>>>>>>>>>>> Current thread 0x0000ffffb90d54e0 (most recent call first):
>>>>>>>>>>>>     <no Python frame>
>>>>>>>>>>>>
>>>>>>>>>>>> Extension modules: perf_trace_context, systemd._journal,
>>>>>>>>>>>> systemd._reader, systemd.id128, report._py3report,
>>>>>>>>>>>> _dbus_bindings, problem._py3abrt (total: 7)
>>>>>>>>>>>> Aborted (core dumped)
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> dump snippet:
>>>>>>>>>>>> ============
>>>>>>>>>>>> Event type: branches
>>>>>>>>>>>> Sample = { cpu: 0001 addr: 0xffff80008030cb00 phys_addr:
>>>>>>>>>>>> 0x0000000000000000 ip: 0xffff800080313f0c pid: 12720 tid:
>>>>>>>>>>>> 12720 period: 1 time: 5986372298040 }
>>>>>>>>>>>>           ffff800080313f04 <__perf_event_header__init_id+0x4c>:
>>>>>>>>>>>>           ffff800080313f04:       36100094        tbz     w20,
>>>>>>>>>>>> #2, ffff800080313f14 <__perf_event_header__init_id+0x5c>
>>>>>>>>>>>>           ffff800080313f08:       f941e6a0        ldr     x0,
>>>>>>>>>>>> [x21, #968]
>>>>>>>>>>>>           ffff800080313f0c:       d63f0000        blr     x0
>>>>>>>>>>>>               perf 12720/12720 [0001]      5986.372298040
>>>>>>>>>>>> __perf_event_header__init_id+0x54
>>>>>>>>>>>> .../coresight/linux/kernel/events/core.c  586         return
>>>>>>>>>>>> event->clock();
>>>>>>>>>>>> Event type: branches
>>>>>>>>>>>> Sample = { cpu: 0001 addr: 0xffff8000801bb4a8 phys_addr:
>>>>>>>>>>>> 0x0000000000000000 ip: 0xffff80008030cb0c pid: 12720 tid:
>>>>>>>>>>>> 12720 period: 1 time: 5986372298040 }
>>>>>>>>>>>>           ffff80008030cb00 <local_clock>:
>>>>>>>>>>>>           ffff80008030cb00:       d503233f        paciasp
>>>>>>>>>>>>           ffff80008030cb04:       a9bf7bfd        stp     x29,
>>>>>>>>>>>> x30, [sp, #-16]!
>>>>>>>>>>>>           ffff80008030cb08:       910003fd        mov     
>>>>>>>>>>>> x29, sp
>>>>>>>>>>>>           ffff80008030cb0c:       97faba67        bl
>>>>>>>>>>>> ffff8000801bb4a8 <sched_clock>
>>>>>>>>>>>>               perf 12720/12720 [0001]      5986.372298040
>>>>>>>>>>>> local_clock+0xc ...t/linux/./include/linux/sched/clock.h   64
>>>>>>>>>>>> return sched_clock();
>>>>>>>>>>>> Event type: branches
>>>>>>>>>>>> Sample = { cpu: 0001 addr: 0xffff80008125a8a8 phys_addr:
>>>>>>>>>>>> 0x0000000000000000 ip: 0xffff8000801bb4c8 pid: 12720 tid:
>>>>>>>>>>>> 12720 period: 1 time: 5986372298040 }
>>>>>>>>>>>>           ffff8000801bb4a8 <sched_clock>:
>>>>>>>>>>>>           ffff8000801bb4a8:       d503233f        paciasp
>>>>>>>>>>>>           ffff8000801bb4ac:       a9be7bfd        stp     x29,
>>>>>>>>>>>> x30, [sp, #-32]!
>>>>>>>>>>>>           ffff8000801bb4b0:       910003fd        mov     
>>>>>>>>>>>> x29, sp
>>>>>>>>>>>>           ffff8000801bb4b4:       a90153f3        stp     x19,
>>>>>>>>>>>> x20, [sp, #16]
>>>>>>>>>>>>           ffff8000801bb4b8:       d5384113        mrs     x19,
>>>>>>>>>>>> sp_el0
>>>>>>>>>>>>           ffff8000801bb4bc:       b9401260        ldr     w0,
>>>>>>>>>>>> [x19, #16]
>>>>>>>>>>>>           ffff8000801bb4c0:       11000400        add     w0,
>>>>>>>>>>>> w0, #0x1
>>>>>>>>>>>>           ffff8000801bb4c4:       b9001260        str     w0,
>>>>>>>>>>>> [x19, #16]
>>>>>>>>>>>>           ffff8000801bb4c8:       94427cf8        bl
>>>>>>>>>>>> ffff80008125a8a8 <sched_clock_noinstr>
>>>>>>>>>>>>               perf 12720/12720 [0001]      5986.372298040
>>>>>>>>>>>> sched_clock+0x20 ...sight/linux/kernel/time/sched_clock.c  105
>>>>>>>>>>>> ns = sched_clock_noinstr();
>>>>>>>>>>>> Event type: branches
>>>>>>>>>>>> Sample = { cpu: 0001 addr: 0xffff80008125b758 phys_addr:
>>>>>>>>>>>> 0x0000000000000000 ip: 0xffff80008125a8e4 pid: 12720 tid:
>>>>>>>>>>>> 12720 period: 1 time: 5986372298040 }
>>>>>>>>>>>>           ffff80008125a8a8 <sched_clock_noinstr>:
>>>>>>>>>>>>           ffff80008125a8a8:       d503233f        paciasp
>>>>>>>>>>>>           ffff80008125a8ac:       a9bc7bfd        stp     x29,
>>>>>>>>>>>> x30, [sp, #-64]!
>>>>>>>>>>>>           ffff80008125a8b0:       910003fd        mov     
>>>>>>>>>>>> x29, sp
>>>>>>>>>>>>           ffff80008125a8b4:       a90153f3        stp     x19,
>>>>>>>>>>>> x20, [sp, #16]
>>>>>>>>>>>>           ffff80008125a8b8:       b000e354        adrp    x20,
>>>>>>>>>>>> ffff800082ec3000 <tick_bc_dev+0x140>
>>>>>>>>>>>>           ffff80008125a8bc:       910d0294        add     x20,
>>>>>>>>>>>> x20, #0x340
>>>>>>>>>>>>           ffff80008125a8c0:       a90363f7        stp     x23,
>>>>>>>>>>>> x24, [sp, #48]
>>>>>>>>>>>>           ffff80008125a8c4:       91002297        add     x23,
>>>>>>>>>>>> x20, #0x8
>>>>>>>>>>>>           ffff80008125a8c8:       52800518        mov     w24,
>>>>>>>>>>>> #0x28                  // #40
>>>>>>>>>>>>           ffff80008125a8cc:       a9025bf5        stp     x21,
>>>>>>>>>>>> x22, [sp, #32]
>>>>>>>>>>>>           ffff80008125a8d0:       b9400296        ldr     w22,
>>>>>>>>>>>> [x20]
>>>>>>>>>>>>           ffff80008125a8d4:       120002d5        and     w21,
>>>>>>>>>>>> w22, #0x1
>>>>>>>>>>>>           ffff80008125a8d8:       9bb87eb5        umull   x21,
>>>>>>>>>>>> w21, w24
>>>>>>>>>>>>           ffff80008125a8dc:       8b1502f3        add     x19,
>>>>>>>>>>>> x23, x21
>>>>>>>>>>>>           ffff80008125a8e0:       f9400e60        ldr     x0,
>>>>>>>>>>>> [x19, #24]
>>>>>>>>>>>>           ffff80008125a8e4:       d63f0000        blr     x0
>>>>>>>>>>>>               perf 12720/12720 [0001]      5986.372298040
>>>>>>>>>>>> sched_clock_noinstr+0x3c
>>>>>>>>>>>> ...sight/linux/kernel/time/sched_clock.c 93
>>>>>>>>>>>> cyc = (rd->read_sched_clock() - rd->epoch_cyc) &
>>>>>>>>>>>> Event type: branches
>>>>>>>>>>>> Sample = { cpu: 0001 addr: 0xffff8000801bb4cc phys_addr:
>>>>>>>>>>>> 0x0000000000000000 ip: 0xffff80008125a930 pid: 12720 tid:
>>>>>>>>>>>> 12720 period: 1 time: 5986372298040 }
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> With fix:
>>>>>>>>>>>> =========
>>>>>>>>>>>>
>>>>>>>>>>>> Event type: branches
>>>>>>>>>>>> Sample = { cpu: 0001 addr: 0xffff80008030cb00 phys_addr:
>>>>>>>>>>>> 0x0000000000000000 ip: 0xffff800080313f0c pid: 12720 tid:
>>>>>>>>>>>> 12720 period: 1 time: 5986372298040 }
>>>>>>>>>>>>           ffff800080313f04 <__perf_event_header__init_id+0x4c>:
>>>>>>>>>>>>           ffff800080313f04:       36100094        tbz     w20,
>>>>>>>>>>>> #2, ffff800080313f14 <__perf_event_header__init_id+0x5c>
>>>>>>>>>>>>           ffff800080313f08:       f941e6a0        ldr     x0,
>>>>>>>>>>>> [x21, #968]
>>>>>>>>>>>>           ffff800080313f0c:       d63f0000        blr     x0
>>>>>>>>>>>>               perf 12720/12720 [0001]      5986.372298040
>>>>>>>>>>>> __perf_event_header__init_id+0x54
>>>>>>>>>>>> .../coresight/linux/kernel/events/core.c  586         return
>>>>>>>>>>>> event->clock();
>>>>>>>>>>>> Event type: branches
>>>>>>>>>>>> Sample = { cpu: 0001 addr: 0xffff8000801bb4a8 phys_addr:
>>>>>>>>>>>> 0x0000000000000000 ip: 0xffff80008030cb0c pid: 12720 tid:
>>>>>>>>>>>> 12720 period: 1 time: 5986372298040 }
>>>>>>>>>>>>           ffff80008030cb00 <local_clock>:
>>>>>>>>>>>>           ffff80008030cb00:       d503233f        paciasp
>>>>>>>>>>>>           ffff80008030cb04:       a9bf7bfd        stp     x29,
>>>>>>>>>>>> x30, [sp, #-16]!
>>>>>>>>>>>>           ffff80008030cb08:       910003fd        mov     
>>>>>>>>>>>> x29, sp
>>>>>>>>>>>>           ffff80008030cb0c:       97faba67        bl
>>>>>>>>>>>> ffff8000801bb4a8 <sched_clock>
>>>>>>>>>>>>               perf 12720/12720 [0001]      5986.372298040
>>>>>>>>>>>> local_clock+0xc ...t/linux/./include/linux/sched/clock.h   64
>>>>>>>>>>>> return sched_clock();
>>>>>>>>>>>> Event type: branches
>>>>>>>>>>>> Sample = { cpu: 0001 addr: 0xffff80008125a8a8 phys_addr:
>>>>>>>>>>>> 0x0000000000000000 ip: 0xffff8000801bb4c8 pid: 12720 tid:
>>>>>>>>>>>> 12720 period: 1 time: 5986372298040 }
>>>>>>>>>>>>           ffff8000801bb4a8 <sched_clock>:
>>>>>>>>>>>>           ffff8000801bb4a8:       d503233f        paciasp
>>>>>>>>>>>>           ffff8000801bb4ac:       a9be7bfd        stp     x29,
>>>>>>>>>>>> x30, [sp, #-32]!
>>>>>>>>>>>>           ffff8000801bb4b0:       910003fd        mov     
>>>>>>>>>>>> x29, sp
>>>>>>>>>>>>           ffff8000801bb4b4:       a90153f3        stp     x19,
>>>>>>>>>>>> x20, [sp, #16]
>>>>>>>>>>>>           ffff8000801bb4b8:       d5384113        mrs     x19,
>>>>>>>>>>>> sp_el0
>>>>>>>>>>>>           ffff8000801bb4bc:       b9401260        ldr     w0,
>>>>>>>>>>>> [x19, #16]
>>>>>>>>>>>>           ffff8000801bb4c0:       11000400        add     w0,
>>>>>>>>>>>> w0, #0x1
>>>>>>>>>>>>           ffff8000801bb4c4:       b9001260        str     w0,
>>>>>>>>>>>> [x19, #16]
>>>>>>>>>>>>           ffff8000801bb4c8:       94427cf8        bl
>>>>>>>>>>>> ffff80008125a8a8 <sched_clock_noinstr>
>>>>>>>>>>>>               perf 12720/12720 [0001]      5986.372298040
>>>>>>>>>>>> sched_clock+0x20 ...sight/linux/kernel/time/sched_clock.c  105
>>>>>>>>>>>> ns = sched_clock_noinstr();
>>>>>>>>>>>> Event type: branches
>>>>>>>>>>>> Sample = { cpu: 0001 addr: 0xffff80008125b758 phys_addr:
>>>>>>>>>>>> 0x0000000000000000 ip: 0xffff80008125a8e4 pid: 12720 tid:
>>>>>>>>>>>> 12720 period: 1 time: 5986372298040 }
>>>>>>>>>>>>           ffff80008125a8a8 <sched_clock_noinstr>:
>>>>>>>>>>>>           ffff80008125a8a8:       d503233f        paciasp
>>>>>>>>>>>>           ffff80008125a8ac:       a9bc7bfd        stp     x29,
>>>>>>>>>>>> x30, [sp, #-64]!
>>>>>>>>>>>>           ffff80008125a8b0:       910003fd        mov     
>>>>>>>>>>>> x29, sp
>>>>>>>>>>>>           ffff80008125a8b4:       a90153f3        stp     x19,
>>>>>>>>>>>> x20, [sp, #16]
>>>>>>>>>>>>           ffff80008125a8b8:       b000e354        adrp    x20,
>>>>>>>>>>>> ffff800082ec3000 <tick_bc_dev+0x140>
>>>>>>>>>>>>           ffff80008125a8bc:       910d0294        add     x20,
>>>>>>>>>>>> x20, #0x340
>>>>>>>>>>>>           ffff80008125a8c0:       a90363f7        stp     x23,
>>>>>>>>>>>> x24, [sp, #48]
>>>>>>>>>>>>           ffff80008125a8c4:       91002297        add     x23,
>>>>>>>>>>>> x20, #0x8
>>>>>>>>>>>>           ffff80008125a8c8:       52800518        mov     w24,
>>>>>>>>>>>> #0x28                  // #40
>>>>>>>>>>>>           ffff80008125a8cc:       a9025bf5        stp     x21,
>>>>>>>>>>>> x22, [sp, #32]
>>>>>>>>>>>>           ffff80008125a8d0:       b9400296        ldr     w22,
>>>>>>>>>>>> [x20]
>>>>>>>>>>>>           ffff80008125a8d4:       120002d5        and     w21,
>>>>>>>>>>>> w22, #0x1
>>>>>>>>>>>>           ffff80008125a8d8:       9bb87eb5        umull   x21,
>>>>>>>>>>>> w21, w24
>>>>>>>>>>>>           ffff80008125a8dc:       8b1502f3        add     x19,
>>>>>>>>>>>> x23, x21
>>>>>>>>>>>>           ffff80008125a8e0:       f9400e60        ldr     x0,
>>>>>>>>>>>> [x19, #24]
>>>>>>>>>>>>           ffff80008125a8e4:       d63f0000        blr     x0
>>>>>>>>>>>
>>>>>>>>>>> It looks like the disassembly now assumes this BLR wasn't
>>>>>>>>>>> taken. We go from ffff80008125a8e4 straight through to ...
>>>>>>>>>>>
>>>>>>>>>>>>               perf 12720/12720 [0001]      5986.372298040
>>>>>>>>>>>> sched_clock_noinstr+0x3c
>>>>>>>>>>>> ...sight/linux/kernel/time/sched_clock.c 93
>>>>>>>>>>>> cyc = (rd->read_sched_clock() - rd->epoch_cyc) &
>>>>>>>>>>>> Event type: branches
>>>>>>>>>>>> Sample = { cpu: 0001 addr: 0xffff8000801bb4cc phys_addr:
>>>>>>>>>>>> 0x0000000000000000 ip: 0xffff80008125a930 pid: 12720 tid:
>>>>>>>>>>>> 12720 period: 1 time: 5986372298040 }
>>>>>>>>>>>>           ffff80008125a8e8 <sched_clock_noinstr+0x40>:
>>>>>>>>>>>>           ffff80008125a8e8:       f8756ae3        ldr     x3,
>>>>>>>>>>>> [x23, x21]
>>>>>>>>>>>
>>>>>>>>>>> ffff80008125a8e4 which is just the previous one +4. Isn't your
>>>>>>>>>>> issue actually a decode issue in Perf itself? Why is there a
>>>>>>>>>>> discontinuity without branch samples being generated where
>>>>>>>>>>> either the source or destination address is 0?
>>>>>>>>>>>
>>>>>>>>>>> What are your record options to create this issue? As I
>>>>>>>>>>> mentioned in the previous reply I haven't been able to
>>>>>>>>>>> reproduce it.
>>>>>>>>>>
>>>>>>>>>> I am using below perf record command.
>>>>>>>>>>
>>>>>>>>>> timeout 4s ./perf record -e cs_etm// -C 1 dd if=/dev/zero
>>>>>>>>>> of=/dev/null
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Thanks I managed to reproduce it. I'll take a look to see if I
>>>>>>>>> think the issue is somewhere else.
>>>>>>>>>
>>>>>>>>
>>>>>>>> At least for the failures I encountered, the issue is due to the
>>>>>>>> alternatives runtime instruction patching mechanism. vmlinux ends
>>>>>>>> up being the wrong image to decode with because a load of branches
>>>>>>>> are actually turned into nops.
>>>>>>>>
>>>>>>>> Can you confirm if you use --kcore instead of vmlinux that you
>>>>>>>> still get failures:
>>>>>>>>
>>>>>>>>     sudo perf record -e cs_etm// -C 1 --kcore -o
>>>>>>>> <output-folder.data> -- \
>>>>>>>>       dd if=/dev/zero of=/dev/null
>>>>>>>>
>>>>>>>>      perf script -i <output-folder.data> \
>>>>>>>>       tools/perf/scripts/python/arm-cs-trace-disasm.py -d
>>>>>>>> llvm-objdump \
>>>>>>>>       -k <output-folder.data>/kcore_dir/kcore
>>>>>>>>
>>>>>>>
>>>>>>> With below command combination with kcore also the issue is seen,
>>>>>>> as reported in this email chain.
>>>>>>>
>>>>>>> timeout 8s ./perf record -e cs_etm// -C 1 --kcore -o kcore \
>>>>>>> dd if=/dev/zero of=/dev/null
>>>>>>>
>>>>>>> ./perf script -i kcore/data \
>>>>>>> --script=python:./scripts/python/arm-cs-trace-disasm.py -- \
>>>>>>> -d objdump -k kcore/kcore_dir/kcore
>>>>>>>
>>>>>>>
>>>>>>> However, with below sequence(same as your command) the issue is
>>>>>>> *not* seen.
>>>>>>>
>>>>>>> timeout 8s ./perf record -e cs_etm// -C 1 --kcore -o kcore \
>>>>>>> dd if=/dev/zero of=/dev/null
>>>>>>>
>>>>>>> ./perf script -i kcore/data 
>>>>>>> ./scripts/python/arm-cs-trace-disasm.py \
>>>>>>> -- -d objdump -k kcore/kcore_dir/kcore
>>>>>>>
>>>>>>> Do you see any issue with the command, which is showing the problem?
>>>>>>> Also the output log produced by these both commands is different.
>>>>>>>
>>>>
>>>> BTW are you running this on the target or somewhere else? It's
>>>> suspicious that "-i kcore/data" works at all because there is no
>>>> kernel image given to Perf. Unless you are running on the target and
>>>> then I think it will just open the one from /proc. Or maybe it uses
>>>> /boot/vmlinux by default which also wouldn't work.
>>>>

Yes All tests are done natively on Ampere's ARM64 platform.
some more combination of commands which are also failing.

./perf script -i ./kcore -s scripts/python/arm-cs-trace-disasm.py -- -d 
objdump -k kcore/kcore_dir/kcore

./perf script -i ./kcore -s scripts/python/arm-cs-trace-disasm.py -F 
cpu,event,ip,addr,sym -- -d objdump -k kcore/kcore_dir/kcore

  ./perf script -i ./kcore scripts/python/arm-cs-trace-disasm.py -d 
objdump -k kcore/kcore_dir/kcore

>>>> Also the difference between "--script=python:" and just giving the
>>>> script name is in the parsing of the arguments following " -- ".
>>>> Sometimes they're also parsed as Perf arguments (like the -v becomes
>>>> perf verbose and -k becomes the Perf vmlinux rather than the script).
>>>>
>>>> I _think_ you want the " -- " when "--script" is used, and no "--"
>>>> when it's not. But there are some other combinations and you'll have
>>>> to debug it to compare your two exact scenarios to see why they're
>>>> different.
>>>>
>>>> But ignoring that issue with the argument format, you mentioned you
>>>> didn't see the issue any more with one version of --kcore. So I'm
>>>> assuming that confirms the issue is just a decode image issue, so we
>>>> shouldn't try to patch this script?
>>>>
>>>
>>> Although one change we should make to the script is change the example
>>> to use kcore. We can leave in one vmlinux one as an example if kcore
>>> isn't available, but add a note that it will fail if any patched code is
>>> traced (which is almost always).
>>
>> James, you may recall the year old thread
>> https://lore.kernel.org/all/ed8cea4c-a261-60ca-f4e1-333ec73cca8f@os.amperecomputing.com.
>> I described there an awkward workaround Ampere has used to solve the
>> patched code problem. At the time, it sounded like the maintainers were
>> interested in getting away from using the python script, mostly for
>> speed purposes. I didn't see the discussion go any further.
>>
> 
> Oh yes thanks for the reminder. I wasn't thinking about the source code 
> lines and debug symbols in this thread. I suppose your merging of kcore 
> and vmlinux gives both the correct image and the symbols, but I was only 
> focused on the image being correct, so only kcore was enough.
> 
> It looks like everything we want to do from your previous thread is in 
> addition to the fixes from this one. Even if we auto merge kcore + 
> symbols and move the disassembly into Perf, we still want to detect 
> decode issues earlier and not have IPs jumping backwards. Whether it's 
> the script or Perf doing that the behavior should be the same.
> 

Since it is breaking the decode, can we please add as a fix to drop the 
packets from decode when the discontinuity is seen (with warning message 
in verbose mode)? like below diff?

--- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
+++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
@@ -257,6 +257,11 @@ def process_event(param_dict):
                 print("Stop address 0x%x is out of range [ 0x%x .. 0x%x 
] for dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))
                 return

+       if (stop_addr < start_addr):
+               if (options.verbose == True):
+                       print("Packet Dropped, Discontinuity detected 
[stop_add:0x%x start_addr:0x%x ] for dso %s" % (stop_addr, start_addr, dso))
+               return
+
         if (options.objdump_name != None):
                 # It doesn't need to decrease virtual memory offset for 
disassembly
                 # for kernel dso and executable file dso, so in this 
case we set


> To summarise I think these are the changes to make:
> 
>    * Improve bad decode detection in OpenCSD
>    * Get the script to auto merge kcore and vmlinux
>      * Maybe we could get Perf to do this if both a kcore folder and -k
>        vmlinux are used?
>    * Improve the performance, either in the script or move more
>      functionality into Perf

Thanks,
Ganapat

