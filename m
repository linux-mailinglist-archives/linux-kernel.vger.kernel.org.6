Return-Path: <linux-kernel+bounces-421501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB74D9D8C29
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 19:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE57289D7C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13391B87F4;
	Mon, 25 Nov 2024 18:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="rg2zVBGt";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="MNKN48EL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OEHpCpd4"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405B91B85F6;
	Mon, 25 Nov 2024 18:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732559049; cv=fail; b=YxAeO6Fl1536FPJOl+IjAJkKkl/CwagUeNqxrDuwXtMGk97qXB6nAl5naWKYk1vWYuXpAp9NZ1QOFZp9To44uj5yVEEpdSQMS3s64o87DwVpmcD5sHylFCEbMJXeLkGM3qtJJCzMVEbfRkRoXVPUlZNTp/SbDW19RCoHjtsNzSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732559049; c=relaxed/simple;
	bh=7PeIyl/3avnb2h0l59HekshOv3SufTuM4rh0twRKfwY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E4I1ajQPU6hCp7QaY2aa6ZuZ+kFptHDXh+jKWqD0jr1nDoVooeV97qbDlIuICIO2CdrqHHt32xmsEsfs2E+CS91CNoc/bmLYDdjLLAYk4MQ8l9ckDe+bcwAYH061GZxbl8OQc9MTuUpIMNE9ubJdjgzt0x+tiX858tuWMYnyVDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=rg2zVBGt; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=MNKN48EL; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=OEHpCpd4 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APFS44J026549;
	Mon, 25 Nov 2024 10:23:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=7PeIyl/3avnb2h0l59HekshOv3SufTuM4rh0twRKfwY=; b=
	rg2zVBGtCcwqTUknvhMFhwZJSXSMh4UCs8abyCvlOJ4niqAV0lvirMDfUxGO2Qk5
	Jdi/5fPrC9reu5+JRjYu1Kku4qCcZdVY2kSg5d8AzBsq6vmsOZ5FZ6GcLE8EEPET
	w57Mty0Qhv1aLV3IajtwIUQ3s0oP4GnFlkReXUPZAYw7M3DJKzUCXhjJ1Junhfwh
	zsLM6tHSCDz5Psu/8FcObgVhrLTjjt631iKngQsiuuvFctOooquXLjXCODnPCVin
	kUDkHjnZFv3xdNp4Jez8vUenT9D/1IE/VuFNEsa2rj6MZHNPQqarAU2DrD4PbP4a
	lV5Dtjj5EMTQc+/qIa7sUw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4342b0x7vf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 10:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1732559028; bh=7PeIyl/3avnb2h0l59HekshOv3SufTuM4rh0twRKfwY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=MNKN48ELHbbvPHQsGQnlaUBDQ13tI2FvWKf4DKa+EwK8hKpsENVcdYC9x4RsEAJFm
	 6a3hzy7VfXkzYgrVZxpmvCgvVM5t20H2LNZtLQPYh5GQ5sJtTxTCKpdM0XrgGjXBKo
	 hMgvgErcHKIjbbu83i8IOqE6bL0wn7xe96O+YYgtYdaFHwo2LZyblxsnzJC3sYQ1/9
	 PXBaiMuBlMGToV4rLqF4psLPg0Ne6+fUcUUG3xYrmP10lXFcmSt1d942K2HvcpgimW
	 8/BsuABPvBw+BHhrWWdlWI2FQpU10kpbLcaeYGMW+rusuwLaz6iMP1Ik9zJj9k4TDA
	 Yok4cHISLcMyw==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 261DC40147;
	Mon, 25 Nov 2024 18:23:47 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 8BAEDA0076;
	Mon, 25 Nov 2024 18:23:47 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=OEHpCpd4;
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1B7BD4052F;
	Mon, 25 Nov 2024 18:23:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abiBK36hxigmJpVtE8hMIYC/Kp+jKgfn5f8RdRtovv7HVWh3h0R+8GsiEkTj5+SXjaZrCJfyDHnjGAZJQNxq7V3hWtzMjSjBAxsz3A5EX1RoAlc1AX1ADrEveJAzNZk5INaQZbO9tQeEQ058yk5ul1e1EdpBYvPsGuuvzCc5nP6opUrPN02TLALdlfVmr64wYkkLPfXGe4hceSoXoiMsL9TS9RNKQZbPFrL9svth7/kxg+02Ia8tE0Q4tPKvP0LaYBKvL43ezUOhAABoP2iWQMuakm/znaekbZC486ylRKK/dhpjEBVJ2ndMf/+4HoYwkIOsonsi7h1cVWHyquAs/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PeIyl/3avnb2h0l59HekshOv3SufTuM4rh0twRKfwY=;
 b=VRuyAaZa6RB6xzhGSs5dDiFxChatvxcoG2Zyt9ZNLwFad0+59agV9iSe4pZhA7C5RrEd91KdMxksnZaJU6ay6nGdcGVP7mcLrjbVSfsvD1USRsv4Ybqn6A+NL/6PxrRjO8iqKqmVeapR/tUz3nSJ/EHqPEJPc+KmFfLGWzEPnAKfLdhhQg6S8psxpPoJfGVOFSaSi27jlOuMst15AXDFanePhCIq9BNNO0Va1HeBw77grs9fsrtbE6cKCuTeOdaQPdxRlFxF0mR1X7yeDJ02QGO/ZQq4xiolvB/F1hyU1AusrMnhcW57muIthOehMQ8Kv97UiAglsK2FKyWEp971kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PeIyl/3avnb2h0l59HekshOv3SufTuM4rh0twRKfwY=;
 b=OEHpCpd4NPvPUxmNYuVESLwUqRAZWq7proLK9zb03Rc9WSZvxvjfwn8820X+5fJIb74dg5EDu7yHCTFi5ovixwb5mqNDXv6tyrp1+ewBls/4+YWrqzE77n3hPiCfcw/fzAXJA1aSOuh0zLJz3v/qgD53FosQ67Njx/h06z1lSK4=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CH2PR12MB4309.namprd12.prod.outlook.com (2603:10b6:610:a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Mon, 25 Nov
 2024 18:23:43 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 18:23:43 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Siddharth Vadapalli <s-vadapalli@ti.com>, "srk@ti.com" <srk@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: dwc3-am62: Re-initialize controller if lost
 power in PM suspend
Thread-Topic: [PATCH] usb: dwc3: dwc3-am62: Re-initialize controller if lost
 power in PM suspend
Thread-Index: AQHbPOaCI7R13zfU+USZwOYHfSs+F7LIVIOA
Date: Mon, 25 Nov 2024 18:23:42 +0000
Message-ID: <20241125182343.bfnecsub2oxohrns@synopsys.com>
References: <20241122-am62-dwc3-io-ddr-v1-1-cc4956449420@kernel.org>
In-Reply-To: <20241122-am62-dwc3-io-ddr-v1-1-cc4956449420@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CH2PR12MB4309:EE_
x-ms-office365-filtering-correlation-id: 482a84f6-608f-4904-cf2f-08dd0d7e4ae0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cWN3TG1FQ3dpL1pHUUFRUGNrVmdiM3RCVkU5V002NDc0RW01N0ZmdkRUc2RO?=
 =?utf-8?B?OHJveTIyMXNSTmpha0tSQXcweGtDdFdmSUIxZEc4azZNVElkNUUrSkY0RnQ0?=
 =?utf-8?B?ejBEU3RxUFVsOUxQQ2F1elpDa2Vsa1NoQ2ZmK0lCNGtJc284UitFTUtMV0M3?=
 =?utf-8?B?cEdiaEI5UVRJMEJMZ01xYk5kMjJwbEtqMzhKWXd5Rm14TW5Od1NhVTVhNG9i?=
 =?utf-8?B?SkdRQWR1THBFSy9SN3kxZlVvQS84eG9VQXV3NUYvZGtCbEJBVU5EK3VINERI?=
 =?utf-8?B?T0lQUzFDUDB1cEFqVkhidnIxRHVEUFpOVGJRUW5kb1lGcVg5NG5HeFo0NjFk?=
 =?utf-8?B?TWN2NVcrdlJET0k0Y042ajI3UURDK3JwUWJXZVVEUzhwL1RIeVVQcDVuelhI?=
 =?utf-8?B?cjl4OWZsZDB0TVNNQkthYXhSSUFDeVo0L01WK296UFpwWDQ4U1IydlBiVmZK?=
 =?utf-8?B?bmdER1FtL1c1aTVQY0o1S0VWQit6ZG5TelltNTZCZTZVQUJjYVR1SVVtRUhK?=
 =?utf-8?B?dGZHbzlKcHpwMitMbUNHMjlGTjlvelBLZy9xUTNhdENXVTJUT2MyS0lUUmhK?=
 =?utf-8?B?YVFTdW1FdDBUbm5oVzFnbHFQTnYxODVPenN1V093Q21BZ1poRXE1UTVPbm8w?=
 =?utf-8?B?RVB0cnRFb2VwSGQ5S2VBUjhFY25HSGpUSC9KOVJ3T2lITXBMbGcwNnNoRERN?=
 =?utf-8?B?Yi9rZE13VEN4MDZPY2V6L0JUWlRTSGQzbzJYbGlISXZRdmdUWTlYb0ZBQVIz?=
 =?utf-8?B?QzZHUURvdW11V2ZnWWNqRlFJeU5YaWNqRlptNXVabm83RitrQmRvSEpDczI1?=
 =?utf-8?B?aG0xbFc1REhpNG4xdW4rN3J2UWFJMTMrYllTcDBaY1N2UEVQWnczbEpLbk1P?=
 =?utf-8?B?dEcrcXNVREtFYlJpQnF4a0haT1J6U0w0WlpTOC9Xa095Y04xdmg1Nk5ja2Iz?=
 =?utf-8?B?M2tFb2pDLzFNcjM2RDk1TjlXU3N1aXFrc2tXVHRYZ2lwN25FWkR5blI5eFl0?=
 =?utf-8?B?bUd4OHZsaEFWQmNmM0hnMDJ2aTJDL09CQXhIaVltUGlsL2gwWCtYMm1wZWZ2?=
 =?utf-8?B?c3phd013YzFZUjBYczlneHNWbW5abFVrbnZyYXFDZFJWOGRDdldwS2d6Q0lY?=
 =?utf-8?B?RVVqeGJXTlljS0UxQ2xjTzdrWjUzTHhMWEgzallGdVBCVVZhNVNQVHplNHpn?=
 =?utf-8?B?R3UySlRpTm9Bd3duaEVybmdyNmFkdVRDbGVvMHlSMzNsbDFtbEcvNS9GUTc2?=
 =?utf-8?B?SURaZ054anoxSHJPeDBVTHRzaXd1Si9XUjdpWXliVEZOazlQSFg3UVdFRGo3?=
 =?utf-8?B?ZUd1cE9MOGhkSEQxRzlrVkNwYmdJWHlpNUJEV09PWnMxdTc5bFdDZWpsME9H?=
 =?utf-8?B?aXlvNmx2Z2QwM3FKYzFGaGtMV3JBM0FiRjMyUGFhaUFGOVhwdkN1anpSWGJN?=
 =?utf-8?B?Zit3YTVuWmg0bDlEZ20xZEs0cFBWaCtXQ1JQR1BERDlNb3ExcDhqbENRaTgz?=
 =?utf-8?B?TDZQSEwyTDRMYTAwejA4NUxVWGs1cG5PUTJ5bDI5YjYxbG5LeTlmc1RwZGdM?=
 =?utf-8?B?ZmRBSytqdGlxSjA3c1VPYWVndWpucE1kZ2I4eWVkeVdVUndXZGFWanBvaGpW?=
 =?utf-8?B?eGhKRGY2QmlSa0xuYUgwSzh2WHp5VnRPVm9GN0JRZ080VzVlMXBIVDFvVmNj?=
 =?utf-8?B?RnpCZHFtL0FnNnVOV3FjL09zb0Q0NXdTSUNIMDlVYUpFd2tNaE1nMi83bnBm?=
 =?utf-8?B?RE1EMTd4RVhkamtxdHZVbFNNeWhCUFo3K2x5aDQ5Z2lycmE0a1NJZEFnVE02?=
 =?utf-8?B?SjZxZkw5aEdjYXVFUU5pZXVGK1pzdExVTDkzQThmVGd3Q2NpaXBiWmhPUTVJ?=
 =?utf-8?B?UlkxWlAyR2RWQjcvMmhUbkcremNuRWRmeFVvTVZvd2M3ZlE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aTBlL1JPUzIvdzZZaWE1dnNUeUFkUEJYNk41MURkWkNBUXlPRTE0WDZSeTM3?=
 =?utf-8?B?RHhxMlNOeERjVlhtQjFmcmJJWldXeDFSUnd5VmVTTjZiVE8xMDB0Zmp2QzEr?=
 =?utf-8?B?UnNuU01ldGZaZEswWTJ0WElzbFVUODM5WGRNaU9PdGgwWExJYVV3SGhieXlC?=
 =?utf-8?B?MnlIY0NZc1ZDZGhxd2VNRFIxSENnVEM2amNOSTNPUkRBbGdVR3hpLzhvWTF2?=
 =?utf-8?B?dHE4YnFlditNbkUzVU1Wb08wVitkbkcvQ0hwNFJZUmg0MVM5aXROdktFVVQ2?=
 =?utf-8?B?ZDJ6VS9rU3RiY1FLMmtUaFlBYUw0YjVVcGk2ZWR1RTNablVwUmNZdVFQUWFp?=
 =?utf-8?B?aXlXdUxCREd1SGtBeDVZa3BoVnhnSUR3anZQalJCekMxYmNxY1hzaE42eVhI?=
 =?utf-8?B?RjN0ZEdtSS96aUcwVmlzWVF5OTlmMVRaaEpLK1lnejJpZzEyckEwMWRIWDkr?=
 =?utf-8?B?MlIvZW9wbDQ2Y29Nbk9udUNCZU9hWTROVExVVGZqVUZ5ditVY0N1aWY5Mjhu?=
 =?utf-8?B?dEJXNmlsRDZtTG1CUEJJRzdlSm0rS3czbUdVaGlPOE9tYnk1YlBvdVNSaVVX?=
 =?utf-8?B?NDc1ZHozN3RyUnkzSFVxRTZmeDNlNU44R2lTVUU1WDZXMUZZSHRPSHp1SFd5?=
 =?utf-8?B?NGVPOGtUaFBSaTJKNDRkRisxWGJYSHBRSnlLSk9FVWZSdDZ4M0JUaG9RSENu?=
 =?utf-8?B?Q05FRzc2cmpzWHl0RkFGbWEvN2ROaFhVVVYzU1p1c1dLZ3dBTGlCTVhJc21o?=
 =?utf-8?B?NUFjQWV4M0Nqc2VlZGNRVVA2TTFRUDdNMWRIdDFkS2hTVkJmaFpoOG9oM1F3?=
 =?utf-8?B?a0NlQUJ4ajNxeDVWem9xU2RqK0srZGVrYnVOc0p4ZVpqWU5ocUI4cUMrMUNy?=
 =?utf-8?B?clF6UE5PTTNvanpWalNBS3FsdUwzMXpJSS9SOWpRZUt2bm01SVRHcVNJd2RF?=
 =?utf-8?B?SEE4V0ZVS0pPeGRJaFJETUtYV1Y2YmpzVkdpcFEwalNtTWR0NTM5UlBrdHFT?=
 =?utf-8?B?cXRGQUo5Zm5NMWhQbXoxU2RvZ1NPUEt1N0hKUzdjWTA0RzRNMGlFb1g4T1d5?=
 =?utf-8?B?eE9wRkpQcXlIbmtNQ09rbGhka1BSbDNKK0xIVk5nUzNUbmttV0Uvb3IvSjNJ?=
 =?utf-8?B?S1pkYVlIcjR2NVpRS05LeFF1Y0pZVExCTzNkalhoWEYyMXdCeGxUUHE2cmRv?=
 =?utf-8?B?dEJnNlh1US9qSm91bDF6WWpxRGdxSmlCNjh1dld3YjZXOURVVE5GQWhvd1pJ?=
 =?utf-8?B?eENmQ0FQNHZ3MkdVY2ZZK0plRHJnNjZiK0ZKNWdsMTFoeDFvd29sVWRWdmY2?=
 =?utf-8?B?dG5RUUlCdTFxeE1qVzU1UjFkN1F4cWFHYXI3YzRxYkEzMkFkSDV2Y2FjVVZT?=
 =?utf-8?B?OXQ1SWd4VVJNWTRiMlhsUkJGVEt3RU95emZiMTdYMFM0N2xyRHB5MUM4RENn?=
 =?utf-8?B?YVRPaTBSNCswRElNaUpqV3llb3BacUd3Y3M0TGw4QXZuTmVHWmtNZW4yVlFB?=
 =?utf-8?B?Y1EzZERXdEtKRFo0YnBPY0liY0dRZnJNQkNLd2lZNXdVc3JOeEhKTW95NHNN?=
 =?utf-8?B?YlNHb01qdERJd2xiWHZYcnZETm1ZWXBPT2lNTysrR0o3NlVDQlpnREdtMEZK?=
 =?utf-8?B?dGY5S2NhbkJWVHoyV2F4RWtTM2o2YlJnMFZhTVJRWU1UWHRicG04aVBmckty?=
 =?utf-8?B?U0NrL3RMeFhCT0JETENLVmw2MU4vNndOU01JeUZZN3JOcFlpdVZrTGdLZEIz?=
 =?utf-8?B?VW1pSFN1Yk9abW1lcHhOVzFBcG1qTFY3QWlLUXJsd2oyNWowSE1zZ3dEcXNz?=
 =?utf-8?B?dTNnRHFZTXhJVFdQRXpsSzg2bmk0dGNqLytDb1kvS2FGQlM1ZzNlblByZ1h4?=
 =?utf-8?B?a29JZC9tR09hT0lmbVE1T1diWCtZaUlkRDR2NVZGSXRKRDhXdUhuc0hsNjg5?=
 =?utf-8?B?ZWE2eVNMdGM2cTU4Wm9kc3NOSkFLb3BueTVhcUNOdDhtdldFejBrazN0bUtv?=
 =?utf-8?B?akY1ZkhnTHVTK05ML0p3dDBlUUlSUGdBbXpkUmFNbTlQcFEyUTZRd2o0SU45?=
 =?utf-8?B?aElyTUpWbEt3enZDdHlueHBxaHR2dzk0UE14aFVKODd1M0ZLTml0OTFIMlJN?=
 =?utf-8?B?NTVUdnNlSVVhRm9XL3BVb3o1Y3Yya0tHWWt4aVNtZm9KYk1mQ0p6ajBoZXFE?=
 =?utf-8?B?ekE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <89D46F19C2D4CB498C10515E4ECD922E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6u807N1aIcDGxPvBb3FMdqwqiSciHWzMxNvcQ2kMuhPaGfLoR9yfNGretjYB7+a1ZARIk344rdzeIQL/ZfkVly8oYVfEWEzcXrC4PjvoDp1KcD/ypnBnbg8tfBatesOcwcabw+EBVCeKN6FntJkHaznEz/t4xwniPpvvNrKPp0+EBv/NP4t+FcLn+c4AmY9sedRgrWJS0NAf9Sy7UazZpXlWIddCGhjFW0+iJy8qxU19ezOO+v+uS+6LbvBtAsXCA3s6g1FBX6dMcX3tC6Rbf7C3RJPIj4oVm3tU0O3UtnHH6BEJIWWF/ONN35jyuHOjjSlYI8cyHZZwk5VC7mZbYOKrMDZ04zncMaH9hc4VQrgP+5/naKUJbDpllzwr6kkeq5ILigdoLstImwzgaimyw/jywM4PdLRHlfCKQIZSQv/8vTRiyVX+inDR9IYqSpl+e0BzroXGXyKifHA5D/lIpxs7ROSBcYpqQKrTLFDNLG89jXUOAX9ufwBgOxUx4Hyy0XQmYfIGC7rxwLUzS3/iSAVf8JsldkxOD/0MxTQDnAxvw5PnhZ8tuV04yDUL+55FyLGJopKNqQ4cUB8JCXot/DqZKnKx6cwBM4jjcc4SvBN2qaXRD3EI/me0/pNNafLUaiyXkaHPnK5psmfdwYYOIQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 482a84f6-608f-4904-cf2f-08dd0d7e4ae0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2024 18:23:42.9195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aK3PTaCvpJE9UBOj3mwJB2FX///KVydMWj2WK5nDEFsPIhZp5AfDRJA3s61xahSFwMAoSkJ6ykvAcJ6uEFB3aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4309
X-Proofpoint-ORIG-GUID: 1qBQhwh16uob4_zz-Hc69QN1EE4w7qKQ
X-Proofpoint-GUID: 1qBQhwh16uob4_zz-Hc69QN1EE4w7qKQ
X-Authority-Analysis: v=2.4 cv=I4Y3R8gg c=1 sm=1 tr=0 ts=6744c0b4 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VlfZXiiP6vEA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8 a=zwN49a19Amrq6m5fmp8A:9 a=QEXdDO2ut3YA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 malwarescore=0
 phishscore=0 clxscore=1011 spamscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411250152

T24gRnJpLCBOb3YgMjIsIDIwMjQsIFJvZ2VyIFF1YWRyb3Mgd3JvdGU6DQo+IElmIGNvbnRyb2xs
ZXIgbG9vc2VzIHBvd2VyIGR1cmluZyBQTSBzdXNwZW5kIHRoZW4gcmUtaW5pdGlhbGl6ZQ0KPiBp
dC4gV2UgdXNlIHRoZSBERUJVR19DRkcgcmVnaXN0ZXIgdG8gdHJhY2sgaWYgY29udHJvbGxlciBs
b3N0IHBvd2VyDQo+IG9yIHdhcyByZXNldCBpbiBQTSBzdXNwZW5kLg0KPiANCj4gTW92ZSBhbGwg
aW5pdGlhbGl6YXRpb24gY29kZSBpbnRvIGR3YzNfdGlfaW5pdCgpIHNvIGl0IGNhbiBiZSByZS11
c2VkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUm9nZXIgUXVhZHJvcyA8cm9nZXJxQGtlcm5lbC5v
cmc+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9kd2MzLWFtNjIuYyB8IDgyICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwg
NTUgaW5zZXJ0aW9ucygrKSwgMjcgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy91c2IvZHdjMy9kd2MzLWFtNjIuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1hbTYyLmMN
Cj4gaW5kZXggZmFkMTUxZTc4ZmQ2Li4yMTkyMjIyZmFmNGYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvdXNiL2R3YzMvZHdjMy1hbTYyLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9kd2MzLWFt
NjIuYw0KPiBAQCAtMTA4LDYgKzEwOCw5IEBADQo+ICANCj4gICNkZWZpbmUgRFdDM19BTTYyX0FV
VE9TVVNQRU5EX0RFTEFZCTEwMA0KPiAgDQo+ICsjZGVmaW5lIFVTQlNTX0RFQlVHX0NGR19PRkYJ
CTB4Nw0KPiArI2RlZmluZSBVU0JTU19ERUJVR19DRkdfRElTQUJMRUQJMHg3DQoNCkRvIHdlIG5l
ZWQgMiBkaWZmZXJlbnQgbWFjcm9zIHdpdGggdGhlIHNhbWUgdmFsdWUgb2YgdGhlIHNhbWUgcmVn
aXN0ZXINCmZvciB0aGlzPw0KDQpSZWdhcmRsZXNzLA0KDQpBY2tlZC1ieTogVGhpbmggTmd1eWVu
IDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGFua3MsDQpUaGluaA0KDQo+ICsNCj4g
IHN0cnVjdCBkd2MzX2FtNjIgew0KPiAgCXN0cnVjdCBkZXZpY2UgKmRldjsNCj4gIAl2b2lkIF9f
aW9tZW0gKnVzYnNzOw0KPiBAQCAtMTE3LDYgKzEyMCw3IEBAIHN0cnVjdCBkd2MzX2FtNjIgew0K
PiAgCXVuc2lnbmVkIGludCBvZmZzZXQ7DQo+ICAJdW5zaWduZWQgaW50IHZidXNfZGl2aWRlcjsN
Cj4gIAl1MzIgd2FrZXVwX3N0YXQ7DQo+ICsJdm9pZCBfX2lvbWVtICpwaHk7DQo+ICB9Ow0KPiAg
DQo+ICBzdGF0aWMgY29uc3QgaW50IGR3YzNfdGlfcmF0ZV90YWJsZVtdID0gewkvKiBpbiBLSFog
Ki8NCj4gQEAgLTE4NCwxNSArMTg4LDQ3IEBAIHN0YXRpYyBpbnQgcGh5X3N5c2Nvbl9wbGxfcmVm
Y2xrKHN0cnVjdCBkd2MzX2FtNjIgKmFtNjIpDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+ICANCj4g
K3N0YXRpYyBpbnQgZHdjM190aV9pbml0KHN0cnVjdCBkd2MzX2FtNjIgKmFtNjIpDQo+ICt7DQo+
ICsJaW50IHJldDsNCj4gKwl1MzIgcmVnOw0KPiArDQo+ICsJLyogUmVhZCB0aGUgc3lzY29uIHBy
b3BlcnR5IGFuZCBzZXQgdGhlIHJhdGUgY29kZSAqLw0KPiArCXJldCA9IHBoeV9zeXNjb25fcGxs
X3JlZmNsayhhbTYyKTsNCj4gKwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gcmV0Ow0KPiArDQo+ICsJ
LyogV29ya2Fyb3VuZCBFcnJhdGEgaTI0MDkgKi8NCj4gKwlpZiAoYW02Mi0+cGh5KSB7DQo+ICsJ
CXJlZyA9IHJlYWRsKGFtNjItPnBoeSArIFVTQl9QSFlfUExMX1JFRzEyKTsNCj4gKwkJcmVnIHw9
IFVTQl9QSFlfUExMX0xET19SRUZfRU4gfCBVU0JfUEhZX1BMTF9MRE9fUkVGX0VOX0VOOw0KPiAr
CQl3cml0ZWwocmVnLCBhbTYyLT5waHkgKyBVU0JfUEhZX1BMTF9SRUcxMik7DQo+ICsJfQ0KPiAr
DQo+ICsJLyogVkJVUyBkaXZpZGVyIHNlbGVjdCAqLw0KPiArCXJlZyA9IGR3YzNfdGlfcmVhZGwo
YW02MiwgVVNCU1NfUEhZX0NPTkZJRyk7DQo+ICsJaWYgKGFtNjItPnZidXNfZGl2aWRlcikNCj4g
KwkJcmVnIHw9IDEgPDwgVVNCU1NfUEhZX1ZCVVNfU0VMX1NISUZUOw0KPiArDQo+ICsJZHdjM190
aV93cml0ZWwoYW02MiwgVVNCU1NfUEhZX0NPTkZJRywgcmVnKTsNCj4gKw0KPiArCWNsa19wcmVw
YXJlX2VuYWJsZShhbTYyLT51c2IyX3JlZmNsayk7DQo+ICsNCj4gKwkvKiBTZXQgbW9kZSB2YWxp
ZCBiaXQgdG8gaW5kaWNhdGUgcm9sZSBpcyB2YWxpZCAqLw0KPiArCXJlZyA9IGR3YzNfdGlfcmVh
ZGwoYW02MiwgVVNCU1NfTU9ERV9DT05UUk9MKTsNCj4gKwlyZWcgfD0gVVNCU1NfTU9ERV9WQUxJ
RDsNCj4gKwlkd2MzX3RpX3dyaXRlbChhbTYyLCBVU0JTU19NT0RFX0NPTlRST0wsIHJlZyk7DQo+
ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGludCBkd2MzX3RpX3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICB7DQo+ICAJc3RydWN0IGRldmljZSAq
ZGV2ID0gJnBkZXYtPmRldjsNCj4gIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUgPSBwZGV2LT5k
ZXYub2Zfbm9kZTsNCj4gIAlzdHJ1Y3QgZHdjM19hbTYyICphbTYyOw0KPiAgCXVuc2lnbmVkIGxv
bmcgcmF0ZTsNCj4gLQl2b2lkIF9faW9tZW0gKnBoeTsNCj4gIAlpbnQgaSwgcmV0Ow0KPiAtCXUz
MiByZWc7DQo+ICANCj4gIAlhbTYyID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCphbTYyKSwg
R0ZQX0tFUk5FTCk7DQo+ICAJaWYgKCFhbTYyKQ0KPiBAQCAtMjI4LDI5ICsyNjQsMTcgQEAgc3Rh
dGljIGludCBkd2MzX3RpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAN
Cj4gIAlhbTYyLT5yYXRlX2NvZGUgPSBpOw0KPiAgDQo+IC0JLyogUmVhZCB0aGUgc3lzY29uIHBy
b3BlcnR5IGFuZCBzZXQgdGhlIHJhdGUgY29kZSAqLw0KPiAtCXJldCA9IHBoeV9zeXNjb25fcGxs
X3JlZmNsayhhbTYyKTsNCj4gLQlpZiAocmV0KQ0KPiAtCQlyZXR1cm4gcmV0Ow0KPiAtDQo+IC0J
LyogV29ya2Fyb3VuZCBFcnJhdGEgaTI0MDkgKi8NCj4gLQlwaHkgPSBkZXZtX3BsYXRmb3JtX2lv
cmVtYXBfcmVzb3VyY2UocGRldiwgMSk7DQo+IC0JaWYgKElTX0VSUihwaHkpKSB7DQo+ICsJYW02
Mi0+cGh5ID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIDEpOw0KPiArCWlm
IChJU19FUlIoYW02Mi0+cGh5KSkgew0KPiAgCQlkZXZfZXJyKGRldiwgImNhbid0IG1hcCBQSFkg
SU9NRU0gcmVzb3VyY2UuIFdvbid0IGFwcGx5IGkyNDA5IGZpeC5cbiIpOw0KPiAtCQlwaHkgPSBO
VUxMOw0KPiAtCX0gZWxzZSB7DQo+IC0JCXJlZyA9IHJlYWRsKHBoeSArIFVTQl9QSFlfUExMX1JF
RzEyKTsNCj4gLQkJcmVnIHw9IFVTQl9QSFlfUExMX0xET19SRUZfRU4gfCBVU0JfUEhZX1BMTF9M
RE9fUkVGX0VOX0VOOw0KPiAtCQl3cml0ZWwocmVnLCBwaHkgKyBVU0JfUEhZX1BMTF9SRUcxMik7
DQo+ICsJCWFtNjItPnBoeSA9IE5VTEw7DQo+ICAJfQ0KPiAgDQo+IC0JLyogVkJVUyBkaXZpZGVy
IHNlbGVjdCAqLw0KPiAgCWFtNjItPnZidXNfZGl2aWRlciA9IGRldmljZV9wcm9wZXJ0eV9yZWFk
X2Jvb2woZGV2LCAidGksdmJ1cy1kaXZpZGVyIik7DQo+IC0JcmVnID0gZHdjM190aV9yZWFkbChh
bTYyLCBVU0JTU19QSFlfQ09ORklHKTsNCj4gLQlpZiAoYW02Mi0+dmJ1c19kaXZpZGVyKQ0KPiAt
CQlyZWcgfD0gMSA8PCBVU0JTU19QSFlfVkJVU19TRUxfU0hJRlQ7DQo+ICANCj4gLQlkd2MzX3Rp
X3dyaXRlbChhbTYyLCBVU0JTU19QSFlfQ09ORklHLCByZWcpOw0KPiArCXJldCA9IGR3YzNfdGlf
aW5pdChhbTYyKTsNCj4gKwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gcmV0Ow0KPiAgDQo+ICAJcG1f
cnVudGltZV9zZXRfYWN0aXZlKGRldik7DQo+ICAJcG1fcnVudGltZV9lbmFibGUoZGV2KTsNCj4g
QEAgLTI1OCw3ICsyODIsNiBAQCBzdGF0aWMgaW50IGR3YzNfdGlfcHJvYmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikNCj4gIAkgKiBEb24ndCBpZ25vcmUgaXRzIGRlcGVuZGVuY2llcyB3
aXRoIGl0cyBjaGlsZHJlbg0KPiAgCSAqLw0KPiAgCXBtX3N1c3BlbmRfaWdub3JlX2NoaWxkcmVu
KGRldiwgZmFsc2UpOw0KPiAtCWNsa19wcmVwYXJlX2VuYWJsZShhbTYyLT51c2IyX3JlZmNsayk7
DQo+ICAJcG1fcnVudGltZV9nZXRfbm9yZXN1bWUoZGV2KTsNCj4gIA0KPiAgCXJldCA9IG9mX3Bs
YXRmb3JtX3BvcHVsYXRlKG5vZGUsIE5VTEwsIE5VTEwsIGRldik7DQo+IEBAIC0yNjcsMTEgKzI5
MCw2IEBAIHN0YXRpYyBpbnQgZHdjM190aV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KPiAgCQlnb3RvIGVycl9wbV9kaXNhYmxlOw0KPiAgCX0NCj4gIA0KPiAtCS8qIFNldCBt
b2RlIHZhbGlkIGJpdCB0byBpbmRpY2F0ZSByb2xlIGlzIHZhbGlkICovDQo+IC0JcmVnID0gZHdj
M190aV9yZWFkbChhbTYyLCBVU0JTU19NT0RFX0NPTlRST0wpOw0KPiAtCXJlZyB8PSBVU0JTU19N
T0RFX1ZBTElEOw0KPiAtCWR3YzNfdGlfd3JpdGVsKGFtNjIsIFVTQlNTX01PREVfQ09OVFJPTCwg
cmVnKTsNCj4gLQ0KPiAgCS8qIERldmljZSBoYXMgY2FwYWJpbGl0eSB0byB3YWtldXAgc3lzdGVt
IGZyb20gc2xlZXAgKi8NCj4gIAlkZXZpY2Vfc2V0X3dha2V1cF9jYXBhYmxlKGRldiwgdHJ1ZSk7
DQo+ICAJcmV0ID0gZGV2aWNlX3dha2V1cF9lbmFibGUoZGV2KTsNCj4gQEAgLTMzOCw2ICszNTYs
OSBAQCBzdGF0aWMgaW50IGR3YzNfdGlfc3VzcGVuZF9jb21tb24oc3RydWN0IGRldmljZSAqZGV2
KQ0KPiAgCQlkd2MzX3RpX3dyaXRlbChhbTYyLCBVU0JTU19XQUtFVVBfU1RBVCwgVVNCU1NfV0FL
RVVQX1NUQVRfQ0xSKTsNCj4gIAl9DQo+ICANCj4gKwkvKiBqdXN0IHRvIHRyYWNrIGlmIG1vZHVs
ZSByZXNldHMgb24gc3VzcGVuZCAqLw0KPiArCWR3YzNfdGlfd3JpdGVsKGFtNjIsIFVTQlNTX0RF
QlVHX0NGRywgVVNCU1NfREVCVUdfQ0ZHX0RJU0FCTEVEKTsNCj4gKw0KPiAgCWNsa19kaXNhYmxl
X3VucHJlcGFyZShhbTYyLT51c2IyX3JlZmNsayk7DQo+ICANCj4gIAlyZXR1cm4gMDsNCj4gQEAg
LTM0OCw3ICszNjksMTQgQEAgc3RhdGljIGludCBkd2MzX3RpX3Jlc3VtZV9jb21tb24oc3RydWN0
IGRldmljZSAqZGV2KQ0KPiAgCXN0cnVjdCBkd2MzX2FtNjIgKmFtNjIgPSBkZXZfZ2V0X2RydmRh
dGEoZGV2KTsNCj4gIAl1MzIgcmVnOw0KPiAgDQo+IC0JY2xrX3ByZXBhcmVfZW5hYmxlKGFtNjIt
PnVzYjJfcmVmY2xrKTsNCj4gKwlyZWcgPSBkd2MzX3RpX3JlYWRsKGFtNjIsIFVTQlNTX0RFQlVH
X0NGRyk7DQo+ICsJaWYgKHJlZyAhPSBVU0JTU19ERUJVR19DRkdfRElTQUJMRUQpIHsNCj4gKwkJ
LyogbG9zdCBwb3dlci9jb250ZXh0ICovDQo+ICsJCWR3YzNfdGlfaW5pdChhbTYyKTsNCj4gKwl9
IGVsc2Ugew0KPiArCQlkd2MzX3RpX3dyaXRlbChhbTYyLCBVU0JTU19ERUJVR19DRkcsIFVTQlNT
X0RFQlVHX0NGR19PRkYpOw0KPiArCQljbGtfcHJlcGFyZV9lbmFibGUoYW02Mi0+dXNiMl9yZWZj
bGspOw0KPiArCX0NCj4gIA0KPiAgCWlmIChkZXZpY2VfbWF5X3dha2V1cChkZXYpKSB7DQo+ICAJ
CS8qIENsZWFyIHdha2V1cCBjb25maWcgZW5hYmxlIGJpdHMgKi8NCj4gDQo+IC0tLQ0KPiBiYXNl
LWNvbW1pdDogYWRjMjE4Njc2ZWVmMjU1NzU0NjkyMzQ3MDljMmQ4NzE4NWNhMjIzYQ0KPiBjaGFu
Z2UtaWQ6IDIwMjQxMTIyLWFtNjItZHdjMy1pby1kZHItM2JjYjY4M2E5MWEwDQo+IA0KPiBCZXN0
IHJlZ2FyZHMsDQo+IC0tIA0KPiBSb2dlciBRdWFkcm9zIDxyb2dlcnFAa2VybmVsLm9yZz4NCj4g

