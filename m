Return-Path: <linux-kernel+bounces-535059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57668A46E49
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D1C1889071
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6190926BD8D;
	Wed, 26 Feb 2025 22:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GMaF4N7v"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5560626F46E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 22:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740608006; cv=none; b=D8704YyBVeLr6SbvG8QiWLgOVMoRn9nDY54wVc+pskx07qj4RGcvpvLq+Ac60D+OoXbUp69FTPwnEmJvGQSudb8Q/SFDFT3p5DOOpk1ibFMkEA4Pa/9gkgBkH0j7T+XKJS654DlSdeJgOqvL1QxfYpb7Xwvw31y2XJw4Y8pp3OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740608006; c=relaxed/simple;
	bh=+AGXsd3l0/ZAahpV30MW18ZWS7qqDgJIIVxUnI5sp+M=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kr7h3IgsbuAI3+nbEY/6bpn625bvxJ7AnahHvvgPbZWGom8holLGjXnhGFw2roeKsh4CYtBNSd/Svh8NCCILSagzMxlTO797vGpfRAaGt8T8urMjJkUuVwqCVnW2cL4IDzhiey3Wfiob7AEdnCs3VGkGBfXaSCgSFuGqv0OBL8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GMaF4N7v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740608003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xoC6B7ot7I9gFHLsIIDATRwO00Yvhc2uVgVPoqjJGYQ=;
	b=GMaF4N7vZfTUIQbKjNutN13Zj9lRI0CUKGUmiSGfBfR6IQcc+qcb4DWOPY0gXR9HhvaA7o
	5lUtqGN3qVW0CoO+J8A/LCn8+wyS81B9NhFpofG9AgWEFCIqAZWEOyl1anaYY54KwZ+X+R
	fvJRHQDdHzjPOLXpI35TlQorlzYp/7Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-8woCtiPVNPW9N9HDdE8HEw-1; Wed, 26 Feb 2025 17:13:21 -0500
X-MC-Unique: 8woCtiPVNPW9N9HDdE8HEw-1
X-Mimecast-MFC-AGG-ID: 8woCtiPVNPW9N9HDdE8HEw_1740608000
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f3bac2944so71727f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:13:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740608000; x=1741212800;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xoC6B7ot7I9gFHLsIIDATRwO00Yvhc2uVgVPoqjJGYQ=;
        b=aJBQHHKlyzQ1xMhU7DZ63S0uh/2dWjs+qVnkqtUAmvyGG2HCSJ24d3kHUTwqi/kQdq
         HTQOF1Ny/i9tOKjGtRzpQgLsNWOip1z2ZBWcJJu30LofeqYuqCxRr0xmGskqUlYcz2hK
         D5l+T5vs9r6wYZBBUeqYK/6oBDRL+UrgeYFEbwj1owFO7/npiyve/kEmf+VLaU+ORgvy
         nO4T1mUeZQ32jvA7Zi3c5HqUGvNn8O9MH1fVuSwSS1+a1LZgFK7m5SoSP/42ltxIxK78
         fYOV0lcruo88Ezew8X1niU1SE2VZRiavv2kdcc/3qgrfcA2G+sl20NkNKi+i9rGzsPKF
         wndQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdFo/TafNnSch4DxDV1uEI53zIwD2rhmn0Dz9RwQkkFEKfnTkDjNDJcWGPpvMuOXTEZmUXKOoO//TAlT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNtVEPZ0h98FYMe2TeTNeqXtZuEgOEhIKCB0NQirn5TlPKzbSZ
	eSWyR8sHABMubyLEL3HOU20JclOn6FMV9OmuRl1ehBQ3LUF7pT0PCnWq4boEqleR+Jzt2KchuV/
	h4PdFaYUEz9lbZuxCQvuhFszqnzsb1/dDKr6NCB/WTOKy1+RGRfS9Apm4WqgQFA==
