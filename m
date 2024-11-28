Return-Path: <linux-kernel+bounces-424094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6021B9DB08C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 040E916133C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 00:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67A515530C;
	Thu, 28 Nov 2024 00:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tsv2Z8/6"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E473153BFC
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 00:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732755380; cv=none; b=fPnDJWZfifBVBhqzYDZWMm7fJ9cScH6zOafjoG+wa16dnV4BlH92Cl1OkP0F7O5rBGfl5fOic49l7oCyPpCLpe8hsG1V6/7kHzt1jNLmls9FeQxktK3WC4nwtShMZDKH5kud2bcBzV6uZ2U80ZATsKiH/o6jhCdcbIzNLjbpWQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732755380; c=relaxed/simple;
	bh=vSRfrEytDpN8W4HCrYiZGYIvGxH/eHfJp4zZjiL/A9E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AIthwTQbJSI92HVifm+2hoF8Mv6KX6P0HNiki8xefwLYRM9ZiT7HYJNIGkFXL+55uQ7UFuBss/GStecNIPZKklHRZ+PGTvTl0CL6IiTvNRN6HnVOgpFzdRaaL01XzQM+YjIOYn69FN4yeAmy6mUo5/dm5u5P99N2YZZDnbZt/L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tsv2Z8/6; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7fc2bdd115cso247438a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 16:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732755378; x=1733360178; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=SIrOHFdLU07PpaXHI/YgxGMl42ASMs52y5wmlleZ1JI=;
        b=tsv2Z8/68GsvgAC+sDcHM6nSzYGwFcJWaMD9KqfowUE5UXu7FtJTpbdsoNLPpYf3iF
         F7kxzQgZdM48dYrWX4F803l9E3C7Az6Ny1hcWMu3wF91AV3u+9ipAgx7JVjS1qQe4kS1
         ayIMomUFUjMgJuSRjo9rjrDrkyGYjhdUnsIZq2uH7KKozxTt1osFnBUY0OMqvq5FH0ys
         wGn3Z971vdlFdWtrEtqldW63IuEIrX2dvpxUVomsppHc8fdt9FO+emEdw4NUUdA9VYth
         X6ffGMMuCrme53m9ITbdgBCxBJLZ4EjPCdouDFRthkO5znzqWjbZHCMc0gjlnhornF5e
         Hhng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732755378; x=1733360178;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SIrOHFdLU07PpaXHI/YgxGMl42ASMs52y5wmlleZ1JI=;
        b=nSOCD0uzSAUpMR6Fkv15vRj/wAwQPE6DmaadGmygwMkFLx1J8IhiEBWp8jeNPvrnVg
         mjWWrnIfhyuQxTWdYYDSGQonP1PaLtPIri4K9Hl46aF0ExJCdab3e2do5jzW+AnIrFOZ
         gLczp9JLIzGP8Sa7t9lS/GUhWuRykzQEapFcQTx7m2dMNHhsXhQzEq8XGGx8OdjhKZWD
         JQ2UTK/5JRKjJjIssIZySEggfz4qhLZ4WI4GsuKwVLuYItufsbHfph8EJQayx+6nMP3P
         MwWJ5K19waSqiH8cSymYktNBqDSgrOPYLysuxentZm/dDqTbngQvVLOxdlGOYON0dDbZ
         TxJg==
X-Forwarded-Encrypted: i=1; AJvYcCVhTMEtPOk0hP9Mvw3DmmpCVluLqwVeqDxrquSwl/81OfYiGIbfRnBn8L32AscNeDTT4Kj3yqdJnuxk1b4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwldI4AUWqBBpJy9M4za7+hdqjvaxlQOW7wAT6AOC9EKsjVGAxa
	aBOD/JrDc19opRZjb+nbv3AJQiOaRgxQUTtlKSBn6Jbt4BJ9wQWQrjK5HyFwDZEAJI1vjRbvHv9
	FPw==
X-Google-Smtp-Source: AGHT+IEWNoqxkKJEuSCYYZMRl85uBIjfdRzypvum78dwg9LOBi3REl5p9HlxVwSIxD2wnWKazGYBZqWzZwk=
X-Received: from pjbst14.prod.google.com ([2002:a17:90b:1fce:b0:2ea:9d23:79a0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:9f93:b0:2ea:5658:9ed6
 with SMTP id 98e67ed59e1d1-2ee25b38db4mr2121026a91.12.1732755377809; Wed, 27
 Nov 2024 16:56:17 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Nov 2024 16:55:47 -0800
In-Reply-To: <20241128005547.4077116-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241128005547.4077116-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128005547.4077116-17-seanjc@google.com>
Subject: [PATCH v4 16/16] KVM: selftests: Override ARCH for x86_64 instead of
 using ARCH_DIR
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Sean Christopherson <seanjc@google.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Andrew Jones <ajones@ventanamicro.com>, James Houghton <jthoughton@google.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

Now that KVM selftests uses the kernel's canonical arch paths, directly
override ARCH to 'x86' when targeting x86_64 instead of defining ARCH_DIR
to redirect to appropriate paths.  ARCH_DIR was originally added to deal
with KVM selftests using the target triple ARCH for directories, e.g.
s390x and aarch64; keeping it around just to deal with the one-off alias
from x86_64=>x86 is unnecessary and confusing.

Note, even when selftests are built from the top-level Makefile, ARCH is
scoped to KVM's makefiles, i.e. overriding ARCH won't trip up some other
selftests that (somehow) expects x86_64 and can't work with x86.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/Makefile     |  4 +---
 tools/testing/selftests/kvm/Makefile.kvm | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 9bc2eba1af1c..20af35a91d6f 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -6,9 +6,7 @@ ARCH            ?= $(SUBARCH)
 ifeq ($(ARCH),$(filter $(ARCH),arm64 s390 riscv x86 x86_64))
 # Top-level selftests allows ARCH=x86_64 :-(
 ifeq ($(ARCH),x86_64)
-	ARCH_DIR := x86
-else
-	ARCH_DIR := $(ARCH)
+	ARCH := x86
 endif
 include Makefile.kvm
 else
diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 9888dd6bb483..4277b983cace 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -207,10 +207,10 @@ TEST_GEN_PROGS_riscv += steal_time
 SPLIT_TESTS += arch_timer
 SPLIT_TESTS += get-reg-list
 
-TEST_PROGS += $(TEST_PROGS_$(ARCH_DIR))
-TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(ARCH_DIR))
-TEST_GEN_PROGS_EXTENDED += $(TEST_GEN_PROGS_EXTENDED_$(ARCH_DIR))
-LIBKVM += $(LIBKVM_$(ARCH_DIR))
+TEST_PROGS += $(TEST_PROGS_$(ARCH))
+TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(ARCH))
+TEST_GEN_PROGS_EXTENDED += $(TEST_GEN_PROGS_EXTENDED_$(ARCH))
+LIBKVM += $(LIBKVM_$(ARCH))
 
 OVERRIDE_TARGETS = 1
 
