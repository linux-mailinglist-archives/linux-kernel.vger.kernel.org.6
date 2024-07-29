Return-Path: <linux-kernel+bounces-266302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBB093FDE9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DD41283F5F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 19:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F3F187355;
	Mon, 29 Jul 2024 18:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XdfTx+Pp"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011036.outbound.protection.outlook.com [52.101.70.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D7A15A87C;
	Mon, 29 Jul 2024 18:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722279594; cv=fail; b=owl1Y1nSnDL9nc5OxONMGUjMW9ycjDjbeTLwEPlYUgaOlBhTJSjMuEygtQeMIDtQ0jVNBfB64FDjSoP4wNczrJrKK5Vkz7QRIn+dm3ktgnhWMP06TW9+naPRSrSevZXrwvY4NrUtAO3+8OZIhGopdAKKYmBmgXOZ8StTd0mF7Q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722279594; c=relaxed/simple;
	bh=IVUQZD7jLcmt9SEbDhOP7PaywUvKWxrUheVeSttzn4A=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=X8+oikhlMTquds4MWiof9wXBQVJOLVDoUPb/cSq1gR7PoX8XaetXeRFmvAMy6rFA3oJRc5qO6qgr15wYyH2DOme7BFtdD2RFohr14R4/N5TKBPTqnBaEtGXKX6/VE4eGYh0EdBSGTSNErJNbj9jcx1930pEAdzSZI58EAiT/OHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XdfTx+Pp; arc=fail smtp.client-ip=52.101.70.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iSOyG8m9awm1Q//mcmNnfDipGWQN2MzPhMCiLTaLRXuOuPJt/eSAFbdzTzNVhD9bxrq9rGLMXHyLyKnFpAeE6EubKLahN/EXxuDJyDThh7ovpdjwxqqp3Ds8jgNswGHQqBdRmlvZXxZvIQcdX4/hpZOLJ0AQZ/z8gfV+ahs91taTge6zDfOr5JJaEOACKTl2vCy/1VbY1gvqxn1zznFtoP+IU8vI50vVMfBKAGT5qCsO2lURv6/83mdDikMSb0u8ayVbermDHYIJR4m4LrrWJ3MutyTc34BbYqEHrFT6gn43WseV7/IKUGpYcBk6KopnowgJjT9DaTXTB2Kkff9zXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zhty9TgoT/3OG8bGi7tyXXqeZzSSP45x6f4OPHVAy0=;
 b=ujDVcRyylPn8mcWKiLH5dC7BV84ZtTMY/TZ3AHNAjyVa5xE9nTJBGm5Xeg9F1FIEtaTMAcuB7r7dstDT5fm7sFMBg22rfG8yueutd6XlB5zF/4rV0xpoSq4/gkgnzDpmXDhZQoedIBm7LeRw7q/Ezej7Zc4WtW8hAyVKqzj0x8bmNR9lkYW0D6cjFLXD1rZH29hygvbhoJeeChFYymJ0E8JTYHp94XxBYbqn2ve3YEEbOK3thPjp6KCfAVAOyn1Fu6zSWLGH/7X/ZzTUS1d/6gCRtEAePB+KJCCBRKLbiX4XogHBDGrnnHpetjzG5H3fr2wW2xAMigjvp+WJZDquBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zhty9TgoT/3OG8bGi7tyXXqeZzSSP45x6f4OPHVAy0=;
 b=XdfTx+PpfZV4FdTxz5iDC8xALgsL/9pQG2WaLiHFTn8NiPG4O5pllYRZ/RajCa3ZwVJAakveRaUXRQdg5DWMX54v2ANzdNSxMRVywWy9sOkg57mMkvXYtZbEFumuznbtBfuU3aGtif6gp6MxSHMfcq6tDh0flEyJx2CpI14XBb8c5p/sAcNN4ewJlEupMr+Nei3CT6/aAxSglcWCMJ9WCLqobuwrDxYQbSnEsLJvAKh+9FAJSaOf0y7AyAAwH7Zz3ZEhCMYB0kolizC5WhNdyX491dhTpIdv+IwfyIMT5dJYdGxPzArzJJcMPaE6fNaGgie7DV34mxC8ATNiVZSQow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB6939.eurprd04.prod.outlook.com (2603:10a6:10:11d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 18:59:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 18:59:49 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 00/10] arm64: dts: layerscape: collect all fix warning
 patches
