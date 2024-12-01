Return-Path: <linux-kernel+bounces-426745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 869139DF72A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 22:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD693B2140D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 21:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3E31D7E3D;
	Sun,  1 Dec 2024 21:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="BI2f1ll9"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C3A376F1
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 21:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733088937; cv=none; b=hCIyHu1vAYDfjeWsb6xw6SIHSu1X+jLCw6664iKG81Ctkc1iH2Ic+xP0q1XVMHRmXc0/lYeSzi8N3155s8eqfr46LeYh+NNmxzlvErWYCxCpvfzPXMzu3RZTRw7gNnaamMZhgA/oGl40u5IDEtwSFOUYP9mq60eWPxBBEO6tZdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733088937; c=relaxed/simple;
	bh=/2KoYNqKFYAcmXPEiYlndUehL3zWLmP5tqm26Z5S5UI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBr122s2DRHOG5wRf/cLXURz0HiDqbc9mqNfNkd06jIOXwZY2062k4z489m1tcdDdJ4HQDOfqjF4Ly9c6yU91qfD978kra9mGhelSdxm9+2Axyn1d9hxtb4nY+sVyjHS0xWvjPAUItSOnDXEIP08z1t1I+N/z/JCN+OUnw5DDPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=BI2f1ll9; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=l1SyJ9GaTUY4VvDw45QDXDMDLzw8fH/VWg/iwaMU/Eg=; b=BI2f1ll94lB/K/jr
	pnzQse2xh1lXKZDhlwmz85px0QDlc66eOQkVRWs6H+6SBeq1w8F6OZReBHOXLT+Wsd+CSCHVQLjb0
	WZtt9paTGj7nkuSs6CI16a7/zKXLfHBwEHkAWG/3FqP3x5XIEQjXou2q14rOLyabmPYdRL/HiOB0x
	nuCV2pEW8C7sArscRoLV8/z/90Qo8ieOqtiHJSJ0RQtwCwhbRNy+7JFvE3OYkgvBoANP68AhTogzL
	eCALVglUnLOSCgybn1UmpwZs7NLaOzakEIfUwE10lEWDBjjVRAz4gLZCHgEKrHT1vpJPQsYpRvita
	T5w7KW+B0Ax6/iOHSw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tHrbG-002jnq-2v;
	Sun, 01 Dec 2024 21:35:30 +0000
Date: Sun, 1 Dec 2024 21:35:30 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>, Andy Shevchenko <andy@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] vsnprintf: Removal of bprintf()
Message-ID: <Z0zWos7Xh_w1gV1H@gallifrey>
References: <20241201113435.0350cdef@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20241201113435.0350cdef@rorschach.local.home>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 21:35:15 up 207 days,  8:49,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Steven Rostedt (rostedt@goodmis.org) wrote:
> 
> Linus,
> 
> vsnprintf: Removal of bprintf()
> 
> - Remove unused bprintf() function
> 
>   bprintf() was added with the rest of the "bin-printf" functions.
>   These are functions that are used by trace_printk() that allows to
>   quickly save the format and arguments into the ring buffer without
>   the expensive processing of converting numbers to ASCII. Then on
>   output, at a much later time, the ring buffer is read and the string
>   processing occurs then. The bprintf() was added for consistency but
>   was never used. It can be safely removed.
> 
> [
>   Note, this was sent back in October, and since tracing is the only
>   user of the bin-printf code, I said I'll take it through my tree and
>   run it through all my tests. Unfortunately, that got lost in my todo
>   list and I was just reminded about it. I know it's the last day of
>   the merge window, but since this change just removes an unused
>   function, I decided to send it now. If you want me to wait for the
>   next merge window I can just add it to that queue. It passed all my
>   tests and I'm fine with having you take this now, or just adding it
>   to my queue for the next time.

Thanks!

Dave

> ]
> 
> Please pull the latest trace-printf-v6.13 tree, which can be found at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
> trace-printf-v6.13
> 
> Tag SHA1: b825aa3f0c933c2152598462f90eaed7e61a8804
> Head SHA1: f69e63756f7822fcdad8a34f9967e8b243e883ee
> 
> 
> Dr. David Alan Gilbert (1):
>       printf: Remove unused 'bprintf'
> 
> ----
>  include/linux/string.h |  1 -
>  lib/vsprintf.c         | 23 -----------------------
>  2 files changed, 24 deletions(-)
> ---------------------------
> commit f69e63756f7822fcdad8a34f9967e8b243e883ee
> Author: Dr. David Alan Gilbert <linux@treblig.org>
> Date:   Wed Oct 2 18:31:47 2024 +0100
> 
>     printf: Remove unused 'bprintf'
>     
>     bprintf() is unused. Remove it. It was added in the commit 4370aa4aa753
>     ("vsprintf: add binary printf") but as far as I can see was never used,
>     unlike the other two functions in that patch.
>     
>     Link: https://lore.kernel.org/20241002173147.210107-1-linux@treblig.org
>     Reviewed-by: Andy Shevchenko <andy@kernel.org>
>     Acked-by: Petr Mladek <pmladek@suse.com>
>     Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
>     Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 0dd27afcfaf7..493ac4862c77 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -335,7 +335,6 @@ int __sysfs_match_string(const char * const *array, size_t n, const char *s);
>  #ifdef CONFIG_BINARY_PRINTF
>  int vbin_printf(u32 *bin_buf, size_t size, const char *fmt, va_list args);
>  int bstr_printf(char *buf, size_t size, const char *fmt, const u32 *bin_buf);
> -int bprintf(u32 *bin_buf, size_t size, const char *fmt, ...) __printf(3, 4);
>  #endif
>  
>  extern ssize_t memory_read_from_buffer(void *to, size_t count, loff_t *ppos,
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 6ac02bbb7df1..9d3dac38a3f4 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -3428,29 +3428,6 @@ int bstr_printf(char *buf, size_t size, const char *fmt, const u32 *bin_buf)
>  }
>  EXPORT_SYMBOL_GPL(bstr_printf);
>  
> -/**
> - * bprintf - Parse a format string and place args' binary value in a buffer
> - * @bin_buf: The buffer to place args' binary value
> - * @size: The size of the buffer(by words(32bits), not characters)
> - * @fmt: The format string to use
> - * @...: Arguments for the format string
> - *
> - * The function returns the number of words(u32) written
> - * into @bin_buf.
> - */
> -int bprintf(u32 *bin_buf, size_t size, const char *fmt, ...)
> -{
> -	va_list args;
> -	int ret;
> -
> -	va_start(args, fmt);
> -	ret = vbin_printf(bin_buf, size, fmt, args);
> -	va_end(args);
> -
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(bprintf);
> -
>  #endif /* CONFIG_BINARY_PRINTF */
>  
>  /**
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

