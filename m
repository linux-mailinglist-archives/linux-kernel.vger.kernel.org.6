Return-Path: <linux-kernel+bounces-227972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B6391592A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 23:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8982B1F2431C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 21:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98D11A0AFB;
	Mon, 24 Jun 2024 21:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uGbZ9HvA"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF978F6B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 21:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719265315; cv=none; b=uTQVqHRzUww6WtfmOu0SHHnFNCEFz62QWGROfD6F6XaXVx+9ECa8su/QKZ6M/xvv1iaCjmMjTFR/l+/PGlYhEvyDw2HUzVR//hRFozumGoQ6wqUNKqcGeQbc8g47e53lzNf7q/nT9W+UCHBJ1VmVU9qdDrQQNJa/xJSuvasBcfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719265315; c=relaxed/simple;
	bh=INDzkogUr8vsj6gysN5YnrA7Il5jPfEYwvp559Io+80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oRsMcDYL7i9yiKlbngZijJAXVMPPW41ERfSmy6bPnK49G3fXlHv14x2z/jSDyheRVz64qGqrzIhE5wIWoCNuimOe+MbKeLMtBAb7YAY/4ZodZDqRyNYuwiqJ/uCukRWyDO/7WFEp8gV86EUi7128flk/KzEKO1NyoKbiOG/atqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uGbZ9HvA; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52cd80e55efso5656640e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719265312; x=1719870112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INDzkogUr8vsj6gysN5YnrA7Il5jPfEYwvp559Io+80=;
        b=uGbZ9HvAzjUS6FCl1Beoczf235Z9NlQGhZCqPvgw7x6g/w0RZbhtZOI9cdmxi7WFXw
         Avw8/hG2AjNr3PUXta5+lg8wBfqw9PgZTf2lOxJdIpCNEEkGYiHw082CYTjWND5/JS3/
         C4WVTN0iMxNsc6lGi52zp0amGI4sNfDaGjw6OVGQjAvDf+odEuuo6RtkRpMbLgNAY0VU
         RL6cLdp9xWGtPaJxVag5WLY8ItBTaeksG3dPVi45b3XbaBJ2smnEl9PV7d5qeIfWwNTF
         1OFgCIJd1bIsLKlyjOfZ1OgsowscxS+6S0ogrzahDDPPR8dla0LRyrDKrhMZGGfrvB/1
         90sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719265312; x=1719870112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INDzkogUr8vsj6gysN5YnrA7Il5jPfEYwvp559Io+80=;
        b=Q26SUHnZJE3mGC8wpxK6GhPGu68FGCUhWGH5Gk/rt3YhpkxJy3QFskw1o7yhdAyuZI
         cYw2M+LM9Sbh50s8+ccg1lZJPn7QUHd7ENfVlrvqocPFDVXkiPdZ33xHikDEo3LV6+IH
         zq/T0rSVvY2MYnna/V5yl/LNe+hOre4L6asHI1y7bS/mnvEfCoFYapec9qtYxYPsQqnk
         sKQ5OqIrua7CKk6/VS8v9U9LL84xgf1g5Z61StZ3vPG50gCAh+zZgFr10Qphx9wP/HQ7
         h8iowqz7l+mpnrdwqHuAu9s/6ndtQcVmXJaqQt1WB2R4GHKQiUX0YpFXCQ3X8ZiMEoys
         w3Og==
X-Forwarded-Encrypted: i=1; AJvYcCXvVForOilQx/+G4zhwl02uTKE3Ed1Kqj3b9Oxg8OtJhKQxXR5QX6oHyrv+bjBCltrjuFYyO54k0Csx3gr+fAz+j9m7j82aNU4JdW9r
X-Gm-Message-State: AOJu0Yz25AmK/8ld+yJDKr7AWURV+wDe6h7pfbwvjNIFzztXUZ7JTVnh
	F/9HJTDQCF5HxarED9K7yRv6WRVPHgWzoWu8xdHW2Lc0+bGMjByG17xXOkCqYVlS1C+eyfDu+LQ
	U/bjEJUcXrpAJhkwZSmLADO1BwV119/bS2AzB
