Return-Path: <linux-kernel+bounces-426617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A939A9DF5AF
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 14:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57384162B8D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 13:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5B41CB330;
	Sun,  1 Dec 2024 13:11:47 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85821CB306
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733058706; cv=none; b=pxKGOGM9efHMVloEkWndeZK59KyAn5kO0IoxGoNH1KChrXi0sCBoVTUjRP79nVjXjl4O2X5uRU60ScZbM6coPftVVMm/aZkymoiaLZ/8JvN/8fGJwP+KvX/L4LmjksMX4h4NDurqs/IRiG+bAqRYuaJ43AvGPB/kVYqGedvpYB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733058706; c=relaxed/simple;
	bh=pSmDu/FocUYN8Q6UUmN+SAyaSjv1fnoWsplTvYO+cEo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=QMK/pVA8AZFcgab0POQYQ30o0rMjnPe8vBd+QM5O7aMrQWOaPQoKbb0+1+kkkaVMX8CDCfS8H79M1RBv8sUToqJOhC/Dsn9ZB7zARx0rVES5fVNZv0hudbgFInDOXdK2c03yNMr8QVCXrPW9gptdcLnWAkpQVrjn3/0yCa+vBiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8469C4CECF;
	Sun,  1 Dec 2024 13:11:45 +0000 (UTC)
Date: Sun, 1 Dec 2024 08:11:43 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Petr Mladek <pmladek@suse.com>, Andy Shevchenko <andy@kernel.org>, "Dr.
 David Alan Gilbert" <linux@treblig.org>
Subject: [for-next][PATCH] vsnprintf: Remove unused 'bprintf'
Message-ID: <20241201081143.558918e5@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


vsnprintf: Removal of bprintf()

- Remove unused bprintf() function

  bprintf() was added with the rest of the "bin-printf" functions.
  These are functions that are used by trace_printk() that allows to
  quickly save the format and arguments into the ring buffer without
  the expensive processing of converting numbers to ASCII. Then on
  output, at a much later time, the ring buffer is read and the string
  processing occurs then. The bprintf() was added for consistency but
  was never used. It can be safely removed.

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/for-next

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

