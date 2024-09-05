Return-Path: <linux-kernel+bounces-317009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4169C96D83B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E105A1F21C8C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C4819CC0A;
	Thu,  5 Sep 2024 12:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAkAdols"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACE519B3F9
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 12:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538833; cv=none; b=D5QhOhKPwaHNS4LrucrjufQCYhEDA3Cp+3jTgt883g6fyLvgYI7+0M6cDVGrI3YtleUCMTL88UfLKC6ElsdHaC+kDimCh1AlCXwx17o99GBis2VLiLW6wypMYbHZ6LbWPD3izt0VYpc4YfUbD2YKFbiCKq+DlzUkGOue/0fWv3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538833; c=relaxed/simple;
	bh=A+pRTvc7UJSrtRlsW4bv6NCFc6XVDwIoHF/A1M/BsvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n3qZlXotB8/u9prgysUxrV7RU98ZKtUWjGz0xSamvmDv5WhD35IlS7TJNgu+vI1Wf1ctpG00jSEoZgMuwCXcOAZu5TaL6cYBedOWHHiWkfQaYgFBFyI3OXkLU5Ybk2yoE2Gvmd/iWWwP75rqqp5+PyIWYvDHMwt1jQEy9WFe2pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAkAdols; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42c94eb9822so5595115e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 05:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725538829; x=1726143629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6vVoqhFptCkQXt3i+ZEJEpUKCxugyOE9bwve1vN+BA=;
        b=NAkAdolscC1BvUuP6DZ8y7sMXzNPNwLrHdw76g1/RO8G8yKR87kCb0AdLdYYBXPRD3
         VJtWbpkiufk/ZKAkbRDvc3GVNNcQ3h5awFMGGmwRXsiYjEGuspZdN6UXK2fnR1AYjZ5H
         Q4OYD145OBL92FyT4/Ned11UjLHY6Al/G42Vchudc+iYFtswp6F1PHyYYRn4SC5ZSV8x
         aurMk+vd0a9C7VW5KXq9CyTJKUQ0JIHTs+147QbGlltoJuavumRR/nRrcA3LVnA8UYwY
         u/c41AgyBhhneDQswU2EO29gdAoXAUZ7JmLkEj7VlZjyAWbXp4CDiXhU1tXRYTogodgW
         JaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725538829; x=1726143629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U6vVoqhFptCkQXt3i+ZEJEpUKCxugyOE9bwve1vN+BA=;
        b=mfP/RHaI2HYJiTRoNBjT3ai7V3P0AHubS7qRuJyHSvjxVPa8pEtERwagjHX46syPpA
         GS0dLhq+l9U/maJJonDgLgeYLbbW/pAV+iz7/NSn6cwYcfVWPDv6T2gm1INqhHI8Gi5j
         YGnLXdoAntCGlBWAT/BGIa4S98Fr3KUqmp3YiwYQqYdEeQHXKZU10qQdwd52U35tkjgR
         w9GB6649k2kzCLR3j69pbyzMkUiwyfazidiTEPYJSzm5NYib0cusTIqG09ftjWZeZ7dA
         B4ewahvxGJs2aYfgz5mBAgLYC10XKMixEg+PKkhKVbaKeMQYFZtXhlOhV0RjVorl/XUc
         OpiQ==
X-Gm-Message-State: AOJu0YwmOjpvdNmrjSsMBo8kVLSJ29a/T4nucu1ojHdUxq8bDLwd0tnd
	508oz8qGYy/D6SiBqi1HrSz+khzoBFnUK0CFv2xU4XXbHA5WLVJWjwwWQg69VZs=
X-Google-Smtp-Source: AGHT+IHJpCeepIKpHkViCWDrVTZnpu8/LQ0QooYN0UAjk42ke/hGd6daAhMcjRRSSTY1ptqXauxyOA==
X-Received: by 2002:a05:600c:3b9b:b0:426:62c6:4341 with SMTP id 5b1f17b1804b1-42c7b5b4bdfmr121442645e9.20.1725538829300;
        Thu, 05 Sep 2024 05:20:29 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e27364sm230390515e9.34.2024.09.05.05.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 05:20:28 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 03/18] drm/lib: Include <linux/prandom.h> instead of <linux/random.h>
Date: Thu,  5 Sep 2024 14:17:11 +0200
Message-ID: <20240905122020.872466-4-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905122020.872466-1-ubizjak@gmail.com>
References: <20240905122020.872466-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Usage of pseudo-random functions requires inclusion of
<linux/prandom.h> header instead of <linux/random.h>.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/lib/drm_random.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/lib/drm_random.h b/drivers/gpu/drm/lib/drm_random.h
index 5543bf0474bc..9f827260a89d 100644
--- a/drivers/gpu/drm/lib/drm_random.h
+++ b/drivers/gpu/drm/lib/drm_random.h
@@ -6,7 +6,7 @@
  * be transposed to lib/ at the earliest convenience.
  */
 
-#include <linux/random.h>
+#include <linux/prandom.h>
 
 #define DRM_RND_STATE_INITIALIZER(seed__) ({				\
 	struct rnd_state state__;					\
-- 
2.46.0


