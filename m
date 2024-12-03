Return-Path: <linux-kernel+bounces-429753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9DF9E2360
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D6F161477
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DEB1F892E;
	Tue,  3 Dec 2024 15:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Z29DVIqD";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Z29DVIqD"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2064.outbound.protection.outlook.com [40.107.104.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5421C1F8921
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 15:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.64
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239863; cv=fail; b=DDwqVoma+9d2BZGBrm9Ig+6TWbSbCVO5skG9kxNXp2umJl0a9aTFhWEJUaCBYUR8x4GoXK/3yjFKrukgE1Pe4mxWckNJ2GW+/EtqVU3E2tHwWw+SO6KLmeAo+2nTm+0nmSS/eCKXMof35Plg6xDyX/UTMmgqho8YzRJ4tbP0oBU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239863; c=relaxed/simple;
	bh=tfLrDR02eXRs7mLK7mPmodLUQekUo5xUaIK/CIJvgug=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TPvDfxizOVK3kmy/dLn+gwjKzrSCJ1UaNTDpvTphcblm76aT6VWsN/wzCJ77uP5rUhFrOvi66XY8jRxWcsHHUHrlksXZ17bXrjGeccGxp0fy1bjcm1VsUD3oQset1QHeMYZVgz12km5SoxNwWfTTHFuvALIX7kujjU1NFpSRW5Q=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Z29DVIqD; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Z29DVIqD; arc=fail smtp.client-ip=40.107.104.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=auLRc7V6+OZmqLnfW83/rBz2P4mjZiswHrRs26U21INelG16Z9928RhfYpf+lN76Escv0pcfx0wQN87fbTZnay18Ngd7ftnJkA00GWWS4YVrw0CmMAaKaimbYWh2HEW/wepBrh/SQJ6EhfZ/pC+QHI3dziN4jEoVDHs5l+FVFHA0gNR9zT7/eU1eYnwhYevc0DG1DUU6XCkGPpOh/SmIbNVn74HTMCXq8X+PmUlcahTNNx/kMyprfcZEwidac+by3+odhnAc4BE8dEUg5NHTgWajaWna+Pz7aCjpqIhRQ5mGwiVr+8by6eMFccm3tvRkgc5m00wiKr3kWWj2DJKEkA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfLrDR02eXRs7mLK7mPmodLUQekUo5xUaIK/CIJvgug=;
 b=M4528yTNm30ZzN0Te0f+bV7Bk1kc+rcf0m48uRkqaJB45Sxs31bVJCSVPWII1sMIoZGjZEou83AjR94lU1BMbzTFF051tSQ91r+dNrqkzylsSgbQI+BFqqGr9Ur2u4VAmzJTtHf2qkMgzpIdBUFPwJxnE0r12Mqs7ye7BUnTyGNtXEeLxtAwLjgUK8A0tXmHcA3tR/QlbKLEeSVnzPMp7KDdm5HuDbFR5EdA73GJcxBd3EVTifxAQl6c/loyq+B0aslpxTA4k2QehI9kaDQqNWIWDFBbSUDPPCfeIY6ZHaq3nCaUqupmszbHOUzjMRlB2cnyE0NXVM9xcQI3s0aRjA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfLrDR02eXRs7mLK7mPmodLUQekUo5xUaIK/CIJvgug=;
 b=Z29DVIqDhBj0lObZJPLBVXuBdY+CYJ+afk9ibTRiBaHHu2X76nMiSy4CWku218q/BE8R2Wq9tw27oaULPrfNHw4gKFCQxJXSNM+nFL1v2ThwKssM2yGVIIdzeYaheTYEBJ4zg7sDYW33ztFO8EUn/7XIEfsmw7/q+87Jpts++9M=
Received: from DUZPR01CA0247.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::17) by DB9PR08MB6634.eurprd08.prod.outlook.com
 (2603:10a6:10:23f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 15:30:55 +0000
Received: from DB1PEPF000509EA.eurprd03.prod.outlook.com
 (2603:10a6:10:4b5:cafe::47) by DUZPR01CA0247.outlook.office365.com
 (2603:10a6:10:4b5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Tue,
 3 Dec 2024 15:30:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB1PEPF000509EA.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.7
 via Frontend Transport; Tue, 3 Dec 2024 15:30:55 +0000
Received: ("Tessian outbound 206fab1c37e0:v514"); Tue, 03 Dec 2024 15:30:54 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: c393e09ce843bb2d
X-TessianGatewayMetadata: nCgfyCV/rkCti776tiCSQahB+vKsrsTG+Vbhaj8sw3pEvWi64XD5BhIVh5V6E2AVg+K3dRNd193+6ASpZku4SFDlEvaYbTFa3W4nmJP1uii/BIgas1zplPeKlqpshUo7asCAVGUUFowW3OW/q7KHGZGhPseYeaz2LU9j/zKFvsZkOLf7IrHRYR4tys+DFNblC70iHMFIfnsfWezRIPSvug==
X-CR-MTA-TID: 64aa7808
Received: from Lc94fc43f3c7a.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 2A27920B-5733-4BE7-A5A3-46525A7984E9.1;
	Tue, 03 Dec 2024 15:30:47 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lc94fc43f3c7a.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Tue, 03 Dec 2024 15:30:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lATzZ0Ca88qqjh2QkJclLfYy+Hg03a0GX6jaBRN9wGxsZSnM5Zjt6d2dPOz0lj8jyMDs4EMjrRHIJxL4K0mbGpxJNA25LKJ61ILqEw2Cj1t54dAwgUxrdUBWBFazVGO9QDDEzG2Nxr6iDqb1JyrBjpfUME/2MLc5UJAs6ORr5xrJhjgzXWDTKRX8gRJIcZEKYA0hu4xVEpfF1MqH0Kv8kPkGBxBRq9V6mncB9A/mHTVpEbZzk6vzeB7eBqyEU58RWAD4zOFV5icuHkF2Ugooe3vHka+BG8VUcQeFElXhSUOtlL4Sk8ZBf69a8w8rv4EMfUneTtTDjgqIkVEteqo9Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfLrDR02eXRs7mLK7mPmodLUQekUo5xUaIK/CIJvgug=;
 b=ReMIwdCO2lsyNDX70/tz57QN4nU0f9sA6H9UzQYz99rzdZbUd3sKkAk9iuOetTJNPSLegnQQXuADAJ6RXZM8wzYAWU17y99IycrUKkRzDlORQzuyEOGqPIkBLYalrdw3Pcb9k/+atmWd6YVa7ER0dWydK/EV7xyKVfB65T54Y7yKsetYFgGpwDAlPoypC9vmAfbphv/L5vsPJyvK7d8E+8lOa+/RDkH7Ipd8+Ilif0DnWeQjq7iQuanP1TNfaFG/FyDJsMVMA9jjE8Vziu4YFoh1u5OXbCc/6Wt4Y6yHEcORBbP/BlQcR40IzxQJ0nTwJvFnLc0FpKuxKF0QK6rapw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfLrDR02eXRs7mLK7mPmodLUQekUo5xUaIK/CIJvgug=;
 b=Z29DVIqDhBj0lObZJPLBVXuBdY+CYJ+afk9ibTRiBaHHu2X76nMiSy4CWku218q/BE8R2Wq9tw27oaULPrfNHw4gKFCQxJXSNM+nFL1v2ThwKssM2yGVIIdzeYaheTYEBJ4zg7sDYW33ztFO8EUn/7XIEfsmw7/q+87Jpts++9M=
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS8PR08MB8443.eurprd08.prod.outlook.com
 (2603:10a6:20b:567::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 15:30:44 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 15:30:43 +0000
From: Yeo Reum Yun <YeoReum.Yun@arm.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: Suzuki Poulose <Suzuki.Poulose@arm.com>, "mike.leach@linaro.org"
	<mike.leach@linaro.org>, "james.clark@linaro.org" <james.clark@linaro.org>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>, "clrkwllms@kernel.org"
	<clrkwllms@kernel.org>, "coresight@lists.linaro.org"
	<coresight@lists.linaro.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rt-devel@lists.linux.dev"
	<linux-rt-devel@lists.linux.dev>, nd <nd@arm.com>
Subject: Re: [PATCH 1/9] coresight: change coresight_device lock type to
 raw_spinlock_t
Thread-Topic: [PATCH 1/9] coresight: change coresight_device lock type to
 raw_spinlock_t
Thread-Index:
 AQHbPx8vuTignQOEcE2iGTau3pde/LLLYBwAgADpbc6ABtjNgIABGYcAgABzv4CAAAFbSA==
Date: Tue, 3 Dec 2024 15:30:43 +0000
Message-ID:
 <GV1PR08MB105213222FB18FF328443148BFB362@GV1PR08MB10521.eurprd08.prod.outlook.com>
References: <20241125094816.365472-1-yeoreum.yun@arm.com>
	<20241125094816.365472-2-yeoreum.yun@arm.com>
	<20241127120954.0facd34f@gandalf.local.home>
	<GV1PR08MB10521520ABD7B72D92FD60DE9FB292@GV1PR08MB10521.eurprd08.prod.outlook.com>
	<20241202103853.26db0c13@gandalf.local.home>
	<GV1PR08MB105212FEF9251CA2B3AAF7FFFFB362@GV1PR08MB10521.eurprd08.prod.outlook.com>
 <20241203102047.5844de81@gandalf.local.home>
In-Reply-To: <20241203102047.5844de81@gandalf.local.home>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	GV1PR08MB10521:EE_|AS8PR08MB8443:EE_|DB1PEPF000509EA:EE_|DB9PR08MB6634:EE_
X-MS-Office365-Filtering-Correlation-Id: 230d9521-5a27-46dc-780e-08dd13af7a9d
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?0nmgu/jXWswkb/7UbmOE3d1GWfjlOQE9o3WLZio6GRy/BHZvzSg+9I5Q1K?=
 =?iso-8859-1?Q?B0+/wWfPqNrQOLqY6/BTtIZTduBx03Igk3zRs5UN0RFH4ej/A6lLwSyBJ6?=
 =?iso-8859-1?Q?1kCNQM5MeME7iH3xesmu7et598jCtV4CxtyL84uoK/Z81ryKSYqYNfPD2z?=
 =?iso-8859-1?Q?wqgil/WzkhnTl7mhiySyjqJ9aOc6y1nA8AaHtQ1tp9S39Q+XdnEQ3PfxAF?=
 =?iso-8859-1?Q?U09rs9dPchbwh4A+CMhZdLl35pYEoDspLFIQjw5LZ0kyACC27QSAI7g16E?=
 =?iso-8859-1?Q?s9QrY0c4uHp7yBi8F4fVALsRjvYJp98BI1dZoShy1G47boVqGkcX1xgbql?=
 =?iso-8859-1?Q?7RuoALDm7HKki9cXVDa8GVx3gle4dF6IhDY6XuMXMWqyvCZlsS0M+qCm7g?=
 =?iso-8859-1?Q?wMi4uf76mmNjJSDVZJapF7vXIsZH0HA/abUuAbOkhoovBzmYhPAJLU0jtP?=
 =?iso-8859-1?Q?AxCOyJQ4rF/2iLMgGbxMtMWzr1rq6FDHoFkEwkWoFHghxv0BX/gexiVgRB?=
 =?iso-8859-1?Q?yHPZTeRdcBCL7utKezMjmi6eevtPDdoZkOnlIUg4M8bqU3lviPEO+CLwqc?=
 =?iso-8859-1?Q?QcnNwXUgGP5jgtFweP8fN7LTlNEpqs28GfaCJvPCrc5xnhfSxlNBczxZR5?=
 =?iso-8859-1?Q?8S5DLkQqSY0BCw2o6c3nGgUqujhxhpeN8fA8+wUaM2H7LSb/n/laMfmPj9?=
 =?iso-8859-1?Q?2pjQGzeiVtuNgzwaBLYycrAxKfX5DnprG7h1Zok9A/x0TN4rQUuDlHOPEm?=
 =?iso-8859-1?Q?4W1zFiQuyDsABUATz2pQe7FZQnlj7TPi4Ih300mV10Uj6gnOCP4VXZ9YRG?=
 =?iso-8859-1?Q?4XYxF3xHvGih7PGOoQLlQHHQHhdnt9kBXIZ2prjE7HUchxxFdynF2a61mu?=
 =?iso-8859-1?Q?AgykghpjhWB85ZharRZgg8ySBOw7MZ5czwaL8pV75k1uk5iUyKNZbbtyDL?=
 =?iso-8859-1?Q?kT0yFdr7UC2CxXJ97nZ/u6Vsb0xIRye107+amqTgSfyo1OH09+SvKmfhGk?=
 =?iso-8859-1?Q?ihm7AfD3Ko0FBodJ98lxw0C7tzPs7VStBZ4Wg2Ry/vzud/Nj52jMQgBD8R?=
 =?iso-8859-1?Q?iBCHGMg5Dhgt0oXGkkZbGbw8pJHRGkTtJpuoFhRwvzvi3ULAwgl7TXtlan?=
 =?iso-8859-1?Q?LK0iptdLBGPiVfXX0bC+BM9jTqoIhrbc0/Pz2Kcjvkw+aMirNZyWCrhAjG?=
 =?iso-8859-1?Q?bWtBiVp7niAB910Lswg84K9idMyZF2jeHDoqW+9+PQmWnXy+0ziI+Q5SFD?=
 =?iso-8859-1?Q?A+373k3/C4F9rYfgTKev94+9gjJy+g/imFS+Mu4BcZwg4wE6Zls1r+CL/m?=
 =?iso-8859-1?Q?i0jbGVLSxLro+3QnheILygfPmGCkKLxiDBOCEDnjS6/I+gWwF3GNFTgy6n?=
 =?iso-8859-1?Q?1P4Pja89+YFtSd4REpdlPAQRDzC+1WSCQQwEPji+Kz2EN+M6lHjZ84867w?=
 =?iso-8859-1?Q?HvUYP17r8y5Ph5kTwfgytFFxsmbkJWaHuGXRYg=3D=3D?=
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
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8443
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509EA.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d57271d3-3062-4220-5c7b-08dd13af73a9
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|35042699022|14060799003|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?ElykHZx+lla02Q+fVkOA0KJMvXeEkwXENBJDiulBBxReKfA24Ik9GCCW1a?=
 =?iso-8859-1?Q?shAulmucsO6XQQ/04mYMk9sgv32RZPEcKjs0NhmsdBrTicizgfDZpRYrko?=
 =?iso-8859-1?Q?G7aSrFTOKKGCPG4cDHynNMxAVAHgvgky7PNFcRKTpNzQXYv99yB+libyAx?=
 =?iso-8859-1?Q?teE0kFfytZcQNzxAiAE5YWLMoZfYbrCiou8MleQyC+kVIYtQk0LUfiWalJ?=
 =?iso-8859-1?Q?clYp5GkTLjoCBn7O4hCQVYHurAfW47Pii9F+ey5oj0i5UgV8kVURN438+4?=
 =?iso-8859-1?Q?mrgBSY3HU5cBzuhN1CeYp0aPdAx3Tzvc2oJPvuNOmITYUT0Y5vOHKwMRuh?=
 =?iso-8859-1?Q?zqsEKPMMDUO0Uhq+vzyi6DWuFNk/j2PidBYXFDUtMxjeOjYlewPsbDS/Fq?=
 =?iso-8859-1?Q?XGPKsVUUfgs9fme4JW5PcW/ykX0Nk+/5CgXOyn4QOY4BLzRneo/Jb1bwEN?=
 =?iso-8859-1?Q?I9KRBDZHJ/VS2nIgRUEEVuwpljEtUZ02FaH2+zeN78GolXdKH9I0Wg5THk?=
 =?iso-8859-1?Q?nLMjrlcc99gZ5SkmSR1WZuIxNOwMdAEhbq/z2P7NzmNcEWrHyn6P96HhsM?=
 =?iso-8859-1?Q?6a22K3AYWL8aTAmwsjUh6P+LUo6WEENsn3U+5HXkY4C3h7i0N5mkKB1FHH?=
 =?iso-8859-1?Q?sTwatEXQcq8NCbIDlMZXm+aLdMq5/5J7G5H180L4lTV95kbmrWSUfrj6lq?=
 =?iso-8859-1?Q?oM8l11BjBHOlsqcw3hlJhVfoXHIWV0OdoWRA8tIwGzgNnc7OnDerVcPplP?=
 =?iso-8859-1?Q?l8SBNhdwwHhxtgpE5TD5Po+7pjvnfDqpFB3hrZ5IipMh6Y2sEu3nR/gNG+?=
 =?iso-8859-1?Q?ow9JdJ+C+hzASTlVsW8NHDbXovz6vgkyw9mhGosE6kPdxc5W6gX/JWJdXI?=
 =?iso-8859-1?Q?JBW97q0hfbFirv8v6g7GZps4PAKyzfKhV0KN+HO19qOXkdOwRcyOMfY/Jh?=
 =?iso-8859-1?Q?UIq9oT92kAmadkB46LbaKa3H1dkEru7cfSDeHigqQpuDEztRra4r8pycmD?=
 =?iso-8859-1?Q?8Gi7vwWZSedGhhElHtVk0PI3zyKHrJpl+qovTLhMwlxNjl3mxE5GCDBb7Y?=
 =?iso-8859-1?Q?OypYF6IuzIB2FkRgWQjWGVcfr18cy69YaRSZp+FZrqtG9B4R+yss/jj0ug?=
 =?iso-8859-1?Q?L26Tz9TfILm7P24yqLJdDCOUtWHSGUEX6/nGenP4W1Yb4PJUt89BhLlVkM?=
 =?iso-8859-1?Q?w9R5XLo+xKc88J5rtu5QZj5KWRGVUZyYp/98W5szIOi7e4qhuvdJZ9FlJG?=
 =?iso-8859-1?Q?70j6hay4CAZwrHHeK1yulrGcZTrOQmPeDykj8NfvHNh2GqVlFO8ZLa0AHr?=
 =?iso-8859-1?Q?T6K4LGnsUccY+HYf+Pv/xBZtl9+SM8vc4TfW/pX6AW28Ob2L4OSNgT7AUU?=
 =?iso-8859-1?Q?gFELPIjmn6cTUSz4G7hyiJWjn9Rxd9CAeZP/N+p1o1MskQ8LvuK+Y68rAh?=
 =?iso-8859-1?Q?LvEnrSpBE6WGsvua+EI0uFkIhdi+HafLCzlUS501rhgzyeeQxpApC5k4ev?=
 =?iso-8859-1?Q?5cp5wFzAtlyjvkJynbTrHo?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(35042699022)(14060799003)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 15:30:55.2260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 230d9521-5a27-46dc-780e-08dd13af7a9d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EA.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6634

 Hi Steve,=0A=
=0A=
> > > Still should be documented somewhere. It should describe the maximum =
number=0A=
> > > of feats that will ever be loaded. If there's a max, it makes it back=
 to=0A=
> > > O(1). With a 'k' of how long it takes to process the max number of fe=
ats.=0A=
> >=0A=
> > But with other patchset seems better=0A=
> > since not only this function, but also for other functions too.=0A=
=0A=
> Which other patchset?=0A=
=0A=
I mean I'll send with seperate patchset to documents this.=0A=
Because I'm not sure documents here or in other file...=0A=
=0A=
>=0A=
> BTW, is there any example describing this I can refer?=0A=
=0A=
> No, it's on our todo list for RT. To document the RT behavior of the=0A=
> kernel. This is just one location.=0A=
=0A=
Thanks to let me know :)=0A=