X-Gm-Gg: ASbGncvJp/3r0odCWrLRs/kR8drNeLbgh6dYzSX3hDJUSacRG5FbY1plHqk4lym5jda
	pU4HkHqanPRxYW5eL/Hw8QZzcMhuIJ5251fp2hMLbYUjEpGAd5JSvITft+jgbsBt+7rTP8Hd3iK
	GjShEIq43eGYT1faoEnbbUwB2WGnHv1qUfyU2LTP8UJJv1U4KglzEcO718ly0rma6NJXa23rE1h
	cOEzq/R16E3BaBqTdp/8eQTsG+/HM/Kp9fjEBSVxjwCtAQLkBTRD3xmGWy/PY8ml0EoL50wMZ5C
	CETeIgsOZw==
X-Received: by 2002:a05:6000:1f88:b0:38f:286c:9acc with SMTP id ffacd0b85a97d-390d4f429dfmr3953213f8f.32.1740608000163;
        Wed, 26 Feb 2025 14:13:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6UZscpycCohbgKUm67MTCc3ms1w0NUKbtY3TjrWejb4s65WjUp3KhFLNFf62YjJo396h7PQ==
X-Received: by 2002:a05:6000:1f88:b0:38f:286c:9acc with SMTP id ffacd0b85a97d-390d4f429dfmr3953196f8f.32.1740607999757;
        Wed, 26 Feb 2025 14:13:19 -0800 (PST)
Received: from redhat.com ([2a02:14f:1eb:e270:8595:184c:7546:3597])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7a28bd85sm2488945e9.36.2025.02.26.14.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 14:13:18 -0800 (PST)
Date: Wed, 26 Feb 2025 17:13:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Joe Damato <jdamato@fastly.com>, Jason Wang <jasowang@redhat.com>,
	netdev@vger.kernel.org, mkarsten@uwaterloo.ca,
	gerhard@engleder-embedded.com, xuanzhuo@linux.alibaba.com,
	kuba@kernel.org,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 3/4] virtio-net: Map NAPIs to queues
Message-ID: <20250226171252-mutt-send-email-mst@kernel.org>
References: <20250225020455.212895-1-jdamato@fastly.com>
 <20250225020455.212895-4-jdamato@fastly.com>
 <CACGkMEv6y+TkZnWWLPG4UE59iyREhkiaby8kj==cnp=6chmu+w@mail.gmail.com>
 <Z79XXQjp9Dz7OYYQ@LQ3V64L9R2>
 <Z79YseiGrzYxoyvr@LQ3V64L9R2>
 <Z795Pt_RnfnvC-1N@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z795Pt_RnfnvC-1N@LQ3V64L9R2>

