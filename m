Return-Path: <linux-kernel+bounces-237638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8E9923BE3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2768D1F214D7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 10:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333F0158DDF;
	Tue,  2 Jul 2024 10:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="H6Oms9du";
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="H6Oms9du";
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="H6Oms9du"
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01on2114.outbound.protection.outlook.com [40.107.24.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0252C6B7
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 10:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.24.114
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719917720; cv=fail; b=qPPY0nwTIMkG0Zkd6PV1AyGtMNK8r1REGwQFdT17SnOxvMViiKl8HL2Me/Q0WbFIsc9jTyqYTp5DX4ouznaXx3i8hnLaW4GufKRGXAaDP3NllxJbg+F/L0Bbo1OOktUswBaJZYKSEpUkC0a21cWnlURLZF9JcUrFzo0RXbroz8o=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719917720; c=relaxed/simple;
	bh=1Ym4F1o1LhxHVFDIrzIEWNGt1Z7BETxUR3lLdJmVwM0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=A0sgtiuUnXF0iZn3a+svrwB5GtCeGaeFHQDm2uaNc9N1C+Rj3aKPE+hXMXX87IgffdJHqCvfo5IfuJhyazWgaDPS2/GUIOVs5wm4NeaMCfIuMQwsjPCbVGQ6hnBygppn0wW80c6z9LyhRQZuOchnHjctV5UWfTmybMejYCi0e3w=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com; spf=pass smtp.mailfrom=duagon.com; dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b=H6Oms9du; dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b=H6Oms9du; dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b=H6Oms9du; arc=fail smtp.client-ip=40.107.24.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duagon.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=XIWOQd1/+GT1mO5Cz5kvWLB9KlpBXTxcyNQf+gfy3zUMQ+CD9eUsLEdChQIBI1fBOAEOBdUxiANR/v+iDHaLzy1BqIRyIZXLYWS2TSlcMU5N2OLiStDUypvb6u+GPOItlnQQ0fwKI28RMRDtfjnzMe3KImWs4uvg+DQPms0vnkhgY2gl39XUT24tj/NDsgyhOgzoPpJOFgGqQMWG4/TiU935bOS6N2mWcFCY010//g2vDtiAcgK5+xy/2xd1Rl4wHdEqFTePmk+bCH1kqURj5Cfk3ZWj+Ji0Q3nzE/fcFZ9CxCO2sWaeEUTLo4gb7dhn9UP6ptCP+4f+OQqL+13uEA==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m41hXR8JfQGIjkmQTjSTZcEKf1GLGLTwZWGiY1hZM8M=;
 b=kQ7VGFps+iKE9OEoINlA5McLPIaXbrRZ0kP8zOFomU5pIaUWVhiuHFWe2Lznzb/+bVJVxf8WP4uKsWuY2qv0+L5mTk1c2LEtY3X74uYAnlMUO1/jIaPBQ7umiC04EqINXzzuyV7p1GTidLMWJHGRgZIKClx1uFwwya99d0mRb6mIDaQI/XM72bYFUq5zMjEn5KlPQahR+H8pqusL3hRK1COvr7ViD6xo0XIC4MfJ+KEa93f/vthim9cqibG/djT0Y3ao4Ht7kuoWYtocPeRjayB/KArNMyNw32MQoX0Q61wvtceYf05jdFhSNVzCHHYeImoczvKCtAg5No05hoifNA==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=pass (sender ip is
 194.38.86.34) smtp.rcpttodomain=gmail.com smtp.mailfrom=duagon.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=duagon.com;
 dkim=pass (signature was verified) header.d=duagon.com; dkim=pass (signature
 was verified) header.d=duagon.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,2,smtp.mailfrom=duagon.com] dkim=[1,2,header.d=duagon.com]
 dmarc=[1,2,header.from=duagon.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m41hXR8JfQGIjkmQTjSTZcEKf1GLGLTwZWGiY1hZM8M=;
 b=H6Oms9duLmWbzdPqxh9XncmswqdnJzfSxkT6iBs6qUu/EyhkwXce3Euv3ndEPlJ0dtptW1VABMcM5gGwycsY7eJDLOpQwMHGjmO6qZD3ZKDIDkv8yXQ9nlk0YFqis+Cz5fjoMwVU9ZSMagP87B6p6ei382eyW8YLtKaPpz1p8r4=
Received: from DUZPR01CA0164.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::18) by ZRAP278MB0015.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:14::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 10:55:13 +0000
Received: from DU2PEPF0001E9C2.eurprd03.prod.outlook.com
 (2603:10a6:10:4b3:cafe::4e) by DUZPR01CA0164.outlook.office365.com
 (2603:10a6:10:4b3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23 via Frontend
 Transport; Tue, 2 Jul 2024 10:55:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.38.86.34)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 194.38.86.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.38.86.34; helo=securemail.duagon.com; pr=C
