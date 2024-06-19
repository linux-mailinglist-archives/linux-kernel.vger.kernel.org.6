Return-Path: <linux-kernel+bounces-221072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0100190EB79
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E3771F254DF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7D41459E3;
	Wed, 19 Jun 2024 12:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5peNBdj"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8274D8B2
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 12:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718801505; cv=none; b=Sln5Ssoi07NUtpCEqcsg4W/n0hndqczDqxS0lGSlDySvjrC5pOG/kC4653AEY5AX38lDxrk1vXI23dsmElydtGhJi86SNmRYPUVqRxEWbHHvBhO9slqYc1c+JY0tjJT9kX3gXfORalp55TQt+Dd5egiHmvnKzYKySdKcWK9RIcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718801505; c=relaxed/simple;
	bh=B0tTdnPzdzq2qX9cNaNBqxC9H4o7p+2dWCEZbb06wI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cdfx8RfnsojR1O/quhY6ommASdi3GNRAl5Mr7Pb2hayq2Xq93TGi1Vsdn8PJxAvK7DQ/IqsDqnhOv8p3XCdVjJ1cEwF0eJ9H9MBFrQmqkT6fFyEjaBCq+EcjG3tAss/mbOWVk1pBIDzF6wOZMuOezbqA4NCDAK2iiR0ZyD7mvwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5peNBdj; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6f51660223so398827266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 05:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718801502; x=1719406302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMsD3rtYvv6DR/KAWNNE4xDIpVmpwwTpjIaG1Jg15rk=;
        b=W5peNBdjcuF2zMPvjoIXMBkLLKbZNKg+w8ZChYxXdpleh81u3boOyPKf0s17BqjTYJ
         BO2NU4ssXkDT6D2QQpvGbKxjlWKityBWpKaCZ6H03ggMNXXLILFUzXd+CynjAJh5ZiXz
         qUqhIWNH7+XIE6lgXGI0WAjovihRXfKPUhK/3WVoXjFkKk6GX3c5mce7/dPy9bx1GJIZ
         6fn1cOyMBMHMNFS8jt4LLUCXxoTw7hQG47sjEfK3nkzpZkNt/sgyYeYO0mgX21VJKqgi
         /BcujqUiqTNWCwxRxLvgPgLql6i3XsfMz7/No6XWf/Gl/1QdfjRTV7nK64FrRL3bFLbb
         La6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718801502; x=1719406302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMsD3rtYvv6DR/KAWNNE4xDIpVmpwwTpjIaG1Jg15rk=;
        b=VVXNuxqVpvOP/rKoTVW07bUdSNYSITxBkcdXzKmCpRgbCO4RbrOGU4E8c4gt1wYP7k
         sZIytNB9oJc2NETlKS3uWcILZ1tGoqyFkzVbYL9epWh4laW9x88hv8RmjKmd5Lz3kkxx
         138wUsSL0bxTLC2Ac5CfhVg7vjkHCkGILhYZ8EreTyN5lu65ebcJd0aQJl7n9Yeg7XQ+
         wF7Bvvc+/RFu8C7w4Lpj3gJOttsZv9sC1vunoNaWPYRHzm4fT2ZpcccjvbMgw3zOT0/t
         YOwYOCUU27o2nLZgYhNQBV0kUUwZopBwVDZvorxlr5l9lBABlqOpKjIrsccrx4h27ooQ
         09Gg==
X-Forwarded-Encrypted: i=1; AJvYcCX4adlq0y5mtmJocMqJoOn57HDfnv1jWc60ssuKvwL4t/PlnBLyGTCIj6vm3JBiuFJxG3L6bnVk0udPCnkCWb6DQbgEQi4TBMsW9nXW
X-Gm-Message-State: AOJu0YzS70YNRY2uW42iQpcc4XYvjLofB7rltNet/UFDwqiIubSlqzAa
	74Y2e0l+ISOEJAcWq4nEoyhWwK5Ta2GTMm25/AuSN1Ux4uCRBD+jDJE3yIUISfzUClgl0dyzo2C
	ZrsooLOaQkjEryk5Mf49IiJWXEfk=
