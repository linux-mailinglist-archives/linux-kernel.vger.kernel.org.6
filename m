Return-Path: <linux-kernel+bounces-570226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E369A6ADF0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28BAF7B233C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B0C233D91;
	Thu, 20 Mar 2025 18:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXjUgzN2"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B33233724
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496826; cv=none; b=gsVfPxVKZGqhuCiMl8COAgvDtd8HX/zWgh4cDwDFvSq1lUf1AbLO7u4q/TggVtW1dUOESGtkooNobLEqwjSVCfcl6hqxpb2bCfZ0hYwhLAHmdX5cVtfzx74CLyGh5NEZ1iaJe2g5O0pxcRr80J5/sRscVdnBJEhUxuPdr4fyUl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496826; c=relaxed/simple;
	bh=v325/R/096chjTXtqgrNRnSwmubhuU0T03Rv9PPtR4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SukYtRPZ7VOc3usfhYZ66kBlaCfTpGa5FW4DYMeh3RplpnMji6j45Ig6AXhE44FkZgHNams2VDDQUBTSvPkkF4UkPgqunWon2OlAcfpPWSpYKydpwKYHtNAvP+mn9DcznU1QROYrZX/rMdmeXPqdbE6ojZS0WywLBZ2uIiW3mpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXjUgzN2; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-85b43b60b6bso41411339f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496824; x=1743101624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtBnrd8yWB3oKPUJX24gJEUHr1Wu50+TDt3ZzWgKjdc=;
        b=AXjUgzN2VxRVpYChOzZXd8ArikZH5DEthCcXqiUjrTw/fXbcJmZWNb3RJRJBk4bpGY
         UAdSiDVlVFqvzrPscZUGmjO1kcrBgCGITjl9kU+EWA0s7HPHxlDcd7M21Hyxi7nNXGV/
         HzoABVvNLIBMaXr90OJKW7sdBcOFUd/sXVjxnC9OZk0o5pGf269pq6Ixs1fud9/HV1rN
         HIRtcMR+I13IyriOLKB89zyM2UdUX5CKxLN26S/hE+edJt4gpwZM//2dT1o3ZARPpifN
         cji3wnBgz5N6sUGsT344KVM9LTGV7r0MM6YlSqRpVfYJMkE3v7Y00d90S6mqy3SG1r+h
         0qcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496824; x=1743101624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TtBnrd8yWB3oKPUJX24gJEUHr1Wu50+TDt3ZzWgKjdc=;
        b=L5Oa3zyM//kEjDc0kXC0i14c0N46SivgFbnfzFzBZOYCxflPSQpUgZIJZb/qKw7Wib
         WfipmmuCfNvdQNXprf9C3CTq2ZxOhzipSqZZppDurjl0P8W0GZpngWtS7VfAC2ubXJWM
         tEHtirAsMvwNgvdLVOsLIekQ/M57kjDJc8/khVBWFxiHT3+YqG6+HQWthZQqWi7K0DRH
         YF5N2eE99brb5Ciw1ggPM8YNFGAMjQERAqTCekbAdWuzdPckRepz7bePCXz88Jrsf7t3
         M8WcsfkD8FYAm16koGG9CxaW6oUlA1EiXe7BZOqb/RnSiUb+Xv4bix108dmlVCMb5U6H
         5qKg==
X-Gm-Message-State: AOJu0YxbQlxe2hukn5SVEeBOqcoNWq3Xt5kMweFSplO/B+myPCQ5eS22
	R7qJ8hriJIDanpEUmXeApVTE52EsbUo7DQVrvNF16bxhBS/hA8IyPYuCskNV
X-Gm-Gg: ASbGncus/Wk1qu4/Opva0prfzKt6+HKZ4UXbUcLxKSWwa+xlxK8Ajs/RF5pudYqyYZR
	ZHBfG9nn0BVWZcwsIrjT8GqgOFaaw0K+08nGSxTtC6KYRiAmbJm7T9uhQMGOiEtG7lASWB4MF/u
	2xRZS69yf2tjpbJSRC7J8V9u/+S/rJECG/MfjUIY5phL2qhgJVkqPkD5sEX6ClIMw5kTnsRvQav
	rM0gqFFkdPFWqQg3TUoyZs89EkZNl08TOWSGC6J5LmbR9UTJomyLVWwNWPvM2W7mIgyKZIWlFuG
	mZpmuBdBdx+w7Xl7koZLzkgHAcOoW2+Zbb0lwVpdblbywupLboLn5CYtHm74R2uJldfy8mv/ckH
	xhh9Eql0cpFjY
X-Google-Smtp-Source: AGHT+IHFvyQVRbturEwDcbCPHLoZwk+VN5bfdFvOWI+5XsTyYwxQd9MOexegAMxgJSGfLg+Eu4mK1w==
X-Received: by 2002:a05:6602:72e:b0:85e:16e9:5e8d with SMTP id ca18e2360f4ac-85e1f0179afmr538360939f.7.1742496824100;
        Thu, 20 Mar 2025 11:53:44 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:43 -0700 (PDT)
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
Subject: [PATCH v2 35/59] drm: use correct ccflags-y spelling
Date: Thu, 20 Mar 2025 12:52:13 -0600
Message-ID: <20250320185238.447458-36-jim.cromie@gmail.com>
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

Incorrectly spelled CFLAGS- failed to add -DDYNAMIC_DEBUG_MODULE,
which disabled dynamic-debug in modules built with:

CONFIG_DYNAMIC_DEBUG=n		# 1
CONFIG_DYNAMIC_DEBUG_CORE=y	# 2
CONFIG_DRM_USE_DYNAMIC_DEBUG=y	# 3

NB: this adds the flag (when 3) more often than strictly needed;
modules built with CONFIG_DYNAMIC_DEBUG=y (!1) don't need the flag.

Fixes: 84ec67288c10 ("drm_print: wrap drm_*_dbg in dyndbg descriptor factory macro")
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 19fb370fbc56..704f94efc804 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -3,7 +3,8 @@
 # Makefile for the drm device driver.  This driver provides support for the
 # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
 
-CFLAGS-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)	+= -DDYNAMIC_DEBUG_MODULE
+ccflags-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)		+= -DDYNAMIC_DEBUG_MODULE
+subdir-ccflags-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)	+= -DDYNAMIC_DEBUG_MODULE
 
 # Unconditionally enable W=1 warnings locally
 # --- begin copy-paste W=1 warnings from scripts/Makefile.extrawarn
-- 
2.49.0


