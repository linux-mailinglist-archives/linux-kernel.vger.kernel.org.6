Return-Path: <linux-kernel+bounces-440019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 092909EB807
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C35E18865E1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EFD2397AF;
	Tue, 10 Dec 2024 17:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="L2bV9tXv"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126B6239780
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 17:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850620; cv=none; b=fI23dF3WNV02oQATP+xgNeZUEOUbw5/IXBXRlrHNc24qtz3n0tH+fdqUOudI3hdY8YQ03RbuxElKMsUyT8VCP+px9dOxh0JThMh/slTgdhsN0TXPIhBKTeOKLa20dAGfXVT9ViOYMtLZyahtOfGSConqfgueVNVJ9LXzNYqdfZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850620; c=relaxed/simple;
	bh=cYpvDeE6GTSqLQn4hyIC1LguXTCN6MR9BcYpMn3wlfA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fPlOsglng0N069lEpRFIj0mDMk3j4oob4Va95ES0qarfTDjKCSihHUBN0dphVYOMEuBCvx09Rd1rd/KIxW909aBEsfGyi/kiSqLGhr/KMd4MImPna9FsPwhwRrFT7ezTquYhuwuHj0yZyNC9UJ94AUic3jW7ZJWrGqfSlmwBJyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=L2bV9tXv; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d3f57582a2so4458849a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733850616; x=1734455416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRP6aXMQvXzM2V4VFmQeuWDqqgGNHEkIoJ0Wes8B7Jk=;
        b=L2bV9tXva4tdVQ/BevOqjIS9pdswIp8ld+5SLzEWysDscaLRaAJvjzGR5tDJiw1luy
         WMJounXTaSWsOcIJ5K2zcFMft8+FvV3SA2EBuI5eJaIW5XGT9OcigFvWXAnjGbw4Xm9v
         P84S9ue930Edv3/RJy5H+9c8BbyovRWJaF466n/rDo1qAQfaIIBdf5+8zSalq27ZfU4P
         /6SJfOA6fzbJpKjB6avY0NMM7+R9tCSdT7vWTHySTELllvYrRgKLRKSKNGjDzbei7dA8
         mEMFSIXv/hTjmCTxNXx5PYGHN5uOwWgLelIAOgEyEAJGN7BXIQ6rgjY3Vcd2HX+tR+ju
         4+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733850616; x=1734455416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRP6aXMQvXzM2V4VFmQeuWDqqgGNHEkIoJ0Wes8B7Jk=;
        b=rf/voM0DOFZLRL0nAbyISJFA5ZN/fr8YNOdix00PtMWiHlVRFTNXblG5m6sT474HGJ
         W+5dj7UPXYulTWhOXtUcav0DQxvmrt6xLSBP+dk00DUDfeyJ099QU/1cvsEc+kRVs7sM
         3ZmmJ7rC4sZVZjaTAkaK0DTCdXUNs6ppaFznZE2cbmH8i9JY+e15H0ZKuuDdFIhGwYG0
         7JcxxCM9AU5DTLJ+pgI7xkCIqT9bosOjR1HSMrghMWCvgAQ+hnVKxbetl0tuJDR/zah4
         ifKzORhyNs7PcaI4AG3ylSvnsYgjl4uWcCM/e0NGbhEHiCRQNht3f4Yh971MQFo3ymuJ
         by9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5vRhkc5IMzU4kaVKid4fZSxbjmZzTOXFkexowlqqWdBdGqxCZqFPp0BxWmEdr55OYWFOZYyjlTl6aNrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUrdzXKDJYX6JOVT3N421mnuBszO+ajSin9paADbXZqJIUFSvD
	LDxtYspX/oO7t1MhPXvfQoA8rMW7UFspFsoTGRlUH1woLpB4S+Us/XsBa0JLCdA=
X-Gm-Gg: ASbGncuqcX6i44qCAEM25YKBgDgqdc/ShHR/+PDBJX4eAOAE3g5xjsk7CJexCUa8uxU
	d8k0r45utpkAqM/P8T9rCkb/MedbFLHjhKqXuFTvJePH2m1kioNnHbXjJIpN+zamaNKX7VzTDt2
	vnYzQeVs57Ylg4t55Ylg2DbrAvpLRtXAY5q39Hn4BEv86ce064qTiAoUYsXq7bKI8ctX1lU+OBI
	+kovBoOD2sFWGTta7/IHcHoYlGGCdm3tAhWymrU1N+a4EVbDkcp94QeqpFghwY36o+y0IHtMJBR
	bLmRDSn5
X-Google-Smtp-Source: AGHT+IHNyZ6Gmhi8CkHwki8iCp5hZVMJCqmLrVUuVJwgJ65+43JewzpqCE+zMexCnQ7438KBklSDKg==
X-Received: by 2002:a05:6402:510a:b0:5d0:d208:4cad with SMTP id 4fb4d7f45d1cf-5d41e16362amr4618611a12.2.1733850616337;
        Tue, 10 Dec 2024 09:10:16 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3e7936581sm4853124a12.56.2024.12.10.09.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 09:10:15 -0800 (PST)
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
Subject: [PATCH v4 05/24] ASoC: renesas: rz-ssi: Use only the proper amount of dividers
Date: Tue, 10 Dec 2024 19:09:34 +0200
Message-Id: <20241210170953.2936724-6-claudiu.beznea.uj@bp.renesas.com>
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

There is no need to populate the ckdv[] with invalid dividers as that
part will not be indexed anyway. The ssi->audio_mck/bclk_rate should
always be >= 0. While at it, change the ckdv type as u8, as the divider
128 was previously using the s8 sign bit.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- changed the ckdv type from s8 to u8 and updated patch description
  to reflect it

Changes in v3:
- s/sh/renesas in patch title

Changes in v2:
- none

 sound/soc/renesas/rz-ssi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/renesas/rz-ssi.c b/sound/soc/renesas/rz-ssi.c
index 2d8721156099..178c915331e9 100644
--- a/sound/soc/renesas/rz-ssi.c
+++ b/sound/soc/renesas/rz-ssi.c
@@ -258,8 +258,7 @@ static void rz_ssi_stream_quit(struct rz_ssi_priv *ssi,
 static int rz_ssi_clk_setup(struct rz_ssi_priv *ssi, unsigned int rate,
 			    unsigned int channels)
 {
-	static s8 ckdv[16] = { 1,  2,  4,  8, 16, 32, 64, 128,
-			       6, 12, 24, 48, 96, -1, -1, -1 };
+	static u8 ckdv[] = { 1,  2,  4,  8, 16, 32, 64, 128, 6, 12, 24, 48, 96 };
 	unsigned int channel_bits = 32;	/* System Word Length */
 	unsigned long bclk_rate = rate * channels * channel_bits;
 	unsigned int div;
-- 
2.39.2


