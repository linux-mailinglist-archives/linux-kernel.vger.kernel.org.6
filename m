Return-Path: <linux-kernel+bounces-533441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C2FA45A76
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CAA816A941
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C732238153;
	Wed, 26 Feb 2025 09:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AvRqVXgA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024811E1E18
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 09:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740562919; cv=none; b=pYNJnr9FZdFlfQMOYxOeRcAkRh1DVZ6dvjnrxEoRXrXVpBmLpNcHwObUuAtDzqsL/EzxM3UkbN9HvpR3MIeLlCCn6Choh7eSndyNjSfoMgiMEyJ6TfDOuaFbNctaJjtZ7Qc+M/9kfOb3JxdgbhvwBh3F7DbxBU7ojX3wN3DExEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740562919; c=relaxed/simple;
	bh=vlwe3g7egmkzEBkQSzX3LSMTW10UmJaDYSyt6uIJXOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=apnbUqNQ7CIkokINpHl9a6Cp1Q5Gd5Sk7shsoh8K+8GaJoVWW5C9gmAnLSwMjmV4gude0VgmiNw7ZNiZPL/zRSQ1g+JeTBJuGYDDF0szPXqD7gg8xKNbk8yRWgR1WLp3tQv2xWcBqnJdGSt9lvEqyr2ZSX+GIbwe7MVj20THiqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AvRqVXgA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740562916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=35a45e+KUNfgdwWER78OhdI0cbUBUXNz7n/UkAMYBnI=;
	b=AvRqVXgAowx28RhouMLQKbXFaIuXl/B634eGk75Ibz+S6xV4izvVSFtnJ5q8BYdAl3GM0B
	leqWbsBqThS0yrqwwACW/JxikQ5z+X9zREfAHOJYdAZs0grv2pCSrCxmfIE93zwidtkxbx
	OebBHxz25sk18bzRaYi4zst2L3iLK3o=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-lnyG06BTMCWrRkRcZ7RYnQ-1; Wed, 26 Feb 2025 04:41:55 -0500
X-MC-Unique: lnyG06BTMCWrRkRcZ7RYnQ-1
X-Mimecast-MFC-AGG-ID: lnyG06BTMCWrRkRcZ7RYnQ_1740562914
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fe862ea448so1416508a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 01:41:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740562914; x=1741167714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35a45e+KUNfgdwWER78OhdI0cbUBUXNz7n/UkAMYBnI=;
        b=vT3W2S4QZF4zkb3hZFIQDdeEkD+10tgm6tfStUiaCs+LWOYIFode7KozQA9YyOYkr5
         cedM570Rps1XA5JgZP0MZFNoS/BkwLz8xPsKT4N4ifpBp17EJH6ZEW23fSYYuR9FwsDM
         AlfFv/AODRxuULlNVqYtlQ8OCARXIJ3xtAIJNmHIVHPLRSxQpYXTb80oxLKlxowHFuY1
         eIhzaAQbQ1wo8OCxS6udYAEWWE/4RNBhTXWiEYSzEwSAyOwGBivxUuDoWBeeogEg6EVL
         /0bG5xw48JSpzQeqY5vPpRwxOghYQ5beiQX7xzLc10AjlIQGKZM2jU3wWgCMIdDVMSfN
         PVXw==
X-Forwarded-Encrypted: i=1; AJvYcCVw95YF190reZYQbxtTwqsgeHPH5HS+69F0OU39ahYw5inTeRwnlNtoZaoVCrzEQxbBNbMAjOdwXQFghLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxceRk4Q/zb6BujdW7tbGuIpjEsy7LLd7klmja4nsoMImipsQzc
	SKU7QfRTRGNNMTbN+1Ny0AqT2jr1p1soVose98OZH50hUk8jMhKj05epuQc+0c9aKpDCIbt4oJT
	jwzbyUQT7pW5JCnZU2lQg/djo60vlK96EbvVREQgg+XWQG1nEvGX4xVaNBv12ULWD7iFMgHamEl
	K2kD21OKd1c5zKm9CcJHPnF43ZGHs05jpktLSE
X-Gm-Gg: ASbGncsgTScGZ0MOI1iGd3i4kSWNCeB2tswvdGjpR4jMJDGGgdPOBHs55pmeYxB8H7d
	ESPvuiHeZfGG79xTJ20Auu0PUE9ygzd9VwzRB+jWs6PWM6p/e1J/KpUqAGaCcQ+kpxnOYptSLcw
	==
X-Received: by 2002:a17:90b:3bcb:b0:2ea:b564:4b31 with SMTP id 98e67ed59e1d1-2fe68ae7147mr9875979a91.19.1740562914029;
        Wed, 26 Feb 2025 01:41:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFd2VtFq1+EBSUe5YRiKx2c1b8xErNTKsEKpyNpzK8NMUkxluegLLjCSvqusnZyPT8sBH5l6nTPU/LhghJl6kU=
