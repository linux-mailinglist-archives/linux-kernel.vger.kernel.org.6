Return-Path: <linux-kernel+bounces-238453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CAC924B19
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BBCE1F27F8F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63341A8B22;
	Tue,  2 Jul 2024 21:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jf9d4lcn"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE9F1A51D5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957535; cv=none; b=S41uQ4s1HNhYmLwEIos6ygiwgDhfQhaUTOg3U6RGznwBDn1jyuwWJ3SQEfe3XdowbC7U2266Xw1Up2MKwXyBYCc5wXf7OFf/2LtbT7b6FXRvyqsqvBWpFQyHZP29SK1+/z0LWW9I/DTUhhD28VDvEPo2R0n1+BFKRFdNBD8OZlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957535; c=relaxed/simple;
	bh=n1/hz4xykVkUk2xjKjG7eczT8WaUv3YrnseEt+1afak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jy/nwG/NUhuc0qhFkMlU+z30pg4lhoAG1F7H9Nyv9UJMS0pOtFwM4a0d4ezE339fqbyzGKz0CNnIk3ilneeKRlhNxiq0jg6MDvwYqKsJl6yZkEWU0o0312Ghx5IYNJJW1LrkB0KxfcaUCNSp5zAd5cGOLKx5X9nXnJ0dhQGefb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jf9d4lcn; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7f6309e9f29so165191139f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957533; x=1720562333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbmqLbQI8HTQzNGF8HQCP2HSLNy1cuHjZEiMFoqqHgs=;
        b=jf9d4lcnSHwIAX6nx4/x3UYU7ZGpkvIJ/XNvF1ljQ5ApTqRvuSZ477rzfwJSRr60lY
         vZ617hBNsgidyee0xGSstkTdl0uQalGuwvXwhJ8K6tFYXmXBN05a2ga8vupeQxCnGe7F
         l4spX7yajTYA4QtgxdIazSDhhdmY57iuC0WxsgySMqlXaBTxK1l8LZqjZKAJRWKEM180
         dP/3tPa+7a3A8W+2yBxxIZGLU8C8zjQWqSTZmQY4+zm1ncVwoAGjudXKGfiN2C77EeZj
         MIlDjGcFvxYfNKni5LvQkIWL+uCySbvK1uVEEoYMXDzgF9ZX9mGH8nyVDIXD7ny7ZmQ/
         JpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957533; x=1720562333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FbmqLbQI8HTQzNGF8HQCP2HSLNy1cuHjZEiMFoqqHgs=;
        b=QwQ8I9LKPDtBCGUUojlePUSjY4wmiqC4Xka4F7uCX13OQqWM8nPz0UvrJuGKdsg61C
         5J5mj32dJANBV2jOfZ6yh2HB+FOLl3zxGDdTUAoUkoW4psw57PZtFj5sKjsl7nZkTXOz
         THiW+A8LPEdRm7DHHMmQiLJ9TVikd5qaLAqXsyeHO7pONJAuugCTojjilWBS8aRWh68l
         ro9Ji2j0ZTUaR6X4sNQmiKMkhWXHGo4+WFiRYqifbwjV9SWwIBAmEArN9o94nRWNekre
         Ul0De2pP988R515ivDRkAQ46C+YR9d2fVw6FcSs+BRXNz8FQPEZ7Dv/OlWkEUrnIxzDT
         LSQA==
X-Gm-Message-State: AOJu0YxPEJquJHlZp0yXhwejtCUhlPWGmWaFBwtNr/tVRQnzPEqCajs8
	L0Jslj7rEGrxMduBZBm6vPMV0XT7LIn5xKqSV6uo2f/cxIUUQqZu
X-Google-Smtp-Source: AGHT+IGlV5e4CX2/hYLHSwwmfK8aU2Z7WZzMU6zQISMzjPh/8c+A5mSKEdQB89WlGTCmF6ZX4oDK1g==
X-Received: by 2002:a5e:8c05:0:b0:7f6:2b2d:8ad4 with SMTP id ca18e2360f4ac-7f62edff929mr1067071239f.4.1719957532918;
        Tue, 02 Jul 2024 14:58:52 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:58:52 -0700 (PDT)
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
Subject: [PATCH v9 32/53] DRM-CLASSMAP-USE in drm-drv.c
Date: Tue,  2 Jul 2024 15:57:22 -0600
Message-ID: <20240702215804.2201271-33-jim.cromie@gmail.com>
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

---
 drivers/gpu/drm/drm_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 243cacb3575c..f511d40f577a 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -56,6 +56,9 @@ MODULE_LICENSE("GPL and additional rights");
 static DEFINE_SPINLOCK(drm_minor_lock);
 static struct idr drm_minors_idr;
 
+/* single ref for all clients ? */
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 /*
  * If the drm core fails to init for whatever reason,
  * we should prevent any drivers from registering with it.
-- 
2.45.2


