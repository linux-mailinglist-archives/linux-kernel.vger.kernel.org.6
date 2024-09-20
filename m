Return-Path: <linux-kernel+bounces-334106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A4897D2AC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35E9A286EC8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D7914A627;
	Fri, 20 Sep 2024 08:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JBQy5fCd"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11D57DA7F;
	Fri, 20 Sep 2024 08:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820613; cv=none; b=d9orKZvNlWWN769zF8uERijLKrY1D7u+d/1Abm32KTyuYghvMCrgrPV3B/X1yzhd1EfvHyK12/hqwX6is1Cco4C5yBRMbOVjjJmTYtJc/Y27yMg6FWfB9vzUvEqVFFcyQoXifMMO7TMUkwkSFAwkYwf72EjC+sz+2nkVifl7FYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820613; c=relaxed/simple;
	bh=CHYjGuFvzYe56c3qHxTRthJqcCNbin4VchMMcRFCPJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9UukWftn3cW8W64mXoEVogr/sjOURPL27D07C6khYIsNOY4uuXwmRV4UXlt8PbwWBWJESaQ+L7M3GjNp5ISvtDdKLd9EzF1TzOsEqnrQlQIFTFxNvlWWvLvO18Gxgr80UrH2vswr/H99VRBl3MVB7NQxgWhMM7C01BnZdCF27Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JBQy5fCd; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=C7BXA
	3vRFQzypGqSRa+Pr7mmHTFBAcqnlbyhQTd3wVU=; b=JBQy5fCd8gJu1BMZYWjBt
	WS1bMgTY2/jGGmacJ0zY+fPrPXMV6GON5OxK5L3649xLNlgpW5sMaWxWCpyPsHxF
	jQ03uu82829tVXG7lj8xlKNvDlL6bQsZu0IFiMdCOAIzNGPRNgNqlcsIlJMVj6dt
	jTdNj0dLTG9hrLj9W8uGQY=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzsmtp4 (Coremail) with SMTP id sygvCgDHLl7rMO1mqCVvAw--.49823S2;
	Fri, 20 Sep 2024 16:23:11 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: hjc@rock-chips.com,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	s.hauer@pengutronix.de,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	derek.foreman@collabora.com,
	minhuadotchen@gmail.com,
	detlev.casanova@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v3 14/15] dt-bindings: display: vop2: Add rk3576 support
Date: Fri, 20 Sep 2024 16:23:02 +0800
Message-ID: <20240920082306.6982-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920081626.6433-1-andyshrk@163.com>
References: <20240920081626.6433-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:sygvCgDHLl7rMO1mqCVvAw--.49823S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WrWrKFW5tF18ZFWrKF4rXwb_yoW8Xw1rpa
	93CFyqqrW8GF17X34kGF1rCrs5XFykAF43GFs7tw1xtwsxKrsYgw4agrn8Zr45GFyxAaya
	9F4Sk348A392vrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZo7NUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0g9gXmWX0hs8xwAAsj

From: Andy Yan <andy.yan@rock-chips.com>

Add vop found on rk3576, the main difference between rk3576 and the
previous vop is that each VP has its own interrupt line.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

Changes in v3:
- ordered by soc name
- Add description for newly added interrupt

Changes in v2:
- Add dt bindings

 .../bindings/display/rockchip/rockchip-vop2.yaml    | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
index 2531726af306..a44964b6c36a 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
@@ -20,6 +20,7 @@ properties:
     enum:
       - rockchip,rk3566-vop
       - rockchip,rk3568-vop
+      - rockchip,rk3576-vop
       - rockchip,rk3588-vop
 
   reg:
@@ -37,10 +38,14 @@ properties:
       - const: gamma-lut
 
   interrupts:
-    maxItems: 1
-    description:
-      The VOP interrupt is shared by several interrupt sources, such as
-      frame start (VSYNC), line flag and other status interrupts.
+    minItems: 1
+    items:
+      - description:
+          vop system interrupt, such as bus error, and vsync for vop version under
+          rk3576.
+      - description:
+          independent interrupts for each video port, such as vsync and other video
+          port related error interrupts.
 
   # See compatible-specific constraints below.
   clocks:
-- 
2.34.1


