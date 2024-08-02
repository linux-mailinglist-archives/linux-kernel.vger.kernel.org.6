Return-Path: <linux-kernel+bounces-272293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 155F29459BB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 10:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A4FC1C229C5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 08:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8601C231A;
	Fri,  2 Aug 2024 08:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LBlZpt2S"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178D02C181
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 08:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722586601; cv=none; b=NAIzrdTLKcr7yqN7PwRrdnR4p1Pc13XPrnzVo6dcHUl3osPaWYLY4nxPQ1vCFT7zOzt2i8Y5LUU/Yxx9EQL8JHjeU7EDsKpX3N88Hi5efMciwT5dRwbN47rkikNnF9pJuojwi+HBNtnA4QN1FCR/+3jsZb9xWNHepNXTltEFOu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722586601; c=relaxed/simple;
	bh=VxOQQgdsfWjGBXueG5ovg3Q5nhwSXk3ct8fq5tEVDxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pRbSZGRwu1t/EP7YGbLxTqqhmDpJW+ThDzuldx4DbAtlKAXOpk9BmekEcKwc7uzE0nhMVz+BQAMNaXLispEmPhCWMbiuUebpTKrRisUq0m/S86EFZKKEGN8ickpH87JtyUrhBX7HCsixqy211aSNmOAArVTUkAPbc4W87w2nIqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LBlZpt2S; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5a869e3e9dfso48500a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 01:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722586598; x=1723191398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPqWS3uBC8uRjVmox5tLMIJZ6S7fBW9xV6DFvr9D4DE=;
        b=LBlZpt2ShStSys/1oRfm3liwiWwcT7F78XxJdcCcvosD9bgibq9lA8QU1dzHzY9Uko
         TVNyvNzpiZaiMub9Hw3Syozzuz+y8n/Q9sXjrrmWeb9Jacw3lGY6hDU1AFc9d53Kdhqs
         8HsS4/uwKkigaznI4lJopU2YUnTNlPP0X5gQxVIEHoirdMuD3khbI13T8595d3KONrur
         X7Q1ZjoVuzyxvBlG6/SOHiwQosr7TdwUDfFghyxVfFl4nL4Xkal+pSXzH3fCunD0x2yb
         d6XxdvR5TLF2fJrPOFOwPSTNGgDBbo6oX3AiV7XYApGOdFsdo/HAUfin82qYILlTQAM1
         /hLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722586598; x=1723191398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dPqWS3uBC8uRjVmox5tLMIJZ6S7fBW9xV6DFvr9D4DE=;
        b=tyjp/5X/tsSPmrN7U9hRcbgmkkiDnKP/CAcqndeVZShiaMuv/tq0E+Cn096Pn5PRj5
         dMPvc5OtBZSI5tg9q4wi795CMdRCRScZHUJcYOx+tb4Vi70U9Y6V84Pa5fgJ+fiJUhd4
         cT01XmcASdLIWZxmEjgLLaqRreyyrMmzNO4vxb7Mgi9FnnZ/b+7+qOv6Fe4lnN3ErhgV
         UTfXstnwJP2D6EABS3cWfTIKINNb5jCUqAQAJ3rK3NAoHN82t+Fl+h9Ypk6FINPlEXwH
         1DHipj0NVKrdoOo/fm8S7XK2K1NIefHHOGFHdZ5aUXjIjC753ZaOYeGzhReNi7bEPWxx
         Tkag==
X-Forwarded-Encrypted: i=1; AJvYcCXDb9/YKCqgwKfqvqmI3YUi1rN/vfMwJfQ+AQ1HS/f0cpP2pLE+8IEGsdhBS8XEI1eR+zldtd/pCtYKa6emjvQ6qZ6Jn70xYeXhqVsp
X-Gm-Message-State: AOJu0YyXAVklTfVxOyEih5deSBMEap5bJathLhXNUI6MOjE1hBHLLies
	4rpLd6y8OS60Su+5BFdwNSR2keOstRamcrgCMQEe1zRc9NvSLuh8JWHVIs9mW5Ve4z+2geetwrj
	Urd7SJbj0d3D0ATgnf5s+7io/GKeMwm8vqSqN
X-Google-Smtp-Source: AGHT+IGXxgaegB3n2CiisLyoBXg5cvPfq2G/dAMHQw/MYv37SPK5m5w+7bTowp3Vu8qC2pz1JRcwS5RGWPZzMwkTE8k=
X-Received: by 2002:a05:6402:5206:b0:58b:90c6:c59e with SMTP id
 4fb4d7f45d1cf-5b8713605e3mr87660a12.7.1722586597734; Fri, 02 Aug 2024
 01:16:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-kasan-tsbrcu-v5-0-48d3cbdfccc5@google.com>
 <20240730-kasan-tsbrcu-v5-2-48d3cbdfccc5@google.com> <ZqyThs-o85nqueaF@elver.google.com>
In-Reply-To: <ZqyThs-o85nqueaF@elver.google.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 2 Aug 2024 10:16:01 +0200
Message-ID: <CAG48ez0-DYzYP4pWgJF-bT4EbQcNmt08F-7zM+twa0bjjVRFLQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] slub: Introduce CONFIG_SLUB_RCU_DEBUG
To: Marco Elver <elver@google.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 10:06=E2=80=AFAM Marco Elver <elver@google.com> wrot=
e:
>
> On Tue, Jul 30, 2024 at 01:06PM +0200, Jann Horn wrote:
> [...]
> > +#ifdef CONFIG_SLUB_RCU_DEBUG
> > +     if ((s->flags & SLAB_TYPESAFE_BY_RCU) && !after_rcu_delay) {
> > +             struct rcu_delayed_free *delayed_free;
> > +
> > +             delayed_free =3D kmalloc(sizeof(*delayed_free), GFP_NOWAI=
T);
>
> This may well be allocated by KFENCE.
>
> [...]
> > +#ifdef CONFIG_SLUB_RCU_DEBUG
> > +static void slab_free_after_rcu_debug(struct rcu_head *rcu_head)
> > +{
> > +     struct rcu_delayed_free *delayed_free =3D
> > +                     container_of(rcu_head, struct rcu_delayed_free, h=
ead);
> > +     void *object =3D delayed_free->object;
> > +     struct slab *slab =3D virt_to_slab(object);
> > +     struct kmem_cache *s;
> > +
> > +     if (WARN_ON(is_kfence_address(rcu_head)))
> > +             return;
>
> syzbot found this warning to trigger (because see above comment):
> https://lore.kernel.org/all/00000000000052aa15061eaeb1fd@google.com/
>
> Should this have been `is_kfence_address(object)`?

Whoops, indeed... thanks, will fix in v6.

