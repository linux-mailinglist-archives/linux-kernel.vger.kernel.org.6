Return-Path: <linux-kernel+bounces-176108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D9F8C29FE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 20:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 998061C21557
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 18:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4D53D968;
	Fri, 10 May 2024 18:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SXJyHIoE"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2078.outbound.protection.outlook.com [40.107.20.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6625D2EE;
	Fri, 10 May 2024 18:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715366335; cv=fail; b=CCRsBnLiaT2n07LEvXMMb+Fe5kNkbvWKwkyS1iUw3JndzSFkWRv8KCXUdsIsCXoTluXC1mrfrCRK4bWa12d7DY6H7uHfyw3AXvPc3ouDW75wKEzw6+TWHGqPs7HUMnPK4lPflJRhsImf2KAHdXNDQ1FMr8v8xrHI09SitxbQo3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715366335; c=relaxed/simple;
	bh=WMwUtuir+gAPNuI6ez0vCQ2KHH4EWRfAqISPXSWrhWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ib6cgMBPBR4eRtiuhE1rDGUPktPz3KbuwNJAkr7uK7UM+2/cmAeY3K9Xn/YUDaiZebUXahDa1X67oeQCIQI1hZowDdP8sRfuQF0h9EfaAOxEYGpukQtc52p2ASbzjXsh5/VrF2DHbzp2WcSsmArvJZiTorJribHfUrqjOpR751s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=SXJyHIoE; arc=fail smtp.client-ip=40.107.20.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GE9fztAdiShWmj6AyIh65/ZRuzkTIO1EPW94VrQOTDHjx05LljRI97cS5YW4KnfrLQQ2dqtXnDhS5Tcx2iMY2H5ji1jsg8vagPe1o07A8QOkYRp8GSuqEPimxxCbePmMLYpDtfQCuuH7O7fI2MX2RDikCt37znwcYcZYRQZQhG69kYuHY6P3KGfsgBKgCMY4uIABVFrKy9kyW14FTBwksx2OGXSf2uIsRzGs4DHT0hU55PhN9pPR3XhKm4597YT0m3+5hfD3vbcWijFaS+KjimbBZIGrazKiWxP8yUkZvlRl/TnOHKhMS0qfQA5FTiBDrIEqqm3Ym10CXvEt6hysKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUy05h7JmmTSJGy6G5zAcOkdejCJaKJgbL8tFFVYLpQ=;
 b=Pz0o5Up8o1w4/3Wybu0Btlkidr+ESFsUouGWQ0b8/PgcDBjLg0RRkn+O6I4voPkotksrNyms6vsrptMThZB8kiaCWX7ngAVZNgxOQ9Uzp2e0Mu1HkmCMCP8CzwabS17MMzliwTEkb0MpisQZ7d2Oe3Pa5R1n8PpgDueIapWIsli9VpON+GL94kV4Hd3zK/ocJB3KNWHWxUwli++JreszxpAfHAsMMHtYdO5bVkI6z4jehHi32FP3ju755a33LeuoLBIDP1jDqn/Hk7dbhrjs1ObwYi8Fzar+SNaIhyjuRjQoWQiFMrpZ5TPVmrwA5OW86PkLaOLyfdj2oqAAj4mzSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUy05h7JmmTSJGy6G5zAcOkdejCJaKJgbL8tFFVYLpQ=;
 b=SXJyHIoEjGBH6GPaPPFex3ZFF05loFZX2ZuDg+0LzF34eM8ZlZucjEK8cnPW3c1CYrjkJzUWm6K4GeZn1ZdKcEkR8Gcls8WiVad584FMKSSIqti6acB2WcsYfHFnRf4AAURiFHSdkq2YTQUTEzm8/jRjoN5yPsHiUPXS/4AqUl0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 18:38:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 18:38:49 +0000
Date: Fri, 10 May 2024 14:38:41 -0400
From: Frank Li <Frank.li@nxp.com>
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org,
	peng.fan@nxp.com, mturquette@baylibre.com, sboyd@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, imx@lists.linux.dev, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: imx: imx8mp: Add delay after power up
