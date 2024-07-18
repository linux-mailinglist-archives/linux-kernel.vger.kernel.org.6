Return-Path: <linux-kernel+bounces-256616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9399493511A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 19:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E44D2830A7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 17:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E681459FE;
	Thu, 18 Jul 2024 17:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2TxTmCZG"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144B8144D10
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 17:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721322603; cv=none; b=rbsGzLU+YzgTAttTrgI/zcI7nf77xM6owdznJBseexNyr3OFkUlsQqgymanpfemUKYzTRhxB8w2zMMZFyekZlnFS2g3HJC18g9q2m7qSXq+xQsCS0686RWsALAfsej8bxdjxGoY6AaRWsEkoq7E6YF/PbZAYu1K8HUgbO3PTD6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721322603; c=relaxed/simple;
	bh=6nbNmq9keipECaitOCTHHOJ/2SiCOYt7HdwJHw9bbL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJ7XnsmSJ7oHQCl5BXN1CGk4NB99Ww5cAuKGQjruAqxiW8pUTpsiWq15723D7dnmVXrP6c4BkZZe4OKq2KLLVks8qcxFhcWgQzOVr+D8Zb6HyQaEt7TNBoBdbOdiT3gVJU9MsXkfTEOYZ72PpIyZdswTy1RWk6j+sFjWSHbN8xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2TxTmCZG; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42666b89057so2045e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 10:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721322600; x=1721927400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VE1zlo0WYP5fFUwruBkAhVFeTQERu81k99aRGv+J5us=;
        b=2TxTmCZGf48JiUhnNebuMdQmwRvECLCgP1uIGVrNDo9ptXShVA0DbJ7Suqt/cQE5Z/
         /8BCp04kHCqK9nV98crOm72DyQIy8jLvMkvUouKmtbAvRFMc/yMM9sGaGaa26CxESKGm
         yDkQKoVNOAeuQ7NTv/q5lLhFxoVzfirUUgXd1EBALAWIJL9uhsrwEx18pAzDcQTxeo2D
         bCLV+5WASt/+g5xUA3pdofyQHT0UILkZms++fa3+ZuEfQhRJWiPhQm1px2C6IDwNTrO9
         xd82jlmkvtxJpxHAiTo6kJx7N9VtR0TAE4sVfxAbPE6xfxNtOt79Hq991ZsY1qhgOJqA
         a9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721322600; x=1721927400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VE1zlo0WYP5fFUwruBkAhVFeTQERu81k99aRGv+J5us=;
        b=fD4eSfF1ct3Lpv1OL1HBZ9B9XZvCQprJUPnmd0NlmEFKh2l574nPGtZtcPk9YsbOUU
         MS68U5gKaDM8JE5ENcmxoRkQzNzn9gCE6Q4QmhcQ7N9eVc2K5YrWEG85rWAW6DTpg2u7
         6EUERAWJN7r6DkiWXCFk/bIGgor0H88KWxNYtKYjuYs2gMwEv85R2Vb5rU0zYa8JZ8Rk
         BqL3XfmkoIIYLyKQhjUoxmoHx/O4QBHjUuNfPC/JYOlxRxhK+Z8SEG+xJbSUO8yMVZyr
         u8qEpvh/lIDOzsO/6ntU0Yy9m6ea2PTk1qtMAe86Z6euBaWpz5SFbVtHJU8imJWJPOaQ
         Jdog==
X-Forwarded-Encrypted: i=1; AJvYcCXHheIUnnseuFx6t7Gf5Hvmnzx73oXL85RiRgSquPANsMKg66X+nJXyQlcJkBccmvYDxSxIspoir+TDxb66K7CHI6vBu8hSjodtgSOi
X-Gm-Message-State: AOJu0Yy4B+2mmfg2ifWpk5DIOmFQ1EebZ/VbbK6QbdiMZgiUTQ0g6yEN
	9yO4BLd0eks4Kub1B63OrrALSGEZZblYUCbnILZXhKC7pducmnesEhE17cPJZETWD8OAS1Lc9sr
	tvBmL2rHWj5SXs+mkIuYlAw0+64y8kUnVBWs=
