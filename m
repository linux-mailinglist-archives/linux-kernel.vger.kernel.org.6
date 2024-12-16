Return-Path: <linux-kernel+bounces-447906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E39089F3868
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2678116D8C1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BE72147F4;
	Mon, 16 Dec 2024 17:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AlrSwZGY"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34409208997
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 17:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371997; cv=none; b=dxhp/uYH8Ym0+lyQvoAABlqjm/dqrlJBj4KYaCBntppjSFwloY8SgBSNJVll/pdbqZBaG5A3oZm3GLLHBDAkBy+abNe0KcETncFetfAx6A8Iki/+Ihhd5YKe02R+I2ipyb6OcD2tmq2Ymr7zyuOAYQLI5uLzxtBiyQMT8P3fHuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371997; c=relaxed/simple;
	bh=28Xr7YkvGvy9Y8S/3Vzt74Zg34q+9beXJ+u0XQqOY4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JgG+scpxrwEGzEf+Lchj6b2vgxmpw8f8x1SOdg7DkPXHc5MwY8wREKg5rNqMjk9VVUr9fONEVzNtEAtyUwzRdydcLNSGMxVDnyu1iyvT1NL9K5qMTFFPjHNedpZen/8ap5vVUPh3GMszcdvLzO80dJLLC3oNDukUSsY4nUAlpUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AlrSwZGY; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso673087866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734371993; x=1734976793; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PoIqM4lGkZGVXqEUNVkpPEgzopLjXtfITbGUBrnVtJM=;
        b=AlrSwZGY1sliBGLq3U6sEtlNGmY0QhISb7RbqL9bCDx13g1a7gOXQY6b6fugy7zRhG
         23rajizJExxY/LPvVhsyh6bo2NoYpBcyFVWDl9mkba/9mOtBFNgnQ4ULAZatYAuDyG17
         y2LzXnLJ/KB9V86UKALN7SqcI1C1IIYkWwhfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734371993; x=1734976793;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PoIqM4lGkZGVXqEUNVkpPEgzopLjXtfITbGUBrnVtJM=;
        b=LwB+eIBAyTH+jjze8bFWQkByhqtqoGyXEC+Q6a8/dSl01nP06VxVi903oINL3zf/8P
         W7ffyD+qhJlZyyI7G2efnKKn8l2LXeze1kyIPrGDkFULiF4OtlQrxKU7ZhCrtPXgjL6k
         6g/UVgMkV/YAEtqe84KtFx8NekvIBhGwMOJ3YAxNNv9iboeWXPx5UhwpPcGXv9QWKUjv
         LsVRRCsmi8pO/XDo0b8gC/9f4GUgXemaBbsUHM8lnS1Stl4ZQtYWTa6fNkyciVYO9sVK
         VJrN6l815igkmSNIFwURTTyWtbZXYTsz4LRuiHJ+oSgG7qrTUJZ5X0mxqt44QiHfT8rO
         bmdw==
X-Gm-Message-State: AOJu0Yx1UfkkuUy4hHV8FauLylGb/NsYqLTW2vyf5j+9cGvI4ebk+FUm
	q5VEgToe7v3zpb4URDXJ3g3QBOM7Si8e8EJAHIkUWnXzDPsNmQZl37XhiIWGrn/81ozMqrOUU8R
	dCcE=
X-Gm-Gg: ASbGncu2pONaj0pPHDLJ0OI1OquFzRJ9qqoj8JRmpURLek2BBPBu7Wf+eMXqUMNeZQB
	wFRYplM+7P46sGhF4uzRPb6UJaHM7ckpWMpWXW2CVlGSS6S5F6RDXTtTrWV1mj1v6e3nCWCQurp
	Tv0+jr2jGL4thEEU/OBCHj01XrPyZRQqM55dVxteL+Vtlunc6eX7u1MBNRNHU3NcbBro8ErBUZh
	ARQjEx+VR44iI7KqjCktiW99hNbKAzHKsOriYQVK3d8xPRq6g7N+v2VGhLIlzXCG94cTPOO5i88
	JOk0XSLgUZe5Mj26YmlgCvk5H4+uuko=
