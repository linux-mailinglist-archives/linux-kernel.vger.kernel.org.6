Return-Path: <linux-kernel+bounces-431568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7949E3F09
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F9FB1697B6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DDF2144D7;
	Wed,  4 Dec 2024 15:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ESSoFeqg"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376122144B6
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 15:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733327900; cv=none; b=MdrAfaUiQUKt5FM0RfjhHHVuJ8dahoJgL7KetpOmI5qdcEHzO34mpvDl7QBd6biXi+cOVlF9cBcNJ0SJNx52vqBvq47WQglA2OIOFfTyORTl3LiHJAsTMLQItZhamssPibTRFg3V+2LomYONIxezWbpLclDEwslKi5fsOvXUo3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733327900; c=relaxed/simple;
	bh=vd24ELPUpzIEthODLFQ5qLWi9e3qKvukCK4lkf0j1CA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pyPgbRS5rLyCH5k0CiM3Wwv0WU9lEClalWPxD3a74Z98ZHmU7ME2NTtYvW9PMP+uEalFCRdVR52Tlh57qaHTPGJNKoRtN805IusW47Z1WfuT5gMKBgmB8Ticr6WIMALZkX5JyYsPrBXP8DXYItQngfrmHrOXjpz6fM3bQf8ovzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ESSoFeqg; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4349e4e252dso64926555e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 07:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733327897; x=1733932697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YI/FcgkOifwXXzXlvk8zo5YFKecagbmROLu06ZFniA0=;
        b=ESSoFeqgAkRcjblLHxccnALnvO5s38lf9FD0kZkU+b5gom6Rt3ekj1uZHNpyf1eJUn
         ycfokj0PQ9TKic9L7JNu9vIZWevcIxJe6L2XHCzvBJtxTk+3XNBERDmrRObL9rAVKyK3
         jqdRsmJ/cOuXrn2QlwpHPZnvKnlYzwMNhbL0ysUOBtIn2sFZAtn9KaLzNtmyO30ERFqU
         Ma1rM/JWZkL6XgY+ocSkMMdeXFzmkIiibxO1JUT1bvetJaczP8jw0Dr7e2zWmge8IpmY
         W8PG0t4FaV81W/RwsZUHVv1HoExjum8ND+0Qx3shNXKhTGNK/tBQLacc6szeTRwMqP1R
         R9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733327897; x=1733932697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YI/FcgkOifwXXzXlvk8zo5YFKecagbmROLu06ZFniA0=;
        b=d318KgHUllY6Uk32IvxhPntEQHrVpcoKcVCcoEW6qVkYv/33URbJdzdMdhv7e5dtLo
         fwfWnRfxqIHr1g9euR3dKYkM48/U+BhOHAANtzKUEtKJ9hyEHl5sKc8FdiVfLz4hWfyB
         whK2TwpevUnnI4BvJl3INl+lU02+9SnigeQVAnCirgtwG/1kJ8p+5onmpfbOi/wplSDT
         JnaS5hE928Z09A7gM2qfCplhD3D8zQUGSKtoZrh9+Qc1Ne+3ZnDKqZs/sEw5zZ0ZucT5
         +O7zhK+5IWjiDSs86zHZOWQhXNwgI0B4cQzUgxOQdrVfpoUFdu+qQvT8ytMrc0NtQHUc
         wbHw==
X-Forwarded-Encrypted: i=1; AJvYcCX3/2dfhDkp9tATS/a5Fb/BDSar3/4ifN+kAWrLHmEmId1YQqEnyMGxzl8mMsrp0xoCe145s+M3hv8icK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKi5qgDRXGyVP+Z0bwpx+/0Q2EaOc8cqie6WdGsxkXkoxI1s14
	p8ht8SF03yX4UTLplMz5iUhfORqDuLRO2s9WhHsLM/aCn4rGpYKY+T2XaN2nwyY=
X-Gm-Gg: ASbGncvxZvZylkhQ0dCFztxweS1qc8lOHME0DkpRgguPSr1RugbXuG11JTmM1nEFpDv
	drDzF+qZfy58xwzdCH/uGvBHJJqQSFfRHlrPa7TYNppiJqaBxNgv8uI/5FYkcSoEHebKHSF1c0R
	aeV+WwoJ60vv1UkijxhzGvaf9YcK3FgPnmp4sFjXuw2ZJMgbofk3Bkd8mSHBYFIikL195Woflze
	wLvIQ4ZYAdxXs0G3zWmxKPSwPFNOSazrmuxFPzesvqZw9uOGw2BwPZQW91F7adEkZ7VPVJiAPe9
	Wr6v
X-Google-Smtp-Source: AGHT+IGPLwKQh57Ead8RRrh1gxEVt29W9QxQJZdC/e01yLZTzadTaRF9r6H13On42Alm4HnNGJ6b+A==
X-Received: by 2002:a05:600c:19d1:b0:434:a765:7f9c with SMTP id 5b1f17b1804b1-434d09acf91mr62725955e9.6.1733327897506;
        Wed, 04 Dec 2024 07:58:17 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52b5677sm29043695e9.37.2024.12.04.07.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 07:58:16 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	wsa+renesas@sang-engineering.com,
	geert+renesas@glider.be,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	lethal@linux-sh.org,
	g.liakhovetski@gmx.de,
	groeck@chromium.org,
	mka@chromium.org,
	ulrich.hecht+renesas@gmail.com,
	ysato@users.sourceforge.jp
Cc: claudiu.beznea@tuxon.dev,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH RFT 2/6] serial: sh-sci: Drop __initdata macro for port_cfg
Date: Wed,  4 Dec 2024 17:58:02 +0200
Message-Id: <20241204155806.3781200-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241204155806.3781200-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241204155806.3781200-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The port_cfg object is used by serial_console_write(), which serves as
the write function for the earlycon device. Marking port_cfg as __initdata
causes it to be freed after kernel initialization, resulting in earlycon
becoming unavailable thereafter. Remove the __initdata macro from port_cfg
to resolve this issue.

Fixes: dd076cffb8cd ("serial: sh-sci: Fix init data attribute for struct 'port_cfg'")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 924b803af440..4f5da3254420 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3562,7 +3562,7 @@ sh_early_platform_init_buffer("earlyprintk", &sci_driver,
 			   early_serial_buf, ARRAY_SIZE(early_serial_buf));
 #endif
 #ifdef CONFIG_SERIAL_SH_SCI_EARLYCON
-static struct plat_sci_port port_cfg __initdata;
+static struct plat_sci_port port_cfg;
 
 static int __init early_console_setup(struct earlycon_device *device,
 				      int type)
-- 
2.39.2


