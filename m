Return-Path: <linux-kernel+bounces-348513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD8D98E87A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 04:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14B2DB21A38
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 02:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A85C17C9B;
	Thu,  3 Oct 2024 02:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPekkd4G"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8340715E86
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 02:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727923100; cv=none; b=SNu7KLKcWQnZC4rpqNnfStSd7+04sUBgEAcTQxxdbftHUiyc/L0rcxi9eSULA7I6qonM4tkscia+OxdHYI6ebJNRPxRDV1j7hZJSpJAK3E0i/EHsFIARq0kL0avl6u4XzHlHUlCSfg7YScsBcHtPbrwE8BB2O4998VSWw79JlD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727923100; c=relaxed/simple;
	bh=DxoGgWWE19EO/BOOTZf3sT7/D6M9hh3tL4iGFh1dwVY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n/beVSjK5DCSt8w1HiFoIaA//m9HOMP/EFWrfXx+oflVoiO3Kk5r91zh9+jN2OG3NbraDUpi7666bwHdUznmh0qQhsWC88aeHCzanTPocsn7ECL/mBg+/YP4sN3UAbr61OU9BNNM8Fm5KASgU7P+4OfCRUEu884CTWNRRzhIGP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPekkd4G; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e084dc44bcso45892a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 19:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727923098; x=1728527898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aBhhnWvJLxAsX91SXPla2wRicBwvXtlUH3afSaFOliI=;
        b=fPekkd4GoSKsFy8D3BIqT7tXPZCJzhGDylmN6kYQairqif45WGf4EfegVQfuVE6/4m
         tkmMFanWN2Ehsh99IgebsyjbLOSSjeJCOyuLgadaljjBLRakz5U21WRNN4lbkH0A5KmJ
         TdW/aKFwInQoOaGZ8iiFCWGuWTtoAns1VIsc5xgQKIrlMAwMPyyrcKQukrMElqaBypWi
         gtrBGYoeX6IspoTDOMsHLmtgyVJJJ4sQvaN209jDEt3Cgl8jG1yorwH/8E+tuqUKu86w
         Shsqo2ZyWLhvqXvTwh2cSU9LE89ilVWsaZj+OAiGOLNwAbpy2HqwVKQvPFZ01f1xElfy
         fiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727923098; x=1728527898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aBhhnWvJLxAsX91SXPla2wRicBwvXtlUH3afSaFOliI=;
        b=XDBU4tA2W4DJhZUar2hy96xUyyT/6YscET4/csNEiXWWJv8GuY/W2kUfjrVvWfzS32
         ZfXvggEip0etnp2uqznuxf8YP2jngySYlCmfFJETdj1yaC78310QQIhqt/d9bh6oi6Ls
         RNVeTTGC/9MLQF+57OgLBQ88lCxuCaEW4pljhoNVP9YSxDJ6yvg7F8K2vAVLBqNxh+5z
         rQ8A3HQyziIA74BhMkvV98RHGay9Db0IwEs5cHBeSyq1z99iU6qnYWKI8hXr7KojTwNP
         9ZtEHeoowRoukWBg+uhnDe8jendMeNvE0vOLCmBNfXHR+oKXtL8DY9WMjo5/MNAarKdu
         bdwg==
X-Forwarded-Encrypted: i=1; AJvYcCWr2T2t8h1B/L/l2t724hUJW4FVVbiF7UAoRiy5GHlYCvk7jONZ+/ucjLqg+5KvFi1JXlkHXy8iHQLczLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtfPBqvHvcaFspGyhQbD9J0uFdJprOQIjvcm4cqcNhuxCFNryH
	kvD+uDj6K/j/ZrJcHL5Zn8iN/xlpplDOB1pJQJ5YMSr2ZLwyTmNF
X-Google-Smtp-Source: AGHT+IECIn9zFuwUuZvE2eF0qZ9HXxmehAG2tOfd/jUaogGl9epHv/6wUXiyV7p1rrZaq9sbWkwHfg==
X-Received: by 2002:a17:90a:77c4:b0:2d8:b071:e10e with SMTP id 98e67ed59e1d1-2e184513f9emr2573480a91.1.1727923098522;
        Wed, 02 Oct 2024 19:38:18 -0700 (PDT)
Received: from dev.. ([2402:e280:214c:86:3469:2360:12e1:1ea9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1bfb16ec4sm282039a91.14.2024.10.02.19.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 19:38:18 -0700 (PDT)
From: R Sundar <prosunofficial@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	R Sundar <prosunofficial@gmail.com>
Subject: [PATCH linux-next] drm: Fix for kernel doc warning
Date: Thu,  3 Oct 2024 08:08:06 +0530
Message-Id: <20241003023806.17537-1-prosunofficial@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added colon in kernel-doc comment to fix the warning.

./include/drm/drm_drv.h:372: warning: Incorrect use of kernel-doc format:          * @fbdev_probe
./include/drm/drm_drv.h:435: warning: Function parameter or struct member 'fbdev_probe' not described in 'drm_driver'

Signed-off-by: R Sundar <prosunofficial@gmail.com>
---
 include/drm/drm_drv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 36a606af4ba1..1bbbcb8e2d23 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -369,7 +369,7 @@ struct drm_driver {
 			       uint64_t *offset);
 
 	/**
-	 * @fbdev_probe
+	 * @fbdev_probe:
 	 *
 	 * Allocates and initialize the fb_info structure for fbdev emulation.
 	 * Furthermore it also needs to allocate the DRM framebuffer used to
-- 
2.34.1


