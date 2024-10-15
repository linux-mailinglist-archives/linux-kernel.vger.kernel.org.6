Return-Path: <linux-kernel+bounces-365457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2471F99E2A1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 11:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD9FB2835BA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB89E185B47;
	Tue, 15 Oct 2024 09:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VOJIbftD"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2051.outbound.protection.outlook.com [40.107.105.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EA418035;
	Tue, 15 Oct 2024 09:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728983946; cv=fail; b=XrhiTrcPlPSGFhLRUBAPCIxDIxxW0bAUC7hglGHIytWx5fElzSy7J4WhY1bIXu9RkUESsCA5UGdXW0/ASzmj66+Bt5LdDp1UCxTH5Lit2oY3PUH++77sRV9850QjItSWpgWh/Gl+4TOw0iOHMbJZrXtbz2ysZCW4M6uMxsjeIjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728983946; c=relaxed/simple;
	bh=CAp29e4dJvIJhjezeivUEV3N2fsOdQiYBtFCUQP95Dc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h6JNcpe/pOsxJS6LsF4Aa6wZQMp19MjBfG5aX4fKCBRGGYnZZ9rrfDKn/8ubgaD9IT9IS5XX94uDy8g2+zdJxIXad7aqjyIRZTcOADI4a6JPl1DVTZi9ywzuSQ+JHB9GTz04Ex6VRkQismp0w5B2M3k37a1kY4vWIbcMVe7VXsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VOJIbftD; arc=fail smtp.client-ip=40.107.105.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSKS9kVUD0qSdxUm1ticJdTLtpVvRiHpVKphQimL6LutEH7U03Ws6EoK8iOZK31TGp+wgmN6BK4XsekDomm09doQOryVtWU+ut+4QtpgJzrPsPUJvxKCNF3AUN4AhmySFUVVxQbd8fN9lI3gnJQ3PPfnFLITGsYL58BAvfunw7wtPfZtIX9J349IZZIvGef0JvCerbm70YPVU/sgHkDb55tKKMf5Myx+SS+lMRtipMBTmypgZKRKIV85YhNYGD7xGCpXRw8tQD7SGV5LMk9UGS5p/r6Gue1j45zGj5F+5LCE5YW75CH/8XAU7hnoBA85eckIwKydxrXEp8/ZVNVivQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FS5TjMgBNpdbZ2LQAtMoWGFWD6R/H2z+SzyyqQs4nlU=;
 b=t/9j1+gWTPpi/44bxPQx2OUHn4zXzwr9Sg504rOIA1QYQ/9lnnJTx0lnPJHVXZMdsb2BRwP4Um3aeeoJksaWvUHztL3psNhfSofS2tvTaupm7BVAiLNKAV4fRFw4O1OmERHUB/qtJ3VAOTpjlTXaQoklSWIOQhdYTgHqHSPb3e0AzCbrFg8NuHnj7lavRhtW5uZ0+WbIsw8Gb1LA8e5YhrxOzuYQqWefkwIfUyWvDH7cOxp+8ip0VhD1JgzMipkYI+Kuu9oP6BSUXz9r0kGoOsNahRx651VytGyCbLT9M8q9ItRD/S+vSq+Wr058/WN1jp2gaUZxMugddBwUAdGjYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FS5TjMgBNpdbZ2LQAtMoWGFWD6R/H2z+SzyyqQs4nlU=;
 b=VOJIbftDITGHeznvexmgt5WhqpuAhxtmYzduRSgX55T13sjShuZ3AOYMPiYIU5yWaRO5NDm9O2aoXmOxhjIYy/7srA4NUd5QvxFcq9VmxxsEPDsiy+DPlPSOt5oxJ3329B91W7HW4/4+qNTnL0C5qnZz6w+BF5FpSkRAqSvph1106jfuoqQ7PchXW6p5p+JMvAUYz0GF3SWW2J9FJ/binezhYzp9FmC6dH87iI3Wp7COFvReNTkXimZ9AOeuNVYwgG1Gw5+qUgcIheWmQZblKhmXop1Dh6wAx25mRerfBEjAnf5qFc8FSsaLEUNIm6VTc7RKXZsnrArhhHNbM0lovg==
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by AS8PR04MB8021.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21; Tue, 15 Oct
 2024 09:19:01 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 09:19:01 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Rob
 Herring <robh+dt@kernel.org>
