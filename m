Return-Path: <linux-kernel+bounces-512860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E52EA33E83
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D425A3A6035
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B195D21D3D9;
	Thu, 13 Feb 2025 11:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CcjZU7OP"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107D5214A62
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739447736; cv=none; b=aB/r/TNxsLy27iaUdvWEwuZi2WiAQ2n7D2sVWM9Wpye6V+Gsj3+TdE3OCFjT8xnAUQBxb6fy/a6ZIhnNMawv5yx5JhxujYsyPaq3s5VuDDeExoI2abyCN9AFL+hnbaWgf27KRE8oYhsCJauG21TB03CmdprGcQqbOTHkzqUoIeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739447736; c=relaxed/simple;
	bh=C1OI5EFaptGAyIC31Qyp31hhbpiPg9O9Rv2rGr/QaG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qheGo0EKQNWbBb2seoSz+GTA9GDst6xYeRZ8iN7bGJ4m57gv7BdmXvH4i88yQitsOsAZPpNEQJAfyOjBTBlO8gm7f89HF0VfRlR/L5vtM+Gp75RxGV6HRTARnGMM/YhmOQgGebVBvYIHafWTDj7wXNzSBfd9Oc2aXenUbKRlnn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CcjZU7OP; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f26a82d1dso249760f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 03:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739447730; x=1740052530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VTfLFSL7H02DDwltR23No4VBBkNnVp9ZJzpNJFBZ+M4=;
        b=CcjZU7OPSl4exRHaNIuSrWya2bwiHFLbxjPH9dgbhkeZMRf7yq7n2oYN6BzVtnzy89
         JQrEC2D4pygYoQEE2VRVtYV0rk7D2qRT9HvY4gIHqmSQvLctUQjYggoAcdFvcsOo5nIp
         KPzy0VqnH0gjLaGklPH4+NjOAv82VmePpyUrBRBeTOFfUjksNqRHTe9yRkgWuA3SbQUK
         0hqdrsboJVbKcK6LptbpKeITw/vfUsjfdQVnR/qyojQw6uFyCCWoN3DIi+GWqD1B+Vfu
         LgAFZkcf4YPRsJd2nhq+WPxLVad5m4uRrWOSDGIY+Zb6Uf0Ym9HvONbf2JIv8wCfDiW2
         S5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739447730; x=1740052530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VTfLFSL7H02DDwltR23No4VBBkNnVp9ZJzpNJFBZ+M4=;
        b=L4MNbqM0OEEDU6g5UN5Ziw6V66HvAbgUSybhq1Wk0AcJwUjNPeu0LydERKHk1Y4m8Y
         XD5tWdFhoNUO9AMFLTCICY/tR0IE38PlM/xBhkNr8uvfztXk9p7p1+Tcg5jQe3agBVA2
         CyE2Lx2WsbC+z8B8gE3U2CEE6LejKDmrtV44TS1XQl6ghgekFFoiuUAvjW7Ey61wEv7v
         mHGdXJxCptNOT2PIHtdT3IgS7J9Xc421e4dCQzf5U6PyvJYJf4o+nUE9i7XjERmQB7+Y
         QZP0gclRUDSmInSlVyT7eEStg8+VJQLQPXIvwpw/w5addfKedybRdfrmD8V7P0M8Z0zW
         kwvA==
X-Forwarded-Encrypted: i=1; AJvYcCW5gbkHUnX5bVpADk7jFIYEaNv+nUH8xq1MCrwy6USo+v0zfgY/XwPfXmVGHcEMLrkIc4zpq3lSk9N1Gnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZGKNRkW+XrMA4zlb7Owr/NeHE6F00+eQb7V7Qz/LeP+KIlRNC
	8oHIEq1SpFlY6ldJDAZlahqfU4nv8/TtYdlZ14s4l/RQ98n8JmAg85xmG8Xu/+QCXfZ1Wkfdff9
	mY7g=