Received: from securemail.duagon.com (194.38.86.34) by
 DU2PEPF0001E9C2.mail.protection.outlook.com (10.167.8.71) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7741.18 via
 Frontend Transport; Tue, 2 Jul 2024 10:55:11 +0000
Received: from securemail (localhost [127.0.0.1])
	by securemail.duagon.com (Postfix) with SMTP id 4WD0DZ5gspzxpF;
	Tue,  2 Jul 2024 12:55:10 +0200 (CEST)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01lp2105.outbound.protection.outlook.com [104.47.22.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by securemail.duagon.com (Postfix) with ESMTPS;
	Tue,  2 Jul 2024 12:55:09 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=cJCl5eaD3+yIajlX6URoCprZRNoJC8+dbGtMcIUfcRLitLw/XQ6L83/pk1deT6DKSZHIIijjsJvxHiPznjB0dZMoayfFxy7Og4teW3HUUT6gGWtJQYewjF8oL44+rBaUjAl5SK17RLt9TlhERzx2kjD/vfCqL3nPxIWG7XS2dnOovgvEhQKQy/OzXV+Q3WFREpOL1UQETJDTldizesMuiFXoNRX3kg2mV4a94H9WLB/sWeYTxRfPLsn+DCkWwC+8nqDWuir8lNk/YTXIK49MzyEsiuwreHQNCsnIhhLer9i6JhfSdIUWO0Z1mdtMt2LUYE4xhEWZ2WJIF6P2fqF5iQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m41hXR8JfQGIjkmQTjSTZcEKf1GLGLTwZWGiY1hZM8M=;
 b=kF2yuG3twCs3l1ZGKYc80osvOvvv/GEPeEs20ETV2Z0MsD5Kgc86Zf6Naws9e7ddYX7sVd5XhlK5N4zwIAp89OPPqsArbqERz6xUM2Q/M3OlEGHZAdEehIleMYE/KASGWj+2pCen9UPntrTH52WitJ97BR/Tzw3mElPpPOihCfUyo+pD3QNLIVqhkjo4P6qEpwVddbgWJA0AoWf0+N3ZHiCDWRdg9A84PAfqtB+45x/0HoIr9vOZlZ19VQ4fGCRAZ0KBVHQ1bWPNkzQth1b9hrHcbNhNb5k1avF+z4dYFPIq2QYtSBEfDigBrXPK8z8W820rwY5iNW9o+2BmNJljwg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.79.220.33) smtp.rcpttodomain=gmail.com smtp.mailfrom=duagon.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=duagon.com;
 dkim=pass (signature was verified) header.d=duagon.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=duagon.com] dkim=[1,1,header.d=duagon.com]
 dmarc=[1,1,header.from=duagon.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m41hXR8JfQGIjkmQTjSTZcEKf1GLGLTwZWGiY1hZM8M=;
 b=H6Oms9duLmWbzdPqxh9XncmswqdnJzfSxkT6iBs6qUu/EyhkwXce3Euv3ndEPlJ0dtptW1VABMcM5gGwycsY7eJDLOpQwMHGjmO6qZD3ZKDIDkv8yXQ9nlk0YFqis+Cz5fjoMwVU9ZSMagP87B6p6ei382eyW8YLtKaPpz1p8r4=
Received: from AS4P190CA0035.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d1::11)
 by GV0P278MB1300.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:5a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.34; Tue, 2 Jul
 2024 10:55:07 +0000
