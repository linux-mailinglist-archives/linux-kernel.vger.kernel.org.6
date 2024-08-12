Return-Path: <linux-kernel+bounces-283862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFD794F9CD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 00:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68B83281C16
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B915C199EB0;
	Mon, 12 Aug 2024 22:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xwMfPmmv"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8531684A6
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 22:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723502785; cv=none; b=Kc3TGDo+U8yQFbYD3KvvVkkbH1KiG/gDH714LO/T2+1SSJCceo34THvckCXz7w4AgsUZSPeYc1QQogM1Il959I0HvJzIuKqVOlxtfCaX7hQMfyLWlvMt0wWogY8fTwBr+UEcLqNW/NhJ2V/G2n38sffSfK7+BNz6fVOd17q2GIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723502785; c=relaxed/simple;
	bh=rH25vNwOXSys+FTcrxYnu2EShTDf3++VALt6L2iDL9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7e7o4xfjsn9k44S5KXEN4fu8M3xK8qWGVLMNUlsr92CQHIQia6llwSsO0B9q/XSIiOqNa/4hI7coQcuTaburkECC+GRPOHP8rgn4sBb6eSTEk+j6OCfCCivJqfhHUAVGTc74Triz14xDVVtaLEztVOdUMh0wam9Uu8YVhh4k6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xwMfPmmv; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4266f3e0df8so34341655e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 15:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723502782; x=1724107582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ra0vNY+3JSbv4IVQwD/1uhLFvMw53ariqz6DtVyqbWE=;
        b=xwMfPmmvgVXM2Uv8Qak/hQgJEGWPL6Lu+HvEG2a7mvG7mwIialquos7N04A7Zg0CLv
         Cx8/pK4vk98PiulMWaMVO2eRuIfJ88wz5aKx4pYgEM3kBuYae2QB+4nbDuZaA7G5l3yk
         g+a4d+fDKRRaPoj0DK2AvAv3KKCClqQEbkTTlCEzsjIR4VZM8s5L7WX2ydZ178NboODB
         qoCWrV9wUNiwZceG1iYronePA+spjukeZrIaZ8w/bKv0pGZTS8/EOYcJ9YZens3hz2Ax
         JzlR+VnvQcdUM8k60OuogOvY4OS9LlDHIlMXxe7od4AJystvz8yISsxZKd3Vf4IxmGEu
         C50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723502782; x=1724107582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ra0vNY+3JSbv4IVQwD/1uhLFvMw53ariqz6DtVyqbWE=;
        b=gk7xnzoQwX5Zq0pveClbQwTdGtss7yF5RVdKphO7fk9a6cW5DxEjElNylj01fkoBDa
         wxY4VW3zsVVKXpbNxnLWqTchDkUjMxHOzpulNW4JNfzcTMdMxFM8sieh9QaJI0ISFXkY
         IK9ct5++ukbL2UMZ2UAQ8WO9HaNpsWA7zKF4j64iMTGcxUBOT2Kuljoo2Ro3JUb/bcx/
         qBX0pJyKGzi7+GBg5lF2zxDtQI/cYAe/Som9wAKRcK5ERIfFPgMjGFwoehTZH0E0UfHq
         QaKK+gby0qosLcsB9GSRSSdtYEG5/qYoirfme4W9x0OF7psAMDURxUF5k5K3HwI1YK9T
         G/2w==
X-Forwarded-Encrypted: i=1; AJvYcCUHAqCKqf2H1ulmXISEt6CgUHa/wGlIoHw1cDwcIqKNb4RWl+m1nEbpOFAJ54LoXwRC1dHGRn/Gb6eIZeUkYIrA3U/sHgIbdDDWFbYY
X-Gm-Message-State: AOJu0Yw8FKqEWOtT53oKu6uQOm9Eymozp0YtudGdoXAZcLCyLdTMWxeG
	RkWmrxZnQsGaNqUB1HuD07MgCmS3zNfyivZayjD5otxIqwcaNRRHP14gDbtqkAdRupy+vu1sbBL
	LUQBFGOvxGacExmRxwrJC0nCS3PDN/oKEshob
X-Google-Smtp-Source: AGHT+IEU+vOuyo14kw+euYFd9LEDJFYcB8RLRm7z0Gj6kGyapDjzoF/wqJ3BamNUS1JnOpdw2adZ01R70SRqZSl/pCA=
X-Received: by 2002:a05:600c:1391:b0:426:6416:aa73 with SMTP id
 5b1f17b1804b1-429d4828df2mr11145995e9.12.1723502781513; Mon, 12 Aug 2024
 15:46:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806232649.3258741-1-axelrasmussen@google.com>
 <a1058e89-7554-475a-9cc1-90af74b90917@suse.cz> <6951700d-b6c0-b9b7-6587-1823a9d8c63d@google.com>
In-Reply-To: <6951700d-b6c0-b9b7-6587-1823a9d8c63d@google.com>
From: Axel Rasmussen <axelrasmussen@google.com>
Date: Mon, 12 Aug 2024 15:45:44 -0700
Message-ID: <CAJHvVcgP_yOc7rgyEsyC2u+h0XLLCRAUp4Fd0nAX2fJ2KTvL9g@mail.gmail.com>
Subject: Re: [PATCH] mm, slub: print CPU id on slab OOM
To: David Rientjes <rientjes@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
	Pekka Enberg <penberg@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2024 at 1:21=E2=80=AFPM David Rientjes <rientjes@google.com=
> wrote:
>
> On Sun, 11 Aug 2024, Vlastimil Babka wrote:
>
> > > diff --git a/mm/slub.c b/mm/slub.c
> > > index c9d8a2497fd6..7148047998de 100644
> > > --- a/mm/slub.c
> > > +++ b/mm/slub.c
> > > @@ -3422,7 +3422,8 @@ slab_out_of_memory(struct kmem_cache *s, gfp_t =
gfpflags, int nid)
> > >     if ((gfpflags & __GFP_NOWARN) || !__ratelimit(&slub_oom_rs))
> > >             return;
> > >
> > > -   pr_warn("SLUB: Unable to allocate memory on node %d, gfp=3D%#x(%p=
Gg)\n",
> > > +   pr_warn("SLUB: Unable to allocate memory for CPU %u on node %d, g=
fp=3D%#x(%pGg)\n",
> >
> > BTW, wouldn't "on CPU" be more correct, as "for CPU" might be misleadin=
g
> > that we are somehow constrained to that CPU?
> >
>
> Agreed.

No objection to the rewording.

>
> When I suggested this patch, I was trying to ascertain whether something
> was really wonky based on some logs that we were seeing.
>
>   node 0: slabs: 223, objs: 11819, free: 0
>   node 1: slabs: 951, objs: 50262, free: 218
>
> This is for a NUMA_NO_NODE allocation, so I wanted to know if the cpu was
> on node 0 or node 1.
>
> Even with the patch, that requires knowing the cpu-to-node mapping.  If w=
e
> add the CPU output here, we likely also want to print out cpu_to_node().

Seems reasonable. Of course we could always look it up separately, but
it would be convenient to just print it directly. I can send a v2 to
add this.

>
> > > +           preemptible() ? raw_smp_processor_id() : smp_processor_id=
(),
> >
> > Also could we just use raw_smp_processor_id() always here? I don't see
> > this has any advantage or am I missing something?
> >
>
> This matches my understanding as well.

That's fair, in any case it seems to matter very little for this use
case whether the read is "stable" or not. Better to keep it simple. I
can send a v2 with this tweak too.

