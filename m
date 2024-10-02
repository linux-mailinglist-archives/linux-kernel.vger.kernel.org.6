Return-Path: <linux-kernel+bounces-347653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC53B98D8F6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E065286204
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5340D1D151A;
	Wed,  2 Oct 2024 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aYu9Idr5"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A6E1D1726
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 14:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877728; cv=none; b=u+n4yFqz8KVSBe0n1etc71NAh/VWrCyhtZKZQEckXLlc+9W7xb4mFFGhNeU7FTL9C01iSHGhcW93ajubXq8zItVPUutcs0UD9tW0LRnYea7cN/1KBJ2RGQYvK1uKZ93Tq9Z7MuMhH5IYHYIgb2Zoew9y9cR2CqQ+63FJJNXtDr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877728; c=relaxed/simple;
	bh=7BrTsAKh4MFpdR9YBwkIuwHmvrRp75lxEmda2w5qUJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=se9WTTkytTX+n5CGDgsr3WnYxsqbk0t0ajEccqe08xFlKzMfTlM1re8/LOffXtI+eTI1pcjnWgWRhDFXkWPnhm+4PBM0GuC70EcU6DIMUjazrWFkyMgJaGiL4teaDOCp5UThLPt+MZ7KnGLuB+ubJQYta2rK6EULyNEjMR4oimE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aYu9Idr5; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6dde476d3dfso52738907b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 07:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727877726; x=1728482526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hU3AfRDfh1aF4aXzKGaV2H7rkfLnCR1DkDAZ1hTclEs=;
        b=aYu9Idr5zbC5b3bJ1ZQi2tvc4FesDTQ+TiVfegtIK5lwv9ats943pDuE8KXP71d2Qr
         gyCSwa0qoqxIsApW2HOR+Dm7WwnEd5ZBkGPcSlDJJfJeH1vKHWZQgDM5IpxOh4HwV3dQ
         hP3tXsBZTyO/0kXnMZXAaggCXP+xlZjpG5tuvQ/Wj9LN1bQbHaZIxzlI/e6bGtNeBpqa
         ooeuqo132uEUWsjg+nqCh4UVfRH6zq0EJCR8gfMpHVzo00R6bwd1CXMjOAsx/IwbUmVJ
         ZQ9t4obSuU5zmA54a3OF/jh6gf+iT29jiKJun2pX0rEM+U8Kjf3wk9h4x5x7pYGC5r8t
         CDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727877726; x=1728482526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hU3AfRDfh1aF4aXzKGaV2H7rkfLnCR1DkDAZ1hTclEs=;
        b=OVF/wepQL/ysF0kNHkPvH96lbBWzAClUh/LkxYq40o1C3RuvTfUkzV3H3utrIGafOg
         w6LA0x262tYaU1xkvKx7k0cY1nyCq7YI/oH+NEIfZuAhKiP79PD+pX4B+vCuxXvfpWpu
         5Z6JE4+xmJlHYSFxuZ6AIZE4pkH9cbjk/l63I7K3TcOrjBznzKVCiwgHvWDz4NGY+nSf
         tt/LytqvCxM0dzBph8Gop6heg2RuEt45y1w3v15kAs6EC8EZ8jQpDNmsTNcIqQ1jgbqc
         ipnSoQz3eCC/JS+bnku4xbVl0Ng5JXCB9T2BGHtybxeOh6bfZPZCQAXUraFlzxQcYopw
         5Juw==
X-Forwarded-Encrypted: i=1; AJvYcCWjVb3no0i3lMS3eIsPVVSbGHBZOwVvZ7MG/4KREIcgv/hlVJ7juhRSAXKMqYEshomEBeeag95JQZo/MBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YylpG5sO+MNxfaoR6HiVC6x5F/4BNUIRTKoVPrFOEAeUvvoTNjZ
	yqf9tUMZd83/yTZQQx0Wq+aZkWmedzzi94vV8Cd8BidCtUDG9CFW4zZ4nfOZoD1/QP9jVDoZIAz
	uCM2wr0uNE5IGrSvn3XqMBwwH/9KbmpyTF/5x
X-Google-Smtp-Source: AGHT+IHxMeZ2QMGkwVqefxWia7dXDdxuFAW9bJYl6/vLiZMsrnWrsRP8Q/j2Vva+3XWYlULqu0GU9E+R8/EoarfWMWE=
X-Received: by 2002:a05:690c:4d01:b0:6db:d7c9:c97b with SMTP id
 00721157ae682-6e2a2e3672fmr30677237b3.40.1727877725970; Wed, 02 Oct 2024
 07:02:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp>
 <877cavdgsu.fsf@trenco.lwn.net> <CAHC9VhRnTrjP3kNXMmzsK4oZL7WD+uH0OuXszEPgTc5YoT5dew@mail.gmail.com>
 <CAHk-=wjLdoBcY-r64oBbKXo3hSEr5AawrP_5GSFQ4NEbCNt4Kg@mail.gmail.com>
 <CAHC9VhS_8JtU0KQyy3rEGt0CQ_XMQFt2Kic-bz-Qd=SMjeWe4Q@mail.gmail.com> <19e29693-718c-4667-ab40-948718bcc6f5@I-love.SAKURA.ne.jp>
In-Reply-To: <19e29693-718c-4667-ab40-948718bcc6f5@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 2 Oct 2024 10:01:55 -0400
Message-ID: <CAHC9VhT3yfahvwSVqGHyQq5SDpf8QRjDoEttoyD0zSau41Sb4Q@mail.gmail.com>
Subject: Re: [GIT PULL] tomoyo update for v6.12
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	LKML <linux-kernel@vger.kernel.org>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 11:32=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2024/10/02 3:22, Paul Moore wrote:
> > Starting tomorrow when I'm reliably back in front of computer I'll
> > sort this out with the rest of the LSM folks.  Unless something
> > unexpected comes up in the discussion I'll send you a revert later
> > this week.
>
> What I am asking LSM framework is as simple as
> https://lkml.kernel.org/r/caafb609-8bef-4840-a080-81537356fc60@I-love.SAK=
URA.ne.jp .

You mention that Linux hasn't supported loadable LSMs since v2.6.23
when SELinux was the only LSM implementation in the upstream Linux
kernel.  In the (almost) 17 years since then we've seen a number of
new LSMs introduced and merged into the upstream kernel, each having a
voice as to how the LSM framework is managed.

> Now that built-in LSM modules started using __ro_after_init static calls,=
 !built-in
> LSM modules can start using !__ro_after_init linked list without affectin=
g built-in
> LSM modules. I can't understand why Paul does not like it.

A *lot* of effort has gone into both hardening and improving the
performance of the LSM framework.  I'm loath to introduce anything
which would take away from those gains, especially if it is only done
to satisfy out-of-tree LSMs, or users who don't agree with their
distro kernel's build-time configuration.

--
paul-moore.com

