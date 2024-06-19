Return-Path: <linux-kernel+bounces-220997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C450790EA80
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6077B285E7F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB48143734;
	Wed, 19 Jun 2024 12:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="UBEEQmtD"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233741422C8
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718798991; cv=none; b=e13bcbafwQsvB1WQTp0Ud8w6PmCzJUHPuNzpEF+kY89eRg/olaf/fLL5Cm6adQwC5/d2wxHsooLsfwNM8EawA5vymkdFwgb4y6CcOpCIPeYclupckCfqYVgfkDQgkHiNrNeS4SH0MsD4ZzEjITrxx8R3/66OdClst5rn3rBlw+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718798991; c=relaxed/simple;
	bh=AWXmdY3rXYMSjyADn2ws2KVH0wuevnkDpCzm8/QmWWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qy2WV17QwNR1JaK1n/XGpH71I3kRQ5yrawqKv5ntyRTeQGuwTFFk6M9ee9BBuFkQ4DBaS/o8/EL13WXFWZLEQqd4IRBlqkNwDFUw1YbYo+I/ovv0Yy4wQxBLyUHpg4DThPPp5WRPJQOQlHiy6rj5B1YjVTlYWx0mu7++P/Ggvww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=UBEEQmtD; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57d1679ee6eso431749a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 05:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1718798988; x=1719403788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54/0ynllrtFkceQQjV8JTld4EwzpadxoNpmSQm229aE=;
        b=UBEEQmtDJEz3H4kkEHWMgnYqOJy1Y0hwFKSkHHuGnszABnC2KXCl2yKRBtYNgakOx8
         IRCEV0ROopn28PL3LMEn9kST+OTL8SY3rV1PoYPMPIWycOR35AOFgwMyJr3+WmlwPUtp
         doHR5W+6Ept3wPCFYDwdUNEFMwQQYNs+Os/t0ZRq/Bqp2zRnlE0ovlEjsYVCur3jZrBE
         eILtbrX97ZNHByVoCU+VOPU6g6tDYqqWvbtH0OH0sGFqVwP8LECl/Tkw2QehKviLxAPn
         AkC1SgCeBz0/aOSe8HO8n/SwpSOBcPeft2puJb/FJowjGux4fp//PbGgU8QyoNvQmmCD
         j8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718798988; x=1719403788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54/0ynllrtFkceQQjV8JTld4EwzpadxoNpmSQm229aE=;
        b=r08UYj3pp2Tj9JR52sfiqcKRTi1w04MH3zq1jEb7FaaeO99X3ctkQnEo9jN5X3FMxm
         SDQKKtULo1Ns8ShUjJTxP3qDnH+fRMiN29hyu5qzp9vEkvA6zPuMNlyhf+ldb6lqTCGB
         zOm+SGrwcJP8wgRV4GfXZU3CSJAq4QieqTYeeyB7QxeV7AhZG/WvcewM6Uy4oIL5S6wF
         PXy7vnsqXAQD58rgYCwBsDQKq6+i/Hx3O5GRAJgVW4DEdWUzUsA28gjwCoOQP2TBnwFP
         bHP3Kn4Tf6kcXspJ0qdD3Tg2gxMH93pDicF7TjVyoFIdwf1oZgh0XBfkWAUmLabFyvJp
         SAJg==
X-Forwarded-Encrypted: i=1; AJvYcCUxAxnMLay5flfvmy/3aXHpwCaVSNQb0pks6zEjdOMd301uRGbVlKPr+B4QCQ4rwLzAfcJ3pKWhEyHd0XwTH5kSv8jSKjueNTMRaBXO
X-Gm-Message-State: AOJu0YxbVm5WDdAqfAknsS8dAXzbVorDHWjBemnBWEDL4Yh4aS0M7GOF
	k8ZrcoeyNAvMydfktqU7pf/cR7J0TwA40UbGpilXoHOAU7svTaLTMluTmnxkFXU=
X-Google-Smtp-Source: AGHT+IHJOKe6kBXUNHgR9qDl5dDG/jclLXow93dX2013HdXfIPrJid9GCPxLPrnwMA4R1Tfsu5wZ4Q==
X-Received: by 2002:a17:906:bf45:b0:a6f:77bb:1703 with SMTP id a640c23a62f3a-a6fa4109c43mr154657966b.13.1718798988338;
        Wed, 19 Jun 2024 05:09:48 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56da43fbsm659014066b.39.2024.06.19.05.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 05:09:47 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: ulf.hansson@linaro.org,
	wim@linux-watchdog.org,
	linux@roeck-us.net,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	geert+renesas@glider.be,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH RFC 3/3] watchdog: rzg2l_wdt: Power on the PM domain in rzg2l_wdt_restart()
Date: Wed, 19 Jun 2024 15:09:20 +0300
Message-Id: <20240619120920.2703605-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240619120920.2703605-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240619120920.2703605-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The rzg2l_wdt_restart() is called in atomic context. Calling
pm_runtime_{get_sync, resume_and_get}() or any other runtime PM resume
APIs is not an option as it may lead to issues as described in commit
e4cf89596c1f ("watchdog: rzg2l_wdt: Fix 'BUG: Invalid wait context'")
that removed the pm_runtime_get_sync() and enabled directly the clocks.

Starting with RZ/G3S the watchdog could be part of its own
software-controlled power domain. In case the watchdog is not used the
power domain is off and accessing watchdog registers leads to aborts.

To solve this, the patch powers on the power domain using
dev_pm_genpd_resume_restart_dev() API after enabling its clock. This is
not sleeping or taking any other locks as the watchdog power domain is not
registered with GENPD_FLAG_IRQ_SAFE flags.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/watchdog/rzg2l_wdt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
index 6e3d7512f38c..bbdbbaa7b82b 100644
--- a/drivers/watchdog/rzg2l_wdt.c
+++ b/drivers/watchdog/rzg2l_wdt.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/units.h>
@@ -169,6 +170,17 @@ static int rzg2l_wdt_restart(struct watchdog_device *wdev,
 	clk_enable(priv->pclk);
 	clk_enable(priv->osc_clk);
 
+	/*
+	 * The device may be part of a power domain that is currently
+	 * powered off. We need to power it on before accessing registers.
+	 * We don't undo the dev_pm_genpd_resume_restart_dev() as the device
+	 * need to be on for the reboot to happen. Also, as we are in atomic
+	 * context here, there is no need to increment PM runtime usage counter
+	 * (to make sure pm_runtime_active() doesn't return wrong code).
+	 */
+	if (!pm_runtime_active(wdev->parent))
+		dev_pm_genpd_resume_restart_dev(wdev->parent);
+
 	if (priv->devtype == WDT_RZG2L) {
 		ret = reset_control_deassert(priv->rstc);
 		if (ret)
-- 
2.39.2


