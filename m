Return-Path: <linux-kernel+bounces-440031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BB49EB7AF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FB282837DB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC76B21423F;
	Tue, 10 Dec 2024 17:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="BY4gWM0a"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B77B3DABE2
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850634; cv=none; b=NEN1udaUN41aynjJfp/S7vj82QEf0XQsNtNSIEM8tWcQ+XfZtK//855AJheAe/+u9R9p8J3Hx+jAeIvbTn6wUrnE/RFNRQAjVFZcSgqPGLhO9kSpo8Uj2Lo6pIT6PgtyyFuZY8yes9LhALPbSuFThAGNfN4sDKzP+F+oKVY+Qgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850634; c=relaxed/simple;
	bh=cnajpc59mzRLWDYn+TlQEWJ18Tzqm1CRjbROQ6JPtZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a6bg0VWBKlAHkqaL9Z/ivfCGgvkFOiUC1l7QXX3ydSg1vgEWQ0UNn9BNE6Q6WB57S9B3GsE1nM+uZj8VIVFwEzW3LYQdEQJJ5H8hjXKRBp76cZKGEKxGCcSjwJvP7hL09IphfdYCwBnbPJLMdTPe0x6cPdCG0XqfMhBlFa2XSJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=BY4gWM0a; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d0d32cd31aso6838985a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733850628; x=1734455428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3F8PzVf1JVHBMdfZjuuSPBsoTNCHuDc7mT2swoePkeA=;
        b=BY4gWM0aRKGmRPNfU/t17wSV6WCBMCbALqJIZ4xdnA62ORaysTgl0Mq1WJUkC/jvOe
         EtqPV8SeIsWUpXEHMdIo1c8ASje479H3/71wwqGhO3lmhIjeJ7y9U2kCThtRAxUGo+Y5
         9pl2SuPLNEF42r//twOOg5LRgNgar9DFo2waWQUjstF0PZZ8ZGD5IEaQga6RYBzS8aI4
         TuRFpVgkOT4HlZLzfo0mAsTMy5HkDY+bgcScK9oLG2PgCRL0EZphfkwVUSSU+n/Janrv
         ygBdWpp2fy6pVySIZmTqxnk1/CtHuq3Cc7tAAXkiQ9QZ28GURU+2nZltLA2fgy3btaMr
         0umw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733850628; x=1734455428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3F8PzVf1JVHBMdfZjuuSPBsoTNCHuDc7mT2swoePkeA=;
        b=KuDHYDFumU0G6hqh9M2kjA9VlFhf5s/vmsHGv7sA/c0wfrWW2//bzaOgiQJpXJ+dKo
         cbGnOLNHb5BA64CtDDIIq14ZNR7urgshasYvOocj0b+adMar7wzEXOgjZ9+XY0xPvHbd
         KiwGnCdGQvH4D+yzIS/joen8dxzLqPKZQ3sk4gsAStEm/QdcvGbDKK5hbvY+dYppZUJb
         iqjpux4zAD6gQ66iA6YZDLNUut+rMnCoIb5hlBxFy1Haq896E15FVO6iFW+pvYlCBKiO
         uvLMv9fzWA1E/n0f2euEr/O8v6tGDjAso+vPg4l6B0910NK6LBIG3KFyp0LRxlWx1NEu
         j+Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVzfHz40CUq9E6AMfIxxpBktFUm3UUAj6jZAfhEKFX3UP3JpzEX18ljK9XvmmYf35n/aPQKgQEAwao9kaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFMpc/s0VWodZB01HRN7A3sH84LlAFin/mr0rZY8LoQTfVX24D
	6c0ewm1buKUbgNoaV57mKbBpOSIjuYekEl6ZKbe6ntrvTfNgcfbIfIoMMOF56CE=
X-Gm-Gg: ASbGncuo/2NRrH9UHeNo28OUO7vHZp46Zihe+pZJM2Tn7HJZtxH6FpeeXuI4fXmtqW4
	oflZTymtkpqY3AbcQWQtHJgHBTTLUlwO99TQ0FDTAjKfnXPs1G/Mo4CXPejd7bfVcEMvwFCHzHQ
	jskgZzSf1wurguRaIMcma3FHQ2nTSg8UkTZotXy8Fc6Dd5DbDr9SEbkHn4Q49lLElb9Mt1rNwd5
	fIrgBdE0pG6kqMdYJNSnCgEvcBoqfhXsFNjQFxZMmUoGwVqQPjvFQJEFXa/pbi0saq0kWECnH8R
	cp42pJfc
X-Google-Smtp-Source: AGHT+IF6mILseNMfJmIB9ZOyimXPXPfxpdkmjbt3WuqKLQbtoG5tgiV9L7CF+aAEAjMF8dRgPTsU9A==
X-Received: by 2002:a05:6402:42c6:b0:5d0:ea4f:972f with SMTP id 4fb4d7f45d1cf-5d4185060b8mr11381588a12.8.1733850628448;
        Tue, 10 Dec 2024 09:10:28 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3e7936581sm4853124a12.56.2024.12.10.09.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 09:10:27 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh+dt@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	magnus.damm@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	p.zabel@pengutronix.de,
	biju.das.jz@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v4 10/24] ASoC: renesas: rz-ssi: Use readl_poll_timeout_atomic()
Date: Tue, 10 Dec 2024 19:09:39 +0200
Message-Id: <20241210170953.2936724-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241210170953.2936724-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241210170953.2936724-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Use readl_poll_timeout_atomic() instead of hardcoding something similar.
While at it replace dev_info() with dev_warn_ratelimited() as the
rz_ssi_set_idle() can also be called from IRQ context and if the SSI
idle is not properly set this is at least a warning for user.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- collected tags

Changes in v3:
- s/sh/renesas in patch title

Changes in v2:
- none

 sound/soc/renesas/rz-ssi.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/sound/soc/renesas/rz-ssi.c b/sound/soc/renesas/rz-ssi.c
index 1a98f6b3e6a7..03d409d3070c 100644
--- a/sound/soc/renesas/rz-ssi.c
+++ b/sound/soc/renesas/rz-ssi.c
@@ -9,6 +9,7 @@
 #include <linux/clk.h>
 #include <linux/dmaengine.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
@@ -307,7 +308,8 @@ static int rz_ssi_clk_setup(struct rz_ssi_priv *ssi, unsigned int rate,
 
 static void rz_ssi_set_idle(struct rz_ssi_priv *ssi)
 {
-	int timeout;
+	u32 tmp;
+	int ret;
 
 	/* Disable irqs */
 	rz_ssi_reg_mask_setl(ssi, SSICR, SSICR_TUIEN | SSICR_TOIEN |
@@ -320,15 +322,9 @@ static void rz_ssi_set_idle(struct rz_ssi_priv *ssi)
 			      SSISR_RUIRQ), 0);
 
 	/* Wait for idle */
-	timeout = 100;
-	while (--timeout) {
-		if (rz_ssi_reg_readl(ssi, SSISR) & SSISR_IIRQ)
-			break;
-		udelay(1);
-	}
-
-	if (!timeout)
-		dev_info(ssi->dev, "timeout waiting for SSI idle\n");
+	ret = readl_poll_timeout_atomic(ssi->base + SSISR, tmp, (tmp & SSISR_IIRQ), 1, 100);
+	if (ret)
+		dev_warn_ratelimited(ssi->dev, "timeout waiting for SSI idle\n");
 
 	/* Hold FIFOs in reset */
 	rz_ssi_reg_mask_setl(ssi, SSIFCR, 0, SSIFCR_FIFO_RST);
-- 
2.39.2


