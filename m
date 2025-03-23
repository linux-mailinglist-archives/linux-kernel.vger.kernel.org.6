Return-Path: <linux-kernel+bounces-572828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B66F2A6CF32
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 13:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 556EF1899D95
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 12:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54EF214A6F;
	Sun, 23 Mar 2025 12:29:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2286F205AC6
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742732951; cv=none; b=s9o+MBWXgngNLRiZCvpaojzJ392rAR154P0lCMTHQCVYHElHdeJSwoizA+C/C1dqKLfkPg5P6CUevA/WOCYg4iXCPdywmJsHpbXBIerWAyQr/IBaOhIGKz/j8rkACxmjPOMBuu8uCXFvx7SkIZj7XJ45PQXGLZFS8pQjLOM+ssk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742732951; c=relaxed/simple;
	bh=cd3LNfemcSgCououTTCnVgTcEGfS6qWC5kUBf/M2nhE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=h3ngJblhM3jr8kbrVUhzuO86iSdgYLSNR/gFVeKpjU/fAxZTG8Ix0NjtClXNo1ySZ7VEH/zjrFHJFt9IQv0TZVrxQw71+u4buHf7e2x0ogfGA8Q0XbeDJ5F+iQTW6pr8M+vNUgTWPqjRUYhYO8q5VHqhYAPBZ0SypAyrQfWL5EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1F1C4CEEF;
	Sun, 23 Mar 2025 12:29:10 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1twKSb-00000001yfE-3f7f;
	Sun, 23 Mar 2025 08:29:49 -0400
Message-ID: <20250323122949.723796800@goodmis.org>
User-Agent: quilt/0.68
Date: Sun, 23 Mar 2025 08:29:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michael Petlan <mpetlan@redhat.com>,
 Veronika Molnarova <vmolnaro@redhat.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Tamir Duberstein <tamird@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Petr Mladek <pmladek@suse.com>
Subject: [for-next][PATCH 04/10] tracing: gfp: vsprintf: Do not print "none" when using %pGg printf
 format
References: <20250323122933.407277911@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Petr Mladek <pmladek@suse.com>

The commit ca29a0bf122145 ("tracing: gfp: Remove duplication of recording
GFP flags") caused the following regression in printf_test selftest:

[   46.208199] test_printf: kvasprintf(..., "%pGg", ...) returned 'none|0xfc000000', expected '0xfc000000'
[   46.208209] test_printf: kvasprintf(..., "%pGg", ...) returned '__GFP_HIGH|none|0xfc000000', expected '__GFP_HIGH|0xfc000000'

The problem is the new '{ 0, "none" }' entry in __def_gfpflag_names macro
and the following code:

char *format_flags(char *buf, char *end, unsigned long flags,
					const struct trace_print_flags *names)
{
[...]
		if ((flags & mask) != mask)
			continue;
[...]
}

The purpose of the code is to print the name of a mask instead of bits,
for example, printk "GFP_ZONEMASK", instead of
"__GFP_DMA|__GFP_HIGHMEM|__GFP_DMA32|__GFP_MOVABLE".

Unfortunately, the mask "0" pass this check and "none" is always
printed.

A solution would be to move TRACE_GFP_FLAGS up so that it is not
the last entry. But it breaks the rule that named masks must
be defined before names of single bytes. Otherwise, it would
print the names of the bytes instead of the mask.

Instead, replace '{ 0, "none" }' with '{ 0, NULL }'. It works because
__def_gfpflag_names defines a standalone array and this is the standard
trailing entry. The code processing these arrays always ends the cycle
when flag->name == NULL.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Veronika Molnarova <vmolnaro@redhat.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tamir Duberstein <tamird@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/Z9Q5d11ZbA3CNMZm@pathway.suse.cz
Fixes: ca29a0bf122145 ("tracing: gfp: Remove duplication of recording GFP flags")
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/events/mmflags.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 82371177ef79..15aae955a10b 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -101,7 +101,7 @@ TRACE_DEFINE_ENUM(___GFP_LAST_BIT);
 	gfpflag_string(GFP_DMA32),		\
 	gfpflag_string(__GFP_RECLAIM),		\
 	TRACE_GFP_FLAGS				\
-	{ 0, "none" }
+	{ 0, NULL }
 
 #define show_gfp_flags(flags)						\
 	(flags) ? __print_flags(flags, "|", __def_gfpflag_names		\
-- 
2.47.2



