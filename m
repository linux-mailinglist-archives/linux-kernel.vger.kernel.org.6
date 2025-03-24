Return-Path: <linux-kernel+bounces-574492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F16A6E5F7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D5E03A6803
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B851F0E36;
	Mon, 24 Mar 2025 21:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8GiW27+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F111EFFBE
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 21:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853385; cv=none; b=KDCdNBVF2EJreXg1PuWO8SroHxAXIKi0wDykwD/TUw0DCdknCL/FzxBQgfLDRv9XaiXCqYNuc87qTlIgHhefqvDw+2XOnzGgH2MVPSzDC3N+GUF4/nul3MIiAAN8wiayGq10Y9ghak/8FJK0rEzvJRUJAmnhQ1ZQjNYZWkY8Ghc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853385; c=relaxed/simple;
	bh=hYjLeGv1GkKqvO/3TQGk13kouupJ6pyWS4PiJFO8iEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E9w4Neeq/vMHpxKvZXfG8w/YXDqcRbioP2dqjwAZ2XvcmMnt9IxAQQygrTid011pB/1H3kHP5JdzyYderJpx8z9ARzTnr8l7r2BseAlS/tDpK0lV9AuhfWhHVps633rC140x2eDRSp7eunSpVQwLDLLvQKZ5X/1VLsEaKf1NOgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8GiW27+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4282CC4CEED;
	Mon, 24 Mar 2025 21:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742853384;
	bh=hYjLeGv1GkKqvO/3TQGk13kouupJ6pyWS4PiJFO8iEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F8GiW27+srWSwFYmW38fSfbLGXe0B6FS61HbUHKWFn3uYg9jHUHoCo3blpcz2GgW+
	 VJM+3QIkmDqhvMoBdoxtjY9bvm+QWiB+V0bL2/s50ZJ2lGpH6aqukcE+P0xJRpDJOr
	 fFjO4ZQe4V+DQ+EAuqdgzI/cPa3m22YQjP+tNrwgzASNqSYfqOoMcEP+TaTqoDmz15
	 oisiVqIOe6AONnmzGrC2tK44AkVRpD3pYJ9sawsyYZ3095BPsMu+67+2F6vd9RuMlp
	 ZCUzsjCpWvuSTHQ1SSnDlpF5BOQU6kuxgtZIpl83BGBkL1ipY+BhnFEArfRGqKJhYv
	 B2/HcAUNCv5Mg==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Brendan Jackman <jackmanb@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 07/22] objtool: Silence more KCOV warnings
Date: Mon, 24 Mar 2025 14:55:57 -0700
Message-ID: <66a61a0b65d74e072d3dc02384e395edb2adc3c5.1742852846.git.jpoimboe@kernel.org>
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

In the past there were issues with KCOV triggering unreachable
instruction warnings, which is why unreachable warnings are now disabled
with CONFIG_KCOV.

Now some new KCOV warnings are showing up with GCC 14:

  vmlinux.o: warning: objtool: cpuset_write_resmask() falls through to next function cpuset_update_active_cpus.cold()
  drivers/usb/core/driver.o: error: objtool: usb_deregister() falls through to next function usb_match_device()
  sound/soc/codecs/snd-soc-wcd934x.o: warning: objtool: .text.wcd934x_slim_irq_handler: unexpected end of section

All are caused by GCC KCOV not finishing an optimization, leaving behind
a never-taken conditional branch to a basic block which falls through to
the next function (or end of section).

At a high level this is similar to the unreachable warnings mentioned
above, in that KCOV isn't fully removing dead code.  Treat it the same
way by adding these to the list of warnings to ignore with CONFIG_KCOV.

Reported-by: Ingo Molnar <mingo@kernel.org>
Closes: https://lore.kernel.org/Z9iTsI09AEBlxlHC@gmail.com
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503180044.oH9gyPeg-lkp@intel.com/
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 8edb7044f7fc..032b3be409f2 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3493,6 +3493,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			    !strncmp(func->name, "__pfx_", 6))
 				return 0;
 
+			if (file->ignore_unreachables)
+				return 0;
+
 			WARN("%s() falls through to next function %s()",
 			     func->name, insn_func(insn)->name);
 			return 1;
@@ -3702,6 +3705,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 		if (!next_insn) {
 			if (state.cfi.cfa.base == CFI_UNDEFINED)
 				return 0;
+			if (file->ignore_unreachables)
+				return 0;
+
 			WARN("%s: unexpected end of section", sec->name);
 			return 1;
 		}
-- 
2.48.1