Received: from AM3PEPF0000A794.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d1:cafe::b0) by AS4P190CA0035.outlook.office365.com
 (2603:10a6:20b:5d1::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.34 via Frontend
 Transport; Tue, 2 Jul 2024 10:55:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.220.33)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.220.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.220.33; helo=de1-emailsignatures-cloud.codetwo.com; pr=C
Received: from de1-emailsignatures-cloud.codetwo.com (20.79.220.33) by
 AM3PEPF0000A794.mail.protection.outlook.com (10.167.16.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.18 via Frontend Transport; Tue, 2 Jul 2024 10:55:06 +0000
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (104.47.22.105) by de1-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 02 Jul 2024 10:55:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfXF81aITJUlo8BaTUGDck+InC7c1fAgkAmYeG9KohJjMW2uKEtaMALXiJ5OB09VWAegfLqwKkmj5IfVfvdTU/NA5kbVlSJMn7jbAwLTGiIl+40+7AVmZhwcICY9jQBmutItP81M+5BDHLNTlY3Q9zhNme8QrbgMl9zxvQCXhviNcfHyuxEYCrzUEadOFS0lc86V+/apUtLGOiqbjTDdzfOAcNDWLbCgteZVlgevKy2HrNZQgvsyAh+gCnXPo8vVOL28FvVocpz7DX81C/EyNt1AZ6+B9Zd7uGFBWC3YZc/n28J/jQmaNl9A8zUQnp4FizPuF6qroDP1da5CDrnRdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m41hXR8JfQGIjkmQTjSTZcEKf1GLGLTwZWGiY1hZM8M=;
 b=MokKD+f2FRaZpbgO/1HR8p0SIZ6PJVUVfGSaxL2mg64od4DRnOkiUAJuA3pHrQcdd0AhYwsLXld//CT3lnnPBFiHIzDUzstdW1/Prm1sZ3xg8aoHr9d5sylmQNhmweLq0T1GkcPdR4J9xnrvkLQhqBh+VDcMUtgse4UJpMAHBBgxEhL+856qQvhhVGdZynhN/HUbCeg/LduEplXkr5ylLKXXXI7Zx7+zw76KGzV9mqzokad9QOjF1oxEN849ASuwUDb7EbSSQf5PjUBgBkBQU9x6I3nlmo0I6304G8a2NumzGp+cEIry4KvWoJt/J61/5bZ4jSNe06W0yZOzvss7sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m41hXR8JfQGIjkmQTjSTZcEKf1GLGLTwZWGiY1hZM8M=;
 b=H6Oms9duLmWbzdPqxh9XncmswqdnJzfSxkT6iBs6qUu/EyhkwXce3Euv3ndEPlJ0dtptW1VABMcM5gGwycsY7eJDLOpQwMHGjmO6qZD3ZKDIDkv8yXQ9nlk0YFqis+Cz5fjoMwVU9ZSMagP87B6p6ei382eyW8YLtKaPpz1p8r4=
Received: from GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2e::11)
 by ZRAP278MB0030.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:14::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Tue, 2 Jul
 2024 10:55:00 +0000
Received: from GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ae7a:9620:b675:152e]) by GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ae7a:9620:b675:152e%7]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 10:55:00 +0000
From: =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?=
	<Jorge.SanjuanGarcia@duagon.com>
To: "morbidrsa@gmail.com" <morbidrsa@gmail.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>
CC: "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jth@kernel.org" <jth@kernel.org>,
	=?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?=
	<josejavier.rodriguez@duagon.com>,
	=?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?=
	<Jorge.SanjuanGarcia@duagon.com>,
	=?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?=
	<josejavier.rodriguez@duagon.com>
Subject: [PATCH v2] mcb: mcb-pci: detect IO mapped devices before requesting
 resources
Thread-Topic: [PATCH v2] mcb: mcb-pci: detect IO mapped devices before
 requesting resources
Thread-Index: AQHazG5IfwUJ/JpLxEuXudoXtw/mEQ==
Date: Tue, 2 Jul 2024 10:54:59 +0000
Message-ID: <20240702105435.566617-1-jorge.sanjuangarcia@duagon.com>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic:
	GV0P278MB0516:EE_|ZRAP278MB0030:EE_|AM3PEPF0000A794:EE_|GV0P278MB1300:EE_|DU2PEPF0001E9C2:EE_|ZRAP278MB0015:EE_
