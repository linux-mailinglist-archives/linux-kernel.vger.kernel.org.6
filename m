Return-Path: <linux-kernel+bounces-365432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 037CA99E230
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 11:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 277F21C21E83
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD221E202D;
	Tue, 15 Oct 2024 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zb1KIIGf"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2071.outbound.protection.outlook.com [40.107.247.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549911DE2A9;
	Tue, 15 Oct 2024 09:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728983147; cv=fail; b=jgrn0zHX+540noyuFFlfY3VNndl/b9wMaHgBb+KN692uDzU8uep+UDcwnkMZZM/jgU3iJWcPSHiXAWyhzGRyUqIsj/qiTPIxKQVIWDKfW3hBcaEVir2ozoIcTE320AmPxqJ77gVCLPmCVtWm1Nx3e26ileizwOlSH/5JcciuGDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728983147; c=relaxed/simple;
	bh=pYE3/Q6exoCLJsnwweUy9J21x6w9vr/mPHeIgg5m5qc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WUmfAFYgCP2Qic2VC3F/WB1CKAbLmQa6sPS6tTsVT88RETeMU0YF3nUVOlIbcZbQV/5BocwBjnzWgscz6OIjp5AgqrbzcdSXGAlXm8Yp9hCuke13z8A0S0tjSUEGxXSABO+i3NYXHxsnXEbbnjunB2Hxl/PaN7APGucMYizgNvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Zb1KIIGf; arc=fail smtp.client-ip=40.107.247.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wqZx+/PlRjQ9OcKmltgYCQ7sqexQGgoOHUok+Hj/x/eTTnQgXOI2xgdn1Aw0VJNpm5zZDVOhyJtvEcJABSXDObHCPZIbRTlvp8A9MquYBSVUm4gF2JsBmI+ICYk5t5eOGzMhq7wymincNCM015qx9BLUU5hja6zas/aDUrHBjk7oDOvOlQ82zmdsSuMEfMiLFwcvc7u6UbV2Te9+sWiAdTAF9ZIPt2rUkSaYx5bkasniqogSruaCYUSmlZjL4Ebed8KeqYQrKmCmgfj6ydBZMW66lEffUHFg5iGTDSOLBXUF/iq2zXwIal7YV6lXug9BbKuxUz+dOit6fl1XBkNjpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gtkzixnwb0RPmDgVy9ypv5aH2wWPad0rOTiqgwx/eh8=;
 b=TEDEelsbInsAPhsoM52Kv8P34q0RM0gAc9/7CtRjUjOHn5bl73fBWfcz+VupfkcinLFVLJCGY3lrk210D4VeXtXb7N4Jntt5QfaIaKyb3kHbjCfXDqNfPQQsxb3Im5kLha3v17bxX7N849BRlSPzbGGfwLa0Kp8ld/6ycED91GnfByc2rccMtdQWAmj0d7vWTqnYV/JP4niXz8JdmAVWjf5XwmQTj7q7T7NMH6OB1rJOfKIwhIS4hWUflSoLhrIXL+o9pq6gnSSGKn+oik4Z/JcdSlHBjj6h2EZ5eGAmNEg1WxQ8jkcV1Kdw2JlAs8XQqdZXFYO1DYRLybjGn2V/hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gtkzixnwb0RPmDgVy9ypv5aH2wWPad0rOTiqgwx/eh8=;
 b=Zb1KIIGfDTbDmorwJGGN9rQZCYd/MnpBCZazKaFnXoqt9F5m1RuNa73Wmd1qte5ogDAFMH/uy99WUGmF4bwXP6DiLePDerrxjL17Y2Ziu0ahsAvRJeR1eoLKOOJ0au0qdFrMsxrKPbDemIgSsIOVqJ++fTLJDG6nRkf0RJ0jAvNMmghXXL+GgRc0jhaVC3QzFIxZlvh9vBy7pNhWQ3oTptdwfTVWLvSrVy/G5NtMCczFvs9usGRnrMJ3FAg/8VTx54eOMZpNGzkAk+rC1tBZbI90GuZ1YNPZpCpuFvS4RCZSAB0/i3clw6GEiT1PpWHheDwG3O87LxenoBLUl7hj5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by PA4PR04MB9223.eurprd04.prod.outlook.com (2603:10a6:102:2a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 09:05:43 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 09:05:43 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Tue, 15 Oct 2024 14:31:01 +0530
Subject: [PATCH v8 3/5] arm64: dts: imx8ulp-evk: add nxp secure enclave
 firmware
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-imx-se-if-v8-3-915438e267d3@nxp.com>
References: <20241015-imx-se-if-v8-0-915438e267d3@nxp.com>
In-Reply-To: <20241015-imx-se-if-v8-0-915438e267d3@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>, 
 Rob Herring <robh+dt@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728982877; l=2640;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=pYE3/Q6exoCLJsnwweUy9J21x6w9vr/mPHeIgg5m5qc=;
 b=8e1Z0/Ti8N9KWehTPPydtBSrd+kH5UfAUk8dTrrqfLR6hNLuE4urmzlOxD1HP0pzCTBGeQaE9
 O1p6SXtc3sFDWVffxCCWJmfMMLrMeTUDD3vC4zsCJ+2i29clSlNCrgz
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SG2P153CA0019.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::6)
 To AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|PA4PR04MB9223:EE_
