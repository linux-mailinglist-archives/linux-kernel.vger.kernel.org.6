Return-Path: <linux-kernel+bounces-173818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D33A08C05F3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 22:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402C71F2411C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B73131BB9;
	Wed,  8 May 2024 20:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T6Ul30lK"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD6C132C38
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 20:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715201610; cv=none; b=M9bx41tv0zoa/TEMurw4oOGftrqHZZPePXtfJpWKKsrhtpWf0UI9//2OxscO2Zx5kQ/hTRX4OajnJL940g+Pr0DUPaGP2EBkPG8697LjBaARmEDI+xnMwk/7iUNOz51L1zWx7XoZbAfHU2qeDHKk3BooG/7aYnMCRs2CCr3rpNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715201610; c=relaxed/simple;
	bh=hZ/iWognldSeJiuYLC3vaqfpHgueYOXA78OBz393etU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dBqf090o55w4eyBjXOzC1av+vdVkMoHNu8Zg5zqSkEVCmaOW8qF4A+1QTkjm82p3R7zkTzwOypXAjGGp+yfyDW8E96CXURKZOFxf134nUg9O5MzLiAWisTkxSrBAXW9JQAUEPecun7mH8b5XoXmNpXlkTksOjOapNQ3xdDzA9YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T6Ul30lK; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2b37731c118so188916a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 13:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715201607; x=1715806407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNBdRTUhnMJUQTGuBK+L0Dohk8GABfrnq3BrV29pwCE=;
        b=T6Ul30lKfgHRp/onVeFDMRsMeJYrJs5jrGxQWMiyN2/Uq/zB1Z+nBZCQ4wFJ6QGtDd
         6nMjMq1rMeH+obl6X6T69em1z9Ez2BBrJtJYf082iG/tUwT8NxB5S6g5qsucpjp22RCk
         Miuico9RrXqqYRGGpYaq2xFEFVdoGamDxmy50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715201607; x=1715806407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uNBdRTUhnMJUQTGuBK+L0Dohk8GABfrnq3BrV29pwCE=;
        b=gnS22rpBhEpNNkU6EKsaFcHGUBw28kL6e6BSzeWyOJ7QSaxgZIc6ydglPGozOZrw96
         8tW8YQvqoncuVAnCg8zoqwNn4QpxaT5sOdQg4T2W67JlTYUoTP25sU7DK3oxgjsppoff
         9AXsDtUXxYqqFygBvROtUE+YqfLxnwT81GclgMZiO8YAVLV4K4QXvHoGoBU5TwPDjYdD
         +OxcgfqQnCqQNT6twhm/vsPvD0cffEYoSqH/ZShONBHNupR0u2klfrRMOGjiycb8EWz2
         63csX/zfCNw7PUrAqzpfwBxNNNmFZxXsmt5rxJGzBd0NeqjrJ0Z/zbtlCcwhRgG2Y3Jm
         Ey5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFiMUa1D48DTVTo097MIkISiMK4AQ6h1KAuoiOuWnSX5bv1q8/xKPA37yGfGyc1jYUZkAwQweVHy6rbkNImlhu4lrD7+JRystlgs37
X-Gm-Message-State: AOJu0YwEvndM+pRajl5wvBHrYSzmmNNnA7AaYBAjyLbKu0XEOYSZqFzk
	8EbzWWgr3Dl9ZBoDYTHVqzSNCQgtf2pfQwJVjbNx/HljtcaOZv347F9Zcl4f4EwM6Iz40Y/f04A
	=
X-Google-Smtp-Source: AGHT+IEeIMaogXMqXUTjhVxOaZrBfFy5NscKSzOlvn7E0V1UAI9d4eb+d6pW7Z4E1sAw4JUo/a1BcQ==
X-Received: by 2002:a17:90a:6348:b0:2b4:32be:3b8c with SMTP id 98e67ed59e1d1-2b616be2394mr3562061a91.37.1715201607021;
        Wed, 08 May 2024 13:53:27 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:40f4:feca:59e0:d3ca])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b67126ad51sm6887a91.25.2024.05.08.13.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 13:53:26 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org
Cc: lvzhaoxiong@huaqin.corp-partner.google.com,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Hsin-Yi Wang <hsinyi@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Joel Selvaraj <jo@jsfamily.in>,
	Brian Norris <briannorris@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Ritesh Kumar <quic_riteshk@quicinc.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/9] drm/panel: novatek-nt36672e: Switch to mipi_dsi_dcs_write_seq_multi()
Date: Wed,  8 May 2024 13:51:48 -0700
Message-ID: <20240508135148.v4.6.I3c08a7d02c467d2bc88da14e513ea4c8649fce45@changeid>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240508205222.2251854-1-dianders@chromium.org>
References: <20240508205222.2251854-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a mechanical conversion of the novatek-nt36672e driver to use
the new mipi_dsi_dcs_write_seq_multi(). The new function is easier for
clients to understand and using it also causes smaller code to be
generated. Specifically:

$ scripts/bloat-o-meter \
  ...after/panel-novatek-nt36672e.ko \
  ...ctx/panel-novatek-nt36672e.ko
add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-988 (-988)
Function                                     old     new   delta
nt36672e_1080x2408_60hz_init                6236    5248    -988
Total: Before=10651, After=9663, chg -9.28%