X-MS-Office365-Filtering-Correlation-Id: 83e3df42-f712-4c3b-80b8-08dc9a85722f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?wLG1k4Cci2U8Y4+DIOFBvm8QhuqIvKWwStJz1ZW1ISTjWgYNhyokKXXBUY?=
 =?iso-8859-1?Q?GgK3uYfz3vioS0HmuiRH0r/BEIUWE2gX02Jw6vun/iNyE5VW+Ixv/2VSx0?=
 =?iso-8859-1?Q?97EYOVOBQf4lB4dyWy9T+x5Ji0upuWykmpZYOYMfgiUSt+QcL9kDEcQJZ/?=
 =?iso-8859-1?Q?bkZIZvP0yBMrthoMqPN8gS7WqGZSryUUH3Xbm4rnp4MM0VVmxi06K1KAOA?=
 =?iso-8859-1?Q?VnTDH/BW7bowZnRwmyZ8hE7qnHlor5VTTAGFp/N4tfSBLiuVKG7N0lFwrH?=
 =?iso-8859-1?Q?6XJBlMixzm7GzCkKf99BFK3xPB9Z3519div+FEvvJeGpVAdTvzKg0leoE7?=
 =?iso-8859-1?Q?BmnxYq5QXq3veJ+54OXQlosC3URxA/eeZI22QeXQAwqIqyAbIwOw41n28a?=
 =?iso-8859-1?Q?ZR6FTL4zu8VXgx0UJGKdvJN/1P5lvHKmdmh00aJPKYm+9tczQCBhgWiK+u?=
 =?iso-8859-1?Q?bPLEtv2MQyiiHbXUCwIutOfEpo+2G9Q5noY0RcwesFEz5VYqdFbD+bWfSg?=
 =?iso-8859-1?Q?QtVsJXRtXtJDYinj31JzzVUXYRmPg+uOA5Abb2baq47mh5pngCKV/cN0Si?=
 =?iso-8859-1?Q?VjXveIIKnB+oCPCF4ie9xSoBe6+unXy/nfOikK0OIWkq7lPIbhzMarbA65?=
 =?iso-8859-1?Q?84vEPPYSgICHwfzHkDrcK3CvxshYJ/h00LiliiqqzKXgIkb6iVyvm2dZG6?=
 =?iso-8859-1?Q?Sn1kuKS1coaETmkjwJ616KT1XdL+JWqT+QFZ18DxHuegDVE/IJ8vIWt6+U?=
 =?iso-8859-1?Q?jicZxZzg2cFWtSZCfs1q1ICzNNpsubLa/ZRatiI6Ub8TrEfKm8euZKT/7G?=
 =?iso-8859-1?Q?NZp8IMxGhFeh5Ck+iUW1G8swTGjZMbiOlHXDTPyzXMOD1WWGMBpoIfaExj?=
 =?iso-8859-1?Q?WcxS59VXd8Ti9NBO+SVytiwTFYYUnr/Ms9TRYzKmcZzj765xunRZkNR6f/?=
 =?iso-8859-1?Q?LgV5V2PJAbwyUSS+4vEEVmoR/e0L5fOVtQ0LkGwEkayZWXYEPnmtnBqUHz?=
 =?iso-8859-1?Q?XfJ9Lp3AbIhMzsdQykxFFd2DQ/1YXoijoxaMmgFkzVG7iZdmIcBeC2OC83?=
 =?iso-8859-1?Q?dq8RPTkPOrKQRERbwbi29l5LQB8r3hDAVdxEEtkN87DOUS7bgFvcAgYnIX?=
 =?iso-8859-1?Q?QTae9KLXWRQTUilVpcJhpOM6HOuaLFjRO+GOiauXjxiRWfLYKINnZtSbPK?=
 =?iso-8859-1?Q?QZrYJ5O8zHWJivB9lyKltLj7xczosXsbo+D4Ko6zzELcjvL2U0Qv7e6WDL?=
 =?iso-8859-1?Q?UqaC06Ppbu3/7WhzbeOoi4uZB5QqPMeKvsEwoXkLBCyi8Qd3HZTLOjgy6W?=
 =?iso-8859-1?Q?AEuZagQsKMn4QJqk5UY3E3srHXjRfQ1+ku6RDcOOYoFnOjgtaRstrZrd6S?=
 =?iso-8859-1?Q?EpP2CCKZKkEbNmXyPHoWSwxHo1hnHUSiQBUMEoNh6Z+ZOymk5qz1JR5Y2E?=
 =?iso-8859-1?Q?AVebT3sx/c8ceuO3763ehTu4ORfNq1scaYFv0A=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0030
