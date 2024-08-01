Return-Path: <linux-kernel+bounces-271151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7099B944A2A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15F4283092
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8F7187FFF;
	Thu,  1 Aug 2024 11:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Szmim/5A"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E73D13D24D
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 11:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722510775; cv=none; b=utC2Umg/09kh3VpcekC2nQcI7ovLYn44STF9Yh8vJoel8A2/mN4gbL7VNwATZL8PdbP5hShqkPq0kCAl21QC7xNUTkSQ5luzbVyaLUr/qdNE3xEVPBaIUznGkcYx5/ar1zW0TtfetYhusSWA/IJeHKbnnXxGE5sUbdToGCA4MG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722510775; c=relaxed/simple;
	bh=sN0vooMDwid5d1t5ADQ59AkyIhh5ZAs/oSxua4fzJso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JiPEseRJy7GTeLRk6X0rpsAXFPgvMZkrHoLeQiiOYoZkvG3nnllzO3I2rn3kUrU4U2AYV06sf0wfSGYshaNZyfvJ0oZN5+m0B5MMNVYsDpMEZRW/ChP9NGK/oyo8lpTBjbfkTKk+GLZ2zwyCoukP7LY+EFhAOkraH9iuwG3hwqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Szmim/5A; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52f04b3cb33so15003106e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 04:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722510771; x=1723115571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OccBgiAIGkgIzTM6T6TW0PvHRAfFeTwL0ias0SamkbE=;
        b=Szmim/5Afdnma48sMzULtCeTlITe1mslW8xvcCgZINv/sEU25dzeqk2clEEhzckZ5S
         V39zI4EmXymVJ6ji+DhghXPGJ0+opsgI8dEi1ecm5WlSUG0OEAteaEA53/6ZzncUlN0G
         zX5eBAhPxbPZC53r/539n7WatcW7ZpxgTU22YHHwZvtn3S3XBfRACuga5NcMm70W6pBM
         Kbqir40aeGNQl9HqX4gAb0gyt+gjyCobRuOLOc8IRl8FTZM8lyxFlHWfwQl1MIoMYK1L
         eUV4Ay7Ydiau4sVaxvJY0aCba0IuH9wK/Vidmcmsxykp1FL+61+yFCgHA/eoekhqamhR
         0T2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722510771; x=1723115571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OccBgiAIGkgIzTM6T6TW0PvHRAfFeTwL0ias0SamkbE=;
        b=C9pD0MbpzVGX5Tb+sgdAL7vKP/w1LGUXpY850k86WyTgMUX0IjGWkvLtEIy7HXSjEE
         vkrObM0S5HTIFdZJ3A24TsbaqCqTCTnfzZ9ZsL5HRPxJb72ABs5hsv1eFhNOxj6UWpCw
         AmgyoZ3U0J13MUZdka58OyzrK+s/bpeXBMVNf4oWHUrBGlzavP+PbWAjFcyJuxa9IRCP
         SUTbz5UYEeZF4Xs+bXp6pWpr8KnYTy0pIzi7LloV2MYTz9bL9iI/2firRlj29eiVORCo
         r2MrhGQ+EuVt7EJ2Q2wqIGHK2lPTm3lzw3GH3gOMBhKPm4W0Gza2aXN8LlWFleCLeQJ7
         W/tg==
X-Forwarded-Encrypted: i=1; AJvYcCX0WhhdhKKZpEHGgqkPyUow4U6DWEPyIkj+CjPX8AlfAaCbZ/5wZwremHcp4qFTbyDGojyMUfHwbbX2SFy7vIuAAMRfwxeChnFwWu/k
X-Gm-Message-State: AOJu0YzHeLgfWRlz4F0FmnwOrcxTyYpX1a9+meu8w8oXSFgA2M6Yj46d
	ECyMHj04OgmYJRI9wfGns3nq2fDDbTGs5CQiISFklPM2DE4filC6xb812GmvrQI=
X-Google-Smtp-Source: AGHT+IE2Bjmf8p2H77tIwxuL/Bh9k7OON8+UXooGCh87V1CspJfQJKng57Vuzg1zH4DO4RrSQmXHkg==
X-Received: by 2002:a05:6512:12c7:b0:530:ac0a:15df with SMTP id 2adb3069b0e04-530b61aafdcmr2141472e87.5.1722510771049;
        Thu, 01 Aug 2024 04:12:51 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad9316csm880942766b.186.2024.08.01.04.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 04:12:50 -0700 (PDT)
Date: Thu, 1 Aug 2024 13:12:48 +0200
From: Petr Mladek <pmladek@suse.com>
To: takakura@valinux.co.jp
Cc: john.ogness@linutronix.de, akpm@linux-foundation.org, bhe@redhat.com,
	feng.tang@intel.com, j.granados@samsung.com,
	linux-kernel@vger.kernel.org, lukas@wunner.de,
	nishimura@valinux.co.jp, rostedt@goodmis.org,
	senozhatsky@chromium.org, stephen.s.brennan@oracle.com,
	taka@valinux.co.jp, ubizjak@gmail.com, wangkefeng.wang@huawei.com
