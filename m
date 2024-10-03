Return-Path: <linux-kernel+bounces-349511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB4898F72A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 21:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1211C22097
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 19:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529131AC88B;
	Thu,  3 Oct 2024 19:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="PKQM7yeB"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F6517BA3
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 19:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727984853; cv=none; b=OPOGUITGM6EYeLfqObOnwYffljc9vmGQglhFdjox2cEwlD75lLsz57u+XzCZOuD4WQBO/IsYt1KFeQHhH/rODLX2xIw0lHijJytYRquCT57oTXLNSpaWnVwu5WJHxJXdaOhm9j8qtAI73kmzGnPECub55q6hnG9Jm07WARjRYXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727984853; c=relaxed/simple;
	bh=f/n1fnuRk2wySinm2hdA0/J+6kWStc5EkQ8GcqSDVjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4Ge8GU/Ai73rN3o8UT+V3wzpoaseh/7DIqWHA2AY+biLavGEMD6q5gryy/nrYfdopqCkZUF3qKEeY3vbB1XP+l4FcmeqZLnLeeCFTiYzVQIgwG7z68AFtiSs5pDmwsQsiH8lRlDVFcdz6jl+p8x3oEdvwLmJBzevfvFQVYNb/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=PKQM7yeB; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e0a950e2f2so1193891a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 12:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727984851; x=1728589651; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E6szT/FpCAfvnqIBQRuc9jFvCTYo4EHgz6+eLgogUoQ=;
        b=PKQM7yeB9dsVvE7O4oRrZ5kjwWEAKMkZdNgXxGkyemrBKFn1LExQlkaluX9+tuq45p
         OAEWYcAQ9KtIbbmI0DCB1J7MSy1iVoq0z258Ks013bW5YObwPYsoTp6je1y1AQ6aXA+l
         A+Q5kGRbaU2Dh9NxFgbpJOU48j72brJP88mR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727984851; x=1728589651;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E6szT/FpCAfvnqIBQRuc9jFvCTYo4EHgz6+eLgogUoQ=;
        b=MBqfLoBHp8Yd2mhsVk5tbQ9HufT+gLtL5Dvyc2OPZAj7HS9qUXlKXPPPEK1tx69mJ8
         VknY0E7qtY8T1zquPtr3Ysgb1xUULENaUA7sbB5dG6fBgQXvZBNk7+qcdhFY3/1b3/3c
         HrAw+Oqfwngktoyw7kjs8yRFNGj9IOJT589O0t+GVSFSahcT+VURKhjcGaBnEnKmP0wF
         o84pPIwMRAbDwJ+cZkYhHGrbB5eG9p5vFfZohJldA0bhwMtZ3s7+p76ey5uopa12lcPs
         NUafJicSVLMaayR39MXR0PBsQxORQypnZUhB58/rZkiY/hzrQbwbSHbSttgRmtrlGxBq
         NppA==
X-Forwarded-Encrypted: i=1; AJvYcCUTCtgADDVMHQBtI2nBEcNkOghLU64vAu7xXEayCwCdXEZVTCHEfYD2NbnGX3QzgXhoSxV9ZjgGDw/6T2I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh8bzmM3/2BH7bu82ALNiUFeBIb9W77oV/SI2/dOJ9RK40TPkb
	XCZaXr5pG1pf5YnlUwbj7r4w0lXtBe3gz4Iz6QkZOSaSbRvX0zrsgY2ynrUKx6xN+onVqHHzwQT
	u
X-Google-Smtp-Source: AGHT+IHV2/djWNYS5fw+1rgEidSNS8de6CY94Cyn5UGCw1O7IeO2aCLwXJh1lfVYZNys6q+7KBu9KQ==
X-Received: by 2002:a17:90a:3487:b0:2c9:81fd:4c27 with SMTP id 98e67ed59e1d1-2e1e6228335mr253720a91.14.1727984851413;
        Thu, 03 Oct 2024 12:47:31 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1bff5474esm2077328a91.54.2024.10.03.12.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 12:47:30 -0700 (PDT)