Date: Mon, 29 Jul 2024 14:59:22 -0400
Message-Id: <20240729-ls_warning_all-v2-0-942d80ddd441@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIrmp2YC/x3MQQqAIBBA0avErBNkDMKuEiFTTTYgFgoVSHdPW
 r7F/wUyJ+EMQ1Mg8SVZjliBbQPLTtGzkrUaUGOne7QqZHdTihK9oxCUZWQiS9qYGWp0Jt7k+Yf
 j9L4fGTR/OGAAAAA=
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722279587; l=2291;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=IVUQZD7jLcmt9SEbDhOP7PaywUvKWxrUheVeSttzn4A=;
 b=boLap3pTIFg9c+talIrH2OJAmr+BqRqeZ9+W86OsifuvQ2+WXc6+p2JNQULw7MltvkwQFpSoQ
 YAKpZhgoA4VDWbKWGXeRWAE+B/fVla7BaCtLYnU50msTxkzu3gYH93B
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0134.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB6939:EE_
X-MS-Office365-Filtering-Correlation-Id: dcdc1443-d5be-4db7-c688-08dcb0009f09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NzAraFQweW5xbHRVYU1OMG5tRmpvOHdGclhRdkZWbHJEVysyODJXVG1zamN1?=
 =?utf-8?B?VlhsdklidzliZ3JlcUMvOURQSVl2bjYzMmhZcUpUS3M3NVBFNUJXc09HbUhV?=
 =?utf-8?B?OTNWUkJBMjBnczUvMnRrVUp0bURiQUFIbFkwM245RnNieGkwYzdjaG1SY04w?=
 =?utf-8?B?dHBEem5ESC9OSTl0V3RkTXhIckJBSExHRlNRVWZubFAxYzRURTExRG5xVnp1?=
 =?utf-8?B?SkZMWlM2TUlwYy81d3pWeGUxdDhVVnZHLzRHbXg4K2dSZW1Yd0xSa3JNc2R2?=
 =?utf-8?B?d3k3a2dyVXpkYzZNKzlOQXNpbStkYmo4Q3FvMjFqV252dHFSVWltUmNqWmJ0?=
 =?utf-8?B?MFFmLzcvbmpqdmp4Y1hkMVdoRTBNSG9HNXdWSUVHSzR2ZG9GQ3QzNVNuc3Rz?=
 =?utf-8?B?WVdIQy8rWkxKazJJN2hDSno5UndTalRKZlE4elZFQXhHOGNZbkNITE9hYnho?=
 =?utf-8?B?Mkxibk00dHpiQ0ZKNnM4bjQ0UGtVVVA5ODlUTVZlSWZBTWEveTlZWXY5ZWZP?=
 =?utf-8?B?YUVlYnVJVkZEa3Nkdzc2T3V1UzlPdk5hZDRRVkloWFprMkhyRXRiVnZxMGsy?=
 =?utf-8?B?VDJWeDcyY1AvWHFHMVZEdWtFakZvZ204ekl2dmoyMVlyTXQ1elVDNUs0dzB1?=
 =?utf-8?B?UVpNQWRGY0o2RkdOQkdldFVWVXgyWmVRWFozaUsvVTFWZ2FwWDhqSlZpbVV3?=
 =?utf-8?B?aHQ4SlF6SGdpZlBVa0hlV1JmY0g2TFV0eTh0UHlWYmljVVVSbFVQbGlvL1Nr?=
 =?utf-8?B?a0xleHl2Q2ZLeEFOdTBqZzdvbmIrYjcyclpCWC9kWFFKY3Y2UDZyaEdPMDYw?=
 =?utf-8?B?UnVaREdtQUlSR3ZYTVZzS2RtU2o0ZDVzOXJiL3o4c2ZXVFd0UzVxL1gyVFZl?=
 =?utf-8?B?clRERzJUN1RtY1lnOW4xQTZWcHR3R1F5dklTTy9YNEIybk9VUTNlSzEzdDBv?=
 =?utf-8?B?ZVZXUzN2Qm0wdWtndm1LditxcWwzVXYxakRRT2c4ZFliOGlrMzJ0OW56bmlV?=
 =?utf-8?B?M0dvcFJreXg4N2pQK25ZOUZaUUdiYU1kMzNCS2pyLzNTSmhvT3lpSE1TcElC?=
 =?utf-8?B?YzhGNm1WRVBwWUZjalBST0kxaVFMcXBvMkVtWDArM2ZIMVppRDM0T0I2N3hL?=
 =?utf-8?B?UEZqVEJMTUluSjMzdXoxTnhYdXVWb0pQb2Vub0VBY29keERlWXc1RXdhWFBJ?=
 =?utf-8?B?bTFxUHFjNlhBQSthckRBZ3BkNWsxOFJEa3duOW9rTmwwS09TV25vTXlaWFU5?=
 =?utf-8?B?OSs0RElISkVqcFdmd3l0THBRNHRQSG55RUYrR2Z3Y1RrbWthQ1NWUFJmL1B1?=
 =?utf-8?B?dnNIbit2QmpsaU5WL1dFcDFHazN0OWpoNE5vS3RsdVZWVFlBUGVmRUdDUzlE?=
 =?utf-8?B?K25zYkkxWUNocjFORlNXZG0yYUNVZ1U5Qjg3b09Nc05JQVFiaUNNMThiL1pX?=
 =?utf-8?B?UEdqNGZteDVDMjFUaHBodVptTVBDRzkvN2I3bEhFMExOamE1bVIyZWRSbExn?=
 =?utf-8?B?bnQ5Wmx0THkzcllvbFpVMWNYNmZtaHQ4SEttb3dRd1VvektQR3VUNTF5dGpL?=
 =?utf-8?B?MFZrZ1JVNDlJa1hFWk1zL0JVQkxaMDh6aFFFT2JkYnJzZExIMi8zNG1jWnZo?=
 =?utf-8?B?MGVTRDRmbFV0d01oclh6U2czajVXUXhIck1FSlNaWS9oV2JTU3VTMzlVQUJH?=
 =?utf-8?B?M2xlU0FLVklzMkJCeWdweDFGMU9jaW9iNTBKRHVzSitPdXFNM3UxeUFnTW8x?=
 =?utf-8?B?VC9HSXVvS0IxRWpoTG1SdXhXekZ1TlZXRTZlKzZlTHh6eTZMWU9UenFnamUw?=
 =?utf-8?B?N01nenM1Y2t6KzdUQlJ6cXB2MXhJaEhGeVQySDVOZGNNTCs1SG5uN0tyazdk?=
 =?utf-8?B?MWhCcFVLQnlYdkpXa2ZEbWhvTTQ5bEVKMlB3bkVKVHk2MHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjdiWHduNW92QlV5SkJGREZFQlc5WGZ4WEI0WGsyVWpLR1BDamhOM3FBSE90?=
 =?utf-8?B?Z3BSbFJ1aFJMc2FJL09SZGtsT1hJdmZHaS8xYXo3a2lUb0dEWU1QYk4xajJR?=
 =?utf-8?B?ellwb0VNK2VKTmJzaFNWVnBaN05pYzRObUhvc2tIOXN1MExTTllVTmwweFlJ?=
 =?utf-8?B?Qk5VcFZDc0txSTROZ01EaUtXeEErSkZreEF4Z3NGRzRPeFdhWTVpRWd2Y0ll?=
 =?utf-8?B?VVJLZndQek9QRzBzTWhVaTFXSm1yUlg0VHdNU2dVZEtEOEg1S1RSSE1QcXdw?=
 =?utf-8?B?SGx0bUVUVHlZS2kwS1Qvb3RPRUtKRGZKYkhiNTVBTGdJYmg3bC9mbnhmdUVv?=
 =?utf-8?B?ZjhRbTZIbCs4SDVKMlNQZ0VUVFpEREg4ZUFGcmJuN2NnWFd2T29GSlV4TVlt?=
 =?utf-8?B?Tm84dytST1RBRG1OeTRIWnV1eVFFK2xRY2Y4UGltc2V5MWRuSnV3VnFlK2NL?=
 =?utf-8?B?VXRYNEh1K0lQeHRMN3IzeW9BZUFyQ2dVYUh4bXlzZ092eWJxYkJ6NW8vSmtV?=
 =?utf-8?B?MlV0eDdCcXRTa1FCVVQwY0RjSEhIcjg3Rlppb1pqaUp1Z3Y1amNDSE9odndv?=
 =?utf-8?B?TXRDRFBFR2hlSXVnQnVBcllhZDE5ejAvUTUzb3FwL0ozKzFaenJUZnlST2d1?=
 =?utf-8?B?ZTNRUEVicHZFclI3bWVlR0QzR2tEZVEvUEFhM0tySE5jSkQ1RXN2NVJ3MU1i?=
 =?utf-8?B?dWpYb2RDMmljdk1TOEZUbDVTallrM29zaEFXR0dIUjZ3WlpPa2xMOHY3RkI4?=
 =?utf-8?B?bkhFeVdvUzhLSklPbE5kOFFpRExmL1NUN011VC9MMHhwa0JtZUFrUVNqRTc3?=
 =?utf-8?B?QnRUaEZSZUR0dkg5Wlpqc2RqYUNGVWNDdVFvRm43ZkFLeGorckZDSkpXNW0w?=
 =?utf-8?B?RmdXS241emJBZVBPNGNkNTIzT2FSdVlIemcwTFIreDg5Q3RkMDYzSUNiNzVz?=
 =?utf-8?B?RTUzTTRSTmxkUDBKTXh0QXh3QkxHM0ZFbEhtaXYrdFVHNDQ0MjEzdXM2VThs?=
 =?utf-8?B?TDY0OHBMQWVreUROQytyTGxHVDAxSnh1c1d3UTYxNTl1M2VwWm13QUpHeWFq?=
 =?utf-8?B?dWtpL3hmbHZHY0dNVlBIT0VNeWpRclBQQ0IrNVhDcDZjU2R2aUJKMHllNklp?=
 =?utf-8?B?QU0rakdKQ2k2b2I2L3FyTUc3ek96RlZINFdHd3VJRDhlNXpnK0poOGVxTUFm?=
 =?utf-8?B?OG83UzROc2hmTmRBcnUyWUlEYmFIZ1pXWW5BRlkxUnVYcTRUVE85YWErWlh4?=
 =?utf-8?B?eFlxZFBnQmQycjA5K2lFRjB0MVNndXhUQ2JEaHcvK3VyTE9kcGdiVW9VdXpG?=
 =?utf-8?B?bzJxVGRjeitHQjJYeUx2cjdJQjdiSUdKNVVLcXlpblVlSm4yeTJPMHVHSWxz?=
 =?utf-8?B?RXpZdTliWWFFUGdmM204Sjl3M3dTSzJneWt2SERNUFc3aERuaW1MOU1pcTAw?=
 =?utf-8?B?WVNFS1JvQk1pY2kvbUtIWDR0aEJINm91WE9MTmZiRWJIaUVQYXFuZnkzc3hj?=
 =?utf-8?B?S2dXR2sra3JSa214QWZMalo0Sm44czY2TzRwd0V1dXJMRWkrMmlRY2REdlpO?=
 =?utf-8?B?RjM4ZzZlbEZsTWkxbkZZRmhCRFlxelV2cWl1WmJtTlZwVElIVWJ4TjEvcnhi?=
 =?utf-8?B?UUZTcVc3QWFLWXVaQ1BzdnMvV1dPNWFFUDBmNCt2ak1pM244aERQdUpIS3Zy?=
 =?utf-8?B?ODVGSC85MFpIclgxN2VZRTNrWnZZOXZncHRGVm16eFN3ZmtWR2RURVRNYWpK?=
 =?utf-8?B?dGQ3a1F5SkthaFh5Y3ZhQzlGeDgzeWNzVEQrWXVDVFpULys4aWhsMnRXREZs?=
 =?utf-8?B?UFYzN2RCaFliWTlKbHJJSjk1YjVMK1hwTHBJdmdWK25IdWFNdmFaTFlQZHVa?=
 =?utf-8?B?aVBYbGo2eVNzUDBHRzFSV3dnZWJXYnhDRE5SRmZPQk5TYWJPZys2bkh0Sk5T?=
 =?utf-8?B?a3RQekNROVdCOUF2bXNpRnE5WHF1SUZOcWpoWG5VTGdHcktRbnAzQkZzWFVu?=
 =?utf-8?B?WkYrM3RtN2tQMUlZbXJxbFR1STkzRWhUMEtjcnZPT005NTU4bHJDdUlxVitJ?=
 =?utf-8?B?bkllWEJYSGZRMXowTTIyRy9aSmlyaVpPendqNzJEak5VN25mcVgyeTRBeGw0?=
 =?utf-8?Q?iBLHlebncz4PZTyFxvNdwLuUw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcdc1443-d5be-4db7-c688-08dcb0009f09
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 18:59:49.6826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nlUMt8r44eZsVATWNjhNFQPqQ7RbICYGgc+lQNyHa1ivWtkZkSZVslqxkzaOqvIhmd2zbtegrI+KSTH1AhWkPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6939

