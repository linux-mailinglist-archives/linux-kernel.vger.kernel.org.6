Return-Path: <linux-kernel+bounces-512134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18517A33499
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A261B7A327F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29380137C2A;
	Thu, 13 Feb 2025 01:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="sdBbx3hw";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="C4v5O6/y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="O/BrW6H6"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E4E78F26;
	Thu, 13 Feb 2025 01:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739409929; cv=fail; b=b1+D0bRB53motHRbesjdKH6RF+qtOloRAZEVBBYF1ufwMRgNK9WDVo5E5bNWCSZth7PzJB7K3n8Nsh3ldbFqxR4uMJ0+1aNIvYVNJi8vofUEFyG1pcx7KRMKYKK3rdMwofzaQ8RSkgq2aVI5+rmhoZcXN3Hazv5sAywFHxWi6q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739409929; c=relaxed/simple;
	bh=mpDbz35k71jNoe3GFA5dS0VJwppoiAkn25J6tdA5aHk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EOkAxnigyqEDX6HaNdkBVtYcFPo5YMTP4+BWPUW6ZHZTWFJWZzwX1Y5B3vt8iVS8d/s91JKlxDeoMX5VQ7NsUddRQ6K1jJ/KMXpYVtDPxj3oH9y43M+4cnStwO/WWoV9t8IlVNssCPmOwwQZh4tY+uaDZmI4muKLVraEY5u9bm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=sdBbx3hw; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=C4v5O6/y; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=O/BrW6H6 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CLMwiV011304;
	Wed, 12 Feb 2025 17:25:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=mpDbz35k71jNoe3GFA5dS0VJwppoiAkn25J6tdA5aHk=; b=
	sdBbx3hw1OmGLxq4NOlxW9IXgeQEFwcM+TtF00TDIfDfY20WqU5XMgVWqdelEwt4
	pQDSKrb5y058GqteL0IxlTVpWlP158HN2YJd2iP03OTD7dOgYc0Z2ZOgyW+0wW8z
	9kZFev8R0HocnIa//HW4fKDH6QwvaiXFec1pDHsj9eqb6ovA6iHvnOdAEye6cOKg
	wy7Lhlt9DOTiiyVb6ODYhLgcLml1Eybrhi90rv/F3QzbMyS1ryHG+s/m5QHetwtr
	Igpk1TqJXdL3geOAJ1Mvo4q2HCZf5Djb4HPR6s20csdh4lWslgWT/8/AO+YU3rqp
	oaAmh+BR4bb6mqhvpRn17Q==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 44ruhebu3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 17:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1739409916; bh=mpDbz35k71jNoe3GFA5dS0VJwppoiAkn25J6tdA5aHk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=C4v5O6/yO7Px4+kP6J/9Amm0JFU5l2R2KZGwg3MeYGemLKuZJFvFuILkRUEEmA5r4
	 JfKZ9dHhzzO3i+iGNZeOyiUmp7G/Hsd/hIYjy2lobRqTo0XJIu3uY3kaLj1IL6Kyj6
	 7WweiSnos72N38yUfMeQx/g+MBebg7LNBlj05V9CT2cZ4c6TL57HSZ04QuRF+iHy3j
	 yjLt/z2t5Rea8Y3GjQVfLvMpdAE9QJ8S/WkvVyNH+J9umRN8K2IjH8d3EFUGt4AzTJ
	 Al6qYehkDDYjAULR9Dpn39uxjcpjcdp/G+27RigP4bm+AJwnhjpsc0UHKZAE+1nXwW
	 Dm+CPyAwJR0Qw==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 667654013E;
	Thu, 13 Feb 2025 01:25:16 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id B99ACA0077;
	Thu, 13 Feb 2025 01:25:15 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=O/BrW6H6;
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 330EA4041E;
	Thu, 13 Feb 2025 01:25:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FF+Xoj3xzqwHr/1/GdSNtD8Q/5LJCAxr0g5nYVDVAC8mQI+XdXH63QrGqHthyhwC+HaAWWheA/XljaKBDcQ+dQrU7suUOP1wNeZAOe3I9VJi+EdWMNfTmU8MioOfBqtZ5i+FCG1X/GvTc/6TXcsSjKIxkjXT2HeVFYGBrmO2PKSgzsCCWs3LQGWsDhnWZWMfalErQARAfD4GsLRTLYrLZV5C4O0KPOXacKiWMrI/EGlsuaDE+KJHCC0/ibLvDhcg8o0W+xdspO9av36iMrgOeZDHkWnjxEgYvrIeT4VE7jpYiz7VeiJw1nOwRkoWmULplXrex1PWQt4tOu5J0jjqVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpDbz35k71jNoe3GFA5dS0VJwppoiAkn25J6tdA5aHk=;
 b=AinvYL/QghMwtK+TTypI/Z1tYwrGzNaoq/HcGYMtdIABpOizH1O9m6xXUMM3AfD+iQRyNSmrA9Nkc8YsktGn0rPpcx3wPujzU1wOalvavoUpyNPlbBJ3uroH4SY47WFd3uX8ZyOxa0f9iRLpJ99U2Rc8Wt6Is5HkyZCS6o3COePmaaT8svTKsJAE6ABkmujU234wcoKIn4v49hpF0Ow7fd155jMfqsaX3nIfFIbiFE6+JkPa9YaiLt+60omYAcNFJT7tkFZN91h5+DneYEtGWuvO9qWJArkwZ/tsXOr5/7yusRogfvJtOH5A73KC6E67HJ7gTg80TUrHYXDA61Kstg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpDbz35k71jNoe3GFA5dS0VJwppoiAkn25J6tdA5aHk=;
 b=O/BrW6H6vPQEFx7yMTPGYWhekMaANJUPRzv6mNSO9ewpeusmA8QCc6DVcaGCTQs8Q53XnG0ge71d1W8JrFfrBCqNJGmxdC/t1srl+X1czQ9ogR2bo4eJfs8EGS6XoS34tVN2iyWJ2n4Gfvd/E3BzqCpKE9/mPQd8grgpZVyRMZI=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 01:25:12 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 01:25:11 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi
	<balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Ferry Toth <fntoth@gmail.com>
