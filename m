Return-Path: <linux-kernel+bounces-426846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6649DF963
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 04:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40572282954
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 03:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF59F33986;
	Mon,  2 Dec 2024 03:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="dyang6kY";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gLuLOlsi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jtpOOAYy"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1AE18E29;
	Mon,  2 Dec 2024 03:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733108838; cv=fail; b=RCYBFCl6Iq8+wq6+o7S5GvTZWYGaMNMzM+RwfobGPDCrcQRSsr7823n4ReYGQassNMVbwFRujTvyElh3PMdOaYjvmjQ5HDp+yBgyPeoJAkqRqNtay0dXBP6rKlXZA33IToRg81OIg1oSKiqogdGpdVSU8BAyAIfGrKh+UDKuCrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733108838; c=relaxed/simple;
	bh=bg0RqbNEitW2clomyIk2L+g3IwJ0j1tVPHQv03N3E7c=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Vz1bppM6OnC77JqptA8fBMZPm5zm3lIer+z1kq4SDI+FrkRFpTCvdxw0nHhooNdN9CqXz7KjsHLydqGNboUUZS+6AmhzVSK922vZwTMao/BCoZTQkk30Jt5+wW6SbvwSMBkmJEdAu2Srep9JmeVNO0VpFJ9jKa3jN717vc4pnqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=dyang6kY; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=gLuLOlsi; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=jtpOOAYy reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B1KNsiK006475;
	Sun, 1 Dec 2024 19:06:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfptdkimsnps; bh=h5HV9K49imEMPd33uEX
	uu+MPv30bOxCntpJF2eMlYl8=; b=dyang6kY6tZbKWwRG7+KbumNKzFn5J1qvOg
	7oJdFnMdfLDjAHoP/uJjQRgEd20cBJj0ZQgUbsenZZl5QJ/aB+9FqYV86uikX7g/
	CFBRsutsVcaFSQ5nZhRwKiWOR2KsraXmxZMi1igYheafXslmXAvI6zNj/nU55YQ9
	9o8MaSYZ5sdp9vzAArWG/pvqTHm86vqk/o8fGH5MEtQN1dfA5E/mWBQpMfVBidM6
	hn4C5yt+W1kyGFeANnNovK5bGIqqF7RXkOZGnVpqvw+KzMK2LdSVVAcZLzTIYt/y
	bPam7hkmuWmlElzCBnay7GtL+Gv3dsHkblF5+Jd1yAY94zqDFkw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 43827k4y61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 01 Dec 2024 19:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1733108816; bh=bg0RqbNEitW2clomyIk2L+g3IwJ0j1tVPHQv03N3E7c=;
	h=From:To:CC:Subject:Date:From;
	b=gLuLOlsig06knoq7Y3/5AJDzF0E+JMygp5Ka0yuUi8zIINzm7Z0tuGDfOupryPlV0
	 WrLfJyuSDcqLrmScxLpfd37PFxzUn4yioqwK23msgFOh1O7OkWYsiu1b2pUUWZBM2U
	 uW5cf1lThNzbq3mT6rNOokfKIDOYbP6PwZaUaS3Ss70XGiDI3KeD+avgl/fpaMXQTF
	 f/Taa1IoiMson9LOqXWyuRCjUD1C2Xs7qTv5u9/o7DbMYRNBc/p6fUqEu3RkwpooF+
	 BEIslcVBhN3lsT42obLbZ3xjKcwpAzFmf6yjAw7UXABALMIbut76Sz5584+0gr7aUl
	 lfNerChJZfaMQ==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A9FDC40147;
	Mon,  2 Dec 2024 03:06:55 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 3986FA0085;
	Mon,  2 Dec 2024 03:06:53 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=jtpOOAYy;
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id BFF2340235;
	Mon,  2 Dec 2024 03:06:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFdYFLti77201bosMAobJ7JHsDoK0FOyk/KZTQhzl7myBTmRdTs7qPVVSBgZgl+lcoakzosrhV76LoGwOPIxxeQcN5TILAJ+3fWbNVBrFVdeXUd5OIymUlxINNeryJzAwc63j5Q2nR4TLFAM6BL0ZswvtdnY4YlG52lBBvJzUoLni/Tz3JutMYZ1T6IkWhD6kRbuy17HlkHsU0C2gqPfshv9QvFhA5KBEw8dg7MbeZlk61TmLZ9sGBXiBfruRIM7SzQtByaAwJY0gy+6dtZSHK1AS30xTF9WgQLSFC8WLobCuJuWGloW8yMVtZEFLi9qL4W1hm50wPIUiLVj2EbFTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5HV9K49imEMPd33uEXuu+MPv30bOxCntpJF2eMlYl8=;
 b=o9wr6ujypX/A96x+pSllyS0GjuzKmkK9t+dx8KiITMvUIZcW2UEl/APtpHFA6XJyQlLiSMfu2M19miIm9VIiJkC9h0e+hzP2U6ZutJ6gQvrLz3YMlfoNnLwgXcx1JV7Th/DV9wnoysOXqA7BJYQ2fysr+xTwXtlNNI5xmXFQ76OtNPd7BO6M4is+mxUNRUM6+ysPyVu3DOkshqkcqBC08siwyz23Ug/H+iWCe+YmqsG4q0vyH/GpOzMfHk8OOeqQnNhYJfSPsYa6GdC4xf+TnjLk3vWxXvNTlhs/JEj4GBfkBtaFGxJu13loEmh5EICJxTagVhlwZDZH/+CoLm1Iww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5HV9K49imEMPd33uEXuu+MPv30bOxCntpJF2eMlYl8=;
 b=jtpOOAYymsZSaOFoF3gIAmYai/djknDcNp5Mv5FQdSEVYZf/ZkQPeFenFgAaQSWJg/FDWfq6eZdwYkG+Cyog8CHABHzpXEvSAcKvi2SzA9Lvd+w/pQa6H/0gZRGFNdT84Vn0Ni7BfOZN0pT1qgHfwapYkbru13FvZ2TbHB8CArw=
