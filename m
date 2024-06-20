Return-Path: <linux-kernel+bounces-223409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B18911282
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 485A3286C21
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 19:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1D61B4C35;
	Thu, 20 Jun 2024 19:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e1ccJKNO"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5E613AF9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 19:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718912876; cv=none; b=In1AUagCcVtPwZEH84v0KmEJ/KxRJwGNobLOfeoCElniZJ5xRcsZW0q7JPA2Cy/T+wOo0G7YzLmynWyB7hXR1v7q4F0k+FL8Mq3zX2T6gULYxUzxn6jACg3Ql9+Z6rByv1UWUpMrKraMlPeWGufh5pvAUcbZou6W6ApJNsyDqfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718912876; c=relaxed/simple;
	bh=862VnKCkNLOQBFx4YiOtMqgmmlHiFEVEMCgVVYka2b0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z/rH1Yv+sI/N/Ms0MTT14++NKK+V4EtL3Cw+kPw/3u6bqlQ5K/HhDHLtXigsL3u7EnIeVt6rrrKd1lyHoVyPV8XLYouTN67hpLW0y49W1BEWipqOJNtgljzdK4GeiTcfFCi2Q3FgJOiZ7YaPWac3fRXqxgQm9dqm5wJLnJJgMEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e1ccJKNO; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-364a3d5d901so928447f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 12:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718912873; x=1719517673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNc529DGB2kuH106Zk8B0JpwUGAF1N0DtZphSOYR/oA=;
        b=e1ccJKNOJt2tzyXSUx2TkoB/EjTqYkTSxTzqaVWiqO5gYrGz3zyzsnNHOAxycDlxJH
         Oqowd+uu2DIZW5haxf7TvLOLuu0AD0sZU/F19P0eZ26CppDnmWQBoOC4ljir8Dy1h+la
         23WiafSbHkMiet7XTD3QrGDqHM8lq+RN3pyHZqWRGoQExFPQpkd5IkqKuZTsaO4ToMAP
         XpExof24tzYUjLGlTG9R/SXVCb00TfY+o8uIiug814DBxGcjlz+EOyHh9aVCCeqQ4obF
         kuntbGzTyt2+7VL6NQY8V9BbEdLtDpgWiIgq/TWU8IvUTXnNSzyPTnr0GPc9KLFyycY9
         D2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718912873; x=1719517673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNc529DGB2kuH106Zk8B0JpwUGAF1N0DtZphSOYR/oA=;
        b=tbN9P/kjykgLg2lHOkmpSqCd1Nfp8/WNkK21d6It6o4mue+7Wh8/78LqXiMYG4mEu6
         9PbPJM0k+TD1MagijbVTON7+st9b9jaPBcW0KQXS9cqTS7U8lKG/0PjsHu/TzjxiC30q
         gCa4yyyvdBUhiV4dXd/h8/xNotduMgPa3HCnc7zRpY/Pt+UEqbfktwhQRlZKyiB1Dipu
         3s+bwKcDUx3546DI0GvHpCVyQBRcBIm4fmGxrTwzQzYyQlK9CBuUSFCMxbm0PjRp+Dft
         RG0yfWlP7KO64greFUdK7OTKjo3Hm+ZUU8iTzc3ctEDbvFC+25GjC+uve9U/F11R2Oq+
         Q75Q==
X-Forwarded-Encrypted: i=1; AJvYcCWVRjSPGq3NNSetoCApJQfubP3PL0JZTfUr6qEjpu3Gx9/u4JRaWWQgBsTxcqGHuMsTp3H1lyRP3DhkxWKsos8zdVVP0z7YmeqoWwYr
X-Gm-Message-State: AOJu0YwpNGp0REn65sPtS7dv+3hRlmb5+L+tctwz6Wq76ki+vyP+Ag6I
	c8lthoPvJX9OXz9vg23xPdyI23EFOMAM+XyBRgwc8lNTzTFQpL1EFpk/bWPV0TdmC3nhc7oc5L/
	gJNuY5n+Xha43qX9V1k5EAhJN0R48JQbtN2a1
