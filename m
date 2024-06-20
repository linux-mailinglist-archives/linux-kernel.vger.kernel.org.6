Return-Path: <linux-kernel+bounces-222431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FFA910175
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 12:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 644321C2141F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710FB1A8C3E;
	Thu, 20 Jun 2024 10:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DKPr/V/r"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C16B15A845
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 10:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718879308; cv=none; b=h+6WZWtaOKNK9H503lmaIeO0+lbKdBL/kyDeRCwkMPn5wgb0RsN397UitUwZg3bPWddmw6Lfc8IzAxRpZ5+FYm+1Ea0jGyNJDTl84Hdf1Jyt0nu6Vznaeuu9xFTMtTsLDs9+tzTB5X7FqX8DPxKniB4iBgdOPKW0YbZ2ZTm2tng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718879308; c=relaxed/simple;
	bh=eLolpew0WP3F1CU7xMxQzuGFHsPk4ssPoTsyz+0Jl68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/waqT7+DIgUBV9iZuKiJb3N/4fgrDtDGu0iHFgPivPVT85D1zGKNB+EBU8dti/jGBQHg3n8Ax054wSbEedC5FzCowbS45SGY6NmNgkj6ovyYj768HmWzz/E7tu5g4Cc/w8Q03Sl9FKfz3hVTlm4n2ltU9KJE+3XX6xcS9e6Zm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DKPr/V/r; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ebe40673d8so7350311fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 03:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718879303; x=1719484103; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NLJZF6G9FkR7w8/5l/JJWsJzW22wi4kW0RvW3AjsaxU=;
        b=DKPr/V/rkIqd7w6qzRQJpAL+V78YKo5PHqZlcl9dg7k9fOQz/vvuvhG27XOTd5XqwW
         sHm+x37weD6GyJdeDUZzo6yJMLe31nuisDkyMrQQR9AzyZ+5YYzA4PMv/grkUADKOKwD
         w/JQ9/Tsdc9luAnrwUTRucve2IyPEMGysi4BTz1iR09GwE+C5Acv8FRWgDTGyNQDVP+w
         dl8UwSQd06O1BJwXP4vJow0M2XROfaiIaCt4cK/7Eb4Qlxnt1aKoKLO0qzHp4jv/Gj25
         LOQP45tQ5pBXCfnFr5C7b/TkqIhpj1P7moGVsNGXa3pB5fCYTuBbJddTqxZN9KZaNVQz
         xPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718879303; x=1719484103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLJZF6G9FkR7w8/5l/JJWsJzW22wi4kW0RvW3AjsaxU=;
        b=t44vlVu0g6BhqKfoe8uTs83rHaIRtDGkl2YK42XiFAuToHATsNfv4FwcsbrAwGTs0I
         8XdwoUYcpuZRAgyT5hZf/yrrz2uRDAs+tqsnd0n3jF+H+lEjC+8Qoq+0ApOk1CM4rXSH
         ymIlZAZ7pMzrPDqkA87UyzVqd9DXp4VnuHjg3wXGPHAvnthhs1xIjchKUWBvHPpbAsdr
         7ZNmS6YayEsYtSCs233S/4yBIflwK9eWABfSWes6zIZrnxX11+uK4RcGvF7nKtpVoBzG
         hj3HEQC3wLIplf2WTm5aUQWbO9wNEWGaOyWM1SAISnEoCywqlGKrognitP+yclcCqugt
         hevQ==
X-Forwarded-Encrypted: i=1; AJvYcCVozNZSxhlKR4yUwu0pEHP4bTkEvQO4SNZ/683H9jjw7mmm+Ll1BejNJcKVNq1OyHVOE01haFs8WRBqmPvAiiIe4TjCEVP3x9fEjAvg
X-Gm-Message-State: AOJu0YzkB+xAZdDBjuAu9riBQ0lLgsjE2EUAkgMUEoMEQEOg6JI/Ip/U
	0gJLWwCdiFJdLLBLp7v6MlJeikUjXl64bxQ7gzCVtlX9IUelqFgPib6rSHmR63Y=
X-Google-Smtp-Source: AGHT+IFqdXHbkQeDqu1v24g5fI8AAeN1WdCfg4XjZD0G602o3i75KN+BdIvaHTgNn/SAoUzpdAJISw==
X-Received: by 2002:a2e:84c5:0:b0:2ec:287c:4ae8 with SMTP id 38308e7fff4ca-2ec3cff5687mr30472001fa.53.1718879303472;
        Thu, 20 Jun 2024 03:28:23 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb92025sm11995571b3a.208.2024.06.20.03.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 03:28:22 -0700 (PDT)
Date: Thu, 20 Jun 2024 12:28:14 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 10/18] printk: Provide helper for message
 prepending
Message-ID: <ZnQEPjcLnolJFi6n@pathway.suse.cz>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <20240603232453.33992-11-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603232453.33992-11-john.ogness@linutronix.de>