X-MS-Office365-Filtering-Correlation-Id: 5344a3e8-8357-491f-62f5-08dcecf88ca8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0JtL2ptY1lkQ2dWdmI3ZThoaCtkc1pidlFCZ08xVFFMdFJRdzFiNmZlWHd1?=
 =?utf-8?B?UW9VYVZRUjhBNnRjaG1aeFVqQTcwOURMek90TVpOOVA2TzFKL3RVVHhGVHJR?=
 =?utf-8?B?WVpuV2ZLYlhvU3RvSFpUY1AxYUlORDZZcmkxeTQ0MWZtWWFBaFR0T3NldTNV?=
 =?utf-8?B?VnRPa1Q2RDh2NnhVcTFWYTdSZHRaK3ZwQXduYmNsMDB4V1MwdExDTEJRNUI2?=
 =?utf-8?B?WUNTM3B6Y0JmSVNBMjQ3VC9vOUlkYVdZbjdrTFNXNUhkOWptZ0JjVGdxNUV0?=
 =?utf-8?B?K1A5YjFuSFp3RHZ1K29nYWF1NExpTEgxOG9Za2MrKy9IYzN3VU9xVkYyalFn?=
 =?utf-8?B?S0F4RW5ZTmNGdGxyVXpORDhEOUdKZm9tRmJMOG5Gcm00MCtYWTlqQXUyejRq?=
 =?utf-8?B?TVY0MEs5OWd6RXNodTYvL1RUVGs2cGtReGdCMUJkaUc0ekdQdFFOZGNxWTIw?=
 =?utf-8?B?cGhvdmFPU2hROTB2cVdJcGtubVN6a1F0MDI2QmhqcDZmWnUybGhiaWRXNHhU?=
 =?utf-8?B?aVJGTGVsUFVPUzdrWnBwK0k2Z01nMGJZQjNZSFM4eVVpOVJoRjNibFlqZUE3?=
 =?utf-8?B?Yzg0eVlCZ3E5dXpHWS95RnhFWmV3VUJpMTF0VUxkYnB5SjI4WTVmM2Y4QXl5?=
 =?utf-8?B?UjdadFc0Y3U5aHB1R1d6SjhNemxHbVUrWDlURE15Q0l5bVAxVHhVVjV6UVdZ?=
 =?utf-8?B?dG05dVd0S0lPOHJDRjh5S2tWYkJFcG44a1IwaU9lNkd3VUFtcVBCM3czZWFH?=
 =?utf-8?B?WXRmSU5IZG1QTnpFUERKZTVwK2srQXp6YnRNY3FPUGNueTVUWmdGYTZVekFR?=
 =?utf-8?B?OE5nMTRNV2VjWW5IcXAwNjVZZ2FHMFk3MjVPY1h0VGdjV0hzTzRGN1llSlBz?=
 =?utf-8?B?ZGEyQy8yclhoMlk5RFU4LzJNU0lFdnZyMURsMHA3bVcva2R6eGFWREVndHV6?=
 =?utf-8?B?QjRTbmN1b0dOM3FKTWJNdmQzOFpMQVlNYUhDWmVKZCt2UHlWZDN6c2ozM0J5?=
 =?utf-8?B?V1Y1NlB2YmNRSGltY3p0SjdyNU1ad3VPNkpCcll6ZytqdTg3YlBQak11SXU3?=
 =?utf-8?B?MGZPMWhrQnM1M2cxWmNUU2dYNW9JVFRiQm5wQms5MnBPT2twVU0wSUdadjlM?=
 =?utf-8?B?VzUveStsU1g4WlhBcGZNQWxzME1HdDRPTHdBUWdjR0hXZ2RxZWIzQUZlL2RV?=
 =?utf-8?B?bjBmR0k2VURsMXRxclNzV25pQzAzUzIzamRXNUJ1UnNQMzIycjliQW1LdkRV?=
 =?utf-8?B?U1FweXBnT2JiUklaL3pqeTB6RU5qNDFKL3A3T3FCWjZJSTRuWU05WkZBMUdr?=
 =?utf-8?B?TFp4cG5YR3hFaFRDQk9qL0FkMGd3UUI2VnFkNFhHSEl0dys0NHgraXRDajcz?=
 =?utf-8?B?dHRHVDcrcSt2NkhYcVlsbEN6UG1EenlxQXBRcWFnVS9lQ2h2SmQrZTllbXZM?=
 =?utf-8?B?V2JIeFYxalBDTUxlRzFJaXU0KzFQZVRpY3hIK0k5NlE5VG5aVVFkVjJBeUov?=
 =?utf-8?B?UHlrNWwxSVYzMzFxUUFqcjF4RWRJQWx5SnJWbjNGWWxMTUc4WkZTdkhnenNX?=
 =?utf-8?B?TWlzSTgrSTFnYnRCQldOVm5vSFJOUUxXQjMwc2FVaU5NNHF0Nkx2b1FVY29Z?=
 =?utf-8?B?TEZ5aWtkRWVhb3Voa1Zrd3ZVT0ZSbnZwRFFvVzJYT3lhblhialJ1RFRvcmM5?=
 =?utf-8?B?M0JPS0ZWSWpKM0VrNTNEYkhHSGQzTndMNXBhUVYza0Jmb3czZ3pGVk1Lc1Bz?=
 =?utf-8?B?ODhiMGg0elAwZkZraFNORFdRQnhCZzZ6MFpuZkh3anBIN3FZckhoanJYQjE5?=
 =?utf-8?Q?pyNTIGZRN3binMz/E0gIpqOllUpEriEkPg75s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnRMRmNYTG41Q2hvZWxCNDMrU2g5MTB5OGVvU0RESVl5dE5DcFVwa2YrRFlh?=
 =?utf-8?B?V3d4bVRCdXNyZ2gwVmN6aXFPdzRES2NrazMwT3FrV3ptNS9tNEJQZDR1VEFW?=
 =?utf-8?B?dzc0SnpTWWpUb3N6dXRIR3VteENvN29aOFZKNllOcVJMLzVWbzQ5MlhEckNB?=
 =?utf-8?B?QSswNkRyS3I2bVc1U1JRV1R5VFNkYXNsZlYxUHFSYTBkUHBJVnpzZWZLSWVM?=
 =?utf-8?B?QVhScjhYK2dmcG04QjFZK0wzaUlyby9GYURmSUJ4d0JDazhWUmg0ZXVhYytx?=
 =?utf-8?B?bk1ydmp0dXM3Q1EzQWt0SHVPcHltUVFTTnRhOUFsRTZ3aU1RbW1rRUUxYVht?=
 =?utf-8?B?Rytqdm16MEVIT2l1Nm1PbEg5cEduMURzOG0zNUNBTzc4cW1FVDdSQzExdHB5?=
 =?utf-8?B?OTBWVHVmYUd3cjNTQmMzU3Iwa3FlMGQ1NkFSQUNQK0plSkpTR3FSQzBiRXVM?=
 =?utf-8?B?a0t4RzNnM0h0VVQ1QjRXU3puZ0hXY1pVRTU0OHgzUTN3N2d0dFFHc0d6dnNP?=
 =?utf-8?B?NjUzTzVQZU9XSVE2d3YvZVp4WXhDVXhzSUR4YjZXakhvaXJ4T3pLSnF0YWxI?=
 =?utf-8?B?VUxYQUw3Z3ZPQXRVd1piUnNZalVrZS94Y2pOV2FXazM1ZUFERkYzd3NyREE0?=
 =?utf-8?B?N2JneEZzUGt2ak82TzdzSkh3RnJwMitmOUJabGdVWVBGYlZIMEZaQ2w4K3Ji?=
 =?utf-8?B?NTJkekxYMUI3T2ZlNU1uQTVXYUtkMlJrSkpsQ1Nod2dWVDI1YzN3amJjODlJ?=
 =?utf-8?B?S1Q1RmdpODhPSE1CK2kya0F2V0MvSkxwVHpZaDc5R2FGd0R4aDZrazA2dDdx?=
 =?utf-8?B?dWRFc3hjYTh6T3R4Wmo5YVo1VmlzQkVOb2J4YU1DcFA5TE9hbE5mN2NYL0pW?=
 =?utf-8?B?WHhDOVVpOHpveTJKVE9tZU1kcmlDM1BLcjFicmwrNTRsRmowTjhOL2FKekwv?=
 =?utf-8?B?N2xBZGJnMWZhRGVmRVcwUnpabkpQQU9BNEhBN2UrUDV3VmRQa1BpQ1lpQ0hC?=
 =?utf-8?B?dkxQbjFnSjU5Y1V1L29PcUx6VFlBQmZVeUFQMGJMS0IxeE9Fb2l2dzRjdnE4?=
 =?utf-8?B?RTFjYUVJeTcrTkFyL2tqM2xRU3paMnlzbEtYYjJrbjRkSFBQNy85TVFkNTli?=
 =?utf-8?B?WjhZd3JHK2R2d2hJOTFtTWxmejRhUDNqaHprVFdPWDhDZThIUkorMVc2ZlhN?=
 =?utf-8?B?OFU2TmxyeU9WTlVaQTU2THcxK2VRTzhKNkVseEVWUVBPbFNwOVhZVzd0VUha?=
 =?utf-8?B?TXBVb1QzZW85M003bHZteHpOc2ZKaTVjbDhYQW9UM25lWnZKWVNtSlhvRVda?=
 =?utf-8?B?YytqMUxUUS9EdlB3ZHVTOU1QaVMvWlJ1V01qTWdVcC9rNWd2UW1kRFd5YkNt?=
 =?utf-8?B?OWRZQUhXOWdnY3BPS3NUbnBhOUpSaGFhalA2dDBaM2NoYWcyZ3laZmczcFN2?=
 =?utf-8?B?UEhYbkZ3TVJsOC82RmNwck5Bcy9QWEdkTTRTL2ZCTzhzYlFQOFVpbzFPYU9K?=
 =?utf-8?B?T3J6MlFJUCtkOUFTak1vNFRFR0dvOTNLMXg4cWY3ditpUnVQU2tObWpPTTQ4?=
 =?utf-8?B?MDc0bmdRSWZHbnFHTUJkamxjYTlZaDBsNkVHQ0hRakZsRjZ5aWhCVFcyOTdG?=
 =?utf-8?B?cXF4L041VkhCQThnS3lTNUJ4bi9tbFRDZmlEWG5YQnFqanVua2tub2ExSVE2?=
 =?utf-8?B?cWMxODU1V3dSVEExZVlTdDJqeUtJT0pXQk5VWDltZ0Z1Rk5yOUlZVTlVZVJj?=
 =?utf-8?B?VG5OL0hLVE8yaENnVEZXWFRQSDhmaENoTUE2M09VbFhPNmJrcmw0dTFZY0lw?=
 =?utf-8?B?aVVPd3JweDJTaERHSFhrZitkWWpCM2VLQ2dwT1YyZnNUVHlJakpwdE52Qnls?=
 =?utf-8?B?S0c2WjBoVWIyYzJmVkNrWEoxeG9SUjJrUmtCUEFBZy9VOFhEK3pma3ZwMERX?=
 =?utf-8?B?WXpLVUhpYWFHb2d0UUw2Yms2ZU1BY2prZ2hjL2Y0alVaZjZyZXVERnZwZ3dT?=
 =?utf-8?B?V1ZTcFU0TVEvS24xenpFeXZvcDJ3WW9VbVdjd24yV3NvanBKYStXb05nUzlY?=
 =?utf-8?B?R1VEVWFpbEE3UjE1RW1uTnRJZXlrNVROUy95SlVSci9XeUNEY2FtS0RoaVVy?=
 =?utf-8?Q?EkuF7JX1MpappDf/mWBRdw2Ho?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5344a3e8-8357-491f-62f5-08dcecf88ca8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 09:05:43.7099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I9kY+Ucn2PDyUE2N2dIRaq+UjUjt3+7DNKMhJ6DXKn2sYjzVCRIm2hahB3rhX102TYp/5DVL/v/YcYlYMdgcBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9223

