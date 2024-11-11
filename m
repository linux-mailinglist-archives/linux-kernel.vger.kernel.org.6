Return-Path: <linux-kernel+bounces-404383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FC49C430D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 682521F21A50
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB501A706F;
	Mon, 11 Nov 2024 16:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRucuyHk"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F911A303C;
	Mon, 11 Nov 2024 16:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731344169; cv=none; b=TDHxFeH8NTpHYntOk/JFdJ5zQq1S0zoyY9nnenrX/k8XkCXyHSew4cU1GsGd6el+/622an6/82oNYe2+g3gjGF9/hzxjqc9AJkJCMGFIWko38Wuu4Jh9WSCha+QrDeiVGgYesz1TSktDWRT554ZXRyGaofkDDTT26BZbpAOeBPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731344169; c=relaxed/simple;
	bh=BHuuImuZ9TK/Z6I6vu+VYwqEVvV0g6bfeFmkl8Tc8aI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MnvzCMe0z3ooiiMOFFeeezutk6NSbwVfbdf2Cq+EToZHvxY9ZnmZomGMQjax2UQrybklEo93uwwfmCVc/pJys11YSJddJQGkO5HD+d+qQATrr34j1HP1XYu+sSbA8TyjpdLULXGl5jDr3E5QgOalSi+cQG9kJWRENnogmURezis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRucuyHk; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539eb97f26aso4563175e87.2;
        Mon, 11 Nov 2024 08:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731344165; x=1731948965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cq2vv+vlrS+liCK+o2xaokofGSYSa1PC7UgkAUeyMv0=;
        b=bRucuyHknPaZ+LPyzU+jhJnIb/cKyjvOnYM5SfCSSaX6P/rwNDfBvVtamDy0eN1rpW
         F1eK7pfaJoqe84SS0p6q5pbL46bk7Dr7odQLakCr4qmo6eCVHbJv+FG9zYqUeAjQWFMv
         h3wUb1QSjnG08dDW6qdmlS35Mu+thjILzV6wPfORVKGrD9ShFhAddCbi8UH4zqWVRyjk
         vT+hkdeEmpWuNRuOADLAk7FzgmqjnZtIpRAPPsYJ8bMd7Z4hFAOVt+g0quWtkz2J1jqH
         7S7bnG1V7L1xANn98gpa+8eolpw60Cn3PaN3KnDO8QbGMawJBG+eC3abuUMWNE7I9XJj
         iVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731344165; x=1731948965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cq2vv+vlrS+liCK+o2xaokofGSYSa1PC7UgkAUeyMv0=;
        b=AAihy85E6KZcvuAm3uTv/m+pOoi9LXoETVYIA7yazgXpXG+Fn3fA+pU0fmSX7ZMrU6
         yA96j3OQJCGg9jx5974La7mf6wfn+TfkPpojgkF7vIYWwpHIpoL4xmFUsamuT4N4ax1U
         qvpkIyordlamwcLXM9+nqG6AiON7xPyHD/EJKf8vYGAiNwPaLhZDogTiDpRsRHzdMI/5
         oESJQtX9Zl9Q23OzyZa6QoBCjCDhEyL3c4iS6yO7CaRaOpwAbJUe1TwUB6VAbBaOG/hg
         fBXiSO899KrsgU82M73R8choL1qSXRnnhB3+WxyaEGKBGbM/hsGb4W+QF6MBPeSHVQKt
         W1fw==
X-Forwarded-Encrypted: i=1; AJvYcCUQrQeksn7+MmpShSy/qeAH7WB/EmkfK0e/gb8zV+1UXBjojzW4x7o2HUPJL/1zsk78NVBf6XX9OftFT9owQerh@vger.kernel.org, AJvYcCWR/7Rzqj2lryq8fTuDRhGBc1Pow0PfZAjrAF/vCuKFxxx+Z3mG77ek5URKY0+OmhUaA9mX+oQa5lEJuX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeJ81iMZua1eVKmJgoCpQRgzMenu6krc3hLLOB14ndOHGSwps9
	NFsO105E3OtfyxeIxEUT+n5CwFwNX8Wdh6H0A1dCeK65VMttG/yVCyXmL0U/
X-Google-Smtp-Source: AGHT+IGVrnZ4G5gv1axm1AEb+TVo9siTiIXy9Fiw2dPk9skT6S15TI18REvnsc1gh1yGg2BeuWdGgA==
X-Received: by 2002:a05:6512:3ca2:b0:53c:74dc:2252 with SMTP id 2adb3069b0e04-53d862793b6mr5909400e87.49.1731344165064;
        Mon, 11 Nov 2024 08:56:05 -0800 (PST)
Received: from localhost.localdomain (c90-142-33-119.bredband.tele2.se. [90.142.33.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826a7387sm1624737e87.140.2024.11.11.08.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 08:56:04 -0800 (PST)
From: codekipper@gmail.com
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@vger.kernel.org,
	linux-sunxi@googlegroups.com,
	linux-sunxi@lists.linux.dev,
	linux-sound@vger.kernel.org,
	lander@jagmn.com
Cc: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	andre.przywara@arm.com,
	wens@csie.org,
	u.kleine-koenig@baylibre.com,
	Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH 2/3] ASoC: sun4i-spdif: Always set the valid data to be the MSB
Date: Mon, 11 Nov 2024 17:55:30 +0100
Message-ID: <20241111165600.57219-3-codekipper@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241111165600.57219-1-codekipper@gmail.com>
References: <20241111165600.57219-1-codekipper@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marcus Cooper <codekipper@gmail.com>

This doesn't affect 16bit formats and allows us to properly run
24bit formats.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-spdif.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index 7cf623cbe9ed4..5a9407aaa1a19 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -202,6 +202,10 @@ static void sun4i_spdif_configure(struct sun4i_spdif_dev *host)
 	regmap_update_bits(host->regmap, SUN4I_SPDIF_FCTL,
 			   quirks->val_fctl_ftx, quirks->val_fctl_ftx);
 
+	/* Valid data at the MSB of TXFIFO Register */
+	regmap_update_bits(host->regmap, SUN4I_SPDIF_FCTL,
+			   SUN4I_SPDIF_FCTL_TXIM, 0);
+
 	/* clear TX counter */
 	regmap_write(host->regmap, SUN4I_SPDIF_TXCNT, 0);
 }
@@ -323,9 +327,6 @@ static int sun4i_spdif_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	regmap_update_bits(host->regmap, SUN4I_SPDIF_FCTL,
-			   SUN4I_SPDIF_FCTL_TXIM, SUN4I_SPDIF_FCTL_TXIM);
-
 	switch (rate) {
 	case 22050:
 	case 24000:
-- 
2.47.0


