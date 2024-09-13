Return-Path: <linux-kernel+bounces-328902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D29B978AA1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 23:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361C61C21FFB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 21:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDA0154445;
	Fri, 13 Sep 2024 21:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OhmS80rm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08365154C09
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 21:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726263177; cv=none; b=efscTbDmDj+CSWwTxFyDYn9aCZKQKuQVNjKfPUTV0OV4ykYml3Nq3i8N9l6EhU43olRSflQy2M6qvm+uT+RQ7iopDo/22nBx5FgV4zQOgTddsGbdnxI1OU8VpRBN4dwNuA39ZRViH5hn7C9rANzW5rwn29SL3iQ7DeKZDDEgpQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726263177; c=relaxed/simple;
	bh=4UwXVn3VjGHTV9K0yYJ+/4sQY1rIjdE/3NLygsvBHHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jsjmSaDpVeY5YPx18CybALhJUIButC2zWDU4itZtgzQ2rdsIGO6wPXdMba9BKnioPGCFBBt6OsukZEzNYPa0a6x4fZwUBOtVKAswmNKDhDnWDuYAydevhB5Mnph1DzcyECz/iazVfa54Me/0qSPsPbDyMtrQ/sSzHopZP/aKtwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OhmS80rm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726263174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zq/XGfhuxnu2xqsl1VfuSOlwQfCDeWHk07eSBLjaxgY=;
	b=OhmS80rmWwHEmZ7hp6E5zm8NVxzmEy7dL9q/8M4U90rqFEDa2Hg+1P+VSxVOswvZNgTbIf
	tAphImSchjxP9sawpZ+gp2c8PyYU3443xZKYcq39KWcYzeqnrtrYWdfJCqSmLCdDbQHYrK
	e7949al16jtk6gp7kyLpEuoRdQ0dKLU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-J6O02tpQPwCliz5bH53u4w-1; Fri, 13 Sep 2024 17:32:53 -0400
X-MC-Unique: J6O02tpQPwCliz5bH53u4w-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-377a26a5684so623322f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 14:32:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726263172; x=1726867972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zq/XGfhuxnu2xqsl1VfuSOlwQfCDeWHk07eSBLjaxgY=;
        b=HNnEzbsUrZ26e1n0vDL+qyKLcc1fV7oo8wtLeJjSb8dZhzy+ctY4lZzb1lDU4Lk8Bw
         fYBApeeQmGSPuFbk2jrbYtsULiGQHlVa3LDotbj1f20aJdVgt0Z1SWUt5v45vmqcJtH/
         IwDNf76SWMl+9mmHsbch7pAu2qbjFPwwBe3eEd3ayO0LIFJDIykWQ/+i75N054CAdKYF
         WQfmXpHViJXLV23JpbxadJ4f0IBvrEjOK0bk/P50/H9ZW68ApSFi3DA4oKGMUiA5vjJk
         2A/0bR+rzG3+rcxNylDYJOUgdlODfU1ibKyrEI67NWml9uwlDjkYu4bEdPTqEIwM+ugE
         iLpw==
X-Gm-Message-State: AOJu0YyXHY0qZqwKK8kMo6TKT/qJMrjAMM521V2cuuqZHp2Vtqr2SFuZ
	0A/3dh8XCl6DOkQ8C4xrJZrn5ygH5L8Ue0aHVtyyltpmlQmlDApY3tnHl0KIGBGP/1mMDZPIt4L
	dfodL0PyiJkWWa4sAtp6Kr5QCAudQvlMwMjihbcuci6u62RlBT9+I4iQyotuTgh6rZo+sMFlqlq
	41qwBiZEfR6jqDwN+L4NDfi6yX4lNpz5Bsesid0KRpVPs2
X-Received: by 2002:a5d:4388:0:b0:368:5b0c:7d34 with SMTP id ffacd0b85a97d-378d61e2c14mr2554804f8f.22.1726263172286;
        Fri, 13 Sep 2024 14:32:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEyVfX5FD6HqnGhKNhramC2RAHdl6F32DVAZO0vkVjMaGBuk7aa+lbQRZkWnexB34MoaO9XQ==
