Return-Path: <linux-kernel+bounces-328686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A299978762
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 20:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2A421C22800
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2554584A50;
	Fri, 13 Sep 2024 18:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="UAQIuhME";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="VPm0Z9rw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="mnFD5/aJ"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F9C43152;
	Fri, 13 Sep 2024 18:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726250429; cv=fail; b=Dv0tRTRQpO3WgUIAsP8t9rcCa2+6Gen9ebOhrsVY4MuACWECKrMLfqQdTBwHGVIGK4QEe9lcLxxDjiOkeHOgwkXHW3Jkdj7XDRbUiGSnY068ULw+5ZSImZGkWbyZhZNbdszrKJGRfwhZBPEs6KPySDAsfbjNmJQlMUlWnODKj5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726250429; c=relaxed/simple;
	bh=/v7dRU9/s+BxOjob7VbL3Bt7c126TgfUROckf3F5A9Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ItonR0E0zzgsIogTrIxqc3P7mP9PDJDCB7ZXsJw81UdP1L7V7b/q9NQM/W4ECsN9XPBPeiFuG15RoZqg6ImuXUmEHSbz1tOfeHvJB50vHL3vmm28XlL+3a7M6dcgt9s0BtUsxv1Vzzm7QAKyQfKmJmy++k/9zcit6ua4GlqVcVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=UAQIuhME; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=VPm0Z9rw; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=mnFD5/aJ reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DFwUbX023412;
	Fri, 13 Sep 2024 11:00:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=/v7dRU9/s+BxOjob7VbL3Bt7c126TgfUROckf3F5A9Q=; b=
	UAQIuhMEEed5uyp34l0kkt3K/GCvoKoh0VNn79tAP+I33iuCb+FFLBa2Ut5GjDCu
	rq6PnBfuDL6LN0asTJRQPlldTmfYPYVjJnB4Dml25FZP5RdZlt0icdJDu/3vhfdF
	wvenUA12YF52jXk5f3QJdj6vn32ta+Lh4Q1OjuOJKqwH+J0zJlsi9ispR7ZXDI5e
	mw2+VriYk04bjTnQGejwLR3Q4Qce9/s/IJoQUbyu4PCV5ip4KxIhTm0CN4Z4mQQA
	uNGFFLB9TPVClVIEK8P/BkTJ/2XRslf4Ncm7ZdrPtqAXi9YCjajmmOskqRrOkSqU
	mos9XvEuSfHDXH9XkAdDcw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 41gy8kacgr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 11:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1726250421; bh=/v7dRU9/s+BxOjob7VbL3Bt7c126TgfUROckf3F5A9Q=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=VPm0Z9rwYymRokYETcHlqZEf2RCLjKxzriJqrtzzS6mnzj+qF3PccniiHg8dTV+qe
	 8caOdNQI3ykB3uUbQWk7OZ3TEurkk7WMeuYMegEhYLESEq3RVs4zb+GK/CaunXfItY
	 sD8uk+qGt7pUzE2Xf5d5GCfgBiYQblKvBjUFNuCgQf8UJaiNSGMWG1O/4sQEQvuQH6
	 d5W1nddQ3FKL6AnJAbHi9U+vC5+/g++O+tYEnD1U9cAll4/06RLCEpdBhpWAdnCVyR
	 gKpRJ793bUq/afT0SDLuf6ZX0HEfxY2GDOTIK0mF9iL5IEuHmg7WroBkhNHCxh57Xw
	 yxk7fsrttwasg==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D8CFA4048F;
	Fri, 13 Sep 2024 18:00:20 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 05E2BA00D4;
	Fri, 13 Sep 2024 18:00:19 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=mnFD5/aJ;
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 32ED040354;
	Fri, 13 Sep 2024 18:00:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UW+ju/CG+wOpFbLVzG04A00fp14yCly2txss03nRBB3FZJMnRaPFbTv8OZHc3VLUAnQ8nl5f2KZfgJgUqjPtoqImuS+3p+NoilAB5tmvtvNSGuphH0RuWJRR1jhFM/fPdPHeVvENccWgJI4wDn1oSIAI35o3K2hX/GyaiVwul3owp8kxOyovC6rw/HlB6ARn/sAOJ3yvd04vaT/fXwMlhWVpVYdsrLi2aQexdc18X5EktXArmm77hnAnU746oULnLkytYRGuBiUGl/d09JqQUVRt0MVHynUEGSIjX4d4mxhKODFeftOfqmoWaEKtze7YLexfCBbz8fxC6EkVdEHrMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/v7dRU9/s+BxOjob7VbL3Bt7c126TgfUROckf3F5A9Q=;
 b=lG+XogFTPTR864b9WNMQT3tCvWpkAczAvN1S86/Lul0E38PAYU2tJoUXZAukh/bo58w/QztgPVTles3/aqe6nYnx8biEhUif9nM6oewWG7zYXaALltvZgEIc8TBxvREatcGt1XTSobs8h+Np+5CjZGMTuGeVWqvh4kHqP3I1YUH3MPX8GShsx5sbxRjD+xJvS1fZ+ABBwdfXysn4rlkgwaXnW/nFfheUorU/T5sYsz80ngc4q7oJ1kQJxbYsSq6Boq2AzsPTj22Xv/0CwNay8K5y3LDwOQrdq9qri2WU2DmPVKgEEnZMJ+RNTGtCGYG73IJLkHyfEH5ZAXBnnXgYBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/v7dRU9/s+BxOjob7VbL3Bt7c126TgfUROckf3F5A9Q=;
 b=mnFD5/aJn63sxO8WyKJs/Srxg2jaO/D+Tc/6Frb6RvQiPXgCJ0nZR7KLRO5QdbrYSx3yKGa2AdiFPVZWB2THak7D+O9K6neYynARj1IHwALC8RzsjPbMeufpWwyjhoq5Imzk40DEKZKxvC4ajDLZTcYhtSlpglApxdbQdcbZIPI=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by IA0PR12MB8303.namprd12.prod.outlook.com (2603:10b6:208:3de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.21; Fri, 13 Sep
 2024 18:00:12 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.7962.017; Fri, 13 Sep 2024
 18:00:12 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jh0801.jung@samsung.com" <jh0801.jung@samsung.com>,
        "dh10.jung@samsung.com"
	<dh10.jung@samsung.com>,
        "naushad@samsung.com" <naushad@samsung.com>,
        "akash.m5@samsung.com" <akash.m5@samsung.com>,
        "rc93.raju@samsung.com"
	<rc93.raju@samsung.com>,
        "taehyun.cho@samsung.com" <taehyun.cho@samsung.com>,
        "hongpooh.kim@samsung.com" <hongpooh.kim@samsung.com>,
        "eomji.oh@samsung.com"
	<eomji.oh@samsung.com>,
        "shijie.cai@samsung.com" <shijie.cai@samsung.com>
Subject: Re: [PATCH] usb: dwc3: Potential fix of possible dwc3 interrupt storm
Thread-Topic: [PATCH] usb: dwc3: Potential fix of possible dwc3 interrupt
 storm
Thread-Index:
 AQHa2cstTT8AcV9+kEe9fm+4hVNVnLIbEIwAgABflQCAAT06AIAAVgGAgAK0ooCAIEFKAIAA0sIAgAPWhwCAAnZSAIAA99mAgACQGICAANfzAIAAhJUAgAAfSwCAAAOTgIAAE4YAgAAIvoCAAS6LAIAAXkAAgAWQSACAALStAIAD8tcAgABWWACAAAJygA==
Date: Fri, 13 Sep 2024 18:00:12 +0000
Message-ID: <20240913175951.ahtlhkc5cycu6vjs@synopsys.com>
References: <20240905231825.6r2sp2bapxidur7a@synopsys.com>
 <64d049cc-d55d-4376-b6b9-402eb6f170c0@samsung.com>
 <20240906005935.caugoe3mqqdqwqao@synopsys.com>
 <30ca8527-419b-4e44-a21b-18e494b39076@samsung.com>
 <20240907003946.qn6t3xw65qwl2cn7@synopsys.com>
 <dff83c7d-56b8-481f-af69-8d4262bd54e4@samsung.com>
 <CGME20240911002436epcas5p19be55e1144edd6f77184192c7f22a85e@epcas5p1.samsung.com>
 <20240911002408.gr4fv5vkst7ukxd5@synopsys.com>
 <dd7965fa-9266-46b9-9219-1ef726480a9b@samsung.com>
 <20240913175106.qbav2aigzwaj7pvd@synopsys.com>
In-Reply-To: <20240913175106.qbav2aigzwaj7pvd@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|IA0PR12MB8303:EE_
x-ms-office365-filtering-correlation-id: 0133e773-6a64-4b65-8c62-08dcd41dea2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VTJUWWVGS2tESUk2c0JWckY2Y2xJY0RUb2Q0TlJ2NWpkaGZudWUySkJ4SGxJ?=
 =?utf-8?B?aVBzTVJrOEg3ekZ2ZEc5a0RKNEFvdVkzcVAwbFRISEd2NkV3VHVTOHdiN0Zw?=
 =?utf-8?B?YTBSZFBncy9oNE9BRkpCKzZBdG5UTXRHbG9La01vVEZ5bHpjZW1RNTJ2UjhI?=
 =?utf-8?B?cDV5Wmk0c1BhNkF3M0xZcUhlMHFadEZHVVBqVHpFS0NZenllUVN0akQzMTNJ?=
 =?utf-8?B?L2tWZEUrUTM2enRVQXFqK011UElHQ0MvV1R5NHpjZVNvSU83WXZBMmNYNGZa?=
 =?utf-8?B?UUZreDFLQ0J3U1FqNCtYRXhWdGZQb2V6N0p0VEFQZkIwaHcxbFdYWVc2K244?=
 =?utf-8?B?SkttZHhnSkJZd2pzeWd5OVgzUTNtMDNiRXUxaDlGakNuSEdDWVduYjc0cnZ0?=
 =?utf-8?B?SW1PWGFPclpvYVZVaWFFZGgxODl5THZHdm4yYktTL1pjODk3R2UvM1UyY0J5?=
 =?utf-8?B?Nm0zM2dsWXNia1FVUGlMaGVyN29IaGljVzJSaXdoaDZhWnEwaUg2QXp2dkg0?=
 =?utf-8?B?aXBlSEJkUm5kY2RyMmdXQ1psSlZnN2VvcUxhbzF4czJ1ekJ6dDZoUzFpTy8v?=
 =?utf-8?B?a3UwQlFVZFRIQisyR2dad0JaTE1JREpJcXk4SWZZbFdWeGFsYVZOSGpWWHpw?=
 =?utf-8?B?enVvZThEZWE3K1dxOEhoREk3Sk1JSFR6TWdOYjlxY0pUd2FvNWVkb0xxVWV1?=
 =?utf-8?B?ZjdpbzFnTjdQQlF2UkZQV3VMNHByUjJBS285QjEyUnhrbUE3OEQ3dUJtRmJi?=
 =?utf-8?B?NDduclpMb1ExLzEzWlZsL2dHamRtblRnNFNDb0lUdWltRjJoYmRLZzJCWm9L?=
 =?utf-8?B?bHJSOUNZQlhvS2J1M3NCRGNPQ3ljNmVzZkY0TG1QajBFQ2syOW9oRnNDNDRN?=
 =?utf-8?B?dlpjNHJURnA0TnNxOEg5UnRqMldOZnFrT2szR2cweDBqSTRSWXhZcVZXd3lY?=
 =?utf-8?B?KzRLa1BRSWo3MmNqYjlQOGRkakllQWxWaldyTk9LTmJaM0FnWGt1bU9PZTRw?=
 =?utf-8?B?MG9IYmVEOGpiRGZncWZBY2NBdDdjSVpRT3dHc2pyRjRDTkJUZVphcCtxR2RF?=
 =?utf-8?B?ay8yU2tFTUJUVDhFTEQzMzZ4alhwU2lCMlRPY0p1TWNKUnprcHh5c01VRG9Y?=
 =?utf-8?B?ZzVNN1QrNlg1U3dtWGhGdUhYZEVmMU5vRG1nVXpRdDdnS0xYdTB5dmlzeS9a?=
 =?utf-8?B?RTNJU1R6d0VxR3dNVDkrN25sUm1pcFhrMW94Q2xlTTU2NVRudHQ2dW1TMjRx?=
 =?utf-8?B?clFtWDBLeUNrZ094VmU3Q1hRNDE5SXFqSkhGMjJXSUpJYm0xNUlQLy9OaHFm?=
 =?utf-8?B?WWNDMXh5eE5hQUNVUlpTVmdBVEd6Szdock9RVTV0ejNra0xmdGdvZW13eEc1?=
 =?utf-8?B?L1ZNTW9VREZSUUo2czJWMmxISEZBWUluRnZ5UUNPNXBzSjJMNlVVQkphaUs3?=
 =?utf-8?B?dk1hb0Y4ZXRab2g1d3ptUkRLclFPUCttKzR5c1ZLRjdtdDAwdVA0TU1ubjdK?=
 =?utf-8?B?NjRLU2dmRmRzUmVBd3VCdS9TVjZQR0pjV3Q2MUQrUnN3eXJOU2IzL3g3SW05?=
 =?utf-8?B?WEJqZmRxNjdNN1FZa1RabXlPenhCS0NTc3N3cXYweGlpWURndmRCNkNxcDc0?=
 =?utf-8?B?TVdsb3cxWHhCUktGMGFQZFZhYzZMWUdWcUZpUk5qVmlNQlZkbFpxQ1ZVbTBm?=
 =?utf-8?B?cDlMWEkwZWhGcmMrc1grUW9sNnFyLzNlaHpuVGRITk9SQTVtOXdudDJvQ2di?=
 =?utf-8?B?QTkvYXhUdDB6WkZiZDRhYjl3ck01NVNadWdQTVpvdW95eGNxbGxDSE5NUFpL?=
 =?utf-8?B?WVRhMSs5VWdKNE1aVlQzWTJ2N25mbUpHNFRmN1o5bDdmNHpRZ3NtOUVmeWJh?=
 =?utf-8?B?Mld0NEUwYlZlLzNDVjN4Q1NMVTNVL0UrblQzS3FjaDNxT1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q25UQmZqWGFLcVU4RkV6bDVuWlRON0xyb0F5bGpESCtGMXU5Rm9pQWZ3dmFz?=
 =?utf-8?B?WldrZXdwVERqQ0VUb2d2M01TbkRkYTVxUHNFYnlSSlM4SWZMeEVBdXlHVGtk?=
 =?utf-8?B?aEJLRE55aXh1czBiTEJnVVBqblVDSWs2elVVSjU5dXAzWXo5UlZjYVZWSVdO?=
 =?utf-8?B?T0dxV3Z4eUV1Y2J3WTJjWUxjejRnZkt5TEdWRkw5MDFod0g1cThlTDZ2NlNN?=
 =?utf-8?B?WXYvT0g5MzN1RWRwYlJSQWFmWktzRFR6YnhYWENvbHBnOXpBajBjbnE3SkFj?=
 =?utf-8?B?bWRUSzMwWEhlZVk4VjJnMzkvaTY0ODJYSDQxQjNheE9hbXRJWTJ4ZjVnUTZZ?=
 =?utf-8?B?cVNLd2VrcUJTR2FFeS9tN0Fnd0dybGhFTXkrM25TOUg0eFd1OGIwZ0tGVW9O?=
 =?utf-8?B?V3p4ZDhUaFRDc1h1WkdadlFJNW9KMUt2VXlzK1BmUW00TXBCamRGcG83Wndj?=
 =?utf-8?B?T2M0UlR2SWJvNHJoVUlPVGlZUzdxcTVuejBIMm53a00yMG5PWEN2SGdKQkpX?=
 =?utf-8?B?OTQrV1h6cWdJbjUzWDl6TmZrcVdPa1V2V29JS05HaERGckhyK2huVjE1YlM3?=
 =?utf-8?B?UUVNV3ZNTDFlN1RSNGEyczQ3UzhqcjlXTzgxRDRrSjlMZkpqaVRrMmorU1lG?=
 =?utf-8?B?UEQ1VGJxYlRxam92OGZKbDdqb01JZkN1N3ZWTjl2YjNKL1JsVjhRMjJ4UE15?=
 =?utf-8?B?OGpjQUpGVkw4Z0NzNG0yTjB5SkROZ1U5ZCtRN2lNL2c3MTVZS29GdkhRRGYr?=
 =?utf-8?B?SGVmWVBjUXlQbHpMYjJ0eTdiK1diNHNjTXFQSHFYaGJEN2FpZGN4U2h1bUlo?=
 =?utf-8?B?VE1tclMrV1Zmc2lsSnBKUnNTWUg4aElPaGJwR2VKNGtBVVhOdnFLaVdUUVR6?=
 =?utf-8?B?Umg4cmoyVENpMVBZYkorODF5dkdUTkJiSlptSEJPeVBEQlJSaGZjMW9pNktj?=
 =?utf-8?B?ZXJsb1c2MnZhNVF1a0R1aTI5VjB6ZFY4RGRWdzF1RnhMWjlXOVBUTzBSbkEw?=
 =?utf-8?B?UWxTcGhaRWVxTUFYZ08rMldJL3N4a0h0ZitRUFF4dmtCT3VBL01nSTNXaHNt?=
 =?utf-8?B?T0hYOHBsbG5HWnV6U09pczBubkpCSkhZb3JoY3ZUTEhVMUtEVmZuT3pjelVB?=
 =?utf-8?B?eUphMVZjNytWSWRoQXZCdFNhSDFESTN6Slk1aUxSd05oWXU2YlZFZmgxK2tq?=
 =?utf-8?B?YnhRRzRwaXNqZE5YTVVHRzA5RXMrRlV1eHo4TEM4Uml4d29RYTZCYUJzbFlV?=
 =?utf-8?B?QjcvcEFpOVpWOTJkQkdOcG1qT1RONHlSUlF6d1FIeWl1RVJSQnhVR3k2Z2gr?=
 =?utf-8?B?N2dKZ3YwSURISDF5WmZ2b0pvdjJlQUhET3ZjaE93N0pJS0crQlpTaURvSzFn?=
 =?utf-8?B?WUw1TENWWE1RUUVyV1VXTEFTaVlSSFFzU3EyS2EvSE1DZ0xnOTVsNnRNT1p0?=
 =?utf-8?B?Qytpd0NGMUl1UlBEYTFqVkNyZTI2T2RYeUNZVDFEUVZYbXhidjBIZmZBbS9r?=
 =?utf-8?B?Z1MvS1hJUlN6dTFUVFBoaFpEdzNkL1AxQXFVRG50VFBzTjhBL2plbm9heGlD?=
 =?utf-8?B?V2QycjgvLzBFQzFIci9vZVNrbWE5R3MyMGNyUEpYUzJMdGRWYjJGSWttenM0?=
 =?utf-8?B?L1poNHRsR1hQL3h5OUJsSUVPbFNaejN3d2dmRTc5TVAxYWxmc3ZXWnA0bUd6?=
 =?utf-8?B?akxTcjN0ZXhRM1ZScmhtMlRmZTN6N2hpNFl4N29nb2pMUDJtajZ6L1RwQzFI?=
 =?utf-8?B?VHVJakhNdy9CTjNQeUFDbC9uaFVkajhHcDF3T1p4RzJBVEJrZHRORVl5MDAr?=
 =?utf-8?B?cUl3bFBQUmRoL05HL1RJU0pHMHdSMDFkNTRvYzFxRWpTVU02MENNMzhHQjlL?=
 =?utf-8?B?WnNlS2xmdGhPMkhEcjRvL1dKUWx6b0VYNlFwQk5YWXNyMmpvOURudGtrTENC?=
 =?utf-8?B?d0dycVBTQ0ZCcU05K0VHSDJqUStKZ2hrYzkvY1IwaHhxNmVvUDNFRTJHMk5j?=
 =?utf-8?B?b3JzVzk2Z3VUTTUrQjBYamxmckh0YURQVzJLMU1Vd3NmazRsUkhwVlo1bDJK?=
 =?utf-8?B?WFJoNmM2bGp5NTYxNzJlS0hYS1QxVEFkK2FqdVAwbXgxMkpUenNpK2Z5MWZP?=
 =?utf-8?Q?e0FB9cDxAEQzJYs3kKnYJZDla?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C86077A650C80498F63BEF17CDC03BE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+WaSWh2dfC5zoMxBNtYQTl+Y0eRbe3occ77vKXVG2t7ymSSpUba9AsuiguErXijdCIej0F0wMzHx2bkthNRQU06sA9Qs7V3mhOGbVZhyMr/gTF1JHGgyf74YRAz20ivObo5sGCyaweTonMNr/vTTrC0AvowOY9K07vZL1QcY76oTz/fpBxDeVcUjc82KgawrofZzoRCUNrPstcux5xOr5VJKBFzumGaQuESMNP+pz30omecsX/6gaZtZuLKeVu+mfmQN/prOSuIT0tAJB9cwaQSjFnbDPQlOiW9lHuw3dq++pu7fZ0D34hmpg3ij/zVKcPT+5OzzwTk0E8O5/XgIzle7CHO7R5Wj3YCXRdkG7jSYkPNeMs1JcHfBYxL7GBq6+vLKFjQRrO4CzrY4pX0FhoZaIzcU3Ete7R8unXGQvbGuQRbeq4DDMGc5nQIC0p5dts9pSlnYaofU7SjErgZrDE5WdcLycDcaluTxGSAUkj74FFNEzj4PPwN3tUj94NMPkImM9GzzOHdm1L1uda0Zoe3uuvtlkGnt0SuQtVwJbQ/7fCcHvudemSx2Ku5u7eUtoAuSu6QmUPqH0EquiJfzLVswZ5E6kd6nDv4jFsLqq8Py/OZ5uWFttr/0zDRuRfLiAB3/U78bcoepiAUFiayEVg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0133e773-6a64-4b65-8c62-08dcd41dea2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2024 18:00:12.7355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CVvBM7MFnCNfutPl5aOFWo/0Ig5FbTA6W6J82GyK4vtCnf6+9eHGk7USVymJDrtSsVgUE0j/4QK2/gK9OmUX/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8303
X-Authority-Analysis: v=2.4 cv=cLmysUeN c=1 sm=1 tr=0 ts=66e47db6 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=ZNS0VtNRhb_YaIv2XuUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 45oaUO4iZlM6Dv7R4jCLRixB6DOf9-lg
X-Proofpoint-GUID: 45oaUO4iZlM6Dv7R4jCLRixB6DOf9-lg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501
 phishscore=0 malwarescore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409130128

T24gRnJpLCBTZXAgMTMsIDIwMjQsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gT24gRnJpLCBTZXAg
MTMsIDIwMjQsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiA+IEhpIFRoaW5oLA0KPiA+IA0K
PiA+IFNvIGZhciwgdGhlcmUgaGF2ZSBiZWVuIG5vIHJlcG9ydGVkIGVycm9yIGluc3RhbmNlcy4g
QnV0LCB3ZSBzdXNwZWN0aW5nIA0KPiA+IHRoYXQgdGhlIGlzc3VlIG1heSBiZSByZWxhdGVkIHRv
IG91ciBnbHVlIGRyaXZlci4gSW4gb3VyIGdsdWUgZHJpdmVyLCB3ZSANCj4gPiBhY2Nlc3MgdGhl
IHJlZmVyZW5jZSBvZiBldnQtPmZsYWdzIHdoZW4gc3RhcnRpbmcgb3Igc3RvcHBpbmcgdGhlIGdh
ZGdldCANCj4gPiBiYXNlZCBvbiBhIFZCVVMgbm90aWZpY2F0aW9uLiBXZSBhcG9sb2dpemUgZm9y
IHNoYXJpbmcgdGhpcyBpbmZvcm1hdGlvbiANCj4gPiBzbyBsYXRlLCBhcyB3ZSBvbmx5IGJlY2Ft
ZSBhd2FyZSBvZiBpdCByZWNlbnRseS4NCj4gPiANCj4gPiBUaGUgZm9sbG93aW5nIHNlcXVlbmNl
IG91dGxpbmVzIHRoZSBwb3NzaWJsZSBzY2VuYXJpb3Mgb2YgcmFjZSBjb25kaXRpb25zOg0KPiA+
IA0KPiA+IFRocmVhZCMxIChPdXIgZ2x1ZSBEcml2ZXIgU2VxdWVuY2UpDQo+ID4gPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gPiAtPlVTQiBWQlVTIG5vdGlmaWNhdGlvbg0K
PiA+IC0+U3RhcnQvU3RvcCBnYWRnZXQNCj4gPiAtPmR3Yy0+ZXZfYnVmLT5mbGFncyB8PSBCSVQo
MjApOyAoSXQncyBmb3Igb3VyIHJlZmVyZW5jZSkNCj4gPiAtPkNhbGwgZHdjMyBleHlub3MgcnVu
dGltZSBzdXNwZW5kL3Jlc3VtZQ0KPiA+IC0+ZHdjLT5ldl9idWYtPmZsYWdzICY9IH5CSVQoMjAp
Ow0KPiA+IC0+Q2FsbCBkd2MzIGNvcmUgcnVudGltZSBzdXNwZW5kL3Jlc3VtZQ0KPiA+IA0KPiA+
IFRocmVhZCMyDQo+ID4gPT09PT09PT0NCj4gPiAtPmR3YzNfaW50ZXJydXB0KCkNCj4gPiAtPmV2
dC0+ZmxhZ3MgfD0gRFdDM19FVkVOVF9QRU5ESU5HOw0KPiA+IC0+ZHdjM190aHJlYWRfaW50ZXJy
dXB0KCkNCj4gPiAtPmV2dC0+ZmxhZ3MgJj0gfkRXQzNfRVZFTlRfUEVORElORzsNCj4gPiANCj4g
DQo+IFRoaXMgaXMgZ3JlYXQhIFRoYXQncyBsaWtlbHkgdGhlIHByb2JsZW0uIEdsYWQgeW91IGZv
dW5kIGl0Lg0KPiANCj4gPiANCj4gPiANCj4gPiBBZnRlciBvdXIgaW50ZXJuYWwgZGlzY3Vzc2lv
bnMsIHdlIGhhdmUgZGVjaWRlZCB0byByZW1vdmUgdGhlIA0KPiA+IHVubmVjZXNzYXJ5IGFjY2Vz
cyB0byBldnQtPmZsYWcgaW4gb3VyIGdsdWUgZHJpdmVyLiBXZSBoYXZlIG1hZGUgdGhlc2UgDQo+
ID4gY2hhbmdlcyBhbmQgaW5pdGlhdGVkIHRlc3RpbmcuDQo+ID4gDQo+ID4gVGhhbmsgeW91IGZv
ciB5b3VyIGhlbHAgc28gZmFyIHRvIHVuZGVyc3RhbmQgbW9yZSBpbnRvIG91ciBnbHVlIGRyaXZl
ciBjb2RlLg0KPiA+IA0KPiA+IEFuZCBXZSBhcmUgdGhpbmtpbmcgdGhhdCBpdCB3b3VsZCBiZSBm
aW5lIHRvIHJlc2V0IGV2dC0+ZmxhZyB3aGVuIHRoZSANCj4gPiBVU0IgY29udHJvbGxlciBpcyBz
dGFydGVkLCBhbG9uZyB3aXRoIHRoZSBjaGFuZ2VzIHlvdSBzdWdnZXN0ZWQgZWFybGllci4gDQo+
ID4gVGhpcyBhZGRpdGlvbmFsIG1lYXN1cmUgd2lsbCBoZWxwIHByZXZlbnQgc2ltaWxhciBpc3N1
ZXMgZnJvbSBvY2N1cnJpbmcgDQo+ID4gaW4gdGhlIGZ1dHVyZS4NCj4gPiANCj4gPiBQbGVhc2Ug
bGV0IHVzIGtub3cgeW91ciB0aG91Z2h0cyBvbiB0aGlzIHByb3Bvc2FsLiBJZiBpdCBpcyBub3Qg
DQo+ID4gbmVjZXNzYXJ5LCB3ZSB1bmRlcnN0YW5kIGFuZCB3aWxsIHByb2NlZWQgYWNjb3JkaW5n
bHkuDQo+ID4gDQo+IA0KPiBZb3UgY2FuIHN1Ym1pdCB0aGUgY2hhbmdlIEkgc3VnZ2VzdGVkLiBU
aGF0J3MgYSB2YWxpZCBjaGFuZ2UuIEhvd2V2ZXIsDQo+IHdlIHNob3VsZCBub3QgaW5jbHVkZSB0
aGUgcmVzZXQgb2YgdGhlIERXQzNfRVZFTlRfUEVORElORyBmbGFnLiBIYWQgd2UNCj4gZG9uZSB0
aGlzLCB5b3UgbWF5IG5vdCBmb3VuZCB0aGUgaXNzdWUgYWJvdmUuIEl0IHNlcnZlcyBubyBwdXJw
b3NlIGZvcg0KPiB0aGUgY29yZSBkcml2ZXIgbG9naWMgYW5kIHdpbGwgYmUgYW4gZXh0cmEgYnVy
ZGVuIGZvciB1cyB0byBtYWludGFpbi4gKEkNCj4gZG9uJ3Qgd2FudCB0byBzY3JhdGNoIG15IGhl
YWQgaW4gdGhlIGZ1dHVyZSB0byBmaWd1cmUgb3V0IHdoeSB0aGF0DQo+IGNoYW5nZSB3YXMgbmVl
ZGVkIG9yIGNvbmNlcm4gd2hldGhlciBpdCBjYW4gYmUgcmVtb3ZlZCB3aXRob3V0IGNhdXNpbmcN
Cj4gcmVncmVzc2lvbikuDQo+IA0KDQpBbHNvLCBwZXJoYXBzIHlvdSBtYXkgd2FudCB0byByZXZp
c2l0IGFuZCByZXZpZXcgdGhlIGNoYW5nZSBiZWxvdyB0byBzZWUNCmlmIHRoZSBnbHVlIGRyaXZl
ciBtYXkgYmUgdGhlIGN1bHByaXQ6DQoNCjE0ZTQ5NzE4M2RmMiAoInVzYjogZHdjMzogY29yZTog
UHJldmVudCBVU0IgY29yZSBpbnZhbGlkIGV2ZW50IGJ1ZmZlciBhZGRyZXNzIGFjY2VzcyIpDQoN
ClRoYW5rcywNClRoaW5o

