Return-Path: <linux-kernel+bounces-348143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B7B98E342
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D60CF1C22CAD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32232141CD;
	Wed,  2 Oct 2024 18:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aI/+hdgx"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B65712C54D
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 18:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727895520; cv=none; b=t1gc5Dgs/Ba5Qxtx3xBQIjV5Pn56SdgcTT2czJ8Krredtyfhv0BXp5rECtjVvZvNwnpzUYkpmR83t0u9u/wGzU5l3Upq+8aa/x4/pZpZGkIQcY2e7vdDXFN4qmFPRqQ7ngtdv5afHRnAwYev4xcQAlJDWVZeLtMwJjpYxwS91mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727895520; c=relaxed/simple;
	bh=HdVxj2tTqKMeexd/LoAX7UMbVSiPUees+wGzRpjW6MM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ESEirjT96XGbwbx9VXVgi/FgkIS5ecUJPvZloncdA49BeegkIyen0CBLRl8fxmDJ+N4caelGzNUOcygeH+GuNwtx/PbRY6A1pe/tFa3r7WIEgTlEhth/ET1uc68Fl/ltx7sbCp/71AiIsOkHOJ0/zd/RjxnXqcZ9awYAFlRZZ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aI/+hdgx; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fac3f20f1dso1405411fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 11:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727895515; x=1728500315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJihvFLY+/PB1Gfvqw4s7qDkzZW2UtDYa8qi2yTs9+c=;
        b=aI/+hdgxxm9Lid0dEndYC3yjnX/Ym+1ZUH/Y65OP0G9on+cGz6SY8h/XoxSPTS0zQ/
         pQim/R5nnpZedVJB0ALMDjjI8TtRiAWRvZ7irIubciSY34bdhj4Bzp5J5kKBdE3/3yWd
         ZMT+MohNjObt51sAO7OM46AUeP6jXbHOqmuhsxxEd5yGM1WpXWNRB+mKbgwcjccUn3lv
         +yIYVi49byVbjH1i6qCFXKQlvesjdnL4Il3KG4qLPaYzrLJI3CywcakYfpfZPLsbsPDt
         kfHhau1RS0g+TqE+0Knyr79Ts4mo1+ipeEYwUGMzGF0Vh6PfbXcyoXQ+9dwpqBaLVSwb
         9bcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727895515; x=1728500315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJihvFLY+/PB1Gfvqw4s7qDkzZW2UtDYa8qi2yTs9+c=;
        b=TcA7+zZDzPcNeYh/961MZascx/sP0MXmKPHFRCIOVj7HEGnyyTHrYUAGPJBEl7f2Cj
         DQNPrJXl6JDDqQerBoOg8BpIMdl1YWJIQOzZuoB7rhM05DHzUG3iArrzE5dxQP7NM2/V
         0XQpvo4B3YchfbfUnugx3NuvjgcXbKJgROpTdgMG54ez4bF/D6/0xn1jfHNNO4WF5p5i
         FpjSQqh3A3PGXASsrcqYotLjsSJ1kg5mKM3tzkBzxFHOg4P6uRMdvHQcx7fCX8r8LZbW
         wnroUTiXU0wrTQrybyvo8ZEbD+KJjHE+tw9vDg1sSr5cAYEQ+0pFMlnk1ZXbnMrDL8EZ
         vk3A==
X-Forwarded-Encrypted: i=1; AJvYcCXRs9tvuoDIf5bT4LhWoeNA/26OsdVqnVLoklnwL7txvP4rzsJAaexTqNFPGyVf5xkVWDkD3wWz28UxAPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8c3HsJ620bI/2ArUMb2XBG36wVCmUneJYwYTfY7jFXEBKIW1X
	wi9XB+7Z9/kpL3sik9kfKvh1rRV+k9boFcOHBWI40MkjOlD+LJLY3FesVK02ujqTbeZ1A2geF/I
	S7KH3bs9zXPzzk2e+qz/QVPii3Kc=
