Return-Path: <linux-kernel+bounces-238479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76635924B3B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94AA11C21C18
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C681D19EB;
	Tue,  2 Jul 2024 21:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyA7MY+m"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504651CD337
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957558; cv=none; b=LLa7277lUHdHdRmI1OVfDP7welpI4I3JvVFqaQo5AAnEyWm09Uz12vcDN/YIO4zLQ6W2ESdmBoKOgI+4+/ShBJjaQAas6DrGxvL9tY9aZjP285h5iQqtGFqsWxh8/WHlaa6nMQkirEAgId/MH6XaT9VvfZJLKxLnNypJzXxoKf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957558; c=relaxed/simple;
	bh=jGiueC+Dh5EN2Lejau2B4bSvCKR8MfH5CgBIgeJvpL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZa+1tGmkh3wsVNGPJPwUfTejPz9oHporxG1vHZfSRar25xWp4eTeiNcB0/piwQyfUA3RYc9LvUsshVw9PJN7M6vP9WJCcraCznCK/OhyUxPM3B+BmIRbpxiT0lbKUO+Qseh7BqifxlOkJ1sCcfDuuTrnl/3pt+5MHYJDH14f14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyA7MY+m; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7f61f41eef0so205097539f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957556; x=1720562356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIsdMzCagTnPqkjtDJJFzcS6RuUfrVRwKo+d8V5q9yk=;
        b=XyA7MY+m/EqNoEgzzSYCWZ5bGoPReQtgQPN8i3rfWZkJ71PdfL+UeLtYO8TLZsw8Bc
         lmz8l83LjgwgFxVhzvS9VzkLOjyXn8L3a+mE4jM0JFsXt4PucNLKW8lvtElDBXjhq+8X
         zmCo2/6OEdTs+/b4qjKSGaLPxpto1QjeXPXxCEcCSTOqz3eH2++B2UPXlahCygNeOr8V
         CCDnHqIeh+1CWrYaj6kfpyGFZeHuyMFksw2XzoL/t+Q5QyafLsMVIh3xldjdWaGQenf1
         renpFHNttgcaeoexSRIkDUnfb35gNJW2lF0iBlkollM4IWk2UU3uq+Ik9P1Jv4r1wqai
         +cVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957556; x=1720562356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pIsdMzCagTnPqkjtDJJFzcS6RuUfrVRwKo+d8V5q9yk=;
        b=Kdy7Joa2wWq0D22InxWyJNRtq8oyUL/DkmtiKyz57E+xi95cjQ8za3UnpcXKnr8pcD
         aMtyzRED3NuIQov2ku1bAjGV1KLWSkEbKYhcfpr0n5JS+Jwmak4ZfpWbMH8JtMzHGEuc
         m+YCVna43ePSux/FfGvnBsIwRTdzoi2WhpYC//m8N9Cmi8n0Ap5kNAdcf1Masgg4hbb2
         g+NjP+VD+NiKpQS0G5sT2pUgUqwDbDDC2/m1DPWVfoaf1M3SFxrTBf4NIzTEVu+HfJgK
         ALXAxdEsmf0njO0hdN+EiPmVYgkTpNcECBWJ6z2zZVkXPsSP+wnqRxYPkmFi4eheCthm
         ZVGw==
X-Gm-Message-State: AOJu0YxTXM87XaOdC0Y8Vu6Skdx/VUQxlkS0SXQ8W5eB7XgIkkW4zoOL
	Q2hkQAB1lixtCGDZuzIFdNwUBgsqijlkTAurbUDnNThB5KO1qaka
X-Google-Smtp-Source: AGHT+IHkqfivsiD8dHTonTZAnkys7OGTa2LDBnrQBx2fInhOiG5IlwUdftnx+Nl9cVfwsK85+z/TuA==
X-Received: by 2002:a5d:9544:0:b0:7f6:1f20:f137 with SMTP id ca18e2360f4ac-7f62ee3cc32mr1102400639f.5.1719957556538;
        Tue, 02 Jul 2024 14:59:16 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:59:16 -0700 (PDT)
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
Subject: [PATCH v9 43/53] drm-dyndbg: add DRM_CLASSMAP_USE to etnaviv
Date: Tue,  2 Jul 2024 15:57:44 -0600
Message-ID: <20240702215804.2201271-55-jim.cromie@gmail.com>
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


