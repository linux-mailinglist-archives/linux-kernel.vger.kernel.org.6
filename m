Return-Path: <linux-kernel+bounces-216885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7C790A80F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40D2F1C247B5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E81A1862BD;
	Mon, 17 Jun 2024 08:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U5wHCExs"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918D5256A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 08:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718611400; cv=none; b=FMD5WguUybAvs5CCiM7H5sC/0YLCulCKbKJodZo5qSVKAYoNERJYYzwqrdZf9veeZXKq0fKWBQk7ApaYgb2qC/+1rTYWqXfFb+1HsSE2yWwKbm9nV8eqnbG+ssd/LLMVh+EfmXQqHQO4wLqqmP113K/ocLSbQzw0lrRhJ7zOs3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718611400; c=relaxed/simple;
	bh=qP2c8SI7c8LR+At+5MSM/4ZIzSxkMD7apY0IYjLrXGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/O7MJn8jf+769SEDlgD/lG22tGNt/Dl971yeddEA88pscAvc3jGuQVMMSmX5qLHPDvbYGMglxShzVyjkHRWl6P1aAFiyG//qWIxn6yIfQpQSnU5iItn78NSeek0jtlVN9kvxxA5kESo0Gi/8z/hE4OY7dHAwlKhBHuuuaJXKoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=U5wHCExs; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57cc30eaf0aso1522824a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 01:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718611397; x=1719216197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RiRNeXTNLkPeYnOsXqevm4dREEioiq1cUZc3k0Sc504=;
        b=U5wHCExsDw4t9fbecOpMzS3lP527aheiPXXCoz6uwZ3ccGd9CQWhmi/AY3wnFLHawp
         f190J2peabReJ/PaKRkDn4ztzl08kRunkz6XHn/Zx6eKtPXx1PcLXrB9EgLaQ64iEBE+
         ETrVB9dH+K8J4aFdFfyN4VZjBeC5SNir00lnr+670nsP8K9vqfnEMc4tOP/sCY6fhq6h
         L2jU0FrTfFSvP0AFgpUo0niKzjLR7WHcR8fEyLjj/DaNpkp8scrazuiAevqn4PuqalBr
         BV/PGayvO2tGOn0slTnX2OSNqRumFUXUMNHLfTAJCL7KB8gMEzz55fc91ZHSXr0zP4d8
         MXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718611397; x=1719216197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RiRNeXTNLkPeYnOsXqevm4dREEioiq1cUZc3k0Sc504=;
        b=kOnTEjAftvTcUANU967GcEz399dKnGsg/j7f1mEZKL97sc4Nh3mFrM2CufQ3G7p70Q
         B1LbkIMSGtLV6NTI5e/+5WonmqAiLGHL4HiIKpPdQQDR6+WG+E/3k6yLDafEetUWrWic
         HZG3evD0YvIcQV9a6SIXthxgmhwrcmgrtfzhBOV3LtU//GyPe453gkbWZ+q8uyOHGnTl
         XzpOvTtGWs9vBtHSl545heYC/g8jIaMUbf/tnzJVsH1egXZ9KtoSaMz4O7whwSOTEcOW
         xLYj309IgsmgzqwrCBN9dueXexWl7s9HHJ1l6JyPRDDkMfKaORU6psabbHlMDAc78BxQ
         xHBA==
X-Forwarded-Encrypted: i=1; AJvYcCXPBFlktMzCBoOcQc3/c1qYEDUwSb2qzzEgrRrqFzTDYiVDtOHLiqS4mgoVdC6uZvjNzkiaVLXg40R1XjR/8XueE7jQIlLC7Ofrax2T
X-Gm-Message-State: AOJu0YwwyWF3Z10+dCnEikzpM8wPzdssrXOmfwTM3usjBUphZDZSLOyd
	qzfcw1hN/tq9kSdCPw+k6LWbnGK0DglKmD9SsqTPs6b8h8ZQd4SXTKOJiqj4haU=
X-Google-Smtp-Source: AGHT+IFSpUQt6d/6ildUpfUWV+522s+T+z60M3/a+FlFj8a7tqsP/iWZSODumewUHkkMrpN8DgzmeA==
X-Received: by 2002:a50:d759:0:b0:57c:5874:4f5c with SMTP id 4fb4d7f45d1cf-57cbd6c7561mr7237780a12.32.1718611396832;
        Mon, 17 Jun 2024 01:03:16 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cd245c408sm2743993a12.79.2024.06.17.01.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 01:03:16 -0700 (PDT)
Date: Mon, 17 Jun 2024 10:03:14 +0200
From: Petr Mladek <pmladek@suse.com>
To: Tony Lindgren <tony.lindgren@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] printk: Add update_preferred_console()
Message-ID: <Zm_tdcWDEQjQns_G@pathway.suse.cz>
References: <20240613125113.219700-1-tony.lindgren@linux.intel.com>
 <20240613125113.219700-3-tony.lindgren@linux.intel.com>
 <Zmx7IPQX4FVdSe1J@pathway.suse.cz>
 <Zm_j2eq3QcaA-g-e@tlindgre-MOBL1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zm_j2eq3QcaA-g-e@tlindgre-MOBL1>

On Mon 2024-06-17 10:20:57, Tony Lindgren wrote:
> On Fri, Jun 14, 2024 at 07:17:20PM +0200, Petr Mladek wrote:
> > On Thu 2024-06-13 15:51:08, Tony Lindgren wrote:
> > > The earlier attempt on doing this caused a regression with the kernel
> > > command line console order as it added calling __add_preferred_console()
> > > again later on during init. A better approach was suggested by Petr where
> > > we add the deferred console to the console_cmdline[] and update it later
> > > on when the console is ready.
> > 
> > > --- a/kernel/printk/printk.c
> > > +++ b/kernel/printk/printk.c
> > > @@ -2486,8 +2495,8 @@ __setup("console_msg_format=", console_msg_format_setup);
> > >   */
> > >  static int __init console_setup(char *str)
> > >  {
> > > -	char buf[sizeof(console_cmdline[0].name) + 4]; /* 4 for "ttyS" */
> > > -	char *s, *options, *brl_options = NULL;
> > 
> > I would add
> > 
> > 	static_assert(sizeof(console_cmdline[0].devname) >= sizeof(console_cmdline[0].name));
> 
> That check should still be >= sizeof(console_cmdline[0].name) + 4, right?
> For the "number only" consoles we add the "ttyS" prefix.

Right. Great catch!

Best Regards,
Petr

