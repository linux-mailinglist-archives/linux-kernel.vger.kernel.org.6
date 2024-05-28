Return-Path: <linux-kernel+bounces-193205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 872908D2845
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 00:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D184283E22
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E183313F426;
	Tue, 28 May 2024 22:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="Qjs25VR8"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2131.outbound.protection.outlook.com [40.107.93.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8882C4D59F;
	Tue, 28 May 2024 22:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716936714; cv=fail; b=YYS0zOfbsIBQ+vS9dj7e4rHz4lPncVSi+Q/HH59a3I6HHQNvPb1n8Hw/NHSadMKHY/ke/6LvHREGXOwjPnS+T4Ebbpdu1EVxwcFqunJVqeruM/VAJyBM2Rq5GDJYy0tc9QnR/KnJzh8K4ZefoHHAQb6hFK+auZ6WNgnoEbanZTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716936714; c=relaxed/simple;
	bh=DhTTu3gt6dy/7Y6a03qVxxoLB15Uxmc7asvzsQnlcAg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sK+z6D8NseG0WQm80BDWsjLAwBJJuqKxZ1OTqY8JyqKnMPQDp/cwGou5kVn6ex40M4tx70x82F7ARLo6U+iH42X2T9kz1lc61/F6HyJtApeWsJuEDzA5eSmtjbhBlDsBozaToHvWuewJ89IjIetC5NJlBJw8iiiJJeKEskoBOI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=Qjs25VR8; arc=fail smtp.client-ip=40.107.93.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+4vFYj7APIECO4h+uS3gxgtzlVA7f+9yBwBCwlOP8DMb4mRedx0m77e/43nmuZ0WXa0PqiUt0vDbzYMwbEw697vkE44goDwXuO7fZ3dJHVQ9ougeg0uw3Axy1g/a2VDqAzkAsqXiBGgzf+Iav2CpDpqsegxhdwR+nKWAZatNzA89LT5OTit1W75u1cLuPyQv2umk8AZyrjFxxV7daoV9uDAVgRQcfbOtNYbEL974nKs3B6XwUmmBKkDCq1l1fUlQ0Z/zkrzPmyyJUxP7c/Ms5Cikx4Mto23e+TyJzcdASyQNuJv4bz2hutmuuTU8uXWb0JPAy/BsIAmhTc+ETZ1HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J55nQnOQVXe55C/4gPABi+oaF2uxB3mz1JL7vgSyk9g=;
 b=QSs/e0+ph9yUmebgvWs5mv5NsQ5TI3gl3ae79Qe7LIhdpuWQXJh9WPP0o+T+lQEkpUsmLM6rhrQY5+2fP3HjARjobL4rcuQLFwuA3Z+HHV/j+SH4MXA5yCUnVMbkfhlpJy9YedHZZatrtP9BDin0uxn/3b/u6xKyWj14TL7EQtEuDFmFD0c+s4TR5ubP7i9iBzfVsWCJoO9X2+ANLBtsGa3T4K55lWGV1QAwV0c6YzX4UaUnrnjwkl4ussLgHIGFXh1VPMsjUza1eKHh+NAScw0uXHtX0YOyd25jdpv1Tkb3nYDqht7uRe3EBzmLwMX+CyzNDyAXUlBKQ3akYYt2zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J55nQnOQVXe55C/4gPABi+oaF2uxB3mz1JL7vgSyk9g=;
 b=Qjs25VR8GbV7xlG8LRrAlSMI1+Fm7Tu/KOXNy4F9n11ENTsikwTAnw565rCoPcrxVJpDEAy8yaC98/LWZVVJ9/3COaRsKeqcJ0xgm9htbUSAg+nqj6yQQBxaLFMq5qZZZ6VU3RUieLnzgiF3u4150f9CjmLFyRqZuisvSyIuyzE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by EA2PR22MB5065.namprd22.prod.outlook.com (2603:10b6:303:258::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 22:51:48 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45%5]) with mapi id 15.20.7611.025; Tue, 28 May 2024
 22:51:48 +0000
From: Nathan Morrisson <nmorrisson@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de,
	w.egorov@phytec.de
