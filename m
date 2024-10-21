Return-Path: <linux-kernel+bounces-374458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457F89A6A85
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35BF71C24739
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0001F8936;
	Mon, 21 Oct 2024 13:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P++zRoGM"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2611F4726
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 13:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517875; cv=none; b=cFRNDP+nE/p2TumrNXKe1gkF/FWc2Rz5hWKfjUDIBwVbVqurl9i/N0NPGP49Bk7hcFaXh41go3Mt9lYuM43Cdc9DCYtfgymsgBrqKjFJaHNKP0x84M0fGjX1eqeevQ0db/HQ4gZRowgmNC4X3MGqIfWfBUL9x3frQAik83fl4Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517875; c=relaxed/simple;
	bh=Yx0nEL3eDqy4wnT/TPSTYD0CqCa7ByqGEhXEm4yYtd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dIFmVvgODmdSTI+jjFX+P2b828pCu5q3bAcZtHQ0ILh5z1hWDyu5Y8ETygcA1wsXVS+pDrZTmyZjdWXs+NFkNJ++B1Z+KzVp4lrCvVk7COkZ92tzP17OHXMsvjOxYlRd0x71UYi47z7G+Azn+eKVyOpLS6vApqbYUQKWb5Nh+B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P++zRoGM; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539e7e73740so4010335e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 06:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729517871; x=1730122671; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fC1MtmbCN57A6bjwUEsG+s8kklw98PPJXY/T3i9tkGI=;
        b=P++zRoGM6q88QbZMoTnM7HG29UV7HHmUcN/x7zc1utKnHF9ZJiFTEGr/8LLS0vILe2
         UCdFJbE6k8KAl8LJs/FTB8/QCHDRoybtpQuegRO+W9n9+MBuVqPnzfkPzZD0CQbGQitC
         PiCQJ/ZfUeDKbap4SCQrbiyTmkmuG25G/l1wWVXYeHUM2HRCDm5FuvviG42HjJ8zEow6
         wQUR3zQZgfFLW7PptCj0w3N0K/C1ZxOseTYEG+qNP4GQ9kOSZB4M2AE0iq2qj9oWT5XT
         Qjd2pkcjE1b3livbDqprrnzjfZweNMZw+2PGe5kmn0b2cgiaqvNYtcnf1mQXrIPny0tZ
         T/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729517871; x=1730122671;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fC1MtmbCN57A6bjwUEsG+s8kklw98PPJXY/T3i9tkGI=;
        b=EXgY4MfGdydGhgcD8sz0A0er82yjKY61pTQMsm+7Ab31b0N7tM13o5uytLJ4nRfXHS
         /6/27n1CLMudLDu6PjAfNQtLiTXaKrl8EomITF04l4n9aXWgzPFd9swpZRGntO9S5VUl
         U8f3u3RDM3weqeWnlj4GI/v7dRFLR7yTb1XsU2ZYwl2O1+KRBFePEXD/jIbr0xUWdDot
         O8s0RZkQb1aWo6FlV26Vi7IPW6mW6jADucz/SCMWZRWMUu/Cl4Axv0VyEnCekq1QiVET
         moGfmqzgWNU++L3gaL5rfGm1pinM5gEPt1myRlj7ZoXhb+3nEu8aWGfzaGutEdY2rqwH
         6rKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMuJQeLs5hx2Utd7BR3Vtobru5MF+SKrpVjWskugLT5AO8+WRhDLkvExmvN+tZz13Kt1sm4efwiMG4Yhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwItQsMHa0AM6epvq56zPEN5Za/2q73oL42isZqKrvAGpKg4arV
	G+bewyGmGJBKR9DeNmOfGqPYU/wdaY+1Fdt03su6B3SjS+GASjCi8eUlmbPWJPg=
X-Google-Smtp-Source: AGHT+IHIBrzPSrtxxezikBJ8RWJQ/7DBIsPbOI7qex7+5iaCtDjcjOOwcYu9pj7lrqoxGT33evVFNQ==
X-Received: by 2002:a05:6512:2209:b0:53a:40e:d547 with SMTP id 2adb3069b0e04-53a1520afadmr5582803e87.5.1729517870933;
        Mon, 21 Oct 2024 06:37:50 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a2243198dsm480767e87.224.2024.10.21.06.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 06:37:49 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 21 Oct 2024 16:37:46 +0300