X-Google-Smtp-Source: AGHT+IGXLMGlpPC9iSsrnp0dsArwZMyvFXIuQtkDUUvWmN0IBfIeW17SsTFZ1CjlCZvPvB4Lf7B234R8xL4PfqMmHl0=
X-Received: by 2002:a50:9359:0:b0:57c:77a1:d1da with SMTP id
 4fb4d7f45d1cf-57d07c37da2mr1742190a12.0.1718801501780; Wed, 19 Jun 2024
 05:51:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618213421.282381-1-shakeel.butt@linux.dev> <fm7buc5wqjfbpkc4vciubjttk73k7vzahohlcolztrhjqywnca@pysupztheg6i>
In-Reply-To: <fm7buc5wqjfbpkc4vciubjttk73k7vzahohlcolztrhjqywnca@pysupztheg6i>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 19 Jun 2024 14:51:28 +0200
Message-ID: <CAGudoHEYsdhXCr6K=zts+-FUmDRL82PiG0U-s7b6-za5o03_Wg@mail.gmail.com>
Subject: Re: [PATCH] mm: ratelimit oversized kvmalloc warnings instead of once
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, kernel-team@meta.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Kyle McMartin <kyle@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 2:49=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Tue, Jun 18, 2024 at 02:34:21PM -0700, Shakeel Butt wrote:
> > At the moment oversize kvmalloc warnings are triggered once using
> > WARN_ON_ONCE() macro. One issue with this approach is that it only
> > detects the first abuser and then ignores the remaining abusers which
> > complicates detecting all such abusers in a timely manner. The situatio=
n
> > becomes worse when the repro has low probability and requires productio=
n
> > traffic and thus require large set of machines to find such abusers. In
> > Mera production, this warn once is slowing down the detection of these
> > abusers. Simply replace WARN_ON_ONCE with WARN_RATELIMIT.
> >
> > Reported-by: Kyle McMartin <kyle@infradead.org>
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > ---
> >  mm/util.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/util.c b/mm/util.c
> > index 10f215985fe5..de36344e8d53 100644
> > --- a/mm/util.c
> > +++ b/mm/util.c
> > @@ -649,7 +649,8 @@ void *kvmalloc_node_noprof(size_t size, gfp_t flags=
, int node)
> >
> >       /* Don't even allow crazy sizes */
> >       if (unlikely(size > INT_MAX)) {
> > -             WARN_ON_ONCE(!(flags & __GFP_NOWARN));
> > +             WARN_RATELIMIT(!(flags & __GFP_NOWARN), "size =3D %zu > I=
NT_MAX",
> > +                            size);
> >               return NULL;
> >       }
> >
>
> I don't think this is necessary. From the description I think interested
> parties can get away with bpftrace.
>
> Suppose you have an abuser of the sort and you are worried there is more
> than one.
>
> Then this one-liner will catch *all* of them, not just the ones which
> were "lucky" to get logged with ratelimit:
> bpftrace -e 'kprobe:kvmalloc_node_noprof /arg0 > 2147483647/ { @[kstack()=
] =3D count(); }'
>
> Of course adding a probe is not free, but then again kvmalloc should not
> be used often to begin with so I doubt it is going to have material
> impact in terms of performance.
>
> While I concede it takes more effort to get this running on all affected
> machines, the result is much better than mere ratelimit. Also there is
> no need to patch the kernel.
>
> btw, I found drm keeps spamming kvmalloc, someone(tm) should look into
> it:
> @[
>     kvmalloc_node_noprof+5
>     drm_property_create_blob+76
>     drm_atomic_helper_dirtyfb+234
>     drm_fbdev_generic_helper_fb_dirty+509
>     drm_fb_helper_damage_work+139
>     process_one_work+376
>     worker_thread+753
>     kthread+207
>     ret_from_fork+49
>     ret_from_fork_asm+26
> , 104]: 12

I should clarify this is allocs of 104 bytes, not some outlandish size.

--=20
Mateusz Guzik <mjguzik gmail.com>

