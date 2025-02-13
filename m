Return-Path: <linux-kernel+bounces-512137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 339D0A334A4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC3A83A6B06
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C021142E77;
	Thu, 13 Feb 2025 01:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="vKCpxWyk";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="EUxwXqBa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Vbk92FQV"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925C98634C;
	Thu, 13 Feb 2025 01:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739410040; cv=fail; b=gVonDCu2KwcrOivudsQjxPsVALav/gBA8rHla2M7et3VSuyGLyKCQiqUWr5ASBV9JwJWs22Emja9pBjgQGTIPDO7DMBCHXMD/5NHbCiN8HNsygn8CCFpxu/NUENZZUbx0Iko3Sh0UY/zb5uKSY8oV6GiHLwg0m9DjAOb6PWu+dQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739410040; c=relaxed/simple;
	bh=92QPlIo3sNSljtYOZP80210/Ttt2K6VeHjQQ2tskiME=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S2rQVsXuH05S9YFJ9aZocABa+PZB6/MUpkH6qosw1RhvPK+XHBcvN2huPovMMzf2aygNJX4L5d1Nrh40EQsQmWDAM4L16gbx6KGAnEYTNbNZvwKrLTlqi2wEGX8q+KNMfKb+dHxGXh3MY1kHCnhgzJac1wC1QoZVXo1DUYQ6P2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=vKCpxWyk; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=EUxwXqBa; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Vbk92FQV reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CLWo0R032572;
	Wed, 12 Feb 2025 17:27:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=92QPlIo3sNSljtYOZP80210/Ttt2K6VeHjQQ2tskiME=; b=
	vKCpxWykcU24wdmJrm6aqmAUHzs2m4IHZVzSYHDwGwDMSSR/FncDnHa0h+QgMdy3
	5kRKUaxIuA0tEdn8gMRw27QMvsb4AWOXcfNwx5UvKucEmr2uiouzv+dOrJ3seFho
	m7oQzcHj7tAQBL+2KClGt/euja6p6SBhmDRZ8bCDoKluzHyZwxlawpFa32ZYuViN
	xsbRWrhGVp10yK0M1i+Coen7bDIR8CApLvM6XEEGL3BewM2OQMS5GuHwRE+zL/6R
	bSd+R5HfzrfuK60JPbP36mFxZueWPLES5hmp7QXdSzd+WLynJOa97/U081DYbBaj
	7czJO3M6KLQGPmG2YBDkJQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 44p75tg5g3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 17:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1739410031; bh=92QPlIo3sNSljtYOZP80210/Ttt2K6VeHjQQ2tskiME=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=EUxwXqBawpCIhnC67Zb/2xXX5k/FwwCIKZONBYmptqOYHLephtyUHsUXVV7fQF6HJ
	 V4e7WHNB+J98rUj6r6OdARUOlR50qeTIgPdESoUI0AmncrwR2ib6aWhKTOjK7YOtlh
	 Ab7XN/k6de0sgDocHwpNIFX9D8gJEg3BsjWhFrtREI6JXHDgJWxQpk4INA4EwPFJj4
	 M/Ehbhiwb2RGYz4fl1IUvkRyQq8iQG/VmHRk/ejZrIzm+sz0jwoJxLL/Q9GWzonaao
	 14XYMtupbebXHBHKcyvRMO4T3H/7OJ2OxUqCdvahz/nEqoqWFGEJBcm3A5pqZj6J0b
	 o7WEv3vpU84cw==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B3F9D40237;
	Thu, 13 Feb 2025 01:27:11 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 211CFA0069;
	Thu, 13 Feb 2025 01:27:11 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Vbk92FQV;
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id D948F40541;
	Thu, 13 Feb 2025 01:27:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHTSAbnS43XLEFlmCm+55wmDQvFO9S13VGSNx5MCApWSJkHgMetTnJqVzDgXtjCFgiUIDCpYy1IxRP8KCIBmXdIDfRNfxBF8NUtbM9vRUkDngAf8+BIJJJKbBfPq9hTIyFuigi6FTCdLMK/bmyOFJvY5Up8FVjqI3LUpd+eYlGD03HL7DrxSjCyxQ4QQqIsqyqfINhAgXbtds3Wr82pgt81jqAPiXmWeRDNQ1yKFn4LrE2lll9UG7sTlYG/fkpi0aChGBPSI0rxqyFwiNgMW7jhugFdgHrKTq3XjQt8wZjHTJVLFrDXXOJ+e4gUHTHiLFq1E5B/KmRSm/0uih+3Fhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92QPlIo3sNSljtYOZP80210/Ttt2K6VeHjQQ2tskiME=;
 b=kfphV7U58Zmwe8IbqTNwVuK0YGYek0du2bNLk9/wMIP7zmtF3k0x8oHwU7zXcLVjZO3Pdj1tVun3YFybDcrexx0eAEU06WVvKbF+2cyZhM3dJxcmeVDjWK1foiwlMmpAQ0Fi5lMBaDGnURBOGQjQGY3igHLduSukUGrPTIUuqQE7zxjMhOggbhEqJ5MOcOo2Pw6R7jRpesYuEHpBzvZ4GGTEDJGqJX65HTFNDWYGYYTqh9h3N/VOskXT9yF7C12fEqU/3jKSHHl9Fs8kIKJZnCWyLRi8957nqGixVe3WDHt/Swv8dcwYHultGJPcWI2WpWpMv6/8MhOd2owqOKgGbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92QPlIo3sNSljtYOZP80210/Ttt2K6VeHjQQ2tskiME=;
 b=Vbk92FQV1/2iprfI/9Wha+MQZV9FWic+izFbKC5JtPmHF3YWSxdDcTvJTNEiU1C4buYb/t/vHahhNbfZ2kN4QQuU9N5AsP0Y1N9cLAWTZa2CtDPMHVQ7rKdlqNtF3vei7dLpOgEUoyLdzCiJjr8RgQ/9LZeXDS3wkDVWacT6iRM=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 01:27:06 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 01:27:06 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ferry Toth <fntoth@gmail.com>