Subject: Re: [PATCH v2 2/3] usb: dwc3: gadget: Add support for
 snps,reserved-endpoints property
Thread-Topic: [PATCH v2 2/3] usb: dwc3: gadget: Add support for
 snps,reserved-endpoints property
Thread-Index: AQHbdnAAit2sY24YUU+11LLZH+RUWrNC6NyAgACeGQCAAPXlAIAAAoCA
Date: Thu, 13 Feb 2025 01:25:11 +0000
Message-ID: <20250213012507.rzmyweziti4rbtz7@synopsys.com>
References: <20250203191524.3730346-1-andriy.shevchenko@linux.intel.com>
 <20250203191524.3730346-3-andriy.shevchenko@linux.intel.com>
 <20250212011013.xumqgguhluxdslpz@synopsys.com>
 <Z6x5lB4hGpz-9IzS@smile.fi.intel.com>
 <20250213011610.ov3q2rq6bfzdzqlk@synopsys.com>
In-Reply-To: <20250213011610.ov3q2rq6bfzdzqlk@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SN7PR12MB8770:EE_
x-ms-office365-filtering-correlation-id: c6ddefe5-9480-426a-72c9-08dd4bcd42ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZUtQSTEwck9JcTVyMjFMMFY4d2ZWK2cvZjYvdU9GekYzRm9kbElSWFpzNXd2?=
 =?utf-8?B?RDNLakw2TTl0bFprd3krMlBrZTNkY0M3MnZvbm9aWHhydytTblRpMklpRW5j?=
 =?utf-8?B?enVrc0M4d0o2SGRJZUFyUzR3azRCR21PRkNnUlBKWE9Ld01lYnMyRHB6cllx?=
 =?utf-8?B?SStiZnJnNDBKcjZpV0tHaG5JQ2V6T1FYeE02MVp5YXN3MUptYm9kaVFMVjdY?=
 =?utf-8?B?WHpneWt1RGV0dDl0RHVrSmViR3RIc0ttQlJ4cy9FZWFNZm8rTG1JaFVsQ2Nn?=
 =?utf-8?B?bG9EbGljcGlkTGlZSEZ4Si9BSHl1WnJjMjFqbDJYWWlmaVVhVkFwNElFYlpo?=
 =?utf-8?B?SW1KUlI5VDNvcWNKeGxpV2I4akI2VHhCMDk5TUVwOXUycmxieWt2K0E4WXhY?=
 =?utf-8?B?Um9lNDZ3dHEydXdTaWtqbnpUN0lWQ0xoTDFkLzhKM3BHTFE4dzBJNHpZekYw?=
 =?utf-8?B?VVdmaHdUK2E4L0dqVmtxeUgzMndNb2taTWFFejZmVUg5RzNxQ2pKMVBBMW45?=
 =?utf-8?B?ZjZ5dm9tMEVnT2UxaXNFbGVhVDVmbWUzdkUzbS8rUUh5WGhTV3BnQmZTMEEw?=
 =?utf-8?B?NHJsSFdRTXJvalFnU1RncmJCclFNbGVzYVhaNlJlM281OVhUc0N2WmpGa243?=
 =?utf-8?B?eFhMc0pzSURlblBvbTBKRkUvaUZicTUzNDRnUSsxVVNYcXRKTTZZM3dCeWJR?=
 =?utf-8?B?S05NSDZNU0x0bU1paEdxVHY1MDJEQUFEelk1S25sOFFjMEJaVlJQNUo2c3li?=
 =?utf-8?B?SFdKcUJqZm9lc1lMSm1BS1hvYTNIV0wxU0VhN1kxYWRPclJGSFNFTTlTVGRo?=
 =?utf-8?B?dUVoQ3o5eVFqdmszRzQ1NjJ0WUVRUW92TXFVVU13WjlpS044THdhM0tzcU0z?=
 =?utf-8?B?K3VDdE8xRnBZV2ZLb2IyakJTdmNJaWlreXNOQkpvNkhGZWV0V3B4bWNWUDRO?=
 =?utf-8?B?SWh4L0wwOWpDS3lhd0JhNHhZTVN5Ky9CcHo3UmlnakpKUHlmbUVxVzRsR09a?=
 =?utf-8?B?SnJaaVZtVFYySldtL25qKytaaVh6c0s4blRETjVDSlhoUVNLbnJsNW8xNW9o?=
 =?utf-8?B?U1FGaHhmM1FTdVdQSms3TkJOaUlMblljN09yRC9QVEdTbmEwZ2tjVGMxNCtn?=
 =?utf-8?B?RTRUMStqd2dhd3dzU2hIZzhvZVQ2aXdZbW5IYSt6c3FYMnB5M2sxZkI3SllR?=
 =?utf-8?B?VGMxT0FyZzI3RGFJSnZoM3YwcGJ1VnpqaDNSc3dEbFNmTzAwYlBkMnhMY3pz?=
 =?utf-8?B?L3JOZDNOTzA3Z3hvcDVNRkdtZmJDVDFtdEFLQ29GaW5mU0VhaDN4Z3lXV0U1?=
 =?utf-8?B?V3h6Mmt6d0ZMUFhWUEFtOVkwQnFvcFU5VlRqQmNlVllsanpxS3ZIbktMTzR2?=
 =?utf-8?B?cEU2ekIzUUFZWEFQSUJRRkZhM0xEUGorMDNabjljRWRkYm9tZmJWSXNtZTk0?=
 =?utf-8?B?dGJLU2ZISGxGSVZlMmhndEx5K0dFNVdhb1ZBdS9ubi8wcVJkSzFaemJrY3Vy?=
 =?utf-8?B?cEJBdXhyQzI5WC9uMDRMaCtyMU5ObnZQV1ptVmNjTWNYZWlxTE4rbDVHRE93?=
 =?utf-8?B?SThCSXIxUDRsamVKNkZIRW5iUjlpSHdkWlFpek5hRS8ydzNUdGlTL21WME1F?=
 =?utf-8?B?eko5eVZYd3NEalJPcGRFMG9vTkVuc3FvbFk1WEVjZElJSnhmY2ZzSXdyc0ZQ?=
 =?utf-8?B?eVhnT0FHd3hiUXoxcU5wOEoxdlJiWnM0eG1oSTRJbEh5RW1PSExZeGZwa0Rp?=
 =?utf-8?B?anExdGJEalQyRjNBNnNDU0VBK3drY0lMZ0ovRkRGNHFTTzljQm5aTW9CMFdX?=
 =?utf-8?B?RjlwZTIzZ0RmYkFaRkZNc25mcThhTGsyWnU3QmZHVm5OdkZxazdRMTlWcnND?=
 =?utf-8?B?U1BHNzZrcVJLaFE0ZlZkUWs5U3phTnh5R1BXSnJsbFREMXJJK0tkZGF0SGdi?=
 =?utf-8?Q?kg+cF4sKXZPHub/Rtk5bSwP3q7N7X7o0?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TEJvTWswTWdESmdGYXVRdUtkM2pPcWZ2RFdmSStHQzJWY1VGT2VMd0JRQTBm?=
 =?utf-8?B?TGdwemErT0ZQb096NmFTdGExRzB6cy96QWJBV0VFc0YvZWJoZDd2V3hNWHdr?=
 =?utf-8?B?RnZ6a3lrT0JhNjJseWJLK1FiL3BwVUZvTU55c2YrNDB1ZkwzQVYrMkduZDBl?=
 =?utf-8?B?Zk9MMXFkMkxDcWZ3cVgveC9QdHBpTVFrVWhTVVlJZVNkeUYvaDd6ZHAzdEVa?=
 =?utf-8?B?czQ2TE1uN2h6ZlhmelYzWHZYblJxOUFya3VNQWRDTXcyNGFKMkdXYTVzelI1?=
 =?utf-8?B?UWZKRllqTTFyWVIrMStneEtBSFhsdlFhRlRBUDJMWHVFSkF6NmJndWJkb3BL?=
 =?utf-8?B?eTI1V0VXWmlMTnJQSWx6c2RjNkp1YkludS9yK3JabHNSK1Y2VlEyNUs5VGt4?=
 =?utf-8?B?Wkc0U2pZNm4yditGdmJPTHVWL092SyszUUgvaUtPaDVhdXM1VTh1cHBGVTFK?=
 =?utf-8?B?Sk15dDdkUmR2TmVZKzNsOHRoSU85VEJ5WE5LTHk3U28wYWNnbGlpR3YwSWhM?=
 =?utf-8?B?RnZ0TVBvMm5VQ0p3dm9teW56Q3ZPODJmQWNqVERIdXdIOG5FWEJkWkhSS3B0?=
 =?utf-8?B?K3BJTEZLUlA0Z015M25scmVSV29lZ0FPU2hjcDJzVWJCZHI2ZzNaNnppUEU0?=
 =?utf-8?B?UkEvRzh4SWxSdldLSTV1eWNoZHZ2TkxNcWhmU01OWjFmZjlDYyt6WnZXMmlP?=
 =?utf-8?B?Z1U5bDczY3lKY1V3bU9hQ2JOM1lWbmptZkpWVUVDcU1ha3paV3FrQi9rRlJW?=
 =?utf-8?B?NGFqOXdGb2dBM1JETkNNWjlMUmNxV3NvakJsTXBlOFFuOS8yU1hEb1RXVGFE?=
 =?utf-8?B?Nm1VZ1hEcW5kVkNCY1YxQWNrQ1pKN0lKOEx4d3hWcVhtTGYzY0hlaXdKTTh3?=
 =?utf-8?B?ZGJTbEV5bndKOTZZVzE2TGdjUDNDMXBFRXdEWmNlWWl1eksxUi9SWnJ4R0ZQ?=
 =?utf-8?B?VDB4WDZMM0xab3pTMURRTXVidzlHSFV1ZS9yRGw0Mlp0emRodmEvQVVzL3lx?=
 =?utf-8?B?MVR6Wk1CRzdGRVYxZUs3cnRQU3Q3dzBDYzJBc0p0dHhXR0FIdWQ4dzFUVnhT?=
 =?utf-8?B?TlpJR1VaZkl0RFgzOFVFcGNqN1ZMTTlRWDQ5L2xXNTVZWFFzRUY4YitzQk1F?=
 =?utf-8?B?enU1dlllUGJoelp4MWxkNUtlYTZiQThlU0hZTS9kTmpkc1dlZjd6WG1OMjRm?=
 =?utf-8?B?N1Q5VkEvc1dxazVWRUYyaWF1MmFNc05yelpJWXJIbXdiVGh2YmRXeFp2SDZG?=
 =?utf-8?B?M0cyTFpFNHB6YWNrNkIwSSttNFhuVGVvS21rRWpsRlNxYURDSW1jS0ZVRVlr?=
 =?utf-8?B?VCt0dmlsSS83TEVlSjJVVG9aRW1sREREQ3N3SkFMZ3pEc2diZmM3bjRvOHd2?=
 =?utf-8?B?TnR6aXFQRkFvcC8rNi9xNnh4WHhhOVVvYVNjZ1ZQSWFZQU52dnR4Mm51ZkxW?=
 =?utf-8?B?TTZhNEM1VEJwK2ErNTAwdWkrOGtaZk1ycUE2WklIK2RsNy9hM3kyQUJETFcz?=
 =?utf-8?B?Nm1yZko4V3dxNDBQSHJLOFJTVTJLUlRsZHpxNXpiVTFKbkEzYWhwMDJTN2Ft?=
 =?utf-8?B?cC9QRGF1YldzMm1xMDVMUVdXQmhuUTF3Ym8yZHprbUZuUFZHbnhWbWNrMkNl?=
 =?utf-8?B?S3lpVDQ4V05HM2l4aVJWQXM0cVNCektaYzZNYjdiWEwveXlwcGR1ZGJoWjhJ?=
 =?utf-8?B?L0RYQ2lDR09NdzdKVXh0STBsS3dNTEt6UlIyTUFtTVV4WlM4NDRWUHM4eU4v?=
 =?utf-8?B?SlpRSE0xS2FUaWM2dGNESk5yVVFpQjhqMEdUOEs5YW5IYXlEZHN0ZnRDUS9C?=
 =?utf-8?B?N09lTjFxOHhYak5vTHNBWnZMSzR6UmxzS3JaOWxXZmFpWEtRR2VDeDVhZzdH?=
 =?utf-8?B?YzRKUHRKWnJRQWVaZnVwYXRCZ2lrRGllS0hkb2ZDT3lNVTdhWDJwdXE3OEd2?=
 =?utf-8?B?WVNYZ0t5UXlmS1lHTk5rU2NNWmhxME1jMHkzQ1B2ZXp4aWZEVDB3SjhNQVhT?=
 =?utf-8?B?ZVRvelpjanN4V2xZdnB3VmFvYkZQSEY3OXNVTHd3ajhxZ0JSRW0xbkUzMXFW?=
 =?utf-8?B?emc0MEdzZzNsVHJKcnF3S1RIM045YnlxYnRnVHlYbUs4UkJibDBNWlRnSy9h?=
 =?utf-8?Q?BD1jkpVpxP571GcwkRAqYVTwX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D83D5A1F5D5F8548923BAB12AE3784F4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zRDPRsu294SXvsp0jWZBrul68/7UtlLQC3zwxdgXlaIps6IdNOECPMKoAq67vaYHoqKyLh4lxJPtBqtFn+O8cG/694Oe4nihAPv+jM6L5bz/PV9+TaLTqAgvdutAKaj9Vagi88+UMXOuFCJSMCcJEQRr9lp5EmAzc/3/tRu2dlUQeMqSmQYMVrTEjXUAFLd3rtyJaqDXUHBjQx/Dg91hhKT/HKYGATStVyaV6gZZuGJGxxPEDMPmU4xxnhJASo778SJRrqNZ5sHPNiawS0fkDcz0bpCYMWwfk4BOUpocODc8sbViGNPOkt+uRZNm4USVeC+RyYL9NHiyjQ10c1bFuSBZkvRMeQqcgAr5SyfkHfvzaPIKaa7LZ6b6vI3t2id9oANVnRxSjc/q0oeb1d3HRt7/8d4pzjNlNa841oxBl97/i5gi9M0vsUysAYdkzz45k8R5Tz4pDFgQr1D2gfz8A+A9Ec3vKfGpq7VE14kJy7B/s67EVnbwspjEp56JM2KkEPsKG3X0gVF17IYDGqCwAJqiky5Ti5MN/2+mtpnZoVklwT+RgkNn7LGg4UZYOIYKK0s0funGyGLPFt4aENSo8yqc2JyEAO8UhorBVn+jvKK0iuUmppc0l1NK3M7VLEbdiAkrHy/LZy3xeZWowQKEwA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ddefe5-9480-426a-72c9-08dd4bcd42ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 01:25:11.9361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tjafhqIL2t/2sWwjkATa1dAAuioRxP8gCoKA8hTo3hhfO31dO4O5Tg5aetvcDKCO620c5pp9rLnudnQUUaSZeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8770
