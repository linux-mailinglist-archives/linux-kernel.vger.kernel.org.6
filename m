Return-Path: <linux-kernel+bounces-442000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC479ED6AC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221A2280352
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433D120110F;
	Wed, 11 Dec 2024 19:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m7P30MkC"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1D4259491
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 19:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733946044; cv=none; b=SWVrXRROdBeK8l2CsWOkXknWMpTgkHw8fto7sFPMd5d0CibN3nz51huyXILjApCJz7kBfXf/L02VDOdXLUrcaKHRjviHQrNmXfKcV59XdFZqBaOT77JEnDzMHSYtupyYCVePFMPIQQFksVBWKn4n8LcAWZARORasTAom24zFlew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733946044; c=relaxed/simple;
	bh=PlOFHIOkZBBtJiIhHKVfkhxd1vmGGBDqDG2mNZd9mWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msmi01NyeUddVfESJ/dYFHZrMxLYIhxZfjX44QKnWKnO5aVUxwaaue/MYxO6O8moJMlsBXHqSCSnZ8CAE2rtrBDjMkVsACk0TfZjkeqANX/THANiNyfh3K3mysPasV22the3goGWOF5WwT20UNLAz80IWDnA2jaNlmrVrl5ZQHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m7P30MkC; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-467896541e1so39371cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 11:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733946042; x=1734550842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gAi2sZAVOfaezM6vHnfZEQr2lBUdILrViUkilAOY9a4=;
        b=m7P30MkCCIal9GAw+XyrFNUWBt90/+NyWJvMlFWTBcEg74CunZ7teavsu3Crxsp+r0
         xNzlUncJwBcA4eY9yu+FS1q3JOB9mYI+MAHVRz1dtfOxqwgQUHeU7R2FOLOML21dyPg2
         tqVd7NwgvMZhBxMJ0aUtP8A4TcewXyjgXfb2WOZdJIs40sE1FNQ0xmPFxHlCuAYuJCFz
         F/8j6StDCkUZm4P+EUGAFakeUCdOcCsYY2fmhZVI8uExxGqjDL9I92jnYhk1QA6qGgle
         i+D2Biq6rRd0GcB4ejbiglbEPRkPuEf7J6aLwHlguwT4wax7g09BdBT+vEOugaOmssYS
         9JZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733946042; x=1734550842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gAi2sZAVOfaezM6vHnfZEQr2lBUdILrViUkilAOY9a4=;
        b=OTWfjYXHqgCTj/SyHkySQyokQ7zEC7aD7oMlvZiJtdc+6TrGygR1afHFmjTaWid4qA
         2+LKnHPJXCg53mApEeKF5SX9HWpK8IMA1fagUz2s5stcUPgX7xpjGW+qoiqY3pcnpbnT
         PQMvZknp4Su5NXl5RRj2JE9bWMdRTfx++8UQnsRbCb48xrDJLHK/SD00hW4fBxEVSW2k
         gg4dYguYaXShweHU4j7UCaTJWnV12HTINYB1HOyWktKQpHWveU5ENRY+Tti3qcy2edOl
         /zs3fsM8/YY/PryzVNIjzvVwQpUfcUclYnt8g/FSzNiRwlqWQYpHe93x5KHyLg0hnKUb
         OYDA==
X-Forwarded-Encrypted: i=1; AJvYcCVacpZXDvxr8OmWo+e0zCX5o77NWhetgH/dcQ38YzsKZpQIt8RVf8qnfL8QJn3AItc7hBAB/FUPzUBxBk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNnmCrUigwGtHoHz3SKQi2Ka1NQINSJQPcRrbmL5d+UBf1OjMG
	aFqdZ+JQSTOZyV9kxkaSQyXRWu5vqdSiiVFvItjYyMwkUMpASxLbt6PHpQbB2VvHUc57Reb/CE2
	drlOhE9X9SwtASbnBCau1YjfljXkO6VxKPEoT
X-Gm-Gg: ASbGnctT5fxgIJYmfAsp/I9rmaqfnmyJe7BdzeYh124KAq3k9+j8zF7EAxpM3XxZ1/5
	fVHSl4BtHkzRZdS3yetUqpmHZmvMolG6UqNQ=
X-Google-Smtp-Source: AGHT+IHe0a/olZGmNb2j063xWVYnWyQiRtYgcQ2KPzSRgRc1IuQoCoKKCfBfPKLaAI8hJccI+cZOsKhE0JwynGSCsXg=
X-Received: by 2002:a05:622a:1f89:b0:461:358e:d635 with SMTP id
 d75a77b69052e-46796e2f498mr396471cf.18.1733946041952; Wed, 11 Dec 2024
 11:40:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209172308.1212819-1-almasrymina@google.com>
 <20241209172308.1212819-5-almasrymina@google.com> <20241210194745.7a0a319e@kernel.org>
In-Reply-To: <20241210194745.7a0a319e@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 11 Dec 2024 11:40:30 -0800
Message-ID: <CAHS8izM45fsLyPxJy-Q9cxXzz-Pb1dHOw0yCHmJTqU8puRTwKg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/5] page_pool: disable sync for cpu for
 dmabuf memory provider
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Willem de Bruijn <willemb@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 7:47=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon,  9 Dec 2024 17:23:07 +0000 Mina Almasry wrote:
> > -static inline void page_pool_dma_sync_for_cpu(const struct page_pool *=
pool,
> > -                                           const struct page *page,
> > -                                           u32 offset, u32 dma_sync_si=
ze)
> > +static inline void
> > +page_pool_dma_sync_netmem_for_cpu(const struct page_pool *pool,
> > +                               const netmem_ref netmem, u32 offset,
> > +                               u32 dma_sync_size)
> >  {
> > +     if (pool->mp_priv)
>
> Let's add a dedicated bit to skip sync. The io-uring support feels
> quite close. Let's not force those guys to have to rejig this.
>

OK.

> > +             return;
> > +
> >       dma_sync_single_range_for_cpu(pool->p.dev,
> > -                                   page_pool_get_dma_addr(page),
> > +                                   page_pool_get_dma_addr_netmem(netme=
m),
> >                                     offset + pool->p.offset, dma_sync_s=
ize,
> >                                     page_pool_get_dma_dir(pool));
> >  }
> >
> > +static inline void page_pool_dma_sync_for_cpu(const struct page_pool *=
pool,
> > +                                           struct page *page, u32 offs=
et,
> > +                                           u32 dma_sync_size)
> > +{
> > +     page_pool_dma_sync_netmem_for_cpu(pool, page_to_netmem(page), off=
set,
> > +                                       dma_sync_size);
>
> I have the feeling Olek won't thank us for this extra condition and
> bit clearing. If driver calls page_pool_dma_sync_for_cpu() we don't
> have to check the new bit / mp_priv. Let's copy & paste the
> dma_sync_single_range_for_cpu() call directly here.

page_pool_get_dma_addr() also does a cast to netmem and bit clearing :/

The whole netmem stuff was written to maximize code reuse. We don't
really special case pages for performance, we convert pages to netmem
then pipe them to through common code paths.  I can special case pages
here but we would also need to copy the implementation of
page_pool_get_dma_addr() as well. But note the tradeoff is some code
duplication. Seems from the discussions it's worth it which is fine by
me.

--=20
Thanks,
Mina

