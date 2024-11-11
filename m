Return-Path: <linux-kernel+bounces-403864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0512B9C3BF7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 376471C2177A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C627C189F5E;
	Mon, 11 Nov 2024 10:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cr+3CDdQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2973E1850AF;
	Mon, 11 Nov 2024 10:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731320979; cv=none; b=aMZDAfpqlZ4Qj6AhJ7+CZ3L6kyCrzoFoLF0JJB74xiNkOkrsOFZ7FJJC4D+ta6ZWq1DalrSQ/RWjqivLJdLUzI8uH33TJ/j2pHsDlpX6mhgTEEj2PosDV17HHl9Tqlu+p9CU5q3Mh9iUH3sFAy3y98EfreQ9lCkPEivccCGsD9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731320979; c=relaxed/simple;
	bh=uIZqmnuRJS8ekHv7lZsq7+XDiS0vhUubfUCwr80FMvs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=StV6SaPp16ePDk1JGDAnQmmfJuEyFeFAJuEDtiwKkGS8eStVUrLzLiJ/cOQ8whXqq0G37WsSlJRtBroqd9G5N86Ok68kNdmm9a0KN9k2z/AHB3UrR2Vt42f8G9D+e6MIAj2A7kLBq245oEi6oXuIWUfyxEURaYW2PpRU3M0+39A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cr+3CDdQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47B6C4CECF;
	Mon, 11 Nov 2024 10:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731320978;
	bh=uIZqmnuRJS8ekHv7lZsq7+XDiS0vhUubfUCwr80FMvs=;
	h=From:To:Cc:Subject:Date:From;
	b=Cr+3CDdQv65miQSVhu73OzxU7prbdWiB+XY946y6RQnMjnOJ1OLbUHIaruK/paf3+
	 q98U5nppe0SlsmjqxQkSki0TzfPSMh2UNKl3wl4uBNY27XyeqIPsS7t0yzMxPcPIMp
	 ikWcV5f06UsXxinaJRfgyFmKjpwJt2TZ5mQ4msOR/EUfkQUoLisXvXfgcFEnHXdTdn
	 GPF9Oc3K/Ao+FYHBCXIbN4ptWMaW4+qXS1diuhVKM9HeNh2h5h1qjqMGMJj4iFb7Ky
	 Z+aS3MQKDbCIAgfDi+zjsi+rToZ4OGJf/TzTmO9RllH4mmkGCMg8lnQynn++RFsSMk
	 9yzOG8HxwMUdw==
From: Arnd Bergmann <arnd@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Chuan Liu <chuan.liu@amlogic.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] clk: amlogic: axg-audio: fix Kconfig dependency on RESET_MESON_AUX
Date: Mon, 11 Nov 2024 11:29:21 +0100
Message-Id: <20241111102932.3209861-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

As in most cases, using 'imply' is wrong here and does not prevent
build failures since that code may not be visible to a built-in
clk driver:

axg-audio.c:(.text+0x15c): undefined reference to `devm_meson_rst_aux_register'

Replace the incorrt 'imply' with the necessary 'depends on'.

Fixes: 664988eb47dd ("clk: amlogic: axg-audio: use the auxiliary reset driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clk/meson/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index 7cb21fc223b0..febb5d7348ff 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -106,7 +106,7 @@ config COMMON_CLK_AXG_AUDIO
 	select COMMON_CLK_MESON_SCLK_DIV
 	select COMMON_CLK_MESON_CLKC_UTILS
 	select REGMAP_MMIO
-	imply RESET_MESON_AUX
+	depends on RESET_MESON_AUX
 	help
 	  Support for the audio clock controller on AmLogic A113D devices,
 	  aka axg, Say Y if you want audio subsystem to work.
-- 
2.39.5