Subject: Re: [PATCH v3 3/4] usb: dwc3: gadget: Add support for
 snps,reserved-endpoints property
Thread-Topic: [PATCH v3 3/4] usb: dwc3: gadget: Add support for
 snps,reserved-endpoints property
Thread-Index: AQHbfYS3asRj4Swb2EippAwWnCvrZbNEcboA
Date: Thu, 13 Feb 2025 01:27:06 +0000
Message-ID: <20250213012702.mlxsm2y5rslttzgj@synopsys.com>
References: <20250212193116.2487289-1-andriy.shevchenko@linux.intel.com>
 <20250212193116.2487289-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250212193116.2487289-4-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SN7PR12MB8770:EE_
x-ms-office365-filtering-correlation-id: db3269e3-e1a6-4dac-f1c4-08dd4bcd874c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZlArSU1uVFBkbndhd0hZdHNxWmZiS2U4Y0dURnZjbXQ0U0ErYlZ1cmhFQzhv?=
 =?utf-8?B?eFR5OFl1NWtQaHd3SWwzU0FiYmJ6SzZsUE1QMlI5d052UHEwQm9SK2VUYkcx?=
 =?utf-8?B?RzZrd0U0U3AyR2doNUpaZVlybEVTVHpXdEt1NlBXUGt3L0MxSytJczZMMW45?=
 =?utf-8?B?VTBnZFFBTHhLSlhLb3BXaGxNV0xvMit0alJOeC9yalI4YkJ2OXEvbTRRaHpa?=
 =?utf-8?B?N1dYdU0wR0RCcVJqMWY4bWFIWXg5RG5IeFFzVFo5enViSFB3WVFpRGlqYmNT?=
 =?utf-8?B?bnFOaDhGR3pmSVN4UTNKeTVzblJNaGNJeGtwUnpIZHgyM3YzQk45OTFWVTRo?=
 =?utf-8?B?dlpDTlJlMVZBUTZyUUIzODA4Z29yMTFVdXFaV2d1Z29BR0ZuZjBuWXE5cUhH?=
 =?utf-8?B?QXM5RVhlKzFWck5zaXp6QnpwS1N2Y2VXYUI5VlZCcmdCMzVhY1ROQk81N29p?=
 =?utf-8?B?RWlTZjZDWnRzcVdBVVRMSDExOXg5NE5seWxQaXZ4SlpQOFAxSDhHUXdnNS9H?=
 =?utf-8?B?RTh3aEp3Ymc1eVBNTWRmY3VIR0V0SjBpQ0FVQ1FqeWNlZGxIN01Na29CM3pB?=
 =?utf-8?B?U1VPc3ljd0NidjMyZGtQczNQYlE2UVZRcG82VDRkTjZDdlpvM0FyOU4yU1pB?=
 =?utf-8?B?SUxoUFhCMFVwblFYQ2FLVXZKS3lydm54OUZwbHZDTnBra0xoaFo5d0NUMEpN?=
 =?utf-8?B?UVVtNXZOelBlNk5ybWo5RXRVSlp2cVgrTHlxcDFiUlpXLzM2UzY4aUFkM1RN?=
 =?utf-8?B?SERwMEtVMkNGOTY4TnJKMC9XelMwVDNQYXFLejU3K2t3ODZqR3lmTk9aK0Fn?=
 =?utf-8?B?ZE1VSkZCSS9hNXNRYVR5MTR1Qkl6UUJyb2o0d0RkQ3JadzJMUUNSbmZnWUxP?=
 =?utf-8?B?RVJ3bGRtYTc0T1crdnJkeHg3OFlFZkVCUVhUUzBUU3V6S3JtRElyeElTR2VW?=
 =?utf-8?B?OTdMaWsvc3g1MUw0UDg5amJjbyt5S05ZYXg3YXhkSnJ0ZTNhRW8vYnByc0Jl?=
 =?utf-8?B?VDZKTk0ybGZGSGF0VGpSVXlnTm1IVlZ4SjVwL2syenptZElxV05qdjhYam5C?=
 =?utf-8?B?RURLU1NReURydk91bUdUQWY4anFSM0M4c1RzQmZyTm9uVmpIZm1UVGpvdVhH?=
 =?utf-8?B?UDdCOGpxVXd3R2RIV3cxYUFmNG9BN3JpK1VwbnRNR0FucUpFc0ZBVDh2cU5x?=
 =?utf-8?B?SzRObzFqSXNNTXVOV0M5TTBhcUhyZXZUVFpyRWgvVDFjdmxUaytUdnZiMGxz?=
 =?utf-8?B?UG5NWWVuN29JdWtITndwM3pYT2JUa0xBRVViRHNFK2RtenJnS1ZBQXBWZlZj?=
 =?utf-8?B?MzV2M0lEYXdsTk5xckphU1pNYjBMaEtqVW5CSXlIZVpRb3k2eDVlT1QxVGVX?=
 =?utf-8?B?R0tJSTdwQ1FPWVFGRXJ1NGROYjJRQ0dsckM5bkdmUkxJWUV4d3NSZzlsdWNU?=
 =?utf-8?B?Mnh0TzdjTlhFazZkdmV5SVBlb2M5SjQwTnpIUDVZd0ZYLzFjTTJicWZ5QUg3?=
 =?utf-8?B?Qk9FR2lMN2RqbXZibnpWNml5OVJkcnNxNVI5WGF1WExVbGVROVJCQkhCdjVv?=
 =?utf-8?B?WVhJdlNCTitNMHE5QlVYVEY1cFFhMFdSbjBUdkpPWUJPR01WeWZCSWwxUTRR?=
 =?utf-8?B?S0daSGFBMmxlbFZkMjRYaEpjYk9OcjcxVUdDVVB4TjhrNFlzTis0NW5tL29T?=
 =?utf-8?B?WUJnZ2VLZG8zRld4dnpmdGIybG9kL21lZU4xcDVwMWtTNWtOdStCT2svMG5E?=
 =?utf-8?B?Z0JTa1IzQVFGTHRmVDdhMnFhRy9jQzNyUWROWXJ0cmR3MStCdmdTRm1tYWlp?=
 =?utf-8?B?d2NZbE9zcnF1TEluNVlzeXQwOGUvSUlNbk1ZL3J0RHBYbnVmTlIvSDdtUDE1?=
 =?utf-8?B?VjB1YitiUm9NazYvYndYNUhNRG9uaTNEeis0OFZsdW9qcjF5T3JHcU1kVW5D?=
 =?utf-8?Q?CjJEP/XcqS4ogvlsLHbfiQyA1/NdvAmN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eWlaNnU0STZnZ0psdHZieVZMNXlLTHY4V3FGZ3pKSWpNOTZYeHhpNGF0ajJK?=
 =?utf-8?B?WFIySUxHV1ZXQjVTcWY1czYybG0xLzE2aDFEaXdxQTdoeWdzbU9xbk9PZXdV?=
 =?utf-8?B?WTlrdTNvNnQwdjQvVnpVTXQyUUxSdTdJSmZnOUpjSVNjWjkyejVsaVd3bTV3?=
 =?utf-8?B?dTN6WWkwUlZLZ2wraS9Qb2c1UFQ0dHB5ZXhENDRiSnFzbzR6Smc2dUNkdTB5?=
 =?utf-8?B?WVBZY3VIU2lSQWp2Vy9PRVdEazBEakx4b3kyYnNtRUcrdloybERIS3hqTTRY?=
 =?utf-8?B?WmlMc2dYUHJHNDB3TzR1R3R4blY4ejQrY25tamtuK0h3dk1hdXJ0NndDZXdz?=
 =?utf-8?B?Mlp5YWVESTNZRVM0bUJVOU94Ui9hUHR1N1VGZGZZWE5CNWxNVkxKUFo4U051?=
 =?utf-8?B?eU02V0YxM2VpQzI1TUc4T21TWm0yTEJnTFJ2K29rS29vRU40ZkthaWpCZnht?=
 =?utf-8?B?d0xlYzRZdXlZcEZreDJxTmdiWDZRY1NSaG5lY1VIYVlXQk1UQmw3WjNsVVV2?=
 =?utf-8?B?U1RhS0JLS0hVRTl3K1ZrT1Bpa1VTeitnc3ZMWVZKY0twMVMzV2FCR3QyTE03?=
 =?utf-8?B?SFpKMmJmRUhWS0FyVWNoeDJXcUp6K3Y2SXpVcUxVbW1GR0FKTE04ejBBRERJ?=
 =?utf-8?B?azF1dVFtcUllUmMzU3d6WFNaZXNSYTg5QkVPVzRqQmRNdnlsdHNDNWpoRkZh?=
 =?utf-8?B?UGQvT0syS2FIbk5FK1I3TXQwS0xQRGZ6QkF5RVJia3g0Zm9KdXpmSWd5bXdT?=
 =?utf-8?B?VHFkYngyWmtySFF2K0FZTDZnZDB3UzcvaVlIbnMxRnJxS2hTV1NYVjRhVksw?=
 =?utf-8?B?b0R5M25WNTRZUXV1RWZtQjdFTVFwV0pDa3BSaE8rVmU2YjlTNDR3TTVHRjl1?=
 =?utf-8?B?WGZaaWUrYWVSd0FHK0tJVW94UkZXMlFlR0lxaWlmZnM4eDVWOEFmVkgxWDJX?=
 =?utf-8?B?MmpLandjc2NBWlFTanVDYjU1RC93MkdaK0VpUGpGei9rSHBNMEc3SXJUTEsv?=
 =?utf-8?B?TnVPeDdaakpCRFZsa21lNzhPNW9JNXU1RktSWjAyaHlRMnp0L2dDemUyMGpI?=
 =?utf-8?B?VVNiUitUQ3Nqa0thMkFKY21ZU0liZm1sVmhMa3hNK1JkOGxDSGVxMG9Yd1Bz?=
 =?utf-8?B?Rml6M3UycGU1TUNhR1VXYmVCQm9RZGFOeTc4aEN3ZUVrZTRqNFgxNzhIY09y?=
 =?utf-8?B?TVJnbHVzakpvUzFXT2tZL2ZrRWJsQW1pdEUxNThKVkNUUW84YitLc3BSWnQw?=
 =?utf-8?B?WlV2L25NWnJjWVBZR1drU3VlTVJXWi9LV0tZNFFUWjRLSzV1alhYcUxtbGNv?=
 =?utf-8?B?QkRES2xrQ3ZaUFNvaVNmcWs5UnUwdXcxMlI0UDZTK2MzdW1FY2hkTXc0T1U1?=
 =?utf-8?B?a3B3NVMzR0ovZW9tUktYNzRuTjZqL0lDbGN3blJJVzArNnA1S2l3YzN6TkpE?=
 =?utf-8?B?SnloOGVjOXY0WUtycUdia0M0S0JSOExqRGJRUnp3MFNJTWdtZENsSlFOTGJ6?=
 =?utf-8?B?YjJXeTlDYVhSZXk1VGYwK2I2MjViN3FqRStMZnpQbC9OQ1JHRnR2eFVBMlBO?=
 =?utf-8?B?L3JnVXRNK1Y3RXpyT1NMU3oxZlJ1ZzlUS3RFRWNkdGFHY3I3M3kzYTJqQWg4?=
 =?utf-8?B?QkJ5cFhCaUVSWUptQzllNjVmZHMxSGpOL0w4R0VlNEJuVlpWNWpLNVQxL1Fw?=
 =?utf-8?B?b2h3eDFkYk5mZlFndElpTjhSWlBraHVsM1J3NjRBQ2crVjNPcU9tTFBBYnVl?=
 =?utf-8?B?a0kzNnY3VVRieTZXQklkcDBJajIzL3FGSjBmVWx0Tm1wWlcwRktKZjJyRCt2?=
 =?utf-8?B?dW9ZZXFMSXZmaUM5eG5UMDBxL1lLRkZVTHo5cnNkWkYrTGoyK2FaZzRYeTll?=
 =?utf-8?B?Rk9qdFMvaHlUZk9KUVppTnpFdVN0NVJrZ3dvb0NlZzg1MzQrdG5LQXRWWnF1?=
 =?utf-8?B?bjlHTDZKT0dBaTFod2lGaVU4ZVR3Z3RoUjJ0dU5BdUVOUHhOVmJ0YUhDSmlM?=
 =?utf-8?B?OXdXT2s5TDRpTlFnWTVxNkNRekxySGE2RVcrck9BOVhtL3I2akM1dkQ0ZzZ2?=
 =?utf-8?B?UFR4dE1TLzdwblcwMzdXNER3VjRjZ1VxYm4rQmN6ZXJaV2FOUTkva1ZMTGFq?=
 =?utf-8?Q?qJsHC4HKdW7Y0s5cSc0I8wCbJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C16452D1DA2D75479E1C39701316BCB2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rHJXbDFoT2hPOZeHb1of7+vs5WnvrIc0qEzkNOBYmVu5TgcZMiYF1a4iMZBh4jZDkYXo3BKnHE4pmL5Q8fK63sZ2QPHOeIIJartFgR38JrQQ3ZmjyXlRBKG4RYyhiTZhBIbKdIFGmh7hDQ9pF1ExN5VnjUcZKn8W2nkrjshCQjV3SSh/WD9+z+hTW+ulZFFACVEldakrKvSxulCnidKruO4vMUHcIyA7iIYFL8W0tfSe9+/ACbOguQa5maQZKOP35G7JRITUkJCGyTU0iK6ZBLgN41DfHqPhZXCg7zChlKx+tHyxRgO9mmGB3VUNPFYEP7/HOY/px19dcAFjqNEN3EU5XO/nSA+DNkU03uwsypUBVszJmpIjPPbxzh+eOhO7w0WWsGRgijlDVsH9jQb3P2mmKt31Ra8ZX9aZGT0YO6gqWruOFuGC5zCxNoK8zwNrE9Jh6ysLl9x4li6BqOE6Zq2tZqVNslCksYILErm06zFEs/UxBoRY6Ov04SFIVAOpSSVmYebGydKLM7KdqaAD/NnIXEn7fEJdp54DMpaWcbQevrU3EtmKJ9sAXIqOBIFNep8dDiY8PQOIZc30Xk+3PZFRLxUDYVrKhybtt9wDH30yf0XvJd/NPpYXq3Yd7RoWPjpTGL/SIBpHWyekEXVcZg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db3269e3-e1a6-4dac-f1c4-08dd4bcd874c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 01:27:06.6458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: geV2CYT38+1YHjli7vrV0ChTu2yplolzGrbyJD5DTfxrWI84LlSAu/FA58EVpMx3QBUVfdZaq9hq6i79tIHXDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8770
