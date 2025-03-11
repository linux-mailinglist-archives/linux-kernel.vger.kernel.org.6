Return-Path: <linux-kernel+bounces-555932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC95A5BE7E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D56516C17B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FFD253F0E;
	Tue, 11 Mar 2025 11:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OayPHAF/"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6254C24169D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 11:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741691194; cv=none; b=N/OcHFDfYV7hqngDy8l6x5k2PEiWzytemZAS3nRWaS4WV+c1LWT3vF9YAMN4yG83jpb6zlvRMTlTFonvF7Fx1TNMGkIcUfjM+zZkWPg16JuUCaMrlR+iOgVZYCKqy4ofnTyzGa0wP+20wNVdEn3+pArsVT8UCyQtgHUu/xQIDI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741691194; c=relaxed/simple;
	bh=gVD0/fzhrleJz7qWjI+8Zc3sgv/qdPMRB6vrQfcnKH4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EnwcnVd/rJ1pQRGQYPeN6naSs3Vy5PjFRrP8/cQJScMQSITxre2CEqInzV33vUf7/puQk5CQZ7pfYVWjGVAjlPKTZYNtDRV1OxHW9o9hLZgIAgt/k3Rs8NLpFQ5NpRdI5v2kq++Wincd64DdWUIuc8n8/i+aokxn5DltPejAHg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OayPHAF/; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-39130f02631so2062083f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 04:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741691191; x=1742295991; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tV9KNmIji6xAM0Ucpo6ZsPi4ZsXCFqqr1ylqjFTDO+c=;
        b=OayPHAF/trOLVTdL/8xflO2zrX9MaBj7UQ40E1iLoXnwntj1iu6t7689iGS+36eKT8
         8nugA5pXfN+4jyhuA8FkPzP0rI2JY2nVVzxJp8Xkd6Gvx7dNY97z+lgyDuUVe9q4gmYm
         CHh0/Axp2s2uRLkY8VMiwJ9dK37UcYmt0KcmZA+/He2M7W2ntx0StRG8kU9AVEoGolJX
         jq5bJERKTJosAi6qwhF+riyMwXsxP9gdY51B0aH76hRMKQjVBQ6J6cTePkk8+zDcVMjm
         K93GA6sMJKW+sh3Jlm6aAbgq1L2LVLpcG334E3yvKd1/gNnS7CfkfW6P0WqEBu4OQJVq
         FWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741691191; x=1742295991;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tV9KNmIji6xAM0Ucpo6ZsPi4ZsXCFqqr1ylqjFTDO+c=;
        b=eHv6fBX3jSUxAR+ZTAknntkVzdpG2d10tXteR5ABc2vjTPnb/fGB1erWtmFhtHB+0w
         /N3USkCZfqNdmQqCIOrJJqoTqJUwQZr3Hgb6UHxoEL61CkkpvIf9qxiCVToDY7KtpKYW
         9d30fULJyt0zS/8246b851xtZqR4/nGCwd66387ljoi9NNLWrgfl/9bzdDcN/ftWqSPR
         6fGWYtiQkkRquVrU7gYdkGJnTX2DOuoOfOs9ZZU6j8lnrrnY7gQQebtPBkjEhOUiC4hB
         xEFFsp53OeqbrsZItT2wTESo9K/3zNoKQZq9gq/1e4vlEzbHmyDWzfuR8WslzOTFYcf0
         FA4A==
X-Gm-Message-State: AOJu0Yx9gbaBqsPip4eSSLnbO0/efk4gPApeL0axPaxnGnl0RAY6SGUo
	E6+A4LvIGnVjuH/cvlib6ZDSSN56jpWvrTHcQEXK5vKCmwylePTUw6f4FqAZU0C4mVN5+3zlMhb
	9R2iI3TYf2i9Tf6zJx3jI6wNbgVdfg9nSiDLue7Qm8YesbUcNTgxywt/5jEB3z+PP9G9RDMzWlE
	1cZr4fi7QGnBA7NWLK3JG+bbIlxcbp9Q==
