Return-Path: <linux-kernel+bounces-383576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1759B1D88
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 12:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBC8C1C20A2F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 11:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A84516B391;
	Sun, 27 Oct 2024 11:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="pbxjIn9m"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060.outbound.protection.outlook.com [40.107.21.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAA216631C;
	Sun, 27 Oct 2024 11:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730029819; cv=fail; b=WFLUDWjZijyyM1rg9pb0sh14yohsd43y+IijghWmYnWScyncFO2YLg4i3bHScDTVDnn1Z72SELZzvZfApZ40gdDJGAC5n8E94KQ+yggcrAbud+nkP+acJig+d4lgDce78B5z3rcHZpQqzMh2KnLFByd5cGYyhk+GmnN7+D+HVhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730029819; c=relaxed/simple;
	bh=DWEYRqS78+d9hSFm1aNEF7U68gsD7S4JOQqzK3hgEtI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=mcmYNh2nTYwFLNzO6GwY/ppvBf0setTmGUaC7dhsu8bSKtzyPpDYgXFZrkNN9qmbjBaBvJpcyhlGpWcOqCwIMTeTBVvZUaAVZIqf0ZMlGqVka+x3nkQ+WaGdD6LxNIcP+bNvmQZConYJnhNVRv/HTZNAYKD7PzzCsQiLbPNqpeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=pbxjIn9m; arc=fail smtp.client-ip=40.107.21.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emxw4LreFEk71+21SaSWo7nbumo8bCGauwMgFVhFZD5bTFGzqGrLDM4+IxxwDRsvx+bxZt8S4HSPeiyLI859zbYziLlEeVN9CevcO41xNluBWNsTUtNgaBgEzUBAEjdDfgndhJuAKw6viJ+HYcbS1x396O0ira2cUmoqZixn4YeCdMWvVC0Lvl2pKwKWIHXVUgzFsPlqPCZqJ537r7aKWyunYw5eYFFW/aFS9ZwnlsgyEi7ZKIUpq8dyst8h1tITqBsIvlhDvd3kNYcxR+mVAdm+KsMj6KKh/pIY7b+H/VmD8+2jKBNKanenQz+z3ne8F0QnPlavPJ8K5NdNXjJm4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKK38nCOci4ZCIoXe5gEa3U4nuztclm+S/58tn7qlss=;
 b=brYH210vPkX7uoXvCGrqlSOL/qmhAS8IXpIil4bUFHSojPQjcWyf7kg4paOGk5SBrgqpx6VzkNz3lxW1mRWKPGlTAWSctyCLvJjSGf+Ovo3aV3WzOpCd4PRF3L7yGW2AfrIadb6FwKC8QGgcjBpVJJBYQRyObyrNlnlrC5WZ8W030M6xd0kDAIyglkcfD1241wYLZY7EZOkk8/FYyiIq+LyUK6VRWFAW43t6COqM7TNU9MH6mPEmTdiMAMfdF1RyzbUuh+vzm9cLJHQE0ELdwVnLZyzQBkbzJe3yPxqEE/pBIJnBMYQv9/OLxJKv/mSVx7dKLCgHffrflf+3T+wu5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKK38nCOci4ZCIoXe5gEa3U4nuztclm+S/58tn7qlss=;
 b=pbxjIn9m7Zgcj0kCZKmvjiWN23KdZDJ+IrZn7WA7Bvu0kE9iqG8HMnjzj+cdzgyJDW2IeloxeoL3T3tr3WaOqSA8wFC5jgT7LUjwEBI0aumgeweP56M/gRS16FWJ4/YRYlLyTU48sc2ecRm9oXAwnO3yNFCe4E+GFXkZamZ0Nbz+OlGkZfrNeTrdopVDXV7+svKh0/X1aZXUXvwveRwIvauaTg4KcXlBxYbWuOICESrh8t8jZBYejYHgFM7AUKAANR8JH3L8p2XaDLlrB6m6veHG7hDHD808l+iObsjevqdYKgYRBw/cR4dyQXI/6x8fkYD0/bnqIRthXTfQbK77WQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by AS8PR04MB8689.eurprd04.prod.outlook.com (2603:10a6:20b:428::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Sun, 27 Oct
 2024 11:50:15 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%5]) with mapi id 15.20.8069.016; Sun, 27 Oct 2024
 11:50:15 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 27 Oct 2024 20:00:10 +0800
