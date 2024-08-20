Return-Path: <linux-kernel+bounces-293539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2725195810E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C613A1F2544A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1B418A926;
	Tue, 20 Aug 2024 08:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="VG8ajf6B"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9AB18A6BC
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724142787; cv=none; b=LbJiKJCfXnXNfPzTVIOuv3dQniRxNLPfZAuDXzCq9Kt4s0egQEQMDxBsGPD61uhUC/io2sQajylC9tqLep71k8sAMLgEnDPuTle6I0IZC1WxJwx0A+VYyXeo8txuLlUxhS3EwHaERF+GczKGBmh2pppH4y9okEaCbPlGkM9vsaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724142787; c=relaxed/simple;
	bh=sSUYkM8HYmaJN7xqG+tfsAHvEYV5RAq6szVJelU+X+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5JRV1hap3wL3btXHOzAKEeC6t+Al7n02haYDVEeJFzB7KzesL3eNWsEoD6Ebth5ezTRoq074vSsBbbKSLYWFn2ZVMwS5nR7IjM1e8CElCnaJvk7d1KfQN8/ZkTlvcnZtP0Gxg3KylyyxcR8LcWpdLbegbRvpEicxPWldCS3DzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=VG8ajf6B; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7d26c2297eso598942566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 01:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1724142784; x=1724747584; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XNQ9tyNfl4ljX/BPGLUOjjoGD0Ou+TIYM+qPExssLvc=;
        b=VG8ajf6BuTNmkSG0citgtyRIslAki+3nxKaQreOE/2Jt+XtQq867Hbt6IZQKqYcZIy
         Jah6u7gnrTVuJMlWiAlwcqZxMRsbpB8G9sGpIMHVAIwMhDn6Chc2+I4tonuf1y1MhNdL
         F8BFC3GhlV619NSvDG4KxYAMFyyT5dW/57ES4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724142784; x=1724747584;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XNQ9tyNfl4ljX/BPGLUOjjoGD0Ou+TIYM+qPExssLvc=;
        b=fO105jgJ1oXtAVjdp+NJ9AVKyap+BnqtdkyIuS/YKHDV6ParLL3YS8L2s+E6uqCDSc
         3it5dNS/rIpDlQ1z9NYGDOknSq8o9tcRlBqpsaG2fn1b4nCcU/6FIvC7fy1A511yEjXA
         hlCDq1nV6PxXHy5gQeGqzkJIFPjfseXPvOsY4GdCeoUIkYFZISdfcD55MKhSasLmpH3v
         zIPBYgh3TJImDjE7EyKqMqR75BHdhAtLsss9JdXe5WQs0sJ1RhpJ9bqW87UxN8fTHHkN
         LyfElyZAVhoWwqDvXM7Jlr51yPfy9TcaN6uaSaZpCd2Mx7iFs19WgAvNql/zCr/7w5x9
         /h0g==
X-Forwarded-Encrypted: i=1; AJvYcCVLd27LFIYwR+q4WRgSmSDj4GaReEQ5/W1vrbcS9hZn3CZdmC2OwPIz4/VuuFo2kGXGpj6dKNJ1E2wn1RaKcI5cwtflqiLxU0BSAwX/
X-Gm-Message-State: AOJu0Yz3S/I/H2sWciLEdkBQ3TtGcWLIs1HjUX4qkYGTihZMy+9dId9Y
	UK8qROh9i6GycHs5vzhWgT2jlbbWluGfgwRY0uZnLuB5o75CNnJhYCVR+rDcMMY=
X-Google-Smtp-Source: AGHT+IHdCu1gJlayHwi4drLhhfQxyfMUzMC+JYbFPtj9dlU1JF6GxmGI/OuqVO5LTmVnsfb9hkmppA==
X-Received: by 2002:a17:907:97cf:b0:a6f:59dc:4ece with SMTP id a640c23a62f3a-a83928a4023mr845774466b.2.1724142783295;
        Tue, 20 Aug 2024 01:33:03 -0700 (PDT)
