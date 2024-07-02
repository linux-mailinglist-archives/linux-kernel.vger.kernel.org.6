Return-Path: <linux-kernel+bounces-238450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B57F1924B16
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76C0D28438C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355211A51A9;
	Tue,  2 Jul 2024 21:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXldIh5D"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E72191F75
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957531; cv=none; b=WBkdZiwFfiAo7VA4DFKfa5VZyvsr0ZtPS6f1SKCwueUrUg+nxbWCLHUKyyyEV/maf/B6pINzB9lIX4lZhQOk9eUUCnaj3MPxw647a9E1NFC0g+/L4OUtDEHtEX+xfawTs/gj4INGdHUpUIp8INMeNonADnFSLKS1dztYUmsi66w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957531; c=relaxed/simple;
	bh=a4W4s9BVRiPLm/yh9K6Hd3gD4zdb5i70EVvfIpE053k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dn4j/v4J8X82PtotcQ6Z3zdd5i5ZxhyruBPprH/iIMoysEbSVZXr7qN+5Bgif1WEVeJTkpBW24e7ZRSRifV9vhoLMsKvZ7M0mAYorvD4iI/feoLJHUxUJe/MF2XCn1MRTAxrVWqbYB5heeSLpfAC9zc7sn5HTqTMBOtnDj6Ozuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXldIh5D; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7f3d59ff826so173101239f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957529; x=1720562329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kydKHLvNbnZg3PNir0Er7pU83Hek2HX1+Oh0xgNXyIg=;
        b=gXldIh5Dl2jyJx74xYtLMa7+PPGZLs3Lkwc97KjTNSepyOCYE2gm4ASfNpIzxmABQ1
         P0DwwX0TlfIw302Gjw3/hSUq+WIaA22omFuCYiJvibU+tO+KcrdAzhiy1tpAzIuRMUJ1
         ZDWq4rmXcK1cMr9XjCpeDmKNvGKbegI8CVGpGNEdHDnSOg7rPJ8vnpnK5O8QEuN14kft
         X9M5b1Iw1JuGBXRACvDudyl8PWbmstJ4OM9i70IsBC1EXDVojOcHECbc7yvJXkw5FEJo
         NlZLmlq+2/QAmh+1aYV9TYyP2pvRM+pSwtUvsAE6MTZgUAxN9CD7zJbe9KjxY+mKOxT+
         7t6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957529; x=1720562329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kydKHLvNbnZg3PNir0Er7pU83Hek2HX1+Oh0xgNXyIg=;
        b=S3MwLrwnIbBkRVnfqpo+6gJuGH/II5YkYA+pbbkKRP7f4j51sK53g7twRFDaUeP/x5
         h7Psn0CXY3jyW81VpZrcMNmFk1hGDWoSgl79tO7lGLMaBzBQvhWXhNs1WMQyDOZhu0bv
         VMirEVLS0U7EoqOmudWP8N/YVqnZ1duVOlEILVQ53mtaueUJOcFYg7lMJd+l2sJhTsOO
         Y7MacGFblRPdNbc5a/o8mM+xmf5+GZVpPHKU3qceiABWU2ZNxCRwQTEc4gaPfipA1P0S
         pOvTnGp5qR0KaE3B7Fb6WWd7CdxZldHwcdmThd6PJEKrsrqS6cqaS8YPrJIZrVqbxegS
         MWkg==
X-Gm-Message-State: AOJu0Yysz6LW98vV4Z0KJT/kXVk4+nD8+6t+iqPsz0V4lz6L6yYZPKFH
	x0jfxyJHf7TV+83/E4jisGZaYbIFwSDRmdpVth8u/WO29y181cid
X-Google-Smtp-Source: AGHT+IHiT4qyllY61e86gEC6NbmhhO5i7DHIdNJWIww0KazUvs2igsL+Uh2C87ePfk+pKL5jlhS9Bw==
X-Received: by 2002:a5d:8455:0:b0:7f5:bd0c:b532 with SMTP id ca18e2360f4ac-7f62ed69020mr1001616339f.0.1719957529366;
        Tue, 02 Jul 2024 14:58:49 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:58:48 -0700 (PDT)
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
Subject: [PATCH v9 29/52] drm: use correct ccflags-y spelling
Date: Tue,  2 Jul 2024 15:57:19 -0600
Message-ID: <20240702215804.2201271-30-jim.cromie@gmail.com>
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

Incorrectly spelled CFLAGS- failed to add -DDYNAMIC_DEBUG_MODULE,
which broke builds with:

CONFIG_DRM_USE_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_DYNAMIC_DEBUG=n

Also add subdir-ccflags so that all drivers pick up the addition.

Fixes: 84ec67288c10 ("drm_print: wrap drm_*_dbg in dyndbg descriptor factory macro")
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 104b42df2e95..313516fc2ad5 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -3,7 +3,8 @@
 # Makefile for the drm device driver.  This driver provides support for the
 # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
 
-CFLAGS-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)	+= -DDYNAMIC_DEBUG_MODULE
+ccflags-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)		+= -DDYNAMIC_DEBUG_MODULE
+subdir-ccflags-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)	+= -DDYNAMIC_DEBUG_MODULE
 
 drm-y := \
 	drm_aperture.o \
-- 
2.45.2


