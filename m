Return-Path: <linux-kernel+bounces-223418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8189D91129B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D74EDB22AA9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 19:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64C81B47B9;
	Thu, 20 Jun 2024 19:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sqmDW9Z+"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6103D575
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 19:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718913267; cv=none; b=YAt3ex2lunlydTFJZe5OANOvT6f5cSu1QvCQPLhvR1YqPkLQC0yoN4CJQjhQ5k1ay7uvtN9LzRDW3vKU5he7AOt+ZXLxTUkfWmOBrZ8bTr/ud9ZMYrL0XUUudi8q2psk+haUhW7nmaGPMuW8BCVRQ+P9tqg3RPk7X2V3qOaeDL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718913267; c=relaxed/simple;
	bh=BLZ4+99zlaXYewrSKS/BeWr6vPLy/tesWoL9XhfXIxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tZFsVJ/zQE1kaNrhgB3tfq1Bw6xJ2ZyGKKNuTeU0SX/5kXhmOW9xIAblbsAKAw1uk2Ac7VgtrdvxHR+529KAjgK5DWIgGaxnzLl6B4eCvPbB8yfeFsJx8ANVK9ko81IT91fTFAgp+OfTN/rsExu1FM+qOKHqhAkVQlQo26eJk7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sqmDW9Z+; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4217dbeb4caso11566915e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 12:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718913264; x=1719518064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YcaMH55LLUeG7NrepQHRnj4cJbGnKrphz5BhzNZk32g=;
        b=sqmDW9Z+HV2blw+YAkVEFfEWEBBFATSslbjoZA0VckQ0x4NJaHS29GDV6cSSwdz9DJ
         BzyZIlj3ucUgdMUXA4ZAb+11A03tOAoPWKyALXLD+oKZs4NjzO5Jvbpy7MJ6yw7XdR0p
         xN768ZvWnuaxjo24BNER4syqvU5qx/zN0WG7bi5aP8Q51NBvAFy6W9iZTCVkLAnJueRd
         J8WUKkoFqQ4KT8PrC40OMs0f+BUzUEUG4yX1lLf0Ii5suVQVKCfpKspJhFRPYg6a+YU2
         eLIupmjLfIj0+na7q9RueBZPZQyH05oDa+HO0Eqz7kUZou5aDCYB3JTv91sPnfa0wTrQ
         dHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718913264; x=1719518064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YcaMH55LLUeG7NrepQHRnj4cJbGnKrphz5BhzNZk32g=;
        b=MLJuPr3d77pe2VQywTalsOT1lzS5fL1HACGXzLE5TcvmZ5D70MATXJaor63BL9v4Uo
         RwnhVH4zukxDm+HR56AaUu7ilwaTG6pyrwK5KxWna1ZNfSUsdUPeG++PkcxTaTOyH4dL
         VC93vBZvSgb/7jnMFhhvzuY8ylzC2nuLJNAMx5YHEboh6HSM9HSOXM8mbbBM+9GFQj0d
         QpV0HtEFS2kjh0kOvPjzx25TQP1SE+hVYpJWJRzeFJYhyVvN1FtjAw9zdTAfvp02y+IV
         XA/8h7vzdciMEWDnQpMlNiDbGPZWzoRut9nsu84TXKjXKHEvWzzwtiuB8gx15KAsBDEb
         AK/g==
X-Forwarded-Encrypted: i=1; AJvYcCXcDxtsG4m3HkdgejSepJjTC3PsCoetMvO4g8cfcZFDZbzl8hG0ic97FoqOUqUF05Lp7I63QCfeVBG+c0ytt1WjRpQOdrYYYwr/BqX0
X-Gm-Message-State: AOJu0YyZIl8vOYiiStWM5+363tMhklv6uwr9LFyylTUpyBvO+DnXe+FZ
	IhliMXI1Zzdp5FJL4pJe6i1A8nKMfT5Iaecu/BFLC0H22w4rqoXnvIbGZhx5avFV5XlVVu4GWWl
	X7sfBEivjDbFrrvG0m7yNXn+5YRU7I+MZgeQy
X-Google-Smtp-Source: AGHT+IHbb0ns1VcAL2AuPsJP0VuRb7bEni14HNl55IoSwWc7cQ1UsbBgY8bSBKed9IK11uNfM7jlCgePEyPllxvYmpk=
X-Received: by 2002:a05:600c:2252:b0:424:798a:f7f6 with SMTP id
 5b1f17b1804b1-424798afe74mr42769395e9.8.1718913264293; Thu, 20 Jun 2024
 12:54:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620181736.1270455-1-yabinc@google.com> <CAKwvOd=ZKS9LbJExCp8vrV9kLDE_Ew+mRcFH5-sYRW_2=sBiig@mail.gmail.com>
 <CAKwvOd=DkqejWW=CTmaSi8gqopvCsVtj+63ppuR0nw==M26imA@mail.gmail.com>
