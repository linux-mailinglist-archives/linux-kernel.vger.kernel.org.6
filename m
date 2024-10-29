Return-Path: <linux-kernel+bounces-386542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6208F9B44D4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 849E31C221AF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C19A204009;
	Tue, 29 Oct 2024 08:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePAKAKiT"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8769A2038C7
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 08:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730191762; cv=none; b=Ff8wqTN+6Uue7mZBJ5t9HthTUSNlZNu1rnuH/UDfTylEEYUVVG5iYZI62Nkhsl9cw7AjT5+gmWRzebWhaIBCfqL8NuxXZ3aCOiGkVhDFex8mb4c6SzurIaC7ddHykW5dtXNg+K/9Po6yGycv4AVlMNoks/NHsRaKnizGOV4ornk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730191762; c=relaxed/simple;
	bh=zb6s5QSNab5uGv6gxOiZNnPBCrUwpJdx8jSdIyfQ8PQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=amRUVMZR+ULvYtXN7SDt7FWtMkV9tm2UvZOma5GiFLxr8N5O+FnPf+ZAvQr9z06RBrXx6fsdMD5eHaSeINgP2LcemWcxvbjWWgg5SQvyW/TlBlGlg5tLc1osSa5evdS3nJ98Kpfnuta6Ntsa2a4eciG8B5L0KJx/bV/jtvfCL5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePAKAKiT; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e5130832aso3634194b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 01:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730191759; x=1730796559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LoOFfYpo1uCoXTqMLL9mhUUj3EdIXvRo1zOQLi0+PSM=;
        b=ePAKAKiTlEge8/6QAiJkgeXg1eHzCb7HdyDua59nLJ06pcKr0j8eU84bnoVYVVkxFu
         ToZYppZb08a4xaNbR2PGVpfYJfL3mRa+nAwvNeqA9pmmst9JdF955BvccGuDWpumxtDJ
         igV4nNsL1BVKC8W5jFBl8dg9wcXlAl36KChxk2LyoC10nENP4KTWmnAOhBodJS+G3+WH
         dAY9W/OO8HAmdB7W+4l8z8NTi+bVXuDp/MKK8bst0frmZ2NXeVqJ8AlOFkUAxQkvUjOi
         V2YN9d8xv+8VRysXomCx0ABEfYJXjCkVoJ2meY95cCRszMwTNldDqWja/jFxR7Qn5uk3
         2wHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730191759; x=1730796559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LoOFfYpo1uCoXTqMLL9mhUUj3EdIXvRo1zOQLi0+PSM=;
        b=CLw3LEx1nanHawfKqlhAP+BZvcGpbXP56eN2uVOygZ6HJcjfoYUltqISpQrMsm4FYd
         lDztHAvdAoTxos+GXJFBAIGZBJJD0T7Q6VH+jUfOTXmpLBJI6XuK48+WvwarOx8w5IB7
         u/+9Fx4mYML5/XFHvIrBtCF9qekgKbfsblJscFMprYL3mhrtjnsYzDa/dpqY5hjE3lc5
         CYdHbZO+LIFiY1KHQjldqni4AUGimaYvtqpUexzx3cY1HVmPNidgKDCG6Rgm43mDN7GH
         vdfJx6sHS8MuVEf5KlqwiFSUsbHzXR3lVQcqAptCpJkuwldpmjRTgqvRnSbjyAsf1rPB
         k+WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNwrryRhdo5Ro+F1XjQY5RdRbNoTgZopUshWAq/A2O6PSrQg/X25QrFW/ijwh0IcLbUnTxbOD+S3TrpDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBgD8FSFSV3zIHiuMb5RxKp+SC9/DzBStxjfnGr/iYPXNcSF3w
	Aan1kCmzzeZ3XsmtiuYsQLDLEe3TQDVEt4deHaCpBfZv+h8S3YY4
X-Google-Smtp-Source: AGHT+IF6/PgyjqWquahL8uc5W3n0vli3ePD2PTK642Axmywaf6SYTUzPfIFPcaYdUjyCxGVsyREoDg==
X-Received: by 2002:a05:6a00:2e06:b0:71e:3b51:e856 with SMTP id d2e1a72fcca58-72062f4bdfbmr15623858b3a.1.1730191758317;
        Tue, 29 Oct 2024 01:49:18 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([39.120.225.141])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a1fe53sm7122491b3a.162.2024.10.29.01.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 01:49:18 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Gyeyoung Baek <gye976@gmail.com>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/xe: Fix build error for XE_IOCTL_DBG macro
Date: Tue, 29 Oct 2024 17:48:58 +0900
Message-Id: <20241029084859.135172-1-gye976@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

if CONFIG_DRM_USE_DYNAMIC_DEBUG is set,
'drm_dbg' function is replaced with '__dynamic_func_call_cls',
which is replaced with a do while statement.
so in the previous code, there are the following build errors.

include/linux/dynamic_debug.h:221:58: error: expected expression before ‘do’
  221 | #define __dynamic_func_call_cls(id, cls, fmt, func, ...) do {   \
      |                                                          ^~
include/linux/dynamic_debug.h:248:9: note: in expansion of macro ‘__dynamic_func_call_cls’
  248 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
      |         ^~~~~~~~~~~~~~~~~~~~~~~
include/drm/drm_print.h:425:9: note: in expansion of macro ‘_dynamic_func_call_cls’
  425 |         _dynamic_func_call_cls(cat, fmt, __drm_dev_dbg,         \
      |         ^~~~~~~~~~~~~~~~~~~~~~
include/drm/drm_print.h:504:9: note: in expansion of macro ‘drm_dev_dbg’
  504 |         drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_DRIVER, fmt, ##__VA_ARGS__)
      |         ^~~~~~~~~~~
include/drm/drm_print.h:522:33: note: in expansion of macro ‘drm_dbg_driver’
  522 | #define drm_dbg(drm, fmt, ...)  drm_dbg_driver(drm, fmt, ##__VA_ARGS__)
      |                                 ^~~~~~~~~~~~~~
drivers/gpu/drm/xe/xe_macros.h:14:21: note: in expansion of macro ‘drm_dbg’
   14 |         ((cond) && (drm_dbg(&(xe)->drm, \
      |                     ^~~~~~~
drivers/gpu/drm/xe/xe_bo.c:2029:13: note: in expansion of macro ‘XE_IOCTL_DBG’
 2029 |         if (XE_IOCTL_DBG(xe, !gem_obj))

the problem is that,
XE_IOCTL_DBG uses this function for conditional expr.

so I fix the expr to be compatible with the do while statement,
by referring to "https://gcc.gnu.org/onlinedocs/gcc/Statement-Exprs.html".

v2: I modified this to print when only cond is true.

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 drivers/gpu/drm/xe/xe_macros.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_macros.h b/drivers/gpu/drm/xe/xe_macros.h
index daf56c846d03..ac2bd103bb22 100644
--- a/drivers/gpu/drm/xe/xe_macros.h
+++ b/drivers/gpu/drm/xe/xe_macros.h
@@ -11,8 +11,12 @@
 #define XE_WARN_ON WARN_ON
 
 #define XE_IOCTL_DBG(xe, cond) \
-	((cond) && (drm_dbg(&(xe)->drm, \
-			    "Ioctl argument check failed at %s:%d: %s", \
-			    __FILE__, __LINE__, #cond), 1))
+({ \
+	if ((cond)) \
+		drm_dbg(&(xe)->drm, \
+			"Ioctl argument check failed at %s:%d: %s", \
+			__FILE__, __LINE__, #cond); \
+	(cond); \
+})
 
 #endif
-- 
2.34.1


