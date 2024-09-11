Return-Path: <linux-kernel+bounces-324464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E724D974CC1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F9521C20CAA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788D116DC33;
	Wed, 11 Sep 2024 08:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="f1SmcZx3";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="f1SmcZx3"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2054.outbound.protection.outlook.com [40.107.103.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCB5154C0F
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.54
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726043750; cv=fail; b=kbB8YMmIO5gyvpi2phLQK4fhRa+dly0rdsRkx5HAwcNKDrDAR258KFCYizAhH0SrvYAWbc11vFLU4gPtkQ2szx73YOGYlKkwNQzT4uPPI28Z1XtGuZ8YN4t5l4W5bKcht4rDKuKwzyA4vNpcSl+Lq5Ky5LPoT9ozmSpkt6cMvvI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726043750; c=relaxed/simple;
	bh=UDn80SRLvT1syFJ62bGALZtULWyRK77V8guKmvEhd1o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lKK+/+jNVH9zVq2Ou3ymZbu78/FcCkiCQLTdRg2NeOE+gC8Oki/6DAXRtJ64hirHkzwTcqMH/R3L0B1GnicFdCr3ejoyHdd+3UeojwmKOdaaqzaxpRrCcbb0+F1Vi0xmU8/FDrXHiyRdTBlCgv/g++ba+2OCGckHTtq8Gb1GlAk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=f1SmcZx3; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=f1SmcZx3; arc=fail smtp.client-ip=40.107.103.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=A5cR6AH0yXm9J5eh39ggy+qTwU+IDFavnfkmktJ+fN11Mze9OCEHk3MPQxZ7V59EseaLI5+rK+V4SSu23jEd1jPrGec3u1DOh2KssWlGk19BZ8VPLICRdBMgonxnY8WRLf/p+DclBrMuEvDqPwzBOVVT4YE2DOdFO+kP+6hpcPKYvFIrPyqE5xRl6GCDB/Bz2LzabP/y9uhfPCMqxaTMweDvhoefjVWlaiWiIuPfyl2NlSqrMBVgYBQMOSEjAouEavoNcddc67VbaHY5a9IG/nUVyaKqVwa6riedJo419aduOb2Nsx9EYbKXbx9X/KGT3u8UpX1XhVfk/75sllUqyA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWtAFPeHg9FWZLqKsIXhd56BIA4sNRWWrzrMRAJ+y6I=;
 b=MWmMYIlhABi0lL4MzB9Gea884FfYiwKYmHfC7pLPjFRNub9uWVKk5Up+KM66RTIgM2Pk5sxa0hw0OJmAe3tEXdussmF2qE7VUZfaVvKsbv5lFJZqwEBhZrPeuDUFk6xf6+HKIZ9UysMDe1ei0ijT/1KL9amFFnGDoPx6flc+PWGVlXw4c+qu3buWO41sNKtEV82sHxXcDonj5ACzOvKNx4PvP1sEdOrksd4iPrKmf6oQeHPB2ucYXboPXHkoTAHD//tcwHDeNJKM0BTHRNfkLlBebF0J78ZNukkGXEeK8YBDGiFJfjDotsxCdNSBw5SgtLKZJBqRoT/p/coeHPRjoA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWtAFPeHg9FWZLqKsIXhd56BIA4sNRWWrzrMRAJ+y6I=;
 b=f1SmcZx3LDVJrsKQRg9Hyfo8dXGsQDY13x54MWbcAWIzZlfjqLk++FGhQ/S1PXYBT+2hxtLES5SYKIpotBeyPTDO1cdCeLRLL07rrvnZ9NKSfwc9Pkr29abL6Y/nbFL4pq/lfYeOGVbyebOTcetFS7jY1sIr8MC7SV9EZtQ/VaE=
Received: from AS4P251CA0004.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:5d2::6)
 by GV1PR08MB8449.eurprd08.prod.outlook.com (2603:10a6:150:81::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.16; Wed, 11 Sep
 2024 08:35:39 +0000
Received: from AM3PEPF00009B9F.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d2:cafe::e7) by AS4P251CA0004.outlook.office365.com
 (2603:10a6:20b:5d2::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Wed, 11 Sep 2024 08:35:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM3PEPF00009B9F.mail.protection.outlook.com (10.167.16.24) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13
 via Frontend Transport; Wed, 11 Sep 2024 08:35:39 +0000
Received: ("Tessian outbound 80464012c5bc:v441"); Wed, 11 Sep 2024 08:35:38 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 8fbcd60e2d39d23d
X-CR-MTA-TID: 64aa7808
Received: from Lca4aa531713b.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 3E4B2475-16C8-477C-866C-679393595208.1;
	Wed, 11 Sep 2024 08:35:27 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lca4aa531713b.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 11 Sep 2024 08:35:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DTzNYXGL67nOdDQSqTt8CN8+Cr9xZzJEEkHfWsmcijzGIsLerjoa47BwjQei1JWgHiIrldA7k0S+fOqVGRhWIj9Dy9AcfzEMbk+ni6ZslG4sML1BxGPLyrR2vfJQXCtGldAYwsTQmI86fs9ixQH4gebl+1BPbATuHni+wXRMxP6xi5B0f4PLqzxciRvOEB42weyYe6OmnmX7UrKCPlMwdyeFd9BtyIKhPONobTubyDkYZpo4zGnMftdIzqM7X6WPKh95vjg88/kYlGGkPgOKhP3P9wdutm5hS3cA4m4QvQEL94VcYPHBsEmmjFZXQyHSrE4UMtKG5Iqei01vOxISxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWtAFPeHg9FWZLqKsIXhd56BIA4sNRWWrzrMRAJ+y6I=;
 b=dI16an3AG3qlvRFKcToHRZdm+bWkshABOWZY0rcK+TiDNTzYht5oBxRJ8VKMXxsy2jbrjJzZeLqYDX9gR/O7iYSKv0zEf3QXdoaFi8Dpi7UW7tocPFoYIGney8svLp8R0fYleOfzMcgtijk4A/fiXRjy7t8p5nVs0SHPlbXR7YUN83XZlBcoS0l5rfv1dmA083o7i2BvKQ+xiVCg5rcfVx77URlY+QvdakWgeXUHpi1s5P1UNF38CPPB19ZPIMyTFym0JoK+JitW/FoWyB6PRR9ZH4YXaRLH9wtp9vZ82Pycg4etjJBBEWM6Lsv1dDnVlEkZpNg/xN8nd0yn8a2zYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWtAFPeHg9FWZLqKsIXhd56BIA4sNRWWrzrMRAJ+y6I=;
 b=f1SmcZx3LDVJrsKQRg9Hyfo8dXGsQDY13x54MWbcAWIzZlfjqLk++FGhQ/S1PXYBT+2hxtLES5SYKIpotBeyPTDO1cdCeLRLL07rrvnZ9NKSfwc9Pkr29abL6Y/nbFL4pq/lfYeOGVbyebOTcetFS7jY1sIr8MC7SV9EZtQ/VaE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PR3PR08MB5852.eurprd08.prod.outlook.com (2603:10a6:102:8e::21)
 by PA4PR08MB7521.eurprd08.prod.outlook.com (2603:10a6:102:26a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Wed, 11 Sep
 2024 08:35:19 +0000
Received: from PR3PR08MB5852.eurprd08.prod.outlook.com
 ([fe80::f44:d113:1c29:825d]) by PR3PR08MB5852.eurprd08.prod.outlook.com
 ([fe80::f44:d113:1c29:825d%3]) with mapi id 15.20.7939.010; Wed, 11 Sep 2024
 08:35:19 +0000
Message-ID: <52ca4cea-8f65-434e-af17-e4bf664d9488@arm.com>
Date: Wed, 11 Sep 2024 09:35:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/24] sched/uclamg: Handle delayed dequeue
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Hongyan Xia <hongyan.xia2@arm.com>, mingo@redhat.com, juri.lelli@redhat.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com, youssefesmat@chromium.org, tglx@linutronix.de,
 efault@gmx.de
References: <629937b1-6f97-41d1-aa4f-7349c2ffa29d@arm.com>
 <CAKfTPtBPK8ovttHDQjfuwve63PK_pNH4WMznEHWoXQ=2vGhKQQ@mail.gmail.com>
 <CAKfTPtDO3n-4mcr2Sk-uu0ZS5xQnagdicQmaBh-CyrndPLM8eQ@mail.gmail.com>
 <aa81d37e-ad9c-42c6-a104-fe8496c5d907@arm.com>
 <c49ef5fe-a909-43f1-b02f-a765ab9cedbf@arm.com>
 <CAKfTPtCNUvWE_GX5LyvTF-WdxUT=ZgvZZv-4t=eWntg5uOFqiQ@mail.gmail.com>
 <a9a45193-d0c6-4ba2-a822-464ad30b550e@arm.com>
 <20240905145354.GP4723@noisy.programming.kicks-ass.net>
 <20240906104525.GG4928@noisy.programming.kicks-ass.net>
 <8d0d01b9-a430-49cc-93a5-67b4d68aa35c@arm.com>
 <20240910140524.GH4723@noisy.programming.kicks-ass.net>
From: Luis Machado <luis.machado@arm.com>
In-Reply-To: <20240910140524.GH4723@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0018.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::23) To PR3PR08MB5852.eurprd08.prod.outlook.com
 (2603:10a6:102:8e::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PR3PR08MB5852:EE_|PA4PR08MB7521:EE_|AM3PEPF00009B9F:EE_|GV1PR08MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: 150db77f-e73c-4155-7e30-08dcd23cb746
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?bm9kcSs4UDU2NkhqTnEwODdkKzJKUjhCUm9NbzBBdXJUYjJrNWFhS2I5bFox?=
 =?utf-8?B?bFFSVXExNFl1dmZRTzJBUkZ3c040bDh3bmdWVi9JWWF3YkdHVlNKaFlXYi9R?=
 =?utf-8?B?Z1RENUM0eXlzYlFQeGVFWUxGSHdoOXVzdGRoTXM1WHNpMjc0TnZHbXhxRDR3?=
 =?utf-8?B?WUQxTGdMdWJPR2F3cUJCRE5YOTFwRGJrdzl4bWFlU29CYlJ4WllvdXRMbWVG?=
 =?utf-8?B?L2NEL0xad2M3THp4enVVM0dWdXpoY1BaOXlnMmlMd3VRZ05YNTBuS2NFbHBR?=
 =?utf-8?B?d2tOTEFNbkpOTnR2Zi85QVFCQjZkclNTZ3FkTHBMalFScWFsWE5JeGlnRVV4?=
 =?utf-8?B?THltSXk5S00xdTdLU2JHamdhMlFhUHh4QVVJeVJnN0pXQTJjc0E4UmV5NVI0?=
 =?utf-8?B?enozdWhZYllSZUN2OCtUTHRMVEpXVjJWY2FMVDVSUVdad3l0eWhyYVlRS092?=
 =?utf-8?B?cXVsWVFXbXQrc0IzcTJYMjFPaDBqdkFVTXlXZVYrQ1l4NEpBOFZqaGhTeXo1?=
 =?utf-8?B?bjBtVnRjZFVTRURJVzZWekpUT0J1VnZPdVRqV1NhUEpsNytZQTB3N3p1bE00?=
 =?utf-8?B?NnlxY0FXU3VhcWFkVmdYTnlnS1pSWkNPZjlRd2Y5SFByYkUvOHNsT0FKRmRl?=
 =?utf-8?B?TFB2Z0s1YVRvaDhtaTlwQ1l0eDVFbGFPZGJXU3gwZHBodGN2c3RWbmlZaUlw?=
 =?utf-8?B?V1g5d1k5MmEzdDRLWm5IR2QvbFhDc2tTT1VCTk1Kb2R2RkozcTJKM09CU2oy?=
 =?utf-8?B?RmlwUGNYcUJUSjlyejhYV1dDRXJLT01jd0I0Sm5sdytPZUVLT09RZWJZUXdE?=
 =?utf-8?B?ekExZWtIbkJDU1U2Sko0T2s4SDdIanpKdXFjWjdUelB1L1BLOUE3cXJNeDI2?=
 =?utf-8?B?OHd5U0xQSVpaMjNlSHZ6ZmtYaTl2NGhRbGJLZzZWN2hCYlpTSk9xWkQ5QWRp?=
 =?utf-8?B?WDhHZVZzNE5oSUExTGcxV1hEOUZCUW00ZTc5eFlFV3FlRWxkZ0xmNllsSEh5?=
 =?utf-8?B?dGdQQlNoV2pmME5SdGI3dGthc3Uyb0NnMmREcDVxNkNGMm9oTmxPQnpORjNO?=
 =?utf-8?B?SHRrYUxDazMrNVozVndGbC9oQ2o4Tm02QVZaeTRKODZjUU5FNlpzSERDMWpM?=
 =?utf-8?B?eG1PZitPVjhHTDJzeFNtQ3ZkdWZCTG5YeU55aDBlQ3Rydlk4b21mUE45eFU1?=
 =?utf-8?B?UENDQ0lsa21NaVpEcXp2RzlTdTlsS1JzSElnNkxmZjBXQXk2NVBlMmdVSDRH?=
 =?utf-8?B?SWtRYytDRzV3SHpaRDdQb2piVUNQUFZGOUlVZjVTalppQnkvYStmMHhQY3d3?=
 =?utf-8?B?ZTNjcithMzZxTWtSYzcrS3BaNkV5YTU5bElPbWF4bVIrYVVhS0tDS3ltSytF?=
 =?utf-8?B?dmx4SGE5OFl0Yk1hYlBkTmpsUzlreXdnODJOc1hhWHZ6T0g1dVlXMndJZDFi?=
 =?utf-8?B?dXg2amJaMy9UZkJBUURGZUtseS9FRFhYbHdmc1E5SlVRMHhsS0hMeHovMFN1?=
 =?utf-8?B?OE1pQ0sraG5maGtLUUJibytwcXJCMTMzRUFrQnU4WFMvak1UYlFHTUJjZkFy?=
 =?utf-8?B?Y3lZNnh4OFZrZXRXWVppQ0tqQmgxQ3cwRFd4MXlTZXN2L3JUU1J0RVR5dlQ2?=
 =?utf-8?B?R2luanM2aTVZTXpORUxQdHFNeFVQOE9sanNpYXdBRDhxYmhCSW5VSkxwTVls?=
 =?utf-8?B?a1RMZVM3S1A3Unk3SkwvamdmTm9HTEpqbC9hNHZCby80NmlMUW1aTTlscVVW?=
 =?utf-8?B?YWtwMHVNMFJOdGpFZ1REbDBka0twSnRwbEtmL1BEKy9ZUnM4SHJsemVGbm9q?=
 =?utf-8?B?VWVFU1ZhM2ZjNVVJdWJoZz09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5852.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7521
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:102:8e::21];domain=PR3PR08MB5852.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009B9F.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	fa0d1174-8948-4646-e14d-08dcd23cab46
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUxtNTZwL3ROcGk3eC9IWk9obWtRNFJ1dGRUcVA4ZzFTU1hDUGxSK0QxTFdu?=
 =?utf-8?B?R3NVTzc2R3daNStwZi9MakZHQVNaNkd1dnhDZ3VjbmtkQTV0TjVnL3hkelNw?=
 =?utf-8?B?MGRBU1MxN2FPTVptd2ppZGtNY1RrdE5iR1dOcEVxZkJmdjlOYzhuK0IzMEt1?=
 =?utf-8?B?V2dtNHVMclUydXM5OUZKc3VzcW5UTTNPb2lVMEpxTCs5NFpMcjN0WlNteFF3?=
 =?utf-8?B?d3dnUXpnWmRjb0pFaHBSWUROUVlsbjJiM2VVZkNYZGNtR1JEWHpQY2w1cWt1?=
 =?utf-8?B?ZFBkKzJ3SEc1b0g1SHFGUlJkcEplWit6b1lYWkV5M1ljRWplR2JxRHhiQlgx?=
 =?utf-8?B?WWRyRUwwOGkvMm9BSTd0em1rcTZLZU1VbFNRYkUxRjVFOXNPa21sWmxKVS9Z?=
 =?utf-8?B?WDJDZ3NqUU9GVCtldTJBelFEdno2SHBrR2JLNWdzbXFEUXptN292RXZTVFlJ?=
 =?utf-8?B?U2JCeVNibmd0OHFpbkxBZFJWbTlWOE4yNXlhSTJ4QkcwazdHNTNSQlZXOXBT?=
 =?utf-8?B?Tm9VRk14TjNYY3prNEVwWmN4M1Z6RWpuc3ZiL09JSm1sMmNIc1ZEbk5ZbmFu?=
 =?utf-8?B?TmU0ZkZ2WkxMTU0wUjFMd0pLeXJSMjB5dUw2N282TnVGS1lrK3VXWDBSMjZP?=
 =?utf-8?B?U0RPNWx4MHd0RERFWUlmZGk0SkwrMHFxZXBsK2xSd3IxelNzZElHN09pNThL?=
 =?utf-8?B?bFJDZnc5Rmg5cDEyQmVXb0NjOWE0aDdBQkZQTGFMTHVkNVpaUXZ4YlZUbWJR?=
 =?utf-8?B?RVB6OXBjQTNqOTdaQU51bno4MmZuRFp2QjI4M1VQMnBEMFpHY0dkOTNEL3Yx?=
 =?utf-8?B?YWdsWFIxS0ZZTnY2aHRXS0Rqc0pZY0d1N0FpWmtEN2t4NUpaVE9qMmxzbXZk?=
 =?utf-8?B?d1dFaFM3M2FSdHptK3dRcG9sL3NYekt0cjdoTUxUUmZWeUFFVlhhbWFRWHZx?=
 =?utf-8?B?TU5zK3hWQnptZzBuSWUrTmxNRWNMMU00V29YVFU0ejNDMHpiMCtFekl0VWM4?=
 =?utf-8?B?K0xoS3lHNWVmT2NNaUowb3FYdURJWmpDOU5SOHB5NHVtS1dpQW5GT09uTFVm?=
 =?utf-8?B?TUlDTzJYQnE1TjdqWVpOcVBxZ1UrUWRLY01MNGRyc1FmTlc0Tk5KeHU3SjhZ?=
 =?utf-8?B?Um1mOWZhekxTQXR5VkxPRFFSUUNUcld4VHNsZ0RleXgyYkROSGJPQUVEWk5w?=
 =?utf-8?B?STVkT0VVNnNUUWEwQTZ1M21tWWtoc2FsQTJ4dTRkVGpnZFNtWjR2MEJUWDJs?=
 =?utf-8?B?c0ZtWVArenZtdmM0bFV0QU1LdzN2YTRCNXljcWY5YVc0aGUwRlpCUi9rczRS?=
 =?utf-8?B?MlkxMCs0QnV4L3MrY0VJUTlIajBUUHRMRXpoZXJXOUV2dUxDYWxEaHc2QXhT?=
 =?utf-8?B?SDcySmVmaE03M3pEZGZ1eW5uYUgzeWp1YUliMUsxU0gwUnFsV3ZIU1BISFdm?=
 =?utf-8?B?aDVMeFIwMlhCcm9aMk15MUhXclZOdWsrckVZbWxDaEw3a3MwOVk5VjRoTTdi?=
 =?utf-8?B?YjBWYnA1K0NIR3krbXlRVHJMeHBmZHM5NlVCcExyTCtxUmplTGhxUFRUUUs5?=
 =?utf-8?B?SWNUVmJNQlgxWmdxK2ZrVVY4OEwyM2lIaG1IUkY1alQwb0k0THhuMTk4b3Qr?=
 =?utf-8?B?eGpBUk8ydmxDLzhhTXJ3c0xYRHNndFVPRVo3alBYV1Rtc2VCNm5vektIWWRu?=
 =?utf-8?B?N2xlSURhWWtndUVsMHZSclNCaFVNTHJCbnEzcDVyQWpGb2ZOY3RGNkNpZDhy?=
 =?utf-8?B?OG5oVU9FalhwNFhSMFc5ektKaGJNR0JEZHRyZnBTL2tLZEpMM3JXenUydW9L?=
 =?utf-8?B?QVl5UTVHUEFTQjI0cHNOOHM1WTBydDJKTk5xblhtRmpZUVJxSzl2R3hyemVM?=
 =?utf-8?B?MWZNOEQ1TE5aNzd5M0orM3llVW40ZXYwMzd1UXdPV0FnRnRKbWNnOW5qT0JZ?=
 =?utf-8?Q?ulnJ9fG7D0YZDH83Ldq9udvGtKO3cmsO?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 08:35:39.4020
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 150db77f-e73c-4155-7e30-08dcd23cb746
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8449

