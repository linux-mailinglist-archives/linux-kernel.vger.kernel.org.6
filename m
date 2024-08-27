Return-Path: <linux-kernel+bounces-303242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8A1960973
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFFF61C2236D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2838A1A0720;
	Tue, 27 Aug 2024 12:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bsewUPKo"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B1F1CD31
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724760051; cv=none; b=ePNSmlDVtC0dKAki84SyDsKIgq9EbqwvyFm2+zlJ90DHCfJs3q6vZlC0gqV33MmI6CRyZ4NRtD3Fo8F86rkbTjtM0i5Av1mT9kBhyRRikue3fxOlfse154OWO9244GYvEj6UXuaTfCdDYSLxMdo5L9mwuQlCRIiazAcoFttAzfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724760051; c=relaxed/simple;
	bh=9by1Q5vd5/Cnqu7BDl8Wtr3yJ50vlOqRXPIkbKJR0wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWvcoqUFcGl3vWfT0oPnut0MFQpVFjcEZm1he9nQAAjY403fStSruRU9ZRWzA/qjy8cc4JaQDDyaBN2LzRUjxXlUJ/Uc/Nzoo0XAa97l85duQa0GZgKjFiBNnQ/k7a0mbQM+2g3H0EQXtavQpo7s6feQ1F6CVZyoqSgCJWoN3tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bsewUPKo; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5bec4fc82b0so10639639a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 05:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724760047; x=1725364847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6p1k0SgHgNlQc3A2c8yKOCo/W99ToOBORtxjv0rCphQ=;
        b=bsewUPKos4jhfDrCBi2kUe7vRxS8j+l3q59HYeVaGyPjouD5+d7z3Lof/mrfaVgfeg
         aCCEQM9ppxvMQmuFWfaD2Hu7jYLOW6hLAeSoL6G/xJk2ru+Nr1IAin0wTU1ml3tnOalU
         XjYVuWFe1VCYm+Sxg/yvaYMN3BoODepZWHzJIlVUv9j1yesywphamG2KLUl38fDmQBKT
         XtDigl1I0QD11erXy8rYTK0HRbV276tBeWSXorX++izlZ56amYJXq8vdrMDSsRyk2e25
         l41jlRSAmjYw4SdZAbI1vRs2/AZkkfTLjcr4db0QCY45FEi8fV2rWglcy/QJCX+NSscV
         fSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724760047; x=1725364847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6p1k0SgHgNlQc3A2c8yKOCo/W99ToOBORtxjv0rCphQ=;
        b=DjQ/tNpMVLLhxwsYGKfhvlOEBbTIsta9zqaQoGQ0pRLS9gtSNslHp4JbCJwH/RQEoi
         TNy8Fcf+0P2HWTQOin24CVy8mX2/NEOEt9Jnh8htUjZRI1vhzldP6IDgGvVb3yT0D0HO
         xgmvSBcwCxjMR+2yG27V+Xq9BXXpQb5s7Gl1+NgTJfSU7cRgZwx3mQmnyMQUuIGRfdiT
         AaGHhwBX6rSLYDvzsrRzIXQx6+J9wdgvijyf5mzEtTd10vbAojAGUp7o42fav7PVHuln
         1IhNIftjxhkFSJ0c17UqJL0+JmVTYbp9Y64UVvDWIaF3gdndmBjoZQwbAvYJjyyqhasu
         UcKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUegUVDmnIspOqh0OhMZrNmnCgP76JRbqvkk9Yc4WExR7qHkWMesRp4+vuH/wtoxpAM9aW7ztAfOWEq+YI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuN+nzYQsb5WD4rgfCCBi6NUAEAblsR5gzd3wClQyXiUGoKVTK
	Gbc9lr/bBN505M6FjstweXZIXYuJCG2VSdQbJbIn7lYiTo8PpS9wzmsNbc7Masg1vCTeSykklct
	0
