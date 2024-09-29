Return-Path: <linux-kernel+bounces-343044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F9E98962A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 17:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76C4828321F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 15:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65DF17C7C4;
	Sun, 29 Sep 2024 15:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NT/sLc4v"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2055.outbound.protection.outlook.com [40.107.96.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D63B17BEAC
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 15:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727624635; cv=fail; b=jonLmZcoFRSoT3V02lFogbUKh2xQWXamn4DUQyRRKTWvZYC9EehEsMmaCxuZrRetb6dRECEN/bq32u+Ky1pabROzkiEVD8xJe61tsup1llXEx9c1wXHp9YkGCE2Wcg0yVgT4KozIoTrEw+67dhGVLZ6GJh2VR1rMDKkhsM+7+Fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727624635; c=relaxed/simple;
	bh=35F5E+XIQsOpMfPHb42P/zQM24Be8bzruuIfkS8aEd0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J7H7WMrGk5UH+JHsL+i8Xh2ENwHcBK3k/BomLL5MwE07SkH0nrMU6ts/CcmlS+r34I5Gpr9Am9LaY/Q0uKpcTNteYMPo+L9dcxfITgSPtFLSO1lDdAzdiodLtmt1a6xGg3bstRjtJyAc6WKAAvcMbRDhXzpbRFvemNEoO0eylgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NT/sLc4v; arc=fail smtp.client-ip=40.107.96.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMoqzaBDIE3V4LovTolw/qIbZl2EkoPneaGf/7Ojn+sGbfF1em10H3RtcsBtcHDyTZuowl0TUsimTIXtahHMFf9zbsS51LTRQP5f+0VRp7e5l57vw6uhURojXJIaUV/aXm6bUJTdFoCCO8enEqC5P1d7dHzbWhYFUl9ekBNeUxMWxs6LUNvZGMz6svA30BQasoPwehXgs23uAftxtFmv2r3hdMRpr5hnKcS/jaKdQf08d7HEl5k2bTCuMr872xY0ZCVCaT2ES2Sdr/8VwwyZQb/UuR739I0AzDk6cdO/YQRrKDS83Lwp4oJo5yI2z39DmdxNePxzasx/nbFX+xDPVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35F5E+XIQsOpMfPHb42P/zQM24Be8bzruuIfkS8aEd0=;
 b=M6XltY0SpqTiSYlFduppp+Hes3/UXjagHxFyDN/9YyweORRRWifTcieYnRMyO6ndXAcw8484pyFTBT2HcvS4iNEI7ZOEeuD/r6JozPGXZbP8L9ifhla6w0T+E9PhMeGxwv7jn5k5wdXW4DXrvmJgZzsV31d5QftiQvVwYsiC62vB73CZASGyjshZN0d2VL0vRRJwcQhSEF5JA0uXbrkXZVfxFzPYz3vl/bgpkGumb4khvXw2Ve4Xq6DIMBBqHCM80Ysm5g1rq9hAXCAzy3jN56UGF1dnMjXYaYof8D5yPb/glNtzrIw4tTL94tMVpmDtsgwOANLiYUDeK5H1jN1QMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35F5E+XIQsOpMfPHb42P/zQM24Be8bzruuIfkS8aEd0=;
 b=NT/sLc4veq407msf9eLi+9wSI60ZyJU2vwHRulEtOO1XuwzY3olUol6jdQxM/0DfA0Yp3llXJg+kPyIzFxIP7FHeYiusidmi7R491HU/bhg7Hutpkiob562W5BiVqWl51043BoD24G+xqn9qDsGK8WMw52yOFrXLu1BrPl3mvxx8QT/wKb0/p5AnTglAoIm3r5dOAf+30NpKPF2mO0ohOppE+diEfg7ajcTIaZRjWfO/NyAHrThxblMW7T+1epPOAdwRu9lGNx11bL4BPu/C/PZ6UvYtqXvK4chbklonQa+uLIeAV1lgJuWW0JvyY1dK4ytM+z9nyDC9ksdR3KP6zw==
