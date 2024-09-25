Return-Path: <linux-kernel+bounces-338305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4458098562A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 11:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECD2E286DBF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0592615F33A;
	Wed, 25 Sep 2024 09:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="iLZJhQGt"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9229156257
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 09:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727255642; cv=fail; b=S+l9xwhbZYmnc0rl1t43qememieKR6mMJyZ5KPD6muip+x3buPKEEzJ9YZKZ4jczSJmJLQydGnCbJ9ncRKslVtwuENcqhIruyUSBzOCSBuc702mPPu787TUq6Bb0/rR5TFisQMInkkpAEzUN/nKXf//jtr551QA97hqisx4r97M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727255642; c=relaxed/simple;
	bh=oLue5rMmYytIQtA3pU+CeKLoR3DQwI33voTQjpyES6s=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W2BWJ+14Kd5IJzQEvt9i9l773dhjlxwlBsEdizZP6Pcxc02w2l3iHcK3oL/b9WOK2GHeUNYoOVRmcf4bdQFv/R4of5A3lyeQfeQbsh0stteTtK6XMtCaKOeu78P8fMvb3+iVoprDJxmNdPmxLz+SnUNo+O8lISHl3k43/Fg78LI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=iLZJhQGt; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48P8oUCM025510;
	Wed, 25 Sep 2024 02:13:33 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 41swnk1cq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 02:13:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ncSpdESn4Iv0dwXoelYWAGVRNadr/hmXkfnkBWslhLqb5Y/ltaS01cjS9u2LMNHEB1Zt9S89EkZfxo37w3/zm9RQzZ4G9lpvak0V13b0V2Gig80tzZNLCB8CPOmQfChbYHuare64AjdfW53rSbB0PH2RJp893b+w9nlkFTukTymSHNvP+TF7J/VlMSDwswhIoSSjAu6mIz72vD8bVux6KCudIYYdreo21FGbCcUL8rkWb0zOC8JmVuwNadS1a6YTxRRVI6QCABUAzfjQz6cdyENpM6PmRsfruD7HoMOcggMj18RVKucjLLykwFOLV11nqC+siHaTf1xJZNf0FyOWYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLue5rMmYytIQtA3pU+CeKLoR3DQwI33voTQjpyES6s=;
 b=msEPi4VeAEEqfsIn+sI2L5rxCU4eM3m/FW79/Iz4zy70f0nqAoOFm631TGkmIKYqE9ZWKyWtvFJFval7AHRWzzsEGdWrC957TuOHKNM26uY+8iHg6QMgp78ybru6oar5D1mtiQ/gSQgDbr3j4CpHlEZnXVePuR4ThMcKAAkQHImZADPndWBBj3XaRamRB2LJGRiYOEqhBfLEcUN94jR0ff/DJr3BeNUDH6sJFd9Hcvv98T7a3mXzfPaRQUbA14NcUU4Pd7dzd3G+Psd3W0/Hv7xHVKQ91+xlHPMMi8GxXqWQXh2Qn0VrmDe7LCqqbE/HS1ibkpTA485wsY3/3xNXHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLue5rMmYytIQtA3pU+CeKLoR3DQwI33voTQjpyES6s=;
 b=iLZJhQGtjVMtLubaRyt6tyXy8GXirA7U5fVUgVEt3qx9b0w8Ag133PPmxC1q7xQCruhncjZUUBqRfKQVCCzOiGOTGaR2E0MQ4+f1ACDHgpzOwz5ELI8cb6berEivQjBpOBc0ti4Fo1hLxVh8uCZO12GiZz5/ysFHGXvB6qpABAI=
