Return-Path: <linux-kernel+bounces-402405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D8D9C272E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 22:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C50F51C21480
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 21:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A5C1F26CD;
	Fri,  8 Nov 2024 21:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mZpL+wK0"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85A31E0DDA
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 21:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731102599; cv=none; b=EiOnxf77bdqtP9zO6D0mP6PpeerGj3oyghaAm7Jub6mpR57Rp732kaKOZ8t2pWljM9IV3xoVRTlfYXWl2ITYh7sWHDP4bPjPWv9BBMrpk/pQRMK+RMMkNzpVXYiRnc/x4j7XlO2m3+3pxg8tgYEX+2FJUKXPvFYS7xvaf6L2eOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731102599; c=relaxed/simple;
	bh=1yrF4jnXLhnSfWIojTz1DEjyYTazYPoSLrO9bq3y4RI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oV5v2ZvF+B3Fg2WmOxDo9YFfgmcUlguVTAbU19lx5LvbNoySMsFKmTpsOfIH07pV4v8hXesuJRsVc+i1lAhiv2XMB+rJlPj3WqG51dQzkbTtDqe2/cO45gG7XZe3Ii9U5f4kvBhzwKm/IwTNsdd37gqggSWSxgo4jNn9gWpYaUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mZpL+wK0; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea258fe4b6so51206327b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 13:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731102597; x=1731707397; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Af4hMZ20VDS1C3kB5ShD2dxZfce4JKGeXzwvkb+Jdoc=;
        b=mZpL+wK0xWwtPnjbZPg8O9RCqt0Td6ECWZ8xZmAnNt4ZWvr028G/lJ3llxIfF9/zCr
         yQ9nUWEAuxYoYcfJXRvCf/8WO1vF0NLM96LljrVO/rE4FPEXGZxSIyzX8sCwiXoH6hfb
         7LtXqCJkOlB9gxsgZkNGEPyJC9nWOMr1F+BXaIKW7v8wGtiOXQSgDta33Z4zOUZtbWUJ
         EIxB+gO8x1qeI+z+ldeU0rBymcx59kOgp61tvg0y2pxujf/Vp4z8tsz1SYP6ksl7IVow
         dexQafp2UlXQxAZD4lzAvVUEPR7WQnpzWWp6VNjP0cIiRrloJPd1311VlGRFCjnq4sYz
         j0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731102597; x=1731707397;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Af4hMZ20VDS1C3kB5ShD2dxZfce4JKGeXzwvkb+Jdoc=;
        b=smdRlooeNoU0wnIwRdQVOHm9lSy037v7QUIUnviqq1/O6xuvzueiMk1eMoFdj9/vif
         7zDFJnRC8UXetZUxNv4bFjqHYYFqw+VFL5uhizumUWqZH8umIb83TwfS+U8Z0t4RvMUr
         czahHoKeObCwU8QZKFs1p8jFujOe88P/EbJ4q3/g5atZyUru4t/IPM9+zdSojk3oOio/
         Gt84lt8ndIK0rSFtrwcEKSrO0b7QgzKDbFsl3xGENKgEY1CFIr6sINeF1e+wzY6/csm/
         AyVJm3ZYo97SZMWtLmmp1pCjSrKCl5R1YnoT6bu1hV6lY3GyUfGEmXUuPj8W1ZIJNOw2
         ZKug==
X-Forwarded-Encrypted: i=1; AJvYcCU4C1fuzgQzwTEtC20odathciK1/RYnHvNagQNYt5h8AAB5qRkxwWFWju5sSqwg6QL9qqiXBw8PnSdu4ek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0E4RsfrX21nhJNO3NolFs+Mrzcm9+GdGDfpoKYoboX2fQ+D9+
	4K/H6IEbC1+kPK8BltIhwwB2vVJe3SoYBw9g46lQdE+xKSab0rAEBA93t6PPF5j3bw==
X-Google-Smtp-Source: AGHT+IGY5DjIqopeDmsWhcIroI1hvNOh14a/8IP8B3zDQoN6tNo8YsyS7v29bZZQV4LsFJ1jdq4Wj30=
X-Received: from xur.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2330])
 (user=xur job=sendgmr) by 2002:a0d:de02:0:b0:6e3:f12:1ad3 with SMTP id
 00721157ae682-6eaddfb6818mr536407b3.6.1731102597002; Fri, 08 Nov 2024
 13:49:57 -0800 (PST)
Date: Fri,  8 Nov 2024 13:49:53 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241108214953.1160765-1-xur@google.com>
Subject: [PATCH v2] kbuild: Fix Propeller build option
From: Rong Xu <xur@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Rong Xu <xur@google.com>, Han Shen <shenhan@google.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

The '-fbasic-block-sections=labels' option has been deprecated in tip
of tree clang (20.0.0) [1]. While the option still works, a warning is
emitted:

  clang: warning: argument '-fbasic-block-sections=labels' is deprecated, use '-fbasic-block-address-map' instead [-Wdeprecated]

Add a version check to set the proper option.

Link: https://github.com/llvm/llvm-project/pull/110039 [1]

Signed-off-by: Rong Xu <xur@google.com>
Reported-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Nathan Chancellor <nathan@kernel.org>

---
ChangeLog in V2
Integrated suggestions from Nathan Chancellor.
(1) improved commit message
(2) added links to the comments
(3) used ld.lld version in the version check for lld
---

Signed-off-by: Rong Xu <xur@google.com>
---
 scripts/Makefile.propeller | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.propeller b/scripts/Makefile.propeller
index 344190717e47..48a660128e25 100644
--- a/scripts/Makefile.propeller
+++ b/scripts/Makefile.propeller
@@ -5,7 +5,14 @@ ifdef CLANG_PROPELLER_PROFILE_PREFIX
   CFLAGS_PROPELLER_CLANG := -fbasic-block-sections=list=$(CLANG_PROPELLER_PROFILE_PREFIX)_cc_profile.txt -ffunction-sections
   KBUILD_LDFLAGS += --symbol-ordering-file=$(CLANG_PROPELLER_PROFILE_PREFIX)_ld_profile.txt --no-warn-symbol-ordering
 else
-  CFLAGS_PROPELLER_CLANG := -fbasic-block-sections=labels
+  # Starting with Clang v20, the '-fbasic-block-sections=labels' option is
+  # deprecated. Use the recommended '-fbasic-block-address-map' option.
+  # Link: https://github.com/llvm/llvm-project/pull/110039
+  ifeq ($(call clang-min-version, 200000),y)
+    CFLAGS_PROPELLER_CLANG := -fbasic-block-address-map
+  else
+    CFLAGS_PROPELLER_CLANG := -fbasic-block-sections=labels
+  endif
 endif
 
 # Propeller requires debug information to embed module names in the profiles.
@@ -21,7 +28,11 @@ ifdef CONFIG_LTO_CLANG_THIN
   ifdef CLANG_PROPELLER_PROFILE_PREFIX
     KBUILD_LDFLAGS += --lto-basic-block-sections=$(CLANG_PROPELLER_PROFILE_PREFIX)_cc_profile.txt
   else
-    KBUILD_LDFLAGS += --lto-basic-block-sections=labels
+    ifeq ($(call test-ge, $(CONFIG_LLD_VERSION), 200000),y)
+       KBUILD_LDFLAGS += --lto-basic-block-address-map
+    else
+       KBUILD_LDFLAGS += --lto-basic-block-sections=labels
+    endif
   endif
 endif
 

base-commit: 0dcc2d1066150787017a71f035145c566597dec7
-- 
2.47.0.277.g8800431eea-goog


