Return-Path: <linux-kernel+bounces-424339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EA69DB338
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 08:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C664AB21E93
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 07:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD8F1494A3;
	Thu, 28 Nov 2024 07:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Y//h4KPT";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Y//h4KPT"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABC1146590
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 07:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.43
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732779589; cv=fail; b=iIBtKAnBuC0oLZxgU7BdlI2B3kS69tWaFMI/ZC5tMgk564ufmXo6ZpDR5qfzh8Ndo4dXjHKTAxw4Bt8Y6aY7hvT1bbxBbyO6OD9FzsAAZc2zdhiJAetOfztfHh7xaaWhJxxQ9+hPA6+Kclha2pU1Ur9sRgo7BQX/L5/vtnVeUxA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732779589; c=relaxed/simple;
	bh=sZjF0TXA1r/BNENIdwheraPYna+g+Pgl5SUbbgRsUwQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y9TiFJyaWQZvNVZ7ygbOEupFbyC7/3mB2Zbnna+neVgTSKFKwWPvjcLEGNDTRT+7wgifHNK/w+WNgR3g9KHdfBpSoV9cbkHR0ULadD9gxYVqlE25idzX74v0B+Z8AZJoVqgZx0um+saoye29RJ3icqtF97D4c7jtTcOHBB+akww=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Y//h4KPT; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Y//h4KPT; arc=fail smtp.client-ip=40.107.22.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=hDKJh0doymTxCuYLSpFkJnEd7ePaXviThL9g8P7cbk6BfdMhP+aWhgisT2OW0u4//2/eawD9DC3mbC+nvdcDwNtb/yKa1QkBAKkN8Gj5S97MLNVUNLTlnLwQBRaWKrdShL8vRTCuKNOso8UeLVwgqSl2FY7LneoSFUTQnDUn+YBry/x8i0JIXEk6mR+DoPuBr/0A2WcjF7gJmEbVu3mpBL9xjvSGegMzkSwDlRJRTwMSquQr24AWbQsw9cCcXhjzQX5ZKH+v+GWK1Q/eSuZm8avlq/2/rNMDca8RTxYgy8bFijxPZgMJBOHclLXsr9WalYLuqXH1tBN27r1kB18Gkw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/tpeceYyYHj0O55HsKb0pEgU6wm0e653aMoxVz0HYc=;
 b=bZmb55RQbKvYq+49ePoZ4DMWO60nOckasFLOWMPreKu8QIiidpIlaJBwfh5+6/0+fRUsvT+yd37qZ800uWdsEFb2S44HKhjkNqoJPAC+KgOgFcUo/OnnNgMo9A8Hw0K3VZCwPtFv4hB9ELSaQ20kd4W9VIp5h9INRSyfhsxsFYu1jNWM2GwZixhY6ppRApdwW9jmr0S7THnHEAYdiCdIQsQY559k/LY7KauTylrX9FZMxENjX2x5cD00cbU5DfaX0Y8dmPELhdu5/ARkdXS+OQZnqoLOwnVjKxehr7K/llf4E8qVVSvWpvtkWEgVrG9s1pEQSv9qIb6ROB92UrsSRQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/tpeceYyYHj0O55HsKb0pEgU6wm0e653aMoxVz0HYc=;
 b=Y//h4KPTKqYGbO0Z3jPqpdy8DEGaGVX6OHAY+ywYqvuu5THC1BemrOM95D+NkLQNSPjdv17icqywhAO9pGxc5MhEe6jEQANp9qiumJvC+SILrLkv/oYWYI0VNMRHjcm4DIMAs9+I+Z4KC2nYkFBUoTBMzQp/ajuVHetUYHG63wc=
