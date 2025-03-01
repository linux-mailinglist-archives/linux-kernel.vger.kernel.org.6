Return-Path: <linux-kernel+bounces-539884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1843EA4AA48
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 11:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAAA017104A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 10:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FEC1DE2C6;
	Sat,  1 Mar 2025 10:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="CBr6IEh4"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DC41DB15C;
	Sat,  1 Mar 2025 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740825814; cv=none; b=QXl5fVKEp/8qMFp5feiZTFiNEk5tAt/JH+cCtTMRXQdxildTUMErFfT/Y5lgsem02gezkfJhQwLzHW69PcKytEgUQfba8mRFGHQV7xKE05BfTnKGj9KJRG3lvgO22NQU+RFuJfdpD8/635WefmTIHAof/secxgbFJJRrNp0Iwec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740825814; c=relaxed/simple;
	bh=+/8rpNaXqgj2/UDdoRlxWLdQHgeGvT0ON3E4PuZizwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vGIarM/1qmnXyS/bpbDHwg4+s5vEL/xiwfRTr5uKVq+TbJNa2gjoq1PRuqV6Hte8QWEGulmG8nqnuXyGvvEL83Zp7aGpL+IvXC/nLHVYcMqH0BymIvo2si8Nsb1akh5g5Z4KcoWuO5kxX8ugVFumQr26ScWbLuvT8mWwV4Cdcd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=CBr6IEh4; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 017AA25E9E;
	Sat,  1 Mar 2025 11:43:30 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2tShyXdx4OvH; Sat,  1 Mar 2025 11:43:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1740825809; bh=+/8rpNaXqgj2/UDdoRlxWLdQHgeGvT0ON3E4PuZizwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CBr6IEh4ns1UkkAX2jgVc8D44yDKhj6U45DkWOx4DAJf3rJGDq10+NtJI9NObCHrJ
	 WM9pbfm2XnDVPfkeM75v3Ckb0dd12tLNDIwdITy0aj7TWY38YJJABZ9SELpkWPl23C
	 NrawBTlMIB0oVc+Di42YukqrgTbwUn9MPQkCB87YjB+5wzgeu2KVZknRAWqyRmkG98
	 MVCF4Ufk0Gv7B9dVzw8+AjjfYWAA/FomPNA5UT8blVZFsJZpRmFUF/9Kav+m+F8P45
	 u38BKwYPSnTVmN0JV0+0J8CY4dKhiFLQrIOfsHxK5RCJQPc2Zw2aEpVX1AFiFEcoI0
	 TnKllwalzlOPA==
From: Yao Zi <ziyao@disroot.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Frank Wang <frank.wang@rock-chips.com>,
	Shresth Prasad <shresthprasad7@gmail.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Jonas Karlman <jonas@kwiboo.se>
Cc: linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH 1/8] dt-bindings: soc: rockchip: Add RK3528 VO GRF syscon
Date: Sat,  1 Mar 2025 10:42:43 +0000
Message-ID: <20250301104250.36295-2-ziyao@disroot.org>
In-Reply-To: <20250301104250.36295-1-ziyao@disroot.org>
References: <20250301104250.36295-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible string for VO GRF found on RK3528 SoC.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 61f38b68a4a3..7936be79159e 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -15,6 +15,7 @@ properties:
       - items:
           - enum:
               - rockchip,rk3288-sgrf
+              - rockchip,rk3528-vo-grf
               - rockchip,rk3566-pipe-grf
               - rockchip,rk3568-pcie3-phy-grf
               - rockchip,rk3568-pipe-grf
-- 
2.48.1


