Return-Path: <linux-kernel+bounces-352542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A44992085
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 21:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06DAD1F2173E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 19:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9323C189F2D;
	Sun,  6 Oct 2024 19:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ys7S/UoM"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6E417DFE4
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 19:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728241459; cv=none; b=sJo2UkEBOFvRMnxdsqi1gWxZRQLqCY6uW+ZDaHym1xlnwIMp3L3BWTRCptWMzCWqaH6a24W5ESmMBuNm0Rq712inNXS/CNaM3ijREyJ90G4Rl9cMzqHUI2BGshI53GAmRAG9TntxXPEqMFAykAYrvP6xJZFxMhdLyzcAzI6yPjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728241459; c=relaxed/simple;
	bh=HNrFd/PGUU8WcSrRQfH4Vzosl/k3lpvVnsKnl7wZPAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DnRHU7v9RbyhcnXPFVsbFM0Z77hmRcALGueoqRhGEGO60tbzmaw/RQmvtbZmjcxwmmrzXsyuZ9iahNTqWeqv5ll5HIGj2kWvcbU2LYy+vTwzrcgbLwD6aJ78tAmII2ZckY75K6Bl3LlRNurO/c9Op6YeJ6LMEgR8VY8OyimTv1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ys7S/UoM; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c721803a89so4966012a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 12:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728241456; x=1728846256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Fw0XseSH+Ve6ONa8vMAg4AER4YN4R6MDRkWml4yhFY=;
        b=Ys7S/UoMx8JnvgOEZTvvdKqhw7eVbxRc2E7uts2B1UAerBRo0hlhXWXTgkARu987+l
         ORYBzdi1jr3//xj1TAG3uM5rJUg9UAju7ko7stFR6Y5czjsfshLP1gSmPw3FxysUNl7V
         dMojuOmAoQB4m8zjyJadAtjl6lvt8HPwKDpFKoxtrMn0iGTrgidR994SMD1EXITtrP2U
         54Ee+Wqwci4kjiM11gclyL1cOYxiqRlFowlpdL4y9HGRh7dTwW8hGmsZer8WVfK3RTiG
         K379UoWHjbYWHz9yPYhMNkONAAYC6Fz1pjSsMG53b0ZCJbsj1wQ69ewk6lZcIsdB9Wwk
         FgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728241456; x=1728846256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Fw0XseSH+Ve6ONa8vMAg4AER4YN4R6MDRkWml4yhFY=;
        b=lP9sHdsvwUUdIbH0rWAqfGbHpBNwNyQvs22fEMjtZzMdyo6FNngX54D6jlHOYNAJXR
         dZdysNHqDb3+7qDBlDe7BRXo48p8ru2D1zClaWjwPduOkxmK0WSFw9DByTzvp7wwESKZ
         0HPbtcwDl9s5dM0/My/j32m2lMcdtjl3ikgL5Vj4UhGG7kMoNeBNC4UR+Wt3PPCrf9RS
         Ze53cb5/aI8uR+FZb2gMDvxzevURSd38+UkFKM2AjjnzcrKqn1/c1cOjrn5jevEnNhaV
         JM9lfxD2TqDHuiz5+bcfRgopbSLWUljGbfMAJbx2w+ao0Wjp/CPCgUaBEJaXpjklp9QM
         aDtg==
X-Forwarded-Encrypted: i=1; AJvYcCVl7hnWgbxv7YF0PRcPY29zFmxGA3cx8KTSNbr0zFXMHzxwCNaVVz0Yx8pHvrm7avkZv9SKD9qU4tvVFoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmdoPxmCPILa/tkmxlKiZFm8HotAqRQoUJ0+3Q+TtcXNo/xzMz
	Sp3C6mCN2NEinqvuaGM1oLGLcIjKUvLiVwH6/nhAZo6C0R4lUTxABLROCrDTEhLJdSKgg6JwxhG
	dh6p2DH1zGH/kQMv5LhvECCRgmiSSpG8HV+fI
X-Google-Smtp-Source: AGHT+IHLi6qgIbcAhmZ5d9BCterOP5EmT7+vJQipve8Oi/uMqinOIKtDjFyL2Zu250Y+Zrqg2kN+S6ARzBNQzVax93o=
X-Received: by 2002:a17:907:3f87:b0:a99:4e2e:6f58 with SMTP id
 a640c23a62f3a-a994e2e76dfmr296639666b.35.1728241456228; Sun, 06 Oct 2024
 12:04:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230830112600.4483-1-hdanton@sina.com> <f607a7d5-8075-f321-e3c0-963993433b14@I-love.SAKURA.ne.jp>
 <20230831114108.4744-1-hdanton@sina.com> <CANn89iLCCGsP7SFn9HKpvnKu96Td4KD08xf7aGtiYgZnkjaL=w@mail.gmail.com>
 <20230903005334.5356-1-hdanton@sina.com> <CANn89iJj_VR0L7g3-0=aZpKbXfVo7=BG0tsb8rhiTBc4zi_EtQ@mail.gmail.com>
 <20230905111059.5618-1-hdanton@sina.com> <CANn89iKvoLUy=TMxW124tiixhOBL+SsV2jcmYhH8MFh3O75mow@mail.gmail.com>
 <CA+G9fYvskJfx3=h4oCTAyxDWO1-aG7S0hAxSk4Jm+xSx=P1dhA@mail.gmail.com>
 <CADvbK_fxXdNiyJ3j0H+KHgMF11iOGhnjtYFy6R18NyBX9wB4Kw@mail.gmail.com> <CANn89iKrLE69O+qOuhGG0ts2zmxJzw5jAAFLfzspi8uOQe8pQw@mail.gmail.com>
