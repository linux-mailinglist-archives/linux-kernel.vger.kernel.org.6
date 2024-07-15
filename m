Return-Path: <linux-kernel+bounces-251967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D8A930C50
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 03:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09D671F20FC1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 01:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271524C79;
	Mon, 15 Jul 2024 01:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kKxCSk7p"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012004.outbound.protection.outlook.com [52.101.66.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCC42595;
	Mon, 15 Jul 2024 01:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721005889; cv=fail; b=fNhfR+QhetbzxLuLtQRLf2+mUBGQLJ6lGNeS876ZTwIiqJ3kfACdsVhSQ36aHUfRCI5FH0s4ImPiR8u11G1jfOWUfJak5ESu4UFYQ5NMSiC3aO8K/dZYHbRhzAV25ZVkgxmHWJbF9QvsOuzrS0TRkfP8euYvkkqsn4G5khGUuJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721005889; c=relaxed/simple;
	bh=WAiEAupAng9ATr2JIH4Nl910ZaeMvVWXwvtCukajDgU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OlCtue874eDAnrU/+BVQB0RtLchU1jk1z2YLKl4rRBAG3nVvp1P52T9uKJgvZ5JaGi/XknHXQNWTD1w/xX9RvUXcwv7O1P114Ho0lC75wcre51RdKPnpfhIF+TC/2SuiXXt2wPeL1b3mx640+uDPgyiIqwYJFx6DZw0pSay6zew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kKxCSk7p; arc=fail smtp.client-ip=52.101.66.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XAOU02RiLXzAE08CRzwqQA/jEsJlXSEBml4uqpF/awcG2MzseI13rxPEokQ82YqRIj3LkOppHyEf67DByUZ7oK33X++1/mmX6jGu8lAgpbwYbmKurFNY3HOVVgZtmn8psOgod3y0MHb0Jm0lgIkBkNKFd47n5v0/3lQ+IA3QrBgDZTXl47zi4XGvRsHlDA49Zb2+O8dFetJUFCL9XotbnbNGEUG8APNHxufM5PtiIaZ3C/NgClLSgVV6cHPSJ/m9js8/1zUXnwng7C1Veq6SOjoiJHf/P52uKg+rckWaMvQsNovRQXS5RZYVNinaYx00Apw+3O1VmmNpR61ZyYdATA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAiEAupAng9ATr2JIH4Nl910ZaeMvVWXwvtCukajDgU=;
 b=pI+NRNI8/QHVN7YHlg8FZQSDuFAEJBOy+NeM1EUIrGFEj/4I4LrBbVCTzEAxgxXvpStUtzuCviSRiFfhaDLSmtYLz7/NwPdby6ArP585rmUStHbXA1H9aeVv1WtYo11iCi3/JmUuSyK+4sSTQSYG4QEnaqYUzfn5ci+7hSs3ti3CYy+2ahyM4B0oAJhYiO0UJGaLyhzTZ1UgUNb/bg3pkR057GiaycwZPx0xHuzWXEMiNJnjPeGAeSClY8+X/8koJlNNzpdFPtWlz2ivPIESev3DV1VRrDBH/B8Ess9sPpiSA+cwtJi9s71QYDS3IFDh7ZEnpoe3WR6RYXZhrlF5zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAiEAupAng9ATr2JIH4Nl910ZaeMvVWXwvtCukajDgU=;
 b=kKxCSk7pDNAncfY/AhLwcR2tskrdlRL8Ev9rPIE0bdb4eLH0zS4qEqdGgaLS6rZ9w7jzatqHY3491AJfb7iJktngPD0GKdmOa5Nixohl164NT436gn9lCymAYzSZq1lfi2Aoa8VhVYMPs6EQsnfGKMh0eAVJRBNGndX2xCog4xM=
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10725.eurprd04.prod.outlook.com (2603:10a6:150:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.25; Mon, 15 Jul
 2024 01:11:22 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7762.020; Mon, 15 Jul 2024
 01:11:22 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Adam Ford <aford173@gmail.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: "abelvesa@kernel.org" <abelvesa@kernel.org>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "S.J. Wang" <shengjiu.wang@nxp.com>
Subject: RE: [PATCH V3 05/15] clk: imx: imx8mp-audiomix: remove sdma root
 clock
Thread-Topic: [PATCH V3 05/15] clk: imx: imx8mp-audiomix: remove sdma root
 clock
Thread-Index: AQHauN4p5iIGLXV380i5STgXcwipUbH2rYKAgACIPLA=
Date: Mon, 15 Jul 2024 01:11:22 +0000
Message-ID:
 <PAXPR04MB8459E0FEFFFC4F7FB257F32B88A12@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240607133347.3291040-1-peng.fan@oss.nxp.com>
 <20240607133347.3291040-6-peng.fan@oss.nxp.com>
 <CAHCN7x+pzcdwSq19LefsyYAPUp8=kQYJeVbHm9sgSeaKXigMZg@mail.gmail.com>
In-Reply-To:
 <CAHCN7x+pzcdwSq19LefsyYAPUp8=kQYJeVbHm9sgSeaKXigMZg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|GV1PR04MB10725:EE_
x-ms-office365-filtering-correlation-id: 6c4d4b99-c2fc-45ed-83f6-08dca46b0a55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WWoxemREVk1KOWVpbS9iaVRYMEhWRDhtbGJwckJwZytjcGNlSGpOVzJGSFpx?=
 =?utf-8?B?bjFERGxnOEtmQllLdDFMb3JIRWNxOTd0YjJqRmt1OUpySS9lUzhISVROSFR4?=
 =?utf-8?B?cXhPR0dteGwvbWdLYUVqZFVuYkRtTFNPTWFrTDNNVWszVU9BYTB2ZytLZUlJ?=
 =?utf-8?B?RmYwMXpNSk45Z3U0UW1JT0p2ZmxNaDZxRW5TVENiRDdaUzE1dnVQT2R3TFJo?=
 =?utf-8?B?MlZQODNqK2RJbTJBN1pTODFaMkM3UWRWcTZaRUhSUEtKN1ZzQnMzczY2NXFa?=
 =?utf-8?B?Q1pJMkt4RXhwc1NpdVY2djdtR05WMnpMWGZBU2NuSDN1RTBxQ3dsN2NzU0Zx?=
 =?utf-8?B?TW9QeFB4cFNQY3R1VkxOc2o2dGVlZGZOeEhHU2czRmVZUy9MbU1TNnFTaUpP?=
 =?utf-8?B?ZmdNeHoxb3JQQTFSaVg2K2dJZVNMZEh3M3oreC9rUXBzMzR6QjJ0SERoemVO?=
 =?utf-8?B?dFdranhxdVloVEFyODh3emRhcnRUNTl5L0lSMUE3MVNhejNuS3pTQVN3YmVP?=
 =?utf-8?B?NFY5blJ4WlZ3QmhoeFpKNDE3Q1BNQklyMnpORGw1NUhuSkJDbnRZTXpNQjNO?=
 =?utf-8?B?U0dRd3E3MGJZV0NqRXBKWldRODFackVGQllOaksyUm5LSHgweE5IL3lqUXJO?=
 =?utf-8?B?bDg4TTgxR3F4MEtLeDFhWnpkVy80WU5ZNEdCc1FDbXMvblM1MlN0eC9jc3lY?=
 =?utf-8?B?bUFYZ3F6NjR5VHNwNU9ZTjR6NzVPQTNFQlhRNUxoVTQ1QzkwR3lzR001d1kr?=
 =?utf-8?B?WFFZOHJEcWJiZW1GdVE2TlgyZ3VoeWxqdGNzbjE4R1dlY213VnhoNFNYeGtK?=
 =?utf-8?B?Zi9KK21zb1U0TWs3VHI5MWFTY0NQWmlyVnlSZ2U5ME13cVQ2dGZ2S2ppaEhS?=
 =?utf-8?B?TlVGZ054cWErbGhEa0JSZFJJWUQ0UW03dDRYd056bTBFSmtaTzB4SEl2SGJS?=
 =?utf-8?B?SmlieUJoaTBvVGlUSWE5VHhTZVBBUTlvZlV0azhUNmZaY0VDc0F1aS9rN1Mw?=
 =?utf-8?B?VUdHVkNXdFF1a0VrS0NXV2R2WWVTeWc2U1pkWW9vWE10aVhOdUN4NEJtNXFE?=
 =?utf-8?B?ZUlRZUkwOUR6UFZUNGQ3c3hnT3ZHdEl0eWFLS2NmZWlydGswU0RJOCtKeGRp?=
 =?utf-8?B?d0lPbmpIRlZEMVRreFlkc0xpVnd6dXprQ1E5eTZzQmZKbTFoZCtNbzBCeExq?=
 =?utf-8?B?ZlZXR2cyV1l4OUFCS0xvd1J5NzI3TGZXdG9vQU4zaC95TFFoZ05tbnpNOGRs?=
 =?utf-8?B?UTJzbGhvUzlSeVJaZTZnUlgwK2I2QU5JMEk2ZFNtd2hEYUFtb2JUVGxWSGxi?=
 =?utf-8?B?UkxSTHhsdWpraFlFZU43dnNTNFNZNWNrZG93dEhseDhpbTQwZlYwT0oxcEUr?=
 =?utf-8?B?RE1hSW9Zb1VaZTRQVng3TjNiUTF5ZU5xOGpFeldGeUU2MTdFZlN0YlphQ1lh?=
 =?utf-8?B?d0pUQ0NPZ2tNM0dGNjI0Wkc1T0VjV1pFb2lTL0hWaEdiempsVWo0Q1Q3YmZn?=
 =?utf-8?B?MkZwUnEzd0VRNHBUTlFhVEZvNXdpZi9EVzNPVnVyV24wc25qWUppL0xodUU5?=
 =?utf-8?B?L2p5UU5qZGpVSWRrK1lLZlFVTnhXYXM4VW5sbHlkQTA2S3I1RUhVcVd4QTVi?=
 =?utf-8?B?aDQvYVVLWFNhOThoblp3WFNpK01GTzdkTzZBc0hoczlyWXBSTzRUNWhxbm1R?=
 =?utf-8?B?eG5LdFBoNUVYdXZNSGJIdlJVeFR1bG9wQWMxbUZKRHN4MzdIdUZYeWtraEJI?=
 =?utf-8?B?VUVBLzZvQlZ4S2VzK3FYREtjNURsVUJpR05EekExclZ4dGdmQU00eFAvTzBO?=
 =?utf-8?B?S2NHZFo4aHRwck0yWWhVZVRVaTZJOFpjdVlIZUdwd28zb3UySFppM3lwcVdI?=
 =?utf-8?B?RFJnSjVLRnBMdG1PSER1a29TWk5UK09FTkhST2hYTGlRWmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TndvZnNxczBaS3dkOHdvWndmVDBoRUs2ck9GWVlBcVhrZzh5c3RoU1U1RGZl?=
 =?utf-8?B?N1J6dE9ZcnJLU2g1SUdSN3hOQUlIc0xnZnZxc2psOEVKNU0rUWw0dlZuV1JS?=
 =?utf-8?B?VWoxRDFST3Z3NnV3cW5pRHBKSmpWU2g4VHU1bGhwSHc4R3ZWSmZMTjdFcDNr?=
 =?utf-8?B?NGFBckNXaWJqYldxV3JmNjRsS1J3dlJUWWdYUWRTRkZFeTlZcVdNMDloNGxu?=
 =?utf-8?B?R3ZiRWV4YWtuWWFsZHNFREJUUHF3L29Kc3ZrdWl1Q2VYV3QreU14Zit1WjlL?=
 =?utf-8?B?MDVIdS9oakwxSlh6d000emZXU2Q2MTJuMVJ0bDBoc1JnYVE0dEE4VVpzVXpT?=
 =?utf-8?B?WTdJYUJwL1JLNUZsWXdJRzhGNktVV0lMNnhvRmtCV3U2dFpXVjV1V1Y2Visz?=
 =?utf-8?B?UmZoS3lOaVBFdjgyVnJURHVYVFIveDFiS1dicXFseC8wNmUyMC8xRjZma0Ra?=
 =?utf-8?B?RkloWnUwVkFKUWRaQy95Qk4ySXRONHdDYmRMTGZOQloxbG5zd3VKSXpuQlpJ?=
 =?utf-8?B?U0p4YVpSaTJMTHQvajcwTW94Z2FaVlNqL0JndCs2akFQZ0ZBQjUxUXJ4Q3F2?=
 =?utf-8?B?c2NkWGREdHpGTVIrK2dZS29QdWw3SnNyaXoxOWtLNU05OHlmLzlRRENRTUNq?=
 =?utf-8?B?WEJtVDNZUGJPS0J2R1kvZnJGdzg3MkRSZWRiRU12Tk93TkFBa3d2RUlhZUxm?=
 =?utf-8?B?TlUwZ3BuQ015U1V4cU5LdndOdkExWlExeUtzRzFxeHltMDRzM0QyVHR3NXM2?=
 =?utf-8?B?VEkxNnhJSVZSREhpRW13aCtYMHZlNGdnYU53ZmcxWGVVSU44V3d3Y3QwcGF2?=
 =?utf-8?B?T2dSbllqUHRoZFRkSUJTZHhrOW5rb04xZzRkdW16bkhpT1dyejFCWGFoWjQv?=
 =?utf-8?B?WWwvSWxKUERNTWVidmo1dTZ3L0VZM2xZLzZ5VmszdmIxQWhxN1FSb1AyamZw?=
 =?utf-8?B?azlKVXZTaU1iaWMzeWtEa3phc2dvTGFZM1lQM3BJZ2krK1U2OVhuOENxMXJX?=
 =?utf-8?B?S2Y5SUdJc0VKbHh1ZVAzZDRZTkJNMGVYaHFRSmpLdUZZWDFkb3hzNEF6Ui9h?=
 =?utf-8?B?U3JLYmFKT1Juc1hrYXRFVmprMTdrcUJ0VVBTTjBiUTlaQzErdEZQRmpjTDhx?=
 =?utf-8?B?QmZoYzI4c2o3dDVmNkR1ZkpnZFplanRiUmNTQk16R3Z0RVRYcGJVYUpFekM0?=
 =?utf-8?B?bC8rdkpNYW1pbXgxRnRVQ0tOL1RIcU8xYjZzWW84VGo3YTJkMndhZWdWVDly?=
 =?utf-8?B?eko3N1ArZ3h6NzQzRTh0U01YMEFaQlRWUWNiU1dnVmgwSUR6aldvTEs3WHZi?=
 =?utf-8?B?QjBrRmJvSnFGUVZtSCttcE1SWllnN1NTVzdHcHliWVZwZlErKzJmT1NmQ2Js?=
 =?utf-8?B?aG5ZTkt0N1ZVZkZEYlZPQUd4ZENVSkxZbWQwNzAzMmdYcW5iU0F0b0JLR3BE?=
 =?utf-8?B?TUJoV1Y0T0dpOFNadkhnNmlEeFRlMi92NlNkdlRnSGdrV3B4Q250WEFMVHda?=
 =?utf-8?B?cDhuckpQRFlFOFNwK3hvbHlJK0ppRGtjdkNKcEQ1U2NFd2R4T2gxcGM3NEZZ?=
 =?utf-8?B?WE5nUUJJWno4bmpsVnBTM2VVQ2JENVlLNjc5UEozZmNMeWxKYjF0clo5U3pi?=
 =?utf-8?B?dytaejE5amNVdlozc1V4ZkNUbWpNVFVZNlNIVUNEWDJMWmZhTEJiMGVvQUsy?=
 =?utf-8?B?eWk1MXBFR1JiWEloUXZVeHExWVpDemhDYU9DMlAxK0RCL3F0V1NCcFc1RHQ5?=
 =?utf-8?B?aWI1dFQxL2xGNmRDa2hpbUVSNHVxVk9xdHFrZ1JQZlArSjYyRjlPcEpTcHdS?=
 =?utf-8?B?ZStacjRjMkRUSDlvQVc1c3Bud1dGSWI0MHNBMU5ZS3hoN0duN0VvNUNnWGwv?=
 =?utf-8?B?cXlTODU4VStBdnBPUmtRdkd1NGZLZWEwendMZEk0TktCOG5CbFJ1OWtVbnBi?=
 =?utf-8?B?VVZERlNkb29tWGhWdnlwdjJDRnAvalRMVmZ2eWxxU0JIbDEyMUt3QnBjVVZl?=
 =?utf-8?B?M1d6blZDYkl6TXFjcm9raGJmaVVyWTd5enZaUE1LU0lvYVBUdmpZcmdJMEk3?=
 =?utf-8?B?N09QOERlK2lHQ1BYbjQ0S055QWVINjdNY3RoRUJ6S3FLYnB4em80ZFVBUjgw?=
 =?utf-8?Q?TCcM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4d4b99-c2fc-45ed-83f6-08dca46b0a55
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2024 01:11:22.1227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nS2AT8MCxAT+a+PMEHVBt1/noIPvD49MLi2Gm81D9fwifBvSB+31CCaaHn5FNENn2Rogq/Ur2hKKH0Iv6Oj3+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10725

PiBTdWJqZWN0OiBSZTogW1BBVENIIFYzIDA1LzE1XSBjbGs6IGlteDogaW14OG1wLWF1ZGlvbWl4
OiByZW1vdmUNCj4gc2RtYSByb290IGNsb2NrDQo+IA0KPiBPbiBGcmksIEp1biA3LCAyMDI0IGF0
IDg6MjjigK9BTSBQZW5nIEZhbiAoT1NTKSA8cGVuZy5mYW5Ab3NzLm54cC5jb20+DQo+IHdyb3Rl
Og0KPiA+DQo+ID4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4NCj4gPiBU
aGVyZSBpcyBhbiBpc3N1ZToNCj4gPiBTRE1BMyBjYW4ndCB3b3JrIHdpdGhvdXQgc2V0dGluZyBB
VURJT01JWF9DTEtFTjBbU0RNQTJdIChiaXQtDQo+IDI2KSB0byAxDQo+ID4NCj4gPiBUaGUgd29y
a2Fyb3VuZCBpczoNCj4gPiBBcyB0aGUgcmVzZXQgc3RhdGUgb2YgQVVESU9NSVhfQ0xLRU4wW1NE
TUEyXSBpcyBlbmFibGVkLCB3ZSBqdXN0DQo+IG5lZWQNCj4gPiB0byBrZWVwIGl0IG9uIGFzIHJl
c2V0IHN0YXRlLCBkb24ndCB0b3VjaCBpdCBpbiBrZXJuZWwsIHRoZW4gZXZlcnkNCj4gPiB0aGlu
ZyBpcyBzYW1lIGFzIGJlZm9yZSwgaWYgd2UgcmVnaXN0ZXIgdGhlIGNsb2NrIGluIGNsay1hdWRp
b21peCwNCj4gPiB0aGVuIGtlcm5lbCB3aWxsIHRyeSB0byBkaXNhYmxlIGl0IGluIGlkbGUuDQo+
ID4NCj4gPiBGaXhlczogNmNkOTVmN2IxNTFjICgiY2xrOiBpbXg6IGlteDhtcDogQWRkIGF1ZGlv
bWl4IGJsb2NrDQo+IGNvbnRyb2wiKQ0KPiA+IFJldmlld2VkLWJ5OiBTaGVuZ2ppdSBXYW5nIDxz
aGVuZ2ppdS53YW5nQG54cC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcu
ZmFuQG54cC5jb20+DQo+ID4gLS0tDQo+IA0KPiBXaXRoIHRoaXMgcGF0Y2gsSSBmb3VuZCBpdCBi
cm9rZSB0aGUgaW14OG1wLWJlYWNvbiBib2FyZCB3aGVuDQo+IHJ1bm5pbmcgYXVkaW8gdGhyb3Vn
aCBhIGNvZGVjIGNvbm5lY3RlZCB0byBzYWkzLiAgUmV2ZXJ0aW5nIHRoaXMgcGF0Y2gNCj4gbWFk
ZSB0aGUgY3Jhc2ggZ28gYXdheS4gIElzIHRoZXJlIGEgd2F5IHRvIG1hcmsgdGhlIGNsb2NrIGFz
IGNyaXRpY2FsIHNvDQo+IGl0IGRvZXNuJ3QgZ2V0IGlkbGVkPw0KDQpNYXJrIGl0IGFzIGNyaXRp
Y2FsIG1lYW5zIHRoZSBibGsgY3RybCBuZWVkcyB0byBiZSBwb3dlcmVkIG9uIGFsd2F5cy4NCg0K
WW91IGRyaXZlciB0b3VjaGVkIHRoZSBTRE1BMl9ST09UIGNsb2NrPw0KDQpSZWdhcmRzLA0KUGVu
Zy4NCg0KPiANCj4gYWRhbQ0KPiA+ICBkcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhtcC1hdWRpb21p
eC5jIHwgMSAtDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4bXAtYXVkaW9taXguYw0KPiA+IGIv
ZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4bXAtYXVkaW9taXguYw0KPiA+IGluZGV4IGIzODFkNmY3
ODRjOC4uODhkOGJhOTc1YjVhIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xrL2lteC9jbGst
aW14OG1wLWF1ZGlvbWl4LmMNCj4gPiArKysgYi9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhtcC1h
dWRpb21peC5jDQo+ID4gQEAgLTE3Miw3ICsxNzIsNiBAQCBzdGF0aWMgc3RydWN0IGNsa19pbXg4
bXBfYXVkaW9taXhfc2VsIHNlbHNbXQ0KPiA9IHsNCj4gPiAgICAgICAgIENMS19HQVRFKCJvY3Jh
bWEiLCBPQ1JBTUFfSVBHKSwNCj4gPiAgICAgICAgIENMS19HQVRFKCJhdWQyaHR4IiwgQVVEMkhU
WF9JUEcpLA0KPiA+ICAgICAgICAgQ0xLX0dBVEUoImVhcmNfcGh5IiwgRUFSQ19QSFkpLA0KPiA+
IC0gICAgICAgQ0xLX0dBVEUoInNkbWEyIiwgU0RNQTJfUk9PVCksDQo+ID4gICAgICAgICBDTEtf
R0FURSgic2RtYTMiLCBTRE1BM19ST09UKSwNCj4gPiAgICAgICAgIENMS19HQVRFKCJzcGJhMiIs
IFNQQkEyX1JPT1QpLA0KPiA+ICAgICAgICAgQ0xLX0dBVEUoImRzcCIsIERTUF9ST09UKSwNCj4g
PiAtLQ0KPiA+IDIuMzcuMQ0KPiA+DQo+ID4NCg==

