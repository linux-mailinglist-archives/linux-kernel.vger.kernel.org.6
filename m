Return-Path: <linux-kernel+bounces-277151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA312949D3E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 03:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3703BB2171D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 01:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB02E2207A;
	Wed,  7 Aug 2024 01:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="VcRtuFhu";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="N075jEF7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ax7pmBgx"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD1D848E;
	Wed,  7 Aug 2024 01:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722992910; cv=fail; b=GqeL1kSf6Xk8BJMvm2+/LmOuI2+d1/O19+IQgNhvtAU/ZyRDBxysmEhd6+p/1ZFbrTG4AiwVYjfFx15dLhz/989ynUUtsedLAX/NDbc/Tq43MqtjgMOc3SnkwTle2aJivu10eifxCCJjcDpUXS97wBEFn91mkDk8AJ/jkV0fz2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722992910; c=relaxed/simple;
	bh=sZMgo2z4AUmcKcdYeP5nHgWE88nPD4mx0xtpbQt1qYE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M6TP1Yo0wDcm9wjCxrz96s0i+m+QigSzOw+c4zDoi2frFlwaRg+3lN/FskqqmvJSWqHeNULeJBgdlzAXAGDeCpFw8qg32F43nn0v/eKcBkuJpBVAGUVfPaLtLiTrnQMtY9jhZSahjeXW9HGFL/9Pn3Wb1GqM9D9aYCqE0Z+SJbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=VcRtuFhu; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=N075jEF7; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ax7pmBgx reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476MJhIZ025827;
	Tue, 6 Aug 2024 18:08:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=sZMgo2z4AUmcKcdYeP5nHgWE88nPD4mx0xtpbQt1qYE=; b=
	VcRtuFhuF+zVbHRmmHStp+hg58KMZwLxygn01QlOGYBPm6Z0xgkisHxIIr/hP9Om
	goEIdJOuajPMBL3YsjXcO9J2lpncyukk6pgDUXQl0BUxB2ztci0CsGY8JysaBGy1
	7Cy5VTrrCTKIEUQUQs8wyYeJ+gEBBclscEC/2e6ZJOKeYTAefkI4yvAdTDM/idk+
	E8xg9cL+sTp5RMfNZ313ZTUUTueIS9i8HG76QQsmTuXdhsqdXa2l1bv6VEqlnM3j
	0SlTFs4THg3hz0kspyAuoeEbemDIQrHFhZS4vP6y9wpWrObcM2FfroEY0As7qVZJ
	1V35yG9V7t1eMOr/V+F/6A==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 40uujb8ndt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 18:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1722992890; bh=sZMgo2z4AUmcKcdYeP5nHgWE88nPD4mx0xtpbQt1qYE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=N075jEF7PYEOQfCMcsKMokqSrwiCgrDnxgSBHzao4iuV3grG0XXGMGU/9lsLvBceE
	 msb+BbXftNcJNTNTGdsVVUIxG0IfOPdDlAsHjm7C3Vjc2z8NpQ23hNYgzG2fbVPtmW
	 0DiG+Gt48eJhkkVXlrTC6QVZYaruNLf873IvGHeh3fHVHoxKuCQaeZUsNnLwTNCS1d
	 sjUY9pdJRmUb6RODg4yCMGPMMROOnsuJ961tmstHWoZdQEzaD6yEo4B9VofeNqfjch
	 yj9cRf5LQjpWvZina1l9PwpRIRn1YUAUuwyIEyTG1DYrpHUkgSEdOKSKLRgAZrBejb
	 b2FQ0C6lojnfQ==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5599A40130;
	Wed,  7 Aug 2024 01:08:08 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 1FBFCA007B;
	Wed,  7 Aug 2024 01:08:08 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=ax7pmBgx;
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7536440353;
	Wed,  7 Aug 2024 01:08:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hwB4+Chopfz2B6nVKqZfWz84m5cvfVFs2UxIqCsvN1lWoeoJJwQWEr9beB7UXNEqplZGHLVm92JsZWrpCPY034HIAHdFzsS8zKwL2CrQbJi5LPjfEUZYY7vHtxLJMDyjaSj4SrO7puq/Jxqcgk5N3zoDBcqvTHNJ10jYHfT8qBr46Dh8r9P7SMEB+rcV51IaswcUkChg7Fkft4hhy/bTwqEntjlPpXofRUANyZP3N469y9+3C2ZQegOzlvTWofF4b9BFZHKDCEJG2Jm6qKSxIJUq3KPdLhrzwiPKfmXTFDYlus9tjyT9cq4l+COIigFRprSVAtobGnX3MMvyYopkeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZMgo2z4AUmcKcdYeP5nHgWE88nPD4mx0xtpbQt1qYE=;
 b=xqhwNhMOmnFfX3QCtrdwQXRHALCDXn5tBG9NyA0lYGC7Z5m0gfq9kuOL2K6aKgvscIi1MHlaUzu529BGL8n3QyN6oQkO+4emLNpfFN6XdXXaF/Ig3WNo2QMjfS+Y0QvHkq9VY9zZYD3CvO31FdceU0bexbRhmKa2Hi+01XE4UZrobDkkPHPRmMgwG4g2dT7+ksqIZ3lS4Fwhh+V3RiU637a/OJF2e0VXgKu3VeJYCX4+JRl5shjsOCFMNhxipnRl419tsMx5nxrS/OXor0KYoo16mpjfnhz3xWI7QjC9fYr8wGYOsuM7FFvJ5LxZTgWYQpGuOfrJYpK5zn6WlyBU9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZMgo2z4AUmcKcdYeP5nHgWE88nPD4mx0xtpbQt1qYE=;
 b=ax7pmBgx8Q4a8zNBuFObI9GWKw1V/2ZSjCHFeaTOim+HtqvKxixPqgh0qGpSnFcukDlAQKr2hzMHrC5YQ8HPO/x6Pv99xXHXyvaLBJ+tuashWsVqdyFEL8R9q1E+nwOCni0o+wCAxvR/If5cmpiy/wXMRPMjvlW6UltmbgRz35g=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CYYPR12MB8961.namprd12.prod.outlook.com (2603:10b6:930:bf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 7 Aug
 2024 01:08:00 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 01:08:00 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Frank Li <Frank.Li@nxp.com>
CC: Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "jun.li@nxp.com" <jun.li@nxp.com>
Subject: Re: [PATCH 2/4] usb: dwc3: imx8mp: add 2 software managed quirk
 properties for host mode
Thread-Topic: [PATCH 2/4] usb: dwc3: imx8mp: add 2 software managed quirk
 properties for host mode
Thread-Index: AQHa1HHmhvhYoaW6Ok2/xNUoZJ2yU7IbI5OA
Date: Wed, 7 Aug 2024 01:08:00 +0000
Message-ID: <20240807010755.g4yde7vdgpu3lgsz@synopsys.com>
References: <20240712-dwc-mp-v1-0-295e5c4e3ec9@nxp.com>
 <20240712-dwc-mp-v1-2-295e5c4e3ec9@nxp.com>
In-Reply-To: <20240712-dwc-mp-v1-2-295e5c4e3ec9@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CYYPR12MB8961:EE_
x-ms-office365-filtering-correlation-id: e7a0c748-154e-4295-e372-08dcb67d6191
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZzdDajBvSzZoaXdDUlZGSmdWZ3lUK1dlOENCQ0hZbVJFc1A2VVdGWU1uY3RF?=
 =?utf-8?B?U1lCT3JVeVhYeHZwNW81MkNLNTBVM3Z2WW9XMXRxQXNpNFQ3SlFNb01iN1NZ?=
 =?utf-8?B?MVU5WjZ4MVVvUk5tcDZlc2duSEdERGxIVEFMcFcxMHB2VmdWVlJmTlk4QnM1?=
 =?utf-8?B?cGZXOUwrQUZDTXlwYmpZMFVnQWw2bUlrK1IxOGJCVDJ6Q3dNeUdLR2s2Sytl?=
 =?utf-8?B?SVJ6S3lvMGRFUFZyd2hoWnQ4V0xYYTE1NVljQnh4ME9lbk1mUjZCL0UrbWgv?=
 =?utf-8?B?TUVDTW9xMmlkNW9PM0NlRTdjYVdzcVBvbmQ0WXB1dmlHS21uMVd2QW0xczJB?=
 =?utf-8?B?cGhXcFhCUmVKdHBNTEw5V2JydzdDZjFoNkhZRC85a2FnbGQzcFFWa0RJNEJY?=
 =?utf-8?B?aXk4ZHBYMm12bnZaQWpSbTZTVmNVQk9GMjJiUWZ1aE9hWGxRQmFNUEpPVzh2?=
 =?utf-8?B?RFBPYXNKUDBIa0VzQ1R3b1JrZVUzSHZ5ZlVNb0Ixa3Z2dUFUdGhEaUFLcGZJ?=
 =?utf-8?B?aUZ3ejFwbXVVTkl0RG1BSVQvcHA0Y3hLNUhQUzRSeENlelE3TWp6VFRObDVJ?=
 =?utf-8?B?MkY0NU95ZHdka0hjb2JpRzJSamlhdHZ6ckhPb2NjdUlqdEhtYTdZT1AxRm5Y?=
 =?utf-8?B?Qnc5TVQydDJwNVJFQmdTNGhnUS9ac2daWjgwQmlJMzd3WEtmZkNXVVpMMHIx?=
 =?utf-8?B?MjA4TEVyVDQ1NjRyVTVHTWdRSUVvVU0xbUh5M0ozZlUwRWVxU2hsRjZ5M1VQ?=
 =?utf-8?B?UURvbFpxVHNTQ3RZSUxGNmd2ek1ibjVqU1VxTDF0TVQ4SUZEUmVxVnVCNDIx?=
 =?utf-8?B?VW9DQ0tMc0d5VmNkbEcxVS9tVzRiTWtiTVRmZngwcDl1UGtEUThjN213ckxs?=
 =?utf-8?B?eWJJbTNWY3pZU1E5dHY5K3FDRlp2UHhpU0gzMXBPcytVNE4xWUJYYzhSL0Zp?=
 =?utf-8?B?aG9DU055eER0dlIwYkQ2STdOd3pac2NjNWVqYkhBaXRFbm1rcVU0TmdqRFhY?=
 =?utf-8?B?VUdjRUF4VG00U3ZEMVc4Z1pOY2I1dkR1ZDJuYWV0ZjNFZFlEeUJ5NVRDNEpP?=
 =?utf-8?B?cHA1WnVBdlVVOTF3R0p6anFlWUpMejA4ZVYxaVlqUzJ4TlBOZ1V5UjlsYmx1?=
 =?utf-8?B?Rlk2dnZ6MjRDYWg0NjRadGdGM2ZWeGdmaXFzbS9mZG5BaXZLeVZSMjMxTllE?=
 =?utf-8?B?UW9SU254WVpDaHVqZ3FmWFdiamdtV3ZWeml3L1VnMFBpUlVmVlhaWERkOXF6?=
 =?utf-8?B?NTc3QmtGR011bTBLeU5sb0FDWlF6UytsQXdtclJZeVZRbFVTVWgwZDBSZmNF?=
 =?utf-8?B?cHZZS1NmR0NEQmpzQ2FPNit2ckpEejZlb1pmTE9EekxpeEtBRzFVNEVzcGhB?=
 =?utf-8?B?clBaOGUrdERITzNSTUs1OEVBajdEUnM2SVRGL0R2U0RGT2c2RklybzNYRUoy?=
 =?utf-8?B?cTR0R1A0R1ZxUG4wcGx0UHlvSnExMUhIV1JrWVdoK1RUblF1U3hjMTFQVzBt?=
 =?utf-8?B?RkJ6ZnZvRUFVNWorYkY0REVESWZOYTJ2Mk5haG5oZDcrdGxic2JsNVkxUUp1?=
 =?utf-8?B?bHNBcmQzdDhEc3JBSzJuNVVSTVk0K2t4WDkvZE90UUROSlFjNjU5ZEVzeWlj?=
 =?utf-8?B?Wk9abVptQmJBVXRTTnFjT0wxVUgvWDVsdGlwNDV1cFVnWjFVVFJrSi9PTHkx?=
 =?utf-8?B?bzZDejVRSFQrR2hudlQrWTdKaHYvK3FxR2FBTXFEVXh3eEJSeUtMaXhaMU9P?=
 =?utf-8?B?QlF6MXhyTXBCbnRCNE1TQnZ5bDh5U0ViSjgyT0g5RUQwWVhZajA5QzZ6Qjcx?=
 =?utf-8?B?S2FhZE9iWjBDUEowMW1HMGNOVHpGSlJXYU9vcVhTK0JsT0ZVckpYQ3pLSlp0?=
 =?utf-8?B?dndhV1F2RHIxTGFibHZLWDBXdzY1c0ovZDVtOG5lZ0JhL1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a0t3Q3pVVE9QaThUWDViK29QQS94OHR1YXBOeGZWclliRlpRa0RGVXJacDZh?=
 =?utf-8?B?dUsySEdweUZmVGEzekpMazdqVStSS2tWQkp0UFFVRFRUeWRxTFA2akJQbWFx?=
 =?utf-8?B?WUovYm55Z0I5bjArVmxEMFdqR3ZabG0ranZibEE5Z2FJOXk5dkYxU3VGbGUv?=
 =?utf-8?B?YVRKaFNGenhlWGhlVnBMdHcxRkxjSVgyRHFsVGJVMFB3Q25DWEVxR1Y2VEQv?=
 =?utf-8?B?eHBxemRQOU1OOW1Qc2I3bmdmM3ZDM3VFM29TcDRFQUY5aU91eU9qYnNrNmZ5?=
 =?utf-8?B?TDQvWk9Menl5QktrbXVoTDVJcmE4WFc3Qm1EeE1ZNCsveG10MmJXSTJFR2RG?=
 =?utf-8?B?MDkrekZIMUhTSklZMWk4bWhhbnkzMGNkdWVlZTcxZ09lOWJ6SllCOVZDbkth?=
 =?utf-8?B?andkL0ZZTHFHbUQ2VWlyQzhMMk9LVmxBVTVhRTI0bWltVGRiZldCMlk3eEUz?=
 =?utf-8?B?QXJFRlo1dWJIT29URDJ1WlBxN3ZRSGRPSHBsWVR3T0VEbURyTEZMRldjd2Jm?=
 =?utf-8?B?WU1WY1E2Q3FDYVYyTEYvMzhHOUExdjd6WElQbHpaTTFISE02RENzdGhTMFdQ?=
 =?utf-8?B?ZU9tRG4yMzFZTVFXZmpleGR5eHo4SUYrWU9ReE1oRlIwZ0lSWHJRVHd1TXJj?=
 =?utf-8?B?azErUjBMRVJGTkt6akpHeEdzT2FUNUtOV0FvNzgvNS9wUTJLUEZnaU9JOHRO?=
 =?utf-8?B?T1BCM3ViMHM5Zk9IdENMQ1EwRVk5amcxMFd6d3Q5dmFjT2JtM1lnc21yRXRM?=
 =?utf-8?B?dUZSL1hjYUlPaHFZUEozWDkzQlgvTVM3Z2VjZk5MbW90TmVkamd1MGF1eXZk?=
 =?utf-8?B?NzFDaFd2Y2hNaXBFemZDZmVBaXJGREM2MHE4Q1pES0xlcmlUOXltaEh4bWlu?=
 =?utf-8?B?SGZRTmZGZjg5Q1dzYjcrVThLa01wOVp6YXNWRVVZOXB0WXhNVDJSUmpyMHBJ?=
 =?utf-8?B?VWZCL0wrYVg2ZnpzVmtlM1pxN2JrQUtMeGg4ZGdOV0V4eE15Zks3V0V0cjIx?=
 =?utf-8?B?L0VRYktpTFRzZi8zeHVLRVAxNmp5d1BmYzd5ZXd6Y2l2QmFpdWU0WlIrTHJk?=
 =?utf-8?B?Z2hjSFdvY1NiTmllakJSaTFVTG5TTFF6ei9PSkZPK1A5ODl5NkxDV1FWTHJE?=
 =?utf-8?B?MndrL3FJaGZQcWZid1pMbGl2ajBmSjZMUEJGRlR5ZUI0aVpRNmEwMGh5c0k0?=
 =?utf-8?B?YUJPUkZZeVl1WFVWTFhoZHJ4UHhvbkFXZUdOOU5OMDA2c0tpVXkrUmU2MEFp?=
 =?utf-8?B?OVZrM1k0V3lsSy9aNVBEbERUZytzZVpmTzhHMFoybWpwVGtrUmNDZHFxajF5?=
 =?utf-8?B?RGMxeXRLY1ZIb25aTTkxcy83OUptR1RKeE1uTWk5Q0RXOThPZ3dzTjRGV3ZU?=
 =?utf-8?B?VEtBcWs4aTFoY0JvcnpJUnBaQlF5clBscWVWcU9VL1lBWE54azh5V0R0Y3RZ?=
 =?utf-8?B?TkdxMjhNanlkcGhWeDJwblZ2VVVkV3JGM2hyUUVPR0FaeGRLLzNEemF5UlJ4?=
 =?utf-8?B?Mm5hQ0VRb3N4YTFpTitxSEFqcjJXRzFKOUk5QUxvUHpCeFc5K05kTm1oUjBi?=
 =?utf-8?B?RzhoSXoyeDN5aGI3V1J3N3FQemdUU1E3K1V5U0JtcUtac0JzWHI4RG9tUFNw?=
 =?utf-8?B?Rlg4ak9zYzJGbks0SGZCemRRVmhzMzV4cW9DdmJSTkJwdWlMVmo0aHZqV282?=
 =?utf-8?B?d0tINTlNU3lEamhFZnNYUURZM1JRZEE2djJnRUczS2lVZnF3VVZoNkY2cjVt?=
 =?utf-8?B?UXcwWnlCMVNKZFYvRHVBMkdWNW1va2V3eE1qWlBkTnlScy9saEtjZVZjOG8w?=
 =?utf-8?B?clk0ZThidmQ2ZGc3eHFoYlZrcmd4TFQ1bm4wVmhiazJlODBTWHE0NUpvSFlt?=
 =?utf-8?B?OXdjRk51aWdSYkdNdmVZOEl5R0d6NEJWUUl6bmJmVjNaK3MvTlZ0ZFZsWkov?=
 =?utf-8?B?Q2tXNWRIM2lleEk3MnIyNi9QajlzZVJYR25lU0R3aHJ0QlhzL0p0dUprQzB0?=
 =?utf-8?B?SytGSW81Z0k0R3dmbytaS0p4OEZuMGcwVysxZk5yZXZ6RTV6dHpYd2dYajI0?=
 =?utf-8?B?OTgvNzczRXVJTzR3UWVEQ3RNb0JqbmhtMFl0Z2J0eXlsMkw1bWgrY2JaVGUv?=
 =?utf-8?Q?IR/hVfuDt4OZBg/cu9MkkdILg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5ECA44A9FE84F045A493E2C875684412@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hZC8bcED2HcF0YLnWWw2L1F+WMntBwlzJ2OxIAvz44FsomrPNm/fON42ekrN+X/orliBa/Cy3Wc53cwevAcndcvpADOoPAaOLrY1SZ1Iufn/z2O/bj/NQ4BcBXSYV2zaBH1hQffFVcybYGRa0n/gADhEN4a2FpQ6VmmpCcEHBtlL96l/R73T3Rs7t4kVwEV1VrV8giGE0HeTAARZmtJjf2StqZqC+A0Hi5CLrhizM9vahbcvpKtylWA9pm/i0Q3kVCoYUiTVAUDyIfTumweJuP3xnk1BiJWVokdwHoJ0OxOly4Kk11t+Jusu30lLQV/xhK5zyv3IwyNFukMdZxv1nCg1WBDpDcRvjRWjuN3sOKIr95C6tctyQpd1dMIIgnm1v19dmdE+IlnenwZoCMFODKFEzBSQYijd0ouxBbsuSIhErkXeo6czX92a4sjkq2l0ig5VitWR0r0e2cHnEIu76k6k+OXoyDOx4p5Pw5kqltCFzqeCswh73urjzUpOdxVV+o5jQtkOL3PKEp5TRBgAKwV2GSTibIkW7KevsI65z/K8b+EMLTbxaUP5I7x5UADx1e45IWTOG6/bB2S9tzynOD8pZLTu6toOXxOP4zM1+M5KHXj+GD/UI5jrQFlJX8cQZE8G56l1Lj0WVE4cafQmaA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a0c748-154e-4295-e372-08dcb67d6191
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2024 01:08:00.3604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b4xycubd4nelIFYjQ0eDoH2YH9OPh7SD9AlB16Bl0oG1nBPdTD64MrD1a5EzPbMWf63TbNSwDxXPNxmb61CkOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8961
X-Proofpoint-GUID: SsK714hXs04uzFSQukYZYGpvCj-n2clO
X-Proofpoint-ORIG-GUID: SsK714hXs04uzFSQukYZYGpvCj-n2clO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_20,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1011 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 impostorscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408070006

T24gRnJpLCBKdWwgMTIsIDIwMjQsIEZyYW5rIExpIHdyb3RlOg0KPiBBZGQgMiBzb2Z0d2FyZSBt
YW5hZ2UgcXVpcmsgcHJvcGVyaXRlcyAoeGhjaS1taXNzaW5nLWNhcy1xdWlyayBhbmQNCj4geGhj
aS1za2lwLXBoeS1pbml0LXF1aXJrKSBmb3IgeGhjaSBob3N0Lg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogRnJhbmsgTGkgPEZyYW5rLkxpQG54cC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdj
My9kd2MzLWlteDhtcC5jIHwgMTggKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMTggaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMv
ZHdjMy1pbXg4bXAuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1pbXg4bXAuYw0KPiBpbmRleCA4
ZWU0NDgwNjg1MDMxLi41Nzk0YmI3NWY3NjA0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9k
d2MzL2R3YzMtaW14OG1wLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9kd2MzLWlteDhtcC5j
DQo+IEBAIC0xNDQsNiArMTQ0LDE3IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBkd2MzX2lteDhtcF9p
bnRlcnJ1cHQoaW50IGlycSwgdm9pZCAqX2R3YzNfaW14KQ0KPiAgCXJldHVybiBJUlFfSEFORExF
RDsNCj4gIH0NCj4gIA0KPiArc3RhdGljIGludCBkd2MzX2lteDhtcF9zZXRfc29mdHdhcmVfbm9k
ZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICt7DQo+ICsJc3RydWN0IHByb3BlcnR5X2VudHJ5IHBy
b3BzWzNdID0ge307DQoNClRvIGJlIHNhZmUsIHVzZSBwcm9wc1szXSA9IHsgMCB9IGluaXRpYWxp
emF0aW9uIHNlbWF0aWMgc28gdG8ga2VlcA0KY29tcGF0aWJpbGl0eS4NCg0KPiArCWludCBwcm9w
X2lkeCA9IDA7DQo+ICsaDQo+ICsJcHJvcHNbcHJvcF9pZHgrK10gPSBQUk9QRVJUWV9FTlRSWV9C
T09MKCJ4aGNpLW1pc3NpbmctY2FzLXF1aXJrIik7DQo+ICsJcHJvcHNbcHJvcF9pZHgrK10gPSBQ
Uk9QRVJUWV9FTlRSWV9CT09MKCJ4aGNpLXNraXAtcGh5LWluaXQtcXVpcmsiKTsNCj4gKw0KPiAr
CXJldHVybiBkZXZpY2VfY3JlYXRlX21hbmFnZWRfc29mdHdhcmVfbm9kZShkZXYsIHByb3BzLCBO
VUxMKTsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGludCBkd2MzX2lteDhtcF9wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgew0KPiAgCXN0cnVjdCBkZXZpY2UJCSpkZXYgPSAm
cGRldi0+ZGV2Ow0KPiBAQCAtMjI2LDYgKzIzNywxMyBAQCBzdGF0aWMgaW50IGR3YzNfaW14OG1w
X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJCWdvdG8gZGlzYWJsZV9y
cG07DQo+ICAJfQ0KPiAgDQo+ICsJZXJyID0gZHdjM19pbXg4bXBfc2V0X3NvZnR3YXJlX25vZGUo
ZGV2KTsNCj4gKwlpZiAoZXJyKSB7DQo+ICsJCWVyciA9IC1FTk9ERVY7DQo+ICsJCWRldl9lcnIo
ZGV2LCAiZmFpbGVkIHRvIGNyZWF0ZSBzb2Z0d2FyZSBub2RlXG4iKTsNCj4gKwkJZ290byBkaXNh
YmxlX3JwbTsNCj4gKwl9DQo+ICsNCj4gIAllcnIgPSBvZl9wbGF0Zm9ybV9wb3B1bGF0ZShub2Rl
LCBOVUxMLCBOVUxMLCBkZXYpOw0KPiAgCWlmIChlcnIpIHsNCj4gIAkJZGV2X2VycigmcGRldi0+
ZGV2LCAiZmFpbGVkIHRvIGNyZWF0ZSBkd2MzIGNvcmVcbiIpOw0KPiANCj4gLS0gDQo+IDIuMzQu
MQ0KPiANCg0KVGhlIHJlc3QgbG9va3MgZmluZSB0byBtZS4NCg0KQlIsDQpUaGluaA==

