Return-Path: <linux-kernel+bounces-532001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7090CA447CB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CEBB86759C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBD7199E8D;
	Tue, 25 Feb 2025 17:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="AhqIDzWN"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7576F1624D1
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503350; cv=none; b=GzieKxiY9IuleDAlkE7uySoMG9Bd847Yieval58vxHvJ8bBQc8vvlBl/JJ8Z3NflRuI7VK+K9u5PXSGzgxYBcdFefIRrSEhBihZ9VzH2rNQYjqv9TBhek/3eKbNjMUGWkJKi8C1IY+NIHA0UAbRZFGMm5804YkKJbeBVdNTIq5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503350; c=relaxed/simple;
	bh=YrCbpp9TYHBD/VlN2lOwxwORNWzE7tZi9l8Lic7j8D0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HmPY5rMk350IkwqLocKJCRw2KVm9lSkr2NwpKTd8NV7d06sFmMkWDGD6tQAmZy8uXzG44FwH7yo/mEKTbXFTVMVGSPPN0VtYxA4YLGYcGqP83KiK7zUjRW38i9uOARvSrf+Bw/SwFGvMySXKI8k2c/nGcG+JedqVEMH4YzNy14o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=AhqIDzWN; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1740503338;
	bh=YrCbpp9TYHBD/VlN2lOwxwORNWzE7tZi9l8Lic7j8D0=;
	h=From:Date:Subject:To:Cc:From;
	b=AhqIDzWNcEBLy3ruKtkqlFI1o3LzuNe+nSNoL21nlWcAM8hVwoHuX94mQIKR/3inp
	 AHSIGfuECFCSgtYLICGektJmr/YbuZQh+ho9zUzJ+602uamIt4I9bg6/B7v3wgNuy1
	 ir0nNldGQAyuowqjhGrOlcpScvreureboVi5y2IU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 25 Feb 2025 18:00:47 +0100
Subject: [PATCH v2] posix-clock: Remove duplicate ioctl handler
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250225-posix-clock-compat-cleanup-v2-1-30de86457a2b@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAD73vWcC/42OsQ6CMBRFf4V0tqYtIaCT/2EYSnnYF7WtfQUxh
 H+34uDqeM5wz10YQUQgdiwWFmFCQu8yqF3BjNXuAhz7zEwJVQmpKh484czNzZsrN/4edMoA2o2
 BG9U1vdAw6FKyPBAiDDhv4+f2yxEeY26kn7RIycfXdmCSH/tXa5JcctN0Yijr+iCq7vQEJCJjR
 7t3kFi7rusbb3/tDd4AAAA=
X-Change-ID: 20250125-posix-clock-compat-cleanup-c2b8d0aefa31
To: Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, 
 Richard Cochran <richardcochran@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
 Cyrill Gorcunov <gorcunov@gmail.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740502903; l=2228;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=YrCbpp9TYHBD/VlN2lOwxwORNWzE7tZi9l8Lic7j8D0=;
 b=B7ifjwp01FUhVa1iMSEWrf0leIwjQxFonpTFA27al0RX1RAYgy6uZE9NEPxRJXzXXRrfp943Z
 HtvTp6dRfu5A+h23sGl2CsRa0O0DkPATe3tywv7Kr4Ja+0VIt6JnSv0
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The normal and compat ioctl handlers are identical,
which is fine as compat ioctls are detected and handled dynamically
inside the underlying clock implementation.
The duplicate definition however is unnecessary.

Just reuse the regular ioctl handler also for compat ioctls.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
---
Changes in v2:
- Drop #ifdef and move .compat_ioctl next to .unlocked_ioctl
- Pick up review tag
- Rebase onto latest mainline
- Link to v1: https://lore.kernel.org/r/20250125-posix-clock-compat-cleanup-v1-1-c8b0f377905b@weissschuh.net
---
 kernel/time/posix-clock.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/kernel/time/posix-clock.c b/kernel/time/posix-clock.c
index 1af0bb2cc45c0aab843f77eb156992de469c8fb9..7f4e4fb7381ef05e5f4766181abd0a9887f53c19 100644
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -90,26 +90,6 @@ static long posix_clock_ioctl(struct file *fp,
 	return err;
 }
 
-#ifdef CONFIG_COMPAT
-static long posix_clock_compat_ioctl(struct file *fp,
-				     unsigned int cmd, unsigned long arg)
-{
-	struct posix_clock_context *pccontext = fp->private_data;
-	struct posix_clock *clk = get_posix_clock(fp);
-	int err = -ENOTTY;
-
-	if (!clk)
-		return -ENODEV;
-
-	if (clk->ops.ioctl)
-		err = clk->ops.ioctl(pccontext, cmd, arg);
-
-	put_posix_clock(clk);
-
-	return err;
-}
-#endif
-
 static int posix_clock_open(struct inode *inode, struct file *fp)
 {
 	int err;
@@ -171,11 +151,9 @@ static const struct file_operations posix_clock_file_operations = {
 	.read		= posix_clock_read,
 	.poll		= posix_clock_poll,
 	.unlocked_ioctl	= posix_clock_ioctl,
+	.compat_ioctl	= posix_clock_ioctl,
 	.open		= posix_clock_open,
 	.release	= posix_clock_release,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl	= posix_clock_compat_ioctl,
-#endif
 };
 
 int posix_clock_register(struct posix_clock *clk, struct device *dev)

---
base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
change-id: 20250125-posix-clock-compat-cleanup-c2b8d0aefa31

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


