Return-Path: <linux-kernel+bounces-325396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EB1975924
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F32301F2728B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170DA1B3728;
	Wed, 11 Sep 2024 17:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FvfOstzT"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FE21AC451
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 17:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726074944; cv=none; b=cJllO13mmY1zTkqQsD5YiouemGMz4075VTAc1r6/Xk7vb7z3HVXoZKzLRDmHtdXT5tj6wsXL2x5zdaRGv7Nio3jxz5Nnc1lYXqZ7mExrzLU8Qwnm0/RigBVe4CHo6PFo11QNwKzJgTfvCOQ/ZaAMJ5i2xvjpp8ES5YOgXv0tXqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726074944; c=relaxed/simple;
	bh=EkfZbnNAKZJKt6YdxlmCLpGjMHhUaFXO+vzODlsvHIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0vqwap3OiLCwc8NHdpN+Vn/TBXOsllfWXHCkj0zNyX8l1tr+LaC9sqhxkme5tqp0uHRRpAW1HDzzdTmXbCmly6+Wd94NSLm66+soYea1cSNj6UJttztHTYRNHlmMSZeuhBWsr5bgsacftL2XJTS9ZbiGt2uPtRMdDdrT0gsRSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FvfOstzT; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8ce5db8668so12924566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726074941; x=1726679741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Wj3u/SZcZ84wv0uyyDUXwk0NeAqrzZGdvX2dGOPDIk=;
        b=FvfOstzTEXHCtEIdWFah15VFcO9wxSGJUok1lP+8LMoWLVYgwGs0cQak3aW5IkP2iZ
         /9tS9wuLFH8ittp755CfxVpjCqMjYS8ZRY8T2eejuuvYYP1GzDVYsK4wh+7c8WNvh8CS
         ZeVPADU8lQcyItxIynaUO0Ov2PBQ2nXYtdVGDVSsdPVanBPfM9HzucMqXK69flCn+qIk
         qWP1C+DDfLrIl0oS568tv5j5muQRVgFA0UwsfoeRfDJQHRimup4Ijg2/EryPQRVYT7Pn
         DHYa0lCCaLEu+ioCJVLS2j/onCD01HX99TgSIZKPTVLITuPLSkT8CZ8xiIUWVrMzXbgW
         AM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726074941; x=1726679741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Wj3u/SZcZ84wv0uyyDUXwk0NeAqrzZGdvX2dGOPDIk=;
        b=IbN5q4tLoOe6VHdOgUO1QbpmRD7B5iaBXVllGDEu/O3O6CKUKT9XkmhGy41srEWI6j
         /c9kjKJUmNaM+Ev0sMNKe7chN7yLO47aabhP81ml/N8nvVUyHIDodE8BCSRMOfz1+S1e
         qmLFrhQ5KKCjCtBLEabSdl/jTd/o6dZOyQJhZlUWixhoqsMjS90MJNMs1TSdjUB6nWCX
         H0CYgwz+aecLFjI4KHirb3O51rbumcj2P3fzQPpbW5FNRzUi4K8IukT/JKd4gTvVQrUS
         CwcNpy0bPAqbtVKrxqgnC8m4233H0XN+XaiisSBDw2At59iDMFnDjKy7RorGpxOoGjdT
         8Bfw==
X-Forwarded-Encrypted: i=1; AJvYcCXM+yYRvGWqr8a2LU+JtxtxpGfwQPf/M3XHh7sxGq9qe63B6pUH9ioNa4rQL9V82Rju+RHiRjFr3qgUzVk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9KH/OhtK8EdPd6rpLOT3lJ30H92gWU/lXF00KuMqY7oNcQmSv
	fTB+nlh4Nm+FHW0mG9yl/rJEp/68ju/12ZaF+2DeUDkaYxJIBNJ+b0NtQKrfRIaaLalaNNWzcTZ
	UovfGchPFoZLpKrgc/9MaiYWkiEAvHOWmmC4f
X-Google-Smtp-Source: AGHT+IG9+mNNmawqAYJSFLQ64vrBkqwuGsEE/AFuujnaeVEYCrzRJ5PrIIKl1JRvWNsXpJGXlLUNrxnEyeaesDYs8xY=
X-Received: by 2002:a17:907:e28c:b0:a8a:837c:ebd4 with SMTP id
 a640c23a62f3a-a9029491985mr19094766b.27.1726074940275; Wed, 11 Sep 2024
 10:15:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911050435.53156-1-qianqiang.liu@163.com> <CANn89iKhbQ1wDq1aJyTiZ-yW1Hm-BrKq4V5ihafebEgvWvZe2w@mail.gmail.com>
 <ZuFTgawXgC4PgCLw@iZbp1asjb3cy8ks0srf007Z> <CANn89i+G-ycrV57nc-XrgToJhwJuhuCGtHpWtFsLvot7Wu9k+w@mail.gmail.com>
 <ZuHMHFovurDNkAIB@pop-os.localdomain>
In-Reply-To: <ZuHMHFovurDNkAIB@pop-os.localdomain>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 11 Sep 2024 19:15:27 +0200
Message-ID: <CANn89iJkfT8=rt23LSp_WkoOibdAKf4pA0uybaWMbb0DJGRY5Q@mail.gmail.com>
Subject: Re: [PATCH] net: check the return value of the copy_from_sockptr
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Qianqiang Liu <qianqiang.liu@163.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 6:58=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.com=
> wrote:
>
> On Wed, Sep 11, 2024 at 11:12:24AM +0200, Eric Dumazet wrote:
> > On Wed, Sep 11, 2024 at 10:23=E2=80=AFAM Qianqiang Liu <qianqiang.liu@1=
63.com> wrote:
> > >
> > > > I do not think it matters, because the copy is performed later, wit=
h
> > > > all the needed checks.
> > >
> > > No, there is no checks at all.
> > >
> >
> > Please elaborate ?
> > Why should maintainers have to spend time to provide evidence to
> > support your claims ?
> > Have you thought about the (compat) case ?
> >
> > There are plenty of checks. They were there before Stanislav commit.
> >
> > Each getsockopt() handler must perform the same actions.
>
>
> But in line 2379 we have ops->getsockopt=3D=3DNULL case:
>
> 2373         if (!compat)
> 2374                 copy_from_sockptr(&max_optlen, optlen, sizeof(int));
> 2375
> 2376         ops =3D READ_ONCE(sock->ops);
> 2377         if (level =3D=3D SOL_SOCKET) {
> 2378                 err =3D sk_getsockopt(sock->sk, level, optname, optv=
al, optlen);
> 2379         } else if (unlikely(!ops->getsockopt)) {
> 2380                 err =3D -EOPNOTSUPP;         // <--- HERE
> 2381         } else {
> 2382                 if (WARN_ONCE(optval.is_kernel || optlen.is_kernel,
> 2383                               "Invalid argument type"))
> 2384                         return -EOPNOTSUPP;
> 2385
> 2386                 err =3D ops->getsockopt(sock, level, optname, optval=
.user,
> 2387                                       optlen.user);
> 2388         }
>
> where we simply continue with calling BPF_CGROUP_RUN_PROG_GETSOCKOPT()
> which actually needs the 'max_optlen' we copied via copy_from_sockptr().
>
> Do I miss anything here?

This is another great reason why we should not change current behavior.

err will be -EOPNOTSUPP, which was the original error code before
Stanislav patch.

Surely the eBPF program will use this value first, and not even look
at max_optlen

Returning -EFAULT might break some user programs, I don't know.

I feel we are making the kernel slower just because we can.

