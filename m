Return-Path: <linux-kernel+bounces-300461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA9E95E3EE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 16:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93C141C20C6D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 14:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B55C13A89A;
	Sun, 25 Aug 2024 14:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ihYMXAN8"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5E71E4AD
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724596474; cv=none; b=YEERcuS87BXLKbQYoUASq28GSVT1MvqmH9DSOxqPJSaPpc3v5dq+Y01QFoCr0MHbgTcyTJmTxVX6ePU9MCjiZ3zrNM7O1W1eV+LM066W+n9VrBf/KLk8YaL+v08cK6ra9ODZuLBO1YcPYgLBFrQaeyCm9rhCNC+tU7gWdzJyJrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724596474; c=relaxed/simple;
	bh=Y4w5OHB5AAqQgw5YqBA+ey3TPocL/Uh/eEew5lcaGaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OVOa5XKiTnm5AZiJqngnd9Nq7lCI2vIBn6WsD7ib1T8LXfx/46EXPgJgnrhSUnrjbuNtvQCUYYN8GD0L09y5o1fPj2YnwbjAaI6RdydFpqSBMkqnInMic5vB4B8K1Uq7UjFtb5Xj79px7Om+U6A1pyjYU76nkceIPaR1mbFSxys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=ihYMXAN8; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a868b739cd9so421908566b.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 07:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1724596471; x=1725201271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KJCtcmIB3UdIrkYLcVzOIpEPiO2wmd+dCBPvqHnV2K4=;
        b=ihYMXAN8P/oS5Omlvw7LKf0EmeqiN5gVWUxQdm+Jxifh6b6NTAQRmyHvDlNO0yRgcO
         9d3xw3M89fMfcuDN1N/OPqUddkRNOcbCqjZ7JHOsjx4gJqNeIuoQJrBREYV8Ew3dXp0o
         44G+q4E6m6UVpVRXoBUoSpyapGYYdBzn1gAAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724596471; x=1725201271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KJCtcmIB3UdIrkYLcVzOIpEPiO2wmd+dCBPvqHnV2K4=;
        b=RaPKbd/ZyEvxtRR2z9rIDyjHApj8AGBLOeL5v16xDoERYs/8IV/sDtdQff6Lm3DzGV
         Lv7UxAF6VwIK6u70uN2pEAjzSI3Z6ueTACLnBRjJYArbz6QzOnBX2JsCPTxa69i+udrR
         zxllBNByot54mG7CN95xI82+SdUpL32NjvFzY5zKbxfkiBfCjdsvSPDZdIl9V1Z8wJii
         otm1JwxqunBfPwXUQTpPbf4Z1cRlEUjbp7WmpkBxhImSsHUOJXZbQcge2XgSyrAByPNl
         Fe6EPCraYoOqj5kQNK5Iq9Tg9XT/cZK15K5NbHrXOG6R9euhPcrWsXkFHZykrqndRvi2
         Ferg==
X-Gm-Message-State: AOJu0YxibXTEtZgs4CdcBVDZfUakekzFVLE3U7xKyQdg1atEoahmGO0u
	6NRSQ+XiIGHVw9JCe+oYYU81o7Px/4L6J//fHbmSUSiN9k1VbqaZIyvM6EQ02UngNpVksBBYNWS
	ajGQ=
X-Google-Smtp-Source: AGHT+IFrPkCDWSQxHr3mcynt8lDSRSWlq9K1FdNFRP5DdDzP7xtG+zdnJc3gqlxqDwJcYjVr7uYgTg==
X-Received: by 2002:a17:907:7f12:b0:a86:8524:2558 with SMTP id a640c23a62f3a-a86a518a3a6mr468976166b.12.1724596471075;
        Sun, 25 Aug 2024 07:34:31 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-25-99-149.retail.telecomitalia.it. [79.25.99.149])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4862b6sm550625566b.170.2024.08.25.07.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 07:34:30 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Fabio Estevam <festevam@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Peng Fan <peng.fan@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 1/3] pmdomain: imx93-pd: replace dev_err() with dev_err_probe()
Date: Sun, 25 Aug 2024 16:34:00 +0200
Message-ID: <20240825143428.556439-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This way, the code becomes more compact, and dev_err_probe() is used in
every error path of the probe() function.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Drop the extra { } to be even more compact.

 drivers/pmdomain/imx/imx93-pd.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pmdomain/imx/imx93-pd.c b/drivers/pmdomain/imx/imx93-pd.c
index d750a7dc58d2..44daecbe5cc3 100644
--- a/drivers/pmdomain/imx/imx93-pd.c
+++ b/drivers/pmdomain/imx/imx93-pd.c
@@ -125,11 +125,10 @@ static int imx93_pd_probe(struct platform_device *pdev)
 	/* Just to sync the status of hardware */
 	if (!domain->init_off) {
 		ret = clk_bulk_prepare_enable(domain->num_clks, domain->clks);
-		if (ret) {
-			dev_err(domain->dev, "failed to enable clocks for domain: %s\n",
-				domain->genpd.name);
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(domain->dev, ret,
+					     "failed to enable clocks for domain: %s\n",
+					     domain->genpd.name);
 	}
 
 	ret = pm_genpd_init(&domain->genpd, NULL, domain->init_off);
-- 
2.43.0