CC: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v8 4/5] firmware: imx: add driver for NXP EdgeLock Enclave
Thread-Topic: [PATCH v8 4/5] firmware: imx: add driver for NXP EdgeLock
 Enclave
Thread-Index: AQHbHuFs+JZk8K6XI06wSnJ0fzr+rrKHhzNA
Date: Tue, 15 Oct 2024 09:19:01 +0000
Message-ID:
 <AM9PR04MB86047361CA1E9AC521DB51DF95452@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20241015-imx-se-if-v8-0-915438e267d3@nxp.com>
 <20241015-imx-se-if-v8-4-915438e267d3@nxp.com>
In-Reply-To: <20241015-imx-se-if-v8-4-915438e267d3@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|AS8PR04MB8021:EE_
x-ms-office365-filtering-correlation-id: 3daa7241-fdf5-45e0-c947-08dcecfa6847
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VFEvaGh2MkgzV1E2UGt3cXhZL0pxTm1RajlrazR2dDYzTGxObEdVaDVsRlox?=
 =?utf-8?B?NHFoMEhodU5KWDRpOEVJNmI0Y2Q5M3ZsRGZmQ0NBcTdTeUliSm1FZXcyRzVI?=
 =?utf-8?B?ekJoVUxmRnFhaUh3SkhGS3Z4VUoyRGxQd3YzYzdyalN4bVJpd21GMUpqMEw4?=
 =?utf-8?B?OVdXU3FBbEdRYmFtQjNzSFZuVjIySVkySElvUXJheHpjdkZYNkcvbjRrOXh1?=
 =?utf-8?B?d3dwN0NDSVN1eWtidTZmdVhJOVVoTE9Gb2JLWXoxSVppa0tOUGFSZExUQkRu?=
 =?utf-8?B?YzJ3bFpiQkZWb2FzT0REeGN6RE55N2gxS1BJNytjOEJOWTJSVnhwNlZZMmRK?=
 =?utf-8?B?WHM3ZEFvUDdqVzA2RC84ck9rdjQrUTRsZnlCZUFOb09wSlpscmQvdW44VXVl?=
 =?utf-8?B?UVh4alA4dHZKQkVHT0N1NDNVL0JRSUZONzFwOERjeTI1NjFReXpmN3U3WTRK?=
 =?utf-8?B?cUxsbnVBS0RLNGxqdUpTWm1RRVJHMVpuQnMvdDJCQ3NrMzBxNENZNHNicVF0?=
 =?utf-8?B?RXlTMnBkcDJoQVNObVVFZlRvOGtLc2xtWU9pQi9vK0pTWmpUR1NmbDhQNEI5?=
 =?utf-8?B?MDUrNUxYbExwVnJZbDc0YlF2Z1RtenRhYk9QL1dHMXFzcTNCZVlmRGFDSmZB?=
 =?utf-8?B?aWlCUmtLWUdRaXRJbnkySWhTY2IxaUR6YzRtYkk3NFBEMEI3Q2lrTnlSVkpS?=
 =?utf-8?B?dGRPUjBXMHVHdzBaTmc0cnFXVEVVbXZxMUx0ZjBKalpOaWI1MURiZ3l5NnB0?=
 =?utf-8?B?TnJ6RmhoVTVyYnA2OWdaeEFkSnFLTTRXSCtyeGFYeW0wSWRPajFmdTI1TmJl?=
 =?utf-8?B?OFU0dSs4clVjc2R1dnZrc3UrbTBDdGhtZEZBN2lEZWc2L2M1YVVyODdPYVJF?=
 =?utf-8?B?K3Z6U053dll5ZHk4S3VZVnIxckNzZ2dFRlo5cThpNWlMUnJ5YlgvTFJqQWd5?=
 =?utf-8?B?cFF4Z1NaU2pwYnQ1WTNvRURLaW5tclhTUm52UDJLdlBmYit3TTNXOVh5Y0c0?=
 =?utf-8?B?aXhBbUEwWWV3Ujk4Q0x0OHZEcjhuOTFpU1kxaG5TVVlGT1QzNkpWV1F3UjNZ?=
 =?utf-8?B?S0V2ckh2eHBleldBK0tzdzNBSXBDN2RGOUh6TW1remJYenZUUkJkQlhsdU5D?=
 =?utf-8?B?S1B4c3JkSG1PV3BZM21UY0ROM0I3OXAxRCt4a3hiUFNnSHhCM0pJTlROa3h1?=
 =?utf-8?B?M0hZa25KZWtsN0VKMjY4bFpZNHBoM1E1U25Sb1dPajlocWQ5TVVhVDR2bXd0?=
 =?utf-8?B?T2xzRWd6SVZVVU5SdGNVUEJXdTYwVGZsZ0V4RHhQYTJwaXhCZTE2WVJabm8y?=
 =?utf-8?B?d0J3dU5lYUtmUWpRbnlNWHNJTFRDUUdJanJKcCsyV0tCNm9KY2cxVlN4U2cv?=
 =?utf-8?B?dUsrNTFqOTMvZ1g1NlBuMzJ5VGRLaDl6ZitxR3hNL3ZWaTYrN1VhTUsyY3Fj?=
 =?utf-8?B?ZjJqTW4vaVY5dk5yVDgrTUh6dzJnKzB5N2wwVVNjUDlYbjhRdkFFTTVBTVJp?=
 =?utf-8?B?MjBaYVlXL2M3K2VYV1BoWkd4ZnpYdkJkZlFRSUUwTzArQVJiZkYwTllwdC9R?=
 =?utf-8?B?bzRwOWRtOU9IN2NEM0ZqNjJRS05zSm5mNmN4OFl0UVZBQ2ZkM2gyMWdPcktz?=
 =?utf-8?B?ZEoySFAzckdMQkFTbzRpUmpCUm96RUE4MmdMdTlUSjZVbk0yWlV5RXhldlNy?=
 =?utf-8?B?dS9nYW42Z2xoSExkbStiVFlEOXBPSy9yeVQ3eTc0MTRuS3Z2QXZON3RwVSs0?=
 =?utf-8?B?VHJobW44c1VkQm4vKy9mWnhDcTJSUkpMNFFKSWQ4bkRLRm92WHZienE5bmda?=
 =?utf-8?B?RER6NTVYZTlQc2Ntandldz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cmxLYzBCNlJOa0k0ZlNyYXpDRnFqMXhUT2xRWlZJUUU2OTFsUnlSbXNTbjlx?=
 =?utf-8?B?S3l2Y0pibGxnOFpJZ09OOHRTdUtFNlpsYlJUa3VoaElRbzNyWE9iVXV0Rjdu?=
 =?utf-8?B?TndpbEMycE5RSE1nOVdWS3BTWGt0NTVTN2lhei9sSXZ5UEQ1Zkt6blBjRzln?=
 =?utf-8?B?SWVoMEI2aFlpanJKTlA0ZTNWc0c2NGNpdjV2RFhMNjZIdmlqZmlVblV2eVJV?=
 =?utf-8?B?VmF5TW1LZXVZRzdiOFhuTDVONzdoWXJUTUQwem1zcTNsaGlEdG83NDh2YWJy?=
 =?utf-8?B?YzR1V3VnODIzZlFFa0lhVlJFKytkT3dzcWJjTk9aZVdQQ3A2QnczakZJNy9o?=
 =?utf-8?B?UnQyZXVWaHh5NFZ4SzdOY2ZadEd3YTNPNTNnTWhoazhSWGYwRzhERllFc3NQ?=
 =?utf-8?B?d1JNazRnU3JqWGtjbElPMFdvTjh6VEtlbUozS0E4THdXVWV6aXAvNjZucWgw?=
 =?utf-8?B?SWtQY0ovcEVjVklnZHFrWUFPK2UyQnIra3dPZGY5V3dkU1lDNVN4M0MvcEYr?=
 =?utf-8?B?d0x6S0crdlFuVWY4a2tWaUNQOXhQdFIxQWJEc2E0UjRKOTNOTFA1cGl2YTlU?=
 =?utf-8?B?Wi9iQ0ZqRlgvVW85Yk9EZ1pCZ2VCOEVJdzZkTUFrM1lLZzRTV1JsWk1NclBN?=
 =?utf-8?B?dFBkTlQvSi9mVXE4Yk94WEFlalhlbXd0WHIzcDdVVjBVVWN1QmVGeGMvbkt1?=
 =?utf-8?B?VC9JbVdUakV4V0pwOVhKTFFlcGwybWlXanZRQlZNamM4V3oraUZsYi9GUGFi?=
 =?utf-8?B?RS8rRzYzMEhoY0ZORWNRcE1DcHEwaU9XZSthcEZsR0lqWFNKUlFuQTl5UWQv?=
 =?utf-8?B?TGpLVUlyNUZqc0VBbDdhUkNnUXZ4SFZNc00valArRmJ6RmxiWGpSYllVWVF5?=
 =?utf-8?B?YTFzM0tTY1czNnYxanMrbHBGR293ZWJqdWVLT0Roa3FncklaUUF6WVlGWUlm?=
 =?utf-8?B?ay9lYkpraFRHcVp6S0V0eGJSeGpEQUE0NGZLcnJZUWFvdUErSWtCVVVha0dr?=
 =?utf-8?B?WU5wYmdIUkp2emJjVEQvWGs5WWhFNG1PUDBEMGt5SkVMWitHL0RHSjhJWWcr?=
 =?utf-8?B?SG5adGV5ZjZCWklNQnh0R1c3N3ZkUWhzT2RhOG1lVTdjcENLVEdzOFJHVzF3?=
 =?utf-8?B?RUNVRXJJaDNSdFRmSG1TN245M2VFYkYzdTc1U1pOa2pPTHI4YnJaenhIOVIw?=
 =?utf-8?B?aCtOdlZ5amlMOG1zN2t1eG1yMUtWdXlQZkd4T0JOaWx3WnhLazZkOXZuNkVo?=
 =?utf-8?B?aEErcmtwZDZQU1pITVNWb21KcVVuZWNPR1dEeVBKZmlrV0JWd2tjNnRXTEhE?=
 =?utf-8?B?bHpSTnd4bkxLdUpvdm53aEc4WFlpd0V5RTJoL0RIN2FGaVVrTGtCc2xQQi9V?=
 =?utf-8?B?VTRFMXJiOFpLMTViYmlxSGF0R2s2c0JGeGMva01UKzRQWmU3WHFqMWl6MDZE?=
 =?utf-8?B?QXJlWDRSM29ZMk9lUzhGN0FnalMrYlhsR1FGeFVHZll6Q1NXcW9tcmFqUTJI?=
 =?utf-8?B?ZVIyY3AzNmw3M1JkV0Q4RkVOTEpseVk2WllZOUl0c2JnMnBxbjdILzM0YTBY?=
 =?utf-8?B?RUFNOHduaXFpQU90RnBsUWx0bUg2dnd1cU1sSWR5elkxT3dIeDBwZklDMitK?=
 =?utf-8?B?anV2QUFxZ3pPVXJaaTFGN2EwTHBlaDBCeWNVTEU4Qm14WlAwbG9NRmpyVVZL?=
 =?utf-8?B?WWpvTjRLY0Y3SHVzRDFTUXNYL3FDbUFvUTcxQjVjMUZyU1UyMHR6N1dndUtr?=
 =?utf-8?B?bjI3cG9jK0xRbVZ5enNIZ3ZRbGdNcWphTkJZSUFNNUFjT21HcG96YmVXOGRq?=
 =?utf-8?B?UTBUOVhGZ1l4S2lrQk5JNmNLWDA5TlhLYWNmd0wzcXN1VnB6RjMyYnBmQnZ6?=
 =?utf-8?B?TmU4UmhaMUY4SGRMS3ZadVU2ZEtYWGpWUnAwVjZNei9kV2RQWldlcVVuWkd5?=
 =?utf-8?B?NStnNmp1REVKK094N2F5VlZEbXJyc2ZySFljUy9kWFBqdG5RT1NSd0Q2NWNa?=
 =?utf-8?B?QmNRaFhqSytxYmQ5OWVLUmY2cnhYUHZTcUNqT0NydGpuQy8wVUhsOTdvS2pR?=
 =?utf-8?B?Ujc2NE92Ny9mYzBSYUNKZlYvRUJqOTA5R0EwTnd3ejJOUStuSjZWWk13dDJt?=
 =?utf-8?Q?A1DrQU+Zaizz1hEnIxyDH8NV3?=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=SHA1;
	boundary="----=_NextPart_000_0093_01DB1F11.5D600300"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3daa7241-fdf5-45e0-c947-08dcecfa6847
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 09:19:01.4848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3hZ2Aj8DOiGfiBHHka+1IvxAQOBZqPFTkoj9FUlvqYMN1GqR0AZCYBm+w5tvnBKIwQG8zv7cRI0Cv4d5rsHQJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8021