In-Reply-To: <CAKwvOd=DkqejWW=CTmaSi8gqopvCsVtj+63ppuR0nw==M26imA@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 20 Jun 2024 12:54:10 -0700
Message-ID: <CAKwvOdm+uudyu_JrHUBBJnU_R4GYprym6HWmcYYyHoCspbcL3Q@mail.gmail.com>
Subject: Re: [PATCH] Fix initializing a static union variable
To: Yabin Cui <yabinc@google.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	"Ballman, Aaron" <aaron.ballman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 12:47=E2=80=AFPM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Jun 20, 2024 at 12:31=E2=80=AFPM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Thu, Jun 20, 2024 at 11:17=E2=80=AFAM Yabin Cui <yabinc@google.com> =
wrote:
> > >
> > > saddr_wildcard is a static union variable initialized with {}.
> > > But c11 standard doesn't guarantee initializing all fields as
> > > zero for this case. As in https://godbolt.org/z/rWvdv6aEx,
> >
> > Specifically, it sounds like C99+ is just the first member of the
> > union, which is dumb since that may not necessarily be the largest
> > variant.  Can you find the specific relevant wording from a pre-c23
> > spec?
> >
> > > clang only initializes the first field as zero, but the bits
> > > corresponding to other (larger) members are undefined.
> >
> > Oh, that sucks!
> >
> > Reading through the internal report on this is fascinating!  Nice job
> > tracking down the issue!  It sounds like if we can aggressively inline
> > the users of this partially initialized value, then the UB from
> > control flow on the partially initialized value can result in
> > Android's kernel network tests failing.  It might be good to include
> > more info on "why this is a problem" in the commit message.
> >
> > https://godbolt.org/z/hxnT1PTWo more clearly demonstrates the issue, IM=
O.
> >
> > TIL that C23 clarifies this, but clang still doesn't have the correct
> > codegen then for -std=3Dc23.  Can you please find or file a bug about
> > this, then add a link to it in the commit message?
> >
> > It might be interesting to link to the specific section of n3096 that
> > clarifies this, or if there was a corresponding defect report sent to
> > ISO about this.  Maybe something from
> > https://www.open-std.org/jtc1/sc22/wg14/www/wg14_document_log.htm
> > discusses this?
>
> https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3011.htm
>
> https://clang.llvm.org/c_status.html mentions that n3011 was addressed
> by clang-17, but based on my godbolt link above, it seems perhaps not?

Sorry, n3011 was a minor revision to
https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2900.htm
which is a better citation for this bug, IMO.  I still think the clang
status page is wrong (for n2900) and that is a bug against clang that
should be fixed (for c23), but this kernel patch still has merit
(since the issue I'm referring to in clang is not what's leading to
the test case failures).

>
> 6.7.10.2 of n3096 (c23) defines "empty initialization" (which wasn't
> defined in older standards).
>
> Ah, reading
>
> n2310 (c17) 6.7.9.10:
>
> ```
> If an object that has static or thread storage duration is not
> initialized explicitly, then:
> ...
> =E2=80=94 if it is a union, the first named member is initialized
> (recursively) according to these rules, and
> any padding is initialized to zero bits;
> ```
>
> Specifically, "the first named member" was a terrible mistake in the lang=
uage.
>
> Yikes! Might want to quote that in the commit message.
>
> >
> > Can you also please (find or) file a bug against clang about this? A
> > compiler diagnostic would be very very helpful here, since `=3D {};` is
> > such a common idiom.
> >
> > Patch LGTM, but I think more context can be provided in the commit
> > message in a v2 that helps reviewers follow along with what's going on
> > here.
> >
> > >
> > > Signed-off-by: Yabin Cui <yabinc@google.com>
> > > ---
> > >  net/xfrm/xfrm_state.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> > > index 649bb739df0d..9bc69d703e5c 100644
> > > --- a/net/xfrm/xfrm_state.c
> > > +++ b/net/xfrm/xfrm_state.c
> > > @@ -1139,7 +1139,7 @@ xfrm_state_find(const xfrm_address_t *daddr, co=
nst xfrm_address_t *saddr,
> > >                 struct xfrm_policy *pol, int *err,
> > >                 unsigned short family, u32 if_id)
> > >  {
> > > -       static xfrm_address_t saddr_wildcard =3D { };
> > > +       static const xfrm_address_t saddr_wildcard;
> > >         struct net *net =3D xp_net(pol);
> > >         unsigned int h, h_wildcard;
> > >         struct xfrm_state *x, *x0, *to_put;
> > > --
> > > 2.45.2.741.gdbec12cfda-goog
> > >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers
>
>
>
> --
> Thanks,
> ~Nick Desaulniers



--=20
Thanks,
~Nick Desaulniers

