Return-Path: <linux-kernel+bounces-225738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8599134A8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 17:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10F651F23860
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 15:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0726016FF44;
	Sat, 22 Jun 2024 15:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAHAxa3c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F73154BE7;
	Sat, 22 Jun 2024 15:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719068855; cv=none; b=BWP5B3mwt0/SomAJ/lEgnBOUS6V/BwMDNmbUADP/F47iIZpJn4/6iMSo8csQm0JIdCIgOkNNpcZtMeq4GPhOz3+wtFDn63BP+8URbf6iqkdkqnNH/xLxfBj11fxJTlOcseQMaF6K7Bh8LSsvmHvTW9Nw35AXvPQ8MY0pBXX0y5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719068855; c=relaxed/simple;
	bh=FkLEANghdY0F2D5oAhPpzR3TSX+luZAk5onCsfRlqBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ht+O8dkRBNXOqriuxJIpqxkP7VtNy0Ncy2SFWXYX50eOFNJQD//DGUcYGPQ5t3xe+BVl5U63Ht18wgLe1smZX1iWZwWkThl7gJJk00prOvm11MIV/Iu7N7m2pQgyEU4B13sh+V3jdmibYU7xs7atPAGIhSkN5aDXozEU/Kwq3fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAHAxa3c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C450CC4AF09;
	Sat, 22 Jun 2024 15:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719068854;
	bh=FkLEANghdY0F2D5oAhPpzR3TSX+luZAk5onCsfRlqBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KAHAxa3cyqn+is4Ur9RvX89VJ5N24VnFsJ4lM9RIBxdR1c4OlWYUt1ck7wimyjFqL
	 cyrwM32ibLLYu/jbT8anZF4vdW4lfswSeZ7d2OtdIY4u0lCGpp+Yz9jdLjs5rc4Ae5
	 QnAclpNZkg2OX1ZPgJywYRMp/FWeFUgpKkil/1+WUnqCGsgl8Q4R57f/Tks29rnFJ1
	 0ZhsbNVUg24Wduhlzl99PP4GStWBUTQhAoou674xYgb9aMGYS1WTEZuz8o9mcQJ8Qa
	 WyUwG/f4SE7zdyEmzXqXOLE4f5hnmFJjZ3a0PY0CnoH6m+iCxAE/tq+xZZ4NOrdl9a
	 k4uvOWV3hmaXw==
Received: by wens.tw (Postfix, from userid 1000)
	id AFE9B60341; Sat, 22 Jun 2024 23:07:32 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Chen-Yu Tsai <wens@csie.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] riscv: dts: allwinner: d1s-t113: Add system LDOs
Date: Sat, 22 Jun 2024 23:07:30 +0800
Message-Id: <20240622150731.1105901-3-wens@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240622150731.1105901-1-wens@kernel.org>
References: <20240622150731.1105901-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

Now that the bindings for the system LDOs have been merged, the nodes
for the system LDOs can be added. These are used on the ClockworkPi.

This was originally part of Samuel's D1 device tree series [1], but was
dropped in v5 as the regulator bindings weren't merged at the time.

[1] https://lore.kernel.org/linux-sunxi/20221231233851.24923-1-samuel@sholland.org/

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
index 5a9d7f5a75b4..e4175adb028d 100644
--- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
@@ -396,6 +396,17 @@ syscon: syscon@3000000 {
 			ranges;
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			regulators@3000150 {
+				compatible = "allwinner,sun20i-d1-system-ldos";
+				reg = <0x3000150 0x4>;
+
+				reg_ldoa: ldoa {
+				};
+
+				reg_ldob: ldob {
+				};
+			};
 		};
 
 		dma: dma-controller@3002000 {
-- 
2.39.2