Cc: Ritesh Kumar <quic_riteshk@quicinc.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This change is only compile tested. I don't use this panel myself but
arbitrarily picked it as an example to look at when working on the
MIPI DSI macros.

NOTE: as of the posting of v4 this change still has no tags. Without
any tags (Reviewed-by/Tested-by/Acked-by) I won't actually land this
change even if the rest of the series lands.

(no changes since v3)

Changes in v3:
- Fix spacing of init function.

Changes in v2:
- New

 .../gpu/drm/panel/panel-novatek-nt36672e.c    | 576 +++++++++---------
 1 file changed, 289 insertions(+), 287 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672e.c b/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
index 20b7bfe4aa12..9ce8df455232 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
@@ -51,293 +51,295 @@ static inline struct nt36672e_panel *to_nt36672e_panel(struct drm_panel *panel)
 
 static int nt36672e_1080x2408_60hz_init(struct mipi_dsi_device *dsi)
 {
-	mipi_dsi_dcs_write_seq(dsi, 0xff, 0x10);
-	mipi_dsi_dcs_write_seq(dsi, 0xfb, 0x01);
-	mipi_dsi_dcs_write_seq(dsi, 0xb0, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0xc0, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0xc1, 0x89, 0x28, 0x00, 0x08, 0x00, 0xaa, 0x02,
-				0x0e, 0x00, 0x2b, 0x00, 0x07, 0x0d, 0xb7, 0x0c, 0xb7);
-
-	mipi_dsi_dcs_write_seq(dsi, 0xc2, 0x1b, 0xa0);
-	mipi_dsi_dcs_write_seq(dsi, 0xff, 0x20);
-	mipi_dsi_dcs_write_seq(dsi, 0xfb, 0x01);
-	mipi_dsi_dcs_write_seq(dsi, 0x01, 0x66);
-	mipi_dsi_dcs_write_seq(dsi, 0x06, 0x40);
-	mipi_dsi_dcs_write_seq(dsi, 0x07, 0x38);
-	mipi_dsi_dcs_write_seq(dsi, 0x2f, 0x83);
-	mipi_dsi_dcs_write_seq(dsi, 0x69, 0x91);
-	mipi_dsi_dcs_write_seq(dsi, 0x95, 0xd1);
-	mipi_dsi_dcs_write_seq(dsi, 0x96, 0xd1);
-	mipi_dsi_dcs_write_seq(dsi, 0xf2, 0x64);
-	mipi_dsi_dcs_write_seq(dsi, 0xf3, 0x54);
-	mipi_dsi_dcs_write_seq(dsi, 0xf4, 0x64);
-	mipi_dsi_dcs_write_seq(dsi, 0xf5, 0x54);
-	mipi_dsi_dcs_write_seq(dsi, 0xf6, 0x64);
-	mipi_dsi_dcs_write_seq(dsi, 0xf7, 0x54);
-	mipi_dsi_dcs_write_seq(dsi, 0xf8, 0x64);
-	mipi_dsi_dcs_write_seq(dsi, 0xf9, 0x54);
-	mipi_dsi_dcs_write_seq(dsi, 0xff, 0x24);
-	mipi_dsi_dcs_write_seq(dsi, 0xfb, 0x01);
-	mipi_dsi_dcs_write_seq(dsi, 0x01, 0x0f);
-	mipi_dsi_dcs_write_seq(dsi, 0x03, 0x0c);
-	mipi_dsi_dcs_write_seq(dsi, 0x05, 0x1d);
-	mipi_dsi_dcs_write_seq(dsi, 0x08, 0x2f);
-	mipi_dsi_dcs_write_seq(dsi, 0x09, 0x2e);
-	mipi_dsi_dcs_write_seq(dsi, 0x0a, 0x2d);
-	mipi_dsi_dcs_write_seq(dsi, 0x0b, 0x2c);
-	mipi_dsi_dcs_write_seq(dsi, 0x11, 0x17);
-	mipi_dsi_dcs_write_seq(dsi, 0x12, 0x13);
-	mipi_dsi_dcs_write_seq(dsi, 0x13, 0x15);
-	mipi_dsi_dcs_write_seq(dsi, 0x15, 0x14);
-	mipi_dsi_dcs_write_seq(dsi, 0x16, 0x16);
-	mipi_dsi_dcs_write_seq(dsi, 0x17, 0x18);
-	mipi_dsi_dcs_write_seq(dsi, 0x1b, 0x01);
-	mipi_dsi_dcs_write_seq(dsi, 0x1d, 0x1d);
-	mipi_dsi_dcs_write_seq(dsi, 0x20, 0x2f);
-	mipi_dsi_dcs_write_seq(dsi, 0x21, 0x2e);
-	mipi_dsi_dcs_write_seq(dsi, 0x22, 0x2d);
-	mipi_dsi_dcs_write_seq(dsi, 0x23, 0x2c);
-	mipi_dsi_dcs_write_seq(dsi, 0x29, 0x17);
-	mipi_dsi_dcs_write_seq(dsi, 0x2a, 0x13);
-	mipi_dsi_dcs_write_seq(dsi, 0x2b, 0x15);
-	mipi_dsi_dcs_write_seq(dsi, 0x2f, 0x14);
-	mipi_dsi_dcs_write_seq(dsi, 0x30, 0x16);
-	mipi_dsi_dcs_write_seq(dsi, 0x31, 0x18);
-	mipi_dsi_dcs_write_seq(dsi, 0x32, 0x04);
-	mipi_dsi_dcs_write_seq(dsi, 0x34, 0x10);
-	mipi_dsi_dcs_write_seq(dsi, 0x35, 0x1f);
-	mipi_dsi_dcs_write_seq(dsi, 0x36, 0x1f);
-	mipi_dsi_dcs_write_seq(dsi, 0x4d, 0x14);
-	mipi_dsi_dcs_write_seq(dsi, 0x4e, 0x36);
-	mipi_dsi_dcs_write_seq(dsi, 0x4f, 0x36);
-	mipi_dsi_dcs_write_seq(dsi, 0x53, 0x36);
-	mipi_dsi_dcs_write_seq(dsi, 0x71, 0x30);
-	mipi_dsi_dcs_write_seq(dsi, 0x79, 0x11);
-	mipi_dsi_dcs_write_seq(dsi, 0x7a, 0x82);
-	mipi_dsi_dcs_write_seq(dsi, 0x7b, 0x8f);
-	mipi_dsi_dcs_write_seq(dsi, 0x7d, 0x04);
-	mipi_dsi_dcs_write_seq(dsi, 0x80, 0x04);
-	mipi_dsi_dcs_write_seq(dsi, 0x81, 0x04);
-	mipi_dsi_dcs_write_seq(dsi, 0x82, 0x13);
-	mipi_dsi_dcs_write_seq(dsi, 0x84, 0x31);
-	mipi_dsi_dcs_write_seq(dsi, 0x85, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0x86, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0x87, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0x90, 0x13);
-	mipi_dsi_dcs_write_seq(dsi, 0x92, 0x31);
-	mipi_dsi_dcs_write_seq(dsi, 0x93, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0x94, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0x95, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0x9c, 0xf4);
-	mipi_dsi_dcs_write_seq(dsi, 0x9d, 0x01);
-	mipi_dsi_dcs_write_seq(dsi, 0xa0, 0x0f);
-	mipi_dsi_dcs_write_seq(dsi, 0xa2, 0x0f);
-	mipi_dsi_dcs_write_seq(dsi, 0xa3, 0x02);
-	mipi_dsi_dcs_write_seq(dsi, 0xa4, 0x04);
-	mipi_dsi_dcs_write_seq(dsi, 0xa5, 0x04);
-	mipi_dsi_dcs_write_seq(dsi, 0xc6, 0xc0);
-	mipi_dsi_dcs_write_seq(dsi, 0xc9, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0xd9, 0x80);
-	mipi_dsi_dcs_write_seq(dsi, 0xe9, 0x02);
-	mipi_dsi_dcs_write_seq(dsi, 0xff, 0x25);
-	mipi_dsi_dcs_write_seq(dsi, 0xfb, 0x01);
-	mipi_dsi_dcs_write_seq(dsi, 0x18, 0x22);
-	mipi_dsi_dcs_write_seq(dsi, 0x19, 0xe4);
-	mipi_dsi_dcs_write_seq(dsi, 0x21, 0x40);
-	mipi_dsi_dcs_write_seq(dsi, 0x66, 0xd8);
-	mipi_dsi_dcs_write_seq(dsi, 0x68, 0x50);
-	mipi_dsi_dcs_write_seq(dsi, 0x69, 0x10);
-	mipi_dsi_dcs_write_seq(dsi, 0x6b, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0x6d, 0x0d);
-	mipi_dsi_dcs_write_seq(dsi, 0x6e, 0x48);
-	mipi_dsi_dcs_write_seq(dsi, 0x72, 0x41);
-	mipi_dsi_dcs_write_seq(dsi, 0x73, 0x4a);
-	mipi_dsi_dcs_write_seq(dsi, 0x74, 0xd0);
-	mipi_dsi_dcs_write_seq(dsi, 0x77, 0x62);
-	mipi_dsi_dcs_write_seq(dsi, 0x79, 0x7e);
-	mipi_dsi_dcs_write_seq(dsi, 0x7d, 0x03);
-	mipi_dsi_dcs_write_seq(dsi, 0x7e, 0x15);
-	mipi_dsi_dcs_write_seq(dsi, 0x7f, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0x84, 0x4d);
-	mipi_dsi_dcs_write_seq(dsi, 0xcf, 0x80);
-	mipi_dsi_dcs_write_seq(dsi, 0xd6, 0x80);
-	mipi_dsi_dcs_write_seq(dsi, 0xd7, 0x80);
-	mipi_dsi_dcs_write_seq(dsi, 0xef, 0x20);
-	mipi_dsi_dcs_write_seq(dsi, 0xf0, 0x84);
-	mipi_dsi_dcs_write_seq(dsi, 0xff, 0x26);
-	mipi_dsi_dcs_write_seq(dsi, 0xfb, 0x01);
-	mipi_dsi_dcs_write_seq(dsi, 0x81, 0x0f);
-	mipi_dsi_dcs_write_seq(dsi, 0x83, 0x01);
-	mipi_dsi_dcs_write_seq(dsi, 0x84, 0x03);
-	mipi_dsi_dcs_write_seq(dsi, 0x85, 0x01);
-	mipi_dsi_dcs_write_seq(dsi, 0x86, 0x03);
-	mipi_dsi_dcs_write_seq(dsi, 0x87, 0x01);
-	mipi_dsi_dcs_write_seq(dsi, 0x88, 0x05);
-	mipi_dsi_dcs_write_seq(dsi, 0x8a, 0x1a);
-	mipi_dsi_dcs_write_seq(dsi, 0x8b, 0x11);
-	mipi_dsi_dcs_write_seq(dsi, 0x8c, 0x24);
-	mipi_dsi_dcs_write_seq(dsi, 0x8e, 0x42);
-	mipi_dsi_dcs_write_seq(dsi, 0x8f, 0x11);
-	mipi_dsi_dcs_write_seq(dsi, 0x90, 0x11);
-	mipi_dsi_dcs_write_seq(dsi, 0x91, 0x11);
-	mipi_dsi_dcs_write_seq(dsi, 0x9a, 0x80);
-	mipi_dsi_dcs_write_seq(dsi, 0x9b, 0x04);
-	mipi_dsi_dcs_write_seq(dsi, 0x9c, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0x9d, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0x9e, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0xff, 0x27);
-	mipi_dsi_dcs_write_seq(dsi, 0xfb, 0x01);
-	mipi_dsi_dcs_write_seq(dsi, 0x01, 0x68);
-	mipi_dsi_dcs_write_seq(dsi, 0x20, 0x81);
-	mipi_dsi_dcs_write_seq(dsi, 0x21, 0x6a);
-	mipi_dsi_dcs_write_seq(dsi, 0x25, 0x81);
-	mipi_dsi_dcs_write_seq(dsi, 0x26, 0x94);
-	mipi_dsi_dcs_write_seq(dsi, 0x6e, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0x6f, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0x70, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0x71, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0x72, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0x75, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0x76, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0x77, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0x7d, 0x09);
-	mipi_dsi_dcs_write_seq(dsi, 0x7e, 0x67);
-	mipi_dsi_dcs_write_seq(dsi, 0x80, 0x23);
-	mipi_dsi_dcs_write_seq(dsi, 0x82, 0x09);
-	mipi_dsi_dcs_write_seq(dsi, 0x83, 0x67);
-	mipi_dsi_dcs_write_seq(dsi, 0x88, 0x01);
-	mipi_dsi_dcs_write_seq(dsi, 0x89, 0x10);
-	mipi_dsi_dcs_write_seq(dsi, 0xa5, 0x10);
-	mipi_dsi_dcs_write_seq(dsi, 0xa6, 0x23);
-	mipi_dsi_dcs_write_seq(dsi, 0xa7, 0x01);
-	mipi_dsi_dcs_write_seq(dsi, 0xb6, 0x40);
-	mipi_dsi_dcs_write_seq(dsi, 0xe5, 0x02);
-	mipi_dsi_dcs_write_seq(dsi, 0xe6, 0xd3);
-	mipi_dsi_dcs_write_seq(dsi, 0xeb, 0x03);
-	mipi_dsi_dcs_write_seq(dsi, 0xec, 0x28);
-	mipi_dsi_dcs_write_seq(dsi, 0xff, 0x2a);
-	mipi_dsi_dcs_write_seq(dsi, 0xfb, 0x01);
-	mipi_dsi_dcs_write_seq(dsi, 0x00, 0x91);
-	mipi_dsi_dcs_write_seq(dsi, 0x03, 0x20);
-	mipi_dsi_dcs_write_seq(dsi, 0x07, 0x50);
-	mipi_dsi_dcs_write_seq(dsi, 0x0a, 0x70);
-	mipi_dsi_dcs_write_seq(dsi, 0x0c, 0x04);
-	mipi_dsi_dcs_write_seq(dsi, 0x0d, 0x40);
-	mipi_dsi_dcs_write_seq(dsi, 0x0f, 0x01);
-	mipi_dsi_dcs_write_seq(dsi, 0x11, 0xe0);
-	mipi_dsi_dcs_write_seq(dsi, 0x15, 0x0f);
-	mipi_dsi_dcs_write_seq(dsi, 0x16, 0xa4);
-	mipi_dsi_dcs_write_seq(dsi, 0x19, 0x0f);
-	mipi_dsi_dcs_write_seq(dsi, 0x1a, 0x78);
-	mipi_dsi_dcs_write_seq(dsi, 0x1b, 0x23);
-	mipi_dsi_dcs_write_seq(dsi, 0x1d, 0x36);
-	mipi_dsi_dcs_write_seq(dsi, 0x1e, 0x3e);
-	mipi_dsi_dcs_write_seq(dsi, 0x1f, 0x3e);
-	mipi_dsi_dcs_write_seq(dsi, 0x20, 0x3e);
-	mipi_dsi_dcs_write_seq(dsi, 0x28, 0xfd);
-	mipi_dsi_dcs_write_seq(dsi, 0x29, 0x12);
-	mipi_dsi_dcs_write_seq(dsi, 0x2a, 0xe1);
-	mipi_dsi_dcs_write_seq(dsi, 0x2d, 0x0a);
-	mipi_dsi_dcs_write_seq(dsi, 0x30, 0x49);
-	mipi_dsi_dcs_write_seq(dsi, 0x33, 0x96);
-	mipi_dsi_dcs_write_seq(dsi, 0x34, 0xff);
-	mipi_dsi_dcs_write_seq(dsi, 0x35, 0x40);
-	mipi_dsi_dcs_write_seq(dsi, 0x36, 0xde);
-	mipi_dsi_dcs_write_seq(dsi, 0x37, 0xf9);
-	mipi_dsi_dcs_write_seq(dsi, 0x38, 0x45);
-	mipi_dsi_dcs_write_seq(dsi, 0x39, 0xd9);
-	mipi_dsi_dcs_write_seq(dsi, 0x3a, 0x49);
-	mipi_dsi_dcs_write_seq(dsi, 0x4a, 0xf0);
-	mipi_dsi_dcs_write_seq(dsi, 0x7a, 0x09);
-	mipi_dsi_dcs_write_seq(dsi, 0x7b, 0x40);
-	mipi_dsi_dcs_write_seq(dsi, 0x7f, 0xf0);
-	mipi_dsi_dcs_write_seq(dsi, 0x83, 0x0f);
-	mipi_dsi_dcs_write_seq(dsi, 0x84, 0xa4);
-	mipi_dsi_dcs_write_seq(dsi, 0x87, 0x0f);
-	mipi_dsi_dcs_write_seq(dsi, 0x88, 0x78);
-	mipi_dsi_dcs_write_seq(dsi, 0x89, 0x23);
-	mipi_dsi_dcs_write_seq(dsi, 0x8b, 0x36);
-	mipi_dsi_dcs_write_seq(dsi, 0x8c, 0x7d);
-	mipi_dsi_dcs_write_seq(dsi, 0x8d, 0x7d);
-	mipi_dsi_dcs_write_seq(dsi, 0x8e, 0x7d);
-	mipi_dsi_dcs_write_seq(dsi, 0xff, 0x20);
-	mipi_dsi_dcs_write_seq(dsi, 0xfb, 0x01);
-	mipi_dsi_dcs_write_seq(dsi, 0xb0, 0x00, 0x00, 0x00, 0x17, 0x00, 0x49, 0x00,
-				0x6a, 0x00, 0x89, 0x00, 0x9f, 0x00, 0xb6, 0x00, 0xc8);
-	mipi_dsi_dcs_write_seq(dsi, 0xb1, 0x00, 0xd9, 0x01, 0x10, 0x01, 0x3a, 0x01,
-				0x7a, 0x01, 0xa9, 0x01, 0xf2, 0x02, 0x2d, 0x02, 0x2e);
-	mipi_dsi_dcs_write_seq(dsi, 0xb2, 0x02, 0x64, 0x02, 0xa3, 0x02, 0xca, 0x03,
-				0x00, 0x03, 0x1e, 0x03, 0x4a, 0x03, 0x59, 0x03, 0x6a);
-	mipi_dsi_dcs_write_seq(dsi, 0xb3, 0x03, 0x7d, 0x03, 0x93, 0x03, 0xab, 0x03,
-				0xc8, 0x03, 0xec, 0x03, 0xfe, 0x00, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0xb4, 0x00, 0x00, 0x00, 0x1b, 0x00, 0x51, 0x00,
-				0x71, 0x00, 0x90, 0x00, 0xa7, 0x00, 0xbf, 0x00, 0xd1);
-	mipi_dsi_dcs_write_seq(dsi, 0xb5, 0x00, 0xe2, 0x01, 0x1a, 0x01, 0x43, 0x01,
-				0x83, 0x01, 0xb2, 0x01, 0xfa, 0x02, 0x34, 0x02, 0x36);
-	mipi_dsi_dcs_write_seq(dsi, 0xb6, 0x02, 0x6b, 0x02, 0xa8, 0x02, 0xd0, 0x03,
-				0x03, 0x03, 0x21, 0x03, 0x4d, 0x03, 0x5b, 0x03, 0x6b);
-	mipi_dsi_dcs_write_seq(dsi, 0xb7, 0x03, 0x7e, 0x03, 0x94, 0x03, 0xac, 0x03,
-				0xc8, 0x03, 0xec, 0x03, 0xfe, 0x00, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0xb8, 0x00, 0x00, 0x00, 0x1b, 0x00, 0x51, 0x00,
-				0x72, 0x00, 0x92, 0x00, 0xa8, 0x00, 0xbf, 0x00, 0xd1);
-	mipi_dsi_dcs_write_seq(dsi, 0xb9, 0x00, 0xe2, 0x01, 0x18, 0x01, 0x42, 0x01,
-				0x81, 0x01, 0xaf, 0x01, 0xf5, 0x02, 0x2f, 0x02, 0x31);
-	mipi_dsi_dcs_write_seq(dsi, 0xba, 0x02, 0x68, 0x02, 0xa6, 0x02, 0xcd, 0x03,
-				0x01, 0x03, 0x1f, 0x03, 0x4a, 0x03, 0x59, 0x03, 0x6a);
-	mipi_dsi_dcs_write_seq(dsi, 0xbb, 0x03, 0x7d, 0x03, 0x93, 0x03, 0xab, 0x03,
-				0xc8, 0x03, 0xec, 0x03, 0xfe, 0x00, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0xff, 0x21);
-	mipi_dsi_dcs_write_seq(dsi, 0xfb, 0x01);
-	mipi_dsi_dcs_write_seq(dsi, 0xb0, 0x00, 0x00, 0x00, 0x17, 0x00, 0x49, 0x00,
-				0x6a, 0x00, 0x89, 0x00, 0x9f, 0x00, 0xb6, 0x00, 0xc8);
-	mipi_dsi_dcs_write_seq(dsi, 0xb1, 0x00, 0xd9, 0x01, 0x10, 0x01, 0x3a, 0x01,
-				0x7a, 0x01, 0xa9, 0x01, 0xf2, 0x02, 0x2d, 0x02, 0x2e);
-	mipi_dsi_dcs_write_seq(dsi, 0xb2, 0x02, 0x64, 0x02, 0xa3, 0x02, 0xca, 0x03,
-				0x00, 0x03, 0x1e, 0x03, 0x4a, 0x03, 0x59, 0x03, 0x6a);
-	mipi_dsi_dcs_write_seq(dsi, 0xb3, 0x03, 0x7d, 0x03, 0x93, 0x03, 0xab, 0x03,
-				0xc8, 0x03, 0xec, 0x03, 0xfe, 0x00, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0xb4, 0x00, 0x00, 0x00, 0x1b, 0x00, 0x51, 0x00,
-				0x71, 0x00, 0x90, 0x00, 0xa7, 0x00, 0xbf, 0x00, 0xd1);
-	mipi_dsi_dcs_write_seq(dsi, 0xb5, 0x00, 0xe2, 0x01, 0x1a, 0x01, 0x43, 0x01,
-				0x83, 0x01, 0xb2, 0x01, 0xfa, 0x02, 0x34, 0x02, 0x36);
-	mipi_dsi_dcs_write_seq(dsi, 0xb6, 0x02, 0x6b, 0x02, 0xa8, 0x02, 0xd0, 0x03,
-				0x03, 0x03, 0x21, 0x03, 0x4d, 0x03, 0x5b, 0x03, 0x6b);
-	mipi_dsi_dcs_write_seq(dsi, 0xb7, 0x03, 0x7e, 0x03, 0x94, 0x03, 0xac, 0x03,
-				0xc8, 0x03, 0xec, 0x03, 0xfe, 0x00, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0xb8, 0x00, 0x00, 0x00, 0x1b, 0x00, 0x51, 0x00,
-				0x72, 0x00, 0x92, 0x00, 0xa8, 0x00, 0xbf, 0x00, 0xd1);
-	mipi_dsi_dcs_write_seq(dsi, 0xb9, 0x00, 0xe2, 0x01, 0x18, 0x01, 0x42, 0x01,
-				0x81, 0x01, 0xaf, 0x01, 0xf5, 0x02, 0x2f, 0x02, 0x31);
-	mipi_dsi_dcs_write_seq(dsi, 0xba, 0x02, 0x68, 0x02, 0xa6, 0x02, 0xcd, 0x03,
-				0x01, 0x03, 0x1f, 0x03, 0x4a, 0x03, 0x59, 0x03, 0x6a);
-	mipi_dsi_dcs_write_seq(dsi, 0xbb, 0x03, 0x7d, 0x03, 0x93, 0x03, 0xab, 0x03,
-				0xc8, 0x03, 0xec, 0x03, 0xfe, 0x00, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0xff, 0x2c);
-	mipi_dsi_dcs_write_seq(dsi, 0xfb, 0x01);
-	mipi_dsi_dcs_write_seq(dsi, 0x61, 0x1f);
-	mipi_dsi_dcs_write_seq(dsi, 0x62, 0x1f);
-	mipi_dsi_dcs_write_seq(dsi, 0x7e, 0x03);
-	mipi_dsi_dcs_write_seq(dsi, 0x6a, 0x14);
-	mipi_dsi_dcs_write_seq(dsi, 0x6b, 0x36);
-	mipi_dsi_dcs_write_seq(dsi, 0x6c, 0x36);
-	mipi_dsi_dcs_write_seq(dsi, 0x6d, 0x36);
-	mipi_dsi_dcs_write_seq(dsi, 0x53, 0x04);
-	mipi_dsi_dcs_write_seq(dsi, 0x54, 0x04);
-	mipi_dsi_dcs_write_seq(dsi, 0x55, 0x04);
-	mipi_dsi_dcs_write_seq(dsi, 0x56, 0x0f);
-	mipi_dsi_dcs_write_seq(dsi, 0x58, 0x0f);
-	mipi_dsi_dcs_write_seq(dsi, 0x59, 0x0f);
-	mipi_dsi_dcs_write_seq(dsi, 0xff, 0xf0);
-	mipi_dsi_dcs_write_seq(dsi, 0xfb, 0x01);
-	mipi_dsi_dcs_write_seq(dsi, 0x5a, 0x00);
-
-	mipi_dsi_dcs_write_seq(dsi, 0xff, 0x10);
-	mipi_dsi_dcs_write_seq(dsi, 0xfb, 0x01);
-	mipi_dsi_dcs_write_seq(dsi, 0x51, 0xff);
-	mipi_dsi_dcs_write_seq(dsi, 0x53, 0x24);
-	mipi_dsi_dcs_write_seq(dsi, 0x55, 0x01);
-
-	return 0;
+	struct mipi_dsi_multi_context ctx = { .dsi = dsi };
+
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xff, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xfb, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb0, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xc0, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xc1, 0x89, 0x28, 0x00, 0x08, 0x00, 0xaa, 0x02,
+				     0x0e, 0x00, 0x2b, 0x00, 0x07, 0x0d, 0xb7, 0x0c, 0xb7);
+
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xc2, 0x1b, 0xa0);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xff, 0x20);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xfb, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x01, 0x66);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x06, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x07, 0x38);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x2f, 0x83);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x69, 0x91);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x95, 0xd1);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x96, 0xd1);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xf2, 0x64);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xf3, 0x54);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xf4, 0x64);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xf5, 0x54);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xf6, 0x64);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xf7, 0x54);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xf8, 0x64);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xf9, 0x54);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xff, 0x24);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xfb, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x01, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x03, 0x0c);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x05, 0x1d);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x08, 0x2f);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x09, 0x2e);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x0a, 0x2d);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x0b, 0x2c);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x11, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x12, 0x13);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x13, 0x15);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x15, 0x14);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x16, 0x16);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x17, 0x18);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x1b, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x1d, 0x1d);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x20, 0x2f);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x21, 0x2e);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x22, 0x2d);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x23, 0x2c);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x29, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x2a, 0x13);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x2b, 0x15);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x2f, 0x14);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x30, 0x16);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x31, 0x18);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x32, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x34, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x35, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x36, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x4d, 0x14);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x4e, 0x36);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x4f, 0x36);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x53, 0x36);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x71, 0x30);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x79, 0x11);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x7a, 0x82);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x7b, 0x8f);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x7d, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x80, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x81, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x82, 0x13);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x84, 0x31);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x85, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x86, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x87, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x90, 0x13);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x92, 0x31);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x93, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x94, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x95, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x9c, 0xf4);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x9d, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xa0, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xa2, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xa3, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xa4, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xa5, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xc6, 0xc0);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xc9, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xd9, 0x80);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xe9, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xff, 0x25);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xfb, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x18, 0x22);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x19, 0xe4);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x21, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x66, 0xd8);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x68, 0x50);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x69, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x6b, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x6d, 0x0d);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x6e, 0x48);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x72, 0x41);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x73, 0x4a);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x74, 0xd0);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x77, 0x62);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x79, 0x7e);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x7d, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x7e, 0x15);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x7f, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x84, 0x4d);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xcf, 0x80);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xd6, 0x80);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xd7, 0x80);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xef, 0x20);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xf0, 0x84);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xff, 0x26);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xfb, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x81, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x83, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x84, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x85, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x86, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x87, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x88, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x8a, 0x1a);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x8b, 0x11);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x8c, 0x24);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x8e, 0x42);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x8f, 0x11);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x90, 0x11);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x91, 0x11);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x9a, 0x80);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x9b, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x9c, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x9d, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x9e, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xff, 0x27);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xfb, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x01, 0x68);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x20, 0x81);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x21, 0x6a);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x25, 0x81);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x26, 0x94);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x6e, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x6f, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x70, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x71, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x72, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x75, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x76, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x77, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x7d, 0x09);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x7e, 0x67);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x80, 0x23);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x82, 0x09);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x83, 0x67);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x88, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x89, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xa5, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xa6, 0x23);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xa7, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb6, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xe5, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xe6, 0xd3);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xeb, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xec, 0x28);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xff, 0x2a);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xfb, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x00, 0x91);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x03, 0x20);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x07, 0x50);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x0a, 0x70);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x0c, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x0d, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x0f, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x11, 0xe0);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x15, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x16, 0xa4);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x19, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x1a, 0x78);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x1b, 0x23);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x1d, 0x36);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x1e, 0x3e);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x1f, 0x3e);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x20, 0x3e);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x28, 0xfd);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x29, 0x12);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x2a, 0xe1);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x2d, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x30, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x33, 0x96);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x34, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x35, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x36, 0xde);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x37, 0xf9);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x38, 0x45);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x39, 0xd9);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x3a, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x4a, 0xf0);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x7a, 0x09);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x7b, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x7f, 0xf0);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x83, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x84, 0xa4);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x87, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x88, 0x78);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x89, 0x23);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x8b, 0x36);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x8c, 0x7d);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x8d, 0x7d);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x8e, 0x7d);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xff, 0x20);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xfb, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb0, 0x00, 0x00, 0x00, 0x17, 0x00, 0x49, 0x00,
+				     0x6a, 0x00, 0x89, 0x00, 0x9f, 0x00, 0xb6, 0x00, 0xc8);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb1, 0x00, 0xd9, 0x01, 0x10, 0x01, 0x3a, 0x01,
+				     0x7a, 0x01, 0xa9, 0x01, 0xf2, 0x02, 0x2d, 0x02, 0x2e);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb2, 0x02, 0x64, 0x02, 0xa3, 0x02, 0xca, 0x03,
+				     0x00, 0x03, 0x1e, 0x03, 0x4a, 0x03, 0x59, 0x03, 0x6a);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb3, 0x03, 0x7d, 0x03, 0x93, 0x03, 0xab, 0x03,
+				     0xc8, 0x03, 0xec, 0x03, 0xfe, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb4, 0x00, 0x00, 0x00, 0x1b, 0x00, 0x51, 0x00,
+				     0x71, 0x00, 0x90, 0x00, 0xa7, 0x00, 0xbf, 0x00, 0xd1);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb5, 0x00, 0xe2, 0x01, 0x1a, 0x01, 0x43, 0x01,
+				     0x83, 0x01, 0xb2, 0x01, 0xfa, 0x02, 0x34, 0x02, 0x36);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb6, 0x02, 0x6b, 0x02, 0xa8, 0x02, 0xd0, 0x03,
+				     0x03, 0x03, 0x21, 0x03, 0x4d, 0x03, 0x5b, 0x03, 0x6b);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb7, 0x03, 0x7e, 0x03, 0x94, 0x03, 0xac, 0x03,
+				     0xc8, 0x03, 0xec, 0x03, 0xfe, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb8, 0x00, 0x00, 0x00, 0x1b, 0x00, 0x51, 0x00,
+				     0x72, 0x00, 0x92, 0x00, 0xa8, 0x00, 0xbf, 0x00, 0xd1);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb9, 0x00, 0xe2, 0x01, 0x18, 0x01, 0x42, 0x01,
+				     0x81, 0x01, 0xaf, 0x01, 0xf5, 0x02, 0x2f, 0x02, 0x31);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xba, 0x02, 0x68, 0x02, 0xa6, 0x02, 0xcd, 0x03,
+				     0x01, 0x03, 0x1f, 0x03, 0x4a, 0x03, 0x59, 0x03, 0x6a);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xbb, 0x03, 0x7d, 0x03, 0x93, 0x03, 0xab, 0x03,
+				     0xc8, 0x03, 0xec, 0x03, 0xfe, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xff, 0x21);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xfb, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb0, 0x00, 0x00, 0x00, 0x17, 0x00, 0x49, 0x00,
+				     0x6a, 0x00, 0x89, 0x00, 0x9f, 0x00, 0xb6, 0x00, 0xc8);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb1, 0x00, 0xd9, 0x01, 0x10, 0x01, 0x3a, 0x01,
+				     0x7a, 0x01, 0xa9, 0x01, 0xf2, 0x02, 0x2d, 0x02, 0x2e);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb2, 0x02, 0x64, 0x02, 0xa3, 0x02, 0xca, 0x03,
+				     0x00, 0x03, 0x1e, 0x03, 0x4a, 0x03, 0x59, 0x03, 0x6a);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb3, 0x03, 0x7d, 0x03, 0x93, 0x03, 0xab, 0x03,
+				     0xc8, 0x03, 0xec, 0x03, 0xfe, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb4, 0x00, 0x00, 0x00, 0x1b, 0x00, 0x51, 0x00,
+				     0x71, 0x00, 0x90, 0x00, 0xa7, 0x00, 0xbf, 0x00, 0xd1);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb5, 0x00, 0xe2, 0x01, 0x1a, 0x01, 0x43, 0x01,
+				     0x83, 0x01, 0xb2, 0x01, 0xfa, 0x02, 0x34, 0x02, 0x36);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb6, 0x02, 0x6b, 0x02, 0xa8, 0x02, 0xd0, 0x03,
+				     0x03, 0x03, 0x21, 0x03, 0x4d, 0x03, 0x5b, 0x03, 0x6b);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb7, 0x03, 0x7e, 0x03, 0x94, 0x03, 0xac, 0x03,
+				     0xc8, 0x03, 0xec, 0x03, 0xfe, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb8, 0x00, 0x00, 0x00, 0x1b, 0x00, 0x51, 0x00,
+				     0x72, 0x00, 0x92, 0x00, 0xa8, 0x00, 0xbf, 0x00, 0xd1);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb9, 0x00, 0xe2, 0x01, 0x18, 0x01, 0x42, 0x01,
+				     0x81, 0x01, 0xaf, 0x01, 0xf5, 0x02, 0x2f, 0x02, 0x31);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xba, 0x02, 0x68, 0x02, 0xa6, 0x02, 0xcd, 0x03,
+				     0x01, 0x03, 0x1f, 0x03, 0x4a, 0x03, 0x59, 0x03, 0x6a);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xbb, 0x03, 0x7d, 0x03, 0x93, 0x03, 0xab, 0x03,
+				     0xc8, 0x03, 0xec, 0x03, 0xfe, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xff, 0x2c);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xfb, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x61, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x62, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x7e, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x6a, 0x14);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x6b, 0x36);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x6c, 0x36);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x6d, 0x36);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x53, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x54, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x55, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x56, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x58, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x59, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xff, 0xf0);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xfb, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x5a, 0x00);
+
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xff, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xfb, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x51, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x53, 0x24);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x55, 0x01);
+
+	return ctx.accum_err;
 }
 
 static int nt36672e_power_on(struct nt36672e_panel *ctx)
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