Date: Thu, 3 Oct 2024 12:47:28 -0700
From: Joe Damato <jdamato@fastly.com>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: netdev@vger.kernel.org, Michael Chan <mchan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v2 2/2] tg3: Link queues to NAPIs
Message-ID: <Zv700Aoyx_XG6QVd@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>, netdev@vger.kernel.org,
	Michael Chan <mchan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20240925162048.16208-1-jdamato@fastly.com>
 <20240925162048.16208-3-jdamato@fastly.com>
 <ZvXrbylj0Qt1ycio@LQ3V64L9R2>
 <CALs4sv1G1A8Ljfb2WAi7LkBN6oP62TzH6sgWyh5jaQsHw3vOFg@mail.gmail.com>
 <Zv3VhxJtPL-27p5U@LQ3V64L9R2>
 <CALs4sv0-FeMas=rSy8OHy_HLiQxQ+gZwAfZVAdzwhFbG+tTzCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALs4sv0-FeMas=rSy8OHy_HLiQxQ+gZwAfZVAdzwhFbG+tTzCg@mail.gmail.com>

On Thu, Oct 03, 2024 at 09:56:40AM +0530, Pavan Chebbi wrote:
> On Thu, Oct 3, 2024 at 4:51 AM Joe Damato <jdamato@fastly.com> wrote:
> >
> 
> > This is happening because the code in the driver does this:
> >
> >   for (i = 0; i < tp->irq_cnt; i++) {
> >           tnapi = &tp->napi[i];
> >           napi_enable(&tnapi->napi);
> >           if (tnapi->tx_buffers)
> >                 netif_queue_set_napi(tp->dev, i, NETDEV_QUEUE_TYPE_TX,
> >                                      &tnapi->napi);
> >
> > The code I added assumed that i is the txq or rxq index, but it's
> > not - it's the index into the array of struct tg3_napi.
> 
> Yes, you are right..
> >
> > Corrected, the code looks like something like this:
> >
> >   int txq_idx = 0, rxq_idx = 0;
> >   [...]
> >
> >   for (i = 0; i < tp->irq_cnt; i++) {
> >           tnapi = &tp->napi[i];
> >           napi_enable(&tnapi->napi);
> >           if (tnapi->tx_buffers) {
> >                 netif_queue_set_napi(tp->dev, txq_idx, NETDEV_QUEUE_TYPE_TX,
> >                                      &tnapi->napi);
> >                 txq_idx++
> >           } else if (tnapi->rx_rcb) {
> >                  netif_queue_set_napi(tp->dev, rxq_idx, NETDEV_QUEUE_TYPE_RX,
> >                                       &tnapi->napi);
> >                  rxq_idx++;
> >           [...]
> >
> > I tested that and the output looks correct to me. However, what to
> > do about tg3_napi_disable ?
> >
> > Probably something like this (txq only for brevity):
> >
> >   int txq_idx = tp->txq_cnt - 1;
> >   [...]
> >
> >   for (i = tp->irq_cnt - 1; i >= 0; i--) {
> >     [...]
> >     if (tnapi->tx_buffers) {
> >         netif_queue_set_napi(tp->dev, txq_idx, NETDEV_QUEUE_TYPE_TX,
> >                              NULL);
> >         txq_idx--;
> >     }
> >     [...]
> >
> > Does that seem correct to you? I wanted to ask before sending
> > another revision, since I am not a tg3 expert.
> >
> 
> The local counter variable for the ring ids might work because irqs
> are requested sequentially.

Yea, my proposal relies on the sequential ordering.

> Thinking out loud, a better way would be to save the tx/rx id inside
> their struct tg3_napi in the tg3_request_irq() function.

I think that could work, yes. I wasn't sure if you'd be open to such
a change.

It seems like in that case, though, we'd need to add some state
somewhere.

It's not super clear to me where the appropriate place for the state
would be because tg3_request_irq is called in a couple places (like
tg3_test_interrupt).

Another option would be to modify tg3_enable_msix and modify:

  for (i = 0; i < tp->irq_max; i++)
          tp->napi[i].irq_vec = msix_ent[i].vector;

But, all of that is still a bit invasive compared to the running
rxq_idx txq_idx counters I proposed in my previous message.

I am open to doing whatever you suggest/prefer, though, since it is
your driver after all :)

> And have a separate new function (I know you did something similar for
> v1 of irq-napi linking) to link queues and napi.
> I think it should work, and should help during de-linking also. Let me
> know what you think.

I think it's possible, it's just disruptive and it's not clear if
it's worth it? Some other code path might break and it might be fine
to just rely on the sequential indexing? Not sure.

Let me know what you think; thanks for taking the time to review and
respond.

