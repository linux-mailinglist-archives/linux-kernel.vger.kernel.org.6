Return-Path: <linux-kernel+bounces-238494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F64924B4A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106C72829DF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1C31D5A41;
	Tue,  2 Jul 2024 21:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BI1nytXb"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15CF1D614E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957576; cv=none; b=oTGjpfAIfU3N1LPV9HxbVpYmYBr7Hrh531BEasF+iPUL2IkQmVKQ/M6Ji2cPlDp4X6x3qJKIMRgpBFnuoHP8kLdKzrEPGKieIaj58PfpJyKr3Vn4+fNQ/sEooClFeHNP3PuvY0HtxrFCYLn5prZgku5PmOvHSzfIizxBTSoVw+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957576; c=relaxed/simple;
	bh=ZdgkYt8StKCj0Myc4WWZURkgaMtctnUiCw+YT1im5Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kOsz50yV1flBV2vNks4GUjqamIUuCSNuNGvtAvgMONZeJ/XSKqRrrLAdRsf7ANk86BAZBPRRjz9KugADXbdtuS0d7cO5hdTDAe2rIuTUF0Hhe0SNTgKfwIM96ZeUjEmjG9xAsXAy/qEbsgW2+IzRgJHsiLIdp9lvPmoMCdQOPtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BI1nytXb; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7eba486df76so882239f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957574; x=1720562374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JTbEivvcQUwAcXrAriYcuJGP77J1qAidh1sZIrKRVg=;
        b=BI1nytXbw+vE+XlY7M0Ut+wazskab07Sleqt/8445wXm2MMrzKW2TqXNMRDekpIU07
         iDEv6aj/rG7G51a0IXEt86tkMRIONfElk3sd6oa8oLLGLGY6kMnwJK52MtZBDy8P8+7Q
         CVuu/M4U+wHhDVJdZSZC3lOFesZgmU/e5c7lNeyicpppSDyN2wBYDJBvIx/H2qz3Xo9k
         C7ZlH7tp3drxEyQNfPMmLckBKONaLTWULMreqHcfBDp7UhVkHUD4p90wy6IZVF5IwMTN
         ilHIKhZrl9rlubT1pzzZFLg65PoLZpUJgbLZM0J9vRw7kUK0MDFKolokJKXBusjRzBtj
         fGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957574; x=1720562374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3JTbEivvcQUwAcXrAriYcuJGP77J1qAidh1sZIrKRVg=;
        b=VStXRTiO3sp0MQrX0Bz5v1u7lfmJ2itc84ewuKJQwMCFt9LY2C5l5YWtEMwp+V/EXT
         r8X8EbTrNTgp1JfE5a7hB1x+nx54uL1GEfDbg651iGEGwIFubbz6uLhcQwxUAF7UQnAV
         fTVibY9cFuEzLPRVnBDUHfs5PoeASoGAyKsKhpVbhrSAxYL0voWx/ATcICg8LZuwmWWF
         nLizAf8AXIQ32SD5jI859aLd4C6qbh6TkYZxaqg4EJOuGuJ8CzjCxOw8JkcJRATzso7A
         Hh17BAJkfLWb8o2Ku9CZ9TyVibnyNcd8RemufmuGAi+giXb9jtLH1yu8RocFhLShCpjP
         +gGw==
X-Gm-Message-State: AOJu0YyQ128UZZsI8DoODru9/l9ybzs+Jw43jXXpCrZS436r2ZL3PnTR
	AhYeOkY1qMSCcvREqtcVrbGxvSyhahbXbUm6t1yefg4IWq2vGLoR
X-Google-Smtp-Source: AGHT+IHm0jXqTVtk7QVjjSb+zomWmd/7d6iWmMvK3abb0BF2wBUE0rEZf9n+FnhAA07EmTqJ9TZwcg==
X-Received: by 2002:a05:6602:45b:b0:7f6:4c8b:efdc with SMTP id ca18e2360f4ac-7f64c8bf2a0mr206658639f.2.1719957573878;
        Tue, 02 Jul 2024 14:59:33 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:59:33 -0700 (PDT)
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
Subject: [PATCH v9 50/52] drm-dyndbg: add DRM_CLASSMAP_USE to the qxl driver
Date: Tue,  2 Jul 2024 15:57:59 -0600
Message-ID: <20240702215804.2201271-70-jim.cromie@gmail.com>
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

The qxl driver has a number of DRM_UT_* debugs, make them
controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg
that the module uses them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index beee5563031a..1971bfa8a8a6 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -65,6 +65,8 @@ module_param_named(modeset, qxl_modeset, int, 0400);
 MODULE_PARM_DESC(num_heads, "Number of virtual crtcs to expose (default 4)");
 module_param_named(num_heads, qxl_num_crtc, int, 0400);
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 static struct drm_driver qxl_driver;
 static struct pci_driver qxl_pci_driver;
 
-- 
2.45.2


