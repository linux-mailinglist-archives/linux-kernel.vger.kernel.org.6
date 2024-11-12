Return-Path: <linux-kernel+bounces-405880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEC39C586D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8DF71F23553
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C5E13212A;
	Tue, 12 Nov 2024 12:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FzHqa3ar"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6851292CE
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 12:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731416364; cv=none; b=NC0tiiWvGd6XjI/x/ZO1tEmAcYF1aYP+70HuK28Rb43AyzomrmBd7ISOQRZpIrnWVg6LA0st2hajHyAX/Y9v3zs3jsKef9MmbZ9262IFL/NJN7qiUuqv4o+Qpq0rws7fN8iyE9s4f5YKxrHytop+XdZHA0U4j0ehszHXlp27bGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731416364; c=relaxed/simple;
	bh=O1ra4cc8YXF6OcVwIaYhFtkTaBxbuaqHKor32feVjhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYiXCzqfaPDkNyb1+yZeLexIen0JiSfh9xmQPo6ug/A87M5y0FgsSpX8TyM7lgDy8KgzzgAUmcpw5hjRvDXpJN4SUYLsqKhXBn6hXhmza7KzeXxVLC9GzieG5gY1s/6XR6R8OXuk8jZi1cbPbKb4c1D8h4Slh2gQWoQjbFfXz5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FzHqa3ar; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4316cce103dso70682515e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 04:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731416360; x=1732021160; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cfaiPLSE/cSMEniC7rNx14oY4I502rUQz+kbxcUTM/M=;
        b=FzHqa3ar7dMC1zz4SEoyk+b8jk55Z942h7b2WqkdmZxprNjgr3Werl1yphBws75eVP
         mfs3usrcASUjcMrGV2vS0K/dSSSiW8P56K7/7r64o366tC27/dKnf73y9R3mfcCviekT
         N0m0tfNQZuXVGIuRKceb6JIEHJ49SKRiAw83gx9SmX1Q2tqeeOkO2G04KI/SbQb0ay1X
         O/WBcP39bJ0GN1rcRRjSBKHYqRS8LQ8uIEc+tFOKLis7rVecSpuWiWXtbC8tWgIx/cNV
         S7FHAAy3Nh0x7HN7hddw4hUnux9QiiOeSTRb+zLbPrgfnDXLnzONBGjddnF5+ec++qXV
         lVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731416360; x=1732021160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfaiPLSE/cSMEniC7rNx14oY4I502rUQz+kbxcUTM/M=;
        b=msLIyQKwmG8Xc6T6w3e2BNrQah4ZbmeowQSpBzF9Q+SSzXum5gkAsvvzGj9rO6AQny
         h3TicCVZsFCVgIf8HEM7gmixAMcC6tEP0B3WvDK7OLVHDnKCtVk7hBGUZT1pnk6LsG2+
         oQ2xBqVuGnfGbWSGaWLxRFVF4XU7NBTvbaBuIWh8A+RALHjJbjVhM3qaB2jCybGzaZRZ
         R06vbGJM2DOjLkIakKxbcJZBLpCHdHTPElfOp4Lv33uk8r0H9q3Y445Ym+WHNUVDdp1t
         CJRv1UMdjzCc5YE7sIsguSKcRfbPXv4pLBPLl3XFDVo73FjVRHhB21suMwJCnNt99Qvx
         FPGQ==
X-Gm-Message-State: AOJu0YxxkUJjmoA1OGNeYJUry3PjPEXeOFM71eZmCrJSAggvlvlGaGMz
	DQj+90W0KZ/TmSoOp9QJVcyUR3gChjjhL0pfJuQ7PUX9J8x1H370PDRfUOiue/0=
X-Google-Smtp-Source: AGHT+IFU6xTdnYAb/vcuPafz5OnVgaag1P8H6I72Di3zG/EFdT2LjuKgZeQulxlN4dthmJnEGi4hdA==
X-Received: by 2002:a05:6000:1541:b0:37d:2ea4:bfcc with SMTP id ffacd0b85a97d-381f186bc9bmr15525328f8f.13.1731416360468;
        Tue, 12 Nov 2024 04:59:20 -0800 (PST)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9ec1b1sm15705648f8f.82.2024.11.12.04.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 04:59:20 -0800 (PST)
Date: Tue, 12 Nov 2024 13:59:18 +0100
From: Petr Mladek <pmladek@suse.com>
To: Chris Down <chris@chrisdown.name>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: Re: [PATCH v6 04/11] printk: Support toggling per-console loglevel
 via syslog() and cmdline
Message-ID: <ZzNRJr21HiHXBAFO@pathway.suse.cz>
References: <cover.1730133890.git.chris@chrisdown.name>
 <07141a533c4071c364c4f2eda6d97a9a89797e67.1730133890.git.chris@chrisdown.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07141a533c4071c364c4f2eda6d97a9a89797e67.1730133890.git.chris@chrisdown.name>

On Mon 2024-10-28 16:45:40, Chris Down wrote:
> A new module parameter (ignore_per_console_loglevel) is added, which can
> be set via the kernel command line or at runtime through
> /sys/module/printk/parameters/ignore_per_console_loglevel. When set, the
> per-console loglevels are ignored, and the global console loglevel
> (console_loglevel) is used for all consoles.
> 
> During sysrq, we temporarily disable per-console loglevels to ensure all
> requisite messages are printed to the console. This is necessary because
> sysrq is often used in dire circumstances where access to
> /sys/class/console may not be trivially possible.
> 
> Additionally, the syslog actions SYSLOG_ACTION_CONSOLE_ON and
> SYSLOG_ACTION_CONSOLE_OFF are augmented to save and restore the state of
> ignore_per_console_loglevel. This allows administrators to enable or
> disable per-console loglevels dynamically using the syslog() system
> call, as supported in userspace by things like dmesg.
> 
> This is useful when debugging issues with message emission, or when
> needing to quickly break glass and revert to global loglevel only.
> 
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1298,6 +1313,16 @@ bool per_console_loglevel_is_set(const struct console *con)
>   * 1. con->level. The locally set, console-specific loglevel. Optional, only
>   *    valid if >0.
>   * 2. console_loglevel. The default global console loglevel, always present.

I think that I have suggested to remove the above comment because
it was obvious from the code. I am in doubts now because use
extendended it below ;-)

> + * The behaviour can be further changed by the following printk module
> + * parameters:
> + *
> + * 1. ignore_loglevel. Can be set at boot or at runtime with
> + *    /sys/module/printk/parameters/ignore_loglevel. Overrides absolutely
> + *    everything since it's used to debug.
> + * 2. ignore_per_console_loglevel. Existing per-console loglevel values are left
> + *    intact, but are ignored in favour of console_loglevel as long as this is
> + *    true. Also manipulated through syslog(SYSLOG_ACTION_CONSOLE_{ON,OFF}).

I like that it is summarized in one place. I like the comment after all ;-)

That said, it is also nicely summarized in
Documentation/admin-guide/per-console-loglevel.rst
So, it might be enough to mention it here.

>   */
>  enum loglevel_source
>  console_effective_loglevel_source(const struct console *con)

Best Regards,
Petr

