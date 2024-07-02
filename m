Return-Path: <linux-kernel+bounces-238473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95452924B34
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 410B81F24312
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4011C8151;
	Tue,  2 Jul 2024 21:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxZ/RwoW"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D5B1C5A37
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957552; cv=none; b=mqczB6PktNSswsgEg2VO/V6sbEvB06ljq9e2/+BMFZ+8LmfYIyDmpx6nFq4UbeHWf/DO8WxVSAJ075YhzRv1xZK+le55S1Zgf+nKWxEycvj2y/5TKz1onWXPFcvTDPcQIn2LDj85K8UZgRUmcAOSAQDw8PlZwDqGr0BqBkjU2c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957552; c=relaxed/simple;
	bh=zmyLO65yPZ2P+sQ2d3HjTXHc3m95hCKtg7yLZG+YhsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8DqWelVuiP0YbLOtRD/kXf9AVUzZN0p+7AwwEdCsofZ78EzdFwyHvcWD5hy+sbbnckoOjv+j5VKvgQYvMkbi138AJs7e+o4gNZg950upMtpNN6l0FyeogDJfs/ZBQhTcvewECCgqNGe0nQAIjO6KZ89nHzq9WdsIlsX8yVRgvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxZ/RwoW; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7f61e75642cso212366939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957550; x=1720562350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzxAaDu6jznCkYGTIESxKGj+agIaj+uEvHm/3W7k4f4=;
        b=IxZ/RwoWgCjp73yK4++Yy7t+ZQst7Ch1HkkTNIHfZcleWESj1IlypCshiZ3hQaa8Mk
         vUYNkIJJv/xPWt4b4Bmt+6+7QNc+0/hu0XyqrZnZMo4m/ZQK95mxRiGC6419Yhv6jyD5
         xLT48CO2ZYoeWwrfDmx+gtAZ+mcJQarc934OQ88SPmJSLl5y6BFH8Oywkkw7quX7l/7/
         otq8FW79imajBdL1RdHVgCh2uUoBDZKBIEt5MSiYdcQyXtUbZcdhjvfqMh288pIbxWjT
         Hp1nhJJN/U4tqNzAvXV3MXawrPbzfDOc5yEgmgaiGju8sjaIwlLQTfGWjEJcuWOZhuuf
         SimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957550; x=1720562350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzxAaDu6jznCkYGTIESxKGj+agIaj+uEvHm/3W7k4f4=;
        b=sTDj2dBmoaE74HtTa58padASvX/GQFDMviDgjShYD6DzqEF1o1IdUkXzsO/CXPxUaB
         LZlpGTEy8+gozrlGvsWP7dyBIbL03jegLjjdZF5mskidMJ5ntU4KXjOsS4OukcXrcZ51
         y6eg83QM733W7z458GqpQGhPD+4fqs2mz7TEJdUGeNxyT+p2S6HgBXNychgJaq/I9dN3
         qIZWZFBBKTn2Wo7JTVz0CWWSIcKy5WBGLo4fWW8I2Bok3zbGI9IXoeUwDXwUDfRvuJ9O
         ZAFjy8gDubYg4UR6OK5roVU0Oyl0pHqT3ZhqW+H30uCfe2vF+PF5agLfBBShZlMLv+VN
         HX6w==
X-Gm-Message-State: AOJu0Yy9tUYvFMLyOuRrUo0uv7qL1I0vhIlE4YlnaVWLEvFCfRTKdhFI
	mUO8eCwmd6FCixnLegVXJzLPTIeDW2JynGiarnKf5MGzbO4lfQcG
X-Google-Smtp-Source: AGHT+IH6FgmYtruVie6MYmI+39/gsTLr9f9UoNDdF0ISkmNJ1lHfdTSInJOZogzQSQ9dyJk1hbdfQA==
X-Received: by 2002:a05:6602:600b:b0:7f6:4f7e:b87e with SMTP id ca18e2360f4ac-7f64f7eba13mr445681639f.21.1719957550253;
        Tue, 02 Jul 2024 14:59:10 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:59:09 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	ukaszb@chromium.org
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v9 40/52] drm-dyndbg: add DRM_CLASSMAP_USE to simpledrm
Date: Tue,  2 Jul 2024 15:57:38 -0600
Message-ID: <20240702215804.2201271-49-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702215804.2201271-1-jim.cromie@gmail.com>
References: <20240702215804.2201271-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tiny/simpledrm has 3 DRM_UT_DRIVER debugs, make them controllable when
CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg that the module has
class'd debugs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/tiny/simpledrm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
index 7ce1c4617675..9cab48bd0581 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -33,6 +33,8 @@
 #define DRIVER_MAJOR	1
 #define DRIVER_MINOR	0
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 /*
  * Helpers for simplefb
  */
-- 
2.45.2


