Return-Path: <linux-kernel+bounces-254303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D04933197
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55D00285508
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6881ACE7A;
	Tue, 16 Jul 2024 18:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUb9wP1G"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452151ACA28;
	Tue, 16 Jul 2024 18:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156370; cv=none; b=p3gZ5CSJRKhEZay3uP8HDrxeYERKeVM38SwMYRCbUdaX2zANpJBSj1CCGl+wjsuHzCh2UoK/EemjZAgeEm71rWfrAsFdaFx6WCnTypnbH2jH9T096QZ9srCYTSnfxC1uvO6hSmfOn5MpxI1wZJonhm5AarYIslquE5ANyA85UdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156370; c=relaxed/simple;
	bh=VcaoUfrcouQV0gFCR662Kxzm42SL0jyYYKIh4ngnOzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GN6iGUIEbQl8Ynim5EJMlvUny9yy0vWDn/XqP2McH9Avu1xGK+Wl8se5YN5sY6rHE1qtYf7pFXIMqHUgY7Kv2QOFesutqnR5DELSvaTOO389HraTWwmbzalIApegdyVNvBwp/fKb3QBNF87Xwm9rkOFmYOTpGUD4hhOc0qKeVjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUb9wP1G; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7f70a708f54so6579639f.3;
        Tue, 16 Jul 2024 11:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156368; x=1721761168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdxS3Fv+DdtdyD/OX9RwYgW//DQBvhU2TaujYV4igeo=;
        b=ZUb9wP1GFE9IM0oaNbWy1x6OWmXl+PGNMmJWBS5smxWqnSvn8/OhqTFcll/sAoZr1i
         Q3fQj8R5yoY5gZ0viYgG+OAa6ww0nXmjNQsRFosfJHb4dQ+NuhRKW7imHQ0NNvifwc9a
         Lr1GO2RlNQhBHPEfLrUfWtQWujZx37fKRsOvu2zkG+NA4ZFamcI18X2WFIOAAFdxydjs
         9R4WEPO62OlDsNtgImlwY92PbbPtXVflelBCVNdcPmzzr3TgPPxR+Ru7XPU0DQugZzmb
         2nofetgDs2AahKqa9yRiJwfrAy4UR2If2gCAskWR2M+WKkceeCVbceJK/Y1Dq1DK487H
         RUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156368; x=1721761168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdxS3Fv+DdtdyD/OX9RwYgW//DQBvhU2TaujYV4igeo=;
        b=kAszxCRkHJXRTVIp3aIrysy3X0vvgwiNKTGO3ySKFrt+v5tBdCQXuRSihBksSPBGMd
         IRC7hNbE/LZ7o4fvcqnKOahsZGVfWgZcj0FHH6WgjLdYJTSGu+A8fOfpO8qzsx5PoT++
         geAlpPHhEGH9IB52WVIRiKe/ZVU+FPwX90hglfBES73CFqJtpcvx5FtVDPB/mSs8R0FV
         q5w6mhRDIeAGim+JypMbpDPM9Hl3Uf0UbL0BdXVh8HiPPgDKQoLWTYs1/DGHZdpDjXRp
         GH754UeMqIpLHGJfQ3EFw0uAA/0QRLbbLCGt6OvOlo9g8HGjqWam/Htw5PavNj2OMsV2
         uxDw==
X-Forwarded-Encrypted: i=1; AJvYcCVc7rDnAJH9MKaNXvV8jbTnrapLTgll2busOUy0SIUvYTuIzdEFMRuV07FLIikV7warF45TqdQkIHEbMF7CPk/yDVhJEOpx9yI1
X-Gm-Message-State: AOJu0Yw/G1nOJtbdx1XpyxsLzM53Cmo8DWMrHQmeZweax+ZrA6cMgAEu
	TWYC4bxczLqHnjXYZO7as/uxqm0C7luQByOKKniMD09vB+JQsVY17IHNddLo
X-Google-Smtp-Source: AGHT+IH6IKw5JArubE44ma76RRQ/D8ylu5XLCUV75AdBLcATiRJS8BMkgjWPefk5pTs0a712LpVuig==
X-Received: by 2002:a05:6602:341c:b0:804:b27:82c with SMTP id ca18e2360f4ac-816c4a1aaa7mr36704139f.12.1721156368121;
        Tue, 16 Jul 2024 11:59:28 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:59:27 -0700 (PDT)
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
Subject: [PATCH v9-resend 49/54] drm-dyndbg: add DRM_CLASSMAP_USE to the gud driver
Date: Tue, 16 Jul 2024 12:58:01 -0600
Message-ID: <20240716185806.1572048-50-jim.cromie@gmail.com>
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

The gud driver has a number of DRM_UT_* debugs, make them
controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg
that the module uses them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/gud/gud_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/gud/gud_drv.c b/drivers/gpu/drm/gud/gud_drv.c
index 9d7bf8ee45f1..5b555045fce4 100644
--- a/drivers/gpu/drm/gud/gud_drv.c
+++ b/drivers/gpu/drm/gud/gud_drv.c
@@ -31,6 +31,8 @@
 
 #include "gud_internal.h"
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 /* Only used internally */
 static const struct drm_format_info gud_drm_format_r1 = {
 	.format = GUD_DRM_FORMAT_R1,
-- 
2.45.2


