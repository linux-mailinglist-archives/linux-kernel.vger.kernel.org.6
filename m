Return-Path: <linux-kernel+bounces-284145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0CD94FD8B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A89A5B2130D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF0136AFE;
	Tue, 13 Aug 2024 06:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="c5DB6ZNg"
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7E137160
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 06:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723529107; cv=none; b=INjSYRDyltcvrCoqpQi8MTweS6s0S9AuoWOtduRN0u1o+WYg36qVxPzEWKYg5t3ZY+0uqs2LZL36DslVUTbV31H1mhxX9dVMHPiPKjqxtQxAsN43YfZNoUXgbM9h82+JFkRnHvoODlPa6YLOr5AYaMg125kFXK5Xvjy/hxbuq5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723529107; c=relaxed/simple;
	bh=WcfJ7WTdADIYYkRPneqkHpbRz7chEfpxWxFcF+Q7f1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R83ypwEu53BYnXIz6igVL+plp0o0IsTHlh/6Okfw3nL4paZfzb4/Tt71hvdrhB6O+eM3SnepEN0Kl9JN4ZDLWvI1Efkg+jgtimSvofFTpXrGNDcIASTuFMBTWA3cl0SAn5u/WJpP9Q7VSRbW7E/p9xs0hMH5k/Yo1gFbPPYxXEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=c5DB6ZNg; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2024081306050207ae97d96bd390aaec
        for <linux-kernel@vger.kernel.org>;
        Tue, 13 Aug 2024 08:05:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Pv6R5qO6OHa9npCqyOnvNhJtNg3sOz/iholMJCquoQM=;
 b=c5DB6ZNgIAd5H22UowYgV2MMkbKFK/rXb/L0pVULRjdW7in4ER6Yt2oIxgqkla4IVAKBdc
 +q9/P1+3/Aa4/NT1pE6sofVCK+eY8CAIWhxcGaDGrnI05es6KQqFahT/lT2k63S98YcRqmGB
 MvMX3Y0aRpiVfH54zgvuzbvfbs7+1DILB2sVMjaH0gyCABQzBVccwPK055EMFUHf3GMxYPK/
 MSIgL1CeoedRokcsLk0xt2cc8OIVa8zqxWIg7bUINV06WLUfa++FmXbm9Ppp1hzkTGZ53t/f
 2bDPkkcmYjvjhkMKLL7nL6soIEaQwdUUwEhapfL8NOTn+n5sNtAH1AUQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Bao Cheng Su <baocheng.su@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>
Subject: [PATCH v3 3/3] arm64: dts: ti: k3-am65-main: add system controller compatible
Date: Tue, 13 Aug 2024 08:05:00 +0200
Message-ID: <36799828cb8bc85a2f6e948f5414d705544bd3e6.1723529100.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1723529100.git.jan.kiszka@siemens.com>
References: <cover.1723529100.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

Now that the TI K3 AM654 system controller bindings also cover the usage
in the main domain, add its compatible to address dtbs_check complaints:

  k3-am654-base-board.dtb: scm-conf@100000: compatible: ['syscon', 'simple-mfd'] is too short

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 06ed74197f89..a8664b246795 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -471,7 +471,7 @@ sdhci1: mmc@4fa0000 {
 	};
 
 	scm_conf: scm-conf@100000 {
-		compatible = "syscon", "simple-mfd";
+		compatible = "ti,am654-system-controller", "syscon", "simple-mfd";
 		reg = <0 0x00100000 0 0x1c000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.43.0


