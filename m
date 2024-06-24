Return-Path: <linux-kernel+bounces-227829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3EB9156EB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 21:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91C871F25ACE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172531A01A6;
	Mon, 24 Jun 2024 19:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M8s/nupx"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9AD1A00FC
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 19:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719256028; cv=none; b=b7WzCcB1/ZoTGBWAc6Rc3dcU//lq6OKb+r72hQJqGTAxJ97JOQNZIOEPohrgrB+XPZTQ5BLYg8LAOGdI2O4pLsbE3Cjr05mCtWRNS5nVNJeYPwMTNzQ66pRYmAgAUPU1Og6WfCIZNN29IvyFeclNxT7mN8ZGSEomNp1c6Yyc6P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719256028; c=relaxed/simple;
	bh=lR62gI/1SAvRGFQwjUeGp5M8TTVr01/DKqtXz/J0W10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WglyPv5MwpxANo5UHhMOLc1YUQ0xKQeLlL4LKdlVx9QbO8cgj5+4647/jg2pKLT8IOXZQjvYsLzqLOKtBJHlToPJXS4VUOJ9WSPd9eK2poUyIwJ4Mfv0p3eCVD1zdeXIPFUi5/bwfxQ6ClbomzDc3qYhTBMp9YWJFBx/v9klXXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M8s/nupx; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a72585032f1so152061566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 12:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719256025; x=1719860825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lR62gI/1SAvRGFQwjUeGp5M8TTVr01/DKqtXz/J0W10=;
        b=M8s/nupx+fpT9i+FMm05z3Gb1/PNNnKoekMt63Pu20EpHtWg3yT9BXqP90jz3q2ENs
         1ek13qETSf85oXQlvDoN1tj3wSSRH/47DkjST6slTI4HxbaTBZk18UkQvR+XS1wkTzSo
         BZlAwrgfuZpeA619rjAZM57NKoUaPhRYhDLSgqPXjU4tAruOH/UQhUn2U7bdf+tyq8+u
         cKzoDm6amEcHVydLFnpZDl5HFHBYB5XwSi6Cw36Xjpap+P68HoIFbL2gyhCrzv77V1DI
         plbFj0Ipe/IrMSU+3jovmmHgiT2QwIMzxPyjJNPE+AmLMgAvweK7Mq9wknWbUzobh9V8
         UghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719256025; x=1719860825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lR62gI/1SAvRGFQwjUeGp5M8TTVr01/DKqtXz/J0W10=;
        b=eqmHRtCtqXueTkvWa0B6UkexecZ+475g5Stxfw2w9QBfZkFd88xnBCdRgHcjsonTrE
         HWHgHDM35wZ9io7PcS0AF6fmZw5YH23VrD/BeC187BPmg6I4GhSNY6GCGWzrzW75gAhw
         dW7W/Gm5c5w6qIlmiGam8EJatf3ziU95M/4gOX2cfYRaN4BB12+jZvm4CmS4hL2OYg13
         H5H3mZ3/P4xP4img8w2ZtdWG/063rVKEbDR+R8zfCChcgcW9zy061ZjqLYvySSj6DbSN
         D572048AcoB1kGsisuukbWzDkoRF7/KPSTgbgwnr5EIb/TH9rx6clSXSWJwoxMbCyZGX
         LSJA==
X-Forwarded-Encrypted: i=1; AJvYcCVWQ7amkGNNAaCsOklvXk50IS2ZlTIzUVbzHs7Th75oFo8Ud5hp6PTY3ePR9+83nqzje1FxUcuEMdFmET0tT8RE3z9IVTehImPbKQXZ
X-Gm-Message-State: AOJu0YwwsOLjhCg1rUtc5mVlaXCYW3aqmaoa4uV0Gw39NFS6RpeBbbt2
	ufaEKj/kI4OLAbivILoMOVaMfMKkhrwfB273m8YXNkgXL51V+iXch3WKXBLJgQhdVyTy1KPXGfp
	FZxFJ3lEwX26bPUOyTdiTtp+aILzQjA9tzQzu
X-Google-Smtp-Source: AGHT+IGQGMLtBV20gTmfKdSojAfvaC7E4ljNx1sZ1gUfGpKwgiNYyPDTR9/rZjR+aXfJjbjlFCWO2UZ7I6NB4jdknJM=
X-Received: by 2002:a17:906:418:b0:a6f:5723:fb11 with SMTP id
 a640c23a62f3a-a715f9cbb00mr381699066b.58.1719256024286; Mon, 24 Jun 2024
 12:07:04 -0700 (PDT)
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
 <CAJD7tkaB+JgP=+Nb2Ecikw024eO7qHo6vkHKL-uf2f135LL4UQ@mail.gmail.com> <ymi5ztypuurvtczjep3spulr7klfqh5y4rwuwu2g4pfgxb7hpw@7htpiuhzwc7n>
