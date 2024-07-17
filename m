Return-Path: <linux-kernel+bounces-255529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1A99341CF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA6A01F2283C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5045183079;
	Wed, 17 Jul 2024 18:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AluEkjKR"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8861822E1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 18:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721239549; cv=none; b=k/sxAEq0bFSTyqDtH17koifvgk1G6SYXvoEMwgS04aJLXLy/K09P0Uewb5rLa0ORwdsMqq9ofYWim+HQYTqr8bpL2V929rHsRr6AuXWIiY6i+1tY+AyaYQM14NHAxRypOebprjOwkBwfLyO0FH7PeNv/ippsUiIiTttXMWtGyPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721239549; c=relaxed/simple;
	bh=EcbaqaLncNt5/+ldvNun3H3cqM4FhEED9qsUEKX0xf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfbEZZtD1NA1EWEqhZcblk+iJjjNb3LBUAbYy7wEe5Dg7FXXiM0Q2S/9NTD/D7143Bo3NQM0fgq3EOf45lOZFx6avPxYcLDeN1ET/DDxVBG3zzF84bMPziEjbQgyc4LPIt+ZDHY7zlkFWgJ2IakNP2dm3uWl3EtbaT19F37aNhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AluEkjKR; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2eea8ea8bb0so1229601fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 11:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721239545; x=1721844345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcbaqaLncNt5/+ldvNun3H3cqM4FhEED9qsUEKX0xf8=;
        b=AluEkjKRyBp9OBpRnAu7adluTpuIbylOMPvcHsJALuXuJou0MfT3Dls7+xg1yTJIrZ
         +j4suVjjMdNeLFIFNbFCDNz4Yt337buSfpbA3a4alLFZXEqKsV/CIl/0B7RcuWv6qdg6
         76K9Z93c76YoX318syjkwcgrwg3bICRtk7Lw2gtkakbdwEax0eD/GHxiWWI4PJ+arquH
         nvAl2qYhSAC+WvFwUcmMKJpupna/GLIuufIdrBTP3aTND8XWd6cl+Gbc1Ign0zbwXdtq
         9apdkQ7/ZMi5TN+DL5hhU+V2am2B9GqL/K1eDl3IlXH7Vmq+lWalc0u1jk+H9HbG5BCi
         PC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721239545; x=1721844345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcbaqaLncNt5/+ldvNun3H3cqM4FhEED9qsUEKX0xf8=;
        b=OgoM8gxinZLzmAmAOIJOsFTOZXbUAJ4wVzr7jxmkCuLjJGqYuxooGo9GSvgk9qZi2X
         w2iI7zu8YqVMrz9i+vIqeFrAT35CN7ia0EbjqAynIMU88DWaQhfA/WtutI2hlwO1ZNoH
         GkDf9HQHPEuC8eNvnnCklA+y3PIadNAfTSvHEdLY0tIsNFP7WQG9A1mYkgyIMH375pnK
         OKdV7M1pB4RlpcY78toMcUiZdymEi5B24ur3AdUxLY4rE/PLlOP4RwQ6vpONcKIgrly8
         5w+mnI+H7w5LNTgtHIJVY1cp9VS93nt9lT8vNaJWfyZYww+rycDdtE2EgVKpX/NltvXw
         M9/A==
X-Forwarded-Encrypted: i=1; AJvYcCXlVlcIQullz/RoXViK2Vaf0RM0Y42Mi1Rl0YNen2IfYrxtWh/GY5rXjwi0YTyER8JNUNfx4fFOBX0e+NbNLzVzTy+jf3CZLf/OJK/n
X-Gm-Message-State: AOJu0Yyq6qlnLD7xrAy8IGEhC3FxB4taXPRAKXf1k1DlauUCfXMFwoAx
	+k+El+l3XQOMyA+CgV/2QgoJEUddHzWgT4lgpYVWOUGNdiyEUlsNZuaV561t0X9nxsJp8jWb2jw
	n8cizpffjhy5igAwB37y6VnKJeYgIscZKLBlA
