Return-Path: <linux-kernel+bounces-217071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E92C90AB1A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 924FAB36E51
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541301953B2;
	Mon, 17 Jun 2024 09:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MZ9TCXIa"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2079.outbound.protection.outlook.com [40.107.8.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6B7193081;
	Mon, 17 Jun 2024 09:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718617384; cv=fail; b=DGvnRPnjRRKaEAjMqTgHZdtAKkYW9Vu/4rcTsneXcjZCGeouH4qnS5HOyafuXl9uznpKmku5dL2G8JuMOzMeI1IVI1MoWxZTqFNoryICWmM+t5N0z1GxtY5BK7fvYxDx3ZSPSl1E6TuKQQwCN2PphgyO1B8PwPuopyktKDuTEZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718617384; c=relaxed/simple;
	bh=D1fOEVM+DHWQ/kcg59EUTbCZBfQjk1vWY+0MYw/LLZQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cObEnbPblKhFjK7eyrPMlquyys5EgoNOAMP6Tg+msWUq58h+KQrmc8uaEhin77VR3PgSDduknxtyxGCxMSE2GTIn3cWGMVlKTFHo1B4i8WKxol3tGKks8o4eXuWnvhBH41jiW4/neV24qmffzYjzoONgNIBG5fmPVhZWukJKHo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MZ9TCXIa; arc=fail smtp.client-ip=40.107.8.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQtDhL41SYnpyY907JuzHJ3Ge1PgOat/TAJYl2qc2IZFYxLHojjqGIAbp8whnZ1k9l0Q8wkskWRYwEhlLrMUNeMnYOBxMcmRos8TYLsIgPJWHeXiSvyc7cUn2TNhF1nIJ9O2XVi0Svs98jOYIQTHbykWkgQLAfMiFZMDTXmLi/PEYhRarfv64B+3mB/y2Aw2Q+UjjdgMl7404AckZn7Ney8/sAwkpbVDOwIJL7y6mZNlDk3zTbeeLv2p2gSeYJu1eWnTjJtwZIAGAj980xPBcWNhlfVT5OB81bC4BynxAqIpguCpGiCp2JRIYj/GDSd/f8hkmCvoN+Gmc5ywZkrRAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1fOEVM+DHWQ/kcg59EUTbCZBfQjk1vWY+0MYw/LLZQ=;
 b=aZ1THVjnD49E+Q1+yjNGL3SwR6WkP27KpeYDlQcv0SW/cfiDo+4eZG3K1WN46pF/u45V8d0tSu26gckSUOhfRtE+7cMOj7TMoqzsLMNfnfbGAdEmWnKIkesodSaT6Mjc1dd0QVWOoeKkYLmR+ido47DQ4pOMd9c+G1aZ7WdDhHZR+tW8XngCvImOQ+WoeqgwCqVhi6kEce4NpGTrfez71peSbCBsHRxNn2/ZGhR3U8LCxcCYgWW1DoSek2fjhK8caqkAfyubxlINI+yxxqlRx94gbTzfQHs3DK0QRm/w8gazbHF0+O18MNHj4/In9XIEoGQftvCTIWG8J/cA6E7sfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1fOEVM+DHWQ/kcg59EUTbCZBfQjk1vWY+0MYw/LLZQ=;
 b=MZ9TCXIayjhY/SgXmf19/wG91LsWpxsy/jod/75t4mXIcYTP8d7Q0NP6BNnseQ2HF6uJYigo+Dqy6WsQukGuauv7aWHAiRi1Ms8oDt/3Dr4UA114f0TRiv3x/2UK0O6sV55NARDSY+Wu+b9bRZT+PXShpJB1V3zfCFO18qcVozM=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by PA1PR04MB10143.eurprd04.prod.outlook.com (2603:10a6:102:463::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 09:42:58 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 09:42:58 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Jonathan Corbet <corbet@lwn.net>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi
	<cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v4 0/6] firmware: support i.MX95 SCMI BBM/MISC Extenstion
Thread-Topic: [PATCH v4 0/6] firmware: support i.MX95 SCMI BBM/MISC Extenstion
Thread-Index: AQHarbcSRA31Fg5kVESXEpwlbKGGhbHL2ghw
Date: Mon, 17 Jun 2024 09:42:58 +0000
Message-ID:
 <AM6PR04MB594185473203DC3FC065918A88CD2@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240524-imx95-bbm-misc-v2-v4-0-dc456995d590@nxp.com>