In-Reply-To: <ymi5ztypuurvtczjep3spulr7klfqh5y4rwuwu2g4pfgxb7hpw@7htpiuhzwc7n>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 24 Jun 2024 12:06:28 -0700
Message-ID: <CAJD7tkb74XVZx+g_xmdC8saH6AXg1seunNSmkYYNsMKfJfg0Cg@mail.gmail.com>
Subject: Re: [PATCH] memcg: use ratelimited stats flush in the reclaim
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@suse.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	Muchun Song <songmuchun@bytedance.com>, Facebook Kernel Team <kernel-team@meta.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 11:59=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Mon, Jun 24, 2024 at 10:15:38AM GMT, Yosry Ahmed wrote:
> > On Mon, Jun 24, 2024 at 10:02=E2=80=AFAM Shakeel Butt <shakeel.butt@lin=
ux.dev> wrote:
> > >
> > > On Mon, Jun 24, 2024 at 05:57:51AM GMT, Yosry Ahmed wrote:
> > > > > > and I will explain why below. I know it may be a necessary
> > > > > > evil, but I would like us to make sure there is no other option=
 before
> > > > > > going forward with this.
> > > > >
> > > > > Instead of necessary evil, I would call it a pragmatic approach i=
.e.
> > > > > resolve the ongoing pain with good enough solution and work on lo=
ng term
> > > > > solution later.
> > > >
> > > > It seems like there are a few ideas for solutions that may address
> > > > longer-term concerns, let's make sure we try those out first before=
 we
> > > > fall back to the short-term mitigation.
> > > >
> > >
> > > Why? More specifically why try out other things before this patch? Bo=
th
> > > can be done in parallel. This patch has been running in production at
> > > Meta for several weeks without issues. Also I don't see how merging t=
his
> > > would impact us on working on long term solutions.
> >
> > The problem is that once this is merged, it will be difficult to
> > change this back to a normal flush once other improvements land. We
> > don't have a test that reproduces the problem that we can use to make
> > sure it's safe to revert this change later, it's only using data from
> > prod.
> >
>
> I am pretty sure the work on long term solution would be iterative which
> will involve many reverts and redoing things differently. So, I think it
> is understandable that we may need to revert or revert the reverts.
>
> > Once this mitigation goes in, I think everyone will be less motivated
> > to get more data from prod about whether it's safe to revert the
> > ratelimiting later :)
>
> As I said I don't expect "safe in prod" as a strict requirement for a
> change.

If everyone agrees that we can experiment with reverting this change
later without having to prove that it is safe, then I think it's fine.
Let's document this in the commit log though, so that whoever tries to
revert this in the future (if any) does not have to re-explain all of
this :)

[..]
> > > > >
> > > > > For the cache trim mode, inactive file LRU size is read and the k=
ernel
> > > > > scales it down based on the reclaim iteration (file >> sc->priori=
ty) and
> > > > > only checks if it is zero or not. Again precise information is no=
t
> > > > > needed.
> > > >
> > > > It sounds like it is possible that we enter the cache trim mode whe=
n
> > > > we shouldn't if the stats are stale. Couldn't this lead to
> > > > over-reclaiming file memory?
> > > >
> > >
> > > Can you explain how this over-reclaiming file will happen?
> >
> > In one reclaim iteration, we could flush the stats, read the inactive
> > file LRU size, confirm that (file >> sc->priority) > 0 and enter the
> > cache trim mode, reclaiming file memory only. Let's assume that we
> > reclaimed enough file memory such that the condition (file >>
> > sc->priority) > 0 does not hold anymore.
> >
> > In a subsequent reclaim iteration, the flush could be skipped due to
> > ratelimiting. Now we will enter the cache trim mode again and reclaim
> > file memory only, even though the actual amount of file memory is low.
> > This will cause over-reclaiming from file memory and dismissing anon
> > memory that we should have reclaimed, which means that we will need
> > additional reclaim iterations to actually free memory.
> >
> > I believe this scenario would be possible with ratelimiting, right?
> >
>
> So, the (old_file >> sc->priority) > 0 is true but the (new_file >>
> sc->priority) > is false. In the next iteration, (old_file >>
> (sc->priority-1)) > 0 will still be true but somehow (new_file >>
> (sc->priority-1)) > 0 is false. It can happen if in the previous
> iteration, somehow kernel has reclaimed more than double what it was
> supposed to reclaim or there are concurrent reclaimers. In addition the
> nr_reclaim is still less than nr_to_reclaim and there is no file
> deactivation request.
>
> Yeah it can happen but a lot of wierd conditions need to happen
> concurrently for this to happen.

Not necessarily sc->priority-1. Consider two separate sequential
reclaim attempts. At the same priority, the first reclaim attempt
could rightfully enter cache trim mode, while the second one
wrongfully enters cache trim mode due to stale stats, over-reclaim
file memory, and stall longer to actually reclaim the anon memory.

I am sure such a scenario is not going to be common, but I am also
sure if it happens it will be a huge pain to debug.

If others agree that this is fine, let's document this with a comment
and in the commit log. I am not sure how common the cache trim mode is
in practice to understand the potential severity of such problems.
There may also be other consequences that I am not aware of.

