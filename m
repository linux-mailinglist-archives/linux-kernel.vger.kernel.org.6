Return-Path: <linux-kernel+bounces-168731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7E78BBCCD
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 17:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7436B21600
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 15:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236E5433C4;
	Sat,  4 May 2024 15:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IHeZPcWA"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CD5225D0
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714837153; cv=none; b=dXYcOIawdhquIC9rx7CNbiKIczGoI3Le7og1R7/iqTMbEQ4Z4PcatHlsG9PVNyhIy5DLsilB58fjw9cG1se6mv24PkBy+LCFIyRpx9StzRss/wTNh/CJ0CcQoj+d2RUzLWF6uaYYZ4ZQ0f8FMm1jLhdMQyqaYObTvZTF194RrYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714837153; c=relaxed/simple;
	bh=dmLzNSiqTCKSgtEtdi4RT/LW9OkahTnAY3Pn0EDC+4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GAIlsVE+FzOzfi1dwbqRO4kdufmR3kwWukD8BZyU4eB7x/nLgRjFULeqQw+lZzHncPTFRveBRhei2Wof5TdS6G4dfjwNnOK01IYdzBc9m84iXUUMgTV/XjTAzN8DD7RlgiQNNh2HOMzuvulEnFCCxD4bFp2GOEiKrW5HSpYUiVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IHeZPcWA; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a59a8f0d941so105222966b.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 08:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714837149; x=1715441949; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BF+X0IVed+h7jlJZMJqRgUDnAGAy0IxXXOyqwBdkEc0=;
        b=IHeZPcWAWJBMFM1/RM46W+XfepCrlJ1rTPBN4m70S6IjqjGsSRogdw3Yiz+sXp+kn0
         nno0QoCSZZOSwmUIaad7WQZAVEJy7pfHc3HXEvr9Yr51Bs3H1vO3mlXOcvZ1t8ZKjiVR
         uRazLELIQAViYbM+WDPjImVYg+96UxluFahMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714837149; x=1715441949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BF+X0IVed+h7jlJZMJqRgUDnAGAy0IxXXOyqwBdkEc0=;
        b=mtbfX7iM2l9rY91K88ciwJGT8aClx+jX8n+W6zubjRLfIAV51m9EwhI314YKl2/tkI
         KyBZUlLBUl78JUPeJJBPk/5YTgE3TT1IocDQVNQLEqsqDiw+GB1fvbG+5oIqIWLCgIlA
         J89eaCCXuKsuTvEZxWWhTdsi2LCPtbpP+yXNu1m5SD6zybmgcvfmuzKw9Jr1uxSkwAyI
         3kmJm1GFBytkH2frXxX84ngJbUawE7I6kD+FNlt5zDrIULHM8DOwLTfheBN/nlFNi3gf
         W2j5aAKs+BjM9c8stpsS5sCq5jI+f5moujmHl1agVf6iqSO5hE4dwDChQzCfnmRKrtJY
         rVwg==
X-Forwarded-Encrypted: i=1; AJvYcCXjZAQVgD7SE5KTG7MPVJERbNHIW+QLGAEoHEUJdKSp3pDtIOKCDN/L/r8c5eMyDOJINmauXxkkzbtgd26g0j1eTOZQUE/4o5Dxkv+R
X-Gm-Message-State: AOJu0YzoLRpNaty1JQhkRUpwM76Fb03QMGqhoGYrtcB+7Fr2aLFr5wd+
	QXfEEdBFji2KH9VPtZOTmgF7k0V/IRqabEIme+0Bm3b5z6GW9DEdbGdizAMNV1DjHfxoeZAo5nn
	1idVX5g==
X-Google-Smtp-Source: AGHT+IGiLSrLaaLx6gdQb3jVbAV543oj3KJE6rykoNsZ0hm4ef/8VJaYlIz5Gb8dyEyfatl6QBo3Nw==
X-Received: by 2002:a17:907:20e2:b0:a59:9c58:763a with SMTP id rh2-20020a17090720e200b00a599c58763amr2607970ejb.46.1714837149281;
        Sat, 04 May 2024 08:39:09 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id xh9-20020a170906da8900b00a597ff2fc0dsm2431480ejb.69.2024.05.04.08.39.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 May 2024 08:39:08 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a59b58fe083so31919966b.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 08:39:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXx5sBaQspw1Q5zn0QMhEqLTJkVbCcNK1PxBacIDeHlFTOHg9bxxH0nj4ALOYQ1k2zYSe0Y8euGdIX24zkspB3UnIBwffpEF2wOhqpQ
