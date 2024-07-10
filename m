Return-Path: <linux-kernel+bounces-247698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DEF92D356
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96C03B24E48
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 13:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4A4193066;
	Wed, 10 Jul 2024 13:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="TM7FQ8Mo"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1B313D501
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720619332; cv=fail; b=Mm7NZ05FCfKm2oXzyGwB1lYiVbwSSHuFDyl2zzHRVyoC7/sE2VGkSuazNrG4yG0AKGbzQFr1jhHlQX7Rvt4uZJ0kWIrPf7MIg2Ulj4om/2fTLJ4AgSux6lBDMcaPpuFliGNLuFK02zswRuA56/AGvLrt82kvn6cVun/ASHO6C0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720619332; c=relaxed/simple;
	bh=NNUa5t1gKA3xCUkTqHMAHZ2Auk/iY45GUm9HK0KUugY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=sHHnL0Rwyikq4DYh2uGsZ/EU6bs5f7I4fQ8DCIyF30XVO37yp1C6Gfiu45qKYwhHxLMHW9sHVKugxEV734FMScsKxpDijkpyja4IbFiwAusNWk/5bueZIquDGtWxSUec6pfAbQ6kSCNUKPH/4V8uCYrRSOfVA9/2bmeUcDSbkSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=TM7FQ8Mo reason="signature verification failed"; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A9lBaG023801;
	Wed, 10 Jul 2024 06:48:46 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 409qyf0tg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 06:48:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eV/HQnHnQ1J5bo4/LLlk5ZaZlaOPuMMltc28ePpDxC2seIXzW7bTOyb1gx4YkHSJdmG0oTfb6g7y+xYlWB3vU9qspYx0QpmesvkooLeU1pRlGIciCBbVsRP6zsVN2qfUVRvEuLw809YnvEWg+Bxt8NJBRhhPiyQFZk1WE97T5HiDyQN9d+MLmgUbWmLxaV8sVLI3WQhG6G7eoNcE4Dh/HYKONZg2MgYg0ayh+Yn/1bVIsap5mcND8dW/LiAXBrSubzNrapzmAtjB2tM8E82P/szHHUY/oM3Q393jjLVdVRzPFxANKseTwztXSIg3VVoVLa3D8jsajNNuYdGzEywX5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiYLoydsxenhq/s1YqBPxkpaISvyp1qCrgTG0JtMta4=;
 b=dIIAJrOaizV/mZQCi5w2AaT0+BX6BHhzIGBgDZOoXlGNIyLeVKK6h9+2cG1uO2ZkqnLQKSK9uxY03Cu7TIH3uZz8t6zRvldCdf452mJbyZpYjEmjEy0iXwAwSS5aYpE4x82zAkb6Hjw5hh42Ul6ZU3MksV88aJI6fv7AfQxN25kCYDQps4NwPcLED30TSnLXhg173egyXrXm/bqJRzPOtQaBNGZ5XBLai3rVshPbhOWjRq93Er9o+E/P7R1qkt60Tj1aMpE8H3C1Z3h1KU9NQAsjzBaww8CrxhCJ2n7u1JJoAO8HG9ZCzoiW4BooKNN/MJVqzAOD8uSy2dLD2PEG1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiYLoydsxenhq/s1YqBPxkpaISvyp1qCrgTG0JtMta4=;
 b=TM7FQ8MopyxFn+menLJ6RJd/fL200SWWMxXsRmgh2/2Mu33jHjMP3gMFZJc0f+SUbXYxzOB/RPcAKDa3b3fGZNOJud8TReHTcl1HAL75B+4pC9Paizz5Wg/Rk9GygZh/mAIa8s5ptV2d5jrissDmY6KNk2Kz6NyWhBTXnsflIqI=
