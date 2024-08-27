Return-Path: <linux-kernel+bounces-303665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F1B96133D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BDB61C22E96
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BF51C93B9;
	Tue, 27 Aug 2024 15:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UZPPJ/ZC"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F50B1C57B1
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 15:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724773834; cv=none; b=eZDFJD95RjTbsfy25duGhzpSsdV+6p4vUMSH5Df+CM1j2wna0TEZHx2szSy8Xphb0irfk/ZU6n1zJrmkr/Si3JSQIki734+muA8hOx0/KG6U+Xmb5R4MwCT12Xg1ABy3UxpGGnYClcYU66wuL6ijD9jlJ48ERPsYSS/hEFQKpNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724773834; c=relaxed/simple;
	bh=Xj4jKomYimzW3NGNZve+oD+PY1FEeu/SsrX38CnwxK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Culc7/dYreb6LX7Qypd2czZthxf4Mp4y4NA0UpkUT1/e8Q5kPJjl/pNBxsZ/SFCQP9MkG5a75S/49CelE7nmSXjczION61fnJg3ot6O73jxulj8n753LzXbdGrZSvszJb+6nnxaOyN1UQRCnsKqQ26dVcZrdGojw6FaeTWffIJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UZPPJ/ZC; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37198a6da58so3982369f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 08:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724773830; x=1725378630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HYHYe6mgJdakAm0fe4ggqtacWr9TU/8V8y8IEeD0kkY=;
        b=UZPPJ/ZC3u2QZPpG3qZrCak4gGVGN04nU81nkgove4XFhYEStESZIdm3fML01SAEhe
         LCNl0YbCHCroF8wikMXu3ZTOWfcfMXgvb9yLbmqait2FPfC54Zjr0L9nAGU4JcBMP3cZ
         DgpDLw8GZW8rTiVu13gjjXSHxwUjji5KVMdsvO+JBVJ4ogKsCn78Ip2HHEG7awSeaS1D
         1lj7VJMIA5TGMuR2kP1UedUDo9soL9d6OCHZJLzR60h2vfjKIHQVndM3Im/zkOCCoTQo
         a4hGke3vxB4Pssa7L2x8wkGITX0JOI+ZA0Bgo//ejcFxGdibdLeL8IFbRV8uXFw8iM/r
         0yGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724773830; x=1725378630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYHYe6mgJdakAm0fe4ggqtacWr9TU/8V8y8IEeD0kkY=;
        b=bHUvP2kTo+19tW5Gjk+stOsaF/HWandu/5zBK5tz9vnRcm1TzYtF+Lk3jttOSnOY1m
         dnOEN2TxxHKiXwZTb5DHEHMCA0JFsG16VjPbLUJZnEg7wmtpX97MQYGRojHn4QqkNbWG
         b1VLT84FsGXAmZb8wV8Jf46ZbkIjwCLQvoJCk1zdARvO2/rrDhg1u0bnkcX4lq6kljbr
         sUCzgYCdT1DfaRVgp2SmrCvtjnipkQDZiP1UyijI7SChaEW7duQuENOX9+uBlhzx54D4
         7dxKLo+rtSBbt6NbCHEGxr92HCeFyPNYwAM6Mnk7y/1elsf3oH/gZb2hcEkXjj/Jf2pe
         4KdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj2iX71xPNe1BAr+9UMmpz0mo0SuANLEKS5RCzogrTU2HvyoQI6CWb3JpX2G0rEKIMy7cnMOhJeZRaH+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPjHlcpDv6q56q0Gjf7LWbHOl5JRa2d/0tle2IwDfT+9bGL0CM
	fNVCWbROc83NJPvUx5e+YnngFhSxYSVD+mm1KQKH8a5RvB7i01ValUk37VGg8n0=
X-Google-Smtp-Source: AGHT+IFBvwwkQc+etfgT1zS3EgEEyaqyxFiE8iazXzSI7Lh3w7j0dDoev7tpLKnWLUWbKAlI4OUfYA==
X-Received: by 2002:adf:f0cd:0:b0:368:7282:51d6 with SMTP id ffacd0b85a97d-37311856059mr10694608f8f.21.1724773830397;
        Tue, 27 Aug 2024 08:50:30 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e549cad0sm124876766b.49.2024.08.27.08.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 08:50:30 -0700 (PDT)
Date: Tue, 27 Aug 2024 17:50:28 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v4 09/17] printk: nbcon: Rely on kthreads for
 normal operation
Message-ID: <Zs31xM0Nn0hEb74O@pathway.suse.cz>
References: <20240827044333.88596-1-john.ogness@linutronix.de>
 <20240827044333.88596-10-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827044333.88596-10-john.ogness@linutronix.de>

On Tue 2024-08-27 06:49:25, John Ogness wrote:
> Once the kthread is running and available
> (i.e. @printk_kthreads_running is set), the kthread becomes
> responsible for flushing any pending messages which are added
> in NBCON_PRIO_NORMAL context. Namely the legacy
> console_flush_all() and device_release() no longer flush the
> console. And nbcon_atomic_flush_pending() used by
> nbcon_cpu_emergency_exit() no longer flushes messages added
> after the emergency messages.
> 
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2749,6 +2753,10 @@ void resume_console(void)
>  	 */
>  	synchronize_srcu(&console_srcu);
>  
> +	printk_get_console_flush_type(&ft);
> +	if (ft.nbcon_offload)
> +		nbcon_kthreads_wake();

Who would flush the nbcon consoles in the following case?

  ft.nbcon_atomic == true && ft.legacy_direct == false

pr_flush() won't call the legacy loop in this case.

We should probably update pr_flush() to call nbcon_atomic_flush_pending()
in this case.

> +
>  	pr_flush(1000, true);
>  }
>  
> @@ -3387,9 +3405,25 @@ EXPORT_SYMBOL(console_stop);
>  
>  void console_start(struct console *console)
>  {
> +	struct console_flush_type ft;
> +	bool is_nbcon;
> +
>  	console_list_lock();
>  	console_srcu_write_flags(console, console->flags | CON_ENABLED);
> +	is_nbcon = console->flags & CON_NBCON;
>  	console_list_unlock();
> +
> +	/*
> +	 * Ensure that all SRCU list walks have completed. The related
> +	 * printing context must be able to see it is enabled so that
> +	 * it is guaranteed to wake up and resume printing.
> +	 */
> +	synchronize_srcu(&console_srcu);
> +
> +	printk_get_console_flush_type(&ft);
> +	if (is_nbcon && ft.nbcon_offload)
> +		nbcon_kthread_wake(console);

Same here.

>  	__pr_flush(console, 1000, true);
>  }
>  EXPORT_SYMBOL(console_start);
> @@ -4629,8 +4665,13 @@ EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
>   */
>  void console_try_replay_all(void)
>  {
> +	struct console_flush_type ft;
> +
> +	printk_get_console_flush_type(&ft);
>  	if (console_trylock()) {
>  		__console_rewind_all();
> +		if (ft.nbcon_offload)
> +			nbcon_kthreads_wake();

And here. We in this case, we should likely call add here:

		if (ft.nbcon_atomic)
			nbcon_atomic_flush_pending()
			
>  		/* Consoles are flushed as part of console_unlock(). */
>  		console_unlock();
>  	}

Best Regards,
Petr

