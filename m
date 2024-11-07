Return-Path: <linux-kernel+bounces-399786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC1F9C0431
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239901F23505
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60ED820C491;
	Thu,  7 Nov 2024 11:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kn9VKanB"
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEB820ADE3;
	Thu,  7 Nov 2024 11:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730979345; cv=none; b=UtJOTWKm0vGExTTpBNsX/Cn1Th3cdix7QzTLlN6SSn/YXpziL4ji0wZYpdGDAl8PhVbfyjjcl9nRncBtjKodGDdR4MhUdrxxWBdu4VFS5SNg4RsvGNzw2LYMrxIB82ouVliHFjIgU5rdJXqH/PdAre7rs7jBpsEKmzBPd/KWSXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730979345; c=relaxed/simple;
	bh=iwb6A/WrE2ZrNOlT8qvszwX1KjXS1iW3wO4bT9b6iKE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lf+8YMiblYL5x5qxdGSFZskaKIICvmmJkKCdLw68jLOf9seqWN90ZapsMP2MEhQ2A+p8l8xZ3wZhWkIY7IfvLLaZQQ8kf5nQ42ZuODr0yqv7+qqGUaLICu0ie4iky78Yw3dsskVeYfHrvaK1O4cHO5W/iMVpaK9Cy8Yn5npjn1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kn9VKanB; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-7ed9c16f687so616580a12.0;
        Thu, 07 Nov 2024 03:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730979343; x=1731584143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UFllrcNplJfXvc3JYxfFMjq1JjZGEEGxP3YevvvzffE=;
        b=Kn9VKanBrDF7E9azGLiUaGOb4oFmDH9VmVuc5PZiLCYl7fvEgZdIc5B5I9pFf4SEfE
         DErRjchymm3J1x/yHO/jfWz7XI7DT4wOAgqqGPDrFx3uFHvrFsmJqwuC/2l6TSj+OQ5W
         RM6Kr4BBuqqJ/blUNAjWLqsvZhI0L3rgWckNpHKM14X2CaOckql5KDHgUwIrsgUQpG/c
         LgqjebESXlP1hMRjAq74NolwxI3znY6a/hKTf6Qg6HIVgmrQsJn2Y65RKJmkKGuODgYW
         e5xk5OPQ+hMTZ63AFKHbxfE3AmdtER6kZDE2KDAHYhdKh3SMLYpABxdyv0KExh6KukVb
         JwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730979343; x=1731584143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UFllrcNplJfXvc3JYxfFMjq1JjZGEEGxP3YevvvzffE=;
        b=a9NChBqEIlkMzpr0A9MX6uAfTjig0AZnBBJQJQDUNXGetSV4ma8gRDWYrnW1OAjhsL
         p9xBtVwOS15wYRJvlAy0c0U91Lpdn0qfSGS07gMYJMuRcC1wq0KOBWkaGpO+CLc7M0gR
         EyAE6wJsjjgHbKKjUkiGdjU4JA8jqNIfI4kbxG69mZg2cublCXnzgBWSy92w8EVCLFIO
         0NtH0NB7wGA7Y9v56qFeM6a0ZopiR/z1oavE0Wzj4Pfa+1I5JJxXp6VnIlricsP4gNWq
         RUuavMePehgVPu5Ez119gqM4HUl4laCZkV2TfcqWZDsPe2ooRSWgOIT90I8mRaQm9N9Y
         dkFw==
X-Forwarded-Encrypted: i=1; AJvYcCWk5r/UCvqnTCsjhiw7s2eSZiJZUXMFnvVaPXA22j7uDeXuSApGdOJZQciC8VsEDzXgd+SYBsjjFg1DZ6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO8pOsjV8WZnMTpzLWnMwzwjvaQbYnmsP7hgLq0n3HegNHayUI
	HplcpeKoPj1MxSMKaezZPUUpkKH2zhx6IW+DK/Lg4n0fPN7LH2Vqrb+64aej9zpCWQ==
X-Google-Smtp-Source: AGHT+IHVQckpKKeRxWwlO06HnNLKcQJcOgeNJfUh49nxpk7hi5cfeokkoR7BCZsoz2H8+b6ACDpG9g==
X-Received: by 2002:a05:6a20:244a:b0:1db:e82f:36e4 with SMTP id adf61e73a8af0-1dc17ae102bmr1017797637.22.1730979342997;
        Thu, 07 Nov 2024 03:35:42 -0800 (PST)
Received: from tom-QiTianM540-A739.. ([106.39.42.118])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a541cfbsm3257801a91.18.2024.11.07.03.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 03:35:42 -0800 (PST)
From: Qiu-ji Chen <chenqiuji666@gmail.com>
To: johan@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Qiu-ji Chen <chenqiuji666@gmail.com>
Subject: [PATCH v2] USB: serial: ftdi_sio: Fix atomicity violation in get_serial_info()
Date: Thu,  7 Nov 2024 19:35:34 +0800
Message-Id: <20241107113534.402265-1-chenqiuji666@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Our static checker found a bug where set_serial_info() uses a mutex, but
get_serial_info() does not. Fortunately, the impact of this is relatively
minor. It doesn't cause a crash or any other serious issues. However, if a
race condition occurs between set_serial_info() and get_serial_info(),
there is a chance that the data returned by get_serial_info() will be
inconsistent.

Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
Fixes: 3ae36bed3a93 ("fdti_sio: switch to ->[sg]et_serial()")
---
Similar issues have been submitted or confirmed: 
https://lore.kernel.org/all/20241002125845.785464707@linuxfoundation.org/ 
https://lore.kernel.org/all/20241106095819.15194-1-chenqiuji666@gmail.com/
---
V2:
Revised the description, placed the reference link below "---".
Used the correct patch prefix.
Thanks Johan Hovold for helpful suggestion.
---
 drivers/usb/serial/ftdi_sio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index c6f17d732b95..e07c5e3eb18c 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1443,9 +1443,11 @@ static void get_serial_info(struct tty_struct *tty, struct serial_struct *ss)
 	struct usb_serial_port *port = tty->driver_data;
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
 
+	mutex_lock(&priv->cfg_lock);
 	ss->flags = priv->flags;
 	ss->baud_base = priv->baud_base;
 	ss->custom_divisor = priv->custom_divisor;
+	mutex_unlock(&priv->cfg_lock);
 }
 
 static int set_serial_info(struct tty_struct *tty, struct serial_struct *ss)
-- 
2.34.1


