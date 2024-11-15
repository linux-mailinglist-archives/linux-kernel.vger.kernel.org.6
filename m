Return-Path: <linux-kernel+bounces-410496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A35919CDC54
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 11:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 343A31F22001
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 10:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC0E1B3920;
	Fri, 15 Nov 2024 10:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HU5cObit"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2070.outbound.protection.outlook.com [40.107.249.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CA418D626;
	Fri, 15 Nov 2024 10:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731665858; cv=fail; b=Tvctds/e1PTB5+rMtYzK31QjQtH2pRPewpdwFxUhH7ywHTS9/6V3hk0SntkCxQcl5Zg38+x242HBRiiqilWs4rlZmwZ+8FsyVywzuyYb5Krz8W03il3054NrskCoinKUocE9AyogzMvctP0gSl64+iXLCYL1TFjpoSE9y2gTVpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731665858; c=relaxed/simple;
	bh=iy4C9XE+G2d15L2wpMa2NDjnJNLeITiaGC77CqkwJtE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cyAglPkV2ZbFz28CMQrIn+ggY4+XlplaVpGX3jOVJgt2+Xfu/VTHX+ytoOs+IOKIqVaDXAQpHo5spKbg5VuwPPNUpPmQvK4PuJ19J0XPmLQazRj88jHeMJvaNSWluaLbzHaZnlIwq/JiQgDJv6jDFcGuWnDXpKwVV705T6zoRl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HU5cObit; arc=fail smtp.client-ip=40.107.249.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQZeoCkPsW1ycQ1ryBQyC8nym9ypah3KvI5qveGud/hFGZl7y9gTb/QZERrcvytP5/u3KUyQWCCAeRj2mvdVToACRDzK+CZ2gIsXB+YcMBq4bePZr4mlPP4NZBfNVLV3oclMb77hGYYveQ/DafF/RXXqDmDd9jZnO/PgH9WxXWWzE9XoaTezh+3BCtRKm8wvpc7iuo7EUoYwYPA1+FiLzxeFEnYZEO/DliiJUAvCOhn0ollpxOLpY68qWvLw0lBdsxHA7EM4egoCgp1UZUIdikc1voAl8hwUUFy0B8sr9DX247LQPqPDk5BG/vFjPMRoi5IeEX6yVBtqm6aATsVmeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iy4C9XE+G2d15L2wpMa2NDjnJNLeITiaGC77CqkwJtE=;
 b=bQpXoqFq7bf1uXQX5Np3VL1B+rbSkRvj6SZOv9eOwfKTRnNOhevkNLccsDF1BbqT1GhnX5exttK5N2JjKVMB44LFtLm5siMoJa7OCOJ9PtRGAUs0kX0hl+tzBIKA9IEOfjyHY/83w/UM8ri8s1AZdnzSeq3ScQdthFphkvQSVwy2o8VOIxWVmrDPMlerx6qv6e+jNaQJn+v9FmTAOAd03KwJGvfVZTFzpA+eCm8Ch8kR4vdYrT+YzTLKdNh23EwUV7gm/GR6dbelvAMGegenfAtUOAyrKF9tGiLKa3hySGvVeYccwsJPVpKHqWEIG11ovRkdC9caUDX1GqhdUtQnPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iy4C9XE+G2d15L2wpMa2NDjnJNLeITiaGC77CqkwJtE=;
 b=HU5cObitvec8tCoxXO1a4hjfkRr6ATNqvoGxGTrpk1qOjsIFsIx6RCmqxGp9FmNUZp7lWJctQwJT2p54m6TIAnubJm/7fIfVEenmnsh9xIjDTDv55iHuyMpMfD4xd5g3grcblQAxFBdwNsavZdwTqZlVC4Ut3TTHbDqSioBMt10eOMCTnJgQBrG9+rFNuvb1L3GZzVLqOOzsXwYZzSmN200HzhCfloz23Y7LlsmizkHDqXAsvInKMnxEtG+GKmQFTmpOz5iIuXwSYXsUimxH/EYcnYQTYac5mlCdIkO/jqLkDzs5jPPy578O0qRwwRYDiiyjUt9Jse50McD6FH7GJA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS4PR04MB9508.eurprd04.prod.outlook.com (2603:10a6:20b:4cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 10:17:32 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 10:17:31 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Shengjiu Wang <shengjiu.wang@gmail.com>
CC: "S.J. Wang" <shengjiu.wang@nxp.com>, "abelvesa@kernel.org"
	<abelvesa@kernel.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>,
	"sboyd@kernel.org" <sboyd@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] arm64: dts: imx93: Use IMX93_CLK_SPDIF_IPG as
 SPDIF IPG clock
