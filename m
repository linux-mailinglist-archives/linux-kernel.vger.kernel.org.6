Return-Path: <linux-kernel+bounces-168732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F2B8BBCD7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 17:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F442B2172A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 15:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74460225D0;
	Sat,  4 May 2024 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HWYpKkor"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240963EA76
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714837246; cv=none; b=AX9iLotGJHOXeF9aTc4M3OKrnSCYxycbT13jKIoi/p+DYVvhrTHvpK5yd5Q+O4Hi/4VdjtlRC42Y9p0T8EzkXEcjVNAHpXGK6pWdnRVujs5UexRC+D6W44eeJZxNoPwOniSpIA7s2AOwUKGaBwT2bXO/CqYLvMoKO5Z78tOcdx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714837246; c=relaxed/simple;
	bh=+wl7Si+XKc7WGkikTFO8826D1qbowNHEhUrycKotHDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H2opA8mp4asQKeBkgeu3wpSDidSu9g2UhBaGYEiuHm5nUScZD9tb+FGpeZ5j+HEW5wTX3qM8VxTrjht1tyT4PmQRIaQcJ/B6KCHKPURjfL4tl+Eia8usEQVpKaQTwbceQAU6ufdpJhGkhCXh3DIu/9DCCGLi/N6mk/M9OrwZqXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HWYpKkor; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a59a934ad50so97235766b.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 08:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714837243; x=1715442043; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PFxw8P3AYgeC7IB6rTn+68WOAU10n6cRPv/6X7o+SOY=;
        b=HWYpKkor+X0OlBZ+pN69qc1p+9D286NR/kjb9Eut9WyLQcVKAOVM+kjWJolAyRIjnb
         EleZB/FacFvDmPO7B6sIPd5rt4NS4hLPAbwx/r0yyPImDmy+aY8X2i+CokrQrNVi9S9s
         PrkfUJUNyE7Febc1tcRFEVT+pa1I32u++fKWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714837243; x=1715442043;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PFxw8P3AYgeC7IB6rTn+68WOAU10n6cRPv/6X7o+SOY=;
        b=IF4jTQK3+LIFcILcNOn7Ih9h3fCpRQCfzp6PWhy251cZgcAg+jDEwRkSUHfBoUefB0
         Jp//mQPEnYWkmsHM5cuHXLRfqs+i2i69bNE0LzjbnTHzbLY5WcNIV3toZpPSqTshtgqH
         RFPx2IwKJ+K1/soYgdsOKFNq/A4TbJJjQ1IF+Dksklu5QPCAed8BGJiwAOkLKfa58OVi
         hg9i4AtWvmuSbtuhtKxfUk+4XrqWJ76aK5GMF9tIfeHElQvcFceCr6vMaAIpF4MVLzGQ
         615W0nN/STO+LdGgEWJbj1iUdZwoIzUhmCde5IyQwO5B38ea5yb61CQ73m3lpNjJfFtd
         c56Q==
X-Forwarded-Encrypted: i=1; AJvYcCXr/mkxooAEYfEpTYBKFYpGAd1aKg7ifM3zS0lFWHTylDFTnRYn4lxOcYC13fKjCmsfDHMxUh6W27MyFOPQtVJ7a7yiktGo18MIJGcl
X-Gm-Message-State: AOJu0Yxy+FFCfpTQf5AhRyEcRi4t429hqI9YygsaMK+y4MhZ/ljEqJDE
	wQwqZzPS6kwxw1sn8uo7870M6Wtmlc8A6F1215NGQqW+cFh8pb0Xjrv8qKP1n8CiJEUkdEKzyFE
	Ep8xnyg==
X-Google-Smtp-Source: AGHT+IGnBD8OxZMM1vxiEWnJmaO16tOPuSziL08QQn/Q9gKEQoLhwM02njmpw14VaOT5WMVG4JUQMg==
X-Received: by 2002:a17:906:dc04:b0:a52:8a8a:59a7 with SMTP id yy4-20020a170906dc0400b00a528a8a59a7mr3655133ejb.15.1714837243414;
        Sat, 04 May 2024 08:40:43 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id d12-20020a17090648cc00b00a59a874136fsm837629ejt.214.2024.05.04.08.40.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 May 2024 08:40:42 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a599c55055dso125713766b.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 08:40:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXNi2keMaZ+m0Q0wHPiq2c3w2GoPa3zj7G42nGoSXvSd1zxKH3NtMgpdYpqFNklhJ7MAkTkF5R6myjJfnj6fqLvie/IvHtY2evRZuQL
X-Received: by 2002:a17:906:cf83:b0:a55:75f6:ce0f with SMTP id
 um3-20020a170906cf8300b00a5575f6ce0fmr3540131ejb.13.1714837242162; Sat, 04
 May 2024 08:40:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405031110.6F47982593@keescook> <20240503211129.679762-2-torvalds@linux-foundation.org>
 <20240503212428.GY2118490@ZenIV> <CAHk-=wjpsTEkHgo1uev3xGJ2bQXYShaRf3GPEqDWNgUuKx0JFw@mail.gmail.com>
 <20240504-wohngebiet-restwert-6c3c94fddbdd@brauner> <CAHk-=wj_Fu1FkMFrjivQ=MGkwkKXZBuh0f4BEhcZHD5WCvHesw@mail.gmail.com>
In-Reply-To: <CAHk-=wj_Fu1FkMFrjivQ=MGkwkKXZBuh0f4BEhcZHD5WCvHesw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 4 May 2024 08:40:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wirxPSQgRV1u7t4qS1t4ED7w7OeehdUSC-LYZXspqa49w@mail.gmail.com>
Message-ID: <CAHk-=wirxPSQgRV1u7t4qS1t4ED7w7OeehdUSC-LYZXspqa49w@mail.gmail.com>
Subject: Re: [PATCH] epoll: try to be a _bit_ better about file lifetimes
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, keescook@chromium.org, axboe@kernel.dk, 
	christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
	io-uring@vger.kernel.org, jack@suse.cz, laura@labbott.name, 
	linaro-mm-sig@lists.linaro.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	minhquangbui99@gmail.com, sumit.semwal@linaro.org, 
	syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 4 May 2024 at 08:32, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Now, during this TOTALLY INNOCENT sock_poll(), in another thread, the
> file closing completes, eventpoll_release() finishes [..]

Actually, Al is right that ep_item_poll() should be holding the
ep->mtx, so eventpoll_release() -> eventpoll_release_file_file() ->
mutex_lock(&ep->mtx) should block and the file doesn't actually get
released.

So I guess the sock_poll() issue cannot happen. It does need some
poll() function that does 'fget()', and believes that it works.

But because the f_count has already gone down to zero, fget() doesn't
work, and doesn't keep the file around, and you have the bug.

The cases that do fget() in poll() are probably race, but they aren't
buggy. epoll is buggy.

So my example wasn't going to work, but the argument isn't really any
different, it's just a much more limited case that breaks.

And maybe it's even *only* dma-buf that does that fget() in its
->poll() function. Even *then* it's not a dma-buf.c bug.

               Linus