X-Google-Smtp-Source: AGHT+IGqGloYtoDbE/cj4acqUh5GhvD1KBfFRWwub7Dz01wOaqAUA8znvrRis2rZfOvQNT79qUteAFFBjkjI5HQKUJg=
X-Received: by 2002:a05:600c:3b23:b0:426:62a2:dfc with SMTP id
 5b1f17b1804b1-427d2a9794emr934485e9.5.1721322600131; Thu, 18 Jul 2024
 10:10:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230926160903.62924-1-masahiroy@kernel.org>
In-Reply-To: <20230926160903.62924-1-masahiroy@kernel.org>
From: John Stultz <jstultz@google.com>
Date: Thu, 18 Jul 2024 10:09:47 -0700
Message-ID: <CANDhNCraQ6UCDNH3s4+YKCWfk4dGjxP_LkZ7WBUnJ_WiKM5u6Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: fix get_user() broken with veneer
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: patches@armlinux.org.uk, linux-kernel@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, Ard Biesheuvel <ardb@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
	Neill Kapron <nkapron@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 9:09=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> The 32-bit ARM kernel stops working if the kernel grows to the point
> where veneers for __get_user_* are created.
>
> AAPCS32 [1] states, "Register r12 (IP) may be used by a linker as a
> scratch register between a routine and any subroutine it calls. It
> can also be used within a routine to hold intermediate values between
> subroutine calls."
>
> However, bl instructions buried within the inline asm are unpredictable
> for compilers; hence, "ip" must be added to the clobber list.
>
> This becomes critical when veneers for __get_user_* are created because
> veneers use the ip register since commit 02e541db0540 ("ARM: 8323/1:
> force linker to use PIC veneers").
>
> [1]: https://github.com/ARM-software/abi-aa/blob/2023Q1/aapcs32/aapcs32.r=
st
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

+ stable@vger.kernel.org
It seems like this (commit 24d3ba0a7b44c1617c27f5045eecc4f34752ab03
upstream) would be a good candidate for -stable?
The issue it fixes can manifest in lots of very strange ways, so it
would be good to avoid others getting tripped up by it on -stable
branches.

(Apologies for being a bit verbose in the following, I've included a
lot of details and breadcrumbs so others might find this if they run
into the same issues.)

I was recently looking into an arm32 issue, and found getting a custom
built kernel consistently working in qemu-system-arm to bisect issues
in the range of 5.15-6.6 was a bit difficult, as I would hit a couple
different odd errors.

For 5.15 I was seeing systemd fail to start in a fairly opaque way:
  starting systemd-udevd.service - Rule-based Manager for Device
Events and Files.
  systemd-udevd.service: Main process exited, code=3Dexited, status=3D1/FAI=
LURE
  systemd-udevd.service: Failed with result 'exit-code'.
  Failed to start systemd-udevd.service - Rule-based Manager for
Device Events and Files.

But further looking through the logs I found:
  systemd[1]: Failed to open netlink: Operation not permitted

Despite lots of digging to try to understand what was going wrong, the
one thing that worked was switching to CONFIG_CC_OPTIMIZE_FOR_SIZE
(which I only tried as I came across this old thread:
https://lists.yoctoproject.org/g/linux-yocto/message/8035 ), this
seemed very suspicious, but I didn't have a lot of time to dig
further.

That resolved things until ~6.1, where I started seeing crashes at init:
[   16.982562] Run /init as init process
[   16.989311] Failed to execute /init (error -22)
[   16.990017] Run /sbin/init as init process
[   16.994737] Starting init: /sbin/init exists but couldn't execute
it (error -22)

That I bisected that failure down to being supposedly caused by commit
5750121ae738 ("kbuild: list sub-directories in ./Kbuild")
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D5750121ae7382ebac8d47ce6d68012d6cd1d7926

And searching around that commit luckily led me to this change, which
finally seems to resolve the different issues I saw for 6.6, 6.1 and
5.15!

Now, In my rush to get something booting with qemu, I started with the
debian config but disabled modules, and didn't put much time into
getting rid of config options or drivers I wouldn't need. So the
kernel is pretty large. So maybe not super common, but I definitely
wouldn't want others to have to go down this debugging rabbit hole.

thanks
-john

