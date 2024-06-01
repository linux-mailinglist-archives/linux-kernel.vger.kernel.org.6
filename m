Return-Path: <linux-kernel+bounces-197894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 805728D7073
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 16:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23379283C93
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 14:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DA815250A;
	Sat,  1 Jun 2024 14:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7mnhAJ6"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1078475
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 14:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717252877; cv=none; b=Z4hwMbzGM9ae/DYo/sS2XWQbaG0RNcMB1om+bn0Q58p/5OVXAk+hgZb0mjdfy1ZyJ6kjWNZTgWSO2BQmeyeSqI2imbEs3K4K6sSJYLnGD8Ei1HCy6cJzW3N7DqfMoEj70HYg5++rK0JNmuXC2ptaYzDQ7jGt2ZaB621k7XO3abw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717252877; c=relaxed/simple;
	bh=+a/mVnYs0/uoIOCgvRtws4D2eIjELAfh3Z43y/B0QH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TWUOujoTmz2Pd0LACRe5Oa+8dlDeejNVoW7DisDFwGxdQhqEQsK4bzD8wrStS/OtJKh+hIkA3anl1ocLnEBNxcWbdvZrgI4lErZRQ4TXyZ7EKlluq7UNJ9CMkrup9z4U9ehuP6eragFAtfx4IyySiEQCQVNW0+25eRWsDbzQ6uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7mnhAJ6; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7eb01106015so71986239f.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 07:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717252875; x=1717857675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YYm71HSiGPsudDN1BEH9h2sX+QmeDn3a45v9S6zBBMI=;
        b=C7mnhAJ6C6pj5O2sN2XSdhD6UclsFvddd4dhG4+FWKV05e+XZgqyWoARI6tljKAaIv
         MvuAKtoQKotmNm2AbHIf7WjRmBp1vK10lANx4Pq/HiyNOHWdy/Bj38Q17N5N+Q1Y05yk
         NnGLUbI/SVa0VX8dSOmBrqVjEtJ6Nix+NlCOnMMsVTR0Uz5pwWHLsaf6+Nbr+Tm6vI4N
         N99ac4oWZ1YcBIkaQ+yylkzk7rkx8Y69G68ufu5rkDHjRlFmThNb/MfDoA/F4JddfYpF
         m2ONgL7tsu75KU2o4tRdtd3cj4yA5fnK1N2f2Qc2F0uE4646zIUxTIl5j+w0rDuVF+fe
         Ti1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717252875; x=1717857675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YYm71HSiGPsudDN1BEH9h2sX+QmeDn3a45v9S6zBBMI=;
        b=ggW8Kkr1hwN0B/WG5NT3fO5SQvzVuM6ZH9hx9QnWX4cBoP4P4B3UxRiuxcLf4aqhSq
         fW66pv5HoOdK0R9ufy+x39Do4+UqfuCbvTHGhLv4pxnTFqxZPM8MaVSgxhQ1G3Pqy7j2
         iMofRO+/AoEniseI0k+WHPMxVtLD5YRWWiUHqY1ryF0YAAydDTnxPTEtYLLKl+dAbj+f
         f1fdouSqeNjoftjgXvn8wcmNXj+THu17zoeRinS3AjUYa5Htfs5rVFsGXf4h1anQhLlD
         zcGQ8dd3RklLBeqTlKkmycpp/IarDlChEX+Z5IYZ/0EKxvXc6UjVmUp+2Dg88NfbXxLm
         IKTw==
X-Forwarded-Encrypted: i=1; AJvYcCXIMdl9YxLQcLiQNiiaht6v+3GN+D/XzOUWKzVU072WCHswHHFQPgZPAjosDGiWgzAAGNxNc7tkQtyBoZtBt7oma3cvPCzAYZJiR0hi
X-Gm-Message-State: AOJu0YyvDHOwspDPWnw+Iw6JJQZVqYAKBt+7l2wDYGHu0qfJfo+cczt/
	skxRNDsr7K1AkcRLoccxkaZUd5kdEHKYc1D9FjZkwKlEsHL2N72n
X-Google-Smtp-Source: AGHT+IFdMB5NEE4I6L4RNnvKvgCE2fzESNYLGg4gSTkI3X2gl0A00bOETGIHdhAGVjPzSoYizwfovQ==
X-Received: by 2002:a05:6602:1507:b0:7e1:b480:4c02 with SMTP id ca18e2360f4ac-7eaffe8caf2mr584434439f.5.1717252874663;
        Sat, 01 Jun 2024 07:41:14 -0700 (PDT)
Received: from aford-System-Version.lan ([2601:447:d002:5be:e0b7:c613:ee:e8f3])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7eafe603e5bsm107424639f.52.2024.06.01.07.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 07:41:14 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Marek Vasut <marex@denx.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Inki Dae <inki.dae@samsung.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Michael Tretter <m.tretter@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/2] drm/bridge: samsung-dsim: Set P divider based on min/max of fin pll
Date: Sat,  1 Jun 2024 09:41:01 -0500
Message-ID: <20240601144103.198299-1-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The P divider should be set based on the min and max values of
the fin pll which may vary between different platforms.
These ranges are defined per platform, but hard-coded values
were used instead which resulted in a smaller range available
on the i.MX8M[MNP] than what was possible.

As noted by Frieder, there are descripencies between the reference
manuals of the Mini, Nano and Plus, so I reached out to my NXP
rep and got the following response regarding the varing notes
in the documentation.

"Yes it is definitely wrong, the one that is part of the NOTE in
MIPI_DPHY_M_PLLPMS register table against PMS_P, PMS_M and PMS_S is
not correct. I will report this to Doc team, the one customer should
be take into account is the Table 13-40 DPHY PLL Parameters and the
Note above."

With this patch, the clock rates now match the values used in NXP's
downstream kernel.

Fixes: 846307185f0f ("drm/bridge: samsung-dsim: update PLL reference clock")
Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Marek Vasut <marex@denx.de>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

---
V2:  Only update the commit message to reflect why these values
     were chosen.  No code change present

V3:  No Changes

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index 95fedc68b0ae..8476650c477c 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -574,8 +574,8 @@ static unsigned long samsung_dsim_pll_find_pms(struct samsung_dsim *dsi,
 	u16 _m, best_m;
 	u8 _s, best_s;
 
-	p_min = DIV_ROUND_UP(fin, (12 * MHZ));
-	p_max = fin / (6 * MHZ);
+	p_min = DIV_ROUND_UP(fin, (driver_data->pll_fin_max * MHZ));
+	p_max = fin / (driver_data->pll_fin_min * MHZ);
 
 	for (_p = p_min; _p <= p_max; ++_p) {
 		for (_s = 0; _s <= 5; ++_s) {
-- 
2.43.0


