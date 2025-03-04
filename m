Return-Path: <linux-kernel+bounces-545309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8014A4EB86
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCD3C1881E0D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7360D2857CF;
	Tue,  4 Mar 2025 18:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="haVjyarl"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB9A25FA19
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741111957; cv=none; b=mZUp3mwwQ/N9uCejjyQrzYVJ9Y4HEAGtEpQiP3IztNwp4BAgJyh+w/S/HZ3W0wKa+wxsBCvIeDcGfz3PsldzRqkOFzEjcGloBaTX9qy+vtMXsw+xu2r9T23e9LE3eZo+ucFBtaqKdnv1jTt2sncMfxqdkC7ZJ0qsGik28RACGRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741111957; c=relaxed/simple;
	bh=ZKEiViHx4lfhXN2b+U2kj8U/5qjRqfhrRty0Xi1nIUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LZfWnlS78Ri7Dp6LNHejF6kujiSOMiI4P9hqjUQPRAAPhkYuGXg3L1eWJ/hh267QLGJh01ciDZu7XwcDIAtE5uljVGh/sD0VZceON3S4wRmMysiUyUn9ItpdIXxr0L5pIuXcB2IHNDd22j7TlhAq4DO9Dm1Cg2A/OMn8iP0pbok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=haVjyarl; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e4c0c12bccso10439691a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 10:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741111953; x=1741716753; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cotFSgUM+8LCa2jd4lHJ3XLun7qyfRX9tXHNjJu7zBA=;
        b=haVjyarl8e5tQsKQcwJkOmqieMH6Fjc5d3tPvYdorYrN8xZvSjSMs7HQXmV470GG48
         O4sAVfD0bgVht4YqEmGxn0UlDw71jHdH8zRH8Cq5wBSm6zvT6GQTECD3LI1N7uYQt3K8
         4xiy9nZwrfuovM2GfKC2x8WclFX9wpJUoIrKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741111953; x=1741716753;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cotFSgUM+8LCa2jd4lHJ3XLun7qyfRX9tXHNjJu7zBA=;
        b=ldUpEUHUhN4v25q4qA1WsXYW2oSBmOV4PoU1Hg0A1y50MDRCRV9WRO+ZpzCyB49PrC
         AG3VfgsPYfOOjg5ZVSqZtzoHzsKdun/NVAo+HU5ZthXHp2YWINfE1+pUavQV/tJbr5i/
         Bv2czQBUoyiZ3ieN6ctpWRNHc+5iN84tJaR3J2gTvVv5Novg/2WPSD6YDZz7ifTWENQp
         B3qsd1r49o23/CFwa5KEeMtIFn41Cvev4YfdF7nlAFtHnbGtZqfTfMBwf3DwxQZNcyb6
         yDQ18McZkRtPQ/FkMURqe8sarQJP23m7exXQidXCMQZebGEKf5aLPwoLl8RITWaY+6dC
         bvVg==
X-Forwarded-Encrypted: i=1; AJvYcCW514ST+3twQAdb5xz+Fh8VUzSIF9Fhe1YDSmiuNx+mi//Y/bF3a2scVtfLO0Y73YvaVjkpL7vrYFcLl8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB0AW2D0nDs0TTmuzT1Q3VmO/ofGyDmxw5+97zEokWXTARMrPj
	YKNwqfSbOQGL4bI2psI025p+22AOrAUVh/u6hBjt0NXoMwaeh2c8hk7YmcU4nvLxPERSbEoSwfo
	rJ5kKWA==
X-Gm-Gg: ASbGncvKjlnRMGesj6MOHcIfSv1mGDmKTVZXQDNvPOUNvHcX0TgXMAWaDzOt8dWbnHt
	XmqFuEoWRRKRvmws7Yu4cr3ceMB2467MC+/7rP8T+JWzR4EKoRobOqU0dUQtLGTs5gp3bZuXDwi
	Ef238xU6LTHAo7aFBipbvFKdtAmM1Q+mvs0lfTKNdhcRyp24aqG68/q9ZrLKFI+FTDUCb6vsEpX
	08ExV4dS8iGw7TDV/9pfiI0V5GQpbdZnUJERuspiGPIAtfN6S0EqV/zsvPRCLE2Edexu48yk0mY
	6KHzsK4UxUMS4mbFjbJr/5WEiF8+Ay22P0XaL6kWy3Jfgfsi15vpfvKEwO3gvFdDJb+/O2W8Lr3
	VQCivfG8bTmaYYO1Wm9k=
