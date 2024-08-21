Return-Path: <linux-kernel+bounces-295208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B049598A2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59C59B23893
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5831E8633;
	Wed, 21 Aug 2024 09:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gydyfXgW"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDEA1E8628
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 09:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724232108; cv=none; b=g4TfqnWKPHm7QhT2RlMD4I9xL8PoDAIn6N3koTVPDIZhBwG9DKPqC8kdEEY7+rK8wevexu8bpWx9aQFOfTw56LdlMH30iz38JNiuFte9G/Lfsx5OHnBzf4AaP2Rx7scG0wcJp5CegTzhbbL9tjHyysbn+dpctVCAzEGeTBBLcis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724232108; c=relaxed/simple;
	bh=zTrmrwvcnsUQONnVX7bXvpZTK4JkDDsBtO5iwajA6aE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8Co19B43f+fcIL6ZlOUEmM+uuJH2UXVoj4//QD1xETPK9hjL1QfIQmiGvgWPjlgfAza+1e3Q193skxI/pMju4oizxocDr0uCvcHBMcYGi+uAr00LHV4ywFYIEZ4ly9xziglR2P7tUv1V9DdIu1Y0hEQYBaWXY4TezAU0MBVe3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gydyfXgW; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7a8a4f21aeso787398966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 02:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724232105; x=1724836905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mEERTRPjJTEkA5X/eKpaMzz4m2QDKwkJiDLjgwX79HU=;
        b=gydyfXgWCjgdhmXEJ4TLl1S96HDbpmtjq0t8wKUZevFdXl37E7zw8AnxLg4sGZxHDH
         AMBUloEgvdF349cbtZ7EiCweev08Y3cHJBpp8dSV14rBBokqf8O1G+Cawb//jLFxfWEW
         MTjVtg2zl1o+7Y9yqXq1STMBdBH5lBHka5DUo8NLEXy0wP/OKl4z5b1jepWAQG7KF1HV
         gB0PFI5D7RaQELYsPOgmSt12YyL9k4MfpYQvpMFtsZcR1NDe179fz7sx0tZgJ04mKorB
         qwjyFl2ZoxlMM6jK02ucNbXAT+JPgJzjJlUGcknYulfvvIv7+INmntW7Q1Ezhq1lEmWD
         XNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724232105; x=1724836905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEERTRPjJTEkA5X/eKpaMzz4m2QDKwkJiDLjgwX79HU=;
        b=Lewon5l1StQ3ePxLjYUVAUZyWx81niKNHTI8XnVBH6JE9dSn5ZsyW12cNg5gEUqZT9
         NkP4SPumrG4O70JUjJ3seNijrlCbssgvt7pCkqZ1ZtWgIWHUMBx3Db7tCW0hpKY282S3
         jcUBs4ax03IHSKYnzIKkvafgoXFRr4wdeSk8grqR3coj52rprhwNKF/AIeSjtRdEmw+o
         zrkV8K1rdUyltOqqmQ0h2/Z+MDfnXAXRfBKTD9mZfeP98N2uvADU4ZEY9JQKoWmBERUV
         S1auE7SsLlXY96FO2CO05UWXMdFtkKEvgx1Yi3ZjnhpDj/SmiGxmGuZmRJJpYIUWroep
         Huww==
X-Forwarded-Encrypted: i=1; AJvYcCXYZwNmmBnT9pEvN9RhXSzIyM+JbqRkLLz3W5gGGZvNS6jStlwLr7xXpR4Bb24ZzB4cGJrnZcjvom2zSd0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4IzDG916nVLJRWYceRoiwui4vynKGTFfFax85oXw+0PZp/fs1
	avMAKwY2B12d2n3a5L4FUlZYklEp2Zw/XUsEDPdQQr442Pe21VsahzZjVS511T0=
X-Google-Smtp-Source: AGHT+IHTKefgAMslcV1Cs0upS9eDIaDmi87CvvZ8H7V6d6k0M6zSoNhCt8tI49NL7kOCx/S0LuujdA==
X-Received: by 2002:a17:906:bc27:b0:a7a:ab1a:2d65 with SMTP id a640c23a62f3a-a866f9c83f1mr128643166b.67.1724232104806;
        Wed, 21 Aug 2024 02:21:44 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383946898sm881723966b.174.2024.08.21.02.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 02:21:44 -0700 (PDT)
Date: Wed, 21 Aug 2024 11:21:41 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Tony Lindgren <tony@atomide.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Ryo Takakura <takakura@valinux.co.jp>,
	Uros Bizjak <ubizjak@gmail.com>,
	Joel Granados <j.granados@samsung.com>,
	Lukas Wunner <lukas@wunner.de>, Feng Tang <feng.tang@intel.com>,
	Baoquan He <bhe@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH printk v8 00/35] wire up write_atomic() printing
Message-ID: <ZsWxpVG8uZ9Nq26h@pathway.suse.cz>
References: <20240820063001.36405-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820063001.36405-1-john.ogness@linutronix.de>

On Tue 2024-08-20 08:35:26, John Ogness wrote:
> Hi,
> 
> This is v8 of a series to wire up the nbcon consoles so that
> they actually perform printing using their write_atomic()
> callback. v7 is here [0]. For information about the motivation
> of the atomic consoles, please read the cover letter of v1 [1].
> 
> The main focus of this series:
> 
> - For nbcon consoles, always call write_atomic() directly from
>   printk() caller context for the panic CPU.
> 
> - For nbcon consoles, call write_atomic() when unlocking the
>   console lock.
> 
> - Only perform the console lock/unlock dance if legacy or boot
>   consoles are registered.
> 
> - For legacy consoles, if nbcon consoles are registered, do not
>   attempt to print from printk() caller context for the panic
>   CPU until nbcon consoles have had a chance to print the most
>   significant messages.
> 
> - Mark emergency sections. In these sections, every printk()
>   call will attempt to directly flush to the consoles using the
>   EMERGENCY priority.
> 
> This series does _not_ include threaded printing or nbcon
> drivers. Those features will be added in separate follow-up
> series.

The series seems to be ready for linux-next from my POV.

I am going to push it there once I get approval from John about
the proposed update of the commit message for the 30th patch,
see https://lore.kernel.org/r/ZsWvRETyuh1Yq80j@pathway.suse.cz

Best Regards,
Petr

