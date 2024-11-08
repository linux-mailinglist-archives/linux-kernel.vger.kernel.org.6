Return-Path: <linux-kernel+bounces-401390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C47C9C199F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A9F9B21BD5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B011E1C29;
	Fri,  8 Nov 2024 09:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ErusWkfo"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0848F1E1A1F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 09:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731059879; cv=none; b=QEGn7WB9uCUcV33vAbocf+esyq32x7Cvfd6fePCM3UXJdsf/gKtLXX/NzH/A4tQH8F3893BbPHYrq8N6ID5dTowtxH1zffJvWh9CMv9PFsiFnXvuWXlF8GLas1y/ibjbZ30h/kHws67uxmIDR5ZjjNqPEMZTPgqnUOnq3YxEg+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731059879; c=relaxed/simple;
	bh=N9bi2WmF5iGQNflwMflPPH6/tarr330e1l0s7QEpbps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bADmvRX+jGrnaR5SfylPpGF3PpaLqRzwJEInpobOBvQc1lx7gPDywk1Xb3hEcpILqdlvRwRrKrblOoa5ndNx3W2P4Y5GMnZpKjAyaB56Io/LIXzfbPLxVXVfMVf/pdjdAF4/SUSk4b4L/jdDWUraHhOLYM9YmU1VdtyISEkzDiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ErusWkfo; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539f0f9ee49so2139208e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 01:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731059875; x=1731664675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4O5Z1ey1Xbo/lGaAnLoLDtEOXFTyarawPpoKW2uPby8=;
        b=ErusWkforDTPiMtffZ2B+D7XCKJPwjvIijq2eboV5ugj0aycEeLpl6cykUzQitDc7s
         AC4hs0BxENhYiCMgyWIkDx2bAaQdhcc0OzVf7F3UAhj1UPkojzFCAxPtNh5zhFxLdyze
         t/SQbxXvpkyzBPO9S/82Gz8X07vTOyo/evO+679U7WVlM8A4zzPjR3lqph60iZhv+6sy
         eMXQ4twdriKf8CHD898ONn9fz8egqeLQ3yEL0JJJ0EVOzR4NriL12OPOIlsUdS0zhxt3
         7LSr6InkNO/Y5ra1EmL2CjFSsxfma7QIM1mWq4/fJA+1x6U7Yj4It7/8qkaGWOvkWw4Z
         O3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731059875; x=1731664675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4O5Z1ey1Xbo/lGaAnLoLDtEOXFTyarawPpoKW2uPby8=;
        b=dwNjVcQVibvnUa42s2EQxgw2ewoWbFceJ4QJQj3kluyTsC/MaRo9F7PJQ1rNG91SLt
         fCJ9chUan0+OlzY3IhriZm0rqoOURuXWC1n/KKnLKkW24slLTpljy7TRgNsVXJvaCVcd
         zhycPXvxF9n2XOZ9UHhFGeDkkrmC4Jfb1tw8qmnJeA2XlAifs3bZ4R2Ezk6br9DERZo8
         wZNZJPpnt9/6tPfWSFGqO0FR9Q+xchH+ce3KKkIo6d/9RMnK1Pva5kSWkryNrXEOAHyY
         B7U6ZxPofu0ji0AL/DvhXjBl+Nf5D2eCCQqDZ6Ia1GOVTLteVeYMCukS6TdBJrlmYwmK
         iGrw==
X-Gm-Message-State: AOJu0YwUPLxkAM9FRjbgXaWtWzDH1iGhXiPvXK/vPckBTbQnYkTaE31N
	R8GgnieJiIIRP/VR3M/j1ugYkkNY3Mmo4YZSdordmLaKvm6O3eZOj3l1fNwn6Jg=
X-Google-Smtp-Source: AGHT+IGr6RL3cKCSgFCNbwWhMSJlVg/B0eNNCF4/KGGeNurJP0fn2feQGt8IyU7NfG43pVCEMco7lg==
X-Received: by 2002:a05:6512:308d:b0:539:ecef:376d with SMTP id 2adb3069b0e04-53d862f052dmr1099760e87.54.1731059874927;
        Fri, 08 Nov 2024 01:57:54 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e58357sm26645595ad.193.2024.11.08.01.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 01:57:54 -0800 (PST)
