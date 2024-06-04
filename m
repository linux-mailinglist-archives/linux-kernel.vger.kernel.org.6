Return-Path: <linux-kernel+bounces-199841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A35C38FA692
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 01:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04EA8B22E00
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 23:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD5713D271;
	Mon,  3 Jun 2024 23:35:21 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AE713CFA1;
	Mon,  3 Jun 2024 23:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717457720; cv=none; b=UwBG4829H7LhV2wabVkD9nhaud2VXq8CO3TZ9HfQSlpKLRYwpen4EdEZgzm4Qsq5GK7AHaQftYjcokkQDUw+KaYXVO7pb3HhaJaIyFIxNQX4xoclVtqRmPBV4VhvxFuKOqOKS7SkQLl9bX89xsxe4bpJOjGLhwDIkCxNVVgPne8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717457720; c=relaxed/simple;
	bh=E4KMQm1Ogt1CyuBV5VilL6zJcZs1kYG26oi9sWfoFBA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=uBP6JqTmy8rluHnvSNjXNv4eCLRVHorRZ739U1a4+d3gu6W+3jq2PezPrE1pakR55khkS4r/VIHGQb4W41+37K7reCLsmDYlP8fG4hYDBI9eG1LTr3j/AzidqzlhgG/LbGqfmmQ+X1Q2wbifbbCP+SJCKl/CNXazdr8LjkwFrX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681D3C4AF0F;
	Mon,  3 Jun 2024 23:35:20 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sEHE7-00000009cvy-3A89;
	Mon, 03 Jun 2024 19:36:31 -0400
Message-ID: <20240603233631.619438489@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 03 Jun 2024 19:33:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 Lorenzo Stoakes <lstoakes@gmail.com>,
 linux-mm@kvack.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Kees Cook <keescook@chromium.org>,
 Tony Luck <tony.luck@intel.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 linux-hardening@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>,
 Ross Zwisler <zwisler@google.com>,
 wklin@google.com,
 Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Suleiman Souhlal <suleiman@google.com>,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
Subject: [PATCH 2/2] pstore/ramoops: Add ramoops.mem_name= command line option
References: <20240603233330.801075898@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Add a method to find a region specified by reserve_mem=nn:align:name for
ramoops. Adding a kernel command line parameter:

  reserve_mem=12M:4096:oops ramoops.mem_name=oops

Will use the size and location defined by the memmap parameter where it
finds the memory and labels it "oops". The "oops" in the ramoops option
is used to search for it.

This allows for arbitrary RAM to be used for ramoops if it is known that
the memory is not cleared on kernel crashes or soft reboots.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/pstore/ram.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index b1a455f42e93..bae8486045eb 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -50,6 +50,11 @@ module_param_hw(mem_address, ullong, other, 0400);
 MODULE_PARM_DESC(mem_address,
 		"start of reserved RAM used to store oops/panic logs");
 
+static char *mem_name;
+module_param_named(mem_name, mem_name, charp, 0400);
+MODULE_PARM_DESC(mem_name,
+		"name of kernel param that holds addr (builtin only)");
+
 static ulong mem_size;
 module_param(mem_size, ulong, 0400);
 MODULE_PARM_DESC(mem_size,
@@ -914,6 +919,16 @@ static void __init ramoops_register_dummy(void)
 {
 	struct ramoops_platform_data pdata;
 
+	if (mem_name) {
+		unsigned long start;
+		unsigned long size;
+
+		if (reserve_mem_find_by_name(mem_name, &start, &size)) {
+			mem_address = start;
+			mem_size = size;
+		}
+	}
+
 	/*
 	 * Prepare a dummy platform data structure to carry the module
 	 * parameters. If mem_size isn't set, then there are no module
-- 
2.43.0