X-Google-Smtp-Source: AGHT+IHmEPpkW9BMRf7R+mnkbP964r6rm53YMQ2kLWJrWHw4ELd3YcPcVXt2ZFtW89ezovDBD1g4Tm5CJK5P3Fnz80o=
X-Received: by 2002:a2e:9a87:0:b0:2ee:8566:32cb with SMTP id
 38308e7fff4ca-2ef05c73758mr1514341fa.16.1721239544904; Wed, 17 Jul 2024
 11:05:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706022523.1104080-1-flintglass@gmail.com>
 <CAKEwX=NL1gOe9k5+JB8Q-UAoZ4ie8SBGg7XTjaqM7j4-hiHv=A@mail.gmail.com>
 <CAPpoddefXD1RAjyW2+X_ankGYNpQgY0Y0+xd1yOFgCc_egaX8A@mail.gmail.com>
 <CAJD7tkYnBw-QiGXTb4BPScuS1VePBkuRx1qG8p92zN9TeD+gKg@mail.gmail.com> <CAKEwX=OPDkwnSno-8r9AsOpmzkZ90SzeX02xz0eDTqbL2_QL2g@mail.gmail.com>
In-Reply-To: <CAKEwX=OPDkwnSno-8r9AsOpmzkZ90SzeX02xz0eDTqbL2_QL2g@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 17 Jul 2024 11:05:06 -0700
Message-ID: <CAJD7tkapE+qSmjFXnLBNamMvn3Lxbx=yvDF3gXW_qba45WU1tA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] mm: zswap: global shrinker fix and proactive shrink
To: Nhat Pham <nphamcs@gmail.com>
Cc: Takero Funaki <flintglass@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 10:49=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> On Tue, Jul 16, 2024 at 7:53=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > [..]
> > >
> > > > My concern is that we are knowingly (and perhaps unnecessarily)
> > > > creating an LRU inversion here - preferring swapping out the reject=
ed
> > > > pages over the colder pages in the zswap pool. Shouldn't it be the
> > > > other way around? For instance, can we spiral into the following
> > > > scenario:
> > > >
> > > > 1. zswap pool becomes full.
> > > > 2. Memory is still tight, so anonymous memory will be reclaimed. zs=
wap
> > > > keeps rejecting incoming pages, and putting a hold on the global
> > > > shrinker.
> > > > 3. The pages that are swapped out are warmer than the ones stored i=
n
> > > > the zswap pool, so they will be more likely to be swapped in (which=
,
> > > > IIUC, will also further delay the global shrinker).
> > > >
> > > > and the cycle keeps going on and on?
> > >
> > > I agree this does not follow LRU, but I think the LRU priority
> > > inversion is unavoidable once the pool limit is hit.
> > > The accept_thr_percent should be lowered to reduce the probability of
> > > LRU inversion if it matters. (it is why I implemented proactive
> > > shrinker.)
> >
> > Why?
> >
> > Let's take a step back. You are suggesting that we throttle zswap
> > writeback to allow reclaim to swapout warmer pages to swap device. As
> > Nhat said, we are proliferating LRU inversion instead of fixing it.
> >
> > I think I had a similar discussion with Johannes about this before,
> > and we discussed that if zswap becomes full, we should instead
> > throttle reclaim and allow zswap writeback to proceed (i.e. the
> > opposite of what this series is doing). This would be similar to how
> > we throttle reclaim today to wait for dirty pages to be written back.
> >
>
> I completely agree with this analysis and proposal - it's somewhat
> similar to what I have in mind, but more fleshed out :)
>
> > This should reduce/fix the LRU inversion instead of proliferating it,
> > and it should reduce the total amout of IO as colder pages should go
> > to disk while warmer pages go to zswap. I am wondering if we can reuse
> > the reclaim_throttle() mechanism here.
> >
> > One concern I have is that we will also throttle file pages if we use
> > reclaim_throttle(), since I don't see per-type throttling there. This
> > could be fine, since we similarly throttle zswap reclaim if there are
> > too many dirty file pages. I am not super familiar with reclaim
> > throttling, so maybe I missed something obvious or there is a better
> > way, but I believe that from a high level this should be the right way
> > to go.
>
> I don't think we have any infrastructure for anon-only throttling in
> vmscan logic, but it sounds trivial to implement if necessary :)
>
> >
> > I actually think if we do this properly, and throttle reclaim when
> > zswap becomes full, we may be able to drop the acceptance hysteresis
> > and rely on the throttling mechanism to make sure we stop reclaim
> > until we free up enough space in zswap to avoid consistently hitting
> > the limit, but this could be a future extension.
>
> Agree - this hysteresis heuristics needs to die.
>
> IMHO, I think we should still have the proactive global shrinking
> action that Takero is proposing in patch 3. The throttling is nice,
> but it'd be even nicer if we can get ahead of that :)

I have always thought that the shrinker should play this role in one
way or another. Instead of an arbitrary watermark and asynchronous
work, it incrementally pushes the zswap LRU toward disk as reclaim
activity increases.

Is the point behind proactive shrinking is to reduce the latency in
the reclaim path?