Message-ID: <Zj5psV6ZIFZ/OPth@lizhi-Precision-Tower-5810>
References: <1714966502-27784-1-git-send-email-shengjiu.wang@nxp.com>
 <Zjkftwr4/6KV39sD@lizhi-Precision-Tower-5810>
 <CAA+D8AN9kFdgojkrR0ORUyrtOW=JOn0AfbXFTJ70RE7JxgA2pA@mail.gmail.com>
 <Zjmi4Qc3C3OYJU5n@lizhi-Precision-Tower-5810>
 <CAA+D8AMC41oUEWLuHb-f=U9pEzqWYon22McvT4MucYK=ajNuFQ@mail.gmail.com>
 <Zjmn1jRW2E2kpSlI@lizhi-Precision-Tower-5810>
 <CAA+D8ANuNtaC90fHtGoYiofPTLQHcyCm0p_dcsYTVgT7gsKtMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA+D8ANuNtaC90fHtGoYiofPTLQHcyCm0p_dcsYTVgT7gsKtMg@mail.gmail.com>
X-ClientProxiedBy: BYAPR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:a03:40::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB6821:EE_
X-MS-Office365-Filtering-Correlation-Id: e4aee70d-444f-43f2-5b18-08dc71206ee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|7416005|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UCtvN0taTDVXSGNsRHIrbVhZTlI5cW5zMVpjTmtjdzRMeVlLZHY4Nlo4TXVF?=
 =?utf-8?B?OTRjNmhUNXI2cUkvcC82VzdJMEM1NGgvZThiYTA4NHpvcFlwc2pVY1BjWmd4?=
 =?utf-8?B?REFwSXY4Mk1NYktjZ0VUYmx6bWx0TXBLMjJnSWRIcGdHbTRHMWF3Z3V4OTFo?=
 =?utf-8?B?UWdMZGVyajVlWjM1Qlc2SHAwcU9VS1EybVkvaGFUZEU1OU13NlNGL0ZLelQ1?=
 =?utf-8?B?cGl2SXZZMktYMkpQYlh6OHRXaCtaNUQ0TzZwT280ZysyOWtPc3l3TGEyYjAy?=
 =?utf-8?B?T05pREIxdUNCcDU3RHlhRE5wL0l1VlZpVWxEb0R1cGZ2ZmZDOEUrb3o0OHJR?=
 =?utf-8?B?dU5QbW44Sjg0VHNyMlBmeko1SEVtVUFZV0NFbG5xWjBhNXl2THVDWWcxSC9z?=
 =?utf-8?B?ODd0aHVPVWF1R1p0Q0Q0cmVycnhrNkJ6TFFHdllPT2oydm5SSE9ocFBUaThO?=
 =?utf-8?B?ZGFiRldOVW55Wk11VVFNNE5tZHNCd0lyUm80Slo1OWdjMS81a3dJTTJtL1gx?=
 =?utf-8?B?aERJZkljN0VocnNYQTIzMXdoc3J5U2ErdnZzTUNEZ3hkbldnRjFsTGZJTlFq?=
 =?utf-8?B?VXJKamk2cWYvQS9DMDZYVG03NUVDR3UyblcrM2ZNM2J0U0VxN3lqbnJNaWFD?=
 =?utf-8?B?emxrTWpSSnc0UE05TVh2Q0FoaERHQWVSbGlhQ0VTNEJGSzBpbmMwVEFTYVpB?=
 =?utf-8?B?ZG9meVBBaEJjbGhUWWtUUUtoWVNEckdidGRJaTJ2eWJSUU9QSTZLa3plZXhP?=
 =?utf-8?B?VndMSVR3eUxKVGRzaWhZZ1BtZDhTY2ptbk0vczNlL2hKQWI4TzhUYlNWUkk0?=
 =?utf-8?B?Q0Z5Q0V2TTIwOVhzVUlxZGFvTDNZOG1xMy9BMkVmL1lLOUdYdFMvaUZUVmpH?=
 =?utf-8?B?a1lhcmdpLytmVHpyVHN2dlIraVpTYTVtS1FMd1M5NmFzV3ZRdFVwYzk1TWJ4?=
 =?utf-8?B?TlBka0FsSjBGT0ZJbFRRb3JhK0NtMmZjOGRhdGkrSXVPVGpSbnVNc0tuemR5?=
 =?utf-8?B?eXR1M1NqSmxXaVgxcmdXd01RdlBkTjlVdWpCSFZPdVpCTGJYMkFyWTM5eTVG?=
 =?utf-8?B?S0JxRHF6UmRSNG9mZVRQTHplT1VPQWVyV3JITHNCNElVS1VMTFJtYTRUTHow?=
 =?utf-8?B?UEJwWDFBdUk5amNPYXB6WGd2L2RtQ3EwdEtqUnF0SWxrMEhYNXI5S2RHaWFO?=
 =?utf-8?B?eUVYL0l3TWZBdGY1eThYZ0NSRmhOcktyYVcvb21tcGc5VDJGTGZ1ZzdnOXdI?=
 =?utf-8?B?QlVJaFFSVUVKSjdScS9TNW9MTEdCdFF5TjhGQTE0QmlHaDYzWTdLRWdzUHFz?=
 =?utf-8?B?cmE3QTd2M3hGK3k5T2o0TUJsVHhESEpGYUlTODdTQmFCN2VmSHhYbmh5K2NL?=
 =?utf-8?B?ZEUrUlhMYmFoazFOK2VPRnhrd2pIelhaMzljeHIvQ0tWeWpaWjVFTWNEeC9B?=
 =?utf-8?B?eDhKbld1MU94L1Y4MU5oTWRwY0R0RDBjL1o3cGwrM0RXazNjSHhady8zOWdj?=
 =?utf-8?B?VnFDSnJPLzJ3bXc5cHJVRFI4SjJjUDBnVk9WQktqbDNZQ2EzVUZhQy9XdkZx?=
 =?utf-8?B?MkV0RFA1d25ncmtqMU5Vb0ZKbEpZOFZiN3lkemZacnVxQllkc29oOC9meS9S?=
 =?utf-8?B?ZkN2TDl3bXBlVm5VMjVKaE5QaS9HN0F0OE1PeVk2TDNLS3Rxc2ZzU0gxdTk5?=
 =?utf-8?B?S0dpRmxtUVV5V28xWmsvQkNkNlpsSFJyL3V2L1cwRHRMakNuaVJXcDdsVmZn?=
 =?utf-8?B?ckFScm12MGYyYllnT2w4cEJOYjZkb1liRjc2WXFmeldiNTkyT05mUm1YNUhX?=
 =?utf-8?B?UHpvMndaOHVLRmF0dmREUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rzk4OW9zczNRTG40dWF2QVRiSExZTjgvdHAwVWZxcCtJcWNaOENFLzJEc1lv?=
 =?utf-8?B?UlQ3TWdEVVRyODF4RVpITnhXYlZnMUxjV2hIdVh6Q29uTlVwT1RrR05JdmNn?=
 =?utf-8?B?TmlZZ0o5OWhnMmJwTXhEVGtjb1hCWGRpaVNCQWNvUDdPOFZtUGRlNlVodmpT?=
 =?utf-8?B?cUh3b2VOTUdzcmVZczZtTTBkaVgwSDE4U2UzcWkzNFZyNmlDU0FHZDZ6MlhL?=
 =?utf-8?B?NkxwdFd1VWZWQnE5cXdocm11bHZuR2I5RVJ5RER1MHdWSS9UUVprZnovWHBC?=
 =?utf-8?B?S3dKaEU5YVFiU0h6b3JQeVR6RmkvVXN1VkNReXJuc2krWkJiNXRibkxQSUpZ?=
 =?utf-8?B?SFVldmFZb1BCNml3MXV1aGQ3dHFMR25UeVlRdnVzT2tOZnZkYjFKUEJoOXFi?=
 =?utf-8?B?eWt1RDY2RmdER0gxaVcvZk9LR21WQnhCUitxb3UyRHJxUDNNcnp6eXNyL3BY?=
 =?utf-8?B?Rm1mRlgxU1hmd3V5aFo0VlZ1NW1odCtiSjBlWm5lVUtUL0V6UGNOc1VYOHl3?=
 =?utf-8?B?UnZmSVZUd09UYzh2TGErVTJoeE1XRjdPcUdRalA5WkRWdEFTY1JWaThjbWNz?=
 =?utf-8?B?cElkR2JkMUdCU3Zkc01oQkFrZ0FUVGY3WVFJOElRSW5WeUsxUlEvWDF0ZHFi?=
 =?utf-8?B?ay9yLzhnbDZkQkszTXhDUTRwWTB4Nmw0a3A5KzhraVRFVFZKNEl0OU9tWEQ4?=
 =?utf-8?B?UnFzT0VDaVB2dWdFWlIvRTNWK05maTdGQTdudFovRTJ5NjlpMmIzS2ZPUXZN?=
 =?utf-8?B?Y2ZsRUFFRVZ1bmJwZDMyV3dIUlZvSlBaL01rQmRmTW1KdzZBT3ZVSEpZeit5?=
 =?utf-8?B?S1UrOFBvZXMwNEJPY1IwM3FRMVVXRG9TZVlLVFFjYkNFUmg5bzY5bjFiN2ZS?=
 =?utf-8?B?RFJ6ZDMrZEk2SXhsejlkdm9HaGRnVkhmejl1dFV6T0JsTnpXRHNTYkRsb2pp?=
 =?utf-8?B?RlQ5bXExL25LU3hUT2tpcHgzd1ZsWkdXbWVtRVc0RStTQXhka0FGL3BrZFdk?=
 =?utf-8?B?dnZtM214azNIa0xMbkcvZ0ZqSksya1RLZ3RkU1I1VHpLNTc1M2t5eVhhcGpJ?=
 =?utf-8?B?TStIb3ZpNExZZkdSVFBxWVAwSHZuRjlLZmMvZGIzNzN3Zi9MWTJId3FDRFlm?=
 =?utf-8?B?Q0NtcHh3d2dsajJOaWJxUWE5UG9RTVYvUzFyZlhzV2dRUFdCcWtlVDBBNllC?=
 =?utf-8?B?RnM2RnNDR2RkYjloQmlTQk16anpqWDFDbFR6Y3F0WGNqMTAwTXBYOEpVSVIx?=
 =?utf-8?B?NHZhWmRTc1dYZGFHZ0l0SFV5UUZhcWhlVTJTQzRmSzVac05qM2xvRUpJZUlQ?=
 =?utf-8?B?bmttUDZaVmFveWt1WUJlTENzZDFpNWFXQkxQOFNtaklCaTF1T2NLLzBYSUY3?=
 =?utf-8?B?ZSttMFkya1lncXl2bUNHck9EekZkVEFSS1k3L0xobFFlclI1QlFrRElGNW1s?=
 =?utf-8?B?K3NBL3YyUmtoVWN5THpNdDhZSUo3UUdack1UMW9wRVRnNlJSVXVFVkVQNVBL?=
 =?utf-8?B?QVZ1QWRxUG40VUhyallYZGtIdGZqaXkvQzdnUlAzNzVDbVYrTkRRYWU4NVo2?=
 =?utf-8?B?US9lblB1S0FZL3ptVmN6OUI3c2JlL20vTzNId3kvN3p6YlpIdndjNHo2MFJY?=
 =?utf-8?B?WWJLTExYcjA1YU9hVHVKNVBmMlBZeFlTdnNJM1pNT200Z0hINklGYnFYTU5F?=
 =?utf-8?B?YzYyOXUzK1FDSFRGdzhJRHo0YTc0VGxYTGdqMXpVczI5ZENXRVBGZG1EeDJs?=
 =?utf-8?B?MkhGaENqQVZZMU9YVzgzaXM3b1RVRWVzcVIvejNleUtjKys5Z3NjYytmOUhM?=
 =?utf-8?B?Y29nazQyeFp6VUhYaTNKdDZKNzVsS1Y4blFKUDZVMW1SK2tiNmd6bTZQcGRj?=
 =?utf-8?B?VFM5WFU1TjBOMXVSeHpJSjRBeUl6UU5KK2FKQkNOZHhwWE9pbTVZUWR5Znpa?=
 =?utf-8?B?NlJCS0tJRS9jSjBEaTQ0Yis2QmtRM1RLN1ZwTHpTWW9CU2JKeFE4eCtvRkxw?=
 =?utf-8?B?M1hDUmRRMmhTMDFNV0dWcVlobXJneDdGQVcvQkFyQ3lJSmFwT2t0dEs4OUlH?=
 =?utf-8?B?ZHJZcXdoM3FwVHMvZWVKaWxqb0p1bWpxN2g3cXhBQWFvYkM0OWlLbi9HcWl2?=
 =?utf-8?Q?59EkZ9kMFiUm6FDFtALamDK26?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4aee70d-444f-43f2-5b18-08dc71206ee4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 18:38:49.4240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oWWOf0tp1wEAQfaxjbJ3REcmCsBFMuHwdASw1Q+nHTml3opTInBha97sfhwqS1zzicS874Gl59iKaxzHVF8Qiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6821

