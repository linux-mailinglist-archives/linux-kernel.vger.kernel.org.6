Return-Path: <linux-kernel+bounces-284100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA88794FCE5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5919F1F223ED
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 04:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC8613B58B;
	Tue, 13 Aug 2024 04:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TXD56Put"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3A013A40D;
	Tue, 13 Aug 2024 04:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723523761; cv=fail; b=D0163edr3XElHyBusNLzv760zw2J6DFZLIop0diIPmnlgLofw6A0YuLd7JmpdKk0QRBvPOZVNu+MvOS9mJwAqPBJs1vyal1h0kYrEy0lHYu+vUix6aOxyc1l5OFQ8TZDH5zY2huRpSTtpIYfW971kPDRQyYl4RiDfRqa4B4tKT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723523761; c=relaxed/simple;
	bh=5qc6Vg/FR1MsaUlU2OGzHiiQzfmsmavrNRemLvounGo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=C9rloqqnbIDsMpGqsHlX+uDPlnqn2CLToyKrF7qUt7VkDc9h2ynhTu091PECoFO+Zxl1yzdTkRaY5flWfdISuAEi63ba2DdaGFRW77cLbkUvi9m6tphWh+iNaY0AnAXUakklsujsbyS/5qjJLuXa4zGrvhoVcdelXw4T/+a+FyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TXD56Put; arc=fail smtp.client-ip=40.107.22.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hiGEAE2CUsQSZdkyHwghnFfrIHyuKDwRmh5rz+7H13SzUXTnv2SZyb+r+KN+VQDpfMuSbY8OlAk8CIf2RjhNP/VWjbczsvvrHB+cMHDoX66THD44o21XDfpXoRjMnBnPPxKP2Q9bCcszmQBEmGBPfssOHb4acQzFaOQfyvmzN5w8xUIu12odBe2qDB85nR8lEi+/DOzrLhm4+xrkXpWbERR8Kwdq3/Jn2Bk8Foh0RNtFBwcALeKlAjV4y0eE+DpF1YevE3JCk1bbhvVpqZlCsAW9ApEhBrgJG/sNK1i1+yIb9jzhi6rcRD/OwXtHHzMkgF8HIOQNtBc+WXLJWu0MFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYlM/NVRbKl8k+/0zED1nHAy/Yz9DXW8VfuFXRjiehM=;
 b=VDpQTph3S1L+AODo2gfwg1oM+Wz8H55VFiDo2UebxYviEZHi9awfBEaHfWzKESHVdslMd+uX7MB3sxhUtA1ygq4ylKMMQ7RnbWXBlqboz1U0BYuXdVxzvhUZQ1I9NM6UfOL1avy5K5x7B0xwf+uSFfg+/3He0QdvDlWnD/HAqlISNTfhHWoKKtVuLmCsth+hAolhqOMWQyeNs+V4AYInP0w9sZckeV3VdvcGJiFg+bohqFlGDLSTK2mbWgMyrtsMWzL8Tw94ZbTKW540yjQmwNBNpeP3QH+o511gnhTrnokabXOi1NkNcbYqwXll3IPq3yp38tYp6gYwTPN9YQHMxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYlM/NVRbKl8k+/0zED1nHAy/Yz9DXW8VfuFXRjiehM=;
 b=TXD56PutpI6mAgIgxIA/LEl6O0xXeOmO7urOdnODPzyTF0YDXoSMZfEaZXEVO6wXP0HaaxXxdXmqe4QPg0q9izGVcN8iYQqxiK+BJOgfJazf4bda24iDfiNoBbTVyZByf60a0P/a5KYVi4m9tJ60RnfPWkrxSX1jXNeQC9HZN1yabap33NPgnyEOdyAAuDQovQwpEG+rVdk8RDZSWcXFWa67aTbv08ofWkjnTEra41CB4w770OcFMU5mMU6Dq5ED68Qv4zcPuvbn/DYRqoT4OPXtlUwxzf/KOQxVH33+kEbZjP1YCSjxpMIox8jeUf/UXP7PTi7b+6O06kr56xG79Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB10066.eurprd04.prod.outlook.com (2603:10a6:10:4c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 04:35:58 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 04:35:57 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 13 Aug 2024 00:35:08 -0400
Subject: [PATCH 13/17] arm64: dts: fsl-ls1088a-ten64: change to low case
 hex value
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-imx_warning-v1-13-3494426aea09@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723523705; l=926;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=5qc6Vg/FR1MsaUlU2OGzHiiQzfmsmavrNRemLvounGo=;
 b=ZeWiQg/z1REy5nIriETLYS/B7hhB3HKk0PNI9AwakaE1oKgneb239a8N0moSTfi6JJHQWuAj2
 nsU+LTgSt8IBDM1QLd1VaAqapmSSb63/RZsYhUTVDdBYTZlrZqjxNBG
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
X-MS-Office365-Filtering-Correlation-Id: 15596448-42f4-4ca0-96c2-08dcbb516d2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEtLUXZnZUgwQlRCNDJQOTl3NWZpSXJxVG04Y0ZxUXQ1RkZlQ3ZyUUpkMDk2?=
 =?utf-8?B?U1M2WnFvNFlGZ3RuQjF1UmlrbE9GSTE0Z0RyL25KQ2lGUGRhSFBQekFEVlJw?=
 =?utf-8?B?RHBBTm83N1hlVWZ3allBcXBIdEtCd1FabW85WEdXTmZtK0ZiSitDQ3NLaDly?=
 =?utf-8?B?cnFtU1RLZ3c3aEdCeHlJVDgwdDNWSzBuZ0xMNm1vaUR4Q05zWW5JNDR3Q3Vu?=
 =?utf-8?B?S3BVSHV5SCsreTA1QU05cmt4YW9kL0RKSjM1UWM2TWlWb2hTRmdRVHJaU0Zw?=
 =?utf-8?B?M3ZhSDQ0Uk5ZcktrR2pwMnMzRTdKZGN2ZVdYeHdCdmZkREpXbjBBbFpkK1I3?=
 =?utf-8?B?RmxzVmEyZnhpUGhaNkw1N1lGY2xJczd2dEtpMmRtQS9MMUIrdklpeHhOZThX?=
 =?utf-8?B?NHhvSkloYjBHYnNVY0kvbm9oRmc4M1A0RUxoSkhraGI3ekQvdU9GQWc0bUZn?=
 =?utf-8?B?c2RUdGp1eWYyMWVHMHd6NVQ1TllkU2NsdHV1YWpNbEMycHlZVXEyVStWWDJZ?=
 =?utf-8?B?MFltR3FZRzB5SCtOZmNFbzRFRU1PbEVSVDdzQWhNU293VzhodEU0cEZqdDUv?=
 =?utf-8?B?TkdoamRZSVVSK2RlRFlLRVV4Tyt2aFJPU3IrVFE4ZExaODNnZVNrdGpSSCtC?=
 =?utf-8?B?ZGtuNmc5MFFJVFI5K0lIR2tSNHBFY0I0bUw2MTJFbXF0YU5YWldINm5MMnI5?=
 =?utf-8?B?MUs3VFkrcnIyczRJeXpveVExenFLM0FDYjczRlVMSEFNRE15Q2lPNkd5cWND?=
 =?utf-8?B?b1Y0clJMZGF5dWN6TzVxQThVMUFOUFBDdXBlSUU4UjlNdk9sSFpFNnNpMStV?=
 =?utf-8?B?eDk4L2J1SXV1Y0ttb3BWaFRJc2xZcUdtZHRzV2o5aFJkM3VUNER2ZGdrN3FJ?=
 =?utf-8?B?MlB1UXoxOGFlWmdvd2N6MHQyTTRpUG50WEJSTXZCUWJUOHlLS0ZTenJXQ2E2?=
 =?utf-8?B?ZGJxUFpkTHV6T0U3Z0F0RzNkc1RMSkdRRlhETDVVeDZtUmMvL0FwekF3a2ZV?=
 =?utf-8?B?Vi9DTFVWanF4UVpXcTZqMUVFR0MybEFkTm9aTWpDY0ZDVXN3a3JjT0FpRmlC?=
 =?utf-8?B?c0pERVdOREZ6U1R5QUFTZ2lWUmVLcHpLaFJ1TTYvRm1zUGVnQkhJTjRLQ05O?=
 =?utf-8?B?U3UvaGtkUUV3aUFKMjRFMHduM1N6cmdXTWRoWkhyS0tTWms4SGR5YVdteEdz?=
 =?utf-8?B?MTJISStKWHhtWGpQRFBVRXNZSzFndTRTTHl5TXJsd3FXTkx2eSswOHVjUmw0?=
 =?utf-8?B?bXY5dVV2dkY0bW5DRmU3QzRja0czcGZKa3ZHakQ0akZqbzlzRDlDZmZkTkdv?=
 =?utf-8?B?MTVGRm9iaHBxbUtYRi9kQW8zZE13b0l3VkMzeEpiYUt4SldpeXcwSmxndTJD?=
 =?utf-8?B?azJsWUROUTJ5eUgvSnNPZmRIeFFSb2JJcEE5cFBHdVllaEJMK0JQOE1yQ3VX?=
 =?utf-8?B?UWN1UmkzN284amFoVml2TlMraXFyRm5jRFFmK0tMSXVuVWNndnFoc1cwdWVR?=
 =?utf-8?B?YVYvdjAzV3V0NzVRYUFtZkg3bDFtUUVXWEw0Z2dwNG4vWjU4N0w5eWc5eE9E?=
 =?utf-8?B?RFRkakE3YkRmdkViQ0YyZnFhZFhEWTZ5ZGJ4UWVXR25rWURzNjhZQzRRWUtY?=
 =?utf-8?B?TkdINDNqS0xteWVqc1h1dUtIeEJrek5oT3ZaY1VhdlhMMUdqUTdvRUdQQU50?=
 =?utf-8?B?K241UXFBbm9saTlkUjkwemluZ1pFOG9TL0VzbXZvQjBnM2kzZjduVXFzSStB?=
 =?utf-8?B?aGp4d3BEMjhDMkNIUnJaYXJ5K242a2FRa1Z3cXN1NERYTUwvUjMySC9lanJB?=
 =?utf-8?B?Qm5WZ043eFN1bEpFN0FUZWN2Z2xKdnZoQ2xMQy94NDdhYUhxTk1UK1N1ZVNQ?=
 =?utf-8?B?WHNZSytHQUU4K2xxNlk1VUtZVnpML1FQUVNrVzRQQlBxWnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0lseHFod2VTZUg2WVQwNTdCbmtlN2lWd2hSUE9vSmtwQ05JK1NNaEd3STR5?=
 =?utf-8?B?amZjYXJ6RlY2RS9INTUrZ3cyUlhOSm11eHE3RlhCWTFkRGxpWkM2Rzdnckl0?=
 =?utf-8?B?NEhxYVNXVmpjcnBNSTh6SkRFeHkzM3haWWNkQzJoSDdsN2d4bmdsN3ZScERG?=
 =?utf-8?B?VCt5dFVudTY2WERGd1NxTkdZNkJJRDU1TTMwN0dOVjhuQmNwYk9sVEZSN2hM?=
 =?utf-8?B?UDZObmQ2bDloeGprT2hqbWJwZ1FwS25sN2c5Y2dleWlnbG15aVhBaXFSdk1m?=
 =?utf-8?B?cjF1ckVPRXBFRlg5R2lIN2djSlRUZlNwTmJ2MjFqeUhxVUpVdWlHaStNMllt?=
 =?utf-8?B?eFFkVGxJOURvckZZZVFaY0lCNXVmS1Y2YWVPQkRDYkhwSUR4KzJ6RGFSeXRJ?=
 =?utf-8?B?b2dNOWxibW5GT1VZMjI4QTNUaWtOVE9ab3hFaWRXL09pMytZZlJpK3F0VHZ5?=
 =?utf-8?B?NnU2ZzRiQWRWOFN0eklqLzlXZzduNVYrYUFYT01PWGh5cnZPQUVsaWl5SlFp?=
 =?utf-8?B?YmNad0NKRjlrTUJWb3VFZjZRcGtFcnkxb1BSYzBxS0JCMW1vUGZKQTFhWjNq?=
 =?utf-8?B?K3ByRHdrNjhHTlJaZ3RwbnNGdmNxU3I3UTd1K01uZnM3T1pYUFk3enhleTV1?=
 =?utf-8?B?UFZ5QWF4VE1aUC9TdVpTR3RRMm1jZDZRZE4xNmV0UndIcllXS28xdFRvWVp1?=
 =?utf-8?B?dUU4TFVubEJMNzRtdEN6dHdiODFJNWtRVWYxOUpDbStybzViSzlnMDYxM084?=
 =?utf-8?B?YzVYQkExUG9FUlVVN2U2WkliK0RleTk4aU8yalQ5bklTbGpMQm5WU3F5N3Ja?=
 =?utf-8?B?Q3BudjhaSDdHcGg1QUZPYWZmN1J5S1dQdGVNcDBmMERtSTEvWGJrZksvM2RX?=
 =?utf-8?B?TzArZC82S0laZVVJeThQZXZiUmxxS0RhekliNDFWek90cjA0UzBIMnZPWmtN?=
 =?utf-8?B?OG15OW4zNlhsMmF0L2E5V0ZlMjc2K1lMaUpJTk5qbm5lUVBzYVRsWE8wQmdw?=
 =?utf-8?B?UlZVbTN2cnNOK2N3QmxNWkgzdEltckZpWHVycWhDWExQUGVwNFJML1NGZGc4?=
 =?utf-8?B?bDNKdWFodEJIWVpnZVpBcEtrbklvWnJLdXdkSEZ1TVJaTWJNTDVybEtUd2sy?=
 =?utf-8?B?WkhNMkNvV2tsNGkxSW1yd2FWT3MxbG5aL3ZDd2xEeVRibXhGbllUdXdWQlFv?=
 =?utf-8?B?TzlHOVpVVzlTaEZnUWg3YWJIRlkzMmo2Z2VPN0l1UGQ5eGJwcEl6OHFWWEw0?=
 =?utf-8?B?ZmczdWlXOHFTWTJnZHZzMU1weGEzaGN1SFpSUkRYankxeERwaHVQSFRXeGoy?=
 =?utf-8?B?NXBtYUtHK0J2K2MxSnBBWFBLZjREM0ZSWkRVS0hoSGxVckkzVVorVzR3dTBR?=
 =?utf-8?B?TUdncU00cHdiL2FsQ2xGNjNaNjg3UURvQStPa0tKWjhsSk1KTXdTL2RkRDQr?=
 =?utf-8?B?ZzZuUFl2MzhUS01QQ09CUGpwNS9IeGY0WWlFb2tvQ0JoV01CMWxCdWR4eCtF?=
 =?utf-8?B?UHUvOExQeXNkL2FhT3pGODB2eDVRVWxmM1B2QzdWVVAwb0cwWjEyRnVsMldU?=
 =?utf-8?B?YWZHM0NFNFlXUmQyc1RuZHFMK1dmU2FyTjNqNis4OUdRb0QyK1ZHU1hVaDJF?=
 =?utf-8?B?VGNsSlBEcy82Q1dpa2loVVhlQTRXTDR5d0t6MmtQQjdHMWdQTTBRQzNCTlVj?=
 =?utf-8?B?c2t4cExWeldkMzR2alpNYVpqUmhXV0ZucWRNLzZVWGkyVHBlSEN5dGM4ZGFo?=
 =?utf-8?B?ZUw0dlVpWXlBWHdYTldZZW9QZi9PUkIwMmdPWTc1OWFXTE9WS3FNT2JObi80?=
 =?utf-8?B?ZXhGVTN2bjRHK0xnNjNtbmZJQ2wrS1BhMi8zek95Nkw1VGhiNDhybEIvdGJ0?=
 =?utf-8?B?Q29PbnhkZ0VSbko5dXQxVk9CZjJ3RXBTRlkrQWd5ZFg4N05maXRVYWVTWGls?=
 =?utf-8?B?RXNWSnZTQkFIRUhQV0hPWldReDFmZEt1dDQxSkZMRkxMN1VYN2ZtNUQzUnJ0?=
 =?utf-8?B?U2hqbmZyc0ZtRVNzMk95bDlsdE83NTBqR2RucGNlT1RwbUN3NnhSN2pnbkwx?=
 =?utf-8?B?ZzJHUWRjMGxMYWlvMWU5ZEZicWdyWVY2RFFSU2h1U0poYTB3bG1NWU15aE5p?=
 =?utf-8?Q?hcEOyPLlAMjyQ3C2QXRWAp2Eo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15596448-42f4-4ca0-96c2-08dcbb516d2b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 04:35:57.9056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jm1iLOA7Uevi+Gk6rmErz7KITure5Utalln3rlLQ86Tqz/ywonOEHXSxi/h1zVRanjVFD3tnX//BmWGXbfFwJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10066

Change to low case for hex value to fix below warning:

arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dtb: flash@0:
    partitions: Unevaluated properties are not allowed ('partition@5C0000' was unexpected)

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
index 57f2082143c8a..bc0d89427fbe5 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
@@ -323,9 +323,9 @@ partition@580000 {
 				reg = <0x580000 0x40000>;
 			};
 
-			partition@5C0000 {
+			partition@5c0000 {
 				label = "dpc";
-				reg = <0x5C0000 0x40000>;
+				reg = <0x5c0000 0x40000>;
 			};
 
 			partition@600000 {

-- 
2.34.1


