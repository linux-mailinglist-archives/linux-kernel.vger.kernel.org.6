Return-Path: <linux-kernel+bounces-177567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5F68C40DF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 14:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AAED281CFE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 12:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677E514F12D;
	Mon, 13 May 2024 12:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="O1lni6WV"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457441487E1;
	Mon, 13 May 2024 12:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715603989; cv=fail; b=eNAgj3RaKWP/mqtmf3jZEbKnSvdNE5MOrKk2zWFuyn9SJ1YYh2CJqyUVqHTWZTsomBza2xd7ligBeLayFUrmrrwYkbMRb9xcAvGbwZy6OgVkETEZQskaz0j+0N/nFpE2JoelAdYM8CsQM6WHny79UhuBB2/ydrnS8o+3eK9Fv/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715603989; c=relaxed/simple;
	bh=gGTXXLnXN/ruPbm7xXu8T68qWf8MATemi5ZZGXqFF6w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K4HU290hsuvjmQxr0NAjKfGhSrVHEsnUaZ/4Hxmddpo7ynCwWJbfZEQ4ZoPBBIaHiKchcO2qlohNXI7l9XRx5dkdQZXOm2T6jkPN0Vy0Ti1w8/+sQw8wykArLiSGPYftTMv85IVbVQGcj467g2sHKff+ofD0e1LZp7xTOwml2ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=O1lni6WV; arc=fail smtp.client-ip=40.107.20.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lH+6y0iKdTF2HAo8wo+zpk8zVOlysfDdBrEZeA0q6B/WtuVQWzFWLnIsw7xg1pGz0zVcPwq/cV6a9QcIlYQAUBeQTgkpwfb3NEuzLuQ/7Pp0AWXQG/2DF3qloDDz7R1vKjCAIlvELjXQ51c7T7ohYF+mVW2MbRARRRXlYawXLtmmZh4c3UrXlanWE7CzK3x5xFLW1C/nEJO9W6gCJ2qZy8j+KdgrDXV2ky8V2HnaJ9+8eavy/+9i4cKU9k3CT6m4q/3rBbD9cGeIxF+FJqlcMSkBJgyzbPIDA78PguNt/rLcQ0/ibJ66iM8nqvUAZm7fDNA8D+PWpLDgh7yLfx1rdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGTXXLnXN/ruPbm7xXu8T68qWf8MATemi5ZZGXqFF6w=;
 b=aAz1D+eQaphSgWC7wVbaNTPPYx8B4NZOfMgnqi5XIQe3XgfEfWZCrEru2JOcR2OzJ7LMcTmMr8fEMoxa0PgL0pKdinEZ0mc+oiR2wMRxHgd/Hx7a5SiF7R3ZFobPewFDjfQQW5yzK9v66zFYQFc3Bshj21UkD9BokhPq6awoo3g5KGbwLJXg+ikB6MrbM1NPGsppHypxvzIauHLaDBL1ZIwPy7/GgyJdP6obPgvfg+sAeQCMdp+Z8KYnMTnltY2wF/9NJ0hd6Cwfr0TtiOyF670XiV4n8r38ROw3AulEPA7UZvIUB4gSkwb8oxLUjqB4n9XMg1fEXOeGTFdJ4mnttw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGTXXLnXN/ruPbm7xXu8T68qWf8MATemi5ZZGXqFF6w=;
 b=O1lni6WVObKvO75oe3AtXFYyszNZJFmWmk2g9oydaf2niwK9tISya16XalaBe6J5LFxu+5o1x14rVZJ1W5Sqp+sAm6Zn3JDwJSY/Y6N67YWIwJDG1wbgYA1Y4gplUmAyV+MgO69AuLZ0KDK63LTyEhHAubHf+a6HdrPfCasbjfc=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by GVXPR04MB10181.eurprd04.prod.outlook.com (2603:10a6:150:1b7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 12:39:43 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 12:39:43 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, Abel Vesa <abelvesa@kernel.org>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	Jacky Bai <ping.bai@nxp.com>, Ye Li <ye.li@nxp.com>, Aisheng Dong
	<aisheng.dong@nxp.com>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Abel Vesa <abel.vesa@linaro.org>, "S.J. Wang"
	<shengjiu.wang@nxp.com>, Chancel Liu <chancel.liu@nxp.com>
Subject: RE: [PATCH v2 05/17] clk: imx: pll14xx: Add constraint for fvco
 frequency
Thread-Topic: [PATCH v2 05/17] clk: imx: pll14xx: Add constraint for fvco
 frequency
Thread-Index: AQHaoroMvImi844DX0SJs1FVr1w0MLGVGIyAgAAHBzA=
Date: Mon, 13 May 2024 12:39:42 +0000
Message-ID:
 <DU0PR04MB94176F2354DC55FF505305E688E22@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240510-imx-clk-v2-0-c998f315d29c@nxp.com>
 <20240510-imx-clk-v2-5-c998f315d29c@nxp.com>
 <557d219a-dc00-4595-a3ff-a464908d5e03@prevas.dk>
In-Reply-To: <557d219a-dc00-4595-a3ff-a464908d5e03@prevas.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|GVXPR04MB10181:EE_
x-ms-office365-filtering-correlation-id: c8b3c67e-f747-479b-b52a-08dc7349c38e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|366007|7416005|1800799015|38070700009|921011;
x-microsoft-antispam-message-info:
 =?utf-8?B?aFBuLzExK3FnLzZPRUpEdGlKRVcwYm83RTVHb1ZodWpHeHRsNnlIY0ZrWDR4?=
 =?utf-8?B?MW9oVXc3VTFYTWRCajlyS0xJdTBDUnQ3R05SQlQ0dE5TamFVbTZKc2w3aHNy?=
 =?utf-8?B?Ky9JQVdyWlZCb3RmaVBKc0gvMzNKY2lReTYvZGpLOTdPY1NJZU1zNnBza3oy?=
 =?utf-8?B?NmJ4dmNvMGtveEpkRzhoNTFjQzhoMnhIdU56c25aMGhSVmRXQVd3S3lFdUJW?=
 =?utf-8?B?ZmI4aTlMa0tDakxNWGxuVHI3U0cwSlBycU1YYVB5bEYrNVJ1NmpMQ0JZYkJG?=
 =?utf-8?B?UDM5RWNlOW5uNUtpeTBXalBxbysySFl3Q2FKUFlURWpzRG9SSnA2RG11V015?=
 =?utf-8?B?UnFEVGJsSDNMc3FuZFdEYlRMb3ZoVHVSOHJoWlZDQllMNS90WU9DRnlGdWdr?=
 =?utf-8?B?aC9pRzJyeW1zUmpSKzMrSWFmN1NvSnlXbFR5MnJmMGlZTHhjNm1xazhwam4y?=
 =?utf-8?B?RTZxMS9yWWlMeWhZRHRscldMREx6blNEZ3ZQcjIrZWhWTEdLeUUxUTk5OWdi?=
 =?utf-8?B?RE4ya0t2QjZ5bkxBTm9zZ0lLMTB0d3V1NGJ3SFdIUDduNXJ2bW56SWxDR25y?=
 =?utf-8?B?cW00TGgrWFhEanRGd1Y2aXA0UmtvL09QdUljUmI1YkJUNjlCMkIrV3JnMmQ5?=
 =?utf-8?B?bFN2TXk0emNUMStZeHBtdkVZdGxPRGljdlpnSVdmQkErZHRJWDdCU3AxV2Nj?=
 =?utf-8?B?WURpY1V0ZlZXUmVxRFJHWTVDV0FNZXFTS3pGeVBYQXNLaE5KWEU1a3lvQWRa?=
 =?utf-8?B?ZlZWZVdZQ3I3b3p3cXVDWjgycW44b3ZoYVlNV3VwZlNOV0ZWb2FLeXZNTVAw?=
 =?utf-8?B?U3BnRkRPRWJFUzBIblJ2VUVKQUNDcFl2VnM3YUg3UFpZVFdFNGVhWWhjNzhH?=
 =?utf-8?B?WmdEUWU3TkhmcjFtYzNkNVJYelA2emZ4NW0vWEk0aHVybDRFYWtkU1VraFRv?=
 =?utf-8?B?dC81QWsvMHNPNGhyTXpGUDR3RmgxK2c3R28zSGJCY011NGMxVlhEOVFvYmsx?=
 =?utf-8?B?RWlsSGFvZ1hHbTlWZ0ZPVjU1aER1VUZVQmoxdjArSE1nR0pKR0ZBN2c5WWF5?=
 =?utf-8?B?VEFmZVh5bFBuMjVlMTA4ZEJwQ3FkQ083TWN5eEVTdEtDZjh5WEVyd0lZK3Rv?=
 =?utf-8?B?alFzNm55WGxEd2FtdmJXSElXcGdwVTFMdXd6OWxRdWxTUDg5QTByVk1SUlRv?=
 =?utf-8?B?TmdYbjlwbmVJMHVRNmpEaFBMMG1QOEo3WC9Wc1lyNDFnZnovTTV5WDhJOXJZ?=
 =?utf-8?B?REdXQVF1Sy9oZVM2bjhPNFNqU3RUYmthVXYyN0pTUCtHdXZwV2trTnJjVjRa?=
 =?utf-8?B?TE9CN2JDTDZPb1g4TUMyNVVZMVZOZkVGYUo5NXM3akY4Y05IQ1pIZ3J0OFJL?=
 =?utf-8?B?SkFjZ2ZTa2NCTUxvTStra3BtREJTUHVYT1JWVWljZ3JwMjByLy9yamc1SkVU?=
 =?utf-8?B?WW82aDJRMWhiOWlITFpocjVXaCtiZDZJMnVZOFhTTjlTZy9SODJlVEpxM3M4?=
 =?utf-8?B?SHBFRlpucndzZTRNVkJwbnB1aEM0SGxEc0dQOFhITGN1T2FaWko2Y2tSRkRw?=
 =?utf-8?B?OHFEUCtpZVg5M2ZCb3BVUWhOdzEvUEtvcDdtSjJadzRpSDl1U1dNeGczK0Vw?=
 =?utf-8?B?VDNOMVRiR1h2am1Bd2pvOEJzMk9qbTVvNFZsWGhOeTRyUm1JTzI0ZDJKVkZm?=
 =?utf-8?B?WDUzTDZUVEd0SmI3Q0hFSHlTUTNtQ2NGYklTYzBQSGprRjNScjFXeXhvU0px?=
 =?utf-8?B?TVpydXFNWFpoMVI4aVA2aUZvRUUxMGtpcXExbHRlYWxYM2VIMXJab2FqUSs5?=
 =?utf-8?Q?mcT+Ypo5dy3mH5/BfN6KpLTFTi1vzCA2ZlGOc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OFc1aU5CUWJ2bitIK3U4NkhteEp3Ykg1WE9BR2pWQlloTEQyNnFsWEFmMlFS?=
 =?utf-8?B?enhGVHhwWTExZENOQ29OSlpmTGFVZVZYYWtzRFhzejdRdjRmRXpNTkFDRFFE?=
 =?utf-8?B?Skg4ZmJISmlVbGh1RHR5QmJZekJkL0ZQU2FsK1laNnpKNC9ybVJ4Y2Y0YVFF?=
 =?utf-8?B?UXpicEtpcUkwWDdjSGdzMkFtQmlkRmZtamVQanZuaFR5eE9uNzIxMlVta0ly?=
 =?utf-8?B?NDZpeERFQTJVNXlDSzBESkk1RFp5NSt5NVpHbVFLa2sxaklFUWJybFJRVkNy?=
 =?utf-8?B?OWsyV1RxbkU5TjZsa3JXSnlvQlJCSVdjWnRia29SR0Q1RXNmZE1IN2QwUFVY?=
 =?utf-8?B?VW93eVplN0FrOENPdndGK1lhRkhBbUJZZTBDYVRBNnZUR2d5OXJpOU5mc2xL?=
 =?utf-8?B?WHBEYWdsUUI4VUxNNGhqeVZyeUpNRjQ0ai94YmZZMk5wS3ZMM29tY3BpZm1t?=
 =?utf-8?B?aElCQ01ncEo0b0NSellkYXFoREtmWWt5QjFoeVJTME93SGtZNXFydXkvWmRH?=
 =?utf-8?B?S2VSamJ5NHEzVG14Rk03Rk9tMmxNeUdxcU5CY0NnZithbUJ2VVJNUWRwNm5x?=
 =?utf-8?B?Y1ZxcGk5alI3L2o4UmVDUXJmZm9UNERiLzdEdk9HUERQaFlUUzdSQmR1R1ZO?=
 =?utf-8?B?U0FpeTV5UDhndVRpZ2lSNngxbHo0MU1JQmgxb0ZCRW5NU3J2a2lWQXZXTWNQ?=
 =?utf-8?B?QTIraWRzVGJZa1Jqbkd4UXZSMldHSW9QenJpeXVpcGhaVFc0S2pCMFNXYXFv?=
 =?utf-8?B?N0QvK21hb3M5MmlwdEtoTnpNQk83Y1VFYjQ4cmU4M2k3cnh6dnBEM0ZPUVIx?=
 =?utf-8?B?MEMzd0pLcjlLSVR1TUNtZy9LaSt6VXlvQTh6N0xpMGhhN20vOVlvN0lMQWJk?=
 =?utf-8?B?QS9UTWM0dk9sWlNiQVcyRFIrOTMrRnFjSTYxenYzWVA4dDlNL1FqL0ZXOVow?=
 =?utf-8?B?QXJOQkxLSXBYTTJVeTJWMGFrTHd1bW9QbmxLNzc1eE1WdEJ2VkJISmdNNFYx?=
 =?utf-8?B?RFliMGlxWWZSSktaeWpWUCtrUFNJcHU0Umh0YzEvUkg0UWZONmp1c255cWtQ?=
 =?utf-8?B?d0tBZnN5RFMyTnZWNlNlSkxnZnFscWhZUXVBb2o0RVhzMkVxT2N6dmJUOFVC?=
 =?utf-8?B?aG9GRDg0bnFPdDZqanAyUjVGSlZSUUlyVjFZeTUyaWp2am00NFl3NnhuVVV6?=
 =?utf-8?B?WUZuTTE0dmZ2cTJpalk0bHFWZEVYRi9FTnpKZEQvUmoveTlkaTNZM3V6alI0?=
 =?utf-8?B?aENzQnh5YXltWE53YUQzeWNpeGQ4RDhicDhPSHFYVDAvTnJMNTRjTEdjQjN0?=
 =?utf-8?B?dWlDajZkd013M2pvR2N3VDRVbU5iZFRLTi9TZnVkcG90V1VrTm5SVWNwalZ3?=
 =?utf-8?B?Uk5lZFVlbXRxNVY3UkxGdjlOaGZwK3BibU9OSllSaldSOXg1K1FVc1g1ZGh2?=
 =?utf-8?B?cmoxQ3l4TnJYaUxlQkhUaUFSMURsQ3Z6bHNhc2JZcThET01WRHpNZEpHTUlM?=
 =?utf-8?B?cXQ5RVhnL0pxb0pjVzFpd3ZSQzUyYmVrK0drYWZZK1NIWDJMelZFdlY3T2Yr?=
 =?utf-8?B?R1hnOElGS1NrRkE4UHFHV3QzRXRkRmpCWFY2Um5NRllIZGE1elR0UzR1THdr?=
 =?utf-8?B?N1ozN0szWUJPRVBnZHowa0JXSnFsVHNZUlhIUmVFUWhEdWpIVm5DektHTzhY?=
 =?utf-8?B?cXVLVStrMHVzTjRqWTl2VEN3VWpRa3Z2allNZUl2eEFqeHZDS2pDUlVjemtB?=
 =?utf-8?B?d3BJd1pUZGpURVFxaExEYlYxMVYxUHJyQjNQSVB1TlcyK2MzbFE3M21jV0sw?=
 =?utf-8?B?RFRPaDk4N1J3aXFxSnVFV0RpNGFURVhHWExiSmxFT0kwa0ZPN0tObDVrMEta?=
 =?utf-8?B?cGVHMDRob3Y5S2x0VVM3OG5YV2RPMWU1TlNqQnF2NGhsa1NRTUo2NDFnekNI?=
 =?utf-8?B?ZTdOQUxRZFNZOVg1SDdHNGt1Sy9pTU5RSlZGUWRGeHRFdVBQTDNoKzZlNUFl?=
 =?utf-8?B?OGRzTWIrNkNha2o5YzlhUCs1dnpjK1pnWGxWWWU5WERBdDFaNGFwL0VoZ2Z6?=
 =?utf-8?B?Q2h6YnpHZ2lKYyttanl0eGs1Ynp2YnRFN2VhSDBodkJJTlBudHBaOWNuTy9k?=
 =?utf-8?Q?CYzE=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b3c67e-f747-479b-b52a-08dc7349c38e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 12:39:43.0095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xef/bhIffnwCMoRsuyeNm/eZTf5eBrE69Andv4UajnnenRiV6wYHVH+QQJmomTUSkRzacbSA/PGnZ/8Gk7jMkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10181

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDA1LzE3XSBjbGs6IGlteDogcGxsMTR4eDogQWRkIGNv
bnN0cmFpbnQgZm9yIGZ2Y28NCj4gZnJlcXVlbmN5DQo+IA0KPiBPbiAxMC8wNS8yMDI0IDExLjE5
LCBQZW5nIEZhbiAoT1NTKSB3cm90ZToNCj4gPiBGcm9tOiBTaGVuZ2ppdSBXYW5nIDxzaGVuZ2pp
dS53YW5nQG54cC5jb20+DQo+ID4NCj4gPiBUaGUgZnZjbyBmcmVxdWVuY3kgcmFuZ2UgaXMgYmV0
d2VlbiAxNjAwTUh6IGFuZCAzMjAwTUh6LCB3aXRob3V0IHRoaXMNCj4gPiBjb25zdHJhaW50IHRo
ZSBmdmNvIG1heSBvdXQgb2YgcmFuZ2UsIHRoZSByZWFsIG91dHB1dCBmcmVxdWVuY3kgaXMgbm8N
Cj4gPiBhY2N1cmF0ZS4NCj4gDQo+IENvdWxkIHlvdSBwbGVhc2UgcG9pbnQgZXZlcnlib2R5IGlu
IHRoZSBkaXJlY3Rpb24gb2Ygd2hlcmUgdGhhdCByZXF1aXJlbWVudA0KPiBpcyBzdGF0ZWQ/DQoN
ClZDTyBoYXMgYSByYW5nZSwgd2UgbmVlZCB1cGRhdGUgcmVmZXJlbmNlIG1hbnVhbC4NCg0KUmVn
YXJkcywNClBlbmcuDQoNCiBUaGUgaW14OG1wIHJlZmVyZW5jZSBtYW51YWwsIGZvciBleGFtcGxl
LCBtZXJlbHkgbGlzdHMgY29uc3RyYWludHMNCj4gZm9yIHAsIG0sIHMgYW5kIGsuDQo+IA0KPiAN
Cj4gPg0KPiA+ICAJLyogRmlyc3QgdHJ5IGlmIHdlIGNhbiBnZXQgdGhlIGRlc2lyZWQgcmF0ZSBm
cm9tIG9uZSBvZiB0aGUgc3RhdGljDQo+ID4gZW50cmllcyAqLyBAQCAtMTkzLDYgKzE5NSwxMCBA
QCBzdGF0aWMgdm9pZA0KPiBpbXhfcGxsMTR4eF9jYWxjX3NldHRpbmdzKHN0cnVjdCBjbGtfcGxs
MTR4eCAqcGxsLCB1bnNpZ25lZCBsb25nIHJhdA0KPiA+ICAJCQlrZGl2ID0gcGxsMTQ0M3hfY2Fs
Y19rZGl2KG1kaXYsIHBkaXYsIHNkaXYsIHJhdGUsDQo+IHByYXRlKTsNCj4gPiAgCQkJZm91dCA9
IHBsbDE0eHhfY2FsY19yYXRlKHBsbCwgbWRpdiwgcGRpdiwgc2Rpdiwga2RpdiwNCj4gcHJhdGUp
Ow0KPiA+DQo+ID4gKwkJCWZ2Y28gPSBmb3V0IDw8IHNkaXY7DQo+ID4gKw0KPiA+ICsJCQlpZiAo
ZnZjbyA8IDE2MDAwMDAwMDAgfHwgZnZjbyA+IDMyMDAwMDAwMDApDQo+ID4gKwkJCQljb250aW51
ZTsNCj4gDQo+IElmIHRoaXMgaXMgcmVhbGx5IGEgbmVjZXNzYXJ5IGNvbnN0cmFpbnQsIGl0IHNl
ZW1zIHRoYXQgb25lIGNvdWxkIGp1c3QgdXAtZnJvbnQNCj4gY29tcHV0ZSB0aGUgb25seSBwb3Nz
aWJsZSB2YWx1ZSBvZiBzLCBvciBhdCBsZWFzdCBjaGFuZ2UgdGhlIGxvZ2ljIHNvIHRoYXQgb25l
DQo+IGxvb3BzIG92ZXIgYSBzbWFsbGVyIHJhbmdlIG9mIHBvc3NpYmxlIHZhbHVlcyBvZiBzLg0K
PiANCj4gUmFzbXVzDQoNCg==