Thread-Topic: [PATCH v2 3/3] arm64: dts: imx93: Use IMX93_CLK_SPDIF_IPG as
 SPDIF IPG clock
Thread-Index: AQHbMcTBaHNHhOnHoUuZrdGjWt+J9LKxarnAgASuGwCAAhJiIA==
Date: Fri, 15 Nov 2024 10:17:31 +0000
Message-ID:
 <PAXPR04MB84590E73E55EE618E6DC632C88242@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241108100759.682260-1-shengjiu.wang@nxp.com>
 <20241108100759.682260-4-shengjiu.wang@nxp.com>
 <PAXPR04MB84596DD01E6A066A621F590188582@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <CAA+D8AP=cdyvhtzDib8-T5GuHU9pXhPVgdomTQj8R=8CCFr5HQ@mail.gmail.com>
In-Reply-To:
 <CAA+D8AP=cdyvhtzDib8-T5GuHU9pXhPVgdomTQj8R=8CCFr5HQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS4PR04MB9508:EE_
x-ms-office365-filtering-correlation-id: a12bb2e0-4e3e-43df-5a76-08dd055eb758
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VmdzVDRNVFpUVW9CRDJBUUxPNHhCY2NlVldyZDZreXJhcTJoeTJTRS9ZbWk4?=
 =?utf-8?B?STNjZHhVMi8vYmo1R3ZjbVptdHhscEhISHZzVjJ1eUZOTWIvMjVRSy91bGkz?=
 =?utf-8?B?WGxleVAyK0hRSGxNQ2hFVmUvRmNaZUVWWXVycFNObWVOMm03cElic1U2YWZO?=
 =?utf-8?B?WFRLSi96US92dkZBZ2pFZjNwL0Yzd1pKcFRibmxBc2p6emVjTWsvR3Foa09r?=
 =?utf-8?B?WnBnSjlRODZNMkZ3YzFFbmIzRy9zQjZrWloyRGpDQmp6aHJPdjhjZHZaMnpG?=
 =?utf-8?B?ckhBbFRXMUZVc0hvMnVyelVlZFp2WnVjZks3N1BjYmlxbmtRV3QzeDhQYWdv?=
 =?utf-8?B?eGJ6cXVoZ2djRXpJcVZSYjhMNjZzUldqY25QRjlNTlcxRHpFTjNnbjBuelo4?=
 =?utf-8?B?VE01WWI0NDVOVW1iSy9oanFDa2tvbVdiN3dlRGMzcG9ZdmZuU2F6TjRXWVRv?=
 =?utf-8?B?RmE5cHdocUhlT0xtcmVRY1ltbjliWThKejdTcG4vWmxJaTZMQTNYZWpJOHpw?=
 =?utf-8?B?WWVLT3dBanEydmZZbHdkQXp5cXQ2T1BNTDdWaVRidWlvTE9UcGExQ2NOSWc0?=
 =?utf-8?B?SkxRaVB4RGVaOFJvYmhUZThRYUljcVNFQVVDaUtjaWpsZld1ZSttNS9FRXF2?=
 =?utf-8?B?NzdIYml1dkxTUUlCc1FKb0hIYmFkTEtTaGJCTWtRRS9uWVQ2QjltWUhHeUhP?=
 =?utf-8?B?aE95VWI4V0FhVkJkY1BqU0RHL0VYMVJKaWVub0VBMzVRMTBqSFNWME1MV0RQ?=
 =?utf-8?B?aHEvc1NsUzZFQUFOdTczc2ZqcVpFbmZ3ZGVxQWZzSDNCY0hZdk8rSTVZclpS?=
 =?utf-8?B?ODJ3djI4eTg3SEVqeGlwczVTQWhJYkpad3VMeDBUZXl6bnB0NzM0SzdHZDlJ?=
 =?utf-8?B?ZlQ5MXg3Wjdadm1sRndmUG1yVjN6dWdiSjIzU2wzOERtemNaU3FEWXluZVJO?=
 =?utf-8?B?RHpoVytkUE40MkhCd2IzQU4wVE5YNkdHZEpTTnF1Y21sai84bTkxcDdGUS9y?=
 =?utf-8?B?S09TajdnQ3Z3Zm1rQ1UwTitlbE0rQTFIQnBYQ1M4MlV1eWZFZWtKR3pEbEYw?=
 =?utf-8?B?eFpGcFM3ZkR4Q0lnZ3RjU211bjVDd0J1N1J1SllZVUhmbVk1c3l6ZjdlNjcy?=
 =?utf-8?B?QjRpdFFIVkNlZ2t0RGhxL2c3Z3lML01YSjNzaEcrN1dSa0ltRG1xazhKcmhX?=
 =?utf-8?B?c0N4dGowaDhGYzZJcEVjVjJQNFhnRHR5dExBYi85V2t6SzJHdW1UUjRraHIv?=
 =?utf-8?B?TTdobGRMeHBrYlNTd3MxbmpETWhlSm5Jc1ZLVVR0TGlFYUJJSi9TKzNENllR?=
 =?utf-8?B?TWhJTlR3SHhnaFhIeUM3d3FqMHFsT3VvSzdERHRnemVmVWhlS0hNQXVOSUk0?=
 =?utf-8?B?dlJ1OEdGeDQ2MUN5TTMxaEk0K1hXRWZHWDRUeUx2SEM3WUFTcHN2Q2VQRWlE?=
 =?utf-8?B?Zy84UU5FbzUxRXZpWGp4dGZ1bVczbW40V0hhTzkwQmhxWnAxcTJjanlOdGRz?=
 =?utf-8?B?RGhjSnVsZkhLNjh2OEVsaFBQT0lRRmc4eW5UNmF2OFFBdHRoMk1XY3ZMSERw?=
 =?utf-8?B?Y1VCYmdBV2VycmpRaFNkb1JuQnhkajIwNGNVVlRXL2x4WlBqR2x2VHJZVFE2?=
 =?utf-8?B?S0tybG5DSC96a3RqTnAxRitkRzNDc1g2UTF2aUZPTkhFUTJvMitJMjBpYW9C?=
 =?utf-8?B?VXNySzRiVnNaR1ZnOUJwWWY4eEZVZ3JkcVUreENZS0pxNU1BRGZ6MzdVbVhx?=
 =?utf-8?B?cndqVHRFOGtjUHRjRENmckhwUGxYYjJXbElxMWszM29Rd0VGa2hRK3ViN1ZN?=
 =?utf-8?Q?N6x6Ax12JUHazGcqr+Eo74WMoBtP8vo/5k6hA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WWxNaWFjTXNkQnQ3YXZObmxubS9SWUk0SUtYNTcrWXdsZHBRbEZKRDFzanBj?=
 =?utf-8?B?ZzQ1OVdtS0swci85ckgrckNKb2hlYzBDQVBHRGRxWlNRanpDV3ZCOWVvdXZI?=
 =?utf-8?B?NDg4aWhmNEdXOEVxSkE1bjJsU2JKcUE2emFwWFV5NThGbEw3QXIySEhTY1BK?=
 =?utf-8?B?Q0NBU0tadSs2NHA1SjZPLzFHK21DbEZXWWlXaTJVSEFZRndla0I4U0M3bC9h?=
 =?utf-8?B?eVJHa2tLaXVLQmJCRk9MdENHWkpRMENVMlc2RkQyZWxGdjErNU5La3FmdWli?=
 =?utf-8?B?MStnUCtxekxRcmRKMERyalVJekM1Mjh6aCt4U0tubHBTT0thZnFFdTJjVG1V?=
 =?utf-8?B?UFVLY0NaeGl4MEhjNnRjS2NGUFA3UXBNOHJ0WHdRSHNLZXorcFBSQ0c2RFZv?=
 =?utf-8?B?VC9YWFNjVWRsUXcrb0hnY0hZRWQxeDdPTW9HWkFKUkkxc3ZTUmwxeHg2L2dD?=
 =?utf-8?B?WTRYNmhzOE5ER3FDemRUT0Fra3ZvNFliYlZQemkvSDk2UHVmbTEyYk44K2Fl?=
 =?utf-8?B?b2xSelNzZkFjZkp4OFlZdlhOMjJ5TlorUlZKczIzUk91LzEzNTNvRm45dGZP?=
 =?utf-8?B?aUNqOTgwcDR1RWtsTlIzZFhoL3ptVndwV3dSU0RUT2JEeTdXVGYzVDJUcDJB?=
 =?utf-8?B?ZG5ncGZRTVhsa0U4VldUL3V0SDNaNWtrZUpqNnI4ZUlhdWlCNEV3eFhleGhW?=
 =?utf-8?B?WlJtU25CV2ttRWdWM0plZFB6dGJ4dllvNGNqV0NYNUZsVEp5TGcwaVN6V0pE?=
 =?utf-8?B?am85K0tUZ0lwTnQrblZKZ285ZFFXQUxjU1EyL1JCTVMvck9hYytMS1YyUDZl?=
 =?utf-8?B?eitsMiszNUtoU1kyL2FmaFFrWlU5QXQzZ1ZmNHMrbHozcGxpTEg2OE1CQjJv?=
 =?utf-8?B?L20zN3hEejdWMlBaWkhnK3JZVk9GeXNpQkVKTllYZDlqKzhIY1k0V3BhM0lp?=
 =?utf-8?B?M1RpNmMzVFJvWGRLbzVET1FYbDNSenBNbzFJN0RmZ21DUDlGNzBqYlFZa0hG?=
 =?utf-8?B?YXd5dXZpZlNlMWVMd0VWTERDd1QrMys1V21xUnlndURMMkd1UmY4azNEejlG?=
 =?utf-8?B?OVBLcXdWb2tSSG5LTFAzVi9DKyt0dFc1aWNkdmlXeE9oUXkxcEtJd1V4R28w?=
 =?utf-8?B?NGVZcDBTUkplZ2xyUVl0RDQwNDlnRlQ2TE5ObVAyM0dDdktUV1Vla1hMYU4z?=
 =?utf-8?B?c01IeVNxa0Y0WTdEbkllR0RHMEJPcXZZQUFjMWhSQ29OYmJwSzJSeWZleW9K?=
 =?utf-8?B?L3lpRjBHYWN0a2VMRG41VnA0RzJFcFVSb3RlYUZDUVladHZyYWkxQWFnR3di?=
 =?utf-8?B?bWd1am52TFErN1RGV216NW4zZmVMKzVwUGtZSnBHZ1c5Uy9EcDhQbHFVbHIw?=
 =?utf-8?B?SXh3TmxJM1ZIY3BURlVwb3ZXS1V0VVJDa2tWRmFFN3VRRXVYU2sxaTZlWTVG?=
 =?utf-8?B?MTZubVVGWW5SWnZkeE01NnB5TzJkUlpXd0Nrdm9PWitQeENDQ0JMWWdHcitv?=
 =?utf-8?B?TDlqeHhLcmJ6YTR6dmxUM1IvOTVJNTh6TW01NU1vOUZKcHo3c0J6eFZ1azNN?=
 =?utf-8?B?Mk1ibG11YUt5Q1pUOE5jc0N2YUkyM1FyN0JPS1c3a0hDVlBlck5OOUNnS0Jh?=
 =?utf-8?B?ejJDVjByemdCSTEzd2J0Wkh6ZCtnb25HNVc0OWJtam5UakJycWxXRmJWVUFx?=
 =?utf-8?B?c3FYMDlCWTZBMGxFUWRmcmVMMlZjd3QrSTV1V1VoM3d5eVBIVktPZytPN0RJ?=
 =?utf-8?B?MjdtWURYWHVnb3EzMWVhZWJUVllEcUlTakNSbkN4aHBEZEMyV1FhWTNrN3BF?=
 =?utf-8?B?MjNLNHBYQ1dTaGorOGxsdXJBTGxlUW5jMnlkK0FWUnhZSWJ5WHJHRGczRUVF?=
 =?utf-8?B?MjhmMkQvaFFuZC9rcVhXWUFiOTJTcTY0QnAvRW5xaFdJWkpIb0dnQTZFbFNz?=
 =?utf-8?B?TkF3WnAwOVJpU01EZTN5NUMwOXRaL3VMckNaMWxER0xTWkNya1F1Ymx5djBa?=
 =?utf-8?B?Ry9lMnZSaGpicmNOSnV2eU54OTZjb1d4eHRxMHdXM04wT3B5dHJJc2VhOHdz?=
 =?utf-8?B?TXg4c3FiMDgzc1kxamh2em9XbSt4SmhtSE5jTjYxRGdVZE9TRVhKd3d4M2k3?=
 =?utf-8?Q?2iSA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a12bb2e0-4e3e-43df-5a76-08dd055eb758
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2024 10:17:31.7243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j4E+8p+oZ9b40jF4jP5S9mT830XfR14c3QLgFT1pKndPLltCOgh8gJ2uhnhvTNFLp8+AWNm2ks0uFxtM83zXWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9508

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDMvM10gYXJtNjQ6IGR0czogaW14OTM6IFVzZQ0KPiBJ
TVg5M19DTEtfU1BESUZfSVBHIGFzIFNQRElGIElQRyBjbG9jaw0KPiANCj4gT24gTW9uLCBOb3Yg
MTEsIDIwMjQgYXQgMTE6MTHigK9BTSBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gd3Jv
dGU6DQo+ID4NCj4gPiA+IFN1YmplY3Q6IFtQQVRDSCB2MiAzLzNdIGFybTY0OiBkdHM6IGlteDkz
OiBVc2UNCj4gSU1YOTNfQ0xLX1NQRElGX0lQRw0KPiA+ID4gYXMgU1BESUYgSVBHIGNsb2NrDQo+
ID4gPg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBoYXMgYSBmaXggdGFnLCBidXQgdGhlIG90aGVyIHR3
byBub3QgaGF2ZS4gU28gdGhlIG90aGVyIHR3bw0KPiA+IHdpbGwgbm90IGJlIGJhY2twb3J0ZWQg
YW5kIGNhdXNlIGlzc3VlLg0KPiA+DQo+ID4gU28gdXNlIGZpeGVzIGZvciBhbGwgb3IgZHJvcCBm
aXhlcyBmb3IgYWxsLg0KPiA+DQo+IA0KPiBTaG91bGQgSSBhZGQgdGhlIG9uZSBzYW1lIGZpeGVz
IHRhZyB0byBhbGwgMyBjb21taXRzPw0KDQpJdCBzaG91bGQgYmUgZmluZSB0byB1c2Ugc2FtZSBm
aXhlcyB0YWcsIEkgdGhpbmsuDQoNClJlZ2FyZHMsDQpQZW5nLg0KDQo+IA0KPiBCZXN0IHJlZ2Fy
ZHMNCj4gU2hlbmdqaXUgV2FuZw0KPiANCj4gPiBSZWdhcmRzLA0KPiA+IFBlbmcuDQo+ID4NCj4g
PiA+IElNWDkzX0NMS19CVVNfV0FLRVVQIGlzIG5vdCBhY2N1cmF0ZSBJUEcgY2xvY2ssIHdoaWNo
IG1pc3NlZA0KPiB0aGUNCj4gPiA+IGNsb2NrIGdhdGUgcGFydC4NCj4gPiA+DQo+ID4gPiBJTVg5
M19DTEtfU1BESUZfSVBHIGlzIHRoZSBjb3JyZWN0IGNsb2NrLg0KPiA+ID4NCj4gPiA+IEZpeGVz
OiAxYzRhNGY3MzYyZmQgKCJhcm02NDogZHRzOiBpbXg5MzogQWRkIGF1ZGlvIGRldmljZSBub2Rl
cyIpDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTaGVuZ2ppdSBXYW5nIDxzaGVuZ2ppdS53YW5nQG54
cC5jb20+DQo+ID4gPiBSZXZpZXdlZC1ieTogRnJhbmsgTGkgPEZyYW5rLkxpQG54cC5jb20+DQo+
ID4gPiAtLS0NCj4gPiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg5My5kdHNp
IHwgMiArLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9pbXg5My5kdHNpDQo+ID4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lt
eDkzLmR0c2kNCj4gPiA+IGluZGV4IDY4ODQ4OGRlOGNkMi4uNTY3NjZmZGIwYjFlIDEwMDY0NA0K
PiA+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OTMuZHRzaQ0KPiA+
ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OTMuZHRzaQ0KPiA+ID4g
QEAgLTkyNSw3ICs5MjUsNyBAQCB4Y3ZyOiB4Y3ZyQDQyNjgwMDAwIHsNCj4gPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHJlZy1uYW1lcyA9ICJyYW0iLCAicmVncyIsICJyeGZpZm8i
LA0KPiA+ID4gInR4ZmlmbyI7DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBp
bnRlcnJ1cHRzID0gPEdJQ19TUEkgMjAzDQo+ID4gPiBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCj4g
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8R0lDX1NQSSAy
MDQNCj4gPiA+IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiA+ID4gLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgY2xvY2tzID0gPCZjbGsNCj4gPiA+IElNWDkzX0NMS19CVVNfV0FLRVVQPiwN
Cj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNsb2NrcyA9IDwmY2xrDQo+ID4g
PiBJTVg5M19DTEtfU1BESUZfSVBHPiwNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIDwmY2xrIElNWDkzX0NMS19TUERJRl9HQVRFPiwNCj4gPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwmY2xrIElNWDkzX0NMS19EVU1NWT4sDQo+
ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8JmNsaw0KPiA+ID4g
SU1YOTNfQ0xLX0FVRF9YQ1ZSX0dBVEU+Ow0KPiA+ID4gLS0NCj4gPiA+IDIuMzQuMQ0KPiA+DQo=

