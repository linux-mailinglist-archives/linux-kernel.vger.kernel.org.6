Return-Path: <linux-kernel+bounces-238497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C0C924B4D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D84E31C2256E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E181D7028;
	Tue,  2 Jul 2024 21:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J127ICCx"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08071D691B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957579; cv=none; b=EsFDarCGm0SXDkf7N440TGE5sM8/Oy4yRbyWvCki3QdPQXRKS8T27Lxw476F8rDFDGTvvBqgvUogtzXE2kmhyzXUPMjJkPpJ3OWyWeKRGyS3ErpXeuKqfX33lGxSR9paROJR1bIpBpKXskV/HSk2q8D+UVsdWGL2FRUJ8N03sdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957579; c=relaxed/simple;
	bh=RLkL7ykGMweuG/V8iZOSvPEUEytBCsbn4Qh/HeooHHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H04mQ22k6XsIeSbL5GWh4DImsWrMZhTAkHMH/xARlJInAJ24JnEmk3GMtQriSuaw30HniEfbJD6YHGX/KueyW+N5+/Fv3q0boEY1eSHU+G2wfAwbDC9N7ESkPYIrtqREQgkt89YBOQGnpfV8Az9RAdiXTtSDYlBQForX7pAP4T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J127ICCx; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7f3ca6869d1so192060539f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957577; x=1720562377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvF7XGglS4kHqkr9T4qnSlSKUYwSoR5J7DGEbyHu2+8=;
        b=J127ICCxZBixnJr6SzX4w1Fd4AOwPrI9wwi1ehwJTaCqamPGUnFaoGlCxOF9Tpe3Uo
         2KLdZFWNHIT9EuLz2hSZhw//GVinwc1YPMMtmtMOil559tfQC4chSmNXn5l2jCNPKP+a
         kgtVW31xVaK/WHEx1w3sVzYbjjIxG0wwWEhjMSSuTlN+Vup6epf1uxCcgGcTUoy49ZPW
         0CKFrGZC73Cai3bQ6BhYAB8XcopHiOvmnxWwq9/pKG0nraViBzkRGnayl/14y+i/xL/e
         jxwItrzOpu0597RUM0VE0ION0e3TQgSFiHVj/yiy/LNCgvER5E/bhqcghtDZuQMSM4fN
         8eKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957577; x=1720562377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QvF7XGglS4kHqkr9T4qnSlSKUYwSoR5J7DGEbyHu2+8=;
        b=R6TgdXqX0Aaoa2DZyIcSX0gDPIevCN3TFb4unUaDALgrxVJTSe1fodRLeAsk6RmRPD
         qS4fcJ/DuwmIJLBLtCMu+qORq0QhXk9xM+zdztbQ4Sg1XdgpaIypPn7ZCB+5HbNmYauX
         rOIBDAvp5vxc9u31NkA0/4r6HebiFc70TluvGKfllp8jcKb7zzbAoFSsdWzbS7oIL6no
         F9VivyUZsK0IJYUhrh6wI5nA2KaQV9+sy4BXrwC0VTC5j6zeSPG0nAosBLNau41rlLo9
         pMZ8XFiaAzXh2no266Kqs5XqMnPFQalxj5wNuCM+ri6PAyxiVahY/iTFXWsVVL0G+HWO
         T23w==
X-Gm-Message-State: AOJu0YwohuMCIp2jdM+6d7/F8EeRoq1SvZDiB8Ymj6lnuZ1XPtnrMvTW
	Dda8CjELIivXjRt7MOLEWKgDQhkiVuG1PQG+kmSYcp9gtr8Lag9Y
X-Google-Smtp-Source: AGHT+IHr+XWp6uUkEIN9sTm3FPIKljPJiX78B0Egj7pbRiS24t9LgvM6Rlaa2+c/8txTvNCTHxslPw==
X-Received: by 2002:a5d:8418:0:b0:7f6:2c16:149a with SMTP id ca18e2360f4ac-7f62ee6e7c0mr1127312339f.13.1719957577095;
        Tue, 02 Jul 2024 14:59:37 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:59:36 -0700 (PDT)
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
Subject: [PATCH v9 52/53] drm-dyndbg: add DRM_CLASSMAP_USE to the drm_gem_shmem_helper driver
Date: Tue,  2 Jul 2024 15:58:02 -0600
Message-ID: <20240702215804.2201271-73-jim.cromie@gmail.com>
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

The drm_gem_shmem_helper driver has a number of DRM_UT_* debugs, make
them controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling
dyndbg that the module uses them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index e435f986cd13..066d906e3199 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -23,6 +23,8 @@
 #include <drm/drm_prime.h>
 #include <drm/drm_print.h>
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 MODULE_IMPORT_NS(DMA_BUF);
 
 /**
-- 
2.45.2


