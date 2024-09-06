Return-Path: <linux-kernel+bounces-318436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BBD96EDDA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 728DD1C23649
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46819158DA3;
	Fri,  6 Sep 2024 08:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="goaq85ud"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216F015853A;
	Fri,  6 Sep 2024 08:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725611123; cv=none; b=tQt3v5a9s4319mw2QFmb8LZ5PQ7jAXE3Jb04oxDEjhFyINSCSBSkDI1aSR/YhNw55ASur3dcPyE72veuZ3hOPVP7MeweE539xN8FccIShZVDSHOcylUQhg2Xm+uOhhl648fJRxoLrySeoS0lDJNS5to5mtFnTLf+onq9qDyMdVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725611123; c=relaxed/simple;
	bh=CApMsTqccAwD+CzsW7wWwohVHNh5WbVaiWrgACe4r3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HfthscuM0XhBUz3PUXJ/0/iSW0cui8GXQX0/Ax4uZVrxd2ehyemHHhcIu0lRhx6aOGMwK/QaaVyHiCQtmpsrV4XSWdQkYd4QJSKKIv4fzWdNaMUYJh514rJZ/jhRTm8Llfy+543szFUuQaziIXvkq5g9/OCLNRFn0yVbXgZEeyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=goaq85ud; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yGq3JneIJdLWkKicCiB7nkPv7xgVLix/YDHDBEAt+dY=; b=goaq85udzdVSmxwu1bYO4dwi7M
	BEQz2255HQOnPEC6AVicypFep6WFSmVM2QuKV2pqGeLFgEOmAbGbuiXNKtF4/X/CQQhkbH9Is6bSL
	NCueNsAzH6MgkMooQA8CjMcWv7e45PrXYcELVKNqUPJv7HxelhtBZA4V/mH809jBq+RaaCXxZugaw
	sVLS0JSsJnA6BEF7y3jjGEvLq4XAYSh9cQSeYUMwQoFSBpR3dn2DDk7WSXGONeyXrL9qKM31SC0Cs
	BbpMmAvP6uQAUTAuLWxg4fPOHSogR33uZaF8MKpTkCopwz2WQFvz8BOXYWD5TnUP0alxE9VG9kORP
	gxx9cU2A==;
Received: from i5e860d0f.versanet.de ([94.134.13.15] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1smUHP-0000jF-A0; Fri, 06 Sep 2024 10:25:19 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: mturquette@baylibre.com,
	sboyd@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-clk@vger.kernel.org,
	heiko@sntech.de,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v4 2/5] clk: clk-gpio: update documentation for gpio-gate clock
Date: Fri,  6 Sep 2024 10:25:08 +0200
Message-ID: <20240906082511.2963890-3-heiko@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240906082511.2963890-1-heiko@sntech.de>
References: <20240906082511.2963890-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The main documentation block seems to be from a time before the driver
handled sleeping and non-sleeping gpios and with that change it seems
updating the doc was overlooked. So do that now.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/clk-gpio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
index 5b114043771d..98415782f9a2 100644
--- a/drivers/clk/clk-gpio.c
+++ b/drivers/clk/clk-gpio.c
@@ -22,8 +22,9 @@
  * DOC: basic gpio gated clock which can be enabled and disabled
  *      with gpio output
  * Traits of this clock:
- * prepare - clk_(un)prepare only ensures parent is (un)prepared
- * enable - clk_enable and clk_disable are functional & control gpio
+ * prepare - clk_(un)prepare are functional and control a gpio that can sleep
+ * enable - clk_enable and clk_disable are functional & control
+ *          non-sleeping gpio
  * rate - inherits rate from parent.  No clk_set_rate support
  * parent - fixed parent.  No clk_set_parent support
  */
-- 
2.43.0


