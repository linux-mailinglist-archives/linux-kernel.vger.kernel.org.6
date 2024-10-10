Return-Path: <linux-kernel+bounces-359890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5946C999201
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FA501F27F64
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272971CF5C3;
	Thu, 10 Oct 2024 19:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="M1+xncv2"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7181CEABD
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 19:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728587652; cv=none; b=U83M5yCWpYYW5+Dhud+E+q8a8OqhCf4/y0JShAEKNy57m4S/xxrwsHVPsLL0ByexMp5f4OLJOJ9aENLJZuwcGlwcNadvwd433Upt/9WLkWeqpMvisVT4IgzXTz/nbJExjMrTbkb+o9kajDWeW+hsbPdWfUMcRvqgLcQmAeVPt9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728587652; c=relaxed/simple;
	bh=9J2YZOewo+gdC+S01tNmNL+06a41vIYYBHxKTP6AoZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rtgo8uyUUG6XMjwB/o7Tiv/IZH97ZIJbRD5+68gAhJG3Wi601FswnVxxX/5MuTRqUx/XQTjfQqKJkeJCTNCAoQBhvdNkPfNyNwrb8HG78rkYm4xiTqYNwE5ng4u5HN124ExHxxC1Zc+j/4fSHwstWnaG4eWGBYUcxEBRH/pojAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=M1+xncv2; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6e2e41bd08bso15499927b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728587650; x=1729192450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6Pg6F94tMjt4Hzd0hbiOJ9IN5nlvNjG3qJM+Incf8Y=;
        b=M1+xncv2b0E6e1amM7U3ZuPbA7r9Iqh3YGPqXg79nKJTppswu5Ar1d7dDyHsvcR9H6
         9kEApomQqMlwwd/qGWB2eC339+sFkcpz45hp4lX3Z0inJcwy8fET7AoSm+ZpOVKBmY9/
         w52SfAfYDdE16n6Ve8abZMXWexhlqz/GVccUaDuYcPBJEBr7zIYDlrx2x7PpxjeHuqmL
         FBPpgULGwWpjXCJ7z1JCmSIOGC5aKDRrn2JpKKuuQLdnELpgYkByYxVQuC2rXVJz+V8p
         Mg9ujGmLpd+EqRLzxANQyl0hFsCl6qxm6+4IKOaDc66VputxU2vKxvDLyiqkZymiFBJ5
         xvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728587650; x=1729192450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6Pg6F94tMjt4Hzd0hbiOJ9IN5nlvNjG3qJM+Incf8Y=;
        b=oaDH8O/yH47wjd5sMALtQhbKBhQQKRLgoIYGK9s4UsT6cHBL6lZBhP9Iaf5PZvakog
         T5utf9dJCbRAtpByyXPzEUqW5z7FkRs0LMj+b8T5tU3lgxDD1CVbt/QKsgF3P4vnLxAn
         Gg1aVzr689y7PqF2e7SMVBSIZcqNY/SmxRLXRIrLufsfJUS8czT6Lq6R5WcPjyFxC6Lo
         eL9FrvB6a1tT7gllwxo1fyxsjJx2ORZ7gC+M312wExhoCrbbzsf6NVg9o/dcgBU7/tqs
         jF8sQq0pn3BcIffYy8l8R4TbyOxByQkk80YeThC0dn5G/N3K2wYTQgK1m2dH9wnkL7J+
         NwKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB7HjcDQ5SuVOwLoOCLflfrDTSXLDU/rmd22feLSXrWJTHyeCbzPPZdO1O6hy99JmlD0n74XuPDtp+z9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6m/dH44fcwVBAgnXrqjBm7IHJIvqvzbmVS3pjJc74blz3YoHp
	wWtzCoZO6rQCNGfixfPfxcwQwPnkgzGcejnyJTkVffmCAPSUH/oKeG5SabNREBR6/ItqHsWWMwe
	suK4kkq3ubf5qZeLaD/y7y7MICMfmgHU1xIYm
X-Google-Smtp-Source: AGHT+IHnv4orDez7mVyaCamNo5riXD5so7ejl6e+p+Fw01YmHomhmfIG+INttnHTWDIYhyHZKQAoeiK3WGnlHJxdHNw=
X-Received: by 2002:a05:690c:7602:b0:6dd:fb47:2184 with SMTP id
 00721157ae682-6e322121ac1mr65921917b3.13.1728587649945; Thu, 10 Oct 2024
 12:14:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009203218.26329-1-richard@nod.at> <20241009213345.GC3714@breakpoint.cc>
 <CAHC9VhSFHQtg357WLoLrkN8wpPxDRmD_qA55NHOUEwFpE_pbrg@mail.gmail.com>
 <20241009223409.GE3714@breakpoint.cc> <CAHC9VhTC=KAXe6w9xTG_rY4zAnNvPv-brQ7cTYftcty866inCw@mail.gmail.com>
 <20241010175925.GA11964@breakpoint.cc>
In-Reply-To: <20241010175925.GA11964@breakpoint.cc>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 Oct 2024 15:13:59 -0400
Message-ID: <CAHC9VhTW0nsoZk3bkfLU5WaGoJhK544+35Cap6=dzv=td_+OPA@mail.gmail.com>
Subject: Re: [PATCH] netfilter: Record uid and gid in xt_AUDIT
To: Florian Westphal <fw@strlen.de>
Cc: Richard Weinberger <richard@nod.at>, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com, 
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net, 
	kadlec@netfilter.org, pablo@netfilter.org, rgb@redhat.com, 
	upstream+net@sigma-star.at
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 1:59=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
> Paul Moore <paul@paul-moore.com> wrote:
> > Correct me if I'm wrong, but by using from_kXid(&init_user_ns, Xid) we
> > get the ID number that is correct for the init namespace, yes?  If so,
> > that's what we want as right now all of the audit records, filters,
> > etc. are intended to be set from the context of the initial namespace.
>
> Seems to be the case, from_kuid() kdoc says
> 'There is always a mapping into the initial user_namespace.'.
>
> I'm confused because of the various means of dealing with this:
> 9847371a84b0 ("netfilter: Allow xt_owner in any user namespace")
>
> Does: make_kgid(net->user_ns, ... and also rejects rule-add if
> net->user_ns !=3D current_user_ns().  As this is for matching userids,
> this makes sense to me, any userns will 'just work' for normal uid/gid
> matching.
>
> a6c6796c7127 ("userns: Convert cls_flow to work with user namespaces enab=
led")
> Does: from_kuid(&init_user_ns, ... and rejects rule adds if sk_user_ns(NE=
TLINK_CB(in_skb).ssk) !=3D &init_user_ns)
>
> Seems just a more conservative solution to the former one.
>
> 8c6e2a941ae7 ("userns: Convert xt_LOG to print socket kuids and kgids as =
uids and gids")
> ... which looks like the proposed xt_AUDIT change.
>
> As I do not know what the use case is for xt_AUDIT rules residing in
> another, possibly unprivileged network namespace not managed by root-root=
 user,
> I can't say if its right, but it should do the right thing.
>
> Sorry for the noise.

No worries, it was a fair question and discussion about this is rarely
a bad thing as it can get rather complicated somewhat quickly.  With
audit our current philosophy is that we try to do our logging and run
the filters within the context of the host/initial namespace for the
sake of consistency.  Of course this introduces some limitations and
"hide" some details specific to a child namespace, but it's the only
solution we could think of that allows the current kernel audit
implementation to behave in a comprehensive and sane manner across all
the various namespace/container solutions.

--=20
paul-moore.com