On Tue 2024-06-04 01:30:45, John Ogness wrote:
> In order to support prepending different texts to printk
> messages, split out the prepending code into a helper
> function.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/printk/printk.c | 38 +++++++++++++++++++++++++++-----------
>  1 file changed, 27 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 4613f9145a8e..fcbf794a0aaf 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2806,30 +2806,25 @@ static void __console_unlock(void)
>  #ifdef CONFIG_PRINTK
>  
>  /*
> - * Prepend the message in @pmsg->pbufs->outbuf with a "dropped message". This
> - * is achieved by shifting the existing message over and inserting the dropped
> - * message.
> + * Prepend the message in @pmsg->pbufs->outbuf with the message in
> + * @pmsg->pbufs->scratchbuf. This is achieved by shifting the existing message
> + * over and inserting the scratchbuf message.
>   *
>   * @pmsg is the printk message to prepend.
>   *
> - * @dropped is the dropped count to report in the dropped message.
> + * @len is the length of the message in @pmsg->pbufs->scratchbuf.
>   *
>   * If the message text in @pmsg->pbufs->outbuf does not have enough space for
> - * the dropped message, the message text will be sufficiently truncated.
> + * the scratchbuf message, the message text will be sufficiently truncated.
>   *
>   * If @pmsg->pbufs->outbuf is modified, @pmsg->outbuf_len is updated.
>   */
> -void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
> +static void __console_prepend_scratch(struct printk_message *pmsg, size_t len)
>  {
>  	struct printk_buffers *pbufs = pmsg->pbufs;
> -	const size_t scratchbuf_sz = sizeof(pbufs->scratchbuf);
>  	const size_t outbuf_sz = sizeof(pbufs->outbuf);
>  	char *scratchbuf = &pbufs->scratchbuf[0];
>  	char *outbuf = &pbufs->outbuf[0];
> -	size_t len;
> -
> -	len = scnprintf(scratchbuf, scratchbuf_sz,
> -		       "** %lu printk messages dropped **\n", dropped);
>  
>  	/*
>  	 * Make sure outbuf is sufficiently large before prepending.
> @@ -2851,6 +2846,27 @@ void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
>  	pmsg->outbuf_len += len;
>  }
>  
> +/*
> + * Prepend the message in @pmsg->pbufs->outbuf with a "dropped message".
> + * @pmsg->outbuf_len is updated appropriately.
> + *
> + * @pmsg is the printk message to prepend.
> + *
> + * @dropped is the dropped count to report in the dropped message.
> + */
> +void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
> +{
> +	struct printk_buffers *pbufs = pmsg->pbufs;
> +	const size_t scratchbuf_sz = sizeof(pbufs->scratchbuf);
> +	char *scratchbuf = &pbufs->scratchbuf[0];
> +	size_t len;
> +
> +	len = scnprintf(scratchbuf, scratchbuf_sz,
> +		       "** %lu printk messages dropped **\n", dropped);
> +
> +	__console_prepend_scratch(pmsg, len);
> +}

There is a lot of boilerplate code around the custom part. A better
solution might be to allow passing a printf format to the function
prepending the existing message.

I have tried how it would look like. Here is the patch. Note that it
is only compile-only tested:

From 853a3761f4e0f13970ffc71d9463f79eaa06fca1 Mon Sep 17 00:00:00 2001
From: John Ogness <john.ogness@linutronix.de>
Date: Tue, 4 Jun 2024 01:30:45 +0206
Subject: [PATCH] printk: Provide helper for message prepending

In order to support prepending different texts to printk
messages, split out the prepending code into a helper
function.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 3e07e9884907..b0a6aab792fc 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2806,30 +2806,31 @@ static void __console_unlock(void)
 #ifdef CONFIG_PRINTK
 
 /*
- * Prepend the message in @pmsg->pbufs->outbuf with a "dropped message". This
- * is achieved by shifting the existing message over and inserting the dropped
- * message.
+ * Prepend the message in @pmsg->pbufs->outbuf. This is achieved by shifting
+ * the existing message over and inserting the scratchbuf message.
  *
- * @pmsg is the printk message to prepend.
+ * @pmsg is the original printk message.
+ * @fmt is the printf format of the message which will prepend the existing one.
  *
- * @dropped is the dropped count to report in the dropped message.
- *
- * If the message text in @pmsg->pbufs->outbuf does not have enough space for
- * the dropped message, the message text will be sufficiently truncated.
+ * If there is not enough space in @pmsg->pbufs->outbuf, the existing
+ * message text will be sufficiently truncated.
  *
  * If @pmsg->pbufs->outbuf is modified, @pmsg->outbuf_len is updated.
  */
-void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
+__printf(2, 3)
+static void console_prepend_message(struct printk_message *pmsg, const char *fmt, ...)
 {
 	struct printk_buffers *pbufs = pmsg->pbufs;
 	const size_t scratchbuf_sz = sizeof(pbufs->scratchbuf);
 	const size_t outbuf_sz = sizeof(pbufs->outbuf);
 	char *scratchbuf = &pbufs->scratchbuf[0];
 	char *outbuf = &pbufs->outbuf[0];
+	va_list args;
 	size_t len;
 
-	len = scnprintf(scratchbuf, scratchbuf_sz,
-		       "** %lu printk messages dropped **\n", dropped);
+	va_start(args, fmt);
+	len = vscnprintf(scratchbuf, scratchbuf_sz, fmt, args);
+	va_end(args);
 
 	/*
 	 * Make sure outbuf is sufficiently large before prepending.
@@ -2851,6 +2852,19 @@ void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
 	pmsg->outbuf_len += len;
 }
 
+/*
+ * Prepend the message in @pmsg->pbufs->outbuf with a "dropped message".
+ * @pmsg->outbuf_len is updated appropriately.
+ *
+ * @pmsg is the printk message to prepend.
+ *
+ * @dropped is the dropped count to report in the dropped message.
+ */
+void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
+{
+	console_prepend_message(pmsg, "** %lu printk messages dropped **\n", dropped);
+}
+
 /*
  * Read and format the specified record (or a later record if the specified
  * record is not available).
-- 
2.45.2


