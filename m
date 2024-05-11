Return-Path: <linux-kernel+bounces-176315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F168C2DCD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 02:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17E01B22A46
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 00:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120EC23B1;
	Sat, 11 May 2024 00:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="XtmlNiiA";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="V61ArHzh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="JcBUvfsp"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6C2184;
	Sat, 11 May 2024 00:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715386316; cv=fail; b=RDkPALEhnIBw+cKNMMTAU8mOXEYH+puQRNVPGEnlPym3ILc7g8A0HT+uRgmcSpeeqTE8LJY6JYqwvKquQuXmk1vNyTg/b4jlt50oOOizuSevrVmHrctjOSp4zEkNCW+j8kmRrslBaGvJhP0gjaavukkqwP7ADs6jBDqTaDIrSbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715386316; c=relaxed/simple;
	bh=0Hw6eghQEOROKEeE+uLWJB3BMixCemwgfqjiU6SCYck=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=COxS5hAFjM/AMexdi2GJvD8hS7aeZESHllRRODXNa+yPXtW4uECyZOo8Tgbf6bjnncXbKHp5wG0K7GWetHFzOy9hEVMyKCbj6TpkdPGZU4Svcb2ePNmKiF1FKqv9wmLQg0sT5f9u9erZWiuEnMfc95rWsJaYJtNaUJUZ3stwXVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=XtmlNiiA; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=V61ArHzh; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=JcBUvfsp reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44AKjK7k031397;
	Fri, 10 May 2024 17:11:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=0Hw6eghQEOROKEeE+uLWJB3BMixCemwgfqjiU6SCYck=; b=
	XtmlNiiAdB1xyZX4NLsKmijQYN6AMT/gI2q7sztfJdQ7b9iRJ951n0U4FN0O9U3J
	ylfdoDUj1y6CSvUp2Iaf0WdnCStyIAnsHPtA78IwkC8EkfqezBE4OI5VtR7ATEzU
	kBgLbDj3ms0VZSLym2PL2in5MrGAQnQRqp7eAavZkpWOh0ANbveBrCv+2k7i1fKk
	lQmBsmg+kyGPj6reXFtXkyVu1r8B/bvhrX8VfBmSvstd3AwrxKxueCAf+d5EUDyO
	0yGcvw2fqh1SVEk6VXs++hFiDHL5/fzRIu1DcWyycVtzdVeu2/M/V7KXMUMpNgq8
	Ld/zPPRd2L2UeLllKsKlVw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3y16xacsf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 17:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1715386299; bh=0Hw6eghQEOROKEeE+uLWJB3BMixCemwgfqjiU6SCYck=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=V61ArHzhj+HFcufcHtWEiUIsxi6tC9xFwsHpO+y1l3PiJMbRcOgfqN7HPrIy5Awca
	 WipTO3yBUqAKonCbzQSKNeo6+XvTqb1V0npRFgwGubmz0TZras3DdSWcwxPKhWaiSO
	 tAK4OZ2UyXMQDJgDFaGKrKmP5RrgVlk2nLs1ZmxyDZzUX1diekWD3ORVD5rfuIjtb1
	 +AhXVg3jhhx5PhMoWM8rZVnraHjl+6VzLNQI6vgOUyiC3TvvPl0EkyRQJpmpkebbuj
	 crViGx+nrUA+Qkcs11FKFDW+TPQ6I0uodQY9J2SyB0iDv5Td6LmYyZSR7kmdWBpa2q
	 31Gx+aiLa0CCA==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4DF444044C;
	Sat, 11 May 2024 00:11:38 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id C62D8A006D;
	Sat, 11 May 2024 00:11:37 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=JcBUvfsp;
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id D554340360;
	Sat, 11 May 2024 00:11:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZM+Uh0Em33qutBn5v3OSpMfKGQazri7iOcMkYgCexpFKMn+ujMoAroYuo1Nqyg06D0zN+CNiVAyfHMN3AZaN5J42qBqv66k0EsufK2PHG+fwHZtCfcj4YjY3vMlE/pFBBAYYz6fnqxMWlgJNo3EdRAEN0OPF70c+HURrGfS+CNn3T1IJXU2+DjNKXjswy8DKFJnwNjKKjBn/qb23gDRHvCcJsAiCCez5pn02nJmh0qRk/wPqKMxSaJHFoY9o1/1EzQDoBYg6c6gNiRpsYu4RXfe1A0mwHnHyhNpVRHY2xBrf5r4cHQXV4m8vbbBN45OxL9d3DaLtg1+qU8qB3sBnug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Hw6eghQEOROKEeE+uLWJB3BMixCemwgfqjiU6SCYck=;
 b=QdgznwaOUDMH7038szWvbABa5m+ztv+cqDJG5rJdMaVNMox8xYG9+290GOp/1qAxIWt/xESu3y2qhERreRk7ZevOMizAeayQ/VfiyJQO7442/OA4qXxPvSpq4z5vLGH8tcY1L25UeHcmL7PDNYG2IPKVkjwEqNrHTTcQ7VGITT7z/P32Ui/MT4g1Llb9Om0JlHVXN5WVDkkPB+0LJxlPk5esGffjx07cOC31vNIliEvontRab+3nRN/E/saveSC12pJ3pnWBqj9QRXzZDPxYYWsFi8BFwMuKzR8Oytjpvd/J/YFRMekX/dMVj7QEg1WTgBvB1p0D2zBG2DVTpveTQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Hw6eghQEOROKEeE+uLWJB3BMixCemwgfqjiU6SCYck=;
 b=JcBUvfspvlZNkYiGW4aCfViQFuMWmaNI7NtFoy3JrNcgrBw9DrwNjILQkPJ+kj+5DC1hg1EgJsGDXU1CX9nkwRg+ETtUAicvGE4+mOpngvn1Qb2esFztgIqLFxY2QaTl5GsqXyD9WRmyf9NlVxR2mJssloLMXm3njW2WHcmJ//s=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CH2PR12MB4184.namprd12.prod.outlook.com (2603:10b6:610:a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.52; Sat, 11 May
 2024 00:11:32 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d%7]) with mapi id 15.20.7544.048; Sat, 11 May 2024
 00:11:31 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Michael Grzeschik <mgr@pengutronix.de>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "michael.riesch@wolfvision.net" <michael.riesch@wolfvision.net>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: gadget: create per ep interrupts
Thread-Topic: [PATCH] usb: dwc3: gadget: create per ep interrupts
Thread-Index: 
 AQHaoAoVjxvJC9SNLUaNNv/Fh2AK5bGMIMUAgAG8qICAAB7xAIAABjyAgAALZQCAAo+7gIAAkbWA
