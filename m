Return-Path: <linux-kernel+bounces-183712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E91718C9D01
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 14:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DD7CB22053
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 12:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE54D54675;
	Mon, 20 May 2024 12:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XFLGoF6/"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA185337F
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 12:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716207200; cv=none; b=D8t2m6L2VcL9xo7rEgemMeRSNLUJPKCPgLBsEkDB9MaTVfwQQOEHGzCN6St8p9eyePwlmwYvrLD6+8SRVzHr+qKx8004d2xCd+k/XOix/ACgH9qmhCiQr94g5jzBd7oVg+tCfqGtEoW4080s2+GyxZRcZ+vH3gfO/oXFMbIqaJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716207200; c=relaxed/simple;
	bh=iD22LoyvP1b3Cffzn6b+BCqUp34FfrjwA3/bpSQ6rE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/ob22JRyk4ZL3ZRDwUTI/IQYRU+d9Q/1CnU0IVJtQsAHrt0rFXiHBpFXM74AhxTGwIP3EuAFVJ2bLZyj5M8Lr0gN66yahec0g3xnaDh8Ek7UnjIWrQS7+udIOjpiKlYmrNA3hH9eJnx4WuQTN+Ql60IwHwcs91kayn8NXR3RPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XFLGoF6/; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-572e48f91e9so8124035a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 05:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716207197; x=1716811997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vq2921iavEdoPmEW4aOE6M8eMTh4FTRY+b70NrF3F90=;
        b=XFLGoF6/eFYgy1egQoeJl9+s3kd9Ri/zb9qYSe6Y3MdiAS6AXngPZmLQzpL3TLOUwk
         6t9Ea17U1GOttGP2uxGfVFEHAF/pQzPukgWmJM6fwPcJNKpxckkHtjFz0Vs3VxKevLRA
         sWeDC7u3CZXTC12bP9vy3oavxBj4TEYcm4Ou9dEqv5DSI+CkwFrtAnUHFHwXcUqa6uTy
         pt7yjgmq3h2laDThJY2Rt8EN4FM9gRx+pUj20QXrKAY5ON/Ow4DApx264lFxuIUFWy1+
         w4vYi+X5eBJ7K+2w7LwGEDGLX/N7RVcMzKpOp8y0Gx8YswbubyiYpcxmsV3KImaUNd1v
         AfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716207197; x=1716811997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vq2921iavEdoPmEW4aOE6M8eMTh4FTRY+b70NrF3F90=;
        b=K0GDzpocRBD0NNTs+vNIvljYH7W+N1zQKIB6WaDAXmib3j2RdcEAej9AQcfOhik+2w
         H7fhStuNAATjf5fBAQyLhe0idoyX0w8i0cWK5EgiUz0njGaq6fOpc5yrlvoTmX70JaBF
         Uq65vQmt0B1xKRHHaZf0Thz5xzhXatGp6K/DauzrlSLUKL2MxLtC9yLs3xqonPJ+9QzO
         rIyoZ5LoB8WY/G30hsGbuGAUSMJO9uMQuM1jgQ+RhmdvQQaXM3PXh/zTtNxitmodTcyD
         wobDOKTRHZJPEledHrcU36qNUR/pNjFEBsh5RZcDg7J40dXJTVkNm8Tlnkgwn3VGfPpf
         5Eiw==
X-Forwarded-Encrypted: i=1; AJvYcCW4ShdbLEWMWwVMKXXbH5UoPpzfaAOvOHigV1wk8toBIIKpOA+sz/XAJqn/WTIN605GifWHN1gnDLjH0wvaKpk80B+d5lIV9232bxOc
X-Gm-Message-State: AOJu0YyPgSXRfHUaTcH9xGyzMzG9yAiB7j6uYGtSHHxGhZCpv4sjCRme
	b5JLDYfEgnsYfBs9m8HFXO8nMBBaHfQydJR4505MOnAaIgzL43738uedzB30bkWtMAByM3seT0L
	b