Received: from DM6PR18MB3289.namprd18.prod.outlook.com (2603:10b6:5:1cf::15)
 by DM6PR18MB3587.namprd18.prod.outlook.com (2603:10b6:5:2ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Wed, 25 Sep
 2024 09:13:29 +0000
Received: from DM6PR18MB3289.namprd18.prod.outlook.com
 ([fe80::6a44:6658:d0cf:bca2]) by DM6PR18MB3289.namprd18.prod.outlook.com
 ([fe80::6a44:6658:d0cf:bca2%4]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 09:13:27 +0000
From: Anshumali Gaur <agaur@marvell.com>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "arnd@arndb.de"
	<arnd@arndb.de>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "nikita.shubin@maquefel.me" <nikita.shubin@maquefel.me>,
        "vkoul@kernel.org"
	<vkoul@kernel.org>,
        "cyy@cyyself.name" <cyy@cyyself.name>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri
 Goutham <sgoutham@marvell.com>
Subject: Re: [PATCH 4/4] soc: marvell: rvu-pf: Handle function level reset
 (FLR) IRQs for VFs
Thread-Topic: [PATCH 4/4] soc: marvell: rvu-pf: Handle function level reset
 (FLR) IRQs for VFs
Thread-Index: AQHbDysuy3HEzSEbhUS/J/6HvQ28jA==
Date: Wed, 25 Sep 2024 09:13:27 +0000
Message-ID:
 <DM6PR18MB3289700364A89C7714973C70B8692@DM6PR18MB3289.namprd18.prod.outlook.com>
References: <20240920112318.2722488-1-agaur@marvell.com>
	 <20240920112318.2722488-5-agaur@marvell.com>
 <8f3c9f97d2de59ba73bf3c50f16d262d68ef4b2d.camel@gmail.com>
In-Reply-To: <8f3c9f97d2de59ba73bf3c50f16d262d68ef4b2d.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR18MB3289:EE_|DM6PR18MB3587:EE_
x-ms-office365-filtering-correlation-id: d514f47a-25dd-4263-298f-08dcdd4250bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?akNWZy83dkpXY2JwY3RCSVNrSGs3ZWNlTmlwN1lhWGZVWXplblk1RWZGeUdv?=
 =?utf-8?B?KzFzWXVrVldvSjNNcFNDejRLOTZJc0E0RkdPK0pDcE1IK0dselBSNHNZaURJ?=
 =?utf-8?B?VDhnc2VmOXNkRnZqYi9tUTd5b3RhNGcwVDh2aWRLNE9PRC9yeFEzZnpYaGxm?=
 =?utf-8?B?TlBLUENOLzlORHMvMG5FdXN1THk0cExZaGdvNlgzMTdIUTE2SmpyWThtc0hl?=
 =?utf-8?B?dnFmSnNUVWJjOFpSSUpxbGJMeExZV0FlOUZVYXMvQWRCSXBzNTNQQ210K1V6?=
 =?utf-8?B?eW81Mlo3dlBlZHRrMWM2clBBdnU2aWhCdk0vQ2FEYTlhcmhUN2RHWEYxdVNU?=
 =?utf-8?B?d2RkOEhjT1VIZXhzSjF0SzdYdnhxeDc5dExSU1k3b3pBY25PNjZNemlaM0M3?=
 =?utf-8?B?K0g3MDlQZU1nUTlNdmJWQzh4QzYza3hZS1JmSlBCazEzalpLUmx4M096Q25J?=
 =?utf-8?B?U3lYRi9rTGhCbUk1Wkphb0hUa29DeHgyMW1PUlJYWlNDYjNnc0Fvd3dxMUdH?=
 =?utf-8?B?ZVQra0VtNDBPQVlTMUZueW1TSFJaT3N1Nytpd0plVnV4ZEFhdjFsZ1pDbnNI?=
 =?utf-8?B?MjZLVnBzWFVKQWQwcmJKc3FFZnJiRnkrdDZCN3VGZzArT1hVQ09lNHpRSi8w?=
 =?utf-8?B?LytUTTY4b3h4akJVQXJDR202dXliVlFvditBL0NiM0p0UEhpWTY3Z2dZVEFZ?=
 =?utf-8?B?NHRqTDRVWlkzUEpWeXRPalRNQVBuWkZTd2hWQ2hZWDM4bXh0KzE2VXdsQXJ4?=
 =?utf-8?B?dUJVNE1zYWtWRVkwNjNoQ3pEbEE4ekh1RkdaNDVWSEljYmZWc0lvSm9IUjZn?=
 =?utf-8?B?S3EvU3BBUTRYTjk1dmpyU0ZHV01VSlVDQVYvWVF4UnZTUUNPaXJ1Yjgxam0z?=
 =?utf-8?B?WklodUFOSnVhL2lQYW94WWkwTWp0WFFCMVlnaUJ1QXliZzM1NGNUYVN4WXpv?=
 =?utf-8?B?enNra2FQSFd2M1NIOGZtZ3BjNmZOekMxcXQrd3BSYmErUjROSmQ3L2habXov?=
 =?utf-8?B?ek5MV0lXSW5XRUVPMXhLbGJaazgwYTV1bmUzclBsMEJ5bUVydGtKeGE3TjBS?=
 =?utf-8?B?QTdyVWx1SEpYWThSZkRjdTR5bk0rcVZYUDA2bGt1dW8yT1JmUUMybE8wcWtO?=
 =?utf-8?B?UitqaDRCRlZiS0ZuUmlCcFlieDR4UjJLVlhlS2xFTy9TOWw2NFFmb2NOU2t3?=
 =?utf-8?B?b1NYVGpGQU9STFlMTC9kTm9CNXJMSEtHbGxpbDFZbVBvSzlCOERKSDV2V3NJ?=
 =?utf-8?B?Tko3Yktma1ZKYnpmZDNPM3I2RCs1REpKTWhpeTBEaFNvVld4b0NKMVZQRjFn?=
 =?utf-8?B?NmJzQW1jSGFMNXUxMnZXNXRiRFBCZElFKzJiem5yRzh6VG1pRjZoQUNaS0ZO?=
 =?utf-8?B?U0hldmwvcDlIZVl1YkdkcW1URkoyZFdnUkJVdm1nZnFZc3Iram9tbFgyZ3JT?=
 =?utf-8?B?RktXV1pKQU5WbWpjR25YcVpFaFc5Y0toZjJ0RUdQejZ1SjdDSGVoTkkxam5z?=
 =?utf-8?B?SEJLS2FrdzVQYjgvUXFTeEd1UlZyMEhXWi90L05jVVFzNk90V3dSeUg4SUto?=
 =?utf-8?B?Ym5WMVV3RmMyMnFmT0s3dkZoU3NCc1BOMnRTRE5oMS84K1Z2dWNHSjl0aytW?=
 =?utf-8?B?cllqbmN2MStDcGpZWTdLMzdjN0p5QkVQS2lKcTc4bGRSNXRVNHRnTmdya2RD?=
 =?utf-8?B?QzQwTFpNQUJzYy9aRWg0dG43cWM5cit3YitSQi9EM1JaZHU0M0doYmYyMkt1?=
 =?utf-8?B?eE1CSHFYQ2tuMzVTQm5oZVB1cHA3UE02NFRWcFR5MmhvRGJqQkN0Q1VoRnRl?=
 =?utf-8?B?cDFSZDRhVldaajQraGJKVnRXOVJkLy90ZkhydXRlc0hIbnVUZnB6cHFWWEFk?=
 =?utf-8?B?V29wbURmMk9XVWlWbGFDWmRhbEx6N2VtWU4rN1BhdVZQUHdkQVN4UEFXdnRP?=
 =?utf-8?Q?GLCV8ulsx0Q=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR18MB3289.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bU83ZGlQWkR4Nzd4SGZ0ZEtMVnRuNkpQY0Z0TUJVdlhoODA3STNMYkN2VUlB?=
 =?utf-8?B?Z093Skx6dHZCTVlaUnJIdDBzVHNJVnJqU3FGZndBRVltanZ2R1llV29vK0Jr?=
 =?utf-8?B?dVRBZlhMZEM1cWtYZkU4Tkc1aDE2aGx3Q2hpbG5oQWZRaCtUbGlrUXhHS0hp?=
 =?utf-8?B?WlNwczB0STc4cFo1RVdUTGhsMUVsbDRhbFIwb0JCT3c3T3VYN2htdXpveWI5?=
 =?utf-8?B?aE0wTVRPdXRUNGdTcFZtU3k0d0xGcTc1S28yUGJLektIWGtIeXZRUGpjU2g1?=
 =?utf-8?B?THpxUVBQRUNmOWI4Ni9hWHl2a29NVkU4Q2Z2aDN3cUJWQTBVeGF4NkZVTDFi?=
 =?utf-8?B?bzlYenhpVDhIWlQ1VGV4aUNobG04cmZOb2dCWnpMbHVpUlYwNit3LzR4dXQ3?=
 =?utf-8?B?VHhiR0Nwb0ZIdms0RExkMGUxNGRBQ0FGVGZmSm80b0hDZmRDaUNkVFhXa0o4?=
 =?utf-8?B?QUZjK3NWaGtWSzRweUx0R1JjQ3l4NytHeTY1TTZZak1VdWd6M2JCQzgzR3NY?=
 =?utf-8?B?d1hXWk5lK2w0REZOOFRhczJGM002SHZ4TjhGRm8rUUxJbEk3UHJ4Z0pZalJJ?=
 =?utf-8?B?MGJqWll3S1FlVHdZZ0NCZTFBb2pEODVYTzBlTXR1RFFnckZrTkhnR0hOZDh4?=
 =?utf-8?B?N1A5Q01wUW1lUEZDT1lyTFl6QkZES2JaRjdFenBROFdyWTYrYlNTY0V6M2Rh?=
 =?utf-8?B?aVNDSzM3SUU3bDNkS1RuL1ZHZWhmSU01aG5EQUJqZUg0L2JGbU52djA3TTZD?=
 =?utf-8?B?UVBIcU5SZzluZVM0d2JQVzFaYW4wb1FVa0xqdEExSXRFNDNITlZEUGtFT3lt?=
 =?utf-8?B?ZkVPeUw3eDl0UytLWGVUNmhGQ2sxTmx2YUc3akcyakp0ZW5IejI2UTN3WW5r?=
 =?utf-8?B?L1RCTFh3ZEwzMDN0dVlwbWRzbVpLZEVVOFBCRS8zL0hQczVRZmpJUTY5Y3R0?=
 =?utf-8?B?ck9QRERSdGp2QWtlbmlUN2s3ZXpVNTlWNEs3bDhlNnNqbDZFWkNuQUI2dHpB?=
 =?utf-8?B?eVk4d0w2UFBvYXIzeWRhaFJTVFBIU0d6cVlvMGNTUUw1OTJCYnJxTnZ5NXNk?=
 =?utf-8?B?WjlPbXNCblJpZ21wNFVIckxUTlhEYXFLenpWMTU0eGhtaUNOR05maUFySHFv?=
 =?utf-8?B?SGNHcDdZUGI0ajhvWHdBTjhpTklVaGVPeFVaenBSYnI2YlpyaUF1cnFRUVRT?=
 =?utf-8?B?WmVCT1FJanFBRjJ2dVYvT0t5Y2ZzeUc1NGdhazhiWGZEQ0NzMXpTVmdHYko5?=
 =?utf-8?B?VDNnOTdVbG9KQ2RUbWF0K21PUmdBRDhyaUFhTFRsY2dSVmxzYWtZRTRvRk5w?=
 =?utf-8?B?NHF5YWVuYWhzUWluSmgwNDRvZE1lNlU1djkwZVBFM1dRTEx5aWNnTFl6WkJY?=
 =?utf-8?B?b1FRblYvaHlwRTluRXM2cTJkcXh0NWZjM3o5MzJTVk4zRTlUUncvT1pWSG9C?=
 =?utf-8?B?SldZOFBQaWJyYTZTZzFJYXBZNUI1bUNDVW0xOXZJa012QmR5YzRuQ0tPUU9s?=
 =?utf-8?B?dUdLRXBGd2oySkhCeWlaU2lDYlh2QitRUVhocjNoeklMWEZOZGpzcFVMRWtz?=
 =?utf-8?B?YzhKK2ViMmhsemhVR1VPa21SYzFVZlc1RHpnaXJYZTlUOUQrcGdlQjUzdzR2?=
 =?utf-8?B?NXNkV3htZ0Fna3haKytOcHIxaE5TcjQ5SW1UcEszWXdnVEIyM3U4Qk9LQ05U?=
 =?utf-8?B?UTJNT0tUSUhuV2pPR3JNZmNBcDc0MlYrajAxNG5FVVBvcFJiSEFoWDAvZzBN?=
 =?utf-8?B?eXh0aytodWNiTEVrSEE4YmdqUFBKc0haS0IvVVJ6eHNuWDBYTmx1UXJNOXEv?=
 =?utf-8?B?ZEk3Q1FsOWd5VkYrdEJvY29qZ1lwSzl3YjNrSDcwcWZRY0x6UUlsU3lTdzRR?=
 =?utf-8?B?cTBuS1pRNE5yaWZhdGZscDVyUDczR3BFekhhMFMrQ3RRMFlVcHZwanRMcXRk?=
 =?utf-8?B?a1Q2NDJsUFJveHFsTjVMOG1JbVZRakdqTXFCUURpelNXaEIzSmt3cWsvTHJS?=
 =?utf-8?B?NkFjcUpVYXN2S3Ztd3dLNVVsa3FJT3R2UnVxa2hVU2p2SjF2S2IrMURqTUZo?=
 =?utf-8?B?Uk5HQjJLL1JwM2xUNlZlRk9QK2RmT0tTamtyVU1uZjFKbEhvL0MyV2pMby9x?=
 =?utf-8?Q?4E5U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR18MB3289.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d514f47a-25dd-4263-298f-08dcdd4250bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 09:13:27.1700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y9L/63JIZ/uIb+zK5YW1tl8/BCT/LuHGJNXzPI0zQq8o3q9kEBfqkCP/GzAgVyxgbM9r4SRVKbuJSHmWwZsBMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3587
X-Proofpoint-GUID: OJ5Du36w2EOcxMBnEL9NUb7sQMbHM0mt
X-Proofpoint-ORIG-GUID: OJ5Du36w2EOcxMBnEL9NUb7sQMbHM0mt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4YW5kZXIgU3ZlcmRsaW4g
PGFsZXhhbmRlci5zdmVyZGxpbkBnbWFpbC5jb20+DQo+IFNlbnQ6IFN1bmRheSwgU2VwdGVtYmVy
IDIyLCAyMDI0IDQ6MjAgQU0NCj4gVG86IEFuc2h1bWFsaSBHYXVyIDxhZ2F1ckBtYXJ2ZWxsLmNv
bT47IGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tOw0KPiB1bGYuaGFuc3NvbkBsaW5hcm8ub3Jn
OyBhcm5kQGFybmRiLmRlOyBsaW51cy53YWxsZWlqQGxpbmFyby5vcmc7DQo+IG5pa2l0YS5zaHVi
aW5AbWFxdWVmZWwubWU7IHZrb3VsQGtlcm5lbC5vcmc7IGN5eUBjeXlzZWxmLm5hbWU7DQo+IGty
enlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgU3VuaWwgS292dnVyaQ0KPiBHb3V0aGFtIDxzZ291dGhhbUBtYXJ2ZWxsLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCA0LzRdIHNvYzogbWFydmVsbDogcnZ1LXBmOiBIYW5kbGUgZnVuY3Rp
b24gbGV2ZWwNCj4gcmVzZXQgKEZMUikgSVJRcyBmb3IgVkZzDQo+IA0KPiBIaSBBbnNodW1hbGkh
IE9uIEZyaSwgMjAyNC0wOS0yMCBhdCAxNjrigIo1MyArMDUzMCwgQW5zaHVtYWxpIEdhdXIgd3Jv
dGU6ID4NCj4gQWRkZWQgUENJZSBGTFIgaW50ZXJydXB0IGhhbmRsZXIgZm9yIFZGcy4gV2hlbiBG
TFIgaXMgdHJpZ2dlcmVkIGZvciBWRnMsID4gcGFyZW50DQo+IFBGIGdldHMgYW4gaW50ZXJydXB0
LiBQRiBjcmVhdGVzIGEgbWJveCBtZXNzYWdlIGFuZCBzZW5kcyBpdCB0byA+IFJWVSBBZG1pbg0K
PiBmdW5jdGlvbiANCj4gSGkgQW5zaHVtYWxpIQ0KPiANCj4gT24gRnJpLCAyMDI0LTA5LTIwIGF0
IDE2OjUzICswNTMwLCBBbnNodW1hbGkgR2F1ciB3cm90ZToNCj4gPiBBZGRlZCBQQ0llIEZMUiBp
bnRlcnJ1cHQgaGFuZGxlciBmb3IgVkZzLiBXaGVuIEZMUiBpcyB0cmlnZ2VyZWQgZm9yDQo+ID4g
VkZzLCBwYXJlbnQgUEYgZ2V0cyBhbiBpbnRlcnJ1cHQuIFBGIGNyZWF0ZXMgYSBtYm94IG1lc3Nh
Z2UgYW5kIHNlbmRzDQo+ID4gaXQgdG8gUlZVIEFkbWluIGZ1bmN0aW9uIChBRikuIEFGIGNsZWFu
cyB1cCBhbGwgdGhlIHJlc291cmNlcyBhdHRhY2hlZA0KPiA+IHRvIHRoYXQgc3BlY2lmaWMgVkYg
YW5kIGFja3MgdGhlIFBGIHRoYXQgRkxSIGlzIGhhbmRsZWQuDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBBbnNodW1hbGkgR2F1ciA8YWdhdXJAbWFydmVsbC5jb20+DQo+ID4gLS0tDQo+IA0KPiBb
XQ0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWFydmVsbC9ydnVfZ2VuX3BmL2dl
bl9wZi5jDQo+ID4gYi9kcml2ZXJzL3NvYy9tYXJ2ZWxsL3J2dV9nZW5fcGYvZ2VuX3BmLmMNCj4g
PiBpbmRleCA2MjRjNTUxMjNhMTkuLmUyZTdjMTFkZDg1ZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL3NvYy9tYXJ2ZWxsL3J2dV9nZW5fcGYvZ2VuX3BmLmMNCj4gPiArKysgYi9kcml2ZXJzL3Nv
Yy9tYXJ2ZWxsL3J2dV9nZW5fcGYvZ2VuX3BmLmMNCj4gPiBAQCAtNjkxLDYgKzcwMCwyMTEgQEAg
c3RhdGljIGludCBydnVfZ2VuX3BmX3JlZ2lzdGVyX3BmdmZfbWJveF9pbnRyKHN0cnVjdA0KPiBn
ZW5fcGZfZGV2ICpwZmRldiwgaW50IG51bXYNCj4gPiAgCXJldHVybiAwOw0KPiA+ICB9DQo+ID4N
Cj4gPiArc3RhdGljIHZvaWQgcnZ1X2dlbl9wZl9mbHJfaGFuZGxlcihzdHJ1Y3Qgd29ya19zdHJ1
Y3QgKndvcmspIHsNCj4gPiArCXN0cnVjdCBmbHJfd29yayAqZmxyd29yayA9IGNvbnRhaW5lcl9v
Zih3b3JrLCBzdHJ1Y3QgZmxyX3dvcmssIHdvcmspOw0KPiA+ICsJc3RydWN0IGdlbl9wZl9kZXYg
KnBmZGV2ID0gZmxyd29yay0+cGZkZXY7DQo+ID4gKwlzdHJ1Y3QgbWJveCAqbWJveCA9ICZwZmRl
di0+bWJveDsNCj4gPiArCXN0cnVjdCBtc2dfcmVxICpyZXE7DQo+ID4gKwlpbnQgdmYsIHJlZyA9
IDA7DQo+ID4gKw0KPiA+ICsJdmYgPSBmbHJ3b3JrIC0gcGZkZXYtPmZscl93cms7DQo+ID4gKw0K
PiA+ICsJbXV0ZXhfbG9jaygmbWJveC0+bG9jayk7DQo+ID4gKwlyZXEgPSBnZW5fcGZfbWJveF9h
bGxvY19tc2dfdmZfZmxyKG1ib3gpOw0KPiANCj4gU28gdGhpcyBmdW5jdGlvbiB3YW50J3MgdG8g
YmUgYSBwcm9kdWN0IG9mICJNIiBtYWNybyBmcm9tIHBhdGNoIDI/DQo+IEJ1dCBkb2VzIGl0IHJl
YWxseSBoYXBwZW4/DQo+IA0KWWVzIGl0IHVzZXMgTSBtYWNybyANCk0oVkZfRkxSLCAgICAgICAg
ICAgICAgIDB4MDA2LCB2Zl9mbHIsIG1zZ19yZXEsIG1zZ19yc3ApDQp5b3UgY2FuIHJlZmVyOiBu
ZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvYWYvbWJveC5oIGZvciBtb3JlIGRldGFpbHMN
Cj4gPiArCWlmICghcmVxKSB7DQo+ID4gKwkJbXV0ZXhfdW5sb2NrKCZtYm94LT5sb2NrKTsNCj4g
PiArCQlyZXR1cm47DQo+ID4gKwl9DQo+ID4gKwlyZXEtPmhkci5wY2lmdW5jICY9IFJWVV9QRlZG
X0ZVTkNfTUFTSzsNCj4gDQo+IERpZCB5b3UgbWVhbiAicmVxLT5oZHIucGNpZnVuYyAmPSB+UlZV
X1BGVkZfRlVOQ19NQVNLOyI/DQo+IA0KeWVzLCB0aGFuayB5b3UgZm9yIHBvaW50aW5nIHRoaXMg
b3V0LCB3aWxsIGRvIHRoZSBjaGFuZ2VzLg0KPiA+ICsJcmVxLT5oZHIucGNpZnVuYyB8PSAodmYg
KyAxKSAmIFJWVV9QRlZGX0ZVTkNfTUFTSzsNCj4gPiArDQo+ID4gKwlpZiAoIXJ2dV9nZW5fcGZf
c3luY19tYm94X21zZygmcGZkZXYtPm1ib3gpKSB7DQo+ID4gKwkJaWYgKHZmID49IDY0KSB7DQo+
ID4gKwkJCXJlZyA9IDE7DQo+ID4gKwkJCXZmID0gdmYgLSA2NDsNCj4gPiArCQl9DQo+ID4gKwkJ
LyogY2xlYXIgdHJhbnNjYXRpb24gcGVuZGluZyBiaXQgKi8NCj4gPiArCQl3cml0ZXEoQklUX1VM
TCh2ZiksIHBmZGV2LT5yZWdfYmFzZSArDQo+IFJWVV9QRl9WRlRSUEVORFgocmVnKSk7DQo+ID4g
KwkJd3JpdGVxKEJJVF9VTEwodmYpLCBwZmRldi0+cmVnX2Jhc2UgKw0KPiBSVlVfUEZfVkZGTFJf
SU5UX0VOQV9XMVNYKHJlZykpOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCW11dGV4X3VubG9jaygm
bWJveC0+bG9jayk7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpcnFyZXR1cm5fdCBydnVf
Z2VuX3BmX21lX2ludHJfaGFuZGxlcihpbnQgaXJxLCB2b2lkICpwZl9pcnEpDQo+ID4gK3sNCj4g
PiArCXN0cnVjdCBnZW5fcGZfZGV2ICpwZmRldiA9IChzdHJ1Y3QgZ2VuX3BmX2RldiAqKXBmX2ly
cTsNCj4gPiArCWludCB2ZiwgcmVnLCBudW1fcmVnID0gMTsNCj4gPiArCXU2NCBpbnRyOw0KPiA+
ICsNCj4gPiArCWlmIChwZmRldi0+dG90YWxfdmZzID4gNjQpDQo+ID4gKwkJbnVtX3JlZyA9IDI7
DQo+ID4gKw0KPiA+ICsJZm9yIChyZWcgPSAwOyByZWcgPCBudW1fcmVnOyByZWcrKykgew0KPiA+
ICsJCWludHIgPSByZWFkcShwZmRldi0+cmVnX2Jhc2UgKyBSVlVfUEZfVkZNRV9JTlRYKHJlZykp
Ow0KPiA+ICsJCWlmICghaW50cikNCj4gPiArCQkJY29udGludWU7DQo+ID4gKwkJZm9yICh2ZiA9
IDA7IHZmIDwgNjQ7IHZmKyspIHsNCj4gPiArCQkJaWYgKCEoaW50ciAmIEJJVF9VTEwodmYpKSkN
Cj4gPiArCQkJCWNvbnRpbnVlOw0KPiA+ICsJCQkvKiBjbGVhciB0cnBlbmQgYml0ICovDQo+ID4g
KwkJCXdyaXRlcShCSVRfVUxMKHZmKSwgcGZkZXYtPnJlZ19iYXNlICsNCj4gUlZVX1BGX1ZGVFJQ
RU5EWChyZWcpKTsNCj4gPiArCQkJLyogY2xlYXIgaW50ZXJydXB0ICovDQo+ID4gKwkJCXdyaXRl
cShCSVRfVUxMKHZmKSwgcGZkZXYtPnJlZ19iYXNlICsNCj4gUlZVX1BGX1ZGTUVfSU5UWChyZWcp
KTsNCj4gPiArCQl9DQo+ID4gKwl9DQo+IA0KPiBTaG91bGQgYW55dGhpbmcgZWxzZSBoYXZlIGJl
ZW4gcGVyZm9ybWVkIGluIHRoZSBJUlEgaGFuZGxlciBiZXNpZGVzDQo+IGFja25vd2xlZGdpbmcg
dGhlIElSUSByZXF1ZXN0Pw0KPiANCldlIGFyZSBqdXN0IGFja25vd2xlZGdpbmcgdGhlIElSUSBy
ZXF1ZXN0IGhlcmUuICANCj4gPiArCXJldHVybiBJUlFfSEFORExFRDsNCj4gPiArfQ0KPiA+ICsN
Cj4gPiArc3RhdGljIGlycXJldHVybl90IHJ2dV9nZW5fcGZfZmxyX2ludHJfaGFuZGxlcihpbnQg
aXJxLCB2b2lkICpwZl9pcnEpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBnZW5fcGZfZGV2ICpwZmRl
diA9IChzdHJ1Y3QgZ2VuX3BmX2RldiAqKXBmX2lycTsNCj4gPiArCWludCByZWcsIGRldiwgdmYs
IHN0YXJ0X3ZmLCBudW1fcmVnID0gMTsNCj4gPiArCXU2NCBpbnRyOw0KPiA+ICsNCj4gPiArCWlm
IChwZmRldi0+dG90YWxfdmZzID4gNjQpDQo+ID4gKwkJbnVtX3JlZyA9IDI7DQo+ID4gKw0KPiA+
ICsJZm9yIChyZWcgPSAwOyByZWcgPCBudW1fcmVnOyByZWcrKykgew0KPiA+ICsJCWludHIgPSBy
ZWFkcShwZmRldi0+cmVnX2Jhc2UgKyBSVlVfUEZfVkZGTFJfSU5UWChyZWcpKTsNCj4gPiArCQlp
ZiAoIWludHIpDQo+ID4gKwkJCWNvbnRpbnVlOw0KPiA+ICsJCXN0YXJ0X3ZmID0gNjQgKiByZWc7
DQo+ID4gKwkJZm9yICh2ZiA9IDA7IHZmIDwgNjQ7IHZmKyspIHsNCj4gPiArCQkJaWYgKCEoaW50
ciAmIEJJVF9VTEwodmYpKSkNCj4gPiArCQkJCWNvbnRpbnVlOw0KPiA+ICsJCQlkZXYgPSB2ZiAr
IHN0YXJ0X3ZmOw0KPiA+ICsJCQlxdWV1ZV93b3JrKHBmZGV2LT5mbHJfd3EsICZwZmRldi0NCj4g
PmZscl93cmtbZGV2XS53b3JrKTsNCj4gPiArCQkJLyogQ2xlYXIgaW50ZXJydXB0ICovDQo+ID4g
KwkJCXdyaXRlcShCSVRfVUxMKHZmKSwgcGZkZXYtPnJlZ19iYXNlICsNCj4gUlZVX1BGX1ZGRkxS
X0lOVFgocmVnKSk7DQo+ID4gKwkJCS8qIERpc2FibGUgdGhlIGludGVycnVwdCAqLw0KPiA+ICsJ
CQl3cml0ZXEoQklUX1VMTCh2ZiksIHBmZGV2LT5yZWdfYmFzZSArDQo+IFJWVV9QRl9WRkZMUl9J
TlRfRU5BX1cxQ1gocmVnKSk7DQo+ID4gKwkJfQ0KPiA+ICsJfQ0KPiA+ICsJcmV0dXJuIElSUV9I
QU5ETEVEOw0KPiA+ICt9DQo+IA0KPiBbXQ0KPiANCj4gLS0NCj4gQWxleGFuZGVyIFN2ZXJkbGlu
Lg0KDQpUaGFua3MgYW5kIFJlZ2FyZHMsDQpBbnNodW1hbGkgR2F1cg0KDQoNCg0K

