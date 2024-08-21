Return-Path: <linux-kernel+bounces-295633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5AC959F53
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB2541F2340E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0591B1D40;
	Wed, 21 Aug 2024 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gMztRNNj"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C94A1AF4DB
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 14:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724249406; cv=none; b=CvrsggBC9NowpTYhtTxkislcSg5OyozPGlJ9oesKHRjaeiVnTwCQ47roD8GLZlt3sk3X00YeQoE863kFMpEVK9h0gd9CAMy4Eb3uRwXbNgSezcDL9e2QAiv/b7HJxnOw434blpjiNcLBrPS1z6wAOYzeB5zmTjTlAZEiLsSqfFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724249406; c=relaxed/simple;
	bh=riyVaot7yE9KKpq7VxW53IsUodHZOfqZV1CJ4X02tHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5TeT92qYEndh0TwX/57s1b6seFW5M1WVj4H7eVFZ2otAYW2jbSGGjkBZ+1CF1lQoDz7ZBK/m/SbqabUyTM74n14V9yPIFSJ1T1D69IG1DzaVbQVU87/j+NYUkVMtjvqYRO6OTd8Qa8pw07q3VqHKhRh0X8jdM5NKwbBiUuZvCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gMztRNNj; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5bed68129a7so6247184a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 07:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724249403; x=1724854203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pyVej4wWk7sZ6oPDSS5+W5HYICTGvMDbDpyFC/8qrHY=;
        b=gMztRNNjdM7c/Zywdf6bFEcUM4PxVlv9HCZBuNCFhKrkSs3DasmEmNTy94zIeKkY6K
         xNzNFqnsSzg8Zc2Sn3P/Z0FQt/fBgHC0Kai81QM7bFrFNrBZaCnv8erG6u1rqdkqXlkP
         kECjK4ZV0D3L9BJIYWPXEBHEZvmgROqTK2JqwP2uUhyj5vfu+itrKd8UXAn1xPBJ9FOz
         CN5T2rCMtjvUjDleIZIIdkuEt3BDcb94F1mpNEbn+YogMP73s2I/YMh2g3x3ZpLPhglu
         XQ5nepxxXEhQ0Ri0lxW0qX1tK2yRPEyb05aW6LSTZEejJ5lH75zCPOnmynSKz5oiBKvX
         1RFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724249403; x=1724854203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyVej4wWk7sZ6oPDSS5+W5HYICTGvMDbDpyFC/8qrHY=;
        b=HzjfxLK3aEgm/mSLZ5iKVI7Tb+sBFF9CQUt1//IHZhSJcWc6i0giZZ5IO5Z++M2rEi
         fVdcnzpw8WdOfOHTKhNO1Ox82SFAVLB5kgMGVNM2j8EQxGmsUVApPg8XYOSannT24HDp
         WM+AtaDNgGMhXFW3K2bppGS1UYpQsASd5iooNaNuESj1JCxf6+tT92XBkYQBHw8bGzut
         +wLgnMaCDfJLQhz5oFn5wuM1oIcYI9FjjaKtzGmgHGFKBz0LHFRuNWerMuzAMyxlCCZo
         rUIK73cOHdrZhGDz8MhVCf+bcB3KuNA/pRL3H0KITsF95aKtJxt183+l8KfdnzCikKKL
         j3vg==
X-Forwarded-Encrypted: i=1; AJvYcCW9rZcEWsy6ZGmYwhZPqVk/jStPhlF3BWrHaxR/uUoHNlr0PaKkh+HbZIPqB2t/V5BIS3vogdYQw2p4xpA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs9QIlk4qEFnWNbQa/F3MyPO8n3drll2QwHuR6RWevgounHGlp
	VQomgu8Aw8kTldn0sodEl4wBAnlYrCK+THpEm3v/G35w2nbMNXesko/YItxBA8Y=
X-Google-Smtp-Source: AGHT+IFaJ95fVS3WarToMUvEwzPOidzKcDkwSwhOd87o/almjcB695xARxQZyqh4KrES3XHrEtGu9Q==
X-Received: by 2002:a17:907:d3e1:b0:a7d:e84c:a9e7 with SMTP id a640c23a62f3a-a866f8a99a9mr191794366b.53.1724249402461;
        Wed, 21 Aug 2024 07:10:02 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a867acc87ffsm79881466b.28.2024.08.21.07.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 07:10:01 -0700 (PDT)
Date: Wed, 21 Aug 2024 16:09:59 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
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
Message-ID: <ZsX1NztislIJuYsy@pathway.suse.cz>
References: <20240820063001.36405-1-john.ogness@linutronix.de>
 <ZsWxpVG8uZ9Nq26h@pathway.suse.cz>
 <20240821092841.j42XmBAk@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821092841.j42XmBAk@linutronix.de>

On Wed 2024-08-21 11:28:41, Sebastian Andrzej Siewior wrote:
> On 2024-08-21 11:21:41 [+0200], Petr Mladek wrote:
> > The series seems to be ready for linux-next from my POV.
> > 
> > I am going to push it there once I get approval from John about
> > the proposed update of the commit message for the 30th patch,
> > see https://lore.kernel.org/r/ZsWvRETyuh1Yq80j@pathway.suse.cz
> 
> If it is just the commit message, couldn't you push it now to next now
> and then simply rebase it with an updated commit message?

I see. It seems that John has vacation and can't respond quickly.

OK, I have pushed the patchset into printk/linux.git,
branch rework/write_atomic. It should appear in
the next rebase of linux-next.

Best Regards,
Petr

