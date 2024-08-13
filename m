Return-Path: <linux-kernel+bounces-284919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4A29506DB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 061A91C229CC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD9819CCED;
	Tue, 13 Aug 2024 13:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Qi30wFMT"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E260C29CEB
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 13:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723556729; cv=none; b=JC3BBvqhewuBgvYEMQGf0+hVisKQJ2sClp4Wif/9ebQLY2BI8zdAhQgk4JMZK3XPhftM9HcNRTY6pUc7ecbSznrpahwJPNW5HkO65pyTNpO08nzEowYbZP83J+febLAr//wUJtMuP3wbUmgbLSudl2RRoR148uhso+Zznxr7yUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723556729; c=relaxed/simple;
	bh=ujxibdwvLK30VH3vS/JhhY7h5SBArKVRCrWFyndrJNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHsecinzbpSWVzvBpfEQxijaJYbpSEPsLxsMqq3GWBJWhDVcFUk6I05NVJwuveSzKkk5X9h54H6eVXxpbbXfSjp4W5EkZU7JODl5fd0JLexzcvRvOolY2dr4L+rTJ4VtsQaUVp5GOIgorRAnqDvD6KBaZqAYA1s5tNqscYkZLCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Qi30wFMT; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5af6a1afa7bso6428225a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 06:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723556724; x=1724161524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LKJwF414fsJ5dNSWPktLWSIbIfwG1iFkWQp8KafyxHA=;
        b=Qi30wFMTxPN/c516Q5zg81hr8ayFpDBW06nzhPORlkAJvPAUWcppe+oCKTKwstkNuW
         Ha6kDwoalcCl3byz2HZ2EcCJ1GG3sVL6CN0bxYgJCPzFlgtTWoMIw+vd9KJq8Lra6EdM
         n0D2qYCCVuFgcN8IpPe+yqqnl8Srg++VplnlqAuwA2yJFbbM+0/MSukJOl1gpnVoh/ry
         1allz86JR2xvVg3VOxeXzK29JMk9oscp4be3zEo3xhr7VhtpIOs+AZyCxuS4Q36Zpkkf
         mMtd0ACKQCiZEp3ix4FiBQn8wluvP7JEQo09mqgIsh+vbIp9s6R0q2PZI9jtGUC23Q+y
         Pg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723556724; x=1724161524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKJwF414fsJ5dNSWPktLWSIbIfwG1iFkWQp8KafyxHA=;
        b=B/RCoowH3PVeotGsu/GNQ7JVKYyk+z0Pgc4cZeqArsoc2t4BWjw5mZwgj1e+wQkXZz
         5H+IW8e7Ljaje87W6iW04UdTLcN/UNz+U6HgTpdtQWLKIZi3ZxeeubJnKkXlOD5wqgRw
         +yd9q6G1qhDU/drR9352PMKz4lPMq5bJAAEtHsHbeKG5ipdD3q83Sa3oXfD314uSQjug
         d9CNmbZ59IzHIsf+k9+dtELiYMeSQ8+rDUJv6i7MrRtkK9fib8wcjjEwGluIexk/8LqP
         EYeXTRrtNd1UHRlYx3Xnohs2UswsYfIWexjlTiC0aNxevkoUEAQE3w4JqNljXZIoN3Bk
         VkQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcoXePXQMqG5GiImq+UFqaVli+id8TPCLw0S4bEFCA9V6hmoNk3xpnkXUySpBP/xQe2VbmSSFwXNo/uSRceMbji0nPy8ur3ir1bWE8
X-Gm-Message-State: AOJu0Yz3c3QYYXhV6KYln8HMZzRtWFHMTmeHREdDT5mJ8e40aSBtVLlU
	iz37As3/FbITyRkPMjaya35/d4acfeccHnGw8FVLe3Yo3JlZb6JytF6Mhtuphyo=
