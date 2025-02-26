Return-Path: <linux-kernel+bounces-534899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9231A46C68
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7516188D68F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AA42222D1;
	Wed, 26 Feb 2025 20:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="MrWdNX+c"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E7B14EC62
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740601670; cv=none; b=hyls8TKu87+wZcHIyqyDk4cKzmAS9fXuYBApcv3us6olZldEDGFfoAkvhXgz2kJ2aqwKA+ABW8vcmFz4XqIIdxUt++jHJtVQ9DRWev0sb0+QFKp5jieLnbP+4kqLXKjIH8WVFSjIO6kP5dsmHFPXDE0ybjvYuHTJfzuZLtWgcZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740601670; c=relaxed/simple;
	bh=k+QDB4VYH0R9a9+nYzNmvEIhcYQPChkqjyD9WG2Hmh4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AV5ZafogjQhniKmwHl7M5uFpXreewU++BwXByYy4JcEcrcHPZ3+KYryzEPEQ8mcURuNQCH6NeZhRjx2MDf3xgQIQZp3M9tYqQVApyZgYYkz/p15rwdOcnVQNmGlyTj5IZ8RVqrrcGokHgxgvwv7OU74572JVTHbg5EqhUWkm/58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=MrWdNX+c; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c0818add57so17701185a.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740601666; x=1741206466; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ySARA6axU/KgaQ0dVNI+ZmJXsucfopJX3wr+2O18FBA=;
        b=MrWdNX+cw7UFZmA2YF8kovMhfBr4sxn+gVbUVUxS1CskzY2DR0/IcFHQxXtnHTdFZZ
         ubfidBHMMDrgNgGLXbhhSvKaHdwLxKLAY3MV5TEolhGFHAU1BSLTnMF/sicX8uDc+ehw
         ysG5km+mjtLYIpESxnYaB939bh2ninAOSm5J0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740601666; x=1741206466;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ySARA6axU/KgaQ0dVNI+ZmJXsucfopJX3wr+2O18FBA=;
        b=BJnF52OaMUfRi4d290IoPU8r+ZrH8geVYpTdbREevoSHIOi+AjdsEfNB3vHjkaaT0Z
         2H8UUvG2S5MhFFCQG1RLaCwGFr4oBuupD6WEWUhWddjaM0GB/CIQlS3KkH9MwHSjitFD
         FHXvFadwwt0XkTPkjRWW9UPxQE7YgVSGT25m59vWvuMbg1pFA6NT4yqrJAEYLc9mfF6S
         yQYLlGXBeGZKM3vs5+h1kPa65Jd7VaHG67WSCOHM18Mq6KuvK/JLRb0vZyX5bbxyJjA2
         ey53hVjBkvmPycLMI6QEUAW4NC2aKLaCqMsMwf116jXhctQlmx4DbpnJj+5nLXeEwuNW
         dawg==
X-Forwarded-Encrypted: i=1; AJvYcCXFwX6zfANkO/dCVOxWAAmjHS+Y26qga6h1hrLJVPPNO5aCbAccNnHUUCnNXq2g4U5Gl9KGoaRH13iWW4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0sL4xYkWxnlpmvAn4e4mzrcKz0uAtVj6d+E65g9FW50Z4G/+6
	B7kR5wyLIuOLVCo+cbahdpAc/VMO7XZTZ1gZAy4AdLBQoq82CcbCK3qXERskMWM=
X-Gm-Gg: ASbGncuEycm0FXelS/2ayA4NfeRKjqMLgGOtUQWO2K5Mk+jdKY0AtgYXRHwwsNv0cDf
	m5jSpG44/6roSbb1mUqSvlswRlk7KBXweG5avoBbCkUE2CrvgpYPMG0agHeRZROckuVZ5XmmmPb
	LioUbCcOYGrSDsbJ7XHAu3peKbcCS+6jtrFNHuXDf8ZbXZdAoHRTfKtsAYCJjMAhlirc4A/I7Fi
	U8BmEHSE6714Bk5chi4PNVgMAxCRvRlWORR6cESE71qNCPT/Qse6d8KPesa2JEbxeG2InfBg1jg
	lndnjDb5bbTxNTozVL/p0tSgJEXOG+BAWNuTCXC8/zcF2m7bhVpU6Mp2YhLNP8Fa
X-Google-Smtp-Source: AGHT+IEv7viTJhM0Js6vvlYUnBH9P9HF8SbdCpdZLNRgMY6wPWIHhpmuyL0yIEE3uUMtvehXKZHFUA==
X-Received: by 2002:a05:620a:4415:b0:7c0:c0e0:8beb with SMTP id af79cd13be357-7c0cf96e406mr2798739585a.57.1740601665863;
        Wed, 26 Feb 2025 12:27:45 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c23c33f3ddsm292586885a.93.2025.02.26.12.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 12:27:45 -0800 (PST)
