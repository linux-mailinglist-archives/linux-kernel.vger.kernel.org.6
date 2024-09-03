Return-Path: <linux-kernel+bounces-313561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE3396A712
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863521F25216
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 19:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2CB1CF5FA;
	Tue,  3 Sep 2024 19:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Wdj++bi"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27781D223A
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 19:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725390311; cv=none; b=KwbY8SmA8P1MwuNe+kSTFw9geLi8j7/rPni2fyzvw+unVxzJW9ccY9X+AP5jYE9K648KCeWzZjJ4CuUkR/BcmkUZndnRMaPp9WKhZdhPoJzHYjRHXO+yxXBk/kbz43kYaXxXBrL5DCkrP4OcdoY1ciT7t+rUkFqR55mhbF52X0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725390311; c=relaxed/simple;
	bh=w+jDi7RcNQxtOiu+6aMiU4/n1Uk7BZeU/qqu0gwOYvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iy/skyXbm9LtqKiiO/wpK2Uwu+6teLFgy9XXgZfkovOj+bBB/oFDrjrak0hLt6vcl53qXwOhTMrdAzdqmXUvfUGdtTqRj0G2rZgMMOmw8gdhu7TI9jQDIpkCCO7Ab+/RW7IAjvq9OIx0VEzeDSQLi2CEjiPEPA9bnnsovYEM+8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1Wdj++bi; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42ba8928f1dso10275e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 12:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725390308; x=1725995108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rahCq1DYAWjdApi15bVGO4FBhrEqXpDzAgfwt/HJkA=;
        b=1Wdj++bi8ShZ/HVSGXAkE0VtZlP9yjr/C7Et19vUTLAdxqTKoe0u1tlEpbL9cGMoDM
         OX5TjFhifykacy9XDrNgsKU0G2iiTH/HfiXFBgviNFnFXGpL/DrCT6waTB8HXnPaW+HX
         GRogwI5XXHI8a0v82LUjsZupAF2oORkdSCW9/LV7qSk96a+yGvFl9WmRfBwg0PbIsZ9k
         fqxrjODBFpTE/fv+hKG+qMRqiOv9u0svdtIXqFwucR8EaX1kezVNVXHwBDHu7ikpoa5A
         bVqYZN9CPtQtGOZvKjWzbFZerUpgtL2a6l5U/hZ/nSHuBhEp7R8tDPqkgPPQfsZMfc2e
         CrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725390308; x=1725995108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rahCq1DYAWjdApi15bVGO4FBhrEqXpDzAgfwt/HJkA=;
        b=WEoZOi7pVv2T5kiz5GL2zAeZ0cLASH5kVrKPX65u0gHcdmMOVVXmrJW425sDEXoSG/
         dn2I6E06MzQCGZb4Y2QNltmsWdZSuFMRK/FexE7VhMBZR3ZiuSGvOxrsxUIFl28tFBVD
         daaSPk8hd8mueouSCfw+arfh3strBsTl8CKK/z1nYxFqTC2fVI4ax4bOCRq48JDKSEpP
         W07l5mSU1+Drue/1KGrcXOFBXdhhsYuIv+38uCmUOodBX6E4d++2QBNxoqDGRn+Rww1q
         IW6qoTZ4yq8nP2Nb8GKzPjzzQF7e30dUUpBS5SVUtJa3GJQ+MZ2v+9GRJ26zBAT4Tucf
         1JWg==
X-Forwarded-Encrypted: i=1; AJvYcCVbHgDcC4Sdyynnm32ulpm1BPFYVIV3zWrO5WLJ/tOOUe+nXWUrgNOCQHLn/QYxmnXsy2bcPcNHeayzamI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrtxnTa5a4dflkZcwVgUia0592lU67E1w2nCoy0o61x38eV6zo
	UbeQ6KzObKHsvOk2G2lElHogKRxSzNYljUtm8zlitYJMk/nOwxl/sDZ5DHzaUsblPaUFmzQyNnU
	eyjTkpvH+qwrZYZ3GOQMpXkJn4iAoQBb+qiJ5
X-Google-Smtp-Source: AGHT+IELxOCopWmwVWzUb+RsPdYvaNL/p4L6SjQTz4ioRaAERqEQSWY7RwxQCdmsgvQM6hONALoI3itqJnp2662cN4A=
X-Received: by 2002:a05:600c:3d12:b0:42b:892a:333b with SMTP id
 5b1f17b1804b1-42c946b7ba2mr211035e9.2.1725390307846; Tue, 03 Sep 2024
 12:05:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829131214.169977-1-jdamato@fastly.com> <20240829131214.169977-6-jdamato@fastly.com>
 <20240829153105.6b813c98@kernel.org> <ZtGiNF0wsCRhTtOF@LQ3V64L9R2>
 <20240830142235.352dbad5@kernel.org> <ZtXuJ3TMp9cN5e9h@LQ3V64L9R2.station> <20240902180220.312518bc@kernel.org>
