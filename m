Return-Path: <linux-kernel+bounces-574490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9452A6E5F4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BA7C173270
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90741EFF98;
	Mon, 24 Mar 2025 21:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCQ02pMh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3098C1EEA4E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 21:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853384; cv=none; b=bZSTKIYHLonbSd3UacnnUT9mvs1foG5PkiT3ygK1Xr+yuIMt0WnLVSRQ/Gf+IRGGiukcdd6V9fOm42YppnDiuglP7ASb6A+d7WvL+8jxCwNcWWBMOcUjuZ93/tByHcKyzIkknZqNvNbxP/YpfqDSA5bjpUjdjLtPMKiAa392lg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853384; c=relaxed/simple;
	bh=8Ap9V/RlNIssun8Y8rlPm0xiQ7oHWF3BU3WjU1FXwVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQ561sGzZmaDBesWlQF+/bzzJPuqOqAtNZfv5xpH8O8qdotrsj76v/iCJK5WP6EbETMouXhArsCkkCLaT5ivWZE2JjMJRRbqon2bvDdE+uF10iUa2ki5S8YFkgr7gL0lir27OmIjS/Jl7zXm9+3q8JbgVlSb7aisTMXzupkfJ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCQ02pMh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D374C4CEF0;
	Mon, 24 Mar 2025 21:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742853383;
	bh=8Ap9V/RlNIssun8Y8rlPm0xiQ7oHWF3BU3WjU1FXwVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GCQ02pMhH44AtMZMl/GmAjSwhqTcAG8hK2sytOGbAUkOSVY59AZnZwGiqFtXtoPqd
	 31PpTg693vjeOT7EVXAgpkYeWzXs1gRBG09EnCOgCC9zgNg5Ndi8AonhgRO2JT6p+R
	 5J8iXJ64aCIckW3HB//m1IyPALm+o90BngoYDD8clUCUnYnxsKsmmjk2ZE/VuG0QBJ
	 XcE2U8h/dPAf0kgQg7nF5HremAz00tZCWBOY8bTVDTWhUFfUgoDl4ePrYmhHGtnZBN
	 fIz2Pf6UkKjDq1Oh4XAOvYuciPSFFygD8GWoktlCca1IGoCuyQ+ieDuIh9lLkumvuC
	 0YHCWZDz1bF4A==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Brendan Jackman <jackmanb@google.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 05/22] objtool: Fix CONFIG_OBJTOOL_WERROR for vmlinux.o
Date: Mon, 24 Mar 2025 14:55:55 -0700
Message-ID: <4f71ab9b947ffc47b6a87dd3b9aff4bb32b36d0a.1742852846.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742852846.git.jpoimboe@kernel.org>
References: <cover.1742852846.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With (!X86_KERNEL_IBT && !LTO_CLANG && NOINSTR_VALIDATION), objtool runs
on both translation units and vmlinux.o.  With CONFIG_OBJTOOL_WERROR,
the TUs get --Werror but vmlinux.o doesn't.  Fix that.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 scripts/Makefile.vmlinux_o | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
index 0b6e2ebf60dc..f476f5605029 100644
--- a/scripts/Makefile.vmlinux_o
+++ b/scripts/Makefile.vmlinux_o
@@ -30,12 +30,20 @@ endif
 # objtool for vmlinux.o
 # ---------------------------------------------------------------------------
 #
-# For LTO and IBT, objtool doesn't run on individual translation units.
-# Run everything on vmlinux instead.
+# For delay-objtool (IBT or LTO), objtool doesn't run on individual translation
+# units.  Instead it runs on vmlinux.o.
+#
+# For !delay-objtool + CONFIG_NOINSTR_VALIDATION, it runs on both translation
+# units and vmlinux.o, with the latter only used for noinstr/unret validation.
 
 objtool-enabled := $(or $(delay-objtool),$(CONFIG_NOINSTR_VALIDATION))
 
-vmlinux-objtool-args-$(delay-objtool)			+= $(objtool-args-y)
+ifeq ($(delay-objtool),y)
+vmlinux-objtool-args-y					+= $(objtool-args-y)
+else
+vmlinux-objtool-args-$(CONFIG_OBJTOOL_WERROR)		+= --Werror
+endif
+
 vmlinux-objtool-args-$(CONFIG_GCOV_KERNEL)		+= --no-unreachable
 vmlinux-objtool-args-$(CONFIG_NOINSTR_VALIDATION)	+= --noinstr \
 							   $(if $(or $(CONFIG_MITIGATION_UNRET_ENTRY),$(CONFIG_MITIGATION_SRSO)), --unret)
-- 
2.48.1