X-Received: by 2002:a5d:4388:0:b0:368:5b0c:7d34 with SMTP id ffacd0b85a97d-378d61e2c14mr2554779f8f.22.1726263171717;
        Fri, 13 Sep 2024 14:32:51 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cc01a8ee7sm142234035e9.0.2024.09.13.14.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 14:32:51 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Julius Werner <jwerner@chromium.org>,
	Hugues Bruant <hugues.bruant@gmail.com>,
	intel-gfx@lists.freedesktop.org,
	Brian Norris <briannorris@chromium.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	Borislav Petkov <bp@alien8.de>,
	chrome-platform@lists.linux.dev,
	Javier Martinez Canillas <javierm@redhat.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH v3] firmware: coreboot: Don't register a pdev if screen_info data is present
Date: Fri, 13 Sep 2024 23:32:29 +0200
Message-ID: <20240913213246.1549213-1-javierm@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On coreboot platforms, a system framebuffer may be provided to the Linux
kernel by filling a LB_TAG_FRAMEBUFFER entry in the coreboot table. But
a coreboot payload (e.g: SeaBIOS) could also provide its own framebuffer
information to the Linux kernel.

If that's the case, arch x86 boot code will fill the global screen_info
data and this used by the Generic System Framebuffers (sysfb) framework,
to register a platform device with pdata about the system's framebuffer.

But later, the framebuffer_coreboot driver will try to do the same and
attempt to register a "simple-framebuffer" platform device (using the
information from the coreboot table), which will lead to an error due a
device with the same name already being registered:

    sysfs: cannot create duplicate filename '/bus/platform/devices/simple-framebuffer.0'
    ...
    coreboot: could not register framebuffer
    framebuffer coreboot8: probe with driver framebuffer failed with error -17

To prevent this issue, make the framebuffer_core driver to not register
a platform device if the global struct screen_info data has been filled.

Reported-by: Brian Norris <briannorris@chromium.org>
Closes: https://lore.kernel.org/all/ZuCG-DggNThuF4pj@b20ea791c01f/T/#ma7fb65acbc1a56042258adac910992bb225a20d2
Suggested-by: Julius Werner <jwerner@chromium.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Julius Werner <jwerner@chromium.org>
---

Changes in v3:
- Fix coreboot spelling to be all in lowercase (Julius Werner).

Changes in v2:
- Declare the struct screen_info as constant variable (Thomas Zimmermann).
- Use screen_info_video_type() instead of checking the screen_info video
  types directly (Thomas Zimmermann).
- Fix missing "device" word in a comment (Brian Norris).
- Fix some mispellings in a comment (Brian Norris).
- Change error code returned from -EINVAL to -ENODEV (Brian Norris).

 drivers/firmware/google/framebuffer-coreboot.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/firmware/google/framebuffer-coreboot.c b/drivers/firmware/google/framebuffer-coreboot.c
index daadd71d8ddd..f722292e7684 100644
--- a/drivers/firmware/google/framebuffer-coreboot.c
+++ b/drivers/firmware/google/framebuffer-coreboot.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/platform_data/simplefb.h>
 #include <linux/platform_device.h>
+#include <linux/screen_info.h>
 
 #include "coreboot_table.h"
 
@@ -27,8 +28,10 @@ static int framebuffer_probe(struct coreboot_device *dev)
 	int i;
 	u32 length;
 	struct lb_framebuffer *fb = &dev->framebuffer;
+	const struct screen_info *si = &screen_info;
 	struct platform_device *pdev;
 	struct resource res;
+	unsigned int type;
 	struct simplefb_platform_data pdata = {
 		.width = fb->x_resolution,
 		.height = fb->y_resolution,
@@ -36,6 +39,20 @@ static int framebuffer_probe(struct coreboot_device *dev)
 		.format = NULL,
 	};
 
+	/*
+	 * On coreboot systems, the advertised LB_TAG_FRAMEBUFFER entry
+	 * in the coreboot table should only be used if the payload did
+	 * not pass a framebuffer information to the Linux kernel.
+	 *
+	 * If the global screen_info data has been filled, the Generic
+	 * System Framebuffers (sysfb) will already register a platform
+	 * device and pass that screen_info as platform_data to a driver
+	 * that can scan-out using the system provided framebuffer.
+	 */
+	type = screen_info_video_type(si);
+	if (type)
+		return -ENODEV;
+
 	if (!fb->physical_address)
 		return -ENODEV;
 
-- 
2.46.0


