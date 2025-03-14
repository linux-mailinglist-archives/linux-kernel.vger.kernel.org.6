Return-Path: <linux-kernel+bounces-562030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F009A61AAE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 20:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82E1C7ACAF1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9728620E32A;
	Fri, 14 Mar 2025 19:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuZYKOeF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E194D20DD45
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 19:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741980574; cv=none; b=OBmq+uy5JaoqrSlzLxVCaAHRJd370KPIaw/JL6PQC3Sr7YxRA1eXQ4/R2t87F8vWYlNFiRwwy52v077keDr58kj9CEYTkrT+osO9vU1t4u8kB+5t0FNx4DCus0rV0CaTHomSMcnj2xph3XqM7GuPkZLWrzrBJP6nxiEDiy6bItE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741980574; c=relaxed/simple;
	bh=MuEUQXRk4MGKZ+To5bORRPLRoNHakjJEWiddaL41TJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bm9SS2FpwSo8enYHdVvu/qgmTGs37jeNTsYLc4IRD59KO33LAqeLxMRQyQJV3aKm7CPl2ESg3LvmpKkLF/arqNWmTvyyjHjIMm6qjVQAas8baGsuAe5Wvbl0jRBsVTPIEQ0AccuNm2CIJoyDWKGt+zNzRVE/o8zrVw5dBp8yajI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuZYKOeF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8529FC4CEEC;
	Fri, 14 Mar 2025 19:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741980573;
	bh=MuEUQXRk4MGKZ+To5bORRPLRoNHakjJEWiddaL41TJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cuZYKOeFT39LOsL9h+w7Ag+3V8hADSWC1DjT8PERQwD+q2+ykQJ+qVV2WZd23XQiM
	 1EipFpDf2edZzLvtEsSiplQlo5Lnge7qNAKMfDdHXCbKerueX84yynK8aG3MtMGzX7
	 qhepZGzLKwKjxve0tXT9+DiR+JOaIkKk3WhA652CfSjOb4NYV8Sw2gkjDLywbMXxoS
	 Hp8MQF10SbSBaDNIjSVVLs3coiQ+vIHzKnKnnFnUKseVg46DzIXCB242tH30dNIoTF
	 vqmYouOrNNFl2mLLbLuyK/3jXwg4lbpttdFGn+qGukYiYokHMS1DZQ3ZAi3vOya3df
	 wXQ30p37vM7IQ==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Brendan Jackman <jackmanb@google.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 13/13] objtool: Add CONFIG_OBJTOOL_WERROR
Date: Fri, 14 Mar 2025 12:29:11 -0700
Message-ID: <3e7c109313ff15da6c80788965cc7450115b0196.1741975349.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741975349.git.jpoimboe@kernel.org>
References: <cover.1741975349.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Objtool warnings can be indicative of crashes, broken live patching, or
even boot failures.  Ignoring them is not recommended.

Add CONFIG_OBJTOOL_WERROR to upgrade objtool warnings to errors by
enabling the objtool --Werror option.  Also set --backtrace to print the
branches leading up to the warning, which can help considerably when
debugging certain warnings.

To avoid breaking bots too badly for now, make it the default for real
world builds only (!COMPILE_TEST).

Co-developed-by: Brendan Jackman <jackmanb@google.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 lib/Kconfig.debug    | 12 ++++++++++++
 scripts/Makefile.lib |  1 +
 2 files changed, 13 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 35796c290ca3..bbfb9d575f97 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -545,6 +545,18 @@ config FRAME_POINTER
 config OBJTOOL
 	bool
 
+config OBJTOOL_WERROR
+	bool "Upgrade objtool warnings to errors"
+	default y
+	depends on OBJTOOL && !COMPILE_TEST
+	help
+	  Fail the build on objtool warnings.
+
+	  Objtool warnings can indicate kernel instability, including boot
+	  failures.  This option is highly recommended.
+
+	  If unsure, say Y.
+
 config STACK_VALIDATION
 	bool "Compile-time stack metadata validation"
 	depends on HAVE_STACK_VALIDATION && UNWINDER_FRAME_POINTER
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index cad20f0e66ee..99e281966ba3 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -277,6 +277,7 @@ objtool-args-$(CONFIG_HAVE_STATIC_CALL_INLINE)		+= --static-call
 objtool-args-$(CONFIG_HAVE_UACCESS_VALIDATION)		+= --uaccess
 objtool-args-$(CONFIG_GCOV_KERNEL)			+= --no-unreachable
 objtool-args-$(CONFIG_PREFIX_SYMBOLS)			+= --prefix=$(CONFIG_FUNCTION_PADDING_BYTES)
+objtool-args-$(CONFIG_OBJTOOL_WERROR)			+= --Werror --backtrace
 
 objtool-args = $(objtool-args-y)					\
 	$(if $(delay-objtool), --link)					\
-- 
2.48.1


