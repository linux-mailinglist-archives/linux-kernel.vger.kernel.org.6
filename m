Return-Path: <linux-kernel+bounces-259620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A89A69399A3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBF5E1C219EE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 06:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F74213D606;
	Tue, 23 Jul 2024 06:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ps302zRg"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245C413957B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 06:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721715894; cv=none; b=BgTZqv6+uz9602yyUtoP3Q1qJHemhbO61pem+ck6XFbIjoW2acW93Q9iyc1zpWc6KcRNKoRkU9MxEWo3HoFtt4hXgizCCJjfqM0039adOR+aoL2iC1WuzDmTFGzY8HBUo8AEB5AX2s0DEsUEUPWF4XtSHGTCQPgtvzWfQDkiyaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721715894; c=relaxed/simple;
	bh=RmN1rRSG3lwxqRwK69yWPotzbJMTuS9ursXBcLAI8R8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fR4Lqn7SNczk5F2kvJIw4FGLi8hGZYYgvXNYYxJgo97FmvGB0l+PCiht1zGvIeLYektHC2w6Otn9F0ObH2bFaCm9QAlvQXoB3nj01dL0Xx0J+cHVC/L1lnyUL1/xlI07SrG9h0sEmEOyVJkdXb/xYD8jv92YrILXR2aNyOwHj4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ps302zRg; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5a1fcb611d9so4198925a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 23:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721715891; x=1722320691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuZYvoWq8whgmpL1IFSnglW/V1EXZpX9C/pX5nqTQxs=;
        b=Ps302zRgsNAIWC+q4lyzGl7qUrmx549VMneWI5u08c8NgRDhyISQv5mMHPTPdaPtHn
         j5QpcXMpi7TwMHPTJecUNnAV1Vzj6RaOBGHcqbMK8S5g6VX9u+UzW/Iy9XDj3QT90ZSy
         5QclUW1RGmx3RIQW9Fb1forCiGCPC1A5jf7hS8CawETggMVUki2Zl/GkFoJ9iXr2i3Bm
         Xfce52O9gDR3twrwEdKKZgPwaJff2MvL71PV4DJnR/Xd1WdaWE+2MGDNgadJbahH3F2M
         8SFe/hH8gKdmwSbUspydE1A8XwhSJ5C/DZ37O/zhuVD2uY38fuKyVlqy+j+e5wiMrw0/
         xoxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721715891; x=1722320691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PuZYvoWq8whgmpL1IFSnglW/V1EXZpX9C/pX5nqTQxs=;
        b=SWJ0WRwBFTB0S7lWNe/UpEbQUk3QG2olDoW+JQnr0JMKKD8Weh4Jk3dXmFi0oBWrCI
         aIHoADptp/kNWDhMO+OKMFCur3s6ax+sbGz8XgKa15kOS8v7zIhi7zdV3i3w5wLyXOK5
         fESU6+C2jKFVeUZ2Apm98fT9APxj36SIZXL/Z1MLh+W7zsumEvBbO95N/bOU2LNlY4t0
         Gr00zE3jxTb5PlIi2IphKEBG4Jv8WBO//u7l6r8mp30XWd+ipmgd6UQCXkHwkjGiCPpW
         D16WtIg9fEDy30K/II650Amy1Yjo1Q4VvkIHpm9lUvrbbpR/wDIfORIDQvckewfGkL1/
         Lopw==
X-Forwarded-Encrypted: i=1; AJvYcCX1+EK6wzd6ALRpCWBtqrISiFTu0XrBMfHpdgeyscUXtayzsReFkjo9lqNEMxrkLWIzEjimHVPQ0Pi/w2cgvuzD9DNSHzAKMVm4T+KK
X-Gm-Message-State: AOJu0YzBi8SzbvxV0e9YIWKzWQSjCQiJQw6trAvXHVR/+a2qBqnSaOmL
	2D7D7jsLXa+o+K08ULZssKZjw8qeJUXc54VgC2NVApJ/BeMhyeXTaHNnBrSwlyjKYqS3zlo1NVn
	NEPBHRZ0y2C0BTQA1cMqn06B9f+1TkQWIXX7B
X-Google-Smtp-Source: AGHT+IGiQyOg6jtQNoklz56+z3NglFn5Y42p/i72Wp48qUQKGIwp/zuniQZ48JW9nBcy3wageNryev5duikJU+EPMvY=
X-Received: by 2002:a17:907:7296:b0:a79:8149:966e with SMTP id
 a640c23a62f3a-a7a4bfe6355mr623341266b.1.1721715890808; Mon, 22 Jul 2024
 23:24:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a4e67f81-6946-47c0-907e-5431e7e01eb1@kernel.org>
 <CAJD7tkYV3iwk-ZJcr_==V4e24yH-1NaCYFUL7wDaQEi8ZXqfqQ@mail.gmail.com>
 <100caebf-c11c-45c9-b864-d8562e2a5ac5@kernel.org> <k3aiufe36mb2re3fyfzam4hqdeshvbqcashxiyb5grn7w2iz2s@2oeaei6klok3>
 <5ccc693a-2142-489d-b3f1-426758883c1e@kernel.org> <iso3venoxgfdd6mtc6xatahxqqpev3ddl3sry72aoprpbavt5h@izhokjdp6ga6>
 <CAJD7tkYWnT8bB8UjPPWa1eFvRY3G7RbiM_8cKrj+jhHz_6N_YA@mail.gmail.com>
 <t5vnayr43kpi2nn7adjgbct4ijfganbowoubfcxynpewiixvei@7kprlv6ek7vd>
 <CAJD7tkZV3PF7TR2HWxXxkhhS8oajOwX1VG7czdTQb8tRY9Jwpw@mail.gmail.com>
 <x45wrx26boy2junfx6wzrfgdlvhvw6gji5grreadcrobs6jvhu@o5bn2hcpxul3> <ujfbtpvs6lpsuasz5dxvvcgyv2xorlhs2wjpjnpdyeicukwevx@2qj642cgn2ie>