Received: from LV2PR12MB5799.namprd12.prod.outlook.com (2603:10b6:408:179::11)
 by PH0PR12MB5647.namprd12.prod.outlook.com (2603:10b6:510:144::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 2 Dec
 2024 03:06:45 +0000
Received: from LV2PR12MB5799.namprd12.prod.outlook.com
 ([fe80::9fea:67a4:7d73:bff7]) by LV2PR12MB5799.namprd12.prod.outlook.com
 ([fe80::9fea:67a4:7d73:bff7%4]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 03:06:45 +0000
X-SNPS-Relay: synopsys.com
From: Miao Zhu <Miao.Zhu@synopsys.com>
To: "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "andre.draszik@linaro.org" <andre.draszik@linaro.org>,
        "rdbabiera@google.com" <rdbabiera@google.com>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
        "u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>,
        "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
        Miao Zhu <Miao.Zhu@synopsys.com>,
        "emanuele.ghidoli@toradex.com" <emanuele.ghidoli@toradex.com>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jianheng Zhang <Jianheng.Zhang@synopsys.com>
Subject: [PATCH] usb: typec: tcpm: tcpci: Make the driver be compatible with
 the TCPCI spec [Rev 2.0 Ver 1.0, October 2017]
Thread-Topic: [PATCH] usb: typec: tcpm: tcpci: Make the driver be compatible
 with the TCPCI spec [Rev 2.0 Ver 1.0, October 2017]
Thread-Index: AdtEZo2aQYcfRgOGQAOd6IaiTP6nKg==
Date: Mon, 2 Dec 2024 03:06:45 +0000
Message-ID:
 <LV2PR12MB5799D45D0D1376CEBB244A48BD352@LV2PR12MB5799.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbWlhb1xhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTZmYTVhODMwLWIwNWEtMTFlZi05YmQ5LTI4MmU4OTE2MTdjOVxhbWUtdGVzdFw2ZmE1YTgzMS1iMDVhLTExZWYtOWJkOS0yODJlODkxNjE3Yzlib2R5LnR4dCIgc3o9IjE3NTQ2IiB0PSIxMzM3NzU4MjQwMzM2NTg4NjQiIGg9Ik5HSnljdkpEa1VKd3doZVFlVEdPQ05uNkpiWT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5799:EE_|PH0PR12MB5647:EE_
x-ms-office365-filtering-correlation-id: 75849644-e2c7-4ef3-e47d-08dd127e5aa6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?jnB6H/XXZZ8mHZf6m6Vo6veHGkANeAk5FyEnzQpoY5Oh+U/vXaXyOPgRdvkZ?=
 =?us-ascii?Q?k2KyR6ebWETwXFdnnBRxB820q9Rid7KPJB4mpfByRcQX4SUvijbWLxUePb65?=
 =?us-ascii?Q?Nl8PRjZ+D84hhtsp7Z6pQGj9S1I1veAFMMJYDlctf9VRNcS4CbBf1J5EcZEc?=
 =?us-ascii?Q?li6Fr4B4iCwSJP6bXMpZpAiqJsHMo4YbHhQnrqiiaIy0sTUyByGVzUaKOXCj?=
 =?us-ascii?Q?QBDSrNacE7pwznqLe8XG66g2o7McZaFuj5zy2+0nPnUHPS4QIb426MKM7Rcq?=
 =?us-ascii?Q?OVccNsZWKlURp6RmYuBLK8BJCBjTu/i2OfnH7fe3TWWz3Zbv7tRD0kkyuUOD?=
 =?us-ascii?Q?api5w4E3dNnDyLOzE4xrRDO48y79uY/wpVOfw1TiJzHFoNpxgrUbClDwd4um?=
 =?us-ascii?Q?GQ8QAF+yWZClfXlxZa3/vJUjYDQiz8utgrgzGK0uR5BerzFAMgjw4u6PmnHq?=
 =?us-ascii?Q?c2rlQ0wZE3SEzskFgct4eUYXig6WRSeQJ3Ai4lYtRr0qKidRC76PHpyPW60G?=
 =?us-ascii?Q?aiBMOWtnHZPWrB076AV1xVTlwk8QKIcPrS8ybx/SmtyI3Y/nIkPnSJQDrL/l?=
 =?us-ascii?Q?pwQ2XkVdqIEsFqF/Hs2zxbrYoU+Dc6pkGnvDzcK7TQnpx1T7+lwD68M7+j4r?=
 =?us-ascii?Q?pg7J3wyiUUIwzXtggc0LGaxHfgcXSMl6FQHbraaWmA7GutJboUIea9n6/hCX?=
 =?us-ascii?Q?1LtrJsbbjflYIr10hZT17pCze3S4WFApiwNAElXBbHzkxrxCBX2I8lJahIya?=
 =?us-ascii?Q?6HGZZkr0XN2IvTH9huqKPkK1xkSNWKJ3WHCtOHWSmpAI5cDGf/nUrwFJDsq6?=
 =?us-ascii?Q?tkfTf8Ec/vdA3ZqpVB/dT47KX1lO2hNExn7jF5TAkuH6lCeI1qsS3zqYijuF?=
 =?us-ascii?Q?xxTt6eA488+Ni/QM54kAVIF+q2k+lXR9bmJ+aTjx9poS3wGhWA8ahwHedKKs?=
 =?us-ascii?Q?U1CJq4nxRKaitWL6A+8AToypSu5/yXccis6Pz9Rr/E1tw+vadDo8AywZR63D?=
 =?us-ascii?Q?cAcgCBvrHilV4dvn3Wmlt40LgTW9zYZ19qX9qQVt3rZpcYqpR+ONftNRzihb?=
 =?us-ascii?Q?SXCt/OESCDejKxh1jMUf7JsZFeF+jTbARUAOVQou2HHTkY9xy3qS3i1xFnvY?=
 =?us-ascii?Q?amwV7XZGVcBiT9lE8+ZdRMqt1U+B/c9/KHi3yDEOQ0yj715HfwiAH5o/Q/ox?=
 =?us-ascii?Q?f1wpzQzgnnKKeBLHs76RT4IKf8ClGqwTfq9bBsbzap3K2ubxsO2TYxx5ZfxZ?=
 =?us-ascii?Q?LMNnGsQ9zu4ytzraynhzFGyZs1h2xABA3yNSAlDMe99BEz92vh1MaSTyQjOV?=
 =?us-ascii?Q?ZOJLmy0GXSNwPpzMN8XB0Bzdb/Lu/ZldecR4RbBbqN4+Ro7y7bxnG5CD1Zku?=
 =?us-ascii?Q?bNvcYiHupATs0LyJ7ZoElhuvLRYbZslXieSNPIOGquBE15iG9A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5799.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Tg0vNzRsItLJ8PGAvJLdJXvOJe6WRIWbfPzkfke6Cagf6ppCWIvESpXaGQsR?=
 =?us-ascii?Q?W6t0abXbzzXqpwn7nV2W7Ry03wN/ICQJaKyP5vq3Wnv65xDjz9vLUbmt8YoX?=
 =?us-ascii?Q?t9rx2GinHs6Z+GduWmYv0YI9ojhT4lmkbvKKxhzGub/dzJDnk7kDJo6nrv6M?=
 =?us-ascii?Q?8uxfOAmtXObURAobXmvYV3Eeqs6UIxMvDYmfHaBBWgrylM1F6WCUMQAklHxu?=
 =?us-ascii?Q?QoYbHSB93Dz0vq7HqaHwA/gpe/1NJzzM8hw7yw0Y9L7iXxUL5N/kD9KihE32?=
 =?us-ascii?Q?isrF9hbWRnvk0Lr8LrIuvWmsLV1Fto0Jt80yBtx+lJ06vgBHKKRyvoWeEjYJ?=
 =?us-ascii?Q?znL+R4wM6V4l7ZDz2uxiBiQfhK4HWITCt7QjCuVMi7Fvn+lyEvVxuK+5dB78?=
 =?us-ascii?Q?8I2MH//Ii9yefzW+HjQYts2BVqCC74Mv0r+G0Wi37aHWS2mEFtCje+o/8/c1?=
 =?us-ascii?Q?IvzmlIj3TeAzyudnQmRWML5dvaL9drX69wPVE6Z47VirQ7quxg2gKal0+l70?=
 =?us-ascii?Q?N0TD559fMmgom0zDqwUr/famHpM0kwPB8LvIKfzm98GunDbDvqjPH5feAoGx?=
 =?us-ascii?Q?w+InqE8PlHXvbLme+pbgjAljUDbWupQ6JWqhXDLfwBu0E/zwcJUd6Hfe+ZfX?=
 =?us-ascii?Q?+pNh6wamv+gurTF68xL2D0xpxKbKOwHv33UveG++BosJQbB6Tk8Gmf25o4N/?=
 =?us-ascii?Q?ShL35UYEhQLINVTosTBC+dMEp2ZrCNnrKIitKyu7P2Bh0av1fWzFd1ulCISP?=
 =?us-ascii?Q?0oeD+BqooEqNjEfxknvEf1BnZ/xwyp+m0PbpbbfYuWSLby67EJ1QPLliSMLh?=
 =?us-ascii?Q?MPrpaq4Rfva8Q3vCJTbA7C7loG7KZFlkrKWzNMwGseP2/KqozCuMnUtl4eax?=
 =?us-ascii?Q?xOGGeYBCqH/TbZuTxZ+RvkH9gtiWWdA5Uwfa+BcWAaz47zT+XvclkEkqLjP5?=
 =?us-ascii?Q?K4fzczXZ1+Fo+db5b9h2u46bUbP/JECk4LVE5680xKTjOCuFIEJLusjvSC/M?=
 =?us-ascii?Q?X+CP8FqklAUrVq569lkoAuw6WOW1wTLzbkEtUWY8PfTmnxt0ZXxI3wSCEBkP?=
 =?us-ascii?Q?D/irUuy67M8UD4Y3w7Xj1tvAxuG3lhvy5nbd8TPS/mbPsuTGQ4Z1ryRw6t6s?=
 =?us-ascii?Q?xPyNHedOncamjpWcJVawibdUlnUuUC6zySNnM6SDpemCdMWZCG2uzTeb2IOD?=
 =?us-ascii?Q?gDSPBQxUD7IwGZeeXx8oPzkaOwHURcsJtFuzzNBpPF2wWyJtUZahnjLbL5Wo?=
 =?us-ascii?Q?LCcuxqDY4ObtJDCwIxkG1aVVHKK2wfu4EOT4Y9LJofW/5EgJJBXJ/f8UY5QP?=
 =?us-ascii?Q?2yAM/kwHhRM7ZCEZKwL2XM/2vu4CBZdgc42bvU8r4f3ZRY8nalNtJDdvRy8F?=
 =?us-ascii?Q?8WKd8eIG11ELEuQ0VqtMwGLumLd09smycr1gFNpXI0WTWr0HqOh+UCug0sph?=
 =?us-ascii?Q?n0d3nBPTX9ieCNPN2CvH0ark4+/DZJiFHGkhxjAMO0g4GWpOEexzVichTUaN?=
 =?us-ascii?Q?xxGqlii9DjHpcT0/X6I7z+5KWbFc4GZIFgnA4IDHjyPc+YpChC7vLJpdokdI?=
 =?us-ascii?Q?B/ftrdIGE4J1xRRqQ5o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	edskGXv8cdVuJQGV4Z/ffEvrT248Tsr75QDc/GRPf0Rmgg2XNI/fcuUHSFVzzO7PbQ/LFLsTUUxOmXx0l4omD/FaTxSP8S/Ya+pG9pkXKRkneaBHa7yCZG8Ji2njvQVqwNXpLzwEQ8RERoSLL86NTAlafai36rfhxm+v+qtXiCedGlvBKXilUIxS01WwqM+XjPVPAa5sRX+iAQfDzhCkHC2gRxmm5v4VHGWWqNvDA3QpA1SqG/hy4o5YWv6cDPnSFJxM7tiob5kqmge/np2BvCz91IggQ75ZxHkjTei5EZ0FG5xQ+ngssQbr0IPPWxgxW+iDDTN1LynmeGhDr2mvzxRI3KCnfF9kmG/T03H3QgKWvoqElUDu/3kRcwRmafDVzabg7yo8xL76VQHeScbTtwipB/m10tjFNfrm5OaX2MQ3U/hHvMn5RYdh1jGIE6G/a6WG8vPJHtrdw2wSlcMmjMV+eM5lwbp95vqtVyAgd7gA/l2338ZJQ3jfz1FvbGUC2IciSWL82PMPKQ7DQ6d9aHzXlGfimOiqJOfIVtznjmtOGfk76KA1hjCZvu40+RsjldRtGF0cWXpiFfgCF7XgkrycoD3lPSkNe1P6bQaexi+n6k0UT71pxjfLWBuPKVAVttmNIDRrCP4DgOAxq94W/g==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5799.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75849644-e2c7-4ef3-e47d-08dd127e5aa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2024 03:06:45.2100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F08+gx784u4LBSaVCOL7bmSRWs3GVh2rQfOz9m5rLMJLessMg7c9K/0aK+dsLFJMOfl0r8/lvclk3Yb1HMjOwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5647
X-Proofpoint-GUID: Z1xi1xyTVBnKuBWoCMMPbE6iC_aC0Pwq
X-Proofpoint-ORIG-GUID: Z1xi1xyTVBnKuBWoCMMPbE6iC_aC0Pwq
X-Authority-Analysis: v=2.4 cv=U/toDfru c=1 sm=1 tr=0 ts=674d2451 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=N6atwU2pGFX-QpmD:21 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=RZcAm9yDv7YA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=jIQo8A4GAAAA:8 a=eGn6WNas5V0CIjkcNdIA:9 a=CjuIK1q_8ugA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 suspectscore=0 adultscore=0 spamscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412020026

The tcpci driver doesn't fully follow the TCPCI spec even if
it mentions this spec in its comments.
- Add two flags into tcpci_data:
	RX_BUF_BYTE_x_hidden
	conn_present_capable
- Following flags in tcpci_data are read from device tree in tcpci_probe.
	TX_BUF_BYTE_x_hidden
	RX_BUF_BYTE_x_hidden
	auto_discharge_disconnect
	vbus_vsafe0v
The change makes the driver be compatible with the TCPCI spec and
therefore won't impact existing HW.

Signed-off-by: Miao Zhu <Miao.Zhu@synopsys.com>
---
 drivers/usb/typec/tcpm/tcpci.c | 115 +++++++++++++++++++++++++++------
 include/linux/usb/tcpci.h      |  11 ++++
 2 files changed, 106 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.=
c
index ed32583829be..e4a885fa38b5 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -453,19 +453,26 @@ static int tcpci_set_roles(struct tcpc_dev *tcpc, boo=
l attached,
 			   enum typec_role role, enum typec_data_role data)
 {
 	struct tcpci *tcpci =3D tcpc_to_tcpci(tcpc);
-	unsigned int reg;
+	unsigned int reg =3D 0;
 	int ret;
=20
-	reg =3D FIELD_PREP(TCPC_MSG_HDR_INFO_REV, PD_REV20);
-	if (role =3D=3D TYPEC_SOURCE)
-		reg |=3D TCPC_MSG_HDR_INFO_PWR_ROLE;
-	if (data =3D=3D TYPEC_HOST)
-		reg |=3D TCPC_MSG_HDR_INFO_DATA_ROLE;
+	if (attached) {
+		reg =3D FIELD_PREP(TCPC_MSG_HDR_INFO_REV, PD_REV20);
+		if (role =3D=3D TYPEC_SOURCE)
+			reg |=3D TCPC_MSG_HDR_INFO_PWR_ROLE;
+		if (data =3D=3D TYPEC_HOST)
+			reg |=3D TCPC_MSG_HDR_INFO_DATA_ROLE;
+	}
 	ret =3D regmap_write(tcpci->regmap, TCPC_MSG_HDR_INFO, reg);
 	if (ret < 0)
 		return ret;
=20
-	return 0;
+	if (tcpci->data->conn_present_capable)
+		return regmap_update_bits(tcpci->regmap, TCPC_CONFIG_STD_OUTPUT,
+					TCPC_CONFIG_STD_OUTPUT_CON_PRES,
+					attached ? TCPC_CONFIG_STD_OUTPUT_CON_PRES : 0);
+	else
+		return 0;
 }
=20
 static int tcpci_set_pd_rx(struct tcpc_dev *tcpc, bool enable)
@@ -741,33 +748,86 @@ irqreturn_t tcpci_irq(struct tcpci *tcpci)
 		struct pd_message msg;
 		unsigned int cnt, payload_cnt;
 		u16 header;
+		unsigned int frame_type;
+		enum tcpm_transmit_type rx_type;
=20
 		regmap_read(tcpci->regmap, TCPC_RX_BYTE_CNT, &cnt);
 		/*
 		 * 'cnt' corresponds to READABLE_BYTE_COUNT in section 4.4.14
 		 * of the TCPCI spec [Rev 2.0 Ver 1.0 October 2017] and is
 		 * defined in table 4-36 as one greater than the number of
-		 * bytes received. And that number includes the header. So:
+		 * bytes received. And that number includes the header.
+		 * In Section 4.4.14 of the TCPCI spec [Rev 2.0 Ver 1.0 October, 2017],
+		 * the RECEIVE_BUFFER comprises of three sets of registers:
+		 * READABLE_BYTE_COUNT, RX_BUF_FRAME_TYPE and RX_BUF_BYTE_x.
+		 * These registers can only be accessed by reading at a common
+		 * register address 0x30h.
 		 */
-		if (cnt > 3)
-			payload_cnt =3D cnt - (1 + sizeof(msg.header));
-		else
-			payload_cnt =3D 0;
+		if (tcpci->data->TX_BUF_BYTE_x_hidden) {
+			u8 buf[TCPC_RECEIVE_BUFFER_MAX_LEN] =3D {0,};
+			u8 pos =3D 0;
+
+			/* Read the count and frame type in RECEIVE_BUFFER */
+			regmap_raw_read(tcpci->regmap, TCPC_RX_BYTE_CNT, buf, 2);
+			/* READABLE_BYTE_COUNT */
+			cnt =3D buf[0];
+			/* RX_BUF_FRAME_TYPE */
+			frame_type =3D buf[1];
+
+			/* Read the content of the USB PD message in RECEIVE_BUFFER */
+			regmap_raw_read(tcpci->regmap, TCPC_RX_BYTE_CNT, buf, cnt + 1);
+
+			pos +=3D 2;
+			memcpy(&msg.header, &buf[pos], sizeof(msg.header));
+
+			if (cnt > 3) {
+				pos +=3D sizeof(msg.header);
+				payload_cnt =3D cnt - (1 + sizeof(msg.header));
+				if (WARN_ON(payload_cnt > sizeof(msg.payload)))
+					payload_cnt =3D sizeof(msg.payload);
+				memcpy(&msg.payload, &buf[pos], payload_cnt);
+			}
+		} else {
+			regmap_read(tcpci->regmap, TCPC_RX_BYTE_CNT, &cnt);
+			/*
+			 * 'cnt' corresponds to READABLE_BYTE_COUNT in section 4.4.14
+			 * of the TCPCI spec [Rev 2.0 Ver 1.0 October 2017] and is
+			 * defined in table 4-36 as one greater than the number of
+			 * bytes received. And that number includes the header. So:
+			 */
+			if (cnt > 3)
+				payload_cnt =3D cnt - (1 + sizeof(msg.header));
+			else
+				payload_cnt =3D 0;
=20
-		tcpci_read16(tcpci, TCPC_RX_HDR, &header);
-		msg.header =3D cpu_to_le16(header);
+			regmap_read(tcpci->regmap, TCPC_RX_BUF_FRAME_TYPE, &frame_type);
=20
-		if (WARN_ON(payload_cnt > sizeof(msg.payload)))
-			payload_cnt =3D sizeof(msg.payload);
+			tcpci_read16(tcpci, TCPC_RX_HDR, &header);
+			msg.header =3D cpu_to_le16(header);
=20
-		if (payload_cnt > 0)
-			regmap_raw_read(tcpci->regmap, TCPC_RX_DATA,
-					&msg.payload, payload_cnt);
+			if (WARN_ON(payload_cnt > sizeof(msg.payload)))
+				payload_cnt =3D sizeof(msg.payload);
+
+			if (payload_cnt > 0)
+				regmap_raw_read(tcpci->regmap, TCPC_RX_DATA,
+							&msg.payload, payload_cnt);
+		}
=20
 		/* Read complete, clear RX status alert bit */
 		tcpci_write16(tcpci, TCPC_ALERT, TCPC_ALERT_RX_STATUS);
=20
-		tcpm_pd_receive(tcpci->port, &msg, TCPC_TX_SOP);
+		switch (frame_type) {
+		case TCPC_RX_BUF_FRAME_TYPE_SOP1:
+			rx_type =3D TCPC_TX_SOP_PRIME;
+			break;
+		case TCPC_RX_BUF_FRAME_TYPE_SOP:
+			rx_type =3D TCPC_TX_SOP;
+			break;
+		default:
+			rx_type =3D TCPC_TX_SOP;
+			break;
+		}
+		tcpm_pd_receive(tcpci->port, &msg, rx_type);
 	}
=20
 	if (tcpci->data->vbus_vsafe0v && (status & TCPC_ALERT_EXTENDED_STATUS)) {
@@ -916,6 +976,21 @@ static int tcpci_probe(struct i2c_client *client)
 	if (err < 0)
 		return err;
=20
+	chip->data.TX_BUF_BYTE_x_hidden =3D
+		device_property_read_bool(&client->dev, "TX_BUF_BYTE_x_hidden");
+	chip->data.RX_BUF_BYTE_x_hidden =3D
+		device_property_read_bool(&client->dev, "RX_BUF_BYTE_x_hidden");
+	chip->data.auto_discharge_disconnect =3D
+		device_property_read_bool(&client->dev, "auto_discharge_disconnect");
+	chip->data.vbus_vsafe0v =3D device_property_read_bool(&client->dev, "vbus=
_vsafe0v");
+
+	err =3D tcpci_check_std_output_cap(chip->data.regmap,
+					 TCPC_STD_OUTPUT_CAP_CONN_PRESENT);
+	if (err < 0)
+		return err;
+
+	chip->data.conn_present_capable =3D err;
+
 	err =3D tcpci_check_std_output_cap(chip->data.regmap,
 					 TCPC_STD_OUTPUT_CAP_ORIENTATION);
 	if (err < 0)
diff --git a/include/linux/usb/tcpci.h b/include/linux/usb/tcpci.h
index f7f5cfbdef12..0760187ea4b5 100644
--- a/include/linux/usb/tcpci.h
+++ b/include/linux/usb/tcpci.h
@@ -50,6 +50,7 @@
 #define TCPC_CONFIG_STD_OUTPUT_ORIENTATION_MASK		BIT(0)
 #define TCPC_CONFIG_STD_OUTPUT_ORIENTATION_NORMAL	0
 #define TCPC_CONFIG_STD_OUTPUT_ORIENTATION_FLIPPED	1
+#define TCPC_CONFIG_STD_OUTPUT_CON_PRES		BIT(1)
=20
 #define TCPC_TCPC_CTRL			0x19
 #define TCPC_TCPC_CTRL_ORIENTATION	BIT(0)
@@ -126,6 +127,7 @@
 #define TCPC_STD_INPUT_CAP		0x28
 #define TCPC_STD_OUTPUT_CAP		0x29
 #define TCPC_STD_OUTPUT_CAP_ORIENTATION	BIT(0)
+#define TCPC_STD_OUTPUT_CAP_CONN_PRESENT	BIT(1)
=20
 #define TCPC_MSG_HDR_INFO		0x2e
 #define TCPC_MSG_HDR_INFO_DATA_ROLE	BIT(3)
@@ -167,6 +169,7 @@
=20
 /* I2C_WRITE_BYTE_COUNT + 1 when TX_BUF_BYTE_x is only accessible I2C_WRIT=
E_BYTE_COUNT */
 #define TCPC_TRANSMIT_BUFFER_MAX_LEN		31
+#define TCPC_RECEIVE_BUFFER_MAX_LEN		32
=20
 #define tcpc_presenting_rd(reg, cc) \
 	(!(TCPC_ROLE_CTRL_DRP & (reg)) && \
@@ -177,6 +180,9 @@ struct tcpci;
 /*
  * @TX_BUF_BYTE_x_hidden:
  *		optional; Set when TX_BUF_BYTE_x can only be accessed through I2C_WRIT=
E_BYTE_COUNT.
+ * @RX_BUF_BYTE_x_hidden:
+ *		Optional; Set when READABLE_BYTE_COUNT, RX_BUF_FRAME_TYPE and RX_BUF_B=
YTE_x
+ *		can only be accessed through READABLE_BYTE_COUNT.
  * @frs_sourcing_vbus:
  *		Optional; Callback to perform chip specific operations when FRS
  *		is sourcing vbus.
@@ -204,6 +210,9 @@ struct tcpci;
  *		swap following Discover Identity on SOP' occurs.
  *		Return true when the TCPM is allowed to request a Vconn swap
  *		after Discovery Identity on SOP.
+ * @conn_present_capable:
+ *		Optional; Enable setting the connection present
+ *		CONFIG_STANDARD_OUTPUT (0x18) bit1.
  * @set_orientation:
  *		Optional; Enable setting the connector orientation
  *		CONFIG_STANDARD_OUTPUT (0x18) bit0.
@@ -211,9 +220,11 @@ struct tcpci;
 struct tcpci_data {
 	struct regmap *regmap;
 	unsigned char TX_BUF_BYTE_x_hidden:1;
+	unsigned char RX_BUF_BYTE_x_hidden:1;
 	unsigned char auto_discharge_disconnect:1;
 	unsigned char vbus_vsafe0v:1;
 	unsigned char cable_comm_capable:1;
+	unsigned char conn_present_capable:1;
 	unsigned char set_orientation:1;
=20
 	int (*init)(struct tcpci *tcpci, struct tcpci_data *data);
--=20
2.27.0