Subject: [PATCH v2] drm/fbdev: fix drm_fb_helper_deferred_io() build
 failure
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-fix-drm-deferred-v2-1-db1de4c6b042@linaro.org>
X-B4-Tracking: v=1; b=H4sIACpZFmcC/32NQQ6CMBBFr0Jm7ZhOUbSuvIdhUdoBJlFqpoZoC
 He3cgCX7+f/9xfIrMIZLtUCyrNkSVMBu6sgjH4aGCUWBmvsgQydsZc3Rn1g5J5VOaKh4JxrAp1
 8A2X2VC6dTXlrC4+SX0k/28NMv/SPbCYkDHXd9cdojevM9S6T17RPOkC7rusXI1lD7LEAAAA=
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Cavitt <jonathan.cavitt@intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2709;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Yx0nEL3eDqy4wnT/TPSTYD0CqCa7ByqGEhXEm4yYtd8=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ7pYpI6xc0FWfLde7mw2lleHoy37/tiWyrq5LVtkk8Fql
 2LMadPJaMzCwMjFICumyOJT0DI1ZlNy2IcdU+thBrEygUxh4OIUgIlku7L/95I9d9rk3JOLL2rT
 fWUPJ69+rHJ04p2rxsWS2ZbhXhLPfKKc/lc3Cea3xX7pWDdTi6nFl+GXx6WUP/bvWub8Yv4SePb
 V25UvGTlcb5aL17ge/eV/8oKRb4/25fzgbfdWfuV5VavnIC6zzFh97V41jqLOaYy73h5vc+5pTH
 6SEqz2gWFGQZ1l5LPPSuK7Dra8v6t3VkOsyiT/jl2Gi9uSgikvqi6b/rG/r5X33NHYO9zrUWrgQ
 50P6v3uoo8l9V5y3K7MdCphWcBaHsojnLhc9Q+jQ6Acy+fzHEGPF4TutJzxYfq16Vnf/52uTuxQ
 6dD3mXbf+sT6LQ3nF9w4fCdCQcmqXsPPRGd+9ocnW9YDAA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The drm_fb_helper_deferred_io() uses struct fb_deferred_io_pageref,
which isn't available without CONFIG_FB_DEFERRED_IO. Put the function
under corresponding #ifdef to fix build failure if deferred I/O isn't
enabled.

Fixes: 8058944f5226 ("drm/fbdev: Select fbdev I/O helpers from modules that require them")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v2:
- Added guard #ifdef's around function prototype and a stub (Thomas)
- Link to v1: https://lore.kernel.org/r/20241018-fix-drm-deferred-v1-1-c33bf5d209b0@linaro.org
---
 drivers/gpu/drm/drm_fb_helper.c | 2 ++
 include/drm/drm_fb_helper.h     | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index d5e8994345bb..c9008113111b 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -697,6 +697,7 @@ void drm_fb_helper_damage_area(struct fb_info *info, u32 x, u32 y, u32 width, u3
 }
 EXPORT_SYMBOL(drm_fb_helper_damage_area);
 
+#ifdef CONFIG_FB_DEFERRED_IO
 /**
  * drm_fb_helper_deferred_io() - fbdev deferred_io callback function
  * @info: fb_info struct pointer
@@ -740,6 +741,7 @@ void drm_fb_helper_deferred_io(struct fb_info *info, struct list_head *pagerefli
 	}
 }
 EXPORT_SYMBOL(drm_fb_helper_deferred_io);
+#endif
 
 /**
  * drm_fb_helper_set_suspend - wrapper around fb_set_suspend
diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index 699f2790b9ac..8426b9921a03 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -256,7 +256,9 @@ void drm_fb_helper_fill_info(struct fb_info *info,
 void drm_fb_helper_damage_range(struct fb_info *info, off_t off, size_t len);
 void drm_fb_helper_damage_area(struct fb_info *info, u32 x, u32 y, u32 width, u32 height);
 
+#ifdef CONFIG_FB_DEFERRED_IO
 void drm_fb_helper_deferred_io(struct fb_info *info, struct list_head *pagereflist);
+#endif
 
 void drm_fb_helper_set_suspend(struct drm_fb_helper *fb_helper, bool suspend);
 void drm_fb_helper_set_suspend_unlocked(struct drm_fb_helper *fb_helper,
@@ -361,10 +363,12 @@ static inline int drm_fb_helper_ioctl(struct fb_info *info, unsigned int cmd,
 	return 0;
 }
 
+#ifdef CONFIG_FB_DEFERRED_IO
 static inline void drm_fb_helper_deferred_io(struct fb_info *info,
 					     struct list_head *pagelist)
 {
 }
+#endif
 
 static inline void drm_fb_helper_set_suspend(struct drm_fb_helper *fb_helper,
 					     bool suspend)

---
base-commit: 2063ca42486bc07b49bc145b5dfcb421f4deebaf
change-id: 20241018-fix-drm-deferred-01c9996c17a6

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


