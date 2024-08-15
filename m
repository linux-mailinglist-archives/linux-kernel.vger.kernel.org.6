Return-Path: <linux-kernel+bounces-288272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0875953831
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A547F1F2484C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED461B8E9F;
	Thu, 15 Aug 2024 16:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Tnv4/hQd"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7081B29AD;
	Thu, 15 Aug 2024 16:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723739130; cv=none; b=CuKndphureQlqTsJ3oUvZTNUIaiJECllm88KIkQVDNpq7L8M/ae/Sy6BwN1RbO1RIT+z5TMgN8YEhU+uYnoZZUgkGsLA9h5tTdDkp4LygM+EjJf8wKRIBZbaJp8AAhNMRnD9AgKYySl0ed225F+b00s3VsI20MhZ7/2gFFAs288=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723739130; c=relaxed/simple;
	bh=n+hQrW0DZGd29Y/5cLkvGvpvt8KE+MkqtTxKZaNHV4s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lC+kyDE1gZKIixLgX1ecJGZ2/taMI4r07qQcm70dT4XX06S8AJzdyrTHnbYcQLm4Sq4rpULNWkZBMMVk0wTF5JQpm7XGoMhpqVjLuF/ne0Uwo1sCP1NeBqSbeDzZzfjjg1P4piHlJstUTCF2wUzL046bGnjEFq7ffipFzRPACJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Tnv4/hQd; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zrEFK7BocBO/Y/PqTgglKKBtGmH+ZLwsmomcACBjF7A=; b=Tnv4/hQdv/iqgmfOLx/k5lkkeT
	TH9Vyitk9usEXDzKiObvmAqaK2K4SKIpIUMvzGBrg5YA9R505rdVR0wuR/e9SA7n2WhNwyU9Gz1lb
	xGTM5Hbadv+p3ABAwQJx+CHVHDtdym20j+oRH7ZkP9CWcClaJKZ0LFaapTNOHdudYmMLBF9jhGfWN
	Vg4992ilJ/yrlnR70C82a00U7vmE3+hb01fa+mAo4iVZDTjrFMifNvaID5xFLB85B9WRIFHlzx0PA
	JsTxyF5ov3987npzuFVZxKnbujVLMtAgSeOvXLSYzjdMnfqP6Az20hmUg97uWDqEL8RUT4NbT1TXm
	sxYuge8w==;
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sedHs-0005Hs-P7; Thu, 15 Aug 2024 18:25:20 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: robh@kernel.org,
	aurelien@aurel32.net,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: drop obsolete reset-names from rk356x rng node
Date: Thu, 15 Aug 2024 18:25:19 +0200
Message-Id: <20240815162519.751193-1-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reset-names property is not part of the binding, so drop it.
It is also not used by the driver, so that property was likely
a leftover from some vendor-kernel node.

Fixes: afeccc408496 ("arm64: dts: rockchip: add DT entry for RNG to RK356x")
Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index d160a23fd4959..c29b444f9b56f 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -1119,7 +1119,6 @@ rng: rng@fe388000 {
 		clocks = <&cru CLK_TRNG_NS>, <&cru HCLK_TRNG_NS>;
 		clock-names = "core", "ahb";
 		resets = <&cru SRST_TRNG_NS>;
-		reset-names = "reset";
 		status = "disabled";
 	};
 
-- 
2.39.2