X-Google-Smtp-Source: AGHT+IGE+FpUfXlxrHsWD+kVaI5mcFA1ITxlDlJeihpSRmTr+K7mp7rI6DP3cU9yC4XYTiUT5jiKog==
X-Received: by 2002:a17:906:c114:b0:a77:afd5:62aa with SMTP id a640c23a62f3a-a86e2aa6c2fmr297462566b.23.1724760047464;
        Tue, 27 Aug 2024 05:00:47 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e54b55casm102748366b.96.2024.08.27.05.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 05:00:46 -0700 (PDT)
Date: Tue, 27 Aug 2024 14:00:45 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v4 02/17] printk: Fail pr_flush() if before
 SYSTEM_SCHEDULING
Message-ID: <Zs2_7Vl9XaSB-kw4@pathway.suse.cz>
References: <20240827044333.88596-1-john.ogness@linutronix.de>
 <20240827044333.88596-3-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827044333.88596-3-john.ogness@linutronix.de>

On Tue 2024-08-27 06:49:18, John Ogness wrote:
> A follow-up change adds pr_flush() to console unregistration.
> However, with boot consoles unregistration can happen very
> early if there are also regular consoles registering as well.
> In this case the pr_flush() is not important because all
> consoles are flushed when checking the initial console sequence
> number.
> 
> Allow pr_flush() to fail if @system_state has not yet reached
> SYSTEM_SCHEDULING. This avoids might_sleep() and msleep()
> explosions that would otherwise occur:
> 
> [    0.436739][    T0] printk: legacy console [ttyS0] enabled
> [    0.439820][    T0] printk: legacy bootconsole [earlyser0] disabled
> [    0.446822][    T0] BUG: scheduling while atomic: swapper/0/0/0x00000002
> [    0.450491][    T0] 1 lock held by swapper/0/0:
> [    0.457897][    T0]  #0: ffffffff82ae5f88 (console_mutex){+.+.}-{4:4}, at: console_list_lock+0x20/0x70
> [    0.463141][    T0] Modules linked in:
> [    0.465307][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.10.0-rc1+ #372
> [    0.469394][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
> [    0.474402][    T0] Call Trace:
> [    0.476246][    T0]  <TASK>
> [    0.481473][    T0]  dump_stack_lvl+0x93/0xb0
> [    0.483949][    T0]  dump_stack+0x10/0x20
> [    0.486256][    T0]  __schedule_bug+0x68/0x90
> [    0.488753][    T0]  __schedule+0xb9b/0xd80
> [    0.491179][    T0]  ? lock_release+0xb5/0x270
> [    0.493732][    T0]  schedule+0x43/0x170
> [    0.495998][    T0]  schedule_timeout+0xc5/0x1e0
> [    0.498634][    T0]  ? __pfx_process_timeout+0x10/0x10
> [    0.501522][    T0]  ? msleep+0x13/0x50
> [    0.503728][    T0]  msleep+0x3c/0x50
> [    0.505847][    T0]  __pr_flush.constprop.0.isra.0+0x56/0x500
> [    0.509050][    T0]  ? _printk+0x58/0x80
> [    0.511332][    T0]  ? lock_is_held_type+0x9c/0x110
> [    0.514106][    T0]  unregister_console_locked+0xe1/0x450
> [    0.517144][    T0]  register_console+0x509/0x620
> [    0.519827][    T0]  ? __pfx_univ8250_console_init+0x10/0x10
> [    0.523042][    T0]  univ8250_console_init+0x24/0x40
> [    0.525845][    T0]  console_init+0x43/0x210
> [    0.528280][    T0]  start_kernel+0x493/0x980
> [    0.530773][    T0]  x86_64_start_reservations+0x18/0x30
> [    0.533755][    T0]  x86_64_start_kernel+0xae/0xc0
> [    0.536473][    T0]  common_startup_64+0x12c/0x138
> [    0.539210][    T0]  </TASK>
> 
> And then the kernel goes into an infinite loop complaining about:
> 
> 1. releasing a pinned lock
> 2. unpinning an unpinned lock
> 3. bad: scheduling from the idle thread!
> 4. goto 1
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Thanks a lot for adding all the details. It is much more clear now.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

