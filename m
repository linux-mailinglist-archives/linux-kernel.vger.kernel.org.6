Return-Path: <linux-kernel+bounces-254296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C9A933189
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B950B24C96
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F4C1AC23D;
	Tue, 16 Jul 2024 18:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNTpPZzX"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F091A0B00;
	Tue, 16 Jul 2024 18:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156361; cv=none; b=fq+iAqudDWA3Ku4RCs54X0e/oF2TGXiKFc5kFM/4txAD/Bf9wD9p2/8QDuQDz1k978QIRfaJwrWyRSLR1qqurLTsJAk161jZlC32i9xRb/I4M3wLobzMhJtPi9EJbpelJDu5iKFkDo0t9QtU+9z8cZoXVxcxxEFJxZW0Zo5A2eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156361; c=relaxed/simple;
	bh=jGiueC+Dh5EN2Lejau2B4bSvCKR8MfH5CgBIgeJvpL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F31woDmBUE9y9iIKmk3T4iM9ufA7td5aYcQzEe9Qus92w0+pDsFsHFomdx3a4E4HyuYqRUyShVP4kysesH4ncCvQWcL6eUp/NnLI8/A4WCaMyq4W+7sDAPkqiF9VXH4fQN8Mq2W8uUkoAHq/jDv3WHrlj8A9Mvf4qbbuu2uc+R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNTpPZzX; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7fb93b2e2a3so4700439f.1;
        Tue, 16 Jul 2024 11:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156359; x=1721761159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIsdMzCagTnPqkjtDJJFzcS6RuUfrVRwKo+d8V5q9yk=;
        b=UNTpPZzX2HTNWMlDnQn8IfNKx+PZHp91yCqQVhqT7CvywN1vvXkT0VTDy+luz25Tcb
         qUjNiG/0DJaznw5wkPWP9/U7oPhYz8zA/NywLwor3C5G57mvxLsCJEG2xEpE7wqCPaTa
         vf4RuXhADkCjk8FsmTTkySBIzamKdNZU4V0/IbJV8yZjAVAknS8AjeArk+eyv39nDzAM
         0a1SdlrqwT+dDYFTl60hfsHCfURUWg5CxiQXJWCFaPoYTyzBUbksmQiB+S4P4RaUnePa
         SCKXFsLtdvBIG0h/1zQfZLPrb3BTiLQBjdHnmHnoJo9ejjqRH4DFFIm5G9PgNZLQRg1x
         FBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156359; x=1721761159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pIsdMzCagTnPqkjtDJJFzcS6RuUfrVRwKo+d8V5q9yk=;
        b=jONswiWXlKdB8JQK2tv8CWnARWn2KTib9HvqEnseYSsyJ73ql6UK/o+eZ+PH8slO35
         DMk9GbVgz7mcrvVpiXi/RTPkFa2ZrfQFGAQm5HvZAJH58tTfk1sWkovNuptznHhwrAyU
         aVCjf3mLs6IMQ5hYv1K5s1JO4Jqmr7ENmxGM3dD+JF4J4WFeA9GWR1zFMIvPpxCicwzZ
         XFMFs2amTFDx/ebIVMNw10dekygMs9/hPK2Qb4BiHf7og44hd/EAzzxxMFFJkqaBsF9Q
         mu5lXufwxJNxMnEPP1YPtwHaquSsOq8yWdDsUuMlgwkEUBUhke5IUUrUiRLxtlTbKVCr
         GXng==
X-Forwarded-Encrypted: i=1; AJvYcCWVzgBue74gjFV1AJvEdGie2KT8Lde2u6EpOwwj8vlCT4sYiH6mGHpfyinwr40TIWGxNAO7fBUp0DehP8SQGw+EodPlJvnYns7O
X-Gm-Message-State: AOJu0Yx4VJybs3iWPuV/w8+PqXteDw/9pNZbqUPK/4LniJcz2FXRIpHA
	MWHOOFgnhGXDwFOMxRvjRtzs6rh3aXQ/CMi5Hzvo4v0nTKhHkX/meL/KMBjD
X-Google-Smtp-Source: AGHT+IHNiuOywTynIegoUOvJ19aVvPGNEUWBbbHPTejWdZydJpz41aRG2QF6opmLXH5eEouAFJcPxg==
X-Received: by 2002:a05:6602:3fc7:b0:7f9:bef6:2068 with SMTP id ca18e2360f4ac-816c35dac54mr41725439f.10.1721156358829;
        Tue, 16 Jul 2024 11:59:18 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:59:18 -0700 (PDT)
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
Subject: [PATCH v9-resend 42/54] drm-dyndbg: add DRM_CLASSMAP_USE to etnaviv
Date: Tue, 16 Jul 2024 12:57:54 -0600
Message-ID: <20240716185806.1572048-43-jim.cromie@gmail.com>
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

etnaviv has 5 DRM_UT_CORE debugs, make them controllable when
CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg that the module has
class'd debugs as well as plain-old pr_debug()s

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 6500f3999c5f..1d1ddbedcb5a 100644
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
2.45.2