Date: Sat, 11 May 2024 00:11:31 +0000
Message-ID: <20240511001123.egbqumpzogk2mhxf@synopsys.com>
References: <20240507-dwc3_per_ep_irqthread-v1-1-f14dec6de19f@pengutronix.de>
 <518a046b-1056-287b-f505-149958ad9c9c@quicinc.com>
 <ZjvuoVpVTnEcHRIH@pengutronix.de>
 <20240508231950.ifyawl6bfy6bzvk7@synopsys.com>
 <ZjwN0Zp03a1XuQij@pengutronix.de>
 <20240509002256.7grpmpnmlghft4gf@synopsys.com>
 <Zj49cYCdFuCGCXdU@pengutronix.de>
In-Reply-To: <Zj49cYCdFuCGCXdU@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CH2PR12MB4184:EE_
x-ms-office365-filtering-correlation-id: 54ca0c95-644d-4730-6016-08dc714ee968
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?OUp6OG5hMmd1UDZveXdqeVJlMXJRWW5KcDBRWHZNS3dGbXhST3FOd0xsVTRM?=
 =?utf-8?B?ZzRrTnJDeFJ5cExFQUYrNENiS2Qzb0E5cTVrNkc5bnQvR2RLUXZaTnpaVGxS?=
 =?utf-8?B?WGdHVnU5emJvRGo3czBnbStYa1lnTmptbjdKNjk3ZTdkYmcyNWg2OSt4bFZG?=
 =?utf-8?B?ckVCQnEyQnFaYmh6SVJweDVWSzVhVmx3MzhoZVNDd0hqZWxRSDdmYWhtM29a?=
 =?utf-8?B?WGM2S0cyd0FzSkhpbDhGYmVyZzU5dXpiUnI0UWxybzRVRzAwZVBPWm8vSkoy?=
 =?utf-8?B?bG9CbFVrV3IwY1ZIdW1JS1ZXTHViNFZZS01rVmc4c3oxb285eC9oc05jRnNU?=
 =?utf-8?B?dG5MNDkxYW5VcVYxLzNZblI1VjVXeGtENjhYRVFzUU84alp4d1BkUnZBVGlN?=
 =?utf-8?B?VXNINWVtT3RFRWF3a0Jha05ob0RneWY5Um1JdUhBM3VpWHlnVkx2ZElwT2Ju?=
 =?utf-8?B?UWV0Mm9pQWlmejhaS202NWJWM2g3VUNjaVNwdVNJOG9FRlA1OWkrYU5sQlRW?=
 =?utf-8?B?eXMwQk9kOVVDRUdZZlJWVUNhL1U5b3VtOUhabzhuSm43RjhFQ3VxS2U5Mm5l?=
 =?utf-8?B?ZEdQeno0U0JjUE9adHl2Z1N4aDUwdnBGa2NqZFJBbkFDaFJXSHJHaWtnbkwz?=
 =?utf-8?B?UVp4dmd3RHA1YmJxeUVSaUpsY0pkdlZoWHdldGJjNmdrdzl5dnBua1NvL01s?=
 =?utf-8?B?bnJWeW5IU3JubklTV1VLeHVYdHM0bnhPdDZ5MHlVZVo2cjlNZVdhYWluamVR?=
 =?utf-8?B?djMwWHJKa25Bc00yVzU1eWVsalR1VVJ2MjRBREZZaEJGN25jUktucnBNWlVL?=
 =?utf-8?B?LytlcEx0Y0pVbVFLWmt5U1NFTml3cmJUeUhZVTh5am1wWVZyUmlvMTc4TjlM?=
 =?utf-8?B?TkppWUtvcHlHTWZnSGhSclc0dmF2ZGJ6NzBYYUROcVhIOEkzSXN6WFE1Z1Bo?=
 =?utf-8?B?a0QyUVFpNmVwamRkaHltSjhWR1J2bFpPeDMxVFN1eXViZFBqTUZGQmNGc3Rl?=
 =?utf-8?B?OFlYaTRqenVCMnRxWFIxSDI0NndRQlR1aE9uWHFOREZ6eEt1cEl5YWYvOXNz?=
 =?utf-8?B?WHdqNVlmWFVHK2J6QlBVK0lQYStWRGU1RkV4MzVmdVN4UVB6UnpEbXMzb3pB?=
 =?utf-8?B?bTkwK3k5MG5wQ2cyUGJXNmNBTW04aGZDZ1lJVG9XeDlhczBjZ1pUTGtOYTg5?=
 =?utf-8?B?U2VGR3ZUL0JCeSs1ZjdCenZiVXNhMEZBdWNRUCs1TTNLeS80ZUdHQXQxZjF5?=
 =?utf-8?B?akpJdjdpY3N6TU90Zmx6Nnd4WnZmeWlDdUJHRjM0UzFtS2pSMDZZSW9ET3NO?=
 =?utf-8?B?UGhuZmx3bzlnOHZEQkdFZWtjUXUzN0J4T0duZldPL2gvZXB0b1Q1SUJmTm9P?=
 =?utf-8?B?YmVReFdTRThMR29YdC8vL09UWnhPeDYxOFZTSFZMQzNlUndSNElnbW1VT0hv?=
 =?utf-8?B?eEF4ZVZ2Q0szcmJBU1g5dU1GQm1LQUhURTcycDA2akNqQXN2SEs3Vk9kY0Np?=
 =?utf-8?B?TlIzZytRUjBIY0liWC9GL2ROQWp0YWNOTU9yV3ZEYy9KZzMyblg3UU5Vb0NQ?=
 =?utf-8?B?VlVhd3A0NjBxS0NtQjFUZXB6WnovRVZ0TVVka1FCN1JPeFpCcVhMdCtxM0th?=
 =?utf-8?B?cFI2S2pyQWVqN3RjY2VTMUk4aVhlL2I5amFHbllDM3lTaElLUEpDaUJyQmQx?=
 =?utf-8?B?RjFTTzNqVU9PcEFiT0JibEpoM2F3d0xmeDVGM2x6U2NjdUgwSU15ODJ3PT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TVNJNldVaS9za09WbGFTT2c2ZkpZMi9aRnRhc1F5SEVyQVV1TkRUU3JldUl5?=
 =?utf-8?B?Qkp4TloxN3ZnenpiNFZ3dnNRdld3MVhUNG9qcm5nYldDb21rMUhvaSsxOEtS?=
 =?utf-8?B?YXJadWduMzhPNitiaWJUd3FnUGdtZm9DTklZaEFiN0JQVWdGK0lNdklTVm5S?=
 =?utf-8?B?djhtZDdVUkpqRE90Q1FVdEdlckhpdjRXbENBT3lGVWpiN0lYeTlCL21wc0Jx?=
 =?utf-8?B?T0xPcFhIWnh5VVF5VjJ6dE9TNW4wY1AxYldZNU92TWEwQ01EREs0RmhadVF0?=
 =?utf-8?B?cXVtRmZOaWNYV0REZWJ6d3JEQkZOQms2ZCtaRDVUZDROQkdCTVNsbzlBT04y?=
 =?utf-8?B?ZUhlUlMvQmk5c00yN0tHVVA5UkRFRitBd0hJVXZ1UXJHU2wxQVZaRHhMRzZP?=
 =?utf-8?B?WHVUVWdoQTRBZ3pxV3d2SEZpMGVxQ3pVNWIxc2NwNU9BWno1b2VrcGRqL1Nt?=
 =?utf-8?B?QzVSZ0tGblNTOVJDMVJFZVJTMTFkRDZEZDdKSzJGZzgrZVV5WXR5UEg4NC83?=
 =?utf-8?B?dmYyOXQ3ajJZSlBXSGJPamxVZUo5YWRaVXMvWEtVSGJYSkNyUDNhVHVWM1k1?=
 =?utf-8?B?UG9oaXNHZGJIRHFmYkxOcUZvS0xwNkNSSkpqK0QxRXJxUVowVlNQM2J1Q3FE?=
 =?utf-8?B?RGpKL0J2SmFSS0hNSjdMM09MWnU1cURkUFJiTUhOVGRIWlFJVWYwVmMvTWsr?=
 =?utf-8?B?NW8zaDI5Ly9zWEhFNE1MUnV6RGNnQWZBWXRlbkZ6OCtyV2dIdjV0emdwNGtM?=
 =?utf-8?B?akY3VXdWM3c4bnRhK3I0dzd5czZLTkQ0ZmdmdVdtYlBWWFhISVJoaFdnTEdN?=
 =?utf-8?B?SVBpZ3N3eklKSFlBZnhmOEI5M1Q3YXllMDRTQ2UvUTNKNG5zU1dQVDJ6RDNK?=
 =?utf-8?B?NFZoNHcvdEllSXRqbGc4dzQ2T1MrUG01VmdpSWtyOStURzkrZFp3bmVDbnhE?=
 =?utf-8?B?OFlqbDVTV1VweWo4dnYrNDk2WVFZU3pLdGw4MzNKRFp5MDN5Vk8xNWpFVjlv?=
 =?utf-8?B?ejhBL0VjQTJKc2JIbGlBM2ZPWmc5RVYwNWVlb2NuT1YyZXAwdXBFbGVOYTBT?=
 =?utf-8?B?NlhzeUR3WWt1YjdNd1c1ZWR1VDlGL0d4eFZLSEJ0U0xmUmhKVGdpREs4VWR3?=
 =?utf-8?B?UVA5aXNmSlV0TzdUTHpyRHlNSWVsN2M4eFI5NHFmN2QxbzhTT2lVZ1VPT2g5?=
 =?utf-8?B?bWRJY0RHajFWejMvSTF4eEhYcXBZZmdLOW41VnIwMGNrUUJZcXVPNERMamND?=
 =?utf-8?B?U21hL3dwVHVLN0RCYm1EKzlFUStDa0dzRmlSVmg3Q0RGUmUwMlY3Tndka1dK?=
 =?utf-8?B?NlNzK01TV2lGWHlqQy9zSVBhcGp2N0RpQlZBMHA0WnBubVZLY1ZJREN3czY3?=
 =?utf-8?B?c1pURVJYeFpLQTkzWDhvZjNObFRzcHlxL3o1QWhJK3NQNG1xVkVhNXRnWFFi?=
 =?utf-8?B?UEU1YWVkS3hyN2xrNWpuNlFkbG9vTmkyZVcvL2l2NUR6NlRFa1ZNNTZtMUVZ?=
 =?utf-8?B?YklKRkM3SHoxZCtDNk5DQjFZRlY5VUUrTzFZT05mUEFSTTFvSWU2UStOY1dY?=
 =?utf-8?B?RW5TZmZJc1lqLzk2bCt4L0wwTWY1d1F1L2F5K2grbDU3dUxrTjhsUWJFOWZF?=
 =?utf-8?B?NzQ5ZThRYURnN3dYQnQ0SEttV0VheTlmb1g0WHBxelRzenVIOENMRGFlRm9h?=
 =?utf-8?B?Tkx4T1FTdkVCeTJUOE12NFRGdExUbWoxdFl0Uy9RN0RxdExhZkZzQXUvTjVO?=
 =?utf-8?B?aEJlZVF2UEdqVG83YXRwRXlnWVdWRHZRVlpEdGpsVnM2R1VZbVMwQUdHcTAr?=
 =?utf-8?B?MFkrcXdQY0U2bUhKZXdVUy9kczhHeTNNV0tMazJOakJKS2lwRzVxZWE0c0lL?=
 =?utf-8?B?Vjh1YU5xdUY5cXM2VXBxVGxyWVJQZFlLcXVJY0txeW5xMWp4YVIxNW5LSHRQ?=
 =?utf-8?B?SzBoYzhBRUlTYTgvK2M3ZHM4a3ZCb0xJS2MrM0Y5eURkSmpoaGM3emFIVFdm?=
 =?utf-8?B?Zno3SVA1V1dHVmE4UVZYNm1pQXNZdkIrZ05BeFhmQURuM2lZNkV6NkVpdVFy?=
 =?utf-8?B?dUJYamU2dFRWdElNa0pnWi9PK2lnSmNaaks0bUZWZWdvSitRa1piaDY3VGRB?=
 =?utf-8?Q?Ac0d+46/7XfCGTlnVVdvvgqHS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <973FFA0CB8100F4FB7B95073DD5EBD8A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lD4Wqvn53wwNdndoNzZ6+dD686WPEE0GDeEYRnIOrc57H9Q9Mi2iEekQZzIGzaPUn6mMCX4nB4IYe2j0wFDBF8L8LHNjcI9uRhrA92dNCyP1NcRcciyqG+t40ODtFANZ79itfSo3PGbWTiGhFROE9kWSn5Bk50vwVbnsT4iMGL5R+mh1ZRU15NSgCQVcheZllDguJHLwL4rjRIi+/XsjeuSXqml7WEO9E27+mosMZ0Fc34efi0pOSXkuQ4S+25ra0koWNnEBovdWPVUusk1U+LTT2OXKxgXFo4qAbiPojRqLvsRFhAsxh/+wnvRp4IqkaFJCBd5OZIkRnqoxynSYHWREGD4zbb6Dw4ZUj4m3fgsIpBWnpyTbxPHatCdGD4twGxoqkGjDlkazDdDfnTyH+e8dTJ4mEo4x2hmD3NwsyHyDlMygg1C/AEkwM2y4LReR4ZO5+NPSGzO1T7EjyezrIiMmiP/SOKOnhVciiRJVdIrWSwRcaUjyqyPi7Hdcr1KX5qYynd8XegJ56d9IKoGRgh9X5EPqZnEIDk9P1F9HkEtws+zb2ZM2nvtjV+62hU2RfEmi4RpZK3lF2F5832NM3qbrugsMmk3fqNNTcUprp8iDYi0QiV0F8ArcVlLN2OfR7rtAIgJ6yvNhZSUtwYyHSA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ca0c95-644d-4730-6016-08dc714ee968
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2024 00:11:31.6751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Puby5unBv9mS2XUllkRjH/+Zo2OOIiFL7teOqNqpQCGb/BIdyJ9u6hEFOBvOU95948s9TpWphSfp52cP/bay+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4184
X-Proofpoint-ORIG-GUID: ZOaEnoRyUKI37xYMC90eQgZq8Ms7Yuea
X-Proofpoint-GUID: ZOaEnoRyUKI37xYMC90eQgZq8Ms7Yuea
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_17,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=999 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405010000 definitions=main-2405100176