Start from v2, since previous already sent as v1.

Collect 4 thread
20240628142809.2327824-1-Frank.Li@nxp.com
20240703-ls_qe_warning-v1-2-7fe4af5b0bb0@nxp.com
20240703-ls_reset_syscon-v1-2-338f41b3902d
20240703205847.2826263-5-Frank.Li@nxp.com

Change from v1 to v2
- fix typo layersacpe. 

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (10):
      arm64: dts: layerscape: rename aux-bus to bus
      arm64: dts: layerscape: rename rcpm as wakeup-control from power-control
      arm64: dts: layerscape: use common pcs-handle property
      arm64: dts: fsl-ls1043a: change uqe to uqe-bus and remove #address-cells
      arm64: dts: fsl-ls1028a: add fsl,ls1028-reset for syscon
      arm64: dts: layerscape: add msi-cell = <1> for gic its
      arm64: dts: layerscape: remove big-endian for mmc nodes
      arm64: dts: fsl-ls1046a: remove big-endian at memory-controller
      arm64: dts: layerscape: remove undocumented fsl,ls-pcie-ep
      arm64: dts: fsl,ls2085a: remove fsl,ls2085a-pcie

 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     |  4 +---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi     | 26 +++++++++++-----------
 arch/arm64/boot/dts/freescale/fsl-ls1043-post.dtsi |  3 +++
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     | 13 +++--------
 arch/arm64/boot/dts/freescale/fsl-ls1046-post.dtsi |  4 ++++
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     | 13 +++++------
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi     | 17 +++++++-------
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     | 21 ++++++++---------
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     | 17 +++++++-------
 .../boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi    |  1 +
 .../boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi    |  1 +
 .../boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi     |  1 +
 .../boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi     |  1 +
 .../boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi     |  1 +
 .../boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi     |  1 +
 .../boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi     |  1 +
 16 files changed, 65 insertions(+), 60 deletions(-)
---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240729-ls_warning_all-9e2eaa9a033b

Best regards,
---
Frank Li <Frank.Li@nxp.com>


