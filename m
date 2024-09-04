Return-Path: <linux-kernel+bounces-314345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BD596B219
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D95A41C20CFA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 06:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C810F145B1B;
	Wed,  4 Sep 2024 06:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttcontrol.com header.i=@ttcontrol.com header.b="ipLYrFcK"
Received: from mx08-0061a602.pphosted.com (mx08-0061a602.pphosted.com [205.220.185.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19446145A05
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 06:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.185.213
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725432483; cv=fail; b=bl50MSVAQ84EujjaOJHr2GiV57qPRtgQNeP11Y27V1tsJMMuI/v4hIQtPEUF0ZiV0MNkq+Hvihr9iGwkN/AuhRNlyAqGzWuXhDdyqrEDguG5r23/p+2QbPlYClTeOvT8XJkSQFWFWL1jFQupLq+E73kN5Jq6QYkwqQOOe9i1qfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725432483; c=relaxed/simple;
	bh=8Tsu9oKfdNs/5FtMibLGLvIICA97szAZKUEXrBQ7MKg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EjUcfcemrWnudaaNRLJTXP5UYfo0KoeLNBSaphRIif20uhaNekfx4/5UZs04tqlu+zHTyaMtK/U3KRMKALDPu+/XhZZAbSlzu061LXuyS+Vc0S0Tk2XGNOWz5zi/WhWXpf5kLtXpIcM/bWXGN3FyfMRJBf1Vy3QDtm7TtcnmQHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttcontrol.com; spf=pass smtp.mailfrom=ttcontrol.com; dkim=pass (2048-bit key) header.d=ttcontrol.com header.i=@ttcontrol.com header.b=ipLYrFcK; arc=fail smtp.client-ip=205.220.185.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttcontrol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttcontrol.com
Received: from pps.filterd (m0278994.ppops.net [127.0.0.1])
	by mx07-0061a602.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4842IhJQ006497
	for <linux-kernel@vger.kernel.org>; Wed, 4 Sep 2024 06:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ttcontrol.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2021; bh=WEWIwvbZWdcLcBJw830XO1okiMWE/z7sHJJUa5HYA7M=; b=ipLYrF
	cK7Mp/WItM7y+73tQ3Co8oIhX7g+tdWPsbNw1ByhHsPKjnsu4BjvgBQG79/aYnsU
	w6KGO/nLLtU9gMri6TtPB40lOPqB18iAXsUx+vvY71whQHseM7CAHbKbPggF2nuV
	DNKsk+unb4eNIy8DosAMWIUcnlJGJu9iIpp+ilqfkr8u6mhWnQqfC75Ax8w2ewCk
	yR8tAe0Byc1fx+mFZNGYG1gBbAUjzuB2O0u8xb/pshOpKoa62PyQBWOZzsIyohs7
	hQ8QVU8qCZ5YSQwTcgywOb/zCphT4UUw1bKDLJBXJYwPQbmJWrqsj7/eKDqsMILc
	vVFGKEImBFeHWxBg==
Received: from duzpr83cu001.outbound.protection.outlook.com (mail-northeuropeazlp17013014.outbound.protection.outlook.com [40.93.64.14])
	by mx07-0061a602.pphosted.com (PPS) with ESMTPS id 41edy987as-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 06:47:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khsls//gpaCAMu5qg6A4Sx8IE+IlAG3WY+bWH3bI5n4thLVri8yYiUZlRElxkvDV/3XUxOsc+oMMUUJCl2AQzlNdOqtxBEUCtSpk9IjkLKPCHvOOmqMMX4DFRlsXCAf993DGOLdz2kuOYgjGgu9rlJ3NkxG9n9+STe3pseI5JkgV75fhX1MIcqjfG1a2WscwOQ++1NFb9bY6jHP3mME8Ju+XY15IhgkaHLEu6faaPHLb0zJLsRuxR3vLjHGw1WEEi6zXKunDoGCPzzMnIFc+VXDnLpBy2ks+66y8iBz+NL7xSG/r7jJF/Ah1Wc0Guz8RXPouvI7M8YngzCgSMEA5XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEWIwvbZWdcLcBJw830XO1okiMWE/z7sHJJUa5HYA7M=;
 b=rQjfI+5dg8lKufhso6V8CRHb+r0Qf3LCGhv4W/aUdIuR09UOtdSBqJO+S7lopWwMywxPVFLOJpvXxFkh0VoW2fExWC/Ejf6zv4TxkzjlaL1VEAY/vtWvHMkVqZ5neycWahqZsrernx85tL6k92l6NhFfFYO9Qe1t7CB1d931bH1u+L4ImgAdBMJzRn4sg9JPVxfOxums3ZLrTjKmG6R5NFkAct2Y9DvIlTNjwAqEdph4dQ0QW0tbhWSHe9Bhq/pP321WGcGgVoHEdBlPHHBDhJeNiBYPqw5XJaeSwC7iQbjVhTRZRW02ABcFp1yOeMlvfY1V42XG/Vu1PLtyQWRjoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ttcontrol.com; dmarc=pass action=none
 header.from=ttcontrol.com; dkim=pass header.d=ttcontrol.com; arc=none
Received: from DU0PR01MB9382.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:32d::6) by GVXPR01MB10965.eurprd01.prod.exchangelabs.com
 (2603:10a6:150:21c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 06:47:45 +0000
Received: from DU0PR01MB9382.eurprd01.prod.exchangelabs.com
 ([fe80::c41d:dc9b:3f97:1ae1]) by DU0PR01MB9382.eurprd01.prod.exchangelabs.com
 ([fe80::c41d:dc9b:3f97:1ae1%7]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 06:47:45 +0000
From: Diogo Manuel Pais Silva <diogo.pais@ttcontrol.com>
To: Peng Fan <peng.fan@nxp.com>, Abel Vesa <abel.vesa@linaro.org>
CC: "abelvesa@kernel.org" <abelvesa@kernel.org>,
        "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "sboyd@kernel.org"
	<sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "imx@lists.linux.dev"
	<imx@lists.linux.dev>,
        "EMC: linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] clk: imx8qxp: Defer instead of failing probe
Thread-Topic: [PATCH v3] clk: imx8qxp: Defer instead of failing probe
Thread-Index: AQHa/ULwBX4QDqA/8Ua7zDhzNMik3rJG4uOAgABNqdk=
Date: Wed, 4 Sep 2024 06:47:45 +0000
Message-ID:
 <DU0PR01MB93828BA400376EB1D6EEBDA19D9C2@DU0PR01MB9382.eurprd01.prod.exchangelabs.com>
References:
 <DU0PR01MB93828B0E6808E33C608BC0E29DD32@DU0PR01MB9382.eurprd01.prod.exchangelabs.com>
 <AM6PR04MB5941651E3920794104B3D24F88D32@AM6PR04MB5941.eurprd04.prod.outlook.com>
 <DU0PR01MB9382F1AC496F22A20C074BDE9DDC2@DU0PR01MB9382.eurprd01.prod.exchangelabs.com>
 <Zs7gXhohOyQ/abOf@linaro.org>
 <DU0PR01MB9382A2BBCCD8C786121975B89D922@DU0PR01MB9382.eurprd01.prod.exchangelabs.com>
 <PAXPR04MB84591356511162E61E074221889C2@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB84591356511162E61E074221889C2@PAXPR04MB8459.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_6d12e765-bdb3-4a42-8d1e-507ff5c9fe67_Enabled=True;MSIP_Label_6d12e765-bdb3-4a42-8d1e-507ff5c9fe67_SiteId=5638dc0c-ffa2-418f-8078-70f739ff781f;MSIP_Label_6d12e765-bdb3-4a42-8d1e-507ff5c9fe67_SetDate=2024-09-04T06:47:44.671Z;MSIP_Label_6d12e765-bdb3-4a42-8d1e-507ff5c9fe67_Name=TTControl
 -
 Public;MSIP_Label_6d12e765-bdb3-4a42-8d1e-507ff5c9fe67_ContentBits=0;MSIP_Label_6d12e765-bdb3-4a42-8d1e-507ff5c9fe67_Method=Standard;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR01MB9382:EE_|GVXPR01MB10965:EE_
x-ms-office365-filtering-correlation-id: 300170a7-97c2-447f-d5c1-08dcccad7b62
x-ld-processed: 5638dc0c-ffa2-418f-8078-70f739ff781f,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?W1wWvSQ+SIMheYZJjjaUL+saaKfzNBLuUX6D7MEVt5UJNVwOKak7+B5gQa?=
 =?iso-8859-1?Q?HF62p6ZirVSIST/zw0VOvdFRTDhmM5lc5e1JkquvqV2yGBa26FEcRcKa+4?=
 =?iso-8859-1?Q?hr8lKYziORSBW6LfzgeRjASUZl+BvgsQ4nVeDsNgavphot8KNwwDKlhoVr?=
 =?iso-8859-1?Q?COI7jP5hq3wo7rSKgwOfVu0lt/Owul6xHa4wTXhaOoM/xUSm3zRJbevV29?=
 =?iso-8859-1?Q?gi8e8iskmiKKGcLFZiq5FgQI9cTGFzeUfxXM19PizLoP/wHcljTmLOqCA7?=
 =?iso-8859-1?Q?iO7ytRmNVBvimOodJORTbSTgzz34twZCzScFotCww335c2lr6J64g5VKj3?=
 =?iso-8859-1?Q?W4o2i8VxdRxkySf0Uw8tJ7kc0x3ImCBFTFWG8g6wVxcEHchjQ82Sho0U2i?=
 =?iso-8859-1?Q?RN0VXl9wmsxZG+CQNYt2xN6lAM8SwNBGC2zcJyEHWZDCqL6Pw93gqGXN3d?=
 =?iso-8859-1?Q?30s6MS60Ibr0s5lYKzbNFnODa/WeqjfQAkcpIbYecDjeo3ETtWHo9Ng233?=
 =?iso-8859-1?Q?Xeb+jCBg85rgEYtuK6xyRMd92BbQeg4NXlqGkqEVk7LmS6o7+gNtiNNQVT?=
 =?iso-8859-1?Q?5MoaRPD3nlpAJNYvdfb+3BZHXmUfworIBtTPT92F3+ZHYWGG2B4GM+7lCA?=
 =?iso-8859-1?Q?iSn0XgtuwKrBwcq1T7CBkAoDB2YFb0Q0QQ54rsdXU2rTPWtmyUmlZIyT28?=
 =?iso-8859-1?Q?IA1+ZrJjFvDqkRnzhlL8Hr0wpHgwKEnD5/kJddEmamjCuqUbE0wVivvDnR?=
 =?iso-8859-1?Q?YU6jtxe5Zly9FYr9EacxYk5NNIGMh0fGX+LeCS6Ww7WSPKN/BCv87Lljji?=
 =?iso-8859-1?Q?10bsHhjjlMhpBHOKv5L5KT+tEGg5hjGfYP4P6f2/pzRNDb1tr1GqwjtoTF?=
 =?iso-8859-1?Q?9ZRSTzk2L7cRXPqETfNqkc3CU97EJLbiwlZWEvQldsnw0/zSWrhXDwEsWi?=
 =?iso-8859-1?Q?BAEQXvAt0JSRhikQNNK/hTgYWHf+at+xT8EL5ED/d3Gt2XhoTp82j9yGz6?=
 =?iso-8859-1?Q?3Y3+Ss8TulI8YROjelgPpX1B80GYg4p/KAmyemNwGcbQt5Q2NLW8bw0CsD?=
 =?iso-8859-1?Q?b5vqK9jgbMImqWhoknOwKkgMdyhIgvVhGJ6eU+ilo9DILwqs0SzoGVbPpC?=
 =?iso-8859-1?Q?cWZHIw3GPIy6Jm99WL9i2M9egu2s/WJERJInl/h5vourRQwBUM8P1+LiyH?=
 =?iso-8859-1?Q?ecXLiLfroxX/oXZuSgnxz+x5uxnyo/HR4KtyaC5S1YdnoOkOLBiAAbZ2Ph?=
 =?iso-8859-1?Q?zqHZvjeruTjilV2FTCWuhU5AFKTJUPKMOIT9rG9JTZhGT82LaeCLTbIwYO?=
 =?iso-8859-1?Q?weLh9doPHonsejFu0w5dDwwCr2DOqty+m8JOyjBRjgPKD64JBLUjpSuxli?=
 =?iso-8859-1?Q?YtTQZGNoRscVR6/YFtGdsTKzexb2tAtkK3//oXtymvH0BwmAxTUhEnOfjR?=
 =?iso-8859-1?Q?MRKaoAZJTIHoVmWzV8y6VxclRS81Wp4IgFD3Xw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR01MB9382.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?lYKFwVggouxY12PDeBmXC7P8WUYfshtWWXZ1YdtRJ2A+KR2lAHq46NbsuG?=
 =?iso-8859-1?Q?XnHHCCSg+T2chp9q9vR/OpNiyULvOzDAEP1E52L1cm+T4XwvBGCobz5R4u?=
 =?iso-8859-1?Q?uvcsXdLPJhW1NYCOXDCEAzn7os+KrsJa9h5XBbObItkIOZNutWzGoPk29i?=
 =?iso-8859-1?Q?Jv0Oen5PGpL7ojrxN53VMK3epRXbBfroHyG60b2bswEIS6LL825VqpNini?=
 =?iso-8859-1?Q?QQHCPB6mk5rUEFtsi/uDyRa1j9JkCcaxnxlFqEbUdY60lq5ycGgP6/Gokj?=
 =?iso-8859-1?Q?dXusftERyLj2gGmnSDKaTn6qJKIPnNtXLj1z5ZmvSLI3kA8RHPVEn9ySpT?=
 =?iso-8859-1?Q?u0E5d01VpYARG7jxVH7V4MOk7lKHzGoGmbtkpdU1m8H05teXbj+4BLO/Dm?=
 =?iso-8859-1?Q?nT8MVSpkiIIC/qTa0A3rdq+EcDHDHpHOhW4vLJYXpcTIU9Iomst35IBtbd?=
 =?iso-8859-1?Q?Mz1FiPaq/YOIKjyA9ZwYKAi+aiPtkeLLZlX5ym8bX5wu2Eh1ijpPDrHbwP?=
 =?iso-8859-1?Q?zTEeBt1zZMHvSjreFLdlkTKl3mr0gMLv0DrPw9OtLbcLztJkdr7iuamJPs?=
 =?iso-8859-1?Q?+j2h3RptJQeUv6jaSlPqz6FTTqkc1NM1Tjgla3W635P1VmQQSYaaXyIMOD?=
 =?iso-8859-1?Q?W6L1rx6tJ6nW3jKf9sutyqK0HazxehUaZF2Hf4U4ANPOSQXDIFZXBXMLbz?=
 =?iso-8859-1?Q?tul5vQRF6hzDMwOhBWypvtQg56oKW2NLh69V8h3cfjU8wR4/i3YLO+jvXA?=
 =?iso-8859-1?Q?7C7gfG/rAP4+R+UYM8hi4HalP4qwvx7XgCW1IBZziOVe/VVpMOvvmLr50c?=
 =?iso-8859-1?Q?MvXp0E7UWRXXwSSD0ucJd6qWWZzZK+BenNof+ZNxo3spc7ug+kMcNBlCzX?=
 =?iso-8859-1?Q?vt3o8QjPEal/ozz4+PRbfOsooIlrOqTR1RsEA8WuKOXzpbZoOojvA37q57?=
 =?iso-8859-1?Q?oINa4jkKS8wgSImyBLGobOBrkBIwYpKQRdPaK1h+T/tJFRNs1AMSgAclbB?=
 =?iso-8859-1?Q?Xhu0fyDFhmPd0KpmvExNbNeqJx2nfzL/Mitm0gEonhMuTKletb/c50PZeZ?=
 =?iso-8859-1?Q?hqgvMvdbmxPhxIPuX+LvQXFVQsU6Prjj6n9eIbr3q0fgmlcxs5Pdd6YINg?=
 =?iso-8859-1?Q?mSGrj+H6HYkkF7tePiJA0KY6kg75tZX/889xnpDRPX4ZP3BKHMmHJ9xSRB?=
 =?iso-8859-1?Q?lw+5MK9DqPgV0fCkcEEizni0QaQ9RjIuRxRGsCU1J31VF+ChNJpxPy0K3H?=
 =?iso-8859-1?Q?RbI/Ls5hfb91WtikOdPolQbO5e3XplA9ZErmp0WTwov87GOJYvcJrS41De?=
 =?iso-8859-1?Q?rNCPErc9YQaxjWYB9mWe8qFSuCmgXaEV6zN2ipFyBzwUAp4D43EAHjgZCj?=
 =?iso-8859-1?Q?2F9le2E6ZRoo7uUQjqD6zFrOZldu5a5oCTvOk3m7HShYNMVAr75XXU6UqP?=
 =?iso-8859-1?Q?p1eYh6U3YbbTnU1QeADAps39eLbRASLvuKNw9YbEhOzeLmQTZbxvyMSbIV?=
 =?iso-8859-1?Q?QgPKYxB05RT0PH5pZdhmuCU/c7LcDN3Ph8PGTIyfqV3l9D+meRrS+dpxEH?=
 =?iso-8859-1?Q?H9ZW4ZaLB608h2AzoKlIiNEuDZTZWeGt+eRH6C+iwhmOJiGx9Jf+8J5IrJ?=
 =?iso-8859-1?Q?932h+8jVy4IgaU5eDV2qAXVhltlrO1nnb/?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ttcontrol.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR01MB9382.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 300170a7-97c2-447f-d5c1-08dcccad7b62
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 06:47:45.1157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5638dc0c-ffa2-418f-8078-70f739ff781f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YlKKpmwNxrUI9QBOPwxO7SnZojCrV1+HQiSrjNI86MYjZ32yMLl7Kgoh/aLp03Pl6W3eRPime0LcY+32MSKf6ZUS4zShk2RHsEE0UrMq0K0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR01MB10965
X-Proofpoint-GUID: JkiJ8ZgIEYrmaupHZq3CfG4upASYrMcY
X-Authority-Analysis: v=2.4 cv=RpCXLzmK c=1 sm=1 tr=0 ts=66d80296 cx=c_pps a=sxbXCBvE7ebpWdnPLwrrUQ==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=EaEq8P2WXUwA:10 a=9E89HhfwiosA:10 a=EZQmGfNXMHUA:10 a=8AirrxEcAAAA:8
 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=IpJZQVW2AAAA:8 a=pGLkceISAAAA:8 a=nxb4IF0AAAAA:8 a=KKAkSRfTAAAA:8 a=rsmfmBjOAAAA:8 a=Qr78a3XGCp7qmsgNzh4A:9 a=wPNLvfGTeEIA:10 a=ST-jHhOKWsTCqRlWije3:22 a=1CNFftbPRP8L7MoqJWF3:22 a=IawgGOuG5U0WyFbmm1f5:22
 a=muotpCzfy8uUhEcWaHt4:22 a=cvBusfyB2V15izCimMoJ:22 a=5SoQ0aNoiOvKt2feW1sf:22
X-Proofpoint-ORIG-GUID: JkiJ8ZgIEYrmaupHZq3CfG4upASYrMcY

Hi Peng,=0A=
=0A=
Thanks for pointing that out, I missed it. I will submit a v4.=0A=
Yes, the issue only happens when fw_devlink is disabled. I believe this is =
because devlink generates the device dependency graphs and only probes this=
 device when all the dependencies are met. When the devlink is disabled thi=
s dependency is not respect as far as probing order goes, so it can happen =
that the device is probed when the clock parent is yet to be probed.=0A=
=0A=
Best regards,=0A=
Diogo Silva=0A=
________________________________________=0A=
From: Peng Fan <peng.fan@nxp.com>=0A=
Sent: Wednesday, September 4, 2024 4:03 AM=0A=
To: Diogo Manuel Pais Silva; Abel Vesa=0A=
Cc: abelvesa@kernel.org; linux-clk@vger.kernel.org; shawnguo@kernel.org; ke=
rnel@pengutronix.de; s.hauer@pengutronix.de; linux-arm-kernel@lists.infrade=
ad.org; sboyd@kernel.org; mturquette@baylibre.com; festevam@gmail.com; imx@=
lists.linux.dev; EMC: linux-kernel@vger.kernel.org=0A=
Subject: RE: [PATCH v3] clk: imx8qxp: Defer instead of failing probe=0A=
=0A=
Hi Diogo,=0A=
=0A=
> Subject: [PATCH v3] clk: imx8qxp: Defer instead of failing probe=0A=
>=0A=
> When of_clk_parent_fill is ran without all the parent clocks having=0A=
> been probed then the probe function will return -EINVAL, making it so=0A=
> that the probe isn't attempted again. As fw_devlink is on by default=0A=
> this does not usually happen, but if fw_devlink is disabled then it is=0A=
> very possible that the parent clock will be probed after the lpcg first=
=0A=
> attempt.=0A=
=0A=
Did you meet issue with fw_devlink disabled?=0A=
=0A=
>=0A=
> Signed-off-by: Diogo Silva <diogo.pais@ttcontrol.com>=0A=
> ---=0A=
> v2: change from dev_warn to dev_err_probe=0A=
> v3: refresh patch=0A=
> ---=0A=
>  drivers/clk/imx/clk-imx8qxp-lpcg.c | 4 ++--=0A=
>  1 file changed, 2 insertions(+), 2 deletions(-)=0A=
>=0A=
> diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c b/drivers/clk/imx/clk-=0A=
> imx8qxp-lpcg.c=0A=
> index d0ccaa040225..cae8f6060fe8 100644=0A=
> --- a/drivers/clk/imx/clk-imx8qxp-lpcg.c=0A=
> +++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c=0A=
> @@ -225,8 +225,8 @@ static int imx_lpcg_parse_clks_from_dt(struct=0A=
> platform_device *pdev,=0A=
>=0A=
>         ret =3D of_clk_parent_fill(np, parent_names, count);=0A=
>         if (ret !=3D count) {=0A=
> -               dev_err(&pdev->dev, "failed to get clock parent names\n")=
;=0A=
> -               return count;=0A=
> +               return dev_err_probe(&pdev->dev, -EPROBE_DEFER,=0A=
> +                                    "failed to get all clock parent=0A=
> + names\n");=0A=
>         }=0A=
=0A=
The change is not enough, you also need to handle=0A=
        ret =3D imx_lpcg_parse_clks_from_dt(pdev, np);=0A=
        if (!ret)=0A=
                return 0;=0A=
->=0A=
        ret =3D imx_lpcg_parse_clks_from_dt(pdev, np);=0A=
        if (!ret)=0A=
                return 0;=0A=
        if (ret =3D=3D -EPROBE_DEFER)=0A=
                return ret;=0A=
=0A=
Regards,=0A=
Peng.=0A=
=0A=
>=0A=
>         ret =3D of_property_read_string_array(np, "clock-output-names",=
=0A=
> --=0A=
> 2.34.1=0A=
> ________________________________________=0A=
> From: Abel Vesa <abel.vesa@linaro.org>=0A=
> Sent: Wednesday, August 28, 2024 10:31 AM=0A=
> To: Diogo Manuel Pais Silva=0A=
> Cc: Peng Fan; abelvesa@kernel.org; linux-clk@vger.kernel.org;=0A=
> shawnguo@kernel.org; kernel@pengutronix.de;=0A=
> s.hauer@pengutronix.de; linux-arm-kernel@lists.infradead.org;=0A=
> sboyd@kernel.org; mturquette@baylibre.com; festevam@gmail.com;=0A=
> imx@lists.linux.dev; EMC: linux-kernel@vger.kernel.org=0A=
> Subject: Re: [PATCH v2] clk: imx8qxp: Defer instead of failing probe=0A=
>=0A=
> On 24-07-02 08:10:44, Diogo Manuel Pais Silva wrote:=0A=
> > When of_clk_parent_fill is ran without all the parent clocks having=0A=
> been probed then the probe function will return -EINVAL, making it so=0A=
> that the probe isn't attempted again. As fw_devlink is on by default=0A=
> this does not usually happen, but if fw_devlink is disabled then it is=0A=
> very possible that the parent clock will be probed after the lpcg first=
=0A=
> attempt.=0A=
> >=0A=
> > Signed-off-by: Diogo Silva <diogo.pais@ttcontrol.com>=0A=
>=0A=
> This patch doesn't apply cleanly.=0A=
>=0A=
> Please respin.=0A=
>=0A=
> Thanks!=0A=
>=0A=
> > ---=0A=
> > v2: change from dev_warn to dev_err_probe=0A=
> > ---=0A=
> >  drivers/clk/imx/clk-imx8qxp-lpcg.c | 4 ++--=0A=
> >  1 file changed, 2 insertions(+), 2 deletions(-)=0A=
> >=0A=
> > diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c=0A=
> > b/drivers/clk/imx/clk-imx8qxp-lpcg.c=0A=
> > index d0ccaa040225..7bd9b745edbe 100644=0A=
> > --- a/drivers/clk/imx/clk-imx8qxp-lpcg.c=0A=
> > +++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c=0A=
> > @@ -225,8 +225,8 @@ static int=0A=
> imx_lpcg_parse_clks_from_dt(struct=0A=
> > platform_device *pdev,=0A=
> >=0A=
> >       ret =3D of_clk_parent_fill(np, parent_names, count);=0A=
> >       if (ret !=3D count) {=0A=
> > -             dev_err(&pdev->dev, "failed to get clock parent names\n")=
;=0A=
> > -             return count;=0A=
> > +             return dev_err_probe(&pdev->dev, -EPROBE_DEFER,=0A=
> > +                             "failed to get all clock parent=0A=
> > + names\n");=0A=
> >       }=0A=
> >=0A=
> >       ret =3D of_property_read_string_array(np, "clock-output-names",=
=0A=
> > --=0A=
> > 2.34.1=0A=
> CONFIDENTIALITY: The contents of this e-mail are confidential and=0A=
> intended only for the above addressee(s). If you are not the intended=0A=
> recipient, or the person responsible for delivering it to the intended=0A=
> recipient, copying or delivering it to anyone else or using it in any=0A=
> unauthorized manner is prohibited and may be unlawful. If you receive=0A=
> this e-mail by mistake, please notify the sender and the systems=0A=
> administrator at straymail@tttech.com immediately.=0A=