Subject: Re: [PATCH] printk: CPU backtrace not printing on panic
Message-ID: <ZqttsMNERRCZw8FR@pathway.suse.cz>
References: <ZqjZMIxgm46qVgjL@pathway.suse.cz>
 <20240801082721.62935-1-takakura@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801082721.62935-1-takakura@valinux.co.jp>

On Thu 2024-08-01 17:27:21, takakura@valinux.co.jp wrote:
> Hi Petr and John,
> 
> On 2024-07-30, Petr Mladek <pmladek@suse.com> wrote:
> >On Fri 2024-07-26 16:02:45, John Ogness wrote:
> >> On 2024-07-26, Petr Mladek <pmladek@suse.com> wrote:
> >> > I would do it the other way and enable printing from other CPUs only
> >> > when triggring the backtrace. We could do it because
> >> > trigger_all_cpu_backtrace() waits until all backtraces are
> >> > printed.
> >> >
> >> > Something like:
> >> >
> >> > diff --git a/include/linux/panic.h b/include/linux/panic.h
> >> > index 3130e0b5116b..980bacbdfcfc 100644
> >> > --- a/include/linux/panic.h
> >> > +++ b/include/linux/panic.h
> >> > @@ -16,6 +16,7 @@ extern void oops_enter(void);
> >> >  extern void oops_exit(void);
> >> >  extern bool oops_may_print(void);
> >> >  
> >> > +extern int panic_triggering_all_cpu_backtrace;
> >> >  extern int panic_timeout;
> >> >  extern unsigned long panic_print;
> >> >  extern int panic_on_oops;
> >> > diff --git a/kernel/panic.c b/kernel/panic.c
> >> > index f861bedc1925..7e9e97d59b1e 100644
> >> > --- a/kernel/panic.c
> >> > +++ b/kernel/panic.c
> >> > @@ -64,6 +64,8 @@ unsigned long panic_on_taint;
> >> >  bool panic_on_taint_nousertaint = false;
> >> >  static unsigned int warn_limit __read_mostly;
> >> >  
> >> > +int panic_triggering_all_cpu_backtrace;
> >> > +
> >> >  int panic_timeout = CONFIG_PANIC_TIMEOUT;
> >> >  EXPORT_SYMBOL_GPL(panic_timeout);
> >> >  
> >> > @@ -253,8 +255,12 @@ void check_panic_on_warn(const char *origin)
> >> >   */
> >> >  static void panic_other_cpus_shutdown(bool crash_kexec)
> >> >  {
> >> > -	if (panic_print & PANIC_PRINT_ALL_CPU_BT)
> >> > +	if (panic_print & PANIC_PRINT_ALL_CPU_BT) {
> >> > +		/* Temporary allow printing messages on non-panic CPUs. */
> >> > +		panic_triggering_all_cpu_backtrace = true;
> >> >  		trigger_all_cpu_backtrace();
> >> > +		panic_triggering_all_cpu_backtrace = false;
> >> 
> >> Note, here we should also add
> >> 
> >> 		nbcon_atomic_flush_pending();
> >> 
> >> Your suggestion allows the other CPUs to dump their backtrace into the
> >> ringbuffer, but they are still forbidden from acquiring the nbcon
> >> console contexts for printing. That is a necessary requirement of
> >> nbcon_waiter_matches().
> >
> >Great catch!
> >
> >I would prefer to solve this in a separate patch. This problem existed
> >even before the commit 779dbc2e78d7 ("printk: Avoid non-panic CPUs writing
> >to ringbuffer"). In fact, the problem existed very long time even for
> >the legacy consoles.
> >
> 
> Good point! I guess the problem existed since the commit 51a1d258e50e 
> ("printk: Keep non-panic-CPUs out of console lock") as it forbade the 
> acquisition of console lock for non-panic cpus?

It most likely existed since the commit 7acac3445acde1c94
("printk: always use deferred printk when flush printk_safe lines")

These were times when printk() serialized access to the log buffer
using a spin lock. The backtraces from other CPUs were stored in
temporary per-CPU buffers and later copied to the main log buffer.
The above mentioned commit caused that printk_safe_flush_line()
did not longer try to flush the messages to the console after
copying the temporary stored messages.

Well, the above commit was in Jan 2017. It was before panic
allowed to show the backtraces.

In practice, the problem with flushing bracktraces in panic has
existed since the option to print the backtraces was added by
the commit 60c958d8df9cfc40b ("panic: add sysctl to dump
all CPUs backtraces on oops event") in Jun 2020.

Best Regards,
Petr

