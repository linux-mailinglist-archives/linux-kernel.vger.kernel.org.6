Return-Path: <linux-kernel+bounces-531519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7152A4417E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1A977AAC70
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7660726E64B;
	Tue, 25 Feb 2025 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JW1ETh2n";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JW1ETh2n"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2044.outbound.protection.outlook.com [40.107.241.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFAB2641CA
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.44
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491635; cv=fail; b=M5OJJl7+ny68bPGCYSXbrRiG5LDcjNTVNJN2QEExNSuqW1RxWIOr2U36QezWlikgvrFwRFRqWaJ1Z7KSrtCBHU22fcJH3hF0eql9qfMeWwWnZINyJTua1jZqwkhAoOI9IziWqxC1zY4xhCAXHRrNxgIFIv2or8MgcnV3Q6pmSzU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491635; c=relaxed/simple;
	bh=nvC+d5PgVuMNxTXMlLRFuZwh9R6de+79dCqOvI5qqus=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fZthutH9sASV3HjcnPZJboI0Q3pvW0PGF9w4XuKiSb9bpPB8zg4IvIyT2fCC8qTrHuD3/OqgWbnGeXfcVX7NH0XSgfdcU3UXReiIEZPG3aHrotnXxghWwmHJbqFJcXFYgSZakhimgaktB3ihdVsMqrlBBr6k4WKFkWmLSMz8Fk4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JW1ETh2n; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JW1ETh2n; arc=fail smtp.client-ip=40.107.241.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=lRQ5fWNaLjazQr6zWnNN+ARbyg4Zhr0lUZWCRCcJiK8cQc1h63izMdz4Kv3r3/XE0WIznp2RoDGd+Ng7Glop8R9bm300J8D6TPsIrGcaBT/EAkL0EBDPEVPFQ9vMS9B7aYxOB5HI5wdcZoc4+0qlsjh7aiV2HabrNysWI6yZZXgXiZfebPY5v6la7hMxrxjsMtoQVfIvtuuQ3iKiDqVjPuA3SzLCwwSy0pAwCZeh0VI6rwWYc55WO7izEK9XYMj05JfxL8b8+uHoWgsmD6h0JPbH7tE0g5fn7JYStK4VMm3v/WbvTSeTSl+C8zYHWSTIU1lnmKAHIGGXp5WjyMbsuw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvC+d5PgVuMNxTXMlLRFuZwh9R6de+79dCqOvI5qqus=;
 b=mCxbHiEhVMdTVCPpaRmdqgumM6PSHHN44uzLL1vJ5EO+wpxnPs18H+WVjtS/nvbrQ4styMpQ+P997gSSrfTDtCfxkreLebot04Kab5x4TXnPXgVEF/cYDlBsdVLeC0Hm7rdafZjBsT98bpMTk7ypXcKddLQdIMwowzeeXTePLujhiufU8cBfi1RHhPQ0c8RNniKKxckITdibvbZUgoRj35xIb6XKxOg81xrEwBt4PjVPKujoqeIrSCk5osN+sW8L7rkFdcKqZOZ2DW7r77ZsgoMityfU8fZqSozqzyBJlfiSrIz0tl8HjW+wGxiJkSSQqgK3iaSyc8QHGVc7Ze7lbQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvC+d5PgVuMNxTXMlLRFuZwh9R6de+79dCqOvI5qqus=;
 b=JW1ETh2nVispAx8KTGVyoKZ12XURKXBOeGR8RCa26FwAllZe48Ymq4us5brL3qjUSUYr4sZhSK/q3lUSqtpf39j0/2eUWfYSzA0zKFmfUsN+JHNiUUKz+yU6KoeUr6eScD7RIolbEgMZl6MkWquSFKIje16d4TOCf43euRdBAHE=
Received: from AS4P191CA0054.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:657::12)
 by PAWPR08MB9758.eurprd08.prod.outlook.com (2603:10a6:102:2e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 13:53:40 +0000
Received: from AMS0EPF000001B0.eurprd05.prod.outlook.com
 (2603:10a6:20b:657:cafe::83) by AS4P191CA0054.outlook.office365.com
 (2603:10a6:20b:657::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.22 via Frontend Transport; Tue,
 25 Feb 2025 13:53:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF000001B0.mail.protection.outlook.com (10.167.16.164) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.16
 via Frontend Transport; Tue, 25 Feb 2025 13:53:38 +0000
Received: ("Tessian outbound 678e42ac23ee:v585"); Tue, 25 Feb 2025 13:53:38 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f3990364643ee3d2
X-TessianGatewayMetadata: HIIHIEr2RltcOeSVcrWdxBeyCedQ2VE9NtVB3loUAh2hWZ3xsZqUNcI/RPklh9RWdfU9jef3o+P0iUsPhoJ3nEUlsKQaF81bSid26Wyg9yZBEWDJ+LIlSAJWx5jJWmAZf7qEoZiXLQDMT4fO/mXDFQ3QY2/5gKlrWzO1Y5RWH/aNw/AHvulL7lzCHJfhXlb3LcJcqYnojgxMzkOJ9jsizQ==
X-CR-MTA-TID: 64aa7808
Received: from Lf76c0b68e131.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id BE01BE9C-1BEF-4BCD-85E7-E2149E05173C.1;
	Tue, 25 Feb 2025 13:53:31 +0000
Received: from DU2PR03CU002.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lf76c0b68e131.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Tue, 25 Feb 2025 13:53:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJEo+diJm/w8ccvTC1522QuoMHge0+BK8nWBc/fAND21LvGjuj2cYKmUi8Ecj4fbdEhAsHaDSMRce4zgDoJJgleUh6SkPBQuGJwznObeyqF984NtnUUB4gIYVuM6Tgg58pe3hiqtwsSl0enij/jsEVUi7I8I8wl2S62l/fZQGKZixxSuf894K/Zxz7lzeRsmmc1q2lM0Uoiudnb1fBnxT4eszP2xG4mdPo39wcl0+x+oJNgwCzx/GBS4OSxT9ImCQMiNPkBqbRFbGQv0joRFJll5DoZgvawFjkEavu2M1XOkZ3aoOb17OZ48Y5qrMc/3G0009CfPlLwVWzROXHfiZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvC+d5PgVuMNxTXMlLRFuZwh9R6de+79dCqOvI5qqus=;
 b=IUlsdB4FAXSmnxa3R55LPSHIZCXUrR3gJtAF4/FdHK2o07xVgsxkPCftArL7xfniL/dfFIvzkSz3YgdM4oPEnJ5jNGeWVJZg7wiP4uj7UQK4XQ2vSaq1iqSbB1rfjLXXom5CJ0kBsRI8KGejWgNVesr1hPrIFM0rpvB6FLuJv27HENWbHpihD04AKjiE3GV7lj6MCQbMu1IQg4TibVNHx8/9/Wb4am8QtiCiyE5zoDkhDteYyhpV1zrON0sM7xfSX35LQdGN+lGAVLQijw/QFyFdFpU2njVi4wUI3121coh3aoGfqK/uI0tnrDAKBrYCZ/dRdJgnphEvL2Ig20cC8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvC+d5PgVuMNxTXMlLRFuZwh9R6de+79dCqOvI5qqus=;
 b=JW1ETh2nVispAx8KTGVyoKZ12XURKXBOeGR8RCa26FwAllZe48Ymq4us5brL3qjUSUYr4sZhSK/q3lUSqtpf39j0/2eUWfYSzA0zKFmfUsN+JHNiUUKz+yU6KoeUr6eScD7RIolbEgMZl6MkWquSFKIje16d4TOCf43euRdBAHE=
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AM8PR08MB6402.eurprd08.prod.outlook.com
 (2603:10a6:20b:363::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 13:53:30 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%6]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 13:53:29 +0000
From: Yeo Reum Yun <YeoReum.Yun@arm.com>
To: Suzuki Poulose <Suzuki.Poulose@arm.com>, "james.clark@linaro.org"
	<james.clark@linaro.org>, "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>, "bigeasy@linutronix.de"
	<bigeasy@linutronix.de>, "clrkwllms@kernel.org" <clrkwllms@kernel.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "mike.leach@linaro.org"
	<mike.leach@linaro.org>
CC: "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rt-devel@lists.linux.dev"
	<linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH v4 0/9] coresight: change some driver' spinlock type to
 raw_spinlock_t
Thread-Topic: [PATCH v4 0/9] coresight: change some driver' spinlock type to
 raw_spinlock_t
Thread-Index: AQHbUsxKiei+YMVvyEi0xBNF5qncLbNYOPGAgAA6bCs=
Date: Tue, 25 Feb 2025 13:53:29 +0000
Message-ID:
 <GV1PR08MB105213206BC42F2968A2F638EFBC32@GV1PR08MB10521.eurprd08.prod.outlook.com>
References: <20241220104521.809071-1-yeoreum.yun@arm.com>
 <6c00cf65-af68-49fb-b762-675186f45abe@arm.com>
In-Reply-To: <6c00cf65-af68-49fb-b762-675186f45abe@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	GV1PR08MB10521:EE_|AM8PR08MB6402:EE_|AMS0EPF000001B0:EE_|PAWPR08MB9758:EE_
X-MS-Office365-Filtering-Correlation-Id: c9b62439-99b1-46c7-4fdd-08dd55a3ce61
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?rnDP5ClQ3LTBVegLFRLy1JkJuqckqmmAWA92TxkIUUdTjQteAivK6awUHL?=
 =?iso-8859-1?Q?U4KPN4/EnFFZGbRQBbw1th+qnxmr7+kaQFgyyzb9cOrPFNdlMKOoYu9o5j?=
 =?iso-8859-1?Q?IfPBX3Q8na+yPyAlv/1UedvQUdd3r1+mJn4TexeAfICGxhG/n1++Mr/1Ak?=
 =?iso-8859-1?Q?qOA0bHnYF2aFWHV1FtFsAqiAGpfP5kAevvkVndS+MjfeLYxq/MD7PF5qS7?=
 =?iso-8859-1?Q?QjT3FkMt+dP665UeYIdbtOB2f4sN/aBv07wLsGLoVy1lloSEzkFe4C7GJ4?=
 =?iso-8859-1?Q?Xj98TCGyrus1frs74OmkC/e+jKU/Mohm1o7bMBpJZ3yvBsKmx+OMd/ntke?=
 =?iso-8859-1?Q?3wnSY2RYAs0yn1VyMMJA7orVbY/VsNi02q5qAY/m0KCmRezUJHNVOYST0W?=
 =?iso-8859-1?Q?hKVEw8di9MG+oY9OUCMkEyprkToGY56XWMAQCdUfMxyZNwzOPeYgZEfRrx?=
 =?iso-8859-1?Q?YuEsXnQUHLPBHLqfgLyV4ESqPzlBYydKkOs46VBxb3tBH2pVuMYVzVf7Z7?=
 =?iso-8859-1?Q?dlr7eCuzJ9o3Q3+MUonc4N5lYYGw8+nBd2nxmrpXyVb2pdRhMblZHUFWVi?=
 =?iso-8859-1?Q?MTB1mntMAvW0kj/k5ZoVCyYgBCaEE/TsOZkT/Ris6RzkyF4nMPW8AIKx+n?=
 =?iso-8859-1?Q?LL0IbjZWISH4Q3kIVqxNPCs/vRVyjpDlekmtyUJR/tnDSLnOoEsuYrBcnG?=
 =?iso-8859-1?Q?Uee7B3TIcI5l8ssFiO3TZgPsO0UXJnwYLKBoAZY5yGDdMWZtrf9aaFkaut?=
 =?iso-8859-1?Q?wN19ueQ8ATllu4keWZ50YtkVxlk+3n6/iXYYuCvHaB4d7tK9B1obAGgP18?=
 =?iso-8859-1?Q?1TDX/Ib52xJhs3/dAsZ3POAwjFjOp63xgZcQCsUSKDaCusK0bI2Tv0pHUm?=
 =?iso-8859-1?Q?A2JrSCBpFGurF9tDmnFtXybjMuC61aEH5NspdU8Rx8WQTsQMAmxagOdH9e?=
 =?iso-8859-1?Q?59eV5pnSNfspgcErKH6pGjXtzPSfmdLC7gm7t+i6hn54EHQksmJwvOHomD?=
 =?iso-8859-1?Q?m8hOloaP8PPYnJmEoMDlUDxVv0WdTVu8L2au4eQgCnxAIrwWSIlGMbJ3bF?=
 =?iso-8859-1?Q?HkwYdzIl/lHoO7bTu9wx0neQqVgHcD2qW+bdBFKmIrMyzdGbEHeUhj7aWj?=
 =?iso-8859-1?Q?emv5vaiecybN+nH8jRoUzIIayhjno3aIGCCbK9VeTplZ8txzJfefMC9ekM?=
 =?iso-8859-1?Q?LdqlKpj+twIbUap4EgS/KkBZVJNTM6kXhSPqtRR317hkgcMoHy2MWqbeda?=
 =?iso-8859-1?Q?VHgUKdfim9vtfNUxKp3vhmktD6IhaTTfDFWSVI+raEXuqnYeWKZu69zeCs?=
 =?iso-8859-1?Q?Oldw+squuhbSQ7Q8CDOoI+/WIPc9Pah+JEUd/K3ZE+PMdDqCbHs3MjXgSr?=
 =?iso-8859-1?Q?dkhjnDx5lb1dX3ktPl/qfggcDSAFgbovOJWG1u/057rSvSH3J4GrJ4BaI9?=
 =?iso-8859-1?Q?oCEO1+gFktVse9l2u0YLkilpAKz3vPg5uEbxMpgayPLHLoC0h0mI5OkOfi?=
 =?iso-8859-1?Q?CSoUKUeeYWuB0DVmJ38bPS?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6402
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B0.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	96aabd7d-6208-409f-f647-08dd55a3c91a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|14060799003|36860700013|376014|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?ufoADgxMqqprGHaq58eq6eXkL9MSxiVencK44hQeCjYQXf61Q5VtJ6EQ9A?=
 =?iso-8859-1?Q?Ilxd6CSlyVgY60/UkIegn6SG3fUNPqb9cLEPuAO1pvI62EoqC3eujR9xne?=
 =?iso-8859-1?Q?Th4ASgGBtqlV7mUjq5gplBi0sJo2sxfhApHaD7A87RpfweN4ZyT1HDLfFD?=
 =?iso-8859-1?Q?7xkcjaIdC7CyUdvzF9kwU0ZEuVBxyVO8QQYoGLldN/GshSmjMVL4rniJyW?=
 =?iso-8859-1?Q?jlHwrbRgXC74GXPXEPebxukoLdKBiPei1y8YtcLV1nlRZ4CJlfbXltk9Pa?=
 =?iso-8859-1?Q?0xlq66R6R8aaRq913GG2hecM4hS8I0GXp/8wBm2tX4LRMHMzsntioxCCKE?=
 =?iso-8859-1?Q?P05TfNpVO/vKzK/L166aMSf/Syo+C1g1JzVh2mhB3uLalznQwpX5AP3vVv?=
 =?iso-8859-1?Q?dtGpwkQC3Sm7giXDrT4ey74pGam5NjxL9g5vh1mT4tQWVnyVI4eUbsYU/i?=
 =?iso-8859-1?Q?6ANXsVZv8tX33+Ry3IKbrOHx2LXsm9IoK1MSnaNlbfB5GNhtTb4XZaDxFY?=
 =?iso-8859-1?Q?KMANc7AbOpou4ZxGBUSv0cPNk3PUcyP1OBvgWoz5iMCDilL0iAMw5zd7Lc?=
 =?iso-8859-1?Q?cGBQ+SPe6+ga1Xs78k1+GF2L7c+5+a6pNlluHQPYGrVZkUaN2uZRxlTgEe?=
 =?iso-8859-1?Q?LaOkspWA9yjZJkH+A5VL+os9rdRXAHX5oe7bdQcXRqqjHQKX4ZfuB5/Kk+?=
 =?iso-8859-1?Q?YUB1jl5tPVtRezvZSHPlgVsJI7ZrZAlkJ+IWEpykb6aiSn///o+LFamqmE?=
 =?iso-8859-1?Q?DV94nGihzONcSdAssT27u3CgRY8iLv+BE8z6K0sa2McGFL1iIdx4Zv65P5?=
 =?iso-8859-1?Q?SDLbIeC6FeNZyZeIklQHVCuo8iC5OFcEMVStG8o7i1YKk3L1zQAeD3gJa/?=
 =?iso-8859-1?Q?sbbYpiacsS+AKj+j8nm89IKHHK1lM5c8wDLB0cbkczGrfivWtjOEJifquO?=
 =?iso-8859-1?Q?qyab0xg+FlBYmXF20RxuA9HsAp3BIRf02WdtB4sGCN9lzwrW5Bcv1zmIHX?=
 =?iso-8859-1?Q?AmsedkWz/ClaE+EKgx7OmNgAsLCBKl++dMun++pmjoCi483cXGIStn+ucg?=
 =?iso-8859-1?Q?ddBmZciQUFD9T1AklIX/6/dTbkMJQRaPBbldsoSsb6SBPlE1I/+NnIZ0Qb?=
 =?iso-8859-1?Q?tc/cfwiBh4qyFHjJZ1+FRp6skZdIvC9bM5ac+PAWS0zizktD+5skaI4HVS?=
 =?iso-8859-1?Q?prll/OoUYrGSJlnztaSOHoxCnRTHsQk6+FNfaPmEsL3bwvLj4jtRhzkF04?=
 =?iso-8859-1?Q?tYYxO3lAKx6JS34PDS75mQ4oy4eQhR2yUMrsCiMT8CxwefvDBU+0Uce7N7?=
 =?iso-8859-1?Q?NuRQOsDKM6j3x4MtU90v38KQUdzUYBWG5PibN3o4vw+CRGYIVKq3s0EkTp?=
 =?iso-8859-1?Q?4TqRJlg6f62iRvLpS1IAS8ohTZe6HYdRJNJ1rOWN/mgbLhP9tkzk0lm6Y6?=
 =?iso-8859-1?Q?ROcx57OV92PHfEqSw7yLrMIBS0YW6Ynsp0jfiNEDE6lZ7r5kt3k+oyAwSX?=
 =?iso-8859-1?Q?rdyj8mhNcgWHmwbopoYNUAavoaBMShrwY0cW1uy+13OVKEQhlsLUIfvOGl?=
 =?iso-8859-1?Q?qN7JMPA=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(14060799003)(36860700013)(376014)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 13:53:38.6523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b62439-99b1-46c7-4fdd-08dd55a3ce61
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9758

Hi Suzuki.=0A=
=0A=
> This doesn't apply cleanly on coresight next branch. Please could you=0A=
> rebase on coresight /next ?=0A=
>=0A=
> Cheers=0A=
> Suzuki=0A=
=0A=
Thanks. I'll rebase and send again :)=

