Return-Path: <linux-kernel+bounces-406319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 274549C5D54
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABB031F23E06
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F32206959;
	Tue, 12 Nov 2024 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gr73Kc66"
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAF820607F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 16:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731429052; cv=none; b=EffwogONcIvnlZjeEmbZHcJftDpyGH9ndIRGA+4OemYbZWlOxQsW/GaDS3mCiqaQGcVTbkGNX3ij1mSdGdbFNv9BGvsR95j0sgMv57YoW90D7rcTifSkAkqcJVbUu/uZCaIVvfBlgVs86bHqqcxEa8qjKpnEAEFAk3ccljsrgKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731429052; c=relaxed/simple;
	bh=v8ko9JaztVPlbkWrcr3SU0tMhQVGITUdbzLk8tRSvPc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oth4R9Is2TIm1MdFQyWejbRegB4ONj55famVdncVUvn38/uYl3LCKfA6qb6MSwfAcKqS9ngtGhNzZA9Lt3DAE+2eo2AowjGwRLBh1lzFVt/G3HIr7TE/gZwghZAOZivoqvcEJj0aRH4x9NlOh1k5NxPM+NkQbPChOm9PkE+0Eoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gr73Kc66; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-2e5a0177531so4610949a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 08:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731429050; x=1732033850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E0vwOlu6EICHjuPjA2ZrbcHRPRn9Ev+TiEGJ34TFTEU=;
        b=Gr73Kc66fvW9dSjZn6MnkgMYZqIs+2mYtvMPEWsd7vUJK0Eix1SFG3MS8wYBr4sp5Z
         /x8ZNqlvjFNgsSOh4uR3zarXXcgxXaqj3nho29HA8ut/dNaN+iE3w27R3HM8WvBnqIFt
         VSQbxAiPKmZR+yiaY3jU004vwpQ1NSPw4sv0y9aBRGYcRotJt0xWZjyqnvVXx8oENrOv
         kwL/FVd1+Azh39aDuAjgG7z1v2nOiXulW6W1TyDz6kmIvG/LSx/7JX6raV6ujIMaJjUu
         usSXE1wv41sWSHbpDk3x0ByQKGlUm330ILAVqr2PmxB+h5muexv9unQeUjWlOrxZiOyi
         tIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731429050; x=1732033850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E0vwOlu6EICHjuPjA2ZrbcHRPRn9Ev+TiEGJ34TFTEU=;
        b=B+rgJmDzsxU3nSd/wfUPGjysOVkGarAKnbVQrX33PVwF2VUQlBwy9QqPnWSUoavsgt
         plCGJJl2lGbbhjdrGYQpiUv0fjkkSNhtHV2eEq5Oh2wT8bD3J5yb/PsFyNjRlRRKFeaZ
         BNGY991DKHsgIXVwb9WM9WeUjqNng7O3rQYilged5a0jm9nugkHTfqafnKnaA/0nWpT9
         cbqANiJ7KR0rLS6ulo9eLGrV52u/SEn/kO8cqTyjt0vMasbbxYShh1rIYwMACGXCwTJJ
         +v46AJMCmaIcPGtcVOKCH4RvsLt/XSohX69W2QgY8WB03awiq6VixjkoJEGGQ5wgd1De
         xw1g==
X-Gm-Message-State: AOJu0YyVvo2TRvjtCBWkQrzzHSFFWcCSgDvUrzx8+yqo/mX+iql4eM8U
	gfjE6rblroXiLQy58UPdpGVu/ic8pH6BYf8B6iNmGZUhNvdMv3p2
X-Google-Smtp-Source: AGHT+IEx2rmydlzdMayzIzcxGkw3A6Q5eYxzIdmEP03OfXAXAuGlQUYuSuqrAnLLwEvFdxAY8r4wsA==
X-Received: by 2002:a17:90b:3508:b0:2e2:bd4b:ac2c with SMTP id 98e67ed59e1d1-2e9b1796289mr23147258a91.31.1731429050212;
        Tue, 12 Nov 2024 08:30:50 -0800 (PST)
