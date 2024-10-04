Return-Path: <linux-kernel+bounces-350588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F74990729
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25A29B22B1B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AC11AA788;
	Fri,  4 Oct 2024 15:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVCiIVfF"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7F31D9A41
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 15:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728054556; cv=none; b=ifG5FX+3aEVy2s1DD+tU9JgQBiPM+vg6RLxzkbQIEMx8ZZbUuV5TypGfuwhgnfO68wOx4FaCkIhIlTsL6ZjPJ+a05pufMYifJr1v7XKnDH+Nj2n9cMKvS/r1ZqxFbs3QbAxqZhWe0pyCkEj5wTEKPshFhDMqP6cpoUwxXKloyk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728054556; c=relaxed/simple;
	bh=8bosPdQPAI9sA7XcupOPlqC6EiHRjrLZlyJIWP/d6Qg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vb/G6kUURNteRj4W7PVscK+pavikfaFAXEkQ4G2Z/iF8YLz6pR6MyRtq9P2ROex+e/FJ+AQG6gaNS1XcLDFo8wOkqaOHmaR3Dep4N33ZZRFyo08PrpQr83R4oUIK+IHc+gsqn1K7b53L25hzlmBRpQl5xEBKQcl0IPcTACDaWiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVCiIVfF; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20b7a4336easo16045045ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 08:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728054554; x=1728659354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fa7E4EUymtfN4KRPnka0562XBK8R6gqCQBvfGcUm6b0=;
        b=NVCiIVfFwCKpQqvNYkL39Jofeyg9ooI7q/031suZpdUdJt8rJX2lP18SearEwOesrd
         1hhmqaJWYPvDJv1d1f+qdLCp+sL/+MjcuP70FL/DqAjyREnKLEhj5acaJK+GVuNFP4Oz
         EImAz2e8/ttL/AUchYoGbuIkD1XIPoms87VuVoVHFEsvbjIfU52YtlZ3DcYULAidKXLt
         jOfS0evTybarzCcK5UZtBR8lxs5hP+Y9+APpDJSK8odW4vP79CR2WmZM+EylEuLoAyXW
         f9YJaiLpatiFQe1uAebhRMcnLYV+h11eOQZVujZivnkI7dT8TnKy00NcYOJRSvY3OJZn
         XGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728054554; x=1728659354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fa7E4EUymtfN4KRPnka0562XBK8R6gqCQBvfGcUm6b0=;
        b=GxB087hA18ksEaw4bXDbOPDMuyhKoYriQ+7mdPFHWE12606ro6vnU3Ar1e69nzVsG1
         jLFKcA3+VbUkKvgV7B3PSWretWcXippqy1OHWJj9LpwSPEuE9HZ7D2luy5CQGe1V6l8y
         pcxI6a4eV32Sq2qWj4IPwGAf5TOr9cdwdJ873VQ63NC1Sg0iilz1H7TKvQAGVh0qO6y8
         SiX4ZqqItZQx6b/l50uPHlP3MtUqe+wwDctbs4f0abEdax07NaSZwYPbSv+ajzALOZwb
         hYGWCWxvO4Enxi2CWVKW4W9BH/mYSeYFfoRU7k+EoyGG8eTLmXyWqKl0O9sLSP6+91EX
         KRKw==
X-Forwarded-Encrypted: i=1; AJvYcCVgaDPrqk1QWWI4EtWj9FpSZM1LE1T38D+rNq5V2mQ8UPjLl+8QHvQ4HxKTVUEMI2I0P+zylMgrXH3ivkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNg88tt50ZFoRCpCQekmmD5YmY5BchLF9qsq4ktEy8sQLq7x2H
	4tHA9HUbDaFkySw3vmdfO8Oh56TcOPf39SZTGWnJyrbanjVyEfCU
X-Google-Smtp-Source: AGHT+IHqT4WwRtTWnbphT/hdIJs+bGfTdngKVlLEJIWAIBZgE8nozehC5fPrEF0vNA1zmLCvXqEaSQ==
X-Received: by 2002:a17:902:d2c9:b0:20b:4862:425f with SMTP id d9443c01a7336-20bfdfff453mr44987885ad.27.1728054553981;
        Fri, 04 Oct 2024 08:09:13 -0700 (PDT)
Received: from advait-kdeneon.. ([2405:201:1e:f1d5:cc2a:fef9:63f0:2e09])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beeca14a6sm25352775ad.86.2024.10.04.08.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 08:09:13 -0700 (PDT)
From: Advait Dhamorikar <advaitdhamorikar@gmail.com>
To: Sam Ravnborg <sam@ravnborg.org>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	anupnewsmail@gmail.com,
	Advait Dhamorikar <advaitdhamorikar@gmail.com>
Subject: [PATCH] drm/atmel_hlcdc: Fix uninitialized variable
Date: Fri,  4 Oct 2024 20:38:49 +0530
Message-Id: <20241004150849.70883-1-advaitdhamorikar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

atmel_hlcdc_plane_update_buffers: may use an uninitialized
sr variable when the if condition remains unsatisfied

Signed-off-by: Advait Dhamorikar <advaitdhamorikar@gmail.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
index 4a7ba0918eca..4150c4d0b4f2 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -559,7 +559,7 @@ static void atmel_hlcdc_plane_update_buffers(struct atmel_hlcdc_plane *plane,
 	const struct atmel_hlcdc_layer_desc *desc = plane->layer.desc;
 	struct atmel_hlcdc_dc *dc = plane->base.dev->dev_private;
 	struct drm_framebuffer *fb = state->base.fb;
-	u32 sr;
+	u32 sr = 0;
 	int i;
 
 	if (!dc->desc->is_xlcdc)
-- 
2.34.1


