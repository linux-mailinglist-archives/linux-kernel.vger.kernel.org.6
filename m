Return-Path: <linux-kernel+bounces-269331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E606E9431A3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 168F21C217F4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F267D1B14FF;
	Wed, 31 Jul 2024 14:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NO92i3ba"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F39539A
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 14:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722434813; cv=none; b=lA4Gj7lmEnw0ca47TpD+FBjjVsLV53XMvG5zzru0HpX7M/WKiihdbGL2/DUWwlqTDcWwFhBd+7AUKHKohmBqfzTuYUHY82qbUcqO5zgRapi99y996cs+K0x4cUj6EidY6TgP3YnUBAgO2MCB91LJ6YCSzWvSO97l1PEeXxAy8yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722434813; c=relaxed/simple;
	bh=q8JDhzw1q14rcU2eDiP5P4zsSAZiF0l7N+t/47LwLJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0wTROxZhuOpqslnZRWEQeLEomRCAUZ6dapCeO8MoA3laBIyT1E4218vX/lNZk/DHo5HFM+eSmchIwl0Vo6VKaHtD9TNV8ufOSZF4ezsShK6JpjK5MZFKqESrEOxLjYpK2c0oTl08f2SmEpqmY1vnuerhB7Z+VCeSCqJf37xtq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NO92i3ba; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7aabb71bb2so793653766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722434808; x=1723039608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iiCWmhfzk6S/TaIu1raeuLKKW+Pt/lXO0Cdo8S2lGSw=;
        b=NO92i3baxC6ix8aHSr66Tj2EyW+gOOqGIPIux6DLbbIfGgZ1iy/DiaM2Ssqkc1UqMR
         ZipNMQ6O5u7/IQh33w0Wncv9ZLmEV3HInHjD3YiCOJSBs/uW93CVGK0Y8DKIFSPmwKOh
         0Z3bJSnCP6SmxvSf6aPWhGQcEsLU4AWgZLFGqZK1DUkhLjsOAFC3pHrDf+N19WL2WrsE
         LupZ7iI97pYv977uyM0kuPrpuBAjksfSu6Vqz7/keTsv7+zZTKc76DCSNpxsLNvcuVCl
         oiEZzwaYllBmf4I5s9hthzNkxJtGkfnuQZYYVJXXL5nMlKTPGS2of5lrOSOfRzXRyG9W
         Gf1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722434808; x=1723039608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iiCWmhfzk6S/TaIu1raeuLKKW+Pt/lXO0Cdo8S2lGSw=;
        b=E83jYgpS2uSjE4AVGDuUAInxtS0AouUuC/teC05R67hJ96NkKlIBKGrtV2pvgrYaT1
         i8wPHz6ZYk3etW/tGgpb/+YslrJMMdglY9X9VyeX4Q9cdOM5z+BxU/bmBsf7em89Nhcx
         ZU1yjg7bJbkfdwMlKuoY87slN9AtbH3MK8M8L2EFCNs2nSg9AL4+k5erg1daVFfiPwzm
         r1Y4eSK1QjzTEg04Nt2IwNOwuzGuRMROMazAB64HKLd1QFLkQcmrkuY0BerWm0mIKbZr
         WkHpzVMjGI/iiHFhMX9u4AmxpMbz3Z3lfxtEg3IFqE+87tUl3EtBPTkkIrdf26FzqCux
         48gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdRsti/iuxxj+8nC1PbPJgh7gEYkXsgdR1boomBcinwBmr550GfD+QSwYytLRdDKRgamM/RcjNBBBT6Rqg+hrorUkhBXQvenz/P8mN
X-Gm-Message-State: AOJu0Yy0ug19OpWvHTfgxdSU8ydq9PELl7TbXIp5/T0/z0IZixuDyEHA
	z0N5MaixfhOFhUJIGW67BMTL67eZsUiJTkdisY0p6KZx6N4I9EJG9Lty/BHW9nRSPqfP4jS7p7L
	P
X-Google-Smtp-Source: AGHT+IHn//8PA3qWG5PYwATGweOXZKyZpymiXCsWnIlYuDT0RkCRBCSPXp+VM1B4/pN4RLLM2/G+xw==
X-Received: by 2002:a17:907:3e1a:b0:a7a:c083:857b with SMTP id a640c23a62f3a-a7d4016427dmr972818666b.42.1722434808210;
        Wed, 31 Jul 2024 07:06:48 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab23d56sm772952866b.38.2024.07.31.07.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 07:06:47 -0700 (PDT)
Date: Wed, 31 Jul 2024 16:06:46 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 11/19] printk: nbcon: Rely on kthreads for
 normal operation
Message-ID: <ZqpE9urpKZxv4Ks3@pathway.suse.cz>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
 <20240722171939.3349410-12-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722171939.3349410-12-john.ogness@linutronix.de>

On Mon 2024-07-22 19:25:31, John Ogness wrote:
> Once the kthread is running and available
> (i.e. @printk_kthreads_running is set), the kthread becomes
> responsible for flushing any pending messages which are added
> in NBCON_PRIO_NORMAL context. Namely the legacy
> console_flush_all() and device_release() no longer flush the
> console. And nbcon_atomic_flush_pending() used by
> nbcon_cpu_emergency_exit() no longer flushes messages added
> after the emergency messages.
> 
> The console context is safe when used by the kthread only when
> one of the following conditions are true:
> 
>   1. Other caller acquires the console context with
>      NBCON_PRIO_NORMAL with preemption disabled. It will
>      release the context before rescheduling.
> 
>   2. Other caller acquires the console context with
>      NBCON_PRIO_NORMAL under the device_lock.
> 
>   3. The kthread is the only context which acquires the console
>      with NBCON_PRIO_NORMAL.
> 
> This is satisfied for all atomic printing call sites:
> 
> nbcon_legacy_emit_next_record() (#1)
> 
> nbcon_atomic_flush_pending_con() (#1)
> 
> nbcon_device_release() (#2)
> 
> It is even double guaranteed when @printk_kthreads_running
> is set because then _only_ the kthread will print for
> NBCON_PRIO_NORMAL. (#3)
> 
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -4102,8 +4139,10 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
>  			 * that they make forward progress, so only increment
>  			 * @diff for usable consoles.
>  			 */
> -			if (!console_is_usable(c, flags, true))
> +			if (!console_is_usable(c, flags, true) &&
> +			    !console_is_usable(c, flags, false)) {

This looks weird. nbcon console can't make progress when
"write_atomic" is not implemented and the kthreads are not
running.

I should be:

			if (!((console_is_usable(c, flags, true)) ||
			      (console_is_usable(c, flags, false) && printk_kthreads_running))) {

That said. Do we really want to support nbcon consoles without
@write_atomic() callback?

It would make things easier when both callbacks are mandatory.

>  				continue;
> +			}
>  
>  			if (flags & CON_NBCON) {
>  				printk_seq = nbcon_seq_read(c);

Best Regards,
Petr

