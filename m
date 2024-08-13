Return-Path: <linux-kernel+bounces-284993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B95A9507D2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEA83B21B9A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F251119F470;
	Tue, 13 Aug 2024 14:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZabGJnBN"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A791319F464
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 14:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559748; cv=none; b=bVFx96qDGdXPo8bRn1lwAMtzArP29CXcFCVYWlMn11ZttLZ4UATrax45XdS0dW+KpxfciP5cM6MAi/GRpQysKqUdYrAbN1vPjiPlqcQl0njf+MqQtv4t7Mnr3qLMVRTOy/DVubuekq8GmdhJ3XLEpbk3dt0k5w+st5Mw2L+dFFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559748; c=relaxed/simple;
	bh=UILvV4bMxjv9HMfsYOJ3phl/WcKthY8mmPNxtNFIhHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jxjXCN61qE4LNOdF4TsZdgvaGz5eJeUa7BxSHg6yrXmk7mI4ioTX/Ji6wKoYxzho98dA7Bd4Pqsigizk7jqlcwVzMP95TRfVN+tUgAIlQ2PsMEVfT8uSi2oypqKxh6tfX3FereLhqoMUsLfvkQxHMHqY1HIyVp278S2sD4VBWXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZabGJnBN; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so7023a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 07:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723559745; x=1724164545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHkUUb+Bb79GP/2rKFx5/OBmUophNr82XKuyu6ufGDk=;
        b=ZabGJnBNGZhA+siwzqxK241UWlW8swTK/TM9TrEbvWNLZJa3Bj0QtY3wfIrGkVdjL9
         tXMDL+ZEfF1vxJs5hN7AQmJZxAqsmvlmUcAOqWPa622AqsRY8HavF9d3eLAG3BjOnWra
         AfjaMXOMfCzGL5lTLMF1mxyjNQ26ed5S91bgSatUxFCASKzRbGCh5LunuAZohAKXH7Zo
         dcnCE/o5OhPN/4N+rnTmBZ2amWYtLCdhx+qSgYPpfxQe6zophkvF04LZKjgq+qBbw+5B
         Okj0CBO0TzNiUzx3qvbdZnG8hycPv14zIc6PNXH5hha76ueUVLYQJzCrAu/mZC6iS+jy
         dfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723559745; x=1724164545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jHkUUb+Bb79GP/2rKFx5/OBmUophNr82XKuyu6ufGDk=;
        b=bwTJbCoJX2jXXKeZUc+GDpZkD2+jNNinGRbu/j+NS4kAVMRB8QHZM6sGt+CoFWbZmg
         wD1LHmlKokgIZAubp3mUO+4HSGlHt6QDCUpRxj/cYAjUt+IFGW3qrar+HhWy+vDOUprL
         JhYjaFGMjHN45gM8UgqYDUxNYoFwVVyOsrO+IlA9JkcJOdw0I893p6jqPDxJFHfh96xE
         4RbRFkF57Wba5KJ9EPvi7etGPIWl51fJfBuimsHYdtLJCtjcpTrpklo3vqR/RbEhgmft
         TU322jIc3AT7PFWuJ1BIhUv3ccMsW8KFFb0VTOwl1wbclaAzLyR6d8N7KXnhgYCuHbfc
         /tjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVK9wpfPQdCHuVUggstV2RAaZbzn0P8VPgV97Ef2nVj8kMXQFq5a3bMTjvoEafP4H8AnMRxZaKFV7gGq9zAa5+x9zt1ieogXvsqT6V+
X-Gm-Message-State: AOJu0YwZPyWOjXDtrVWtV1jkQJxK+1NRlEeWyciF0JTn/6YoLLalhpbo
	mfwP6wCa6wuzEFoKBlkc+zUB3BanHIxVHfG5xyjrdtegSFeMwZy72hy5+Vw427YDIfKjH+OecAY
	9ivnS/Tla3YMkVN0kaYUf9+T5XBI1vLSTTer7
X-Google-Smtp-Source: AGHT+IHeLfopYA5+BXjlrv9nKiZRDnXJoaZQyRkMEillXRUwh8YU4XiIl4Kkmp/3gkn2YGckbTHD0I0KZoIHNmRKHnE=
X-Received: by 2002:a05:6402:13d0:b0:5bd:3fff:7196 with SMTP id
 4fb4d7f45d1cf-5bd476d59e2mr100042a12.6.1723559744140; Tue, 13 Aug 2024
 07:35:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809-kasan-tsbrcu-v8-0-aef4593f9532@google.com>
 <20240809-kasan-tsbrcu-v8-2-aef4593f9532@google.com> <vltpi3jesch5tgwutyot7xkggkl3pyem7eqbzobx4ptqkiyr47@vpbo2bgdtldm>
In-Reply-To: <vltpi3jesch5tgwutyot7xkggkl3pyem7eqbzobx4ptqkiyr47@vpbo2bgdtldm>
From: Jann Horn <jannh@google.com>
Date: Tue, 13 Aug 2024 16:35:07 +0200
Message-ID: <CAG48ez2DUgxh3f4N=i60TfHBSTbh2HPMbA8DcBo2g7HSepnzzg@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] slub: Introduce CONFIG_SLUB_RCU_DEBUG
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Marco Elver <elver@google.com>, 
	"kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	David Sterba <dsterba@suse.cz>, 
	"syzbot+263726e59eab6b442723@syzkaller.appspotmail.com" <syzbot+263726e59eab6b442723@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

On Tue, Aug 13, 2024 at 11:03=E2=80=AFAM Shinichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
> Hello Jann, let me ask a question about this patch. When I tested the
> next-20240808 kernel which includes this patch, I observed that
> slab_free_after_rcu_debug() reports many WARNs. Please find my question i=
n line.

Thanks for testing linux-next.

> On Aug 09, 2024 / 17:36, Jann Horn wrote:
[...]
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
> > +     kfree(delayed_free);
> > +
> > +     if (WARN_ON(is_kfence_address(object)))
> > +             return;
>
> With the kernel configs above, I see the many WARNs are reported here.
> When SLUB_RCU_DEBUG is enabled, should I disable KFENCE?

These features are supposed to be compatible.

In the version you tested
(https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next-history.gi=
t/tree/mm/slub.c?h=3Dnext-20240808#n4550),
I made a mistake and wrote "if (WARN_ON(is_kfence_address(rcu_head)))"
instead of "if (WARN_ON(is_kfence_address(object)))". That issue was
fixed in v6 of the series after syzbot and the Intel test bot ran into
the same issue.