X-Google-Smtp-Source: AGHT+IHT+4FXFXHpSzVJ2xsAx+yu/dvxZKIC0DzVNL7NS+aUUAOHVjlmEjHt8cyVsO4n6EnN1qMBCQ==
X-Received: by 2002:a50:bac5:0:b0:56d:ee61:6874 with SMTP id 4fb4d7f45d1cf-5734d5e4089mr19783652a12.20.1716207197067;
        Mon, 20 May 2024 05:13:17 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c322c85sm14998153a12.84.2024.05.20.05.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 05:13:16 -0700 (PDT)
Date: Mon, 20 May 2024 14:13:14 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v5 11/30] nbcon: Provide functions for drivers to
 acquire console for non-printing
Message-ID: <Zks-WkoTmAVFBgoP@pathway.suse.cz>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
 <20240502213839.376636-12-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502213839.376636-12-john.ogness@linutronix.de>

On Thu 2024-05-02 23:44:20, John Ogness wrote:
> Provide functions nbcon_driver_try_acquire() and
> nbcon_driver_release() to allow drivers to acquire the nbcon
> console and mark it unsafe for handover/takeover.

I would prefer to rename 'driver' to 'device' to keep the existing
naming scheme in struct console. The API will be used to
synchronize the 'device' element.

> These functions are to be used by nbcon drivers when performing
> non-printing activities that should be synchronized with their
> atomic_write() callback.

I am still trying to create a mental model around the synchronization
between the device-specific locks and nbcon context. Also it took
me some time to realize that just disambling the migration is
perfectly fine here.

I propose a bit extended commit message:

<proposal>
Subject: nbcon: Add API to acquire context for non-printing operations

Provide functions nbcon_device_try_acquire() and
nbcon_device_release() which will try to acquire the nbcon console
ownership with NBCON_PRIO_NORMAL and mark it unsafe for handover/takeover.

These functions are to be used together with the device-specific
locking when performing non-printing activities on the console device.
They will allow synchronization against atomic_write() callback which
will be serialized, for higher priority contexts, only by acquiring
the console context ownership.

Pitfalls:

The API requires to be called in a context with a disabled migration
because it uses per-CPU variables internally.

The context is set unsafe for a takeover all the time. It guarantees
full serialization against any atomic_write() caller except for
the final flush in panic() which might try an unsafe takeover.
</proposal>

> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -304,6 +304,7 @@ struct nbcon_write_context {
>   *
>   * @nbcon_state:	State for nbcon consoles
>   * @nbcon_seq:		Sequence number of the next record for nbcon to print
> + * @nbcon_driver_ctxt:	Context available for driver non-printing operations

This provides a context for "@device".

We should call this "@nbcon_device_ctxt" to avoid confusion.


>   * @pbufs:		Pointer to nbcon private buffer
>   */
>  struct console {
> @@ -399,6 +400,7 @@ struct console {
>  
>  	atomic_t		__private nbcon_state;
>  	atomic_long_t		__private nbcon_seq;
> +	struct nbcon_context	__private nbcon_driver_ctxt;
>  	struct printk_buffers	*pbufs;
>  };
>  
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index d8b3f51d9e98..d0a1106388d1 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -9,6 +9,8 @@
>  #include <linux/ratelimit_types.h>
>  #include <linux/once_lite.h>
>  
> +struct console;
> +
>  extern const char linux_banner[];
>  extern const char linux_proc_banner[];
>  
> @@ -193,6 +195,8 @@ void show_regs_print_info(const char *log_lvl);
>  extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
>  extern asmlinkage void dump_stack(void) __cold;
>  void printk_trigger_flush(void);
> +extern bool nbcon_driver_try_acquire(struct console *con);
> +extern void nbcon_driver_release(struct console *con);

Similar here:

s/driver/device/

>  #else
>  static inline __printf(1, 0)
>  int vprintk(const char *s, va_list args)


With all the renames and updated commit message:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