X-CodeTwo-MessageID: f6d18617-6eb7-4306-b1bf-0d960703dd3e.20240702105503@de1-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A794.eurprd04.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs:
 9eda8323-405c-4c53-8e75-08dc9a856b46
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|35042699022|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?77VyMoXupJ0dyEE0FK/oghLUSWqRYijskRgArJYMdIz77KyUJtGmY81bQ1?=
 =?iso-8859-1?Q?o35MFreUmsB/ccPvrasI7JFGqdBsd/bSeEYYLskue/k7CvsV703rfR+JUg?=
 =?iso-8859-1?Q?fZOpELEJQPjhz1mkRcgkstVeoWZnFfmZEoThfdbKFP14DTa3NYJ9jTjwbZ?=
 =?iso-8859-1?Q?LP2oYuomMdX3kAffC72K+g6FWT1m4zWVCBpCT6YB8UKQKrj00jB70+w1k1?=
 =?iso-8859-1?Q?W2hqb6q4d/KvqBx43+346f67eER3YnFWQS4G19EdsWamZ98EmMbvdDvHKz?=
 =?iso-8859-1?Q?T7Lrhsn/ZO6zszS89i6vNjss0DPfLqEDqaCurcduM58tNBZAFnx7K2ryHw?=
 =?iso-8859-1?Q?HvDQztza0oFXGgl7jr/f46G+zwPgGqYA/vxgG9RT7wvbvqg6WjsZz472iQ?=
 =?iso-8859-1?Q?qN+BwbsPKG0+bwLUVLIgWcc6qkCdQIS52vtq4OVXcVSLlsFKM3+h2bo6V2?=
 =?iso-8859-1?Q?cbz/FF1mhDg2lv44wiJkpOy7Cl2LvoyVkdzPBJA/C/saV9Odjqefn6nW7r?=
 =?iso-8859-1?Q?Md3UGpcHy1nFiNHXQTZDH1zi5YDQChy4dG33P/ogMFXISFhivXOK/jmzC7?=
 =?iso-8859-1?Q?eNI1CWXECy7WAB7Ci/l8Zeg8vpK2qq1JIZ7qnUzrVOSLw45ZMDzIMkPXTu?=
 =?iso-8859-1?Q?ubOA6DP3erw5tA84bWRRho+0jy1gz97gjWYaS0doS09p4+R740PlMZtJil?=
 =?iso-8859-1?Q?NM68uAoV4nBhcx0ZHKcmfUryAcL6CztzcvtdTca8uw4hLYkScorKD0N1mY?=
 =?iso-8859-1?Q?pPZ7tqkbJU8af+NBAixBqYgaBbCTLg18VsPe8t5p9zz8AfKTN69jyxV1om?=
 =?iso-8859-1?Q?uCd8nzWnb+ttRzOMgh2UzqoT6UT2bvt35xcDMJ7rJmyxJWg599EQfSQPjY?=
 =?iso-8859-1?Q?dQNTQUHVwqkWPl0PhXy+RUh1meo6gwN+2rAU0nHNleo6lAasP8fp4eGjsb?=
 =?iso-8859-1?Q?kYFSbWNi7aYJg8LOrfwNbL5TZozpDYk3SSAo8a8m/+lAH9JqtqSHD0onPy?=
 =?iso-8859-1?Q?Kob6sPbqCM4penjzTCDnn0eqZJKxEvk8zPLueDNakT4sJwKkN5RQ7qf52g?=
 =?iso-8859-1?Q?8Ngw6cnRKzqW9Bd8Kgi1XLEfEA1mEpmpt04jer0II6L7JYT1/TqJWXHoml?=
 =?iso-8859-1?Q?FAEXd9ryAUZYNeydwML3EToZhzbpP4HfE6EeHUX7rxziKY/BtxB+vVVN7P?=
 =?iso-8859-1?Q?ze2jNK+EXOKGtrV0ipYyeQdu82aSKLpvv+3tubF91ghEOyjFj374sMN1iA?=
 =?iso-8859-1?Q?ixz7GAiuU8oWdiyfU3FSWc3Tb99AENKoebZiuDBjIPdllF/zVMR7LXtSek?=
 =?iso-8859-1?Q?Ut7xovE2pQJkaC7ppwBvRvsNuNkQlL5Y9yg+mjlhk8glKhm/v/KIhvU+8Q?=
 =?iso-8859-1?Q?tRSUjSIMrlL5erzMp4ADghkYM9bPijIO0jZVkXVOd0Lvv4pa2IOVEUO0Im?=
 =?iso-8859-1?Q?zzlU/iTMIbgUPIzef1nP/mBZTYlX8QpJHS3AdFohY9CHMQSqItrp58j1Dl?=
 =?iso-8859-1?Q?GnkIEtfYvBbfYyrZmVKahq?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:20.79.220.33;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:de1-emailsignatures-cloud.codetwo.com;PTR:de1-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(35042699022)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1300
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF0001E9C2.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	71df3335-762d-488e-7a8e-08dc9a856f66
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|35042699022|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?Kx2HS8PsJ4JN1fEFqVFiSFpxK14hFs88H8e5olMpzuGWCmxYumT1M/HtMm?=
 =?iso-8859-1?Q?xw1xtGuPm1yO3ZBomCdQgD0oFL0xM2678RPGpzDgY8q2mxL4VsQKQDmnNA?=
 =?iso-8859-1?Q?tHr0py754x/vAvg+stHv30VN83BbquSE8UnnnY22b9HycES3dlKSLfaFjZ?=
 =?iso-8859-1?Q?4SLuRP5CgOiYpe1Vx4OdaxMSnK3ZEeWn6u3oRziUj46y6WDcvnBF3LCwdy?=
 =?iso-8859-1?Q?8xI2jZvdFLpa96P4tPBBkeBbiAEmhVcyE2xhbNUMZ8VhE7ylsBNkyWbr4Q?=
 =?iso-8859-1?Q?7LECdCMR0t0atgeQAvGXV5GFL2M8uMyu3vGlnpBOgd1qSjtlu4IWfYMjOG?=
 =?iso-8859-1?Q?mapBmlwrsnWoTp0VmzfRcdypnxAG2eFA8UX1BYngqiWXNBbkgFgk8rCG2L?=
 =?iso-8859-1?Q?ShcDthx+CzoOS/2RcwMrlLwDSzUmgolrPLkChFc585MqUlBGDoA8LPGf4P?=
 =?iso-8859-1?Q?HtXoRo/wJ6RZUe3J49Q0VoOiwPLF0bppOKaWaBUMXWLF5d0jI6emswlgdH?=
 =?iso-8859-1?Q?mYz+D6k2sYoZ6oUQ8Xn2LLEXqRkpA1F/m7/PqVbjuWgiuXJ30xpNpg6t4/?=
 =?iso-8859-1?Q?M4+tQdYU6yMFBoXPH+OM0J7CNa5YdQoV11slFkk8Khsix3PB49xN87dGEI?=
 =?iso-8859-1?Q?G595OB7NedWcmk5BIucHEZihPoLd63A2/jYZfslqwX1blSjyCtvl4el69K?=
 =?iso-8859-1?Q?u+MNww+rPFJZBDdILrQeURFfmHEioSDKx852V/knJZTjdYQKBscRzxCQTO?=
 =?iso-8859-1?Q?58OpmXIupNeSx5R8RgXKb+GpgeIfAZAvJYUKHkhp9O9Jp/Jwwm5fEDI/Gy?=
 =?iso-8859-1?Q?VgaBHw1EyaZ9wj1DZmIB2hwSgcQIBtyXBB3hzxo8dN2tcVfMJn7DLaSkEs?=
 =?iso-8859-1?Q?kezWXuNo7VR/Mp2GQPNVZ4UnlA/40jEhdDZRJOFX/q11NeQgFMmAW4Ojkt?=
 =?iso-8859-1?Q?euOCMf9U05GYY36qWPKsDeggZeBlZQpqsyjbBCJ3kq5qrpWe4TRP3uWtoA?=
 =?iso-8859-1?Q?MW6NM64mUjkjBOAKXaxEfVOnTozBX2OzVFtp+hY2FsgDcOR3aOHFBJEJve?=
 =?iso-8859-1?Q?AalnaheWbLjmMTpDqlwEwfTkIT5EwJ6qqfVGiwVA56VAz4nxBr9YaJ/2IF?=
 =?iso-8859-1?Q?diUuqdL2lc5pUwGAF/VT8kRQVymrAkI6o2hMC/qiaj3zQ8Cjyt1e41bAJl?=
 =?iso-8859-1?Q?rdMUIKS4gmvcg4PkFMchsiSY14fD8SE0qOnO/iT1m/C+vyVXxRJnBiwMKm?=
 =?iso-8859-1?Q?MMFbs/RmAgjZOBQuszRAUwCsLPyeCSuvAm+S7ihXf3QBlSzzQSUWqeaRpG?=
 =?iso-8859-1?Q?oM9t3Cu/lfBDW4Kp79IrHCooyb89w8Fd9kkyrkXrz+/qjWZYAhIR8XB8Q3?=
 =?iso-8859-1?Q?kfGNFIpERFlARRqSYKOKMsyHjEDmTJl8rzrTwol+2cgKp89h2nlZNhKeoS?=
 =?iso-8859-1?Q?zftB+sUqOeDRxBCbFWZzwsLUooXkNrB4Znxaz0Awv8yafaQlsJHawdKofQ?=
 =?iso-8859-1?Q?upWWSPmiVlOiQws18XS0KS?=