X-Received: by 2002:a17:90b:3bcb:b0:2ea:b564:4b31 with SMTP id
 98e67ed59e1d1-2fe68ae7147mr9875939a91.19.1740562913645; Wed, 26 Feb 2025
 01:41:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225020455.212895-1-jdamato@fastly.com> <CAPpAL=w7e8F_0_RRhBuyM-qyaYxgR=miYf_h90j78HzR4dvQxg@mail.gmail.com>
In-Reply-To: <CAPpAL=w7e8F_0_RRhBuyM-qyaYxgR=miYf_h90j78HzR4dvQxg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Feb 2025 17:41:41 +0800
X-Gm-Features: AWEUYZkhxJqSexlmCxlZ4MpaYPDcVZbl2V5cw5njrD7GTgOGPeEvAyX7SCzxTvM
Message-ID: <CACGkMEvaYvrxsbOdiN8tfba4t5vH_L8=5MnZqb_P6qNwv2x0Tw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/4] virtio-net: Link queues to NAPIs
To: Lei Yang <leiyang@redhat.com>
Cc: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org, mkarsten@uwaterloo.ca, 
	gerhard@engleder-embedded.com, xuanzhuo@linux.alibaba.com, kuba@kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	open list <linux-kernel@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Paolo Abeni <pabeni@redhat.com>, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 11:47=E2=80=AFPM Lei Yang <leiyang@redhat.com> wrot=
e:
>
> I tested this series of patches with virtio-net regression tests,
> everything works fine.
>
> Tested-by: Lei Yang <leiyang@redhat.com>

If it's possible, I would like to add the resize (via ethtool) support
in the regression test.

Thanks

>
>
> On Tue, Feb 25, 2025 at 10:05=E2=80=AFAM Joe Damato <jdamato@fastly.com> =
wrote:
> >
> > Greetings:
> >
> > Welcome to v4.
> >
> > Jakub recently commented [1] that I should not hold this series on
> > virtio-net linking queues to NAPIs behind other important work that is
> > on-going and suggested I re-spin, so here we are :)
> >
> > This is a significant refactor from the rfcv3 and as such I've dropped
> > almost all of the tags from reviewers except for patch 4 (sorry Gerhard
> > and Jason; the changes are significant so I think patches 1-3 need to b=
e
> > re-reviewed).
> >
> > As per the discussion on the v3 [2], now both RX and TX NAPIs use the
> > API to link queues to NAPIs. Since TX-only NAPIs don't have a NAPI ID,
> > commit 6597e8d35851 ("netdev-genl: Elide napi_id when not present") now
> > correctly elides the TX-only NAPIs (instead of printing zero) when the
> > queues and NAPIs are linked.
> >
> > See the commit message of patch 3 for an example of how to get the NAPI
> > to queue mapping information.
> >
> > See the commit message of patch 4 for an example of how NAPI IDs are
> > persistent despite queue count changes.
> >
> > Thanks,
> > Joe
> >
> > v4:
> >   - Dropped Jakub's patch (previously patch 1).
> >   - Significant refactor from v3 affecting patches 1-3.
> >   - Patch 4 added tags from Jason and Gerhard.
> >
> > rfcv3: https://lore.kernel.org/netdev/20250121191047.269844-1-jdamato@f=
astly.com/
> >   - patch 3:
> >     - Removed the xdp checks completely, as Gerhard Engleder pointed
> >       out, they are likely not necessary.
> >
> >   - patch 4:
> >     - Added Xuan Zhuo's Reviewed-by.
> >
> > v2: https://lore.kernel.org/netdev/20250116055302.14308-1-jdamato@fastl=
y.com/
> >   - patch 1:
> >     - New in the v2 from Jakub.
> >
> >   - patch 2:
> >     - Previously patch 1, unchanged from v1.
> >     - Added Gerhard Engleder's Reviewed-by.
> >     - Added Lei Yang's Tested-by.
> >
> >   - patch 3:
> >     - Introduced virtnet_napi_disable to eliminate duplicated code
> >       in virtnet_xdp_set, virtnet_rx_pause, virtnet_disable_queue_pair,
> >       refill_work as suggested by Jason Wang.
> >     - As a result of the above refactor, dropped Reviewed-by and
> >       Tested-by from patch 3.
> >
> >   - patch 4:
> >     - New in v2. Adds persistent NAPI configuration. See commit message
> >       for more details.
> >
> > v1: https://lore.kernel.org/netdev/20250110202605.429475-1-jdamato@fast=
ly.com/
> >
> > [1]: https://lore.kernel.org/netdev/20250221142650.3c74dcac@kernel.org/
> > [2]: https://lore.kernel.org/netdev/20250127142400.24eca319@kernel.org/
> >
> > Joe Damato (4):
> >   virtio-net: Refactor napi_enable paths
> >   virtio-net: Refactor napi_disable paths
> >   virtio-net: Map NAPIs to queues
> >   virtio_net: Use persistent NAPI config
> >
> >  drivers/net/virtio_net.c | 100 ++++++++++++++++++++++++++++-----------
> >  1 file changed, 73 insertions(+), 27 deletions(-)
> >
> >
> > base-commit: 7183877d6853801258b7a8d3b51b415982e5097e
> > --
> > 2.45.2
> >
> >
>


