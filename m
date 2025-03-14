Return-Path: <linux-kernel+bounces-561722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 098E1A6153E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 871B216BF5A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D913920126A;
	Fri, 14 Mar 2025 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdNQyKi7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4579120012B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741967301; cv=none; b=qAaAaAi3dijKGIjieW86L3F6oLs4EUOTOaY5uxu8rzxy2W0FBXfSVFsFy3388e+Ft699crxDFoCuy8qnQngG0IDMOCGthWMpGlMD03zMgMf5pPC8IKonF5w0IyNO/gykbcTFgp5jOxOXQliuebzZOQgxAIPtYmd2PswhcDd1qLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741967301; c=relaxed/simple;
	bh=NrnpqJSBujUE505Ln7Q/FdL0noE2hDJHuYcHRd1ZRts=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=odOSEWFDl0Ofg5PgJlO45bes6vgEaTVG35lWFy0IBIdtC2sHzFzCJMD9Rl/OaVS8logJ1Yv3Bfc5olz+KzzHggFizfSSn37Y2yE1ZH1ezYS8znp0oqN8EsyK9KhGxmLfPVEQGKCvyfuO3/+58oB3pxEI8vlm6wV/1Q9W55pf+Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdNQyKi7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38275C4CEE3;
	Fri, 14 Mar 2025 15:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741967301;
	bh=NrnpqJSBujUE505Ln7Q/FdL0noE2hDJHuYcHRd1ZRts=;
	h=From:To:Cc:Subject:Date:From;
	b=UdNQyKi7NTHVbbr1bW5KIZI8Mp7kcPvMTJa6w1s1/m93PDLf5RPlyTi2aFQqzvj+d
	 zePmhRpN2aL98RSfNOq8RLl7lmkRy7M15ZwxirG7aPpzEBBhCZRhpD7cpTRlR9fj1I
	 TasApsa/OV7y1/p0buGt4pumQG+hCdPCy1FKNwJBpGMSYF3PNsWC4p+JKVFqd65wfQ
	 GsDO45Cl1S7VNw9DK0rXpyfEj5EE1+YoCL+nUHM//9ltqIPPMZJrz7bY+1YPh0hMNk
	 WwPL9bGpUrbXTdgATpE4zZboMFt/vTXgGQuJFSXORFRDkZQndpFgsgvr7n6+2haRP8
	 qNW9MicepsHIQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Drew Fustini <drew@pdp7.com>,
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Guillaume La Roque <glaroque@baylibre.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Prasad Pandit <pjp@fedoraproject.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: thead: add CONFIG_MAILBOX dependency
Date: Fri, 14 Mar 2025 16:48:13 +0100
Message-Id: <20250314154816.4045334-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Without this, the driver fails to build:

ld: drivers/firmware/thead,th1520-aon.o: in function `th1520_aon_call_rpc':
thead,th1520-aon.c:(.text+0x28): undefined reference to `mbox_send_message'
ld: drivers/firmware/thead,th1520-aon.o: in function `th1520_aon_deinit':
thead,th1520-aon.c:(.text+0x17e): undefined reference to `mbox_free_channel'
ld: drivers/firmware/thead,th1520-aon.o: in function `th1520_aon_init':
thead,th1520-aon.c:(.text+0x1d9): undefined reference to `mbox_request_channel_byname'

Fixes: e4b3cbd840e5 ("firmware: thead: Add AON firmware protocol driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/firmware/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 42e3dd1c387a..6ab9f7ca7ff1 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -239,6 +239,7 @@ config SYSFB_SIMPLEFB
 config TH1520_AON_PROTOCOL
 	tristate "Always-On firmware protocol"
 	depends on ARCH_THEAD || COMPILE_TEST
+	depends on MAILBOX
 	help
 	  Power, clock, and resource management capabilities on the TH1520 SoC are
 	  managed by the E902 core. Firmware running on this core communicates with
-- 
2.39.5


