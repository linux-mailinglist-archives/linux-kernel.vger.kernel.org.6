Return-Path: <linux-kernel+bounces-564268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8012A65193
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD7CC188B50F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E91619D88B;
	Mon, 17 Mar 2025 13:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WFdeR7MN"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8A81487E1
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 13:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742219139; cv=none; b=FLuESkgRV46kGENmvuS0S7m5lkEpZDtFyn7ILbV6FNFkuBKH6cwb8ktZKrZmC4y1/FRHInWhQXy3U0zU1F8whTeFmAkKDMjIC9FbPxICntRRVb6PQCOxUNGy+tTKjoEnOORuEv/tljr2TeRrIwVfN3+3BD0RH6NatGiR5nCC9n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742219139; c=relaxed/simple;
	bh=EwvIcyOlxs0SRBFfD6KXNsK/Od0GTeNNYAv+MbvfiMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQlG58MdOrNmRViDW2ZXbT0qJ4YnQYXvUXsplqWF+58OivPc7qPsoedzAOtCPEXkB1I+R//sFx+efeEoHRP3Ev6e/YgBjWqXH92x+O5DJba+NaskJDuqx7+ISo/rANsIp1wP95Qys1LmVlUf14s+gey7q6IikPgdBY5TGPFZMCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WFdeR7MN; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3912d2c89ecso4070945f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 06:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742219135; x=1742823935; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7RYPTjFlSdbiVwRbP+5ezzFOuC5OjA62qsFQqYTMNpg=;
        b=WFdeR7MNEtqEQGQEwF1031Dv4h+f7wpLaqG1X9Dc9wDbjpkB8fYj5DCi5cTE/ssVQA
         K+f6YbW548c1ZVPFBnD1DbLyGLuZcWjx8/2Ugg+1j4MWoQCQMAWmyn5tlNzBOSmU1CKj
         DTFpiJgJrpRc2RByyQUMmTPuulcxVXve1yib4bmIGctLCfBkGXPzbO7AvjHodL29ufOh
         fbwsCwc1n2KJnIzJPJYIM4BopUqqrV4kylruZ2oMlmdHritoPOj7aVq3ykI9/lZ7gg2j
         rRvR4LZo3VPkMudYhLsrwg6x0S/PXn978Sx6SA2hrqu3toVT1kTlRcc/e0DZnl05On7D
         0miA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742219135; x=1742823935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RYPTjFlSdbiVwRbP+5ezzFOuC5OjA62qsFQqYTMNpg=;
        b=QW3fUkOsN67ztGrxGrCGxKaOy18oXNODPc04bjcQnX5yt16w+3IFmRcI+In5Yn0El7
         PoDeETSjz383lopcSYwi+xEVkHIVA+rcH5Ihjcva5DkBB1JWBRbOlm1hPnx6cRUn+Jf0
         17tKIpxsjxV8rV3DeQSJmcteUJKxgpIn87FiQ1CmB5Aij+OTO+qTSMeXB3zMZb1kZf8m
         uTKpkCU5Cxqy7mVI5K72Ai5uFPLD1eibq087ApeXhnoteMcEC9ernZO/tFbmbYb+XkDH
         0QG21B3n5XSSbG3OkwLiPkQGiy5ujhY4SVcddJEnKkF+DmVwe1VGtrljCM5tbx6B1Z5t
         lvww==
X-Forwarded-Encrypted: i=1; AJvYcCUEf8qqP5hoiP+Shiqn/OtGI2OdpmXYt11NUBp2b8HnctcZaAAhiV4ZPNlOF16/Yb+bJxLbY1TwDzS+L6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlTcQGfEClFEu/3tG7NIPOTAcZWuASX38KuNH82F1d2R7gBfvX
	76p+CDQZ8HO4BhvAL5718BXbbFWr+t3hwubDOo4Y64z6jO901c5MrakXzYzOwno=
X-Gm-Gg: ASbGnctLuStjVP/KV0pjwBqnAY8GbX7Z+VOfrufILClbyBXcD/FjU3raIBvGD0p8mlZ
	2NJXWlSCpLloxtL9Mz2UunHBdALWN1XL+Tdg2VdXFx0ilao7JDUdWAysS6kfBsbsjE9eL0kf2MV
	fBXYRHCygooOEdb6W6HuHq2EhmPTx221yikbcrY7dzOgpHs2/S85+HmUlEoM6lVOY+X0JXiQ3k9
	grTAqtsu2zewWoiFlHRvRf5Vxa6PKtNr0dky6aZFhersEAWjxCje1aRE1/tT4EBGsIAUhb20n0v
	pgs39uqi4SvBFM4PoJUEG2IOc94B3fw4cKZJXC3AsLKFeeg=
X-Google-Smtp-Source: AGHT+IGKXD3/o9Z4XGDkXz0xlimDMfqpN6wusRYWPKkLXhBOhrJAUefu7QMlxDr+KLe3+L26EuXQiA==
X-Received: by 2002:a5d:6d88:0:b0:391:2a9a:47a3 with SMTP id ffacd0b85a97d-3971a873726mr16343825f8f.0.1742219135023;
        Mon, 17 Mar 2025 06:45:35 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8881539sm14757542f8f.46.2025.03.17.06.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 06:45:34 -0700 (PDT)
Date: Mon, 17 Mar 2025 14:45:33 +0100
From: Petr Mladek <pmladek@suse.com>
To: Donghyeok Choe <d7271.choe@samsung.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org, takakura@valinux.co.jp,
	youngmin.nam@samsung.com, hajun.sung@samsung.com,
	seungh.jung@samsung.com, jh1012.choi@samsung.com
Subject: Re: [PATCH] printk/panic: Add option allow non panic cpus logging to
 ringbuffer
