Return-Path: <linux-kernel+bounces-532757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 004C4A451E5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A413919C1396
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DAB155C83;
	Wed, 26 Feb 2025 01:05:37 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8146BB5B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 01:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740531937; cv=none; b=C1hCGFY+7iqrB4jqe5tH91lbzB9QEGxOYxODraPC6CRVjZGsJpcJ5fIaIR/9/3vAxLdW9ciHd66gTc5cPpuwWMF7VnCxrGK7QkSCsvtkBH8ERZqZqm5GhOGVs3ShvqMGmqIHAoODoRYzhpeCaACxKAlwSeYlAq9m8IhWgmx6IHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740531937; c=relaxed/simple;
	bh=npe4+D3FjjabDkZCU8vHG/H5KpBHyP6JcROnGMMiG14=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=mOZxDlvyvTVRUplR7n2bbbciSxSkrSaV2L6Nt0vJ/syDnvle9ExX8z8lSo0FmQhEzYIr5WbIH3k93c8OgyYdxYF/NWp3NFV+ooSqZzvegxHGieVOEc+Ai2Qde3wNHxsRclXezl8tnGkiQgV8FcXW8ocjkIaEoQXoOToglUYH7cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FE5C4CEEB;
	Wed, 26 Feb 2025 01:05:37 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tn5sO-00000009EZG-3A40;
	Tue, 25 Feb 2025 20:06:16 -0500
Message-ID: <20250226010616.603055165@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 25 Feb 2025 20:05:58 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 "Arnd Bergmann" <arnd@arndb.de>,
 Nathan Chancellor <nathan@kernel.org>,
 Mark Brown <broonie@kernel.org>
Subject: [for-next][PATCH 2/4] ftrace: Check against is_kernel_text() instead of kaslr_offset()
References: <20250226010556.526552688@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

As kaslr_offset() is architecture dependent and also may not be defined by
all architectures, when zeroing out unused weak functions, do not check
against kaslr_offset(), but instead check if the address is within the
kernel text sections. If KASLR added a shift to the zeroed out function,
it would still not be located in the kernel text. This is a more robust
way to test if the text is valid or not.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: "Arnd Bergmann" <arnd@arndb.de>
Link: https://lore.kernel.org/20250225182054.471759017@goodmis.org
Fixes: ef378c3b8233 ("scripts/sorttable: Zero out weak functions in mcount_loc table")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: Mark Brown <broonie@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/all/20250224180805.GA1536711@ax162/
Closes: https://lore.kernel.org/all/5225b07b-a9b2-4558-9d5f-aa60b19f6317@sirena.org.uk/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 183f72cf15ed..bec7b5dbdb3b 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7004,7 +7004,6 @@ static int ftrace_process_locs(struct module *mod,
 	unsigned long count;
 	unsigned long *p;
 	unsigned long addr;
-	unsigned long kaslr;
 	unsigned long flags = 0; /* Shut up gcc */
 	unsigned long pages;
 	int ret = -ENOMEM;
@@ -7056,9 +7055,6 @@ static int ftrace_process_locs(struct module *mod,
 		ftrace_pages->next = start_pg;
 	}
 
-	/* For zeroed locations that were shifted for core kernel */
-	kaslr = !mod ? kaslr_offset() : 0;
-
 	p = start;
 	pg = start_pg;
 	while (p < end) {
@@ -7072,7 +7068,18 @@ static int ftrace_process_locs(struct module *mod,
 		 * object files to satisfy alignments.
 		 * Skip any NULL pointers.
 		 */
-		if (!addr || addr == kaslr) {
+		if (!addr) {
+			skipped++;
+			continue;
+		}
+
+		/*
+		 * If this is core kernel, make sure the address is in core
+		 * or inittext, as weak functions get zeroed and KASLR can
+		 * move them to something other than zero. It just will not
+		 * move it to an area where kernel text is.
+		 */
+		if (!mod && !(is_kernel_text(addr) || is_kernel_inittext(addr))) {
 			skipped++;
 			continue;
 		}
-- 
2.47.2



