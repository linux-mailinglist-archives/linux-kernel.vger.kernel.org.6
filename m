Return-Path: <linux-kernel+bounces-574497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C42ECA6E601
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7F181736B6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A9C1F3B98;
	Mon, 24 Mar 2025 21:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvPo1+Al"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AD11F2BB8
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 21:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853387; cv=none; b=YnPUerxmXzp3zRSqgDDH09tCfgN/HMtCuvRv+gl+n+M5ZRlkpjagKfIEYw9bz5fjVOo9o6JLfRZymmJX/nvE4vQqeV66TB9X1gq47UzSqhhVc7NIsTOkU+LF5Bh/ChRY3hPjfMF04q/+L1Vu2MlSMduQ+MjDYsa6zpKaV6/H9BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853387; c=relaxed/simple;
	bh=yo6sJXtvHZ+k/r0fmuhOzf3cJa4+JAvS2CiqyT/PhfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hq4wFebeFmo4C2SGtU8vnkSagV4Ks3wyHcjvFSGLT94P14BoUFSY1cs3XU6GA31j6iaOMVNCPkeXcRhfc+g7/ZJ91zc4hBUQVTlnrGpbi/MtplgOhY1SM7R6WwaYzViR5PuS4qZPFUBhZwECmK8AkArFIHEWkluJM1JlvRY0z0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvPo1+Al; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872FFC4CEDD;
	Mon, 24 Mar 2025 21:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742853386;
	bh=yo6sJXtvHZ+k/r0fmuhOzf3cJa4+JAvS2CiqyT/PhfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cvPo1+AldjWeMVEGkGQmnEIxKS8WdWad6kjTCpfePpNzN90sl1EF56sg1bDsIV6qW
	 TNU0Hnz/6MFpWUI19sAcjYsTaa1TyMecxelaaHBww4tZnOEgf8GjOKBRIjSnkEht81
	 AK0Z1Gfl0i+pDWWgpk4QBOGUZ2VaHOsLTvm/+D/IKvJCL+BTF9pJ4ME/8OgidvYJGb
	 9IjSoKhbc4SdgDbiCwXZOhDKcuC1w5mtKqjZIEW9GwROmDh6m2NScUMPYmDf4AtTgz
	 +NLXy5SIgYrMp/Gnmv1agOPY1jfEKq/E09rcJrWm2pUym/9jxfvUJL5+wT+NO/duPR
	 g3vdS8rMEYduQ==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Brendan Jackman <jackmanb@google.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 12/22] objtool: Remove --no-unreachable for noinstr-only vmlinux.o runs
Date: Mon, 24 Mar 2025 14:56:02 -0700
Message-ID: <05414246a0124db2f21b0d071b652aa9043d039d.1742852847.git.jpoimboe@kernel.org>
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

For (!X86_KERNEL_IBT && !LTO_CLANG && NOINSTR_VALIDATION), objtool runs
on both translation units and vmlinux.o.  The vmlinux.o run only does
noinstr/noret validation.  In that case --no-unreachable has no effect.
Remove it.

Note that for ((X86_KERNEL_IBT || LTO_CLANG) && KCOV), --no-unreachable
still gets set in objtool-args-y by scripts/Makefile.lib.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 scripts/Makefile.vmlinux_o | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
index f476f5605029..938c7457717e 100644
--- a/scripts/Makefile.vmlinux_o
+++ b/scripts/Makefile.vmlinux_o
@@ -44,7 +44,6 @@ else
 vmlinux-objtool-args-$(CONFIG_OBJTOOL_WERROR)		+= --Werror
 endif
 
-vmlinux-objtool-args-$(CONFIG_GCOV_KERNEL)		+= --no-unreachable
 vmlinux-objtool-args-$(CONFIG_NOINSTR_VALIDATION)	+= --noinstr \
 							   $(if $(or $(CONFIG_MITIGATION_UNRET_ENTRY),$(CONFIG_MITIGATION_SRSO)), --unret)
 
-- 
2.48.1