Date: Wed, 26 Feb 2025 15:27:42 -0500
From: Joe Damato <jdamato@fastly.com>
To: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, gerhard@engleder-embedded.com,
	xuanzhuo@linux.alibaba.com, kuba@kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 3/4] virtio-net: Map NAPIs to queues
Message-ID: <Z795Pt_RnfnvC-1N@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, gerhard@engleder-embedded.com,
	xuanzhuo@linux.alibaba.com, kuba@kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
References: <20250225020455.212895-1-jdamato@fastly.com>
 <20250225020455.212895-4-jdamato@fastly.com>
 <CACGkMEv6y+TkZnWWLPG4UE59iyREhkiaby8kj==cnp=6chmu+w@mail.gmail.com>
 <Z79XXQjp9Dz7OYYQ@LQ3V64L9R2>
 <Z79YseiGrzYxoyvr@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z79YseiGrzYxoyvr@LQ3V64L9R2>

On Wed, Feb 26, 2025 at 01:08:49PM -0500, Joe Damato wrote:
> On Wed, Feb 26, 2025 at 01:03:09PM -0500, Joe Damato wrote:
> > On Wed, Feb 26, 2025 at 01:48:50PM +0800, Jason Wang wrote:
> > > On Tue, Feb 25, 2025 at 10:05 AM Joe Damato <jdamato@fastly.com> wrote:
> > > >
> > > > Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
> > > > can be accessed by user apps, taking care to hold RTNL as needed.
> > > 
> > > I may miss something but I wonder whether letting the caller hold the
> > > lock is better.
> > 
> > Hmm...
> > 
> > Double checking all the paths over again, here's what I see:
> >   - refill_work, delayed work that needs RTNL so this change seems
> >     right?
> > 
> >   - virtnet_disable_queue_pair, called from virtnet_open and
> >     virtnet_close. When called via NDO these are safe and hold RTNL,
> >     but they can be called from power management and need RTNL.
> > 
> >   - virtnet_enable_queue_pair called from virtnet_open, safe when
> >     used via NDO but needs RTNL when used via power management.
> > 
> >   - virtnet_rx_pause called in both paths as you mentioned, one
> >     which needs RTNL and one which doesn't.
> 
> Sorry, I missed more paths:
> 
>     - virtnet_rx_resume
>     - virtnet_tx_pause and virtnet_tx_resume
> 
> which are similar to path you mentioned (virtnet_rx_pause) and need
> rtnl in one of two different paths.
> 
> Let me know if I missed any paths and what your preferred way to fix
> this would be?
> 
> I think both options below are possible and I have no strong
> preference.

OK, my apologies. I read your message and the code wrong. Sorry for
the back-to-back emails from me.

Please ignore my message above... I think after re-reading the code,
here's where I've arrived:

  - refill_work needs to hold RTNL (as in the existing patch)

  - virtnet_rx_pause, virtnet_rx_resume, virtnet_tx_pause,
    virtnet_tx_resume -- all do NOT need to hold RTNL because it is
    already held in the ethtool resize path and the XSK path, as you
    explained, but I mis-read (sorry).

  - virtnet_disable_queue_pair and virtnet_enable_queue_pair both
    need to hold RTNL only when called via power management, but not
    when called via ndo_open or ndo_close

Is my understanding correct and does it match your understanding?

If so, that means there are two issues:

  1. Fixing the hardcoded bools in rx_pause, rx_resume, tx_pause,
     tx_resume (all should be false, RTNL is not needed).

  2. Handling the power management case which calls virtnet_open and
     virtnet_close.

I made a small diff included below as an example of a possible
solution:

  1. Modify virtnet_disable_queue_pair and virtnet_enable_queue_pair
     to take a "bool need_rtnl" and pass it through to the helpers
     they call.

  2. Create two helpers, virtnet_do_open and virt_do_close both of
     which take struct net_device *dev, bool need_rtnl. virtnet_open
     and virtnet_close are modified to call the helpers and pass
     false for need_rtnl. The power management paths call the
     helpers and pass true for need_rtnl. (fixes issue 2 above)

  3. Fix the bools for rx_pause, rx_resume, tx_pause, tx_resume to
     pass false since all paths that I could find that lead to these
     functions hold RTNL. (fixes issue 1 above)

See the diff below (which can be applied on top of patch 3) to see
what it looks like.

If you are OK with this approach, I will send a v5 where patch 3
includes the changes shown in this diff.

Please let me know what you think:

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 13bb4a563073..76ecb8f3ce9a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3098,14 +3098,16 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 	return received;
 }
 
-static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
+static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index,
+				       bool need_rtnl)
 {
-	virtnet_napi_tx_disable(&vi->sq[qp_index], false);
-	virtnet_napi_disable(&vi->rq[qp_index], false);
+	virtnet_napi_tx_disable(&vi->sq[qp_index], need_rtnl);
+	virtnet_napi_disable(&vi->rq[qp_index], need_rtnl);
 	xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
 }
 
