Return-Path: <linux-kernel+bounces-263539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C71493D76C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 19:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E0A11C23330
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FEA2E3EE;
	Fri, 26 Jul 2024 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZbnuU8r"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339EA1CD13;
	Fri, 26 Jul 2024 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722014111; cv=none; b=gglAzPGi9nZ07xjfTGT8bYvwT6ASccYmdEglbrKMzcom5Y+rE6UXvKRcvauqu9jqGLnqj4qiT8rIwipOINbupYwWlwfyz49vmQiAOAIT6JcURCEI/tGXMoTTwCamjaXTFpcPVrUyPPRx1K998cKT/8ndgek0QmP2ygPGc1H61SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722014111; c=relaxed/simple;
	bh=nfFr/O+oUqU3+x5ATt7ksz/amJIYNaIo9hmANjiZ/Tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/fTggeFBJLitjdrkrRJbZcQeiwC40la6cAHVlDUUN0VKkSuNi2atilfYCDJLa2iWUOoDkvPUjO38hQQHvxtccdPwHlEDEnlMYQOqzPxRQE2aRjhTnfJxYl7O11G2i+LP9WYDSomDXCx275kCvpghI8vXLzk72xvBh8UGqaRO2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZbnuU8r; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-76cb5b6b3e4so852637a12.1;
        Fri, 26 Jul 2024 10:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722014108; x=1722618908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IC8niKQLK2S9klSSRUjzxiqGLLkZ5D69ejUAD25RXeQ=;
        b=fZbnuU8r6VFi5REEAeUPQSsjCpauq2z7cb6lEK7EUd8eFOvcA9P6aBdUNAPFjlSpiS
         rC9VqXWlw/jNi7tFJoivrly/9zPtb6ceusT+BTIiNXrfN73OR4LVey+gAqmBLoP9vlHX
         1r+cEM6Ct1cnPVTL1cn4sB0KxjCSSy7gnaH6aSP5JEwr/auESrjPCUOPnoduW3lQtzDl
         BB+38Yp2mtgN5S5yVVzWGLlaplr9V/P407pO4pJJsaprHmPhvZzkUQOsNaVkhqPc1qzg
         6el0M1PTmrmt1euJLUtgrkROB+lOJ0VYKHZTCY+Q1oapjqiyKg4QDl7pJwAyiPbR4tc9
         2b9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722014108; x=1722618908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IC8niKQLK2S9klSSRUjzxiqGLLkZ5D69ejUAD25RXeQ=;
        b=aUtN/U7AjIU5UfXuz33yWma+0dMVQXUZMFNMUrLj/JJJT50/EcjTIXCpgC+fuqClqs
         Xtb4cIiXercgTEiITmTbr6jpMubPUCpmV4M7BYgUiwTnmB2YkPeNFnE91MM9EBtyKZEN
         jV1oxgobXU41LhP89m+eTmy0d3W/cMKKEy8jtYOJYxUd5NbKOO6aZTJPR4fCe9pwG6Jw
         v9uh2P1Oi8v9sLVV8tThnPWtnjz46evWONgLFhoEaNDa+U6xycm3/ZhTJ8Rl/dF1Eyqd
         J3BtHR5ClUT8uewFItD7RR9nzAzfm/DdWe2HSNFqb/D/GgMrHMn1NO69FAPvwcAJK8lE
         2RtA==
X-Forwarded-Encrypted: i=1; AJvYcCXjVSca2g4GsjSmi+RwrZzYhoJL2XrFszWgX7b2tfK07aPAli4a6XE6vc2JL/PGFyhJf/XlCkj3PFHj4zIo0mKrZor/Go75F3YHFwK/HUNyYnIlxE6uaQZcCDo+g1g9dPBo9HrRz3A6zA==
X-Gm-Message-State: AOJu0YyHYpxifBIvF+PGmuodjRvcQpCGyrQv09flJaqeNASq0eOL2kRb
	MgwCOOZiNz0et3z+RRjA0YDZt8cQ1T9sB89uoqZnqLK9aMOexfHE
X-Google-Smtp-Source: AGHT+IGevshhNnR1uDre3Jqcy2R5OX/tUZ6EUret7quFk8oYW//qmIpavooBD8dW51AVNNhGGzkZMw==
X-Received: by 2002:a17:90a:66c9:b0:2c4:b0f0:8013 with SMTP id 98e67ed59e1d1-2cf7e1c06e4mr155614a91.11.1722014108250;
        Fri, 26 Jul 2024 10:15:08 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb73ededcsm5718855a91.31.2024.07.26.10.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 10:15:07 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Anand Moon <linux.amoon@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] arm64: dts: rockchip: Add missing pinctrl for PCIe30x1 node
Date: Fri, 26 Jul 2024 16:30:45 +0530
Message-ID: <20240726110050.3664-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240726110050.3664-1-linux.amoon@gmail.com>
References: <20240726110050.3664-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing pinctrl settings for PCIe 3.0 x1 clock request and wake
signals. Each component of PCIe communication have the following control
signals: PERST, WAKE, CLKREQ, and REFCLK. These signals work to generate
high-speed signals and communicate with other PCIe devices.
Used by root complex to endpoint depending on the power state.

PERST is referred to as a fundamental reset. PERST should be held low
until all the power rails in the system and the reference clock are stable.
A transition from low to high in this signal usually indicates the
beginning of link initialization.

WAKE signal is an active-low signal that is used to return the PCIe
interface to an active state when in a low-power state.

CLKREQ signal is also an active-low signal and is used to request the
reference clock.

Rename node from 'pcie2' to 'pcie30x1' to align with schematic
nomenclature.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v4: rebase on master, used RK_FUNC_GPIO GPIO function instead of PIN
number.
V3: New patch.
---
 .../arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index 1c7080cca11f..eeae14842b71 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -318,7 +318,7 @@ map2 {
 
 &pcie2x1l0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pcie2_0_rst>;
+	pinctrl-0 = <&pcie30x1_pins>;
 	reset-gpios = <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc3v3_pcie2x1l0>;
 	status = "okay";
@@ -364,16 +364,24 @@ hp_detect: hp-detect {
 	};
 
 	pcie2 {
-		pcie2_0_rst: pcie2-0-rst {
-			rockchip,pins = <4 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
+		pcie2_2_rst: pcie2-2-rst {
+			rockchip,pins = <3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
+	};
 
+	pcie30x1 {
 		pcie2_0_vcc3v3_en: pcie2-0-vcc-en {
 			rockchip,pins = <1 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 
-		pcie2_2_rst: pcie2-2-rst {
-			rockchip,pins = <3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
+		pcie30x1_pins: pcie30x1-pins {
+			rockchip,pins =
+				/* PCIE30x1_0_CLKREQn_M1_L */
+				<4 RK_PA3 RK_FUNC_GPIO &pcfg_pull_down>,
+				/* PCIE30x1_0_PERSTn_M1_L */
+				<4 RK_PA5 RK_FUNC_GPIO &pcfg_pull_down>,
+				/* PCIE30x1_0_WAKEn_M1_L */
+				<4 RK_PA4 RK_FUNC_GPIO &pcfg_pull_down>;
 		};
 	};
 
-- 
2.44.0