On 9/10/24 15:05, Peter Zijlstra wrote:
> On Tue, Sep 10, 2024 at 12:04:11PM +0100, Luis Machado wrote:
>> I gave the above patch a try on our Android workload running on the Pixel 6 with a 6.8-based kernel.
>>
>> First I'd like to confirm that Dietmar's fix that was pushed to tip:sched/core (Fix util_est
>> accounting for DELAY_DEQUEUE) helps bring the frequencies and power use down to more sensible levels.
>>
>> As for the above changes, unfortunately I'm seeing high frequencies and high power usage again. The
>> pattern looks similar to what we observed with the uclamp inc/dec imbalance.
> 
> :-(
> 
>> I haven't investigated this in depth yet, but I'll go stare at some traces and the code, and hopefully
>> something will ring bells.
> 
> So first thing to do is trace h_nr_delayed I suppose, in my own
> (limited) testing that was mostly [0,1] correctly correlating to there
> being a delayed task on the runqueue.
> 
> I'm assuming that removing the usage sites restores function?

It does restore function if we remove the usage.

From an initial look:

cat /sys/kernel/debug/sched/debug | grep -i delay                                                                                                                                                                                                                             
  .h_nr_delayed                  : -4
  .h_nr_delayed                  : -6
  .h_nr_delayed                  : -1
  .h_nr_delayed                  : -6
  .h_nr_delayed                  : -1
  .h_nr_delayed                  : -1
  .h_nr_delayed                  : -5
  .h_nr_delayed                  : -6

So probably an unexpected decrement or lack of an increment somewhere.

