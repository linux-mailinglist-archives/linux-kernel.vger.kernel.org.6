Return-Path: <linux-kernel+bounces-572132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9856CA6C708
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 02:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1610D464C4A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 01:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4149E44C7C;
	Sat, 22 Mar 2025 01:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZnxfUX7+"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D6928382
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 01:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742608255; cv=none; b=d/C9UmySipQoqHuq6+gNFzRgq1ASV494g+PKozg+QQTJaG5oUCsbLTacj679hfBtz2mVAMQ9Zw6URrMPYwUUdBlF0c7rEjvDIyA04XUbyttukvAhjT5X+pAlY3QFB0+//FkZvAAHKuKaU4Va+gO3VaZDexE9QkhIMOYs/TmtXyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742608255; c=relaxed/simple;
	bh=m/tzIm+7XlBnnxEQSz+SdbtZkGlp6oT6j2MmSPNUbFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bLtD6xtEshBKAs2b7LifL7vR/jmgcUgAu7XigK2Po0LpQMgXrY2+Dmv2NWtk+X04ojslJqS3lUuZilreRMvVBX5/8suBkj/qT1HKp2xVsob0zS6bEyU8Fz3c2xYyOmbkJbU0PhdqTGtICrq2opObO48LO8gsXtMZaZb7JiYuJtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZnxfUX7+; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e50bae0f5bso4372a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 18:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742608252; x=1743213052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bAMqt/kp5xNdpGpWqBm0DUWrT3oTcv1M70fkdyOEMI=;
        b=ZnxfUX7+o1Jx9qyOBgaigjP9wa0+dKwIw2g2jgNiwKLEeAjgB8wbvRJoLGvW3GZHeK
         OmtlAodYnzdaIcsleFXn+/JaBJAP1cY4c75qCj/P7PU8CiJXhryvQWMSQ2VXrshVfjWG
         mg+QqVC/L2ymFTshM7HaMh/JGmnPqiEP0SeWiqMoq1qeGChW05e88m2llzfvcD5eaFVI
         0XE9ITQukaiBfsqUnP6qv7VpeR3zSy6I58FRyaJYTRwqPJXjERPQjjjxL8yff6hPrduN
         czGrh6+zijdC1TQydZeNHvjr8UbFm3msItWpofLgCM8mdm727PN0T30mimaGfMZARwG3
         Yl0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742608252; x=1743213052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5bAMqt/kp5xNdpGpWqBm0DUWrT3oTcv1M70fkdyOEMI=;
        b=AhVgwgguh+G6pRd+dWS7pKTbzGImXbAHIEfjl663+gRwyCWQfWyeqvOVJd1tS5w71E
         DM5KnQfjxNsuDRPvG5v2g2mobnMDsZIc9TZBqKnGdVuL/6NK+s5SCeRvqyNZRI8W9VAX
         VUZdVC01qFxxMO5pzDxOSM5aGda2SPdbDLKpQAmnsdn2bE9PKuriWdqj5lkYO3BkaDTH
         lKYAfHqBPCzfZyOIKVgzhRkxwXfSpQLwI1TWQxBnLqmDN3IF115lmTRPzEo+xPCJxJk3
         Ew8F/IU4mxreWwjpD5KlGjjRTz5bJTrcNS9xkpLlFVoWu7ppwzdE7WkDMSfIMHcX++5W
         3B1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXsu1fHIOG5bD4qoAqlC4kbqdaZjuJtCPEhGYVsuytSZoxJwGXTf7bBa4P7AjUEhv/gRI6KJPH+F11v6gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVxkWBVvQVWIHS0Yr5xaig04tAnERffkpeMbUcNJQzj6UASlox
	E9rXUiS/MG3H5ky2TrexeSW/OKV+vTWpAk4y36Ase96TBAIdK6WEeOe+qL3xCXdlesrhnV07B27
	6Vr3PHg8e0Sahb/T/wGa5ayWGj3zh9vevW3pp
X-Gm-Gg: ASbGncvFjY1hZhV/aC3zM/+nFqh+o2eSlFkaFf7lhXcDxuKaShPJ+Q14vPoPatu1Eh/
	DNJXNWcVZ56t+M+D4Mki790cWQA4WWsJyGSMdvQVOmTRNWoEfuGSbl177JRpr/XB0Pwywh5l8eq
	3W9BUIb+J+tnnqZJVasVMlrwmTLSeNdp4QZ1IeykvZTy+K1dPGBwT/FKimwDdVYp8H
X-Google-Smtp-Source: AGHT+IG7SqtDMOefUjHv5ne9WUK3g+yBu4XthxH3f4TMP/qf+N1EOd9SjiMcRqk87Yg1qrHnesdNGamPnVPjQCloWmQ=
X-Received: by 2002:a50:9e46:0:b0:5e5:b44c:ec8f with SMTP id
 4fb4d7f45d1cf-5ec20b2a1e6mr23783a12.3.1742608251799; Fri, 21 Mar 2025
 18:50:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321202620.work.175-kees@kernel.org> <20250321204105.1898507-4-kees@kernel.org>
In-Reply-To: <20250321204105.1898507-4-kees@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Sat, 22 Mar 2025 02:50:15 +0100
X-Gm-Features: AQ5f1Jod17mZvChlstZSJR1ZRw7owBX6xbKHmuayoKFP5Ryp9maZ2Z5eVrzRgpc
Message-ID: <CAG48ez2-stu91bgZawx_AaypEuMnc5=nJQUiDzUCb+CbsJS6kw@mail.gmail.com>
Subject: Re: [PATCH 4/5] slab: Set freed variables to NULL by default
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
	David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Marco Elver <elver@google.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 9:41=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> To defang a subset of "dangling pointer" use-after-free flaws[1], take th=
e
> address of any lvalues passed to kfree() and set them to NULL after
> freeing.
>
> To do this manually, kfree_and_null() (and the "sensitive" variant)
> are introduced.

Unless callers of kfree() are allowed to rely on this behavior, we
might want to have an option to use a poison value instead of NULL for
this in debug builds.


Hmm... in theory, we could have an object that points to its own type, like=
 so:

    struct foo {
     struct foo *ptr;
    };

And if that was initialized like so:

    struct foo *obj =3D kmalloc(sizeof(struct foo));
    obj->ptr =3D obj;

Then the following is currently fine, but would turn into UAF with this pat=
ch:

    kfree(obj->ptr);

That is a fairly contrived example; but maybe it would make sense to
reorder the NULL assignment and the actual freeing to avoid this
particular case?

Another pattern that is theoretically currently fine but would be
problematic after this would be if code continues to access a pointer
after the pointed-to object has been freed, but just to check for
NULL-ness to infer something about the state of the object containing
the pointer, or to check pointer identity, or something like that. But
I guess that's probably not very common? Something like:

    if (ptr) {
        mutex_lock(&some_lock);
        ...
        kfree(ptr);
    }
    ...
    if (ptr) {
        ...
        mutex_unlock(&some_lock);
    }

But from scrolling through the kernel sources and glancing at a few
hundred kfree() calls (not a lot compared to the ~40000 callsites we
have), I haven't actually found any obvious instances like that. There
is KMSAN test code that intentionally does a UAF, which might need to
be adjusted to not hit a NULL deref instead.
(And just an irrelevant sidenote: snd_gf1_dma_interrupt() has
commented-out debugging code that would UAF the "block" variable if it
was not commented out.)

