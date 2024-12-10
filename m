Return-Path: <linux-kernel+bounces-440036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C3E9EB7C4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 313111888242
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122AA232377;
	Tue, 10 Dec 2024 17:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="VqH3JmWO"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC1222FAE3
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 17:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850642; cv=none; b=M5PLojd8jSQKv1AA2VYChdmA5jgSEYOzCy1Gf0Fyn33h0G0BM7eSoGya8dln/1lGgdJwbdhaaWQuVj8+vZEWvnIOlgLKHpbIUiP3F/B2CsvRL13Hcojp2Am+pNxZsXq5NdHYCNLdA6rUfz6kVGHnTpA2RI7JPN9wt+gxe9n6ALk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850642; c=relaxed/simple;
	bh=cB+Bpu7l1dV+zM88HO7Ze3t/5fdXwi7jPTuxAvUk+U8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HXKbjlBHTVxjSlovWYk9mM75iokNUTDlQs2nqUkR/R9hgUA1nl9mjyxvb6c8SHkgteWqzHSnZMTUR/QTmj3oAzT+KQLkFqYXaAw4zw/7P/JDoJIkXmADA9CE5vm653vsjW+pQfHKZoGaEO9tfddSIgh3VUrLjsrWdnhmKstv+iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=VqH3JmWO; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d122cf8dd1so9452088a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733850638; x=1734455438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6Hy/pRodMw2d91URONzNaEgR8YWtQs7fLTqCwO7+FQ=;
        b=VqH3JmWO8a/dlBZKwdVROvo/+MKWvN5DXmrbLUo5A39E3UaP444kOfHcntyoanVGjg
         5vyCowgmh/B2NTIEPfRrqdv0rMnEf53eif3FLFzpyLecp4R3kKQg69iHg1sFQCWSBeqM
         HJ8Ui6I6oZMTPq6JmgABmhUfAZP7iJddfzI+mHWvTGonyc819SJ4HtBssjejTKjz7c2z
         m4puIilvI35SmSnQDwsF/8cyKd+rs81QLiYLKWa7XfKVGFrSQW6YweovrzD/7hrFpmNv
         zGHqHUvL/jxvurpIGALUpBWfFaERvJ0HBkM9GM/FX8ruLg8wCe3SfYiquALvGyB7mhqC
         5f1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733850638; x=1734455438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6Hy/pRodMw2d91URONzNaEgR8YWtQs7fLTqCwO7+FQ=;
        b=phj0X8ZaOKZEbCwMrqts+0mQ8QZ7iGdZBjn9V6qhJyrlHivqYvXBx/JrCSdO5SQ9y5
         kxC6jeK6meRiLyPAkNTXFo1tkhJ/2VROOX5yzk5nyMwwKLZO5DAvhx/RWX1JeFJxEUS6
         ln6ku431GbDOLz+wUH3x5yp2RWzl3Gr16UXkNml47bDEfcu81O4m9G61Gd1q3t68jQqH
         hN9v2FvbnFgjQygwxV6eTSxIhHI7rAS0p9sYpnbP4fPEMqK2O+Ij9jsHT96rerP1hBJr
         GHljOF7btqsffTMYxAlZwupp39yVbY08S9OiG7qEiy3LyeWxT7xV3+vz+x57tC+b9fy2
         LkyQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8sLABCsjLgnWUzeBZ3fPyjnEbr5zHj43z9lcFgUQ/461OsS0SLn3Xqm13xRw+rmQ0qm7f6vOnDf7PQms=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzriyihgYptvcC6QdLdpwSrCYhsoYdbTS0Fku3EFIABwnR/L6q
	Au5RKR06V+03J4D59Ubl+ta3I4iOIGgqaBeMQEJhrCQV/TZHK9rRqF56RN6xAuQ=
X-Gm-Gg: ASbGncuWEpY0bIvy6W4GCUgbfR1wZVe6rjYgC/KiaQDQForeZP6ymZ/wZ9k6D0y7aSG
	/W8rjVX4Ee3xiFi6IbKf9jxbE25hdVblSXu6blHoaz6uQSWY8UAwQ8GF+Ik5DkAYA+Snwz0s7aG
	6bqQCbWBSyL7XpcjuWR3KpTNxf21vZvkr/T0zdFhnEjcInxx4rdt24ikVN1L2RWIxVFw/umcQpy
	diFBIHha6Vkqo5BPHKqsVOsgPSmMUZtKzcIY12NqTzh+zPfOqL1kDTzqAJlz0iTgT1M9LVuQ9V0
	+aybb2dGiR0=
X-Google-Smtp-Source: AGHT+IGqcJ6bqhwIIKJrt+yeOZgP79f+Ka5SbVUv4mcFJwjMu+9gX00sz7DE8koWILZTW546alVDvg==
X-Received: by 2002:a05:6402:1f10:b0:5d0:b4ea:9743 with SMTP id 4fb4d7f45d1cf-5d3be67e142mr17354125a12.8.1733850638421;
        Tue, 10 Dec 2024 09:10:38 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3e7936581sm4853124a12.56.2024.12.10.09.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 09:10:37 -0800 (PST)
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
Subject: [PATCH v4 14/24] ASoC: renesas: rz-ssi: Enable runtime PM autosuspend support
Date: Tue, 10 Dec 2024 19:09:43 +0200
Message-Id: <20241210170953.2936724-15-claudiu.beznea.uj@bp.renesas.com>
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

Enable runtime PM autosuspend support. The chosen autosuspend delay is
zero for immediate autosuspend. In case there are users that need a
different autosuspend delay, it can be adjusted through sysfs.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- collected tags

Changes in v3:
- s/sh/renesas in patch title

Changes in v2:
- none

 sound/soc/renesas/rz-ssi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/renesas/rz-ssi.c b/sound/soc/renesas/rz-ssi.c
index 878158344f88..eebf2d647ef2 100644
--- a/sound/soc/renesas/rz-ssi.c
+++ b/sound/soc/renesas/rz-ssi.c
@@ -1140,6 +1140,9 @@ static int rz_ssi_probe(struct platform_device *pdev)
 	}
 
 	reset_control_deassert(ssi->rstc);
+	/* Default 0 for power saving. Can be overridden via sysfs. */
+	pm_runtime_set_autosuspend_delay(dev, 0);
+	pm_runtime_use_autosuspend(dev);
 	ret = devm_pm_runtime_enable(dev);
 	if (ret < 0) {
 		dev_err(dev, "Failed to enable runtime PM!\n");
-- 
2.39.2