Subject: [PATCH v2 0/4] Add overlays to disable optional hardware in k3-am6xx-phycore-som boards
Date: Tue, 28 May 2024 15:51:33 -0700
Message-Id: <20240528225137.3629698-1-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR07CA0049.namprd07.prod.outlook.com
 (2603:10b6:610:5b::23) To SA1PR22MB5636.namprd22.prod.outlook.com
 (2603:10b6:806:3e2::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR22MB5636:EE_|EA2PR22MB5065:EE_
X-MS-Office365-Filtering-Correlation-Id: 10837fcd-3e5f-4a7a-ddc9-08dc7f68c197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|366007|1800799015|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KqNNyxmeFRt74WhTV4k4qyERIyh1Y+IL0hrk7FZqWu2UCPEDZS16MVNiXRBb?=
 =?us-ascii?Q?dkHHlhFqICtke4om8hVv6IdZ/U8yWp3KDN3iGYlqhNoGLZAo41ZxIQPTD4oI?=
 =?us-ascii?Q?3r17M3MvyB9+lFo5EMJubpKFzB4j/J0+VIByO7bNaZNll2a3qumj8nTfJ+cM?=
 =?us-ascii?Q?riFsUdcEYckWlF+WisZyURr+UzF8fZg3qB4cgQ6hErLl//Q83YE4Ex2rKsM5?=
 =?us-ascii?Q?pWWIPfJXLb9zjc2Rg5/5iw6mTk4XDFGNYeNKSDHbiCWGlKQ/aTKbObdhIXyH?=
 =?us-ascii?Q?YaADN1L+pIPtFuBJeEcTJRlBM2/z0UO2ysMVkLLOqhF0PF0xPxLBNrTHcO+u?=
 =?us-ascii?Q?Oy1JFmp/y7oEffkkoGNF8NYoAtE5e/uAUv8k8tR9CcCOeXhVwKohH/hbR9sc?=
 =?us-ascii?Q?56LioFcd1t1Lc2u+52A7atPMt9sQNn83ODIj9CM70h419j8pO3x02haDAi9o?=
 =?us-ascii?Q?NEnOWNw3pNkjKFkoJGoCZeLcEbcbOdQob1EDG3u6xyQZ6kNcJUmsybOuOeZ7?=
 =?us-ascii?Q?Ng3DqS7qq6KttUF9NgC0RO5fe/x9tyb++qtIpcN0xsol1e5C6lGUgw1x22+1?=
 =?us-ascii?Q?0r7i/ZJ6Px7WgUt9j3+2o783i1IxTS21Z9G17+dQbbMU02uUJ/wPrnfxP3PM?=
 =?us-ascii?Q?Kg8a9NgyuJdtEVogBBRQoOaE3hSQB79qN21DJdgPGP45vi07E37CUaARlHKr?=
 =?us-ascii?Q?sNNAjxlbeq3oewJTs5WXHvcWs31vbU3h5BnFhZryfGyvGpVUNvlAFCPQmYml?=
 =?us-ascii?Q?SkUVjcvTPiHw2YQMH0aH7JWl77qK7tkM8TkTPUCt6feoTePj94vMDJdGHmUo?=
 =?us-ascii?Q?8Dc863LzOkQ71aU/mYXlMuVBOHb/aJghSsFY0uWXyqIxEl8K2dqPCSXL3WkC?=
 =?us-ascii?Q?xZgoNtDRQlbPi2UB/OziXUJoEJ8dAn/w4D7MvFOdQ4bVHF0CZ2xKKQMQNzdu?=
 =?us-ascii?Q?gNPL3BrZuqXL1n8NdoFpOyDP0g1L2ZlhWpy66r2BTh8fOnxs8VEMebzbBkhu?=
 =?us-ascii?Q?Tm884qN5AX90S11LXff28A+6gm+10fY2JZ04voV7DYzgAikcUzuudLYCyOWx?=
 =?us-ascii?Q?W8gwBgIqI2u24A2EmaJ2oJzHGVQHK+TPwAAkTb3AKYDim4PflMetTlCp2Dpf?=
 =?us-ascii?Q?5AmUDxMeZ/EYiK7ZNhqkEGTwLYX+YSpiMn5IMtK+SNRY8pzoZFB731GC1NxL?=
 =?us-ascii?Q?WxrFrmkRfBD6piV4C9hdOpUR+1jb+72weKiHvnDApo1C2sPaMjIPh30dtDKY?=
 =?us-ascii?Q?RrXlPT3mMU0tdMXas0uODWpJt/CZj56UhkVdYB5iFpqHHmxgstUBq6V/Xtt2?=
 =?us-ascii?Q?AFZJJf9MDB6R6L60k53MEojCSloK1aQD3ttqVauovk0tSQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Eb3098QmZU50m5JDEB3x7obSO4o6hsrV1ZAEhns6lk3dY72oZNLKSA53hvep?=
 =?us-ascii?Q?pXDD9zojc4Lc0anOMng8x9oyMSkqvFqd0NKuv0TsyEOR7t8K0Neig4YC0pu9?=
 =?us-ascii?Q?XPejJDbqFWDJZWJdWUzXPMFAuw1Hxo09slfpWCQuWgz8298DdPIHsrUGGzA6?=
 =?us-ascii?Q?4n7CPX7CntL3BvkFG4jNCpZO0daZMHB5zwavwWvfwrpWcTqSWXgRPp9/GedB?=
 =?us-ascii?Q?vh+7Q0mOEggIrqQnKasUeEI8D84Q9x0Wb2eICfCPyHks8HraBos+sGz5qbjQ?=
 =?us-ascii?Q?kB4HomIw8w5ANEXsLUMA4duYr8IMdI0X0zQwvVqd5pbOd6zvE5lYvP1OJcZ8?=
 =?us-ascii?Q?BDNH6IZX/Old9H80nLZArLpD20dxOG/QjOdvgpwqOxXBkHaUCVmiwkGUHMsb?=
 =?us-ascii?Q?n6axcfgAEI2ubykhaYDl9Mbbug6S5vJsYhwPGbNWydcKZSRrt4jareTMJoXu?=
 =?us-ascii?Q?KXhmonK43Af/mnRRUo4IQTlG31AGtGBh2H9JiKi3iFVaPU4Ll1cJk4JWRcp2?=
 =?us-ascii?Q?EheR9+ewnsOn7HL4LXswu2l7YWtvwTUZzG8N6SILxN6YHhrO34pmhw7t8F1g?=
 =?us-ascii?Q?oMsrQqYBpRhO99zZ/bDVP0fhYH8mIO6vtZLfI5sTLmQeiZ9wcUM2ROiYv6ZU?=
 =?us-ascii?Q?E6zHFTOJqIrJMKLuDmi7VcBzg/QbE67p8TnM+4ZlactX72MEALsMwjjsViBZ?=
 =?us-ascii?Q?D5lgT4Z9DFT1XfTND2Tny0dAfpdKeFrqOpz4bkgpdt7ofzl516Sc/j16WkC1?=
 =?us-ascii?Q?PJA8pBo8ZDnyn/9xzCT3ov9ASJwz2NZ9RnQvHuWLLDZFZYfAomnhO2LW4JsE?=
 =?us-ascii?Q?0shOWbByvuOWJtrGgzBd6xEkliWHsNNDEyrdsDPQK4ORPbJB3bb8516SzgKe?=
 =?us-ascii?Q?4NouEyutjSsGgehDdWMYCalLxO0sIONShK5v9axYQA+LFdH/X6dWrM8+e7Ot?=
 =?us-ascii?Q?bwMNqCOCr+SLZyg+faic5yT74GenAiXFt2lI8NrYOkn7tCUr4VPrxuZf5oKH?=
 =?us-ascii?Q?75BUQKQrInooNVfrPOHJBaoaYzjOcNAwO+VRC0LT7sGDVWUhXxkoErRMnnH4?=
 =?us-ascii?Q?dAkcCkW7jwRLE5tWzY49hRZa2r+Is8E+8mBTv2AFXwKsrxh97ADK9uSeU3JR?=
 =?us-ascii?Q?7828foyDm3iuWsJLiMjJpyNN4MYSw3Kr52HCHz1a0PbdPMTefPsmlADkDct9?=
 =?us-ascii?Q?nFIcTDgBt1RsuYvCj9auIoAsVUG8CltiFZJAikR2WiDOyGLpBwVErKMYPV9D?=
 =?us-ascii?Q?AMSBkgZvr973OLWz/JyD2Wq1+HgkJqHqXk8Cn0/GcTjqJOSowumTXOioG290?=
 =?us-ascii?Q?aP6jjLNOfhkp4wQ1OESMjWxR7A4dxlPgAHjaDEAP4XtH5kzsP+VI/4rIZMpE?=
 =?us-ascii?Q?xG2nopN3TMOa8WgRqT0OVemmmwXJq7jeDe8gy4U8LjaC3gO9HlnJshAGDAyb?=
 =?us-ascii?Q?+JdBOJykoq55K6WS4RYDzf4TwrPFeORVZqTAPt+VDeNHPZhVE84EQnpgJa6K?=
 =?us-ascii?Q?F7+qce+siGFsVEO6AJF2xeHYVxxkEfA9Jc27wilBlzhCxLddc0Y917SV9k/z?=
 =?us-ascii?Q?EQHouIFY6i1f+pGH5TIGMm4s2hqZVTbUUmzgzYjx?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10837fcd-3e5f-4a7a-ddc9-08dc7f68c197
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 22:51:48.2583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lvduMRBKKZXsH04UKBEim4Hg+70A9WH3kgkcsFpb3x8LHYwbvc1fL2SKB/nkJHcbfzNSQdjWVnGXHczJT3FQKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA2PR22MB5065

Add three overlays to disable the eth phy, rtc, and spi nor. These
overlays will be used to disable device tree nodes for components
that are optionally not populated.

v2:
  - Add build time tests in makefile

Nathan Morrisson (4):
  arm64: dts: ti: k3-am64-phycore-som: Add serial_flash label
  arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disable eth phy
  arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disable rtc
  arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disabl spi nor

 arch/arm64/boot/dts/ti/Makefile               | 17 +++++++++++++++++
 .../boot/dts/ti/k3-am64-phycore-som.dtsi      |  2 +-
 .../ti/k3-am6xx-phycore-disable-eth-phy.dtso  | 19 +++++++++++++++++++
 .../dts/ti/k3-am6xx-phycore-disable-rtc.dtso  | 15 +++++++++++++++
 .../ti/k3-am6xx-phycore-disable-spi-nor.dtso  | 15 +++++++++++++++
 5 files changed, 67 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-eth-phy.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-rtc.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-spi-nor.dtso

-- 
2.25.1


