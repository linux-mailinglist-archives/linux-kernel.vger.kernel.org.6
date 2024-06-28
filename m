Return-Path: <linux-kernel+bounces-233231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAA791B493
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 001AF1F221ED
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 01:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A49125DB;
	Fri, 28 Jun 2024 01:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VtM38O5P"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9301CA55;
	Fri, 28 Jun 2024 01:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719537438; cv=fail; b=Lrr2m8FnCtOO9DmrcSMK2i5x0rB+Av6nMEy1D2jEqFDTfz2oq13Y9lxSJlgAgcqNxTw7VqVM37sllaIKvEZaK0t9NCv94ni7gZEyQqQYTTNcvCe40vjSjTqgMBQph/Y+5lU/yWdbaiorAYU5xyWiKimVe6tK/6VlclFDK7b5Hvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719537438; c=relaxed/simple;
	bh=ctdB+9uTj8JDlr8Dtn7Bi1GvkmlMYkRr+m379tmHKsY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PTRiu4dHj2M49/LKWbxknAxTf9OQReHChaPZQW7DOfTVvtacFAl2uGy2WAn2YpMd70Loy2IXSdSBwDbJLVlheTLBdAoyMuj7p4XsCCvyAFPkY6LIt340SycDaBnuB/P6n9/BsvOGsrXLDzvGHveVZGNL/9CG0z8oYz8fuQGDqis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VtM38O5P; arc=fail smtp.client-ip=40.107.21.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTxr+gAgTa+TFbAYvyLK8MUO/WLQ2IG9ppRxY7G3C+zuPsqB7eLkUOvxDeMAgfU0o+EDtMxX5CXpMGI0d74r0c/wfSGbxcyL8j2OJX0ByMVzKz4yeCGXCFWp6YNjVwAu3WW3XEwp9cEhYjBvg3/h7J8gFBcKWYZLlEwLKDrADAzQM+GbgUFthcrUwKD0UDcJ2UAq/k1NWGUbMPXdqCHkO+9LKkbFJsvstRaEB4xMJI3yzEpHl3aWRj9ZFyS7Lq4sWGJ16PzXDdOoJq7MO37QeZ/1j4Xkwj6Vj3ij2cRpy7LbE6I7fpomfA8txxO4yaa4ei6v5jLBJhCw/NcKm3hg2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctdB+9uTj8JDlr8Dtn7Bi1GvkmlMYkRr+m379tmHKsY=;
 b=SzgUtBbaDYMnzzcOwSXnzvEVQwfM3xMilZ9/YNNQEdOrpxMBpcaZVdbB7nHG78sgDTYm8u4pV/4qIYZKTaNLdicxEx6oHEwJk0b8mD0YG/JR2KA6nFelm8xQV74WS/4oJQ6m+KLcS7hu8CCOVt7G2CfY2w9ED8lVVfPkVzs4gGxl2LvLD5Tv9CPYduLmmbw5aO+yjoAqCef5NBSVZpBaRCww9Q2+9t/BL9Di4MsYdt7uvrApGzHSG4BEQM7qK932vYqkb6wWeVrhytYFYPFAKY+2t9EDbU8KNqjcrQFOnDwb90j2AAvHTXhzBZhnc7RZoi2N7WhRjwxBF0CBvybwvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctdB+9uTj8JDlr8Dtn7Bi1GvkmlMYkRr+m379tmHKsY=;
 b=VtM38O5Pa9UrulofjcsNiMUN9qTpkdSZp3AcR5jeBYNpPml7EMLZYGBe0XhaKxNhCFrwsBsWVH/VSOytvgOD2Ef3yvfLQtpBt8WgG/l3Vb34f2pf3WqbUT0hI2jGQmG2/sNuxE+362Lv6NtFr16MGlEUxOn8oKlUDSYQR+B+yjQ=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by PA4PR04MB7856.eurprd04.prod.outlook.com (2603:10a6:102:cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Fri, 28 Jun
 2024 01:17:13 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 01:17:13 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Pengfei Li <pengfei.li_1@nxp.com>
CC: "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "abelvesa@kernel.org" <abelvesa@kernel.org>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, Jacky Bai <ping.bai@nxp.com>, Ye Li
	<ye.li@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>, Frank Li
	<frank.li@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] clk: imx93: Drop macro IMX93_CLK_END
