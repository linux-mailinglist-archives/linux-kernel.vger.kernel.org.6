Return-Path: <linux-kernel+bounces-226712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B78A99142A2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53C9D1F21485
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 06:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A22E25763;
	Mon, 24 Jun 2024 06:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="J+N1DK0J"
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F9622067
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 06:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719210063; cv=none; b=gUdj5fJrsd0ds90mBtKqL4AsRbtqetJOZK6vdH+2/qD5qG39RafUeRa0Bs9ypiMq/0G1e6K5x1MIKBwNcRYVyqonJFZjChWwPuI5/4iQJanxIA/S3xIfA0R6BZH172HUY9Y1vUWql5os85ZJZhXuwm+7QLg0NqnHXSc2of2KbH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719210063; c=relaxed/simple;
	bh=GBpWOXMsKL3GYxAb3Orjzf76eSvZ0XMeiMBTBZX3MI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mucTIXWlqcUmoabGsa0BovgK/e6DZF+rA6V3mmnRR9QExDvgd4F4KoWkm0yIlbw5yg0U5pr4c7xpg9Lgf+cRgaaI6zK19XBFq1smgRYkak5BZmGE7lhcyJ9muYH2a5uuXADRvuRPjHzh5BPBgnHiAyPg0OY7upP6PLW3wYFdOFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=J+N1DK0J; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2024062406205364d4b81c55c7bf89d4
        for <linux-kernel@vger.kernel.org>;
        Mon, 24 Jun 2024 08:20:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=HX3rEphaegaz4eT+TeSVcevgXPEnRQToTXmTZCSA234=;
 b=J+N1DK0JJeqEzorZgZTlNZXwKsX3KOhLUSnOWtz2coIFg+5ZdfjB0uG9lsqAOqRyVAhW4r
 Y+VIs0B/2oxmhOlhIWaQvq4I8ERuIVQmU452Y2sKUCaGAwNyh9nLW31eH+nLyTn7AIaPa334
 TCVJ3p9Lb8kGFEEUl+lI2LfR1N+ak=;
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
Subject: [PATCH 4/4] arm64: dts: ti: k3-am65-main: add system controller compatible
Date: Mon, 24 Jun 2024 08:20:50 +0200
Message-ID: <919937773a001233b65fd1bac13370d410c43384.1719210050.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1719210050.git.jan.kiszka@siemens.com>
References: <cover.1719210050.git.jan.kiszka@siemens.com>
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
index 30c514e458a3..fe90e84c34fc 100644
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