On Wed, Feb 26, 2025 at 03:27:42PM -0500, Joe Damato wrote:
> On Wed, Feb 26, 2025 at 01:08:49PM -0500, Joe Damato wrote:
> > On Wed, Feb 26, 2025 at 01:03:09PM -0500, Joe Damato wrote:
> > > On Wed, Feb 26, 2025 at 01:48:50PM +0800, Jason Wang wrote:
> > > > On Tue, Feb 25, 2025 at 10:05 AM Joe Damato <jdamato@fastly.com> wrote:
> > > > >
> > > > > Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
> > > > > can be accessed by user apps, taking care to hold RTNL as needed.
> > > > 
> > > > I may miss something but I wonder whether letting the caller hold the
> > > > lock is better.
> > > 
> > > Hmm...
> > > 
> > > Double checking all the paths over again, here's what I see:
> > >   - refill_work, delayed work that needs RTNL so this change seems
> > >     right?
> > > 
> > >   - virtnet_disable_queue_pair, called from virtnet_open and
> > >     virtnet_close. When called via NDO these are safe and hold RTNL,
> > >     but they can be called from power management and need RTNL.
> > > 
> > >   - virtnet_enable_queue_pair called from virtnet_open, safe when
> > >     used via NDO but needs RTNL when used via power management.
> > > 
> > >   - virtnet_rx_pause called in both paths as you mentioned, one
> > >     which needs RTNL and one which doesn't.
> > 
> > Sorry, I missed more paths:
> > 
> >     - virtnet_rx_resume
> >     - virtnet_tx_pause and virtnet_tx_resume
> > 
> > which are similar to path you mentioned (virtnet_rx_pause) and need
> > rtnl in one of two different paths.
> > 
> > Let me know if I missed any paths and what your preferred way to fix
> > this would be?
> > 
> > I think both options below are possible and I have no strong
> > preference.
> 
> OK, my apologies. I read your message and the code wrong. Sorry for
> the back-to-back emails from me.
> 
> Please ignore my message above... I think after re-reading the code,
> here's where I've arrived:
> 
>   - refill_work needs to hold RTNL (as in the existing patch)
> 
>   - virtnet_rx_pause, virtnet_rx_resume, virtnet_tx_pause,
>     virtnet_tx_resume -- all do NOT need to hold RTNL because it is
>     already held in the ethtool resize path and the XSK path, as you
>     explained, but I mis-read (sorry).
> 
>   - virtnet_disable_queue_pair and virtnet_enable_queue_pair both
>     need to hold RTNL only when called via power management, but not
>     when called via ndo_open or ndo_close
> 
> Is my understanding correct and does it match your understanding?
> 
> If so, that means there are two issues:
> 
>   1. Fixing the hardcoded bools in rx_pause, rx_resume, tx_pause,
>      tx_resume (all should be false, RTNL is not needed).
> 
>   2. Handling the power management case which calls virtnet_open and
>      virtnet_close.
> 
> I made a small diff included below as an example of a possible
> solution:
> 
>   1. Modify virtnet_disable_queue_pair and virtnet_enable_queue_pair
>      to take a "bool need_rtnl" and pass it through to the helpers
>      they call.
> 
>   2. Create two helpers, virtnet_do_open and virt_do_close both of
>      which take struct net_device *dev, bool need_rtnl. virtnet_open
>      and virtnet_close are modified to call the helpers and pass
>      false for need_rtnl. The power management paths call the
>      helpers and pass true for need_rtnl. (fixes issue 2 above)
> 
>   3. Fix the bools for rx_pause, rx_resume, tx_pause, tx_resume to
>      pass false since all paths that I could find that lead to these
>      functions hold RTNL. (fixes issue 1 above)
> 
> See the diff below (which can be applied on top of patch 3) to see
> what it looks like.
> 
> If you are OK with this approach, I will send a v5 where patch 3
> includes the changes shown in this diff.
> 
> Please let me know what you think:



