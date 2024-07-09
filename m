Return-Path: <linux-kernel+bounces-246662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E06892C4E3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 22:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E1B281B6F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06A518C197;
	Tue,  9 Jul 2024 20:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V/rDWky3"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50201189F46
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 20:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720557777; cv=none; b=qQTouuL/jnp02gtOo+l6uN/fuikNg+LC9gatFx+HbZvWvwdZrm92LK7HnNd9lPMPVUm1nxkohvxVMLM5eJ0FeA25j8/kte3fIJ3+1sB5VnjTDL/ERRTNvvXmBmocMjBHGmnH3fqXmlhZ679swnySCtiZGWAQs7kUHdk9uM4+TJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720557777; c=relaxed/simple;
	bh=5hJtb8O8aGVuCzIkuDaH1C7eL8jW1PgUZ7H/z2BPSw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gv/FqmR41Uc5cd/6LabiTBOJl7kafX9n3vwCaRk03DkuMyvzXm7lVTQFMe2alog3w6WTIK1LwYEIzHA2Nk3qgIBTi/2yjG/SieZO1zO4I/nufDamRn75BWqVZK5EuTSHnpUEZAxXAOPI+X26YjXa4dr/9Dx4eK1QKSEXypDfnjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V/rDWky3; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fb4a332622so21915345ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 13:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720557775; x=1721162575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2jCXrLvZIYGuyX7wwzQt98iRS81M5D6rZNTDsiflt0=;
        b=V/rDWky3NVcNl9fX2hZ8HBmQQ5e2kwGhsheuKWUkN5k1uj+eVyIxQBD0YSRh/NH3yx
         OCWOp7aqImTKs3Io0bdpAkOu7fsPPKWqcrAhGKSXQ157Imf2QrFFcNlkqPxpdyVylnfL
         /rvFYkwo2j31mpHwdasyzpwb9r+fXyqNdewe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720557775; x=1721162575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b2jCXrLvZIYGuyX7wwzQt98iRS81M5D6rZNTDsiflt0=;
        b=BBKQUB/+10/otM59ZptExoq2T7YjJO9FyamvrC1k7VxS+UQREaEQ/Nurr7U+Uz8pTT
         855f140s7174oBKbL6FPPx8qEBddzugDA5iMsGru73/vZuw/GT0+8zu+aIk7SgM+gykQ
         v49bguLwuOVHmmMoDdl/E2oR5UYufNdvO7zDH7Pcq8ZAuN9Z+TK3Ter7Bbu6BlzvFbdu
         PfpYHnz6sxgtMfqR8EGbSTiJNohUzNBqJEsk4BZyznB5gxWdgCPsaMWWashjwhYtvRTJ
         nvddNFSl6bF0fowC9CyM5+z/olQJfG2ScoTX0x19vEtOUKCGVDb3uWYW1gnJyU7TvsTR
         6Hzg==
X-Forwarded-Encrypted: i=1; AJvYcCUhyyJ5wE3Z0XKLWESWlxbAqN+dyauDmbjHWUCQ5xi4eU9pRCvOS4uswcen2BGLF1Fo2kOHNsrHqBTN32VMWmXSpFdnVXAoA+/iKFln
X-Gm-Message-State: AOJu0Yznao3ZebezAd6ueh1ennanVW830VOVZN3OdLLqoqvCNus10ypc
	/xQ8p2xDvt+/JfdUyB1ldnxiCKVW+Q2CXFjwd9rBJsmBg3I7Iz3ABj1JjYfO3g==
X-Google-Smtp-Source: AGHT+IHjK3RExiQOmuK3iDTX/Upl24GWjmDes7leC1u1b1/8tRoqtQUBfMBlLxfOsmft2g4mqCkU8A==
X-Received: by 2002:a17:903:11ce:b0:1fb:365:5e0 with SMTP id d9443c01a7336-1fbb6d25264mr29004165ad.14.1720557774614;
        Tue, 09 Jul 2024 13:42:54 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:4d59:98c6:8095:9b12])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-1fbb6ab6c53sm20318625ad.153.2024.07.09.13.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 13:42:54 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH v3 3/3] tools build: Correct bpf fixdep dependencies
Date: Tue,  9 Jul 2024 13:41:53 -0700
Message-ID: <20240709204203.1481851-4-briannorris@chromium.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240709204203.1481851-1-briannorris@chromium.org>
References: <20240709204203.1481851-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dependencies in tools/lib/bpf/Makefile are incorrect. Before we
recurse to build $(BPF_IN_STATIC), we need to build its 'fixdep'
executable.

I can't use the usual shortcut from Makefile.include:

  <target>: <sources> fixdep

because its 'fixdep' target relies on $(OUTPUT), and $(OUTPUT) differs
in the parent 'make' versus the child 'make' -- so I imitate it via
open-coding.

I tweak a few $(MAKE) invocations while I'm at it, because
1. I'm adding a new recursive make; and
2. these recursive 'make's print spurious lines about files that are "up
   to date" (which isn't normally a feature in Kbuild subtargets) or
   "jobserver not available" (see [1])