T24gRnJpLCBNYXkgMTAsIDIwMjQsIE1pY2hhZWwgR3J6ZXNjaGlrIHdyb3RlOg0KPiBPbiBUaHUs
IE1heSAwOSwgMjAyNCBhdCAxMjoyMzowOUFNICswMDAwLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+
ID4gT24gVGh1LCBNYXkgMDksIDIwMjQsIE1pY2hhZWwgR3J6ZXNjaGlrIHdyb3RlOg0KPiA+ID4g
T24gV2VkLCBNYXkgMDgsIDIwMjQgYXQgMTE6MjA6MDNQTSArMDAwMCwgVGhpbmggTmd1eWVuIHdy
b3RlOg0KPiA+ID4gPiBPbiBXZWQsIE1heSAwOCwgMjAyNCwgTWljaGFlbCBHcnplc2NoaWsgd3Jv
dGU6DQo+ID4gPiA+ID4gT24gVHVlLCBNYXkgMDcsIDIwMjQgYXQgMTE6NTc6MzZBTSAtMDcwMCwg
V2VzbGV5IENoZW5nIHdyb3RlOg0KPiA+ID4gPiA+ID4gSGkgTWljaGFlbCwNCj4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiBPbiA1LzYvMjAyNCA0OjA2IFBNLCBNaWNoYWVsIEdyemVzY2hpayB3cm90
ZToNCj4gPiA+ID4gPiA+ID4gVGhpcyBwYXRjaCBpcyBzcGxpdHRpbmcgdXAgdGhlIGludGVycnVw
dCBldmVudCBoYW5kbGluZyBmcm9tIG9uZQ0KPiA+ID4gPiA+ID4gPiBpbnRlcnJ1cHQgdGhyZWFk
IHRvIHNlcGFyYXRlIHBlciBlbmRwb2ludCBpbnRlcnJ1cHQgdGhyZWFkcy4NCj4gPiA+ID4gPiA+
ID4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBJIGFzc3VtZSB0aGF0IHRoZSBpbmNlbnRpdmUg
ZnJvbSBkb2luZyB0aGlzIGlzIHRvIGltcHJvdmUgb3ZlcmFsbA0KPiA+ID4gPiA+ID4gdGhyb3Vn
aHB1dCBudW1iZXJzLiAgV291bGQgeW91IGJlIGFibGUgdG8gc2hhcmUgc29tZSBkYXRhIG9uIHRo
ZQ0KPiA+ID4gPiA+ID4gYmVuZWZpdHMgb2YgbW92aW5nIHRvIHBlciBFUCBldmVudCBtYW5hZ2Vt
ZW50Pw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhlIG1haW4gYmVuZWZpdCBpcyB0byBtYWtlIGl0
IHBvc3NpYmxlIHRvIHVzZSBoaWdoIGRlbWFuZGluZyB1c2INCj4gPiA+ID4gPiBlbmRwb2ludHMg
c2ltdWx0YW5lb3VzbHkuIEluIG91ciBzcGVjaWFsIGNhc2Ugd2Ugc2F3IHRoYXQgc3RyZWFtaW5n
DQo+ID4gPiA+ID4gdmlhIHVhYyBhbmQgc3RyZWFtaW5nIHZpYSB1dmMgd2FzIHByb2R1Y2luZyBu
b2lzZSBpbiB0aGUgYXVkaW8NCj4gPiA+ID4gPiBzdHJlYW0uIFRoaXMgd2FzIGR1ZSB0byB0aGUg
ZmFjdCwgdGhhdCB0aGUgaXNvYyBmZWVkYmFjayBlbmRwb2ludA0KPiA+ID4gPiA+IHRoYXQgd291
bGQgYWRqdXN0IHRoZSBzYW1wbGVyYXRlIHdhcyBub3QgYmVpbmcgY2FsbGVkIGZhc3QgZW5vdWdo
DQo+ID4gPiA+ID4gd2hlbiB0aGVyZSB3YXMgaGVhdnkgYSBsb3Qgb2YgdHJhZmZpYyBpbiB0aGUg
dXZjIGVuZHBvaW50IGNvbnRleHQuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBCeSBtb3ZpbmcgdGhl
IGVuZHBvaW50cyBpbnRvIHRoZWlyIG93biB0aHJlYWQgaGFuZGxlcnMgdGhlIHNob3J0DQo+ID4g
PiA+ID4gZmVlZGJhY2sgcmVxdWVzdHMgYXJlIGF0IGxlYXN0IGFibGUgdG8gYmUgc2NoZWR1bGVk
IGluIGJldHdlZW4gdGhlIGJ1cnN0cw0KPiA+ID4gPiA+IG9mIHRoZSB1dmMgcGFja2FnZXMuIFRo
ZSBuZXh0IHN0ZXAgaXMgdG8gaGF2ZSBhbGwgdGhyZWFkcyBydW5uaW5nIG9uDQo+ID4gPiA+ID4g
ZGlmZmVyZW50IGNwdSBjb3Jlcywgd2l0aG91dCBpbnRlcmZlcmluZyBlYWNoIG90aGVyLiBIb3dl
dmVyLCBhcyB3ZQ0KPiA+ID4gPiA+IHN0aWxsIGhhdmUgbm90IG1hdHJpeCBpcnEgYWxsb2NhdG9y
IGZvciBhcm0sIHRoZXJlIHN0aWxsIGlzIG5vIGRpcmVjdA0KPiA+ID4gPiA+IGJlbmVmaXQgZnJv
bSB0aGF0IHlldC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IFRvIGFjaGll
dmUgdGhpcyB3ZSBjcmVhdGUgYSBuZXcgZHdjMyBpbnRlcnJ1cHQgZG9tYWluIGluIHdoaWNoDQo+
ID4gPiA+ID4gPiA+IHdlIG1hcCBhbGwgY2xhaW1lZCBpbnRlcnJ1cHRzIHRvIGluZGl2aWR1YWwg
aW50ZXJydXB0IHRocmVhZHMuDQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IEFsdGhvdWdo
IHRoZSBnYWRnZXQgbGF5ZXIgaXMgcHJlcGFyaW5nIHRoZSBjbGFpbWVkIHBhcmFtZXRlcg0KPiA+
ID4gPiA+ID4gPiBvZiBlYWNoIHVzYl9lcCB3aGljaCBjb3VsZCBiZSBjaGVja2VkIGlmIHRoZSBl
bmRwb2ludCBpcw0KPiA+ID4gPiA+ID4gPiB0byB1c2VkIG9yIG5vdCwgdGhlIGNsYWltZWQgdmFs
dWUgd2FzIDAgZm9yIGVhY2ggZXAgaW4gZ2FkZ2V0X3N0YXJ0Lg0KPiA+ID4gPiA+ID4gPiBUaGlz
IHdhcyB0ZXN0ZWQgd2hlbiBkZXNjcmliaW5nIHNvbWUgY29tcG9zaXRlIGdhZGdldCB1c2luZyBj
b25maWdmcy4NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiB5ZWFoLi4u
IHRoZSBjbGFpbWVkIGZsYWcgaXMgY2xlYXJlZCBieSB0aGUgVVNCIGdhZGdldCwgaWUgVVNCIGNv
bmZpZ2ZzDQo+ID4gPiA+ID4gPiAobm90IHN1cmUgaWYgeW91J3JlIHVzaW5nIHRoaXMpIHdoZW5l
dmVyIGl0IGFkZHMgYSBVU0IgY29uZmlnLiAgVGhpcyBpcw0KPiA+ID4gPiA+ID4gdG8gaGFuZGxl
IG11bHRpIGNvbmZpZyBzaXR1YXRpb25zLCBzbyBzdWJzZXF1ZW50IFVTQiBjb25maWdzIGNhbiBi
ZQ0KPiA+ID4gPiA+ID4gYXNzaWduZWQgKHJlc3VzZSkgZW5kcG9pbnRzLCBzaW5jZSBvbmx5IG9u
ZSBjb25maWcgaXMgYWN0aXZlIGF0IGEgdGltZQ0KPiA+ID4gPiA+ID4gZm9yIGEgVVNCIGRldmlj
ZS4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBUaGlzIHdhcyBhIHN0cnVnZ2xlIGZvciBtZSBh
cyB3ZWxsIHdoZW4gYWRkaW5nIHRoZSBUWEZJRk8gcmVzaXppbmcNCj4gPiA+ID4gPiA+IGxvZ2lj
LiAgV2Ugd29uJ3QgYWN0dWFsbHkga25vdyB3aGljaCBFUHMgYXJlIGdvaW5nIHRvIGJlIHVzZWQg
dW50aWwgdGhlDQo+ID4gPiA+ID4gPiBob3N0IGlzc3VlcyB0aGUgc2V0IGNvbmZpZ3VyYXRpb24g
cGFja2V0IHRvIHNlbGVjdCBhIGNvbmZpZywgYW5kIHRoZQ0KPiA+ID4gPiA+ID4gc2V0X2FsdCgp
IGNhbGxiYWNrIGlzc3VlcyB1c2JfZXBfZW5hYmxlKCkuICBTbyB0aGUgaW1wbGVtZW50YXRpb24N
Cj4gPiA+ID4gPiA+IChUWEZJRk8gcmVzaXppbmcpIGlzIGN1cnJlbnRseSBiYXNlZCBvbiB0aGUg
bWF4aW11bSBwb3RlbnRpYWwgZW5kcG9pbnRzDQo+ID4gPiA+ID4gPiB1c2VkIGJ5IGFueSBVU0Ig
Y29uZmlndXJhdGlvbi4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBOb3Qgc3VyZSBpZiBoYXZp
bmcgMzEgKHBvdGVudGlhbGx5KSBkaWZmZXJlbnQgSVJRIGVudHJpZXMgd291bGQgYmUgb2ssDQo+
ID4gPiA+ID4gPiBidXQgbWF5YmUgaXQgd291bGQgYmUgc2ltcGxlciB0byBqdXN0IHRvIHJlcXVl
c3QgSVJRIGZvciBkd2MtPm51bV9lcHMNCj4gPiA+ID4gPiA+IGFsd2F5cz8NCj4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiBIYXZlIHlvdSB0cmllZCB0aGlzIG9uIGEgbXVsdGkgY29uZmlnIGRldmlj
ZT8NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IE5vLCBJIGRpZG4ndC4gSSBkb3VidCB0aGF0IHRoaXMg
d2lsbCB3b3JrIGFmdGVyIHlvdXIgZXhwbGFuYXRpb24uIFNvDQo+ID4gPiA+ID4gdGhhbmtzIGZv
ciB0aGUgaW5zaWRlcyENCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEkgdHJpZWQgcHV0dGluZyB0aGUg
cmVxdWVzdF90aHJlYWRlZF9pcnEgaW50byB0aGUgZXBfZW5hYmxlIGZ1bmN0aW9uDQo+ID4gPiA+
ID4gYnV0IHRoaXMgZG9lcyBub3Qgd29yayBhcyBJIHNlZSBhIGxvdCBvZiBzY2hlZHVsZSB3aGls
ZSBhdG9taWMNCj4gPiA+ID4gPiBlcnJvcnMuIFRoaXMgaXMgcG9zc2libGUgYXMgZXBfZW5hYmxl
IGlzIGNhbGxlZCBmcm9tIGFuIHNldCBhbHQNCj4gPiA+ID4gPiBjb21pbmcgZnJvbSBlcDAgaW50
ZXJydXB0IHRocmVhZCBjb250ZXh0Lg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gU28gdGhlcmUgaXMg
cHJvYmFibHkgbm93IG5vIG90aGVyIG9wdGlvbiBsZWZ0IHRvIGhhdmUgZXhhY3QgZW5kcG9pbnQN
Cj4gPiA+ID4gPiBpbnRlcnJ1cHQgdGhyZWFkcy4gSSB3aWxsIHJld29yayB0aGlzIGJhY2sgdG8g
cmVxdWVzdCBhIGt0aHJlYWQgZm9yIGVhY2gNCj4gPiA+ID4gPiBlbmRwb2ludCBldmVuIGFzIHdl
IHdpbGwgcHJvYmFibHkgd291bGQgbm90IGJlIHVzaW5nIHRoZW0uDQo+ID4gPiA+ID4NCj4gPiA+
ID4NCj4gPiA+ID4gRG8geW91IGhhdmUgYW55IGRhdGEgb24gbGF0ZW5jeSBoZXJlPw0KPiA+ID4g
DQo+ID4gPiBJIGRvbid0IGhhdmUgdGhlIGV4YWN0IG51bWJlcnMgZm9yIHRoZSB1YWMgZmVlZGJh
Y2sgaXNvYyBlbmRwb2ludA0KPiA+ID4gYXQgdGhlIG1vbWVudC4gQnV0IHdpdGhvdXQgdGhlIHBh
dGNoIGFwcGxpZWQsIGl0IHdhcyByZXByb2R1Y2FibHkNCj4gPiA+IHJldHVybmluZyB3aXRoIEVY
REVWIHdoZW4gd2Ugc3RhcnRlZCB1dmMgc3RyZWFtaW5nIGFuZCB0aGVyZWZvcg0KPiA+ID4gaW5j
cmVhc2VkIHRoZSBhbW91bnQgb2YgZXZlbnRzIHBlciBpbnRlcnJ1cHQgdGhyZWFkIGN5Y2xlLg0K
PiA+ID4gDQo+ID4gPiBXaXRoIHRoZSBwYXRjaCBhcHBsaWVkIGhvd2V2ZXIsIHdlIGFyZSBhYmxl
IHRvIG9ubHkgcm91dGUgdGhlIGV2ZW50cyB0bw0KPiA+ID4gdGhlIGNvcnJlc3BvbmRpbmcgc29m
dCBpcnFzIGFuZCBsZWF2ZSB0aGUgbW9tZW50IG9mIHRydXRoIHRvIHRoZQ0KPiA+ID4gc2NoZWR1
bGVyLg0KPiA+IA0KPiA+IEJhc2ljYWxseSB5b3UncmUgdHJ5aW5nIGluY3JlYXNlIHRoZSBwcmlv
cml0eSBvZiBkd2MzIGJ5IHRoZSBncmVhdGVyDQo+ID4gbnVtYmVyIG9mIHNvZnQgaW50ZXJydXB0
cy4NCj4gDQo+IFBvc3NpYmxlLiBOZXZlciB0aG91Z2h0IGFib3V0IHRoaXMuDQo+IA0KPiA+ID4g
PiBJIGRvbid0IHNlZSBob3cgaW50cm9kdWNpbmcgbW9yZSBzb2Z0IGludGVycnVwdHMgd291bGQg
aW1wcm92ZSBvbg0KPiA+ID4gPiBsYXRlbmN5LCBpZiBhbnl0aGluZywgaXQgc2hvdWxkIGJlIHdv
cnNlPw0KPiA+ID4gDQo+ID4gPiBXaHkgc2hvdWxkIGV4cGxpY2l0IGhhbmRsaW5nIG9mIGNvaGVy
ZW50IGVwIGV2ZW50cyBvbiBvbmUgY3B1IGNvcmUNCj4gPiA+IGludHJvZHVjZSBtb3JlIGxhdGVu
Y3kgdGhlbiBieSBpbnRlcmxlYXZpbmcgZGlmZmVyZW50IGV2ZW50cyBmb3INCj4gPiA+IGFyYml0
cmFyeSBlcCBhbGwgaW4gb25lIHRocmVhZD8NCj4gPiANCj4gPiBCZWNhdXNlIHdlIGFyZSBvbmx5
IHVzaW5nIGEgc2luZ2xlIGludGVycnVwdCBsaW5lLCB0aGUgc2VxdWVuY2Ugb2YNCj4gPiBldmVu
dHMgbmVlZCB0byBiZSBoYW5kbGVkIDEgc2V0IGF0IGEgdGltZS4gVGhlIGFtb3VudCBvZiB0aW1l
IHNhdmVkIGZyb20NCj4gPiBoYW5kbGluZyBpbnRlcnJ1cHRzIG9mIGRpZmZlcmVudCBlbmRwb2lu
dCBzaG91bGQgYmUgbWluaXNjdWxlLiBUaGVyZSdzDQo+ID4gbGF0ZW5jeSB0byBzd2l0Y2hpbmcg
Y29udGV4dCBhbmQgbG9ja2luZywgd2hpY2ggSSB0aGluayB3b3VsZCBvZmZzZXQgYW5kDQo+ID4g
aW50cm9kdWNlIG1vcmUgbGF0ZW5jeSB0aGFuIHdoYXQgeW91IGNhbiBwb3RlbnRpYWxseSBzYXZl
Lg0KPiA+IA0KPiA+IEknZCBsaWtlIHRvIHNlZSBkYXRhIG9uIHRoZSBpbXByb3ZlbWVudCBvbiB0
aGUgbmV0IGxhdGVuY3kgaGVyZS4NCj4gDQo+IElmIHRoaXMgaXMgdGhlIGNhc2UuIFRoZW4gd2Ug
YXJlIGN1cnJlbnRseSBkZWFsaW5nIHdpdGggd2F5IHRvIG11Y2gNCj4gZHVydGlvbiBpbiB0aGUg
Y29tcGxldGUgaGFuZGxlciBvZiB0aGUgZW5kcG9pbnRzLiBJIGNhbid0IHJlYWxseQ0KPiB0ZWxs
IGZvciB0aGUgdWFjIGVuZHBvaW50cy4gQnV0IHRoZSB1dmMgY29tcGxldGUgZW5kcG9pbnQgaXMg
Z29pbmcNCj4gdGhyb3VnaCB0aGlzIHJvdW5kdHJpcC4NCj4gDQo+IFdpdGggbm9faW50ZXJ1cHQg
PSAwIGF0IGV2ZXJ5IDE2IHJlcXVlc3Q6DQo+IA0KPiBkd2MzX2VuZHBvaW50X2ludGVycnVwdA0K
PiAgIGR3YzNfZ2FkZ2V0X2VuZHBvaW50X3RyYnNfY29tcGxldGUNCj4gICAgIGR3YzNfZ2FkZ2V0
X2VwX2NsZWFudXBfY29tcGxldGVkX3JlcXVlc3RzDQo+IH4xNiAqIHsNCj4gICAgICAgICBkd2Mz
X2dhZGdldF9lcF9jbGVhbnVwX2NvbXBsZXRlZF9yZXF1ZXN0DQo+IAkgIGR3YzNfZ2FkZ2V0X2dp
dmViYWNrDQo+IAkgICAgdXNiX2dhZGdldF9naXZlYmFja19yZXF1ZXN0DQo+IAkgICAgICB1c2Jf
ZXBfcXVldWUNCj4gCSAgICAgICAgX19kd2MzX2dhZGdldF9lcF9xdWV1ZQ0KPiAJCSAgZHdjM19w
cmVwYXJlX3RyYnMNCj4gfiAqCSAgICAgICAgICAgIHsNCj4gICAgICAgICAgICAgICAgICAgICAg
IGR3YzNfcHJlcGFyZV90cmJzX3NnL2R3YzNfcHJlcGFyZV90cmJzX2xpbmVhcg0KPiAJCSAgICB9
DQo+IAkJICBkd2MzX3NlbmRfZ2FkZ2V0X2VwX2NtZA0KPiAgICAgICB9DQo+IA0KPiBJIHRoaW5r
IHRoaXMgaXMgYSBsb3Qgb2Ygc3RhY2sgZm9yIGFuIGludGVycnVwdCB0aHJlYWQgdG8gaGFuZGxl
IGlmIHlvdQ0KPiByZWFsbHkgd2FudCB0byBwaXBlbGluZSB0aGlzIGluIG9uZSBpcnF0aHJlYWQg
cnVuIGFuZCBsZWF2ZSBhbmQgbWFrZQ0KPiBzdXJlIHRoYXQgdGhlIG90aGVyIGVuZHBvaW50cyB3
aWxsIGFsc28gYmUgaGFuZGxlZCBzb29uIGVub3VnaC4NCj4gDQoNClRoZSB1c2JfZXBfcXVldWUg
b3BzIHNob3VsZCBiZSByZWxhdGl2ZWx5IHF1aWNrLCBJIHRoaW5rIHlvdSBtZWFuIHRoZQ0KcmVx
dWVzdCBwcm9jZXNzIGFuZC9vciBwcmVwYXJhdGlvbiBhdCB0aGUgZnVuY3Rpb24gZHJpdmVyIGJl
Zm9yZSBxdWV1aW5nDQphIG5ldyByZXF1ZXN0PyBGb3IgdXNiX2VwX3F1ZXVlKCksIHRoZSBkd2Mz
IGRyaXZlciBkb2Vzbid0IG5lZWQgdG8gZG8NCm11Y2ggZXhjZXB0IHRlbGxpbmcgdGhlIGNvbnRy
b2xsZXIgdGhhdCAibmV3IFRSQnMgYXJlIHByZXBhcmVkLCBnbyBjYWNoZQ0KYW5kIHByb2Nlc3Mg
dGhlbSB3aGVuIHBvc3NpYmxlIiBpbiB1c2JfZXBfcXVldWUoKS4NCg0KDQo+ID4gPiANCj4gPiA+
ID4gVGhpcyBpcyBtYWtpbmcgdGhlIGRyaXZlciB3YXkgbW9yZSBjb21wbGljYXRlZCBhbmQgcG90
ZW50aWFsbHkNCj4gPiA+ID4gaW50cm9kdWNlIG1hbnkgYnVncy4NCj4gPiA+IA0KPiA+ID4gUG9z
c2libGUsIGJ1dCBub3QgdW5zb2x2YWJsZS4NCj4gPiA+IA0KPiA+ID4gPiBJIG1heSBiZSB3cm9u
ZyBoZXJlLCBidXQgSSBzdXNwZWN0IHRoYXQgYnkgbXVsdGlwbHlpbmcgdGhlIGludGVycnVwdA0K
PiA+ID4gPiBoYW5kbGluZ3MsIHlvdSBfbWF5XyBzZWUgaW1wcm92ZW1lbnQgZHVlIHRvIHRoZSBh
IGhpZ2hlciBjaGFuY2UgYmVpbmcNCj4gPiA+ID4gc2VsZWN0ZWQgYnkgdGhlIHNjaGVkdWxlci4g
SG93ZXZlciwgdGhlIG92ZXJhbGwgbGF0ZW5jeSB3aWxsIHByb2JhYmx5DQo+ID4gPiA+IGJlIHdv
cnNlLiAoY29ycmVjdCBtZSBpZiBJJ20gd3JvbmcpLg0KPiA+ID4gDQo+ID4gPiBJIGRvdWJ0IHRo
YXQgaXQgd2lsbCBiZSB3b3JzZSBpZiBlYWNoIHNvZnRpcnEgY2FuIGJlIGhhbmRsZWQgb24NCj4g
PiA+IGRpZmZlcmVudCBjcHVzIGF0IHRoZSBzYW1lIHRpbWUuDQo+ID4gDQo+ID4gU2VlIGNvbW1l
bnQgYWJvdmUuDQo+IA0KPiBUbyBzb2x2ZSB0aGlzIGlzc3VlIEkgc2VlIHR3byBvcHRpb25zOg0K
PiANCj4gV2UgY291bGQgZWl0aGVyIGRvIHRoaXMgYnkgaGF2aW5nIGRpZmZlcmVudCBpbnRlcnJ1
cHQgdGhyZWFkcyBwZXIgZXANCj4gbGlrZSBpbiB0aGlzIHBhdGNoLg0KDQpJJ2QgbGlrZSB0byBh
dm9pZCB0aGlzLg0KDQo+IA0KPiBPciB3ZSBlbnN1cmUgdGhhdCB0aGUgY29tcGxldGUgaGFuZGxl
ciBpcyBub3QgcnVubmluZyB0aGF0IGxvbmcuDQoNClRoaXMgc2hvdWxkIGJlIHRoZSB3YXkgdG8g
Z28uIEF0IHRoZSB1cHBlciBsYXllciwgeW91IGtub3cgd2hhdCB0YWtlcw0KbG9uZ2VyIHRvIHBy
ZXBhcmUgYW5kIHdoYXQgcHJpb3JpdHkgdGhlIHdvcmsgb2YgZWFjaCByZXF1ZXN0L2VuZHBvaW50
DQpzaG91bGQgYmUuDQoNCkZyb20gdGhlIGR3YzMgZHJpdmVyLCB3ZSBjdXJyZW50bHkgZG9uJ3Qg
aGFuZGxlIHRoZSBjb250cm9sbGVyIHdpdGgNCiJNdWx0aXBsZSBJbnRlcnJ1cHQgU3VwcG9ydCIg
Y29uZmlndXJhdGlvbiB3aGVyZSBlYWNoIGludGVycnVwdCBsaW5lIGlzDQphc3NvY2lhdGVkIHdp
dGggYSBzZXBhcmF0ZSBldmVudCBidWZmZXIgYW5kIGVuZHBvaW50LiBTbywgaXQgZG9lc24ndA0K
bWFrZSBzZW5zZSB0byBjcmVhdGUgZGlmZmVyZW50IGludGVycnVwdCB0aHJlYWRzIGZvciBlYWNo
IGVuZHBvaW50LiBGb3INCmFwcGxpY2F0aW9ucyB0aGF0IGhhdmUgbWFueSBlbmRwb2ludHMsIGRp
c2NvdW50aW5nIHRoZSBsYXRlbmN5DQppbnRyb2R1Y2VzIGJ5IHRoZSBmdW5jdGlvbiBkcml2ZXIs
IHdlIHdpbGwgaGF2ZSBtb3JlIGxhdGVuY3kgZnJvbQ0KaGFuZGxpbmcsIHNjaGVkdWxpbmcsIGFu
ZCB3YWtpbmcgdXAgaW50ZXJydXB0IHRocmVhZHMuDQoNCj4gDQo+IFRoaXMgY291bGQgYmUgZW5z
dXJlZCBieSBwcm92aWRpbmcgYW4gaW50ZXJmYWNlIHRoYXQgaXMgc2ltaWxhciB0byB0aGUNCj4g
dGhyZWFkZWQgaW50ZXJydXB0IGludGVyZmFjZS4gVGhlIGNvbXBsZXRlIGhhbmRsZXIgc2hvdWxk
IHRoZW4gb25seQ0KPiB3YWtlIHVwIHRoZSBjb3JyZXNwb25kaW5nIGNvbXBsZXRlIHRocmVhZC4N
Cj4gDQo+IFRoaXMgcG9saWN5IG9mIGEgc2hvcnQgcnVubmluZyBjb21wbGV0ZSBoYW5kbGVyIGFs
c28gc2hvdWxkIGJlIGNvbW1lbnRlZA0KPiBzb21ld2hlcmUgaW4gdGhlIGtlcm5lbC4NCj4gDQo+
IFdoaWNoIGJyaW5ncyBtZSBiYWNrIHRvIHRoZSBvcGVuIGRpc2N1c3Npb24gd2l0aCBhdmljaGFs
LCB3aGVyZSBJDQo+IGFscmVhZHkgbWVudCB0aGF0IGl0IHNob3VsZCBiZSBwb3NzaWJsZSB0byBj
b21wbGV0ZWx5IHJlbW92ZSB0aGUNCj4gdXNiX2VwX3F1ZXVlIGNhbGxiYWNrIGZyb20gdGhlIGNv
bXBsZXRlIGhhbmRsZXIuIFdlIHRoZXJlIHNob3VsZCBvbmx5DQo+IHVwZGF0ZSB0aGUgYnVmZmVy
IHN0YXRlIGFuZCBtYWtlIHN1cmUgdGhhdCB0aGUgcHVtcCB3b3JrZXIgd291bGQgdGFrZQ0KPiBj
YXJlIG9mIHF1ZXVlaW5nIHRoZSByaWdodCBidWZmZXJzIHRvIHRoZSBkd2MzIGRyaXZlci4gSSB3
aWxsIGdvIG1vcmUNCj4gaW50byB0aGUgZGV0YWlscyBpbiB0aGlzIHRocmVhZDoNCj4gDQo+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8xNzE5MmUwZi03ZjE4LTQ5YWUtOTZmYy03MTA1NGQ0
NmY3NGFAZ29vZ2xlLmNvbS8NCj4gDQo+ID4gPiA+IFRoaXMgd2lsbCBhZmZlY3Qgb3RoZXIgYXBw
bGljYXRpb25zLg0KPiA+ID4gDQo+ID4gPiBMZXQncyBtYWtlIHN1cmUgd2Ugd2lsbCBub3QgYnJl
YWsgYW55dGhpbmcgb24gdGhlIHdheS4gT2theT8gOikNCj4gPiA+IA0KPiA+ID4gPiBMZXQncyBu
b3QgZG8gdGhpcy4NCj4gPiA+IA0KPiA+ID4gSSBhY3R1YWxseSB0aG91Z2h0IHRoYXQgdGhpcyBp
cyBldmVuIHJlcXVlc3RlZDoNCj4gPiA+IA0KPiA+ID4gaHR0cHM6Ly9kb2NzLmtlcm5lbC5vcmcv
dXNiL2R3YzMuaHRtbA0KPiA+ID4gDQo+ID4gDQo+ID4gVGhhdCdzIGEgdmVyeSBvbGQgYW5kIG91
dGRhdGUgVE9ETyBsaXN0Lg0KPiANCj4gV2Ugc2hvdWxkIGVuc3VyZSB0aGF0IHRoaXMgY2hhcHRl
ciB3aWxsIGJlIHJlbW92ZWQgdGhlbi4NCg0KU3VyZSwgd2UgY2FuIHJlbW92ZSB0aGF0Lg0KDQo+
IA0KPiA+IFdlIGRvbid0IHVzZSB3YWl0X2Zvcl9jb21wbGV0aW9uX3RpbWVvdXQgaW4gdGhlIGNv
bW1hbmRzLiBEdXJpbmcNCj4gPiB0cmFuc2ZlcnMsIHdlJ3JlIHVzaW5nIFVwZGF0ZSBUcmFuc2Zl
ciBjb21tYW5kLCBhbmQgaXQgY29tcGxldGVzIGFsbW9zdA0KPiA+IGltbWVkaWF0ZWx5LiBUaGUg
b25seSB0aW1lIHdoZXJlIGEgY29tbWFuZCBtYXkgdGFrZSBhIGxvbmdlciB0aW1lIGlzDQo+ID4g
d2hlbiB3ZSBuZWVkIHRvIGJyaW5nIHRoZSBkZXZpY2UgZG93biBmb3IgcmVzZXQvZGlzY29ubmVj
dCBhbmQgc3RvcA0KPiA+IHRyYW5zZmVycywgYnV0IHRoYXQncyBub3Qgd2hhdCBjb250cmlidXRl
cyB0byB0aGUgcHJvYmxlbSBoZXJlLg0KPiA+IA0KPiA+IEludGVybmFsIHRlc3RzIHNob3cgdGhh
dCB3ZSBjYW4gYWNoaWV2ZSB2ZXJ5IGNsb3NlIHRoZW9yZXRpY2FsIFVTQg0KPiA+IHNwZWVkcyB3
aXRoIHRoZSBjdXJyZW50IGR3YzMgaW1wbGVtZW50YXRpb24uDQo+IA0KPiBHcmFudGVkLCBidXQg
b25seSBpZiB3ZSBlbnN1cmUgdGhhdCB0aGUgY29tcGxldGUoKSBjYWxsYmFjayBpcyBub3QNCj4g
ZGVzdHJvaW5nIHRoZSBydW50aW1lIGR1cmF0aW9uIGFuZCBwcm9iYWJseSBubyB1c2JfZXBfcXVl
dWUgaXMgbmV2ZXINCj4gY2FsbGVkIGZyb20gdGhlIGNvbXBsZXRlIGNhbGxiYWNrLg0KPiANCg0K
UmlnaHQsIHdlIGhhdmUgdGVzdHMgdGhhdCBwcmVwYXJlL3Byb2Nlc3MgcmVxdWVzdHMgd2l0aGlu
IHRoZSBjb21wbGV0aW9uDQpjYWxsYmFja3MsIGFuZCB3ZSBoYXZlIHRlc3RzIHRoYXQgcHJlcGFy
ZS9wcm9jZXNzIHJlcXVlc3RzIGluIGEgc2VwYXJhdGUNCndvcmsuIERlcGVuZGluZyBvbiB0aGUg
YW1vdW50IG9mIHdvcmsvbGF0ZW5jeSBuZWVkZWQsIHdlIGltcGxlbWVudCBpbiBhDQpjZXJ0YWlu
IHdheS4gZS5nLiBmb3IgVUFTUCB0ZXN0cywgdGhlIHByb2Nlc3Npbmcgb2YgdGhlIHJlcXVlc3Qg
aXMgb24gYQ0Kc2VwYXJhdGUgd29yayB0aGFuIGNvbXBsZXRpb24gY2FsbGJhY2suDQoNCkJSLA0K
VGhpbmg=