X-Forefront-Antispam-Report:
	CIP:194.38.86.34;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:securemail.duagon.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(35042699022)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 10:55:11.3842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e3df42-f712-4c3b-80b8-08dc9a85722f
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[194.38.86.34];Helo=[securemail.duagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C2.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0015

If the memory region is requested with devm_request_mem_region()
for an IO mapped device it will return an error and mcb-pci will
incorrectly report it with EBUSY code.

Make sure we identify if the reosure is IO mapped and fail early
with a correct ENOTSUPP code.

Reviewed-by: Jose Javier Rodriguez Barbarin <JoseJavier.Rodriguez@duagon.co=
m>
Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
---
 drivers/mcb/mcb-pci.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mcb/mcb-pci.c b/drivers/mcb/mcb-pci.c
index 53d9202ff9a7..3b634ea318c7 100644
--- a/drivers/mcb/mcb-pci.c
+++ b/drivers/mcb/mcb-pci.c
@@ -45,6 +45,14 @@ static int mcb_pci_probe(struct pci_dev *pdev, const str=
uct pci_device_id *id)
 	}
 	pci_set_master(pdev);
=20
+	flags =3D pci_resource_flags(pdev, 0);
+	if (flags & IORESOURCE_IO) {
+		ret =3D -EOPNOTSUPP;
+		dev_err(&pdev->dev,
+			"IO mapped PCI devices are not supported\n");
+		goto out_disable;
+	}
+
 	priv->mapbase =3D pci_resource_start(pdev, 0);
 	if (!priv->mapbase) {
 		dev_err(&pdev->dev, "No PCI resource\n");
@@ -68,14 +76,6 @@ static int mcb_pci_probe(struct pci_dev *pdev, const str=
uct pci_device_id *id)
 		goto out_disable;
 	}
=20
-	flags =3D pci_resource_flags(pdev, 0);
-	if (flags & IORESOURCE_IO) {
-		ret =3D -ENOTSUPP;
-		dev_err(&pdev->dev,
-			"IO mapped PCI devices are not supported\n");
-		goto out_disable;
-	}
-
 	pci_set_drvdata(pdev, priv);
=20
 	priv->bus =3D mcb_alloc_bus(&pdev->dev);
--=20
2.34.1

