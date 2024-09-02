Return-Path: <linux-kernel+bounces-311488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEB39689C1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C76ADB23986
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D83721019E;
	Mon,  2 Sep 2024 14:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PkvlhCBc"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E6419E97B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286750; cv=none; b=onxbZv0t/V8ls0aMJEVg7tXhJTl8VP4lsONsIRY2KWDjWVg7t2RrR0Ceax3aPzkxt839tJQb72JUzIOFmGx7ls0C3CopfoBe3j70hJd7+QfTLKlDSsOsMIr6PPVNza/LGef86MCT2VL0iw8jLa/VRCnjaC+TheaePlgW8rL8adA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286750; c=relaxed/simple;
	bh=SLGdTn07ubtZV6/hUwLuYIoHIRjobY+U0ouygKTMHA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPlAUANTJGWjzvujWcc0qxHrWhFCnG5MhFKhhGiKOfIRKnwRYqCEQ7rlSSr/orvDpq44LyhkrqIkawZT2WExR8DIL8Q6M1trtHrRvylwbQKxkqHKB7oSsfgACH1LMF11RgwwMFzO9hU6N+YDMhqVsx+vFy6kpYW/CpUVg+hm9GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PkvlhCBc; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a869332c2c2so842055166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 07:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725286745; x=1725891545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uyQjlRpKvPqTe2Vvys+QBD2N8AIKIgckiJUDqZFzBsY=;
        b=PkvlhCBc4pFrgrEJif00LKz+CapjsKcPSlkBtY23eHF8k+AcpLvYczOAf/IsMABeVH
         LGRuB3VnbqfHex5jYj6cXyJ1dHcr2EWghBskWVZfYv7dC+uQXVxcribr6PwGKqHziWJX
         QBg7r8lCEp8Hsj640a2M16mwHVFusiEnQhFLQqYpFey64aNx6OZuqQ6ZrJ0gKBWnfday
         OiG6Mxe7GUMYNRksR37y8QN+TcIKSrDTiwHUkE18O9r7Uve3dKI6N3TE9w1Qs3AbnrkH
         A4scCkizhZriFzkF4/Z/jY36lEyzc+KD7iza/SD1+Er7OaVkDY84m9yYnGKh9tLqNgxY
         i13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725286745; x=1725891545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyQjlRpKvPqTe2Vvys+QBD2N8AIKIgckiJUDqZFzBsY=;
        b=oyhmphplUbtk3FPT9bpPVgDd7hlWM+Nd8tqH9DOVw4HBrmZM5zO8VOgQOtaeFSCj7T
         CWFiK2MQeywpyLQEucJrqQ3O2CpdrNmqFsMCbAEyotJE70s1Ujms85AMhyv8l+Whse7+
         e0LcRMXUwBTLNpn1JuHXG/ZkoaLhwjMpzHDaMWa5Rxobhs4Qq4SYEsS/UhGFK6RszOuy
         ISxobv8Yj24FwBqqr7K7feyLstCwDdY4VBLm4hFIMBzq5M9fJLkXahiOuS4OKmiIljyL
         4zQpC8PtcAfaQyzuLt3oBpefTlcJ4tQc7R/d3UQgaCzEmmT89jnp03RvdVt0qf5Kk3Pr
         srYw==
X-Forwarded-Encrypted: i=1; AJvYcCXkGWSwiAS1h/rmAxbbcL0asZM/kiAy000bYqfeSVkJpisgjP/P5AsXmC4bujm5eqgCUZMrBnSpa4IkB+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV62qQkxC0U315mcGJ1oVb+LKa/w9yFMxmsxOTy7xhywhzji2b
	Z/nwuWSNHGeuYEL5eFzzLGNW68eMwBI54xhIaujQ1HzYCAFuFqcAMnpkCrh/zAlKixl1g5iZDDX
	O
X-Google-Smtp-Source: AGHT+IHZ+0ilJpGlXDpC+TLSggtI+tYYb6aoKjE8QCfgLYzhbjycS+rUWvgpyuCYE+F8eXr5WPUrDQ==
X-Received: by 2002:a17:907:608c:b0:a80:f646:c9c4 with SMTP id a640c23a62f3a-a898231c37emr1576759366b.1.1725286744521;
        Mon, 02 Sep 2024 07:19:04 -0700 (PDT)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a898900ec17sm567413766b.62.2024.09.02.07.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 07:19:04 -0700 (PDT)
Date: Mon, 2 Sep 2024 16:19:02 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v5 06/17] printk: nbcon: Introduce printer kthreads
Message-ID: <ZtXJVvtDNDV7ZaTZ@pathway.suse.cz>
References: <20240830152916.10136-1-john.ogness@linutronix.de>
 <20240830152916.10136-7-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830152916.10136-7-john.ogness@linutronix.de>

On Fri 2024-08-30 17:35:05, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Provide the main implementation for running a printer kthread
> per nbcon console that is takeover/handover aware. This
> includes:
> 
> - new mandatory write_thread() callback
> - kthread creation
> - kthread main printing loop
> - kthread wakeup mechanism
> - kthread shutdown

I have found one more small problem.

> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1036,6 +1042,225 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
[...]
> +/**
> + * nbcon_kthreads_wake - Wake up printing threads using irq_work
> + */
> +void nbcon_kthreads_wake(void)
> +{
> +	struct console *con;
> +	int cookie;
> +
> +	if (!printk_kthreads_running)
> +		return;
> +
> +	cookie = console_srcu_read_lock();
> +	for_each_console_srcu(con) {
> +		/*
> +		 * Only schedule irq_work if the printing thread is
> +		 * actively waiting. If not waiting, the thread will
> +		 * notice by itself that it has work to do.
> +		 */
> +		if (rcuwait_has_sleeper(&con->rcuwait))

This is called for all consoles but con->rcuwait is initialized
only for nbcon consoles.

I would add above this check:

+		if (!(console_srcu_read_flags(con) & CON_NBCON))
+			continue;

> +			irq_work_queue(&con->irq_work);
> +	}
> +	console_srcu_read_unlock(cookie);
> +}
> +

With the added check:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