X-Proofpoint-GUID: 6sNg826OATawQgyHhaTx8L7AX12SkeVa
X-Proofpoint-ORIG-GUID: 6sNg826OATawQgyHhaTx8L7AX12SkeVa
X-Authority-Analysis: v=2.4 cv=TP6/S0la c=1 sm=1 tr=0 ts=67ad49ff cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=T2h4t0Lz3GQA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=QDlsGHGxT76qqXU3M6EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_08,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=773 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502130009

T24gVGh1LCBGZWIgMTMsIDIwMjUsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gT24gV2VkLCBGZWIg
MTIsIDIwMjUsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4gPiBPbiBXZWQsIEZlYiAxMiwgMjAy
NSBhdCAwMToxMDoxN0FNICswMDAwLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gPiBPbiBNb24s
IEZlYiAwMywgMjAyNSwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiA+ID4gPiBUaGUgc25wcyxy
ZXNlcnZlZC1lbmRwb2ludHMgcHJvcGVydHkgbGlzdHMgdGhlIHJlc2VydmVkIGVuZHBvaW50cw0K
PiA+ID4gPiB0aGF0IHNob3VsZG4ndCBiZSB1c2VkIGZvciBub3JtYWwgdHJhbnNmZXJzLiBBZGQg
c3VwcG9ydCBmb3IgdGhhdA0KPiA+ID4gPiB0byB0aGUgZHJpdmVyLg0KPiA+IA0KPiA+ID4gPiBX
aGlsZSBhdCBpdCwgbWFrZSBzdXJlIHdlIGRvbid0IGNyYXNoIGJ5IGEgc3VkZGVuIGFjY2VzcyB0
byB0aG9zZQ0KPiA+ID4gPiBlbmRwb2ludHMgaW4gdGhlIGdhZGdldCBkcml2ZXIuDQo+ID4gDQo+
ID4gXl5eICgxKQ0KPiA+IA0KPiA+IC4uLg0KPiA+IA0KPiA+ID4gPiAgCS8qIFJlc2V0IHJlc291
cmNlIGFsbG9jYXRpb24gZmxhZ3MgKi8NCj4gPiA+ID4gLQlmb3IgKGkgPSByZXNvdXJjZV9pbmRl
eDsgaSA8IGR3Yy0+bnVtX2VwcyAmJiBkd2MtPmVwc1tpXTsgaSsrKQ0KPiA+ID4gPiAtCQlkd2Mt
PmVwc1tpXS0+ZmxhZ3MgJj0gfkRXQzNfRVBfUkVTT1VSQ0VfQUxMT0NBVEVEOw0KPiA+ID4gPiAr
CWZvciAoaSA9IHJlc291cmNlX2luZGV4OyBpIDwgZHdjLT5udW1fZXBzOyBpKyspIHsNCj4gPiA+
ID4gKwkJZGVwID0gZHdjLT5lcHNbaV07DQo+ID4gPiA+ICsJCWlmICghZGVwKQ0KPiA+ID4gPiAr
CQkJY29udGludWU7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwkJZGVwLT5mbGFncyAmPSB+RFdDM19F
UF9SRVNPVVJDRV9BTExPQ0FURUQ7DQo+ID4gPiA+ICsJfQ0KPiA+ID4gDQo+ID4gPiBQbGVhc2Ug
a2VlcCBjb2RlIHJlZmFjdG9yaW5nIGFzIGEgc2VwYXJhdGUgcGF0Y2guDQo+ID4gDQo+ID4gSXQn
cyBpbmR1Y2VkIGJ5IHRoZSBjaGFuZ2UgeW91IGFza2VkIGZvciwgaXQncyBub3QgYSBzaW1wbGUg
cmVmYWN0b3JpbmcuDQo+ID4gDQo+ID4gT3IgZG8geW91IHdhbnQgbWUgdG8gaGF2ZSB0aGUgcGF0
Y2ggdG8gY2hlY2sgZXBzIGFnYWluc3QgTlVMTCB0byBiZSBzZXBhcmF0ZWQNCj4gPiBmcm9tIHRo
aXMgb25lIChzZWUgKDEpIGFib3ZlKT8NCj4gDQo+IA0KPiBUaGUgY29uZGl0aW9uICJpIDwgZHdj
LT5udW0gJiYgZHdjLT5lcHNbaV0iIGFscmVhZHkgZG9lcyB0aGUgTlVMTCBjaGVjay4NCj4gVGhl
IGNoYW5nZSBoZXJlIG9ubHkgbW92ZSB0aGluZ3MgYXJvdW5kLg0KPiANCg0KQWguLi4gbXkgYnJh
aW4gaXMgZnJpZWQuIFlvdSdyZSByaWdodC4gVGhpcyBjaGFuZ2UgaXMgbmVlZGVkLg0KDQpUaGFu
a3MsDQpUaGluaA==