------=_NextPart_000_0093_01DB1F11.5D600300
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit

diff --git a/drivers/firmware/imx/se_ctrl.c b/drivers/firmware/imx/se_ctrl.c 
new file mode 100644 index 000000000000..37693c27042f
--- /dev/null
+++ b/drivers/firmware/imx/se_ctrl.c

+
+static void se_if_probe_cleanup(void *plat_dev) {
+	struct platform_device *pdev = plat_dev;
+	struct device *dev = &pdev->dev;
+	struct se_fw_load_info *load_fw;
+	struct se_if_priv *priv;
+
+	priv = dev_get_drvdata(dev);
+	load_fw = get_load_fw_instance(priv);
+
+	/* In se_if_request_channel(), passed the clean-up functional
+	 * pointer reference as action to devm_add_action().
+	 * No need to free the mbox channels here.
+	 */
+
+	/* free the buffer in se remove, previously allocated
+	 * in se probe to store encrypted IMEM
+	 */
+	if (!load_fw && load_fw->imem.buf) {

This needs to be corrected to: if (load_fw && load_fw->imem.buf) {
Will correct in v9.

+		dmam_free_coherent(dev,
+				   ELE_IMEM_SIZE,
+				   load_fw->imem.buf,
+				   load_fw->imem.phyaddr);
+		load_fw->imem.buf = NULL;
+	}
+
+	/* No need to check, if reserved memory is allocated
+	 * before calling for its release. Or clearing the
+	 * un-set bit.
+	 */
+	of_reserved_mem_device_release(dev);
+}
+
+static int se_if_probe(struct platform_device *pdev) {
+	const struct se_if_node_info_list *info_list;

------=_NextPart_000_0093_01DB1F11.5D600300
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIImZTCCBaIw
ggOKoAMCAQICCE4Rpu+H69FRMA0GCSqGSIb3DQEBCwUAMGUxIjAgBgNVBAMMGU5YUCBJbnRlcm5h
bCBQb2xpY3kgQ0EgRzIxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJ
RWluZGhvdmVuMQswCQYDVQQGEwJOTDAeFw0yMzA0MjEwNjQzNDVaFw0yODA0MTkwNjQzNDVaMIG2
MRwwGgYDVQQDDBNOWFAgRW50ZXJwcmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQ
IEIuVi4xEjAQBgNVBAcMCUVpbmRob3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmS
JomT8ixkARkWA3diaTETMBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTEL
MAkGA1UEBhMCTkwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDAWrnSkYP60A8wj4AO
kATDjnbdgLv6waFfyXE/hvatdWz2YYtb1YSRi5/wXW+Pz8rsTmSj7iusI+FcLP8WEaMVLn4sEIQY
NI8KJUCz21tsIArYs0hMKEUFeCq3mxTJfPqzdj9CExJBlZ5vWS4er8eJI8U8kZrt4CoY7De0FdJh
35Pi5QGzUFmFuaLgXfV1N5yukTzEhqz36kODoSRw+eDHH9YqbzefzEHK9d93TNiLaVlln42O0qaI
MmxK1aNcZx+nQkFsF/VrV9M9iLGA+Qb/MFmR20MJAU5kRGkJ2/QzgVQM3Nlmp/bF/3HWOJ2j2mpg
axvzxHNN+5rSNvkG2vSpAgMBAAGjggECMIH/MFIGCCsGAQUFBwEBBEYwRDBCBggrBgEFBQcwAoY2
aHR0cDovL253dy5wa2kubnhwLmNvbS9jZXJ0cy9OWFBJbnRlcm5hbFBvbGljeUNBRzIuY2VyMB0G
A1UdDgQWBBRYlWDuTnTvZSKqve0ZqSt6jhedBzASBgNVHRMBAf8ECDAGAQH/AgEAMEUGA1UdHwQ+
MDwwOqA4oDaGNGh0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEludGVybmFsUG9saWN5Q0FH
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
ggEKAoIBAQCsljsxzffby7IAt42e7cJH7K+49RL+7i56h3ORt8dS8WNVSdDlejp6uS6mLk/UX0wn
sSxDK1S5KquGJQzaT/3gxE8tdgvfFNBVdrgr48DeCVwWDr1o/UF3RmGcMdxqRz1M/oLDJ03C8n6h
L/0JXiwsNx0KZJoqDrN/48yX5TkoeKJmHFftZ5Op57xV0WkZJ/yLxSC1Om75jOG/UPdqsDzl+wi7
YVj5egV24hoaXgHBxtCeJzUgsHcJlo9nFtGe11j6H1vqFzkPzN9ydjRmhQATV/WLqpG8uot79u0m
6n7Mjwsd/HmJf+8xpovMcHPO2a0axppssKso/3APP6mR1FuVAgMBAAGjggORMIIDjTAOBgNVHQ8B
Af8EBAMCB4AwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMAwGA1UdEwEB/wQCMAAwHQYD
VR0OBBYEFLNr0DCWM1fCXv4ubOt/elkvcoiaMEUGA1UdEQQ+MDygJAYKKwYBBAGCNxQCA6AWDBRw
YW5rYWouZ3VwdGFAbnhwLmNvbYEUcGFua2FqLmd1cHRhQG54cC5jb20wHwYDVR0jBBgwFoAU5TJ6
9GbBR5Ykf/wngDlY3ysX4rswggFKBgNVHR8EggFBMIIBPTCCATmgggE1oIIBMYaByGxkYXA6Ly8v
Q049TlhQJTIwRW50ZXJwcmlzZSUyMENBJTIwNCxDTj1ubGFtc3BraTAwMDQsQ049Q0RQLENOPVB1
YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9d2Jp
LERDPW54cCxEQz1jb20/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENsYXNz
PWNSTERpc3RyaWJ1dGlvblBvaW50hjFodHRwOi8vbnd3LnBraS5ueHAuY29tL2NybC9OWFAtRW50
ZXJwcmlzZS1DQTQuY3JshjFodHRwOi8vd3d3LnBraS5ueHAuY29tL2NybC9OWFAtRW50ZXJwcmlz
ZS1DQTQuY3JsMIIBEAYIKwYBBQUHAQEEggECMIH/MIG7BggrBgEFBQcwAoaBrmxkYXA6Ly8vQ049
TlhQJTIwRW50ZXJwcmlzZSUyMENBJTIwNCxDTj1BSUEsQ049UHVibGljJTIwS2V5JTIwU2Vydmlj
ZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNvbT9jQUNl
cnRpZmljYXRlP2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlmaWNhdGlvbkF1dGhvcml0eTA/BggrBgEF
BQcwAoYzaHR0cDovL253dy5wa2kubnhwLmNvbS9jZXJ0cy9OWFAtRW50ZXJwcmlzZS1DQTQuY2Vy
MDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIWCwH6BjvRVhu2FOILrmUuaklY/hMbNXILljX4C
AWQCAT8wJwYJKwYBBAGCNxUKBBowGDAKBggrBgEFBQcDAjAKBggrBgEFBQcDBDANBgkqhkiG9w0B
AQsFAAOCAQEAWS4IrHXWhCGNWk5vn20xV7mlLkM7JPwltVJzB6MRzwUB438upbyUMwNHcEgAmHcs
xL9hafErN+n9rLL00wEqZsCV732s7YOxSRRjZTE3CmZQ2+TYjXR7A6AzQKo0fv/x43bpSes8ttQ6
Qtt8nzIbGBkDAcI7wfXsUPF5o0NwLOxre+Z+JCPNH0eaOj2J7EKD2ERLCClmvohrYdlmu85iXfyi
nJo42eq9g08FtnxTXVQSIZCtiETiGtXA7+t2Aa8429XXunsijRznaYw2SwI/s4sVmvaK3XHaif0D
QaUYxQp4s2ctzgz3eU6hK68OnNzbhBtF/lx6PHbifqHDzrtUbzCCB+8wggbXoAMCAQICEy0ACwRu
JYOozH+yQuYAAQALBG4wDQYJKoZIhvcNAQELBQAwgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNl
IENBIDUxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVu
MRYwFAYDVQQIDA1Ob29yZC1CcmFiYW50MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPy
LGQBGRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDY29tMQswCQYDVQQGEwJOTDAeFw0yMzEyMjAwOTIw
NDdaFw0yNTEyMTkwOTIwNDdaMIGaMRMwEQYKCZImiZPyLGQBGRYDY29tMRMwEQYKCZImiZPyLGQB
GRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDd2JpMQwwCgYDVQQLEwNOWFAxCzAJBgNVBAsTAklOMRYw
FAYDVQQLEw1NYW5hZ2VkIFVzZXJzMRMwEQYDVQQLEwpEZXZlbG9wZXJzMREwDwYDVQQDEwhueGEx
ODcxNzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAL2JT+kRihW1mBdeZFOoCLGIl4DZ
VL7FWt3V1iFFJJe/bZDw/SUf5z1HeA8xv9+S8rqMyybjlSRHFLgiMm7qrGpVEDniKe8eiqP8Un4Y
3fHgK5FKZIVVn0KlaMuD5G30AMk9HyUdc2MkVRL8YSQCewkQDEVjB8gnx/e6xfbWEVHf5+dOWJoR
aket5+0JKV0l/dPV7cT4hL3BFtiBhq8976Li6rn8gxIi63u0G3qvm9Scqk+EHzemDhw/W+eMmGR4
nwKVLKzumxko8l6EOnnvqqF4vj2hKTpB+2lsEXH1giireMEsvB2RY40lnRUXVQ0FDklOIQV4Qdgi
EJfUdq/ZhCUCAwEAAaOCBA4wggQKMDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIWCwH6BjvRV
hu2FOILrmUuaklY/gbeCPIPthzICAWQCAT4wEwYDVR0lBAwwCgYIKwYBBQUHAwQwDgYDVR0PAQH/
BAQDAgUgMAwGA1UdEwEB/wQCMAAwGwYJKwYBBAGCNxUKBA4wDDAKBggrBgEFBQcDBDCBlAYJKoZI
hvcNAQkPBIGGMIGDMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAS0wCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBGTALBglghkgBZQMEAQIwCwYJYIZIAWUDBAEFMAoGCCqGSIb3DQMHMAcGBSsOAwIHMA4G
CCqGSIb3DQMCAgIAgDAOBggqhkiG9w0DBAICAgAwHQYDVR0OBBYEFMJ81PK4p3H8Q7gn7u/5OwWx
uAwGMEUGA1UdEQQ+MDygJAYKKwYBBAGCNxQCA6AWDBRwYW5rYWouZ3VwdGFAbnhwLmNvbYEUcGFu
a2FqLmd1cHRhQG54cC5jb20wHwYDVR0jBBgwFoAUWJVg7k5072Uiqr3tGakreo4XnQcwggFGBgNV
HR8EggE9MIIBOTCCATWgggExoIIBLYaByGxkYXA6Ly8vQ049TlhQJTIwRW50ZXJwcmlzZSUyMENB
JTIwNSxDTj1ubGFtc3BraTAwMDUsQ049Q0RQLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENO
PVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9d2JpLERDPW54cCxEQz1jb20/Y2VydGlmaWNh
dGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlvblBvaW50hi9o
dHRwOi8vbnd3LnBraS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybIYvaHR0cDovL3d3
dy5wa2kubnhwLmNvbS9jcmwvTlhQRW50ZXJwcmlzZUNBNS5jcmwwggEQBggrBgEFBQcBAQSCAQIw
gf8wgbsGCCsGAQUFBzAChoGubGRhcDovLy9DTj1OWFAlMjBFbnRlcnByaXNlJTIwQ0ElMjA1LENO
PUFJQSxDTj1QdWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0
aW9uLERDPXdiaSxEQz1ueHAsREM9Y29tP2NBQ2VydGlmaWNhdGU/YmFzZT9vYmplY3RDbGFzcz1j
ZXJ0aWZpY2F0aW9uQXV0aG9yaXR5MD8GCCsGAQUFBzAChjNodHRwOi8vbnd3LnBraS5ueHAuY29t
L2NlcnRzL05YUC1FbnRlcnByaXNlLUNBNS5jZXIwDQYJKoZIhvcNAQELBQADggEBALwIIuww1PaF
EbpQoy5vgJ/4N3xS+niIpFTKyYNAD0Ar38FcUlSnj0FIHKRj8rUmZP9WTky3U8m5B3LOyhJ14FPh
iy1EwkhZmds9fJiZyEEFiwQWYDG/uknu6zIKOTlLmtlYPfbzfi58keGcjD3T5H8D8DpCGWI1lAwe
clR9fJCbcYnQSQnuicSCfrHjjXiDZ2O8h7WbE1CC6Cj/qwo5nmS0lMv7yoG94rTNBvYe8iqOkcav
7KiZA6SdhXms3ppvFmBukI6pTheMvT39SM0S6E0dgeqZSGSxHrM7dcxUdAL4fnYMv3Sa+GAgyXB6
rihWC11+goz2eawt5TRU2w45TmcxggSzMIIErwIBATCBzjCBtjEcMBoGA1UEAwwTTlhQIEVudGVy
cHJpc2UgQ0EgNDELMAkGA1UECwwCSVQxETAPBgNVBAoMCE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5k
aG92ZW4xFjAUBgNVBAgMDU5vb3JkLUJyYWJhbnQxEzARBgoJkiaJk/IsZAEZFgN3YmkxEzARBgoJ
kiaJk/IsZAEZFgNueHAxEzARBgoJkiaJk/IsZAEZFgNjb20xCzAJBgNVBAYTAk5MAhM/AAV1goSs
wyqoLYNbAAUABXWCMAkGBSsOAwIaBQCgggK5MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
KoZIhvcNAQkFMQ8XDTI0MTAxNTA5MTg1N1owIwYJKoZIhvcNAQkEMRYEFEEvkOeHWp0DNKzoYdgE
C0f4Y3SSMIGTBgkqhkiG9w0BCQ8xgYUwgYIwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjAKBggq
hkiG9w0DBzALBglghkgBZQMEAQIwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsO
AwIaMAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgIwCwYJYIZIAWUDBAIBMIHfBgkrBgEEAYI3EAQx
gdEwgc4wgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNlIENBIDUxCzAJBgNVBAsMAklUMREwDwYD
VQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVuMRYwFAYDVQQIDA1Ob29yZC1CcmFiYW50
MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPyLGQBGRYDbnhwMRMwEQYKCZImiZPyLGQB
GRYDY29tMQswCQYDVQQGEwJOTAITLQALBG4lg6jMf7JC5gABAAsEbjCB4QYLKoZIhvcNAQkQAgsx
gdGggc4wgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNlIENBIDUxCzAJBgNVBAsMAklUMREwDwYD
VQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVuMRYwFAYDVQQIDA1Ob29yZC1CcmFiYW50
MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPyLGQBGRYDbnhwMRMwEQYKCZImiZPyLGQB
GRYDY29tMQswCQYDVQQGEwJOTAITLQALBG4lg6jMf7JC5gABAAsEbjANBgkqhkiG9w0BAQEFAASC
AQAy4TCty0BO7CbWpk+u/jSuwxXp6i989jR14STj0H1TV2KedSlkmoL3lIGz7NsMfK/eEpP9i73d
y2WG2CzpwXR4wIuiwNL4kZGYD/syPCeAB3EXtpB51b4IaxEJNREpRl55JfsCybj7fHciJaOTzp7w
b/pPJYT0JrtNcLGwvKmoXv6Vf6t8kQrS/gVcjS2Ac2zJ9bxnO8akmj271BAvqpS+xbRjV89unZcr
O/UDx+WAW88hvheO01DuCnnEk4yj4LuxJe/tmNBGmgTf2PqRHl5LdTyF4TCblSQQ95lXKgFeySzh
Wd7ZQaT4K4AiPaf/YlacLy+R8Qm1hQtkalhPPy3qAAAAAAAA

------=_NextPart_000_0093_01DB1F11.5D600300--