X-Google-Smtp-Source: AGHT+IGrPdVcwRWI9jIOBc7bAbM6sVLQ+zmTwl426aeO1W5z9G541aNdbPXNTDAPA+cczAeOT5b6A7edctQRuwcrJCE=
X-Received: by 2002:a05:6000:1fa4:b0:365:862f:21c8 with SMTP id
 ffacd0b85a97d-365862f260bmr1468996f8f.53.1718912872814; Thu, 20 Jun 2024
 12:47:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620181736.1270455-1-yabinc@google.com> <CAKwvOd=ZKS9LbJExCp8vrV9kLDE_Ew+mRcFH5-sYRW_2=sBiig@mail.gmail.com>
In-Reply-To: <CAKwvOd=ZKS9LbJExCp8vrV9kLDE_Ew+mRcFH5-sYRW_2=sBiig@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 20 Jun 2024 12:47:42 -0700
Message-ID: <CAKwvOd=DkqejWW=CTmaSi8gqopvCsVtj+63ppuR0nw==M26imA@mail.gmail.com>
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

On Thu, Jun 20, 2024 at 12:31=E2=80=AFPM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Jun 20, 2024 at 11:17=E2=80=AFAM Yabin Cui <yabinc@google.com> wr=
ote:
> >
> > saddr_wildcard is a static union variable initialized with {}.
> > But c11 standard doesn't guarantee initializing all fields as
> > zero for this case. As in https://godbolt.org/z/rWvdv6aEx,
>
> Specifically, it sounds like C99+ is just the first member of the
> union, which is dumb since that may not necessarily be the largest
> variant.  Can you find the specific relevant wording from a pre-c23
> spec?
>
> > clang only initializes the first field as zero, but the bits
> > corresponding to other (larger) members are undefined.
>
> Oh, that sucks!
>
> Reading through the internal report on this is fascinating!  Nice job
> tracking down the issue!  It sounds like if we can aggressively inline
> the users of this partially initialized value, then the UB from
> control flow on the partially initialized value can result in
> Android's kernel network tests failing.  It might be good to include
> more info on "why this is a problem" in the commit message.
>
> https://godbolt.org/z/hxnT1PTWo more clearly demonstrates the issue, IMO.
>
> TIL that C23 clarifies this, but clang still doesn't have the correct
> codegen then for -std=3Dc23.  Can you please find or file a bug about
> this, then add a link to it in the commit message?
>
> It might be interesting to link to the specific section of n3096 that
> clarifies this, or if there was a corresponding defect report sent to
> ISO about this.  Maybe something from
> https://www.open-std.org/jtc1/sc22/wg14/www/wg14_document_log.htm
> discusses this?

https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3011.htm

https://clang.llvm.org/c_status.html mentions that n3011 was addressed
by clang-17, but based on my godbolt link above, it seems perhaps not?

6.7.10.2 of n3096 (c23) defines "empty initialization" (which wasn't
defined in older standards).

Ah, reading

n2310 (c17) 6.7.9.10:

```
If an object that has static or thread storage duration is not
initialized explicitly, then:
...
=E2=80=94 if it is a union, the first named member is initialized
(recursively) according to these rules, and
any padding is initialized to zero bits;
```

Specifically, "the first named member" was a terrible mistake in the langua=
ge.

Yikes! Might want to quote that in the commit message.

>
> Can you also please (find or) file a bug against clang about this? A
> compiler diagnostic would be very very helpful here, since `=3D {};` is
> such a common idiom.
>
> Patch LGTM, but I think more context can be provided in the commit
> message in a v2 that helps reviewers follow along with what's going on
> here.
>
> >
> > Signed-off-by: Yabin Cui <yabinc@google.com>
> > ---
> >  net/xfrm/xfrm_state.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> > index 649bb739df0d..9bc69d703e5c 100644
> > --- a/net/xfrm/xfrm_state.c
> > +++ b/net/xfrm/xfrm_state.c
> > @@ -1139,7 +1139,7 @@ xfrm_state_find(const xfrm_address_t *daddr, cons=
t xfrm_address_t *saddr,
> >                 struct xfrm_policy *pol, int *err,
> >                 unsigned short family, u32 if_id)
> >  {
> > -       static xfrm_address_t saddr_wildcard =3D { };
> > +       static const xfrm_address_t saddr_wildcard;
> >         struct net *net =3D xp_net(pol);
> >         unsigned int h, h_wildcard;
> >         struct xfrm_state *x, *x0, *to_put;
> > --
> > 2.45.2.741.gdbec12cfda-goog
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



--=20
Thanks,
~Nick Desaulniers

