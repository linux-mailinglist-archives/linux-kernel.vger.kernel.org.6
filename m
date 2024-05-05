Return-Path: <linux-kernel+bounces-169144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D28988BC3C6
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 22:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021AF1C211C1
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 20:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6907602A;
	Sun,  5 May 2024 20:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QfxqIRwk"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4507174F
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 20:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714942452; cv=none; b=XEdPYQovYOovQF3s7YiYnvS/iQ4o32nM+AV/aSxDtksFwXm8vgFBSj3t62NWapK/Kkd36QbKhppj1UfaReZdWc8gP4m4G2YGDmSymaOeWhUJARSUrxlQ5XN+J8CsunX0a0afcEFpvZ4SvoAHoTEKZYJPUTQGHQcGrIZ2DdQmV3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714942452; c=relaxed/simple;
	bh=R+qvYyLMsL0XW6ld3jDTzisj//rKgA9vvCmBe+m5ItU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nmm0fNJTrLBHpKlp74ar7PpuX5U+iKndWsQ9P61ZZWBfwToRwf72uWOCdXk0sjcLdtF1tgBnUnOD/mmH9fVvGNylsQaTcPwpwF/FazMfos1o0azBow5zuBfxbvz+0yCdRortXtFAbHT8hGSPakRtvr2X/VUlx9Yi0obr6n//zO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QfxqIRwk; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51ab4ee9df8so1623977e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 13:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714942448; x=1715547248; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JMg+wUi7Jg85TzG1l7LAOtzS/OMsOgVla4IG61dTMc8=;
        b=QfxqIRwkFN/Tk6Jt3ALuLuCDAs2TWQ9uh6fefFuW61ENU3XmrXofSAf4AdpKOzvHpV
         Yja8kBdje1HVy5FRSUDK9BuUIWxNrOjYGgnhNcjWQtuhQXoSDD+xDqjyA5fw6X+aCAbO
         tWCzmsg5FF9HDsmkl9x8iFwlgsVN4n3B+HpLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714942448; x=1715547248;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JMg+wUi7Jg85TzG1l7LAOtzS/OMsOgVla4IG61dTMc8=;
        b=ateZqU9jT/tDnhznKnTGgmFvyCa9as5RrUheWNXsks5j/MkeDM6IDhaWan8UXvfpwi
         sMBIWWPi2fY5x52GxvlPPGfYgV4iBWbm8CpgKHdrpe6o/WMYeFhI1fMnjPZjrsjVvxFm
         RSqEVGo6rYgSAdteFoBryKjqmFm7Y0i5yshZqrdI/05sw7lxA8Xs9MKnM/jNyZ6UpDrE
         J1vQj4/W9zgf9NKWJVdEZYT6yhFOvFFfvdHOH6FrYtCQXhdCB2gQQrjDJO22aLqrqVGy
         9n0NQ4P3wDdlEeSH5sOGkf44XW46+RJDZGvtX7RxGKNgHkib2lAgQI4RW60SNe2cyEA4
         wKsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEjWWDlMJgNIDyKdXGWOL3zc22OGH7/ou5+e8TA8Er/JPlnpZJgHaRksOKdbbEuqU28a9Q2OCrgsUF+Z4/DdwGE/SG67sv40H1oeH3
X-Gm-Message-State: AOJu0YyAaDe4FLeP7sPR1ueIqvFi6sCO5oBBye6OEzK9+mbCjzj5kz4l
	kjbqH1vKx6eLCIafu6EX5SspssQCOgWuFXTPDeYkXpYqG7FQoEHmw0QO4tidZoeTKdR6yRYL3sx
	ChT3D1w==
X-Google-Smtp-Source: AGHT+IEjZNE348f2NVwx+xS1zEUhVK9tFXFY1UUAuZKRLxlt1EPB3lfT97hsu+0M0lcJSbyk89tz1Q==
X-Received: by 2002:ac2:5b01:0:b0:520:107f:8375 with SMTP id v1-20020ac25b01000000b00520107f8375mr3009913lfn.50.1714942448161;
        Sun, 05 May 2024 13:54:08 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id gc4-20020a170906c8c400b00a59b2c5003csm1647485ejb.23.2024.05.05.13.54.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 May 2024 13:54:06 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4196c62bb4eso9506245e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 13:54:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWOiK5fVn1IzdyTgJ+0IBMVf/NgMad9d0dVuLckjFXl3+0PJjFhhiJNXjQeIFot79xkHnj5Ib56ZJ+MNQ/pql+cpNupJtZJNx4Aua0r
