Return-Path: <linux-kernel+bounces-187150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6298CCDC4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 153B5280D1C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3085013D2BB;
	Thu, 23 May 2024 08:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="IJcKYRN9"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2058.outbound.protection.outlook.com [40.107.117.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA10313D2A6;
	Thu, 23 May 2024 08:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451455; cv=fail; b=Lz91PMLfLziXrdSDcKbMJ9maiZ8OJokTbbUVEXPMizcs04JYFp4coaH5dhrzfGIQ+/7zB+bgNfLAd4WTElwwvRUXmniQ9YHnuAqrrH7FMmwaeaytWEsC1p2X0aUZjWx+sJLo9uBAoQ0GMigpxxJkX0BknGMFtFeerNYJ9Hh1gNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451455; c=relaxed/simple;
	bh=mDZZJlkVcsKOGKmKvCEVvBfa6/zQ+Wv7iupq0qbeGNY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iCZfcq7GjM4WxRQFyw4Hsjx8ooJIA690VE1tl/ZKkdNWMxLj9ksJE+tMrBCm1VlokKpvR5WAR9V2NZ8batkINKF8SnO2p4+hHTHXjwuA9FGJe1ZscMwTnLyo5V0YW8rD8pj+Cue9epJdZ23h0th5MNwl9wyyuvGyM5pyZIS42f0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=IJcKYRN9; arc=fail smtp.client-ip=40.107.117.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8d5oLGP/MGAe/cNg5zRhIxajQiAhertRhiABiQ4AZQ9wZvFAJgZd2p+M8tdPmhZfwDmEx5jdKyAU+lCHDlBg2VKB/sDbaiG2+FOxoWww/wY3pzR4sAiU7yx471VCvwRF749nVOtSRepAWov5zegVZEKg61U/GbNW+n52AJXRfIB+KcDZ4lbmpUJBfNKt1xFgAyi0l7E3i10DFcbXShiPbyn3ZqNzMd6iPIVLsiVaYiZhCKNhf32fEwsmvOv7YxqHMefKcKoq2Vrke9ZzZhPxAZEcSbmGAQIZYneHWjPy3ugkE8iaLAiSP2WJIWTjQ2kLZnZfy59hDRsgT5FMk7iZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/dqJuii+ID5NkttuzvqI67JF2qX2ZPzbFRrGdWVquY=;
 b=oZKrGgwUljOefhLD0+IQx3OFdMPEUTN10Br1Y0rwMOzefnC7mZnD2pPFy/dowlC3EyT5i/jS5QZFaNeZIcx0ZY1TiQmiui9UJbvCM8Xwk5xLbBOAcb9OG8FlvShR/zboHP3zrhadVuuh04Vz0N4MEk4Wts1IEhGl3az/kvpbX+9sCKQ+35B5/BhLNAfAeN4IKZDWFI9ofqCtDPoMsnKdWS/sqIQ8swHP4h4Z4a3msyd5WRivpZWnfgO+vlyrSDpfbL+28A0tyOIr7lCawM4xmZFtYxZkW0WxTEpKb9UzEXhvqTanSDvC71qfUDr14wlr4tbJKEaCU8YzNKnMc4/XIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/dqJuii+ID5NkttuzvqI67JF2qX2ZPzbFRrGdWVquY=;
 b=IJcKYRN98nVlgpzNtMwHcFJIvZNT2EhrECiCXh9xtFDZ5fKuwt6b5RHYGsCJJgrFrMoedmPM6FBMCzjYKGeRTqX4+zuG4qjQfW11t44pM6UVoLZuDWzlyV02s9ra+1rYlsAm69lyFXcwTrE0NjFU9UrsmpWaKlPXRiYU2/2hKomrWxbLutGVLBls7/MW1xIJ5KGnb2V7oqX+TaAGPFfevTGe2on81X56z5xWya8jZCeDo4LNj92pI2bTJJVsPcqNBEX9lw2KaicSIfkVa+SYvRuy7YlAZXkmmTy4oFWlH8qbBAAkrod4+T+bQUTMC9kLjjFK0zQk8Pn03b8/1JSBTw==
Received: from SG2PR04CA0174.apcprd04.prod.outlook.com (2603:1096:4::36) by
 TY0PR04MB6422.apcprd04.prod.outlook.com (2603:1096:400:27a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 08:04:09 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:0:cafe::fa) by SG2PR04CA0174.outlook.office365.com
 (2603:1096:4::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Thu, 23 May 2024 08:04:09 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server id 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024
 08:04:08 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 05/23] ARM: dts: aspeed: yosemite4: Revise quad mode to dual mode
Date: Thu, 23 May 2024 16:03:10 +0800
Message-Id: <20240523080330.1860074-6-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240523080330.1860074-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240523080330.1860074-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|TY0PR04MB6422:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5138d813-e501-4dc0-5afe-08dc7afeece3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|7416005|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e86YnRC1odN7WJxVej2Vtr3KWvR3pD9HSRFjujQvDk8R3kzara6ocN8k/iqE?=
 =?us-ascii?Q?ALPCdiJSXTx2fDiToZvW/Vjmwxu4s3+0g7n6buhb7vvvc+a7NPJVT0PLqrCz?=
 =?us-ascii?Q?thcId5U2zj9OTCn8YU02u+7PuF4kUVv4F8DpRHvLQ3+C2IbCZiEKKpXGmrP+?=
 =?us-ascii?Q?IikqfaBpbZnC0rqePT5fwkxEZAljTegTPB9bzCaL6qIIaep4SsrSyvN4Hv8a?=
 =?us-ascii?Q?BOto1AuXzTdOIMXFHVlu5hd15utlBCyVjxBVrGJfWTBAC30cAJNRPX7/M3RN?=
 =?us-ascii?Q?ysJ4JF7AodEiH8zHtlH+Wx9Dsb60TPxlx0DdMnG+NLEFtY/MdERYv2VcXV3X?=
 =?us-ascii?Q?6/PZOZoykJtTPkFgF3vQxVn9PSMkb+rbwXhE0mpVps0xOgj9lm0V+S0zkCP+?=
 =?us-ascii?Q?YN5SalK9TqCKzPG7jWw0oDODIyml5g9lguMFWnhweEF0v0ZZ50t9C0BiSjKN?=
 =?us-ascii?Q?xe8/DNJf5TJ7PJHBqrBHTfBziU6K2utxHVMM6dbWGfUSkk/Y1zDiV4jfsfP/?=
 =?us-ascii?Q?ki3kqfKmDbS6mc0i7+Z1KR8lXjKHA0kdsUztEDP8gGRt0fMifHkv2zSykdo2?=
 =?us-ascii?Q?hn1nywkDcHmVVlozjXKuqhJAMJGtvQ/xaU8c9YX8VnW3SIbyvf/QrxToHhcs?=
 =?us-ascii?Q?2FE5VfnwQsnDope511ZkCkbUjbjdj9mWy5iBxpzVuGD2vJimV9p90W34UYSI?=
 =?us-ascii?Q?odcec2ryi+Dd9/yCZF9fDy8b0c27/pnA9sMFtyOnH3OS1NuJHVfVDgsBp8Pg?=
 =?us-ascii?Q?vIbioBRlqkqgn9z9WQmZGUUIf8/p+chh9EppU+vqVdgGkJH1CSvw41lRXHej?=
 =?us-ascii?Q?4cS0KMc3Hjeb3u9p7UYtDmrJYLbxvwCjb6ZqTdbBqkttmcy8SMAnakSGlVyq?=
 =?us-ascii?Q?Dz+CUymbjzJN7Q13AqhHOBwHZ3R5BbnALxV3xPEhr8tzIvBKeeBRF/Zg88KV?=
 =?us-ascii?Q?pUG44KpVNeX6B7TMozMjukDe99xyld48BSeMDiGcGSqko39TuBz1fkEJJflk?=
 =?us-ascii?Q?iX4Zz2r7XCpQJbQniBsSDZGYSQ8iihB7sdh+/uCvBm8CQnyRZDBqICJx0uKr?=
 =?us-ascii?Q?WvQhJ+wwp7NW/E6w+sZx4TYATFG7uJsK6QWrQBZNcQfLIOBK/1E8bpXNuSLC?=
 =?us-ascii?Q?ahZRyS/XBqlaoIAbcEW39CsoP0/j1pvTLtHO8zsAgx3IJKqZzcIPpf85pOnb?=
 =?us-ascii?Q?BosSwFJqww86+atVbGjIlAqAyaXwZzkI5dR/FITUU+YYx1lJgIXjXQ7ehkK8?=
 =?us-ascii?Q?ovE2enQkhIGnCa+iYmwDB7teEm+v1/AUpeGyNJB/aogkS/WzXWLxwYv+39eD?=
 =?us-ascii?Q?bCxaOlYszQTUJplZN2Wrnb7JFCk98N2dMAkRMWLQgpI3dUn5Zli0L3ISQgrB?=
 =?us-ascii?Q?klguZFNwsrOzh+Ni/QSBYUEpiz0v?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(82310400017)(7416005)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 08:04:08.7497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5138d813-e501-4dc0-5afe-08dc7afeece3
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB6422

Revise quad mode to dual mode to avoid WP pin influnece the SPI

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index b0643e8aefee..a708e56b7ec3 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -149,15 +149,17 @@ flash@0 {
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc";
-		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <2>;
+		spi-rx-bus-width = <2>;
 		spi-max-frequency = <50000000>;
-#include "openbmc-flash-layout-64.dtsi"
+#include "openbmc-flash-layout-128.dtsi"
 	};
 	flash@1 {
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc2";
-		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <2>;
+		spi-rx-bus-width = <2>;
 		spi-max-frequency = <50000000>;
 	};
 };
-- 
2.25.1


