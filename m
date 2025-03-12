Return-Path: <linux-kernel+bounces-558576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EED7DA5E7F2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 00:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C8AD189A198
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E072F1F1302;
	Wed, 12 Mar 2025 23:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="SgT9kiqi";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="iCcF4Yzn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WpOsJnVt"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AF61B0406;
	Wed, 12 Mar 2025 23:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741820552; cv=fail; b=H1OJm8rOmRR2bRUCpTpGGZurF2BQBhjBEJsnQWYggX9WHBmmJDLneOdJTMdsd21+FwB4JO74LIEom70hgG0fPBlaZmvVZHYMUYb/VrTu3+Fh01pO8CkNmbDx3itdzkowoFWSxgWgu1+FNFE5zV3l3JCC529z9lkRsDGTHoUGaNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741820552; c=relaxed/simple;
	bh=Zc8+mvrY4CN9rH9XKb00wzQHkg2kSlQLoltUlBxuFM8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KD5l+Cy3KlnY8EACGWWCBoCo3032QM9VW/vftFa6tKK9lXn6mDiIG87t52QM3hokehxcG4CQkM5hU0e1Y+9tpmzaUxu5X8/dgRfiEXuFmRysjMANkEyP7WR0xE2Y2mM2KjR4LbisGCDi1vAtCtJtkYlTaH5a4ojNynASZEobxso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=SgT9kiqi; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=iCcF4Yzn; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=WpOsJnVt reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CJ3wlK009059;
	Wed, 12 Mar 2025 16:02:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=Zc8+mvrY4CN9rH9XKb00wzQHkg2kSlQLoltUlBxuFM8=; b=
	SgT9kiqitCLiV0TL4gWnYC7uiI6uBoKrETaTzgd8LIFKQauKj+JWdAOFLenwC0Lw
	hU/1bqMSk5wKF6kjxUd9o682J/VIiErGjw7grrubZioKW91psUjt4ot6m+Z2vLB4
	DeOirkdk6YwprP2ROJjvpEAckIoUFSzLxXUfAZIa0+s5i9J1P07/PXx1UJ4x+qvh
	1/nv/cL0VVRcLmRERZz99UVGFBWZPCl5BkWKO26+uOwgN3HaCs4hhuvP7LlVxYS2
	q8A0vrVqHmIqY7VnoSbkm0DuItcDX0lbzy51dMPfgV3CzAQVDVH56BwA3U+MLC4+
	NP2SicZGK6ncwm+LIPp1zQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 45au46rtgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 16:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1741820546; bh=Zc8+mvrY4CN9rH9XKb00wzQHkg2kSlQLoltUlBxuFM8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=iCcF4Yzn6wosL4eGO2Jdg+s7lasZzjF3x8Pgml117Yt6rm9B8tOGLu6ldes/dtF/4
	 fm7WSFLYrlJd4AUpIEqen/uP09lrjKHf9C1j5cl9XtDdgWBqWFc+m/E3mX6ZoTVs7Z
	 glQvdAq6QxCgWlwt9tdyIowbLd6zwJTSsLcWce33q7LkJqHeRc5ONJw1aSH7rmK6US
	 /diO7IRcWsxdPM12pfiRtZ3aA11sp6xKUjZfFkvyODHT3R+L3Xi5XGtsrWY6D4Gwlq
	 U/MTRvjlJUDhrRBz3ATghudT62cE6gSO4sCwI+IZ3p53ndN46IppFpTJzr9+yOn/es
	 BY5IgALsJHX8g==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 03DD1401B7;
	Wed, 12 Mar 2025 23:02:25 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 7B80CA00A2;
	Wed, 12 Mar 2025 23:02:25 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=WpOsJnVt;
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id CEFC44028D;
	Wed, 12 Mar 2025 23:02:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jaSdnJeII33LyBYYI38tEsE3DrURBVqva0yFqZnbQrdh6hZ8iIvXdPAeW2M8ips4/R6k9klNtpSh86TBAoljiZGqEKu68cj5ZSOz/+14U+mBpNaRGUPaOa6RRr4N2XV63/8/iJRb1ubQRmzTTKybdpCrQl7gfifum8vrOqURxICgWs9vqbVqWygJxaLz4DaLe06XkU7p7rEo8+yp7l+VMNJi49xxAPhb9G8kVc+OH81WcTAtZ/D0bIH46q79iZobTiKV7RhxfgfuPoDSoUpOorUqMWFSQAe5JPOQKTVM/x3X2D/dWgHI4KtteWfic6nSWWq/6KazNd0le7AEIjXLqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zc8+mvrY4CN9rH9XKb00wzQHkg2kSlQLoltUlBxuFM8=;
 b=hwZC3fnLssO7WVPb6q/C1ycNfQQs+Z+pEHzVgDJpn4+RM4MppPnanuswzI9T8ezKPQSMk05EunYuTEbmKY986/P06gmbh3c6Lth2F7KyV/HJt4xApKcxbSyOyeVbuB7PtFuZPFhQ0oqAG6kgpVdkl5b+Cu2y1OIgwZTGV6IsK/9d63GbaHebaFaWYbxFevFC0Tt34vCmjeeGuqmd0MTRqM90ZNsUQldixUQOyLlQ2yLP/x7/A1uiN337homTokeUs9YcIJRTW2/PIThnzq+aTVU4eKY+YkyOz22T7hFBsnW1fsOJ9RvPJaV0ODTKJEAFqXw4NSl2RrUIQ7rf5CJ3vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zc8+mvrY4CN9rH9XKb00wzQHkg2kSlQLoltUlBxuFM8=;
 b=WpOsJnVt9e7TgI/5+tZxapScIid+wUizPCu/7yYqUcG4faqsjdcZ9W6qRquUInv9N+bQ81maL2txJbdm3Jo6TIzOVIblWND4RbZ2PiCKZqRneieDat0M4YEbAAf7CWnYbG/T8IxE7v7hT5OuAYb8bG80cHJpAXPR20f3/l977qc=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DM6PR12MB4121.namprd12.prod.outlook.com (2603:10b6:5:220::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 23:02:21 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 23:02:20 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Roy Luo <royluo@google.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: core: Avoid redundant system suspend/resume
 callbacks
Thread-Topic: [PATCH v2] usb: dwc3: core: Avoid redundant system
 suspend/resume callbacks
Thread-Index: AQHbk572PYB1ZwMp0EOH+L8gWV7VdLNwHloA
Date: Wed, 12 Mar 2025 23:02:20 +0000
Message-ID: <20250312230216.l2e55tb5l6e4xyt2@synopsys.com>
References: <20250312223434.3071598-1-royluo@google.com>
In-Reply-To: <20250312223434.3071598-1-royluo@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DM6PR12MB4121:EE_
x-ms-office365-filtering-correlation-id: 8276afb3-11ea-4956-f36b-08dd61b9f199
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QTRWZkFiYTlGaVdvOE9MTWxPVmJWbGg1TFdYUW0rMFBOTFZ0RGYxb0hPYUI3?=
 =?utf-8?B?NjhDLzZSdDIwc091R3IweTZndjZjWjZPdGxOdzdrc1dnQWxpYXRYMU5EQitZ?=
 =?utf-8?B?QUNxZC8rZkFVemRNYXZwN0JLQ0g1WmFueGRUWVhjUmZUTGl2RXRTK1REb2xs?=
 =?utf-8?B?SjdYL1l2djBLaVZIL0d1YWJxY0swaU9CREFrN09FL1hZQ3cyamc3SC91ZnZH?=
 =?utf-8?B?SFYvdHhGTDZoUTRDdEQ0dnBJdU1EeWRDM3ZFbHNONm11OVFQTmJDb0VNcTBx?=
 =?utf-8?B?dkFKQUhDWW5xcEp2QUZ4dnZrWCtOVjhTUWphbFNNM0RUUDkyNzB6ZGVGVU9z?=
 =?utf-8?B?QVRDcEFMMURnUi9WWXcySjVoTGlEMmxuZ2l0eFAvcFo2ejNMaDBtbFhMN1pN?=
 =?utf-8?B?THdZU3grREF4QTNPcW5KUFBRYTg3QnlDakVwdDRsbFJ1cGNkQXpSZCtMa1Nn?=
 =?utf-8?B?OUhnYVdNaDdvRkFpd3U0N20wcm9PS2s1K25obDl3byt4cElyYVJLQ3Q1ZDZV?=
 =?utf-8?B?bVB6ZDU3c09va09WZnlGZWl6ZVgrdEE3Y0orbzVibk9EV21lcGRDbjdEWEI5?=
 =?utf-8?B?VW1XakVHUU4xYTZQR3VCM3FxU3krTXYzRW03MEc3TlBKOVBMN0UrZFNzV0tL?=
 =?utf-8?B?MWVzeVJ5QUZFTUFud1JqaTlidTRUUVh4NUEyZlJxNWJPVlBSbEtwTWo0b2J1?=
 =?utf-8?B?QTNPQU41a2twb3U2T0RmK0swNWQvMytvK2grR1gzcXVGZHQzeXJwNzUvUElo?=
 =?utf-8?B?T1Y3WmdGYW9tWTlzelVlaWd6MGl5RzRiR1llbDJlRnNEUmFOblN0dzhMMDlz?=
 =?utf-8?B?dHFaaWl6cDBkVjczeXJUVHYvWGptWkYyZTJwU00rcW92ODh1Tit2MHIrYVJR?=
 =?utf-8?B?SFZ0OGcweHhvckhRV3loLzJidTJXVVVIZVRiOGUvcmRHN0g2eHExQXFJc1c1?=
 =?utf-8?B?Z3hmWW5xQno4RUtGanNHN2R4L1NmOFRpa1RiNDVKWkhlWlNMK011cXhYeklh?=
 =?utf-8?B?cmw5Rm8xSW92QjltU1YzMEIxcU5xdUVpUU82UmZjUU5oOTVxdVMwUG54QW5T?=
 =?utf-8?B?N1BtcC9jbGxZdXVnRlB3eklnWlZzMGw0YzQrMk10bTRuY3R3ME44V2p5dStS?=
 =?utf-8?B?eXlaK2xWOHEycDQzdDMvQjhhQ0E5cXBxMk9yOHpQRlFvVzhnT0hySzNsOXk3?=
 =?utf-8?B?ekQ2TEZRa1pESUh4TEhDZUJCUDBZK0dhc09Vd0lEQzJCK1lvK1FYNkNvRWlw?=
 =?utf-8?B?MG00L1J6RWswQ1ZjYVNBMGhnQWtIQld6UTl2K0hIc05GZXkwTDlXYTJCNDdD?=
 =?utf-8?B?VWNBMmZMTW04KzYyZTY0YkNpakhBSStSMWNuY1UrQkhJdm9zMWdLZXRsbE1m?=
 =?utf-8?B?L0daT1F1Vm9QSm9xY1d6T2xvWXNyRGJRSzV2Syt2Y3JRbUdGQld2ZU9lRTRP?=
 =?utf-8?B?ZFkrZEFHdklONDlVT21jZDI5dmV3Z3gzbjNDczRtakR4aEx3SzRSUVk5aEh4?=
 =?utf-8?B?QWNIaUZLendwVWxPeXg3VWdkVG1WeGtMbWJIQTB0NlZCNzlIM2ZLbjhoWU5L?=
 =?utf-8?B?cnBjODBES05EYmthN041UnBqMU5oaCtpc0FCSjZhcjlhUjFSU3E4YlpEbDZy?=
 =?utf-8?B?UVAzT1N6NWEwTTNBM05UanZqTUQxQ0gydm16RzFydVEvM1dHSnZQcUdKV0lj?=
 =?utf-8?B?ZS9KUktOMVc1eXEzTzBmUm5JS0l2VG12enZIUnFwSzArTHFESEpsUjFRYzhh?=
 =?utf-8?B?UlNwNW1TcHBmSUtOVDBSbm51K1ZpRlJTTEdQYUdxU1orQWRYWGFWMGxXNjN0?=
 =?utf-8?B?TXVEOCtOZWRURGJtZmFmeERIY2lvb2xFM0lDbFpoRzgxWEliVEZiUjlQd2RH?=
 =?utf-8?B?bmlYOCtSVlFkSXpCUGRGK1ArSUV5bmdJSHc4L2hHOCtnOTBEb3VsTVArWGxt?=
 =?utf-8?Q?pRooHkFpnF5E0kt5OM51GFoy4wf9PzWd?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a0R5WDRXZ0RNcU9OTzZqdllLY1ZWKzdpeFZUa3BENThOemsvZGJIMGpRV1lP?=
 =?utf-8?B?Q0M4b28rQVVSUFhJdGxPNmlWLzNVbGEzY3RFWDlpM2xLUUdseHVmWGVRNXd4?=
 =?utf-8?B?M2lFSFJwRVhDWnNXdWVOenhpdE9CNkhTSHI1Q1lqaTBrb3dXZHZOOHRDRWpn?=
 =?utf-8?B?Y3FNbnVnYStXOXhoQVdPbjJReXdVUjV3RGZtdHZLSnhyQjYzR3lqTlc3M2xR?=
 =?utf-8?B?ZXo3VlVjOGpUUHVra2ZRckJ4QStOd1RvQ3dISW90aDF5RXViRW90eS85eTVT?=
 =?utf-8?B?b2kzUzZuMkF1REQ4VzlXVVF4M3dPOEJWRi84RWRsWDllWmtmMlczRUxuSGVP?=
 =?utf-8?B?UzlWOVRXeHZGRmhTRlBQNmhwWmhlTUVhMTNrTlFWMUgvWGY1RVc1bmN4bTdk?=
 =?utf-8?B?ZHJDdy9KRGlMQlFZVUdOUnNyOFVGeXdneTRXczlDSGVlVmxYVGg0Z1hsbVpJ?=
 =?utf-8?B?WTBBOFEreTBqNHJXNnQ5WTNPNFY2QjFKUzVYeG5NSXhWS2ZNaTFLSlQ2RzAr?=
 =?utf-8?B?RWNpZVlESnEvQVRmc0dhUmZHMGwwdzdiMUhhRGZJcSsvUVZESXR6REdURUFB?=
 =?utf-8?B?R0RkRjhrcXZRSitGZU45SWZZdGtKWmFQdVYzY1d2YVlPdnlWaDNtWGVtc2JF?=
 =?utf-8?B?aDEzeGs4QTcvR1F3Sk5YWXY5UTlRbCtGbTRTNkMrMFhnV3RLMGlXOHBkR2NY?=
 =?utf-8?B?TEFiS0hpcEJMbnNYM01yaEJKOTdrMzZpdEZPVEFHdU9aSmJuUlZ3bysxWTI0?=
 =?utf-8?B?NlYrKzZsMU9wUENDOVJ2OUIweHEvSW9xSlRxNDRQcWlnMWNtaVE5YzMyaFZq?=
 =?utf-8?B?aHM1SGpqUEZYN0hGYmZqdi9OQVZ6TnUwV0hXQjBnNXJMUlVCUzE0dUp2c3BW?=
 =?utf-8?B?aUtDMHM1UHdKSklZaHpVL0IwbkFkNk1nclFHWHBrT3A4ZmV2enBMWGpTOU5x?=
 =?utf-8?B?NWlidGxLYjduSW9WSTZuQWF4a09WWmF5ZHFpTGJkZjNtRmVNNEwvTC96b2J0?=
 =?utf-8?B?aUp2QlI0RG1GUzBwNUp3VmdrZWZXcFVQbnhJUkxJTTJvU1VxR0oyZjdyOTlJ?=
 =?utf-8?B?bGNUd3h3TUpPR1RHN0UvRzM0OEphQ3NzQ1hKL2pnNjJCMkMwTXkvMlBqTmZX?=
 =?utf-8?B?aE40czkyb0JmczVONXpSQ0RGemZPMmI0cDFwdG9OcFU2YjY3ZStrUU95aE5n?=
 =?utf-8?B?K1ZOdWhmTVM3ODl2ZzJGcndBVFZGcWhzVXBoODlzRys0UXlLTTZkN2d0UlN3?=
 =?utf-8?B?b1AvdEk2cVI0OFBwcmtTaFVFb1ppLzlEcDIwRWo2RWd4RDNsVTlUWVNYbHhR?=
 =?utf-8?B?WVMvRTI0TWtwcUlZVnlDSys5ZjFwUEI5OENsaHZNandmeHkxN2tENmhQTjlC?=
 =?utf-8?B?b0oyYVhZV0hOK0oxaEdOdlJJZlhobTVUVmphc2Z6QXdZaWhyRzgrS1JYdGto?=
 =?utf-8?B?VTgxeTFrN2tmSkd1QW8xcXNOK3hzQUpwYktoQWpleTlhZi9aTEVSdU5KZlZn?=
 =?utf-8?B?dTJCbG1JdTZWdllITGhaRmtIQlZuWHBPeUh1TS9oalp2K0k4OFF3RW8rZm5Z?=
 =?utf-8?B?MG90eUd0YVEyYnNzVjdpZ3JUN0lHVGJGUHdiSk52cEUwclk1eXpiNkRoY2di?=
 =?utf-8?B?SCtjNDMxeElVT3ltSjJJMlRnYmZ2ZGlJaFVjdTBpVE5kbDh3SWU2U1FYNWhN?=
 =?utf-8?B?NlYzdU9PKy9ZQVVtWFN2WFRYL3I2ajY0c2VwcjhUQkgzVFdSMFNPWmpINWlN?=
 =?utf-8?B?QzFkVmFJd25ZV3JsRHFXcktGY2tkRTdpRWw0S3gwVXprYVpQKzhkc2pRNDhW?=
 =?utf-8?B?Y2k1aERvQ2RhSmZWSWxiUE5zNHEzUDArcHVzcEJGWWdSc01aM0tGNm1hQ2Nr?=
 =?utf-8?B?Q0ZidmJNRlZKZExFUkF4ZmNMeTRnamJxOGlDTm15SkFRN2RXbzluZVJacnpx?=
 =?utf-8?B?SVF1cW9IOGlJbXBUdmw5RFpKdVBHKzVPbzlHRDQ0bTZ6QXE1bCtuVEhoWU1B?=
 =?utf-8?B?VHI1Z1JNQmFnU2o0TGFLZmNZaVUwZTFVQWxobXppdjBzMVBxaDF3WE5zRHlN?=
 =?utf-8?B?QStXdnNYaXpCODVjOHkvM1QzMzdUN2t2a21wM0pVb1E3TjJ1NG8rQkFyR210?=
 =?utf-8?Q?6J2ggm4GlrxwCdH2qG3udZ1BR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C30DE635CF4D2E47A6FC971A54A5A593@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Lfu9HzRXh0b/q1dpnA9DCg8uy8BqwhARj4XlcGQKvI+7VN1acSWxok/vZ1O2wLMdFqNFP5NYDneGFkeAi3UZQk6/grC/9A7XPYpD6I0CJh9kWi+I0g0vMTlMMGb1CmEORT58KRWRDE+5Fc1AZYgDarCol8ruG+A3kGemEj4u89DjDZdGyGSbTOi5MmDZShgA6ELK7BCcoLhP6i0R6PQZeN3Wy66kEva2hCoPlXErYj0ItvA9AkWe44hyO/F6zITNN7ypuv1q1ZMDPdM1I1DnUndq0kGwi58YNljhwwGGB9ObsFz8VmXCXDEsxcRHVEZarLwLNLwG23LshKhLOScs3088q7DMhCUOyU2gsP144mN6w3keHfa/yTrwDgOp07z6kgdT4gaMcXhw/k6NTxPGLEAxtAaqHvV8IgUnGspLmBtMeQwpf5QGvcDlSMu+9C6dsrJnSgPbCeZqt5QSNbgj8a3pIq+9MLT/W6pCoQ8WA/ZpPCSxjDnGUYPLXd0t4C5pItvTHw5YZlRVP5yORYmd3GoB9hrPPlVCRrG6bueEtgZ5Acg0pxQN90H3Xlel533EhApaV/D5RAvCuhau23MShnNtyFwoS4aH0BFSxggJnfMm4GugMSqp+hfIEfns8PXQFABX7+YNTWf4+omj+iY8oA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8276afb3-11ea-4956-f36b-08dd61b9f199
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 23:02:20.6410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7YkzwvY5Kt96+jYXwAg96m2N2xzOwedPSu2fCPy88sKyF3tYgBtDpqHg4AtyVOWIb+w2iOWYYdPzCZFD1a4sYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4121
X-Proofpoint-GUID: P-Gq2Rpc2B-_WgnLTL0WNaRG44sXpfnI
X-Proofpoint-ORIG-GUID: P-Gq2Rpc2B-_WgnLTL0WNaRG44sXpfnI
X-Authority-Analysis: v=2.4 cv=Y+f4sgeN c=1 sm=1 tr=0 ts=67d21283 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=qPHU084jO2kA:10 a=1XWaLZrsAAAA:8 a=jIQo8A4GAAAA:8 a=IpIQ5oeoXbENJAf3AHYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_06,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 priorityscore=1501 mlxlogscore=934 adultscore=0 mlxscore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503120165

T24gV2VkLCBNYXIgMTIsIDIwMjUsIFJveSBMdW8gd3JvdGU6DQo+IGR3YzMgZGV2aWNlIHN1c3Bl
bmQvcmVzdW1lIGNhbGxiYWNrcyB3ZXJlIGJlaW5nIHRyaWdnZXJlZCBkdXJpbmcgc3lzdGVtDQo+
IHN1c3BlbmQgYW5kIHJlc3VtZSBldmVuIGlmIHRoZSBkZXZpY2Ugd2FzIGFscmVhZHkgcnVudGlt
ZS1zdXNwZW5kZWQuDQo+IFRoaXMgaXMgcmVkdW5kYW50IGZvciBkZXZpY2UgbW9kZSBiZWNhdXNl
IHRoZSBzdXNwZW5kIGFuZCByZXN1bWUgcm91dGluZXMNCj4gYXJlIGVzc2VudGlhbGx5IGlkZW50
aWNhbCBmb3Igc3lzdGVtIFBNIGFuZCBydW50aW1lIFBNLg0KPiANCj4gVG8gcHJldmVudCB0aGVz
ZSB1bm5lY2Vzc2FyeSBjYWxsYmFja3MsIGluZGljYXRlIHRvIHRoZSBQTSBjb3JlIHRoYXQgaXQN
Cj4gY2FuIHNhZmVseSBsZWF2ZSB0aGUgZGV2aWNlIGluIHJ1bnRpbWUgc3VzcGVuZCBpZiBpdCdz
IGFscmVhZHkNCj4gcnVudGltZS1zdXNwZW5kZWQgaW4gZGV2aWNlIG1vZGUgYnkgcmV0dXJuaW5n
IGEgcG9zaXRpdmUgdmFsdWUgaW4NCj4gcHJlcGFyZSgpIGNhbGxiYWNrLiBUaGlzIG9wdGltaXph
dGlvbiBvbmx5IGFwcGxpZXMgdG8gZGV2aWNlcyB3aXRob3V0DQo+IHBpbmN0cmwsIGFzIHBpbmN0
cmwgaGFzIGRpc3RpbmN0IGxvZ2ljIHRpZWQgdG8gc3lzdGVtIHN1c3BlbmQvcmVzdW1lLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogUm95IEx1byA8cm95bHVvQGdvb2dsZS5jb20+DQo+IC0tLQ0KPiBD
aGFuZ2VzIGluIHYyOg0KPiAtIGxlYXZlIHRoZSBwaW5jdHJsIGxvZ2ljIHVudG91Y2hlZCwgYXBw
bHkgdGhlIG9wdGltaXphdGlvbiBvbmx5IHdoZW4NCj4gICBwaW5jdHJsIGlzbid0IGJlaW5nIHVz
ZWQuDQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgfCAyMCArKysrKysrKysrKysr
KysrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMv
dXNiL2R3YzMvY29yZS5jDQo+IGluZGV4IDY2YTA4YjUyNzE2NS4uMDJjZGQwNzI3YTVlIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9k
d2MzL2NvcmUuYw0KPiBAQCAtMjYsNiArMjYsNyBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L29mX2dy
YXBoLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvYWNwaS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3Bp
bmN0cmwvY29uc3VtZXIuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9waW5jdHJsL2RldmluZm8uaD4N
Cj4gICNpbmNsdWRlIDxsaW51eC9yZXNldC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2JpdGZpZWxk
Lmg+DQo+ICANCj4gQEAgLTI2NTgsMTQgKzI2NTksMzEgQEAgc3RhdGljIHZvaWQgZHdjM19jb21w
bGV0ZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICAJCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdD
M19HVUNUTDMsIHJlZyk7DQo+ICAJfQ0KPiAgfQ0KPiArDQo+ICtzdGF0aWMgaW50IGR3YzNfcHJl
cGFyZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICt7DQo+ICsJc3RydWN0IGR3YzMJKmR3YyA9IGRl
dl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiArDQo+ICsJLyoNCj4gKwkgKiBJbmRpY2F0ZSB0byB0aGUg
UE0gY29yZSB0aGF0IGl0IG1heSBzYWZlbHkgbGVhdmUgdGhlIGRldmljZSBpbg0KPiArCSAqIHJ1
bnRpbWUgc3VzcGVuZCBpZiBydW50aW1lLXN1c3BlbmRlZCBhbHJlYWR5IGluIGRldmljZSBtb2Rl
Lg0KPiArCSAqLw0KPiArCWlmIChkd2MtPmN1cnJlbnRfZHJfcm9sZSA9PSBEV0MzX0dDVExfUFJU
Q0FQX0RFVklDRSAmJg0KPiArCSAgICBwbV9ydW50aW1lX3N1c3BlbmRlZChkZXYpICYmDQo+ICsJ
ICAgICFkZXZfcGluY3RybChkZXYpKQ0KPiArCQlyZXR1cm4gMTsNCj4gKw0KPiArCXJldHVybiAw
Ow0KPiArfQ0KPiAgI2Vsc2UNCj4gICNkZWZpbmUgZHdjM19jb21wbGV0ZSBOVUxMDQo+ICsjZGVm
aW5lIGR3YzNfcHJlcGFyZSBOVUxMDQo+ICAjZW5kaWYgLyogQ09ORklHX1BNX1NMRUVQICovDQo+
ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZGV2X3BtX29wcyBkd2MzX2Rldl9wbV9vcHMgPSB7
DQo+ICAJU0VUX1NZU1RFTV9TTEVFUF9QTV9PUFMoZHdjM19zdXNwZW5kLCBkd2MzX3Jlc3VtZSkN
Cj4gIAkuY29tcGxldGUgPSBkd2MzX2NvbXBsZXRlLA0KPiAtDQo+ICsJLnByZXBhcmUgPSBkd2Mz
X3ByZXBhcmUsDQo+ICAJLyoNCj4gIAkgKiBSdW50aW1lIHN1c3BlbmQgaGFsdHMgdGhlIGNvbnRy
b2xsZXIgb24gZGlzY29ubmVjdGlvbi4gSXQgcmVsaWVzIG9uDQo+ICAJICogcGxhdGZvcm1zIHdp
dGggY3VzdG9tIGNvbm5lY3Rpb24gbm90aWZpY2F0aW9uIHRvIHN0YXJ0IHRoZSBjb250cm9sbGVy
DQo+IA0KPiBiYXNlLWNvbW1pdDogMGZlZDg5YTk2MWVhODUxOTQ1ZDIzY2MzNWJlYjU5ZDZlNTZj
MDk2NA0KPiAtLSANCj4gMi40OS4wLnJjMS40NTEuZzhmMzgzMzFlMzItZ29vZw0KPiANCg0KQWNr
ZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCg0KVGhhbmtz
LA0KVGhpbmg=