Thread-Topic: [PATCH 1/2] clk: imx93: Drop macro IMX93_CLK_END
Thread-Index: AQHaxqICs0HdElmggEaM9UqDqnF2eLHYGdAAgAAyBQCAADFugIAD5tIA
Date: Fri, 28 Jun 2024 01:17:13 +0000
Message-ID:
 <AM6PR04MB5941061D0DCA71B31F44497488D02@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240625175147.94985-1-pengfei.li_1@nxp.com>
 <20240625175147.94985-2-pengfei.li_1@nxp.com>
 <39bcab8b-ed9c-4da9-b1ee-32dbfb2a23a4@kernel.org>
 <ZnqfIudepX4sH4oL@pengfei-OptiPlex-Tower-Plus-7010>
 <61c1eb8b-b8fd-4e9e-b0fc-27ce1c2eb2b1@kernel.org>
In-Reply-To: <61c1eb8b-b8fd-4e9e-b0fc-27ce1c2eb2b1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|PA4PR04MB7856:EE_
x-ms-office365-filtering-correlation-id: b9633698-d6b7-49c2-18f0-08dc97100a81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R0lBaHJERlFQTjN1SitCQll4a25ZdkQ1c04xbVFWdFAyenErU013MzJibjh4?=
 =?utf-8?B?V0RUL2lnQkltMzR5eEhObzVqQ2t3aEd3eVBWNWQ2bWkzTjR5c0crUlZBNUM2?=
 =?utf-8?B?aGgraFZKTVJVTENYWGticTl0Ui9ldVFWaVFGNkFDUmxrdURRMEVVWXFGMEpT?=
 =?utf-8?B?QjdTUWpXamQ0SzIrQUV4eEZiZmxVVlp2TU5oQlVxakFPb0M5TXJMeFB6Mnlw?=
 =?utf-8?B?dmVab2oybEVuc3lubEt6bE1EYzBETUFMOTZjUEVaRTdRNHdvL0dWS05BNUNr?=
 =?utf-8?B?aFRrNDRJSjVKaEtjRllzQ1FiODVVdkd6RFNRZFZBb1dPa0JLWi9xclpuVGxH?=
 =?utf-8?B?VXJHYmtQMDV0LzNMRjZaSnY2RGx2NnpmSkJPQitlYkFLOHlCVU1hUXlCanRo?=
 =?utf-8?B?WFNEVGY2OUFYZTk5Syt6bmc0ZVI0RHNVeTc0ZzJDcHBDY3U1YTFBRlFxTjRl?=
 =?utf-8?B?RHdVVlZ1SkFFV0FubE1pYU96Y1QzT2pCcXJTbVBMajVrTVAxd3p6MmRDdTNj?=
 =?utf-8?B?NUxydHZNM0hpcEhDdkpDVFdlWVVOUjBaTUdRNzRhbzE1bGJRSGF2UDhpbXZh?=
 =?utf-8?B?UXhLWDEzUU9xMWhHYjExMHIyTzdZZXR1eFFrcmEyMzZUb1lRMFZqTlkybEJ5?=
 =?utf-8?B?OC9IczFybEJtSG40eDQyZTY0ZmFwRXErbTd3VTRFcXdSSlNoek9BRXZDSTdq?=
 =?utf-8?B?OTVOSk1TREdieDBUUXBYa2VEcjRtSzhXdTMrYklBUkRLMkRldXJVRXpUbHc2?=
 =?utf-8?B?eGxzZzhsTE0xR0NqWm16aW5LTWpXNU9NWW9nb2Nrd2p3YWNZeFhOU1NkaWN0?=
 =?utf-8?B?bWd2Tm1GQzYxRnZSaGZGMWt2bENhbG91YnFtbGxQUytMY3A0QnovMTZWN1py?=
 =?utf-8?B?VmdLTnZrek1EbSs3VVRncDFJOVBjYU5UbTYvajAxcEJyVjcxdVJlK1VKSnBN?=
 =?utf-8?B?WjZRNDQrSFVmcnFrNmxaeHo5bkNNci9BMzhKUjEvSXQrT0VDNE1UVjdvdmh0?=
 =?utf-8?B?cWFSLzc4NDRKUTlGV3oyR1BLY1h1R3hmbXZTaHhBdFFUcU15NWw1Z1BmVnhs?=
 =?utf-8?B?Z0JEdTB1WlZzcVkvcVF3WFpQU1Rha3BLUGI5c0t5T0N0UDNGUlpmUlJMdi9X?=
 =?utf-8?B?M0pHaVRmMjJqZzljYzlZbmdzZ2k0cm5ZSWUvcUVKakhEcGhwY0ZpNlpCcVdw?=
 =?utf-8?B?TlRDcnhkeTRTRDdOclpKMnYxcWlKZDRwRDl6eXBCRE42RDBZc0VOTi9Ed2cy?=
 =?utf-8?B?VTBHNnArajJ2b3E3SWVHVXhIYjE2dWVHZ0F3VU8xbUs3Qk5sZFpQSDBEQnp0?=
 =?utf-8?B?eE82Q09hcUsraE9DQmtuSTRLNzVqQitKOHdvQkFzcFhJWkdlRlhFNzgxWEpJ?=
 =?utf-8?B?NmZ0Z3pXQjdsQVJxWDJ3SzNHV1doVjdHUzdZT3h0dkxsdmNES2ZDMHBCOUNo?=
 =?utf-8?B?YTBLMFhDVDlSdGFGcjJKVnFZWWdMZElQSGUyQTBFeWVlbUt5a3J6cVpLRlNR?=
 =?utf-8?B?RWllN3diaTErODhVZDdmUnVRWHdZbjFLSmZ1RFVuMWNBS2hKN3h6N1BMdDhG?=
 =?utf-8?B?NmI0NDhXcTdWQU5vSjJUNXdVbTN6Z2tjOTNDZWJvc3M4UEU1SEtGQXJhb3cx?=
 =?utf-8?B?OEdReXBhZFVRUk9maW85RTZnL3EwRlpkQkhWNUFWWWdFNlZOL3NheURRbUJ4?=
 =?utf-8?B?MU01UHJPQXJHSHhEdHZGWHV0REsrNURUWmVTOG5PaThtWVh1Q1Q0cXE4VzZG?=
 =?utf-8?B?SkJaS0xFQStTUllyOTFxL3cydDBiMkVSdE9Tbyt4djVOSUFUVGxBVnIyb0E5?=
 =?utf-8?B?OGdkOG90UGJwbjduY210Sm1VQmhad0JOMjdrdDE1VHZrWS9vbHArQ3dJY3Bv?=
 =?utf-8?B?bjNqS1ZkS3c3YzRnZ3J3Zk9LN0N0THIvbXVZNlJGN2tCY1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZW52VWY2d29la3RlU1VRRHJNMkgxYkRrZnB2dlVCSnlkOWZPSU1zOUlYMVJu?=
 =?utf-8?B?b0p3QzZkNjVaM2Y3cS9ZSmxkMktiNGxCc2FtUlExVFRPTDI4QTBSRTFBaWZi?=
 =?utf-8?B?NTN3VEFtM0t2WE42cHo5R3dUZERpZk5PMEIrRS9vUHY4NGdLbXErTG1pOU5z?=
 =?utf-8?B?cnppVTU1K1prTGpEaktCVXVwWUV5YzJvcXdwUzlTMGtvZE1OZWllQWNrMGs4?=
 =?utf-8?B?Z1htVzZoSU9WSFZoYngrZTVIQThCR005TWV0dkZkZE83UXJCM0xtd2ZzV204?=
 =?utf-8?B?RTdaMkVLT2x1b3B3ejBlN1hickZibjFnRys4V2t2TFVHTnJpVGZmZDdGTVRW?=
 =?utf-8?B?bFU4cE5Sai9Id0pJeUFtc0JUcWRMaDBVWHFHcGt4TmY2SUtMU1pyNTBMU2tz?=
 =?utf-8?B?SnNhRGljdlY2Y0RzK05MeW5wb1MwQ0RhbUdOZEh1WUx3ZUMvd0JPZjFXZHJq?=
 =?utf-8?B?ZlpLVDhSTnZmRnRZSkJIWkJhRHZuYU1IWFJmNm9SY20wNU9pdms3dXhkRWtt?=
 =?utf-8?B?Q0V2Mk1nQzNsUWRUQ2lxaGNGWHd2ZVU0MWdvWE5QQzJKTmxwMkVSOEJubEpw?=
 =?utf-8?B?c1RHS0F3K2k0cVBSRXBUZlZ2NStSYXhNUFRVbnJ5T0JXU1UxYUJZZEJQSmF0?=
 =?utf-8?B?eVhSWDNOSDludUdURkcvRk8rWHRobFFqL21BY3hiYkVqdW9SUXNvT29hemVt?=
 =?utf-8?B?bEdMNGVBTGF3b1FrT1pycjhCbjJTeG0rTXhndjFuYmxjN0dDejU0YU1zWndX?=
 =?utf-8?B?THMwYXdxSzZGSXlFcGtDNzFCY2U1UTE2bVJBTldXT1R4a1BCUitRaFZiZTZr?=
 =?utf-8?B?SXVmbTRCU2FHZHRrS2V5ZmhTazBqazdWUjBIZTNRU1orM1BhNnpYaEIrbFlR?=
 =?utf-8?B?TzNBbERJL1A1WFdMMjZBaFVjQlB2RDVMamtFYk5Fa0FJN0JUdnc5cVJLc244?=
 =?utf-8?B?RUVpMHlSaGF3N3FsL3ZtaFJpbm1wK0JEK2pmbnF1Zm5FQmtsRjJVUXUyNVlF?=
 =?utf-8?B?VDViaXJHTTB3YVpuZVZjQVdoL0x1Wmt6NHpMd3FCUGVybkp5TVJUZ0xDWjAv?=
 =?utf-8?B?K3lkaDVmSXNrci9PMTdiMWxRbXUxUUp1QlJBaW1QazhLV2FQSUR3VGgwVHFD?=
 =?utf-8?B?TzRwMU8zRis1N253UVU5WE8zdVFYVndvZFlzemtwcHB4d1BnYjRveFN6a2lL?=
 =?utf-8?B?SGlPNE1IN1VRbzdBblM4TjVPRVFlREZicUs3RFYrN1hzSk9qZElBUjM1Zjh1?=
 =?utf-8?B?SXpYcjlKWnAvTjdVclVmMEhHcHZXZFBnNk5hNURPVEJhb09vd2dNSW9SMU93?=
 =?utf-8?B?NytoeWM2NmJHaWRxOG9SaWRYUXpQNjkvenBESUVjNTMyOFc4RTJ3NlNsakdo?=
 =?utf-8?B?LzNVZ2htbEE1OVJjdmxvRnVseWJjWlpQaWNPT2NFc2FFcHBKRUMyekxpejRE?=
 =?utf-8?B?UFk3cDFlYzMrdkRTUHZQR1VSeEwyTUJheDhYQXlMVWJkcHYrcjBuZE5YbkR3?=
 =?utf-8?B?alM4akMrOW9zbmVDR05NcDFoOFFYRXZhdzMxSjJtOGxURXdFeFF5OVBWaWQy?=
 =?utf-8?B?eTgzTHprcFF3TnE0VDVNRVdUWVJFcS9PSjBGUE03SUtaMXhYRjVqcU5LY01C?=
 =?utf-8?B?OVA4ZzJSc1NPbUlyM0cycVNxNG5GQ0V2aGtvOFNackRqRm10d3JCZi9adWxX?=
 =?utf-8?B?U0Rxd3FEY2ZnVW1xY0xWTnZYWlZhdmMzSThjMktMMzg1TG5HcUdLL3o1SFM3?=
 =?utf-8?B?ZDVPc3NYa1A2eHU4SjIzMFRGY0RsTENXbVluUDZndlRxYWJST1ovY0VlWjlG?=
 =?utf-8?B?QVVjNDdSNGZpT29ycU1CMW9KRkJDTmhYbk9SSW1GanVoSkd4NkE2VmFpQ1dz?=
 =?utf-8?B?R2MwRzlQMDgzVDlqUWNnMGVhcittNlduOW5XVVFDVUZ1dWVmK05USXk5T1Vk?=
 =?utf-8?B?MkJkOVE4eCt1SXd4aVhhSThCV3dKQUtYOTdIYXQyakNzU0lIMksrTGFVblFp?=
 =?utf-8?B?SStVVzBUTkE5RC9ueDFCKzhNRW4rN2pWSXVqNmFMMXNzTWF5Mlp3YW1oWnA4?=
 =?utf-8?B?bjZzeEN3ZysyWXRBMDc2L2cxYTdQNFdtcUZsNjNUY3RWc0EwT1R3dnV5M3ZN?=
 =?utf-8?Q?5SAk=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9633698-d6b7-49c2-18f0-08dc97100a81
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 01:17:13.0647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i7jms7BGK7j+3ebrWQRXux6pUR+rzJTmUa4pQQYcKZ+d6setfmTaT3xgHqqd0hoBZIkKiY/lZ7VE0PZH8RYJkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7856

PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gY2xrOiBpbXg5MzogRHJvcCBtYWNybyBJTVg5M19D
TEtfRU5EDQo+IA0KPiBPbiAyNS8wNi8yMDI0IDEyOjQzLCBQZW5nZmVpIExpIHdyb3RlOg0KPiA+
IE9uIFR1ZSwgSnVuIDI1LCAyMDI0IGF0IDA5OjQ0OjQyQU0gKzAyMDAsIEtyenlzenRvZiBLb3ps
b3dza2kNCj4gd3JvdGU6DQo+ID4+IE9uIDI1LzA2LzIwMjQgMTk6NTEsIFBlbmdmZWkgTGkgd3Jv
dGU6DQo+ID4+PiBJTVg5M19DTEtfRU5EIHdhcyBwcmV2aW91c2x5IGRlZmluZWQgaW4gaW14OTMt
Y2xvY2suaCB0bw0KPiBpbmRpY2F0ZQ0KPiA+Pj4gdGhlIG51bWJlciBvZiBjbG9ja3MsIGJ1dCBp
dCBpcyBub3QgcGFydCBvZiB0aGUgQUJJLCBzbyBpdCBzaG91bGQgYmUNCj4gPj4+IGRyb3BwZWQu
DQo+ID4+Pg0KPiA+Pj4gTm93LCB0aGUgZHJpdmVyIGdldHMgdGhlIG51bWJlciBvZiBjbGtzIGJ5
IHF1ZXJ5aW5nIHRoZSBtYXhpbXVtDQo+ID4+PiBpbmRleCBpbiB0aGUgY2xrIGFycmF5LiBEdWUg
dG8gdGhlIGRpc2NvbnRpbnVpdHkgaW4gdGhlIGRlZmluaXRpb24NCj4gPj4+IG9mIGNsayBpbmRl
eCwgd2l0aCBzb21lIGdhcHMgcHJlc2VudCwgdGhlIHRvdGFsIGNvdW50IGNhbm5vdCBiZQ0KPiA+
Pj4gb2J0YWluZWQgYnkgc3VtbWluZyB0aGUgYXJyYXkgc2l6ZS4NCj4gPj4+DQo+ID4+PiBTaWdu
ZWQtb2ZmLWJ5OiBQZW5nZmVpIExpIDxwZW5nZmVpLmxpXzFAbnhwLmNvbT4NCj4gPj4+IC0tLQ0K
PiA+Pj4gIGRyaXZlcnMvY2xrL2lteC9jbGstaW14OTMuYyB8IDI1ICsrKysrKysrKysrKysrKysr
KysrKy0tLS0NCj4gPj4+ICAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgNCBkZWxl
dGlvbnMoLSkNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvaW14L2Nsay1p
bXg5My5jDQo+ID4+PiBiL2RyaXZlcnMvY2xrL2lteC9jbGstaW14OTMuYyBpbmRleCBjNmE5YmM4
ZWNjMWYuLjY4YzkyOTUxMmUxNg0KPiA+Pj4gMTAwNjQ0DQo+ID4+PiAtLS0gYS9kcml2ZXJzL2Ns
ay9pbXgvY2xrLWlteDkzLmMNCj4gPj4+ICsrKyBiL2RyaXZlcnMvY2xrL2lteC9jbGstaW14OTMu
Yw0KPiA+Pj4gQEAgLTI1Nyw2ICsyNTcsMjAgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBpbXg5M19j
bGtfY2Nncg0KPiB7ICBzdGF0aWMNCj4gPj4+IHN0cnVjdCBjbGtfaHdfb25lY2VsbF9kYXRhICpj
bGtfaHdfZGF0YTsgIHN0YXRpYyBzdHJ1Y3QgY2xrX2h3DQo+ID4+PiAqKmNsa3M7DQo+ID4+Pg0K
PiA+Pj4gK3N0YXRpYyBpbnQgaW14X2Nsa3NfZ2V0X251bSh2b2lkKQ0KPiA+Pj4gK3sNCj4gPj4+
ICsJdTMyIHZhbCA9IDA7DQo+ID4+PiArCWludCBpOw0KPiA+Pj4gKw0KPiA+Pj4gKwlmb3IgKGkg
PSAwOyBpIDwgQVJSQVlfU0laRShyb290X2FycmF5KTsgaSsrKQ0KPiA+Pj4gKwkJdmFsID0gbWF4
X3QodTMyLCB2YWwsIHJvb3RfYXJyYXlbaV0uY2xrKTsNCj4gPj4+ICsNCj4gPj4+ICsJZm9yIChp
ID0gMDsgaSA8IEFSUkFZX1NJWkUoY2Nncl9hcnJheSk7IGkrKykNCj4gPj4+ICsJCXZhbCA9IG1h
eF90KHUzMiwgdmFsLCBjY2dyX2FycmF5W2ldLmNsayk7DQo+ID4+PiArDQo+ID4+PiArCXJldHVy
biB2YWwgKyAxOw0KPiA+Pj4gK30NCj4gPj4+ICsNCj4gPj4+ICBzdGF0aWMgaW50IGlteDkzX2Ns
b2Nrc19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KSAgew0KPiA+Pj4gIAlzdHJ1
Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiA+Pj4gQEAgLTI2NCwxNCArMjc4LDE3IEBA
IHN0YXRpYyBpbnQgaW14OTNfY2xvY2tzX3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQo+ID4+PiAgCWNvbnN0IHN0cnVjdCBpbXg5M19jbGtfcm9vdCAqcm9vdDsNCj4gPj4+
ICAJY29uc3Qgc3RydWN0IGlteDkzX2Nsa19jY2dyICpjY2dyOw0KPiA+Pj4gIAl2b2lkIF9faW9t
ZW0gKmJhc2UsICphbmF0b3BfYmFzZTsNCj4gPj4+ICsJaW50IGNsa3NfbnVtOw0KPiA+Pj4gIAlp
bnQgaSwgcmV0Ow0KPiA+Pj4NCj4gPj4+ICsJY2xrc19udW0gPSBpbXhfY2xrc19nZXRfbnVtKCk7
DQo+ID4+PiArDQo+ID4+PiAgCWNsa19od19kYXRhID0gZGV2bV9remFsbG9jKGRldiwgc3RydWN0
X3NpemUoY2xrX2h3X2RhdGEsDQo+IGh3cywNCj4gPj4+IC0JCQkJCSAgSU1YOTNfQ0xLX0VORCks
DQo+IEdGUF9LRVJORUwpOw0KPiA+Pj4gKwkJCQkJICBjbGtzX251bSksIEdGUF9LRVJORUwpOw0K
PiA+Pj4gIAlpZiAoIWNsa19od19kYXRhKQ0KPiA+Pj4gIAkJcmV0dXJuIC1FTk9NRU07DQo+ID4+
Pg0KPiA+Pj4gLQljbGtfaHdfZGF0YS0+bnVtID0gSU1YOTNfQ0xLX0VORDsNCj4gPj4+ICsJY2xr
X2h3X2RhdGEtPm51bSA9IGNsa3NfbnVtOw0KPiA+Pg0KPiA+PiBXaHkgc28gY29tcGxpY2F0ZWQg
Y29kZSBpbnN0ZWFkIG9mIHByZS1wcm9jZXNzb3IgZGVmaW5lIG9yIGFycmF5DQo+IHNpemU/DQo+
ID4+DQo+ID4+IEJlc3QgcmVnYXJkcywNCj4gPj4gS3J6eXN6dG9mDQo+ID4+DQo+ID4+DQo+ID4N
Cj4gPiBIaSBLcnp5c3p0b2YsDQo+ID4NCj4gPiBUaGFua3MgZm9yIHRoZSBjb21tZW50LCBoZXJl
IGFyZSBzb21lIG9mIG91ciB0aG91Z2h0cy4NCj4gPg0KPiA+IFJlZ2FyZGluZyB0aGUgcHJlZGVm
aW5lZCBtZXRob2QsIGl0J3MgZWFzeSB0byBmb3JnZXQgdG8gdXBkYXRlIHRoZQ0KPiA+IG1hY3Jv
IGRlZmluaXRpb24gd2hlbiBhZGRpbmcgc29tZSBuZXcgY2xvY2tzIHRvIGlteDkzLWNsb2NrLmgg
aW4NCj4gdGhlIGZ1dHVyZS4NCj4gDQo+IFNvbWVob3cgbW9zdCBkZXZlbG9wZXJzIGluIG1vc3Qg
cGxhdGZvcm1zIGNhbiBkbyBpdC4uLiBBbnl3YXksIHRoYXQNCj4gd291bGQgYmUgYnVpbGQgdGlt
ZSBkZXRlY3RhYmxlIHNvIG5vIHByb2JsZW0gYXQgYWxsLg0KPiANCj4gPg0KPiA+IEFsc28sIHdl
IGNhbm5vdCB1c2UgdGhlIGFycmF5IHNpemUgbWV0aG9kIGluIHRoaXMgc2NlbmFyaW8sIGFzIHNv
bWUNCj4gPiB1bm5lY2Vzc2FyeSBjbG9ja3MgaGF2ZSBiZWVuIHJlbW92ZWQgaW4gdGhlIHBhc3Qs
IHJlc3VsdGluZyBpbg0KPiA+IGRpc2NvbnRpbnVvdXMgZGVmaW5pdGlvbnMgb2YgY2xvY2sgaW5k
ZXhlcy4gVGhpcyBtZWFucyB0aGF0IHRoZQ0KPiA+IG1heGltdW0gY2xvY2sgaW5kZXggY2FuIGJl
IGxhcmdlciB0aGFuIHRoZSBhbGxvY2F0ZWQgY2xrX2h3IGFycmF5DQo+IHNpemUuIEF0IHRoaXMg
cG9pbnQsIHVzaW5nIHRoZSBtYXhpbXVtIGluZGV4IHRvIGFjY2VzcyB0aGUgY2xrX2h3IGFycmF5
DQo+IHdpbGwgcmVzdWx0IGluIGFuIG91dCBvZiBib3VuZHMgZXJyb3IuDQo+IA0KPiBZb3UgbWl4
IGJpbmRpbmdzIHdpdGggYXJyYXkgZW50cmllcy4gVGhhdCdzIGluZGVwZW5kZW50IG9yIGp1c3Qg
Y2xvY2sNCj4gZHJpdmVycyBhcmUgYnJva2VuLg0KDQpCdXQgdGhlcmUgaXMgaXNzdWUgdGhhdCBi
aW5kaW5nIHVwZGF0ZSBhbmQgY2xvY2sgZHJpdmVyIGFyZSBub3JtYWxseSBpbg0KdHdvIHBhdGNo
ZXMuICBTbyBpZiBqdXN0IHVzZSB0aGUgSU1YOTNfQ0xLX0VORCBpbiB0aGlzIGZpbGUsDQppdCB3
aWxsIGJlIGVhc3kgdG8gYnJlYWsgYGdpdCBiaXNlY3RgLg0KDQpSZWdhcmRzLA0KUGVuZy4NCg0K
PiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQoNCg==

