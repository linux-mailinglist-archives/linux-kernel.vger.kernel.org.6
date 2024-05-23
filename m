Return-Path: <linux-kernel+bounces-187155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C53498CCDCF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D0B1281822
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C91144307;
	Thu, 23 May 2024 08:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="xhz+jW1V"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2044.outbound.protection.outlook.com [40.107.255.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EB7142621;
	Thu, 23 May 2024 08:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451473; cv=fail; b=SnENu0rMCdYRy3S09t/ubah+NRWVRifyn+TIpiAUkav/haXlCzaoilfKHvQzoxYD0U7Lyno6BcoWSoGDorBZyzKE+fNkj3YgKkY47JILPeTbM66MnDPhuXVW8GpxTVklFWnl2BqWbk3PtCBeGRtidUj+ZWuRt/Bp2INmx9m8cqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451473; c=relaxed/simple;
	bh=9QLFR+VmV/z9TnXDPdlSddPjyt/lOEkotMb2isambQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WuHDeUkuzCYUdWxWKx2ZA9qDUJ/Il5I46xbxZrceYi9Pmul0G+Ob4LUowzsvqH3D6T6Bx5SH/+VbR10rUyiPBAnqumIsr3QZNa4R9hPL3Whnhpq1iNCHgQt0N82uNNdpGV0Keri3fH3ySmSxZ5H9mm5rVRw6DWibODwnywx6J0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=xhz+jW1V; arc=fail smtp.client-ip=40.107.255.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+tFrr/bKb2Vv6dMuPYULJq6oDRTM1EGQxzKZl4KPfmsXckPpn9jfxgBFYV0hKfzVhLqPoqs/2k5dB6j4J2ge2HdzWIKyHoSS5JqHl0k7HjSHoxL4APUqxQ+f1PgX8Z17rDWQnB/nmMRi+YwtS7dhvtSBGZ29xuHcArM8Z4qOI5eNHZHWPVN0q2gG4Jfausepn9omiS/St8V2rL3vgJsqSwIp8hNeAMIC6OZ4z/eq20hV/vqgsR1d1TnxpI+ud8f8E0czWPSoJEIOJLfyhvKrFKN0LstMTglppAthB2Q8sYCNDtbyveQcLN5BC3BhH+fzdx771fEERyKGuVcIAr0zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S11d+Rgg5XKlgMlTPsawAewq2X5TMPnusGFqrYm+mrA=;
 b=kI3bKMDPLWbk6RBYcQiHjwmNUCucfIproInl3Q5WK+gk37i2Zhzvp3vIiJIURWAzltTcMqe2+Ul+pCAufffgu1jQAmaVdjYUn4xJDqXREnFC2PHuATNN4zPwdU3cMn516w6qyMD6g/Dw5YLduM+4S9LJ2dLkWcLbcDajh6TWo547pPj1u5u5U8idnu/tyrKrjH6vq41zCGcaD+8VhAGoF0qnOK/cveJRGOxXWs8eMhX0iOn2qL0ivHHRCkQiU1E+CW65gMCQxMQAcgzQwSX1bTCRdaqexFHEYbdh4vclaKWdISvp9uChL9OSNOP7eq9ltquLJIFjZd4d95cbJypCpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S11d+Rgg5XKlgMlTPsawAewq2X5TMPnusGFqrYm+mrA=;
 b=xhz+jW1Vk0KyOkRtjK0EqlBrwKZbXfPYL5MVB95rgC6gIHAJ2je+WDg61W2DMsOL2R7z7E2Z6/KkgYylvpIn0yvfTC9zwy8s582fK++OrVbKyMHKfKNdNX3xo/U5dtudERezNhUgPlZ9HFrxkDnBCpeQtgCiACBzKLrT2ocKiVF3Sys6oKUFV2fg8LBj5SRrkL/qVgH1uJVXWWL3gXI8ucbkXrd8zmTuEK3V/2ow3xKJ2xqQEEMwdS490bQb162YZlGzKBrGB4+4vU4y037fMq1f51FrtdmZNaW63F5l7rdnHEOaZa3vSP8oae0ypKclnaGtb46GqzJ8iN5DSHxeYA==
Received: from SG2PR04CA0170.apcprd04.prod.outlook.com (2603:1096:4::32) by
 KL1PR0401MB6210.apcprd04.prod.outlook.com (2603:1096:820:c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 08:04:26 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:0:cafe::73) by SG2PR04CA0170.outlook.office365.com
 (2603:1096:4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Thu, 23 May 2024 08:04:26 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server id 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024
 08:04:25 +0000
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
Subject: [PATCH v8 10/23] ARM: dts: aspeed: yosemite4: Add power sensor for power module reading
Date: Thu, 23 May 2024 16:03:15 +0800
Message-Id: <20240523080330.1860074-11-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|KL1PR0401MB6210:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6edb7e3e-f13e-4f04-3941-08dc7afef6fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|7416005|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LweRbAPssIX6HxSnSjguftoX5+vR4D2KIibCJYMHu8tnVQtUzRXcvsQTJYNm?=
 =?us-ascii?Q?8uaHh7fqMmmUVNmJqutOpd7yuEC+5z7yesKs3YC5U99fHY+vWF4po+0VXPdz?=
 =?us-ascii?Q?PHuxm9tgZpNaOHkS27rH3URzMM5+nMxWLFmtsmVogsS+THc+MiWMOkQ/2uoU?=
 =?us-ascii?Q?ciXpUj2jOh6QnAr2mYoKcTZqmUP3JrXQUFwBiCPM6LaKAV4FHn0emIsdzc/S?=
 =?us-ascii?Q?b9ko2b5Bn6n/wQRFDdScEKtbaEVSFQ+Fp0ITMBb0XqL9d322vDzyZoLzYddq?=
 =?us-ascii?Q?/uM2R57tk2zL4bpV9pN81Vk3Z7WuCillNrDrG6v5R1wKdKuzaYM8Cr8o+eSY?=
 =?us-ascii?Q?JqUa0yLj8zm+/HUmFw+quVlwGgLF3bsK/OvJNjW817gM8kPZF1yPdZJ1SE3X?=
 =?us-ascii?Q?DfR0pXKlmcfZmOk9QaMnLQd+bQCny/GHfjsEPucHwxfkJmmAgj4KesLWpucH?=
 =?us-ascii?Q?gu2oq9uC/UDRwm4V6ZTKYWeUe9iIuIZ/Ux8X7g86faC0+7ZoOTMVfN9u6Ask?=
 =?us-ascii?Q?CP0LYEuSx+cjtw5N0zS3JNaHzmxEzoshccaluiXdKlmSmGqv+ZgNpz0DM540?=
 =?us-ascii?Q?Ee9Ad/LHgcvjgl9CXn96RC1CZxiEp48ppH/TqW11vpROSSxfgvmdPwObWX1e?=
 =?us-ascii?Q?dlSBeh+AdReU5pytuN5qoTs8wzAy8pHC9oYTRRZOKQhM4gurEBIzNoLtglpW?=
 =?us-ascii?Q?Uld6uwkjaRUxBzLLHJY9KiLa+jMcSVzW0YCpVMw/yBzag6nDYxu6tk2kXX7z?=
 =?us-ascii?Q?lWp2iVII59aeI85VEXIv/rHIS7P6OiNw8uW1sYPl7jOaGFa+kaJ/mQI6aeEi?=
 =?us-ascii?Q?TMvrsfYjNA2ZLIOjEPbxS2BCzPSdDpt1Rvos7W7iTQhMiE8MVBH+gmPKEwNb?=
 =?us-ascii?Q?TjDz/Tvlvza0uOp3puixt2qp5PhKgX1lJrvOuSBsCGu+q/wavCR1N7oQsChC?=
 =?us-ascii?Q?aPpnW32nU3cKoCwCvV18H1HW7WPwbXhELq/tSXlScjAd/CMcHNcywvKUfv4v?=
 =?us-ascii?Q?rxOt0ZOyW5au5bDjacEOJ3NnaTh+EqAAva5Qb358TM8/ynCuryBuiTWqy30+?=
 =?us-ascii?Q?OaZHBxZ/SF04HcyneEMPQcS6TraPD4GR04A9d4Od/uz2OM4MVd1QETdVO6w8?=
 =?us-ascii?Q?PIkklYKQPwdUr/7uIFQm9u79sNmV2a/+qeN1ugkjWAKAWRAhmM7F4yUYQOnC?=
 =?us-ascii?Q?rKqcHR0tO2TztxEmYzlqIFtSUVCaeDDKCqbBo/Wn7aajPlV/XS/Y/hX81693?=
 =?us-ascii?Q?4HGZCks9rCCtMCp5XBT2xSY5GpcS/bSKUL6WpnmjqdnYgOGukbKw9a8fFk+G?=
 =?us-ascii?Q?rGYbZnsWWoxU9wljxKQPRwx3F2uC5QlFyNXJQu7ARG4AlAIdPe3kNrTwzyQF?=
 =?us-ascii?Q?90p6jeo56RA3Wo1BmjvklhwXKJ9F?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(7416005)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 08:04:25.7342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6edb7e3e-f13e-4f04-3941-08dc7afef6fe
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB6210

Add power sensor for power module reading

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 92733a8ecf0b..2ac872878acd 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -906,6 +906,11 @@ gpio@23 {
 		"HSC7-ALERT2-R-N","HSC8-ALERT2-R-N";
 	};
 
+	power-sensor@40 {
+		compatible = "mps,mp5023";
+		reg = <0x40>;
+	};
+
 	temperature-sensor@48 {
 		compatible = "ti,tmp75";
 		reg = <0x48>;
@@ -930,6 +935,26 @@ eeprom@54 {
 		compatible = "atmel,24c256";
 		reg = <0x54>;
 	};
+
+	power-sensor@62 {
+		compatible = "pmbus";
+		reg = <0x62>;
+	};
+
+	power-sensor@64 {
+		compatible = "pmbus";
+		reg = <0x64>;
+	};
+
+	power-sensor@65 {
+		compatible = "pmbus";
+		reg = <0x65>;
+	};
+
+	power-sensor@68 {
+		compatible = "pmbus";
+		reg = <0x68>;
+	};
 };
 
 &i2c12 {
-- 
2.25.1


