Return-Path: <linux-kernel+bounces-529151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 873D1A42073
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBA533AAACA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCD424EF7A;
	Mon, 24 Feb 2025 13:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XaJOdO6w"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE0024889B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740403316; cv=none; b=NEiWeysnT4WxbSIH0q8+Gbwy/rTPym01C4zw2LaTjm6lz0Tk79I1FJsPZynDWKr754YXqtrhsQQByU6LKqlf1ecAyPbS6QdZyF+mXD5xqUaUd/dTs1kFgJX8PC1GO0jPoAsq1GjAel+JY+4o7vDAbIdjj1YFpLtxkIxHDVUBpLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740403316; c=relaxed/simple;
	bh=dRq0U8z9TE+qNLNwYD7S40TkyqyC8cws+VNe0sBWZT4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F207y7dFgKpy9V54Kp9pinYwuTLHJenh0s8yz49OvhisfDFxOITJ6d/F2GwAlgUVFKyDadd/5xHleu9dNaCDTPMn4HFUXTe28BqotPBdeuy39MH6CnoajF3mfQeG7/N4mBI2yDZ48ppOT9LiPU3wsNU4yvrk7wo2v53b1uxe66U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XaJOdO6w; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-38f51a3a833so1711794f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 05:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740403312; x=1741008112; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8PDru/78LRKbfp6+7TkdUZoiPcKmAw5IJh8X3W3/JHc=;
        b=XaJOdO6wnvC0oYsVP5uJJuueBs5CcjOaBlV/aQyiQIWySnuy9l0my08mNFsK07uB5/
         JfHgtDgFX2gk1VVLvBbx6JXqi/xje2aDYrx8Qe7PAe7SxAST8tcvgCES4Te2x4RATqiV
         ntKLcZOCpagAI2GuBmQ0dOzfUE7mmtCfRHkCBQdRpISfZZoLDrv7IaPZyhbi3yzIKuuA
         mQJySE/ECfNQ48e0CV8InQIAJxW+8U5coJz7LK2DbpVEqPUgdgNTLXE8Me5gufnkaa0V
         JSW6KYredvXSnzF/+J2zjdSlZulUNTYrHOJI/6mvzpfHRy7uWb7m2SZzCnDqzoMzwsqY
         mm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740403312; x=1741008112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8PDru/78LRKbfp6+7TkdUZoiPcKmAw5IJh8X3W3/JHc=;
        b=Eo4cvrlmeFWUkMwJPTbDba2cmIK9UeCHnc+tgft8UtW4/z8wRsQih/DstJWNhIfcUn
         EmzoJNLCOFTCTvAtrUMHzX02GsAVsARNDgnMiGG2Ubpexm7hP4oEIRcROhZqgLi3qjtd
         3wHQ+mpYHM8cMuoVRtLGsGzw6oIjZ6gJ1MfFfMfdQE6++RuB/5FuSnllI0jT5z5fpafv
         YdWbF7MqbPiikZk4W0POXj8IiTSEpOi5GYi8mW5sFwpmb2YEivzOS6SLdfLelW6pluqh
         erLhzql62dFJC6GuO3RXDHWLicH5ctLipX5RVUw7wHCHLI59z/ilwvSb/cA4uMsrsqZe
         6K9Q==
X-Gm-Message-State: AOJu0YyrnSOBLbS/pKfD1b/qfv1YBduA91XmjLZ3f2hYrQ44QepKsBvE
	gbuENb55ngIAji2HAjXwHsf5AwM0D0PLQtAsilQG14ecx+6Z1Bm17S5ReAY9q7FTSLViL4U5Wpi
	xLOT+GGKcertHFU3sEub9TafHY0XQQhzOKl/EnoECC8awxiObbwWVgob8yq00lgDGwS06KDlon/
	yB68CriLyMHDj0H661tOMb32ODLEBupA==
X-Google-Smtp-Source: AGHT+IGU6iDng62JC/uLtF9oeXB7JINtB0+X2gy+zOzmsORQVum5UsRDNd0ELZATXgLI/M52j6Z9Q+1I
X-Received: from wmbec10.prod.google.com ([2002:a05:600c:610a:b0:439:35bc:65d0])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:5886:0:b0:38a:2b34:e13e
 with SMTP id ffacd0b85a97d-38f70789b52mr11208308f8f.18.1740403312079; Mon, 24
 Feb 2025 05:21:52 -0800 (PST)
Date: Mon, 24 Feb 2025 14:21:34 +0100
In-Reply-To: <20250224132132.1765115-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250224132132.1765115-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2052; i=ardb@kernel.org;
 h=from:subject; bh=MckhOuu0fwDOa6nZDYfMs/sVcAaSvlXxSpoP6NXXouI=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIX1PUZztSo+O9dm7WebVL9w0VV/ovoOuwKz/YUuWLuVgK
 HrtJlfdUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACZSZcLwP6bXJ+ho2p3tq/mF
 W0/dF7jeO0fGQeFTyaZkbgeG7UxpyowME46d/Huu1O/g2f7TZyI/GctEFSh1PF9qumGpoL6FseB cVgA=
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250224132132.1765115-7-ardb+git@google.com>
Subject: [RFC PATCH 1/4] Kbuild/link-vmlinux.sh: Make output file name configurable
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, linux-kbuild@vger.kernel.org, 
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
2.48.1.601.g30ceb7b040-goog


