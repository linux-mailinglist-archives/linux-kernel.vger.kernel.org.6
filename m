Return-Path: <linux-kernel+bounces-393143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9069F9B9C54
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 03:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA1E1B21416
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 02:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B8882890;
	Sat,  2 Nov 2024 02:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvN+bs8R"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281E1249F9
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 02:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730514144; cv=none; b=gdT0ChqpnRVTobPET0ZzD8IXzIZro1bv7ueOx/rSGD0qCTYsv7Pns1kFoRvNQf9e6CVCqZnySa8OZNPGDCJeTHjr4JzCFwA6Sar4Haxq64CkntZFeF1dZ5yc0fkKPL0RFKqvStWVR8vS1RTZVU9yzzrnHXIrCylQ9tFZS0k4Mzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730514144; c=relaxed/simple;
	bh=1xjzQWAnB3Ay2HOz1oHv3HZX5UPhRW8Kvtv7NPXaG/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=JuOd2eNnUJ0NlaH52XnmH3IodtwlXTFGZ5+UWfFqmqhmryIygRbG819uOep3rITQrHcjpzyXYKAc4X+i0+gohXxFp/6tU1+iFBZeiMyu0O4y9SPPN76hAsS4AmDyA/R7XiPi/U3jecepAanvSZlnTRaytriBceukSrH1+7IozFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvN+bs8R; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e4e481692so2327931b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 19:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730514142; x=1731118942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bXcmHSC56/ByVBCx/WoZJC+GVyQ+I9bFtyJEnrciFRM=;
        b=SvN+bs8Rqsdy0LBnE/O0AwkGtJ/cwI41MZSP4hBA5VEulLs9GsIlLTew9C7/j2tCTh
         c8nDvCJQb4euoBnbXnvD6rlTAvQcuJCYnZ3MJkhPFHJy8CS8j/j+Xi/Nyf461pZMU1V2
         //Cdc0hG2zZJAOZHM/FCsYqw6PVgNwMvdYkii6jzmEOgBghUy33aqox374AdwpAjaAEW
         t7DUvC2u9gDkBj0HnnITyeReVf3s203VRaGMoj/I9fJjpk95LSVvzBxKYbELYbXFJQ2A
         N+xdbTa3rXhiO3q57JkpDzUBpPGmXFbA4wznS0cnEtung2PKpxVQh/ZLo+08gqbYanIN
         WyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730514142; x=1731118942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bXcmHSC56/ByVBCx/WoZJC+GVyQ+I9bFtyJEnrciFRM=;
        b=Is4xec/cs+5hTkMAdNyvXdvMDGLGCfc2PdpOMnJ87hWQ6FRoB6CKO5IhIz7Kws2j7S
         B2VZ0KEpJPtHF8o1MjrMajt4GqZKsx4RhXKy2MEu1OoDPk/m7K3MlbPNO6ujSbMcbGUs
         GSCKVy9hp0PqO7q27H4yaVUWKKRToez1Qn9DMMEYCfpvQN4jQjYESWF0lTJIN+U3dVSm
         NOkC9c2zsX0VCZhtGBH/fanGz/xKt8cnglqgC0qyBYeW5vUn7Xlutw+AIya6loByFtHc
         OjetCHZk7gy5o55RcTY8tKTCKNwFGWnYHm33UyrWBvkWckxCHLRKxcOTGZ9h9eD64keR
         2kbA==
X-Forwarded-Encrypted: i=1; AJvYcCXpoMqVOLxkhAgE9IjiaTf7noc2fdC5TLlejOxHapsxPXNvaBsVDBPKppG5lnHv7RqDqDubo/cpHO/Fvdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBFu1hNMTzmS2EGp9hDysD08H1Zn+o5smld+wWqlZi3+3qg/+f
	XtSRppg9XKuEHSibVmEYpgLM9+LCQ+J/Yd7NYjdcShce9qfNn47L
X-Google-Smtp-Source: AGHT+IEHigW4MYYWdNAxbx5bIv2fu2U6puZvygq0xmtIkT7iCcQH7EHK42vEZXwu43CanE6Fs3xNPw==
X-Received: by 2002:a05:6a00:1746:b0:71e:fb4:6c98 with SMTP id d2e1a72fcca58-720c99dca77mr8600897b3a.23.1730514142299;
        Fri, 01 Nov 2024 19:22:22 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([59.16.200.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc205582sm3363387b3a.88.2024.11.01.19.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 19:22:22 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Gyeyoung Baek <gye976@gmail.com>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] drm/xe: Fix build error for XE_IOCTL_DBG macro
Date: Sat,  2 Nov 2024 11:22:03 +0900
Message-Id: <20241102022204.155039-1-gye976@gmail.com>
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
v3: Modify to evaluate cond only once.
v4: There was a mistake in v3, send this again.

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 drivers/gpu/drm/xe/xe_macros.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_macros.h b/drivers/gpu/drm/xe/xe_macros.h
index daf56c846d03..51ac8faa8975 100644
--- a/drivers/gpu/drm/xe/xe_macros.h
+++ b/drivers/gpu/drm/xe/xe_macros.h
@@ -10,9 +10,13 @@
 
 #define XE_WARN_ON WARN_ON
 
-#define XE_IOCTL_DBG(xe, cond) \
-	((cond) && (drm_dbg(&(xe)->drm, \
-			    "Ioctl argument check failed at %s:%d: %s", \
-			    __FILE__, __LINE__, #cond), 1))
+#define XE_IOCTL_DBG(xe, cond) ({					\
+	int cond__ = !!(cond);						\
+	if (cond__)                                           		\
+		drm_dbg(&(xe)->drm,                                    	\
+			"Ioctl argument check failed at %s:%d: %s",	\
+			__FILE__, __LINE__, #cond);                    	\
+	cond__;                                                        	\
+})
 
 #endif
-- 
2.34.1


