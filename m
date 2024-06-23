Return-Path: <linux-kernel+bounces-226385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C989E913D96
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 20:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C962EB211DC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 18:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887271836D2;
	Sun, 23 Jun 2024 18:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rb8G1BgO"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1D014830D
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 18:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719168087; cv=none; b=h1Wnna/r1+xXj2taA4qooyKCTyoaujlKqEUAQFmHVf3US6hKJp7BrvPyJr6u6Qlnz/WZJAfhtg6nKGsnU/vYCST2112ohpUEEMi04IpYfNtYu1mgWh+o2Xvtmhy/qeqBOk8167i/xJFahiBNFLxrb3MBr4s7dHKyLJ29AwdJHgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719168087; c=relaxed/simple;
	bh=gUWxyYGOHpmIygMr2aU1CEMePlDuA1tDMXGdGRh5aCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c20aBHMBEXMdy5LEmFi8yfuD1Twcb75Q5NjwO1Ie1ypTvOBidp+tKOFNQUlLRwECQod1E77KDXQN8GQ+cFsZC75oO7pSxdeOVI7aUxcOBkxG/b13zp1iNlZ1RukJde2WTVPIRNcdF7ODWuXRj9eCYBUOlwpAnOwb+Snng0FMWp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rb8G1BgO; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ec1620a956so42916651fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 11:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719168084; x=1719772884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUWxyYGOHpmIygMr2aU1CEMePlDuA1tDMXGdGRh5aCg=;
        b=Rb8G1BgOd3TJptKvQIzU5iyjhu8VxjUnOpx7MH2d7VpYf74LntmQBb4AEXZmujGLaA
         2CyGFVpW8UJbC6faPtfDVcPexks9qeedborFOvZDCDoTIpc0MGA8bsl1/jHr+Rlfa5kz
         FLKEJ81R4ju8AjOHp3TW1GcnsJitVpeOrFXbcCqQGaTaT5jyO4HRbx/dN86j1Wvc9sEr
         AmASsXUtkaF6KhAqWHTyoa5AQs2oENrVbUMy3vsx/MYpwkPK8nN4LbjFjn81dwt2qOY7
         TOiE8QS9+/yeTNACsWl3XJmhBTGBQz3W8enAPyjWyNxDzeK+vQVJgF/PLRseRQeHbPdv
         ywyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719168084; x=1719772884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUWxyYGOHpmIygMr2aU1CEMePlDuA1tDMXGdGRh5aCg=;
        b=CkiAdN6kcP5NDD3pRuoqN2NJwk3AEBwYkU3IGcGNlg6tkywKrlkNyh6XsuoUO/bJhF
         FCpFisqtihYAkKqhZ4AZZhO+qKvnHIKBhcyUu7gwxMwvKgs8VIBDAEGcKxe7IkRNSO7T
         1QV2PSdS0plP6n8lX0JloG/ILuoiKeXxtCCNuZSosNKcuFCTPP3tP5e5MGU0DQTTyqzW
         mgYJzEa1UocJXZFMya6CpFm30uFXLaANp2rEX09DrCGJSsX8Lwp2AWvD/1EOnNi3y0E1
         hehlnhe3EIekvPqZeSHkQvW2AjC6nb8M7NaJgEDNuCRX+oADBsXnSCsLCrttBW2vip7H
         aTwg==
X-Forwarded-Encrypted: i=1; AJvYcCXLACpLp6W8NBRV9fy7JZgLLo0DhUIJrJSaM6Sbhn6ApDzqmbbfFj9iFc0www7LXIdXAUbwVwYO47p/okpiAiZDx04MX1AI8IzlG7zO
X-Gm-Message-State: AOJu0YzSmcF2++2Ynk59iBMKnkbq4rdLkl0DzBdK63ij9YhvF/k212gn
	W2JUX8gG+i2TaHQHKu6/ne3LrwZjQnxC44o5molWS0JjYJ0ScqZMoOx4rVEhGAqW1HvsEzbYG6T
	WMPQbDIbERcreAANP+98XkFlpq64=
