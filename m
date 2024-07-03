Return-Path: <linux-kernel+bounces-240341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B83926C65
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 01:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E86F1F23541
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F68191F63;
	Wed,  3 Jul 2024 23:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YfmZa87K"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E375A4964E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 23:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720049022; cv=none; b=AqVG852eNGne5IWZzNQDFhrn8exrMDEq5GSXL688nnVfzA/mESi6DvRjWtbecV/NFHe3N1/r+jda12S8KsoFK2p/j7LOMs1H9v0ybnZSU0jeLhEoo7KAlnY2lMzxmPYn2Ek1tWA75EQ5VebIYtrFxRjMptJhfQeNTN+6edgkQBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720049022; c=relaxed/simple;
	bh=sJMsTEcBixQOjYu/BC11/w3Hj6KoQWDe/4zVnNtrx/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jOVVfDCD3KITJnzV9OeaPoVVn/xsUkMoFQkf3Ivgt78YaJdcTEwkpTmUcrGqu7YzNl+KqtsP4Dam2PTWZeZ/U5a9U5EEm6YU/do93ZmNYlkbxLJduhK6a3M6vOcnAXvKv774+kXL3D/1Nb3kWZYTmdsFLlB9TuWUqsZfEMqd1Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YfmZa87K; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6325b04c275so408117b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 16:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720049020; x=1720653820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xg7ZFYxg6MzMytZKSdjILWDWCgootdYg7RDChywshAY=;
        b=YfmZa87KWqJTonk36ObScG6uLRB11tJ60WVScgu6EAiu4z4uQeqXMOf3rZt6oSXSY5
         wSBmg+1dLNKwoLMaoIezoLOrRvXo5B2p3ugsquurmS0VWhRm9kJQG6IXXiJ7lNefjfRY
         z9Qz/jQDkBXdl/R0hgTLLmHHaIxRwzFkcUJBz09XbF+71zZCdvWOQwN0QdNfPWGjC1GE
         KINtB7HXMeXz15HShR3YHRLXxQ03gBIFfY11xQlgVI2Cx6HNo6386zHdtdQQC007AziG
         Q0nH7AXQhCLqKMgs2Iq8D/Pyn8z0Zjzjjg974POZS6jsUt9DLgjpru5/VEGodql1aTP0
         hR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720049020; x=1720653820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xg7ZFYxg6MzMytZKSdjILWDWCgootdYg7RDChywshAY=;
        b=Dn7bVxaiFdqxOfhA3b0Zn7+tdTdvv3Rw5IMZLHD3k+ATgXVd4FvLUo+jU4NxDwnmer
         UUGB+UG05/IgNVsVCInNTltFyYet/tuVvuDGpe8n4jSWxUGkZ7j0UVt0NwAjNVdzdsoT
         3FNZ3M2ktoiPoikO8JFQPlrN5zMNMbXtr1Sn7VD/fpXEtczEa6Mx9eosT0wP5zJOJ3pr
         9wIsznyWVvsE1axgxCTPATehb237LnFrOyAzuLHb5xGbT0tOdNpC/bS9DW7LBmpJ57qb
         V27R9AwrYaKHqdWKlamSCnsph9Lu6kjk8Cev1GMrp1ukO9cjJS8I+TLESyuXCStM14Ca
         j8zw==
X-Forwarded-Encrypted: i=1; AJvYcCXD6k4pVdD35vlBxo6dps9ln46QgpZNLp3g7QSQGBQoHFUHc93XhcsXnAdWnXYt8gR5t7dZ+Pb/0pjdmAEDLOtb6kVfJGx4i511V1i2
X-Gm-Message-State: AOJu0YzG6zqOY9m5mZVII2zD5Z0d4IxI159Khr8PgJvWpL61xEVDkb5A
	32GKq+FxCfMwMKoLzrsHmx81VP15Mt7A2AejfJcCMS9/ajY7fmxr6vJoNsSzxsdT+8m/WfN18dQ
	TiX+qwbYLxJshJHuvSMEmWKO58er938zigR4X
X-Google-Smtp-Source: AGHT+IEIiWXIUIbYrxGIqgFmBLI7Sc27hKlFe1jKVxcoJG6ybIJXGaRuACIgWrhwabfFA+SUjfLGjLrMfU6rTxcgW90=
X-Received: by 2002:a81:9f08:0:b0:61b:1e81:4eb8 with SMTP id
 00721157ae682-652d5225a14mr226637b3.9.1720049019542; Wed, 03 Jul 2024
 16:23:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703221520.4108464-1-surenb@google.com> <20240703155129.cbd023c14dee61e5727bb750@linux-foundation.org>
In-Reply-To: <20240703155129.cbd023c14dee61e5727bb750@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 3 Jul 2024 16:23:27 -0700
Message-ID: <CAJuCfpFGRmQXxkaUjasyVGu74su_a-319o5zYe_eJD_KfbmNdg@mail.gmail.com>
Subject: Re: [PATCH 1/1] sched.h: always_inline alloc_tag_{save|restore} to
 fix modpost warnings
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, kent.overstreet@linux.dev, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 3:51=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Wed,  3 Jul 2024 15:15:20 -0700 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > Mark alloc_tag_{save|restore} as always_inline to fix the following
> > modpost warnings:
> >
> > WARNING: modpost: vmlinux: section mismatch in reference: alloc_tag_sav=
e+0x1c (section: .text.unlikely) -> initcall_level_names (section: .init.da=
ta)
> > WARNING: modpost: vmlinux: section mismatch in reference: alloc_tag_res=
tore+0x3c (section: .text.unlikely) -> initcall_level_names (section: .init=
.data)
>
> Well, is it only about fixing warnings?  If the warning is correct then
> this might be fixing kernel crashes.
>
> Do you know where these references are coming from?

I *think* this happens when alloc_tag_save()/alloc_tag_restore() are
not inlined and are called from an __init function.  They access the
`tag` parameter passed to them and since that tag is a static local
variable inside an __init function, I assume it gets allocated inside
__initdata. If so, an example of such case is cma_activate_area()
which is an __init function and allocates memory using
bitmap_zalloc():
https://elixir.bootlin.com/linux/v6.10-rc6/source/mm/cma.c#L97. There
are likely more cases like that.

>
> I'm curious about the .text.unlikely.  Makes me wonder if we should
> also have .init.unlikely for unlikely() calls which happen from __init
> code.  Maybe we already handle that.

I don't really know.

>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202407032306.gi9nZsBi-lkp=
@intel.com/
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Cc: Kent Overstreet <kent.overstreet@linux.dev>
>
> Fixes: 22d407b164ff ("lib: add allocation tagging support for memory allo=
cation profiling")

Yes. Do you want me to post a v2 or will handle that locally?

> Cc: stable

I don't think so. This feature was introduced in 6.10, so no backports
needed, right?

>
> yes?
>
>

