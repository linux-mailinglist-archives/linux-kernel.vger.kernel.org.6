Return-Path: <linux-kernel+bounces-299190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D48795D154
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 466AB285693
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB35188A2D;
	Fri, 23 Aug 2024 15:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JcuhpfdY"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2908C188A1B
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724426777; cv=none; b=iazFLfgB9rwgetDUCf29y8DmW6K9dHFXNvq6zin6ik2KwJf+9S3WtWzePgcM7DXUCjJ2YHmloBf9MaMT9l8dv8Xyq8xwk2yByhP/FElYAVdVRzhSylXCryPyMVsOVsiMXY38vgjh0/8QHJ2VbrP97qiOoQ6laXwNaKg6CxqGDmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724426777; c=relaxed/simple;
	bh=2GYOLw30+luEJg/tFmrxHlNaXFRBGL5NLd68jN4yGL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DiZFgNAPxHwpfvEQ9lYJrcTIA0+CuzOGlGIoWVZmaVJZeSgOpsI5a0lMMbu4+UixatMqTFM6PIASKhqrJJlEXkVSXqS4J47ppBFCORjcT+zULZNBhHOdBtqcN04q1rMlYKN+ipq6BAySGOglRte5DufPsEUwVj7HbhEK7NMCBl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JcuhpfdY; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-533488ffaddso2726459e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724426773; x=1725031573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Szc69PtQ71Cbgpu7+pqMqmqQ4A3cQ2x6GOUbmqVp4eo=;
        b=JcuhpfdY4syLc1pht8M8nFc19b4AXN2lHLVuM+CX8JRmAG1CPBCPa1ChRDCa1DNYVG
         QK5ydrx4jUEKrqyh6PFsVM4g7b5WnWqsgLoeNmIW5i7zM5c4Zj4eDwydfeT8d4blPj57
         Mya3lZOD5m6SnrxH6IGK87OJWaQIqM1alR+20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724426773; x=1725031573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Szc69PtQ71Cbgpu7+pqMqmqQ4A3cQ2x6GOUbmqVp4eo=;
        b=qs60HILJIfc6fZv6FdWmREofgj4DhvFAp8TMk0FSyT550PqfFD+Vv/Z5kFem4TZ8zW
         c8RnK1jfwbNXNc2TqE4sl8Nz7aE0j1M02rOtJqgAx578uQePjDwnIvFQg6J2NiCC/O2K
         AISklF/jhUKMoTcwJR414Gqn1dx2sm8NGxTI3eN/IiOLlRlsGzmGMTWrPgFIiD04RkI/
         0xP5OqjZVejT5bImki3u++ci/SPqzJ3Ho5CApx0K4iUNzoOzVndGUhdl41HM/PMRkoAv
         hJqken7iCllHCbEQRAUF00OqWTyflH5vqkBdEM6ywFTpOJlDXanzOlNv0KP3BzPupmM7
         xdtg==
X-Forwarded-Encrypted: i=1; AJvYcCUOUQqikQiLhQDZYQ81upf312dEZnpYeLTMyEpF5ke42SmYbT1rUUifPJHBRyKNZ76wp208jNbWiV3r+E8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/LhYG6LK+kpd7EPCkgrAjjxZLVdM9v3z50oyxAXvvQpTOyRNU
	ENMkBqTs3itetcvQunkboQurnMOV10YvamIAOR8wdQzt84qxkcoQswzTD6uekiC8bbmp7WQJfxQ
	VSuHE6Q==
X-Google-Smtp-Source: AGHT+IF+ZNLUOYwTjulaQv59XAx/KrP842PZShvNersTqrIUe1FvI82lVUvg6Oy4nieTBP5n3UpmUA==
X-Received: by 2002:a05:6512:3191:b0:52c:df3d:4e9d with SMTP id 2adb3069b0e04-534387bc61dmr1837805e87.37.1724426772416;
        Fri, 23 Aug 2024 08:26:12 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea8903bsm572125e87.277.2024.08.23.08.26.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 08:26:11 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f3edb2d908so21483211fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:26:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXzMlg9FfVcUpVEsukdQMVDdXMpgr0mMnBR/Nrt3SVc/NKLkXp69Mk2IYAx5lY3QDfnUycS86UloX9dbao=@vger.kernel.org
X-Received: by 2002:a2e:9c55:0:b0:2ef:2883:2746 with SMTP id
 38308e7fff4ca-2f4f4965089mr17361201fa.48.1724426771254; Fri, 23 Aug 2024
 08:26:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822131542.785546-1-mjguzik@gmail.com> <CAHk-=wj-UanKTT-NZKLVjK3mgQsC0Ptv8mK8AM7LfZhj2dVCUA@mail.gmail.com>
 <CAGudoHEjjuGOwf=KkZjNUTPXSr6E8w8Dvz6=_CiKVHsUOY8KeA@mail.gmail.com>
In-Reply-To: <CAGudoHEjjuGOwf=KkZjNUTPXSr6E8w8Dvz6=_CiKVHsUOY8KeA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 23 Aug 2024 23:25:54 +0800
X-Gmail-Original-Message-ID: <CAHk-=wh84ATUBUZG4DtoY-=Jo-WKwDcfNUdOGw0_PzEr85rLqw@mail.gmail.com>
Message-ID: <CAHk-=wh84ATUBUZG4DtoY-=Jo-WKwDcfNUdOGw0_PzEr85rLqw@mail.gmail.com>
Subject: Re: [RESEND PATCH] cred: separate the refcount from frequently read fields
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: paul@paul-moore.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 23 Aug 2024 at 20:33, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> On Fri, Aug 23, 2024 at 2:06=E2=80=AFAM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> >
> > Yes, it is rarely actually written to and as such can be "mostly
> > read-only", but since it is both read and written next to refcounts,
> > why do that?
> >
> > Did I miss some common use?
> >
>
> It gets looked at every time you grab a ref.

Mateusz - read my email. That's what I daid.

But the *ref* is already in cacheline 0. With your change it looked like th=
is:

   struct cred {
        atomic_long_t   usage;
        struct rcu_head rcu;            /* RCU deletion hook */

and if you had kept the union with that 'struct rcu_head', then
'non_rcu' would be RIGHT THERE.

> Thus consumers which grab the ref and then look at the most commonly
> used fields get the non_rcu + rest combo "for free".

They'd get it for free JUST BECAUSE IT'S NEXT TO THE REF. In cacheline
0 - that is already dirtied by the reference count. Which makes a
*store* cheaper.

And you also wouldn't waste separate space for it.

> consumers which already had a ref don't suffer any extra misses

Consumers that already had a ref don't touch 'non_rcu' at all as far
as I can see, so they have no reason to have it next to those "most
commonly used fields".

See my argument? You seem to have pointlessly separated out the
'non_rcu' from being together with the rcu_head, and thus wasted
potentially useful space in the structure.

Your own email even had that:

>        bool                       non_rcu;              /*   100     1 */
>
>        /* XXX 3 bytes hole, try to pack */

which would have been a /* 4 byte hole, try to pack */

A 4-byte hole is more useful than a 3-byte one. A 3-byte one is much
harder to use.

In fact, even without the union, I think your current cacheline 0 ends
up having a 3-byte hole due to that

        unsigned char   jit_keyring;    /* default keyring to attach reques=
ted

with CONFIG_KEYS.

Without CONFIG_KEYS, you have something like a 40-byte hole there due to th=
e

    kuid_t uid ____cacheline_aligned_in_smp;

which seems very wasteful, but I guess CONFIG_KEYS is the common case.

So I repeat: what did I miss?

       Linus

