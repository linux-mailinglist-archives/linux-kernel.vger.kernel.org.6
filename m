Return-Path: <linux-kernel+bounces-238488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C3E924B44
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CFCD2815FF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E821D51D1;
	Tue,  2 Jul 2024 21:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgmyQL1r"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8733E21019B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957569; cv=none; b=NIwsQebCe+arDjr4kVN1F5upEadi/UDm46ymhwsDRxAGvKzMtJ5n5xxnPV0CfigJ00uLovbLTH51qaSUM57/xqSLdH6q5Y5ipk4HgmUC4n50uK+ZXHRNSVycdMzecYxwEJoqv8wZF3f6GIVYppoZXwEbOG++utOBUTKjNbuKtg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957569; c=relaxed/simple;
	bh=oYOe2lhXkLlShr79+oMb5s3dimYUvU++xTU1aiSXEBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ER0XkgVbfhGHj2/rAkxXwdrjIRAIkI5ARbTLcF9sAVuFakZLGcB37MGxzGKPut0wsB6mO9SRA5hmnDFZE/AIRx95+XkafX46lzWj4L3iP25ZJj8vCYhpRqVzz2e/lzZ5HZje1xlqYLzZPpswT1FHQcn/Z7kMVq/7oFW0eqyiEcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgmyQL1r; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7f3d2d441e4so148789139f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957567; x=1720562367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wh8QJ3ROh21ShBzcCiOPzlcJgoRl8pzdhd6qJVNHlVY=;
        b=IgmyQL1rNeBr3v/GBGHQYNCSTf2se0onKda7nx8ViUz8pLybdd6a/ua1Xpt+NTYDPS
         dI4Jtd03yIAKVfy4zAyeDh0VK/pWyMGwXMVYUlWxpEDdoNCJDKyhUr57xHsF1WDx7XRB
         /mn9asuehn6TkU84s/HD2ZfDOdIu9j1ACiKZQVP/+LkAWPiUiDT03L/8xE2hggUqH3tJ
         LpmCLmhXLPa4nqoQsFRAZVWxDY4eGKyGhNJe2UBlrHYwVADQKPIGPyy1p4kaRuj6UCLh
         FvrZiPlmoKOqEyazbOrsDTSxMhaXZ/41KK359wL1ouC7mcKvvNGQga7RbbV2wEK9FE+B
         2xZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957567; x=1720562367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wh8QJ3ROh21ShBzcCiOPzlcJgoRl8pzdhd6qJVNHlVY=;
        b=GDbk+e1bnftjz/V4nU4ZujOLybD1Pf3Zra4ib9ecaK2S02RwVoRAtlJ1oNFWHQCT8t
         WRQqtFkJonnZJIBeFF6exRGgIV3kxUTAiQK60suDti8G29sEUw67Z1k2rFYTTARIfUz+
         IWGBigbRgExj0o7ZGOr1K4rsoPPvWIFXITXLAUHaVeIqwdLFhn6TF7uBHfPve6qmRpej
         6hiMANv8C+9Mokc5IeVy0+Qd9ZUnO+v2igsiihJ71yKu/0tY/7hTO0a+xmwenbViQcqt
         /QxdVWMMxfjiDr+8GWCYptpSIlsR2dN+iHRUuMYJnj5ILSl8C68Spzan/Xb7j+UDAfZK
         Dl4w==
X-Gm-Message-State: AOJu0Yx8X3ko+qEKrCsaRe/DrteV5VkXkoTi9UDUei026dQF8w7MfwNg
	9lT/v5tl3ToIHvbt55zdFl9QZB4WbHVDjjt2W8W40lCX1m6+1Hu0
X-Google-Smtp-Source: AGHT+IH3xH7tho2sBM1GSeoWG+NM2MBhz/xyUPt2gcXQi9kj/rdgFoV4pSxxHWVcBZJh0cz14Ndmig==
X-Received: by 2002:a6b:6514:0:b0:7f3:d5d3:3e56 with SMTP id ca18e2360f4ac-7f62ee8d268mr1165752739f.17.1719957567640;
        Tue, 02 Jul 2024 14:59:27 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:59:27 -0700 (PDT)
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
Subject: [PATCH v9 47/53] drm-dyndbg: add DRM_CLASSMAP_USE to vkms driver
Date: Tue,  2 Jul 2024 15:57:53 -0600
Message-ID: <20240702215804.2201271-64-jim.cromie@gmail.com>
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