Date: Fri, 8 Nov 2024 10:57:43 +0100
From: Petr Mladek <pmladek@suse.com>
To: Chris Down <chris@chrisdown.name>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: Re: [PATCH v6 02/11] printk: Use struct console for suppression and
 extended console state
Message-ID: <Zy3gl84l-74oKP8I@pathway.suse.cz>
References: <cover.1730133890.git.chris@chrisdown.name>
 <ba47efbe432cf33cb358a027a2266296e2cfe89e.1730133890.git.chris@chrisdown.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba47efbe432cf33cb358a027a2266296e2cfe89e.1730133890.git.chris@chrisdown.name>

On Mon 2024-10-28 16:45:34, Chris Down wrote:
> In preparation for supporting per-console loglevels, modify
> printk_get_next_message() to accept the console itself instead of
> individual arguments that mimic its fields. As part of the upcoming
> per-console loglevel support we need the console object here anyway, so
> it makes sense to amortise this now.
> 
> devkmsg_read() has special behaviour here, but all other consoles follow
> the same patterns and can have their extension/suppression states
> determined from their struct console.
> 
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2925,20 +2925,19 @@ void console_prepend_replay(struct printk_message *pmsg)
>   * @pmsg will contain the formatted result. @pmsg->pbufs must point to a
>   * struct printk_buffers.
>   *
> + * @con is the console in question. Only @con->flags and @con->level are
> + * guaranteed to be valid at this point. Note especially well that con->seq is
> + * not yet guaranteed to be consistent with @seq.

@con->level does not exist at this point.

But more importantly, the read of @con->flags and @con->level is
sychronized only by SRCU read lock. It means that the word "valid"
is a bit misleading. SRCU just guarantees that the struct console
can't disappear.

I would write something like:

<proposal>
 * @con might point to the console where the read message will be emitted.
 * It is used to determine the format of the message and whether it would get
 * suppressed. The sequence number stored in the struct console is updated
 * by the caller depending on whether the emission succeeds.
 *
 * @con might be NULL when the message is used for another purpose,
 * for example, devkmsg.
</proposal>

> + *
>   * @seq is the record to read and format. If it is not available, the next
>   * valid record is read.
>   *
> - * @is_extended specifies if the message should be formatted for extended
> - * console output.
> - *
> - * @may_supress specifies if records may be skipped based on loglevel.
> - *
>   * Returns false if no record is available. Otherwise true and all fields
>   * of @pmsg are valid. (See the documentation of struct printk_message
>   * for information about the @pmsg fields.)
>   */
> -bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
> -			     bool is_extended, bool may_suppress)
> +bool printk_get_next_message(struct printk_message *pmsg, struct console *con,
> +			     u64 seq)
>  {
>  	struct printk_buffers *pbufs = pmsg->pbufs;
>  	const size_t scratchbuf_sz = sizeof(pbufs->scratchbuf);
> @@ -2948,6 +2947,14 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
>  	struct printk_info info;
>  	struct printk_record r;
>  	size_t len = 0;
> +	bool is_extended;
> +
> +	if (con) {
> +		is_extended = console_srcu_read_flags(con) & CON_EXTENDED;

I guess that we would need to implement similar API also for reading
the per-console loglevel. I mean that we should check the SRCU lock
is held. And describe the potential data_race() if the value might
be modified by a sysfs interface in parallel.

Let's discuss this in the patch adding the read. I mention it here
rather just as a mental note. The proposed comment says that it will
be synchronized using SRCU. We need to make sure that it will
be valid also for the loglevel stuff.

> +	} else {
> +		/* Used only by devkmsg_read(). */
> +		is_extended = true;
> +	}
>  
>  	/*
>  	 * Formatting extended messages requires a separate buffer, so use the

Anyway, the change looks fine. With the updated comment:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

