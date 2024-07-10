Return-Path: <linux-kernel+bounces-247295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3206B92CDB8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBD57282E78
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0CC17C9F9;
	Wed, 10 Jul 2024 08:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XMDVfT/2"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2072.outbound.protection.outlook.com [40.107.105.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3494917E479;
	Wed, 10 Jul 2024 08:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720601825; cv=fail; b=BFc9v4/pHEh6eA+SwXwJ52WU4IGiTB3qFn28jszUy8WLFZMwK6CmswscfmLXUZyT7RscsPXmA2K54IiCn8776GXl3lScRG/Abr/lWR1jfavTl5LUph46ihDhdEF5QPyaej3+WFIfmv8Kd5aW7WOhQsnbmVH6khPc/quKzzC6Jsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720601825; c=relaxed/simple;
	bh=BjmtumEFSxFo+bkTvqncBsmDG7sQcTAd+WxkHEWfJJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tG7B2W3/QXB4I91DW3htiy+ywxWLzGx8PNue7rgYJ6ftmOKDRIYDoNIqrCBEGbLorVLBiQBirqEOfoDx5HZ0q5mlei8cUJYI4CenX5o4+XAakXAH/BqWgGCgoXyTD7BfbiNG0Q+/SLwX4NRYpjnESvrRKLud5Ew5aj6OAMWdAfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XMDVfT/2; arc=fail smtp.client-ip=40.107.105.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLKMgUITaOvJNRwHmn7sSLnnadGuzKC8eD5e5Qlcqw1UUFHbq8Uf9ZsZY/P1X2PqfvCknCtnbso+QDNnk/qIcINDTxeIGc4F3QWfTR2h3kNAYT2lRa7G7Z+zQ+sgPl6rr+fIvKLl4lHZ+NCqu93f0UolRfSo3hmW8KnzO5DN33nhqZyHtt8CpDwJlJTZVrBi9D0LglKooSaZck1UedUhW/tKQeNBegSDPK2p3p2MS9AspcNwLvuT9N6wbO4Fu7OymrJX/D/NQfyFF1AWx6D+J9sfgiwh+e0nACCmohEOQfpIeCIyrktjfnzBh8NC4mHv2t8tveG5WUjQyZuFIk9FWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBJBWr+N4vhFiys5NIFgt0jl2+IBKuW1s0eJPFIMZwI=;
 b=VaLRaw7aC74I1XBrALZxW59mCy3yrgzKO0L5b4w6GrApsmbFVFmN1nQsqL96DFzrSkJVagpdjLDFeXnVdMB96e4hMgMoB5d4tbu65IerIGNPB3v0Oc0McptPEv2Yi1eIKZfBht933Bx7STZTEZ9OVqw/WPu/HbjG/wSvatUS+Vese38OpvmbtoLnpeesbYDDn6aSQTiMm7oY6MwgC9wTgHulvx47MinCv/tuBsA5dCn1ihoNwRkGgcaQJp+f83nJ4/7LN7WnezxfbQdrFkeC8dJb9tIQsZWD5w/J4q2GGUEIlTyf6Ki9cbiMQk5z71s4xon87KXKU0FKL/nFpHBVmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBJBWr+N4vhFiys5NIFgt0jl2+IBKuW1s0eJPFIMZwI=;
 b=XMDVfT/2Yr+EQYkLOpg8Y7axVk2KIm/uyAi7R/Re0Vgj4nsTUXOoyW8AyChd7RAhFX9lc82lE9SwnAzyE4IDZrZ2bkNm0Xz8ZQAX4C2E4mEV/HXKktqwYPyY8tKdFBj9fr30HK/YDi5hhK21JnqOx3Xc5obeSS8n+njjV99U+oA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8580.eurprd04.prod.outlook.com (2603:10a6:20b:427::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 08:57:01 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 08:57:01 +0000
From: Wei Fang <wei.fang@nxp.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	abelvesa@kernel.org,
	peng.fan@nxp.com
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] arm64: dts: imx95: Add NETCMIX block control support
Date: Wed, 10 Jul 2024 16:43:45 +0800
Message-Id: <20240710084345.2016687-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710084345.2016687-1-wei.fang@nxp.com>
References: <20240710084345.2016687-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS8PR04MB8580:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bc4621a-8162-449c-c844-08dca0be433e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TXemM9NJ3bKP457mS9gjeBzPGG6hXfk5XOD5yBwRDJab6pL9GHrGNUqTPgJz?=
 =?us-ascii?Q?Va+gfZGqKBtPnfIKEPHFOwON4AGY/C2Z83WWzXeptxVGJKGWwffOruqMisIt?=
 =?us-ascii?Q?YH5UCIMii69jRIxX1ko0pHf405Ja9SeEq39A+3KoTU1iJh60wr3qQCPOAp4z?=
 =?us-ascii?Q?sWfUyekqG//28P5WUwzUbz17H4+PAOPVLWgcMoy7/7O73y1acSE0fZ3P1g14?=
 =?us-ascii?Q?9+DgXSIkjbLrx8PRgJGUWQW/Nd4+K17Atsn/ctt7mJ0pr0EGYVVnk1C3RsJ1?=
 =?us-ascii?Q?+UFrRtrfQDLpjG8Cwo9fHU7W7cAqR3+ikIXUFT1sTSmah0tXvC/7XAEsvMyx?=
 =?us-ascii?Q?60ZLcPe0cJv7dZDypWHUfcENRMQ+VgZmYHQkQMQWF2RHtaCN+yiux2IRfLbj?=
 =?us-ascii?Q?idYlmFgsDy0n/Ze5F3WVpmLO7WV5m6q4NuC7YOaTPkN+aihO2HlAi+x6Fi2U?=
 =?us-ascii?Q?ApUMx/5RB86isJ5qbFd6YYvvp+Xq28mmFQMPJUl2k2TOmaILF4qKAkl1RSbH?=
 =?us-ascii?Q?gskA8U3FAussAgJwCpZLwEIDpa0Y/MVwKWWo6YyVUt4inMuJ531ZdwKrsrDg?=
 =?us-ascii?Q?bKpYQZzfbx0a14u6a9FH5fDLgujrvH30MFo/X2nRLM0J2UehhzErB7uAOddG?=
 =?us-ascii?Q?vShV0CTUDxvz6OhsQvvBQFAa0GHfSM0EN5EeNrAjDCcmAplKpPqjaaJfbLc3?=
 =?us-ascii?Q?nQeuJ0YZ6n74D2xiYjmcMAUdyXBTGVEqLb0V8Kvnv0EYuPwfLL0TyW+SVMAu?=
 =?us-ascii?Q?2ZdcS3yguljL6Pzh7T89IjPoo6rp6QvwdwSiPeIVLzAvAwVmasbRyHxzqC8+?=
 =?us-ascii?Q?1j1XLAL9vX/Dqo5zgggU+92/eNSHOjj9DVH/dyDLD5Ld4DMIW2cfH9NUsIEJ?=
 =?us-ascii?Q?lWvNR6c8qyFr3SSIVwXZq9jg11PTrm+kI9TbhQv4OceQj7CZ7a2j+Llb2/oG?=
 =?us-ascii?Q?+gQrRFcQ4sXZy0IxL6WN9MaFPZiBGJKTMPF0bdGeq3ybdHV1sqTATlfHc4pM?=
 =?us-ascii?Q?eDvRnIaBS4LuosaBqoG6x4M2w4oM39EFSYAQvNNlMoa1TfiBYnvfsdlz6dVw?=
 =?us-ascii?Q?Y3El5W98vK/md2HY3LwPAlMTH9X1Tdc4Edc1Tf24zFMiJIlWeEKImj63pu/U?=
 =?us-ascii?Q?O7seGNi2qNpODr7Fz7brDcVc0CDGJtNUePY/PYEWAenAZcQV1a/Sp+fCobjF?=
 =?us-ascii?Q?0fg36QF0WxE1vZjO4YXsxhylYhdVy/lxl74GdXguTvyL8J7nwRRKor5WnSAy?=
 =?us-ascii?Q?c8LbzbjANo1rIf2Pitr01z2uHE0kN8d0FRa9md9F7AbMoM/rlNaMLjXs897u?=
 =?us-ascii?Q?Z4kFC8nQFBwWe9VhRB2hT2aELkRsBAZz4KPkC1GGvblsyKLDnllmobRKKy8I?=
 =?us-ascii?Q?mNhA6PkcH6lUUkq1ilP5y0BLFFNOCbRgMDSUgq/HcmTnj71mBw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VvZA4XKTD/bzgaNtCslTIt419p4oKipcILUXaDMG4fTZtp52P8SNUvnrhIuG?=
 =?us-ascii?Q?xp/723v8f8knerL/Au7OEpn1AodRzGQ3+wjnIzZ9jiVlCzD+A+i32gtAHCLb?=
 =?us-ascii?Q?v6kvYhfPqQJU4x8gX5kVgLmZbC3LWkBMI/51PlHz9ezyRPGpTDyMuTNQDUBX?=
 =?us-ascii?Q?ilKhxQUOU3/bYivtsH2TdKU0SLCivFgZ3XnnlK2cffBB3IqPygGuyaHeJW+T?=
 =?us-ascii?Q?9jfKBVvVlfu+z7r8ZYiASYRwx3xR/dG93wKXxfQMmnAXMKEHXk9RPTqbeqvN?=
 =?us-ascii?Q?HDoRAdLWWjTm3DLZ777su4qxDoUOKZkzkduIrWw3qZCEiOvQ9D1WGkHN9QrQ?=
 =?us-ascii?Q?0MetBfSbpFdo16tjhys7CPJfb7XHGSdeIa3pNVlDIYSqE/kJvulNco4bP+Iw?=
 =?us-ascii?Q?/P/yUdDvyEdWwLYP+OUJj8q6HIvCcOjX9H7ERCiBEB6UfxZk7SmaO25Y74mF?=
 =?us-ascii?Q?/amGFrh5ggb9HbKBueVsFcBdWmat4H3NnsPzLG1sc/VPy0cU8MPqmpFBq2oJ?=
 =?us-ascii?Q?Hx61CykB1FcdGCnxNjScDE+7g1hGpVimMlQdbrmVQz4BlzCpMcJPu8T9MMFp?=
 =?us-ascii?Q?LU5UJAwfVV3aS2lzNRRzdncp62UIWCPF26dFcgOfh4R6bRvJUsQKiqWEbUep?=
 =?us-ascii?Q?6j95uY2pVun9repfgHL0e8GKs9ZiDsC+r6r0YNFacVm/0Hd2S42gZaw7yRtG?=
 =?us-ascii?Q?7MWeEnx5BEbrdWRz+lN3DcL7y21G0rUumiXX5gwnCZFLmHy00c/i6wOSxzlq?=
 =?us-ascii?Q?KHTkHHVHr3EqGVEsaLjIQytFsCzH93H0vt4Z2DHrON6AbGEbm2/dOCLFi6Yy?=
 =?us-ascii?Q?ZA+eTYBoUXnXd13cQ5wBxr9zRcRMdyhTFbXnykcorFWC9GlFwDSHAaLrs8oe?=
 =?us-ascii?Q?GmnM++XfU9Vqsb3TcpxN25hgx53YTWC+eo1c+2DIl9bDVjEEqmtmbtgpLqQ2?=
 =?us-ascii?Q?hxv2cIH80M+yqX/KDtdaM5DTk9CrpKjINUVaoPNdlE0nLW9/vI0YoQfdPLP2?=
 =?us-ascii?Q?xLYtJWiYqcbw4Qgq/srasInJ1vVci+XVlzvx3n5Y1oumJPgA6VU3l1gnOLC0?=
 =?us-ascii?Q?L7u0BiKsw95HXA0WH15F3nCGkhFPphxtgnpsQSAt81FeVy9t/LVu1SDAey12?=
 =?us-ascii?Q?cFo/4w+NRi5ltbyrPlS1ITHqifFum3bvMGcwkkoAxgLBRg1fh/+CYDzvr72Q?=
 =?us-ascii?Q?D437ftSMI4H4iTneADwCpEsrUpPGdOqgM3hrrApUCssVa0PSzhX1EzkVjpVS?=
 =?us-ascii?Q?81WBu/5ZfJWHEnSfzMdhzRYIlwZjvoU1EKcKrEievLdBvcripRaew522eIUg?=
 =?us-ascii?Q?TM2GovtzHg1hqL6MSpDEH8nKQ6wBFRF/ILXas2Ngm/0Oi893b9f633MKMlA9?=
 =?us-ascii?Q?SNoLseN9rIiBKdzLpU50qKni7Bx6KufAGbrOfP1JJlSy8p//RIC/BBHUYHeB?=
 =?us-ascii?Q?WvTerdR2Gy4HLH2jH+ZvXqO+4Jl+1RGTlkJnUyI9CpRy1DgT05WzVtEFjCVb?=
 =?us-ascii?Q?2pDFuIs5u+wXC6rgnYePSqDF7//khwGZHLf9cKy2BjfYqYfkE1ptXKiU3LK8?=
 =?us-ascii?Q?gRmialq0Jcm4rIPbfjxHYymX/AQT04wxzKeFUBq4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc4621a-8162-449c-c844-08dca0be433e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 08:57:01.6557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y5N+eU6uivGtRKiaFG6GGHYNteZffLibOrVs3baj6WSz2c3bKcHjEFzu453VZlUzj45SY1rT0FHhVYDo7dxung==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8580

Add NETCMIX block control support.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
V2:
no changes.
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 1bbf9a0468f6..6e86aa98b431 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1188,5 +1188,17 @@ pcie1_ep: pcie-ep@4c380000 {
 			power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
 			status = "disabled";
 		};
+
+		netcmix_blk_ctrl: syscon@4c810000 {
+			compatible = "nxp,imx95-netcmix-blk-ctrl", "syscon";
+			reg = <0x0 0x4c810000 0x0 0x10000>;
+			#clock-cells = <1>;
+			clocks = <&scmi_clk IMX95_CLK_BUSNETCMIX>;
+			assigned-clocks = <&scmi_clk IMX95_CLK_BUSNETCMIX>;
+			assigned-clock-parents = <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
+			assigned-clock-rates = <133333333>;
+			power-domains = <&scmi_devpd IMX95_PD_NETC>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.34.1


