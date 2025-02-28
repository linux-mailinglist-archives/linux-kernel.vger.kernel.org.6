Return-Path: <linux-kernel+bounces-538560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9AEA49A3C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 357663B9DF5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0237D26BDB4;
	Fri, 28 Feb 2025 13:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YFsaHaZw"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26391D88DB
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740748125; cv=none; b=WsrrAH0vZJfhY5rGqNUdXaMeyQC6DBBc7kO7iOXMauq5qXI3vj3K0b9velOPhysQuBisGER/EB67iTjv/fBKQeGCiPEKEnOG+M/znG9PTmTx4o+zW9ou1tR/emIQs6Hi48qSXUWDZ2YqsXDz9LjfFa3qxyGtkerQLmovl+7ADbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740748125; c=relaxed/simple;
	bh=jVfySmtCKc+rDgzWs0d1iuV0e5AynR7YjDkBSBs9NGs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XimH9KWlSH0K9mRHhsxPqM4RKs59dFDFDUEl2J6o13j+pZ/bNR0/ThAMKfJALIHFjJQcujjAxxeL00WgS2oFEV+L1jyB6XwwOVxHv7Yz+AEvYPcBBgbusX7hOHSoyIsdMY7LW27GjeeJMC6LC7zXFZTiCI9QxR7L8L954DpdncA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YFsaHaZw; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6dd1962a75bso16330476d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 05:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740748122; x=1741352922; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wu47y/gfGsHXETXnfAoCaDWBGszfC1szAfoQtY44QlE=;
        b=YFsaHaZwAS7/RSOvekzrehdKITfXj39H8qQLLq0o+DHWrVmlpe8Zq+RdcihRh/1zdQ
         jakjJKcDz5X89wVAvVhUCan5ov6Csa6JR/2ucF4b4cdYwpLCQ9EQl2YgesHjwSINHKzo
         CfhtABdnGR4j826PPhPE6UlhL6FBmco7wiT24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740748122; x=1741352922;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wu47y/gfGsHXETXnfAoCaDWBGszfC1szAfoQtY44QlE=;
        b=gx505xScb4cQNiFXBbYoPte/iw503sks/ROVQWviPiPDDbIkanUTdv7efPBYGaxDOU
         498fe4fyedNZYch3SVz5opQJ3JRVpA/PwoIxvoQ2Tgd7o4mIiT8PbrD1kkV+WK3cI1lD
         jU7SyXwFWQ6BpqxAxyLBXpanRrpwVSAw9licPEtYNN8NKZUXTL4u1X29Eh0fczQbZ59p
         C+SQtwmecMM5UGcqwS+VAgvJbu06Bd0UJNdqB6AOKeTY8MEK2Sx+N8JOaxsjLre34Yr6
         uz8sPpK0yWIxzJBw0HW62SHm6P4tPiTr0fRwGfsYLyVj7ESaGFFTrkLviODEfs+VDmbm
         h5Fg==
X-Forwarded-Encrypted: i=1; AJvYcCWjl8yoCVURqHIf+d96Ndbj/C6oLdUhze3AQvZ1cTD7UUx/NeZyN7uXSokWT6GrZ/hIdOIKi1JZKVUCfsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyPGMSHSSoBdgY38DIL7NOUKHzugWAGphzXgk0JCxl/138w1o1
	TwOfn50/GRPcGXXhcZenJHlB+DNfgopyibeACeXVO6tODuyfq+A/xwSfi+/BkpiT6OrLoF+0c0n
	z+w==
X-Gm-Gg: ASbGncsV1pc9m2MRHjPkAJrh2KC/d4DFmzOS42hi7B4PPDsv8PLrBUiYI10q/dYkFPo
	pyffnJXXrdeDbKEa68V8+UiTCDOh2fryunWfMC+BT8Wx4eKWhodVmPp9RlyvVu9au6Ks25ZrhLZ
	D03cg/X85FCJb9rXThEa/HZHVMKlsRlPViphUjPbYo83ZCkev9lJXThE7rBsvZqcnSWwVnrZps9
	/ENrcvSN4aG6ZFZjnk7VvL/q3mvHtN4NMhNsamjaUvEiMvB3mZLwR/P9uLecUgPVfUsahBEdXij
	ojcbxUuhylA8m2Sak1x8BQ9r193hJBztK0DKuOQQvln4L/x35FIYVmYeSUIbgpRe0qziHard6kw
	5Pmw=
X-Google-Smtp-Source: AGHT+IGREZ8d3y7LZ4jLIKH/UvjI1lqtGi9/ApBsqfvwniiJKDUn2mxes6cCfftxvK2FRlPK1865eQ==
X-Received: by 2002:ad4:5c64:0:b0:6e6:6535:17df with SMTP id 6a1803df08f44-6e8a0cd3e3amr54758336d6.2.1740748122614;
        Fri, 28 Feb 2025 05:08:42 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976d9fe1sm21938046d6.102.2025.02.28.05.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 05:08:42 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 28 Feb 2025 13:08:38 +0000