In-Reply-To: <20240524-imx95-bbm-misc-v2-v4-0-dc456995d590@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|PA1PR04MB10143:EE_
x-ms-office365-filtering-correlation-id: f2cfecee-8831-462a-8cac-08dc8eb1df37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|366013|376011|7416011|1800799021|38070700015|921017;
x-microsoft-antispam-message-info:
 =?utf-8?B?RGoydHVtZW1jbThQaTNMRGYzakRXOWkrdUgwUDBHemJrRitzNkFUbTh6c0kw?=
 =?utf-8?B?WFBianpWajVESDFOalRBa29kQndBMnhoZkxpTmpqYjU3a09kdm1hWkM1cWJM?=
 =?utf-8?B?aHdiYWg1YlFpV3EzTHdoaUpOZmRXbm9YS3V5bmdzUFFwbnZrazIydnBpeFQz?=
 =?utf-8?B?Y1BvRFB0bkNPL2JJbHVsbHZFV3dRTlVVUmF2eU8zTnk4bUhOaStmM2JIbXZW?=
 =?utf-8?B?TUN6N2MycVc3WVFXaGVTUTIwZlYvbk80VTlJYlUrbmUvRVB1QTE1cERQOXV4?=
 =?utf-8?B?a29BRnhJb0h4SmVIQWRDTTNWclB1VGZ1S2FGaFM3QW5KTUlBWUZXSDB3L0VR?=
 =?utf-8?B?dXZJajlRcDI4QTVIemJ2bDhlRXgyb3d5TjVLeFMxWEZvaXROaklQeld5M1NR?=
 =?utf-8?B?MmtVa2pmc2I1cDRVTzV4MWsvSXFsMVlLZjlIUnptci9OK1lyV1l3MlUvVVY4?=
 =?utf-8?B?Qm1aWVE1bmI3UEI5YkYwd29nQ08xdi9rYjB1TmVPMlpVMFN3OXJxYTRNT01C?=
 =?utf-8?B?b0JaaFhEaVZVbm9abHZWUEtQcTBMNng5bU5GZjFGUmliUFZaSENMQzdBWE5X?=
 =?utf-8?B?MjV5QU1wTlRLbjN5MWt0ZkkxbFBUUVBlSGNPM1J1dk9tckxPN08zR0hRRUdV?=
 =?utf-8?B?RnViRGhqWENyaHptTEhTd0NIU201bGlabFhvdEg0MnFwcFM1aXlMSS84NTVk?=
 =?utf-8?B?WXFISjc1dUxjVndWc2VYK3FLTHFPbDRVbTlweDJHY1hPWjIyenByUWN0UmFK?=
 =?utf-8?B?QWl1aGV0T0lQMW0yUkJuT3lwT09pT29XdHo1RmYvTkpraFlsTHVxYUlqV0h5?=
 =?utf-8?B?OW11M2IxbEJiYmFTemcxUG8rbElYTGd3bHpYWFdJY1UycnpsWlNoRHFudUw0?=
 =?utf-8?B?UnZLWjVnQ3VZYU44ZkZoZUFuaUFqSVVJQVJ5TFFGc3FKNzh3RnR0NkxtQVlM?=
 =?utf-8?B?ZXllaEpySlcvQURuaFBmU2R4RjlwczhzOVhrY3E3TElnU01tZUpBMnNkcVhm?=
 =?utf-8?B?SGZINDVJK1JaaGg0WEpheGYyRzZZczc2bXhYZUZubTd2ODdESHl0eHhTb3Bl?=
 =?utf-8?B?NWdzRithUTh0S01SRzlqWVBGVEJvVXNDRjNrYTlhOFZNU1BlbzZCSkcxRFRw?=
 =?utf-8?B?RytZVFJ2N25JS2VBcWpQcUUwRnlYU3ZnUEtDNld2cjgwZUVQU2dGZ3pVL2d5?=
 =?utf-8?B?LzE2WFpWbm9ubGZ0NjNxQXp0ZHF5RkU2N2FFTGdZMWlYdGVFTUkrMDlsTDhI?=
 =?utf-8?B?K2pObGFRcXpqNERGK2hEaUlGWnZQVzV2dUJ6UjZPM2FNN3RteHg4TmhhY3A5?=
 =?utf-8?B?QlgrSUdIUkQ0eUNqM0tHQTVwa0JwMkd5dkV4eFkwa2FDK1VydHM3ZVFKQ0U2?=
 =?utf-8?B?dVYwd2tBUnY2UlR5Q2NhYXAwbG5wNlBKcWlRSSsyNXQyOHo2ZzRPdzB4UWU4?=
 =?utf-8?B?YnpiQ1FDWEo0WWdMUUdiOEZockhGNVBjaVQycC9tZ0p0RWxNeWFuOGRwM1Nx?=
 =?utf-8?B?WlJsY1JiVS9pYi8xUWZhOHVqeXVQbTBod2dialdyVmw1NDdYNWxIWFp5T1gy?=
 =?utf-8?B?SG5Za1pUdWhBVUFaRkh6MU95NTArQ1c3TUd2WWVtSHJkYWxaRmtlUlM5S21w?=
 =?utf-8?B?UGo1aDJhV0VSWVJ0eERHMW1ZQ0cwbFBwU21XemtmVG9HZndySjlyN3hTL1ZZ?=
 =?utf-8?B?cnJ6MlNNU2lES3FTc1YvaG16QkN2R1R2WXpNMkxwcm8rV2xBQU15dVdBRVZJ?=
 =?utf-8?B?b09zU0NKQ0FRaXduVlVHVkdpYUYxZHY4bllDd3ZNcmR3emVsNTZQSkhoeXFX?=
 =?utf-8?B?OGZxZ25vdkl5R2tDeDN3dz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(1800799021)(38070700015)(921017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bzI5SlJtalU5MFYvTlU2Rk5pQXkrZmd5cFY5VTNuVytlOTFXRkloRWxkeDkv?=
 =?utf-8?B?MEYxZmlNZHNhR3c2Q0lmR1NpL0k1QVY3TkxaZnBhcXFCSVRJeVhmSGZFSVRv?=
 =?utf-8?B?bE9qc0tSejZtS2NyWFhwSFU1RkNpZEM1LzVHNVEwSk82Y1ZqWGZRTzdubUFT?=
 =?utf-8?B?OXVWaE1qQzdPZk8zTnpUdWtUV2hCTElqYVVpaG12azdzd2tRTlMva2lhQ3Rl?=
 =?utf-8?B?V2szdkw3a1dYWEIyTzI3SXJhSDJuQ0xQcEEvQXBkYVB5ZnNGYWtxcUdZZDdD?=
 =?utf-8?B?N3IvS3dQOWlvYmVPSWFKR0IvNCtJaUREdSs1S0tTRWZDR0VKTkExZ1BkU0Ji?=
 =?utf-8?B?TFpxRnE1eTJ5U05id0hvQkJKMWUzSlA3VTNLZXBLd2kzQ3NwL1FBbEV5aHk4?=
 =?utf-8?B?UENIbHcreDZMU2JhcDg3NFZvbUhXN1hLTEk0am93ZzZORUlEbFZ3WHZNSEFw?=
 =?utf-8?B?OUV4MTlpSDExUWJ3MERwZ2NsMU5xUzF2bEJQVmpETHFWL2IrZVVxVS9CVmxF?=
 =?utf-8?B?TjJxS2RuTG1ZNktIT0VibzRvRmNhd0kzMjZPTGN1VzdQRXkvZmJOVDg5TTNQ?=
 =?utf-8?B?SkdnM1FwM2JFTUx6UFhtdkkyWmhrSHR3WjdrQTVWS0pnQXFxSCtxWG9ETXJV?=
 =?utf-8?B?dk93UXNpZkdNT2FSWnF1OWVPN0hwdGs3aXVHdzlpSGJJMU5SV0UzYnNKeWRq?=
 =?utf-8?B?TTRsbDBiTndpbXNEZll1RVlJR29wVzJyWjI3cUNxK2I2RUJyMGM5VnpNWjVN?=
 =?utf-8?B?Y0dzMS95YkVrNVVTUXAxSExSL2FFazhLOHlhbmNMVjhxZUVJUGpWT05ETUcy?=
 =?utf-8?B?SGdTOFFGSE9lbXFaRDlFeDdpSHdYc3NsRHBxMGlncS9veVBEb1l3eWdhUjQw?=
 =?utf-8?B?eWp3amp0YWVQOXNDSjlldm8vMThHeUtVcFJYWkIwSDBkRWpKblZ0M0dodjFa?=
 =?utf-8?B?eVMrb0Jad0xaQUtSZzdkTWp1Mkh0NEdNR3krRExGcE9zdE1BL0loUlErWTlL?=
 =?utf-8?B?dlRpcys0MG5uaTc5SC8zazNjaGVPanA4UXdhUml2QXBuRjhBMDR2T2NhK2Rv?=
 =?utf-8?B?OVFmZVJINE50QzdtNERZR2NJQ0Q0YWR1VE02WXNUaHYvVms2RzAvRVl4QU5u?=
 =?utf-8?B?eXZRZDhQZlloWkNlZjZ4Y2QvZVdyN3UxTFY0OHFPcVN2WGVLSzl1MXFRVmlN?=
 =?utf-8?B?TGZyWHNSUVNwRUFObmY0dVZ3REFtM25CaTZmL1ZMN3Rwd1RnUEUwWEIxT2R6?=
 =?utf-8?B?Y21hcmNmcThUN3FHQ05SSllCWmlGVW5HS0V6SmJWZ2NlbkdPbmhweFFlQkhk?=
 =?utf-8?B?d01PNmlkWHNvbGFNSGZyRjh3cnBOdzJTVEJzd29Uc3AyTnhzSG8yU1JVQVAv?=
 =?utf-8?B?TFFWL1N3blgzbnlyTSs1Z2ZIczhqb3hyZEpsRlhRTEdxenhka2oxQ0t0QVhV?=
 =?utf-8?B?aU5CazA3akFINDBJa0xmL2M2QzJTMEJ1aTJBSG90bVpzQkRiNWJwV09nTnJh?=
 =?utf-8?B?VENhY0wwNFdzRHVVYXpvYkZpL1pEdVQ4UXNra0hmeHBSc2E5MVNqd05pQ1Er?=
 =?utf-8?B?NGovNTlkSmJrS05sVGVNQVUzY2ozaEg1aE12enljMU5sWGVpK3g2RGx5VUla?=
 =?utf-8?B?cDh3cjJDQSsvVEd6eUYvdDh5YTNvZ3lTRFFhRldENDlnc0ZmbTQyTDJVODlH?=
 =?utf-8?B?VmQ3eDViUXhTZ20zMlJld2lLNXJubHFrOWFYb2UxRm5kajl2TlE2UDZaVkxK?=
 =?utf-8?B?aC9VMEZzajhEMUJjK08xVkI3RXNuRDRPU1VQY2Z5NGNRWVR5NDFnWjE4bWh3?=
 =?utf-8?B?Z1NRbFI1Q1FnOVlUbkRXUUIzYWtJbXJnaFQ3M0hKUXU3NkhEb0x6QjdSMnpi?=
 =?utf-8?B?WjNwKzdlNG9OQ0hIb2Rna1lXSkNidGV3RS9OdW1WY3ZUSWlsYkN0WVlHYTNk?=
 =?utf-8?B?cTZTb2s1VytVeWFjVmR3RmJHOUJtYlBBWm4zL293UDBVUGlGR1hLYlNUWnBo?=
 =?utf-8?B?ei95N2VwYmxhYllzOTlLeGdpZ2I1MlJ0SVpoVmFmTlp6M2FaYVZQWXZkeU9t?=
 =?utf-8?B?ZjdoUmI2UXpvZUVQUXRqdlBBdnRZU0NDWlYySTloRGxUVkRoV2x5ZHAvdGZG?=
 =?utf-8?Q?PsNc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f2cfecee-8831-462a-8cac-08dc8eb1df37
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2024 09:42:58.4988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 77kxzmIkNHEtizBiE9uHTYQJf8NNxCtmYadaddD1ugSm1mAsQeFbSkSCUgdCQ5kjk4iCxKlTv8jGwm3NgSk8Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10143

PiBTdWJqZWN0OiBbUEFUQ0ggdjQgMC82XSBmaXJtd2FyZTogc3VwcG9ydCBpLk1YOTUgU0NNSSBC
Qk0vTUlTQw0KPiBFeHRlbnN0aW9uDQoNCkFueSBjb21tZW50cyBmb3IgdGhlIGRyaXZlciBhbmQg
ZG9jIHBhcnQ/DQoNClRoYW5rcywNClBlbmcuDQoNCj4gDQo+IGkuTVg5NSBTeXN0ZW0gTWFuYWdl
ciBGaXJtd2FyZSBzb3VyY2U6IGh0dHBzOi8vZ2l0aHViLmNvbS9ueHAtDQo+IGlteC9pbXgtc20g
VG8gZ2VuZXJhdGUgaHRtbCBmcm9tIHRoZSByZXBvOiBtYWtlIGh0bWwNCj4gDQo+IGkuTVg5NSBT
eXN0ZW0gTWFuYWdlciBGaXJtd2FyZSBzdXBwb3J0IHZlbmRvciBleHRlbnNpb24gcHJvdG9jb2w6
DQo+IC0gQmF0dGVyeSBCYWNrZWQgTW9kdWxlKEJCTSkgUHJvdG9jb2wNCj4gICBUaGlzIHByb3Rv
Y29sIGlzIGludGVuZGVkIHByb3ZpZGUgYWNjZXNzIHRvIHRoZSBiYXR0ZXJ5LWJhY2tlZCBtb2R1
bGUuDQo+ICAgVGhpcyBjb250YWlucyBwZXJzaXN0ZW50IHN0b3JhZ2UgKEdQUiksIGFuIFJUQywg
YW5kIHRoZSBPTi9PRkYNCj4gYnV0dG9uLg0KPiAgIFRoZSBwcm90b2NvbCBjYW4gYWxzbyBwcm92
aWRlIGFjY2VzcyB0byBzaW1pbGFyIGZ1bmN0aW9ucyBpbXBsZW1lbnRlZA0KPiB2aWENCj4gICBl
eHRlcm5hbCBib2FyZCBjb21wb25lbnRzLiBUaGUgQkJNIHByb3RvY29sIHByb3ZpZGVzIGZ1bmN0
aW9ucyB0bzoNCj4gDQo+ICAgLSBEZXNjcmliZSB0aGUgcHJvdG9jb2wgdmVyc2lvbi4NCj4gICAt
IERpc2NvdmVyIGltcGxlbWVudGF0aW9uIGF0dHJpYnV0ZXMuDQo+ICAgLSBSZWFkL3dyaXRlIEdQ
Ug0KPiAgIC0gRGlzY292ZXIgdGhlIFJUQ3MgYXZhaWxhYmxlIGluIHRoZSBzeXN0ZW0uDQo+ICAg
LSBSZWFkL3dyaXRlIHRoZSBSVEMgdGltZSBpbiBzZWNvbmRzIGFuZCB0aWNrcw0KPiAgIC0gU2V0
IGFuIGFsYXJtIChwZXIgTE0pIGluIHNlY29uZHMNCj4gICAtIEdldCBub3RpZmljYXRpb25zIG9u
IFJUQyB1cGRhdGUsIGFsYXJtLCBvciByb2xsb3Zlci4NCj4gICAtIEdldCBub3RpZmljYXRpb24g
b24gT04vT0ZGIGJ1dHRvbiBhY3Rpdml0eS4NCj4gDQo+IC0gTUlTQyBQcm90b2NvbCBmb3IgbWlz
YyBzZXR0aW5ncw0KPiAgIFRoaXMgaW5jbHVkZXMgY29udHJvbHMgdGhhdCBhcmUgbWlzYyBzZXR0
aW5ncy9hY3Rpb25zIHRoYXQgbXVzdCBiZQ0KPiBleHBvc2VkDQo+ICAgZnJvbSB0aGUgU00gdG8g
YWdlbnRzLiBUaGV5IGFyZSBkZXZpY2Ugc3BlY2lmaWMgYW5kIGFyZSB1c3VhbGx5IGRlZmluZQ0K
PiB0bw0KPiAgIGFjY2VzcyBiaXQgZmllbGRzIGluIHZhcmlvdXMgbWl4IGJsb2NrIGNvbnRyb2wg
bW9kdWxlcywgSU9NVVhfR1BSLA0KPiBhbmQgb3RoZXINCj4gICBHUFIvQ1NSIG93bmVkIGJ5IHRo
ZSBTTS4NCj4gICBUaGlzIHByb3RvY29sIHN1cHBvcnRzIHRoZSBmb2xsb3dpbmcgZnVuY3Rpb25z
Og0KPiANCj4gICAtIERlc2NyaWJlIHRoZSBwcm90b2NvbCB2ZXJzaW9uLg0KPiAgIC0gRGlzY292
ZXIgaW1wbGVtZW50YXRpb24gYXR0cmlidXRlcy4NCj4gICAtIFNldC9HZXQgYSBjb250cm9sLg0K
PiAgIC0gSW5pdGlhdGUgYW4gYWN0aW9uIG9uIGEgY29udHJvbC4NCj4gICAtIE9idGFpbiBwbGF0
Zm9ybSAoaS5lLiBTTSkgYnVpbGQgaW5mb3JtYXRpb24uDQo+ICAgLSBPYnRhaW4gUk9NIHBhc3Nv
dmVyIGRhdGEuDQo+ICAgLSBSZWFkIGJvb3Qvc2h1dGRvd24vcmVzZXQgaW5mb3JtYXRpb24gZm9y
IHRoZSBMTSBvciB0aGUgc3lzdGVtLg0KPiANCj4gVGhpcyBwYXRjaHNldCBpcyB0byBzdXBwb3J0
IHRoZSB0d28gcHJvdG9jb2xzIGFuZCB1c2VycyB0aGF0IHVzZSB0aGUNCj4gcHJvdG9jb2xzLiBU
aGUgdXBwZXIgcHJvdG9jb2wgaW5mb21hdGlvbiBpcyBhbHNvIGluY2x1ZGVkIGluIHBhdGNoIDEN
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiBUbzog
Sm9uYXRoYW4gQ29yYmV0IDxjb3JiZXRAbHduLm5ldD4NCj4gVG86IFNoYXduIEd1byA8c2hhd25n
dW9Aa2VybmVsLm9yZz4NCj4gVG86IFNhc2NoYSBIYXVlciA8cy5oYXVlckBwZW5ndXRyb25peC5k
ZT4NCj4gVG86IFBlbmd1dHJvbml4IEtlcm5lbCBUZWFtIDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+
DQo+IFRvOiBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+DQo+IFRvOiBSb2IgSGVy
cmluZyA8cm9iaEBrZXJuZWwub3JnPg0KPiBUbzogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6aytk
dEBrZXJuZWwub3JnPg0KPiBUbzogQ29ub3IgRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPg0K
PiBUbzogU3VkZWVwIEhvbGxhIDxzdWRlZXAuaG9sbGFAYXJtLmNvbT4NCj4gVG86IENyaXN0aWFu
IE1hcnVzc2kgPGNyaXN0aWFuLm1hcnVzc2lAYXJtLmNvbT4NCj4gVG86IFBlbmcgRmFuIDxwZW5n
LmZhbkBueHAuY29tPg0KPiBDYzogbGludXgtZG9jQHZnZXIua2VybmVsLm9yZw0KPiBDYzogbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBDYzogaW14QGxpc3RzLmxpbnV4LmRldg0KPiBD
YzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IENjOiBkZXZpY2V0cmVl
QHZnZXIua2VybmVsLm9yZw0KPiANCj4gQ2hhbmdlcyBpbiB2NDoNCj4gLSBSZWJhc2VkIHRvIG5l
eHQtMjAyNDA1MjANCj4gLSBBZGRlZCB2ZW5kb3Ivc3ViLXZlbmRvciwgY3VycmVudGx5IHRoZSBz
dWItdmVuZG9yIGlzICJpLk1YOTUgRVZLIiwNCj4gICB0aGlzIG1heSBub3QgYmUgcHJvcGVyLCBJ
IHdpbGwgY2hlY2sgd2l0aCBmaXJtd2FyZSBvd25lciBvbiB0aGlzIHRvDQo+ICAgc2VlbiBhbnkg
dXBkYXRlLiBwbGVhc2Ugc3RpbGwgaGVscCByZXZpZXcgb3RoZXIgcGFydHMgb2YgdGhlIHBhdGNo
c2V0Lg0KPiAtIEFkZGVkIGNvbnN0cmFpbiB2YWx1ZSBpbiBiaW5kaW5nIGRvYywgY2hhbmdlIHRo
ZSBwcm9wZXJ0eSBuYW1lIGZyb20NCj4gICBueHAsd2FrZXVwLXNvdXJjZXMgdG8gbnhwLGN0cmwt
aWRzIHRvIG1hdGNoIGZpcm13YXJlIGRlZmluaXRpb24uDQo+IC0gUHV0IGkuTVggY29kZSB1bmRl
ciBuZXcgZGlyZWN0b3J5IGlteC8NCj4gLSBDaGFuZ2UgdGhlIG1pc2MgZXZlbnQgZnJvbSB0aHJl
ZSB0byBvbmUsIHRoZSBjb2RlIGluIHByZXZpb3VzDQo+IHBhdGNoc2V0DQo+ICAgd2FzIHdyb25n
Lg0KPiAtIExpbmsgdG8gdjM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNDA0MTItaW14
OTUtYmJtLW1pc2MtdjItDQo+IHYzLTAtNDM4MGE0MDcwOTgwQG54cC5jb20NCj4gDQo+IENoYW5n
ZXMgaW4gdjM6DQo+IC0gVXBkYXRlIGNvdmVyIGxldHRlciBhbmQgcGF0Y2ggY29tbWl0IGxvZyB0
byBpbmNsdWRlIG1vcmUNCj4gaW5mb3JtYXRpb24uDQo+IC0gQWRkIGRvY3VtZW50YXRpb24gZm9y
IEJCTSBhbmQgTUlTQyBwcm90b2NvbHMgdW5kZXINCj4gICBEb2N1bWVudGF0aW9uL2Zpcm13YXJl
LWd1aWRlL254cC4gTm90IHN1cmUgaWYgdGhpcyBpcyBhIGdvb2QgcGxhY2UuDQo+IC0gRml4IHRo
ZSBiaW5kaW5ncywgaG9wZSBJIGhhdmUgYWRkcmVzc2VkIHRoZSBpc3N1ZXMuDQo+ICAgRHJvcCBp
bXgsc2NtaS55YW1sLg0KPiAgIEFkZCBueHAsaW14OTUtc2NtaS55YW1sIGZvciBOWFAgdmVuZG9y
IHByb3RvY29sIHByb3BlcnRpZXMuDQo+ICAgQWRkIGNvbnN0cmFpbnRzLCBhZGQgbnhwIHByZWZp
eCBmb3IgTlhQIHZlbmRvciBwcm9wZXJ0aWVzLg0KPiAgIFVzZSBhbnlPZiBpbiBhcm0sc2NtaS55
YW1sIHRvIHJlZiB2ZW5kb3IgeWFtbC4NCj4gLSBVc2UgY3B1X3RvX2xlMzIgcGVyIENyaXN0aWFu
DQo+IC0gTGluayB0byB2MjogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI0MDQwNS1pbXg5
NS1iYm0tbWlzYy12Mi0NCj4gdjItMC05ZmM5MTg2ODU2YzJAbnhwLmNvbQ0KPiANCj4gQ2hhbmdl
cyBpbiB2MjoNCj4gLSBTb3JyeSBmb3IgbGF0ZSB1cGRhdGUgc2luY2UgdjEuDQo+IC0gQWRkIGEg
bmV3IHBhdGNoIDENCj4gLSBBZGRyZXNzIGlteCxzY21pLnlhbWwgaXNzdWVzDQo+IC0gQWRkcmVz
cyBjb21tZW50cyBmb3IgaW14LXNtLWJibS5jIGFuZCBpbXgtc20tbWlzYy5jDQo+IC0gSSBub3Qg
YWRkIHZlbmRvciBpZCBzaW5jZSByZWxhdGVkIHBhdGNoZXMgbm90IGxhbmRlZCBpbiBsaW51eC1u
ZXh0Lg0KPiAtIExpbmsgdG8gdjE6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNDAyMDIt
aW14OTUtYmJtLW1pc2MtdjEtMC0NCj4gM2NiNzQzMDIwOTMzQG54cC5jb20NCj4gDQo+IC0tLQ0K
PiBQZW5nIEZhbiAoNik6DQo+ICAgICAgIERvY3VtZW50YXRpb246IGZpcm13YXJlLWd1aWRlOiBh
ZGQgTlhQIGkuTVg5NSBTQ01JDQo+IGRvY3VtZW50YXRpb24NCj4gICAgICAgZHQtYmluZGluZ3M6
IGZpcm13YXJlOiBhZGQgaS5NWDk1IFNDTUkgRXh0ZW5zaW9uIHByb3RvY29sDQo+ICAgICAgIGZp
cm13YXJlOiBhcm1fc2NtaTogYWRkIGluaXRpYWwgc3VwcG9ydCBmb3IgaS5NWCBCQk0gcHJvdG9j
b2wNCj4gICAgICAgZmlybXdhcmU6IGFybV9zY21pOiBhZGQgaW5pdGlhbCBzdXBwb3J0IGZvciBp
Lk1YIE1JU0MgcHJvdG9jb2wNCj4gICAgICAgZmlybXdhcmU6IGlteDogc3VwcG9ydCBpLk1YOTUg
QkJNIG1vZHVsZQ0KPiAgICAgICBmaXJtd2FyZTogaW14OiBhZGQgaS5NWDk1IE1JU0MgZHJpdmVy
DQo+IA0KPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvZmlybXdhcmUvYXJtLHNjbWkueWFtbCAg
ICAgfCAgIDUgKy0NCj4gIC4uLi9iaW5kaW5ncy9maXJtd2FyZS9ueHAsaW14OTUtc2NtaS55YW1s
ICAgICAgICAgIHwgIDQzICsNCj4gIERvY3VtZW50YXRpb24vZmlybXdhcmUtZ3VpZGUvaW5kZXgu
cnN0ICAgICAgICAgICAgIHwgIDEwICsNCj4gIERvY3VtZW50YXRpb24vZmlybXdhcmUtZ3VpZGUv
bnhwL2lteDk1LXNjbWkucnN0ICAgIHwgODc3DQo+ICsrKysrKysrKysrKysrKysrKysrKw0KPiAg
RG9jdW1lbnRhdGlvbi9maXJtd2FyZS1ndWlkZS9ueHAvaW5kZXgucnN0ICAgICAgICAgfCAgMTAg
Kw0KPiAgZHJpdmVycy9maXJtd2FyZS9hcm1fc2NtaS9LY29uZmlnICAgICAgICAgICAgICAgICAg
fCAgIDIgKw0KPiAgZHJpdmVycy9maXJtd2FyZS9hcm1fc2NtaS9NYWtlZmlsZSAgICAgICAgICAg
ICAgICAgfCAgIDEgKw0KPiAgZHJpdmVycy9maXJtd2FyZS9hcm1fc2NtaS9pbXgvS2NvbmZpZyAg
ICAgICAgICAgICAgfCAgMjMgKw0KPiAgZHJpdmVycy9maXJtd2FyZS9hcm1fc2NtaS9pbXgvTWFr
ZWZpbGUgICAgICAgICAgICAgfCAgIDMgKw0KPiAgZHJpdmVycy9maXJtd2FyZS9hcm1fc2NtaS9p
bXgvaW14LXNtLWJibS5jICAgICAgICAgfCAzODAgKysrKysrKysrDQo+ICBkcml2ZXJzL2Zpcm13
YXJlL2FybV9zY21pL2lteC9pbXgtc20tbWlzYy5jICAgICAgICB8IDMwMyArKysrKysrDQo+ICBk
cml2ZXJzL2Zpcm13YXJlL2lteC9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICB8ICAgMiAr
DQo+ICBkcml2ZXJzL2Zpcm13YXJlL2lteC9zbS1iYm0uYyAgICAgICAgICAgICAgICAgICAgICB8
IDMxNCArKysrKysrKw0KPiAgZHJpdmVycy9maXJtd2FyZS9pbXgvc20tbWlzYy5jICAgICAgICAg
ICAgICAgICAgICAgfCAxMDggKysrDQo+ICBpbmNsdWRlL2xpbnV4L2Zpcm13YXJlL2lteC9zbS5o
ICAgICAgICAgICAgICAgICAgICB8ICAzMyArDQo+ICBpbmNsdWRlL2xpbnV4L3NjbWlfaW14X3By
b3RvY29sLmggICAgICAgICAgICAgICAgICB8ICA2NCArKw0KPiAgMTYgZmlsZXMgY2hhbmdlZCwg
MjE3NyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDog
ODFlYzJiYWQ1MGMwYzFiZDNjNjYzODlmZGEzMmE2ZjJjZjkyMjUwOA0KPiBjaGFuZ2UtaWQ6IDIw
MjQwNDA1LWlteDk1LWJibS1taXNjLXYyLWI1ZTlkMjRhZGM0Mg0KPiANCj4gQmVzdCByZWdhcmRz
LA0KPiAtLQ0KPiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCg0K

