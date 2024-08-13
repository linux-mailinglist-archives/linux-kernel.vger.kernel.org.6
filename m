Return-Path: <linux-kernel+bounces-284099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E1A94FCE2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096191F22EF4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 04:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F69E13AA2E;
	Tue, 13 Aug 2024 04:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XzN7lAjs"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2097649658;
	Tue, 13 Aug 2024 04:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723523758; cv=fail; b=mVdScIRNYtpflvCx8qmrQ4NMSWnYDGhrdUrHE8EXRmq6LgrlbU1ZJ1p5dfv3jRcTmtcQ6CobqI1PE8gfaUb0X4RyY36PiVE5mJhfpslw/+t5/ynDICwV/djFZjJoCIM1pusCC7fRdJsgB/TO6sJb93VUXwK26hLh5BxJrzH5l+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723523758; c=relaxed/simple;
	bh=YsCVGi2xLSOi/kR+JYnICx2+6DdcUk/FyLqi5HaFz0o=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=t6cWoeAkVibfumAZal+xzaSSRJKIU72lpLicjkESb9NG20OZ4z88WCzx+e3PAirUPDjED172pUpfHXJjr46H9H8Rtr2MVpkK1F/fIEhi2MRbDNVs5GlBSYwqUIQ4XwOrS6LKJTKuTlxmlZ6O6VBggP6YYE0arMwdx2Br2pnXb50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XzN7lAjs; arc=fail smtp.client-ip=40.107.22.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJNwxnpkLcPdFeG4hWIwcVUhmFhXrAYkHep3PyKeJ/xWxQVAB/tOLsBIqUq+dGWar43Q64jslFHi1cJmcCbP13+6nBj65NAzeiGcKmZGo0gwxnONr3T5GXZdmReFXFR6KosqHkiIff6YpIetOygxF5yxqFN5MjNfwovGvS3ZGbPxN/8Zz33xFexv/jQPCM92dRPvP9Cc3SsH4oE3WV+dLhy8pj5fYYoRr5AnexVUMyGLqWqbucx7O10q+aABtIXOCN//GANmN+sPi6rTLeKH00G/jrBLDwz0lOF53XfSAU2aslzF3AiLW+2TaM9HoHa0GnAM8M+QJSieUR93GVtb+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLsBPDw9P5J+NFUtxzRtJEQ/8MMosfjYts9hYryxXNs=;
 b=PdpkXO8Xff5NKN4r8m1ruaVLGPIgIDMy4HEK0d/p5EwScsLzSRgrrKfbocMJaj8jUShiVB02NgvenGmyC9iZNC8V1RBcvRWHaJ9emG8NDLwuiXSTUHwGPsZ9p7jHFKXOhqGu3715IF43cHKLdgWPd6iaV51CvFp738ACIirSbtF6U0Sc/Aj95/WeuiGW0nyGHIx+exC4F8XIy5SNnTJBji4tfD5R1+zWJ2jm7eOTfOtumWKkAmQtMQZwiLSPPTFfPbgcJ1tKNwfNsVFJWhR+42Tpa+kheno7KzZd2Szx2nokbRuHEGVxmSRSEkexKcYqQmTPl0MBm/D0R6lmWns11w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLsBPDw9P5J+NFUtxzRtJEQ/8MMosfjYts9hYryxXNs=;
 b=XzN7lAjsjfnQaoimVr04yD9pB4VSUDEDS06AiH1AnQZPxtBt2E6qbKudtAierh2OLAyQijt8kXZFOSxCFLi0elPP+vKHUmhzrcJuYMVALAR5r5tnEugwARpR+ajM+ZSezvpj2+0ix996APUV3U352NLfpGZKZpAVML6LptIYSrmClPqHbWQXADX+OFMYf48FW7sahk3HORIrT7xum/p0DinOzJ6CDcVYx8CykYMnM8/ztclB9O5fWce4Xj3EOcH5fxQGKk+wT5IZ65hflhk52Fpo3fC185OyPEasFpG4jWQu5JC4CLH6Qlhw/0foeVoXJw+yjcZtEs9QH7blPxyKyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB10066.eurprd04.prod.outlook.com (2603:10a6:10:4c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 04:35:54 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 04:35:54 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 13 Aug 2024 00:35:07 -0400
Subject: [PATCH 12/17] arm64: dts: imx8mp-venice: add vddl and vana for
 sensor@10
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-imx_warning-v1-12-3494426aea09@nxp.com>
References: <20240813-imx_warning-v1-0-3494426aea09@nxp.com>
In-Reply-To: <20240813-imx_warning-v1-0-3494426aea09@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux@ew.tq-group.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723523705; l=3799;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=YsCVGi2xLSOi/kR+JYnICx2+6DdcUk/FyLqi5HaFz0o=;
 b=2a3f50PgvTKfXvmQ5jm3erslqp/xzmWF+fqedZqEv10JhyVAEeWErDhPUI4vK3W2I7wYKQAAA
 5Eofj7wx/t3Ds8jmotr5egepxM3ESjveuEBzprt6/DWMSlWrRnOXSVc
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:217::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB10066:EE_
X-MS-Office365-Filtering-Correlation-Id: 06038c2b-f70d-4c0b-bc11-08dcbb516ae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akFiaHBiazZ3VGRkcjRBdFovRzlPZW5kcXdHbDVFQm5zYkMyNWJwYXNUWmdR?=
 =?utf-8?B?ZkJRZFlpblhicDZyMU01NTlCSExRYVJDang5aHZQank4QXg3SENpL2VCamhN?=
 =?utf-8?B?UWt4aEIyNVhmS2xON242QUxWdUQveVNIRmlrQXNjU1JTenRVdDFrVEZNZWlu?=
 =?utf-8?B?aFo4cUZkUm5jbU00b1NWZjVmY3RtUWFJblZCTW01WGhZODN5SG5iUkFZQW55?=
 =?utf-8?B?WkJZMTRIdnJjMk1nLzMzeGFycGtXMU9VY1BMZG1tejBqdHp0OHNRTGptZEtn?=
 =?utf-8?B?YmhJWVRwY0pTVFBORTM3WmdOUXE3cTBqOFRRcFFodkEyQ3RLZWNZeW9KWitl?=
 =?utf-8?B?b05lY1REKzRoT01ZcEQ4cTdxbUFkcldjVTMxb3Ava1dvRHZGQVA1dC8xQXFr?=
 =?utf-8?B?NDNnTVNIL3NrTnoxajdqR3JQYUVUQ2xTaUtNZE1MdWdqS080TXpqSm00REZL?=
 =?utf-8?B?U1krM3NLc1d2VTQ3RmFUblVIRDhyaStyYzZpOVZ3SkNVY25UZHExRU5MWjRM?=
 =?utf-8?B?UFpzWS9td3JwRzNJM1VCSUpScG5wLzhLNERkWHZ2MzBJR3BqZTNWVFpjcXpp?=
 =?utf-8?B?N2xOY2ZUeUI1b292YVR2UHR0dTJENUJNUTVvWFBOTVhvakxyKzFZNlNoTE4r?=
 =?utf-8?B?aXBaY3gydFdaYlRnSDNtOTBkb2VZTS9PdFJDZnhOYWVMSE0ybzBBNnJYUzQr?=
 =?utf-8?B?TlBNemFTSkl6NGNtQUpScnBkQ050OS9GRVlobGROZEtPM2NzUzZZM3NnNzJW?=
 =?utf-8?B?NCtWTWxCYnI3TWlHczVSQkpXL3VrSjgwcEV5cERSMzRXbGJwbms1VkJVblFG?=
 =?utf-8?B?QVZjQTVtbGt4TlVoeUJSWGRPZUdMYldFZzc2aEpzSzVTTHFCaUpQQmV2Mm1n?=
 =?utf-8?B?enVQRVJTbkIvWnFqTW14MjNleEVvckpFQ3RhWW9LNnR0QkZaR0VTWlVRMzRU?=
 =?utf-8?B?TkdYVGxqK211cE1yK0g1OGRLVm50eUJhMEFHS3JkMnVHbEhJalRqdnVsZzdB?=
 =?utf-8?B?dHFoVDE2WUV0ZFh3WVppdVVlSVNHcjYzS25PZGplaXV4NDNjM0ZlUys5SGNm?=
 =?utf-8?B?V2g5QjdZK0ZxT0R0bVNzZGljOGNmaFRNVWZSUUwwc2hxa2FsdlpHUXhKTjZ3?=
 =?utf-8?B?NXlIdzRxRElzOHI0bWFCWGxMMHlULzZnVzM2Rk10alpKUzJnV2NCd0RROVB1?=
 =?utf-8?B?UjZwTG96NkdvenQvNER5dU83OGtrbCtCcUQ2NUxTODR4aFkxSXQvblZIbldR?=
 =?utf-8?B?S3gxbkRxK1dLdE9ud3RLTTRWRitDdktCQXdYV0EySGZyMkpnb2QxTFZkYjdZ?=
 =?utf-8?B?YTJKQ21rM3V5bEN1UThBRFN0V1o5U2NLSEJKTmx0cVF0K0k0KzBaaUxlLzFu?=
 =?utf-8?B?MC83K21IS2VBaDN3WjBlU1lFVkhQN0MzbjFWelRIQ1lGdS9rMlpBWEs5a1Ez?=
 =?utf-8?B?OVIxc2JvUW9yK3J4a2I2bDYvS3BPYmxVQlVKYTAzWWs1OTFOdmo2NmNIRFRI?=
 =?utf-8?B?dlI0WHEzb242SDJ5OTB3OHZzMGthZG5Ocm5jckU5ejFJeU1BSDcyY25GcjBF?=
 =?utf-8?B?V0lLTjZMc2N4UFdQejRqcHlJTDdvZnYxNzJGTDJTQ2lJSHRLMFJxelB2dS9y?=
 =?utf-8?B?Y2MxdUtXdWcvTWhWMXcyTlZIV01rVGg3Z3p4dHVpQ0MrOVYzYmQvSHVaSng0?=
 =?utf-8?B?UzEvTXJ4T2Y0cnpYbzZDNDFjakQ5bjZTckZmZFFCZlV0NnF4TWt6MjE4MUhq?=
 =?utf-8?B?OGxIQndUbnc2T3BNRElaRGJuMzRBUjgvTGVIMFVWbGJuTjZHc0tTeXEzUDlE?=
 =?utf-8?B?ZzB6eXZJQmJ2YmdzYU1WUnN5QTZXUXlZRW50c2g3SGlUOFdHMXR0cThRU05B?=
 =?utf-8?B?ZlcwclZoaFBDcDBaM2RKUGtxbVo0U3c1TUpwZVZrNHRSSlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MERFSEJlbFdqVWR1U0cycXd0U0NwWUQrajFTVjFHYU14NFVhRVhhWGlrZEw3?=
 =?utf-8?B?dS9aOUdHNmNKc1pCL3RnbDZJZVVpTDhpNFNlWTlYMDVTU3Y0emtrWW00WHBN?=
 =?utf-8?B?R2EraTB4Z24xOHUrdnFSV2JGUnZ5WmhzQU5SenJKTS8xaTdXekNrTm5Dekl2?=
 =?utf-8?B?b243M3FFTm56QkdKWXlpSElsUTdXb1NKVmgxN0dEVEI4a2kvNEdOV0RpRVhY?=
 =?utf-8?B?Vjg4NmRRZytVVCszRjdiaTl3c2luZitJVmFhS3R1TkpBbGQ2OStXeGRXMGVk?=
 =?utf-8?B?Mk5Kd1JLYXNwd2N3WDVBSi9IanFSbFhuamdKZUVPUkpQbkczVTgyVGpmNmJr?=
 =?utf-8?B?SWVuNDkzdGt5MVJ5USsvMWd0ZkNDRkl0QnZTMWdaK3dUM3RWc3NaQ2haSSs2?=
 =?utf-8?B?WUcvNU5ZN0MxaThBTDNrc2Q2bzIzdnoyS2tiSFNzNHJxQ3FuMkp2T3Zybkxs?=
 =?utf-8?B?SDZpSVZlbWZaN1Nyd09QVGVYZFNQY0hKcjFLclg2dGpudDlTdEtmbXRLdG40?=
 =?utf-8?B?OUhWQ000dFo3MUVna1hhdUZ3Qkp1dnZyNXVMWHoyYUNEaG9iUy9BcjNGeDk4?=
 =?utf-8?B?Nk5HV3VKUWNZNThJcUhUdXNQS054QkVmSDhSZTlRdVdQVUJXcDk1c1p5d3ZB?=
 =?utf-8?B?ZWYxOGFsNmJjd1NiSlZwcXlKYndEeFBBV3VVUys3Wm0zMEEwYjNBWUlkbmZM?=
 =?utf-8?B?Ukp0RGh6czdYbktBT1hKMVJzM0NJbmgzRE8wTDc2ZEc0b2lNNWpRY21mU1FU?=
 =?utf-8?B?QXFRRkJMcTJuanVjZ254MGs3MVhrbjdyRERkbnYrRW5XOTdzYVA3Nkg2UFcv?=
 =?utf-8?B?YmlMN2dPeTNzbzRkS0xLYlBOenZQcE9scy9WU0Rnd0szcXV4RW1KdTBxMVMv?=
 =?utf-8?B?WmYxeHpUMG9QUm1tdm54OE1PNmdWa0lkZncyMDI4TEt1VXlqZW11VDRtWU9R?=
 =?utf-8?B?VnZXdG5qMzBOS2pkRllQLzU5RWd5eGdmdFk5NTlOc3NseDJEUGVLY29JREJy?=
 =?utf-8?B?cis3YzN0NGtRT3JoZ1loVWZmelRmbXZKaDY5T3ZsdjFXMnhSTDJOcEFIYnlF?=
 =?utf-8?B?MU1tWXdERHk3cTE2MDZlRWx2UmRjd0JKc2liQlMrY2Vsd2lNOUJqUm1WVEFw?=
 =?utf-8?B?QlhpVTBaTERvblA0aGIwYWVzRTVMeXVJNDI3NC8zNmhGUlR3MUxQd1FCczZ3?=
 =?utf-8?B?RlJaSndaSzE5RGxDNnVoRHJBaWZtR3A5MEtpN09YbEdlaENBTFdIaW5Qclox?=
 =?utf-8?B?ZFByaEIxV2pHZWNEVTNITTNDVlpKc0E0ZHRNTnhsQXBvTHluNHdBUnBNczJ2?=
 =?utf-8?B?cC85WVR3c2FqODhSMm9SajRtWTc5bnJUcCtUcXp4Wmx3emRjbXlXazgyT2Va?=
 =?utf-8?B?akdFbi84bDI4MzduVUFMTXZmcGN4ZHUrby82dk12amlUaHZvK0hZZHluM3Ri?=
 =?utf-8?B?eE9Md0JiMngzSm9oT0hXeFNWRWk1ZVVaSlphMjJvRlBvbnlESktzRUZ1S2p4?=
 =?utf-8?B?dGw1Vm5USzUxVHRnUEFjRlJEVEdqeWJIZGlzN0NOZmV4aGc2L0R5MlBGWGY2?=
 =?utf-8?B?cU1PeWhYYUpoblhoQnlRRmo5TW9ZWmZYUFcvSHRJT1BYZytnWUZ6NU5PSHUr?=
 =?utf-8?B?amIxSmtxSWUxWXVQTGdQSElKQ3Y4b1JOSzdMRHJmcGVodlB3TllLN2RNOVk2?=
 =?utf-8?B?Z21qdDVYTnNHS3lRRGpMSk5kenhLSGlOMVdpM3BkVkoxL0Y4cS9QQURaNVRh?=
 =?utf-8?B?cFpRODZhUzYxU1NDc3FnSDR4QVdPYTVVRnFoUmNDdjlDMk42VVYvam85OGhK?=
 =?utf-8?B?TFJzb3dvMnBRNEcrR212S0FXa1o1K0J6aWFLTGFKdDM4eUh5dzcvWnB6MmhR?=
 =?utf-8?B?aG91ZjZ6Ri9yMUM5M3ZxcDFNTndyN0xGNnJaSFVZRklhc2dWblBZaXMvc0xz?=
 =?utf-8?B?cDFrRFVHQnl4SzVFV3JWM0RHUWoxVG9LQUd1ZWRTL2NqdW5KaGtKUVRuTTRC?=
 =?utf-8?B?SFRUN2NSa2Q5emtiWEZaVEQ1ajdSRERMU2VWUWFlYkc4UGVVUjFqVWVwRERF?=
 =?utf-8?B?OTNqRlNBSWRWRFFVSkRlQTRkOWE2eGRTT2ZKWFlWMzRmaWxCOVhTdG9OY0lt?=
 =?utf-8?Q?mbzBFCwdSh6jCBNATYKv1JMWt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06038c2b-f70d-4c0b-bc11-08dcbb516ae1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 04:35:54.0858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FrDHBxdU4XHFmwhugVQeUB4CYlBwH7PgpvMi+C4ZRD6Ww46tfyRKS6X4EB/iZiqXbFy5hwS9YetOwlw3Zlwtjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10066

Add vddl and vana for sensor@10 to fix below warning:
arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-imx219.dtb:
	sensor@10: 'VANA-supply' is a required property

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../dts/freescale/imx8mm-venice-gw72xx-0x-imx219.dtso    | 16 ++++++++++++++++
 .../dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dtso    | 16 ++++++++++++++++
 .../boot/dts/freescale/imx8mp-venice-gw74xx-imx219.dtso  | 16 ++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-imx219.dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-imx219.dtso
index 4eaf8aabcbfff..c09aa80d2ba23 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-imx219.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-imx219.dtso
@@ -13,6 +13,20 @@
 &{/} {
 	compatible = "gw,imx8mm-gw72xx-0x", "fsl,imx8mm";
 
+	reg_vana: regulator-2p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "2P8V";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+	};
+
+	reg_vddl: regulator-1p2v {
+		compatible = "regulator-fixed";
+		regulator-name = "1P2V";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+	};
+
 	reg_cam: regulator-cam {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_reg_cam>;
@@ -45,6 +59,8 @@ imx219: sensor@10 {
 		reg = <0x10>;
 		clocks = <&cam24m>;
 		VDIG-supply = <&reg_cam>;
+		VANA-supply = <&reg_vana>;
+		VDDL-supply = <&reg_vddl>;
 
 		port {
 			/* MIPI CSI-2 bus endpoint */
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dtso
index f3ece4b7fbbde..cfc014eb038d6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dtso
@@ -13,6 +13,20 @@
 &{/} {
 	compatible = "gw,imx8mm-gw73xx-0x", "fsl,imx8mm";
 
+	reg_vana: regulator-2p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "2P8V";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+	};
+
+	reg_vddl: regulator-1p2v {
+		compatible = "regulator-fixed";
+		regulator-name = "1P2V";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+	};
+
 	reg_cam: regulator-cam {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_reg_cam>;
@@ -45,6 +59,8 @@ imx219: sensor@10 {
 		reg = <0x10>;
 		clocks = <&cam24m>;
 		VDIG-supply = <&reg_cam>;
+		VANA-supply = <&reg_vana>;
+		VDDL-supply = <&reg_vddl>;
 
 		port {
 			/* MIPI CSI-2 bus endpoint */
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx-imx219.dtso b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx-imx219.dtso
index eb673a947484a..7d9fcdee58a7f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx-imx219.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx-imx219.dtso
@@ -11,6 +11,20 @@
 /plugin/;
 
 &{/} {
+	reg_vana: regulator-2p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "2P8V";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+	};
+
+	reg_vddl: regulator-1p2v {
+		compatible = "regulator-fixed";
+		regulator-name = "1P2V";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+	};
+
 	reg_cam: regulator-cam {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_reg_cam>;
@@ -39,6 +53,8 @@ imx219: sensor@10 {
 		reg = <0x10>;
 		clocks = <&cam24m>;
 		VDIG-supply = <&reg_cam>;
+		VANA-supply = <&reg_vana>;
+		VDDL-supply = <&reg_vddl>;
 
 		port {
 			/* MIPI CSI-2 bus endpoint */

-- 
2.34.1


