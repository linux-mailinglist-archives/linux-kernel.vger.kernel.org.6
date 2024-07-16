Return-Path: <linux-kernel+bounces-254306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE9493319D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9EF21F26EDF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06181AD40A;
	Tue, 16 Jul 2024 18:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJ6zZFxx"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDE61ACE9F;
	Tue, 16 Jul 2024 18:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156374; cv=none; b=LOttdynRaUvlTIEy8qjy1Hxjl+Dc51401jwHmZlvVODFsDfwFaj09EhNYvou6msWdH2G8GYt+7TM7uT0UylY0KGL4qT+O9symCgL7JRP1gtRmXa8sNIfNjKmxvUfDefxCArbK6U3a+IlRGq4yqio/bfCwpBYIkMZzpgyWtsqXIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156374; c=relaxed/simple;
	bh=Ra26uMBZu3ZP5xzbYRr0cuuxt1adYwYS+TsR1/DN7dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p27oXZHKdCOgqK5MrnGTuYHXcGLLpf3UcI8XPi1C5IbwBYBnktrQja/IvdigMLYppHWN38ZJo3HWGe8i2VqosTsO8NWQDRIxoQcCZPx8820MZojxdgBm4arNSJTWRHV9yhw2T98kFONaWeaLLULzuB12X9ZB97gAXsxVy3f/fhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJ6zZFxx; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7f99d50c1a6so8672839f.0;
        Tue, 16 Jul 2024 11:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156371; x=1721761171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gp+X7P7M2G0wGzmEuARHD4YdNz5MLe60OdfLiwoM2pk=;
        b=cJ6zZFxx8//rZ/R/I7IX63UA6uFo3KWaRXBAhCeiXGJUyTs++9x4h24oaj4r+FifQY
         RzDrm3OE5dmpvJfzOsabmA/Gper7hm9NcR0c8S70s1WH4YnDKOV6U34jcLuOTKf6mRz8
         PmII9rMQi0jx2hJcc4Ys2+WGheiayQ+UxiH1S+zuLEjQtxLP1tjCZ11esQUpyhLCTytQ
         oHEWtyMHxvg1haPatnYPENpzyIBzcdoyVNpmbUbWh4T6FUrBYztmIqm982o9axg0EeBn
         /b/A3zOU76NfSdNnzf1PnoRCtl19OslRmmXX1l0NcSUk96FITBUaho/oUQMM4Zv7iYBo
         ew+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156371; x=1721761171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gp+X7P7M2G0wGzmEuARHD4YdNz5MLe60OdfLiwoM2pk=;
        b=hLf6YASn132GoEDiBoO/3m04LLYxR9PLM+e1ZCiQ9TMAK9+/twxMQXozQaaEQpfDbc
         rOlW691GMCg7nMWS9MP4E5o+PPWw6drpm++Adr/3C1K8hMh8mBjDjpmTmC0b3/Msw+oG
         Ctg0z4seSap/7JCeBTwANkvgafyHDAWDbDvQW+3z0/qadkhk756bvHMTeEjDKhijlqNT
         rT+ScbylWMzDKMpnkL9blR0MIpm+rnEmA0PY6CJumGjnaaNFpC6GrTxGnnR3YNndnWYd
         b2SMjiedqLr4IhlB9fuU098H2dmBoKv/AUgFVYLKe8E7/k19EclQL0JdAxDst7qRC9Ro
         8kOg==
X-Forwarded-Encrypted: i=1; AJvYcCW1qHkDMnIvvKg7Sg5zgCs3aot0f4twXjOdtd5MxtvBdgC5Pg0cExQN+MwjT3XKhXaI4e+tYUlr6l8xiU4MSTXN4PfyQFqqjfIf
X-Gm-Message-State: AOJu0Yy+iIHU9F+e6nSdqOYknVJYTwRLGDoh1B4WnHoRCaffhuyhANiV
	LyQKXQhmKieKgM2jay+UEqapZo02nx8GvDeKnq76SSk/SsovQ6x+KykSN/Pu
X-Google-Smtp-Source: AGHT+IECS3LE4CQlGR6D3c9f2we0UYXUMv74VI2oB5R/1GanbhvcHcS5G4efhI9oRo+zYRzuj4p1RA==
X-Received: by 2002:a05:6602:14c6:b0:813:f74:e6df with SMTP id ca18e2360f4ac-816c51c790bmr46646439f.15.1721156371575;
        Tue, 16 Jul 2024 11:59:31 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:59:31 -0700 (PDT)
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
Subject: [PATCH v9-resend 52/54] drm: restore CONFIG_DRM_USE_DYNAMIC_DEBUG un-BROKEN
Date: Tue, 16 Jul 2024 12:58:04 -0600
Message-ID: <20240716185806.1572048-53-jim.cromie@gmail.com>
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

end of official submission.

Time for some quality CI

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index d0aa277fc3bf..c508c0834641 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -56,8 +56,7 @@ config DRM_DEBUG_MM
 
 config DRM_USE_DYNAMIC_DEBUG
 	bool "use dynamic debug to implement drm.debug"
-	default n
-	depends on BROKEN
+	default y
 	depends on DRM
 	depends on DYNAMIC_DEBUG || DYNAMIC_DEBUG_CORE
 	depends on JUMP_LABEL
-- 
2.45.2


