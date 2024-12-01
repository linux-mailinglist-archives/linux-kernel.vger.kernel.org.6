Return-Path: <linux-kernel+bounces-426674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A89D69DF67F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 17:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8B84B21422
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 16:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4E21D6DB6;
	Sun,  1 Dec 2024 16:34:39 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84C31CB33F
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 16:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733070878; cv=none; b=CxTBte+Fil/5o+2xuobxyoVqakvhFLB9ri898d6KR8sfk7FvTkgknQmSMWGsM/AUi3pG6EIse1GWODfDwIdm/+z2VTP9bm1iZTsCz5cKKGrWyb0W/ItOLI7erjAtMJQEKag5cqmOatMg+SJlOYuNQWaoRiMZ/GkwCFdeOiHoxQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733070878; c=relaxed/simple;
	bh=eDpTNAH6M75aLn4JzjO4KQ/rBqXN2h0ml7bUKUNMBq0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Ma/z8T796dbpSOE1VpQGvQqw132gN1ATHQYF5cfU3KQF1tsGRxDT8sy6zMwM13PJCkDfU4Ii/linrUiKoWV4NUC6pDjtAmNEaEEJzmtuaj1ibykJa2V+Wl0Snu/bhWO8wwP3+tLhu2lW+CBN/I56/y7qZIMS7Nct/B+x5azrHMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2432CC4CECF;
	Sun,  1 Dec 2024 16:34:37 +0000 (UTC)
Date: Sun, 1 Dec 2024 11:34:35 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>, Andy Shevchenko <andy@kernel.org>, "Dr.
 David Alan Gilbert" <linux@treblig.org>, LKML
 <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] vsnprintf: Removal of bprintf()
Message-ID: <20241201113435.0350cdef@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Linus,

vsnprintf: Removal of bprintf()

- Remove unused bprintf() function

  bprintf() was added with the rest of the "bin-printf" functions.
  These are functions that are used by trace_printk() that allows to
  quickly save the format and arguments into the ring buffer without
  the expensive processing of converting numbers to ASCII. Then on
  output, at a much later time, the ring buffer is read and the string
  processing occurs then. The bprintf() was added for consistency but
  was never used. It can be safely removed.

[
  Note, this was sent back in October, and since tracing is the only
  user of the bin-printf code, I said I'll take it through my tree and
  run it through all my tests. Unfortunately, that got lost in my todo
  list and I was just reminded about it. I know it's the last day of
  the merge window, but since this change just removes an unused
  function, I decided to send it now. If you want me to wait for the
  next merge window I can just add it to that queue. It passed all my
  tests and I'm fine with having you take this now, or just adding it
  to my queue for the next time.
]

Please pull the latest trace-printf-v6.13 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-printf-v6.13

Tag SHA1: b825aa3f0c933c2152598462f90eaed7e61a8804
Head SHA1: f69e63756f7822fcdad8a34f9967e8b243e883ee


Dr. David Alan Gilbert (1):
      printf: Remove unused 'bprintf'

----
 include/linux/string.h |  1 -
 lib/vsprintf.c         | 23 -----------------------
 2 files changed, 24 deletions(-)
---------------------------
commit f69e63756f7822fcdad8a34f9967e8b243e883ee
Author: Dr. David Alan Gilbert <linux@treblig.org>
Date:   Wed Oct 2 18:31:47 2024 +0100

    printf: Remove unused 'bprintf'
    
    bprintf() is unused. Remove it. It was added in the commit 4370aa4aa753
    ("vsprintf: add binary printf") but as far as I can see was never used,
    unlike the other two functions in that patch.
    
    Link: https://lore.kernel.org/20241002173147.210107-1-linux@treblig.org
    Reviewed-by: Andy Shevchenko <andy@kernel.org>
    Acked-by: Petr Mladek <pmladek@suse.com>
    Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/include/linux/string.h b/include/linux/string.h
index 0dd27afcfaf7..493ac4862c77 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -335,7 +335,6 @@ int __sysfs_match_string(const char * const *array, size_t n, const char *s);
 #ifdef CONFIG_BINARY_PRINTF
 int vbin_printf(u32 *bin_buf, size_t size, const char *fmt, va_list args);
 int bstr_printf(char *buf, size_t size, const char *fmt, const u32 *bin_buf);
-int bprintf(u32 *bin_buf, size_t size, const char *fmt, ...) __printf(3, 4);
 #endif
 
 extern ssize_t memory_read_from_buffer(void *to, size_t count, loff_t *ppos,
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 6ac02bbb7df1..9d3dac38a3f4 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -3428,29 +3428,6 @@ int bstr_printf(char *buf, size_t size, const char *fmt, const u32 *bin_buf)
 }
 EXPORT_SYMBOL_GPL(bstr_printf);
 
-/**
- * bprintf - Parse a format string and place args' binary value in a buffer
- * @bin_buf: The buffer to place args' binary value
- * @size: The size of the buffer(by words(32bits), not characters)
- * @fmt: The format string to use
- * @...: Arguments for the format string
- *
- * The function returns the number of words(u32) written
- * into @bin_buf.
- */
-int bprintf(u32 *bin_buf, size_t size, const char *fmt, ...)
-{
-	va_list args;
-	int ret;
-
-	va_start(args, fmt);
-	ret = vbin_printf(bin_buf, size, fmt, args);
-	va_end(args);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(bprintf);
-
 #endif /* CONFIG_BINARY_PRINTF */
 
 /**

