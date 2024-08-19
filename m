Return-Path: <linux-kernel+bounces-292585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AF195717C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CAEC282650
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8B6189F35;
	Mon, 19 Aug 2024 17:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZONQ4Pvn"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3E418990F;
	Mon, 19 Aug 2024 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724087021; cv=fail; b=WDmbAYeiTTkEQBb42SqiZfGlvR4QI3sh/tdItP/LxEhdUs1PcitjQknBBWXDQw1Gp6V34JWiIDAGBMzHK+qMavByuwid6hRdKpGXEsxlDtZmfsFbB5m0DqCiTALpBsdu3W4ur8twz760cVoByYitP9YLRkunogyr+e0kz2Coua4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724087021; c=relaxed/simple;
	bh=GN4/oeizxm2UR4ecdGvTB3xN5S2Gd2JjPkGtvT2KSac=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=mty3WJIe2gyGd1ufDp6kvfIXFB3gkipt4x0B2L0M9328JhXn4bKDVWJkHAS2LX3+fGQQ6AOE/Grx9+PpUmGcVKsblb5kvqveYGRuhUPP5+XjuS3y5cnL3v7lfMJQgsGW7EqTwXLtRa6R5oOgb00UEFR49qA3Rq4HAeBxe3YfU3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZONQ4Pvn; arc=fail smtp.client-ip=40.107.21.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ybLrsYdY4w/HfZ2qkltDAsl/oSsDqFKvuRZjuoUSsktR+0sd0zCg73y8Vq2KZchYZnOjP0j3esByCmfiQNa2lxvdZDYer4BkCAaLnf3bJcX/c3M+8tiEdULN/aZ2kRJUMTfMMaRg0GC4Gxo2pYc9KblxqBtQemEYMZmg38+3NQbwtxI+HO62m0ngTrIt1Sy4zx6JekKL06o5uwdSGGs0nxJy/sxV5d3XaQm9jcxqxCG2bJBAoW9O+38UAOwWBe+dFKU0RVd9m15t1HeHuOz9O4TiF6sX/kBDuDqAZolFBOAVlgG4Ijr1AV9ys/unIq9tmiJfAFqlsTwOh2/L98kS5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ND7h8Un9nuP5KflElC1ApXUa5+Y90gQdjzbZze4qldg=;
 b=oYGd9fkcLUnOwa8g0N5R2tk7JtjWoYr5fRCN54AWKJtZ0YSTRg0jSkDYyNECoVLxb9V1Dxa/o8kl+Z+3er3+FK4XWXB3VcKV7HV9DldvtIxZxYLCZk3b1tCXJLvJQq289AQ3Y/cDjKJiCf2BJrhcQJYgM/u1g6hqQfv8nQxW1MkKQUp0hwKCnUaJ1/hil6c1WtJaoxQC0igOsXd3q48duAqfTQBAsekh98nr0jozbZnCp7gcW1pOvb80Tpwhj2uKHtBGYBdFjrYpjHhXnxyPTMy6ZFvJmqQVABGeU+GNBa0P9lR7GO5ArgIW8ee9nirK9TS/KKGTZdCqM+FgJzhOEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ND7h8Un9nuP5KflElC1ApXUa5+Y90gQdjzbZze4qldg=;
 b=ZONQ4PvnsjWs36CWCiAdhCKbk24SwO/LRxnKvxMeI++ewLSmqnwBL2EVqMmeyW9/IavhI6XIC66bx5Ybh/6OFvS5hZe5C5Ms/MQ/Ch3xQaTcS8AAYjdwddq06cg1hglLOPel5QHA4ZYG2cfzQh+UUA3uusyYisHkXN/plrwa2agsW0C2JwXsBCwcfdDNoRDdyQluGCrqYn/FirOaQUioPtxI6+Swxu25plquAsGkg4ClghOBcVvD+NXGIrx8CCttEdI2pOJxXP8zoV7n4HkIjmzww8QQZY/ygv6pDXSK2xesYSVjdktbAljmOg8BIqEpzPBSkZK7gulAWlOlQY2/pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8761.eurprd04.prod.outlook.com (2603:10a6:20b:408::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 17:03:36 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 17:03:36 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 19 Aug 2024 13:01:17 -0400
Subject: [PATCH v2 08/12] arm64: dts: fsl-lx2160a-tqmlx2160a: change "vcc"
 to "vdd" for hub*
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-imx_warning-v2-8-4c428bd11160@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724086982; l=1294;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=GN4/oeizxm2UR4ecdGvTB3xN5S2Gd2JjPkGtvT2KSac=;
 b=rG9ujYZQvCQwnuG1f8qBTdJj1tLKx4LhYM4faDcRKI2EDDC0DsRpcCiQhjTYKdoOQ5R56CLKz
 5aNryC4z7uCDkHhXNErLfR3OxqXFYFIFYC60JtRDD7ogkgLpJjTm8yh
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
X-MS-Office365-Filtering-Correlation-Id: 8399149a-6aba-4931-a7ce-08dcc070dd41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2hya2tGSU1PNHIzeHhJUmkrdis1RUd6dFd2K004bkkyWXJDMGVYVVBaK056?=
 =?utf-8?B?M2xXMlN2M0szbEVjQWc3ZytJdjlvaVo4ZTZ5bVNmNURlbEt5OElUbUF0cit0?=
 =?utf-8?B?ZjRpYWpqYWFIYUtqQjJSYVgvMWFJVmtFZlNkbkMvTG5HV3MzWUwxZkxYN2NQ?=
 =?utf-8?B?MjZxdkEySjFsVEtiTURkWFA0UmtqZzRNaGo4OUdtM0U5eDdUcjl0RXNDc1ZK?=
 =?utf-8?B?THlud0dQT005ZnQvTldlL2xNejRINUtrZGMyRG0wMVM5d044SVBtUG1LMFli?=
 =?utf-8?B?d2xxZmNVSGJROTRwNVNOUjhWUGxRSHRVa0xyVFBWZEdXd0FaZHh5NGJNL2h0?=
 =?utf-8?B?aUdjSDJCb2lhTGJUb1ZYT2oxaFpxMkNQVFJnRDhMZkE1d2ZUWi8wdXhVQVFk?=
 =?utf-8?B?MFlBeGxUbmFpUU0zZjJJVjZwMlJMdnk0NDZTQ2V4Tmh1bzQwNUJSOURJVGkv?=
 =?utf-8?B?K3NMR3ZjK3Z0OERVY0JOTlJobzV4NzMwbktCVzJrVm1tWFNSTkVFcW1IUzVL?=
 =?utf-8?B?L3VWY3EzZ0QwZ1VSVk8yWnQwd0IzN1pYTlNtcTJDQUxNRDRuMG1mQXZnSUxI?=
 =?utf-8?B?TmU0SjBYT01TeEtLcE5WY0t5azRlajJ1WmlXMVRnRVpBU0tSbDYwMzZFejRB?=
 =?utf-8?B?WDZDalA1NDBPa1V1eDdYSEhqM1J4ajhCY0UrYlRCVDI2VGFiVTI3M1cxUVJi?=
 =?utf-8?B?M3Zub3F1M0poM2RnTkVwSW1YWlB6Nlh1UVJUcDFMc3lSL3VyOStMbzdWUTZn?=
 =?utf-8?B?RzVKVEhZejg2eGs4K0JlQTlFeFRmZUxuUkpMT1BxQlBhSm9PVStVTHloMk5s?=
 =?utf-8?B?cFlGazlXb3VSaUhueEl4bkdHbG9TcFhzcWJReVJ6MVBqajJqTjJRMVYwcXBw?=
 =?utf-8?B?ejVad1dWOXYySW5qclhnKy9ZMHZUQ0U1VzYwRnZGcDhvTFFBUGloZ0srdlBE?=
 =?utf-8?B?aFpUWVNyOWZaSnRBNGpLMEZDdGJSUGFDRUExcmlYSW1XZzJGTHA4aE9rTGcv?=
 =?utf-8?B?a1RqbGJTQXRuTmxYRFZHNnVoSFJSTmRLcVY5aTJRK3N3ZmtiMStBU0QzSnpQ?=
 =?utf-8?B?OE4xcEFhZUUwNjdJS21CaGVYS0hFSE16RmN6RHgwMGx5dWRzOWRncitEbjk4?=
 =?utf-8?B?WGYxRXR3bjZxNlBxY05lbkk0VjZicGtudEluOHM5T2VLVTdacDFuZUtZRmc5?=
 =?utf-8?B?UVM0Q2FTRWc3Q05SU0dzMWY2TStodVEwNGFBU01COXFGc2x1OUkvdjZKWlh2?=
 =?utf-8?B?bUZRbXhwS3VNMmxLS0MwYXRZSU82cENvVHhnRXdydHpEZEV1NHRkcTd3NHdh?=
 =?utf-8?B?Sk1EdGJsM3VkNzlWWnRxa1E1TkNVY3VFQmNIb0h2SnNYZEFoSlB4THZRQ2l2?=
 =?utf-8?B?TGdIVGdBZ0s2RmxDQ1ltbEdpbzdLdVhnbHZnKzBJcnRWdHVEWFg5dHhld2RP?=
 =?utf-8?B?elRkZ0RpQXpjNWxEN00zaCsxZU9mcCtYdmFrYkRsc0pvNFo1Z2hmanJJdTlp?=
 =?utf-8?B?QVErVWFlRXVoZEJqMWM1b0JCMmtjUEtPN1pmNnBCTWVRVGVPeTlNRWhwRkI1?=
 =?utf-8?B?dlE3eUpZL00vVnk1Nyt0aVlIVXQ1QzNnWVc4NnpmaDFPdDVubmpOcFZYbDAw?=
 =?utf-8?B?ak5YVGVLR0Z6NWd4QVc5NXZYWmRyRForaTB6dFBVM3dhZC9hdUFXYm9kQ1Fh?=
 =?utf-8?B?VkE4ZmkyNmFGOUowaWh2anNObmNnS2hEYlNZb3RKUVlDYjFlNWQ1dGtIWGp3?=
 =?utf-8?B?a2h2N1JVUWk3d2FpRm00ejhUa1ZyaE9sZllZRkR4NjExSmpDTzk4N2dqcUNo?=
 =?utf-8?B?dDE4Tjk1enZ1WGZYZTNISlpuSVIrRXEwMHphVXZ4YXBQRjFoSGY1azBxTXBk?=
 =?utf-8?B?c3BqMk1pd1k3OTRxRllkSndDR2dScnFyejFtelpabmkxc0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGF3aHdkSlhHWmlwcldMY2d3YjMwMWpwRkkwSTA0ZmV6RjJrSHFWalhBczF1?=
 =?utf-8?B?TXgvTy9FOTJPZEZqTlhuWXBDdDRYWmUwSXhRbERza0R3S0NXZkY2U09mZVhF?=
 =?utf-8?B?bjZCWDFVbGVzcFk5V2xwMlZuNUtMdk9wMFhxRnBqa0RYSnRYR0c2YzRLbXNV?=
 =?utf-8?B?Yms3dFd1dzI4Z0JZV1l1L3U1UzdJK2dGeTFNTC8xbDJYSU03Qk1IK01tbk5Q?=
 =?utf-8?B?YXJqanFSc2ZvMzBMeXdIUEppTmd2TE1rbExVcGNtOVFRUHZRVkJnMFpRTGlC?=
 =?utf-8?B?VWxIeklmUndBNFBQTDk4YXVES2pFVWdZTkhYbHFqajNPVnRRWmRFRElxYWkx?=
 =?utf-8?B?SndNbTZ0bnlyWnJkVFY4N3AvNFBvVFh4d3JvM2hkQ3U5RWVxSkgxYW9mTWxu?=
 =?utf-8?B?ZVlralBpak1KWXE2UFFHcWllVnc0VnVWZ2RwK3lES3p0MTh0ZVl4UURCbC9j?=
 =?utf-8?B?a01hejlwSWo4QU1YMFpqLy9KVStoRGVTRVFBYlRoRGh4Y3FLR3hQL2FQemRI?=
 =?utf-8?B?Uk1FMldZMHVmNVFMUloxbXZlVi94bHBhbDJCNE1YZm5mV2RMVDdHdmVGM3Ew?=
 =?utf-8?B?VExZcjNkUGpBeGhIREM1M1N3ZWwyRUxTTkRaZE81NUxhMS92OHRoVm04YXNk?=
 =?utf-8?B?aW8wc3FLL0NJRVV4ck5qZTRDTURBYmQ3QUczVFpyd0JWL3Bqd2Rlam4wMzFt?=
 =?utf-8?B?Nk5IVXJPS0VubUcxVEcxWmFZNTd5MUJRSEp2N2p2L2JGb3RicDlTQnRHSlJS?=
 =?utf-8?B?U0pHRnE2VnpsdHJLV3EybWs4L1NYcWFyb3ZSRGtqQ1BCWC91N3hKUWhwNElS?=
 =?utf-8?B?ckhxUnZUQ09QK0FoSE1XTWlKWHVqN2Q3VHpmd1dUMytjc21jdVUvZWdnZjZP?=
 =?utf-8?B?bW8rN2FFSlRpb2lMNFlFVEpQZHlrdGJvdlJObXZ3ZitVKzA1QTI3RlJZYWpP?=
 =?utf-8?B?L0dBNmpkM1NGV0hYWUtXR0ROMDRjcll4eWZqeElEdVZBL2I1VjNneS9WbTUv?=
 =?utf-8?B?Q1lRQlNTUjVDajhCQzhGWFZzWXpEU0t0ekd5OWhGWWNzWkxwQXo0SmNod0hh?=
 =?utf-8?B?VzdiZVM5d2UwUmtDNUxFRGhWZG0zZzhhVk5IMk44eEozWE5RVFU1S2xhQkx1?=
 =?utf-8?B?a3BOZHd6d3JGVFE2eldUWEVSS0ZrL1d2TXA2SzFGRzBmZWNoWkp4OUNUYWtx?=
 =?utf-8?B?WC90Q3pmSjlkRUlHYWVVQ1hVenhWMExXN1BkSE93NlpHdGVOKzdjREM2dEpL?=
 =?utf-8?B?SXJSdkJ3dE9lRGQ5VUFWbFQ0aTJzOFIzeGppM1FUM0FFV0kyTjQvWTM0UjR1?=
 =?utf-8?B?MU1ZSExoUlVBUmhBbDRHOUgrZ3VVczYrWGtWMlo0eTV6WGpva3JpYXRJRnla?=
 =?utf-8?B?dHpOR2xmQUF5eEpucDVHN0FWSXd4eUhaaERISmlLd1RHajJGNXpraURjSVFi?=
 =?utf-8?B?Sld2VnJBWlZvblVKZVhNNm90OWdjYzcwK0NPTzE5UXZDZG9SdWg0MS9LQ1R4?=
 =?utf-8?B?V2gwSjMyMzNrU1pyZzk5bkZ1dDVYRDkwajVkbDNuMVZ0MDZVcXp4K2gzZDdt?=
 =?utf-8?B?R29xeitiMlZ2bk96amNyYWlyTkVUcUo2RlI1NmUzOTVlQTErd3lUTVNobVlU?=
 =?utf-8?B?aXZsM3FEblQ5ODNqUVVFUVhiVUFRdTNVK0xvN2dKd1BwMitQMldPRDlzNmpu?=
 =?utf-8?B?bTJIRFlsMkRPaFd2bThWZWM3NkNqdU4yL1Z4RlVOQ1JYYllBSlNBWW5RM2s2?=
 =?utf-8?B?c2NnQVE0clNaMHh4V1pDendJRWFibG9ENXBoWi9YeEdLaE1Mbm9QVzI0eE1j?=
 =?utf-8?B?dGRjWlF1ckZNS2d6MmdXY01BRjVhdk5rdnBkUk5mNmFoekNNUUNEZi92QzAr?=
 =?utf-8?B?K0VoK0huRnRtVmNnSWcybWx0SHN0Q01wa1dQbXpYWmRCSzBKSUVBdGxOaDRD?=
 =?utf-8?B?RDVPQ1NyS3RoWmEwYis3Y2dPeU40cXBvYlZsM0xwZm1kd2NiRElXbVRLa3lR?=
 =?utf-8?B?VEE4T3VhSklRZkRId3VhbG9mcDR5VjdJS1ZzdC9wVDlDazljUXlVVGJCREZv?=
 =?utf-8?B?czV6TjVVSlUxTjlwbkU5T0t2NUIraG1wZk5xRGMyL01GaElSQ1pGbHA3T1VS?=
 =?utf-8?Q?ZHHbo7O7asTkDeNRZKbX08ADC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8399149a-6aba-4931-a7ce-08dcc070dd41
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 17:03:36.1795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lonub8YfBunb7Zw9S8SWQqUy4BMEvhiAAW9MhzE3WM9g308Z2rlTeDFFlJ6aMpJeIpQJtPaPY6b/gxJJI5NXlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8761

According to binging doc usb/ti,usb8041.yaml and in
drivers/usb/misc/onboard_usb_dev.h

ti_tusb8041_data = { .supply_names = { "vdd" },};

It should vdd-supply instead vcc-supply.

Fixes: 04b77e0124ef ("arm64: dts: freescale: add fsl-lx2160a-mblx2160a board")
Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dts
index da0f58e26b9aa..f6a4f8d543015 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dts
@@ -320,7 +320,7 @@ hub_2_0: hub@1 {
 		reg = <1>;
 		peer-hub = <&hub_3_0>;
 		reset-gpios = <&gpioex1 0 GPIO_ACTIVE_LOW>;
-		vcc-supply = <&reg_vcc3v3>;
+		vdd-supply = <&reg_vcc3v3>;
 	};
 
 	hub_3_0: hub@2 {
@@ -328,7 +328,7 @@ hub_3_0: hub@2 {
 		reg = <2>;
 		peer-hub = <&hub_2_0>;
 		reset-gpios = <&gpioex1 0 GPIO_ACTIVE_LOW>;
-		vcc-supply = <&reg_vcc3v3>;
+		vdd-supply = <&reg_vcc3v3>;
 	};
 };
 

-- 
2.34.1