On Tue, May 07, 2024 at 04:04:14PM +0800, Shengjiu Wang wrote:
> On Tue, May 7, 2024 at 12:02 PM Frank Li <Frank.li@nxp.com> wrote:
> >
> > On Tue, May 07, 2024 at 11:44:32AM +0800, Shengjiu Wang wrote:
> > > On Tue, May 7, 2024 at 11:41 AM Frank Li <Frank.li@nxp.com> wrote:
> > > >
> > > > On Tue, May 07, 2024 at 09:44:19AM +0800, Shengjiu Wang wrote:
> > > > > On Tue, May 7, 2024 at 2:22 AM Frank Li <Frank.li@nxp.com> wrote:
> > > > > >
> > > > > > On Mon, May 06, 2024 at 11:35:02AM +0800, Shengjiu Wang wrote:
> > > > > > > According to comments in drivers/pmdomain/imx/gpcv2.c:
> > > > > > >
> > > > > > >       /* request the ADB400 to power up */
> > > > > > >       if (domain->bits.hskreq) {
> > > > > > >               regmap_update_bits(domain->regmap, domain->regs->hsk,
> > > > > > >                                  domain->bits.hskreq, domain->bits.hskreq);
> > > > > > >
> > > > > > >               /*
> > > > > > >                * ret = regmap_read_poll_timeout(domain->regmap, domain->regs->hsk, reg_val,
> > > > > > >                *                                (reg_val & domain->bits.hskack), 0,
> > > > > > >                *                                USEC_PER_MSEC);
> > > > > > >                * Technically we need the commented code to wait handshake. But that needs
> > > > > > >                * the BLK-CTL module BUS clk-en bit being set.
> > > > > > >                *
> > > > > > >                * There is a separate BLK-CTL module and we will have such a driver for it,
> > > > > > >                * that driver will set the BUS clk-en bit and handshake will be triggered
> > > > > > >                * automatically there. Just add a delay and suppose the handshake finish
> > > > > > >                * after that.
> > > > > > >                */
> > > > > > >       }
> > > > > > >
> > > > > > > The BLK-CTL module needs to add delay to wait for a handshake request finished
> > > > > > > before accessing registers, which is just after the enabling of the power domain.
> > > > > > >
> > > > > > > Otherwise there is error:
> > > > > > >
> > > > > > > [    2.181035] Kernel panic - not syncing: Asynchronous SError Interrupt
> > > > > > > [    2.181038] CPU: 1 PID: 48 Comm: kworker/u16:2 Not tainted 6.9.0-rc5-next-20240424-00003-g21cec88845c6 #171
> > > > > > > [    2.181047] Hardware name: NXP i.MX8MPlus EVK board (DT)
> > > > > > > [    2.181050] Workqueue: events_unbound deferred_probe_work_func
> > > > > > > [    2.181064] Call trace:
> > > > > > > [...]
> > > > > > > [    2.181142]  arm64_serror_panic+0x6c/0x78
> > > > > > > [    2.181149]  do_serror+0x3c/0x70
> > > > > > > [    2.181157]  el1h_64_error_handler+0x30/0x48
> > > > > > > [    2.181164]  el1h_64_error+0x64/0x68
> > > > > > > [    2.181171]  clk_imx8mp_audiomix_runtime_resume+0x34/0x44
> > > > > > > [    2.181183]  __genpd_runtime_resume+0x30/0x80
> > > > > > > [    2.181195]  genpd_runtime_resume+0x110/0x244
> > > > > > > [    2.181205]  __rpm_callback+0x48/0x1d8
> > > > > > > [    2.181213]  rpm_callback+0x68/0x74
> > > > > > > [    2.181224]  rpm_resume+0x468/0x6c0
> > > > > > > [    2.181234]  __pm_runtime_resume+0x50/0x94
> > > > > > > [    2.181243]  pm_runtime_get_suppliers+0x60/0x8c
> > > > > > > [    2.181258]  __driver_probe_device+0x48/0x12c
> > > > > > > [    2.181268]  driver_probe_device+0xd8/0x15c
> > > > > > > [    2.181278]  __device_attach_driver+0xb8/0x134
> > > > > > > [    2.181290]  bus_for_each_drv+0x84/0xe0
> > > > > > > [    2.181302]  __device_attach+0x9c/0x188
> > > > > > > [    2.181312]  device_initial_probe+0x14/0x20
> > > > > > > [    2.181323]  bus_probe_device+0xac/0xb0
> > > > > > > [    2.181334]  deferred_probe_work_func+0x88/0xc0
> > > > > > > [    2.181344]  process_one_work+0x150/0x290
> > > > > > > [    2.181357]  worker_thread+0x2f8/0x408
> > > > > > > [    2.181370]  kthread+0x110/0x114
> > > > > > > [    2.181381]  ret_from_fork+0x10/0x20
> > > > > > > [    2.181391] SMP: stopping secondary CPUs
> > > > > > >
> > > > > > > Fixes: 1496dd413b2e ("clk: imx: imx8mp: Add pm_runtime support for power saving")
> > > > > > > Reported-by: Francesco Dolcini <francesco@dolcini.it>
> > > > > > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > > > > > Revewied-by: Peng Fan <peng.fan@nxp.com>
> > > > > > > ---
> > > > > > > changes in v2:
> > > > > > > - reduce size of panic log in commit message
> > > > > > >
> > > > > > >  drivers/clk/imx/clk-imx8mp-audiomix.c | 7 +++++++
> > > > > > >  1 file changed, 7 insertions(+)
> > > > > > >
> > > > > > > diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-imx8mp-audiomix.c
> > > > > > > index b381d6f784c8..ae2c0f254225 100644
> > > > > > > --- a/drivers/clk/imx/clk-imx8mp-audiomix.c
> > > > > > > +++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
> > > > > > > @@ -6,6 +6,7 @@
> > > > > > >   */
> > > > > > >
> > > > > > >  #include <linux/clk-provider.h>
> > > > > > > +#include <linux/delay.h>
> > > > > > >  #include <linux/device.h>
> > > > > > >  #include <linux/io.h>
> > > > > > >  #include <linux/mod_devicetable.h>
> > > > > > > @@ -360,6 +361,12 @@ static int clk_imx8mp_audiomix_runtime_suspend(struct device *dev)
> > > > > > >
> > > > > > >  static int clk_imx8mp_audiomix_runtime_resume(struct device *dev)
> > > > > > >  {
> > > > > > > +     /*
> > > > > > > +      * According to the drivers/pmdomain/imx/gpcv2.c
> > > > > > > +      * need to wait for handshake request to propagate
> > > > > > > +      */
> > > > > > > +     udelay(5);
> > > > > > > +
> > > > > >
> > > > > > Did you address the issue I comments at v1?
> > > > > > It should not fix at here, I think it should be gpcv2.c to delay 5us.
> > > > >
> > > > > Other BLK CTRL drivers already delay 5us in its own drivers, if
> > > > > add delay in gpcv2.c, for these drivers, it will delay 10us totally.
> > > >
> > > > We should go forward as correct direction. If udelay should be gpcv2.c,
> > > > it should be there and remove other udelay in BLK CTRL drivers gradually.
> > > >
> > > With Peng's reply:
> > >
> > > "No. Because BLK CTRL enable BUS_EN, before enable BUS_EN, udelay does
> > > not help. For the audiomix, move to gpcv2 would work, but gpcv2 is
> > > not only for i.MX8MP audiomix. For mixes, default not enable BUS_EN
> > > after power on, the udelay must be in blk ctrl driver."
> > >
> > > So gpcv2.c is not correct place for all BLK CTRL drivers.
> >
> > where BLK-CTRL driver source code?
> 
> drivers/pmdomain/imx/imx8m-blk-ctrl.c
> drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> drivers/pmdomain/imx/imx93-blk-ctrl.c

I still think it should put in gpcv2.c. Call power_on/off happen at very
low frequency. Even there are additional 5us delay for other BLK-CTRL
drivers, it will tiny impact to system performance. It is not worth to add
additonal software check to disingiush these two cases.

But correct power on is more important. 

So readl() follow a udelay(5) is more important then additional 5us delay
for other BLK-CTRL driver since there are many 5us delay already in gpcv2.

Frank 

> 
> Best regards
> Shengjiu Wang
> >
> > even if put clk_imx8mp_audiomix_runtime_resume(), it need read any
> > register before udelay. all regiser read and write is strong ordered.
> > when get value from a register, all previous write must be done.
> >
> > all udelay (5) in gpcv2 may not delay 5us at all.
> >
> > Frank
> > >
> > > Best regards
> > > Shengjiu Wang
> > >
> > > > If sometime found 5us is not enough, need change to 6us, we just need
> > > > change at one place.
> > > >
> > > > Frank
> > > >
> > > > >
> > > > > Best regards
> > > > > Shengjiu Wang
> > > > >
> > > > >
> > > > >
> > > > > >
> > > > > > Frank
> > > > > >
> > > > > > >       clk_imx8mp_audiomix_save_restore(dev, false);
> > > > > > >
> > > > > > >       return 0;
> > > > > > > --
> > > > > > > 2.34.1
> > > > > > >

