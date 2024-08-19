Return-Path: <linux-kernel+bounces-292586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 262C695717E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A80931F2345C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6528F187555;
	Mon, 19 Aug 2024 17:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TOjZ2g8a"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D963189BBA;
	Mon, 19 Aug 2024 17:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724087023; cv=fail; b=TMsQMjDAPXM9gpdf463gXn5cZ5HgBWRnRqMRkWSuNXfUXwLdbM+Wex+HKW22035FievQZA5UbYqrBLk+L93vaKPyk0fR8d9D42+6E16FaLV/ILS0nik9Fm9Wf3WuRrPHw+nsXFQVdjV34PuvrZo33/MJpHZX3Tyk2fCWJjGUzHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724087023; c=relaxed/simple;
	bh=YsCVGi2xLSOi/kR+JYnICx2+6DdcUk/FyLqi5HaFz0o=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZFt9wjtgm0bYD+4+PloQeUqjLO7lLDm0NHox2+PNEt/45gZIsbGcw8S3wVRDunSz6pGvBmPhMCZo3fX8KESwWJzB0Kyy91rzavW41sXJbRgi8OnjBTXcY9SOm78zakUpFJn07C/dlJOxATG3WAT/dD3KdunFT6Y8WdfUpbngMo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TOjZ2g8a; arc=fail smtp.client-ip=40.107.21.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6jBB4H9YlQKZ/QA8rOy+XuZaf0jlU/+HIZ8UAWYMv5Yle4kOrauk5HSfE7pa9k+YpGuo1WH++COJynPuXVBpf+sog+ck+BgpWEQRIvnCzsDddKDxGiltz9t5DgreDnHhz1bkQ40tB2oBm6XbaF3a9f3Bfb7Bb4161fGEPEpf+ZY33v/wV5DvuPfvMMWeuKxZYl6ZC8I2rjcJPc/sOMATKkRzpM1nlzAYMuVQFjw7WPVV6UzYmEG2+bXGE/syOpcY/PAPaK65PJq7dGSy+aXTPJMacZn++teQTPM7CpRSd4CM2C8S1lmvmOOvhaYOvuKNgxsMVNKejkBabzVUCgfbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLsBPDw9P5J+NFUtxzRtJEQ/8MMosfjYts9hYryxXNs=;
 b=ihZgDEBfTmn/jl14FzzpoZz3YLQ93PLMllMcrjGn7ojf/eeCdS8okmOekQ6xaakHe8TFhbeLFuDt1dJnftj7Ez3j2IRiJa7m3cx4SUoKiagRBzIVjll7GOm5Cnfynwc7D+TGZfBgDcrBt0S4rhauIpEbcnai3UUtygLu5YDu+J4f8AK12AB2zkpe9cMl5wLkaAuUpE5PU5uGTeZVkG95EMxSEfeuDL+Of/WWrc3QEfme4DSxLekZiX8CVqfUXaoHq4yFJAetLLy5rRgnhH9WNYXlfkpvLoOF39w/oGOkPO4lXkVorWABmK1h1DVKn15qOi2tOdZznmDwmJWs958asQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLsBPDw9P5J+NFUtxzRtJEQ/8MMosfjYts9hYryxXNs=;
 b=TOjZ2g8a4/cGmn19t0aDQpUI94mh54qw38TjXEEu7OcvaOoSMhsvDRDqlivJcZQZGPqsGPPmNsNCVcQSryU1N+kgLBxuOzvxr1z8+hLG6EtDm1kVB+bxGGvoki9xYxNG9imJ+g8+0X2/hOBbGas2suW2o9RnTPQH3TWNSnY28WmU8DLoeor6hGz2gSDMdNuOTV1BwF0j2IwsYCoD0AMWnwwt3vyqG0MeO63RTIaSNS1GElm3veZGsGKYwStHeniS3is/iCcQt2wl1qJGe47yXJdV68ePIqtYvgK7EsXO3zZQZzPPCA0+cP5xKAIIqttDCQwMoNGdZRU/jzjsEvy6VQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8761.eurprd04.prod.outlook.com (2603:10a6:20b:408::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 17:03:40 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 17:03:39 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 19 Aug 2024 13:01:18 -0400
Subject: [PATCH v2 09/12] arm64: dts: imx8mp-venice: add vddl and vana for
 sensor@10
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-imx_warning-v2-9-4c428bd11160@nxp.com>
References: <20240819-imx_warning-v2-0-4c428bd11160@nxp.com>
In-Reply-To: <20240819-imx_warning-v2-0-4c428bd11160@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724086982; l=3799;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=YsCVGi2xLSOi/kR+JYnICx2+6DdcUk/FyLqi5HaFz0o=;
 b=rXRA5PGYj3UKtbpkMQIXs5f7j8KODLSpXX9g22XMeVQF+4KGvYEfut9JaZwBf33hBgSrgq9mp
 nW0QoCW8fVpB554jW44R96Kxg+9zbYvZH6e7Z1uZHKM3VWjPpoc+NFG
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0205.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8761:EE_
X-MS-Office365-Filtering-Correlation-Id: e642faa7-66f0-4004-ce6e-08dcc070df81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UCtNODBNdjFudlAyYS9PYkw0MngrZjMvbWNJQ1pCWmlmV3R4ZDUxNFNJNk5w?=
 =?utf-8?B?bTFqdFFqRTd5MkNYYU5LMzg3TkdKR1RGZ3VYdG9XTXo0K0xCZEtGdEZPd0ZP?=
 =?utf-8?B?MnZhaW4yWVNTclBWUWJxOW9QY2pMNEM3bGFMWUtFWFRpV0lrd2tYaGJjNlhO?=
 =?utf-8?B?YkduTmFkMUVLZ2p6U3pZck85dENOYTZRWmZJSysxU0QrUW5UUWZGSXNTVVRu?=
 =?utf-8?B?ZFBkZWZCemI2aGJHb2xvYlFKakxjTWxaQllWekJwMVNGTnRaS2xhU3A0T1hm?=
 =?utf-8?B?eGxZZXoxL0xnZHRjY3gzeUhDalpzdWtKdk1TdDdoS1ZRUXhSWDBudUdzYWJu?=
 =?utf-8?B?am1EQ2hjekRDcXVVZTY2R0tCalJDbUR6OVUwZVFybnVUSFU1ZkV3dnpsM0pY?=
 =?utf-8?B?V2VmN3ppSFp1UUc1OE01bk9NK2JUbm1YWkdRWTZQMEtFdzNGOUFUSG93V09B?=
 =?utf-8?B?ZWl0WTZCWDdBUWdvWmdxZUpzVDZyVkp3cDVOeTZYZ0R1SGdKK29CUHlPZzhz?=
 =?utf-8?B?ZXJBN2lidnU3M2xaOTBpTjRWaHI3OUdRajZaUmFFWVozRzA2QzZKaVgxVnJO?=
 =?utf-8?B?azFNUXlnekVZNDU4VjBhelJYVzRtU216THZJME5nR3N6MzhZLzM3THUxRWVU?=
 =?utf-8?B?d1daWnl0UmJyVFEvSmxSVUtkNkR1Q1R6RDgvVk5pM0JaV0J0Y0tBVlFyRklD?=
 =?utf-8?B?dnBHRHdZNHlSQmEvRnJOQURkMjNqdlhtNTV3ZmdBWHBudGFiRm1BS0NWQlJE?=
 =?utf-8?B?ODc3WDRyTXZsb2tGZ1c3R0xCTDdlc0dRRXhuMjNqK2pVMUk0MjBXTFAya2Zh?=
 =?utf-8?B?S2F2VnBCdS84R2Z6aTlNaUFjZXNFekc3SzZnVTdWd08rRTFKZXcwN2Iybnli?=
 =?utf-8?B?eXdMdk9aVFNJZCtMMTlJdzdpdHBkT3dzdktKS05GelpvM2ZCVE12T0xTbzZi?=
 =?utf-8?B?M3ZEdDcvQkt5RXh1TnlMZzBKQ1dwUnpxRmIxZTVKSW5XcjlqQWVvSCtqWWVa?=
 =?utf-8?B?YzRPdklndzllOUF2amxFcGJ3bVY1Ni8zT1czYy9lNEs5bTBRRWtHZTRMcmhy?=
 =?utf-8?B?NGs1MXZoK3Q1a05VQTJuNXJ6cElMQ1EzdGJrbkxkTFd5dUhib0ExeG53K1BU?=
 =?utf-8?B?bW1lMUlLMmJoKzF5K2tIeS8rRndFTDhDMnoydE5qSExPL3dGSE05RStWckdk?=
 =?utf-8?B?dWdFcmVCTmk4cjZ2STlDbXYxRDJhMkpSM2d2ZnFPR1FRZXhSL3hvMjRubDdO?=
 =?utf-8?B?QTVkZUEvaVpTcjdtKzBheHkvd3RtVHcwTTlxWlJ0SFkxY2NPQnUxT1hpK2VE?=
 =?utf-8?B?VzFMUkJ3NXdoQ1hNNHNSTWNnd3A0eGdMUmk2UVl4WW5oc1dka2doZ0xRamt1?=
 =?utf-8?B?ZEh3VXhWUlVQaGw1NlJIMmh0NTl5T0pFblZ3NUJPVGdERDV4ckpUanBtbHN3?=
 =?utf-8?B?cG9La05yeGNaVFBBQ3JBaW10Tk9jVUx0Um80dVRFa0Mwb1RBa0hSNXB3ZVdi?=
 =?utf-8?B?MWdoN0RMZmhic0J4NEc2VlJmdURNQy9nTDFIbW55eXJ0RFZVTFlJQ0JnTFh6?=
 =?utf-8?B?bDhzZUxBc1ZvVFVyVG1DUlg1Rk5RKzUyYW0wa0xMcDNOUmxqQUZ6bXlZQ3R4?=
 =?utf-8?B?VkQxNEFNcFAySDdYYXNwa3VKRnJWcDR2bmNNak5oc3IxTzFORzlQem1sUCs3?=
 =?utf-8?B?amppZ2tSTWF4dlU3emRFUDM2eE4vSTMybWhNV3RZN08vMEJPSkp3ZEk1THh6?=
 =?utf-8?B?RTcvbDN2Y1ZPcW5la3pGaG8xbkwzTmZNQnJidEV3eU9sWTJmSXQyL012UEFZ?=
 =?utf-8?B?anFRclcyS0JwcnZXMHg3eEhxT2s2NHNSRGVyc0tMdEdQcDNDOWhTQXhrVmRl?=
 =?utf-8?B?NWNuY1JDTnduY2dUeG91ODRtcDJkY1RnN0lzaXpRdmpsb0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXhsb05mYXBON3cvV1VFaTVmTHl1VWxBM0MraGpZOUhOeGpha1ZqL05tQ052?=
 =?utf-8?B?TVZWVngwUFdhcjhWZGdNdTlsa01CdTY2eFVhZTJNcG91YUx2bEZHMndiUEJq?=
 =?utf-8?B?d3NLR2h0UjlpR0pFMnRybUhDQ3FpWkc4NjloUFRQeU1oWGRmWjNNZXFIQXF2?=
 =?utf-8?B?MmZRd0wwNWY5YXJHc0pRTFZsYUlMQncrYW9pb2Z2dncvTHlJRDRweGdZd3NC?=
 =?utf-8?B?ajZIRHhlL1NXRk4vNjBSSTN3NnQ0M3hSMk1vRnpYbmtYUE1oN0pEbkZlS1FO?=
 =?utf-8?B?aWFxMXZaS29WVCtKYnhNdVUrMlc4ZXhVRFpjN0o5ZDg5KzRkaTZSWEx2QTR6?=
 =?utf-8?B?RUxGbzZSM2ZRR0QrSjJIOGoxT0ZueG5tTTZ2ZWpEWStibUhMMjdmMWxrYWFE?=
 =?utf-8?B?Yi8yZkxoSWFEdmRVNFZrZ0srY2U0VVl6cW0yQWZjNFZNWW9aQ1Q5NUhjaFN5?=
 =?utf-8?B?eTB4bmFXZFZQakEzaFdaYzlmL0RKUGM0Y0lQc1FUWEpWZkt6ZzlRYkk0eGFj?=
 =?utf-8?B?OHcxQzNCZjg1Ry9VZWQzMVFicjhVc09PaEQyTlc0VGw5QTgvdHFhSkNmZXR1?=
 =?utf-8?B?aXRzd3BpYlFXcEIrVXgxQTRWaEZ0VzBQemQ3TEFucEVhUVI5THFjajQrTGYv?=
 =?utf-8?B?WnFwdmFTcG5acURTb1FmOXdxa29VY3NDUG8vM0lqSlNnRk5neVA0MXo5Ymc3?=
 =?utf-8?B?L2I3eTRnc3FuZWhDNXAvd0R5QmxtZDBHSUo2UWdRWmlMSHR2cXJmT3d1cUdW?=
 =?utf-8?B?Mk1SRDByMTVlNkpCK08yR3ZocHc2eGExYmM4alI5bklabDBhOFIrSFZHOFZN?=
 =?utf-8?B?VWdGSUZ3ZU16bXRjcmJ5N0RFa2pTUHluWUNSUXRGeDExa1pmQ3BQcDBFdC9S?=
 =?utf-8?B?OElwR2hmcDM5bjVVNDRYUjV2ektycE45MnVETlh2Ym1rTHR0RW9LdGRoMUhV?=
 =?utf-8?B?Vkp0d2RQZE9kaHFJZUNqaUJVYXhOZ1RaTVFqSVVUTzAxMWpET21SaHhrTitT?=
 =?utf-8?B?YXdQTnFYUWlOTXBCVXBueS9Kem9hcnJ2TFpPQXpYM0NCTVFqdEJvajJVUlhi?=
 =?utf-8?B?b2tFNERTWE9UbFk1U0JJVkdtSmRiYm9HWlZza3BQWjlxRnlkQ1p5Q2tyQVlH?=
 =?utf-8?B?K2UrT01XMDA4V3NHb3RmV3A0QlRpQndxTG1NQ21Ga1RtSUhrbXVZelR0WTNj?=
 =?utf-8?B?T2FndHhjYnFmYi9kNnNFQjNpMVRIam14aEM2Z1ZMOVk1MUVReDFyTkFYZjNr?=
 =?utf-8?B?dlU5SjRuZTlFYUkzV1VuR0dzK3hiVGYzT3k1U0xxM2FyaVZWY29EMlU1NkQr?=
 =?utf-8?B?MG5pSEhib2hUTjZPQngyZzd4cllCWWpYa2U5TjBzQ0J1aFgxZkp4SU9jQklt?=
 =?utf-8?B?R2hIcStGYndDNFNTZVZ5dDBFRmNzKzdwSG11T21mUFhCM0VDczF2MVpwQzl4?=
 =?utf-8?B?a3NjeXF4clVoditOelhEeUtUVVZ5WXdldDZWblJUVEc4ZEVmT1h4V3NJcUpK?=
 =?utf-8?B?OTc0c0I5dlZLeDU5ZTZLM2FYUllYRmx3TlpPNG1weXpCa2lteWdVNEcxZy82?=
 =?utf-8?B?QXNFZ3oxNUx1SjBLaFZIV0N6b2s3S0NqSG44NGFxcys4WGFjZE5TUkpyaW9q?=
 =?utf-8?B?R3JvalVxTm9SeFFoQ3Z1NFUrNTkyVTdlaGozaGF2U2o4Y3VreThNM3pxbHUz?=
 =?utf-8?B?RHp4Sis3M0ozTmZHYWhKTU9ieHUrc1psUHpXRHl4QS9abnA0YjMrbjdIVXpj?=
 =?utf-8?B?Z2VDS2diYXVpRFdVK0NsdVJqV0V0RlJGdDJEQnJJdkFXYnlITGJsR0k3eU5G?=
 =?utf-8?B?MS92MnhseUlGUHFiVWlQeHVvcnpnY2RJNEhaa3dqdFpaOWJZVHZkazJyUTBG?=
 =?utf-8?B?WWhtVGc1RWhJUmVNa2RtSFdRV1pWVklMdlQ2TUVYZkYyQXZjTG0wamJYWEFN?=
 =?utf-8?B?SXUvcmk3MmNLWTdYeWVzNHBXTjkzVkNCdkRMa1VYcmRsOGFrU3l4NTRzcmM4?=
 =?utf-8?B?ZG5HSk03enpuRmZ5bll6VGdQSWRPTGdxZGtaNG5nMzQyNjBsbWF1SGNneVFU?=
 =?utf-8?B?K1VhMU95OGpkdGNvNjEyc2JvbDRkcjR1RFlTZmU4NmF6eEVZeW9QNnFjRUNH?=
 =?utf-8?Q?ZIxx+hl3NlrvzpAifmFYKTunK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e642faa7-66f0-4004-ce6e-08dcc070df81
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 17:03:39.9211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eYuwB5oqbo8IdvcpL1oE6VsUTxjQDtMmtCfHwKFS4P1/LIRKn/vWVbdXjxLMPgnywBtX7OZmiyEOESbUjgtBTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8761

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


