Return-Path: <linux-kernel+bounces-273871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB95A946F0B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 15:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B461E1C20993
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 13:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9758141A80;
	Sun,  4 Aug 2024 13:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PzM3bHWe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CF4A934
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 13:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722778781; cv=none; b=cKyyQBlCTsNwHtq2XK4cbmMdDZ0gbVHL+IqujIDcgnHSup2tEx4Ygb9wHWLQYfd0lEYzWjWMvGxXbm/IcUV+S9i9sImcj1Lh9sNhYGVssM5uxUfAtad6Qk0VMUOSJ8tfBrlw6NPhftsW6hRY4FHiHhqfeHtmRyHK16MOtv1jncw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722778781; c=relaxed/simple;
	bh=2AugPwDuU8yhl8qvqeoxq4lzHQhzQldSKoXcfX07peE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6vFrTQJIo/CEy7wdVCWH9AJzQjDxz3LMSVRH+8cFS1L61d/HFc8WFqw3of01PckgVsqdUNNqQ0i/WR7K+1BRxZZjeDs0O5SZXbY1UkclCy10KIPtuFLF3HmKLna23l73yTAK7DH+J3jia2YskewlGpCOWoFMqUgOYJ4+csB+Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PzM3bHWe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722778779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2peBEAi5l+wVKoySzP8bmu5eaRki7zaxF+VnoO41OFo=;
	b=PzM3bHWewn0W3nw5s+fvzR9Mnt+b1a3UCwOfG6s3t3PFUOuY8r/CIXNSST20PxfiXEwqT6
	Z/7K/rydCKyXBfru/dleK5f1X7zHKWhX3gbEPmGTKjEL2LTnjHtEcxkQXXQDZ0WHBpCURA
	5xUjyyLL3E+qMizjBi1RDYXhRFyph64=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-rEMUBV-tPBSHMfOCHJyN3w-1; Sun, 04 Aug 2024 09:39:37 -0400
X-MC-Unique: rEMUBV-tPBSHMfOCHJyN3w-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3684ea1537fso4845247f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2024 06:39:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722778776; x=1723383576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2peBEAi5l+wVKoySzP8bmu5eaRki7zaxF+VnoO41OFo=;
        b=BJYH/snjWxlT6QjS157wE/cxpXy/X353eAcUk1UgI1k/0xFEdI7wR1BJj/ZTD+BRUV
         WKwhx2wcgF3EaPzOulvMSh784l/BvozUtllSyVphaZln+fo8BVsIj38Z4SvOaQiZV6u0
         Z8QcGPTXa0bsOp5Lzy5WAmamFHIgPdnfHnjhfB/pIn+PjFPeuMK8fqAhpP4rxbT2gJX3
         RGMiOCCtM13ytfPk/HoPiuAp0Oti7Br2qGrs/hwNIP+MrKMRhuUuKZ0UN2aV6qX9+mAv
         QU0V4Ocp6pqi9vhC3aaun/4S1LwbD/gNj+zxwWi/vHkVNn75nwU66llXetTLwEpGwXMI
         3xPg==
X-Forwarded-Encrypted: i=1; AJvYcCVFnHnp2kTVwWQYeklP7CIBsEeE6bHaQZzFsQOD8Rt13VzIo82z8EsWIuuWnuTz2FyvQnyJvqRPYdHicMDcWOs1LBZU/bFUm7M/wf4H
X-Gm-Message-State: AOJu0YzMPYZy9jbu/HquBTlwyCmYX9gS1sMFAm7Fi01/cHqUeXWkolKu
	Gln8AgXs/dj96suKIIyLjijfO+8qvr2MFwaHen0lOA16AYzbS7EaiauLnvvpOuPFyYFuajlv+rJ
	69Ww8a94Bw3UGaTrNjISM9HleBSjZGLzOrN8At5vRtBSDRi6qJdYzRInV+s6MjQ==
X-Received: by 2002:a5d:51ce:0:b0:367:402f:805b with SMTP id ffacd0b85a97d-36bbc0f7b74mr5864613f8f.2.1722778776466;
        Sun, 04 Aug 2024 06:39:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8zEsyUU26zzmWyx8ERloHuBuYDjvidaSX/T11okipj5m2JCXFejr2k7ue7WGpVmp5XAZc5A==
