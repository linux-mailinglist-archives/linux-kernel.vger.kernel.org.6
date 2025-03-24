Return-Path: <linux-kernel+bounces-574491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C2FA6E5F6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D2C617362C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929351F0E2A;
	Mon, 24 Mar 2025 21:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohOrKSOF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4831EF084
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 21:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853384; cv=none; b=SUZTt4OsNIt2dpsJrZHZ1uNWrVxeJHftbn4udHvIsQZkisXIOFN/CARKpyACZ+W5QSuriUOVQsGboX8O6xr1EPOBqtaO18ynk7hDBsIPzkj/lFv7SqzD8ioP0aZqXTUj9qT0iJ76aDotCQ9vQcpx3R0EI2QzpLvBWBxFZDMm0RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853384; c=relaxed/simple;
	bh=uc7Pk6gShU8z9EP+FaeNJKnbU7Tk2Rys/5jL1sospsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAs+6+RnQd5ov3Z0IkknTYYA4VNAD8FWCGXmDsnNMBPdtqVffhHzukcBOpCwFK2SK1CrbrcHhH1Dc94O0G45hD7qC6PEakpRg7HgIrDsGob5i7HE3w79uArRsbXUm0TlKmfLp5sEqZFKhRxmT3VSnPpockYWI28PnHRJO1O9gL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohOrKSOF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3EAC4CEF2;
	Mon, 24 Mar 2025 21:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742853384;
	bh=uc7Pk6gShU8z9EP+FaeNJKnbU7Tk2Rys/5jL1sospsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ohOrKSOFm9abZ+QWHS356IUANj2s4DgA+rXbj7gbNU71B6QYSHjV/WxC+j9CMDEqT
	 LedqdkjnoSv903r77BXkRJpIRrK5Bm/BnkaK7n5VMxzQsEtOG8XCr6yx2+G+pff2b5
	 LsuGwnWC5tO9QrnTudTLDwRH1wB4dSsu6xsAbJpjwjqy5I6f4I9BmEd8fwn6XU+upa
	 uR7eVzX6XFZ/bOkb1DVPiaq6qCsJFI3pjGLNL5BBY6JO/kM4arr/aoiBQL+lE90XS7
	 W7k0U2hxI2j8BkcO1yA0VIcF2AMRdsDM/w2w4yb1ftdzq895KF2PTAL9MWWur1JAik
	 jip2bDU8lphOA==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Brendan Jackman <jackmanb@google.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 06/22] objtool: Fix init_module() handling
Date: Mon, 24 Mar 2025 14:55:56 -0700
Message-ID: <366bfdbe92736cde9fb01d5d3eb9b98e9070a1ec.1742852846.git.jpoimboe@kernel.org>
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

If IBT is enabled and a module uses the deprecated init_module() magic
function name rather than module_init(fn), its ENDBR will get removed,
causing an IBT failure during module load.

Objtool does print an obscure warning, but then does nothing to either
correct it or return an error.

Improve the usefulness of the warning and return an error so it will at
least fail the build with CONFIG_OBJTOOL_WERROR.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index bac88ca82dec..8edb7044f7fc 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -828,8 +828,11 @@ static int create_ibt_endbr_seal_sections(struct objtool_file *file)
 		if (opts.module && sym && sym->type == STT_FUNC &&
 		    insn->offset == sym->offset &&
 		    (!strcmp(sym->name, "init_module") ||
-		     !strcmp(sym->name, "cleanup_module")))
-			WARN("%s(): not an indirect call target", sym->name);
+		     !strcmp(sym->name, "cleanup_module"))) {
+			WARN("%s(): Magic init_module() function name is deprecated, use module_init(fn) instead",
+			     sym->name);
+			return -1;
+		}
 
 		if (!elf_init_reloc_text_sym(file->elf, sec,
 					     idx * sizeof(int), idx,
-- 
2.48.1


