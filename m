Return-Path: <linux-kernel+bounces-187364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B20888CD0B7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C7F281303
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC20A1422B4;
	Thu, 23 May 2024 10:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VqF5C9GO"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2068.outbound.protection.outlook.com [40.107.6.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09AC14532A;
	Thu, 23 May 2024 10:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716461561; cv=fail; b=LIxwozeG0j9uQvJd49YF+0JnBUO4CMfUX/ef4T7uaLdHLtNIKAjfuMSZTVULSO9Y7pCekbqbnmTVYFQRTuB8p0ArQPCVdV7+mHbINiYNHPDtbACTAL/c6y4HeVHc79rW7xZmgq9a/1DTvMnbx4vwpLewtn8v1bCLaRk1w1+sHgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716461561; c=relaxed/simple;
	bh=MuhBVsZUiI5VFPmv9lk7WXE1TbDKt5rB2RVcpcQVO7I=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=QPHyK6w1QKTonGASOgtomVTYerNekalVjqPXXOGvALUXS+s4GWV3Z3CkwjgPaTLPww5NQB6R5tNXzCXvlAn/nnIxDKoI/xpC0IAj7En6+yphwpPH9VrtoZ2RkfmrxSceRMJA9VwRgyr4L2WPZ6ul5wh6gu0II4Arb5B0Vi2dvVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VqF5C9GO; arc=fail smtp.client-ip=40.107.6.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tf5rA2xJssz9gORdVbWpdLPaqXgajtxYuOGtOwOdE8ZnM8MX7zvgoxXa38PqW00zY8iRNVOSCS6Dx0FF/VUPuuPRTmMWO/M6ShEVgcs+1vdhUjwD2xj7yRDK8AkBcVUVs7iIZ0wMp0NgEp5Cke0w6YS0J5eTpX3lGKSD3LcTrci4pz2PWr1POjw8QtD3Yz+aSqR5wOqPlFu6lsCMuDBzolYxqNesklztYwsJeSExI/42MP9sfZagmLeVWzQMJiSiJud+xUPiyspZYgIuqFqevDAoF9zNj2CuuorcwOWeMoScrOzPKr4RS6A0FQv/D/fnsHFe1BLnds3mjD0S3niajA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZltA1ZA8XBbyBwdEZ4b9dyfEx7WJ7IojPm5PxeAyb0=;
 b=RkJj8OFvBZQ23o/BvuHJNPhp2fEvdpnQyjczuaoQG0GvTacvf91i3pDvOnqYHMRvwIqhBNOMmOLiZqzK3mSOQK1V/V7eh2I9fWNdrgbFpa0MF6/nMr4UaevWqDrNcBjNjW2YhhftCfUtCztT5uzQtLDnTpvHAbQZzC7rRmDvMPjJHp+22m+ovgsI7ReX0hjZ/F+GmcTBcsu14nBnzAydOIx5Q2M0YxVFhxvKtF/8e0Lz6FWTaaqU+OA6R+H41VDsDmgOFfH6swlZyfy9RGlfJ4BlhfW0ajRIGvC2YZtoiN6Rg6MONpk0XUx+evOTv9Gknc6zXrGsDahM3CapQBEm8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZltA1ZA8XBbyBwdEZ4b9dyfEx7WJ7IojPm5PxeAyb0=;
 b=VqF5C9GOtXVBS4/wuZIwfnMFcsA/PP95T90L/sDfTu3FxdsfPPQkUrUaPT4A/ea94WjA0W9Afg3wTvlW47J5M+nDl2TpK04vYbE6nFJyJVG2DwZ6MTbiXyyDolwZogjsFpjMhqI5ue7bARNKvrfojleY4x0AFmBnxP2HNt+5ZMg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by AM8PR04MB7474.eurprd04.prod.outlook.com (2603:10a6:20b:1d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 10:52:37 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%4]) with mapi id 15.20.7587.035; Thu, 23 May 2024
 10:52:37 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Thu, 23 May 2024 16:19:33 +0530