X-Google-Smtp-Source: AGHT+IH4biSTMKC8IZqq6WCcH755yTV9BaCzTuN71r1TiTY+7lgmnJ215jo2AQXkmTd2z3feJGWR+YBWppOFTzYDEsg=
X-Received: by 2002:a05:6512:745:b0:52c:8b69:e039 with SMTP id
 2adb3069b0e04-52ce182bd0amr3911904e87.4.1719265311700; Mon, 24 Jun 2024
 14:41:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240615081257.3945587-1-shakeel.butt@linux.dev>
 <CAJD7tkbpFu8z1HaUgkaE6bup_fsD39QLPmgNyOnaTrm+hZ_9hA@mail.gmail.com>
 <tbi7h7lw4gvl2lsobco4s2qq5phln4uilfvpzpqytlwwmerynd@5nrl5odpwcrx>
 <CAJD7tka-Wa95t29G0EY4xd8TWXkw1q_QNQ-QjzNvqnUQovMtQw@mail.gmail.com>
 <rbetatcg46uddpde3dw35g4kgzesbtrtyzhg666cqjneucey65@nhcc6i775qte>
 <CAJD7tkaB+JgP=+Nb2Ecikw024eO7qHo6vkHKL-uf2f135LL4UQ@mail.gmail.com>
 <ymi5ztypuurvtczjep3spulr7klfqh5y4rwuwu2g4pfgxb7hpw@7htpiuhzwc7n>
 <CAJD7tkb74XVZx+g_xmdC8saH6AXg1seunNSmkYYNsMKfJfg0Cg@mail.gmail.com> <wlgw7fz4cgwlsnvzufeak26fqfj5ahutnfnbfifgob722il253@k2qxpgdtutmt>
In-Reply-To: <wlgw7fz4cgwlsnvzufeak26fqfj5ahutnfnbfifgob722il253@k2qxpgdtutmt>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 24 Jun 2024 14:41:12 -0700
Message-ID: <CAJD7tkZivAuP+ett0v8PgUZoQ98pbkBnsk9ThLsWX_C=Vcp-cA@mail.gmail.com>
Subject: Re: [PATCH] memcg: use ratelimited stats flush in the reclaim
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@suse.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	Muchun Song <songmuchun@bytedance.com>, Facebook Kernel Team <kernel-team@meta.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 1:01=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Mon, Jun 24, 2024 at 12:06:28PM GMT, Yosry Ahmed wrote:
> > On Mon, Jun 24, 2024 at 11:59=E2=80=AFAM Shakeel Butt <shakeel.butt@lin=
ux.dev> wrote:
> > >
> > > On Mon, Jun 24, 2024 at 10:15:38AM GMT, Yosry Ahmed wrote:
> > > > On Mon, Jun 24, 2024 at 10:02=E2=80=AFAM Shakeel Butt <shakeel.butt=
@linux.dev> wrote:
> > > > >
> > > > > On Mon, Jun 24, 2024 at 05:57:51AM GMT, Yosry Ahmed wrote:
> > > > > > > > and I will explain why below. I know it may be a necessary
> > > > > > > > evil, but I would like us to make sure there is no other op=
tion before
> > > > > > > > going forward with this.
> > > > > > >
> > > > > > > Instead of necessary evil, I would call it a pragmatic approa=
ch i.e.
> > > > > > > resolve the ongoing pain with good enough solution and work o=
n long term
> > > > > > > solution later.
> > > > > >
> > > > > > It seems like there are a few ideas for solutions that may addr=
ess
> > > > > > longer-term concerns, let's make sure we try those out first be=
fore we
> > > > > > fall back to the short-term mitigation.
> > > > > >
> > > > >
> > > > > Why? More specifically why try out other things before this patch=
? Both
> > > > > can be done in parallel. This patch has been running in productio=
n at
> > > > > Meta for several weeks without issues. Also I don't see how mergi=
ng this
> > > > > would impact us on working on long term solutions.
> > > >
> > > > The problem is that once this is merged, it will be difficult to
> > > > change this back to a normal flush once other improvements land. We
> > > > don't have a test that reproduces the problem that we can use to ma=
ke
> > > > sure it's safe to revert this change later, it's only using data fr=
om
> > > > prod.
> > > >
> > >
> > > I am pretty sure the work on long term solution would be iterative wh=
ich
> > > will involve many reverts and redoing things differently. So, I think=
 it
