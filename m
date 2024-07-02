Return-Path: <linux-kernel+bounces-238485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FFB924B41
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DADAB252CC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F481D4347;
	Tue,  2 Jul 2024 21:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDa0ZIjP"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEB6210195
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957566; cv=none; b=ch8mwUE+/LyrfUHOnExA3w5w432Gtitiuo7FkPW/DY4eMu361pahhgC3rF9QJ53jTIiXGny1Nr1oiFnN0VvaW2J+NAROTdMiYPr0GUiN55hvtpdu7Qpbis/9eoojkh28mpgjNehVaXBYD2MojTiMGpF+pcVe2o3Whd1Ux15OyWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957566; c=relaxed/simple;
	bh=oYOe2lhXkLlShr79+oMb5s3dimYUvU++xTU1aiSXEBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PjhegBtVIFVoevLzJmA47x7SQRXI1H2U8/a10HW4k/K9cpDHJoJj85tFUX/erdFBW0KZBREELzPpPJT1AVTVpMkp8oV5gNo7S8cmLMTYJaoLG2L5czOLz6g/xoVocaYXJX7cJruBG1x7J9vjAHDIVXv6AMrpvhRgtNVX10gm07g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDa0ZIjP; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7eee7728b00so189237339f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957564; x=1720562364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wh8QJ3ROh21ShBzcCiOPzlcJgoRl8pzdhd6qJVNHlVY=;
        b=gDa0ZIjPxyHgwjq7ICLFDFzay+hYAps3BNt1d99rQiff8vY0aZjnyG8Rv7bk4ptoLY
         HNmkJbaFz5VLqyWqQTEvm31VDBypitdxWkl4Hygx73RwoDzQH5+gb0wtM6NpTvJlxnyV
         RHiaegFfhD7bJsB1jZmIXiCXv7Yq08SyCqriofkIZz/tZ26CASjfUugbr/ZNNuVsLi0j
         03A9E8KRst42i6apqguAlKZxyzuHsibYBseVh0VMLsDZYlH3qFmEEUceX5oxFNy6hpZz
         D97C3RhXriMGkcX/mGg53qUg/Xv2ZX7BFlz6FBvWmN+OKgYNa0P+8mwVOpZF8HaL/60N
         61cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957564; x=1720562364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wh8QJ3ROh21ShBzcCiOPzlcJgoRl8pzdhd6qJVNHlVY=;
        b=LezMPYgLG7jDtaXpYLV++1CwBZddDIbVv24jYzoh+zPG8IzJ4laEULoWu3rCjFhWdk
         1K1ZJ/YzdJ9Psoypi8lfxCmsUTxL5SaUFXj0CAOErEdzwEK8TmoRYEvwJGYYn0lan38Y
         GVfMfFHn6MsDWOCrbD6GhS6PYYVBUoTDACjHu5tuGfzTVOVRdL3LcLJiuKdNw0nCwn0j
         vku4t2VDJsM1bhsUc0/rYZO8NL8n5AhzZMg6/P7X2gE8SBeqEWpF5I9b9gdaqG390sVz
         VtucOTXuPewBAPsil0XyfXvBcPfg2ALN+E2J+5pY5dDqdOKFlRizap9oxqkha70uAWc+
         8DlQ==
X-Gm-Message-State: AOJu0YxzeNIWNlqYSBrgDMscbvMyISq9nJ2eo+oc6axrJqH6YEJAbmyh
	dkzOXW1ephWl3SJgWHwV/xqRBrBPuvlY0la61AB0llWva1ctQiaNfeOzzQ==
X-Google-Smtp-Source: AGHT+IGsvIlCZD+c570Neze+GHw9bZoFgMkgtz4aIrGReUzG3qZZPt9ry6B+lTwl9sdSHvOE1K8YBA==
X-Received: by 2002:a05:6602:304b:b0:7eb:8874:99e0 with SMTP id ca18e2360f4ac-7f62ee3a19amr1042539839f.12.1719957564338;
        Tue, 02 Jul 2024 14:59:24 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:59:23 -0700 (PDT)
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
Subject: [PATCH v9 46/52] drm-dyndbg: add DRM_CLASSMAP_USE to vkms driver
Date: Tue,  2 Jul 2024 15:57:50 -0600
Message-ID: <20240702215804.2201271-61-jim.cromie@gmail.com>
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

The vkms driver has a number of DRM_UT_* debugs, make them
controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg
that the module uses them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index dd0af086e7fa..086797c4b82b 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -39,6 +39,8 @@
 
 static struct vkms_config *default_config;
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 static bool enable_cursor = true;
 module_param_named(enable_cursor, enable_cursor, bool, 0444);
 MODULE_PARM_DESC(enable_cursor, "Enable/Disable cursor support");
-- 
2.45.2