X-Received: by 2002:a5d:51ce:0:b0:367:402f:805b with SMTP id ffacd0b85a97d-36bbc0f7b74mr5864600f8f.2.1722778775654;
        Sun, 04 Aug 2024 06:39:35 -0700 (PDT)
Received: from redhat.com ([2.55.39.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e31da0sm99948515e9.22.2024.08.04.06.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 06:39:34 -0700 (PDT)
Date: Sun, 4 Aug 2024 09:39:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Dragos Tatulea <dtatulea@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Si-Wei Liu <si-wei.liu@oracle.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH vhost 0/7] vdpa/mlx5: Parallelize device suspend/resume
Message-ID: <20240804093909-mutt-send-email-mst@kernel.org>
References: <20240802072039.267446-1-dtatulea@nvidia.com>
 <20240802091307-mutt-send-email-mst@kernel.org>
 <20240804084839.GA22826@unreal>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804084839.GA22826@unreal>

On Sun, Aug 04, 2024 at 11:48:39AM +0300, Leon Romanovsky wrote:
> On Fri, Aug 02, 2024 at 09:14:28AM -0400, Michael S. Tsirkin wrote:
> > On Fri, Aug 02, 2024 at 10:20:17AM +0300, Dragos Tatulea wrote:
> > > This series parallelizes the mlx5_vdpa device suspend and resume
> > > operations through the firmware async API. The purpose is to reduce live
> > > migration downtime.
> > > 
> > > The series starts with changing the VQ suspend and resume commands
> > > to the async API. After that, the switch is made to issue multiple
> > > commands of the same type in parallel.
> > > 
> > > Finally, a bonus improvement is thrown in: keep the notifierd enabled
> > > during suspend but make it a NOP. Upon resume make sure that the link
> > > state is forwarded. This shaves around 30ms per device constant time.
> > > 
> > > For 1 vDPA device x 32 VQs (16 VQPs), on a large VM (256 GB RAM, 32 CPUs
> > > x 2 threads per core), the improvements are:
> > > 
> > > +-------------------+--------+--------+-----------+
> > > | operation         | Before | After  | Reduction |
> > > |-------------------+--------+--------+-----------|
> > > | mlx5_vdpa_suspend | 37 ms  | 2.5 ms |     14x   |
> > > | mlx5_vdpa_resume  | 16 ms  | 5 ms   |      3x   |
> > > +-------------------+--------+--------+-----------+
> > > 
> > > Note for the maintainers:
> > > The first patch contains changes for mlx5_core. This must be applied
> > > into the mlx5-vhost tree [0] first. Once this patch is applied on
> > > mlx5-vhost, the change has to be pulled from mlx5-vdpa into the vhost
> > > tree and only then the remaining patches can be applied.
> > 
> > Or maintainer just acks it and I apply directly.
> 
> We can do it, but there is a potential to create a conflict between your tree
> and netdev for whole cycle, which will be a bit annoying. Easiest way to avoid
> this is to have a shared branch, but in august everyone is on vacation, so it
> will be probably fine to apply such patch directly.
> 
> Thanks

We can let Linus do something, it's ok ;)

> > 
> > Let me know when all this can happen.
> > 
> > > [0] https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/log/?h=mlx5-vhost
> > > 
> > > Dragos Tatulea (7):
> > >   net/mlx5: Support throttled commands from async API
> > >   vdpa/mlx5: Introduce error logging function
> > >   vdpa/mlx5: Use async API for vq query command
> > >   vdpa/mlx5: Use async API for vq modify commands
> > >   vdpa/mlx5: Parallelize device suspend
> > >   vdpa/mlx5: Parallelize device resume
> > >   vdpa/mlx5: Keep notifiers during suspend but ignore
> > > 
> > >  drivers/net/ethernet/mellanox/mlx5/core/cmd.c |  21 +-
> > >  drivers/vdpa/mlx5/core/mlx5_vdpa.h            |   7 +
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c             | 435 +++++++++++++-----
> > >  3 files changed, 333 insertions(+), 130 deletions(-)
> > > 
> > > -- 
> > > 2.45.2
> > 
> > 