Received: from MW4PR18MB5244.namprd18.prod.outlook.com (2603:10b6:303:1e0::16)
 by SA1PR18MB5925.namprd18.prod.outlook.com (2603:10b6:806:3e8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.36; Wed, 10 Jul
 2024 13:48:40 +0000
Received: from MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::52f3:9792:ee42:90b]) by MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::52f3:9792:ee42:90b%5]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 13:48:40 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "arnd@arndb.de" <arnd@arndb.de>, Jerin Jacob <jerinj@marvell.com>,
        Srujana
 Challa <schalla@marvell.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v10 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Thread-Topic: [EXTERNAL] Re: [PATCH v10 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Thread-Index: AQHaz7lqd9hdRQGJJUKQ+mbdgUAE1bHv8iaAgAADgvCAAASeAIAAA6mg
Date: Wed, 10 Jul 2024 13:48:40 +0000
Message-ID: 
 <MW4PR18MB524491EEA2A628469595FE47A6A42@MW4PR18MB5244.namprd18.prod.outlook.com>
References: <2024070333-matchless-batch-57ec@gregkh>
 <20240706153009.3775333-1-vattunuru@marvell.com>
 <2024071026-squirt-trustful-5845@gregkh>
 <MW4PR18MB52442E363AE0BED30607F251A6A42@MW4PR18MB5244.namprd18.prod.outlook.com>
 <2024071053-mahogany-cavalier-6692@gregkh>
In-Reply-To: <2024071053-mahogany-cavalier-6692@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR18MB5244:EE_|SA1PR18MB5925:EE_
x-ms-office365-filtering-correlation-id: 17b49246-6707-4e48-a1ad-08dca0e70189
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?RXJPSm50Q1k1T2lIMURVQUlxNlYwQjh2TXdsUFkwZmNrcm5QMEZwRGVmRzBk?=
 =?utf-8?B?aXZ6NzlyM2lqQTMyMFNMdThOTCtraG05b2xrWVl6Y3NMNE1LNXpFMVRTZVFS?=
 =?utf-8?B?R2VKMzhUUUV3V1M0UmJTeUhLdFVjdlAra2lDaDdmZUpTQXlHUEw4R0wzRy9r?=
 =?utf-8?B?UzBGRWtaRHNpLzhXNTJiSXlpaXZ0aW9yaGRGL1B6enNNbUhOUVNaRnZPSEgy?=
 =?utf-8?B?VDNtcks5SmFQQ3RneHY5aXJtL21mRWYwVUdQMWVKYkR0MmhWN2NiUHZQNUFK?=
 =?utf-8?B?ajJad3lDQzU3RVI1MU5WQ2ZhelhkbCtZc291QlNiRkFkazJUNHo4Z0NzZGho?=
 =?utf-8?B?ZzdCQTN1WG90ZThyQlFqM3lzUDd2aTcvVjFNR1JkWURHREtSV3h2V1NvSGFT?=
 =?utf-8?B?WkN2bWRaN0I5M25yU2pMOTd5dnFCc3RDbi9kZjg5cmh5RGVZWE1vRUNrN1R5?=
 =?utf-8?B?c0orUHQ3ZXBrak4rei9iVmJad0dPNjM4R3k2bCtvMFZFazU4cjZPSEg2TkZR?=
 =?utf-8?B?bTNGSzJlRkZNSE1KK2ttK3EzZjM3UTlkWjBwYThhNVVSKzFnM2gvUW96K1gw?=
 =?utf-8?B?czlLRjR1ampoTUJlSTNOd0VhNEpycDlCTDFWY2RncTZNTGFGSHI2Vk0xRS9R?=
 =?utf-8?B?aHFKNmlKQVliZEszM3czSFBaMXVDQzR4TlJWVERNYTJ1clpKcTI5dHRZTjBW?=
 =?utf-8?B?OUNBeTBjVEM5MkZ5VkNzNnZVRVRKK3ZmaDc0b1haTDU0YU9paGlpa1VwVkcw?=
 =?utf-8?B?bU9YMjBvZGhPcDFFTmF3MUQ1UkdXdllJR1F3NWRiam5PRytIbml5NGZNeSsv?=
 =?utf-8?B?cGl2akFraWQrMUt2ay9DclpnQ0RsNmdQK01IVXJSeUF6RFJnUnRBWUdSTStI?=
 =?utf-8?B?YjUxRThsR3JrdTZ6WXFHNGd5NzRrbHNnQWkyQ25lVjNGaTZyQ0RlSTVSYVFC?=
 =?utf-8?B?WlVzeEVNRm5vRXQ5SWR3R000SlNzT2JmaFJrWkk5VGt3UEp2T0NGK2NhL1d6?=
 =?utf-8?B?bDllU2lLSXdVeHRWU0lmT1hpNkJmb2VibDg2RFBYNS9SdExwdnN2TkRCWis1?=
 =?utf-8?B?TnRTZEN0cEpQWEVzYmFWUk1La1ErNXlFdzJpcUtJTXhMN3pvb2QycCs2SDYr?=
 =?utf-8?B?dDQ3Q1ZOd01TMGhLc1BoemNLOWs0cEN3elVFYUZqaVFXWHlJd3hSOWZyQS9R?=
 =?utf-8?B?VHB3OUoyTyt0VTNrZlVZMUFmc2V1aU90dkxlVlE5QTM5cEp4bXBIRmp6VjJ5?=
 =?utf-8?B?Q0tuSGZGN0VseUlkNnRmSEJnZ3V0d2F0VnBsSGJrMWcxWWJPdGdMOE10TDhC?=
 =?utf-8?B?Q0lTWklwMXBDMUtKMUhEaTRFWWhocWZkemphY1oza3VDdFZPOS83bnkrTmhY?=
 =?utf-8?B?cktoeHR5L2FYZDlYRUk5QXhna054b3ZsKy9yaGFUNWM2UUtpbkdXTGVla1JN?=
 =?utf-8?B?M1dmcm1VZkh0dEJoRklRaWd3UDRoc1M1VE0xT0VpM0xSYjg0L2Q1UURxMGtZ?=
 =?utf-8?B?ZGJGbFZqT09SemdzMkhXajE2WjBodWxYbE1FT21TVnJQK1JSWG0vaUNQNW9V?=
 =?utf-8?B?aDVQSXJsb21QWWdQZEtkNi9oQnFzd1JMVWFHSWNvMGxqNnhaNkhTZnhrMHNV?=
 =?utf-8?B?MVJHNVFyYWtPbDJaN2VaQzFnNFJ2eTlUUlNkYU1ROVBhN1pCQS9QTThLK0VZ?=
 =?utf-8?B?b0lRaW5MV04zcnVqTjdJWWlZSlFSQTl0bzF6TzV5czB2T0pSanBnU0QzcllV?=
 =?utf-8?B?eFFGSDJIRXdwQnNSRWkzNnlxRisyS3cwN0x1ZC9EOHQzcWFublRlbGdLR3NP?=
 =?utf-8?Q?YAyRGLkVQ5Ki2wAlDdmZRfJ2jXuT/ATkPp8MY=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5244.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MGVSMEVJckVaUjFLQnhhb2cvbExzNkRwZnBOTE5CY3BFcXd0bmpVMjdnSWF2?=
 =?utf-8?B?Y28vanYzMm8vMVJJN0ZxS0FNamRiaUc1MDhnaHNBSFhzMVR4cE5xeFlsRndQ?=
 =?utf-8?B?cDZIY1BCVGdidVE3b2RjR2dsMWdTRHV0d08vRXRhQjJQUitsRG1ONUZ2TStR?=
 =?utf-8?B?SGdFSDFUUTVkNk94bjRGWnhEZ25jTE5mRTRsZDJNMksxenFXbXhraFRZeE9Z?=
 =?utf-8?B?Z21mSHk2eFJtNXFobFpuTkZaelFnY2FIUi9ZcFRiS0hWc0tzOXZTWW0vSHNs?=
 =?utf-8?B?TUpVMzBiWllLejlOT2xWUXZ0U3dOYjVIeENxeDJvODlnVUc4MmdTcHFONzFX?=
 =?utf-8?B?QTkzc3Y2NWFxUi9EWXpETy9lVzF1T2xUOVoyZDhwaGlwZ0RpRHJNWUtFS2dx?=
 =?utf-8?B?eVhXYXhXaGJpUXh1VDR2N0oya3pDR0doNWxBb045WTgzSHlxMUw2MWN5Tyty?=
 =?utf-8?B?V2Q2L0t2S2wrS08zKzVZUlNjVjEvTk1nemFUOGYrUmpKanlWNkdhenl6YzZa?=
 =?utf-8?B?SmdHWFhMYXN2YWJLdCt3ZHd0WnhDZnlzNDdJc1NWYmE3dnI4QldqRWZmQUtu?=
 =?utf-8?B?N0lvQVlpcDNsT1oyc0YxQzk1cVhTVk5kbWhka0FoakJnMWxIQnFqdnllNU85?=
 =?utf-8?B?c3ZVajZJcUxVUHBaRXRnbC9EQm9XWTMyZDNOaFFmUnRFTzdXRVZScDZIMnkx?=
 =?utf-8?B?TmJ0eEUrZGcrRlIwSVJYNXlldWpwdytKS0V1K3JKdVRHblZkSE5WV1EzSlYy?=
 =?utf-8?B?OHU5YkdNQ0ZaSjY1MHNHZFVYdVFFc25ycURDTEFrS2VNU3BhTUtvek50Qk5j?=
 =?utf-8?B?c0o5SklEakFkZkxETVRQTHNGeDFJNnVIWEx4TStzdEhFdU00eXlrNW5JNFZ0?=
 =?utf-8?B?UG03VzkrK0FDakFjeW5LeDVoTXM3VmVDODljSjBKQnp2S2NWM3RvbXFFaEZx?=
 =?utf-8?B?T2N2T1JyZEJxeEpOYjlDaXJoR0xMaWZGTC9LNzNSbkt0bVpZYmNLN2dFbWtX?=
 =?utf-8?B?WkFBa1FkZ0tvSFpOU3lWeU92Qlh1WkV2VXE0dTA3c2h6ZEVmNUp0a1RsWHJZ?=
 =?utf-8?B?SlJHVHZIb1BnRUZGVS9tdmVOVitlUUdSMVRNbnE3NTRDMlNpNEZqMlMzZjFY?=
 =?utf-8?B?OG9tekpaTW4wZXZHOWhIeEtwTE5zSGF5eDJtWFNoUy9NbmZhQzRqaFFjSWZs?=
 =?utf-8?B?R3VqUCtXbVNXdEJ1eDZtRy9SNnFPdVU3cUFtaFJLaDNvRTErZkJJb1EzRnJF?=
 =?utf-8?B?cTZBMkQ1RDlTNytXakZPYmxya1NEZjhxdlE2blV0WU0rdnJsbXVYM1dEZUFB?=
 =?utf-8?B?WXlFcHdWckNUOXJhb2tFU2pJUUcrN1hjVlpiL3FHVWJQRCtMYjZWT1NBekEr?=
 =?utf-8?B?N3ZxcHQ0VHo2bmRqTWx6QWw0OXE2KzUwMEhNRHhneU8wdjJmR3g5dnF5bVNW?=
 =?utf-8?B?TWllY0E0QVdYbUVKb3JwTEp6b1ZsTVhKMklzM0EyNGlET0Qvam9qbDBEaGRZ?=
 =?utf-8?B?UlUra3g4dDBlWStoQUE4RW1VMU9rVFBMR2l1MzI0NmJnTXJrQTFWQ3pwRjB6?=
 =?utf-8?B?OHBvOTdoWmNPenMwR0F4NGtsUzkxMUdCeHBaNThCQjV0QXdUTDFhbW1MQXk1?=
 =?utf-8?B?UXVVVWRHdkFURklZZjhXWVF1b0Q3N2lUNnJhZFY2WUhEb1p2dTNuZ2lKYXB4?=
 =?utf-8?B?Nkt5YmRDWFEvQ1I3MDZaSnlvYUlDUTFWaWdEMDdhQjRSWEFtQ0xGdTl2TGF2?=
 =?utf-8?B?Mzk5SlNDb01vSFIzQzZOcFJ1V2tiYytMUzFQWnE3Z0EwcVJGd0E5blQwN0Zu?=
 =?utf-8?B?Q3ZnL0h5bVZmWjJHNDV6VTBWVkp0QUZLNWFJejRRUkZ4cEIwNDE5MFRHTHBR?=
 =?utf-8?B?eE1Ga1ZZQnRWU3RGbllpUzd1bEFZSDloK1l5UjlUTGQrMnZuQ0swVEdJZjJn?=
 =?utf-8?B?VHZ3T2ErOElrb2tXdTM5K1hnTFBzdy92d3NPSHdHemhQSit2bElMT1pTYTcw?=
 =?utf-8?B?cDFWZ0hFdCtnSVA3SGhhSU1wMzh2UW42bkZsaGdQMmE5NE5WdE9vM2wrYnMz?=
 =?utf-8?B?SmxCdlNpZEtpc2VaSjM4Q2Fld21QRjFtYVFnak1ZZVp5cVBESnVxd2JLcksw?=
 =?utf-8?Q?brgw62EsYUOosFmOc2ZMtMhSi?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5244.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b49246-6707-4e48-a1ad-08dca0e70189
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 13:48:40.3062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9yyI9tRenpKVsvHJsR0FhD2XJ9NHtnxuXOaZUh3pAunkG3uiAc988DwjWcgNFN5d0dirCmaXphhrqe9vEu5TkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB5925
X-Proofpoint-ORIG-GUID: y5XOq4s7aHF-mmj_DAPUKnIT0B2gysj5
X-Proofpoint-GUID: y5XOq4s7aHF-mmj_DAPUKnIT0B2gysj5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_09,2024-07-10_01,2024-05-17_01



>-----Original Message-----
>From: Greg KH <gregkh@linuxfoundation.org>
>Sent: Wednesday, July 10, 2024 6:57 PM
>To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
>Cc: arnd@arndb.de; Jerin Jacob <jerinj@marvell.com>; Srujana Challa
><schalla@marvell.com>; linux-kernel@vger.kernel.org
>Subject: Re: [EXTERNAL] Re: [PATCH v10 1/1] misc: mrvl-cn10k-dpi: add
>Octeon CN10K DPI administrative driver
>
>On Wed, Jul 10, 2024 at 01:=E2=80=8A19:=E2=80=8A56PM +0000, Vamsi Krishna =
Attunuru wrote: > >
>> >-----Original Message----- > >From: Greg KH
><gregkh@=E2=80=8Alinuxfoundation.=E2=80=8Aorg> > >Sent: Wednesday, July 10=
, 2024 6:=E2=80=8A28 PM >
>>To: Vamsi=20
>On Wed, Jul 10, 2024 at 01:19:56PM +0000, Vamsi Krishna Attunuru wrote:
>>
>>
>> >-----Original Message-----
>> >From: Greg KH <gregkh@linuxfoundation.org>
>> >Sent: Wednesday, July 10, 2024 6:28 PM
>> >To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
>> >Cc: arnd@arndb.de; Jerin Jacob <jerinj@marvell.com>; Srujana Challa
>> ><schalla@marvell.com>; linux-kernel@vger.kernel.org
>> >Subject: [EXTERNAL] Re: [PATCH v10 1/1] misc: mrvl-cn10k-dpi: add
>> >Octeon CN10K DPI administrative driver
>> >
>> >On Sat, Jul 06, 2024 at 08:=E2=80=8A30:=E2=80=8A09AM -0700, Vamsi Attun=
uru wrote: >
>> >Adds a misc driver for Marvell CN10K DPI(DMA Engine) device's
>> >physical > function which initializes DPI DMA hardware's global
>> >configuration and > enables hardware mailbox On Sat, Jul 06, 2024 at
>> >08:30:09AM -0700, Vamsi Attunuru wrote:
>> >> Adds a misc driver for Marvell CN10K DPI(DMA Engine) device's
>> >> physical function which initializes DPI DMA hardware's global
>> >> configuration and enables hardware mailbox channels between
>> >> physical function (PF) and it's virtual functions (VF). VF device
>> >> drivers (User space drivers) use this hw mailbox to communicate any
>> >> required device configuration on it's respective VF device.
>> >> Accordingly, this DPI PF driver provisions the VF device resources.
>> >>
>> >> At the hardware level, the DPI physical function (PF) acts as a
>> >> management interface to setup the VF device resources, VF devices
>> >> are only provisioned to handle or control the actual DMA Engine's
>> >> data transfer
>> >capabilities.
>> >>
>> >> Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
>> >> Reviewed-by: Srujana Challa <schalla@marvell.com>
>> >> ---
>> >> Changes V9 -> V10
>> >> - Added checks to ensure reserved fields are set to 0
>> >>
>> >> Changes V8 -> V9:
>> >> - Addressed minor comments
>> >>
>> >> Changes V7 -> V8:
>> >> - Used bit shift operations to access mbox msg fields
>> >> - Removed bitfields in mailbox msg structure
>> >>
>> >> Changes V6 -> V7:
>> >> - Updated documentation with required references
>> >> - Addressed V6 review comments
>> >>
>> >> Changes V5 -> V6:
>> >> - Updated documentation
>> >> - Fixed data types in uapi file
>> >>
>> >> Changes V4 -> V5:
>> >> - Fixed license and data types in uapi file
>> >>
>> >> Changes V3 -> V4:
>> >> - Moved ioctl definations to .h file
>> >> - Fixed structure alignements which are passed in ioctl
>> >>
>> >> Changes V2 -> V3:
>> >> - Added ioctl operation to the fops
>> >> - Used managed version of kzalloc & request_irq
>> >> - Addressed miscellaneous comments
>> >>
>> >> Changes V1 -> V2:
>> >> - Fixed return values and busy-wait loops
>> >> - Merged .h file into .c file
>> >> - Fixed directory structure
>> >> - Removed module params
>> >> - Registered the device as misc device
>> >>
>> >>  Documentation/misc-devices/index.rst          |   1 +
>> >>  Documentation/misc-devices/mrvl_cn10k_dpi.rst |  52 ++
>> >>  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>> >>  MAINTAINERS                                   |   5 +
>> >>  drivers/misc/Kconfig                          |  14 +
>> >>  drivers/misc/Makefile                         |   1 +
>> >>  drivers/misc/mrvl_cn10k_dpi.c                 | 676 ++++++++++++++++=
++
>> >>  include/uapi/misc/mrvl_cn10k_dpi.h            |  39 +
>> >>  8 files changed, 789 insertions(+)
>> >>
>> >> diff --git a/Documentation/misc-devices/index.rst
>> >> b/Documentation/misc-devices/index.rst
>> >> index 2d0ce9138588..8c5b226d8313 100644
>> >> --- a/Documentation/misc-devices/index.rst
>> >> +++ b/Documentation/misc-devices/index.rst
>> >> @@ -21,6 +21,7 @@ fit into other categories.
>> >>     isl29003
>> >>     lis3lv02d
>> >>     max6875
>> >> +   mrvl_cn10k_dpi
>> >>     oxsemi-tornado
>> >>     pci-endpoint-test
>> >>     spear-pcie-gadget
>> >> diff --git a/Documentation/misc-devices/mrvl_cn10k_dpi.rst
>> >> b/Documentation/misc-devices/mrvl_cn10k_dpi.rst
>> >> new file mode 100644
>> >> index 000000000000..a75e372723d8
>> >> --- /dev/null
>> >> +++ b/Documentation/misc-devices/mrvl_cn10k_dpi.rst
>> >> @@ -0,0 +1,52 @@
>> >> +.. SPDX-License-Identifier: GPL-2.0
>> >> +
>> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> +Marvell CN10K DMA packet interface (DPI) driver
>> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> +
>> >> +Overview
>> >> +=3D=3D=3D=3D=3D=3D=3D=3D
>> >> +
>> >> +DPI is a DMA packet interface hardware block in Marvell's CN10K sili=
con.
>> >> +DPI hardware comprises a physical function (PF), its virtual
>> >> +functions, mailbox logic, and a set of DMA engines & DMA command
>> >queues.
>> >> +
>> >> +DPI PF function is an administrative function which services the
>> >> +mailbox requests from its VF functions and provisions DMA engine
>> >> +resources to it's VF functions.
>> >> +
>> >> +mrvl_cn10k_dpi.ko misc driver loads on DPI PF device and services
>> >> +the mailbox commands submitted by the VF devices and accordingly
>> >> +initializes the DMA engines and VF device's DMA command queues.
>> >> +Also, driver creates /dev/mrvl-cn10k-dpi node to set DMA engine
>> >> +and PEM (PCIe interface) port attributes like fifo length, molr, mps=
 &
>mrrs.
>> >> +
>> >> +DPI PF driver is just an administrative driver to setup its VF
>> >> +device's queues and provisions the hardware resources, it cannot
>> >> +initiate any DMA operations. Only VF devices are provisioned with
>> >> +DMA
>> >capabilities.
>> >> +
>> >> +Driver location
>> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> +
>> >> +drivers/misc/mrvl_cn10k_dpi.c
>> >> +
>> >> +Driver IOCTLs
>> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> +
>> >> +:c:macro::`DPI_MPS_MRRS_CFG`
>> >> +ioctl that sets max payload size & max read request size
>> >> +parameters of a pem port to which DMA engines are wired.
>> >> +
>> >> +
>> >> +:c:macro::`DPI_ENGINE_CFG`
>> >> +ioctl that sets DMA engine's fifo sizes & max outstanding load
>> >> +request thresholds.
>> >> +
>> >> +User space code example
>> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> +
>> >> +DPI VF devices are probed and accessed from user space
>> >> +applications using vfio-pci driver. Below is a sample dpi dma
>> >> +application to demonstrate on how applications use mailbox and
>> >> +ioctl services from DPI
>> >PF kernel driver.
>> >> +
>> >> +https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-  >>
>> >3A__github.com_Marve
>> >> +llEmbeddedProcessors_dpi-2Dsample-
>> >2Dapp&d=3DDwIBAg&c=3DnKjWec2b6R0mOyPaz7
>> >>
>>
>>+xtfQ&r=3DWllrYaumVkxaWjgKto6E_rtDQshhIhik2jkvzFyRhW8&m=3DbFx_7eltw7
>S
>> >6zzVu
>> >>
>>
>>+1LNEdtsbwwynJfAKTja649QUwGNU_y4uWqGoEZ4f7JluYLjX&s=3DwOMzADb
>q
>> >9f4xxz1Oug
>> >> +-slj_xy4ZcbrnWfQJWeO0_ugA&e=3D
>> >> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst
>> >> b/Documentation/userspace-api/ioctl/ioctl-number.rst
>> >> index a141e8e65c5d..def539770439 100644
>> >> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
>> >> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
>> >> @@ -362,6 +362,7 @@ Code  Seq#    Include File
>> >Comments
>> >>  0xB6  all    linux/fpga-dfl.h
>> >>  0xB7  all    uapi/linux/remoteproc_cdev.h                           =
 <mailto:linux-
>> >remoteproc@vger.kernel.org>
>> >>  0xB7  all    uapi/linux/nsfs.h                                      =
 <mailto:Andrei Vagin
>> ><avagin@openvz.org>>
>> >> +0xB8  01-02  uapi/misc/mrvl_cn10k_dpi.h                             =
 Marvell CN10K
>DPI
>> >driver
>> >>  0xC0  00-0F  linux/usb/iowarrior.h  0xCA  00-0F  uapi/misc/cxl.h
>> >> 0xCA  10-2F  uapi/misc/ocxl.h diff --git a/MAINTAINERS
>> >> b/MAINTAINERS index aae88b7a6c32..2c17d651954a 100644
>> >> --- a/MAINTAINERS
>> >> +++ b/MAINTAINERS
>> >> @@ -13477,6 +13477,11 @@ S:	Supported
>> >>  F:	Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
>> >>  F:	drivers/mmc/host/sdhci-xenon*
>> >>
>> >> +MARVELL OCTEON CN10K DPI DRIVER
>> >> +M:	Vamsi Attunuru <vattunuru@marvell.com>
>> >> +S:	Supported
>> >> +F:	drivers/misc/mrvl_cn10k_dpi.c
>> >> +
>> >>  MATROX FRAMEBUFFER DRIVER
>> >>  L:	linux-fbdev@vger.kernel.org
>> >>  S:	Orphan
>> >> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig index
>> >> faf983680040..965641017a62 100644
>> >> --- a/drivers/misc/Kconfig
>> >> +++ b/drivers/misc/Kconfig
>> >> @@ -585,6 +585,20 @@ config NSM
>> >>  	  To compile this driver as a module, choose M here.
>> >>  	  The module will be called nsm.
>> >>
>> >> +config MARVELL_CN10K_DPI
>> >> +	tristate "Octeon CN10K DPI driver"
>> >> +	depends on ARM64 && PCI
>> >
>> >Why does ARM64 matter here?  I don't see any dependency required of it.
>> >
>> Thanks, Greg, for your time. This DPI device is an on-chip PCIe device
>> and only present on Marvell's CN10K platforms(which are 64-bit ARM SoC
>processors), so added those dependency.
>
>Then perhaps keep the ARM64 and add a COMPILE_TEST option as well so
>that we can build this as part of normal testing?
>
>So that would be:
>	depends on PCI && (ARM64 || COMPILE_TEST) right?
>
Yes, it makes sense to add. Can I send this fix as next version now so that=
 it will show
up in next release, please suggest.

Regards
Vamsi

>thanks,
>
>greg k-h

