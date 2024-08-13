Return-Path: <linux-kernel+bounces-285542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E217A950F48
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 23:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D11E1C21DE6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831771AAE3A;
	Tue, 13 Aug 2024 21:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qDCHQfgg"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871721A38D4
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 21:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723585819; cv=none; b=t2XxNxGOHtDGeGu+IA4Tm2Gu6c4/t9e1YjlhYCtLs+VrD0klUPmbJHzHO7SRZ3kXaeWSLNVJjWDcghizbgDxotWiRiTeE6ND173Ba9n78BaMwiehfQm2YlYs3QZOKT+Ej79k7ItUlpSrmb/mJqbqnc28Tbj50xD5Z0ylautCfHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723585819; c=relaxed/simple;
	bh=Eo9cLrGrsiOf2rVTelEn1LJUk+568Belby8uwLONfTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ruT9gD4DLq09bRLBXF9xNU1MzmgNRkUuKKquKGw68MzcgidqsjczNJOIhhpxiCnE4LWKnPTGnLrpsc7A8IcK2+1h51QqFUxO6bwZuwRFbh1BiNBr64ajk7AkkVYn9P0Ew4l1Ft/3lCY+N/bHHy9BEfI6Lyj5Xcp8RnS4U7WYInE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qDCHQfgg; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7a1d5f6c56fso342546685a.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 14:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723585816; x=1724190616; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSiV3SuCMfW9JOqoJiKPvJCeDk2FrtYrANArULa+fHk=;
        b=qDCHQfggQN0m+1jTpWldncrsrqtQSbm6J6Zmr89F0qP0X8Y1LmLjI9R8Na9+dObc1T
         ViRYlqzN/4LBbhn/65HlRXE6e5EIL0FuxSggJiz7I83HpDajcpQHWY7LNBCreQtcJ4I2
         8Qt5X+HOBqnrwONXnKLp0vKb/mLIAFJvs9XwlaLwHuXDRZIa4UyyzIOQ8m3UeaCmxZn4
         Af0NBGW8815K5NQlqovRYc++yj07ncKanp6QBo6DP1D/38O0Q0+JIA/+Bg7xjHyCub/x
         C+jV+qM4wQUFZNVzS9u0muqRdj0l5Pmft5k/qOyCAwOv+Mq3VYc2C7nCZlp8c66Qxy0y
         F/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723585816; x=1724190616;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jSiV3SuCMfW9JOqoJiKPvJCeDk2FrtYrANArULa+fHk=;
        b=aFmmEtlMJIlRaqXe0UNHGRxIwgXdreesa5aTIB4IqVMVjz0HbEClxHtjBnAZMK2gxY
         c7baKF8INrhDVJPNWvutbnz7cGYyGjNnRboOvVVZFH8FB7X9aZW4/qbMW9rgA/f807tQ
         5gORi9gc4Yc3im3Sixa8lM6ogS6J2ot82SMzudgoXz6kHN0jIvktEoQxHoCp+uPVjy30
         ayKFWDvJWS0be/zygwngrv3YrD7PX9nrM7H84pcJ6efLqmj2o3T2+8lnozPtmpAGZZMo
         SjSKk5vUzSWQj/GH9crl9J5RG8hpS86f/Js1ERwudxMrp/G8mXIJnSB+3ZuMdqDGg+lu
         3XRA==
X-Forwarded-Encrypted: i=1; AJvYcCVR3gLE//sm6vhdBYIXxfziaFEjmviRLnCk/ddTBuZXxEPPbZwgGU3Qkp5L+DtGxeZE8mgw8bGow8Q/Kyj6Xrd0X2/1ai8FwpKY/EE+
X-Gm-Message-State: AOJu0YyOt/Qrtvah0aoYJIcviSAkQs+6/bZ8zs69+NvsXzEtuecVUW5h
	4/a44V88J6mj3xCTIN5Z419+4Yt/0IAroXO6ZG3WlFZAVI6AZqcHRmHNuwrYMHHJbKd5BHi04bC
	SbOQVCzu7hGDRKCeuY5VkO47DxQ0dcjsLhH8k
