Return-Path: <linux-kernel+bounces-511205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE1EA327B2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6581D166366
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A6420E33B;
	Wed, 12 Feb 2025 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVVX4QLX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE0F205ABC;
	Wed, 12 Feb 2025 13:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739368522; cv=none; b=ZiH0lsBEyCp+VXj0a1pyfIF08jKkISGkPFCSq7/ACgLAfax7aZjDRyikp+tKPegQVmazuMMSWbh744lG/+2tcV3/5E/7FGKHGS4rDg1RxgwH4+4HeuTDjkUAbGij0Ugwnmf6E4k+0a0y+XV1O1Tm92hsuMGTt6LU7qIf5+iZqPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739368522; c=relaxed/simple;
	bh=N9KGl82SHrD1eJ3yuqzt82ebzKwjoV7zqnKZCS1pvQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EVl/M/n8/QVNxBTUfEClUJyaybGpetjWyFgP5PaeyB84p0l2POXdDr31xwA2iApPhyW4PFkBvntgkVrS40dj9K7aJLMMwriJVu5YruBPtu4Vbc2PWmWDHJIlieImGe5rV4y0T80rfirwRSgTBpLCTWciqDkmFrtCMt6HWp7sBwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVVX4QLX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6B9C4CEDF;
	Wed, 12 Feb 2025 13:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739368522;
	bh=N9KGl82SHrD1eJ3yuqzt82ebzKwjoV7zqnKZCS1pvQw=;
	h=From:To:Cc:Subject:Date:From;
	b=DVVX4QLXVs/264Af+gaXNtb8Ispfymh/uhQwKNMNHJqG/Q8PQswx7VkXVnNNOtVG+
	 pTtauklqWjbRx5UQ/CNynj3h2DVmk9Yl424BV7pmONGujLgERCHmezHftjJ6Ain4wc
	 H15YbD66D4QeMPzdiergVf70scSty7NTL3Yaol3OGlX3YrIn9Rq/kC0RfEiRQverCi
	 0upJQXRgSd00zDXiQi0YFCNX3xdQ+bRmTToFYRVxUZssVnvZkmD5DQQxeBbCT6dmgI
	 NLdmCJwFZKVGL83hbkgwgIxfWeGs5iU174kxHozFvh2T0/avk0+VoG/KFRmzjGtdNa
	 IBXTV5OpBLnvg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	kernel test robot <oliver.sang@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	linux-usb@vger.kernel.org
Subject: [PATCH] usb: gadget: uvc: Fix unstarted kthread worker
Date: Wed, 12 Feb 2025 14:55:14 +0100
Message-ID: <20250212135514.30539-1-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The behaviour of kthread_create_worker() was recently changed to align
with the one of kthread_create(). The kthread worker is created but not
awaken by default. This is to allow the use of kthread_affine_preferred()
and kthread_bind[_mask]() with kthread workers. In order to keep the
old behaviour and wake the kthread up, kthread_run_worker() must be
used. All the pre-existing users have been converted, except for UVC
that was introduced in the same merge window as the API change.

This results in hangs:

	INFO: task UVCG:82 blocked for more than 491 seconds.
	Tainted: G                T  6.13.0-rc2-00014-gb04e317b5226 #1
	task:UVCG            state:D stack:0     pid:82
	 Call Trace:
	 __schedule
	 schedule
	 schedule_preempt_disabled
	 kthread
	 ? kthread_flush_work
	 ret_from_fork
	 ret_from_fork_asm
	 entry_INT80_32

Fix this with converting UVCG kworker to the new API.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202502121025.55bfa801-lkp@intel.com
Fixes: f0bbfbd16b3b ("usb: gadget: uvc: rework to enqueue in pump worker from encoded queue")
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 drivers/usb/gadget/function/uvc_video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index 79e223713d8b..fb77b0b21790 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -818,7 +818,7 @@ int uvcg_video_init(struct uvc_video *video, struct uvc_device *uvc)
 		return -EINVAL;
 
 	/* Allocate a kthread for asynchronous hw submit handler. */
-	video->kworker = kthread_create_worker(0, "UVCG");
+	video->kworker = kthread_run_worker(0, "UVCG");
 	if (IS_ERR(video->kworker)) {
 		uvcg_err(&video->uvc->func, "failed to create UVCG kworker\n");
 		return PTR_ERR(video->kworker);
-- 
2.46.0


