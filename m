Return-Path: <linux-kernel+bounces-331118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A67797A8AC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 23:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B69DB295C0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 21:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D82E14B07E;
	Mon, 16 Sep 2024 21:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="t3JIIxuh";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="mDWRS9mh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="rttq98Mi"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1651757D;
	Mon, 16 Sep 2024 21:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726521508; cv=fail; b=F149JfXZymdZSw8doUqFBwEKWwjwie4LCZgGxTXwyfEM6g4CFmABtDLVJqLoG6ZIjWHkuBWnxxOaS4v2oBB5Gw7jQR4BC+0UTIzwj2H8Jb+GLWI7Xy86MEqeSVXP7Ra8qEgx13ooWh6Y6wDKNwNI9cr2aN8EtbcbTmza5jiVKnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726521508; c=relaxed/simple;
	bh=AOjgRhzwQmPrmVy7A96RN26nXmEfOAh3RSwVbiKFjz4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KHgg3y8j8iYssWR606LC4dKpJ+hjvYjtr7EP3YpTwdLAI9zsD2yITql8LPT60Yfd2eeOAUuSTzwvCLgBxyvUI5G4vKYZxvXkQhHdbmHTMGeEWRzd+wF1UhH9SMVTbHewsvvejsy+C6j50qxGvFGKDQVYqN6XOqKLHZOC/n/2vs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=t3JIIxuh; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=mDWRS9mh; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=rttq98Mi reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GKWdPf020678;
	Mon, 16 Sep 2024 14:18:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=AOjgRhzwQmPrmVy7A96RN26nXmEfOAh3RSwVbiKFjz4=; b=
	t3JIIxuh/FGoGAEk1Cxo31Kdd7mxUE2rGRmAUgV0G3iMNVwsxC9rJv3vKt9Jv6ma
	hYyRGa6+cyJDTCj2Yl7GtC2w0/xn1IIREkrVxu/p0brcXz3DhxP7DgLVBpeLiQ26
	xnkOXE9x+TJujBsuc7UKp68Zn7johdXsODfBFWPCfuJSRKs/dBQkrrcyBDd916RO
	/2936HTbcsDjdZVBA8cK45jwYCHyKOaNMhwVmNzGkfkzSAhQnTxEFOt9N93ADX+8
	IBuuWrLQNNnHbKA7VDAvWO9kPrSWQksuNrPm8ejIF3ZxNxYgogzQ34qbqkKhWA5v
	RhpHDxIfamQyNh65uPI2vg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 41n9dv09qb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 14:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1726521498; bh=AOjgRhzwQmPrmVy7A96RN26nXmEfOAh3RSwVbiKFjz4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=mDWRS9mh/rG9/qpqNPlNDARAB/+TKcGYXUPqVJFRjZ1D7eAD1b9Sghcfj1AfGXXht
	 BKwrP3qab1XMzgth/bQku36A6r9zEDC1lDKewhxSqoq+07ebl+z4w2/L8dr4Hxw4tq
	 V+/g3nJuU3XSUJlTxgyXi1O2B5t2hj+lP/wobwtbWFeUCUuukgIrhScGYnsxpkKpM2
	 0/rgT4NhNsxCtugyOetdn2JB4g5I+2rQ8AQggCemy6f0yJzM/hpkqClk32cXujx7lS
	 WHbdraQzSwBlZ289RQ9ZmtvafsteKf9EquRwCkxSmeWNYKCgMe1N1hCViYWkk4CHnc
	 p4yanneb3effg==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 017D740524;
	Mon, 16 Sep 2024 21:18:17 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 93BF0A009F;
	Mon, 16 Sep 2024 21:18:17 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=rttq98Mi;
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id E96884048B;
	Mon, 16 Sep 2024 21:18:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eWggAuv3odyw3A+kWc1y55MSe7I3NcHBpo0JlA/rtOURCJBxY5Ipi1KpHjdnnV6lrX4y6XUqriCZ6feXixGvCbW+GT1vMFXAzAntKzqGKEijK7Iizg8piBjnLad9WMyZl5n6gNHuz8EW0AKNVlkVY+VRQm/fVdk8jLoRyvwLccOl2RD0tw9LV9qZIJFwCxvMZ2TNW8AaZ3sg8kytb/qhIdsAq9bkPGO+9HwAmMuEcwMcU3fJE2l4TrgtHsCrA7egpXEKL+zg0CEUQoDAWC12SY15gT1xhrLa/RJbl0KrWX5HgrM2dEhIc6h6D8DTJ/qjWraPBeD4qgtSLDeAL4mgNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOjgRhzwQmPrmVy7A96RN26nXmEfOAh3RSwVbiKFjz4=;
 b=ch+6/9Oa1DbVD8HHbs213Q3Hg5DZrApqYFFLozB24702AM31b0UzXCkja7HkTuYbHJrphlLmDsEf2cViLqGltjxdEjDa1QXZqBtagG00aZ2r7oG/BZlkT/xg67+hsMpN6ziH/moy7DT4ZXtm7BIyadYgim2Ly4NoSs4DYvRRF04h15bk+/k/FflI9n6DdVl+2oCHx5ynkTI5BD+/PVgueI87wjCR7Zh8H9tDzI06zVfe03q2HF0zKVXQys/1nO4mCZVauuUHxXgY2UpdbAJhEGTLSo51cijKgpChESsJ+/Co5LFoPitAcdemdp54YmT1SBaM6RmBifm4Xyk5dturvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOjgRhzwQmPrmVy7A96RN26nXmEfOAh3RSwVbiKFjz4=;
 b=rttq98Mixsvvp9b58QwzH+oRy+EnN6enhBT57KbFcxZEItodb5QuhD1QEcJaqjK1Xgu+O8asjWod77MZC6lX0k4ZaQXYCto5gHT4yrwZ1dvCWEIw+alsPTBWRxLpKKAtOD9jE30TXDD/DX5VjtJT0edb6XurEItz7Nxub13GQz0=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SA1PR12MB5669.namprd12.prod.outlook.com (2603:10b6:806:237::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 21:18:14 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 21:18:13 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jh0801.jung@samsung.com" <jh0801.jung@samsung.com>,
        "dh10.jung@samsung.com" <dh10.jung@samsung.com>,
        "naushad@samsung.com" <naushad@samsung.com>,
        "akash.m5@samsung.com" <akash.m5@samsung.com>,
        "rc93.raju@samsung.com" <rc93.raju@samsung.com>,
        "taehyun.cho@samsung.com" <taehyun.cho@samsung.com>,
        "hongpooh.kim@samsung.com" <hongpooh.kim@samsung.com>,
        "eomji.oh@samsung.com" <eomji.oh@samsung.com>,
        "shijie.cai@samsung.com" <shijie.cai@samsung.com>
Subject: Re: [PATCH] usb: dwc3: Potential fix of possible dwc3 interrupt storm
Thread-Topic: [PATCH] usb: dwc3: Potential fix of possible dwc3 interrupt
 storm
Thread-Index:
 AQHa2cstTT8AcV9+kEe9fm+4hVNVnLIbEIwAgABflQCAAT06AIAAVgGAgAK0ooCAIEFKAIAA0sIAgAPWhwCAAnZSAIAA99mAgACQGICAANfzAIAAhJUAgAAfSwCAAAOTgIAAE4YAgAAIvoCAAS6LAIAAXkAAgAWQSACAALStAIAD8tcAgABWWACABGCPAIAAkFWA
Date: Mon, 16 Sep 2024 21:18:13 +0000
Message-ID: <20240916211819.ulvmre4o57bhrr6q@synopsys.com>
References: <64d049cc-d55d-4376-b6b9-402eb6f170c0@samsung.com>
 <20240906005935.caugoe3mqqdqwqao@synopsys.com>
 <30ca8527-419b-4e44-a21b-18e494b39076@samsung.com>
 <20240907003946.qn6t3xw65qwl2cn7@synopsys.com>
 <dff83c7d-56b8-481f-af69-8d4262bd54e4@samsung.com>
 <CGME20240911002436epcas5p19be55e1144edd6f77184192c7f22a85e@epcas5p1.samsung.com>
 <20240911002408.gr4fv5vkst7ukxd5@synopsys.com>
 <dd7965fa-9266-46b9-9219-1ef726480a9b@samsung.com>
 <20240913175106.qbav2aigzwaj7pvd@synopsys.com>
 <2cf9624b-8612-46aa-a528-a8948ef4f5e1@samsung.com>
In-Reply-To: <2cf9624b-8612-46aa-a528-a8948ef4f5e1@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SA1PR12MB5669:EE_
x-ms-office365-filtering-correlation-id: a7d37104-cd25-434c-f014-08dcd6951328
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y1JtZGg0bG4rdWFKWUFXSHFoVm81ckxqTVZsamdwUDdYVTViS1RKUW5KU1Qx?=
 =?utf-8?B?L0NZckZnZWxTUk56eUtETlhmWVpvYWNPQ1F6Z0lqYmtHcllxNzU3elExd0tH?=
 =?utf-8?B?T0YxRDJzNTdWd2d2dEhPR3Z6dS9neFdPbFVHNXZPTXZDZFhxYUNYdmM1WVh2?=
 =?utf-8?B?bVFhWFhBdndNdUhqbDFMcW9iWVNKYWpqS0NXcWUxdVdJUUF0Y0pFUjF3SHRW?=
 =?utf-8?B?dk92WkFsNzJ6bjVBTnRpMlhKeWVHME1JejE0Tm03UkRCVFpJMGxMbkJRTVlZ?=
 =?utf-8?B?Zkx5QUpXZHBmT0taQmxadmhlYXFaaTNpdWw2U3NuS1l4akdHdWlINFJZb0xl?=
 =?utf-8?B?MWxZcEFlOS8wbkd6WTZpa2JKa25Mc01jbU82U3pYZTc2T1lZRVpqcUxRZnlS?=
 =?utf-8?B?bU5ZeFc5NmpQb2xDMWdweXpyRFk3RVM1WnNtc0lDU1VxSU1tN3hZbXowdTNT?=
 =?utf-8?B?TjJIYVZMQkF6SjFEcU02aHJhblN5SmVPb2NZTCtoQUlicU82VVBnYXRLc0pq?=
 =?utf-8?B?R3RMbEduQkkwVk56U0t2Q1dDeHNNYnJWd2l5S3BXMUZOME05K0l2M2QzeWRV?=
 =?utf-8?B?S0twUlFDd2VOeWdlYnRuVjVpcFZzSDdtTVRXNTJudDEzRU1QUzJjcW5lNVZS?=
 =?utf-8?B?MVNLMFpMelJVMWRzV3lQUTRFc3JVbUpBNHVmK1ZRazFvdXp2S0FOSHBsU21W?=
 =?utf-8?B?MUVxTDd5Nk5FL2d0aVdIeUwzSExPc0xITnlXYkh5ZDhhUVZLcDkyNzdhTXNl?=
 =?utf-8?B?ZHZDOW1MeEdBQ21LczZTMnhMNGxXUFM1SjEyOUw5MWViSDVXWUJKYlJWYU9s?=
 =?utf-8?B?WENKcEQxSlQrWUpLUFp1YlhEUUtjS1FrRXdReEZJRm5Hd1dvTXZwcGRSUG5E?=
 =?utf-8?B?bGh1bVB3Z1ozMkhlVWhHQ25RT1JiTkFaZzNJUDExdFl1OUtZZk92SGhBeU9R?=
 =?utf-8?B?bVJxTFcvWTMyRHR5OGxPQjFMNHlkV1dZTjg5NFdGQzlGWTM2anZycWxOMmdz?=
 =?utf-8?B?blRLNXN2UUQrRE50K3FpWk1kNmt1a0lkdnVmTUMwaGlYWkVBRFg3djJsOTNL?=
 =?utf-8?B?Ui9pSFRkdVRtaTMyTWxrV0x4L2VGWWRPQUYyWDNnS05KZ3ZuRDZLekQ3K09v?=
 =?utf-8?B?SHhzeDlpMHI4bGpQL0wremo4V1dOT1VWQU0wK2daTDZ6emZlbGhqMGVXWmJv?=
 =?utf-8?B?dW5LMWZrSjRGQktTRVZGcnlpSUNLRW1JWWNxTmh1NHRlaUs5S3lNUHg4SXV0?=
 =?utf-8?B?azN1K3VuZWcrVGd6Z05OcVMxNE03bTBqTzNuV3lzeFJObmVOcSswQVplOWEx?=
 =?utf-8?B?Q2tvbE9uTE5EYTVmZm83ZDdPTzhCZkYzTUd4MklnS3BYc2RaYWVESzhXSXRl?=
 =?utf-8?B?U05JSEZuNWRuNEg3Y2s3TnA3bGdTR2VzdnB5aDhmVk5DVGVUVTVCOCt4MC9N?=
 =?utf-8?B?S1M5VE42endvNTVjWW9oeXBmalNrSVY3R1pDVG9qZ1FWN3A0anJSd1d5QXlp?=
 =?utf-8?B?NDZ4Sk5RSFhtRDBER1VhMERTRDYrbEtaaWU0NUR5MmdiS3hScWxpVzhHY0I1?=
 =?utf-8?B?b3JPNXJXYTMzQXd3cDZhZkxHSnI0N2NaWVlzVngyV2U4K053MUxYTEpxMFpD?=
 =?utf-8?B?OFJVY1o2US9EUUNFcTJYZ1I5eTZjeGZqQjZma3hSZHQweHpXUzVGZXpFcGd6?=
 =?utf-8?B?cFFuemxHQVkzMDA0U2FyeEd0cTREeWovaTNJdDhCWEFuZzN1UUo4eVpiTkww?=
 =?utf-8?B?emhZZlFlOFJIN1hSa2lWQm5Kd0xMcUtYeExTM2dXV0ZQOFl2WVB6NzV1ckdq?=
 =?utf-8?B?STdPcXhCQys0UWIxS2ErRHNxZ01PbUVGa3o2b1VzRkRTQzlsWmpvbUtYSk51?=
 =?utf-8?B?WEY5TmdmMnNPNUYrRTZHZjVaTTl3dXlNUWFRcU5yaUc5MlE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RlpqUUNRYi9TSWxETkt3ekdqUGhGOVBhZ0NzSENJNGdidnJIRmpHTyt6eUFi?=
 =?utf-8?B?bXJ2a2lyQ3hHb3lCVFBtSEJZaEp6WHE4OGswMjBoT1VmZ0NBOXpCYlRYMlc5?=
 =?utf-8?B?WC9tdzJkY05VNFNMUDA5bmJhS3BDaDlobHd0aGp6VzNsTEZMZ3hoM01JdFJ1?=
 =?utf-8?B?RUtXOUpybGVlZW5FRGpsWDByOVBTci9JM2tPbDJWdUFYazl2WVNyWS9MS1JE?=
 =?utf-8?B?WFpGRDJYNndkU0dkWkNDRnJ2R1NpQkpLNTFmNzdoVkMvMUpDU25nV3BjUVBq?=
 =?utf-8?B?UjZNRHBwNXpmUHdFQVV2WlhiUUt3djVDMWg1VTZMZ25xN0ZnVEdKdjQxUFhl?=
 =?utf-8?B?aTgyU0FvZHlxYllnQ2pxTEtmUm9Ga2p3by9sOEU1TjRaWTF6WWpLYTdGZWl5?=
 =?utf-8?B?YlhhWlNFNDlWRC9PZ1k1dDVyMzFNVUNEbTJWQXBaME8vOU9MRHRhL0RwSWJo?=
 =?utf-8?B?dVlzYStGc29XOEEvaUIzMkQrSUlRdVRRd1pERk43SE4weEZJYmtoTFRkSkVD?=
 =?utf-8?B?cjZQNzJzVXdOcHV3TVZQWHQ4TkdRZ2p5TjFOQStldEtPUWZwV1JyRkM1QlN6?=
 =?utf-8?B?Yjd5dzlxSmFvS0JvYjhUNjdvd3JSU0FVZ24xUGJpZUx6RE1CUnhUWG9pZlpE?=
 =?utf-8?B?VzRwL1FmUldvZW43UXVqWGtiZXFEaVJEc1VpL0dsRnhSWmtTNEpyTEk2RFpq?=
 =?utf-8?B?VE93L2JDKzRVanBNOTVlNml1NWVidytCRE1Pc2tLQTZHNTEzaGdYeFNXU2F5?=
 =?utf-8?B?dm5RWlR6dHNjV1QvNzlMUTl3ME5YV0hxdEZRcFB6Rk1YeGpSd0hZZWtJbjdW?=
 =?utf-8?B?dEFmVWdDTFdtZzlKVlZXNXhnVXFmaHNWVlV2dXkxOW5DMTR3R080QUdLUU9Y?=
 =?utf-8?B?N0JvRk1UVCtkQWJoanY2V1g5UGgrM1ZFYWF5QTRSeFpGMkpqN09hcWRCOUdx?=
 =?utf-8?B?bmJoWE5sT1hKbXFrVHV3V1VSZmt5V3h2Z1JncmFzQzR4TDBmVEVlRzBDVUNG?=
 =?utf-8?B?Y3FYbmtNUlkvcUg4Rk5YWmpSV29obW56SWJlaG81ekdubkNpUEtDQmZIMWY5?=
 =?utf-8?B?QlhJcW9tSG9wQmFCUjBTTlFWQ0VOTDBnanN4NEZEZHhpRmNObHRIVzhQNzZp?=
 =?utf-8?B?dDhWZ09RZHUybjl5YmVMZ0FqU3lkTVpKd3RUZ29kTm94M3JJbGd5cE1WUFFE?=
 =?utf-8?B?QWp4Y1h2OThpRlZNaDBBV2lWZVg5TktUL09HbjUzS09NSzBzZTB3L0dpVDFK?=
 =?utf-8?B?Sm4zOVNSQ2RpZFJjdm1rcUV2U29objBIeXN5R282Q1dyT09nOS9ZWWU2VlBx?=
 =?utf-8?B?RGZIU0xOQ0laVlVRdUZ5a0JNQXppalJDQ3BRVmRONTR5Z2Q3QVFsa0xaUHpQ?=
 =?utf-8?B?K1Nwd2M1NUgxc1BIVzdaUUNOS01JUEdMc2dWNTZWNnYxTjlBbTRRN0xZNkRw?=
 =?utf-8?B?QVRGVU96U1paVXlWT2dDQmJVYkZLL1JGZE5COUtGTDl5SVRSUjg1NTk4SHQ5?=
 =?utf-8?B?S3RXbmxWZ0xFN0xoQlMwdHExSVdQTkZaZjBhd04zSTlHUlNhWXhOMzc0SUtY?=
 =?utf-8?B?YTNaaUJ1bWpTbDNDZnFpWXByMllNTzhEcEwwbG9ZOXpYMlBGbU8wSEFrYmdZ?=
 =?utf-8?B?SUprUUpmRmFUUnVWK1Z5aXlJOXpteDI2R3BTWGk4T0dxSXpJNE8zczR4aDV4?=
 =?utf-8?B?ODdtckN5WThZODduZmRITTBxMlMvbWpKSWlzM05DcXBOVTNtY3hXWWtRT0ZO?=
 =?utf-8?B?THZ2M05RVDJuWks0NW42ZDRuR2xjWW56a2tWZU0wckpyc3FKMmZJanFVMmdw?=
 =?utf-8?B?TmtpMmNxR1hrN25BUjZCU3drZlQ2c2lvalE5Qzh4bkdlbW13cFBObFU2QnhT?=
 =?utf-8?B?SXdaNEdnWU1VUnBHS3hadXlweUM0UzNidnBhVnh1eEd5M3ZQOEcyVWxzV0x0?=
 =?utf-8?B?UUVRSnM0U250M2tBb2RYNVhQMDUvVHlDS2Rzb1F0d1piOG0rYnZoR2w1L0Ru?=
 =?utf-8?B?TjU4QW1CUVZpUDBZdXRnWTBCRS9YSDVXS1BUUm0zSk15VEJQQ1BZZlkyMDFF?=
 =?utf-8?B?aWFqWWRXMjJkaFQ2YlJNbGYwUkpiRDZvMHAra29ONGswYXJaUS9uRm1ENFlW?=
 =?utf-8?Q?8QL0vH2bBYH3UkUgjTmAQEeLv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1ED1A54BB114D647A87D29395DA03AEF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	H5CBcTIWwUAEJEEzKhtxwyiY160hjQQfu/V0JaZBwZsVKpOlslFSohQlQwzBhzIrOshqSY5hm6nvERznIBIHn4VK6zVPtrbtt2jNhTR+u/mpdgnwwWn/LrII4q6Ke3gwGXfXRgh5npBVeMnVNNS+CYPEUGYfQ+T9byPs4Da+eMJ0GAM3jSXjfKvebjFYsh7WaLNcX5yxVIVolu9JOtkp1IlIaYCRW/KhRCEHLflN9XqvLmxvvfwLdauCvEVXtT2oiACyBTlFGW37hd2VatKZEgwerbWZPI7UROh7lkn05gr9Xtig/xTJ7ilZo5IxtPjwp9Mc7XKLHUMIUsNelHQVvOf/AORL5ymr/roBTWI0CvjngNCvnFUrciiRQFgL7Jq10AgO5PYh/6XgXwmTLFhh/3hcOcp0BiAIJra7XXv0e66z4nfdgzoF6htR2zl1jB/Sr+HzQOpcz+nLGFHwmGKoujwpdXvGMhA+iTc7m3Ti9x0C2sc+tt8H2kLpL5e978EokeochPKkM5GTRpbeaEDmMkJDrQP44s4rm6W+0k5XbtjbSE+1fkk6xRjVedsVnZvSWJ1ifny0epHzoF4pqsd9nLEnKFkwtZyAUMzhdy+af3kFP5Dw2MV9o9u8UO09YyQry41iur8NDIfhnxqMVY91nw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d37104-cd25-434c-f014-08dcd6951328
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2024 21:18:13.9256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sKE5wfP3NCEPMFX/Z7KWnLlv1zaslNsfTF9UMvvFs6IsUtLiTEDjRYIA36ji8inoAv0gCm9EjiCtZUydXHNd3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5669
X-Proofpoint-GUID: WYv3z03e-9-X9QiiyuP-UbK6MCt7dtLG
X-Authority-Analysis: v=2.4 cv=C+C7yhP+ c=1 sm=1 tr=0 ts=66e8a09b cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=jIQo8A4GAAAA:8 a=jGibSK9nqXEiagXk-D8A:9 a=QEXdDO2ut3YA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-ORIG-GUID: WYv3z03e-9-X9QiiyuP-UbK6MCt7dtLG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409160145

T24gTW9uLCBTZXAgMTYsIDIwMjQsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiANCj4gT24g
OS8xMy8yMDI0IDExOjIxIFBNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gSGksDQo+ID4NCj4g
PiBPbiBGcmksIFNlcCAxMywgMjAyNCwgU2VsdmFyYXN1IEdhbmVzYW4gd3JvdGU6DQo+ID4+IEhp
IFRoaW5oLA0KPiA+Pg0KPiA+PiBTbyBmYXIsIHRoZXJlIGhhdmUgYmVlbiBubyByZXBvcnRlZCBl
cnJvciBpbnN0YW5jZXMuIEJ1dCwgd2Ugc3VzcGVjdGluZw0KPiA+PiB0aGF0IHRoZSBpc3N1ZSBt
YXkgYmUgcmVsYXRlZCB0byBvdXIgZ2x1ZSBkcml2ZXIuIEluIG91ciBnbHVlIGRyaXZlciwgd2UN
Cj4gPj4gYWNjZXNzIHRoZSByZWZlcmVuY2Ugb2YgZXZ0LT5mbGFncyB3aGVuIHN0YXJ0aW5nIG9y
IHN0b3BwaW5nIHRoZSBnYWRnZXQNCj4gPj4gYmFzZWQgb24gYSBWQlVTIG5vdGlmaWNhdGlvbi4g
V2UgYXBvbG9naXplIGZvciBzaGFyaW5nIHRoaXMgaW5mb3JtYXRpb24NCj4gPj4gc28gbGF0ZSwg
YXMgd2Ugb25seSBiZWNhbWUgYXdhcmUgb2YgaXQgcmVjZW50bHkuDQo+ID4+DQo+ID4+IFRoZSBm
b2xsb3dpbmcgc2VxdWVuY2Ugb3V0bGluZXMgdGhlIHBvc3NpYmxlIHNjZW5hcmlvcyBvZiByYWNl
IGNvbmRpdGlvbnM6DQo+ID4+DQo+ID4+IFRocmVhZCMxIChPdXIgZ2x1ZSBEcml2ZXIgU2VxdWVu
Y2UpDQo+ID4+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+ID4+IC0+VVNC
IFZCVVMgbm90aWZpY2F0aW9uDQo+ID4+IC0+U3RhcnQvU3RvcCBnYWRnZXQNCj4gPj4gLT5kd2Mt
PmV2X2J1Zi0+ZmxhZ3MgfD0gQklUKDIwKTsgKEl0J3MgZm9yIG91ciByZWZlcmVuY2UpDQo+ID4+
IC0+Q2FsbCBkd2MzIGV4eW5vcyBydW50aW1lIHN1c3BlbmQvcmVzdW1lDQo+ID4+IC0+ZHdjLT5l
dl9idWYtPmZsYWdzICY9IH5CSVQoMjApOw0KPiA+PiAtPkNhbGwgZHdjMyBjb3JlIHJ1bnRpbWUg
c3VzcGVuZC9yZXN1bWUNCj4gPj4NCj4gPj4gVGhyZWFkIzINCj4gPj4gPT09PT09PT0NCj4gPj4g
LT5kd2MzX2ludGVycnVwdCgpDQo+ID4+IC0+ZXZ0LT5mbGFncyB8PSBEV0MzX0VWRU5UX1BFTkRJ
Tkc7DQo+ID4+IC0+ZHdjM190aHJlYWRfaW50ZXJydXB0KCkNCj4gPj4gLT5ldnQtPmZsYWdzICY9
IH5EV0MzX0VWRU5UX1BFTkRJTkc7DQo+ID4+DQo+ID4gVGhpcyBpcyBncmVhdCEgVGhhdCdzIGxp
a2VseSB0aGUgcHJvYmxlbS4gR2xhZCB5b3UgZm91bmQgaXQuDQo+ID4NCj4gPj4NCj4gPj4gQWZ0
ZXIgb3VyIGludGVybmFsIGRpc2N1c3Npb25zLCB3ZSBoYXZlIGRlY2lkZWQgdG8gcmVtb3ZlIHRo
ZQ0KPiA+PiB1bm5lY2Vzc2FyeSBhY2Nlc3MgdG8gZXZ0LT5mbGFnIGluIG91ciBnbHVlIGRyaXZl
ci4gV2UgaGF2ZSBtYWRlIHRoZXNlDQo+ID4+IGNoYW5nZXMgYW5kIGluaXRpYXRlZCB0ZXN0aW5n
Lg0KPiA+Pg0KPiA+PiBUaGFuayB5b3UgZm9yIHlvdXIgaGVscCBzbyBmYXIgdG8gdW5kZXJzdGFu
ZCBtb3JlIGludG8gb3VyIGdsdWUgZHJpdmVyIGNvZGUuDQo+ID4+DQo+ID4+IEFuZCBXZSBhcmUg
dGhpbmtpbmcgdGhhdCBpdCB3b3VsZCBiZSBmaW5lIHRvIHJlc2V0IGV2dC0+ZmxhZyB3aGVuIHRo
ZQ0KPiA+PiBVU0IgY29udHJvbGxlciBpcyBzdGFydGVkLCBhbG9uZyB3aXRoIHRoZSBjaGFuZ2Vz
IHlvdSBzdWdnZXN0ZWQgZWFybGllci4NCj4gPj4gVGhpcyBhZGRpdGlvbmFsIG1lYXN1cmUgd2ls
bCBoZWxwIHByZXZlbnQgc2ltaWxhciBpc3N1ZXMgZnJvbSBvY2N1cnJpbmcNCj4gPj4gaW4gdGhl
IGZ1dHVyZS4NCj4gPj4NCj4gPj4gUGxlYXNlIGxldCB1cyBrbm93IHlvdXIgdGhvdWdodHMgb24g
dGhpcyBwcm9wb3NhbC4gSWYgaXQgaXMgbm90DQo+ID4+IG5lY2Vzc2FyeSwgd2UgdW5kZXJzdGFu
ZCBhbmQgd2lsbCBwcm9jZWVkIGFjY29yZGluZ2x5Lg0KPiA+Pg0KPiA+IFlvdSBjYW4gc3VibWl0
IHRoZSBjaGFuZ2UgSSBzdWdnZXN0ZWQuIFRoYXQncyBhIHZhbGlkIGNoYW5nZS4gSG93ZXZlciwN
Cj4gPiB3ZSBzaG91bGQgbm90IGluY2x1ZGUgdGhlIHJlc2V0IG9mIHRoZSBEV0MzX0VWRU5UX1BF
TkRJTkcgZmxhZy4gSGFkIHdlDQo+ID4gZG9uZSB0aGlzLCB5b3UgbWF5IG5vdCBmb3VuZCB0aGUg
aXNzdWUgYWJvdmUuIEl0IHNlcnZlcyBubyBwdXJwb3NlIGZvcg0KPiA+IHRoZSBjb3JlIGRyaXZl
ciBsb2dpYyBhbmQgd2lsbCBiZSBhbiBleHRyYSBidXJkZW4gZm9yIHVzIHRvIG1haW50YWluLiAo
SQ0KPiA+IGRvbid0IHdhbnQgdG8gc2NyYXRjaCBteSBoZWFkIGluIHRoZSBmdXR1cmUgdG8gZmln
dXJlIG91dCB3aHkgdGhhdA0KPiA+IGNoYW5nZSB3YXMgbmVlZGVkIG9yIGNvbmNlcm4gd2hldGhl
ciBpdCBjYW4gYmUgcmVtb3ZlZCB3aXRob3V0IGNhdXNpbmcNCj4gPiByZWdyZXNzaW9uKS4NCj4g
DQo+IFllYWggSSB1bmRlcnN0YW5kLg0KPiANCj4gUGxlYXNlIHJlY29uZmlybSB0aGUgYmVsb3cg
Y2hhbmdlcyBvbmNlIHdpdGggY29tbWl0IG1lc3NhZ2UuIEkgd2lsbCBwb3N0IA0KPiBuZXcgdmVy
c2lvbiBpZiB0aGlzIGNoYW5nZXMgYXJlIGZpbmUuDQo+IA0KPiANCj4gW1BBVENIXSB1c2I6IGR3
YzM6IGNvcmU6IFN0b3AgcHJvY2Vzc2luZyBvZiBwZW5kaW5nIGV2ZW50cyBpZiBjb250cm9sbGVy
IA0KPiBpcyBoYWx0ZWQNCj4gDQo+IFRoaXMgY29tbWl0IGFkZHJlc3NlcyBhbiBpc3N1ZSB3aGVy
ZSBldmVudHMgd2VyZSBiZWluZyBwcm9jZXNzZWQgd2hlbg0KPiB0aGUgY29udHJvbGxlciB3YXMg
aW4gYSBoYWx0ZWQgc3RhdGUuIFRvIGZpeCB0aGlzIGlzc3VlIGJ5IHN0b3ANCj4gcHJvY2Vzc2lu
ZyB0aGUgZXZlbnRzIGFzIHRoZSBldmVudCBjb3VudCB3YXMgY29uc2lkZXJlZCBzdGFsZSBvcg0K
PiBpbnZhbGlkIHdoZW4gdGhlIGNvbnRyb2xsZXIgd2FzIGhhbHRlZC4NCj4gDQo+IEZpeGVzOiBm
YzhiYjkxYmM4M2UgKCJ1c2I6IGR3YzM6IGltcGxlbWVudCBydW50aW1lIFBNIikNCj4gQ2M6IHN0
YWJsZSA8c3RhYmxlQGtlcm5lbC5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IFNlbHZhcmFzdSBHYW5l
c2FuIDxzZWx2YXJhc3UuZ0BzYW1zdW5nLmNvbT4NCj4gU3VnZ2VzdGVkLWJ5OiBUaGluaCBOZ3V5
ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQo+IC0tLQ0KPiAgwqBkcml2ZXJzL3VzYi9k
d2MzL2NvcmUuY8KgwqAgfCAxNyArKysrKysrKysrKysrKystLQ0KPiAgwqBkcml2ZXJzL3VzYi9k
d2MzL2NvcmUuaMKgwqAgfMKgIDQgLS0tLQ0KPiAgwqBkcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5j
IHwgMjIgKysrKysrKysrKystLS0tLS0tLS0tLQ0KPiAgwqAzIGZpbGVzIGNoYW5nZWQsIDI2IGlu
c2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gaW5kZXggOWViMDg1
ZjM1OWNlLi5mNDdiMjBiYzJkMWYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29y
ZS5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IEBAIC01NDQsNiArNTQ0LDcg
QEAgc3RhdGljIGludCBkd2MzX2FsbG9jX2V2ZW50X2J1ZmZlcnMoc3RydWN0IGR3YzMgDQo+ICpk
d2MsIHVuc2lnbmVkIGludCBsZW5ndGgpDQo+ICDCoGludCBkd2MzX2V2ZW50X2J1ZmZlcnNfc2V0
dXAoc3RydWN0IGR3YzMgKmR3YykNCj4gIMKgew0KPiAgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGR3
YzNfZXZlbnRfYnVmZmVywqDCoMKgwqDCoMKgwqAgKmV2dDsNCj4gK8KgwqDCoMKgwqDCoCB1MzLC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBy
ZWc7DQo+IA0KPiAgwqDCoMKgwqDCoMKgwqAgaWYgKCFkd2MtPmV2X2J1ZikNCj4gIMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsNCj4gQEAgLTU1Niw4ICs1NTcsMTAgQEAg
aW50IGR3YzNfZXZlbnRfYnVmZmVyc19zZXR1cChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1cHBlcl8zMl9iaXRzKGV2
dC0+ZG1hKSk7DQo+ICDCoMKgwqDCoMKgwqDCoCBkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNf
R0VWTlRTSVooMCksDQo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIERXQzNfR0VWTlRTSVpfU0laRShldnQtPmxlbmd0aCkpOw0KPiAtwqDCoMKgwqDCoMKg
IGR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19HRVZOVENPVU5UKDApLCAwKTsNCj4gDQo+ICvC
oMKgwqDCoMKgwqAgLyogQ2xlYXIgYW55IHN0YWxlIGV2ZW50ICovDQoNCkRvIHRoZSBzYW1lIHRo
aW5nIGhlcmUgYXMgaW4gZHdjM19ldmVudF9idWZmZXJzX2NsZWFudXAoKS4NCg0KPiArwqDCoMKg
wqDCoMKgIHJlZyA9IGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0dFVk5UQ09VTlQoMCkpOw0K
PiArwqDCoMKgwqDCoMKgIGR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19HRVZOVENPVU5UKDAp
LCByZWcpOw0KPiAgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7DQo+ICDCoH0NCj4gDQo+IEBAIC0y
NDk5LDcgKzI1MDIsMTEgQEAgc3RhdGljIGludCBkd2MzX3J1bnRpbWVfcmVzdW1lKHN0cnVjdCBk
ZXZpY2UgKmRldikNCj4gDQo+ICDCoMKgwqDCoMKgwqDCoCBzd2l0Y2ggKGR3Yy0+Y3VycmVudF9k
cl9yb2xlKSB7DQo+ICDCoMKgwqDCoMKgwqDCoCBjYXNlIERXQzNfR0NUTF9QUlRDQVBfREVWSUNF
Og0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkd2MzX2dhZGdldF9wcm9jZXNzX3Bl
bmRpbmdfZXZlbnRzKGR3Yyk7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChk
d2MtPnBlbmRpbmdfZXZlbnRzKSB7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBwbV9ydW50aW1lX3B1dChkd2MtPmRldik7DQo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkd2MtPnBlbmRpbmdfZXZlbnRzID0gZmFs
c2U7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbmFi
bGVfaXJxKGR3Yy0+aXJxX2dhZGdldCk7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IH0NCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsNCj4gIMKgwqDCoMKg
wqDCoMKgIGNhc2UgRFdDM19HQ1RMX1BSVENBUF9IT1NUOg0KPiAgwqDCoMKgwqDCoMKgwqAgZGVm
YXVsdDoNCj4gQEAgLTI1ODksNiArMjU5NiwxMiBAQCBzdGF0aWMgdm9pZCBkd2MzX2NvbXBsZXRl
KHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIMKgc3RhdGljIGNvbnN0IHN0cnVjdCBkZXZfcG1fb3Bz
IGR3YzNfZGV2X3BtX29wcyA9IHsNCj4gIMKgwqDCoMKgwqDCoMKgIFNFVF9TWVNURU1fU0xFRVBf
UE1fT1BTKGR3YzNfc3VzcGVuZCwgZHdjM19yZXN1bWUpDQo+ICDCoMKgwqDCoMKgwqDCoCAuY29t
cGxldGUgPSBkd2MzX2NvbXBsZXRlLA0KPiArDQo+ICvCoMKgwqDCoMKgwqAgLyoNCj4gK8KgwqDC
oMKgwqDCoMKgICogUnVudGltZSBzdXNwZW5kIGhhbHRzIHRoZSBjb250cm9sbGVyIG9uIGRpc2Nv
bm5lY3Rpb24uIEl0IA0KPiByZXBsaWVzIG9uDQo+ICvCoMKgwqDCoMKgwqDCoCAqIHBsYXRmb3Jt
cyB3aXRoIGN1c3RvbSBjb25uZWN0aW9uIG5vdGlmaWNhdGlvbiB0byBzdGFydCB0aGUgDQo+IGNv
bnRyb2xsZXINCj4gK8KgwqDCoMKgwqDCoMKgICogYWdhaW4uDQo+ICvCoMKgwqDCoMKgwqDCoCAq
Lw0KPiAgwqDCoMKgwqDCoMKgwqAgU0VUX1JVTlRJTUVfUE1fT1BTKGR3YzNfcnVudGltZV9zdXNw
ZW5kLCBkd2MzX3J1bnRpbWVfcmVzdW1lLA0KPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBkd2MzX3J1bnRpbWVfaWRsZSkNCj4gIMKgfTsNCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgN
Cj4gaW5kZXggYzcxMjQwZThmN2M3Li45YzUwOGUwYzVjZGYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvdXNiL2R3YzMvY29yZS5oDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+IEBA
IC0xNjc1LDcgKzE2NzUsNiBAQCBzdGF0aWMgaW5saW5lIHZvaWQgZHdjM19vdGdfaG9zdF9pbml0
KHN0cnVjdCBkd2MzIA0KPiAqZHdjKQ0KPiAgwqAjaWYgIUlTX0VOQUJMRUQoQ09ORklHX1VTQl9E
V0MzX0hPU1QpDQo+ICDCoGludCBkd2MzX2dhZGdldF9zdXNwZW5kKHN0cnVjdCBkd2MzICpkd2Mp
Ow0KPiAgwqBpbnQgZHdjM19nYWRnZXRfcmVzdW1lKHN0cnVjdCBkd2MzICpkd2MpOw0KPiAtdm9p
ZCBkd2MzX2dhZGdldF9wcm9jZXNzX3BlbmRpbmdfZXZlbnRzKHN0cnVjdCBkd2MzICpkd2MpOw0K
PiAgwqAjZWxzZQ0KPiAgwqBzdGF0aWMgaW5saW5lIGludCBkd2MzX2dhZGdldF9zdXNwZW5kKHN0
cnVjdCBkd2MzICpkd2MpDQo+ICDCoHsNCj4gQEAgLTE2ODcsOSArMTY4Niw2IEBAIHN0YXRpYyBp
bmxpbmUgaW50IGR3YzNfZ2FkZ2V0X3Jlc3VtZShzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIDA7DQo+ICDCoH0NCj4gDQo+IC1zdGF0aWMgaW5saW5lIHZvaWQgZHdj
M19nYWRnZXRfcHJvY2Vzc19wZW5kaW5nX2V2ZW50cyhzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAtew0K
PiAtfQ0KPiAgwqAjZW5kaWYgLyogIUlTX0VOQUJMRUQoQ09ORklHX1VTQl9EV0MzX0hPU1QpICov
DQo+IA0KPiAgwqAjaWYgSVNfRU5BQkxFRChDT05GSUdfVVNCX0RXQzNfVUxQSSkNCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdl
dC5jDQo+IGluZGV4IDI5MWJjNTQ5OTM1Yi4uYTMyYzNhMjkyMzUzIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0
LmMNCj4gQEAgLTQ0ODMsNiArNDQ4MywxNyBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgZHdjM19jaGVj
a19ldmVudF9idWYoc3RydWN0IA0KPiBkd2MzX2V2ZW50X2J1ZmZlciAqZXZ0KQ0KPiAgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBJUlFfSEFORExFRDsNCj4gDQo+ICDCoMKg
wqDCoMKgwqDCoCBjb3VudCA9IGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0dFVk5UQ09VTlQo
MCkpOw0KDQpJZiB3ZSBwcm9wZXJseSBjbGVhbnVwIGV2ZW50IGNvdW50IGluIGR3YzNfZXZlbnRf
YnVmZmVyc19jbGVhbnVwKCkgYXMNCm5vdGVkIGFib3ZlLCB0aGVuIHlvdSBkb24ndCBuZWVkIHRo
aXMgY29uZGl0aW9uIGJlbG93LiBZb3UgY2FuIHJlbW92ZQ0KdGhlIGJlbG93IGNoZWNrOg0KDQo+
ICsNCj4gK8KgwqDCoMKgwqDCoCAvKg0KPiArwqDCoMKgwqDCoMKgwqAgKiBJZiB0aGUgY29udHJv
bGxlciBpcyBoYWx0ZWQsIHRoZSBldmVudCBjb3VudCBpcyANCj4gc3RhbGUvaW52YWxpZC4gSWdu
b3JlDQo+ICvCoMKgwqDCoMKgwqDCoCAqIHRoZW0uIFRoaXMgaGFwcGVucyBpZiB0aGUgaW50ZXJy
dXB0IGFzc2VydGlvbiBpcyBmcm9tIGFuIA0KPiBvdXQtb2YtYmFuZA0KPiArwqDCoMKgwqDCoMKg
wqAgKiByZXN1bWUgbm90aWZpY2F0aW9uLg0KPiArwqDCoMKgwqDCoMKgwqAgKi8NCj4gK8KgwqDC
oMKgwqDCoCBpZiAoIWR3Yy0+cHVsbHVwc19jb25uZWN0ZWQgJiYgY291bnQpIHsNCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dFVk5U
Q09VTlQoMCksIGNvdW50KTsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJu
IElSUV9IQU5ETEVEOw0KPiArwqDCoMKgwqDCoMKgIH0NCj4gKw0KPiAgwqDCoMKgwqDCoMKgwqAg
Y291bnQgJj0gRFdDM19HRVZOVENPVU5UX01BU0s7DQo+ICDCoMKgwqDCoMKgwqDCoCBpZiAoIWNv
dW50KQ0KPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBJUlFfTk9ORTsN
Cj4gQEAgLTQ3MjgsMTQgKzQ3MzksMyBAQCBpbnQgZHdjM19nYWRnZXRfcmVzdW1lKHN0cnVjdCBk
d2MzICpkd2MpDQo+IA0KPiAgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGR3YzNfZ2FkZ2V0X3NvZnRf
Y29ubmVjdChkd2MpOw0KPiAgwqB9DQo+IC0NCj4gLXZvaWQgZHdjM19nYWRnZXRfcHJvY2Vzc19w
ZW5kaW5nX2V2ZW50cyhzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAtew0KPiAtwqDCoMKgwqDCoMKgIGlm
IChkd2MtPnBlbmRpbmdfZXZlbnRzKSB7DQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGR3YzNfaW50ZXJydXB0KGR3Yy0+aXJxX2dhZGdldCwgZHdjLT5ldl9idWYpOw0KPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkd2MzX3RocmVhZF9pbnRlcnJ1cHQoZHdjLT5pcnFfZ2Fk
Z2V0LCBkd2MtPmV2X2J1Zik7DQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBtX3J1
bnRpbWVfcHV0KGR3Yy0+ZGV2KTsNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZHdj
LT5wZW5kaW5nX2V2ZW50cyA9IGZhbHNlOw0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBlbmFibGVfaXJxKGR3Yy0+aXJxX2dhZGdldCk7DQo+IC3CoMKgwqDCoMKgwqAgfQ0KPiAtfQ0K
DQpUaGUgcmVzdCBsb29rcyBmaW5lLg0KDQpUaGFua3MsDQpUaGluaA==