X-Google-Smtp-Source: AGHT+IFnca/v+gpcDnq29UQq1DNCBSiG4yc+o/Pu/quDkhEYG0KrLjRvhqxXKXq8PgOJtiIYZagJkPd7d1zBGI0sgpk=
X-Received: by 2002:a05:620a:45a2:b0:7a3:5e6e:e8e3 with SMTP id
 af79cd13be357-7a4ee3ac4b8mr85925285a.53.1723585816231; Tue, 13 Aug 2024
 14:50:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812145633.52911-1-jdamato@fastly.com> <20240812145633.52911-4-jdamato@fastly.com>
 <CANLc=av2PUaXQ5KVPQGppOdD5neHUtUgioqOO4fA=+Qb594Z4w@mail.gmail.com> <ZrvTzX8CfyM40c8I@LQ3V64L9R2.home>
In-Reply-To: <ZrvTzX8CfyM40c8I@LQ3V64L9R2.home>
From: Shailend Chand <shailend@google.com>
Date: Tue, 13 Aug 2024 14:50:05 -0700
Message-ID: <CANLc=auVkEWwhEHVwK9UkdjJJ5z9FTRS6wK=zb9pCgoAm4CWdw@mail.gmail.com>
Subject: Re: [RFC net-next 3/6] gve: Use napi_affinity_no_change
To: Joe Damato <jdamato@fastly.com>, Shailend Chand <shailend@google.com>, netdev@vger.kernel.org, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Ziwei Xiao <ziweixiao@google.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 2:44=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> On Tue, Aug 13, 2024 at 11:55:31AM -0700, Shailend Chand wrote:
> > On Mon, Aug 12, 2024 at 7:57=E2=80=AFAM Joe Damato <jdamato@fastly.com>=
 wrote:
> > >
> > > Use napi_affinity_no_change instead of gve's internal implementation,
> > > simplifying and centralizing the logic.
> > >
> > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > > ---
> > >  drivers/net/ethernet/google/gve/gve_main.c | 14 +-------------
> > >  1 file changed, 1 insertion(+), 13 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net=
/ethernet/google/gve/gve_main.c
> > > index 661566db68c8..ad5e85b8c6a5 100644
> > > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > > +++ b/drivers/net/ethernet/google/gve/gve_main.c
> > > @@ -298,18 +298,6 @@ static irqreturn_t gve_intr_dqo(int irq, void *a=
rg)
> > >         return IRQ_HANDLED;
> > >  }
> > >
> > > -static int gve_is_napi_on_home_cpu(struct gve_priv *priv, u32 irq)
> > > -{
> > > -       int cpu_curr =3D smp_processor_id();
> > > -       const struct cpumask *aff_mask;
> > > -
> > > -       aff_mask =3D irq_get_effective_affinity_mask(irq);
> > > -       if (unlikely(!aff_mask))
> > > -               return 1;
> > > -
> > > -       return cpumask_test_cpu(cpu_curr, aff_mask);
> > > -}
> > > -
> > >  int gve_napi_poll(struct napi_struct *napi, int budget)
> > >  {
> > >         struct gve_notify_block *block;
> > > @@ -383,7 +371,7 @@ int gve_napi_poll_dqo(struct napi_struct *napi, i=
nt budget)
> > >                 /* Reschedule by returning budget only if already on =
the correct
> > >                  * cpu.
> > >                  */
> > > -               if (likely(gve_is_napi_on_home_cpu(priv, block->irq))=
)
> > > +               if (likely(napi_affinity_no_change(block->irq)))
> >
> > Nice to centralize this code! Evolving this to cache the affinity mask
> > like the other drivers would probably also require a means to update
> > the cache when the affinity changes.
>
> Thanks for taking a look.
>
> The gve driver already calls irq_get_effective_affinity_mask in the
> hot path, so I'm planning on submitting a rfcv2 which will do this:
>
> -               if (likely(gve_is_napi_on_home_cpu(priv, block->irq)))
> +               const struct cpumask *aff_mask =3D
> +                       irq_get_effective_affinity_mask(block->irq);
> +
> +               if (likely(napi_affinity_no_change(aff_mask)))
>                         return budget;
>
> with a change like that there'd be no behavioral change to gve since
> it didn't cache before and still won't be caching after this change.
>
> I think a change can be made to gve in a separate patch set to
> support caching the affinity mask and does not need to be included
> with this change.
>
> What do you think?

Sounds good!