X-Gm-Gg: ASbGncuDfz9GN+/fRb3hsMilDUODg4R1TOavTKh0oR/b8latLK+uFDU2HQd7yb+mpse
	lmVuVIRVrLRrmqcPFGbVbxpNp7NtTn+Bw/QaCZ0eUi+QlT7v53ud9o70dAalP1gGKQb01KfHn6x
	RRJOue0+dPtY3eUHA3o0YwBgKq2NRAu7IzqyIQcW+7mzhMcIuFZ8930he5VGiBxEWXWYFgngQm4
	13lV7BkW1KjgwIJ+CUB+5m0JfEkFvRdYTFW+4oGvTssNcQYi/rwYewBPojiUZd6CBPLfFFKEKDu
	hwEkEauHYwrHXb8hB411QSZsYpRiKPWfHCsoNebx81QoYr0FOjau2mMZiQ==
X-Google-Smtp-Source: AGHT+IEQscap/b+OG/JXpDEd/gOofqnnclTalVfCJDzbZNCEN8OOVDRJVyYP2FSB0UDfTZafXUOxjQ==
X-Received: by 2002:a5d:5a0c:0:b0:38e:fab2:60d7 with SMTP id ffacd0b85a97d-38f244f9e11mr2676566f8f.29.1739447730235;
        Thu, 13 Feb 2025 03:55:30 -0800 (PST)
Received: from localhost (p200300f65f083b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f08:3b04::1b9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5d8bsm1666095f8f.70.2025.02.13.03.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 03:55:29 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Amit Shah <amit@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] virtio: console: Prepare for making REMOTEPROC modular
Date: Thu, 13 Feb 2025 12:55:17 +0100
Message-ID: <20250213115517.82975-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1812; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=C1OI5EFaptGAyIC31Qyp31hhbpiPg9O9Rv2rGr/QaG0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnrd2ljEeV1wUlG2Gq7g9rttq8V5T09HYkMOpTW LQG6NzlpriJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ63dpQAKCRCPgPtYfRL+ TlBGCACANwC/3+znCE5Yu7G6KJc3XUvL7o4bnojWvcKBTl4v41VWAzoVkJUy+YQLAIka7E8g9No +eBQxSXBmfd5cKRz2KzOWh69bdzW1q3Z/B10YTb2Ohh/Lv0dUjDrv6GAJMGbR5gRDoLPnFL6Qfc 2UD2gYVD6OgBKiE1rwL3v8qb6xtjFi2U+rmzesFKVA8d1Eftmb9STQYneE7JEnFdzyoYiW0yeJK MJ+xG49BtYdKMMNudVfhB2sVNkET4Ug4aLQ18jme8hxyDatazvFyHQ7+HjGT30e/gpNAovetwXC kqssV0zcI/WoUc3V/ZbhtS5Nxj6ziVw/OkSMLDYF/tPWxiIR
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

virtio_console.c can make use of REMOTEPROC. Therefore it has several
tests evaluating

	IS_ENABLED(CONFIG_REMOTEPROC)

. This currently only does the right thing because CONFIG_REMOTEPROC
cannot be modular. Otherwise the configuration

	CONFIG_REMOTEPROC=m
	CONFIG_VIRTIO_CONSOLE=y

would result in a build failure because then
IS_ENABLED(CONFIG_REMOTEPROC) evaluates to true but still the built-in
virtio_console.o must not use symbols from the remoteproc module.

To prepare for making REMOTEPROC modular change the tests to use
IS_REACHABLE() instead of IS_ENABLED() which copes correctly for the
above case as it evaluates to false then.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

I didn't check what else needs to be done to make CONFIG_REMOTEPROC
tristate but even if it stays a bool using IS_REACHABLE() is still the
better choice.

Best regards
Uwe

 drivers/char/virtio_console.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 24442485e73e..7d7463d6f218 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -28,7 +28,7 @@
 #include <linux/dma-mapping.h>
 #include "../tty/hvc/hvc_console.h"
 
-#define is_rproc_enabled IS_ENABLED(CONFIG_REMOTEPROC)
+#define is_rproc_enabled IS_REACHABLE(CONFIG_REMOTEPROC)
 #define VIRTCONS_MAX_PORTS 0x8000
 
 /*
@@ -2078,7 +2078,7 @@ static const unsigned int features[] = {
 };
 
 static const struct virtio_device_id rproc_serial_id_table[] = {
-#if IS_ENABLED(CONFIG_REMOTEPROC)
+#if IS_REACHABLE(CONFIG_REMOTEPROC)
 	{ VIRTIO_ID_RPROC_SERIAL, VIRTIO_DEV_ANY_ID },
 #endif
 	{ 0 },

base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
-- 
2.47.1


