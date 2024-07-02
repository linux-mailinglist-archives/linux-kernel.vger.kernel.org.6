Return-Path: <linux-kernel+bounces-238487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 052B3924B43
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B9851F218AC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8090F1D51B2;
	Tue,  2 Jul 2024 21:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RM7mHek8"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776901D434C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957568; cv=none; b=tTOjq519GQxn+UwGB3iWksbaZBmmD1zN4Yp4mLOAWF/hGbBhH+7VRUFyOnv7nH2DB7LV8ZMUJJxUfdxei3KJDcOZVuy5jC+wzuMd0tWusmob86sMOc4DGuVJgh92uxPwP8DIc0WexsJD1b5f8tJLT2vmIrU75x1+m6JJbo8JyT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957568; c=relaxed/simple;
	bh=y0Zoxeh2NDhcrC27lg8sSPwKxWiQbpVmdMoWiREKFWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NPqFDyLtz1QJ3C8Kjj+BK4UpKEOcogg76FvLT75PSkVJ/HLOdgfMkLTBNo+oXATKv55mUR3Dq0UM1ya8gozQNisNq1hL3Q0IVm+iZjzDcAyHyGzdfcFOwPQHb7qt7tAfRxVABr3QgPL3fSjnDktWlorfBDcX+EfSk2aGyqz1C/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RM7mHek8; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7eb5dd9f994so174440439f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957566; x=1720562366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0YsvOK5afJ8qV3rkuOU7CKX9HpGcds0hiKx8bDl++s=;
        b=RM7mHek8/SbHNyNOAJEqx21rAbgVG96xcsrf26ErhYfiNzGeVIbU8gg3r3j9WiEvxL
         lsvT4ewAGueITdYwpFGoPTjf/z6xypHUdUOWgSNS5SWCwt5AqJszci0WGhMRiT/tn8Eh
         5ADrqeMY6qaPieUObdB3q+tmdOmIYKIzd5xCV7XAr9tUKV2+4Qwsn5uw3QubPfSzbqjO
         Agos5Ks0AnRW8PwoA7itr3eGkfqB5+Kg34yEmAZ2CDucQXCDWFHtruCpb/T6FQ0FrCjD
         PlKlZ7XtmCDCnsT+3hDxmY/MIvxRwhcQB1HAztLtNDLnBuUK+twqURCdH1M52ZiN+kep
         cUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957566; x=1720562366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0YsvOK5afJ8qV3rkuOU7CKX9HpGcds0hiKx8bDl++s=;
        b=JSdzEly3/sKgyTbeW6h/GVj7F62MzumJcNzMuSR6XnaToIu3wuX21podQq80jXrvJP
         zu3MXlvKMOi2Yba0lzys8+wPGzmPCdCnMFCkJaBU7zaGMxqfk6HgrNwBcrKqNMCFcTkC
         EjCgDp/PcEcsNafio+JmAGB3zp/IKWAIdn7GXl7QNBoGaOkaYMbdiiAQU2Ws7J39/FVZ
         gNsWbW58w87n5Qzyf57xHZeYBnMsyPzvd5c533QToPYXX0oA8yiD1X5ctvqdbGBV1uRZ
         JkTOhpF5kSR2lW3YMCnNS0osP4mf63gY/wx5Ls9JKP/C16NvnK8tmJ/Fgaloq1Zxs5y/
         SSaA==
X-Gm-Message-State: AOJu0YzuHaVXdZEmtuQed9MfGp5NCjq8QGW20HpQ4Kc3wtmn0OE/wJ8V
	zii5PDVkwJxOlDm7vgBlLw/G8GRWAcJFndABTlq23xlEW02p9ecr
X-Google-Smtp-Source: AGHT+IGvYws4ZnTk2jdkfQbNphXRfxlVgTR2bSz3FZORd7ias08UfIGbv4urN9er+A1Gk+gnXV2vKg==
X-Received: by 2002:a05:6602:1306:b0:7f6:27cd:b054 with SMTP id ca18e2360f4ac-7f62ee17f56mr1125065139f.4.1719957566686;
        Tue, 02 Jul 2024 14:59:26 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:59:26 -0700 (PDT)
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
Subject: [PATCH v9 47/52] drm-dyndbg: add DRM_CLASSMAP_USE to udl driver
Date: Tue,  2 Jul 2024 15:57:52 -0600
Message-ID: <20240702215804.2201271-63-jim.cromie@gmail.com>
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

The udl driver has a number of DRM_UT_* debugs, make them
controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg
that the module uses them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/udl/udl_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
index 3ebe2ce55dfd..ba57c14454e5 100644
--- a/drivers/gpu/drm/udl/udl_main.c
+++ b/drivers/gpu/drm/udl/udl_main.c
@@ -19,6 +19,8 @@
 
 #define NR_USB_REQUEST_CHANNEL 0x12
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 #define MAX_TRANSFER (PAGE_SIZE*16 - BULK_SIZE)
 #define WRITES_IN_FLIGHT (20)
 #define MAX_VENDOR_DESCRIPTOR_SIZE 256
-- 
2.45.2


