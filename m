Return-Path: <linux-kernel+bounces-169123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABB48BC36F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 22:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FBCF2821B5
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 20:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265CC6EB51;
	Sun,  5 May 2024 20:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="M0/5+J/R"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ABF22611
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 20:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714939739; cv=none; b=piHJitk1awgPfrnDSiUbjcI5gXHv2PoE3ciPVFJYEQV+Sg/tsUqSq5TrjpZAJVHZMzDfkkrCj/76EmtBFvl987OklPSzJ9n+k9bp+rPNh2sMSM9qaitWfAP0meGcIlqbjfodAnwyzsJSSk4KPQ6IFoFonR4F+0v0QAFrdLKCE8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714939739; c=relaxed/simple;
	bh=wWs9rnVSNPVg9flRopfXNHpvrjJqY4eLW8+/eL6ffhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nebOfSiu/mGbcfLviMOViv1JbQ2exccuHmCdKiVzHVuPrCKqu0dEMNQ9SIpYLkup5z1rW8FzguztPXALF6V8M2dnlkezmpIoK/e6oF6pB+QLqz0ABE9IZ4yb+jAC78or/YzRSqCBcHRWPdP/aNTaOJ9T5qycaAiiHzDXFURpshA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=M0/5+J/R; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59ad344f7dso195146166b.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 13:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714939735; x=1715544535; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EHEpVJVmF2eGrGo8U8tgs6RR34ElBujEmi1VC80nQxg=;
        b=M0/5+J/RYH984EJ9cayE3N7mzUbx0nVaO9CJ2Ku52bXfoF1ATmmyuHnVFML1Z+wjiR
         qgrlDmIin6sNR6lgqxs2vjjN3YcnrUfNLD+ujG1vbZw275Tw2uzUrx4N5imOJocxdvv8
         q4Ju8BzdmVOliOzhwMCPQFbDad4cOuBq01iUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714939735; x=1715544535;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EHEpVJVmF2eGrGo8U8tgs6RR34ElBujEmi1VC80nQxg=;
        b=Y2vnzWxK17mtRNa0266FjYRRbrKiRDItVFnQbAA/RPbzUg77oVjsDIpJYnDpB5W+xX
         O6CbbfLpW+mZVGLJ9QZ/1Y4wyL5UsR+w3NuKYdm2uzR3uq0jvmx4/jtpH8g+zllNb+my
         u07mAKhxDc17TX9HSL4QV9buLj2yFSNJZxqkuITlr5Mi+3POtpRO57Ho10pLQ9bgqeHO
         s21JCm4S9W9fxcaIciAbC79n+w2r8XyiaKv3c7OMBggQltwrrSicwm9h28RA7jzs+Jdu
         I51Xkoj6q4yeZa+G8LTHhg/+GiH4LE2TaIsqiBL1axGlPNPVPBgJuNgM4RjbFrRXEHMQ
         LR3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVVboFw25JFLCXsyJGkJqiZ9x3mL501lusz949bsGI9w5v0E62V1daytH99sgWMDXBTux6KxNrXmKVZuCzmIeHVs6Vu7+3PxRq10gmd
X-Gm-Message-State: AOJu0YwINuV74S1cyK7qTcFlb+w5TimZNDzK9GJlg3ahEo6ZuvnsoeQ+
	ys6TQeJUjocU+aalHkClNq8wvjsDrBC4EW2PE39D2jjnm+RfLrMNqvsEXzwvN5W84spm/BKowia
	Rdp8Txw==
X-Google-Smtp-Source: AGHT+IGvKu9gC8Uld+PZup9YumA8JmjqGWF0aG2ALU5/IAK1fTwnmr2b3A2zGmchY3uBvXBVpa7BhQ==
X-Received: by 2002:a17:907:20b4:b0:a59:8786:3850 with SMTP id pw20-20020a17090720b400b00a5987863850mr4874270ejb.72.1714939735107;
        Sun, 05 May 2024 13:08:55 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id rn9-20020a170906d92900b00a59a229564fsm2450882ejb.108.2024.05.05.13.08.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 May 2024 13:08:54 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41ba0bb5837so8724605e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 13:08:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgmxkdRVJjdaKoUi3cH1Zw5aL7nC5TKFCtGB/sXv0LtDscRjYXpy9WsgCvRNQbO4cR8mhlNhLHb0prCwV1+VrW8RrN5kZEIpTNgKLV
