Return-Path: <linux-kernel+bounces-254295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7EE933187
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFACC1F25506
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5171A0AFB;
	Tue, 16 Jul 2024 18:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQurEcht"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EAC1ABCB3;
	Tue, 16 Jul 2024 18:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156360; cv=none; b=fpeykr2N+Ki1Wn1JTRxPSkkMZnZvRgyxWUuOMHEgt7S3QKqtnAT6vxckk+AdiXtY54l20Gjj0VCpRK4b3Gr3fgqCOW5kn6DmA+9ZWh0Cjw4keqobPKM+WbKsC8e9H+pYRxx5rVIZr2wvFmEazCGH8LheWB3juDlPKdjZTK0+lgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156360; c=relaxed/simple;
	bh=tCPOUZzz1n3M3/Vbz4zH5Gffd4O1Gv0jydxTr8IfQGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrwsiN6Y9loNk24KksWSs4dFpuj2LLAbGqC9NxBQmjOz9H9y+lbQlfjl3ra/+b+5L/Hcfik3n2StcFgozu1t7eIwvf3mjWvbcg2HLO6I0UTNQcU1ExEG1/Z+l7W6/nLs7gKybd6Hx8XpG/Y2aRLc/km8L5Oqsr11fbcJxIZDkWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQurEcht; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-8036ce6631bso5974739f.1;
        Tue, 16 Jul 2024 11:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156358; x=1721761158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVVliFbCcRiwMu0SQpi190huBei8IpcPa+B6oudggrw=;
        b=QQurEcht0lkgNTKnoDQPvwTOp6//JGBX8VkPv6+js7WOHG4d9UStbHrqkocxinahuO
         ZDSkz0Y3ES2rHLUXRTKDPu4pUEVHPjKbO10QFVL3lkQxEzITFA0WhbpEr9vGOqZTfds8
         dUUFTvbwdch/39TK8IRVmiyinP494wwjOtd/yfoWKAEywST/cK83XjmM57s5cxnQcF1L
         QVu0h7ClyjvpxheVJ0E+9iaOVYsgFpPBy2nBIjS2Fmn4JmhqjsQIZKrj88STtWJVlu9G
         MX/g2UPKRYu+4aQxX00QKmG6bo8r7EYbxHWQqN8TDxFtNEpfzuH6Ll7y7t7r20M7WghX
         VrBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156358; x=1721761158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVVliFbCcRiwMu0SQpi190huBei8IpcPa+B6oudggrw=;
        b=SeKtqNwmq6cvfZQ/+MFERLtClSx/SxdvTp8Qi844dcssUHMV3aInm1QB+etBok4hLT
         45Q5X5bmbjcyHd23ypGYBy1pd+5NIGxNngxZTlej6xIL6BePlX8UUo42MxqgDKtFTUoa
         xo7V6zvpwVSOOJhgbkbRMO8g1o0YtuHIUzqdLvOdUkXhco5kczrHKKdYGgi+efEjZbFi
         OCTnT2ev5tabSoviOzuMFQ+6E/7ShhIokfmWjEeNtjk5GTQl/5CH2OQgQqdWXXtLtOlR
         j4RCiO13h/MozvOf1vlIDNE5a5ogfj3H6ZyWGZQIoLZNNzrvCVhGtoWFhtM1bBJA+f7/
         BbGg==
X-Forwarded-Encrypted: i=1; AJvYcCXb244X6EU5S6HixBFEvPSGR6Y4C3v3m23W0P54vgPgJ7cEEYdpFWGzoSTIVcOHyfbYpdEn1ddCoAbFdONfjj2M47wo0xgnAwvw
X-Gm-Message-State: AOJu0YwMFdoTSA3RdMNqGsqv1aRxJeun8q90/GXZCm1bjQlpGWjQDV2B
	9iAHfrh09/zzdkbyyjiJRsCgW3nZNeh3TtPwP6ypOD7KiLjoVB2w2TA760NL
X-Google-Smtp-Source: AGHT+IG55r3J/+WPjmFCfm4i2FdKqBFiyLji83RgakUJ5UGwMl7NPkDm7WMlJ0D93dK102jpqkJ71Q==
X-Received: by 2002:a6b:ee19:0:b0:7fb:87d6:64b with SMTP id ca18e2360f4ac-816c51c78f3mr33599139f.17.1721156357639;
        Tue, 16 Jul 2024 11:59:17 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:59:17 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com
Cc: ukaszb@chromium.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	linux-doc@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	kernelnewbies@kernelnewbies.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v9-resend 41/54] drm-dyndbg: add DRM_CLASSMAP_USE to bochs
Date: Tue, 16 Jul 2024 12:57:53 -0600
Message-ID: <20240716185806.1572048-42-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716185806.1572048-1-jim.cromie@gmail.com>
References: <20240716185806.1572048-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tiny/bochs has 5 DRM_UT_* debugs, make them controllable when
CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg that the module has
class'd debugs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/tiny/bochs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index c23c9f0cf49c..ee98fab5597e 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -54,6 +54,8 @@ static int bochs_modeset = -1;
 static int defx = 1024;
 static int defy = 768;
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 module_param_named(modeset, bochs_modeset, int, 0444);
 MODULE_PARM_DESC(modeset, "enable/disable kernel modesetting");
 
-- 
2.45.2


