Return-Path: <linux-kernel+bounces-363383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D10699C197
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1C76281C10
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4619614D2B3;
	Mon, 14 Oct 2024 07:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="WZoDY4gj"
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010029.outbound.protection.outlook.com [52.101.229.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACE514AD2E;
	Mon, 14 Oct 2024 07:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728891567; cv=fail; b=AQ87ISRcjOTyfJqSonLwjrSjO/qhtggbB4tmROH1LmkW1Sq0kPJMJJrfZkfwit3cwUrN31mNXZyNiXpPeRPnQlvMn0wYCOiEUy/yoYeJ4gD1noxawYIAifSeRACfwCkoopvBkfNifHDMtP/8SG2YiEobIvisDOlDBCfV71vgU8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728891567; c=relaxed/simple;
	bh=u0gzshcqet8TOVODlxuWmBP/RjHez8DZu62O2tV+KHI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P2Ebc4tWisl6YBvTRD+4+bPOhdfW2lJzf63/VS4buICY+TMNAOntMpA9bYDCuy3efpktLXDq95x+XlZ5IB46/ZbDcLnB5CLBKG5IN0Djs32fbEOzGDxdjM6kz9yWC4G1e4fhIMxMlbcwNfYkteYOENfFVvoiyJ2lHo7s2cgSx3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=WZoDY4gj; arc=fail smtp.client-ip=52.101.229.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OBN2jLl4+UK9BrCTpI3XsouiAXBttNOcjZxSG2oQkm877aN37YQ31P/WA2DaXgcpsuw92YJCM9Ou+RVknto8xT0QrWxtYkTlBtLaUMRjTfcY5h5prMc4dRe+n3usv7EMIFQzRejpPKrfkR/zoXFS7DxyTAHrKMisFElrP4ZE9tRHXW3PdfeFDDRrCT4iCY7WFZhixXrM47ULpeTLp4MK5t9yL1LRwDZGl5o0BnCsYN3JuXpxTwNclUn1LAUybhbRKkAe6Y/A7kOtIKdiIcrtxhm72ecGol9xD5Yu/Uc7eCT8qXSz+XeobTxuaLbCfRB7DkBRoPccEsOUgogp66F3Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0gzshcqet8TOVODlxuWmBP/RjHez8DZu62O2tV+KHI=;
 b=hByTE4+pCirdKKU1dhP2hXdPl5ruV7At5OBlUkKMsVr42HIHvKFcbrAD8I35YgneFoAHQeq0FJ2jv1gMj29Zcvlc3RvWyGSLR+8a63gEfQhLVUICYT/TOlqEHSPUOsfO1AV1nH3+XN9wpKnfXTic2p1wX+U9rFYbjvUXxj1Wx1Ac1OLjE3ukZh6CetS/RGmYja5M04qvVYn44W19gxPHP+WhE085YR4/CjMfzev1pDCQYLNxhuXoE9UfZQmTli27VIz40Wc1H3QgmFQ9rBWqwgA3x8xS382HinrbTlnu2/i6ktyXqLv2dHYEHhmCW2OiVBRimcHdIEzGRnWFZ6boSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0gzshcqet8TOVODlxuWmBP/RjHez8DZu62O2tV+KHI=;
 b=WZoDY4gjzVb3E1c5SfBtBenS6Bt+LoTgRePw88qb64KL8LibkZi+Gm3oJxOHzObP/5XlRe6lTtOzv1iu776FTTMNF2vYq2P+bqmGD5AmEnQZlz0o7x3FSf2sxhJXoj34fz+Tdv6ggJjvnSSDeTp9MkuZfnglFaI1WpoJxzme2cc=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSZPR01MB8482.jpnprd01.prod.outlook.com (2603:1096:604:183::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21; Mon, 14 Oct
 2024 07:39:17 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%3]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 07:39:16 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Liu Ying <victor.liu@nxp.com>, Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "andrzej.hajda@intel.com"
	<andrzej.hajda@intel.com>, "neil.armstrong@linaro.org"
	<neil.armstrong@linaro.org>, "rfoss@kernel.org" <rfoss@kernel.org>,
	laurent.pinchart <laurent.pinchart@ideasonboard.com>, "jonas@kwiboo.se"
	<jonas@kwiboo.se>, "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
	"airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"mripard@kernel.org" <mripard@kernel.org>, "tzimmermann@suse.de"
	<tzimmermann@suse.de>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "quic_bjorande@quicinc.com" <quic_bjorande@quicinc.com>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>, "arnd@arndb.de"
	<arnd@arndb.de>, "nfraprado@collabora.com" <nfraprado@collabora.com>,
	"o.rempel@pengutronix.de" <o.rempel@pengutronix.de>, "y.moog@phytec.de"
	<y.moog@phytec.de>, "marex@denx.de" <marex@denx.de>,
	"isaac.scott@ideasonboard.com" <isaac.scott@ideasonboard.com>
Subject: RE: [PATCH v2 5/9] dt-bindings: display: bridge: Add ITE IT6263 LVDS
 to HDMI converter
Thread-Topic: [PATCH v2 5/9] dt-bindings: display: bridge: Add ITE IT6263 LVDS
 to HDMI converter
Thread-Index: AQHbHHmcAQrmzLsoUU25rfXdj34z0LKCyOiAgAAMWYCAAoXDgIAAYU0AgAAhkXA=
Date: Mon, 14 Oct 2024 07:39:16 +0000
Message-ID:
 <TY3PR01MB11346530A53C8085561713B6086442@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20241012073543.1388069-1-victor.liu@nxp.com>
 <20241012073543.1388069-6-victor.liu@nxp.com>
 <4a7rwguypyaspgr5akpxgw4c45gph4h3lx6nkjv3znn32cldrk@k7qskts7ws73>
 <07b47f70-5dab-4813-97fa-388a0c0f42e9@nxp.com>
 <dvcdy32dig3w3r3a7eib576zaumsoxw4xb5iw6u6b2rds3zaov@lvdevbyl6skf>
 <90e0c4ac-1636-4936-ba40-2f7693bc6b32@nxp.com>
In-Reply-To: <90e0c4ac-1636-4936-ba40-2f7693bc6b32@nxp.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSZPR01MB8482:EE_
x-ms-office365-filtering-correlation-id: f40ec66d-a5b3-453a-f3f2-08dcec234e93
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a1B4Yy9zb0F4cStQWlRvcThRTWZEV09TdzVWb280Q3VHREErQzhVWStqc0xa?=
 =?utf-8?B?OUNsbGNNcmYzbGdPY0tvVU1WVitIQmxTQnZJZlYrQjR2WFUycytzays1ZVYz?=
 =?utf-8?B?YUlmQ21keEFraTlwZjkrL1UrU24zM01ualRKRnlpbkc1WTlLRkJmQis1L1hW?=
 =?utf-8?B?QmZHdVpORGxOZ200SDhoWVpzZllOWjNNZFU2NW5FZ3RnR2c4UjN2ZWtLQnJD?=
 =?utf-8?B?SU5DQ1ZXWDhvU0lua09qQ2RhektYY3VQRnhDaWVtcVpjSjBMVFpLclZRRFNh?=
 =?utf-8?B?MzZDQ0p5NUk2em1PMFZqbGpSZXdlc2l2cXBwK1RCNUNNVUV1RUdZS21Cazhk?=
 =?utf-8?B?c0RqSnVQWjlJZFN2SVpuVk5sTWVpUnM3ajdQTlIrbmpreUVueXJiWTliNFFJ?=
 =?utf-8?B?TEVKa0hWTC8xaG1yOG9idDZ5Tm8yaDdUZk5mYXY1cjVqTkdPMk9USDFJekFs?=
 =?utf-8?B?ZnV3OVJQZVRKZGtDR0thV2ZEWHdBZ0NQdGRPZk5UdVFGa3NlZ0FyQWVFWlI2?=
 =?utf-8?B?SFMzZEhkVHE1NEpjQXhYRDErSE1UbzB4SVl0NHJ6VEtVMWVHeVFiNWQ1VzRV?=
 =?utf-8?B?Y3pIRzdOb00vM2pUS0RTUXNYQ1IyaUcwL0pMS2hPZ1ZFYWM4Sk9ScjEvZzdL?=
 =?utf-8?B?RGlFS1FZdkpVS3Y0TEl5NVArTXMybFpmWXg0cDBPRGMwQ2lINTNoaEo2d29C?=
 =?utf-8?B?SHM1dlVmZkJwNnpvbVlYR1JaQTVWZHMxSmlQRXNybXpaRDgwaUZSdmhYV3pC?=
 =?utf-8?B?R0oxN2pZSGxuSUc5dldTT3hjWmZ0amZybjBMSFp1Mkx1UW5YQStWYk1WcnZ2?=
 =?utf-8?B?OGNDYWN0bXVkSTBmaDc2REkxeExqR2tDckFDSTY4VVRUeXFHQnVUSHI1YVho?=
 =?utf-8?B?dnRxMzVGMGlieUhqQnlXTnV5aTh4LzZPNDJpaVlsSG11WjIzY1M3b1dCMkk2?=
 =?utf-8?B?U0hldWtwaTdKSUZrUXhDMmxVVjJ6NnVkZlBsaWxSQlRYOXJuQTc0QXJ3Y0NE?=
 =?utf-8?B?MGRQWFpSRHdqdGJuQkE5R2d1c09ja29rZTZuR05YZkEvSThQaTJ3RjRaTjNk?=
 =?utf-8?B?emdVaDFtdWh6WktCNThxSjlLOGV6djNhMVJiR1RVMk5mVlZoaDRuZElqb1BV?=
 =?utf-8?B?OUZWb051YkJOL3J4a2tMTFZqalBLWW1SUllJMEhEM3dnemhUMkZiK1MwZEFk?=
 =?utf-8?B?d2lZc0c0OSs4UkZqbW9OdWQzclJaWDdYd3g4K08zUU01ZFVoQzN6ZUExNmsw?=
 =?utf-8?B?NEFuMjQrUW4zeWx3bm4wSE03ZklZSEhwSmgzUFovNFFJWGdMM1NybmdNQ0Qx?=
 =?utf-8?B?LzZsSjFBWWdMZGVhdlRWaE1oeVFHSktRc0VlQmNidGRqcGtEYzl1cHZZRlNQ?=
 =?utf-8?B?LzEra2ZTRlNsMjJ3NHY2N25xc2lFRTYrT3puZWswSkNlQnlHNlFrMHRsclNI?=
 =?utf-8?B?R3RMY3J1OFYrTFdmdkJOa2F6NnJxLzdIS2N5Z3FPamt3TW1nVTM1MFlIbmsw?=
 =?utf-8?B?elY5UFV2QXF6SFRBVWRLZThmbHBzWWI0NnBUdXE5WWtNcGduSDNaelE4N2VT?=
 =?utf-8?B?VDliaXhKejFBeWhCb3RYOVlmM0h0ekVTckt2RHRVdXlmZlFvN3ltRTBGZlFQ?=
 =?utf-8?B?dmhMbkt5TU1KNDExMWRNN0pxRmY0c0RaU21jaHFTclNCYXUxekU5WmhmdXJJ?=
 =?utf-8?B?RUVZZWFFSmo1TWRxN2xkVGUwSzhJcTlQWGVHNThZT1REVEEzc294N253PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U0cxeXAxWDJ0WkJIeFVOT2ZKWnYvOEpTeEtpd2FXdG9sZE5pZndlMDJmU3Fl?=
 =?utf-8?B?WDlqYVRWT3NEZURNZHJYOFlSQlVrMHhucEhhdzZHeVdnbno0TFVoWnFobytn?=
 =?utf-8?B?NEdGV3BNVCtlNTJ3MTFHb2xEZURFaGFVYnd6dTJEc0x4a1p6L01DOTRwWXlI?=
 =?utf-8?B?NUc0TzUyNmVmdjg2dTg4akp5V0VnU25wNTE4dkhabG5DeUJFNjBrcU92Qjlm?=
 =?utf-8?B?YWExSkhZNy9hRERQUHlZV2dUOXFyc2JhSktPNUkwZWUwQnZoajZPMjdoZDBk?=
 =?utf-8?B?SkhsZ3NlNTQ1dlluNVRkNngvQWJzcllNczU2T1VQelluc20xNDBiSHJ2Ujhp?=
 =?utf-8?B?Z1ZtQzhULzU4YjV0aU8wRjVYNnhhbU9nMXNVUU15dXV3R09PU05Oa1lxQ2tX?=
 =?utf-8?B?SFdmbjRNQWQ2VkthRTAyYm9YU25nUmp0ZzB1MGJQQkJ6aEJDUEQ2NFFkRm40?=
 =?utf-8?B?dVpRcFJ3ZHQ5S285R3AxOVJkVWhycTFlaDVnd0xmbmZURWJZS0tIZFhLQkFW?=
 =?utf-8?B?TXVDMDh3NUhhVFY3Q2swRnY2cllZc0hmRnVDUVBtUk9IdnF3V0JZNWlNRDhH?=
 =?utf-8?B?bExtczBkRDdLQ1dsMk44bzJFRHArakdDNWJHekhQdDZBS3czZlpsYlRIWHla?=
 =?utf-8?B?blBiQ1kvdDZaVElKQlpwYnBUeWROV2Noa3l0Y0RSWnhTQlg4VlZFcEFPZGJX?=
 =?utf-8?B?NGoyNDdycUE3a3VNOWVDZnp1cXNTazZDL3dhNE9tcVpnVFQ0bmswZG5GWW5H?=
 =?utf-8?B?MjlXY1d0OEFnSFc3SWF3dG13K21PbjU2YlRyTUxOMHp6UERUbG14SjRBQ1JL?=
 =?utf-8?B?Q0cwKytjWGhXaEtCUmNiU2Vja1BVVkR2TUN6SEk4T0c3UmVmaCtuZnU3VDZC?=
 =?utf-8?B?WE91Z2FuM0VjMU5mZzRiU1cvOFEvUmRtb3ByR25LaTNGL3MxenRJV2NCTFpF?=
 =?utf-8?B?aE16TE5KL3lNcnFpMmp4NGI3UDhER3Z2ZWQ2OGhTOE1RWGlTb3RwVTBOT1FS?=
 =?utf-8?B?UVp1ZlNkeDdXWWx3eU9YZ0hmZDdRRUxaSFVNd3Jjd0dVaDZ0d1FVcC9QTkNM?=
 =?utf-8?B?Qjg0SVZSRER0Tm5xZkV3a0hzbXprekVhK1NPb2JoVW5EWTBwSVJNR2tFTXZB?=
 =?utf-8?B?a0xteTI3SG1BY1R3THJ5cVFMRi9PTytFd2t3aUN5MGErUS9HZHVJS1lGdmhD?=
 =?utf-8?B?WVhtbjdHZkFTbFkvWjAxS2RXcU91YldXK3l4TG1SRjFSK1ZxWWNHd3grbVhH?=
 =?utf-8?B?Sld0QnJieGxadjRvVTZWTEVYWjE0N0dtcTUyT20vMm8wSmJ2alJic2pVa0N3?=
 =?utf-8?B?c0txWWw0SXM4WjFYamlUbEtjYUlTTHBTKzBnSVZjaEdJVDVBYldCSHpJYXJn?=
 =?utf-8?B?Z0ZHTWU4c25HQjZzNnNpZ3o2RnZBaExUeHBVL1R4RTlqR1lWaCt0NmVLUnQ1?=
 =?utf-8?B?RGtDMkFZQUFmYXBONzg1TXZtanNVRVhaUVd4SW1ZbkI3SUNSWVVqbGh2VDdQ?=
 =?utf-8?B?NFZwSU1YamRNaFFIWVJSV0MyaGhwYmxYNHMwdkVBWkdnVklYTHVCOWU2MFNZ?=
 =?utf-8?B?bFpjUDd4bjMySU1SWmdDQnU1bWUvWVhxUnJWM2xxbENheXpCSlovOC9oaGZu?=
 =?utf-8?B?OGJvM1QrMnVWUTJ6WmRDSTRNSER1UVBKWjY1TDBWOXBEd29vMlZrRlBWMHVQ?=
 =?utf-8?B?RHdBWVFNSzk5ZTNJZ3dWUWcxditUMEd0R2FCd1YxSnpUeUxvdHpQckJtaDF4?=
 =?utf-8?B?b0dURnZSTWx5ZnBTQ2ZYUjRPZWs0OVJ4bTdVbjFCMU9iVGdSOXlIWDE5QUMw?=
 =?utf-8?B?OXd0K2paRUp5SlpOd1NSTkNwTEFPNW15RWJhY2lFMktHU2RMVGRrOEJHaXc3?=
 =?utf-8?B?ZEJQdHdRWGsxN2w3VEtjcGczOEZ5N045ZEZ5K2s4d0JqRllkRUtJOXhpa1k1?=
 =?utf-8?B?Sm1RNHZTOUFHNlF2RlRKMjJXMjR3bWcybXRQeWR2UFhqa3I4azNXU0xyckJw?=
 =?utf-8?B?ZnlNVFdLak9LOUhESkRwYnlaN2Jmem5FOUhwOFJoZVZpallOS0FVZ2xTNVd5?=
 =?utf-8?B?UXBQN1FVTnRocFJtdkdjbmJKTW9IZk1zMURJbzVwSldCOG9wVnJpTm5ZWVlt?=
 =?utf-8?B?Tmh0aDF1c0pLYzEwdXF1UWFTc3ZqYktIT0IzZjYvcHpCRzNMV3RrV1NDbmNn?=
 =?utf-8?B?bHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f40ec66d-a5b3-453a-f3f2-08dcec234e93
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 07:39:16.3801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UqDWBX/Yhc1MBfwDsysSLbKZm8IIsE9u7zQJpMarYgzBhAZA5BAHlx2YgTL9fPEso+HlfoQX+5iQQBt4b/oWJ8LO+TOcO/wcAe0e8bMNkFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8482

SGkgTGl1IGFuZCBEbWl0cnksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogTGl1IFlpbmcgPHZpY3Rvci5saXVAbnhwLmNvbT4NCj4gU2VudDogTW9uZGF5LCBPY3RvYmVy
IDE0LCAyMDI0IDY6MzQgQU0NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiA1LzldIGR0LWJpbmRp
bmdzOiBkaXNwbGF5OiBicmlkZ2U6IEFkZCBJVEUgSVQ2MjYzIExWRFMgdG8gSERNSSBjb252ZXJ0
ZXINCj4gDQo+IE9uIDEwLzE0LzIwMjQsIERtaXRyeSBCYXJ5c2hrb3Ygd3JvdGU6DQo+ID4gT24g
U2F0LCBPY3QgMTIsIDIwMjQgYXQgMDU6MTQ6MTNQTSArMDgwMCwgTGl1IFlpbmcgd3JvdGU6DQo+
ID4+IE9uIDEwLzEyLzIwMjQsIERtaXRyeSBCYXJ5c2hrb3Ygd3JvdGU6DQo+ID4+PiBPbiBTYXQs
IE9jdCAxMiwgMjAyNCBhdCAwMzozNTozOVBNICswODAwLCBMaXUgWWluZyB3cm90ZToNCj4gPj4+
PiBEb2N1bWVudCBJVEUgSVQ2MjYzIExWRFMgdG8gSERNSSBjb252ZXJ0ZXIuDQo+ID4+Pj4NCj4g
Pj4+PiBQcm9kdWN0IGxpbms6DQo+ID4+Pj4gaHR0cHM6Ly93d3cuaXRlLmNvbS50dy9lbi9wcm9k
dWN0L2NhdGUxL0lUNjI2Mw0KPiA+Pj4+DQo+ID4+Pj4gU2lnbmVkLW9mZi1ieTogTGl1IFlpbmcg
PHZpY3Rvci5saXVAbnhwLmNvbT4NCj4gPj4+PiAtLS0NCj4gPj4+PiB2MjoNCj4gPj4+PiAqIERv
Y3VtZW50IG51bWJlciBvZiBMVkRTIGxpbmsgZGF0YSBsYW5lcy4gIChCaWp1KQ0KPiA+Pj4+ICog
U2ltcGxpZnkgcG9ydHMgcHJvcGVydHkgYnkgZHJvcHBpbmcgIm9uZU9mIi4gIChSb2IpDQo+ID4+
Pj4NCj4gPj4+PiAgLi4uL2JpbmRpbmdzL2Rpc3BsYXkvYnJpZGdlL2l0ZSxpdDYyNjMueWFtbCAg
IHwgMjc2ICsrKysrKysrKysrKysrKysrKw0KPiA+Pj4+ICAxIGZpbGUgY2hhbmdlZCwgMjc2IGlu
c2VydGlvbnMoKykNCj4gPj4+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4+Pj4gRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvYnJpZGdlL2l0ZSxpdDYyNjMueWFtbA0K
PiA+Pj4+DQo+ID4+Pj4gZGlmZiAtLWdpdA0KPiA+Pj4+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2Rpc3BsYXkvYnJpZGdlL2l0ZSxpdDYyNjMueWFtbA0KPiA+Pj4+IGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvYnJpZGdlL2l0ZSxpdDYyNjMu
eWFtbA0KPiA+Pj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4+Pj4gaW5kZXggMDAwMDAwMDAw
MDAwLi5iYzJiYmVjMDc2MjMNCj4gPj4+PiAtLS0gL2Rldi9udWxsDQo+ID4+Pj4gKysrIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvYnJpZGdlL2l0ZSxpdDYyNjMu
eQ0KPiA+Pj4+ICsrKyBhbWwNCj4gPj4+PiBAQCAtMCwwICsxLDI3NiBAQA0KPiA+Pj4+ICsjIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkgJVlB
TUwNCj4gPj4+PiArMS4yDQo+ID4+Pj4gKy0tLQ0KPiA+Pj4+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0
cmVlLm9yZy9zY2hlbWFzL2Rpc3BsYXkvYnJpZGdlL2l0ZSxpdDYyNjMueWFtbCMNCj4gPj4+PiAr
JHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+
ID4+Pj4gKw0KPiA+Pj4+ICt0aXRsZTogSVRFIElUNjI2MyBMVkRTIHRvIEhETUkgY29udmVydGVy
DQo+ID4+Pj4gKw0KPiA+Pj4+ICttYWludGFpbmVyczoNCj4gPj4+PiArICAtIExpdSBZaW5nIDx2
aWN0b3IubGl1QG54cC5jb20+DQo+ID4+Pj4gKw0KPiA+Pj4+ICtkZXNjcmlwdGlvbjogfA0KPiA+
Pj4+ICsgIFRoZSBJVDYyNjMgaXMgYSBoaWdoLXBlcmZvcm1hbmNlIHNpbmdsZS1jaGlwIERlLVNT
QyhEZS1TcHJlYWQNCj4gPj4+PiArU3BlY3RydW0pIExWRFMNCj4gPj4+PiArICB0byBIRE1JIGNv
bnZlcnRlci4gIENvbWJpbmVkIHdpdGggTFZEUyByZWNlaXZlciBhbmQgSERNSSAxLjRhDQo+ID4+
Pj4gK3RyYW5zbWl0dGVyLA0KPiA+Pj4+ICsgIHRoZSBJVDYyNjMgc3VwcG9ydHMgTFZEUyBpbnB1
dCBhbmQgSERNSSAxLjQgb3V0cHV0IGJ5IGNvbnZlcnNpb24gZnVuY3Rpb24uDQo+ID4+Pj4gKyAg
VGhlIGJ1aWx0LWluIExWRFMgcmVjZWl2ZXIgY2FuIHN1cHBvcnQgc2luZ2xlLWxpbmsgYW5kIGR1
YWwtbGluaw0KPiA+Pj4+ICtMVkRTIGlucHV0cywNCj4gPj4+PiArICBhbmQgdGhlIGJ1aWx0LWlu
IEhETUkgdHJhbnNtaXR0ZXIgaXMgZnVsbHkgY29tcGxpYW50IHdpdGggSERNSQ0KPiA+Pj4+ICsx
LjRhLzNELCBIRENQDQo+ID4+Pj4gKyAgMS4yIGFuZCBiYWNrd2FyZCBjb21wYXRpYmxlIHdpdGgg
RFZJIDEuMCBzcGVjaWZpY2F0aW9uLg0KPiA+Pj4+ICsNCj4gPj4+PiArICBUaGUgSVQ2MjYzIGFs
c28gZW5jb2RlcyBhbmQgdHJhbnNtaXRzIHVwIHRvIDggY2hhbm5lbHMgb2YgSTJTDQo+ID4+Pj4g
KyBkaWdpdGFsIGF1ZGlvLCAgd2l0aCBzYW1wbGluZyByYXRlIHVwIHRvIDE5MktIeiBhbmQgc2Ft
cGxlIHNpemUNCj4gPj4+PiArIHVwIHRvIDI0IGJpdHMuIEluIGFkZGl0aW9uLCAgYW4gUy9QRElG
IGlucHV0IHBvcnQgdGFrZXMgaW4gY29tcHJlc3NlZCBhdWRpbyBvZiB1cCB0byAxOTJLSHoNCj4g
ZnJhbWUgcmF0ZS4NCj4gPj4+PiArDQo+ID4+Pj4gKyAgVGhlIG5ld2x5IHN1cHBvcnRlZCBIaWdo
LUJpdCBSYXRlKEhCUikgYXVkaW8gYnkgSERNSQ0KPiA+Pj4+ICsgc3BlY2lmaWNhdGlvbnMgdjEu
MyBpcyAgcHJvdmlkZWQgYnkgdGhlIElUNjI2MyBpbiB0d28gaW50ZXJmYWNlczoNCj4gPj4+PiAr
IHRoZSBmb3VyIEkyUyBpbnB1dCBwb3J0cyBvciB0aGUgIFMvUERJRiBpbnB1dCBwb3J0LiAgV2l0
aCBib3RoDQo+ID4+Pj4gKyBpbnRlcmZhY2VzIHRoZSBoaWdoZXN0IHBvc3NpYmxlIEhCUiBmcmFt
ZSByYXRlICBpcyBzdXBwb3J0ZWQgYXQgdXAgdG8gNzY4S0h6Lg0KPiA+Pj4+ICsNCj4gPj4+PiAr
cHJvcGVydGllczoNCj4gPj4+DQo+ID4+PiBObyBMVkRTIGRhdGEtbWFwcGluZyBzdXBwb3J0Pw0K
PiA+Pg0KPiA+PiBJdCBpcyBlbm91Z2ggdG8gZG9jdW1lbnQgbnVtYmVyIG9mIExWRFMgbGluayBk
YXRhIGxhbmVzIGJlY2F1c2UgT1MNCj4gPj4gc2hvdWxkIGJlIGFibGUgdG8gZGV0ZXJtaW5lIHRo
ZSBkYXRhLW1hcHBpbmcgYnkgbG9va2luZyBhdCB0aGUgbnVtYmVyDQo+ID4+IGFuZCB0aGUgZGF0
YS1tYXBwaW5nIGNhcGFiaWxpdHkgb2YgdGhlIG90aGVyIHNpZGUgb2YgdGhlIExWRFMgbGluay4N
Cj4gPg0KPiA+IEZyb20gd2hhdCBJIGNhbiBzZWUsIGRhdGEtbWFwcGluZyBpcyBzcGVjaWZpZWQg
b24gdGhlIGNvbnN1bWVyIHNpbmsNCj4gPiBzaWRlIG9mIHRoZSBMVkRTIGxpbmsuIFRoaXMgbWVh
bnMgaXQgc2hvdWxkIGdvIHRvIHRoZSBicmlkZ2UncyBkZXZpY2Ugbm9kZS4NCj4gDQo+IFRoZW4s
IEkgd29uJ3QgZGVmaW5lIGRhdGEtbGFuZXMsIGJlY2F1c2UgZGF0YS1tYXBwaW5nIGltcGxpZXMg
aXQsIGUuZy4sIGplaWRhLTI0IGltcGxpZXMgZGF0YSBsYW5lcw0KPiAwLzEvMi8zLCBzZWUgbHZk
cy1kYXRhLW1hcHBpbmcueWFtbC4NCj4gDQo+IFBsZWFzZSBsZXQgbWUga25vdyB3aGljaCBvbmUg
eW91IHByZWZlci4NCg0KQXNzdW1lIGEgdG9wIGxldmVsIHVzZSBjYXNlIHdoZXJlIGEgdXNlciBj
aGFuZ2VzIHRoZSBmb3JtYXQgZnJvbSBKRURBSSB0byBWRVNBIHVzaW5nIE9uIHNjcmVlbiANCmRp
c3BsYXkgb3IgbW9kZXRlc3QoaWYgc29tZSBvbmUgYWRkcyBzdXBwb3J0IGZvciBsdmRzLW1hcHBp
bmcpIHRoZW4gc2V0dGluZyBvZiB0aGUgbHZkcyBkYXRhIG1hcHBpbmcNCnNob3VsZCBiZSBkeW5h
bWljLg0KDQpNYXliZSBmb3IgaW5pdGlhbCB2ZXJzaW9uIGhhcmRjb2RlIHdpdGggSkVEQUkgb3Ig
VkVTQSBhcyBkZWZhdWx0IGFuZCBwcm92aWRlIGEgd2F5IHRvIG92ZXJyaWRlDQp0aGUgaG9zdCBk
cml2ZXIgYW5kIGJyaWRnZSB3aXRoIHJlcXVlc3RlZCBsdmRzLWRhdGEgbWFwcGluZyBkeW5hbWlj
YWxseSBsYXRlcj8/DQoNCkNoZWVycywNCkJpanUNCg==

