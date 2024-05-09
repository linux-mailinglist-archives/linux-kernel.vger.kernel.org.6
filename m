Return-Path: <linux-kernel+bounces-174846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86368C15D9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2919AB20ABC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0213682C7E;
	Thu,  9 May 2024 20:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AzV9vP4R"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667A680043
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 20:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284847; cv=none; b=c/qg884ZbVoiyYQSMW+uF2mKX8wNncfSVSdEp+s7h4VKohssEKTax68IXuvb5uiYNk5PAf7kfTSk3R6R6GFfpvzoqAKVHu8P4Zj0j+PECkUV3cIfJfQoMb2C9we9yCCDmARbngKyYkSdngeXlWN50i+zI05Aw6J1C7aBWTmqkPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284847; c=relaxed/simple;
	bh=sKq0NyNZnefL7KfhQ+DAvF2g31FUow+Jz6znTC7Z/lA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ir0tbuLZgGGrh7enE1Bx1DWroGjfpQ8zhLRd6IqVMqpBVUfzHWvFM63gY6VB2o2VRZDiyofjn4txCjjXgA9yyYsofLazVaGS/DQGQQvNAh/2cg2n6Bz/9MwCcAVdtSB33jPeo8FjS7gobzR2qQU21j8L8KfQkZf/jcpJPIVTpRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AzV9vP4R; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61510f72bb3so22861577b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 13:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284843; x=1715889643; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ba6gtNWy+5dDG4FkE5cayyoNwuE5iBhkuWvzvH75i1U=;
        b=AzV9vP4RFDGU1uUxjqqw7b3BqsAIciN7KQ3ACP51Q+AArDopRVxg2J0VdRFRX5E3p1
         24SY6BYj7LbLKr6MFJLZ2EitoLeQFP6Gbhm7M/ohJ3MLeqLMJeaFPdB9sfkxFfPh+s/R
         f8ehKyF43eMmWe7GnZLUTNLmpRYnWXI+OlixQqqOwDTwksPvYnTTPInP2u0BFZZTQSYT
         BejFhTdrtHSlPmizKArskq3EoFrxJBAUfYsPYNeiFrvWKP8toUJOyQMUmw/AOwZPfGmD
         Vjtov6gWtz44WDRdwsvCeueFiEySmA3aWBnDIPjbApuucpi0qoU7rr57MoxTcirStOuo
         swlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284843; x=1715889643;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ba6gtNWy+5dDG4FkE5cayyoNwuE5iBhkuWvzvH75i1U=;
        b=tgPt7bSKSREl2taJoQphkrWKWPyr207ohffd+liOZ0GiK5zwfnKhbu+OHK3cVWeHnG
         Llu0MAKEc6j9KQr7cAHwCX3mKokkVC2rlnAxymxW4MBjJ/VSyEcHfNVP2AYUExkOj4uH
         zmoBHZn6tVJVJiTzL+4wYc05KnHETl7IXsdfh8Yj3mcmQwKQR15Fm8TcI0q4ke6c/cEc
         3or/3WsM0aK/rWyvon8ihbgzMQMiLlds1FFjnh25AXUk8WLzg2benzhnql6dvAEX4pD4
         kL2Cg2uOsUr8gyvoKeBgF+IBr/zFkC2aLGFlYebimXXfxS/AYqjnM2+jFhn7tpER+PkC
         GNww==
X-Gm-Message-State: AOJu0YxxDhJoo/xtObfoag471Ew3tNLAO4h0sz1rZVTpPPBt3Bv5mAE6
	mMpRL8FkFKibpjCzao3okxscgEjAeazc0+m2QdQbZ264CoOLOAQemhA9AluszJavylZVOeXgFMb
	BCA==
X-Google-Smtp-Source: AGHT+IFtxzWKY7VhIBdVaBt6o2fKuOgK4J0Sm4jxWWsiePPAsW3qSwIRHpAtz3W+/n8cUj9FLINB0ruDjug=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:690c:6f08:b0:61b:e39f:143b with SMTP id
 00721157ae682-622afd84a02mr1771287b3.0.1715284843538; Thu, 09 May 2024
 13:00:43 -0700 (PDT)
Date: Thu,  9 May 2024 19:57:53 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-2-edliaw@google.com>
Subject: [PATCH v3 01/68] selftests: Compile kselftest headers with -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>, 
	Will Drewry <wad@chromium.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Edward Liaw <edliaw@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>, Mark Brown <broonie@kernel.org>, 
	John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Add the -D_GNU_SOURCE flag to KHDR_INCLUDES so that it is defined in a
central location.

809216233555 ("selftests/harness: remove use of LINE_MAX") introduced
asprintf into kselftest_harness.h, which is a GNU extension and needs
_GNU_SOURCE to either be defined prior to including headers or with the
-D_GNU_SOURCE flag passed to the compiler.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202404301040.3bea5782-oliver.sang@intel.com
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/Makefile            | 4 ++--
 tools/testing/selftests/kselftest_harness.h | 2 +-
 tools/testing/selftests/lib.mk              | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 9039f3709aff..f0431e6cb67e 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -170,11 +170,11 @@ ifneq ($(KBUILD_OUTPUT),)
   # $(realpath ...) resolves symlinks
   abs_objtree := $(realpath $(abs_objtree))
   BUILD := $(abs_objtree)/kselftest
-  KHDR_INCLUDES := -isystem ${abs_objtree}/usr/include
+  KHDR_INCLUDES := -D_GNU_SOURCE -isystem ${abs_objtree}/usr/include
 else
   BUILD := $(CURDIR)
   abs_srctree := $(shell cd $(top_srcdir) && pwd)
-  KHDR_INCLUDES := -isystem ${abs_srctree}/usr/include
+  KHDR_INCLUDES := -D_GNU_SOURCE -isystem ${abs_srctree}/usr/include
   DEFAULT_INSTALL_HDR_PATH := 1
 endif
 
diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 7612bf09c5f8..31b2c70a2be2 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -51,7 +51,7 @@
 #define __KSELFTEST_HARNESS_H
 
 #ifndef _GNU_SOURCE
-#define _GNU_SOURCE
+static_assert(0, "kselftest harness requires _GNU_SOURCE to be defined");
 #endif
 #include <asm/types.h>
 #include <ctype.h>
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 429535816dbd..3023e0e2f58f 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -67,7 +67,7 @@ MAKEFLAGS += --no-print-directory
 endif
 
 ifeq ($(KHDR_INCLUDES),)
-KHDR_INCLUDES := -isystem $(top_srcdir)/usr/include
+KHDR_INCLUDES := -D_GNU_SOURCE -isystem $(top_srcdir)/usr/include
 endif
 
 # In order to use newer items that haven't yet been added to the user's system
-- 
2.45.0.118.g7fe29c98d7-goog