Add support for NXP secure enclave called EdgeLock Enclave
firmware (se-fw) for imx8ulp-evk.

EdgeLock Enclave has a hardware limitation of restricted access to DDR
address: 0x80000000 to 0xAFFFFFFF, so reserve 1MB of DDR memory region
from 0x80000000.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 17 ++++++++++++++++-
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi    | 13 +++++++++++--
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
index 24bb253b938d..ca8958f28a83 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Copyright 2021 NXP
+ * Copyright 2021, 2024 NXP
  */
 
 /dts-v1/;
@@ -19,6 +19,17 @@ memory@80000000 {
 		device_type = "memory";
 		reg = <0x0 0x80000000 0 0x80000000>;
 	};
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ele_reserved: ele-reserved@90000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x90000000 0 0x100000>;
+			no-map;
+		};
+	};
 
 	reserved-memory {
 		#address-cells = <2>;
@@ -146,6 +157,10 @@ &usdhc0 {
 	status = "okay";
 };
 
+&ele_if0 {
+	memory-region = <&ele_reserved>;
+};
+
 &fec {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&pinctrl_enet>;
diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index c460afaa76f5..914d61b2275c 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Copyright 2021 NXP
+ * Copyright 2021, 2024 NXP
  */
 
 #include <dt-bindings/clock/imx8ulp-clock.h>
@@ -152,7 +152,7 @@ sosc: clock-sosc {
 		#clock-cells = <0>;
 	};
 
-	sram@2201f000 {
+	sram0: sram@2201f000 {
 		compatible = "mmio-sram";
 		reg = <0x0 0x2201f000 0x0 0x1000>;
 
@@ -167,6 +167,8 @@ scmi_buf: scmi-sram-section@0 {
 	};
 
 	firmware {
+		#address-cells = <1>;
+		#size-cells = <0>;
 		scmi {
 			compatible = "arm,scmi-smc";
 			arm,smc-id = <0xc20000fe>;
@@ -184,6 +186,13 @@ scmi_sensor: protocol@15 {
 				#thermal-sensor-cells = <1>;
 			};
 		};
+
+		ele_if0: secure-enclave {
+			 compatible = "fsl,imx8ulp-se";
+			 mbox-names = "tx", "rx";
+			 mboxes = <&s4muap 0 0>, <&s4muap 1 0>;
+			 sram = <&sram0>;
+		 };
 	};
 
 	cm33: remoteproc-cm33 {

-- 
2.34.1