In-Reply-To: <CANn89iKrLE69O+qOuhGG0ts2zmxJzw5jAAFLfzspi8uOQe8pQw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 6 Oct 2024 21:04:05 +0200
Message-ID: <CANn89i+WVuDascBvduzCK=-WYSdkcc6hy+_XmH+kxHwSf_6bSQ@mail.gmail.com>
Subject: Re: selftests: net: pmtu.sh: Unable to handle kernel paging request
 at virtual address
To: Xin Long <lucien.xin@gmail.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, Hillf Danton <hdanton@sina.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Netdev <netdev@vger.kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	LKML <linux-kernel@vger.kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 8:58=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Sun, Oct 6, 2024 at 8:08=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wr=
ote:
> >
> > Sorry for bringing up this issue, it recently occurred on my aarch64 ke=
rnel
> > with blackhole_netdev backported. I tracked it down, and when deleting
> > the netns, the path is:
> >
> > In cleanup_net():
> >
> >   default_device_exit_batch()
> >     unregister_netdevice_many()
> >       addrconf_ifdown() -> call_rcu(rcu, fib6_info_destroy_rcu) <--- [1=
]
> >     netdev_run_todo()
> >       rcu_barrier() <- [2]
> >   ip6_route_net_exit() -> dst_entries_destroy(net->ip6_dst_ops) <--- [3=
]
> >
> > In fib6_info_destroy_rcu():
> >
> >   dst_dev_put()
> >   dst_release() -> call_rcu(rcu, dst_destroy_rcu) <--- [5]
> >
> > In dst_destroy_rcu():
> >   dst_destroy() -> dst_entries_add(dst->ops, -1); <--- [6]
> >
> > fib6_info_destroy_rcu() is scheduled at [1], rcu_barrier() will wait
> > for fib6_info_destroy_rcu() to be done at [2]. However, another callbac=
k
> > dst_destroy_rcu() is scheduled() in fib6_info_destroy_rcu() at [5], and
> > there's no place calling rcu_barrier() to wait for dst_destroy_rcu() to
> > be done. It means dst_entries_add() at [6] might be run later than
> > dst_entries_destroy() at [3], then this UAF will trigger the panic.
> >
> > On Tue, Oct 17, 2023 at 1:02=E2=80=AFPM Naresh Kamboju
> > <naresh.kamboju@linaro.org> wrote:
> > >
> > > On Tue, 5 Sept 2023 at 17:55, Eric Dumazet <edumazet@google.com> wrot=
e:
> > > >
> > > > On Tue, Sep 5, 2023 at 1:52=E2=80=AFPM Hillf Danton <hdanton@sina.c=
om> wrote:
> > > > >
> > > > > On Mon, 4 Sep 2023 13:29:57 +0200 Eric Dumazet <edumazet@google.c=
om>
> > > > > > On Sun, Sep 3, 2023 at 5:57=3DE2=3D80=3DAFAM Hillf Danton <hdan=
ton@sina.com>
> > > > > > > On Thu, 31 Aug 2023 15:12:30 +0200 Eric Dumazet <edumazet@goo=
gle.com>
> > > > > > > > --- a/net/core/dst.c
> > > > > > > > +++ b/net/core/dst.c
> > > > > > > > @@ -163,8 +163,13 @@ EXPORT_SYMBOL(dst_dev_put);
> > > > > > > >
> > > > > > > >  void dst_release(struct dst_entry *dst)
> > > > > > > >  {
> > > > > > > > -       if (dst && rcuref_put(&dst->__rcuref))
> > > > > > > > +       if (dst && rcuref_put(&dst->__rcuref)) {
> > > > > > > > +               if (!(dst->flags & DST_NOCOUNT)) {
> > > > > > > > +                       dst->flags |=3D DST_NOCOUNT;
> > > > > > > > +                       dst_entries_add(dst->ops, -1);
> > > > > > >
> > So I think it makes sense to NOT call dst_entries_add() in the path
> > dst_destroy_rcu() -> dst_destroy(), as it does on the patch above,
> > but I don't see it get posted.
> >
> > Hi, Eric, would you like to move forward with your patch above ?
> >
> > Or we can also move the dst_entries_add(dst->ops, -1) from dst_destroy(=
)
> > to dst_release():
> >
> > Note, dst_destroy() is not used outside net/core/dst.c, we may delete
> > EXPORT_SYMBOL(dst_destroy) in the future.
> >
> >
>
> Current kernel has known issue with dst_cache, triggering quite often
> with  selftests: net: pmtu.sh
>
> (Although for some reason it does no longer trigger 'often' any more
> in my vng tests)

Simple hack/patch to 'disable' dst_cache, if you want to confirm the
issue is there.


diff --git a/net/core/dst_cache.c b/net/core/dst_cache.c
index 70c634b9e7b02300188582a1634d5977838db132..53351ff58b35dbee37ff587f7ef=
8f72580d9e116
100644
--- a/net/core/dst_cache.c
+++ b/net/core/dst_cache.c
@@ -142,12 +142,7 @@ EXPORT_SYMBOL_GPL(dst_cache_get_ip6);

 int dst_cache_init(struct dst_cache *dst_cache, gfp_t gfp)
 {
-       dst_cache->cache =3D alloc_percpu_gfp(struct dst_cache_pcpu,
-                                           gfp | __GFP_ZERO);
-       if (!dst_cache->cache)
-               return -ENOMEM;
-
-       dst_cache_reset(dst_cache);
+       dst_cache->cache =3D NULL;
        return 0;
 }
 EXPORT_SYMBOL_GPL(dst_cache_init);

