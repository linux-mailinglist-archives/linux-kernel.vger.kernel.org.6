Return-Path: <linux-kernel+bounces-257791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A460A937EF8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 06:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AE4C1F21A6D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 04:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE28D530;
	Sat, 20 Jul 2024 04:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a8IX53ys"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0E063D
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 04:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721451179; cv=none; b=IfO5Xhc9Fzz3c4pL14m9rTXuH6u491UmGqDMreLNFpJmVWVKLPWHXDXTQMbmSDtopjkfuRR1GfrzgNEfPfNfj1+e8nVLACMX58r4CtiFdQBi24KAL30MaCs9pByeJ2r02iJPUkrPctdkMnxIvIJSb3rUCLqR4xCUjyI4nVsfzow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721451179; c=relaxed/simple;
	bh=UoLdUAJAryghMfc6CeCPhFdMgTNMlLLrJiaNMLYtDUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q5fLfM8TtmXVkNMEQ6WAg3kr+A+K4IenGL4HfCGhUNunGmMbXbgh4Ol7gHHaF5hAD1qqr7rSqllKxpCyPJd9S5XwYWJRwaxYU2K0jhBBb77Xk22EgumLmL9FJozaWaGk1YA0BMG99IlYo8GzowNfp3KKEO2g7yZ12X28WIwd1IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a8IX53ys; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52ee4e26790so2837497e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 21:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721451176; x=1722055976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSRulvHWjoBy0HLcI6v4db2avURTI4j4zJY+qVX3PAA=;
        b=a8IX53ysK6PSEBpNtiu/S8YefBzfW/cNabzTYv6ZMqleZL8dAJ2fQSb3Tkz9618kcO
         e8o+lzDLUKQbrlCU3brki9JL0kne5tctdmOzPM5yA9We/Spu0FdTDTqgA0j6C4nZlBD0
         Iymys9DDboJjcr2zcTYb72hCv1S/Dp2WeqcEXJ1v+4d0C2LiG9fmJ0qlZdP1vxTL+99I
         3FoTCvcjDb1cVemF1eoZYuK5ypW9KVFARMm+miZy5f5WuWQMwMGGVuuP2cM/UEHVq3NS
         /k3AJP3Izf4H7W2Jqy5xN2SaLGfo5rhLx3N65FbpMiRFG/+4DT5kKddVoS/yqkodvhIi
         zyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721451176; x=1722055976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fSRulvHWjoBy0HLcI6v4db2avURTI4j4zJY+qVX3PAA=;
        b=t4TEUdqQ4z42sSM57bgMHr1Tv6IlFdS7TwmeSMlhYt3IeyRvuzgItedt/nnP6lPpY7
         3ruJ30XoC/r1f0uwkB46mysueDnuvepZuu5Txb67S7S8xmw55Sq/A1OdevHEKH/NyNoh
         wAbgZ4GZAWdLUVa8q7uJ736M+WTjH+nMlc9JqxpBl1GvZkkQJU5+hLy62sXQa7TRSLXq
         65zJURTX6EERbrJP7JDsjuBp6i8oeSY0U+QxQZKSiOrX05Wyly84aBoiZz2Vb0BT1y6q
         ZqPRx46uf/SMbe49OWqk3Y17Zhrgqfns1FVoBEH9VQmf3QQ++7wArz7mvA2TXOAX0i17
         E3Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVUcoVNpyIi3uP7+IgSPgFjR4HCZu6/QSoHXWYUbVIUhQjiXibW1iM0m4hUs+JzacpGapcNyJiCdUs2md97Jf0PqjdfhqNT7Ux6HW3f
X-Gm-Message-State: AOJu0YwkCPfwys44omWbg6qe9RGHtsqT5WVntRuZqWIBD9tgwh5howKK
	3S1s1wNZVdLDrmvx53Y4TWCdDdsSF+NDwFGVeE/oD7Xw0+TbA2qev8+mz/BfspZ/9OKwgfGj3xa
	DpO9uo8iK+IXN7WmabG7O2NpXxIWQWPaH5/0C
X-Google-Smtp-Source: AGHT+IEuqDE8qtcuvEHCdMjPK+szxTU34wSvAmUMiAVDP0uGH3fdV3MdBRkljmhPdZlIdRmQlRwnnVbtKUVXHMJDaA0=
X-Received: by 2002:a05:6512:2351:b0:52c:8920:875 with SMTP id
 2adb3069b0e04-52ef8d960ffmr873936e87.20.1721451175516; Fri, 19 Jul 2024
 21:52:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172070450139.2992819.13210624094367257881.stgit@firesoul>
 <a4e67f81-6946-47c0-907e-5431e7e01eb1@kernel.org> <CAJD7tkYV3iwk-ZJcr_==V4e24yH-1NaCYFUL7wDaQEi8ZXqfqQ@mail.gmail.com>
 <100caebf-c11c-45c9-b864-d8562e2a5ac5@kernel.org> <k3aiufe36mb2re3fyfzam4hqdeshvbqcashxiyb5grn7w2iz2s@2oeaei6klok3>
 <5ccc693a-2142-489d-b3f1-426758883c1e@kernel.org> <iso3venoxgfdd6mtc6xatahxqqpev3ddl3sry72aoprpbavt5h@izhokjdp6ga6>
In-Reply-To: <iso3venoxgfdd6mtc6xatahxqqpev3ddl3sry72aoprpbavt5h@izhokjdp6ga6>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 19 Jul 2024 21:52:17 -0700
Message-ID: <CAJD7tkYWnT8bB8UjPPWa1eFvRY3G7RbiM_8cKrj+jhHz_6N_YA@mail.gmail.com>
Subject: Re: [PATCH V7 1/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org, cgroups@vger.kernel.org, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 3:48=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Fri, Jul 19, 2024 at 09:54:41AM GMT, Jesper Dangaard Brouer wrote:
> >
> >
> > On 19/07/2024 02.40, Shakeel Butt wrote:
> > > Hi Jesper,
> > >
> > > On Wed, Jul 17, 2024 at 06:36:28PM GMT, Jesper Dangaard Brouer wrote:
> > > >
> > > [...]
> > > >
> > > >
> > > > Looking at the production numbers for the time the lock is held for=
 level 0:
> > > >
> > > > @locked_time_level[0]:
> > > > [4M, 8M)     623 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@            =
   |
> > > > [8M, 16M)    860 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@|
> > > > [16M, 32M)   295 |@@@@@@@@@@@@@@@@@                                =
   |
> > > > [32M, 64M)   275 |@@@@@@@@@@@@@@@@                                 =
   |
> > > >
> > >
> > > Is it possible to get the above histogram for other levels as well?
> >
> > Data from other levels available in [1]:
> >  [1]
> > https://lore.kernel.org/all/8c123882-a5c5-409a-938b-cb5aec9b9ab5@kernel=
.org/
> >
> > IMHO the data shows we will get most out of skipping level-0 root-cgrou=
p
> > flushes.
> >
>
> Thanks a lot of the data. Are all or most of these locked_time_level[0]
> from kswapds? This just motivates me to strongly push the ratelimited
> flush patch of mine (which would be orthogonal to your patch series).

Jesper and I were discussing a better ratelimiting approach, whether
it's measuring the time since the last flush, or only skipping if we
have a lot of flushes in a specific time frame (using __ratelimit()).
I believe this would be better than the current memcg ratelimiting
approach, and we can remove the latter.

WDYT?

>
> Shakeel