X-Proofpoint-ORIG-GUID: vAPEE9Wsrkxxx2C7RmX0s5xsxrUJt0EM
X-Authority-Analysis: v=2.4 cv=NJEv+16g c=1 sm=1 tr=0 ts=67ad4a70 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=T2h4t0Lz3GQA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8 a=jIQo8A4GAAAA:8 a=LIkEmVQZ17z3_bpPndEA:9 a=QEXdDO2ut3YA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-GUID: vAPEE9Wsrkxxx2C7RmX0s5xsxrUJt0EM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_08,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=995
 priorityscore=1501 mlxscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502130007

T24gV2VkLCBGZWIgMTIsIDIwMjUsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4gVGhlIHNucHMs
cmVzZXJ2ZWQtZW5kcG9pbnRzIHByb3BlcnR5IGxpc3RzIHRoZSByZXNlcnZlZCBlbmRwb2ludHMN
Cj4gdGhhdCBzaG91bGRuJ3QgYmUgdXNlZCBmb3Igbm9ybWFsIHRyYW5zZmVycy4gQWRkIHN1cHBv
cnQgZm9yIHRoYXQNCj4gdG8gdGhlIGRyaXZlci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuZHkg
U2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPg0KPiBUZXN0ZWQt
Ynk6IEZlcnJ5IFRvdGggPGZudG90aEBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2Iv
ZHdjMy9nYWRnZXQuYyB8IDQxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQwIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2Iv
ZHdjMy9nYWRnZXQuYw0KPiBpbmRleCA3M2NlYmI3ZDkwYzIuLmYzYWQ4NDM0MzY2ZSAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9k
d2MzL2dhZGdldC5jDQo+IEBAIC0zNDAzLDE0ICszNDAzLDUzIEBAIHN0YXRpYyBpbnQgZHdjM19n
YWRnZXRfaW5pdF9lbmRwb2ludChzdHJ1Y3QgZHdjMyAqZHdjLCB1OCBlcG51bSkNCj4gIAlyZXR1
cm4gMDsNCj4gIH0NCj4gIA0KPiArc3RhdGljIGludCBkd2MzX2dhZGdldF9nZXRfcmVzZXJ2ZWRf
ZW5kcG9pbnRzKHN0cnVjdCBkd2MzICpkd2MsIGNvbnN0IGNoYXIgKnByb3BuYW1lLA0KPiArCQkJ
CQkgICAgICB1OCAqZXBzLCB1OCBudW0pDQo+ICt7DQo+ICsJdTggY291bnQ7DQo+ICsJaW50IHJl
dDsNCj4gKw0KPiArCWlmICghZGV2aWNlX3Byb3BlcnR5X3ByZXNlbnQoZHdjLT5kZXYsIHByb3Bu
YW1lKSkNCj4gKwkJcmV0dXJuIDA7DQo+ICsNCj4gKwlyZXQgPSBkZXZpY2VfcHJvcGVydHlfY291
bnRfdTgoZHdjLT5kZXYsIHByb3BuYW1lKTsNCj4gKwlpZiAocmV0IDwgMCkNCj4gKwkJcmV0dXJu
IHJldDsNCj4gKwljb3VudCA9IHJldDsNCj4gKw0KPiArCXJldCA9IGRldmljZV9wcm9wZXJ0eV9y
ZWFkX3U4X2FycmF5KGR3Yy0+ZGV2LCBwcm9wbmFtZSwgZXBzLCBtaW4obnVtLCBjb3VudCkpOw0K
PiArCWlmIChyZXQpDQo+ICsJCXJldHVybiByZXQ7DQo+ICsNCj4gKwlyZXR1cm4gY291bnQ7DQo+
ICt9DQo+ICsNCj4gIHN0YXRpYyBpbnQgZHdjM19nYWRnZXRfaW5pdF9lbmRwb2ludHMoc3RydWN0
IGR3YzMgKmR3YywgdTggdG90YWwpDQo+ICB7DQo+ICsJY29uc3QgY2hhcgkJCSpwcm9wbmFtZSA9
ICJzbnBzLHJlc2VydmVkLWVuZHBvaW50cyI7DQo+ICAJdTgJCQkJZXBudW07DQo+ICsJdTgJCQkJ
cmVzZXJ2ZWRfZXBzW0RXQzNfRU5EUE9JTlRTX05VTV07DQo+ICsJdTgJCQkJY291bnQ7DQo+ICsJ
dTgJCQkJbnVtOw0KPiArCWludAkJCQlyZXQ7DQo+ICANCj4gIAlJTklUX0xJU1RfSEVBRCgmZHdj
LT5nYWRnZXQtPmVwX2xpc3QpOw0KPiAgDQo+ICsJcmV0ID0gZHdjM19nYWRnZXRfZ2V0X3Jlc2Vy
dmVkX2VuZHBvaW50cyhkd2MsIHByb3BuYW1lLA0KPiArCQkJCQkJIHJlc2VydmVkX2VwcywgQVJS
QVlfU0laRShyZXNlcnZlZF9lcHMpKTsNCj4gKwlpZiAocmV0IDwgMCkgew0KPiArCQlkZXZfZXJy
KGR3Yy0+ZGV2LCAiZmFpbGVkIHRvIHJlYWQgJXNcbiIsIHByb3BuYW1lKTsNCj4gKwkJcmV0dXJu
IHJldDsNCj4gKwl9DQo+ICsJY291bnQgPSByZXQ7DQo+ICsNCj4gIAlmb3IgKGVwbnVtID0gMDsg
ZXBudW0gPCB0b3RhbDsgZXBudW0rKykgew0KPiAtCQlpbnQJCQlyZXQ7DQo+ICsJCWZvciAobnVt
ID0gMDsgbnVtIDwgY291bnQ7IG51bSsrKSB7DQo+ICsJCQlpZiAoZXBudW0gPT0gcmVzZXJ2ZWRf
ZXBzW251bV0pDQo+ICsJCQkJYnJlYWs7DQo+ICsJCX0NCj4gKwkJaWYgKG51bSA8IGNvdW50KQ0K
PiArCQkJY29udGludWU7DQo+ICANCj4gIAkJcmV0ID0gZHdjM19nYWRnZXRfaW5pdF9lbmRwb2lu
dChkd2MsIGVwbnVtKTsNCj4gIAkJaWYgKHJldCkNCj4gLS0gDQo+IDIuNDUuMS4zMDM1LmcyNzZl
ODg2ZGI3OGINCj4gDQoNCkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5v
cHN5cy5jb20+DQoNClRoYW5rcywNClRoaW5o

