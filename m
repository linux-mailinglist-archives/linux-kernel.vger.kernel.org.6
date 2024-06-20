Return-Path: <linux-kernel+bounces-223323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAC9911109
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FE3D1C21B28
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619A51BD026;
	Thu, 20 Jun 2024 18:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="icgdqprh"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD99C1BA87F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 18:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718907954; cv=none; b=eK0NcGpt8VqOz2AnrgrfBCbYs9eHWtBMm9QjboUMXe6xUTobh6joexGE9wyskRI4FZVILMOWZpuhKgj5wFrvEJ25HqFih38johZRlzI6UKRBn05MjilquTcY+STRB/HIJlaYZwjrKXGEdCoVBKUFNIHgVgeO1X10oxdqU4WX9k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718907954; c=relaxed/simple;
	bh=iq1Blr7ULBbvGnmCSYXUoa973pp5SZ0pglfYuKy8orI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G3QkFuod+4Eo8fCmVpKN0LZw8HDbQBayUPuzeq9MIcXrE7PTt8OUMHiTvvGMI9EjyZjKozxkTTAp7rvCkSpjlSBDHWz2smEeVURPnsbelh22PlSPM2GzXK3laWMZcVmu9IOQ61wytruYUzBqpmDvH7qgAYXIlQ57GvycUNc4qTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=icgdqprh; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=xu9VOzRmG/Ukvn
	DAdBmyNxlTOb4JvVACGdu9+nf9yM0=; b=icgdqprhF8MN5jUYmbIwlIO9d9kwyJ
	JJiYUdhhs74r8S+vkN9vt5btRfPM5uxPlo81RWKGd7PBu4MvVyzeKKDz/xB5+OZr
	FdvIChy19OUzjtRSb7g2vmPZuOcfwNdkS2nRYTYecMeep3PjFJ+eJx/lD3Z2Subx
	VooeZJ1O6SpQdtUVdq49ccHDg7ygwGEsum05ptBCkv70fwvsG2H+I7o9iRe5RS40
	gncNWR31w5NUQDkr6MFIEkxCpe52jlZ9nKJRIS1NYda097GnPyzNQoGbLuAKaD+P
	BqS9pXs//rAuQpqEaXLPFmb9qeVWYf2nK+jqdzvHjIN2pFCkH2RHTitw==
Received: (qmail 1109850 invoked from network); 20 Jun 2024 20:25:44 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Jun 2024 20:25:44 +0200
X-UD-Smtp-Session: l3s3148p1@I+VvcVYbgrhehh9j
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	linux-staging@lists.linux.dev,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] staging: vc04_services: use 'time_left' variable with wait_for_completion_timeout()
Date: Thu, 20 Jun 2024 20:25:38 +0200
Message-ID: <20240620182538.5497-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a confusing pattern in the kernel to use a variable named
'timeout' to store the result of wait_for_completion_timeout() causing
patterns like:

        timeout = wait_for_completion_timeout(...)
        if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make the
code self explaining.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 .../staging/vc04_services/bcm2835-camera/bcm2835-camera.c | 8 ++++----
 drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c     | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index b3599ec6293a..deec33f63bcf 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -591,7 +591,7 @@ static int start_streaming(struct vb2_queue *vq, unsigned int count)
 static void stop_streaming(struct vb2_queue *vq)
 {
 	int ret;
-	unsigned long timeout;
+	unsigned long time_left;
 	struct bcm2835_mmal_dev *dev = vb2_get_drv_priv(vq);
 	struct vchiq_mmal_port *port = dev->capture.port;
 
@@ -636,9 +636,9 @@ static void stop_streaming(struct vb2_queue *vq)
 		v4l2_dbg(1, bcm2835_v4l2_debug, &dev->v4l2_dev,
 			 "%s: Waiting for buffers to be returned - %d outstanding\n",
 			 __func__, atomic_read(&port->buffers_with_vpu));
-		timeout = wait_for_completion_timeout(&dev->capture.frame_cmplt,
-						      HZ);
-		if (timeout == 0) {
+		time_left = wait_for_completion_timeout(&dev->capture.frame_cmplt,
+							HZ);
+		if (time_left == 0) {
 			v4l2_err(&dev->v4l2_dev, "%s: Timeout waiting for buffers to be returned - %d outstanding\n",
 				 __func__,
 				 atomic_read(&port->buffers_with_vpu));
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index fca920d41e4f..67489c334f7b 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -655,7 +655,7 @@ static int send_synchronous_mmal_msg(struct vchiq_mmal_instance *instance,
 {
 	struct mmal_msg_context *msg_context;
 	int ret;
-	unsigned long timeout;
+	unsigned long time_left;
 
 	/* payload size must not cause message to exceed max size */
 	if (payload_len >
@@ -693,9 +693,9 @@ static int send_synchronous_mmal_msg(struct vchiq_mmal_instance *instance,
 		return ret;
 	}
 
-	timeout = wait_for_completion_timeout(&msg_context->u.sync.cmplt,
-					      SYNC_MSG_TIMEOUT * HZ);
-	if (timeout == 0) {
+	time_left = wait_for_completion_timeout(&msg_context->u.sync.cmplt,
+						SYNC_MSG_TIMEOUT * HZ);
+	if (time_left == 0) {
 		pr_err("timed out waiting for sync completion\n");
 		ret = -ETIME;
 		/* todo: what happens if the message arrives after aborting */
-- 
2.43.0


