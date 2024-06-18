Return-Path: <linux-kernel+bounces-219443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCFF90D232
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C1201F24EA1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E16E1ABCA7;
	Tue, 18 Jun 2024 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DVihYnhN"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B461AB910
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 13:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716609; cv=none; b=P5/KczycI65GSOmSBfrvQ4iP5y/JZAQJOIBqFI0Wq3woD2T7XXGAGtHrJgbP1WHTZUHq+jWz4px4xyyKtFBq802LmngHXJXQMRLHCLUBqvVGxA48/kaDrCyQRFZX1t4Z3Ur2BK92nLDsTCOvEKhsevguduNYrl/IhI1+PPTAbSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716609; c=relaxed/simple;
	bh=hOVXynVrJqlICx8Jz8//qfgFh9Lh2Hsor9p0s6PiDn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPB2et9IuhUAwDFK/U+zlLSZtfc881nbKbin5tt8H/fkKV9kQytxSqdRpyQCpN3lphTpfF7qPilGfAlYGXAcjJkdcQWIsMPWx7CdKNPTLw5HrzP9oTSuhUYO1wXs7SacWVvB2zaxxqkf7t08xfM92Dbo4ZSCw+pUd4XJNqaO0XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DVihYnhN; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a63359aaaa6so825181366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 06:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718716605; x=1719321405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kKQBoLvrOe16gbYraGhce1y8kSCuWU/qDvfQzHcjb1c=;
        b=DVihYnhNJcj08SXYFBZSYueHUvjPRuOTPAFOwMdHMtdGlchhYofZtcAVmm/weEJF/i
         2YMfsRre9jAfWwxfiT5wldnp5clo+SM8gkesTBUe2PE2WQrA6WLq65WmaimAVkvU96vq
         5g6i+/0Qqd0wtvvVq2S/Cj9zN2ezg4yo3oHwhSqi9hQ3LR4C+sbuIbMSEdMO1SOe3AnX
         MtwhOhI/hPeQ2RYgu7PACFwl/socuA+vs4d7HqLaZJ31opFPoS52z71HzIgu0HrYxD1W
         1HuChRHOyXJAn6xzcUIk00mApX8xrtY5CbO1dCs8MQfwuyfdDah3ONR+6upIVIVW/ynI
         ETjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718716605; x=1719321405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKQBoLvrOe16gbYraGhce1y8kSCuWU/qDvfQzHcjb1c=;
        b=rtKH9X5dGnPKtSeJlFwWe5qD8c0BlzMzociSOsxNYtBtBu6+CUavHoVmbReVwyWf+f
         icWNTjJLvHl3HjErb2TrWwnvx8ldqISLGDDbRorZ+NXbWpy6wgn09U1T0LLOB0thhx5Q
         aiwi2nAoHRpmPoPRPkynUKHYwA2XVfvvdpvxgFq2mWIe3z3+3jK6JaSlUBFxnKHob4uU
         4Y9LdvuflgH9vFvkqaxoEmtSzuSztXRKupqxlce8oWs5rq6l+kGBccrJ71WJAoEfcXTi
         9RepdMHzlaTc9g/Uu6bN4zYH1GMFfxfkBHJWB0JicB5KXR1700xpI3i85Spu8WNNRlLD
         LSrw==
X-Forwarded-Encrypted: i=1; AJvYcCU7j32F2Fa5MI3sdwaZFb0dAft5WXf4tn4J6/EvR/4fgkwA0H2T1EUlGs+oUCaVUbi7QQOrhPhqC28aDpEO8j3+dadtMgP9P9OZI/qI
X-Gm-Message-State: AOJu0YyMZlvGDnCw8lldmNtDm1jLGORJ75WDQwFWYYy9/ZsyzaOs00TM
	mqQSP1Jnud2nuQ1JWAhzOWKRLkriFPZLN3mL4tl3bHKyIlbIp9t1eOMdT+zHkjk=
X-Google-Smtp-Source: AGHT+IGxHFTOx2RcPNTA1EnAUavLZAl4rnZZDEPL2bLu6LEHZGKKXAHjD9sldGiatGLQ1Ll9gQqhBw==
X-Received: by 2002:a17:906:138c:b0:a6f:2e28:4008 with SMTP id a640c23a62f3a-a6f60dc572cmr808317966b.54.1718716605056;
        Tue, 18 Jun 2024 06:16:45 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f4172csm625725266b.175.2024.06.18.06.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 06:16:44 -0700 (PDT)
Date: Tue, 18 Jun 2024 15:16:43 +0200
From: Petr Mladek <pmladek@suse.com>
To: Tony Lindgren <tony.lindgren@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tony Lindgren <tony@atomide.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] printk: Add
 match_devname_and_update_preferred_console()
Message-ID: <ZnGIu9r6DZLbQMOb@pathway.suse.cz>
References: <20240618045458.14731-1-tony.lindgren@linux.intel.com>
 <20240618045458.14731-3-tony.lindgren@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618045458.14731-3-tony.lindgren@linux.intel.com>

On Tue 2024-06-18 07:54:49, Tony Lindgren wrote:
> Let's add match_devname_and_update_preferred_console() for driver
> subsystems to call during init when the console is ready, and it's
> character device name is known. For now, we use it only for the serial
> layer to allow console=DEVNAME:0.0 style hardware based addressing for
> consoles.
> 
> The earlier attempt on doing this caused a regression with the kernel
> command line console order as it added calling __add_preferred_console()
> again later on during init. A better approach was suggested by Petr where
> we add the deferred console to the console_cmdline[] and update it later
> on when the console is ready.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Co-developed-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Tony Lindgren <tony.lindgren@linux.intel.com>

Looks good and fixes the regression:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

