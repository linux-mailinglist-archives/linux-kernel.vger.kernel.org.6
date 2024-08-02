Return-Path: <linux-kernel+bounces-273163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5820294651D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ECDE1F22112
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098C46E5FD;
	Fri,  2 Aug 2024 21:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MdDtlc8o"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B190E53370
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 21:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722634555; cv=none; b=tGZqLcUbbJLv0F0rHBh5yVEorIDYnkU98qBhqcuy8APSLj0hzEUaQhKqbckF7Pe8o+rOLdZ4PTyCJubseDeYUGqCz+dQVlT1uDhPA8jtawvNj9miZMGgWFUUK37I8+SBYxlRNQQhciHZZ5F8B/lr9PI3w0GBafW9FtAVf+Mb6vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722634555; c=relaxed/simple;
	bh=LDKSSq4vLGIJEomiVxO05f9XS0OwUK80h1f98Izof2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZpO7FL4BI+l1B405VyXOdnljWbX5avHw4dK59M8utek5lTwYQWLwWDNooUwls6bgyOqdh2UvLclg8+NOQN//rptTXnjpD8bmKX4BhqBQ7dQqMjaC7xXL4ysk1lwCvXe3VWeDwYUHC99rYAvpGsLpXcZFqvVwvNWyC8lmXEwyghY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MdDtlc8o; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so59356a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 14:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722634552; x=1723239352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxX+FJ8xaCVT8A2gxdlfc9WkbMjiHVlxlmKzCUZ8Z4U=;
        b=MdDtlc8oWXVQSS0apA14zyphcGoWY3s4Rj1Ex/nY6A04yXK2mhiWwDmlMek7IqtcRS
         E7nZ7psYaxAbbv0iDpaSPTTx/GVfl3RFXEhamsJRHlK7xg7+BjbFO6pugbJ7SYl4ygWt
         CRoW4OnkB1Z8PMc6OyUKBaql5LE0lFpP5F/+JaSmnPQoeJOSfDI9kJSX4YTc/sKjtkPD
         jopi7kD8B/Vm8r9YlNtBIHKY/aJokgBBGAKqPFCXmksS+bY7IKCRnNIoDC1p1lLzFBq+
         BeNPNEIJB/yNfIbbvkwQXAcd0dNomjlZ1HWYcehnC3UZtQQ/MzdMMeS8ZXlO9jMhWc6U
         6ypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722634552; x=1723239352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxX+FJ8xaCVT8A2gxdlfc9WkbMjiHVlxlmKzCUZ8Z4U=;
        b=dhWX1PJKuJBc2cIHuvSUDubOC08InnTlPMORqzZAcJtSVpJbUoNymuHGhYQZ3LaUnX
         ZOx+jI5RCJ9SLR6EMtAClL0smvMnLI+jWyH8Ce8OtEBO0OwTHNipx2QjpYKyTvLcLtEf
         BKbtaqINeuvXJOmMHLzlBiNnc2YvP4GWofhDW+UXCLazR39f8ES2i51q+R49vlDAOVX7
         sv3Y2IyT6AjXTDy+rN5A3QDw0gzhlRAnMb/mMrXmshxYMoteB6iHv4d27AjAt8xBl5gE
         ciUv3zTMOPmvRNJoVdKg3cd7/Zjg4roq2o9SwX6Rpl3lAvlB6sEFaogC2U2sPevvndY2
         /q5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXTPYGYTC6edWtkLMPmTL7ZmA6dBI8fPvvMI2Ipxhv9Yjmu+zOj+Wfo7ZUG9JPM5UXwfI5znqWesh8b+iVgzZurfjPD2iTiTntZPE3T
X-Gm-Message-State: AOJu0Yz6OygP2r+9/1j7lZ0CaoeC3HscNm+u3HuDzt/leC1u013gceAJ
	qXjvaslT9Yct9nD9gMdXzf0NXTq/yuR0D2UnQcsRUQ3hLyvV45lHxYirWJBJ/T7aq/MtRg3zR7w
	DgrjRqCmgEu39Q14BjCo6kUQ4M6iELETcxfl4
X-Google-Smtp-Source: AGHT+IFNvqGQabPk09l984h4rHE3lku8l9wvgoyvfJJKavFHp7WF87YgfMC+utWsviQYABEnZrz9agt+LBbq5HSevro=
X-Received: by 2002:a05:6402:5244:b0:57d:32ff:73ef with SMTP id
 4fb4d7f45d1cf-5b9c72cadf8mr9047a12.6.1722634551325; Fri, 02 Aug 2024 14:35:51
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802-kasan-tsbrcu-v6-0-60d86ea78416@google.com>
 <20240802-kasan-tsbrcu-v6-2-60d86ea78416@google.com> <CA+fCnZeaphqQvZTdmJ2EFDXx2V26Fut_R1Lt2DmPC0osDL0wyA@mail.gmail.com>
In-Reply-To: <CA+fCnZeaphqQvZTdmJ2EFDXx2V26Fut_R1Lt2DmPC0osDL0wyA@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 2 Aug 2024 23:35:14 +0200
Message-ID: <CAG48ez0ggtaV8MF-bzzS2=zKg-3nfG1G_QaqGdesAJpQSj39TQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] slub: Introduce CONFIG_SLUB_RCU_DEBUG
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Marco Elver <elver@google.com>, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzbot+263726e59eab6b442723@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 10:54=E2=80=AFPM Andrey Konovalov <andreyknvl@gmail.=
com> wrote:
> On Fri, Aug 2, 2024 at 10:32=E2=80=AFPM Jann Horn <jannh@google.com> wrot=
e:
> >
> > Currently, KASAN is unable to catch use-after-free in SLAB_TYPESAFE_BY_=
RCU
> > slabs because use-after-free is allowed within the RCU grace period by
> > design.
> >
> > Add a SLUB debugging feature which RCU-delays every individual
> > kmem_cache_free() before either actually freeing the object or handing =
it
> > off to KASAN, and change KASAN to poison freed objects as normal when t=
his
> > option is enabled.
[...]
> > diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
[...]
> > +static void kmem_cache_rcu_uaf(struct kunit *test)
> > +{
> > +       char *p;
> > +       size_t size =3D 200;
> > +       struct kmem_cache *cache;
> > +
> > +       KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_SLUB_RCU_DEBUG);
>
> Ah, notice another thing: this test might fail of someone enables
> CONFIG_SLUB_RCU_DEBUG with HW_TAGS, right? I think we need another
> check here.

Why? I realize that HW_TAGS can't detect UAF in a TYPESAFE_BY_RCU slab
after an object has been reused, but here we do no other allocations,
so the object should still be free. And the kmalloc_uaf test also
doesn't check for HW_TAGS.

The one thing I know of that could make this test spuriously fail
would be an allocation failure in the SLUB code for delayed freeing
(but that'd only happen under memory pressure, which I think normally
doesn't exist when kunit tests run).

