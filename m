Return-Path: <linux-kernel+bounces-266303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3F893FDEB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9411F2303D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 19:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C05D187861;
	Mon, 29 Jul 2024 18:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AsVzkR8i"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011036.outbound.protection.outlook.com [52.101.70.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F4518732F;
	Mon, 29 Jul 2024 18:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722279596; cv=fail; b=kcMx+meH4VenYJuCAWEV0WFDY6EDYV5uBBqRqgIw0mIsZbouKPW1kql/U8bqHfqH40l9lfBq7vlWcTjFAIHcQwKzxj4XWXjd4uKgZSkKQwoS2S2WFWdHBk6ZK80ajV/ZSO02ggxOe0mYNl73ChQIxgYo9djfRQ0QmzHLv7jw0Lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722279596; c=relaxed/simple;
	bh=JNscBK2V1CJqZrv4MuB4UPBN1EmHomP4RyAiiB7SmZ4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jhEJbzx+LGL34inlKYpSSele94XpTL4nyC9OmnVz7PCfKy++hn02OUR+2Ne5SAKOk90ExIpnkwxoT6CY4gclPrNsV1xZA+lUzoS2sawNMnB+NRoOHPM3DZQ0t3XG+M7uEgv5I9FQtw4XpOI/AqzaZ3rzMDNXP5MfY5qCCKAIMCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AsVzkR8i; arc=fail smtp.client-ip=52.101.70.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yl8C8MkPCLNanosAYx4/Y0fhb7EeMEJrjvVqaBlW1tCyrjM+b44tK9QyymRuSnJnQ+6VwAGTm4gHFtVGQPh6TnEoHZrBOe8fCnnS6O/zWU7k0d5J6VejRJs0aNZclRK+yxFa9LtRkS86cfYl8o87ZW6rfpduuLBId1796iN/bFbBJlbkpYstjy2RSjOMNsY5Qj0YbnB78Q5ZKA1bYH7B5bpcSnTUXvpPwTFFokttxLRcqlh4YI+fhTQRlWK4NbHce3giaGiGKEUsEG86C+xclWrZjUtxSpZsH0ahBhyOX49U9B4QHofpNOCl6BUp2pe1Gx59bTdQnadqCmsxojJT3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+4DSMoQE+MlX39V5N7QUT5m9VymlXyAw5GZYmRE5tI=;
 b=QI+y0Aw6iYt9tR1UCA1kx0IHvVpSUjexd0e0cZM/YfFsNW/e5MHjDfsfs9cYCL4SHqUM3BqKtIOfItUpAWc4lcKj1HtagpsFxTMAAoZHJB8dNZN/HQw8gbMBcomTxhaADtWXMVC4fo7xVI6/ZbPN7syRZw41XTeGD4PUjE15KLprh9T1xnfO8bUNiadyUoR9SCH1TSuhzvZBo5jpMkIm6oDkpt/bGSKK8/TzeH6IVn6aMFuwEgtXFuB9zp3k2WqCqwXmWpELoMHBmWG2yS8PTS/LRMKkAFIPLBdXoN/0tnZeEH38XWcs3bh2fO231GCGAyeclHXYt0fUm2JDT+lsgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+4DSMoQE+MlX39V5N7QUT5m9VymlXyAw5GZYmRE5tI=;
 b=AsVzkR8i27rEH0QJbkEMgIkDTqBdoV0Mm1205ji1Ji12BrPoAMlm0hAvxOw6limv9FkNuY2S4ia84BCmpGuZvrImGZaYUqLIS+EBVGpOm1UYe9QbPKRkrP9K2CeNpv+Dx7Kdn4hDXDRDm7M46Rp5Y5Gbi9QRGLBvqWwwhyTxzxtTB4dBTq9IM/uiD2u/dYq/Hc0d59Oq1Pc1ExoicKpj/Cp6Asm4NWHlJqBZkYq7lyupNBpn8hKs8EkMpg6FuxnNK5TkrsY8TMY8cjvLorHC8iX8uvu9LKSKId7tCzfXefa1yQdXENd1PdgtgzylnJmyVuCMEmRcxJHVhNw5DJ0LZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB6939.eurprd04.prod.outlook.com (2603:10a6:10:11d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 18:59:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 18:59:52 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 29 Jul 2024 14:59:23 -0400
Subject: [PATCH v2 01/10] arm64: dts: layerscape: rename aux-bus to bus
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-ls_warning_all-v2-1-942d80ddd441@nxp.com>
References: <20240729-ls_warning_all-v2-0-942d80ddd441@nxp.com>
In-Reply-To: <20240729-ls_warning_all-v2-0-942d80ddd441@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722279587; l=1576;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=JNscBK2V1CJqZrv4MuB4UPBN1EmHomP4RyAiiB7SmZ4=;
 b=UaWtwKa/ztHDP4ksIBJE6lHMD4etm1bc5I/0BVgGbbfbdps35pL3loLCjNSvXHrm9kNtF0mw4
 Juy0a8Jh1LEAdgmFg1iDDYNXI7FGOOvVnVk0/01AlIvP8DKDlgOGBr3
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
X-MS-Office365-Filtering-Correlation-Id: 26655b0b-3714-4f03-44d4-08dcb000a097
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajBrUWJYNHQ3Z3d1SWZNb01QT250KzBZa0NMdmtGN0g3WTVoSGVsMXBxOTFa?=
 =?utf-8?B?Q3lVWVVoWGdyK2RvM0NCMHhOOVhiQnEycjBsSmpWOHVScEVlRG51UzViTWJ2?=
 =?utf-8?B?Q0tseWF3b1FUOHRFNU9US09MOE9DUUx5c3lZMXFyQ05ESllYRUF6ai9JRExx?=
 =?utf-8?B?aXNQNE14TTBHOHBGVFQwWGhxTi9iUVNLSjJPbWJPMzN0NWZ1empGejJMeEZR?=
 =?utf-8?B?Z1hMVklGSXd6dXJhL0xjZVRPYzVxZFpSZ1FoK0VhYmZLWmFrVEpxelBRbjI2?=
 =?utf-8?B?a3N4eHgxZFVFT0VYMjJoMW9zeUluV0FHSFgyYmwzZjEvd0lTSm9iVDFmM0lo?=
 =?utf-8?B?L25qcG1taXhqVzZDK3VJTDNhS3FaY0g3ZTY5clhUUEpUMFdVcGJKeUhmcnkw?=
 =?utf-8?B?dEUwSjhva1Rsek5hb1hlK1pNMVJxaHlORnA4cnN3dXpCTU1FeS9KS0dQakZu?=
 =?utf-8?B?ak1ENEprSFg1Wmw1ZFVKU1BRYVpqVnJqZVV4Wmx5OUQrUDROSDZnYkhHb2FH?=
 =?utf-8?B?aSt1NUhxcDl4WG5Ya0NNWE8xREwyUFlhTUpHODBnWmFLaThIc1JSdTVGYVRp?=
 =?utf-8?B?d1BrQlZ4S0pLeEIzRW5QZ0JwdHZDUHNieElDYk5aVzkzTHhpVzNlblBham5v?=
 =?utf-8?B?K0NjZlorRHIvMWhEKzFhZHlydDI3M1N5RFVacHVxVW1ua2p6dDFzZXNRWkF3?=
 =?utf-8?B?MkZOQjBQY29OZjBLb3lpUUV1Ym5KbGtVVGpmOXc3MWJtclRXVUVJeFBhSVFI?=
 =?utf-8?B?V3I3UDFWSExLNXJYajNHbVEwdDNrOEhhSFNMWlNnSzNNWG9pU2xnMTZmRVFk?=
 =?utf-8?B?U2JTVnhDYnAzV29Pd0xNWEw2RHZzZFpzRDU4N0NoQU04YUU2U0R6Y0FjaW1U?=
 =?utf-8?B?eWxNb2FJREVjUU11cE5BVWlJZVR2TCtGYVMwOFB5ZE4zZ3N4UDA1a1NzbUR6?=
 =?utf-8?B?eStnQURPU1JXMng3OC9hdUFLdjU0MU5EWVk1SXJxRHYvcVdLaFJnUjI4R2Fn?=
 =?utf-8?B?R3lkNmlNQzVqL3dJdXUvUmpjajdRU1RWZHI3VTA1R09RUDB4VXhiY2V5NEd6?=
 =?utf-8?B?S0p0MVZNcjVlU2k3bFpKUnZVMUpRdm5BSEdoMDNPbW82amdVRW4vOTRrUGRo?=
 =?utf-8?B?enNDNCtyb2R5V2lPR3NXTDd5dXlqWkpBakxRZk5WU1FGYnBoWndSYjMvYVRK?=
 =?utf-8?B?VkpJNHJLWmVTV1lUdU5EOUxhK1ZUOTJmUlJVeHVmbVJINzkrWkdBRTgyLzZj?=
 =?utf-8?B?MFVtYmhGQ3l5N2dXWTVjcjQwVDExRHlSQ0VqVTc1dWpIeXlxcmg1Z2pJdHhF?=
 =?utf-8?B?K2N6TEIzV292c3BIbXZJTEdUY0FRZm1DaXNxellEejBlRlhWQmNRQjNQN1hR?=
 =?utf-8?B?bTAwQ252QWhFeXo4akNDV0lqQ2ZtV1dMVXRFVGI0LzlIcFdQV0F3djJSNTNF?=
 =?utf-8?B?WkY4RFZHNzFtUURMOFp4RGY0UW9VcVN6MkxEZFR4RVVseEZsOHZiUkVTaWVE?=
 =?utf-8?B?S0p0SG84NG1vQjcxbFlRYjBESEVQcVd4NHlXNysrcGpkakRIS2RyQ2RSM2Nu?=
 =?utf-8?B?YVhURk9UOFp6c2tBLzZ2MDU0Rit1Z0s4OVpCcFFnb1FvWFV6a1YyTXZaS3BF?=
 =?utf-8?B?cVFxaHN5SFZaR2lVM1RPaWxHVFJBOFBDL2RSbmhGNVVoSVBrUEs3ZXFFenZF?=
 =?utf-8?B?azd0Uk83ZHkyNC9iOVR3Q0Q2VWh6YlpEMGlKL0daV0NUdndpVzlkaC94SjVB?=
 =?utf-8?B?Z29MMUpEUUJ2ZFo0d3VRdXFiYmY1Rk9EcEpybUZNbVFhWTVTYnBLNXpyd3ln?=
 =?utf-8?Q?3YS/T/1Wd1sNy6Nxqkd8AC17k2+YM3QjWnEPA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2lYd3RHZzladWFKWEptdUtIaU5XeXE1ZWQvUFN1YXdweVF0MzhYYTVjdFl0?=
 =?utf-8?B?aDhGZ2J4K2tlV0lXSnpBNzUxR21kS3VEallmbHMya3ZKck1wSTY1UlppSmtN?=
 =?utf-8?B?aXE0anhUVjhpQXBrdjBqMG5wd0tyZTNPaE1uWjcrbmRCSUZ5TkZRbjgrM0tD?=
 =?utf-8?B?VFdtS2dmLzZYY1d2cjVDK0xPZVNxdDBpbDZ2UmtGM1Fma0dZSGpEd2Q5TjRY?=
 =?utf-8?B?ckhidmVtT2pCUXUzcmZUL051aDJFUGZCK0ptT0F6Z1FjYnZYdGJKOGxzR0dx?=
 =?utf-8?B?Qm5tUGR4dXExbFFCOFJsOVlMYlEyVjdIdzk2TjNqcWN2ZXcxNmc5MnZZNmFU?=
 =?utf-8?B?TTdxZTFuRlhZTDBRdFhnWnQ4Uzh6LzJQeWJrc25OS0JVZjNsU0RVUGU2V29w?=
 =?utf-8?B?bUx3SkF5b2Z0TVdMVXlqTGZQYTN4eHdaWEtMbUZ5Mk9OamV1QmJOK1lvWDVS?=
 =?utf-8?B?c3ZtcWNPUEpIZjZ2WFRuVjFmUno4Szl1WGtxekxxYnQ2SlBlR3JnU1htUkVW?=
 =?utf-8?B?RjlDNmtNQ0lTcU1tTWNZUHFSRTJoem1qb1NvcUpzWHhlMUI4UUYwckdzaUV1?=
 =?utf-8?B?MVg2c004MDBJbkNTb0FvTlowZmJFMWlRZmtVc1ZTbmhaS1NjYTIyR1ZDRXN3?=
 =?utf-8?B?V2lXdzNWOVhySFlRNndwR0V0WTRpUUZyV1RkT0NJVDI2cCtYUnJpVElqbjgr?=
 =?utf-8?B?U0NNNklpRjUvemhPb3FHSnRld2g5akdwczAzUGpSSlRkTjhpazgxUXVqZ0VB?=
 =?utf-8?B?bDByVEs0NmQ5U0JSdDJCNDh5OVJFZll3eitSdlBsSitaSEpqYldvVFF1WlBs?=
 =?utf-8?B?SXhkUzJDK1VnaWo2MDVjcnRyZ21La29NYk16WnBkVVc1OUprMUg1dmtLVXpa?=
 =?utf-8?B?anBpU1FMN21iaFJCanpnc3U5cUtaMkFIKzVPR3lkYityWmtCNjNXcWdDRFRm?=
 =?utf-8?B?QjMzYWpLMlJiNVB1RUltMWR5RlN4Y1ZrVWtNbVF1ak9ld0FCV3l0QXNuSENB?=
 =?utf-8?B?RDRGT0FkMTFaWjhZTElZQkZtdzdZbi9GZ1pvbXBwZHdwSFIwNmxTUWZGT2cy?=
 =?utf-8?B?RFN4ZFJOc0tnLzNpd1JrQjJ3emI2REVlQVVYZXRDT0lUNjR3WmsyelhJMVFO?=
 =?utf-8?B?YVpEalhlbDF2OG5uek94RlZaek11VzNRMHBOOXBydVVjZGtxajN1Nzg3TUNn?=
 =?utf-8?B?VDV6SitWNmkyU3JabklTbFpVdndBZDBPL2dhOFlkbDBmNTlWZmhTSVZGSU1Z?=
 =?utf-8?B?ZVg5cVN3REtwdS82ay9mUWtkaU1xWDVnZnFuSXJveDduclljRlQvanVyN25V?=
 =?utf-8?B?R3dRN2JtU1ZSdkI3L3dpOE1vWlo1OFc5UFJkOTRjcThDRnNYOWFlMC8zNmNl?=
 =?utf-8?B?K2dMandrOVFwT21ZQ2pEakZCU2xsUnl5M2FPbGhxVDMwTG5va1FvSTFxOTNU?=
 =?utf-8?B?RVZ6L2p5amp1Z0d2bDhrcUZlTmorU0tleTJCOFFOdzk3SXBTeC9XenBBMFJm?=
 =?utf-8?B?S2trQ045UkZ6V1k1UEkrK0RlNmFMYnBjbi81dE9GeklGcm41b2tQTmVXalAv?=
 =?utf-8?B?Wmt4UFp5RUQzUU41R0R5aHE2U2VCdDRXcXhuOVl5M25oNEREdW03elVubGFZ?=
 =?utf-8?B?Q0VzcTNaVDY4OHRxZis1WEVmTTVGekV6M25yT3BiUnVBNWdvc1hBZFp1ZXFD?=
 =?utf-8?B?U3lZUWZFdDRkRllqRmx2RDAwYlh5SnJBTDZkNmV1NlpiajhuVFRMVS9tZnZP?=
 =?utf-8?B?NDdvNTVzbHp5YUZyZFVrQVVBLzdpUUYrZDQ0WDNsdE42V0tYYWtSVmNoQytQ?=
 =?utf-8?B?eWd5aTJzNkNsSVQyT1NLenBHcDJXNFd3dnNUYm1PMGtFQ2IxZXplU1VRWThl?=
 =?utf-8?B?eFdsYk4ybkowc25lQ0o5RGlJeFdYRmlyaWJkcm93RFBxRXBGbHNWbnFISmtW?=
 =?utf-8?B?U1VNYnh5UWZBbmdzb1JieUdzczhKSFNHV0NIU2JFRVd2RDI2VVhvMUxad2Uv?=
 =?utf-8?B?RW9GYlVYMFdrSUV6Z0RuRjREVnRNTlNYK2QzdVByOG1LTmZ1SFJ2ZWtvSlQ0?=
 =?utf-8?B?UURnWjN2UmR6c2c5OGNINjFCN3o1SVNreW05dGxFWmVNc2h5dkZ4Wi9qSTBU?=
 =?utf-8?Q?l8U8ZX7wekk8oIcfc3b4r4r+N?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26655b0b-3714-4f03-44d4-08dcb000a097
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 18:59:52.1270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJCMIOQJOmOBuxcLV/twNNHvxy0eAOfguGKY8ej8skYQ5pA73LvmIx8rMNL4dSh4ilRsYv7V9J2TBb+bglT3wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6939

The node name 'aux-bus' is special word. It invokes dp-aux-bus.yaml binding
check. Simple change to 'bus' to fix below warning.

aux-bus: '#address-cells', '#size-cells', 'compatible', 'dma-ranges', 'ranges', 'sata@3200000', 'usb@2f00000', 'usb@3000000', 'usb@3100000' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/display/dp-aux-bus.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 17f4e31711209..b19a024525cbc 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -804,7 +804,7 @@ QORIQ_CLK_PLL_DIV(1)>,
 					    QORIQ_CLK_PLL_DIV(1)>;
 		};
 
-		aux_bus: aux-bus {
+		aux_bus: bus {
 			#address-cells = <2>;
 			#size-cells = <2>;
 			compatible = "simple-bus";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 200e52622f998..6e244dc4832d1 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -715,7 +715,7 @@ QORIQ_CLK_PLL_DIV(2)>,
 					    QORIQ_CLK_PLL_DIV(2)>;
 		};
 
-		aux_bus: aux-bus {
+		aux_bus: bus {
 			#address-cells = <2>;
 			#size-cells = <2>;
 			compatible = "simple-bus";

-- 
2.34.1