-static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
+static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index,
+				     bool need_rtnl)
 {
 	struct net_device *dev = vi->dev;
 	int err;
@@ -3120,8 +3122,8 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
 	if (err < 0)
 		goto err_xdp_reg_mem_model;
 
-	virtnet_napi_enable(&vi->rq[qp_index], false);
-	virtnet_napi_tx_enable(&vi->sq[qp_index], false);
+	virtnet_napi_enable(&vi->rq[qp_index], need_rtnl);
+	virtnet_napi_tx_enable(&vi->sq[qp_index], need_rtnl);
 
 	return 0;
 
@@ -3156,7 +3158,7 @@ static void virtnet_update_settings(struct virtnet_info *vi)
 		vi->duplex = duplex;
 }
 
-static int virtnet_open(struct net_device *dev)
+static int virtnet_do_open(struct net_device *dev, bool need_rtnl)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
 	int i, err;
@@ -3169,7 +3171,7 @@ static int virtnet_open(struct net_device *dev)
 			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
 				schedule_delayed_work(&vi->refill, 0);
 
-		err = virtnet_enable_queue_pair(vi, i);
+		err = virtnet_enable_queue_pair(vi, i, need_rtnl);
 		if (err < 0)
 			goto err_enable_qp;
 	}
@@ -3190,13 +3192,18 @@ static int virtnet_open(struct net_device *dev)
 	cancel_delayed_work_sync(&vi->refill);
 
 	for (i--; i >= 0; i--) {
-		virtnet_disable_queue_pair(vi, i);
+		virtnet_disable_queue_pair(vi, i, need_rtnl);
 		virtnet_cancel_dim(vi, &vi->rq[i].dim);
 	}
 
 	return err;
 }
 
+static int virtnet_open(struct net_device *dev)
+{
+	return virtnet_do_open(dev, false);
+}
+
 static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 {
 	struct send_queue *sq = container_of(napi, struct send_queue, napi);
@@ -3373,7 +3380,7 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
 	bool running = netif_running(vi->dev);
 
 	if (running) {
-		virtnet_napi_disable(rq, true);
+		virtnet_napi_disable(rq, false);
 		virtnet_cancel_dim(vi, &rq->dim);
 	}
 }
@@ -3386,7 +3393,7 @@ static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
 		schedule_delayed_work(&vi->refill, 0);
 
 	if (running)
-		virtnet_napi_enable(rq, true);
+		virtnet_napi_enable(rq, false);
 }
 
 static int virtnet_rx_resize(struct virtnet_info *vi,
@@ -3415,7 +3422,7 @@ static void virtnet_tx_pause(struct virtnet_info *vi, struct send_queue *sq)
 	qindex = sq - vi->sq;
 
 	if (running)
-		virtnet_napi_tx_disable(sq, true);
+		virtnet_napi_tx_disable(sq, false);
 
 	txq = netdev_get_tx_queue(vi->dev, qindex);
 
@@ -3449,7 +3456,7 @@ static void virtnet_tx_resume(struct virtnet_info *vi, struct send_queue *sq)
 	__netif_tx_unlock_bh(txq);
 
 	if (running)
-		virtnet_napi_tx_enable(sq, true);
+		virtnet_napi_tx_enable(sq, false);
 }
 
 static int virtnet_tx_resize(struct virtnet_info *vi, struct send_queue *sq,
@@ -3708,7 +3715,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 	return 0;
 }
 
-static int virtnet_close(struct net_device *dev)
+static int virtnet_do_close(struct net_device *dev, bool need_rtnl)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
 	int i;
@@ -3727,7 +3734,7 @@ static int virtnet_close(struct net_device *dev)
 	cancel_work_sync(&vi->config_work);
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
-		virtnet_disable_queue_pair(vi, i);
+		virtnet_disable_queue_pair(vi, i, need_rtnl);
 		virtnet_cancel_dim(vi, &vi->rq[i].dim);
 	}
 
@@ -3736,6 +3743,11 @@ static int virtnet_close(struct net_device *dev)
 	return 0;
 }
 
+static int virtnet_close(struct net_device *dev)
+{
+	return virtnet_do_close(dev, false);
+}
+
 static void virtnet_rx_mode_work(struct work_struct *work)
 {
 	struct virtnet_info *vi =
@@ -5682,7 +5694,7 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
 	netif_device_detach(vi->dev);
 	netif_tx_unlock_bh(vi->dev);
 	if (netif_running(vi->dev))
-		virtnet_close(vi->dev);
+		virtnet_do_close(vi->dev, true);
 }
 
 static int init_vqs(struct virtnet_info *vi);
@@ -5702,7 +5714,7 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 	enable_rx_mode_work(vi);
 
 	if (netif_running(vi->dev)) {
-		err = virtnet_open(vi->dev);
+		err = virtnet_do_open(vi->dev, false);
 		if (err)
 			return err;
 	}