Received: from tom-QiTianM540-A739.. ([124.127.236.112])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a62bd4fsm12836072a91.50.2024.11.12.08.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 08:30:49 -0800 (PST)
From: Qiu-ji Chen <chenqiuji666@gmail.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org
Cc: linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Qiu-ji Chen <chenqiuji666@gmail.com>
Subject: [PATCH] driver core: Fix concurrency issue in match driver interface.
Date: Wed, 13 Nov 2024 00:30:41 +0800
Message-Id: <20241112163041.40083-1-chenqiuji666@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch identifies a deeper issue. Taking the function
fsl_mc_bus_match() as an example, since the function is not protected by a
lock, there is a data race between fsl_mc_bus_match() and
driver_override_store(). After the check if (mc_dev->driver_override), the
driver_override field may be set to NULL, but the strcmp() function does
not perform a NULL pointer check. If a NULL driver_override field is passed
into strcmp(), it may lead to a null pointer dereference issue. We also
noticed that in the driver_override_store() function, the function
driver_set_override() is called, and this function frees the old value
after storing the new dev value. If a race occurs, a use-after-free (UAF)
issue could occur in fsl_mc_bus_match().

To fix this issue, we examined the interface that calls this function and
found that fsl_mc_bus_match() is called by the interface drv->bus->match,
which in turn is called by the function driver_match_device(). We found
three places where driver_match_device() is called, and the call in
__driver_attach() is locked. However, since the driver_override_store()
function is implemented in drivers such as amba, base, cdx, and others,
this data race issue is quite common. Adding a lock at the lower level
could conflict with the lock in __driver_attach(), leading to a potential
deadlock. Therefore, we decided to add locking to the other two calls to
driver_match_device() to ensure that when the function is called through
the match interface, dev is protected by a lock throughout the process, and
its value remains unchanged.

Fixes: 49b420a13ff9 ("driver core: check bus->match without holding device lock")
Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
---
In 2008, the kernel moved all match checks outside of the lock, and at that
time, there was no override, so this approach worked. In 2015, one function
moved the match check into the lock on one of its paths in order to support
asynchronous device binding, which led to inconsistent behavior. Later,
some kernel drivers added the driver_override feature to support binding
specific drivers, and the driver_set_override function was widely used to
control it. This function uses device_lock to control concurrency. This
issue is caused by both lower-level drivers and upper-level drivers, so
I'm not sure if the fixes tag is correct, and I haven't added a cc. I hope
to discuss this issue with the developers.
---
 drivers/base/bus.c | 16 +++++++++++-----
 drivers/base/dd.c  |  2 ++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 657c93c38b0d..78d8c58fc50c 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -261,13 +261,19 @@ static ssize_t bind_store(struct device_driver *drv, const char *buf,
 	const struct bus_type *bus = bus_get(drv->bus);
 	struct device *dev;
 	int err = -ENODEV;
+	int ret;
 
 	dev = bus_find_device_by_name(bus, NULL, buf);
-	if (dev && driver_match_device(drv, dev)) {
-		err = device_driver_attach(drv, dev);
-		if (!err) {
-			/* success */
-			err = count;
+	if (dev) {
+		device_lock(dev);
+		ret = driver_match_device(drv, dev);
+		device_unlock(dev);
+		if (ret) {
+			err = device_driver_attach(drv, dev);
+			if (!err) {
+				/* success */
+				err = count;
+			}
 		}
 	}
 	put_device(dev);
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index f0e4b4aba885..0b894719eb28 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1169,7 +1169,9 @@ static int __driver_attach(struct device *dev, void *data)
 	 * is an error.
 	 */
 
+	device_lock(dev);
 	ret = driver_match_device(drv, dev);
+	device_unlock(dev);
 	if (ret == 0) {
 		/* no match */
 		return 0;
-- 
2.34.1