Received: from LQ3V64L9R2.home ([2a02:c7c:f016:fc00:3906:31c:255a:bf09])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83aeb6eb4dsm435559766b.35.2024.08.20.01.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 01:33:03 -0700 (PDT)
Date: Tue, 20 Aug 2024 09:33:01 +0100
From: Joe Damato <jdamato@fastly.com>
To: Shay Drori <shayd@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	Jeroen de Borst <jeroendb@google.com>,
	Jiri Pirko <jiri@resnulli.us>, Leon Romanovsky <leon@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:MELLANOX MLX4 core VPI driver" <linux-rdma@vger.kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Shailend Chand <shailend@google.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Willem de Bruijn <willemb@google.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Ziwei Xiao <ziweixiao@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC net-next 0/6] Cleanup IRQ affinity checks in several drivers
Message-ID: <ZsRUvcOKLnTw16wD@LQ3V64L9R2.home>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Shay Drori <shayd@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	Jeroen de Borst <jeroendb@google.com>,
	Jiri Pirko <jiri@resnulli.us>, Leon Romanovsky <leon@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:MELLANOX MLX4 core VPI driver" <linux-rdma@vger.kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Shailend Chand <shailend@google.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Willem de Bruijn <willemb@google.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Ziwei Xiao <ziweixiao@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
References: <20240813171710.599d3f01@kernel.org>
 <ZrxZaHGDTO3ohHFH@LQ3V64L9R2.home>
 <ZryfGDU9wHE0IrvZ@LQ3V64L9R2.home>
 <20240814080915.005cb9ac@kernel.org>
 <ZrzLEZs01KVkvBjw@LQ3V64L9R2>
 <701eb84c-8d26-4945-8af3-55a70e05b09c@nvidia.com>
 <ZrzxBAWwA7EuRB24@LQ3V64L9R2>
 <20240814172046.7753a62c@kernel.org>
 <Zr3XA-VIE_pAu_k0@LQ3V64L9R2>
 <fe5c6b4b-6c78-402b-b454-837e3760c668@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe5c6b4b-6c78-402b-b454-837e3760c668@nvidia.com>

On Tue, Aug 20, 2024 at 09:40:31AM +0300, Shay Drori wrote:
> 
> 
> On 15/08/2024 13:22, Joe Damato wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Wed, Aug 14, 2024 at 05:20:46PM -0700, Jakub Kicinski wrote:
> > > On Wed, 14 Aug 2024 19:01:40 +0100 Joe Damato wrote:
> > > > If it is, then the only option is to have the drivers pass in their
> > > > IRQ affinity masks, as Stanislav suggested, to avoid adding that
> > > > call to the hot path.
> > > > 
> > > > If not, then the IRQ from napi_struct can be used and the affinity
> > > > mask can be generated on every napi poll. i40e/gve/iavf would need
> > > > calls to netif_napi_set_irq to set the IRQ mapping, which seems to
> > > > be straightforward.
> > > 
> > > It's a bit sad to have the generic solution blocked.
> > > cpu_rmap_update() is exported. Maybe we can call it from our notifier?
> > > rmap lives in struct net_device
> > 
> > I agree on the sadness. I will take a look today.
> > 
> > I guess if we were being really ambitious, we'd try to move ARFS
> > stuff into the core (as RSS was moved into the core).
> 
> 
> Sorry for the late reply. Maybe we can modify affinity notifier infra to
> support more than a single notifier per IRQ.
> @Thomas, do you know why only a single notifier per IRQ is supported?

Sorry for the delayed response as well on my side; I've been in
between lots of different kernel RFCs :)

Jakub: the issue seems to be that the internals in lib/cpu_rmap.c
are needed to call cpu_rmap_update. It's probably possible to expose
them somehow so that a generic IRQ notifier could call
cpu_rmap_update, as you mentioned, but some rewiring is going to be
needed, I think.

I had a couple ideas for rewiring stuff, but I haven't had time to
context switch back on to this work as I've been busy with a few
other things (the IRQ suspension stuff and another mlx5 thing I have
yet to send upstream).

I hope to take another look at it this week, but I welcome any
suggestions from Shay/Thomas in the meantime.

- Joe