X-Google-Smtp-Source: AGHT+IFjAUSORTSqIPw6GTNqjQYPK6sB+UFv5SCQkYWex0V/BK4KHV0KQnPBQYHTy4B8o2EYgEAKXynzZtyzBg0F4Dc=
X-Received: by 2002:a2e:9996:0:b0:2ec:58e8:d7a2 with SMTP id
 38308e7fff4ca-2ec5b337346mr16708821fa.16.1719168084185; Sun, 23 Jun 2024
 11:41:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202406230912.F6XFIyA6-lkp@intel.com> <CAFULd4YVOwxQ4JDaOdscX_vtJsqJBJ5zhd0RtXXutW=Eqh29Qw@mail.gmail.com>
 <CAHk-=wg1h4w_m=Op1U4JsyDjsvqG0Kw1EOVMQ+=5GX_XytdorQ@mail.gmail.com>
 <CAFULd4YR-VkAOKiS5yxSUYi0YMzY1p=pkYe4dOkgFs+A=9AFFA@mail.gmail.com>
 <CAHk-=wi_KMO_rJ6OCr8mAWBRg-irziM=T9wxGC+J1VVoQb39gw@mail.gmail.com>
 <CAFULd4b43=pTnAMKusJmGCeF1Bk-f6AyeOR8wGM8EieqhuH5WQ@mail.gmail.com> <CAHk-=wgHa_5u71j=Zx4DceTfjaeL2w1RCPPXbpEEL-xCw-J8ew@mail.gmail.com>
In-Reply-To: <CAHk-=wgHa_5u71j=Zx4DceTfjaeL2w1RCPPXbpEEL-xCw-J8ew@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sun, 23 Jun 2024 20:41:18 +0200
Message-ID: <CAFULd4bxS0y1b7XZ1_J3yHF84Ghzoi1OWoZGfrLWvNaygVCWTQ@mail.gmail.com>
Subject: Re: arch/x86/include/asm/cmpxchg_32.h:149:9: error: inline assembly
 requires more registers than available
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 23, 2024 at 8:25=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:

> Ah, good. This is something I'm a bit sensitive about, just because
> there's been so many arguments over it over the years, so now I go
> into "preemptive nuclear mode" when the regression issue comes up.
>
> Sorry.

Also sorry from my side if my disagreement was understood as a
criticism of the kernel development process. I'm totally OK with it
(but ignored patches indeed cause a bit of frustration...).

> > I'm OK with the revert, but it won't fix the underlying problem.
> > Please see the definition of __arch_cmpxchg64_emu - it forces the
> > address to %esi registers in the same way as __arch_try_cmpxchg64_emu.
> > Effectively, the compiler allocates 5 input registers just for the
> > instruction.
>
> Oh, I entirely agree that this is a "random compiler implementation"
> issue, and then the code around it makes all the difference.
>
> > > Now, from having looked a bit at this, I can point you to the
> > > differences introduced by having to have the emulation fallback.
> >
> > Yes, I know this - I also (runtime!) tested the emulation, but with GCC=
 only.
>
> Yeah, crossed emails, I started out just doing the "let's see what the
> config difference is", and only after that realized that I had looked
> at the wrong code for cmpxchg (ie I had looked at the simpler native
> case).
>
> > This can be achieved by implementing atomic64_{and,or,xor} as an
> > outline function.
>
> Yes, but then a lot of the whole point of commit 95ece48165c1 goes
> away, doesn't it?

True, because this commit pushed one of the compilers over the edge.

> Or were you suggesting the out-of-line code only for the emulation
> case? That would work.

I am suggesting simply following the approach of
arch_atomic64_{add,sub}{_return} in atomic64_32.h. These functions are
used extensively in the kernel, and if they didn't cause any problems,
then we can rightfully expect that the new ones also won't. This
approach will relax the register pressure, so we won't expect magic
from the compiler.

I can provide a patch series with the revert and a fix in a couple of
days (I'll be away from the keyboard for a short time).

Uros.