X-Received: by 2002:a17:906:5fd5:b0:a59:9e55:748d with SMTP id
 k21-20020a1709065fd500b00a599e55748dmr2287623ejv.35.1714836742417; Sat, 04
 May 2024 08:32:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405031110.6F47982593@keescook> <20240503211129.679762-2-torvalds@linux-foundation.org>
 <20240503212428.GY2118490@ZenIV> <CAHk-=wjpsTEkHgo1uev3xGJ2bQXYShaRf3GPEqDWNgUuKx0JFw@mail.gmail.com>
 <20240504-wohngebiet-restwert-6c3c94fddbdd@brauner>
In-Reply-To: <20240504-wohngebiet-restwert-6c3c94fddbdd@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 4 May 2024 08:32:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_Fu1FkMFrjivQ=MGkwkKXZBuh0f4BEhcZHD5WCvHesw@mail.gmail.com>
Message-ID: <CAHk-=wj_Fu1FkMFrjivQ=MGkwkKXZBuh0f4BEhcZHD5WCvHesw@mail.gmail.com>
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

On Sat, 4 May 2024 at 02:37, Christian Brauner <brauner@kernel.org> wrote:
>
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -244,13 +244,18 @@ static __poll_t dma_buf_poll(struct file *file, poll_table *poll)
>         if (!dmabuf || !dmabuf->resv)
>                 return EPOLLERR;
>
> +       if (!get_file_active(&dmabuf->file))
> +               return EPOLLERR;
[...]

I *really* don't think anything that touches dma-buf.c can possibly be right.

This is not a dma-buf.c bug.

This is purely an epoll bug.

Lookie here, the fundamental issue is that epoll can call '->poll()'
on a file descriptor that is being closed concurrently.

That means that *ANY* driver that relies on *any* data structure that
is managed by the lifetime of the 'struct file' will have problems.

Look, here's sock_poll():

    static __poll_t sock_poll(struct file *file, poll_table *wait)
    {
        struct socket *sock = file->private_data;

and that first line looks about as innocent as it possibly can, right?

Now, imagine that this is called from 'epoll' concurrently with the
file being closed for the last time (but it just hasn't _quite_
reached eventpoll_release() yet).

Now, imagine that the kernel is built with preemption, and the epoll
thread gets preempted _just_ before it loads 'file->private_data'.

Furthermore, the machine is under heavy load, and it just stays off
its CPU a long time.

Now, during this TOTALLY INNOCENT sock_poll(), in another thread, the
file closing completes, eventpoll_release() finishes, and the
preemption of the poll() thing just takes so long that you go through
an RCU period too, so that the actual file has been released too.

So now that totally innoced file->private_data load in the poll() is
probably going to get random data.

Yes, the file is allocated as SLAB_TYPESAFE_BY_RCU, so it's probably
still a file. Not guaranteed, even the slab will get fully free'd in
some situations. And yes, the above case is impossible to hit in
practice. You have to hit quite the small race window with an
operation that practically never happens in the first place.

But my point is that the fact that the problem with file->f_count
lifetimes happens for that dmabuf driver is not the fault of the
dmabuf code. Not at all.

It is *ENTIRELY* a bug in epoll, and the dmabuf code is probably just
easier to hit because it has a poll() function that does things that
have longer lifetimes than most things, and interacts more directly
with that f_count.

So I really don't understand why Al thinks this is "dmabuf does bad
things with f_count". It damn well does not. dma-buf is the GOOD GUY
here. It's doing things *PROPERLY*. It's taking refcounts like it damn
well should.

The fact that it takes ref-counts on something that the epoll code has
messed up is *NOT* its fault.

                Linus