Received: from DU2PR04CA0065.eurprd04.prod.outlook.com (2603:10a6:10:232::10)
 by PAWPR08MB9056.eurprd08.prod.outlook.com (2603:10a6:102:333::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Thu, 28 Nov
 2024 07:39:41 +0000
Received: from DB1PEPF000509EC.eurprd03.prod.outlook.com
 (2603:10a6:10:232:cafe::9a) by DU2PR04CA0065.outlook.office365.com
 (2603:10a6:10:232::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.13 via Frontend Transport; Thu,
 28 Nov 2024 07:39:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB1PEPF000509EC.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12
 via Frontend Transport; Thu, 28 Nov 2024 07:39:39 +0000
Received: ("Tessian outbound 206fab1c37e0:v514"); Thu, 28 Nov 2024 07:39:39 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 21a83b3e99bd773f
X-TessianGatewayMetadata: 9uG6KGrLTr25Wepjcigbts01uv/ZZHjcm5OenUyd/jiZNAa9dR7OzSLSyXG2O43/c0skvTdyKTJIwEAQyqyj5er0LdAmGbu18emnIX9FLRdINp+65OO0vgm9IzALO2Vsxz/NnlgQkXWBnJIcOfT/wSFlxpZSFanZMizJUnhFYQNRqLgvOMpFn/tvi5bJ6kVXGR+iQAUFGCohPF+Ic+hXlQ==
X-CR-MTA-TID: 64aa7808
Received: from L75f4656fc1b4.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 639224FC-C806-4482-9B48-2365545EA815.1;
	Thu, 28 Nov 2024 07:39:28 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L75f4656fc1b4.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Thu, 28 Nov 2024 07:39:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1jAqv3IQOYTC7l0RWfEaLHZwb8Z3f+Cy07uW9buhDZ4O5ITvPGxO3S6Z51HKOTP96H0Zsazf788zfk7PgWid+AiUtd9MYxPssfMqpvNJoqWNF6VN7x44b1hjjvx/IKltXlwZumY5/wsWU7i3zmL2EdKQWxTjJARzOcKHY5ISUqgpaPPFOUAvqeTe847AFRy2Fxj8RyUYbgN0oycWoV36VTlf4qUOxXdjD5RBzy+SN5ykghnzppI9TSkLlkf/e0BU2PzXlYZ0HMLyXWCkKV072mHH6MyaMLGpXIWDpA2mho7oiVNJmcFh94IW4yZ5Al8Mloyz2+w+Dju44DU9K+nSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/tpeceYyYHj0O55HsKb0pEgU6wm0e653aMoxVz0HYc=;
 b=Oe4J6TK5FlgV6ynsxiBcImH78jPK5U0R7H5ptnVxp/EQo5oOoxGKdeBwzBkauMlVE22aJ85QgzrjdUuGr/7sZc8CLShpqwNAmjaCQhrZMqLJi7CHFhMeLzgt6tXdK/ZvoxOlhAIwflpvS2gIOwcnxNDSkwH/Jn3FOw46tIQFshnWrvgJBp+r2CnJE6UIJLXIXYQzaZN18mf/PjHvnYjwg+EyFKO3DBRj8z/M2SLy9dk4jYi5yUhwZcuRzsaVYprfhh4PdYdmRVhD5dtU2l9kAuL/Mntn9Nxt6xGjGY9IlVWypvED6YDvrU9SOn2UrFURwjyiO2UuzNOwbA/OC/vBrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/tpeceYyYHj0O55HsKb0pEgU6wm0e653aMoxVz0HYc=;
 b=Y//h4KPTKqYGbO0Z3jPqpdy8DEGaGVX6OHAY+ywYqvuu5THC1BemrOM95D+NkLQNSPjdv17icqywhAO9pGxc5MhEe6jEQANp9qiumJvC+SILrLkv/oYWYI0VNMRHjcm4DIMAs9+I+Z4KC2nYkFBUoTBMzQp/ajuVHetUYHG63wc=
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by GVXPR08MB7727.eurprd08.prod.outlook.com
 (2603:10a6:150:6b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Thu, 28 Nov
 2024 07:39:22 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%4]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 07:39:22 +0000
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
Thread-Index: AQHbPx8vuTignQOEcE2iGTau3pde/LLLYBwAgADpbc4=
Date: Thu, 28 Nov 2024 07:39:22 +0000
Message-ID:
 <GV1PR08MB10521520ABD7B72D92FD60DE9FB292@GV1PR08MB10521.eurprd08.prod.outlook.com>
References: <20241125094816.365472-1-yeoreum.yun@arm.com>
	<20241125094816.365472-2-yeoreum.yun@arm.com>
 <20241127120954.0facd34f@gandalf.local.home>
In-Reply-To: <20241127120954.0facd34f@gandalf.local.home>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	GV1PR08MB10521:EE_|GVXPR08MB7727:EE_|DB1PEPF000509EC:EE_|PAWPR08MB9056:EE_
X-MS-Office365-Filtering-Correlation-Id: 875a6e13-2cb0-4354-53e6-08dd0f7fd101
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?r0ZJaUAeflkHBaPZJUlZW5efRs2KY7MT+IJIyQEdiXT0bD0wtt4BV9bxZW?=
 =?iso-8859-1?Q?TwMDIg8zIGMLq5LuXOshvmTFSCiRpKCobmRYA1/SmSEL0kV5FGQN0N7ftl?=
 =?iso-8859-1?Q?LeHcEmg+SZUuKvOzZjhT0khesWJ2kQh+mJ08e3uOgTmbXWw/TQDEhLohJQ?=
 =?iso-8859-1?Q?gkwwWSe8XI17+yeqBUI9aXjE4shwVhkrlKmU80UBnWMkkUFOEmwSN6RDmQ?=
 =?iso-8859-1?Q?MPOa/cmUr6cObR1vHvPvxp00SdK0O9iOgfCzQ1GCfvEBaBoARn96Ev79Ga?=
 =?iso-8859-1?Q?7q7O9uv2CrpNr31MssUk1OV9Q9pgnp+P94kK6X5wy0nkAAMFF9ZTVzk0lQ?=
 =?iso-8859-1?Q?9ubjqohF8nVbDsclv3Riu4eOpcZIxXKepRENXAZMfrnJBrxvkKUrUopYR/?=
 =?iso-8859-1?Q?myynqhO2xki5W+fnc3mOIsL8w7yulM9p8z6hcFJ+j9tiOArKVustY8CfWs?=
 =?iso-8859-1?Q?4z8Oa9yX/uNvNNNDOtJKFJnvMmHPpeNPKK6vdbMYzTM5MPVFWvbvwaWwz0?=
 =?iso-8859-1?Q?2vWIVhLANRtCj5torTXQpR0sxHCzdONO4h/LYkyWOx/YC8eH0fcc5JBGAe?=
 =?iso-8859-1?Q?MVOJOQFp0JRr2gFPZJJFNE6AwkXWNbUVw5ZEw7wkCt4scuoG5GbNs4DRy4?=
 =?iso-8859-1?Q?qgXjMs05ehR5PrumadWeotNrSqV2dEpfeYJS0YMzIxfAEG/v0ImgVjn2VJ?=
 =?iso-8859-1?Q?PyFmZufB0iA3nYYbYY2sF5qhxVAKbJZbLl6d9M11LKVZl7TA1A5hon4J9d?=
 =?iso-8859-1?Q?l76Jdy18O/mhcqEsaIXrhMHheCLtA8mm3lX5IFq6Enqi6xmXtZn6toxELQ?=
 =?iso-8859-1?Q?SZRTuNNSv/wPLkchyYgdV0Cd0uiP5KH4rwJmW0jQo4WZ65MzC4hRBV/Rge?=
 =?iso-8859-1?Q?Zt9VlivNdjd4VX2PIAgqQhn8oMorSLvtvBsFGCd4+KaUQ7AWEetAs6Aao2?=
 =?iso-8859-1?Q?gg33t2B/ZcnFRbONd5S7N3Q0Gw6SZAT4fnctmNhTFLj2l9/YfbmefStKV2?=
 =?iso-8859-1?Q?I8VY+HS9ZyuKE0/qErDKlKKJAPCS/eUuIP82ErFatxsy1TQ+KGL/7ojPVj?=
 =?iso-8859-1?Q?7kkS4HtVRQ6lGMMXaPes8hm5ZAH0ZaHvDlNmzHxzjKbNLLQrlOhkJro58k?=
 =?iso-8859-1?Q?MdZQk7V8WSyQ4hxeVoUEDg2QrA0jHet+KYYIi21lmREUCpRzQJw5nwo0/S?=
 =?iso-8859-1?Q?DRF2ARzRph7/lKQdbrVFjgUDY8HmBzGxHItMENoXjJEsKDiP9HHW/SdDUW?=
 =?iso-8859-1?Q?8GWuJ3GxF5hRNq6osnjjNzmmPzu1VgQd6j1v8Br/x2OiuU2BNdzg2ge31d?=
 =?iso-8859-1?Q?z9IgQ7J+BNBaLov+kMQaupnaftZ3uDtP/KeXL0oh4qyCi6TjWjo8lUWNKn?=
 =?iso-8859-1?Q?XkdSTAh/YuQ6Ivzph7uluFsPt2gn/xsR2JuR6dBk2KqweNXl4bV0Mdt4CO?=
 =?iso-8859-1?Q?tuInV9XX3EfWuLO3WO585MB8IXapBqS3H6GW6A=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7727
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509EC.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f1421ad8-e3b8-4fa4-f27c-08dd0f7fc67e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|376014|1800799024|36860700013|82310400026|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?rWYqSj6lyVsnhleizg0nZpP0PfmpMPEVLAQ6KWmQDPqykvws4jtotMbEPL?=
 =?iso-8859-1?Q?WgCSm6L+W1NtN8/t+8dsv515VauGMdEFnXxk7G+dJsc32RlBpCZAcElw+D?=
 =?iso-8859-1?Q?EVXp8jrdB70rdo7XT9P4GZ1NVM2TOQNYxW+tV6lihQPY0a4nuDXQioPTpR?=
 =?iso-8859-1?Q?tBJ6lvxgBvidiLKWhCH8r5b3rtdVUeOV+Fpy8lOoBLr9yRT0ljKrS36MGZ?=
 =?iso-8859-1?Q?PjxMapZnpxPRjdTr8RAXCZFUSOy4dqdaSMTABZfpXcFsIneEGh++7W8z8k?=
 =?iso-8859-1?Q?TJeRJiNo/LfkQQWERreyH+q0ailz3pJLIOyV5wSysBUNClfLEJSFangQ9U?=
 =?iso-8859-1?Q?LuNX4G7WIIy+1HYHmlS2ZtNYOqp8SVjXBG3RABE3vrRym+XZrxMayO8fBJ?=
 =?iso-8859-1?Q?3hfvEzPI3UReeGm79/sTWEyLcItVXVNduskcRkwrCUJZNbAoeICQrXdWZ0?=
 =?iso-8859-1?Q?JCY64WnobsahIn0fZA3K6WScAvD2vQ/HMWcCMKMvp3I4HvAy/5ejqT4Tvu?=
 =?iso-8859-1?Q?nlfPsJg0l7bTYBWMa6rtA0xjk6GGsZH3aINx5DMAjEjmCZnhzneoBIYbBz?=
 =?iso-8859-1?Q?SEbYYfMTU1rdyi9QjMlZCR+MwV25/s4xeQs4TmvFmjGTH+/ef93gDiS5Ki?=
 =?iso-8859-1?Q?rYPYsgZ36hRQ5DbP6OdPwwIOJ7HYvdd04rs5ioVvj/RqD0kr3hITfSqBqJ?=
 =?iso-8859-1?Q?mJ1LDSweCs4mPrUDBDVp/ekDzJ8zl9wP7Lg2Gu4IAM9dDFpDqov0OJMh+q?=
 =?iso-8859-1?Q?mXKeWL9mg2vYT2B1DKPvHwI8hwd/SRcWesqxoHxDcNhfNXgD+8EG7wpAQj?=
 =?iso-8859-1?Q?fucUh6kLpIDCDcCFF7kzdJGG4SY8XAU7DXiDnr+cvaX/itVGrl8IURSHOP?=
 =?iso-8859-1?Q?oBPG0bGU5W5tZUnfQXM9FBtyhwgpClXI2cwwnBeIcMHCjzEqlON3+Nzwma?=
 =?iso-8859-1?Q?O/Prt5RXbX47gQuf/HSa6/JZDvYCFdrTQp8/D6lfCRmTCBv6O7x7r8YenO?=
 =?iso-8859-1?Q?KewnVNjYaC96Yv/hY2hlTkUp9NQ5Mn6bChGELZLf11DdDWLXe6yBHcSidG?=
 =?iso-8859-1?Q?sHrSA8K12AbSq48c9JK8/frN/+N552Fp9gckPUvPJXOa3Zf7pv/PgDwVbY?=
 =?iso-8859-1?Q?vD3FEMuwe11ELAl98DVZ0orACkz0421Sw8N3qpF1P6bBFHKsqC0m4lscMG?=
 =?iso-8859-1?Q?E4aRSTRw8FQsKvQVF5kT1ZK1hATKBNvcLr1kZhvd9L/ASbiTltkgn9U9u/?=
 =?iso-8859-1?Q?OOgfjToLfMq1nP1AKMpt/d2mauQK8oJb9scgBN+TQPIgdgdbXQiLf2S/oB?=
 =?iso-8859-1?Q?zdujirdeDhzlZUDXdGBQiBvNIDnLsQCgaxMwP/na0ge2Wbi9qhX94JbqK1?=
 =?iso-8859-1?Q?zrdWvGDwIM8a0SPhF2eEhY91VelBk2BQQAutJstw4GS/Y+9nfPTkO2NDOD?=
 =?iso-8859-1?Q?l4K9MCICYze1mpxgmtRNV9ZvffUuNfV/gd78vU4w4F39ouQz+T214vLL+E?=
 =?iso-8859-1?Q?WkfPKl/i3wSlyI6waaC9tJ?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(14060799003)(376014)(1800799024)(36860700013)(82310400026)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 07:39:39.7954
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 875a6e13-2cb0-4354-53e6-08dd0f7fd101
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9056

Hi Steven,=0A=
=0A=
> We should start documenting what is not real-time "safe". That is, if thi=
s=0A=
> code is executed, we have a loop here that holds a raw spin lock. This=0A=
> appears to make the time the raw spin lock held to be non deterministic.=
=0A=
> =0A=
> If someone is running PREEMPT_RT and expects deterministic behavior, they=
=0A=
> cannot be using this code. That is fine, but we should probably create a=
=0A=
> document somewhere that notes this.=0A=
>=0A=
> -- Steve=0A=
=0A=
I think it's quite deterministic becase the number of loop currently=0A=
determined by the number of preload_feats.=0A=
=0A=
Also, I don't think the number of  feats will be loaded as much as=0A=
it can do undeterministic behavior since =0A=
the number is not many and it is quite predictable.=0A=
=0A=
Thanks.=0A=
   =0A=

