Return-Path: <linux-kernel+bounces-423661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 021079DAB07
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD4F1281EB0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E9A200B81;
	Wed, 27 Nov 2024 15:50:30 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2B61FF7B6;
	Wed, 27 Nov 2024 15:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732722629; cv=none; b=TYsyaEtK5LFfj0Z+AnKgYF70aeS2wOkWxBroIr6A3yuo6prrSDtyUm2oyoLdgzeBhk/v6iQza5JfecAWt7x6NbOJwTU0GOxffSWClt4bm/3RCIPZOz8ihgpgWTyE7y87dpAJbem2AqwulAV9hm6fAocYXqlHYHwbYnWVanzHg1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732722629; c=relaxed/simple;
	bh=rdqoSNmKZeaq9XwR80IfP0nIm4a7L3kh/jEmUvQgYo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GRTtZkZ6DqBINHQoOl55X5c+nLkcZnDoEvRWFJkaPhXNZFJmgB9vv2J/stnvGzXbqne+YQnboQd60YioEX+dnmBZtwPud7NJo7qjszfq5+Gv0ZEFf3W+X1/lOH1EG9KQu3Oz/s/4fNWdQhCZsqY1+3rdDb34WFFY/88DzXxbyfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from hay.lan. (unknown [IPv6:2605:59c8:31de:bf00:6ecf:39ff:fe00:8375])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 319D6B4B1E33;
	Wed, 27 Nov 2024 16:50:23 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Henry Bell <dmoo_dv@protonmail.com>
Cc: E Shattow <e@freeshell.de>,
	Conor Dooley <conor@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/1] riscv: dts: starfive: jh7110-milkv-mars: enable usb0 host function
Date: Wed, 27 Nov 2024 07:49:23 -0800
Message-ID: <20241127154958.71094-2-e@freeshell.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241127154958.71094-1-e@freeshell.de>
References: <20241127154958.71094-1-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Milk-V Mars board routes one of four USB-A ports to USB0 on the SoC
rather than to the VL805 USB 3.0 <-> PCIe chip.
Set JH7110 on-chip USB host mode and vbus pin assignment accordingly.

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Signed-off-by: E Shattow <e@freeshell.de>
---
 .../boot/dts/starfive/jh7110-milkv-mars.dts    | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
index 0d248b671d4b..3bd62ab78523 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
+++ b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
@@ -53,7 +53,23 @@ &spi0 {
 	status = "okay";
 };
 
+&sysgpio {
+	usb0_pins: usb0-0 {
+		vbus-pins {
+			pinmux = <GPIOMUX(25, GPOUT_SYS_USB_DRIVE_VBUS,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			bias-disable;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+	};
+};
+
 &usb0 {
-	dr_mode = "peripheral";
+	dr_mode = "host";
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_pins>;
 	status = "okay";
 };
-- 
2.45.2


