Return-Path: <linux-kernel+bounces-341076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46126987B22
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 00:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 687F41C2282D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 22:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BC818EFD0;
	Thu, 26 Sep 2024 22:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="F0ZI7/Xg"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15B218E773
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 22:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727389502; cv=none; b=JQRbxoTCqVeswDLEt8I17HKILlL07f7QOpHFoIaI31RT6950LTuNfVBFMsEK2DV/nyAEMazj2O5Y6D9qpGo4tgkqnQ+4YJ7iDXN8PfnIPN200HBsluO8LcGcYlvxmJV3DSTVTubkmJxREdPULdWvXjwZkOJ8BpunzkNpYj7Q9Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727389502; c=relaxed/simple;
	bh=9LWxw0GkDNKQzpLWJEw8INCGvjdnC+s0GVdlJVVvbaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EakUy6kvUEh0XJx8p+h5PuzhnriIc9Pp3EDXwi/gPzN85DD+hJaAxZS28aGVfd43QRwuOMClljn7K35Sr2vOMd8KDsEhn44yWgJkqtojgikt7yWfG5yP2JylPqKLkBdzeF9xH7SpnXrQRZxxzTFRZ1UfdA4gGxbdGlNlRunQi8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=everestkc.com.np; spf=none smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=F0ZI7/Xg; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=everestkc.com.np
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2068bee21d8so15986435ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 15:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1727389499; x=1727994299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nwvdoFGxm3KhCqcwA7uNn+nsr1FJVT8Rrylkxk+BHzY=;
        b=F0ZI7/XgFHmE1EWCmdDGM7o2SV8DiQ2ici+lgrln1f0YwNgrg9uYCPCjvPf5qK0UT6
         mRLMpIwXcO5NaxDnXmYj95PcdSD5bW04q20DyxjHgZQfx8VptyU1sn1B0gwReZiqZ16G
         B0mHdqrE/McNE0115vOUZ/ssarVmR+sHq2iBXVJx8jQRQxCesAyt5MIl3CMeLeX3bX1h
         kS43Y0qJATkoaDm8boAXK87+nUTvmc+w7NCMy0PhEQk09KrdSn97I20I+HBW5t7KYv4d
         hvWQjGjbzyi6DwFjES71UanLooVklt0SgL+AXY469kDZAhcjo+LSAN0mnV9em7XnMfBS
         z3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727389499; x=1727994299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nwvdoFGxm3KhCqcwA7uNn+nsr1FJVT8Rrylkxk+BHzY=;
        b=kcHm2oDS4pXVJiVmktLABBXKtvYPSHIYlTpPM75wXWTPMi/jUI2W3KQpp20bCDHR3m
         hvGr/3vnorczcHELZ0xa+qaamBsRBeBAGeHQJJTTF6M3ovxsW8m+wNnxsJ2EkxDV69p+
         5bOzAfYpd9w3taAaEKpRLnrkjSpSm09rrAlsKT50CUZE4qeSfu8R9DgZ6v6uSAESiJHM
         1X6qwokw+Gtut3mwPOPSOC8AVam9zGJCldLWrshAe3bL8nF3HoFrdaEfAu2TNQN59B5s
         d4waY7pclnCq+kYa7IejqszHYzEJHSZsKgGqID7tGhHA6zicCYgL9aylt5JPU7eupQ93
         2KnA==
X-Forwarded-Encrypted: i=1; AJvYcCWY2u+yE6C+H6GFOofBaxe417CVvTVKIAtqfoJGGwkAWfYuVru9L89177Skoiug0ERDTeCVrC91wIEE5/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXnpWCiC7fkOE8fiuNBAs3uOsuGW+VQ1xHFH1Oe5oa+71ecUCV
	LKJdVgq6w0lPvbgDhyIzkSD/a0c1KvruIM7UUm/P/bpJjjZA5pSEH3LQ531bmoLI8PponVl0EmH
	XMnc=
X-Google-Smtp-Source: AGHT+IFm/tktsslJFScr7N0Z8rSDXeabptEUKFyK1ckvN8vsNqDXTzaPkw22+7tUHK36g8LVTD4Xmg==
X-Received: by 2002:a17:903:2287:b0:205:43b8:1aa4 with SMTP id d9443c01a7336-20b36ad3bcemr12377615ad.19.1727389499047;
        Thu, 26 Sep 2024 15:24:59 -0700 (PDT)
Received: from localhost.localdomain ([132.178.238.27])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20b37da334asm3064755ad.105.2024.09.26.15.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 15:24:58 -0700 (PDT)
From: "Everest K.C." <everestkc@everestkc.com.np>
To: hdegoede@redhat.com,
	mchehab@kernel.org,
	sakari.ailus@linux.intel.com,
	gregkh@linuxfoundation.org,
	andy@kernel.org,
	hverkuil-cisco@xs4all.nl,
	kieran.bingham+renesas@ideasonboard.com,
	benjamin.gaignard@collabora.com
Cc: "Everest K.C." <everestkc@everestkc.com.np>,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] media: atomisp: Fix spelling errors reported by codespell
Date: Thu, 26 Sep 2024 16:23:37 -0600
Message-ID: <20240926222351.7116-1-everestkc@everestkc.com.np>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed spelling errors as follows:
	unkonwn ==> unknown
	Stablization ==> Stabilization
	previouly ==> previously
	acknowlede ==> acknowledge

Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
---
 drivers/staging/media/atomisp/pci/atomisp_ioctl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
index d7e8a9871522..1e42a8ca68f5 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
@@ -43,7 +43,7 @@ static const char *CARD = "ATOM ISP";	/* max size 31 */
 
 /*
  * FIXME: ISP should not know beforehand all CIDs supported by sensor.
- * Instead, it needs to propagate to sensor unkonwn CIDs.
+ * Instead, it needs to propagate to sensor unknown CIDs.
  */
 static struct v4l2_queryctrl ci_v4l2_controls[] = {
 	{
@@ -112,7 +112,7 @@ static struct v4l2_queryctrl ci_v4l2_controls[] = {
 	{
 		.id = V4L2_CID_ATOMISP_VIDEO_STABLIZATION,
 		.type = V4L2_CTRL_TYPE_INTEGER,
-		.name = "Video Stablization",
+		.name = "Video Stabilization",
 		.minimum = 0,
 		.maximum = 1,
 		.step = 1,
@@ -678,7 +678,7 @@ static int atomisp_g_fmt_cap(struct file *file, void *fh,
 
 	f->fmt.pix = pipe->pix;
 
-	/* If s_fmt was issued, just return whatever is was previouly set */
+	/* If s_fmt was issued, just return whatever is was previously set */
 	if (f->fmt.pix.sizeimage)
 		return 0;
 
@@ -1028,7 +1028,7 @@ void atomisp_stop_streaming(struct vb2_queue *vq)
 	/*
 	 * ISP work around, need to reset ISP to allow next stream on to work.
 	 * Streams have already been destroyed by atomisp_css_stop().
-	 * Disable PUNIT/ISP acknowlede/handshake - SRSE=3 and then reset.
+	 * Disable PUNIT/ISP acknowledge/handshake - SRSE=3 and then reset.
 	 */
 	pci_write_config_dword(pdev, PCI_I_CONTROL,
 			       isp->saved_regs.i_control | MRFLD_PCI_I_CONTROL_SRSE_RESET_MASK);
-- 
2.43.0