Looks ok I think.

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 13bb4a563073..76ecb8f3ce9a 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3098,14 +3098,16 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>  	return received;
>  }
>  
> -static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
> +static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index,
> +				       bool need_rtnl)
>  {
> -	virtnet_napi_tx_disable(&vi->sq[qp_index], false);
> -	virtnet_napi_disable(&vi->rq[qp_index], false);
> +	virtnet_napi_tx_disable(&vi->sq[qp_index], need_rtnl);
> +	virtnet_napi_disable(&vi->rq[qp_index], need_rtnl);
>  	xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
>  }
>  
> -static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
> +static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index,
> +				     bool need_rtnl)
>  {
>  	struct net_device *dev = vi->dev;
>  	int err;
> @@ -3120,8 +3122,8 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
>  	if (err < 0)
>  		goto err_xdp_reg_mem_model;
>  
> -	virtnet_napi_enable(&vi->rq[qp_index], false);
> -	virtnet_napi_tx_enable(&vi->sq[qp_index], false);
> +	virtnet_napi_enable(&vi->rq[qp_index], need_rtnl);
> +	virtnet_napi_tx_enable(&vi->sq[qp_index], need_rtnl);
>  
>  	return 0;
>  
> @@ -3156,7 +3158,7 @@ static void virtnet_update_settings(struct virtnet_info *vi)
>  		vi->duplex = duplex;
>  }
>  
> -static int virtnet_open(struct net_device *dev)
> +static int virtnet_do_open(struct net_device *dev, bool need_rtnl)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
>  	int i, err;
> @@ -3169,7 +3171,7 @@ static int virtnet_open(struct net_device *dev)
>  			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
>  				schedule_delayed_work(&vi->refill, 0);
>  
> -		err = virtnet_enable_queue_pair(vi, i);
> +		err = virtnet_enable_queue_pair(vi, i, need_rtnl);
>  		if (err < 0)
>  			goto err_enable_qp;
>  	}
> @@ -3190,13 +3192,18 @@ static int virtnet_open(struct net_device *dev)
>  	cancel_delayed_work_sync(&vi->refill);
>  
>  	for (i--; i >= 0; i--) {
> -		virtnet_disable_queue_pair(vi, i);
> +		virtnet_disable_queue_pair(vi, i, need_rtnl);
>  		virtnet_cancel_dim(vi, &vi->rq[i].dim);
>  	}
>  
>  	return err;
>  }
>  
> +static int virtnet_open(struct net_device *dev)
> +{
> +	return virtnet_do_open(dev, false);
> +}
> +
>  static int virtnet_poll_tx(struct napi_struct *napi, int budget)
>  {
>  	struct send_queue *sq = container_of(napi, struct send_queue, napi);
> @@ -3373,7 +3380,7 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
>  	bool running = netif_running(vi->dev);
>  
>  	if (running) {
> -		virtnet_napi_disable(rq, true);
> +		virtnet_napi_disable(rq, false);
>  		virtnet_cancel_dim(vi, &rq->dim);
>  	}
>  }
> @@ -3386,7 +3393,7 @@ static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
>  		schedule_delayed_work(&vi->refill, 0);
>  
>  	if (running)
> -		virtnet_napi_enable(rq, true);
> +		virtnet_napi_enable(rq, false);
>  }
>  
>  static int virtnet_rx_resize(struct virtnet_info *vi,
> @@ -3415,7 +3422,7 @@ static void virtnet_tx_pause(struct virtnet_info *vi, struct send_queue *sq)
>  	qindex = sq - vi->sq;
>  
>  	if (running)
> -		virtnet_napi_tx_disable(sq, true);
> +		virtnet_napi_tx_disable(sq, false);
>  
>  	txq = netdev_get_tx_queue(vi->dev, qindex);
>  
> @@ -3449,7 +3456,7 @@ static void virtnet_tx_resume(struct virtnet_info *vi, struct send_queue *sq)
>  	__netif_tx_unlock_bh(txq);
>  
>  	if (running)
> -		virtnet_napi_tx_enable(sq, true);
> +		virtnet_napi_tx_enable(sq, false);
>  }
>  
>  static int virtnet_tx_resize(struct virtnet_info *vi, struct send_queue *sq,
> @@ -3708,7 +3715,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>  	return 0;
>  }
>  
> -static int virtnet_close(struct net_device *dev)
> +static int virtnet_do_close(struct net_device *dev, bool need_rtnl)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
>  	int i;
> @@ -3727,7 +3734,7 @@ static int virtnet_close(struct net_device *dev)
>  	cancel_work_sync(&vi->config_work);
>  
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
> -		virtnet_disable_queue_pair(vi, i);
> +		virtnet_disable_queue_pair(vi, i, need_rtnl);
>  		virtnet_cancel_dim(vi, &vi->rq[i].dim);
>  	}
>  
> @@ -3736,6 +3743,11 @@ static int virtnet_close(struct net_device *dev)
>  	return 0;
>  }
>  
> +static int virtnet_close(struct net_device *dev)
> +{
> +	return virtnet_do_close(dev, false);
> +}
> +
>  static void virtnet_rx_mode_work(struct work_struct *work)
>  {
>  	struct virtnet_info *vi =
> @@ -5682,7 +5694,7 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
>  	netif_device_detach(vi->dev);
>  	netif_tx_unlock_bh(vi->dev);
>  	if (netif_running(vi->dev))
> -		virtnet_close(vi->dev);
> +		virtnet_do_close(vi->dev, true);
>  }
>  
>  static int init_vqs(struct virtnet_info *vi);
> @@ -5702,7 +5714,7 @@ static int virtnet_restore_up(struct virtio_device *vdev)
>  	enable_rx_mode_work(vi);
>  
>  	if (netif_running(vi->dev)) {
> -		err = virtnet_open(vi->dev);
> +		err = virtnet_do_open(vi->dev, false);
>  		if (err)
>  			return err;
>  	}