Subject: [PATCH 1/2] media: vivid: Move all fb_info references into
 vivid-osd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-vivid-osd-v1-1-16963a0a0ab7@chromium.org>
References: <20250228-vivid-osd-v1-0-16963a0a0ab7@chromium.org>
In-Reply-To: <20250228-vivid-osd-v1-0-16963a0a0ab7@chromium.org>
To: Hans Verkuil <hverkuil@xs4all.nl>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Slawomir Rosek <srosek@google.com>, 
 Hidenori Kobayashi <hidenorik@google.com>, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.1

Most references to fb_info are already within vivid-osd.c. This patch
moves the remaining references into vivid-osd.c.

This is a preparation patch to make CONFIG_FB optional for vivid.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/test-drivers/vivid/vivid-core.c | 10 ++--------
 drivers/media/test-drivers/vivid/vivid-osd.c  | 13 ++++++++++++-
 drivers/media/test-drivers/vivid/vivid-osd.h  |  2 +-
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/media/test-drivers/vivid/vivid-core.c b/drivers/media/test-drivers/vivid/vivid-core.c
index 7477ac8cb955..10f5bef3f49c 100644
--- a/drivers/media/test-drivers/vivid/vivid-core.c
+++ b/drivers/media/test-drivers/vivid/vivid-core.c
@@ -1410,8 +1410,6 @@ static int vivid_create_queues(struct vivid_dev *dev)
 		ret = vivid_fb_init(dev);
 		if (ret)
 			return ret;
-		v4l2_info(&dev->v4l2_dev, "Framebuffer device registered as fb%d\n",
-			  dev->fb_info.node);
 	}
 	return 0;
 }
@@ -2197,12 +2195,8 @@ static void vivid_remove(struct platform_device *pdev)
 				video_device_node_name(&dev->radio_tx_dev));
 			video_unregister_device(&dev->radio_tx_dev);
 		}
-		if (dev->has_fb) {
-			v4l2_info(&dev->v4l2_dev, "unregistering fb%d\n",
-				dev->fb_info.node);
-			unregister_framebuffer(&dev->fb_info);
-			vivid_fb_release_buffers(dev);
-		}
+		if (dev->has_fb)
+			vivid_fb_deinit(dev);
 		if (dev->has_meta_cap) {
 			v4l2_info(&dev->v4l2_dev, "unregistering %s\n",
 				  video_device_node_name(&dev->meta_cap_dev));
diff --git a/drivers/media/test-drivers/vivid/vivid-osd.c b/drivers/media/test-drivers/vivid/vivid-osd.c
index 5c931b94a7b5..043ffccbc6af 100644
--- a/drivers/media/test-drivers/vivid/vivid-osd.c
+++ b/drivers/media/test-drivers/vivid/vivid-osd.c
@@ -333,7 +333,7 @@ static int vivid_fb_init_vidmode(struct vivid_dev *dev)
 }
 
 /* Release any memory we've grabbed */
-void vivid_fb_release_buffers(struct vivid_dev *dev)
+static void vivid_fb_release_buffers(struct vivid_dev *dev)
 {
 	if (dev->video_vbase == NULL)
 		return;
@@ -380,6 +380,17 @@ int vivid_fb_init(struct vivid_dev *dev)
 
 	/* Set the card to the requested mode */
 	vivid_fb_set_par(&dev->fb_info);
+
+	v4l2_info(&dev->v4l2_dev, "Framebuffer device registered as fb%d\n",
+		  dev->fb_info.node);
+
 	return 0;
 
 }
+
+void vivid_fb_deinit(struct vivid_dev *dev)
+{
+	v4l2_info(&dev->v4l2_dev, "unregistering fb%d\n", dev->fb_info.node);
+	unregister_framebuffer(&dev->fb_info);
+	vivid_fb_release_buffers(dev);
+}
diff --git a/drivers/media/test-drivers/vivid/vivid-osd.h b/drivers/media/test-drivers/vivid/vivid-osd.h
index f9ac1af25dd3..883459552fa9 100644
--- a/drivers/media/test-drivers/vivid/vivid-osd.h
+++ b/drivers/media/test-drivers/vivid/vivid-osd.h
@@ -9,7 +9,7 @@
 #define _VIVID_OSD_H_
 
 int vivid_fb_init(struct vivid_dev *dev);
-void vivid_fb_release_buffers(struct vivid_dev *dev);
+void vivid_fb_deinit(struct vivid_dev *dev);
 void vivid_clear_fb(struct vivid_dev *dev);
 
 #endif

-- 
2.48.1.711.g2feabab25a-goog