X-Google-Smtp-Source: AGHT+IEzJRf7MFyDsVxjW673BylqHIB96B4aipixnP3nuiONRJdGY8k0OmutBEO+xwFhvigjx9Godw==
X-Received: by 2002:a17:907:6d23:b0:a7d:a00a:a9fe with SMTP id a640c23a62f3a-a80ed1bfe32mr268358366b.17.1723556724010;
        Tue, 13 Aug 2024 06:45:24 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f414e46csm72026366b.180.2024.08.13.06.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 06:45:23 -0700 (PDT)
Date: Tue, 13 Aug 2024 15:45:22 +0200
From: Petr Mladek <pmladek@suse.com>
To: takakura@valinux.co.jp
Cc: rostedt@goodmis.org, john.ogness@linutronix.de,
	senozhatsky@chromium.org, akpm@linux-foundation.org, bhe@redhat.com,
	lukas@wunner.de, wangkefeng.wang@huawei.com, ubizjak@gmail.com,
	feng.tang@intel.com, j.granados@samsung.com,
	stephen.s.brennan@oracle.com, linux-kernel@vger.kernel.org,
	nishimura@valinux.co.jp, taka@valinux.co.jp
Subject: Re: [PATCH v3 2/2] Handle flushing of CPU backtraces during panic
Message-ID: <ZrtjXChY_0wnFXsS@pathway.suse.cz>
References: <20240812072137.339644-1-takakura@valinux.co.jp>
 <20240812072931.339735-1-takakura@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812072931.339735-1-takakura@valinux.co.jp>

On Mon 2024-08-12 16:29:31, takakura@valinux.co.jp wrote:
> From: Ryo Takakura <takakura@valinux.co.jp>
> 
> After panic, non-panicked CPU's has been unable to flush ringbuffer
> while they can still write into it. This can affect CPU backtrace
> triggered in panic only able to write into ringbuffer incapable of
> flushing them.

I still think about this. The motivation is basically the same
as in the commit 5d5e4522a7f404d1a96fd ("printk: restore flushing
of NMI buffers on remote CPUs after NMI backtraces").

It would make sense to replace printk_trigger_flush() with
console_try_flush(). And the function should queue the irq
work when it can't be flushed directly, see below.

> Fix the issue by letting the panicked CPU handle the flushing of
> ringbuffer right after non-panicked CPUs finished writing their
> backtraces.
> 
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -260,6 +260,7 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
>  		panic_triggering_all_cpu_backtrace = true;
>  		trigger_all_cpu_backtrace();
>  		panic_triggering_all_cpu_backtrace = false;
> +		console_try_flush();
>  	}
>  
>  	/*
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3284,6 +3284,20 @@ void console_flush_on_panic(enum con_flush_mode mode)
>  	console_flush_all(false, &next_seq, &handover);
>  }
>  
> +/**
> + * console_try_flush - try to flush consoles when safe
> + *
> + * Context: Any, except for NMI.

It is safe even in NMI. is_printk_legacy_deferred() would return true
in this case.

> + */
> +void console_try_flush(void)
> +{
> +	if (is_printk_legacy_deferred())
> +		return;
> +
> +	if (console_trylock())
> +		console_unlock();
> +}

I would do something like:

/**
 * console_try_or_trigger_flush - try to flush consoles directly when
 *	safe or the trigger deferred flush.
 *
 * Context: Any
 */
void console_try_or_trigger_flush(void)
{
	if (!is_printk_legacy_deferred() && console_trylock())
		console_unlock();
	else
		defer_console_output();
}

and use it instead of printk_trigger_flush() in
nmi_trigger_cpumask_backtrace().


Well, I would postpone this patch after we finalize the patchset
adding con->write_atomic() callback. This patch depends on it anyway
via is_printk_legacy_deferred(). The patchset might also add
other wrappers for flushing consoles and we have to choose some
reasonable names. Or John could integrate this patch into the patchset.

Best Regards,
Petr