X-Google-Smtp-Source: AGHT+IHvHc1W1uAV9CCyoGWUNVsWkc6XGTj7y7LFDT5NKp4pF4uoyLULqssajGtt7wQca+1/86DAxw==
X-Received: by 2002:a17:907:608c:b0:ac1:f4bc:3797 with SMTP id a640c23a62f3a-ac20dabb6a7mr23169566b.14.1741111952846;
        Tue, 04 Mar 2025 10:12:32 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0b9956sm1006699066b.16.2025.03.04.10.12.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 10:12:31 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaecf50578eso1132873166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 10:12:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWi5Loh1xc23HE2D3+fWT2vJc8watskvDidWMkiy/b3l5FyVThq0PecKNRdZ1LYmaA72RAyQ0vNTmuzSAU=@vger.kernel.org
X-Received: by 2002:a17:907:96aa:b0:abf:40ac:4395 with SMTP id
 a640c23a62f3a-ac20db4ce56mr17933166b.31.1741111951498; Tue, 04 Mar 2025
 10:12:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303230409.452687-1-mjguzik@gmail.com> <20250303230409.452687-2-mjguzik@gmail.com>
 <20250304140726.GD26141@redhat.com> <20250304154410.GB5756@redhat.com>
In-Reply-To: <20250304154410.GB5756@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 4 Mar 2025 08:12:14 -1000
X-Gmail-Original-Message-ID: <CAHk-=wj1V4wQBPUuhWRwmQ7Nfp2WJrH=yAv-v0sP-jXBKGoPdw@mail.gmail.com>
X-Gm-Features: AQ5f1JqjSP27LVMyo09ZwIOqft6imz235TbU_7WRePdslf_UMXdRbBjWU8irOdU
Message-ID: <CAHk-=wj1V4wQBPUuhWRwmQ7Nfp2WJrH=yAv-v0sP-jXBKGoPdw@mail.gmail.com>
Subject: Re: pipes && EPOLLET, again
To: Oleg Nesterov <oleg@redhat.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Mar 2025 at 05:45, Oleg Nesterov <oleg@redhat.com> wrote:
>
> Linus,
>
> On 03/04, Oleg Nesterov wrote:
> >
> > and we need to cleanup the poll_usage
> > logic first.
>
> We have already discussed this before, I'll probably do this later,
> but lets forget it for now.
>
> Don't we need the trivial one-liner below anyway?

See this email of mine:

  https://lore.kernel.org/all/CAHk-=wiCRwRFi0kGwd_Uv+Xv4HOB-ivHyUp9it6CNSmrKT4gOA@mail.gmail.com/

and the last paragraph in particular.

The whole "poll_usage" thing is a kernel *hack* to deal with broken
user space that expected garbage semantics that aren't real, and were
never real.

They were a random implementation detail, and they were *wrong*.

But because we have a strict "we don't break user space", we
introduced that completely bogus hack to say "ok, we'll send these
completely wrong extraneous events despite the fact that nothing has
changed, because some broken user space program was written to expect
them".

> I am not saying this is a bug, but please consider

That program is buggy, and we're not adding new hacks for new bugs.

If you ask for an edge-triggered EPOLL event, you get an *edge*
triggered EPOLL event. And there is no edge - the pipe was already
readable, no edge anywhere in sight.

So to clarify: we added the hack to work around *existing* user space
bugs that happened to work before.

If anything, we might consider removing the crazy "poll_usage" hack in
the (probably futile) hope that user space has been fixed.

But we're not encouraging *new* bugs.

               Linus