> > > is understandable that we may need to revert or revert the reverts.
> > >
> > > > Once this mitigation goes in, I think everyone will be less motivat=
ed
> > > > to get more data from prod about whether it's safe to revert the
> > > > ratelimiting later :)
> > >
> > > As I said I don't expect "safe in prod" as a strict requirement for a
> > > change.
> >
> > If everyone agrees that we can experiment with reverting this change
> > later without having to prove that it is safe, then I think it's fine.
> > Let's document this in the commit log though, so that whoever tries to
> > revert this in the future (if any) does not have to re-explain all of
> > this :)
>
> Sure.
>
> >
> > [..]
> > > > > > >
> > > > > > > For the cache trim mode, inactive file LRU size is read and t=
he kernel
> > > > > > > scales it down based on the reclaim iteration (file >> sc->pr=
iority) and
> > > > > > > only checks if it is zero or not. Again precise information i=
s not
> > > > > > > needed.
> > > > > >
> > > > > > It sounds like it is possible that we enter the cache trim mode=
 when
> > > > > > we shouldn't if the stats are stale. Couldn't this lead to
> > > > > > over-reclaiming file memory?
> > > > > >
> > > > >
> > > > > Can you explain how this over-reclaiming file will happen?
> > > >
> > > > In one reclaim iteration, we could flush the stats, read the inacti=
ve
> > > > file LRU size, confirm that (file >> sc->priority) > 0 and enter th=
e
> > > > cache trim mode, reclaiming file memory only. Let's assume that we
> > > > reclaimed enough file memory such that the condition (file >>
> > > > sc->priority) > 0 does not hold anymore.
> > > >
> > > > In a subsequent reclaim iteration, the flush could be skipped due t=
o
> > > > ratelimiting. Now we will enter the cache trim mode again and recla=
im
> > > > file memory only, even though the actual amount of file memory is l=
ow.
> > > > This will cause over-reclaiming from file memory and dismissing ano=
n
> > > > memory that we should have reclaimed, which means that we will need
> > > > additional reclaim iterations to actually free memory.
> > > >
> > > > I believe this scenario would be possible with ratelimiting, right?
> > > >
> > >
> > > So, the (old_file >> sc->priority) > 0 is true but the (new_file >>
> > > sc->priority) > is false. In the next iteration, (old_file >>
> > > (sc->priority-1)) > 0 will still be true but somehow (new_file >>
> > > (sc->priority-1)) > 0 is false. It can happen if in the previous
> > > iteration, somehow kernel has reclaimed more than double what it was
> > > supposed to reclaim or there are concurrent reclaimers. In addition t=
he
> > > nr_reclaim is still less than nr_to_reclaim and there is no file
> > > deactivation request.
> > >
> > > Yeah it can happen but a lot of wierd conditions need to happen
> > > concurrently for this to happen.
> >
> > Not necessarily sc->priority-1. Consider two separate sequential
> > reclaim attempts. At the same priority, the first reclaim attempt
> > could rightfully enter cache trim mode, while the second one
> > wrongfully enters cache trim mode due to stale stats, over-reclaim
> > file memory, and stall longer to actually reclaim the anon memory.
> >
>
> For two different reclaim attempts even more things need to go wrong.
> Anyways we are talking too much in abstract here and focusing on the
> corner cases which almost all heuristics have. Unless there is a clear
> explanation that the corner case probability will be increased, I don't
> think spending time discussing it is useful.
>
> > I am sure such a scenario is not going to be common, but I am also
> > sure if it happens it will be a huge pain to debug.
> >
> > If others agree that this is fine, let's document this with a comment
> > and in the commit log. I am not sure how common the cache trim mode is
> > in practice to understand the potential severity of such problems.
> > There may also be other consequences that I am not aware of.
>
> What is your definition of "others" though?

I am just interested to hear more opinions. If others (e.g. people in
the CC) agree with you that this is the approach we should be taking
then I won't stand in the way. If others share my concerns, then maybe
we should not proceed. It seemed like at least Jesper had some
concerns as well.

If no one cares enough to voice their opinions then I suppose it's up to yo=
u :)

