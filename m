Return-Path: <linux-kernel+bounces-424609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB369DB6E2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 12:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DE9E1617AC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7967B19ABD4;
	Thu, 28 Nov 2024 11:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="EMdxhjZz";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="EMdxhjZz"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2042.outbound.protection.outlook.com [40.107.104.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33938199385
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 11:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.42
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732794519; cv=fail; b=Xfu6EkqpfltSHfTqAi9zG3bsNJG3Bi7RyI/bk1HMkqLYkklJ1MTNKG9nB9nDELjVBkbQSj1R1S7V/zwy6711r5dma+/3faY/Sfon45q2TUjCSUTFMrwRLkaDpjjYqLwK8hLE2Dc4RCC/gAnHaT0PHV61Lz5V1BQ64eJzitI7nEk=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732794519; c=relaxed/simple;
	bh=6+m/ysFz2Hu41Ggaf+PjThNKhcyHnYTJ3QlhnTJUpgo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l6rhETNEfju3u/engg9ahHFyCrFpTyzdvzsugCeaHIMw/enkCaoHJBFE+dFZWxkN3UJfjBOPat0K5G5YLC3/sNuzKno4L5zPq+545sR7HEWviUX0x3QeUH/H5wzW0dvbZ6s7DD0tYa5m2VK1lHF5ZFNLTuQ5R8jJ3zSrGNcE73k=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=EMdxhjZz; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=EMdxhjZz; arc=fail smtp.client-ip=40.107.104.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Y0P49fEQn4GbDAHK9eHbZ+ISiH/zVZKW86ySH/hfMwhWcrMMi1bIhuhV9eHAjbnVti321k8hocIVe9nycWavhj8aeeikZP8CNZe9c9AEBQK7cmV97yOnU3abkDIQxX8QnDmOsW6P0eyCytxGal+JsJY2sT9KA8gvx/+ewTUzb9UhDVRvA/VNEqJmdYB3vxQQ61M4pU7y07jgsYNoPU2RWfSNB2FQo4J3ULnY/C0r7ZnBtpSqeZLPZY0IAo0XM1njD5GnyJCqrNIKTxvTtlhqvplCJONufRprJbTs0n5F++YzzKiv1639GCo3q3gjw47RqPBmAeW0ylU7l2fzHMttfw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6tAA5aaKnot30BgPce8peoaI4LF8mzEstbKPkegUjs=;
 b=N8s5SipGS0bCD5iHqrlZWKWL20HHwANQJ8iKQS8ywxCgYHdlgBKRH24Z3PRmMOKZ+2EccEVwsLCiggZAsGTcY9JvRl5J1ti+Z8YtFK+eJbJN22462qpKi2Py917jKfb/41oLvrwnoB8IiYdCZs6P2r20YZHyOyhIStvkGUdMZspr+LyAfXX36OADqsGvqO+UKzGMRGs6w6PQkPY+guVOvYlthSNAOUg82jeTbyjkUwRYh2u0EYATTlAnezZUjEqb023Q3DkJms6pbjqMnLXdl0UdO4BZ592CPPkDvYg/Y4ohWUrIoz8arJVD6krSTQRTJlAXkrC7PD3LllVIEkoN/A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6tAA5aaKnot30BgPce8peoaI4LF8mzEstbKPkegUjs=;
 b=EMdxhjZzd/DC5zuHYUIQU3BKWDnvrpl5xqpf6h7wGrgVmXFYTiA+CY0m9lnFYQ5MPMMXzKSAKO2vmpcaAJBWyV/8H+vsCt4spbUlNznv1g1yxKCAjOhzNcB7DoXRNvDlYel12ZkIC5SFTXHNAEHlibll6RABHIkDXWNyuKOMxo8=
Received: from AS4P191CA0004.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d5::10)
 by AS8PR08MB6680.eurprd08.prod.outlook.com (2603:10a6:20b:397::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Thu, 28 Nov
 2024 11:48:31 +0000
Received: from AM1PEPF000252DE.eurprd07.prod.outlook.com
 (2603:10a6:20b:5d5:cafe::b9) by AS4P191CA0004.outlook.office365.com
 (2603:10a6:20b:5d5::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.13 via Frontend Transport; Thu,
 28 Nov 2024 11:48:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM1PEPF000252DE.mail.protection.outlook.com (10.167.16.56) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12
 via Frontend Transport; Thu, 28 Nov 2024 11:48:30 +0000
Received: ("Tessian outbound 2e0b2b8680ec:v514"); Thu, 28 Nov 2024 11:48:30 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: b348ce1b391b9a5d
X-TessianGatewayMetadata: nUK6oYivwG2G7E2uohxImhE1SoWReXekYxQhTqmUpOraRiNUMf+3NAJYwhr7k8D9h8aDYihJak+89Lsd4oTktspE3TV6ykAFCg+emnL4IuLJf+CbudGqttry+U7bDK8/jvAxyzKsRFEJWdWPPpXU1lIbubxcRNMTfpu0RWTnju6+d0fJP/W4wj22JJRQOvqxJIugNAUucmh2iUXX6NYYGg==
X-CR-MTA-TID: 64aa7808
Received: from L2329cca40ef8.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 930D6589-CC51-4C38-8237-FB58A3725D55.1;
	Thu, 28 Nov 2024 11:48:19 +0000
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L2329cca40ef8.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Thu, 28 Nov 2024 11:48:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=psxYATY/sM/o1EIN5Y3EF1RS9BT+6IJnKku2zk1lO8Ah+2co3iBklcRQuTGfX8HUApZ+tnTxcK2BkdEWqHGodquyuXUup2zqaDKMhO0vu302RnJqnN2gnHK2Ns1hUXDeqST3I0Ar6TXvY6wx2c1IC2EX/wjC+uWxHi0EbPj9T2tWdFpdxHaYpEIDVgIJhCNSlg7SWk/yx6nm1kkxXv7846bbZSUcGTnZB4/ZbdrZnw+tTcaV5vRkWp1MgZW2M47bF7jwcQerJnBqqzLgl01dXLTNJG+qCcUDI8k3oKsmEBURzrq/g4M5h9vXDaNDuzLK7Lgh9eOblguOgJcVrw3Lng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6tAA5aaKnot30BgPce8peoaI4LF8mzEstbKPkegUjs=;
 b=Gz0oDnXtWoOqpjsdTxOf3CkJFJy/qG8lbyvQzBEn4AlMoWJ2OsRcWc/eNtLt5wyWac616/YVPCrP5bJ5/3OsrBNcLSBFRe+XcAq4s4X3ZJn8BtKT4eSsTKrLqbpLDlcn/C01d5b4hvRNdMORaCFLk1hlULHu/jPNc6ZaKIedJhT7zneOQJe3VTEWXMC1F0mSnZjDNhslSn8BiTycJgYGYWg0ggcHmkYNIIt/JjKzWWwatVCTnAF6yTy/hDCzkXAIyg912cUP+eUBIwZxNA0b/C2hrP/E8MqiElA/FK8rHEDnNoCju4buBDI1hk/FBWBBNYx4VfGOyMAMGKpGB4hgYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6tAA5aaKnot30BgPce8peoaI4LF8mzEstbKPkegUjs=;
 b=EMdxhjZzd/DC5zuHYUIQU3BKWDnvrpl5xqpf6h7wGrgVmXFYTiA+CY0m9lnFYQ5MPMMXzKSAKO2vmpcaAJBWyV/8H+vsCt4spbUlNznv1g1yxKCAjOhzNcB7DoXRNvDlYel12ZkIC5SFTXHNAEHlibll6RABHIkDXWNyuKOMxo8=
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AM8PR08MB5796.eurprd08.prod.outlook.com
 (2603:10a6:20b:1d1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Thu, 28 Nov
 2024 11:48:16 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%4]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 11:48:15 +0000
From: Yeo Reum Yun <YeoReum.Yun@arm.com>
To: James Clark <james.clark@linaro.org>, Suzuki Poulose
	<Suzuki.Poulose@arm.com>, "mike.leach@linaro.org" <mike.leach@linaro.org>
CC: "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rt-devel@lists.linux.dev"
	<linux-rt-devel@lists.linux.dev>, nd <nd@arm.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>, "clrkwllms@kernel.org"
	<clrkwllms@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>
Subject: Re: [PATCH 0/9] coresight: change some driver' spinlock type to
 raw_spinlock_t
Thread-Topic: [PATCH 0/9] coresight: change some driver' spinlock type to
 raw_spinlock_t
Thread-Index: AQHbPx8wr3p+WgsBJEaSjUrN0UERgLLMifcAgAAL+/8=
Date: Thu, 28 Nov 2024 11:48:15 +0000
Message-ID:
 <GV1PR08MB10521E2C28D14B8A0FCB3A59EFB292@GV1PR08MB10521.eurprd08.prod.outlook.com>
References: <20241125094816.365472-1-yeoreum.yun@arm.com>
 <6468302c-f1f1-4edb-a6b6-ca248944cbbf@linaro.org>
In-Reply-To: <6468302c-f1f1-4edb-a6b6-ca248944cbbf@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	GV1PR08MB10521:EE_|AM8PR08MB5796:EE_|AM1PEPF000252DE:EE_|AS8PR08MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: e7360394-dd3d-41b3-528d-08dd0fa294b0
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?G8PzYcQer1ZXy2CbVa3vD4QMWaGB1WYvfsajf6RAd3ipXC25CzF7b9I1Bb?=
 =?iso-8859-1?Q?dwFrKtjQYa+OA3wSufARDvXIOIARKab405FzBEo2mbC2QkyQV1tGI87X1h?=
 =?iso-8859-1?Q?WyK/n+bET/XaI+irE1aQWVAVdwD9/ho91eDg63usZoEwz1swULflf72Ria?=
 =?iso-8859-1?Q?O7QKLxCAB0wqiOj3s+L4ycLBIYam3fm/o8iGmgefNK7wXus+kktvu9l/rp?=
 =?iso-8859-1?Q?8Oj3jjGgzL5pA0dqB3Wf15Nc4L02SHEI5G4b7Me9olWppIujosOrbmbq7z?=
 =?iso-8859-1?Q?7YnFOsuX3l6UDT2Jgkb1ZyaUPTkjtpvfs96juFAJXC7KPCctGuKbaDdNhJ?=
 =?iso-8859-1?Q?mXvsvkx7Dbk2KFeX+r/iKG6RsL+OcD1023E7uIqmT7rAcUPWZ8vZgRZ186?=
 =?iso-8859-1?Q?snSThhUuVVhY9zDYc6ytypZxVJH6ky3SOU8AQK4OLYbjAggRaP52IWQeFD?=
 =?iso-8859-1?Q?CRlI+PRcgKrgSUpwJMXKzCP/KmfT4vGrHx0DuNfjc3IaChzPwtWKmjf0ie?=
 =?iso-8859-1?Q?ts1YCLTCWaY92aOLzWg5kx7KiYQHpputXZI0B2j5ITqgfbv96kVjQH1LTc?=
 =?iso-8859-1?Q?21Ql9dM3IOHndla1fNLlcxr0fhvDCu1RrZseUjnl4PrY5SCFE1t8Knzc00?=
 =?iso-8859-1?Q?yOyQTs+9D4dhiZ1/Y46KL/G3tZdjMZrx7gevbcTAOju0Ohpu1mB74QS60E?=
 =?iso-8859-1?Q?3lgmVt5qMeUJu9+MFOLM+1hrILt5QXZboOTOhrl3aA0fLicrSjTq3+Cqbo?=
 =?iso-8859-1?Q?STKaLtI4RniSo3sVFiGmWri1o2gWDB/AJzs4KpyUK9rX7jRiUxO8hIVlza?=
 =?iso-8859-1?Q?rLdjJoHOXFxF13JX7A33GEZKLHJ0qol2ZFDxtauW/qgFP6SC6mP1lBLkIk?=
 =?iso-8859-1?Q?YWYgO3lgOfr75sIZ5pln9QwyGYxxE0/k7/KC7L9I956sQ+GJO0iAbAXMQo?=
 =?iso-8859-1?Q?SOrCWd3tFat46kXQM0NfjDHhHYJD0KNwuS+Gtqzm8dNQZT63WbwxuAFEij?=
 =?iso-8859-1?Q?mxK/Frd52wrqza/77k8hQr9lG2HyFuy9NXot167hzV7yKHOoQiLzor+58X?=
 =?iso-8859-1?Q?OXz2quNzRnnIN3ddrGJh8/Ke61pGTFaUCFw9XPXZjM8Q4/FXeWZJcmRWa6?=
 =?iso-8859-1?Q?g9iMevc5XkXM5/VdVPZnSNuQcpmqOGYciq/+s32eGiTVSLUWLAyA1lsYjm?=
 =?iso-8859-1?Q?DzvKUuO7AVhG8hIUJhWBpyiGTbrP1sOYJTINMB6nC2sSnCQTO6vBlWClqT?=
 =?iso-8859-1?Q?tHltnmWEvwM/Hlsp0AjAQyffsiwhEqB31H8BH5GTQO4WzyTulOmV9okgrD?=
 =?iso-8859-1?Q?g+0jKwVkO/ggVssXrPCw7AzyYQPkMMVrl+cwB5Es2wl069h1jEYxq7KVOC?=
 =?iso-8859-1?Q?3sGkf+42J1KbQVK6hqtbwkV6VIAYidezDocqKMaV1YOqPoxXsNwDwIwFxZ?=
 =?iso-8859-1?Q?4Q881KdVgicePYjXAXKANHgzLgUOqIfvorAj0g=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5796
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM1PEPF000252DE.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	749ef02b-b6fb-4ff6-1318-08dd0fa28b8e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|14060799003|36860700013|376014|35042699022|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?3d5h7ON716i4QJW04XeVjKLF8L+7qV71BYp0wrzNvSPns6Lad4/Ud94VJP?=
 =?iso-8859-1?Q?4JU033/WoExvkp91295sATowjFcGai9SEcAUCwpt1d2f3KTpDXfVZPFkLm?=
 =?iso-8859-1?Q?1UznCG1xtUo6X8UpjUeLfqN1dhLtT7VRzYMJZAFCBP1MhOGWMziCw5isCV?=
 =?iso-8859-1?Q?6vHgfV0GCLns6uKBUCmtUXV9gmLixONf4WTxqHUC9hhbw8u1+budqAGMRN?=
 =?iso-8859-1?Q?aWcHWCdMMt16KOzt91B+Ih3vBtVyV+ROTK2V3kMvWRyeNhQnF33D4txg+0?=
 =?iso-8859-1?Q?Fjlw5JITdx9Wl7qdrODxZCZtg74p+ustqqSRs2V7uyc3JVmksdHQgu0vTz?=
 =?iso-8859-1?Q?HRP5OteGY27XAMKX86qcJTOD2aiM9Qo+BZZWX4eNNTTEt5huEDEAczOwtR?=
 =?iso-8859-1?Q?+6jrF8Pumqb0qacOVuqoOkwoJZEKv817DhhmaBLjOkzwdp3HxNIAELUQ0N?=
 =?iso-8859-1?Q?jINK6PV406/2iSyC75tiPeqLaE9C7fDfEF6AhgkmYGnO6IWhMsgpuA3e9q?=
 =?iso-8859-1?Q?FcKDz4q6ZQ6N0FKvCd9AXp/qnZQWOTw0zaDXaortJlq8OU39p64E0sCDwv?=
 =?iso-8859-1?Q?1ZCYZJQs1d7a853Mrj35zAwfpGMaxKa62mwylUNmLdPtkxnixZ/YOgNAoC?=
 =?iso-8859-1?Q?PIXKDUG6Ab9bFFKlF8KflqeYvP610gciBG1xnfKQhTf67SeGBDsg6D0jw0?=
 =?iso-8859-1?Q?VySnlraLyuxZo3VWsX6ERnRujpyYeP224Q3UWznCltG/egUmfp4GHedDrU?=
 =?iso-8859-1?Q?09RI3vCZPZ0irDCpxNyAunGnHG5eQX45SZU3G8YYkyqurVPvfi21iReE93?=
 =?iso-8859-1?Q?Qy2PzxBmMOnpeB0zxHAkzC+Jfi/IwTDSUbnihbgCj2Cf8lJuXY3yPp1QQF?=
 =?iso-8859-1?Q?x3aliZNcF7w65Jjx7NOekwV6k7+H336F7pjUMq3jeVpFACIzKb/bbGEJKp?=
 =?iso-8859-1?Q?YlQ/MW7Qh3t5kwmPo4h2w/1iElQPfqczmLOhN5xJ2BorDDoXUSQywMNIGw?=
 =?iso-8859-1?Q?e/8EhMgUKdvnN7LN1V9jnX7y9j4apKbvezYuvThaaE4qkfx/uso49B8zS9?=
 =?iso-8859-1?Q?7AsVQsLN+Y9ppxKQnHMIw3jdYtQQCSY1HAnUIkEImOJwoIGoUvM348ScPn?=
 =?iso-8859-1?Q?mrA956jkLdvHUyU4P1oGIaV+CwUqJd3NzDSDPoS4UtkwxrrzerLJcaPtxy?=
 =?iso-8859-1?Q?a1YOVGyOZeP21hMH8BmYSFWfSF60Bzk3+uhAPBg31wh4CxgQOVfo+CeaWL?=
 =?iso-8859-1?Q?07quUd6vOdJmE9l1qNHdFVrXoWvEI9i1Nzfo7w1+G1Kl6YF2n+R4lC/+Sy?=
 =?iso-8859-1?Q?Jti3jS3w4aPRwCHUEgZ0lZezZvhjGUw9Er4ZCIX+REYbEsJovl73pj7Cz7?=
 =?iso-8859-1?Q?JZ1PRhgo5hg4MhCBI9ONAc/kCXk8iDwo//WLXYXENAoJS36Dl9LSF0Xmxf?=
 =?iso-8859-1?Q?9XqdzEN0BImiXd0LGq//7z0MnaA0gytJzeZp5GhzC07ELwiHT12XTl5U7B?=
 =?iso-8859-1?Q?VscTCVN8fkNm93eWWbDe4y?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(1800799024)(14060799003)(36860700013)(376014)(35042699022)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 11:48:30.9555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7360394-dd3d-41b3-528d-08dd0fa294b0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DE.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6680

Hi James,=0A=
=0A=
> Can TPIU be used as a sink with Perf? If so that one is missing the updat=
e.=0A=
=0A=
No. IIRC from feedback from Suzuki, TPIU not used in perf mode.=0A=
=0A=
> Makes me wonder if something like a "perf_component" flag in=0A=
> coresight_device or a #define would make sense. Then the lock type gets=
=0A=
> auto picked. Seems like in a few years we will have completely forgotten=
=0A=
> why some of the coresight locks are raw and others aren't.=0A=
=0A=
I think later then do define new flags to solve=0A=
sharing data between perf and sysfs (i.e. etm4x config),=0A=
=0A=
it would be more resonable seperate config for perf and sysfs.=0A=
so that, sysfs shared data could be manged with inside of SYSFS subsystem=
=0A=
and it can have sepearte lock to synchronize under SYSFS.=0A=
it doesn't need to define that lock type as raw_spin_lock_t and=0A=
solve the data modifying between perf and sysfs setup.=0A=
=0A=
But, This is another story.=0A=
=0A=
And I'll seperate this patchset to two part.=0A=
     - Change locktype from spin_lock_t to raw_spin_lock_t=0A=
     - Apply scoped_guard =0A=
=0A=
so that backward portiable.=0A=
=0A=
Thanks for your review again :)=0A=
=0A=
=0A=
=0A=
=0A=

