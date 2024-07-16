Return-Path: <linux-kernel+bounces-254418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 967969332FC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F0A0284715
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AE019FA72;
	Tue, 16 Jul 2024 20:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c4dSD8Rw"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE771CD20
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 20:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721162100; cv=none; b=ALpkdbQGoWQd0dD6N55lvribpYG633SCtrImHic5IPJirygadAVojIdq32+OrBLxy0PPijHHsBiAOfD1E/1pNnbgdOqiy19FTYuTM9yyNFOiBpPFAaTBgul4j4wZ3tmWxoW1CZd/IRE8mm4D4U+7/qKakZqFdYMh3DRzHJXfMTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721162100; c=relaxed/simple;
	bh=lT1tp2SfIPDrjoq6pT0zVzeBNkLVmlkERap9uJ0MSIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ALzX+XoX4jM9WLGlzeGB/pCDnibJzejIFYWKTaHmEgVrj5QEFvZFYdQjlMb30vfd+uRkpDgdtysJpmsj0kK8DHd3M2CTeAGVEaNrVNwa+dEOB7eZD9aS+bK1du+Ltf8mJWxs7kOF12Qw8Uh+FpWDKg7iAm+1QwUZg8HkjmFkUPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=c4dSD8Rw; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2eeb1ba040aso80521211fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721162097; x=1721766897; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V+OfEIDNMP4T2UfyjkE4klMf3HvL7XLJvT+HBJZwot8=;
        b=c4dSD8Rwh+tMq+mcRbpPa0plKK4LAXLNm+B040Q9OnNrepMcAiT7H0K+LcJkr0yDyc
         TeAuOttejfw14cmYg22qYmV+WGoCCRMHOqhX1yZHgSO8av0yZa+ge8J5ZRtXBEI0c1z0
         dzvMPJTCG2rFat6BWMjDWJR6BbdgiyfS9AHnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721162097; x=1721766897;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V+OfEIDNMP4T2UfyjkE4klMf3HvL7XLJvT+HBJZwot8=;
        b=g63IDYHjYhZT7K3YaPEFapoyQgb1CCS957vOzrfxmmBexO8fsX7dWVb3EMQvAgStvE
         R1+3zWdjBDY6L7sz2Aacf1C1b/OU1KDYz6LdAxqjZNcuxLppbg8IDC2eNjqiKntFwzUb
         NzvlYItDm2sXC6rMojAFGWxMATDdGXr3PvuD4heohOCi1COb7P2PsSOuWdxvHseHAu3E
         w9Ffi8bmaItqpYlV75u+ThNIJCfm3cxATMh16J5ZfnWaw8RokNVrj0l6jfh9Avbf8Kho
         OjM9ncmmukox84HrO3bRCR1xrzV8/sgrhedb2vYXxRLlW3CHrznab0z0A5BPI2mOgPlN
         eP9A==
X-Forwarded-Encrypted: i=1; AJvYcCXZUn7dgzdmuWoFPplCGVvxp1F74qbRpZ+EDu1PZ+JGCjylXqPt15tOwhqVMLNuvMwVQJOr9dL7oFP44QrHu7si9JeJIdzKT3851LKL
X-Gm-Message-State: AOJu0YxlOdNj+6FCiGLh41WL+eMwqCYhkPuUlQRIezfOm2ZWJXwrF6fO
	6rhNzDXcbs1s/KOu5FRJQhVHigxh9suats1eQDNBcgKorJaB37zkvKB7ah/KHh9Np48TSD2Qjun
	uSn3wKQ==
X-Google-Smtp-Source: AGHT+IGL3ImUVZXKAuseZxiRmuWSdDqH9i8BUTDp1Y0znJe0JogxxqS276xb55y2EPowDd658n+/FQ==
X-Received: by 2002:a2e:731a:0:b0:2ec:51b5:27bc with SMTP id 38308e7fff4ca-2eef419d7a6mr21965231fa.21.1721162096850;
        Tue, 16 Jul 2024 13:34:56 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2eee17ad2c3sm12817001fa.46.2024.07.16.13.34.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 13:34:56 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52e99060b0dso6410368e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:34:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQc61ZX2sRBhtdwBMFauwwqtizMrXTI2tcrytvNeodupVLoWmyhy9Dtia8VnOTTZpVCOg2OyLYk8As+N6uYin5SAnwvVVQWlOFSh9u
X-Received: by 2002:a05:6512:1281:b0:52c:d5b3:1a6a with SMTP id
 2adb3069b0e04-52edf019226mr2346130e87.28.1721162095855; Tue, 16 Jul 2024
 13:34:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fe3126a0-7c32-426a-9997-77d76ade5179@app.fastmail.com>
 <1df9dda1-1f40-4e13-b79b-350690295ab5@app.fastmail.com> <CAHk-=wg+38EHPKGou1MqXwAAXC30cM8sMgZAGnZ7TcFO4L9J2w@mail.gmail.com>
 <CACMJSetbuZ4u64fksB26AxMxYpiB2_i5=NJefDW_aN_-aHd62g@mail.gmail.com>
In-Reply-To: <CACMJSetbuZ4u64fksB26AxMxYpiB2_i5=NJefDW_aN_-aHd62g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Jul 2024 13:34:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiqETvfxW_mG6++9uX4tY5gYbqqXsMURDw1nQy0q0qohw@mail.gmail.com>
Message-ID: <CAHk-=wiqETvfxW_mG6++9uX4tY5gYbqqXsMURDw1nQy0q0qohw@mail.gmail.com>
Subject: Re: [GIT PULL 1/4] soc: driver updates for 6.11
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, soc@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 13:16, Bartosz Golaszewski
<bartosz.golaszewski@linaro.org> wrote:
>
> TBH it never occurred to me to test pure `make config`. I use `make
> menuconfig` almost exclusively and never noticed this issue for that
> reason.

I use "make oldconfig" for every single machine I boot, because why wouldn't I?

Isn't that what everybody does?

I'm surprised that anybody would re-make their config from scratch
every time, or use some GUI tool.

But yes, I'm also perhaps a bit odd in that I do a *lot* of rebooting
on several machines, and I do it with all these things that come from
outside.

So I see all those cases where random developers added new Kconfig
options, and then I have to go look at *why* it's asking me for some
new driver or whatever, when my hardware hasn't changed.

If I see anything that doesn't default to "n", it immediately raises
my hackles. Why is somebody trying to push new code on my machine that
worked just fine without it?

And if I see the same question repeated multiple times (in just
slightly different guises) for a new feature, I get annoyed.

              Linus