X-Google-Smtp-Source: AGHT+IGx5sLNnKxVFCGhCCzaNKMvpj+hJ1CMgltFrMWRcriH1uhpFfBfRRlejgGSfIVVwI7xdZNOUNcl
X-Received: from wrbgz25.prod.google.com ([2002:a05:6000:4819:b0:391:3213:f77f])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:64c5:0:b0:390:fdba:ac7
 with SMTP id ffacd0b85a97d-3926c78f683mr4008136f8f.51.1741691190737; Tue, 11
 Mar 2025 04:06:30 -0700 (PDT)
Date: Tue, 11 Mar 2025 12:06:18 +0100
In-Reply-To: <20250311110616.148682-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250311110616.148682-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2056; i=ardb@kernel.org;
 h=from:subject; bh=CGnv6V5I23eS/SExFYiNHZ+B0GmQlF8wLC6M1T8xHx4=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf2CpOb3sw3R948qlQYYiblGM+ulcO/2LdLm8N/Pz1PWn
 +974FtHKQuDGAeDrJgii8Dsv+92np4oVes8SxZmDisTyBAGLk4BmIiHMiPD08Mc70NvSuVs/VFZ
 vXSTUq/wq04HGf9emzihoqx3Kh6dDP8MWf5oHO+qXp/rxKExWX6Vl/O8H7qvp/UFL/hSs7NLrYE JAA==
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250311110616.148682-7-ardb+git@google.com>
Subject: [PATCH v2 1/4] Kbuild/link-vmlinux.sh: Make output file name configurable
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

In order to introduce an intermediate, non-stripped vmlinux build that
can be used by other build steps as an input, pass the output file name
to link-vmlinux.sh via its command line.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 scripts/Makefile.vmlinux |  2 +-
 scripts/link-vmlinux.sh  | 11 ++++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
index 873caaa55313..3523ce3ce3dc 100644
--- a/scripts/Makefile.vmlinux
+++ b/scripts/Makefile.vmlinux
@@ -69,7 +69,7 @@ ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
 
 # Final link of vmlinux with optional arch pass after final link
 cmd_link_vmlinux =							\
-	$< "$(LD)" "$(KBUILD_LDFLAGS)" "$(LDFLAGS_vmlinux)";		\
+	$< "$(LD)" "$(KBUILD_LDFLAGS)" "$(LDFLAGS_vmlinux)" "$@";	\
 	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
 
 targets += vmlinux
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 56a077d204cf..e55026128e05 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -31,6 +31,7 @@ set -e
 LD="$1"
 KBUILD_LDFLAGS="$2"
 LDFLAGS_vmlinux="$3"
+VMLINUX="$4"
 
 is_enabled() {
 	grep -q "^$1=y" include/config/auto.conf
@@ -278,7 +279,7 @@ fi
 
 strip_debug=
 
-vmlinux_link vmlinux
+vmlinux_link "${VMLINUX}"
 
 # fill in BTF IDs
 if is_enabled CONFIG_DEBUG_INFO_BTF; then
@@ -290,11 +291,11 @@ if is_enabled CONFIG_DEBUG_INFO_BTF; then
 	${RESOLVE_BTFIDS} ${RESOLVE_BTFIDS_ARGS} vmlinux
 fi
 
-mksysmap vmlinux System.map
+mksysmap "${VMLINUX}" System.map
 
 if is_enabled CONFIG_BUILDTIME_TABLE_SORT; then
-	info SORTTAB vmlinux
-	if ! sorttable vmlinux; then
+	info SORTTAB "${VMLINUX}"
+	if ! sorttable "${VMLINUX}"; then
 		echo >&2 Failed to sort kernel tables
 		exit 1
 	fi
@@ -310,4 +311,4 @@ if is_enabled CONFIG_KALLSYMS; then
 fi
 
 # For fixdep
-echo "vmlinux: $0" > .vmlinux.d
+echo "${VMLINUX}: $0" > ".${VMLINUX}.d"
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