Subject: [PATCH v2 2/5] dt-bindings: arm: fsl: add imx-se-fw binding doc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240523-imx-se-if-v2-2-5a6fd189a539@nxp.com>
References: <20240523-imx-se-if-v2-0-5a6fd189a539@nxp.com>
In-Reply-To: <20240523-imx-se-if-v2-0-5a6fd189a539@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Pankaj Gupta <pankaj.gupta@nxp.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716461396; l=5119;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=MuhBVsZUiI5VFPmv9lk7WXE1TbDKt5rB2RVcpcQVO7I=;
 b=w6fbQBlSTkOflp/dwQjjCb6ENBEUre9TP+QIs3bCen6ZoiCugS2nXXC+vdfMBbVtOebEXxVsQ
 w38+bL0zmojB4dlkLmptmCvEdZPLugN9fTJkoMcwquQeo2f2kBTwLD1
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SI2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::7) To AM9PR04MB8604.eurprd04.prod.outlook.com
 (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|AM8PR04MB7474:EE_
X-MS-Office365-Filtering-Correlation-Id: 6833a1db-9e41-4bc5-8508-08dc7b167565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|366007|1800799015|52116005|376005|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFJ2VllPT1liY2Y1enlxRmh1TnZyR3dtUEM4VHArdnNRdktmR3hEQUh3NUdM?=
 =?utf-8?B?QWZnaVVZSTFMdW9LMS9nc05YQXIzbXMxUGNmZ3l6di8wTEFBUVd1d1NkaXpO?=
 =?utf-8?B?VysybzN4WVE3Y1B5OVFmR3BqY1NtS0wrS2wwNGhCRDN3b0U4WXcyUGhLK2M2?=
 =?utf-8?B?T1I3MElzS0hEVUo5QmFJV2lnaS9NSUdIU0RTV3R0TkdOUWVDMkRUK3NyUzRC?=
 =?utf-8?B?ZHc1NTFsdzhVd1lFVmZQOHZtKzFFazZuN0ZZN29mNlZabDN5d0RPTm1vWWpZ?=
 =?utf-8?B?SGtuRC8yQjFuRnlGcnNkNnRuL0NqUGRlQUhhb1E4VzYzcm0rOHFmRUVmSG5M?=
 =?utf-8?B?ODd0WVJUQVZMMU1OV1VpSlFZdm1nK1dPY3pyMUFobkF0dFh0MXF2OXNTdlFa?=
 =?utf-8?B?Z2gyam5pdk44SlE1dkNIRXZJUVIxN21OT3FmVlhPblFKSmtubWxEVGVRUXpK?=
 =?utf-8?B?YzdmdW13WUgyWmUybkw0SUs5U25xeHI4MmRDQWpnRExwc1NvY1JNeXZNL29P?=
 =?utf-8?B?Z1p5STlXYnhKZ0kwb0Z1cGIyUWp4VFJBYkJTTUNGZGUzdHNRNVYzcitwNHc3?=
 =?utf-8?B?T0UxQnNyam1xc1RoS0oyY1k3ek9nNXVzdkx1YW1yYUtxc2lKdmdEOTJpeG5D?=
 =?utf-8?B?YTQ1M0dOaCtjWVFWbHlyak00VlNkUk10Ui84dlVPNzlQSWQ2Uys3dXJnRUVx?=
 =?utf-8?B?K1pHYnpFOFBzWW5hcDhiZFl5WWpNZ09NdW5vcFVLbGNjM04vWHl2eHI0Z0VC?=
 =?utf-8?B?R2hDOTJGRWRmL1JSOVJKRHZHSWc4MjRSdGF1RHRYaEQ0dll6TEg5NktOZ2RI?=
 =?utf-8?B?ZTY3Ry80cTQzSS9BUkZJYmtmQ1RLcmUyaTBlKzJlTXRuM0FTV2tNNlRRd3BB?=
 =?utf-8?B?NlNJa24wUVRHOVZEMGJMZURMdldCRUNGOXljTm9kUit5dlI1c1ZGd01ZRE9z?=
 =?utf-8?B?U0RHaHVFY2cyYWlzTDhlYjkrbVc2eHFSWmt6UUl4NFVUS0JWZldObVI1a3dO?=
 =?utf-8?B?dGlhZ0lmN1dzb2xGWFNsVEtsbitwODNwTW1NRGw3UjA0bVdWR2xvZzVLeWxI?=
 =?utf-8?B?UFY5MTdIRURvcW54MTN3UTBGOXhmb0llWTNxR3ZhMGwzZjVmUDllWEJyMGNi?=
 =?utf-8?B?blNkSDZ3b3lvMGZGK3Z4NGFZTWRVeTZNMEZzK200VExqY1ZoTmpJY2lJNzh1?=
 =?utf-8?B?M0trVU12ZWo2R1kvT1hVL2EvRDJnMzR1U1FXUjUybVpMM3BEMjFlY1ZHSzMv?=
 =?utf-8?B?WTI1czdaeUpmWjhEc2o3RU5DMkdBUHkxYkJGN29CczM5V0QwYTEwdEdlZ296?=
 =?utf-8?B?S1p0b1RUa3VGT2lTMy9rdjdiZVMvR0xZUHJja1ZnalRBcEkzYTBzdVEwRUcw?=
 =?utf-8?B?OE8ydFp6MXZsNVlqcDFzU3A0NWl0THdUY3g1Q0ZkUmNlcFRmenhSbTdVTEkx?=
 =?utf-8?B?WG5UOHZkVldUZlFOOXFFdTRVb2swRGhxQUJiNjhPODJ0WGc4SktCSWNxaWJi?=
 =?utf-8?B?VEUyYnBkbVVmVTZoTmJxVFg1Nm5kTnhoVi9KWXlPWmdyVm5zMWVSU20wUUN3?=
 =?utf-8?B?dzJWWU9BQXc0UkdPMEtWSU4rdmpMVXRTb05HdWdGbUVTcllEdTFZU1l2Wjda?=
 =?utf-8?B?YytiZlBYNm4yRThlYjZRdDB6dmw0VXc5eXl1dWl2Q0xwTW5PK21EdWZyMHBW?=
 =?utf-8?B?UXhHSVhUN0tJdnlmMGc2RkRoZ1FiYU14eWd4MEhwKy9Yb2FnNnNnTDhiN0NI?=
 =?utf-8?Q?+ie5xpH3h9i16PbH68=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(52116005)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGZrRFQwaFlDNHA0Vm9zelBYV3MyUTdQRFYzVU5pdXFyOFEySTFQaFlwV1Zh?=
 =?utf-8?B?OTFaZEVNWnRZOFR6dktoS0NPTE1nYXVuaHU3Y25OMWlMSlVZUUhmK25VdUFX?=
 =?utf-8?B?TFJaYlBacm1oSStwWDNoanlXcUlNWmFwSzdCRWRPbkZJOXR6K0tOUUlmS3hu?=
 =?utf-8?B?eTRWS3IyZys2MFpPTndkY0Vjc2Q3NVZBaXZhaEpyM0Mxb1VBcXJDV1U3ejF1?=
 =?utf-8?B?WU01TC9oZDZqOUFMTDlCRC9Qb3oxVVZuank4aXlmYU54eEs0VTBGL1J2VHJ5?=
 =?utf-8?B?Z2NGS2lXb0hvaURMOWRGUlJoem9vMkhxNWpRZWFjUnI4eElCdXdwcy8xRWJ5?=
 =?utf-8?B?QThxQUNSUEI5aHAzT0didUR4Z0lhc0swQjJlaEx4QU1sb3dqOGZyNFRmZ2lT?=
 =?utf-8?B?TTFKdG96aHdSbHFBR1NzNVhTNDhJd1l0YWUwS21qaU42aHBFU2VKREh1V3Vw?=
 =?utf-8?B?TW9mWDdHRklOZlZUM1JHRlBPanVSQmk1UWlKNzZHd3FPdzExVUh0VWh2Vmtv?=
 =?utf-8?B?QkdzcnIyaEdxQ2pTRFhMYkU2NDJON2R6Y2h3NDlUd0IrNDlpY3IrNUtXdnpm?=
 =?utf-8?B?UW1VbjRqWW94RkV6S1FqYm5KRndCemQ0c3RrajZ3SmNSd1dWdW9qSFMrWStq?=
 =?utf-8?B?eEFGK0tGd0pXalllT3Uvai9USnlWV080dWFUTE83Y2lOL3pWRkZJUlBTREVV?=
 =?utf-8?B?Q3BKamloMjVQOVk3ckswdWVXdDB4RXcwNHNIcWRzZm1KajErUjhyM21Md2hZ?=
 =?utf-8?B?YzhtU2RFNExpb1FTSmhGbXhaYU5Db2h5QURHdCtMTlBpMzNUSmF4ZXgrMU1B?=
 =?utf-8?B?RDRuYTRCUXFqWFdzMjR3cFJuaFR5UGpJZm52alBsc3N3UWxoa1RaQ3lpQUJP?=
 =?utf-8?B?NERxOW1vcUYrUUxhMWVMY0pOVFg3RXBlUHpiSGZ2VFkzUkRJejlIblVrVFpM?=
 =?utf-8?B?S1RJdE1CWlVPd1VQN0FXb2NOQ25uWXVCYXUwQmxRM0t2VThjWFFybnZZeDhP?=
 =?utf-8?B?VUthMDd2KzRJdlBlUXVmQUNuTXZTRFNmekR5d1U4emllcXZWVW9xYURtcmRI?=
 =?utf-8?B?dUZIYlJUcEViYXk2eU1KRU5pRVRZd2lTbkZoRFo1anVrQnNnbXd6OTdicWlG?=
 =?utf-8?B?a0p3T25CWFQyQzFCM0k5S2NiVjJKOUZFSUhPS1hRWG82cTd1eVhuYjBWcWFu?=
 =?utf-8?B?aHpRaXl2dUd5clhpbzlSNzJLcWRraWptR1JXTm1DV1BWMlhnSWo1M08xRTMr?=
 =?utf-8?B?Vy9HM3N0Q0M4R09Ld29pSTVkZW1VeE5NR3AwYnpVU0JrSTlNdXRSVm4xK1J6?=
 =?utf-8?B?V0svTzlhZUdNYzhaVld2K3Z3NU1QT0JXazRWK29lbVQ5NDRiRVNjd3JtZXYx?=
 =?utf-8?B?R0V0b3drOW5oQ25OVnBlbDQ5Umg3d01xRVhPbFU5ZmY4MU5Rcm5tN2N5QW5Z?=
 =?utf-8?B?ZGxJYVlNSlN5eUNwRlhUeHZwbjNtT0FwR0JNMzExOHBaTlJrbFFjVHVLTFk5?=
 =?utf-8?B?VTZmS2xMZ0h2NzQ3ZDdxNlNPbHJRSEhOcWRKalVOSFJNMWljdzJTSThNT3R6?=
 =?utf-8?B?ZUpsWk9ROHpieEppNllSNjFCTU55L2xld2RqYWJiRzdpSUo1OWpPNG8yOEJC?=
 =?utf-8?B?aDVxaWM2QnNhWUhIVmtNZHlEelhXTmx3UW9HeExGRmNlSnZhRHNldXdNczM2?=
 =?utf-8?B?NmlJY0liY0hVekxEYjZmRVJWUjJMUXRQR3hja3hzV3d6RXQ0M3EyMVZ1RSs0?=
 =?utf-8?B?SzBINm8zZGppcGdSUC8zK1hhWVUrMTMvYU05RDJKOENkV1MvTmNaZDhqU0xx?=
 =?utf-8?B?WTB2Wk85QVcwQjNhcmhYVm9ERnRHWHduakJGNU9MTUw1amRxU3ZLM1YvVVdW?=
 =?utf-8?B?eENWcmVxMWk0OUZRVTJ6NFV4TnhSajBhcklvK0FxcER3ck1hWlAya0ZWeUpF?=
 =?utf-8?B?UE5uWjhqbWtwMzAwbWlHSjZtZ2g5c2x3Q1FUOVp0WXUzZ3lROExqKzhZYXkz?=
 =?utf-8?B?K2tlZ1dMby9JeXJmSFFMYks0aytWYnpxTG16N3VLcXZHdVlndHlnK2VrMkk1?=
 =?utf-8?B?NkdQbzh4WnVyNUJtNzFFbUpDTmFTWTI3S1dhVWVUK1N1QmM5RjdKdFFDMFFv?=
 =?utf-8?Q?T8kGOMgeiLTeMt4h3n0kMKo/+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6833a1db-9e41-4bc5-8508-08dc7b167565
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 10:52:37.0689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2DMusY5Vva3/iwmDYXbwNbiuMSru6hAmlGjR7d7lN6j4Je7jGeEcHn7V5lp/54Mu/CYJPdbWycc0vqupxFSbOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7474

The NXP security hardware IP(s) like: i.MX EdgeLock Enclave, V2X etc.,
creates an embedded secure enclave within the SoC boundary to enable
features like:
- HSM
- SHE
- V2X

Secure-Enclave(s) communication interface are typically via message
unit, i.e., based on mailbox linux kernel driver. This driver enables
communication ensuring well defined message sequence protocol between
Application Core and enclave's firmware.

Driver configures multiple misc-device on the MU, for multiple
user-space applications, to be able to communicate over single MU.

It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 .../devicetree/bindings/firmware/fsl,imx-se.yaml   | 154 +++++++++++++++++++++
 1 file changed, 154 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
new file mode 100644
index 000000000000..b27f84db6f91
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
@@ -0,0 +1,154 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/fsl,imx-se.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX HW Secure Enclave(s) EdgeLock Enclave
+
+maintainers:
+  - Pankaj Gupta <pankaj.gupta@nxp.com>
+
+description: |
+  NXP's SoC may contain one or multiple embedded secure-enclave HW
+  IP(s) like i.MX EdgeLock Enclave, V2X etc. These NXP's HW IP(s)
+  enables features like
+    - Hardware Security Module (HSM),
+    - Security Hardware Extension (SHE), and
+    - Vehicular to Anything (V2X)
+
+  Communication interface to the secure-enclaves is based on the
+  messaging unit(s).
+
+properties:
+  $nodename:
+    pattern: "^[0-9a-z]*-if@[0-9a-f]+$"
+
+  compatible:
+    enum:
+      - fsl,imx8ulp-ele
+      - fsl,imx93-ele
+      - fsl,imx95-ele
+
+  reg:
+    maxItems: 1
+    description: Identifier of the communication interface to secure-enclave.
+
+  mboxes:
+    description: contain a list of phandles to mailboxes.
+    items:
+      - description: Specify the mailbox used to send message to se firmware
+      - description: Specify the mailbox used to receive message from se firmware
+
+  mbox-names:
+    items:
+      - const: tx
+      - const: rx
+      - const: txdb
+      - const: rxdb
+    minItems: 2
+
+  memory-region:
+    description: contains a list of phandles to reserved external memory.
+    items:
+      - description: It is used by secure-enclave firmware. It is an optional
+          property based on compatible and identifier to communication interface.
+          (see bindings/reserved-memory/reserved-memory.txt)
+
+  sram:
+    description: contains a list of phandles to sram.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - description: Phandle to the device SRAM. It is an optional property
+          based on compatible and identifier to communication interface.
+
+allOf:
+  # memory-region
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8ulp-ele
+              - fsl,imx93-ele
+    then:
+      required:
+        - memory-region
+    else:
+      not:
+        required:
+          - memory-region
+
+  # sram
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8ulp-ele
+    then:
+      required:
+        - sram
+    else:
+      not:
+        required:
+          - sram
+
+required:
+  - compatible
+  - reg
+  - mboxes
+  - mbox-names
+
+additionalProperties: false
+
+examples:
+  - |
+    firmware {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      ele-if@0 {
+        compatible = "fsl,imx8ulp-ele";
+        reg = <0x0>;
+        mboxes = <&s4muap 0 0>, <&s4muap 1 0>;
+        mbox-names = "tx", "rx";
+        sram = <&sram0>;
+        memory-region = <&ele_reserved>;
+      };
+    };
+  - |
+    firmware {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      ele-if@0 {
+        compatible = "fsl,imx93-ele";
+        reg = <0x0>;
+        mboxes = <&s4muap 0 0>, <&s4muap 1 0>;
+        mbox-names = "tx", "rx";
+        memory-region = <&ele_reserved>;
+      };
+    };
+  - |
+    firmware {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      v2x-if@0 {
+        compatible = "fsl,imx95-v2x";
+        reg = <0x0>;
+        mboxes = <&v2x_mu 0 0>, <&v2x_mu 1 0>;
+        mbox-names = "tx", "rx";
+      };
+      v2x-if@1 {
+        compatible = "fsl,imx95-v2x";
+        reg = <0x1>;
+        mboxes = <&v2x_mu6 0 0>, <&v2x_mu6 1 0>;
+        mbox-names = "txdb", "rxdb";
+      };
+      v2x-if@2 {
+        compatible = "fsl,imx95-v2x";
+        reg = <0x2>;
+        mboxes = <&v2x_mu7 0 0>, <&v2x_mu7 1 0>;
+        mbox-names = "tx", "rx";
+      };
+    };
+...

-- 
2.34.1