Received: from MW4PR12MB7261.namprd12.prod.outlook.com (2603:10b6:303:229::22)
 by SN7PR12MB6958.namprd12.prod.outlook.com (2603:10b6:806:262::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Sun, 29 Sep
 2024 15:43:51 +0000
Received: from MW4PR12MB7261.namprd12.prod.outlook.com
 ([fe80::d231:4655:2e3d:af1b]) by MW4PR12MB7261.namprd12.prod.outlook.com
 ([fe80::d231:4655:2e3d:af1b%2]) with mapi id 15.20.8005.024; Sun, 29 Sep 2024
 15:43:50 +0000
From: Bruno Faccini <bfaccini@nvidia.com>
To: Mike Rapoport <rppt@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, Timur Tabi
	<ttabi@nvidia.com>, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH] mm/fake-numa: per-phys node fake size
Thread-Topic: [PATCH] mm/fake-numa: per-phys node fake size
Thread-Index: AQHbC/5hOhfDqm6u6kCFHQtAUmFnf7JmxFMAgABx2ACAAQyIAIAG05iA
Date: Sun, 29 Sep 2024 15:43:50 +0000
Message-ID: <9759DD75-5DA6-4C3A-8300-CD8EA8353BAF@nvidia.com>
References: <20240921081348.10016-1-bfaccini@nvidia.com>
 <ZvKXFnriMlH2y5Oo@kernel.org>
 <A846613E-A2B4-4B56-B368-5786F572F168@nvidia.com>
 <ZvPX2J7D9w0EJTUo@kernel.org>