In-Reply-To: <20240902180220.312518bc@kernel.org>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Tue, 3 Sep 2024 12:04:52 -0700
Message-ID: <CAAywjhTG+2BmoN76kaEmWC=J0BBvnCc7fUhAwjbSX5xzSvtGXw@mail.gmail.com>
Subject: Re: [PATCH net-next 5/5] netdev-genl: Support setting per-NAPI config values
To: Jakub Kicinski <kuba@kernel.org>
Cc: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org, edumazet@google.com, 
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com, sdf@fomichev.me, 
	bjorn@rivosinc.com, hch@infradead.org, willy@infradead.org, 
	willemdebruijn.kernel@gmail.com, Martin Karsten <mkarsten@uwaterloo.ca>, 
	Donald Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Daniel Jurgens <danielj@nvidia.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is great Joe.

On Mon, Sep 2, 2024 at 6:02=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon, 2 Sep 2024 18:56:07 +0200 Joe Damato wrote:
> > > How do you feel about making this configuration opt-in / require driv=
er
> > > changes? What I'm thinking is that having the new "netif_napi_add()"
> > > variant (or perhaps extending netif_napi_set_irq()) to take an extra
> > > "index" parameter would make the whole thing much simpler.
> >
> > What about extending netif_queue_set_napi instead? That function
> > takes a napi and a queue index.
>
> This may become problematic, since there may be more queues than NAPIs.
> Either with multiple combined queues mapped to a single NAPI, or having
> separate Rx/Tx NAPIs.
>
> No strong preference on which function we modify (netif_napi_add vs the
> IRQ setting helper) but I think we need to take the index as an
> explicit param, rather than try to guess it based on another ID.
> The queue ID will match 95% of the time, today. But Intel was
> interested in "remapping" queues. And we all think about a queue API...
> So using queue ID is going to cause problems down the road.
Do we need a queue to napi association to set/persist napi
configurations? Can a new index param be added to the netif_napi_add
and persist the configurations in napi_storage. I guess the problem
would be the size of napi_storage.

Also wondering if for some use case persistence would be problematic
when the napis are recreated, since the new napi instances might not
represent the same context? For example If I resize the dev from 16
rx/tx to 8 rx/tx queues and the napi index that was used by TX queue,
now polls RX queue.
>
> > Locally I kinda of hacked up something simple that:
> >   - Allocates napi_storage in net_device in alloc_netdev_mqs
> >   - Modifies netif_queue_set_napi to:
> >      if (napi)
> >        napi->storage =3D dev->napi_storage[queue_index];
> >
> > I think I'm still missing the bit about the
> > max(rx_queues,tx_queues), though :(
>
> You mean whether it's enough to do
>
>         napi_cnt =3D max(txqs, rxqs)
>
> ? Or some other question?
>
> AFAIU mlx5 can only have as many NAPIs as it has IRQs (256?).
> Look at ip -d link to see how many queues it has.
> We could do txqs + rxqs to be safe, if you prefer, but it will
> waste a bit of memory.
>
> > > Index would basically be an integer 0..n, where n is the number of
> > > IRQs configured for the driver. The index of a NAPI instance would
> > > likely match the queue ID of the queue the NAPI serves.
> >
> > Hmmm. I'm hesitant about the "number of IRQs" part. What if there
> > are NAPIs for which no IRQ is allocated ~someday~ ?
>
> A device NAPI without an IRQ? Whoever does something of such silliness
> will have to deal with consequences. I think it's unlikely.
>
> > It seems like (I could totally be wrong) that netif_queue_set_napi
> > can be called and work and create the association even without an
> > IRQ allocated.
> >
> > I guess the issue is mostly the queue index question above: combined
> > rx/tx vs drivers having different numbers of rx and tx queues.
>
> Yes, and in the future the ability to allocate more queues than NAPIs.
> netif_queue_set_napi() was expected to cover such cases.
>
> > > We can then allocate an array of "napi_configs" in net_device -
> > > like we allocate queues, the array size would be max(num_rx_queue,
> > > num_tx_queues). We just need to store a couple of ints so it will
> > > be tiny compared to queue structs, anyway.
> > >
> > > The NAPI_SET netlink op can then work based on NAPI index rather
> > > than the ephemeral NAPI ID. It can apply the config to all live
> > > NAPI instances with that index (of which there really should only
> > > be one, unless driver is mid-reconfiguration somehow but even that
> > > won't cause issues, we can give multiple instances the same settings)
> > > and also store the user config in the array in net_device.
> > >
> > > When new NAPI instance is associate with a NAPI index it should get
> > > all the config associated with that index applied.
> > >
> > > Thoughts? Does that makes sense, and if so do you think it's an
> > > over-complication?
> >
> > I think what you are proposing seems fine; I'm just working out the
> > implementation details and making sure I understand before sending
> > another revision.
>
> If you get stuck feel free to send a link to a GH or post RFC.
> I'm adding extra asks so whether form of review helps.. :)

