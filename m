Return-Path: <linux-kernel+bounces-219758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEBF90D765
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 605DC1F24082
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261783D0D5;
	Tue, 18 Jun 2024 15:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bC8GSTI/"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7094A35
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718724865; cv=none; b=SW16fGDKCUJrGPl0TXThroV2U0D/81/okBcqjXVNnEyeaxZZO0G75yAhOUeqDUnfc4mA7rNzjvTlBzowNAe5iQpA+5FJP2W/iVS3GiaaVvSOpSPq2Y8YKM5JmNZT029e6WyC1RuFj4AS7AOZa60EKHt9j+izPTvbbO2yZV+4Zn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718724865; c=relaxed/simple;
	bh=klRn8hEHrMEOkXwedKBnqGZoiaDq3LJBujN4oUNzn90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKLA9kSk5B+Hm26QFck95k6BGjiaPq1Zu9y/qmDZi0JGdYOAJzHjWttqTu0GGNBZzh8rp1s60E/e9lnFXGGtiD7QdLhnQOFQeqNU57pie2YD8a7k6HnNbqp3DXk9QNITu9008eJyZKahRmtMGVbao1mmNNlO8Ix0HV9b7IV5sSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bC8GSTI/; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso658262866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718724861; x=1719329661; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=43PtNKyazrFRNMPvJuCC2xLcEd12xxILp702APcFCH0=;
        b=bC8GSTI/zMe4Qirq9TjMP3H6XP/18rGkNd498oXtU3gOEesFqb1hBkWPNdmfJ5dCra
         uawMyCNi1VSGuHRMAWisXiciKxDvY3ohIpzxsnxKH/IaycUgY6SyRVVKkH1DzGwwu5BB
         DBiIGih7WTnDZuF+FRUA5CaGUbUFNfg3tOcawZe/39rd4NPwpI5je9HoKoxO+X3kil+s
         zGWHyY4jSoyGQGoAHAN08N/lZt5x0JDcijHwkGeKQGb23FfXBNJpBnDY3OgKY3pHXwVe
         dqPWee3cJ9DIV95V3s+Tq4sm6p4U7zcALSotEcr3wrEl0/ZZnonoSEJsGvTrM48zqOGQ
         fAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718724861; x=1719329661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43PtNKyazrFRNMPvJuCC2xLcEd12xxILp702APcFCH0=;
        b=wCgCrftH+vGt3ibnFQS8JEqyBO6p+HwKsd97pQC0uzsGaAglo80BnMjyg1zoVZuyA+
         vZkNwJXgLvvLDVPrzZLht1L6NclnuyxVTluiSyOAsa9IZWILq/pq7gG20PeMD4M5oxKc
         PzuStF2+KijlfFm8/n6QjqzY8gSHcYltNT8v20dWJ4awMf6BjlyFchITeUjNoH1B0+kT
         +xyW/LxUo3o9Kvy/gV/0gMg65LzhP9eQ7bec4ml0KivJvXQxteUjEVadp8pHoJvgMBJD
         YkhIghzNC6bfDAvwfuHFpS1tGVDjTBBlfdp9LisoX5P2jZYhj0hUBiPBGDFfqPq3a+F9
         XLOA==
X-Forwarded-Encrypted: i=1; AJvYcCXT9TEtuuSd6diKeN+yvB/dAmoEcosZO7SakmFy9CmEX3U2y+1A69+PLd4ec67sv3tc+CKGktyHhvK30d9PyKsD4dw4HCVIpwGNFmi6
X-Gm-Message-State: AOJu0YwVWmUJg9yMH6U+lGS9maUmTvfMPGG/7pderXydwxqj8w2tFiv+
	rzq9BTM7JqEbNzMULfdf95NB5fCWase5NFAyUhqzEYzS9qIvf8WBf9SDyK3XYJIzZO0nhV8Pwbm
	o
X-Google-Smtp-Source: AGHT+IGDpayvEFITYrmAlBbYdZfw9pR5A8Lp3WO6s98DJhd24h4nf2cHpplg42jxNxt5Cv8vWtqPHQ==
X-Received: by 2002:a17:906:4f08:b0:a6e:2a67:7899 with SMTP id a640c23a62f3a-a6f60d40d5dmr740828666b.35.1718724861299;
        Tue, 18 Jun 2024 08:34:21 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f6b2b04f5sm478728066b.192.2024.06.18.08.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 08:34:21 -0700 (PDT)
Date: Tue, 18 Jun 2024 17:34:19 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 09/18] printk: nbcon: Start printing threads
Message-ID: <ZnGo-7ctV9oidQM8@pathway.suse.cz>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <20240603232453.33992-10-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603232453.33992-10-john.ogness@linutronix.de>

On Tue 2024-06-04 01:30:44, John Ogness wrote:
> If there are no boot consoles, the printing threads are started
> in early_initcall.
> 
> If there are boot consoles, the printing threads are started
> after the last boot console has unregistered. The printing
> threads do not need to be concerned about boot consoles because
> boot consoles cannot register once a non-boot console has
> registered.
> 
> Until a printing thread of a console has started, that console
> will print using atomic_write() in the printk() caller context.
> 
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1568,6 +1570,19 @@ void nbcon_kthread_create(struct console *con)
>  	sched_set_normal(con->kthread, -20);
>  }
>  
> +static int __init printk_setup_threads(void)
> +{
> +	struct console *con;
> +
> +	console_list_lock();
> +	printk_threads_enabled = true;

What is the actual meaning of the variable?

Does it mean that kthreads can be created? (can be forked?)

It does not guarantee that the kthreads will be running.
They might still get blocked by a boot console.


> +	for_each_console(con)
> +		nbcon_kthread_create(con);
> +	console_list_unlock();
> +	return 0;
> +}
> +early_initcall(printk_setup_threads);
> +
>  /**
>   * nbcon_alloc - Allocate buffers needed by the nbcon console
>   * @con:	Console to allocate buffers for
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2397,6 +2400,7 @@ asmlinkage int vprintk_emit(int facility, int level,
>  		 * consoles cannot print simultaneously with boot consoles.
>  		 */
>  		if (is_panic_context ||
> +		    !printk_threads_enabled ||
>  		    (system_state > SYSTEM_RUNNING)) {
>  			nbcon_atomic_flush_pending();

IMHO, this is not safe. nbcon_atomic_flush_pending()
is synchronized only via the nbcon console context.
It means that there might be races with boot consoles.

Another problem is the meaning of @printk_threads_enabled variable.
It does not guarantee that the kthreads are running. They might
still be blocked by boot consoles.


BTW: The same problem might have the system_state > SYSTEM_RUNNING.
     The boot consoles are removed only when the preferred console
     is registered and "keep_bootcon" is not set.

     Note that printk_late_init() unregisters the boot consoles
     only when they are using a code in the init sections.

>  		}

My view:

We need to enable creating the kthreads when:

  1. the "kthreadd_task" is running. It is a kthread responsible for
     forking new kthreads. And it is started after the init task.

  2. There is no boot console.

Plus we could use con->write_atomic() only under console_lock()
when there is still a boot console.

Best Regards,
Petr

