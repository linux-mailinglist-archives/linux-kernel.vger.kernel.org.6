Return-Path: <linux-kernel+bounces-174848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2B18C15E3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62D86281AC2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DAC8594D;
	Thu,  9 May 2024 20:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YbxhrzLJ"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C2284DF6
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 20:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284852; cv=none; b=Lvirrv8chqtcdaRRxAyu9yOC2q/7sQYNNh2zquS6qwSz1wMJ1649qpMKeBVY5kbts4A6GF5FOmTYPz1/AT4BfaLj0f9pC9dZG7G3VDIk67emloYJJgMzPDFiCUUUbBVxNXIg5954T0Yj/7LvsEYkRDoQcAfOYrwf9jWO9sDBtHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284852; c=relaxed/simple;
	bh=olG+XfDL3xDdohtjq5mUHNgjYfinvarWZWSY+TyFh0Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XVIMT13a3Fibs1quDAD4VibPBEWzM8rZJliiPGVbcl7nAmKrVdyW8OAkjcCCR5eSNo6PQGtZHd/eC+S2Dvlj/WN+qJ7tz+dWY8p73v9lzXkROFqXpl9dV7DjceahleIFy0h/9FCuqxachahuNK+Qi5Dox/ZfkueMI2QXVxMlS/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YbxhrzLJ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc743cc50a6so1612906276.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 13:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284849; x=1715889649; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8CLdotFEq8j908dUbT6RbcvFD+YTCI0iXOlq7nFkwSk=;
        b=YbxhrzLJHfALsYA/PUh3m3WC4pHJpa3lO7g+ECbMiaUbh/ATox7Wt71ok3O00i9peh
         sIJDw27zFF36Waua/LrOBQtMWzpBxcu5PDn5wnk4RGSlAc+IpSqvmIZ6PPLHTONDuMu4
         bCFKATO65omrW3g9qKAAhwtosIW6+IlalFJiw5YfP+yH7fINC6/sXa7358MgqbGaw8XG
         PQqbNKxjfuu+SF62l7ABcnpm/5IHBZhJAfsc8vuWH0b00Znf/908z4QLf3SUdtDn0dqg
         5AOdTORHvH0K3RrY/2NaJSHidUh89a/tNXPo5sAKJK3VRncTfKq3FGwjH4NOq6A93aCC
         UE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284849; x=1715889649;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8CLdotFEq8j908dUbT6RbcvFD+YTCI0iXOlq7nFkwSk=;
        b=iErz7Me0BHNHQbd3twqgEinGam9FglGC/cCsO8HqMJ1XluvKMpZqQAkk8Fu1ekEZiq
         weGKM7qnEkqzG4QkBBAZDWaXnlvkArHuZAoO5e23VEyYBm5uxu36KaORODRUqXsRGMgU
         WhAos18Z1do2i5n05/5uo1h6o/DfsZ0hvhdYMj31es6jAHWRnJV2j2iGJuoTl90Oy13K
         Nj64GrgL3+q77ikSPfe9dZWg0fGi9zpAqUJiwjWmzSHuBBSl9IpPR2hKsmnWDo5pPUXz
         fD4Tt1M1UndzbVlsC42tWTsw3GzaIP739/sdoeIW7O/7Fw8oJGCnyrOazEjNkCu/cro2
         4MMw==
X-Gm-Message-State: AOJu0Yzt+gamHRQeswwusead/+5EEVUKwr7EoDuefGIYRGE4pkoHlPA6
	nObNlMuey/tcs+aYqLdIuniX0DljjYAts+irUGucKIyg6uiGJq1ROkyzw2r0N8u7b4p/9oVUHDx
	zSA==
X-Google-Smtp-Source: AGHT+IGZb1++ccVRLEMIHpSPN2qAQJXid7wFD4piJoYbkIu2XX8BrfoTxjJ3q5NtoiGCFIfHJDyo+fBfXww=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:705:b0:de4:5ce5:2656 with SMTP id
 3f1490d57ef6-dee4f301355mr46992276.8.1715284848710; Thu, 09 May 2024 13:00:48
 -0700 (PDT)
Date: Thu,  9 May 2024 19:57:55 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-4-edliaw@google.com>
Subject: [PATCH v3 03/68] selftests: Compile with -D_GNU_SOURCE when including lib.mk
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Edward Liaw <edliaw@google.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

lib.mk will add -D_GNU_SOURCE to CFLAGS by default.  This will make it
unnecessary to add #define _GNU_SOURCE in the source code.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Suggested-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/Makefile | 4 ++--
 tools/testing/selftests/lib.mk   | 5 ++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index f0431e6cb67e..9039f3709aff 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -170,11 +170,11 @@ ifneq ($(KBUILD_OUTPUT),)
   # $(realpath ...) resolves symlinks
   abs_objtree := $(realpath $(abs_objtree))
   BUILD := $(abs_objtree)/kselftest
-  KHDR_INCLUDES := -D_GNU_SOURCE -isystem ${abs_objtree}/usr/include
+  KHDR_INCLUDES := -isystem ${abs_objtree}/usr/include
 else
   BUILD := $(CURDIR)
   abs_srctree := $(shell cd $(top_srcdir) && pwd)
-  KHDR_INCLUDES := -D_GNU_SOURCE -isystem ${abs_srctree}/usr/include
+  KHDR_INCLUDES := -isystem ${abs_srctree}/usr/include
   DEFAULT_INSTALL_HDR_PATH := 1
 endif
 
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 3023e0e2f58f..e782f4c96aee 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -67,7 +67,7 @@ MAKEFLAGS += --no-print-directory
 endif
 
 ifeq ($(KHDR_INCLUDES),)
-KHDR_INCLUDES := -D_GNU_SOURCE -isystem $(top_srcdir)/usr/include
+KHDR_INCLUDES := -isystem $(top_srcdir)/usr/include
 endif
 
 # In order to use newer items that haven't yet been added to the user's system
@@ -188,6 +188,9 @@ endef
 clean: $(if $(TEST_GEN_MODS_DIR),clean_mods_dir)
 	$(CLEAN)
 
+# Build with _GNU_SOURCE by default
+CFLAGS += -D_GNU_SOURCE
+
 # Enables to extend CFLAGS and LDFLAGS from command line, e.g.
 # make USERCFLAGS=-Werror USERLDFLAGS=-static
 CFLAGS += $(USERCFLAGS)
-- 
2.45.0.118.g7fe29c98d7-goog