@@ -222,14 +222,14 @@ include ../lib.mk
 INSTALL_HDR_PATH = $(top_srcdir)/usr
 LINUX_HDR_PATH = $(INSTALL_HDR_PATH)/include/
 LINUX_TOOL_INCLUDE = $(top_srcdir)/tools/include
-LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/$(ARCH_DIR)/include
+LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/$(ARCH)/include
 CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
 	-Wno-gnu-variable-sized-type-not-at-end -MD -MP -DCONFIG_64BIT \
 	-fno-builtin-memcmp -fno-builtin-memcpy \
 	-fno-builtin-memset -fno-builtin-strnlen \
 	-fno-stack-protector -fno-PIE -fno-strict-aliasing \
 	-I$(LINUX_TOOL_INCLUDE) -I$(LINUX_TOOL_ARCH_INCLUDE) \
-	-I$(LINUX_HDR_PATH) -Iinclude -I$(<D) -Iinclude/$(ARCH_DIR) \
+	-I$(LINUX_HDR_PATH) -Iinclude -I$(<D) -Iinclude/$(ARCH) \
 	-I ../rseq -I.. $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
 ifeq ($(ARCH),s390)
 	CFLAGS += -march=z10
@@ -273,7 +273,7 @@ LIBKVM_S_OBJ := $(patsubst %.S, $(OUTPUT)/%.o, $(LIBKVM_S))
 LIBKVM_STRING_OBJ := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_STRING))
 LIBKVM_OBJS = $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ) $(LIBKVM_STRING_OBJ)
 SPLIT_TEST_GEN_PROGS := $(patsubst %, $(OUTPUT)/%, $(SPLIT_TESTS))
-SPLIT_TEST_GEN_OBJ := $(patsubst %, $(OUTPUT)/$(ARCH_DIR)/%.o, $(SPLIT_TESTS))
+SPLIT_TEST_GEN_OBJ := $(patsubst %, $(OUTPUT)/$(ARCH)/%.o, $(SPLIT_TESTS))
 
 TEST_GEN_OBJ = $(patsubst %, %.o, $(TEST_GEN_PROGS))
 TEST_GEN_OBJ += $(patsubst %, %.o, $(TEST_GEN_PROGS_EXTENDED))
@@ -282,7 +282,7 @@ TEST_DEP_FILES += $(patsubst %.o, %.d, $(LIBKVM_OBJS))
 TEST_DEP_FILES += $(patsubst %.o, %.d, $(SPLIT_TEST_GEN_OBJ))
 -include $(TEST_DEP_FILES)
 
-$(shell mkdir -p $(sort $(OUTPUT)/$(ARCH_DIR) $(dir $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ))))
+$(shell mkdir -p $(sort $(OUTPUT)/$(ARCH) $(dir $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ))))
 
 $(filter-out $(SPLIT_TEST_GEN_PROGS), $(TEST_GEN_PROGS)) \
 $(TEST_GEN_PROGS_EXTENDED): %: %.o
@@ -290,9 +290,9 @@ $(TEST_GEN_PROGS_EXTENDED): %: %.o
 $(TEST_GEN_OBJ): $(OUTPUT)/%.o: %.c
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
 
-$(SPLIT_TEST_GEN_PROGS): $(OUTPUT)/%: $(OUTPUT)/%.o $(OUTPUT)/$(ARCH_DIR)/%.o
+$(SPLIT_TEST_GEN_PROGS): $(OUTPUT)/%: $(OUTPUT)/%.o $(OUTPUT)/$(ARCH)/%.o
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $^ $(LDLIBS) -o $@
-$(SPLIT_TEST_GEN_OBJ): $(OUTPUT)/$(ARCH_DIR)/%.o: $(ARCH_DIR)/%.c
+$(SPLIT_TEST_GEN_OBJ): $(OUTPUT)/$(ARCH)/%.o: $(ARCH)/%.c
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
 
 EXTRA_CLEAN += $(GEN_HDRS) \
-- 
2.47.0.338.g60cca15819-goog


