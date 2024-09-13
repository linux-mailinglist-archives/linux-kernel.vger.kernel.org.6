Return-Path: <linux-kernel+bounces-328779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 373169788B1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 21:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC90B1F220AC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78771459E4;
	Fri, 13 Sep 2024 19:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KtnM4UnJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53C91448DF
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 19:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726254879; cv=none; b=krN/oaIpupl/pZxDtoh3rjjXQeMJlhGlQw3DD91/BZRWT5s8gsCaDyFyx6xC29BDENHWXgj++h6qEPIHNYXb70i4uBjm7+pX4dAFgN75mVcnpwbGE9d2kfWQYM0KB5PZda33iVbi1bFrwtFcZTT22AFo/4RhlH7moC8JbipavzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726254879; c=relaxed/simple;
	bh=PLusFX4CKkS1QA4qJmDPXg6tWB5qFGY21DvddyURCjg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iGFYQQ8Au36hpqTHjTGwMiUH7Lf6RAchvxAUzdKdtpQZ5H9VLCGz/eUwK/dl23M2Slu15K+a+GoiKsXwweP55yk8++ZfxOf3wrzj9Uof10HNPIT/d+bmUdcrSPRbnWen11ewipQIZnvN1TGkT75GB9CY5Pux4brr84djmyuHX08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KtnM4UnJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726254876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kEDaZq1JvqwS7B5a6C/b79xspKvNtOtKMLXgoPqkWiU=;
	b=KtnM4UnJQcqy/21s+pD3fTdzknAE+vKenEoRMY+SEgFBGnRYKYCwhiKQBamOJ2hDbl5war
	bRDgIDeMk4z+EV044IvkSVdhHEM36y/oG4/Ajr+o7idyencf1+f8GcWTOZW3rqTZlhg/fx
	T2sQLET6dCX44wHSu4UX1Gjn0HYfdh8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-7jlZEgZiPe6iMADljh1XPA-1; Fri, 13 Sep 2024 15:14:35 -0400
X-MC-Unique: 7jlZEgZiPe6iMADljh1XPA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb0b0514bso19183185e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 12:14:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726254874; x=1726859674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kEDaZq1JvqwS7B5a6C/b79xspKvNtOtKMLXgoPqkWiU=;
        b=kprYb0UA6YgwKvirEFS79LRae7/MjHcJEBuFaHAtDYRuhfkBldFxW6cDCERps/6ysQ
         GJjqycYoY5VjRLrDTQV0HeRVG5Ar8G0wU8/0hG4wUogToDf6nEA3iIxwaGl38svo/aC6
         HUzBk3iiA7UwqkQCSK0d5iucyv9tgPoAECAwtRgLTqcpxh8fNuNt9/wi/6fdrtJt9Vo9
         n4rUFhfcUZ39Nrz8uad12ilUXMIrEYcYLtFedgGF7hxSXlFO6GGoRq9pGTmEqkIBcDQi
         mHcE93r4TOAcwvePPco0jbQwMLfAI66q0fK5PeTbqcxps0AsqIbh6LzWuAkkSUeREFqf
         IdeQ==
X-Gm-Message-State: AOJu0YymgW7oAwVeP7gDS/s99NmWribts+JwifSe8XGZNfx9FWlISsqR
	O3RinImh7mGOg18PYFD844w5zjh/yEjFgIUWOX1LmHMa4h76clTKw2tUuVFBZbbGvTs1GlTHGVB
	HuMvH6LKfkcaMFFFNJ1isM19JaKybJLScY0Hi4wP5yvvpEAPHd6voz4uqp0dVeO1TMo/mg4rnCA
	1rR6ElVus8a+V2dWzhjfwO1SQ58JQ2DENMVjqDHUIYSdMN
X-Received: by 2002:a05:600c:3514:b0:42c:df67:1d35 with SMTP id 5b1f17b1804b1-42cdf671f9emr58878385e9.1.1726254873512;
        Fri, 13 Sep 2024 12:14:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEv6ZqQqprM8k1B6dy7IN1qr0vv0mBK5M/OuTZw60w5IV+Msv048q6Y8MOMeLK+vWaPrKuugg==
X-Received: by 2002:a05:600c:3514:b0:42c:df67:1d35 with SMTP id 5b1f17b1804b1-42cdf671f9emr58878005e9.1.1726254872862;
        Fri, 13 Sep 2024 12:14:32 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42da22b8b49sm380015e9.2.2024.09.13.12.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 12:14:32 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: chrome-platform@lists.linux.dev,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Hugues Bruant <hugues.bruant@gmail.com>,
	Julius Werner <jwerner@chromium.org>,
	Brian Norris <briannorris@chromium.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Borislav Petkov <bp@alien8.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH v2] firmware: coreboot: Don't register a pdev if screen_info data is present
Date: Fri, 13 Sep 2024 21:13:59 +0200
Message-ID: <20240913191428.1539653-1-javierm@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Coreboot platforms, a system framebuffer may be provided to the Linux
kernel by filling a LB_TAG_FRAMEBUFFER entry in the Coreboot table. But
a Coreboot payload (e.g: SeaBIOS) could also provide its own framebuffer
information to the Linux kernel.

If that's the case, arch x86 boot code will fill the global screen_info
data and this used by the Generic System Framebuffers (sysfb) framework,
to register a platform device with pdata about the system's framebuffer.

But later, the framebuffer_coreboot driver will try to do the same and
attempt to register a "simple-framebuffer" platform device (using the
information from the Coreboot table), which will lead to an error due a
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
---

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
index daadd71d8ddd..49eeb13814e4 100644
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
+	 * On Coreboot systems, the advertised LB_TAG_FRAMEBUFFER entry
+	 * in the Coreboot table should only be used if the payload did
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