I also need to tweak the assignment of the OUTPUT variable, so that
relative path builds work. For example, for 'make tools/lib/bpf', OUTPUT
is unset, and is usually treated as "cwd" -- but recursive make will
change cwd and so OUTPUT has a new meaning. For consistency, I ensure
OUTPUT is always an absolute path.

And $(Q) gets a backup definition in tools/build/Makefile.include,
because Makefile.include is sometimes included without
tools/build/Makefile, so the "quiet command" stuff doesn't actually work
consistently without it.

After this change, top-level builds result in an empty grep result from:

  $ grep 'cannot find fixdep' $(find tools/ -name '*.cmd')

[1] https://www.gnu.org/software/make/manual/html_node/MAKE-Variable.html
If we're not using $(MAKE) directly, then we need to use more '+'.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---

Changes in v3:
 - add Jiri's Acked-by

Changes in v2:
 - also fix libbpf shared library rules
 - ensure OUTPUT is always set, and always an absolute path
 - add backup $(Q) definition in tools/build/Makefile.include

 tools/build/Makefile.include | 12 +++++++++++-
 tools/lib/bpf/Makefile       | 14 ++++++++++++--
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/tools/build/Makefile.include b/tools/build/Makefile.include
index 8dadaa0fbb43..0e4de83400ac 100644
--- a/tools/build/Makefile.include
+++ b/tools/build/Makefile.include
@@ -1,8 +1,18 @@
 # SPDX-License-Identifier: GPL-2.0-only
 build := -f $(srctree)/tools/build/Makefile.build dir=. obj
 
+# More than just $(Q), we sometimes want to suppress all command output from a
+# recursive make -- even the 'up to date' printout.
+ifeq ($(V),1)
+  Q ?=
+  SILENT_MAKE = +$(Q)$(MAKE)
+else
+  Q ?= @
+  SILENT_MAKE = +$(Q)$(MAKE) --silent
+endif
+
 fixdep:
-	$(Q)$(MAKE) -C $(srctree)/tools/build CFLAGS= LDFLAGS= $(OUTPUT)fixdep
+	$(SILENT_MAKE) -C $(srctree)/tools/build CFLAGS= LDFLAGS= $(OUTPUT)fixdep
 
 fixdep-clean:
 	$(Q)$(MAKE) -C $(srctree)/tools/build clean
diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 2cf892774346..630369c0091e 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -108,6 +108,8 @@ MAKEOVERRIDES=
 
 all:
 
+OUTPUT ?= ./
+OUTPUT := $(abspath $(OUTPUT))/
 export srctree OUTPUT CC LD CFLAGS V
 include $(srctree)/tools/build/Makefile.include
 
@@ -141,7 +143,13 @@ all: fixdep
 
 all_cmd: $(CMD_TARGETS) check
 
-$(BPF_IN_SHARED): force $(BPF_GENERATED)
+$(SHARED_OBJDIR):
+	$(Q)mkdir -p $@
+
+$(STATIC_OBJDIR):
+	$(Q)mkdir -p $@
+
+$(BPF_IN_SHARED): force $(BPF_GENERATED) | $(SHARED_OBJDIR)
 	@(test -f ../../include/uapi/linux/bpf.h -a -f ../../../include/uapi/linux/bpf.h && ( \
 	(diff -B ../../include/uapi/linux/bpf.h ../../../include/uapi/linux/bpf.h >/dev/null) || \
 	echo "Warning: Kernel ABI header at 'tools/include/uapi/linux/bpf.h' differs from latest version at 'include/uapi/linux/bpf.h'" >&2 )) || true
@@ -151,9 +159,11 @@ $(BPF_IN_SHARED): force $(BPF_GENERATED)
 	@(test -f ../../include/uapi/linux/if_xdp.h -a -f ../../../include/uapi/linux/if_xdp.h && ( \
 	(diff -B ../../include/uapi/linux/if_xdp.h ../../../include/uapi/linux/if_xdp.h >/dev/null) || \
 	echo "Warning: Kernel ABI header at 'tools/include/uapi/linux/if_xdp.h' differs from latest version at 'include/uapi/linux/if_xdp.h'" >&2 )) || true
+	$(SILENT_MAKE) -C $(srctree)/tools/build CFLAGS= LDFLAGS= OUTPUT=$(SHARED_OBJDIR) $(SHARED_OBJDIR)fixdep
 	$(Q)$(MAKE) $(build)=libbpf OUTPUT=$(SHARED_OBJDIR) CFLAGS="$(CFLAGS) $(SHLIB_FLAGS)"
 
-$(BPF_IN_STATIC): force $(BPF_GENERATED)
+$(BPF_IN_STATIC): force $(BPF_GENERATED) | $(STATIC_OBJDIR)
+	$(SILENT_MAKE) -C $(srctree)/tools/build CFLAGS= LDFLAGS= OUTPUT=$(STATIC_OBJDIR) $(STATIC_OBJDIR)fixdep
 	$(Q)$(MAKE) $(build)=libbpf OUTPUT=$(STATIC_OBJDIR)
 
 $(BPF_HELPER_DEFS): $(srctree)/tools/include/uapi/linux/bpf.h
-- 
2.45.2.803.g4e1b14247a-goog