Subject: [PATCH v3 4/5] clk: imx: clk-scu: fix clk enable state save and
 restore
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241027-imx-clk-v1-v3-4-89152574d1d7@nxp.com>
References: <20241027-imx-clk-v1-v3-0-89152574d1d7@nxp.com>
In-Reply-To: <20241027-imx-clk-v1-v3-0-89152574d1d7@nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Aisheng Dong <aisheng.dong@nxp.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Carlos Song <carlos.song@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730030419; l=1313;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=3X/Qf8yxkbiUb4z7PIwDr4+tntiXC7Iu2g5/3wMx1uE=;
 b=VI+Lsj5R2/35/vQhujc0PD5alNCf7KHi/4s8314O1YMtpUo1hUYjxxKz0Ns0behxdgRhNha9w
 0Z+P3rpe3XLAM6ih9NS+2CfqqyuyxXDq95o3gx7knYeAYB2ghDPG4OE
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) To
 DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|AS8PR04MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: ba2e4a91-853e-4efa-cdac-08dcf67d85c1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ME1zYXhUaSszak5EK25DdGdwaGtabFVMTm83RW9DYjhhN3NXRHB2Ry9DM0hE?=
 =?utf-8?B?VGpMUWNicHZMM2hLd25mQ1pMeHhOQzkvcGEwZk1qRkhYQXVrdFc5ZklTY2Jr?=
 =?utf-8?B?Y2dzMkJycG9ubnJHcXhJYVZvUTRPd0ZmRld6UURLSGNUSnNNYTZablZ5dTFo?=
 =?utf-8?B?S0dxQ3RYeWRmTDE4R0g3bE5YL2twRno5MHFWYVFPdnBRSk1XdE1TSEUzdkMz?=
 =?utf-8?B?Y0pHL3EwUHZUVGxnL0ZoSmlDbWhGYTIvN1F1OUpnYkkzWnZmVE5MUk0ySGlJ?=
 =?utf-8?B?SmM3bUUxSXZWU1lDRVNYLzY0VXJ1TjlRQTRjT29Rbm9zTDJpaVEvVkcwM1RJ?=
 =?utf-8?B?Skl5T21vSzJvVktKUWduTmg1TnRIWllHdllwTGl6bkVUdGh1KzhoTnBFS1Fh?=
 =?utf-8?B?ZEhtR1ZueWNGMEJjazhxVkNFVzN3d3BrZlZTdXNwcFpFNUUrbHJaV2VLVGg0?=
 =?utf-8?B?QWNQSmg1aDRBa0dqOWREOFJqSVk5aUV5eHFVQkRWMkUrYmpIRzJ5cisrY3pY?=
 =?utf-8?B?ZGJLTXY2d3NxMGtZZ0ZNR1kyckNFS0RVcVE2cEVQdWlaQ3JIQkFzL214Zk5t?=
 =?utf-8?B?TFQ1VXVTcE9heVVVMFBjNUtKcGI3NlBMV1B3L2FsK2R5cGZzMUdoRitRSVE4?=
 =?utf-8?B?U09mSWF4cTR5eEE4N1MwWGRyVVJhSWtsVDJhT3UxWnZ3ZzNNU1ZrQjRrblpB?=
 =?utf-8?B?a3E1TUhNNVE1U0FFOC9MZTVWTVJKQUlqV2NFNFg4UENBSVA4Q3NxQ3hMd05F?=
 =?utf-8?B?UWw2bWNoOE5OdGh5M0tQZ0xFNkRCU1dUek9uTUtPZlF3dWxKbUlDdUtHUkIr?=
 =?utf-8?B?aDNNUHkyR2ZJeEN0bTBsUEhvMitCdDZUVmZPOXhTUGZYb0sxVElMM3ZkdWly?=
 =?utf-8?B?aS9oTnJkVXZiVi9DS09tTmd2WFZIdXN3aDV0UnZsSVp5QlA0VmxLL2FKWlhR?=
 =?utf-8?B?cVpSczI5b2VGSnJIOSt2UkNrMEdjbTNiNlMrM1pHZjJMdmZXNkhIMGdhRXhP?=
 =?utf-8?B?ajFsejNQTGtGcnBmWWF5RElnSHR5ajAyUEIwcGJUN29DUUpaM2Y1cngwY1po?=
 =?utf-8?B?S1liRU5yaXBhWlhZeHdFVlZ3cEJjMkV2UjdjcXFTOU8xd3BDZ1hxUjJNaUhF?=
 =?utf-8?B?L1BoWHJSQTFHOWx3dVptNnduTTBDV1llMUw3bmRvbk5JZ0JqdzErWGpiL2FL?=
 =?utf-8?B?bERQb0VxOEgvM001RlYraThXcDNhd1FMTCttdUhWMjZ3dHJPNGQyd2dFcjR1?=
 =?utf-8?B?SEVOc2U3ZjVvVkJsSjJiNHZTb3BkZnRHNmhzYUJPalpDbXMybUV0M3NUZHFy?=
 =?utf-8?B?cjlpVkxpZTVrZTNGVGF5Qm0zNUNFcFNUWStsYmxGblYvVHVIL1JxSXpOcnhU?=
 =?utf-8?B?c2gxNFU4QmxwNjJCVDl5SWxKUTVTQXZZYlpjTHBWeExsVXU2WkNJRGZPcDVa?=
 =?utf-8?B?b3BaYlBsWGlmekFQM0pxNklQQmdaTnN0UnR0NEQ3OVlsK2RoR3A0cmpoYk9m?=
 =?utf-8?B?eGRielhwL2dSUDFqSkVPUjRpL2VnWEdLM054TEdPRU0wTElsUEU4RGlPUkdV?=
 =?utf-8?B?RWZRSHdBZ3VubHNYSDI2VDJtMDZkQThMOXlqR01sM09Lek1KdjhMUnlJNi84?=
 =?utf-8?B?SGhYK0J2RWc5MGJYVm5IVGNFb29FV0twVXpZRHgzT2JCUlc0U3dQUnhSaDRx?=
 =?utf-8?B?dWwxNW9nNkFLc1A5QzhlWlM0eVo5dCtTelZuUWtOM2xKNkVyNTg5UktFZisx?=
 =?utf-8?B?RjN3NkJURXRGM1duQzNkS1U3a3FMTHhzem12OW94bTBSTTU4ckFpbUNXc01R?=
 =?utf-8?Q?8KGBiR3pLLYb5/unnLNmht6poN4891HqpXZyM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8461.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjZMc3UvNGd1N1BPdDBzRVk4eU5zWnBhdUNRaFlYcmtnTW8wUHptMTNEejAw?=
 =?utf-8?B?SHlFSGZWTCtydU1KektxU1cwTXFHNW5obi9welMzY2UyMDY5N1pLR2hVanFu?=
 =?utf-8?B?c1NJbXJSelJ1bmYyNk9rek5ZdVJFc29Lcm9PN04yK1BNcnRQRXcrYXRkckNx?=
 =?utf-8?B?S1AwazJLY21OaTRWb3RWdS9BVHJtcUtRaWxoNjUrK0tSZ01iZ1FVc1g3dTZS?=
 =?utf-8?B?T09LNGFDTWpqVWZiR1BXZzZCSnpHV1U3SHozb0wvdkQ4T3Q2RHNIVmptWjFW?=
 =?utf-8?B?cy83VDZDdnRvemFTSFFxQnk1SVFGekpCWVZWdVJSNGdTZmZwN3d0MHFCU1A5?=
 =?utf-8?B?NHp0ek1oblZGVWZVRi90TEhoam0rYzVnWFE0YURoWmZwMzQxZ0E5TDRubzdm?=
 =?utf-8?B?OWJkc1FNdFJIeHNHNEZzcUVidEZpeWJGVEJqNFhYUzJiWlIyQW9oR2VRME44?=
 =?utf-8?B?WmlqTzdrRll2aEdPUnZuS3hpLzdNZEV0ZzFyVUI3OTJOa1J3TS9Cc1ZHV0lk?=
 =?utf-8?B?VlQ5bkwvUm1qYW1pMnFMZFNQa3FEYk1hN2JjQ2dYUkhheUVrdlQ0UXBadXdE?=
 =?utf-8?B?Rm93N0hGZWt0Q3M4ZmpoRFVtTjFxSkVjbFBZQk93cTE0dWhSdXRFU251MzVF?=
 =?utf-8?B?R3pOM24zMEVYVm5vaEtXdWs5bHhET3Z2M0EwVWcyRHJldUJkMSs0MVFNT1dS?=
 =?utf-8?B?SmUyV2J0eWRBeGlCQy9lYU1ZT0dPalRxYXJ0ZGhFcys5Vm9GcDJWWGxoTHcx?=
 =?utf-8?B?QkMvMnZpcnptcFRCUnpXVEhPNnIxN2FsREc1NjhleU00TlRBUkxPQW9Wd2F6?=
 =?utf-8?B?OUlsdlp0YjdpdHR2SWo2UGVQTVdUNmhIblR6VHdFeUV1a1F0dTFQZWVqNzZW?=
 =?utf-8?B?Z3dweW9WZzgzZVVNSy91UUUwdWZLbG9PQmlXQnU0ZmwydlV6QzR6YlJwMi9h?=
 =?utf-8?B?NStBRDJHWldJTFZDSU01aFQ3SFVkVXE2a3J2YXRNNCs0YmdtOWoyRXlIVzN3?=
 =?utf-8?B?ZmNKbUlkK1lnVi9TYys1blNVNGdQUlYyb3JrOWdGVHYzVU1sZXptQVd1aERV?=
 =?utf-8?B?dzU5THJZR016QjhSTk9LaFBjc0oxcWtYTG1LRWJmOHhLa1JPUVo5dHVRSVV0?=
 =?utf-8?B?VlE1REtYMitodXlXUlVEWjJMZmpkaTc5bDdaa1FhY2xtUW1aN3ZuS2NjaS8v?=
 =?utf-8?B?NHFyOG45dnRQUkxINE5jUTdnS09sUTJGQlM5SkxXdjBLZ1ZkRGVPQ3NueHpN?=
 =?utf-8?B?aFRFZTBWUG9WaE9sb1hua1hvbDB3MUhteUJ5K2xPclBQeDIwZXh5OXFidmZ6?=
 =?utf-8?B?VzF3Q1BFbDAyR2JUL21oU2k1dW1jVUt6bWl0a0ZKdUMzNU0vaUlSSEVtUEZP?=
 =?utf-8?B?VzhxcDVOQUdhRDJZMDZUQmtad1VxU0dhRTl2ZXFObzhxT2NsMjBtOGNsb3B0?=
 =?utf-8?B?cEJqNWJBK2lxcWFwM0NxVzh6N1pxSGRmRWM3NjdBNVN1NUJ5V1E2NVY0ZjZx?=
 =?utf-8?B?WTBQWHpxMWlHRk93RHI5cnhWeGVlNW9ZT2MvbnA4RnhkMkYvcU9PQTRrVXo1?=
 =?utf-8?B?VjRlaHgyMzFiM1ZVWWxjdzVvVkxiS0FJcEhEeXNNUTl2aGpidlFaMTRYV01z?=
 =?utf-8?B?bk9LdENqeFpQckd4RjNZRk5VSE5ERDMxS0dyVEZKT2JuU01XTHBMWU5CazFi?=
 =?utf-8?B?M0J2TEp0WTJ3S016Tm9uZEI1NU9wMGxtL3RYWTlSS2JuQmxiUWlXeStNWE9M?=
 =?utf-8?B?c0xWa21JSEY2UHJnRTR5OE11bjZrODdPcURxUzVqb3cyOG40R1BnUWJoT1gx?=
 =?utf-8?B?bjlaL1R3ZXVIaHl5bVhaL0NURk1yUEg3dnJENEpLMEFxMlgzZzRCWk92ZXhR?=
 =?utf-8?B?UHB2dE1HWUNWazVsb0YxZFFWaXM2UXZ1UVR1aEVMTFB3b1Z5U2wyZXBPYi9u?=
 =?utf-8?B?YVhQbWtMOTlUWUlwNno1QkU3K2R2eCs3RGVCbHIrbVJXTmQ1cHl0NHZiWTYy?=
 =?utf-8?B?akFJd3RXTmFjRG00TW95NTNSUWhjbnVWTEFFc2s1Z3MzK3g3UG1lcDVmNEx4?=
 =?utf-8?B?TTRGVU1pRDk3QWdJeWNDcTRvbUFVQWdvbUlIanN5ZXJuaHR2Rjh1MTIva2xX?=
 =?utf-8?Q?boLHMIO3/yPORnE6WUwjbG43O?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2e4a91-853e-4efa-cdac-08dcf67d85c1
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2024 11:50:15.6191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tUs9iwsibw6nou/HZ6q7KRcPtFO6optK/8m5oCo6awU2ZlnDwXQaGEM/xiGLSRWA24ROMNCCTQOHQc+ABIYhaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8689

From: Dong Aisheng <aisheng.dong@nxp.com>

The scu clk_ops only inplements prepare() and unprepare() callback.
Saving the clock state during suspend by checking clk_hw_is_enabled()
is not safe as it's possible that some device drivers may only
disable the clocks without unprepare. Then the state retention will not
work for such clocks.

Fixing it by checking clk_hw_is_prepared() which is more reasonable
and safe.

Fixes: d0409631f466 ("clk: imx: scu: add suspend/resume support")
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Tested-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/clk/imx/clk-scu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
index b1dd0c08e091b6b61f6972eb630adacaa4f288c2..b27186aaf2a15628910ea6a3d4aaa5320ec4295a 100644
--- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -596,7 +596,7 @@ static int __maybe_unused imx_clk_scu_suspend(struct device *dev)
 		clk->rate = clk_scu_recalc_rate(&clk->hw, 0);
 	else
 		clk->rate = clk_hw_get_rate(&clk->hw);
-	clk->is_enabled = clk_hw_is_enabled(&clk->hw);
+	clk->is_enabled = clk_hw_is_prepared(&clk->hw);
 
 	if (clk->parent)
 		dev_dbg(dev, "save parent %s idx %u\n", clk_hw_get_name(clk->parent),

-- 
2.37.1