X-Google-Smtp-Source: AGHT+IH8MpcRdjd9DhqsAwLkZKoQVw1e6Q6fMrgqRcM0MtqUumsbTF1Cw4qA/fQw5PWFfIakZctyS6QFiOvCg1HPfV8=
X-Received: by 2002:a2e:e09:0:b0:2fa:ded3:f6aa with SMTP id
 38308e7fff4ca-2fae1023cccmr21302301fa.20.1727895515241; Wed, 02 Oct 2024
 11:58:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYvo5npQ3o_vgiOX2guHtgafRoFPL__4O8Kcwg2=ssXmKg@mail.gmail.com>
 <e718bc99-e63b-4adb-9e40-2379f48301f5@stanley.mountain> <b22dbfe2-dd29-40de-a4a3-4a0d6b55cd65@stanley.mountain>
 <62a65418-2393-40ec-b462-151605a5efcf@stanley.mountain>
In-Reply-To: <62a65418-2393-40ec-b462-151605a5efcf@stanley.mountain>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 3 Oct 2024 02:58:19 +0800
Message-ID: <CAMgjq7CapiW2h2pzcKQBhwf_5rs5fgMGHw1E2YJYwEiY6zc=LQ@mail.gmail.com>
Subject: Re: next-20241001: WARNING: at mm/list_lru.c:77 list_lru_del
 (mm/list_lru.c:212 mm/list_lru.c:200)
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>, 
	linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 7:28=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
>
> On Wed, Oct 02, 2024 at 02:25:34PM +0300, Dan Carpenter wrote:
> > On Wed, Oct 02, 2024 at 02:24:20PM +0300, Dan Carpenter wrote:
> > > Let's add Kairui Song to the  CC list.
> > >
> > > One simple thing is that we should add a READ_ONCE() to the compariso=
n.  Naresh,
> > > could you test the attached diff?  I don't know that it will fix it b=
ut it's
> > > worth checking the easy stuff first.
> > >
> >
> > Actually that's not right.  Let me write a different patch.
>
> Try this one.
>
> regards,
> dan carpenter
>
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index 79c2d21504a2..2c429578ed31 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -65,6 +65,7 @@ lock_list_lru_of_memcg(struct list_lru *lru, int nid, s=
truct mem_cgroup *memcg,
>                        bool irq, bool skip_empty)
>  {
>         struct list_lru_one *l;
> +       long nr_items;
>         rcu_read_lock();
>  again:
>         l =3D list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(memcg));
> @@ -73,8 +74,9 @@ lock_list_lru_of_memcg(struct list_lru *lru, int nid, s=
truct mem_cgroup *memcg,
>                         spin_lock_irq(&l->lock);
>                 else
>                         spin_lock(&l->lock);
> -               if (likely(READ_ONCE(l->nr_items) !=3D LONG_MIN)) {
> -                       WARN_ON(l->nr_items < 0);
> +               nr_items =3D READ_ONCE(l->nr_items);
> +               if (likely(nr_items !=3D LONG_MIN)) {
> +                       WARN_ON(nr_items < 0);
>                         rcu_read_unlock();
>                         return l;
>                 }
>

Thanks. The warning is a new added sanity check, I'm not sure if this
WARN_ON triggered by an existing list_lru leak or if it's a new issue.

And unfortunately so far I can't reproduce it locally on my ARM
machine, it should be easily reproducible according to the
description. And if the WARN only triggered once, and only during
boot, mayce some static data wasn't initialized correctly? Or the
enablement of memcg caused some list_lru leak
(mem_cgroup_from_slab_obj changed from returning NULL to returning
actual memcg, so a item added to rootcg before will be attempt removed
from actual memcg, seems a real race). If it's the latter case, then
it's an existing issue caught by the new sanity check.

The READ_ONCE patch may be worth trying, I'll also try to do more
debugging on this and try to send a fix later.