In-Reply-To: <ujfbtpvs6lpsuasz5dxvvcgyv2xorlhs2wjpjnpdyeicukwevx@2qj642cgn2ie>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 22 Jul 2024 23:24:14 -0700
Message-ID: <CAJD7tkY1B9M6A8jHRuw4H8R95S9V4j_BkSQkDnr87_Tir+7VAA@mail.gmail.com>
Subject: Re: [PATCH V7 1/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org, cgroups@vger.kernel.org, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 3:59=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Mon, Jul 22, 2024 at 02:32:03PM GMT, Shakeel Butt wrote:
> > On Mon, Jul 22, 2024 at 01:12:35PM GMT, Yosry Ahmed wrote:
> > > On Mon, Jul 22, 2024 at 1:02=E2=80=AFPM Shakeel Butt <shakeel.butt@li=
nux.dev> wrote:
> > > >
> > > > On Fri, Jul 19, 2024 at 09:52:17PM GMT, Yosry Ahmed wrote:
> > > > > On Fri, Jul 19, 2024 at 3:48=E2=80=AFPM Shakeel Butt <shakeel.but=
t@linux.dev> wrote:
> > > > > >
> > > > > > On Fri, Jul 19, 2024 at 09:54:41AM GMT, Jesper Dangaard Brouer =
wrote:
> > > > > > >
> > > > > > >
> > > > > > > On 19/07/2024 02.40, Shakeel Butt wrote:
> > > > > > > > Hi Jesper,
> > > > > > > >
> > > > > > > > On Wed, Jul 17, 2024 at 06:36:28PM GMT, Jesper Dangaard Bro=
uer wrote:
> > > > > > > > >
> > > > > > > > [...]
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Looking at the production numbers for the time the lock i=
s held for level 0:
> > > > > > > > >
> > > > > > > > > @locked_time_level[0]:
> > > > > > > > > [4M, 8M)     623 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  =
             |
> > > > > > > > > [8M, 16M)    860 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@@@@@@@@@|
> > > > > > > > > [16M, 32M)   295 |@@@@@@@@@@@@@@@@@                      =
             |
> > > > > > > > > [32M, 64M)   275 |@@@@@@@@@@@@@@@@                       =
             |
> > > > > > > > >
> > > > > > > >
> > > > > > > > Is it possible to get the above histogram for other levels =
as well?
> > > > > > >
> > > > > > > Data from other levels available in [1]:
> > > > > > >  [1]
> > > > > > > https://lore.kernel.org/all/8c123882-a5c5-409a-938b-cb5aec9b9=
ab5@kernel.org/
> > > > > > >
> > > > > > > IMHO the data shows we will get most out of skipping level-0 =
root-cgroup
> > > > > > > flushes.
> > > > > > >
> > > > > >
> > > > > > Thanks a lot of the data. Are all or most of these locked_time_=
level[0]
> > > > > > from kswapds? This just motivates me to strongly push the ratel=
imited
> > > > > > flush patch of mine (which would be orthogonal to your patch se=
ries).
> > > > >
> > > > > Jesper and I were discussing a better ratelimiting approach, whet=
her
> > > > > it's measuring the time since the last flush, or only skipping if=
 we
> > > > > have a lot of flushes in a specific time frame (using __ratelimit=
()).
> > > > > I believe this would be better than the current memcg ratelimitin=
g
> > > > > approach, and we can remove the latter.
> > > > >
> > > > > WDYT?
> > > >
> > > > The last statement gives me the impression that you are trying to f=
ix
> > > > something that is not broken. The current ratelimiting users are ok=
, the
> > > > issue is with the sync flushers. Or maybe you are suggesting that t=
he new
> > > > ratelimiting will be used for all sync flushers and current ratelim=
iting
> > > > users and the new ratelimiting will make a good tradeoff between th=
e
> > > > accuracy and potential flush stall?
> > >
> > > The latter. Basically the idea is to have more informed and generic
> > > ratelimiting logic in the core rstat flushing code (e.g. using
> > > __ratelimit()), which would apply to ~all flushers*. Then, we ideally
> > > wouldn't need mem_cgroup_flush_stats_ratelimited() at all.
> > >
> >
> > I wonder if we really need a universal ratelimit. As you noted below
> > there are cases where we want exact stats and then we know there are
> > cases where accurate stats are not needed but they are very performance
> > sensitive. Aiming to have a solution which will ignore such differences
> > might be a futile effort.
> >
>
> BTW I am not against it. If we can achieve this with minimal regression
> and maintainence burden then it would be preferable.

It is possible that it is a futile effort, but if it works, the memcg
flushing interface will be much better and we don't have to evaluate
whether ratelimiting is needed on a case-by-case basis.

According to Jesper's data, allowing a flush every 50ms at most may be
reasonable, which means we can ratelimit the flushes to 20 flushers
per second or similar. I think on average, this should provide enough
accuracy for most use cases, and it should also reduce flushes in the
cases that Jesper presented.

It's probably worth a try, especially that it does not involve
changing user visible ABIs so we can always go back to what we have
today.

