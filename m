Return-Path: <linux-kernel+bounces-292035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24462956A62
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C290A1F22648
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADCD16BE32;
	Mon, 19 Aug 2024 12:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="VP9dMiQe";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="IEA0YOSY"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AE616D9B9;
	Mon, 19 Aug 2024 12:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724069085; cv=none; b=c8PMCgctZ1GPaf5TqV/JQIXcWUaJyZf0h9Mw8rjnuF/H92E94aHHvCPEFrdIe4zXV25a1akJA0bcIG+0NhtcYZUKNrrQ8NDSzW5SxywjoWqrY90/EZTrQh5KHCM3foDVdXi5XFTggDGfeuyrJem28fgOJfqqolpe+L4oajDzpoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724069085; c=relaxed/simple;
	bh=cOvCF7ddoxuLGB8ZmqPr92PmJ0DCpazxZ0al1cO/JRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JR5Xv3GH7KotWUtDW4H/qC54q3pzD+qlv6mE1+hGv6leykKJ8f2eVaNnruV9ChPwcRfzXxVGZW04wlUsgppgVcXPAZfd+se1WlEe/InBlPawtc68Tqecvfj7emo7N58B7HFCLxqxXFf1YHhzyTzSqgdKx3uy2JYZq4++xS5iANI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=VP9dMiQe; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=IEA0YOSY reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1724069084; x=1755605084;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kk2j9StN4AZLZf0NCG5Rh0FIZy+v2TXllMl8suxny4s=;
  b=VP9dMiQepkiBTMnoDvm1D7qclOhldmvxlVyoTPjblQRmPEPWX6A6W+m5
   K2EFFHYTFGMS6Lf8cYfC3x2zBnXwRjyLaprKKqOTUgyhkQwsSxg7jssuZ
   wOj7z+fS8dkgB0YSrVWAlHPnfUVNHxRljVWw2rfmBT1MQzGq3qu4Illou
   FO2xAMZrIVOMaPP+NlaWo3wY82O7bXa4fY3WKkyexEXlTQT3o6RXHPv/I
   dW/KBHyUgjMT86CRxBjcDBd9fvpubGBpDMSRD5hKN5Pb2QDoIcsSl2y7M
   3qTY7eBaBGvuwfxlu4BZRCyIdGurs0DlXsfO0/wc+Gy6qf2ERl1khYbxA
   w==;
X-CSE-ConnectionGUID: P2zGBtMNRf2HHK95zxKnXQ==
X-CSE-MsgGUID: 0OWxnzluR7aX8MPPmQslvA==
X-IronPort-AV: E=Sophos;i="6.10,159,1719871200"; 
   d="scan'208";a="38467150"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 19 Aug 2024 14:04:43 +0200
X-CheckPoint: {66C334DB-11-FF00FE11-F2A862FD}
X-MAIL-CPID: DF22968BBA2747E32084513EDD9308FC_5
X-Control-Analysis: str=0001.0A782F19.66C334DB.00D2,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5980F167F5F;
	Mon, 19 Aug 2024 14:04:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1724069079; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Kk2j9StN4AZLZf0NCG5Rh0FIZy+v2TXllMl8suxny4s=;
	b=IEA0YOSYm3upuhMcwEjhdilXEhPDoUmrkbVykReFSWLs/l19slk1nj3/v3i3ikA/94in6U
	zesmSDZN2PFO5eEfJytV6iC8E0EYJ/SRl6IEffbvaxZYCPPjShtOmleFC8QkMNhgfVryZ+
	l78d9I3zR6Fqz81MdHgToHk2Tjv92vCQJjzqehr7cQmmBHL5dULU6dK8mSHFeeRfJ0QP4J
	111AUm65f8bGlJLUJ/VkB8zalItOhCKrrjQ8+nQCrFyT7EVBaCsT5AS+NYTwYhDZ4fXVDH
	6+NGylJoskKRGl7IA45CC0Y/+q1c/LcfOLnM+ImMJW0ewzU4cpZvLUqes1pP0w==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/14] arm64: dts: freescale: imx93-tqma9352-mba93xxca: Add ethernet aliases
Date: Mon, 19 Aug 2024 14:03:26 +0200
Message-Id: <20240819120328.229622-13-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819120328.229622-1-alexander.stein@ew.tq-group.com>
References: <20240819120328.229622-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

They are used by systemd to rename network interfaces to predictable
interface names, e.g. end0 & end1.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
index 60b288f89a530..b4795e2e2ebf7 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
@@ -26,6 +26,8 @@ chosen {
 
 	aliases {
 		eeprom0 = &eeprom0;
+		ethernet0 = &fec;
+		ethernet1 = &eqos;
 		rtc0 = &pcf85063;
 		rtc1 = &bbnsm_rtc;
 	};
-- 
2.34.1


