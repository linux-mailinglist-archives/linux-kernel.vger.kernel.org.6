Return-Path: <linux-kernel+bounces-220312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8B690DF8F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 01:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60EC8284ADD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16651849C0;
	Tue, 18 Jun 2024 23:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gclykgnP";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="fXoUbfZF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ouviut79"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7507714D44D;
	Tue, 18 Jun 2024 23:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718751959; cv=fail; b=DqtANDuI5WPO1WnTJnbrcd5ea6MeSCvHkyRrcWmRnFv/1fHleKadwOBRBeVWyiGt081VTPept7LD2LsihUgVKJfXRJqz4sxn5CDAvkCGHsNbj3qmP1xOnoyE38qTRsJiXmJYbXW6OQZlh8C2taehvIMUr1gFQzc9plxWw8slFUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718751959; c=relaxed/simple;
	bh=ku+wSJ/yXb8ZFs5HE2rN1MJHtH/TLsYth8hocJD8Q08=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rVgN1am1ogW+zCMYGsDFKvgDGLHGkRIYJNNxaLz7PQUO44NfbrouMKg8IHH+v0KtePxHXOOpApeO1X0mYeY1q0RaQe7v3rCL/BPI3KP6CAOz2phuYA7FeRQbhtAO8u4UpfbYFIfd68FMpjHimkF0JVJSTfTeQB9a+1U1rX267Hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=gclykgnP; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=fXoUbfZF; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ouviut79 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IMow76011367;
	Tue, 18 Jun 2024 16:05:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=ku+wSJ/yXb8ZFs5HE2rN1MJHtH/TLsYth8hocJD8Q08=; b=
	gclykgnPcaO1SGOMucJb4v7ouItXA/K8xsI8Z6eYX8WgsVOs86A+DpPXQA2R4kdU
	kN0FeIr62yehVmrSKjUNIABaphIrtUbDWwhA7nNkUxmyDeZDzu/OWg5ryWvSfI3w
	JTPK8urZ6iV2msFuB3gvXw64ybcY++vE41952eLiAVkTQc4sF2RmiePdkniRkkho
	EqEHZu0H8XNmNhZtxDF1yksYdsgMv2/XIIzyTpup/wC2IFiIYoYNaZKbP73xjZga
	Gvcbe4ZopgdBNqYGYnLsEbMRDjGRkF0JALwbchDkWK9Qf27tGBdpXv/CW42oB67j
	p6pWAk0JT5zurZE0DNv60Q==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3yujaq06x6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 16:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1718751948; bh=ku+wSJ/yXb8ZFs5HE2rN1MJHtH/TLsYth8hocJD8Q08=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=fXoUbfZF9tsSraRIlEc0zXIYANRt/zuMWPeDRlErMQuQhILYMucv2zejRraz8C1nH
	 X2T7dEctiPdZ10t2noyV2KpqwksIbvoc8QP7d+pULC5Nx7lrhPWPU5DZj9XNmZgFpy
	 qOuevpndjrrRxXdLExFX26kFI8k30jKLMSSl91HJAS4NEXlEjn4kMfYen4oxpGNti1
	 hdGD5fdU5z7cExo705O+3PUSrYHvqDLKDIiZc0gtm23kXZD5aXXTKmDMWEgjzGimZ5
	 O6vuZj3vRj7oqR/TApREexajfijIhifiHeoWWlUwp1p+KYjjPCc2yFj1DiMtq9BBrX
	 b5pBSc8LbVJvw==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8C9F84048B;
	Tue, 18 Jun 2024 23:05:48 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 60345A006E;
	Tue, 18 Jun 2024 23:05:48 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=ouviut79;
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 2992540355;
	Tue, 18 Jun 2024 23:05:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njEKB3jM9R1C89LeMCHGnE5UtV2acJkVZXkGjeVIYsFpwjXe9KrfyhRgTh2m3CFCzmOtApF6NUHK9BNLdenuquVpV1Yv70I0njXSndc2+JD4Wg4RZAzzm19fW/B4GdTkTn1WcTDdMnnsuz5Aj9nr97HfkbS+HKLe5LiIkC6kLDOlKMvBoxSeVWrovqd/CowiA0xEypU+iCUk9bHtEKdL93yOOwQzNsOoglbz5kgq8YnY5VZkx6Azu4MX9ReNIaKEkQjH2v5Ta5y626a3RVwxPHK4/EL19o8/KMgbGZnuC3n9/RCyHqFEdTn/8q12GiY7NMSS/jsxGTYoEyZRjrPNDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ku+wSJ/yXb8ZFs5HE2rN1MJHtH/TLsYth8hocJD8Q08=;
 b=X/D6mfLIdcO7r6ktom60pMDZ0J8aHf3Id7hVfF3kjlO2MtLMIQjrZ5Uqed9Kmo3gJRL6MWd4GvrP9c62FOaI1woMUCECYJ8eEzx1896oYfiVxZP9r6I+aMZ98vuae4fHukjY1yIjlG3lRRiPNw91TNxchr3TcjsTCFL64zfOPR5xp9VB8dSPQZTwZkrS/GG5ffMwEi2lT4VG/z7bFe15gM3th3M3p6jzJxor4JLPackI8ENYwXI8duI6QYidevdDVIWUeuDiU4ZDvdboApxNYH2J1EPwviT30ijMsB22I4txPSigz2Z7bumrVwib0puUh4J6HfQCrBBQzSgnYQZ3YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ku+wSJ/yXb8ZFs5HE2rN1MJHtH/TLsYth8hocJD8Q08=;
 b=ouviut796JFfP9hYDfKKndOGqUDYscMJxvlLTMts1cXrf0pJwkNu1PWW5OpHs6rJ6oidsTdiqXFKZfPuCm8qCXniDcyUHcTFxwBxFemFWYuQRlkKXr8oMQ3LNuJz/8t7nw8XDCdAjVnveMidSx85jkffZz/BOIs1Zp6zPAWPeWs=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by BY5PR12MB4243.namprd12.prod.outlook.com (2603:10b6:a03:20f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 18 Jun
 2024 23:05:45 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 23:05:44 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Meng Li <Meng.Li@windriver.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "quic_uaggarwa@quicinc.com" <quic_uaggarwa@quicinc.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xu.yang_2@nxp.com" <xu.yang_2@nxp.com>
Subject: Re: [v2 PATCH] usb: dwc3: core: remove lock of otg mode during gadget
 suspend/resume to avoid deadlock
Thread-Topic: [v2 PATCH] usb: dwc3: core: remove lock of otg mode during
 gadget suspend/resume to avoid deadlock
Thread-Index: AQHawS5mXgmtPyyguEiEAyP9uNoV27HOEasAgAAHPoCAAAY9gIAAA7OAgAAC3QA=
Date: Tue, 18 Jun 2024 23:05:44 +0000
Message-ID: <20240618230540.dcxsud42532sep4h@synopsys.com>
References: <20240618031918.2585799-1-Meng.Li@windriver.com>
 <20240618215356.hw6ar6guxbhlf5y7@synopsys.com>
 <CAOf5uwm82WzuqOHfBHLkursywfA8JNYp8RPPh+8K9DamVtyD=w@mail.gmail.com>
 <20240618224211.peey3dhfa2qvhpef@synopsys.com>
 <CAOf5uw=pmKOgA1ct766Q-F6c4P21bNV-i_acEisxO9gxg0gQDA@mail.gmail.com>
In-Reply-To: 
 <CAOf5uw=pmKOgA1ct766Q-F6c4P21bNV-i_acEisxO9gxg0gQDA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|BY5PR12MB4243:EE_
x-ms-office365-filtering-correlation-id: 623ca701-f367-461e-5f93-08dc8feb2f07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|366013|1800799021|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?U2trTjhzamhqZWdtbVVOY1dQa0FDMk5iMDBnSmRHb1hTeTFhK2txZjZEWUMv?=
 =?utf-8?B?ZjNRNkJaTENzSU42TGwzOS9sY2pWRCs4MHpmbkFQd0NlcFF6Nzc1QXJQYldU?=
 =?utf-8?B?Zy90ZmdBSnQ1UllCcEZCcFBtNFZub2dHQjVsYnB2bHpQbHQ3Q1FnUTljTTFL?=
 =?utf-8?B?N3ExcVRscU5jZDFVbyt3d2o1VzJ4d041R3ZTWVN0dER5aU9OU0F1MnJKS0lL?=
 =?utf-8?B?VmFhZmJCcFNmTHZoa3FHUWlyVDBYSEorSVh5RGRKY1p2UnZCOTdVazJycHg2?=
 =?utf-8?B?RXBYMWtLT1JDVDlMZ0FoeXljNTc3V1d4WjdSYlhuK1JnWFVFMVJxK0NQUjM0?=
 =?utf-8?B?UGNZTTJaSUlLUTRYRmVGZHZ0Y3dya1UxMklDb0RFdGtlTE8wVEFFUU1kTGd5?=
 =?utf-8?B?c3FyOTFTODEra2V3Qkx2Q2dxNUFvbjVQbWgramNkRTNzaDRENEUrYWVRMjNa?=
 =?utf-8?B?TGNjNDhFc2JuMStNamJBOGp2VmhwQWRiZkluZi9XTktYV1BucmlDL3RlRFFr?=
 =?utf-8?B?YU9IWnVwcUxwbEpMMkZZK0tzQ0N4NFQ3d0VKdlVtMXNsaE9OditnaitwMGJv?=
 =?utf-8?B?dTRkVE9RRUVmMTkybnZUeTdEaFZURDhZRFgzZ3Bxd2xGL2dnL3F0WXNkenBY?=
 =?utf-8?B?MFozc1hYZGdkQUlnaFJQczNJRXB2RktMN3VTa1hDelRzUUZlbWhqYWhtKzNY?=
 =?utf-8?B?Z3A1MEJheHY2L2JraTRrWWFZRXpLcjZQQUpJMC81R2pqN3JSZmRlZGFCZzkr?=
 =?utf-8?B?V3VLejhzQ1c4cUtoOGRZdXBmSllydW9Pd290eGE3b1lMSVA1UGtvMHR6QzZU?=
 =?utf-8?B?SmtsSUxVUllxMVdtK3hBY3h3RjltK0poMGIrL2xPRmhZMDBqQnlBcFdLaVBX?=
 =?utf-8?B?b0dhdUZBVEtNWmpKbS8yRGs5blovT1JkOGg2dFFQNXkxWi90SndnSDE5a2tp?=
 =?utf-8?B?aWpreHUzNWUxWUdzMkM3WjRzMXV2bDhKaEpGNFZYQWRLS0JxN2ZoYUNaUkRF?=
 =?utf-8?B?NDJJb1cwN1R4TzB0YWJhMTU2UTBUcGNNUzFFZm45aXNkZzd3R0tWYVdmR2pX?=
 =?utf-8?B?SmxOSUd3U0Q1anE1WkJrR2NYblJsdUFtY3lBN2hVRTRBTzAyMG9VYnhSR2ta?=
 =?utf-8?B?WkIxd2pvYkJhNTIzWlFQNmFJUkV6TEp2d01xV3Rlc2RhTHA1OHZIa3ozZzlL?=
 =?utf-8?B?elZUN2FCSURMc2lqSHZpdmZWWnJpMnZCQXkxTnZZUlFrM3V0QjlYQTNBYlBa?=
 =?utf-8?B?VGNWWk5sLzdBbDk2bE9sUWJuNVpxckpCazVUVnUwUklPYVlBdDdoT01HRmZO?=
 =?utf-8?B?VjlMdHc5eHV4VEwwa2V1Sk5SeVVMd2JxTzNRWERmcEQrN3JDY0tQR0VPRHp1?=
 =?utf-8?B?T1pEWEZLUlB3ZlBPL0lkeVppRWZLRUJ3aWR4a3ZJZjZTRnRXK3htM2VTZUEy?=
 =?utf-8?B?RVhqTmxDOWNHTVFtT2I3WG1PSUxVaVFXODRGZ1BIRGpxdkVhdG9EYVhkQjNp?=
 =?utf-8?B?ZkdlTDZ4ZWt0b080Yzk0eFJwNDV5NEhEdUNMV0hFaFI4TURzWDhOWE9sd2Nh?=
 =?utf-8?B?R2o1SmxzV0NpMVllVjRaZzJINGJPM0hXTnhOajJFQnR4WFBaRUlPSzE2c1ow?=
 =?utf-8?B?RlpFVkpzS1FMTmJIejFRaHlka2dwVEZNcHBqVEwwTDV2SlpOZVp0ZXA2Q2Jn?=
 =?utf-8?B?NG9sVXBLcVFtZ1JkVEFNVTExWEtEdjZsRWx5NWFzTHg4UTVwVTNoWXF3Wm4w?=
 =?utf-8?B?ZVhCYnM4M1VSbG9mMjYvK2dRYWJyTHZvVy9mNWtWeWpOUDd1ekZ4am11bnBS?=
 =?utf-8?Q?TcEV71zn6MJbADO55T1pE3YmIoJqX8ljFrYHU=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UzJZdFdHUjEyZ1N5OVZQdGxjaDFBSDVpZjFEN0RmSVlmSkl1N3RteVp2eE8y?=
 =?utf-8?B?dCsxdDl6U2JJRmFXcHlJQVdxWEp5bXpXek1uWVcwM1FYeWJBdWlaNkJPUjA0?=
 =?utf-8?B?RnYyZGt3STdURFUyY0FKSGpvNTZFdStBbzJQVXpMeWJERk0rZ1VJVnpwN1ZL?=
 =?utf-8?B?b2UvcDNyRzRqdy9udG9XOTZ0VE1CSnFSWk85alJBS25PQjVoMEc3ZWVFYVZs?=
 =?utf-8?B?OGRKalZQbW5kT0oxSmtSSXZSb1RMYzVGcXU1NExFaTFFZjVwdzlnb2UxOEFt?=
 =?utf-8?B?aGFLUHJobjZMRnEra2ZnYWpGSUdLbzVveW9ORUt1cFRZRHBLM21SMGlkM3NZ?=
 =?utf-8?B?OTRtdDBVU3VvdlJmcWtCRHhwbXBmamNScXFiOStnb2k3dDZDU1k3bTdET2xR?=
 =?utf-8?B?N2FjZk5WL25iOHNRYlIydTJjdUpCeXdDaWFmY1VKMjBvb2IxUThlY0ZabEc0?=
 =?utf-8?B?bFZXN0RTN2JqNWdXSEtnV3ArNGhPYWdaM05lQTBPSk5MNzNjN05xSWx5dEtV?=
 =?utf-8?B?UFUvdFY4TmlzS1pDOTg2c3RmdmNEN1h1RXl6a3hMMnlGeWJFaXdHTEw5RUxs?=
 =?utf-8?B?RmRlSFVsVDQyT05SU1ArNi8zM2tKcWg3KytZQ0dDUGJvVlNWU0tNcU1aVjNG?=
 =?utf-8?B?UW9NaDJuclFHWFMzdy83bVRYWmU5R2xFTjY5MkNodXhDalZKN0ROMjFxVlZk?=
 =?utf-8?B?a1YxVHJxbStGYjFKb2JCUk1iUkl0Z0JxS2J4cmVONXZqM3YzcTdOYTFQSUEr?=
 =?utf-8?B?UkJSR1ZDN1MvOXk5V1QxWnVUMUJNcXVIU1NvMlRpNXVhYnAzVllTRi84NVNH?=
 =?utf-8?B?MGorbmpmRUtkQzB5RE1aT2lldzltQmpxR2pYUHVzS3RzakdCMXhlZTh3bWlj?=
 =?utf-8?B?N24wS2NBeFRkNkpuVnpaNDBLNmpsTGhOcTlDOUJzNW5hVU55dXFLcUJCRHhQ?=
 =?utf-8?B?UEtud0MzMzZlNnBhN0JjeFpzM3h0NGx1M2F0VGxmL2VFeWloN25LWXM5WWU0?=
 =?utf-8?B?eExqOGpyRE9CTjJ6TmN3YTYyMzZZd0RYTWRoSUJpeEhjdjFTUXRYMDBhSXht?=
 =?utf-8?B?RkNreTJSV1ZnVUNZSDBFVnBLRVdwSWJTZkNvQU12cUJlWFZCaUZjNFZFS0o2?=
 =?utf-8?B?R0ZpVGt4Z1E0Tk1mNGhIUXpaNmkvNWVxQ0Qvb1B1SmVUMjFYTWR2WDNtRVhs?=
 =?utf-8?B?SnVXZ1B1cmtxMG1rKzRYQlkySTBpUmJwdERxQ0lDbjJoQWRSTHVwejFTZmJv?=
 =?utf-8?B?NVVsamZhWWZ4MGwxcTFEQUJRN0x4dkxCd2JGZ2tlTTJvaWltbFFCZmtoZm03?=
 =?utf-8?B?RFpqRnd0UFo0ZjhPVWhjTjV0SlpxZ3p1WHorUnBMVmVUZkFFSktzeGRycTNF?=
 =?utf-8?B?UVJidE42QVBpWGxIZ05UVlNnamUrZTFEbTh0MGpZU29EbUhLaWdhZUV3V0V2?=
 =?utf-8?B?bkZ1UUduSFlNYmcvNmwwd3ZyOUNrNTRVNU01TU1vU1VNbU5Sdk40U3VacW82?=
 =?utf-8?B?bEpnV2ZQMEZYVzhaZTVESjVnd245L2ZKeXBHTC9HK1ZvUCtjVm5oQ25tdzZV?=
 =?utf-8?B?L0E3L2hrUEF0UytXSmtYMFhvOW9aeDRFRkoycW5ISFRad1Z3cHJKUTFCM3Vp?=
 =?utf-8?B?dmdhb2NqbURXU3dYemt2UzVFZGtwNXNwVUR3ZmFhTjFBWjNidVM3TURzT2Rp?=
 =?utf-8?B?d1N4YmRLTmZNZDJnclZld2puUnpBTitWdUxQbzZZaVRiN0IzNDJOVVFTNFVB?=
 =?utf-8?B?bmJvcHMzcG1hc3RBWkttM25KMy83RE9PNXliSlFkY3JOT2RmRGVpb29Mb01W?=
 =?utf-8?B?K3BsN1NJUmlPTG1rUDhsNVBjVWN6MnQvdzV0Q01TdElFYmQrYVVvOWs2NldM?=
 =?utf-8?B?SE1acWVRUFk5eitkenZHS1E5S29xaFBCK3NOT2pYbzAwenZUVDB3ZksvNGdt?=
 =?utf-8?B?Sit2S1dSNklIenpjU0R3d0laWEpoY1J1QlhVbzVxcnpaQTlUeUwzSmx5QnhG?=
 =?utf-8?B?bnRoVDc1UHdFK3VsRmJHdVdldklacWd0SXZkYldoaWo4VWI3aGRqYlNSVktP?=
 =?utf-8?B?d2FqaW5MQ1Zod2ZnVU9BWXUwQlI4bmR6KzBwKzZDcmF5VFJNQWc3bEFYKzcr?=
 =?utf-8?Q?gVStoSZDJ0soae6k0HSPaWj0w?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F89FA38875BE446B4EEAFEE7191BF84@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/A++LfNLPNNHvuDcDCxwA14S1ew1kkxBNjr1PkBebAIcC/qgav/mbfD45UgDdO22iI9yU/cTIqBMUONgtZoSwUayij971jw3quiLQbK+MMiZ8anga+on3xkvkIC/KoV9peUTd8rK/z05NWsSaeqTyJVbcZDlHU6TpXGc/M3Mioff74hEHkNSVIdz9AI2vPrP3rs8tK0r36AaUgj3aumW+0qOIHGjLV2NfWPyCfKNOvYRkGoG2TH6Y4i4vH26FiVXBqjyNQz+j7l1pj2GQj8Ed1GoS7TxnwiJRmvi3wgh06/Vt133PU9fk5o0Nz4pWBUZHeSb/jyJmfyXx/O21DX9CqdbkczyuOKvIPSZL1WCzRXsT+WjFZPxvsKiLP727/O2k/mhxTbANyWhI49BUPyWtqtFApwcgvXFqRRI4fjCMHIB7fEYGLw2XXVmQGgcZJB7w9MRjcEpaQHB0zsUF2C/KnVeu4oCcmsBq3YG+AUuNDC+74PR8DJus/0Rz+eGk46pZ7YBf1crcfQOX/NSBm+9YchDMtiruTKsLiog3gBxWB/Ac1lUJw8jBqxN3vmJ2eNriHYwspj4Q3AUfyhTgVkuT5xImTPKXZHSiLcCn6JEPEx4g00XBiq4jcm1T2hKXqkdfe7C7jRTjAgiyLBn0dlYeg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 623ca701-f367-461e-5f93-08dc8feb2f07
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 23:05:44.8298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nIkwv9Zn7rQqTYtcH81xss3FRa2saAvFRhr3dYQFQ0hVND8QgKgAXCd9dEGZg5cEVwJkiowxCCg3kwGKgDsO6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4243
X-Proofpoint-ORIG-GUID: q50jbhVNuSdOgt3wl8aDNKBEo_k3Bu2x
X-Proofpoint-GUID: q50jbhVNuSdOgt3wl8aDNKBEo_k3Bu2x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_06,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180170

T24gV2VkLCBKdW4gMTksIDIwMjQsIE1pY2hhZWwgTmF6emFyZW5vIFRyaW1hcmNoaSB3cm90ZToN
Cj4gSGkNCj4gDQo+IE9uIFdlZCwgSnVuIDE5LCAyMDI0IGF0IDEyOjQy4oCvQU0gVGhpbmggTmd1
eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPiB3cm90ZToNCj4gPg0KPiA+IEhpLA0KPiA+
DQo+ID4gT24gV2VkLCBKdW4gMTksIDIwMjQsIE1pY2hhZWwgTmF6emFyZW5vIFRyaW1hcmNoaSB3
cm90ZToNCj4gPiA+IEhpDQo+ID4gPg0KPiA+ID4gT24gVHVlLCBKdW4gMTgsIDIwMjQgYXQgMTE6
NTXigK9QTSBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+IHdyb3RlOg0K
PiA+ID4gPg0KPiA+ID4gPiBPbiBUdWUsIEp1biAxOCwgMjAyNCwgTWVuZyBMaSB3cm90ZToNCj4g
PiA+ID4gPiBXaGVuIGNvbmZpZyBDT05GSUdfVVNCX0RXQzNfRFVBTF9ST0xFIGlzIHNlbGVjdGVk
LCBhbmQgdHJpZ2dlciBzeXN0ZW0NCj4gPiA+ID4gPiB0byBlbnRlciBzdXNwZW5kIHN0YXR1cyB3
aXRoIGJlbG93IGNvbW1hbmQ6DQo+ID4gPiA+ID4gZWNobyBtZW0gPiAvc3lzL3Bvd2VyL3N0YXRl
DQo+ID4gPiA+ID4gVGhlcmUgd2lsbCBiZSBhIGRlYWRsb2NrIGlzc3VlIG9jY3VycmluZy4gRGV0
YWlsZWQgaW52b2tpbmcgcGF0aCBhcw0KPiA+ID4gPiA+IGJlbG93Og0KPiA+ID4gPiA+IGR3YzNf
c3VzcGVuZF9jb21tb24oKQ0KPiA+ID4gPiA+ICAgICBzcGluX2xvY2tfaXJxc2F2ZSgmZHdjLT5s
b2NrLCBmbGFncyk7ICAgICAgICAgICAgICA8LS0gMXN0DQo+ID4gPiA+ID4gICAgIGR3YzNfZ2Fk
Z2V0X3N1c3BlbmQoZHdjKTsNCj4gPiA+ID4gPiAgICAgICAgIGR3YzNfZ2FkZ2V0X3NvZnRfZGlz
Y29ubmVjdChkd2MpOw0KPiA+ID4gPiA+ICAgICAgICAgICAgIHNwaW5fbG9ja19pcnFzYXZlKCZk
d2MtPmxvY2ssIGZsYWdzKTsgICAgICA8LS0gMm5kDQo+ID4gPg0KPiA+ID4NCj4gPiA+IEluIHJl
c3VtZSBwYXRoIHRoZSBzcGlubG9jayB3YXMgdGFrZW4gdG9vIGFuZCBJIHNlZSB0aGF0IHRoZXJl
IGlzIGEgY2FsbA0KPiA+ID4gZHdjM19nYWRnZXRfc29mdF9jb25uZWN0IHRoYXQgY2FsbCB0aGUg
ZHdjM19jb3JlX3NvZnRfcmVzZXQgdGhhdCBjYW4gcG9sbA0KPiA+ID4gdXNpbmcgbXNsZWVwIGZv
ciB0aW1lLiAgSSBkb24ndCBrbm93IGlmIHRoaXMgaXMgYSB2YWxpZCBmaXggYnV0IHNlZW1zDQo+
ID4gPiBkb2VzIG5vdCBmaXgNCj4gPiA+IG9ubHkgY29tbWl0IGM3ZWJkODE0OWVlNQ0KPiA+ID4N
Cj4gPg0KPiA+IE1lbmcgZGlkIHRha2UgdGhlIHJlc3VtZSBwYXRoIGludG8gYWNjb3VudC4gQ2Fu
IHlvdSBjbGFyaWZ5IHdoYXQgeW91DQo+ID4gbWVhbnQgd2l0aCAiZG9lcyBub3QgZml4IG9ubHkg
Y29tbWl0IGM3ZWJkODE0OWVlNSI/DQo+IA0KPiBJIGhhdmUgc2VlbiB0aGF0IGlzIHN1cHBvc2Ug
dG8gZml4IHNvbWV0aGluZyBpbnRyb2R1Y2VkIGJ5IHRoYXQgY29tbWl0DQo+IGJ1dCBJIHRoaW5r
DQo+IHRoYXQgcmVzdW1lIHBhdGggd2FzIGFscmVhZHkgYnJva2VuIGJlZm9yZQ0KPiANCj4gc3Bp
bmxvY2tfaXJxc2F2ZSgpDQo+IGR3YzNfZ2FkZ2V0X3Jlc3VtZSAtPiBkd2MzX2dhZGdldF9zb2Z0
X2Nvbm5lY3QgLT4gZHdjM19jb3JlX3NvZnRfcmVzZXQNCj4gKGNhbiBzbGVlcCkNCj4gDQoNClRo
ZSBjb2RlIHBhdGggZm9yIE9URyBzaG91bGQgbm90IGhpdCB0aGF0IHNsZWVwLiBUaGUgc2xlZXAg
aXMgb25seQ0KYXBwbGljYWJsZSB0byBEV0NfdXNiMzEgYW5kIERXQ191c2IzMi4gVGVjaG5pY2Fs
bHksIGl0IHdhc24ndCBicm9rZW4NCmJlZm9yZS4gQnV0IHdlIHNob3VsZCByZW1vdmUgdGhpcyBz
cGlubG9jayBvbiByZXN1bWUgYXMgaXQgaXMgZG9uZSBoZXJlLg0KDQpCUiwNClRoaW5o

