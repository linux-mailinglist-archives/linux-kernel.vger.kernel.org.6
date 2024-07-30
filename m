Return-Path: <linux-kernel+bounces-267573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF249412FE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 856861F24AD1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA12919EED5;
	Tue, 30 Jul 2024 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZHB1rTm"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D40018FC6E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722345631; cv=none; b=OwVR+u//imNx9zWXeNVy/SzFsEpaunkHAmQHqE6k0xVo7jFiIcKtf43kQXQyzbjn4S3/WplHmAjLek/vr76uY+9Ll6Zcftd5MOYm/qpifbUExGnAGDIQqpUMVqrQlFMgoFH5Y2myLBuMNwZNlwvvenaaC5iYgaueITsinksxUqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722345631; c=relaxed/simple;
	bh=gULpf+gF1m2QdadUi3voJli1/0nTCTahNBYIJmG9XHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uqzfoY4rCsnzGh1pAtP6ApGFAd/+sNMjONpgpa1NNiHMkss9rdrdHW3o41728N6tg1+AKnrogneet+4RkIQxCF7CTBlc7LpgPlFQtbmy5pCpJvh6td6E79efwGRz3A4G56MfR174UzP7NEFfbIxQt6FYXy4HhJNDP6jExtbdcx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZHB1rTm; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ef2fccca2cso56645671fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 06:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722345627; x=1722950427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S4IXsmWzQmiY0ZnXZ1hr9OrKYGq/IGYbRucIt4C7Z0U=;
        b=OZHB1rTmnRwyHAFD46V6Vucrt5Ajv3Czkqwv0a6AUeZV9QU94gcth8r3EGyS8eJd3U
         EsPdVpyWmWB2tba5MAqqbVd0cigzAcCym7AjP8+/rRhvlg4WURKFuMxdXsleke10CzYU
         bajZstS0goYH+pLZDdeF4I8xp7YBFrwC7GbJELgSvAgU8ruNIG8UHHUFCNVLOHKSL5XJ
         xETsPLZ2GHC0BF1e7ZOPebUjRtX38o1OFWONN99dbpmP5bwOlOXcgcMtCpHmm4Wb/KpD
         ZP3EGIYbnPWOAl1zzgbybw+bvu1Txv7wNUGa2XWmay8gkGQk3+rOwOlgarWFXp29qypM
         7LMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722345627; x=1722950427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S4IXsmWzQmiY0ZnXZ1hr9OrKYGq/IGYbRucIt4C7Z0U=;
        b=pJLaDUF6wShW9bMy8HoKrDIruih8tHGcwKhzlqP7jF6OTJgu0OLfxTpx1xz1W8NwT4
         d09zTa0tGkmWMVHgsOQ3EUx5CiUE4+WRtFLECz4GKdIF+gFR/6o85HXyekOq1yRTvAui
         VuEXT+q3OnEJ6i/1IJCvnwqeadmPZyqJFSsXbayvnBFEDd7JBRPPY//iFaCFbnX0hURy
         Gzoy+K/EtioKKsffdBKqqpqoTgmnAswSSZ0nkOHifq9MLJHzfIS6GzWqBo398AVv0Y0f
         eOJH8YXHjON7hm6Te+ttfBkCRYSOE0wvbvquPum9lwCVl1GyT4BrH1PyQq2SGOeEyOqa
         OXJg==
X-Gm-Message-State: AOJu0Yzf1IOtqG9cwWLXMZAg+wmfCspZsYGpardLUw6szODNpeze8VjQ
	FoLqILyGLO6ZCAcza3k7hx1u4K4DB1N/pv88xjxbfyk6AbQYhSGMjm17nQ==
X-Google-Smtp-Source: AGHT+IH8Of0FyjoO/oEUIIulbwYI5lbJ4uKXGTQpfKstRHzbWbGj58YHwfSm+RFSLnAlG1m/t27v/g==
X-Received: by 2002:a2e:878b:0:b0:2ee:7a54:3b08 with SMTP id 38308e7fff4ca-2f12edf7f25mr72925141fa.3.1722345626856;
        Tue, 30 Jul 2024 06:20:26 -0700 (PDT)
Received: from localhost.localdomain (93-103-32-68.dynamic.t-2.net. [93.103.32.68])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63590ac3sm7230079a12.34.2024.07.30.06.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 06:20:26 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] clocksource/drivers/jcore: Use request_percpu_irq()
Date: Tue, 30 Jul 2024 15:20:00 +0200
Message-ID: <20240730132015.8920-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use request_percpu_irq() instead of request_irq() to solve
the following sparse warning:

jcore-pit.c:173:40: warning: incorrect type in argument 5 (different address spaces)
jcore-pit.c:173:40:    expected void *dev
jcore-pit.c:173:40:    got struct jcore_pit [noderef] __percpu *static [assigned] [toplevel] jcore_pit_percpu

Compile tested only.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/clocksource/jcore-pit.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/jcore-pit.c b/drivers/clocksource/jcore-pit.c
index a4a991101fa3..5b79347ce6d5 100644
--- a/drivers/clocksource/jcore-pit.c
+++ b/drivers/clocksource/jcore-pit.c
@@ -168,9 +168,8 @@ static int __init jcore_pit_init(struct device_node *node)
 		return -ENOMEM;
 	}
 
-	err = request_irq(pit_irq, jcore_timer_interrupt,
-			  IRQF_TIMER | IRQF_PERCPU,
-			  "jcore_pit", jcore_pit_percpu);
+	err = request_percpu_irq(pit_irq, jcore_timer_interrupt,
+				 "jcore_pit", jcore_pit_percpu);
 	if (err) {
 		pr_err("pit irq request failed: %d\n", err);
 		free_percpu(jcore_pit_percpu);
-- 
2.45.2