X-Received: by 2002:a05:600c:314f:b0:416:88f9:f5ea with SMTP id
 h15-20020a05600c314f00b0041688f9f5eamr6455233wmo.34.1714942445499; Sun, 05
 May 2024 13:54:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405031110.6F47982593@keescook> <20240503211129.679762-2-torvalds@linux-foundation.org>
 <20240503212428.GY2118490@ZenIV> <CAHk-=wjpsTEkHgo1uev3xGJ2bQXYShaRf3GPEqDWNgUuKx0JFw@mail.gmail.com>
 <20240504-wohngebiet-restwert-6c3c94fddbdd@brauner> <CAHk-=wj_Fu1FkMFrjivQ=MGkwkKXZBuh0f4BEhcZHD5WCvHesw@mail.gmail.com>
 <CAHk-=wirxPSQgRV1u7t4qS1t4ED7w7OeehdUSC-LYZXspqa49w@mail.gmail.com>
 <CAHk-=whrSSNYVzTHNFDNGag_xcKuv=RaQUX8+n29kkic39DRuQ@mail.gmail.com>
 <20240505194603.GH2118490@ZenIV> <CAHk-=wipanX2KYbWvO5=5Zv9O3r8kA-tqBid0g3mLTCt_wt8OA@mail.gmail.com>
 <20240505203052.GJ2118490@ZenIV>
In-Reply-To: <20240505203052.GJ2118490@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 5 May 2024 13:53:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=whFg8-WyMbVUGW5c0baurGzqmRtzFLoU-gxtRXq2nVZ+w@mail.gmail.com>
Message-ID: <CAHk-=whFg8-WyMbVUGW5c0baurGzqmRtzFLoU-gxtRXq2nVZ+w@mail.gmail.com>
Subject: Re: [PATCH] epoll: try to be a _bit_ better about file lifetimes
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, keescook@chromium.org, axboe@kernel.dk, 
	christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
	io-uring@vger.kernel.org, jack@suse.cz, laura@labbott.name, 
	linaro-mm-sig@lists.linaro.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	minhquangbui99@gmail.com, sumit.semwal@linaro.org, 
	syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 5 May 2024 at 13:30, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> 0.      special-cased ->f_count rule for ->poll() is a wart and it's
> better to get rid of it.
>
> 1.      fs/eventpoll.c is a steaming pile of shit and I'd be glad to see
> git rm taken to it.  Short of that, by all means, let's grab reference
> in there around the call of vfs_poll() (see (0)).

Agreed on 0/1.

> 2.      having ->poll() instances grab extra references to file passed
> to them is not something that should be encouraged; there's a plenty
> of potential problems, and "caller has it pinned, so we are fine with
> grabbing extra refs" is nowhere near enough to eliminate those.

So it's not clear why you hate it so much, since those extra
references are totally normal in all the other VFS paths.

I mean, they are perhaps not the *common* case, but we have a lot of
random get_file() calls sprinkled around in various places when you
end up passing a file descriptor off to some asynchronous operation
thing.

Yeah, I think most of them tend to be special operations (eg the tty
TIOCCONS ioctl to redirect the console), but it's not like vfs_ioctl()
is *that* different from vfs_poll. Different operation, not somehow
"one is more special than the other".

cachefiles and backing-file does it for regular IO, and drop it at IO
completion - not that different from what dma-buf does. It's in
->read_iter() rather than ->poll(), but again: different operations,
but not "one of them is somehow fundamentally different".

> 3.      dma-buf uses of get_file() are probably safe (epoll shite aside),
> but they do look fishy.  That has nothing to do with epoll.

Now, what dma-buf basically seems to do is to avoid ref-counting its
own fundamental data structure, and replaces that by refcounting the
'struct file' that *points* to it instead.

And it is a bit odd, but it actually makes some amount of sense,
because then what it passes around is that file pointer (and it allows
passing it around from user space *as* that file).

And honestly, if you look at why it then needs to add its refcount to
it all, it actually makes sense.  dma-bufs have this notion of
"fences" that are basically completion points for the asynchronous
DMA. Doing a "poll()" operation will add a note to the fence to get
that wakeup when it's done.

And yes, logically it takes a ref to the "struct dma_buf", but because
of how the lifetime of the dma_buf is associated with the lifetime of
the 'struct file', that then turns into taking a ref on the file.

Unusual? Yes. But not illogical. Not obviously broken. Tying the
lifetime of the dma_buf to the lifetime of a file that is passed along
makes _sense_ for that use.

I'm sure dma-bufs could add another level of refcounting on the
'struct dma_buf' itself, and not make it be 1:1 with the file, but
it's not clear to me what the advantage would really be, or why it
would be wrong to re-use a refcount that is already there.

                 Linus

