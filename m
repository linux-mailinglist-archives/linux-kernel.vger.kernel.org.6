Return-Path: <linux-kernel+bounces-570239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51882A6AE00
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CC8B189E23F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3269240608;
	Thu, 20 Mar 2025 18:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqslYZOe"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD30C23F364
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496841; cv=none; b=IuVOcWOHQ6LedBU8R0qXko0Pm79NUMhiYV62qe1knqmV17WlCsKDhsks1TDnkPCN+w80GOVmBKHJLBYi6lb9zT49PZLYy6dprEjjNqSWUE1uGgEZVZKSWsVMK7cN05KtKSs4SZvnVOJRgN4dH5NUVr6Ov6LjZ8HNsmoCtucFXrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496841; c=relaxed/simple;
	bh=8uJoalDz4gUJ4A+Uu9pLqeleSfN8jtRQc+WX9rk4RaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3sICL4WczeGsudSgMJrM5buyNIg52i3wC8AwltnDzAf1i4XUBKnhQYvkE8TB/ava3cgygl7Pr0C075ZX+VIb5yjXYZ5tyoJDqtaMzCw3nfoK92dI4AX2P4fkRCAC6yCZHC/FxQGmisW0PwOu/HzViDyuJstpc7lg/dpRE7ElgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqslYZOe; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-854a682d2b6so76766039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496839; x=1743101639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mR3GZQ988EXrhdMWSVSfrBHjk8VugzTeXVmkAtrRrJY=;
        b=dqslYZOey6TZBtJHNjXvcQT0cUzQDGBMIwbyR3fyh89ghQlVeG6WJv9q1tVSQAe1kU
         KTNDVyTvifoFWbU9W1Q4pAhCKUZiI+ZpYd81kwsUWX0Mmfzk9Me3F33O+8x4PxMxuFYl
         KbfXP51SJhVcKoMqkouUQp6Ug5A7Ezq1O18ePgVWyXTAWrbrpW98F4URzuwzOuwGvNSj
         htfetcHkR4ypHKBl1tGSGDrWAsUhWnAz10sEE00uLmeUIVcDv4Jp6VL+gSc+t8BldHHR
         s/VkdjII5hiQLoCH8XPOpK/R/3zb/ZgZvcwMgYx/voi7IT+KdOIHnFK4efg8zSHac9ii
         SmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496839; x=1743101639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mR3GZQ988EXrhdMWSVSfrBHjk8VugzTeXVmkAtrRrJY=;
        b=U37FWbdhPLrfSGYaFUuQBBPaBAvxfrMK3pnYqLX1GDXwAKfFC+glSJT2t3h6VQYkRd
         CLPSgu8HnvKyUyqvHP+Dj8EewHMal+6pQjObFuGGyyyaHSw8Mta2DWhuhjANwzBAk73R
         xLEQt1EhJKMm2QM3sGCAZNJUgwFq/sbXy0jX1Gkq60EqEzGcLj7Tdjzw2LI2YhOI0vUQ
         TPKIpiE+/l4lNZ33hPTKa8gx8YGz7mcuJMDzkN4j8paYj2sh/0HMwe6GiQbHxkklo6l0
         blLHWjDJUJjjFeo17HxFP2rdRsDU7FpdDNGFMBdVBek6htDqyRf8KxDYJyyUx82bLiVc
         8Zkw==
X-Gm-Message-State: AOJu0YwBA6JXv7pvJYl5o7CSXJGVsMgicWGuq5IhBV/TwJ01veyZlJso
	JTsEC+tapPfrQq8oBma8LJlQTncOQ0i7rCmAXBBiZG2D20DqU7R6htX9/rMN
X-Gm-Gg: ASbGncs+dsdqRlyOdTaUbJ1Uxvl8WKz533ZH6iiojG2E8+KBd2YRG1RE85p0Vk96hv4
	/qthYs7UtoYKew+HjIHF6P5wTcJn5TnU3oKY6ovlbCYuK5oY3Jo4v4IkhC9tm4pE4dmegh8ytJ6
	jzPInxK0NtW32HNZ7PHxy7bhIH3X+lCBA4hlrSy03NmygIVTyiyhFZQFQQFN1B/GK/x0isEcDai
	/XGGyeBxATcUqrfOoqUM/RJ9Reu6y4XTwu5qt+J9/O/Y4uqKGjI2Edn/ctBhwNjjbD1FWml2u8K
	Xco4hVVq3xPfm9Ka1eg9iQRo0k4MAAXvMQqlIT2lCU57RNU8qn01aLuLo2AUkuKofM/rsateV3T
	Nng==
X-Google-Smtp-Source: AGHT+IE/8vAD9xn894tiXvAQK0Gxh3uyYswy4zA7uBx2cF18ny9SJTNkmwBTELmd0JQj7p9EY0kClA==
X-Received: by 2002:a05:6602:2762:b0:85e:2020:2396 with SMTP id ca18e2360f4ac-85e2c8ff5a6mr53200439f.0.1742496838785;
        Thu, 20 Mar 2025 11:53:58 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:58 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-gfx-trybot@lists.freedesktop.org
Cc: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 48/59] drm-dyndbg: add DRM_CLASSMAP_USE to etnaviv
Date: Thu, 20 Mar 2025 12:52:26 -0600
Message-ID: <20250320185238.447458-49-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320185238.447458-1-jim.cromie@gmail.com>
References: <20250320185238.447458-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

etnaviv has 5 DRM_UT_CORE debugs, make them controllable when
CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg that the module has
class'd debugs as well as plain-old pr_debug()s

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 3e91747ed339..70759b7d338f 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -25,6 +25,8 @@
 #include "etnaviv_mmu.h"
 #include "etnaviv_perfmon.h"
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 /*
  * DRM operations:
  */
-- 
2.49.0


