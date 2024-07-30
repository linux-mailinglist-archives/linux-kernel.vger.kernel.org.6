Return-Path: <linux-kernel+bounces-267281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DB3940F90
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 973FDB29DB0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0ED19D8AE;
	Tue, 30 Jul 2024 10:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e+91zWYW"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0659C19DF70
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 10:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335474; cv=none; b=qAEZ8EG7HilrJYQYKGFUDcMaUmCN6dXx/sptUBc2gw7cJX1T3pW24Pb38dc+4oGgPUGYVFeAv7pwh2FvUGK7E7LZJ/49v1Nhhvz91MemBSrteIkA51xZr3BuWhdq9fJGlH2sE7N5dBI7ePvFAWYXjUJNEZMOZ9Cfb8jc9p01EYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335474; c=relaxed/simple;
	bh=+0SgFk0UCcjyFQ1ag4543DDdAqZ4f+PJCAgSBXmnExE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nhErOi60DVT4kvh1TfWgxLwu3N6Oe1Rr9qn6VheABuvtWRF3w4uaOYjxt4uIEv9m4xTDE2dHQQe9C7BxQ1mJ+tQsFfb8TV7IMutlK+qo6u2/VKG9d2xwAfLY1KCgB756vCWAwHlphKrOzymKQg5jbWTbQ8TZgGjKnuVCBRaT2/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e+91zWYW; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso12551a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 03:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722335471; x=1722940271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0SgFk0UCcjyFQ1ag4543DDdAqZ4f+PJCAgSBXmnExE=;
        b=e+91zWYWEOuT6I91MfEkBYQIgqSKKziJfArfmDWp9AgkAyiKH1vnaOAjARAw4QWDnl
         BgU9JodlRMlA/b5hHAZlX/X9c6hcRrepKLlkHX/4rqmWWS2X0lrDWTrBcPCQooL0lE/X
         /tTfBFL0PQlDUg14RZHwu0rFpnEourqUFvIsayhsBtW65ETzgRbMW2rq2G2ihh5pPRoi
         EVPjXESgXnSUh+UZpUqDldz8+ECnvKBgnQiTImDnWVr1A2lWMi2NLWBzWF3CZOH0dLIb
         uL+Fg0zeKo1hRnZ2hkkAzEwXep1SXWkv6//gdXYnigCitnDy+3O5fZGBYOIX8hPTj4bt
         WBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722335471; x=1722940271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0SgFk0UCcjyFQ1ag4543DDdAqZ4f+PJCAgSBXmnExE=;
        b=hLJ/jjGZuUeFXs+NfFcJ9SNXzt3HONlNhwW1lkoHuza+ftbFwY3kIj/f9NLT6WqXHV
         FwVfyur5hKSoUn47SFMMM4EorrEnTVLlHeSA1XoTM+dFolnlZR8EamXL3gp7UsCTZPDP
         DFZJ5uwRQDn7IO1e5ETBWG1liIxTDhJ7kasHjdouxLYrD04tldgs2KQWJY/hbmx2AcxG
         nbUSP8jVsnSP4X7T9S3Gp+VvCB9xDmWXQVkZbWh8wCweoEZr4KOIjo44G1YAWD/SmOXc
         wybXbSangdMEDhZLbUXZyKRF/A5qoBwxzjYwiVEFUqyG6+pd2uUQLiDs6wSTwD/Lj1Kk
         cMsA==
X-Forwarded-Encrypted: i=1; AJvYcCWvyTenGYVhlHrJZRLnpZJhd3WQTl0uF/gykfU17Sb65FU8f6qBbgt4CCAzY2/VLBPRMP9H/FlZNVmP+OmoCKJVizBgxwXvzGMehXhl
X-Gm-Message-State: AOJu0YxRlXarczaBbwEmLJvkDMwvus731OgyisCILx8q4hCMVSjDaeE4
	TKqj+t4RHtqbWSqtWQsGMrtGupPgWhvZ+PpNHll1piUFKnktahUuUs8GeYWRRDaKyjn0alJ0+Mq
	x/VDufVIhnHBT67JFM/kV0yzu+M63mDkGGpnp
X-Google-Smtp-Source: AGHT+IGLmcA5xxV1M4r6CbwNmSSM8fTDUc0WCfwWsdfAZHZjtPV8UqocY2ggpWtoUek+6I5ATI4LjP7xq1XesXiYQV0=
X-Received: by 2002:a05:6402:35c3:b0:5a0:d4ce:59a6 with SMTP id
 4fb4d7f45d1cf-5b45f835dbbmr100114a12.2.1722335470822; Tue, 30 Jul 2024
 03:31:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725-kasan-tsbrcu-v3-0-51c92f8f1101@google.com>
 <20240725-kasan-tsbrcu-v3-1-51c92f8f1101@google.com> <CA+fCnZe-x+JOUN1P-H-i0_3ys+XgpZBKU_zi06XBRfmN+OzO+w@mail.gmail.com>
 <CAG48ez0hAN-bJtQtbTiNa15qkHQ+67hy95Aybgw24LyNWbuU0g@mail.gmail.com> <CA+fCnZckG1Ww9wNcXRuCwdovK5oW3dq98Uq4up-WYOmddA9icA@mail.gmail.com>
In-Reply-To: <CA+fCnZckG1Ww9wNcXRuCwdovK5oW3dq98Uq4up-WYOmddA9icA@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 30 Jul 2024 12:30:34 +0200
Message-ID: <CAG48ez17_Etm_-AMaJHENq=QjtCRqNcCe9VUDvNw8En49wKybg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kasan: catch invalid free before SLUB
 reinitializes the object
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Marco Elver <elver@google.com>, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 27, 2024 at 2:47=E2=80=AFAM Andrey Konovalov <andreyknvl@gmail.=
com> wrote:
> On Fri, Jul 26, 2024 at 3:52=E2=80=AFPM Jann Horn <jannh@google.com> wrot=
e:
> >
> > > Do we still need this patch?
> >
> > I just tried removing this patch from the series; without it, the
> > kmem_cache_invalid_free kunit test fails because the kmem_cache_free()
> > no longer synchronously notices that the pointer is misaligned. I
> > guess I could change the testcase like this to make the tests pass
> > without this patch, but I'd like to hear from you or another KASAN
> > person whether you think that's a reasonable change:
>
> Ah, I see. I think detecting a bug earlier if we can is better. So I
> don't mind keeping this patch, was just confused by the commit
> message.

ack, changed it in v4

> Adding on top of my comments from before: I think if you move
> check_slab_free() out of poison_slab_object() (but add to
> __kasan_mempool_poison_object()), and move is_kfence_address() and
> kasan_arch_is_ready() to poison_slab_object()'s callers, you won't
> even need the free_validation_result enum, so the patch should become
> simpler.

right, makes sense, changed in v4

> You can also rename check_slab_free() to check_slab_allocation() to
> make it be named similarly to the already existing
> check_page_allocation().

done in v4