In-Reply-To: <ZvPX2J7D9w0EJTUo@kernel.org>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB7261:EE_|SN7PR12MB6958:EE_
x-ms-office365-filtering-correlation-id: fc88838f-af66-41b3-7ccc-08dce09d83ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MExoMDFOcHZoVUs2SkszUExZSXdXU1JPYmdCT2laZ0hlMjVOSFU0Z2RiaFNW?=
 =?utf-8?B?M0NoNlo5OEM0K2ZwbE5CRXJMYlRMclhDWjdnWGVQWUFhbkF3TXRLaVoveHl6?=
 =?utf-8?B?L25YZzRVa25MTEJjSXp0RktZdVV1Njd0N0dDRW40VlV2dDgvZi9STnFDMDIw?=
 =?utf-8?B?SWViMnVSSFk4bHlXVWovTTRoMmN1V0Rwb2szSmhtTTNuVmZKSHVUNTFXNlZX?=
 =?utf-8?B?YmhncmpobTAxcmkyRFVROW56NTNCOGo2TVRkZDJ0RDBVT2Izb01FTzZTQnFR?=
 =?utf-8?B?WjV4S0NQemQwUjZneG1SdEFybHRXcDlwOWRYTVZRaTYrNGsvVFovQ0UwQ1Mz?=
 =?utf-8?B?Z1Z3QkFJNnJyWGt5cUo2c3RoL284bHZCa0xnMVU5dW80Z0FaT2xEL1VwNWNz?=
 =?utf-8?B?eCt0dmJCRDZUSzhzR0huSFo2cUcwd01oRmZvTzZiU0ErM0dYQUJTTEFsVGRB?=
 =?utf-8?B?ZlpuMXRYMTEzNEszUHdIcWlOZ3FYYmRJc1M1cndCenY4OHBBK2JkM0FpM2xm?=
 =?utf-8?B?bnRONlNxK1NueGFTcmRhaGJ4Ni9VazNRWTViMCtjaHpNd0JmeWduSVVqNEFH?=
 =?utf-8?B?YWNud2JvNldYOHR3cjZsMWN4U1NJUnYyTlJ3ZEtVblJ5UFRkNzF1dVhiQS84?=
 =?utf-8?B?L2w4R2dJS1k1TmR4VCtkNzhpUStGaWZvR3F5dkpGNDFVS2hyWmpsZllYaVM2?=
 =?utf-8?B?dk9FUHIyUFhOaTVDWlVJd1N3Z1NNT1pMOEYraHN4QlFVMkVtZXZGbkNIVWhB?=
 =?utf-8?B?NFpXVFNBVzZHQWhkYUNQSERvc2dsc3FyV29DVmtHblA1T2xHNXMwVy9JNy91?=
 =?utf-8?B?RWs0cG0wZkNRT0xoZHUvZUJrWlRKYmFPc2I0bDZ2N2xKRjIrRTFodmk5TUw4?=
 =?utf-8?B?SnFTcE1WVHMxYXdESGNwQUlmUDFlYnFudWJhU2hZdS90ekxvWGJoNEE0WmJG?=
 =?utf-8?B?TlBQV2xkMEtPaUlPbVZxSWRBUHlqK0VkN0wyYURac1c1UHlQeVNZbkNxekNh?=
 =?utf-8?B?UmJPT3lWU2JjWHA5dnR6TU9wYS9ZTG05aU5iejVJclVPeEtBajNRQzE0dm5k?=
 =?utf-8?B?SlFEU0RKYUlyL2Z0eVQxc29sSmsvQ3BNa1hPeFNGRW5yMnpsR3ltT3Z6R0xO?=
 =?utf-8?B?L2ZxOVJ2UC9pVDFnSTY0aVpTZkxuV0ZnVm9mNWkwTExuYnFPaVVKckdLQitC?=
 =?utf-8?B?WmRjdlJub0tqR0EvRGlYeEZHbiswSWtpb3ZOdnJIVXh1K29zU1hHT2czbDRE?=
 =?utf-8?B?MFQxdFN1bVllQVlWTlBXTTA2UnJzQTN1Q3JCbDlJWU45bjBxVXQxd2FNODl5?=
 =?utf-8?B?VXg0VVRDaTdRcDlXai8ycWt5VHdvR1FmbU4rcHBYMjc5T1ZzNElDbEVvREgy?=
 =?utf-8?B?SEhpMG9SWUUrYTFFa2Y1WE0vRWQ4akNHbUNVTzkxSGJyZmR4L2h1cTk4UDBT?=
 =?utf-8?B?ekFMQS9aOUxtek1qN3p3MmpXZGw0dG5FazlvbXd0MGVUUU9kUkMwQytjNnZB?=
 =?utf-8?B?eTI5VjFXMXM4MzEzUmV0YS9KV3dML3ZoV0ZTRFBZOGowWFRGZi94Y3RoZm9y?=
 =?utf-8?B?WVRqcXZyc244OGszcVpYTkY4ZFN0aTdDZmhCazFEY0cyZE9PNUlvT1c5QXJQ?=
 =?utf-8?B?Zlg3UHJ4ZUJEVzJkWWp0aU1SSFdZTG5SbXIrUWprdVpWM1dFL0pBZC9JQ0Zw?=
 =?utf-8?B?WlpuVmNTbGVkTTEvSk12Ylk0bno2enFvUVM3VWtzR2JEQ1pNZFNvV0xMZkFj?=
 =?utf-8?B?NnZ6NllHV1l0WnhnL0tFRXUrMGJCc3MwMFV0bGdFN0ZUSDBqRXhvRVg1MVdG?=
 =?utf-8?B?NlVVRkhYRzJ0M2h4OUtnWk51R0t4Q0ZPZHJVNEN2a3NzVVBIdk11K3ZZY3Aw?=
 =?utf-8?B?RDl5VE5kK1h4MFdSWmdxcll5SXRSMGpMaVVDa2xrUEI5TWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7261.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aWg1YituMmtreHZ2Mk1uTnZ2azJhQUJuRUFaUDgraHkrL1Zud2Z4ZnY5WjZa?=
 =?utf-8?B?ZEhzMWZCUUtJbXFQSFhZcFE3a0RqS0htcVJBQ0dWZlVBejJjcXo0bFVLRjEy?=
 =?utf-8?B?WDQ0c2xIMjdiSkc5TGNqU1NCb2xTY1htWTdhVGc1bi9aTHVYVlhad0oxekVo?=
 =?utf-8?B?NDhWdHk1Z3QxRWJyZG9tN3djTVNnSDc0QkdJM1BNNHFmWkJyVHhLWmFZckxq?=
 =?utf-8?B?K2FjcHhRd2J3SWVNSnNMWFFVWmFXc3J0eVlkYnc1U3c5R0ljTHZWZnJRVFEr?=
 =?utf-8?B?UjZPZ0RCQ09LSm5JaWlpWjVRc0VXN1EzeFNhRG55ZlZ6OFdyU0hNb28yN0hI?=
 =?utf-8?B?WnBkZnV6YW94d0tOQ0NCWGJUbVVON2hYNVhrYnpmclZDdEllWUNDajl0TzF3?=
 =?utf-8?B?TkRuQzh4T25KZkE5L3NPMGovcDdVaGtrNVJySWVpYXZBVFVFOXlFelJFaEo2?=
 =?utf-8?B?R1N5YWVJMGFtanRwTmhLSllzaWY3Sk9QTG1nVjE1ZHJzU29aZVpMN2lmSUVD?=
 =?utf-8?B?QWN2bFRPVmU3ZVJ2ZE5nbkFqKzNRYlFjTzRuaDlETnBBNEtVSlBMcXdyNnln?=
 =?utf-8?B?OXFTeDJ1d1NxNTl6QmlkTWUvM3h6V1RBR1ZNTUFJVUdVZnVQa1F6ZlBoNUpN?=
 =?utf-8?B?NDkyQ2JzbnVtdWlrWEFjWStOdytNdWxsSkRVMTZSRHFtOXlhNWxsRkFRVXRq?=
 =?utf-8?B?N2tJeHpFemJuWEVkcW81a1dCZ0Y1cUlPK2tML0VRVjdhVk9tKzdXZ1kzVTBG?=
 =?utf-8?B?UXRjeTRGUTQyUjhsanpycnhWbjhtSU5zbkZ2UnBvbVJTVUNWYTZSVHM5L2kw?=
 =?utf-8?B?dmJjalJqOW82ZXU3cDV6OUZ3d3FQWUlGK25pZE5vY3U1WmdBRXpiNTZBTVBv?=
 =?utf-8?B?akJRNldFZitIYzkzczFiU0lVcDZPZUYrRlVLYkVTS2MyemM5UHZOYmdUOGpi?=
 =?utf-8?B?VExiZjhzSldtRkUyWnVaMWx0OUdUemFabVVMV2RPY0FSekxXYS91ZkpHeGZT?=
 =?utf-8?B?YXpQeFZEQU1RZ1BBdzJnaHRFSHpyTGhwQ25PQmFQYkhUZHpFdCtMSVMxTC9z?=
 =?utf-8?B?NXloazZkbnJuSy9jdm9LZmd5ZC9DTmQ0RlBSeUtmc1cvd0swbnhLZ1pLNFkr?=
 =?utf-8?B?bksrb3BMRk1NbHBLenNpTTQ3QXp6OGVjdnJETU42c3Q3WUMxRFIwKzRacW1l?=
 =?utf-8?B?RitUb3YrZURnbFB1Y2tuTVMwd2tVU3dDZEdJcnphR1RqcXRuV3g4QWYxdlVt?=
 =?utf-8?B?U1ZuMkluendCNHVNbjcyUStHS2FlZCtiamJyWjdDQUEreUwwUEVLV04xMFVt?=
 =?utf-8?B?aWNzSTZHaitTSk4vajhRMEZNMlRsN3hsL0ZacUFnMFN3cUZrZzEybHYxSDJU?=
 =?utf-8?B?VjNlaW40WGFKMit3aUtRVTVnTk9wYzZBZWRSc0NvbGU4TTNiYnVyVkdBZU1x?=
 =?utf-8?B?eGNGRWliOXYzOTBiRGlaQnpwUUhDWGk3S0RLak9jTGxoblQvRVB3MDBjR1Uw?=
 =?utf-8?B?eWp0UHpOT2hxaCtzQ0xWSXR1cDFCYlRma2V5NHpiMGFkQ2dOSzU5bGhzcEJT?=
 =?utf-8?B?Q1JDMXNhQWJSTlRPbWlLNUVxV2JxMkpPeUd6dUtTdndmaUVhU2ZTQ1liZGla?=
 =?utf-8?B?d3Y0WG1NQjVYZ2tmM3kveGJLZFlyeEVndHZlVm94dWFlMG9iTXFhS3lXU2pu?=
 =?utf-8?B?WHlPazBVLzVIaGZRWUhNSDhGM2VIWmlVVWlybmQ2cnZqbmtZTXByWDJvbXVj?=
 =?utf-8?B?c2JRM0RYS2xDOEM5NTMrVFpwNmE5RktET3JsdFNIaWdBMHZya0FLVUljTmla?=
 =?utf-8?B?MDNIZXRTOXl1bzdzcjIwOEV5RXJYQVI4bmpDTXV2RjFsck0yWXU0bzNKeHJ6?=
 =?utf-8?B?QWZ6b3BpY0RvUlRCRno5R1ZheHVMYWZMeG55S1lneXFiaENYLzlIbTFxRXgr?=
 =?utf-8?B?bEI5OWhEbTZ5NVBGUC9pSm9zUkwrMjFrVURacGYwdWxUbXRXME5vUXd1eWpj?=
 =?utf-8?B?czQ2MmFpazV6VU1NQXNQMDRyMnpMZU5hN0pXRi8wZG1YUGhiREcyTkpWUFRR?=
 =?utf-8?B?SkZuRXdobi9OeWVzZ0ZtOS9VVEZRVVI0TXkycHk4Mkd1SlZ1VEgxdEtYSXB4?=
 =?utf-8?B?U2N2eVFCVjl6dkRNSVR2V3hBRDlxeEVjMmQvK3RCRFk5ODJEaWxIL2wydFJy?=
 =?utf-8?B?V0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B87694630297F742A003B83946D984E0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7261.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc88838f-af66-41b3-7ccc-08dce09d83ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2024 15:43:50.5408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bvsqQF8TD3u2MbWLFFbGTaaQOkdFBoxEtnyzV8/q8JmfD6Tk3fdXF2jlUeuO2Rb93yS5bFvmJUmgT0N9AGi8VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6958

