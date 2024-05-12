Return-Path: <linux-kernel+bounces-176971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDF48C37FF
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 20:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F3CD1C20AA4
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 18:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01435103C;
	Sun, 12 May 2024 18:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="wdMvA4Qv"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45792D04E
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 18:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715539047; cv=none; b=Mqma7yOIUQ/602BpzXEgSfP8OZ8EsPnDtxwEQdtZ6xtwXwjW/MHPrT5V+Xd2FTJROHO46YOfDhdcjcX4+1AZdzG8Iz4VrZPdFyoj9S/mhnuM9MyzKU6Vv3eXWC53Ocs1nT8cy/vcAAr7lxtVzWfLvZ0MgGsMwhamKq4BTYCkkOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715539047; c=relaxed/simple;
	bh=EsBxKjiK3YT2IXz67XdPLB6hnSXRyOnEnLz6QQoWq/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c59LtIuSrNk2rNUDaT5REzh48MnkMdU8nLJh7mg7S2ExPBxXqlhXe4xe24nyQGVU5vD5SiObnfsIq1LQsczJBHuqoPRHg4Fya02/qK0IPQ08E4Xm4mMIhq3AIN11qpeD4OmF8ZmqCTKKpcIJVaT8/uoGBEi4HCqBGmXk3B36uJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=wdMvA4Qv; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ee954e0aa6so26675195ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 11:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1715539044; x=1716143844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xvDALX2Uri5RTgIn6pzRLr5p/TpABW6ze+cHJXhnhz0=;
        b=wdMvA4QvO9dUJ6/CsD1KXqndM/gwWX/PlXL09eiIqLKMVjvLAyYRzkLxxbOa8OgN9K
         TiiYmLKLrMg71pBy5XAc1Hwp1Fmeli8fVtTmj36MHgcMccKSQk5IfwlCpxUz0rXFYhEG
         8zPbHhf+BSqCyEcSzNLG09alINutQhD5JTv5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715539044; x=1716143844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvDALX2Uri5RTgIn6pzRLr5p/TpABW6ze+cHJXhnhz0=;
        b=Zz4FseiHsd9dUPnVffrixe2LknUiLn/tib6YExSYnVDjX8WOseW4a05n7OP+0ItmQE
         HQ2DjEcqusHYnZQ156ZljGHQ2psjwCDoZv4a8fJcBi9XGDrR1ktOYeCEgd1CCaeSlz0q
         JWfJzRHeHX/neDetEFRC9IkMZSzLYU8pz8BliCg4yClz6qa0nQbWEOYWrb9eyBb9RsDv
         JYAs23SnFFtZqSNRxnYit3+GtH/jp8DXfD3ExdX0V5YkxNMqure/SYwKBbj89sV9Lzwc
         Bid/vPG22IiXFn23DCOPiloVtie0uFeJzlbLferijWAO8b6phZIxowdayxX1jBTn3gec
         S2CQ==
X-Gm-Message-State: AOJu0Yz+H2w0PDA+7BpDBOfYDrkMtkapcySz/0iltuj3j3AKOiDXsYw5
	KRg3Xgoc8OVUqUcndWQE24E7SUdCnHBKOKYGF2jxBBvV69JTutohMgMb+ti9Rns=
X-Google-Smtp-Source: AGHT+IFkxbq3Rkzvs5WbT/T22/l24x4EHoOEeAsDjLGj1lSmdme4hW/JDJacIPGNIS8Nz9h/fW+3zQ==
X-Received: by 2002:a17:903:2442:b0:1e4:17e4:3a1f with SMTP id d9443c01a7336-1ef43d2e2b7mr105905115ad.4.1715539043815;
        Sun, 12 May 2024 11:37:23 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d1a57sm64970295ad.11.2024.05.12.11.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 11:37:23 -0700 (PDT)
Date: Sun, 12 May 2024 11:37:20 -0700
From: Joe Damato <jdamato@fastly.com>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, nalramli@fastly.com,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:MELLANOX MLX4 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next v4 1/3] net/mlx4: Track RX allocation failures
 in a stat
Message-ID: <ZkEMYDP586iKp1vT@LQ3V64L9R2>
References: <20240509205057.246191-1-jdamato@fastly.com>
 <20240509205057.246191-2-jdamato@fastly.com>
 <a4efd162-5dc0-4ed1-b875-de12521a6618@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4efd162-5dc0-4ed1-b875-de12521a6618@gmail.com>

On Sun, May 12, 2024 at 11:17:09AM +0300, Tariq Toukan wrote:
> 
> 
> On 09/05/2024 23:50, Joe Damato wrote:
> > mlx4_en_alloc_frags currently returns -ENOMEM when mlx4_alloc_page
> > fails but does not increment a stat field when this occurs.
> > 
> > A new field called alloc_fail has been added to struct mlx4_en_rx_ring
> > which is now incremented in mlx4_en_rx_ring when -ENOMEM occurs.
> > 
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
> > ---
> >   drivers/net/ethernet/mellanox/mlx4/en_rx.c   | 4 +++-
> >   drivers/net/ethernet/mellanox/mlx4/mlx4_en.h | 1 +
> >   2 files changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> > index 8328df8645d5..15c57e9517e9 100644
> > --- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> > +++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> > @@ -82,8 +82,10 @@ static int mlx4_en_alloc_frags(struct mlx4_en_priv *priv,
> >   	for (i = 0; i < priv->num_frags; i++, frags++) {
> >   		if (!frags->page) {
> > -			if (mlx4_alloc_page(priv, frags, gfp))
> > +			if (mlx4_alloc_page(priv, frags, gfp)) {
> > +				ring->alloc_fail++;
> >   				return -ENOMEM;
> > +			}
> >   			ring->rx_alloc_pages++;
> >   		}
> >   		rx_desc->data[i].addr = cpu_to_be64(frags->dma +
> > diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
> > index efe3f97b874f..cd70df22724b 100644
> > --- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
> > +++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
> > @@ -355,6 +355,7 @@ struct mlx4_en_rx_ring {
> >   	unsigned long xdp_tx;
> >   	unsigned long xdp_tx_full;
> >   	unsigned long dropped;
> > +	unsigned long alloc_fail;
> >   	int hwtstamp_rx_filter;
> >   	cpumask_var_t affinity_mask;
> >   	struct xdp_rxq_info xdp_rxq;
> 
> Counter should be reset in mlx4_en_clear_stats().

OK, thanks. I'll add that to the v5, alongside any other feedback that
comes in within the next ~24 hours or so.

> BTW, there are existing counters that are missing there already.
> We should add them as well, not related to your series though...

Yea, I see what you mean about the other counters. I think those can
potentially be sent as a 'Fixes' later?

