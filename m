Return-Path: <linux-kernel+bounces-169063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 228538BC292
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 18:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BCB528184B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 16:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19ABA3FBB7;
	Sun,  5 May 2024 16:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Jh0m25dd"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9DF26AFC
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 16:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714927588; cv=none; b=cXxO/EUu/U2TndvjHHQhdkUuMsZcKHvdVnWkcb0nRM/Y1653FIWSgtYYsyh8GOtbHgnuuH3K4UdcNJA1M828NpCfs8T79vZdIgSl5ng94Z7e+Oh27eOlmhNXzVEyIGyJ9S+c6cp+EwGZjcjyNyAhUn7i7zpAxMc+1kcCsmyFs4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714927588; c=relaxed/simple;
	bh=CLhNByDrSyy3KlkeokG4swipYxw1p9LkQ6WM4wj072Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ui1HaqqxnTt3u3uHJN6zWMlVxb/WyRtHrw665z5DlaaS4sm1g+KF7GaUqyHYM7iioNItGzjp8H4s3Qke3wxS3CzYZ7CXCsVJbaC4xGL/+6rFBJAY+qZrQJTD88VnVsPTQJkaaNAIX2e+gAJIvqj4y/4BOleMf6EEKdGXPWXCF/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Jh0m25dd; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d8a2cbe1baso14355261fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 09:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714927584; x=1715532384; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aYdtp3YANTth8Vi9S+yHKBJaPcPwhcLOgY9vMAI/QdY=;
        b=Jh0m25ddNdP2B2AMRer6g2SsW4aWlFV4wvbACB4nQ9lt2L9qHjX30wG6XAmXRJqb9b
         cnDKyodeqsI4AtByabWH8SPehOzuKTxu659W1aKn8zxvej/pit6U6xPJg7vIiRNCPxJT
         Pmhip1fNYVkrmjHVLDxwcOUHdbIpck4jh1lVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714927584; x=1715532384;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aYdtp3YANTth8Vi9S+yHKBJaPcPwhcLOgY9vMAI/QdY=;
        b=P0UPvhZxOrJD9dhxSex97DYSPKF87b5VP4vQO5RhsfpFwxJi/FB86+bZtT138FDSHE
         5c/GR037gjB+LuV3FFqvi+PkRskljCigm8tKrQ51rcj9GdPtpJ0tI/IWWeSEsnhbeszz
         RwNLoMtuNrGgpvD5wU0uFDu1OH3WoIrmlarIvUWWZ8mUCWE6E1vR3Dn45/U1OZK2a4qW
         u3qHHu8eGcOIUdvTaWhSBYAyfCWsZyl3/C+xRlb5Pj1g42SDg5P9S8JvDC5LlOdtpeBb
         l6AUBN2rZ9j3dVDdUY+h2uxOt5dMAsJN5wyK6HSQhHQ/DyxMufBnlgrVpzw2qjHuJrpa
         jvFw==
X-Forwarded-Encrypted: i=1; AJvYcCW4Da6jawq0oi5uPTmLC9ELlzAY1owPEPeABg88mhNGeAtlLycimwksH7MNeXE9Pyp2AoN9U5d5Mx1NH+2wr4cZ26atayFrdg4y5smk
X-Gm-Message-State: AOJu0Yx3urAZnzVdULbLD5WIB02n2/ciLalFc5UNmKaFtfCMJRPJWceC
	LFBjgHdIwm1JOZMaeuZAUDh74kEg/99wvhbmtMHLpmZ09aj3hB5gh1DWK8WuMTMo81Tb1cMHtXY
	2Kv/1Bw==
X-Google-Smtp-Source: AGHT+IH9iEJtWKYh3Qw/ZQsySKIQ9iveTfcgBDFx0ShrVtrkg4KMDJ7cRs2jaG73c7lUCQ1EVEyxDA==
X-Received: by 2002:a05:6512:2024:b0:51d:1d42:3eef with SMTP id s4-20020a056512202400b0051d1d423eefmr6568478lfs.29.1714927584187;
        Sun, 05 May 2024 09:46:24 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id rs21-20020a170907037500b00a59b259e2ffsm1471842ejb.93.2024.05.05.09.46.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 May 2024 09:46:23 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a52223e004dso220762266b.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 09:46:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW6rJJBCaBodS10LFnYkI+y0UfMa/VrSJA9DdktU92Y+Q6Vl0UVHEY6zCU2hCSF7hZN1xQP5lkTbgpxrW6/0wozbNVS1JcbERglBe2u
X-Received: by 2002:a17:907:3f9a:b0:a59:c5c2:a31c with SMTP id
 hr26-20020a1709073f9a00b00a59c5c2a31cmr2077374ejc.33.1714927582181; Sun, 05
 May 2024 09:46:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405031110.6F47982593@keescook> <20240503211129.679762-2-torvalds@linux-foundation.org>
 <20240503212428.GY2118490@ZenIV> <CAHk-=wjpsTEkHgo1uev3xGJ2bQXYShaRf3GPEqDWNgUuKx0JFw@mail.gmail.com>
 <20240504-wohngebiet-restwert-6c3c94fddbdd@brauner> <CAHk-=wj_Fu1FkMFrjivQ=MGkwkKXZBuh0f4BEhcZHD5WCvHesw@mail.gmail.com>
 <CAHk-=wirxPSQgRV1u7t4qS1t4ED7w7OeehdUSC-LYZXspqa49w@mail.gmail.com> <20240505-gelehnt-anfahren-8250b487da2c@brauner>
In-Reply-To: <20240505-gelehnt-anfahren-8250b487da2c@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 5 May 2024 09:46:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgMzzfPwKc=8yBdXwSkxoZMZroTCiLZTYESYD3BC_7rhQ@mail.gmail.com>
Message-ID: <CAHk-=wgMzzfPwKc=8yBdXwSkxoZMZroTCiLZTYESYD3BC_7rhQ@mail.gmail.com>
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

On Sun, 5 May 2024 at 03:50, Christian Brauner <brauner@kernel.org> wrote:
>
> And I agree with you that for some instances it's valid to take another
> reference to a file from f_op->poll() but then they need to use
> get_file_active() imho and simply handle the case where f_count is zero.

I think this is

 (a) practically impossible to find (since most f_count updates are in
various random helpers)

 (b) not tenable in the first place, since *EVERYBODY* does a f_count
update as part of the bog-standard pollwait

So (b) means that the notion of "warn if somebody increments f_count
from zero" is broken to begin with - but it's doubly broken because it
wouldn't find anything *anyway*, since this never happens in any
normal situation.

And (a) means that any non-automatic finding of this is practically impossible.

> And we need to document that in Documentation/filesystems/file.rst or
> locking.rst.

WHY?

Why cannot you and Al just admit that the problem is in epoll. Always
has been, always will be.

The fact is, it's not dma-buf that is violating any rules. It's epoll.
It's calling out to random driver functions with a file pointer that
is no longer valid.

It really is that simple.

I don't see why you are arguing for "unknown number of drivers - we
know at least *one* - have to be fixed for a bug that is in epoll".

If it was *easy* to fix, and if it was *easy* to validate, then  sure.
But that just isn't the case.

In contrast, in epoll it's *trivial* to fix the one case where it does
a VFS call-out, and just say "you have to follow the rules".

So explain to me again why you want to mess up the driver interface
and everybody who has a '.poll()' function, and not just fix the ONE
clearly buggy piece of code.

Because dammit,. epoll is clearly buggy. It's not enough to say "the
file allocation isn't going away", and claim that that means that it's
not buggy - when the file IS NO LONGER VALID!

                      Linus