Message-ID: <Z9gnfSYnX3r0wwci@pathway.suse.cz>
References: <CGME20250305044241epcas2p45a526aecf91f33b9ac253f561e909978@epcas2p4.samsung.com>
 <20250305044046.1249972-1-d7271.choe@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305044046.1249972-1-d7271.choe@samsung.com>

Hi,

first, I am sorry for the late review. I have been snowed under many
other tasks.

Second, the patch looks fine. I just would like to do few cosmetic
improvements.

Let's start with the Subject. It has few small grammatical mistakes.
I suggest something like:

  "printk/panic: Add option to allow non-panic CPUs to write
   to the ring buffer."

On Wed 2025-03-05 13:40:46, Donghyeok Choe wrote:
> commit 779dbc2e78d7 ("printk: Avoid non-panic CPUs writing
> to ringbuffer") disabled non-panic CPUs to further write messages to
> ringbuffer after panicked.
> 
> commit bcc954c6caba ("printk/panic: Allow cpu backtraces to
> be written into ringbuffer during panic") allows non-panicked CPUs
> to write backtrace only.
> 
> Since that, there was a problem with not being able to check the
> important logs of the non-panicked CPUs.
> 
> Fix the issue by adding debug option(printk_debug_non_panic_cpus) to
> output the non-paniced CPUs' message.

I would slightly rewrite it. I took inspiration
in the first version of this patch, see
https://lore.kernel.org/r/20250226031628.GB592457@tiffany
and asked "Gemini" to help:

<proposal>
Commit 779dbc2e78d7 ("printk: Avoid non-panic CPUs writing to ringbuffer")
aimed to isolate panic-related messages. However, when panic() itself
malfunctions, messages from non-panic CPUs become crucial for debugging.

While commit bcc954c6caba ("printk/panic: Allow cpu backtraces to
be written into ringbuffer during panic") enables non-panic CPU
backtraces, it may not provide sufficient diagnostic information.

Introduce the "printk_debug_non_panic_cpus" command-line option,
enabling non-panic CPU messages to be stored in the ring buffer during
a panic. This also prevents discarding non-finalized messages from
non-panic CPUs during console flushing, providing a more comprehensive
view of system state during critical failures.
</proposal>

> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2375,6 +2375,19 @@ void printk_legacy_allow_panic_sync(void)
>  	}
>  }
>  
> +bool __read_mostly printk_debug_non_panic_cpus;
> +
> +#ifdef CONFIG_PRINTK_CALLER
> +static int __init printk_debug_non_panic_cpus_setup(char *str)
> +{
> +	printk_debug_non_panic_cpus = true;
> +	pr_info("printk: keep printk all cpu in panic.\n");

I would update the message:

	pr_info("printk: allow messages from non-panic CPUs in panic()\n");


> +
> +	return 0;
> +}
> +early_param("printk_debug_non_panic_cpus", printk_debug_non_panic_cpus_setup);
> +#endif
> +
>  asmlinkage int vprintk_emit(int facility, int level,
>  			    const struct dev_printk_info *dev_info,
>  			    const char *fmt, va_list args)
> @@ -2391,7 +2404,9 @@ asmlinkage int vprintk_emit(int facility, int level,
>  	 * non-panic CPUs are generating any messages, they will be
>  	 * silently dropped.
>  	 */
> -	if (other_cpu_in_panic() && !panic_triggering_all_cpu_backtrace)
> +	if (!printk_debug_non_panic_cpus &&
> +	    !panic_triggering_all_cpu_backtrace &&
> +	    other_cpu_in_panic())

I would switch the order:

	if (other_cpu_in_panic() &&
	    !printk_debug_non_panic_cpus &&
	    !panic_triggering_all_cpu_backtrace)

IMHO, it is more logical. Also both "!printk_debug_non_panic_cpus"
and "!panic_triggering_all_cpu_backtrace" are always true by default.

>  		return 0;
>  
>  	printk_get_console_flush_type(&ft);
> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> index 88e8f3a61922..ffab5f6c1855 100644
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -2143,7 +2143,9 @@ static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
>  			 * But it would have the sequence number returned
>  			 * by "prb_next_reserve_seq() - 1".
>  			 */
> -			if (this_cpu_in_panic() && ((*seq + 1) < prb_next_reserve_seq(rb)))
> +			if (this_cpu_in_panic() &&
> +				(!printk_debug_non_panic_cpus || legacy_allow_panic_sync) &&
> +				((*seq + 1) < prb_next_reserve_seq(rb)))
>  				(*seq)++;
>  			else
>  				return false;

The indendantation does not help much to understand where the if
(condition) ends. Also I would udate the comment. I suggest something
like:

--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -2133,9 +2133,9 @@ static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
 			 * there may be other finalized records beyond that
 			 * need to be printed for a panic situation. If this
 			 * is the panic CPU, skip this
-			 * non-existent/non-finalized record unless it is
-			 * at or beyond the head, in which case it is not
-			 * possible to continue.
+			 * non-existent/non-finalized record unless non-panic
+			 * CPUs are still running and their debugging is
+			 * explicitly enabled.
 			 *
 			 * Note that new messages printed on panic CPU are
 			 * finalized when we are here. The only exception
@@ -2143,10 +2143,13 @@ static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
 			 * But it would have the sequence number returned
 			 * by "prb_next_reserve_seq() - 1".
 			 */
-			if (this_cpu_in_panic() && ((*seq + 1) < prb_next_reserve_seq(rb)))
+			if (this_cpu_in_panic() &&
+			    (!printk_debug_non_panic_cpus || legacy_allow_panic_sync) &&
+			    ((*seq + 1) < prb_next_reserve_seq(rb))) {
 				(*seq)++;
-			else
+			} else {
 				return false;
+			}
 		}
 	}
 

With the above changes:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