X-Received: by 2002:a05:6512:202c:b0:518:c057:6ab1 with SMTP id
 s12-20020a056512202c00b00518c0576ab1mr4629192lfs.66.1714939404009; Sun, 05
 May 2024 13:03:24 -0700 (PDT)
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
 <CAHk-=whrSSNYVzTHNFDNGag_xcKuv=RaQUX8+n29kkic39DRuQ@mail.gmail.com> <20240505194603.GH2118490@ZenIV>
In-Reply-To: <20240505194603.GH2118490@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 5 May 2024 13:03:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wipanX2KYbWvO5=5Zv9O3r8kA-tqBid0g3mLTCt_wt8OA@mail.gmail.com>
Message-ID: <CAHk-=wipanX2KYbWvO5=5Zv9O3r8kA-tqBid0g3mLTCt_wt8OA@mail.gmail.com>
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

On Sun, 5 May 2024 at 12:46, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> I've no problem with having epoll grab a reference, but if we make that
> a universal requirement ->poll() instances can rely upon,

Al, we're note "making that a requirement".

It always has been.

Otgherwise, the docs should have shouted out DAMN LOUDLY that you
can't rely on all the normal refcounting of 'struct file' THAT EVERY
SINGLE NORMAL VFS FUNCTION CAN.

Lookie herte: epoll is unimportant and irrelevant garbage compared to
something fundamental like "read()", and what does read() do?

It does this:

        struct fd f = fdget_pos(fd);

        if (f.file) {
                ...

which is being DAMN CAREFUL to make sure that the file has the proper
refcounts before it then calls "vfs_read()". There's a lot of very
careful and subtle code in fdget_pos() to make this all proper, and
that even if the file is closed by another thread concurrently, we
*always* have a refcount to it, and it's always live over the whole
'vfs_read()' sequence.

'vfs_poll()' is NOT DIFFERENT in this regard. Not at all.

Now, you have two choices that are intellectually honest:

 - admit that epoll() - which is a hell of a lot less important -
should spend a small fraction of that effort on making its vfs_poll()
use sane

 - say that all this fdget_pos() care is uncalled for in the read()
path, and we should make all the filesystem .read() functions be aware
that the file pointer they get may be garbage, and they should use
get_file_active() to make sure every 'struct file *' use they have is
safe?

because if your choice is that "epoll can do whatever the f*&k it
wants", then it's in clear violation of all the effort we go to in a
MUCH MORE IMPORTANT code path, and is clearly not consistent or
logical.

Neither you nor Christian have explained why you think it's ok for
that epoll() garbage to magically violate all our regular rules.

Your claim that those regular rules are some new conditional
requirement that we'd be imposing. NO. They are the rules that
*anybody* who gets a 'struct file *' pointer should always be able to
rely on by default: it's damn well a ref-counted thing, and the caller
holds the refcount.

The exceptional case is exactly the other way around: if you do random
crap with unrefcounted poitners, it's *your* problem, and *you* are
the one who has to be careful. Not some unrelated poor driver that
didn't know about your f*&k-up.

Dammit, epoll is CLEARLY BUGGY. It's passing off random kernel
pointers without holding a refcount to them. THAT'S A BUG.

And fixing that bug is *not* somehow changing existing rules as you
are trying to claim. No. It's just fixing a bug.

So stop claiming that this is some "new requirement". It is absolutely
nothing of the sort. epoll() actively MISUSED file pointer, because
file pointers are fundamentally refcounted (as are pretty much all
sane kernel interfaces).

                Linus

