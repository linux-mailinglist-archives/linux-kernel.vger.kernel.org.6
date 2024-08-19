Return-Path: <linux-kernel+bounces-292589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 551DF957184
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C68761F228BD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAD417C9AC;
	Mon, 19 Aug 2024 17:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A1pjWMVY"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2075.outbound.protection.outlook.com [40.107.241.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1E8187878;
	Mon, 19 Aug 2024 17:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724087036; cv=fail; b=dsVyWGMuEVz70FsyUgEI5L+gUdw7ReOYYTopsSOo/LqXTvMtAYBTDK/oeZ86c2cr3y8svtmIRSzpGbbWxqzkwU7BTijHZTPpoQmlNHDjP0Z30NDgA0FWQbVb1uAva/9MADP1QgYzNVfbsRWivuJo8W+G/fbW0b3n/BpDjGZFuoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724087036; c=relaxed/simple;
	bh=ntv8+a0b0cCJDPSd4QFjKGTB36LdRaVFWXIvK3931a4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=NJEMd3OD54DGZpyC/25mH4k6j+wD65cVUOfwz2NmXU72uAfbQyMJIhYMB/qJI/waoNwbDir8pPuW54KH+yop2aiEabDjwaAOxYC+iy0fYXQRIZGsSV7IYDHZHPSnwrFgF0/c8h8tvm7ckQf7BF6jJvg+nmtWt/I98j9q5exKmjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A1pjWMVY; arc=fail smtp.client-ip=40.107.241.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BSMk6effWHRXyZpdn4YcRgs44Q7mpJuZpCthvUZGV4WGsPxj851UfYS3b1p9I1zrhS+qn/pP2tt3CKm4w79BrOkDsk4Wp9VlpTh4h17mDpMAnD65ZgKgNWcC8nlpmaXmAgk0PKppu/Qrvq+E++suKCqvqs0KroiLQYlKHrhTamtaBPhcKheC916HVOvq8/gz4ijdaQOT+UIs64eEPdROChH9Ok9RhGn8FQoXjIUlo4N08Hg5yOb3ELBzoJSg9CDBxNEAgQY/h6bkJLzzSo8ASMor9y9a90TckyATRZAbi9EmDABnjHfywp44ZvJwXJQC2iuRSXmM0Y1nn46Z0aSrsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8F/1ziFftUEOisf15A05tXH9s9Hk5S22oJbdvXMiP0=;
 b=Nv6ZR9jKqr+/T943Z9gG/oeZbLiQepN2h6UdNfxzO42uZfSbOi2D1tcor4zGUCXkmoEUVukSlf5roGCruqqnp2oCVnW1jx2EOgcmSW3354cLGC3QeHMKE/BRnnCjBb4NU+HdvUOOmnzhADyN3cw6q6FVEQ176+xs9zHnksqvHhyuUD3Mw7w1GzmMyQCIyXu33JjNwOd2aa01Xpld6qdECzB4/XojYFQ8nkDz1TUi141dTlCix82UOSVO3toyFKJLwFaBYclmNJexrktzMX9RgOJOz0fdU8O5eDRjD/vN+y/LEZzgpsECYipPF8UdbXkPA3S3y7Y4Ek1b3VmNsO7Hqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8F/1ziFftUEOisf15A05tXH9s9Hk5S22oJbdvXMiP0=;
 b=A1pjWMVYy/W1SYOvNlqRHTV+Ag8aAixHHGzSR8k2xoxIC+UBkgVj7LM3YSBcQtOC/GPNfMEQhfWB+Ej5pcev3pSlj4UbuRbt7Il+3DaIpkb1Jbv1fPWxP9EuvcrKVFLDQ8TunGoRkTLbpumnVlOF7B+MQncstPs1QI3AsbxcTfMCiWRiuTMdtNAF4UxHkZBWpni5RvI54/Jz92jz/V1pSSc2NaJgX7Pz1Nz8eLsmgorJFWxo2qOW7L3o/O3Kb6wTbFtQNkAzR+2A5R7aiUKWKXcutRU45eG45+a9QVEhzSVSG+Dtt0a8SbiOPGqDxfuEdANCqDBomB9CZ/9RXIWs2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8761.eurprd04.prod.outlook.com (2603:10a6:20b:408::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 17:03:51 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 17:03:51 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 19 Aug 2024 13:01:21 -0400
Subject: [PATCH v2 12/12] arm64: dts: imx8mm-beacon-kit: add DVDD-supply
 and DOVDD-supply
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-imx_warning-v2-12-4c428bd11160@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724086982; l=2855;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ntv8+a0b0cCJDPSd4QFjKGTB36LdRaVFWXIvK3931a4=;
 b=07FZ8ShWvdMCeI6QU6F2M81uGq3psC8e8S5BAvOFfJKyTfWU48K5uf5/LLqxgoZygKet5V+ZT
 2ZBdivyUQCqDT01Kq/qrJKGi0Pi4I07u4L84yQD6nLbTJAJljGv9aPp
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
X-MS-Office365-Filtering-Correlation-Id: d47516d3-c7a5-46bb-a089-08dcc070e643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDAvRUdqV0RsaGRHcFQwWm52QnVFcVBMUmdUUXRLRTFhTVA0QVkra0NCQno5?=
 =?utf-8?B?bzc4aGs1ZGlBR05MSnRlZ2lnWENibkk4UEoxZjBuN1I3WmNrenpYV1lOdXZi?=
 =?utf-8?B?UE41VHZhTUR3d0hQMy9WMXZMNUtSQ2NoSFJhS0h4MXhQRkFJY01lMERuOUVU?=
 =?utf-8?B?TWJ4TW9BQUR5NU5keEpha2RsSmVVRlh5SE5QQ2RLR0JkMUc3MVl2VG5DN0tq?=
 =?utf-8?B?TXV1cE1XOFBEK3E4L1VERmhGVlUyYUlPUWt0ek5aSFlIR3UwdC9BL2pSanlS?=
 =?utf-8?B?UUhWZThtaDlhUDJhRXA5TW9sY01zL3FnN202Y1ZBNkg1Mm9jQ2RNeXo4dVhy?=
 =?utf-8?B?b0lDbUQxNjdSU3hnczZZUDVaMUdqMS9kOWVuVmR6VjYrK1k5OUVyVzZqYlIr?=
 =?utf-8?B?dWhBMTBGMjVGek9HKzhxL2ZuZU5IdkVINldGVWdWWXFVNUpLWlJ4STM5aWFF?=
 =?utf-8?B?N3N0Q012RjBRSE1pU2JoeThVT0ZYSGw3WVFlRElNL0hIK3dQTEh6NWhKZWtY?=
 =?utf-8?B?OXNBY1B3VWRlYktvQmRBdk9ZNGJnaFlwTU5VVWhHNEdONnhaOGZVVWl3Z0x2?=
 =?utf-8?B?WmR2TzNPWkNad1h2Q29lTFE1VW1PcUMzaVRIRXBLakpnZU9BaDFSLzAvMFha?=
 =?utf-8?B?YWN3MzRPbDRURkhvZEh0cVVoZmtKN2tOei9NTmttUFc5SHFXK2FJVDNOTWwx?=
 =?utf-8?B?WmNuUzRmam5ERFk4UXhETXhVTTRWdVVKSkxRV0JjdkxrTDV1ZHN2SVY5MjhW?=
 =?utf-8?B?N25FQ1BuMmNlR1NGdjRheHBqcFcxcGswWDBac21wR0x3Rkh5WTNkbndNMzM5?=
 =?utf-8?B?dTlzSXkyZ2VyTXd5Nkt1ZndPKzh0Mmw3V3lYQWNXWWN0UlhRR253RFg3Q0xx?=
 =?utf-8?B?RnFXUnNSQUk3bzNOSnF6SGtUenN4aDVkRWlnaXd5ZEo3Yk9WTTlUc2dsMXJG?=
 =?utf-8?B?TGIzSGU3K0V6L1o3Z2IwVDEwaEduL1d4cGUvTmp4ZzB3MTA5dDhnWVRwUFo4?=
 =?utf-8?B?YUhqc1RPaThpWG96T0g0cG9PSTBtVWUrVDFiL0ZIY2dPMUJza0YxU3NlVTZP?=
 =?utf-8?B?d250UmdFK3YzSWg2Q01lck1LLzJ5SVVMb0NlM3lmM0syQWloOFFnMEkzdzFt?=
 =?utf-8?B?WmlhUVVmUU9wZmtBdXZtUE9SUlBXMlMvSDdXTllKUEpHanNIdlVqdFlOdE9J?=
 =?utf-8?B?UzVkR05UVFVZREw1SC9Cb3M0cU82dGxJWWJ0TUhiRjJLTWRLVnMwMTdIeCtl?=
 =?utf-8?B?SDBuQ2lMb1VxZldYRVQyTStRSHdocjl0Qm1wdXVxc2YwdUtWcmIvY3kydDhS?=
 =?utf-8?B?ZWlITkxCS1lDbS9qcjZVNk9IMDE1aDNqMWVMRUdCUXhQcDZVVzl0K0dMVTUz?=
 =?utf-8?B?SzBGb1hETGtIa1FzalI4ekN3QmozR2pIUld0VzB4V2dWdTY4a3BqWjZzMjEz?=
 =?utf-8?B?cTNSUDYyNFlKUGo4YjA5ZDNjODBadlkwNEMrVExuaG9EWjR3MlJXVCtZeFBZ?=
 =?utf-8?B?TzBHaGN3ZkRPWXVhN0ZyTDRPWnNFUkloL1kyL2xHSE9Yd0NhdmltdHlwdUdW?=
 =?utf-8?B?d2tyT2JnaHVTOUZrbEV1enZqNE1rbmY2OWExbDdVN1R1UG55cVUrU3EyVzE2?=
 =?utf-8?B?dlBDaXFTaGFCU3QzYlUvK0hIcktZemxrSzJWam9XS2dFWGxzMk1ua0NYMUFh?=
 =?utf-8?B?VVFtU0xCb1BNRmRJVm1xZnpLK3B0eW1QQUdiWFRrdnQ5bHkwTDIwVDJ2Mndz?=
 =?utf-8?B?V3czdXMrRnVwN2VVYzNieFc4YWJFUm5pamtoTTYvMVhnYzhBc1NGZ2R6QUFM?=
 =?utf-8?B?a0k1UGtPV3YxOTN3Zy94N3duT09RMm9vYTNXWE4zZGRKd2NEYVBYbFJPV1lL?=
 =?utf-8?B?Z1NBZXVTcE5kWmlhLzJjdGFqRmVaTXhjQ2xSek43eFZENWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGR5YkFHTTB3YVM0RXIrZ3VtZjAvY0M2blhTZGk3TzBPdWp2amJBQ2VoR3M1?=
 =?utf-8?B?WEV1U2NEeEE5RS9uN1NmT1FCMEl4dHJyV3NsWWw5OHNwamdzUzBmTmdNdDZl?=
 =?utf-8?B?OVdHbU05ZHQ3c1NnSjlBa3RGVld0RVNqZndsUUdlN3VYWitBSzQ2M25QTlhk?=
 =?utf-8?B?TUozRStIZ1RuOXduaGZ0SFBXODJQY09wbyt0RGgyalU5WEZzdTBPNEdOREhZ?=
 =?utf-8?B?RWdZRExCdnZxWWdqMy9zNDcwOUlpeFpTd3Z6OUtZVzl3c2xHL21iQW1VZWlx?=
 =?utf-8?B?TTJkZE9QeVA3TzdQZGVNOEZqTDRXN1Y0UjZMeThNQkpMSEs4dHB0SVhIa09W?=
 =?utf-8?B?b09KbGhzTnIrUjJ0VWtsTExrWHA2anVja3pIN0JtTTQvYjRRMVViTnBXVWJQ?=
 =?utf-8?B?Z1ZmWUVKN2Jta2xRK3ZJZFpuODR0aUZXVXhGNkQzb2J5TlBPL2NWUk1KbkNH?=
 =?utf-8?B?aXlxVmJ2Sk9vRm9VWUF5bGRXNEM3M1JYRnhCQ2ZoYW1LR2s5NE5xWGFtK083?=
 =?utf-8?B?RG9jZEREUksrK0ZiUHp5bks3NDZvRG00ZWMxM0RsWEc0YTRCaGhMT3poTzI4?=
 =?utf-8?B?R25WRkUyVmJZLzJiNkhzQzlPdnIxTmhlWldiNnMrdWJVWGw1aTNEWEtaTW5O?=
 =?utf-8?B?N3pXdUZpRWF2QlJvZEdqUFRQYVZ2M2dsOGVGemZyc2dqejNrbml4bGYwcWtv?=
 =?utf-8?B?WmRoWXVkQnI4VlVwMVZQd1JMT0IzNGRNdHJ1SzRsdHZVZkdZSGdzRlBxSVIr?=
 =?utf-8?B?YjZBM0tNbVJxdmJTNHRvMFNTS2tkZkl6czRXUmdxMmpyUWV0UUhTVUNZb2VQ?=
 =?utf-8?B?T2JRZ3FtMTBMUWljejcwQnl1ZHBNWlhuV0hNVWtpcElWYmg0UnRyK3k4V3hx?=
 =?utf-8?B?Lzh5OGtqdWJxWHFPY25SZFdaSVgwVWl2bmZiSkVJYjFDZVVLR1BVQ2JUU1pO?=
 =?utf-8?B?VHhLczNudXBOUmxOZkhPck1UUHZSbGZjMFVIQjR2QzlGaHVhckpESkVwUldq?=
 =?utf-8?B?SXNxaG9ESVk1RE9CSDFLU09GSE8vZkpFa1NsMENYL2pBSTl2SWF2RUw4b0h6?=
 =?utf-8?B?S2llV0R0RHBJVG81dkRZcTFwczNZTHh6YjlwWDZqWEs2YnV1R21KQWhlRjB5?=
 =?utf-8?B?a2x0NE4vUytHVWY1Y09mQVNGbWJsTUM5b3BBSEtSTWsvYktEMkQrb00remMz?=
 =?utf-8?B?T3g2dUxhcDJUOEg2QzNVZkpjUGhkVWNuN3B0S0VZK1hLL2xnZy9CODJZZmNG?=
 =?utf-8?B?K20vSnR3dmhmdnd1MGNEdFJKSndvc0hxVUI5STNXWDVEOXMxc2lydnVZc1A5?=
 =?utf-8?B?SDNmVDg5bjhjOTd0Q3I0RUNWaEIwNXQvWHlXdDVFcGlSVlBkaXJaTndyREVk?=
 =?utf-8?B?Y1kzV1ZJVUg1Rmc3TGdBZXZKNUF5NWErUERwTWNVRWdhSGI2YjJJWGM3UUpL?=
 =?utf-8?B?SXJQUkVuWG5aT1dPMGJlRlpTYklJNlp6c0pKWUtMVlFSZ3hKcVp1L0kxdnV5?=
 =?utf-8?B?TG5TNjBaQy82NTRyUWFkK1JRcmlWOU1TREZ5cGNjNEdjTUgvT1JhWGdvd1Fy?=
 =?utf-8?B?bGpBdG1DdU5IbmdlTXBLclpWZUtubFVRODRPbXJCR2E4SjRpRjdGU3Nmek5y?=
 =?utf-8?B?T0hDanRHa2dmL3RTa0huSmtVaDAzc0s1cEIzY1drQ0dXeGU1UWoxeEVxVVhI?=
 =?utf-8?B?SVFVNmNpM3A4ZzNaYzM0Nk5QejFiZjFNYUdlMTY3VTUzV2d6U2pqNi9mWDZm?=
 =?utf-8?B?QWt2eEZlQUFISys0bFd1QVFoYnFwSDJ6SjhZdExkK0J5MFVmTHAxTnhLbnJM?=
 =?utf-8?B?Z2FBODJMUGl3UXpnbE10dkNQa3Zzdk9hcGE2SVhSb2NSSHlnM2lTNUFSbENZ?=
 =?utf-8?B?dTNMRGJDMjJPa3FvemtyUVcrQjA3VUNmbkRVR1c4eldhNHhUM2R2WlpWV2d0?=
 =?utf-8?B?Qm9HdU9uaktqVmpMSWpRWXlpQ1BYdE5SVEFhaHpad2svN2ZXK1hGM2F0SFV0?=
 =?utf-8?B?amMxbXZFaG1LcXVDaUxZRlJ1WUVOMG5Odkh1VDZDSldSc05NSCtHRlA3RVR1?=
 =?utf-8?B?bEYybUFRSEsyd1MxQ01DUkc2WUsrZ3VZcjdMMzBBTEErb0UzN1FSenNZUHlJ?=
 =?utf-8?Q?Oid5Rp+94kFure2VD3fM1ZQw9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d47516d3-c7a5-46bb-a089-08dcc070e643
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 17:03:51.2562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vt7hBkyycYHLq1EqlbROWN1vi0YjJ09Ujh8weXslPwFXddi+eZKAAS30DNHG9EouD2F1qoLO6/endRszzumrUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8761

According to binding doc, DVDD-supply and DOVDD-supply is required
properties. Add these to fix below warning:
arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dtb: camera@10: 'DVDD-supply' is a required proper

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../boot/dts/freescale/imx8mm-beacon-baseboard.dtsi      | 16 ++++++++++++++++
 .../boot/dts/freescale/imx8mn-beacon-baseboard.dtsi      | 16 ++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
index 6086dae2e5fbe..ea1d5b9c6bae0 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
@@ -56,6 +56,20 @@ pcie0_refclk_gated:  pcie0-refclk-gated {
 		enable-gpios = <&pca6416_1 2 GPIO_ACTIVE_LOW>;
 	};
 
+	reg_1v5: regulator-1v5 {
+		compatible = "regulator-fixed";
+		regulator-name = "1V5";
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+	};
+
+	reg_1v8: regulator-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
 	reg_audio: regulator-audio {
 		compatible = "regulator-fixed";
 		regulator-name = "3v3_aud";
@@ -187,6 +201,8 @@ camera@10 {
 		assigned-clock-parents = <&clk IMX8MM_CLK_24M>;
 		assigned-clock-rates = <24000000>;
 		AVDD-supply = <&reg_camera>;  /* 2.8v */
+		DVDD-supply = <&reg_1v5>;
+		DOVDD-supply = <&reg_1v8>;
 		powerdown-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
 		reset-gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
index 20018ee2c803e..77d14ea459e57 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
@@ -40,6 +40,20 @@ led-3 {
 		};
 	};
 
+	reg_1v5: regulator-1v5 {
+		compatible = "regulator-fixed";
+		regulator-name = "1V5";
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+	};
+
+	reg_1v8: regulator-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
 	reg_audio: regulator-audio {
 		compatible = "regulator-fixed";
 		regulator-name = "3v3_aud";
@@ -158,6 +172,8 @@ camera@10 {
 		assigned-clock-parents = <&clk IMX8MN_CLK_24M>;
 		assigned-clock-rates = <24000000>;
 		AVDD-supply = <&reg_camera>;  /* 2.8v */
+		DVDD-supply = <&reg_1v5>;
+		DOVDD-supply = <&reg_1v8>;
 		powerdown-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
 		reset-gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
 

-- 
2.34.1


