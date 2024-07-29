Return-Path: <linux-kernel+bounces-266308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF6B93FDF6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317C41F233DE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 19:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323DE14F9CF;
	Mon, 29 Jul 2024 19:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NXZfHHbY"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011036.outbound.protection.outlook.com [52.101.70.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3721218A926;
	Mon, 29 Jul 2024 19:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722279606; cv=fail; b=dIbWFuaBgdOiIzHtETjsRh5m//JEU60NW0wXyQSP7NYFRCe8w8QScHS2liXrLW7CuI27iLX2+5sv+0wM5QljHnbT/Cul35BIdfhZ36M3S7QjE9ka1FaYUT4AhBR7E8qtaBondlXOIZMotYYrReR+0D1b2kMDxYk+Wc7U30iKNk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722279606; c=relaxed/simple;
	bh=yneG34hXW82InUQpv/wwEySy4yd74do0stIK7qyKl0g=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=IuiP+BI/ceYg7PFHrblphACnadAHwCk8ftrYsJpgAfVdxfmwPDUXuiqxGV34W9DOH/Hg410ozYIE9CRbWLjcAzNT+QDAQarjfWRsQqsKtzbYjkdqSXK3WIcJqP3w07bKf8rR6uQe6fWw12z69DxVSJDq6BXI3Rexq02Nr1RKll0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NXZfHHbY; arc=fail smtp.client-ip=52.101.70.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJdnV4ewoJgVBYrn3qJy0H8v41MbdktcxOQV7IE8HuoSv99LEPNj8PTa4eZmYSR/+0b3xe/uDAnueHPcmmLup3nbif9IqbLszlssfenpvkUf8zBOaKaBksV27yk6FFe7p5/Eg+8lOQhawU4JZOdFbxN3ARuihjDhP0f5+L7vcrPJeiOpaqvEWrGE+KtimVrLl3QoqZWKh3UYkbgUcYjfU5HC3jnKUtUVT63a+DkOqGBVpp+aN7++f5vaDbhBczoIVOIoRMjKbjugAQj2+86Vpu11iKxoN84PZMaUc56qTvMAeKULbWfyAXeOkSAj1oMnTv8elwM6HA332e+z2RKWmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJUzVhGqk3fk1vsRYDouFFZ2fMpzlTRj3LKx5egY7f8=;
 b=ajc9meSjaRoKApjPQpVta7rWhpVDggv+7JrRuFykgyo/AypWx1warl+rWxymQXOzVZ7UN+nC788IsLZhCf2ftkeptdSiz3ibOXbcLJtbWh00RAZYuGD5B6cgHWRlINwQxUgKjqotSJqxd6se6rxkrzSJ+vybAcrUSzZNnLYLsbBmWoUsOFS11EY+OQxcu3SVqXTWjYr9b4r10jUg23d9bJTk365Kecl9MV/acnSqCUk0pKkSa6G8MJZzzN1UUMQfzEAWopY3zDP/p6qJW6y/xdbzhwRroGIkV8zZA2BVyvyV8KHBq6POKib/rR4AroEzCqKa0EyLp5/kwlABPsj2jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJUzVhGqk3fk1vsRYDouFFZ2fMpzlTRj3LKx5egY7f8=;
 b=NXZfHHbYMxID2rAC4UWn+HQEiD2y3VChPRtkBz8kdkbqVFQ+hzPqUqnvJCDBteKux3x0mbpeLoiR8RGsOwKD4ERnOcZvwtJS8wEapdiLuciEEhmRq8gXIHpfIDfQ0c8TYreSDcOlNPlEB/cAFahrpO/pMBTsncO0x67DR+pNgnNb5rNKfCi8wKO2NojXpWPoo7pH30mKSAXL70uU/qBUYLJbrpDw04TTdBFST6Qaxtd07ok1hhH+KgvtZcWRi+8+oesjgbLaQJtGGJwZJJ/tjpT3z8S54ZIIvL61fMBSipq2UvVoeEeCsSTa4AtYq7mt/GBwKy9h72QZLOSMk9mFDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB6939.eurprd04.prod.outlook.com (2603:10a6:10:11d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 19:00:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 19:00:01 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 29 Jul 2024 14:59:27 -0400
Subject: [PATCH v2 05/10] arm64: dts: fsl-ls1028a: add fsl,ls1028-reset for
 syscon
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-ls_warning_all-v2-5-942d80ddd441@nxp.com>
References: <20240729-ls_warning_all-v2-0-942d80ddd441@nxp.com>
In-Reply-To: <20240729-ls_warning_all-v2-0-942d80ddd441@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722279587; l=1448;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=yneG34hXW82InUQpv/wwEySy4yd74do0stIK7qyKl0g=;
 b=HOUFMzLyMUy3F+BVivvjRbuUU1de5WsitzktzHyyENzMRpRRSKqif1B+6JJvp+1p4i0MSyYy7
 Bz64ErHXVqhCfEn8JC3ohn705mUeaDDeU8bcfTiKgBfC2K04ztnLV8n
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
X-MS-Office365-Filtering-Correlation-Id: 881bd816-af32-4f7b-471b-08dcb000a661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlFsVS92SldOSDlKeUpkTFQwRGFWM3hzNnBvMXg2VXhLQTZCbVBtZVNjUVlI?=
 =?utf-8?B?eURBZzBtQVVtT0tJTWdEK291N0Z6b2sxWmxtUU1KV0RxWWhnOXBzSmhQWUZq?=
 =?utf-8?B?dWU2YzQrV2ViNnVCQW9LdmlQNldJcyt2L1loWjFsUVJFYlJtSlpueW91Q012?=
 =?utf-8?B?eWNTQ2dJWlRiREp5VEpuVlFwWllhZVhYOFZNeGpLOWI4c25Hd25aWmxBSHpG?=
 =?utf-8?B?NTRRTWQ2Tm4yaitXOGR4K2x0dDkzM0ZWWE5pTHNmd2lKWDJRTU4wcHJGT3NT?=
 =?utf-8?B?TFBUbVRpY0YyZyttTVlReTYzQ1hrNTlycElLQjhrSllpZ1RGV1QzNTNBcFRu?=
 =?utf-8?B?ZjZIeTRXOFBFbklTSmtndmJaZ0c1dlZkb1JrTmYvTjdLcnJoVmExUWkvQTZT?=
 =?utf-8?B?TS9VOHgrVXlQalp4QXdTeWpDQlBxMHliVHZyYTVuRFYxSG5mUEpqYXB1Rzdw?=
 =?utf-8?B?UEFKQnZWVXdaKzhLMzdVSllHWmsxTS83V25seE9VSnpyOE8yMCtmNnRaSGt1?=
 =?utf-8?B?c1hVeHVHaEZ2REo5dkFYZERZMittSWMwcGU5eC9RemNBR3Fub1JQM00zUDIz?=
 =?utf-8?B?YW5RdmVqZ3p5cTdVSWNpMjRFanJPbmJtdTJ1Z05NUmNBZE5Td1FleWZDalNV?=
 =?utf-8?B?Qjhxazl6MWRLa2hGNGorQzM3clMvWDc4NjlHMWFVamhLcHJ0SWFMYTVORTlU?=
 =?utf-8?B?RVc4ME5reGQ3ZDRNYVZyeVo3QkRNTFhYUjJjZXJhWGczYmZaSHA0WHVkdzUy?=
 =?utf-8?B?YU5MZjdJUGNWNmkweEowQmZxYlBUaFc4SU0za05TM01Vd0RnSVlZcy9objJs?=
 =?utf-8?B?ajNHM2NPa2FUUzJnY3MrRWZHWVZGVm5GVUtiOXRkTjR4a0xHK2hvRFpmYklj?=
 =?utf-8?B?T2VZdFY1MjdxN2wyY1Y1akJzdlVQdnA3TXFVMTNzUmE3RFBjR3Q5dExtL25K?=
 =?utf-8?B?cVA4SWN0aXcyUUhyN1huTi9sbVVqTmx1K1pLRllTeG5rTEx2czNLT3hzekJ6?=
 =?utf-8?B?ZERCMW83eHNrZTlCa1FYWUJGd2VlUDVnQW1xeVNKQ1pWSGkwQ09HTy9zSzFM?=
 =?utf-8?B?SlRnNUNpWUtGdkVtNXZBbmNzNlppdzI1UGtuSlhLRDlQWWdER1o1MW85aVdr?=
 =?utf-8?B?cEcxaUZPaUFJQUFZaE85Z08yTFlJd1lhMVloT3FkNW00WHJVaW9FdGxncHNT?=
 =?utf-8?B?c2NVeEt6MHFnUG1KU1hNUUJLSmFpUm5LODJQalREUkRxTkwzeVhISklXTkEv?=
 =?utf-8?B?Mno1dkhnSTgyeDVqU3M0Y2pUZjJWVWQ1Y1JYcy9aNHg0VE9veitYY1Jjci9x?=
 =?utf-8?B?Q1llQWFCclkxR2ZsTS93REM5cFBQTUs2bHp2WCtETTI5MGpQdzJRL3RmM3d0?=
 =?utf-8?B?WXBpT1RVM0Jsb1QwbFB2R1VuVWRwWU1iZjQ0L1NMN041a0dxenF0RStCcUtM?=
 =?utf-8?B?TVdoSEgzd1VndmpXempJckRHSXkvbmdib2FDOEhjNU1kWkIwbnpuU21iSEpl?=
 =?utf-8?B?R1BjRFlQdjk5elQzaGdnc29oR25heHhScHl1aTRQVE5zM3F2RllUYURHWWhU?=
 =?utf-8?B?MzlSZFNEVmQveG1zaWduT0FNVWVPRUo0WitUcXdaM0xmWm15bzVnUlFhR1lw?=
 =?utf-8?B?Uy9NMnhtK3E0cHZiTDJTWEsyTWtzUk5YemlOMWxiWGRncTgxdmp2ZFZZY09Y?=
 =?utf-8?B?YnlpVHhoSHIybGsxcE5rdFlaQ2pib2xBVzJmd05LYmQyNVlNLzkwMEJ3Kytw?=
 =?utf-8?B?dDAxeHlkdml3VHpXSVZlNnJJYmkzcTN6UlNtMzRUMnkvWE1XdHZYUzMwdFh4?=
 =?utf-8?B?SDVDUEwwMjlRZGwrUUhINzhsWTlRMU16NVo2QWlxTVNpYVlLOFJqZHNSUGRG?=
 =?utf-8?B?ejVFUHh2dmtWZUtqVmZGTGcvcFZIVjdNUC8yTVNMdmxrVEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmRNSzVxTHFvM1FibVNzZWdndW1YWU9rYzd0RWJPVTRtNk4zaE9Bd3FWSEJs?=
 =?utf-8?B?Q3VmeTloNk00akNjU1ZrbllQS0pwS1R4VmFOdEo3TGZjSnBrQnJLbFdVa0Zi?=
 =?utf-8?B?UUlDR1FrQWljYjBMMVkxbStTc01SOW1zcldrVFBTRGZINzRLeXpROVlhcTRU?=
 =?utf-8?B?ZzFESHlKencxMTJkL2V6Vmp6V0EzejFLY2k4Z2JGZXE4bmRCTFVIbDVRaVJK?=
 =?utf-8?B?bDVDQVNoc0FVNjczZzdNdk9YdDAyd2xTczI4bk9tNHZLYXovVkZsckhlanBk?=
 =?utf-8?B?cHlRVkRkTnU2Wi9HcFFVNFNxTDBlMVpYUHl5dE12eEE5QU5UMmpqeENhYk4y?=
 =?utf-8?B?R1R1cEkyWXNtVDlBcEs3YXBkaDZuWG8vUldKSXJrdU5vSDFGK2xERGdCc29W?=
 =?utf-8?B?blkvWXRrQm5yVkx3dUNIRGNNZjVqejFFOE16cnc3TTdPVVEyd0RZRVdRN3RM?=
 =?utf-8?B?U3NNbVlzUzNITmZMTDJ2WTZEaDg1cGw1bUo3SjBIOWcwOHNGb1o4dEIrNlZR?=
 =?utf-8?B?VnYxVTlnWmZBVWljRGZjYlhZRmVaQnN0U1ZPN3ZUL2ZQeWtzcTBzTmRTNE4x?=
 =?utf-8?B?Z2Zha2FDb2liWTFtZWErSVdCeC84WWJwanVNTUNsL0dORllNU3RmRVVsU2pl?=
 =?utf-8?B?YXNFdC9jTUM2N3ZoVnlLN2FOMUFXaUg2WEpueWJCd0w0TGdJNEVxY2JvQ21r?=
 =?utf-8?B?aENRVENJcHdvRlRYUjNRNkUwVVp3RUtzZlpYM3BxRnNaVWtxUHlKVzdNaDZL?=
 =?utf-8?B?b1JFRmZTKzMzcTkvRkNleWN2K0tNVFBKL0gxTmFnKzNIVDVEdE8xdUFOZXlh?=
 =?utf-8?B?RGM5LzQwcSttYWRxaEJ5ZFNWNFFZQVJ1ajhSQzZUcW82c0xqSWwrQ3JLMmRE?=
 =?utf-8?B?NGdqY1REV1hiZk5NQmVib2c1SW5kbkE0SEdXb1NhV09tbmdDOUsxZTV3VjNV?=
 =?utf-8?B?RlZjZFZRNTMrRzZKSG0wekY3cVd2cnd6L0ZrT09RVzZhc0ZpMllGNEpLL2hJ?=
 =?utf-8?B?MEV1Y1hBVDJBNmwreWh0aU84eC9SbDJmQXhhMjh4YUZ3ZVRIS3JNTUNUUWNs?=
 =?utf-8?B?RXp5R0I0UGc1NHBIeTdOWTBsOGlXUEN2YlFHeTh0ZDdrbEJ6UWRlbXR3bFNn?=
 =?utf-8?B?Y09OUmovUlBMdmJGRlloUStxUDRtRlc2SDNuTVZHNTBDYTRBVHg3MTg3SkJx?=
 =?utf-8?B?ZG96bGFHcjBjeS9YY1l2ZE1RbkhWV3RBYkJ5cGFCekg4N3VNQ01hYWI0OWNY?=
 =?utf-8?B?bTVsNi9ycTJuMjRPTzkyUVptYzB0YjN3dTZETUJ0dFlaRW1RaURvVFZ2UVlY?=
 =?utf-8?B?WHVMbTF3VTlUcnlzZGZYTlNnbDYrZHZhdXFCWE9QYktZSFpBdlAwclRGdDJJ?=
 =?utf-8?B?ZXJwdFpmeHF0TmUwbDV1K1UwdDlKNXpzM1lLS2dDK2NqVHRPRlNxSTZxbjZY?=
 =?utf-8?B?YTNhNzBiVzU5MDdjMktRQXhQVXJlcFluUmhpR09xM1lVaW5ZaCt4eU56cGtm?=
 =?utf-8?B?OGtwVTNBeks2RzE1RUIwY1JEelVmYjVPSE1ZWEJuOU1vTW9tQ2hTTFJsTVBX?=
 =?utf-8?B?VFp0MzMxTEVSWnZYaWhzVTVYdlNSb3gyMUJTTmQ5N2hneHk3UkpwU1hFMEU3?=
 =?utf-8?B?VWkwS2ZoOGw4Szc3WWtrWjlaNUJqcXhZY0NpNEdnWUJ2YlowQkhUamxKNTdB?=
 =?utf-8?B?RHVxSDRVeUNHZE5qbjBkR0l4Z0sydEJBaFBaQ0szVkJSK1pkVmttd0pXT2Vn?=
 =?utf-8?B?UFVscGcyVU9nSTVtV3E5aFA5WG94L21EN29lenV3VjhNdDF4NlI0amx1aWZ1?=
 =?utf-8?B?YzdnNE1DWTU3TjQ3RGdVQTVYNk5ha1JIOFNIczJ0bkJ6Zjltc0NDUjJ4YXN1?=
 =?utf-8?B?MlM0bE1uTkEzaDU5R3JmemkrME10bTllbStWbHl0NWZaUW1hc2w3b3pqeVUw?=
 =?utf-8?B?ZUdWWVVxREJ0WFhKcDZ3c29HbElmVXA2ei9OL2srUU5uZjNBTkJLNzhYSHN6?=
 =?utf-8?B?TUtrbWo2RjU3NW15QlpKSkxyUXRHd3RRNGFwTE5WUFU2dzZ1Y0hRNkI2bzVZ?=
 =?utf-8?B?WDA2Z21sTWU0TWFnSkRLdnNCdUIyTXV6TTNOazJDSDdkajZMZGVhcVBhdnlZ?=
 =?utf-8?Q?U1eTWHPjbr+SqDS1DKuiO/omi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 881bd816-af32-4f7b-471b-08dcb000a661
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 19:00:01.8391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hsH+eGcjlpKb/NjWZPg56OErPeNXyjZm0hqxXL7j1RhdEtuwah7O/0+DI+xdoe81DD9wFqteSBjEsd82+FH02Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6939

Add platform specific compatiable string 'fsl,ls1028-reset' for syscon and
move reboot node under reset syscon node to fix below warning.

syscon@1e60000: compatible: 'anyOf' conditional failed, one must be fixed:
        ['syscon'] is too short
        'syscon' is not one of ['al,alpine-sysfabric-service', ...

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 24e86abe88ea1..701f0b2a3e579 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -112,13 +112,6 @@ optee: optee  {
 		};
 	};
 
-	reboot {
-		compatible = "syscon-reboot";
-		regmap = <&rst>;
-		offset = <0>;
-		mask = <0x02>;
-	};
-
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
@@ -235,10 +228,16 @@ fspi_clk: clock-controller@900 {
 			};
 		};
 
-		rst: syscon@1e60000 {
-			compatible = "syscon";
+		syscon@1e60000 {
+			compatible = "fsl,ls1028a-reset", "syscon", "simple-mfd";
 			reg = <0x0 0x1e60000 0x0 0x10000>;
 			little-endian;
+
+			reboot {
+				compatible = "syscon-reboot";
+				offset = <0>;
+				mask = <0x02>;
+			};
 		};
 
 		sfp: efuse@1e80000 {

-- 
2.34.1


