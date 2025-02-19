Return-Path: <linux-kernel+bounces-521070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D8DA3B388
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7626F173C5E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464DF1CAA95;
	Wed, 19 Feb 2025 08:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="MLLL0RW9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="GwRoyopz"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBD71CAA9E;
	Wed, 19 Feb 2025 08:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953133; cv=none; b=I8Yl9019i7VoxgYAB23uLUc/jqumic51EVzNuRGq0wEgbDr75Rm6QGSpD8ffo/JsTc8TxHFBmIj7ogm6bHaMX03HsOQXaONGTtMyZOgZGh8eCh7fq2rG+LF5tK85z6RscJzrk7rBeB05gICCf/JqJKLVdjUSMxkuSNbjUmqnCTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953133; c=relaxed/simple;
	bh=QGDwY1x4W8QtR5yxKgHmCsEFYX3eeJHlwtwdFaWhWgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QgNvjA6A/WEGyPNynAdGkMUIqKJg1Bdz0uHjqNlQ7KXiumF/FDR1mj36SsPtujJwa887e2JEWZlujZX0KKELqk41Rpkt5U5ZF2KjIz0XBireGjWwgDY7D4adDD4mDzLg9WmMGFruBB3VrIhgDDQqpY10jCKH/Lt29Bi49QzqnpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=MLLL0RW9; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=GwRoyopz reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1739953128; x=1771489128;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sJCpfFuLYwpfyisJZD4BZNp2s874UbfEw6yfvZepqdE=;
  b=MLLL0RW9fb4ZoXako2zh72F1Ks9ZmG/V8izhIMAiaG59HpV5SZtn6HE6
   cQFPaqij4NhP4z/3OHdJ1G15OQseniW7hHGIRcx3D37B1qMJ356BLxpC/
   /5MIs6jVFtj25JlTQOnA6P9JIaZ2OFOxjivKqfmRBnHnPc5vHcrD9/wUA
   YS6y59m+ktKieZ7zMMAwP3NimZ7ZZyO6AZgYBwFXta67m/1ppEmal19Ap
   H/u14J8/+AmlfvdNE6OypGmH+zstGVlwZOGX1xJMCr9pJD0fgdn6L6Hfq
   wPCvNlbP2niRR3XRubU7Yq/NOlRvX09VboCvG+z3gKA3r33CTc8YVkRnC
   Q==;
X-CSE-ConnectionGUID: PIkwYlt4RYWT1ITq5zOsOA==
X-CSE-MsgGUID: CtiBKZdITmql8A1axdGK5Q==
X-IronPort-AV: E=Sophos;i="6.13,298,1732575600"; 
   d="scan'208";a="41945182"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 19 Feb 2025 09:18:45 +0100
X-CheckPoint: {67B593E5-38-6E0A4539-DBC44C3A}
X-MAIL-CPID: 6D57F2DBFDF88598594366B5F97E1B52_1
X-Control-Analysis: str=0001.0A002119.67B593E6.0005,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DE5C316D46F;
	Wed, 19 Feb 2025 09:18:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1739953121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sJCpfFuLYwpfyisJZD4BZNp2s874UbfEw6yfvZepqdE=;
	b=GwRoyopzItomM2TruwIv/TMEriySQ/CwUMzGt2NqsfLaBvVzNVKrQBP74VhmnqpCeQmiv7
	He/wg+RrMR7ig6zAv04r95MmET2/uVarahSHpmj9pmmUgmuTpZkFOhPkdgZgRS6RSaut8L
	I0h9BztWcpnd05oCdJuuQ2MktdPOBoxztlfLk+ZfUdi6wow2iUEH+vaMFPwhYQnX7k/zq8
	ql6cLIbmQGezhIrRtZ4sWi9Vl3zDibw52HZ1UHuEIcHgKY1GKEYQPKA25ytfHXR8Mww3cQ
	ivxQrieoWVtCQlPZRnG+1HniAhan/sulxI7sQ+EuXbZ8bPcGIIsV8PWKb8DlCg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH 9/9] ARM: dts: tqma7: Add partitions subnode to spi-nor
Date: Wed, 19 Feb 2025 09:17:44 +0100
Message-ID: <20250219081748.1181507-10-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250219081748.1181507-1-alexander.stein@ew.tq-group.com>
References: <20250219081748.1181507-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

The bootloader adds MTD partitions in this subnode if present.
Add an empty partitions node which the bootloader will fill with
configured MTD partitions.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi b/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi
index 618c3f68fbe25..2966a33bc528a 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi
@@ -266,6 +266,12 @@ flash0: flash@0 {
 		spi-rx-bus-width = <4>;
 		spi-tx-bus-width = <4>;
 		vcc-supply = <&vgen4_reg>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
 	};
 };
 
-- 
2.43.0