DQpPbiAyNS8wOS8yMDI0IDExOjMyLCAiTWlrZSBSYXBvcG9ydCIgPHJwcHRAa2VybmVsLm9yZyA8
bWFpbHRvOnJwcHRAa2VybmVsLm9yZz4+IHdyb3RlOg0KPg0KPiBIaSBCcnVubywNCj4NCj4gUGxl
YXNlIHJlcGx5IGlubGluZSB0byB0aGUgbWFpbHMgb24gTGludXgga2VybmVsIG1haWxpbmcgbGlz
dHMuDQo+DQo+IE9uIFR1ZSwgU2VwIDI0LCAyMDI0IGF0IDAzOjI3OjUyUE0gKzAwMDAsIEJydW5v
IEZhY2Npbmkgd3JvdGU6DQo+ID4gT24gMjQvMDkvMjAyNCAxMjo0MywgIk1pa2UgUmFwb3BvcnQi
IDxycHB0QGtlcm5lbC5vcmcgPG1haWx0bzpycHB0QGtlcm5lbC5vcmc+PiB3cm90ZToNCj4NCj4g
PiA+IE9uIFNhdCwgU2VwIDIxLCAyMDI0IGF0IDAxOjEzOjQ5QU0gLTA3MDAsIEJydW5vIEZhY2Np
bmkgd3JvdGU6DQo+ID4gPiA+IERldGVybWluZSBmYWtlIG51bWEgbm9kZSBzaXplIG9uIGEgcGVy
LXBoeXMgbm9kZSBiYXNpcyB0bw0KPiA+ID4gPiBoYW5kbGUgY2FzZXMgd2hlcmUgdGhlcmUgYXJl
IGJpZyBkaWZmZXJlbmNlcyBvZiByZXNlcnZlZA0KPiA+ID4gPiBtZW1vcnkgc2l6ZSBpbnNpZGUg
cGh5c2ljYWwgbm9kZXMsIHRoaXMgd2lsbCBhbGxvdyB0byBnZXQNCj4gPiA+ID4gdGhlIGV4cGVj
dGVkIG51bWJlciBvZiBub2RlcyBldmVubHkgaW50ZXJsZWF2ZWQuDQo+ID4gPiA+DQo+ID4gPiA+
IENvbnNpZGVyIGEgc3lzdGVtIHdpdGggMiBwaHlzaWNhbCBOdW1hIG5vZGVzIHdoZXJlIGFsbW9z
dA0KPiA+ID4gPiBhbGwgcmVzZXJ2ZWQgbWVtb3J5IHNpdHMgaW50byBhIHNpbmdsZSBub2RlLCBj
b21wdXRpbmcgdGhlDQo+ID4gPiA+IGZha2UtbnVtYSBub2RlcyAoZmFrZT1OKSBzaXplIGFzIHRo
ZSByYXRpbyBvZiBhbGwNCj4gPiA+ID4gYXZhaWxhYmxlL25vbi1yZXNlcnZlZCBtZW1vcnkgY2Fu
IGNhdXNlIHRoZSBpbmFiaWxpdHkgdG8NCj4gPiA+ID4gY3JlYXRlIE4vMiBmYWtlLW51bWEgbm9k
ZXMgaW4gdGhlIHBoeXNpY2FsIG5vZGUuDQo+ID4gPg0KPiA+ID4NCj4gPiA+IEknbSBub3Qgc3Vy
ZSBJIHVuZGVyc3RhbmQgdGhlIHByb2JsZW0geW91IGFyZSB0cnlpbmcgdG8gc29sdmUuDQo+ID4g
PiBDYW4geW91IHByb3ZpZGUgbW9yZSBzcGVjaWZpYyBleGFtcGxlPw0KPiA+DQo+ID4gSSB3aWxs
IHRyeSB0byBiZSBtb3JlIHByZWNpc2UgYWJvdXQgdGhlIHNpdHVhdGlvbiBJIGhhdmUgZW5jb3Vu
dGVyZWQgd2l0aA0KPiA+IHlvdXIgb3JpZ2luYWwgc2V0IG9mIHBhdGNoZXMgYW5kIGhvdyBJIHRo
b3VnaHQgaXQgY291bGQgYmUgc29sdmVkLg0KPiA+DQo+ID4gT24gYSBzeXN0ZW0gd2l0aCAyIHBo
eXNpY2FsIE51bWEgbm9kZXMgZWFjaCB3aXRoIDQ4MEdCIGxvY2FsIG1lbW9yeSwNCj4gPiB3aGVy
ZSB0aGUgYmlnZ2VzdCBwYXJ0IG9mIHJlc2VydmVkIG1lbW9yeSAofiAzMDlNQikgaXMgZnJvbSBu
b2RlIDAgd2l0aCBhDQo+ID4gc21hbGwgcGFydCAofiA1MU1CKSBmcm9tIG5vZGUgMSwgbGVhZGlu
ZyB0byB0aGUgZmFrZSBub2RlIHNpemUgb2YgfjwxMjBHQg0KPiA+IGJlaW5nIGRldGVybWluZWQu
DQo+ID4NCj4gPiBCdXQgd2hlbiBhbGxvY2F0aW5nIGZha2Ugbm9kZXMgZnJvbSBwaHlzaWNhbCBu
b2Rlcywgd2l0aCBsZXQgc2F5IGZha2U9OA0KPiA+IGJvb3QgcGFyYW1ldGVyIGJlaW5nIHVzZWQs
IHdlIGVuZGVkIHdpdGggbGVzcyAoNykgdGhhbiBleHBlY3RlZCwgYmVjYXVzZQ0KPiA+IHRoZXJl
IHdhcyBub3QgZW5vdWdoIHJvb20gdG8gYWxsb2NhdGUgOC8yIGZha2Ugbm9kZXMgaW4gcGh5c2lj
YWwgbm9kZSAwLA0KPiA+IGR1ZSB0byB0b28gYmlnIHNpemUgZXZhbHVhdGlvbi4gDQo+IA0KPiBU
aGUgYWJpbGl0eSB0byBzcGxpdCBhIHBoeXNpY2FsIG5vZGUgdG8gZW11bGF0ZWQgbm9kZXMgZGVw
ZW5kcyBub3Qgb25seSBvbg0KPiB0aGUgbm9kZSBzaXplcyBhbmQgaG9sZSBzaXplcywgYnV0IGFs
c28gd2hlcmUgdGhlIGhvbGVzIGFyZSBsb2NhdGVkIGluc2lkZQ0KPiB0aGUgbm9kZXMgYW5kIGl0
J3MgcXVpdGUgcG9zc2libGUgdGhhdCBmb3Igc29tZSBtZW1vcnkgbGF5b3V0cw0KPiBzcGxpdF9u
b2Rlc19pbnRlcmxlYXZlKCkgd2lsbCBmYWlsIHRvIGNyZWF0ZSB0aGUgcmVxdWVzdGVkIG51bWJl
ciBvZiB0aGUNCj4gZW11bGF0ZWQgbm9kZXMuDQoNCkkgYW0gc29ycnksIGJ1dCBsb29raW5nIGF0
IHRoZSB3YXkgbm9uLXJlc2VydmVkIG1lbW9yeSBpcyBiZWluZyBjb2xsZWN0ZWQgd2hlbiBhbGxv
Y2F0aW5nIHRvIGZha2Ugbm9kZXMgaW5zaWRlIHBoeXNpY2FsIG5vZGVzLCBJIGRvbid0IHVuZGVy
c3RhbmQgaG93IHVzaW5nIGEgcGVyLXBoeXMgbm9kZSBzaXplIHdvdWxkIHN0aWxsIGFsbG93IG5v
dCB0byBhbGxvY2F0ZSB0aGUgcmVxdWVzdGVkIG51bWJlciBvZiBmYWtlIG5vZGVzID8NCkJ5IHRo
ZSB3YXksIEkgaGF2ZSBzdWNjZXNzZnVsbHkgdGVzdGVkIHRoZSBjb2RlIG9uIG91ciBoYXJkd2Fy
ZSB3aGVyZSB0aGUgb3JpZ2luYWwgY29kZSB3YXMgZmFpbGluZyB0byBkbyBzby4NCg0KPg0KPiA+
IEkgZG9uJ3QgdGhpbmsgdGhhdCBmYWtlPU4gYWxsb2NhdGlvbiBtZXRob2QgaXMgaW50ZW5kZWQg
dG8gZ2V0IGZha2Ugbm9kZXMNCj4gPiB3aXRoIGVxdWFsIHNpemUsIGJ1dCB0byBnZXQgdGhpcyBl
eGFjdCBudW1iZXIgb2Ygbm9kZXMuIFRoaXMgaXMgd2h5IEkNCj4gPiB0aGluayB3ZSBzaG91bGQg
dXNlIGEgcGVyLXBoeXMgbm9kZSBzaXplIGZvciB0aGUgZmFrZSBub2RlcyBpdCB3aWxsIGhvc3Qu
DQo+DQo+IElNTyB5b3VyIGNoYW5nZSBhZGRzIHRvIG11Y2ggY29tcGxleGl0eSBmb3IgYSBmZWF0
dXJlIHRoYXQgYnkgZGVmaW5pdGlvbg0KPiBzaG91bGQgYmUgdXNlZCBvbmx5IGZvciBkZWJ1Z2dp
bmcuDQoNCldlbGwgaXQgaXMgb25seSBleGVjdXRlZCBvbmNlIGR1cmluZyBib290LCBhbmQgYXMg
eW91IHNhaWQgZm9yIGRlYnVnZ2luZywgc28gSSBiZWxpZXZlIHdoZW4gdGhlIGJvb3Qgc3BlZWQg
aXMgbm90IGEgcmVxdWlyZW1lbnQuDQpBbmQgbXkgdGVzdGluZyBvbiBvdXIgZmF0IE51bWEgbm9k
ZXMgZGlkIG5vdCBzaG93IGEgcmVhbCBkaWZmZXJlbmNlLg0KDQo+DQo+IEFsc28sIHRoZXJlIGlz
IGEgdmFyaWF0aW9uIG51bWE9ZmFrZT08Tj5VIG9mIG51bWE9ZmFrZSBwYXJhbWV0ZXIgdGhhdA0K
PiBkaXZpZGVzIGVhY2ggbm9kZSBpbnRvIE4gZW11bGF0ZWQgbm9kZXMuDQoNClJpZ2h0LCBidXQg
Ym90aCBtZXRob2RzIHNob3VsZCB3b3JrIGFzIGV4cGVjdGVkLCBpcydudCBpdCA/DQpBbmQgb25l
IGFsbG9jYXRlcyBlbXVsYXRlZCBub2RlcyBpbnRlcmxlYXZlZCBvbiBwaHlzaWNhbCBub2RlcyB3
aGVuIHRoZSBzZWNvbmQgaXMgZG9pbmcgYWxsb2NhdGlvbiBzZXJpYWxseS4NCg0KPg0KPiA+IEhv
cGUgdGhpcyBjbGFyaWZpZXMgdGhlIHJlYXNvbiBhbmQgaW50ZW50IGZvciBteSBwYXRjaCwgaGF2
ZSBhIGdvb2QgZGF5LA0KPiA+IEJydW5vDQo+ID4NCj4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTog
QnJ1bm8gRmFjY2luaSA8YmZhY2NpbmlAbnZpZGlhLmNvbSA8bWFpbHRvOmJmYWNjaW5pQG52aWRp
YS5jb20+Pg0KPiA+ID4gLS0tDQo+ID4gPiBtbS9udW1hX2VtdWxhdGlvbi5jIHwgNjYgKysrKysr
KysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gPiAxIGZpbGUgY2hh
bmdlZCwgMzkgaW5zZXJ0aW9ucygrKSwgMjcgZGVsZXRpb25zKC0pDQo+DQo+IC0tDQo+IFNpbmNl
cmVseSB5b3VycywNCj4gTWlrZS4NCj4NCg0K