X-Google-Smtp-Source: AGHT+IHnjrEvlAWtXK2cOI8tYJNis3DI6gCCfGtoWs8uwZ37ndzqQfwC53clhvpfelyZ24ne7rA6dQ==
X-Received: by 2002:a17:907:96a8:b0:aa6:6c6b:15fd with SMTP id a640c23a62f3a-aab77909e9amr1389470866b.20.1734371993308;
        Mon, 16 Dec 2024 09:59:53 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab96068177sm351596666b.57.2024.12.16.09.59.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 09:59:52 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso673083966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:59:52 -0800 (PST)
X-Received: by 2002:a17:907:3d94:b0:aa6:8676:3b33 with SMTP id
 a640c23a62f3a-aab77ea5986mr991693366b.47.1734371992249; Mon, 16 Dec 2024
 09:59:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214182138.4e7984a2@batman.local.home> <CAHk-=wgyWEbWa9k5=z4LxY1hx0Pxqf5TQQC_BKme_+DrzGufKw@mail.gmail.com>
 <20241214220403.03a8f5d0@gandalf.local.home> <20241214221212.38cc22c3@gandalf.local.home>
 <CAHk-=wiSdtNvq_wUtq7f3oO7S7BYCeXh7a707HKvK9nVkxR=jQ@mail.gmail.com>
 <CAHk-=wh3cUC2a=yJv42HTjDLCp6VM+GTky+q65vV_Q33BeoxAg@mail.gmail.com>
 <20241214233855.46ad80e0@gandalf.local.home> <CAHk-=wh3uOnqnZPpR0PeLZZtyWbZLboZ7cHLCKRWsocvs9Y7hQ@mail.gmail.com>
 <20241215050517.050e9d83@gandalf.local.home> <CAHk-=wh5jE5ARarmYNdL4sja36_e-mnejv3zRMC62Jzn-a3omw@mail.gmail.com>
 <20241215202404.06f7be8f@batman.local.home>
In-Reply-To: <20241215202404.06f7be8f@batman.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Dec 2024 09:59:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi-7D-9Lp+bMGyw6nt7y-KBQj4-utWE=8nfLSbs4G-o7A@mail.gmail.com>
Message-ID: <CAHk-=wi-7D-9Lp+bMGyw6nt7y-KBQj4-utWE=8nfLSbs4G-o7A@mail.gmail.com>
Subject: Re: [GIT PULL] ftrace: Fixes for v6.13
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Michal Simek <monstr@monstr.eu>
Content-Type: text/plain; charset="UTF-8"

On Sun, 15 Dec 2024 at 17:24, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > IOW, instead of dynamically creating a temporary buffer and adding
> > that 'x' by hand, why wasn't that just a 'sed' script and done
> > statically?
>
> I'm also OK with that. Should that be done for 6.13 or something to be
> added for 6.14?

So a scripted thing could probably be done right now, assuming it's
obvious enough. Something like

   git grep -l TP_printk.*%p |
        xargs sed -i '/TP_printk/s/%p\([^a-zA-Z]\)/%px\1/'

would seem to do the RightThing(tm) for at least simple cases. And I
didn't actually find any cases of people using %p with precision
modifiers or anything like that, so "simple cases" seems to be all
that exists.

What the above does *not* do is handle any multi-line cases, and there
are probably several of those.

That said, honestly, looking at the resulting diff, I really think a
lot of those %p users are mindless drivel in the first place, and I am
not convinced that the real address is even wanted or needed. I think
people have completely mindlessly added "print out address" without
any actual reason for it.

I'm seeing things like just random usb_request pointers being printed
out, and I'm not convinced that is ever really useful or a situation
where a '%px' is *any* different from a plain '%p' (ie the main thing
I suspect you can do with that value is just say "it's the same
request", and the hashed value works just fine for that).

So I am not convinced that the original reason for the mindless
(runtime) conversion of '%p' to '%px' was really even well-motivated.
I think it was a bad idea, and implemented badly.

End result: instead of doing that automated sed-script (which is
certainly easy, but noisy), I actually think it might be much better
to just remove the runtime '%p' -> '%px' conversion entirely, and see
if anybody even notices - and then when somebody has a good reason for
actually caring about a random kernel data structure address, change
it at *THAT* point.

                 Linus

