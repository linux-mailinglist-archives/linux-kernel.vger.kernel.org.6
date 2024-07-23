Return-Path: <linux-kernel+bounces-259927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F29BC939FF4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F931282E81
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498B5152166;
	Tue, 23 Jul 2024 11:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XaJqXoHb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D851514C0
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 11:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721734160; cv=none; b=tR4akV85/Nl0hTHvapl9mwdM43sI/Hi1W5wAEDnukuoRuilG9wmM/1YNzUm6PBm1HRfoYgdoXP+YpVVwODw7vIKqG9nf/tOt247zgEeBpmFYseeJyMqcVL99rcmclCaMZ7iqSC4fyMmy6AodGcCdCPXX/GSscn8uiROcaG4ANdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721734160; c=relaxed/simple;
	bh=ywiEz9lNEQ9WmelnvEr3eWbFdDAiCBnoLZvMkLA1J4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUDLcfX+zJCkhMzgdXQJsN7007qAGx+x3Wl6uSzvhAJouyns73aAa1mvSc70keX57b3xrp/IUijRnqyl4SnUuEfilPMT2M8rhnYWswqB1rqhYU/10mjSMEAofW1oLzNXRKi4LGUruQ3olatgJDWTfkbbuYKnrOMY9rRCLbuROn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XaJqXoHb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721734158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s7jCTUnDItxD8cjWWIIoCSjBuZfVeWntboTVzts3D7o=;
	b=XaJqXoHbPkrTBwYkEoMI0DP4JRrZj0OfypKTkORfsUw7xm5zComkMXDRSqzCzBeEuAFrR7
	lxUQ9tSlizR6kb7qkKE3Jf3p2B00Bc9LmLNDxKf01Q8nrVqUZ/7K72RQVEku2ZxjQqWF5b
	5UM2jsoHAgjzBVFLHRrw1U+BAyhFF1Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-N4livhYuOZWluWXTIePcrQ-1; Tue, 23 Jul 2024 07:29:16 -0400
X-MC-Unique: N4livhYuOZWluWXTIePcrQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4265d3bf59dso38713715e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 04:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721734155; x=1722338955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7jCTUnDItxD8cjWWIIoCSjBuZfVeWntboTVzts3D7o=;
        b=Up+2oXxOkVRAoWz4K5jT3kJhKSR/KlkWrfZ0+xxbN6FJ6ZtQ9YhjzINi4NH/kovBtt
         qfNSXLc8zegA4Wfbvw8VSW4A28Sassq1F1s3u+7vGe2zF/6ckgXneHZu2uB/gHo3zGeV
         rGCe6Iv3qB0VDSV18Rn0RjlqYewRZ5Q59ScKjUkCEHyyjzxSUMeo4npLDY49YkwLbsXD
         bW/b7VKyxTrSuIdGjmbRpnJ+qzSTdGT1jeMwWq+x3pcG3rGrslrE6XIfrWS7sPpJeFjt
         JjSG1WURih7HxbypfB/nicjIFAywK4Yhky1qQqqGJ2nEgdy15bSIeUYPSkaFlSW7Tz0P
         3EqA==
X-Forwarded-Encrypted: i=1; AJvYcCWZNJ+2K5sINWgED/ZzTnpVYtHi7LvRjJkJIhihLaPXFgDOtK0sINJMSJLFk7aOwOeZ78W0ai9nk0sNg1JVPKkikMqv1CUdWgJanfLb
X-Gm-Message-State: AOJu0YwAF0ORNSDrxf0Z9SadqikcXszyLgmgAP9WpTT1tEgNF+1BEE9Y
	Hf57YrXfz9rFpAZI+CWeRY7x2DM8EQqNjvB6WGVaPBFHWUzo8nNk54MfVDy4k2qJbLR/x06HqAs
	158yIr6YkgWKASv9FIiSKJvgGlEYGPq9P+ak9/wMz30OD0jobQbqUfDQ3hnzyH4dOS7BTng==
X-Received: by 2002:a05:600c:198a:b0:426:5ef5:bcb1 with SMTP id 5b1f17b1804b1-427dc516030mr62453915e9.6.1721734155397;
        Tue, 23 Jul 2024 04:29:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy8f4+JM8Dv9qpEpAG+F85IIgy6v0jInHBiNNS5aGKN9kSnvuaOCv+YAidUy3L2q08C0jGsg==
X-Received: by 2002:a05:600c:198a:b0:426:5ef5:bcb1 with SMTP id 5b1f17b1804b1-427dc516030mr62453655e9.6.1721734154739;
        Tue, 23 Jul 2024 04:29:14 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a95530sm187309455e9.45.2024.07.23.04.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 04:29:14 -0700 (PDT)
Date: Tue, 23 Jul 2024 07:29:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lulu@redhat.com" <lulu@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>
Subject: Re: [PATH v5 3/3] vdpa/mlx5: Add the support of set mac address
Message-ID: <20240723072712-mutt-send-email-mst@kernel.org>
References: <20240723054047.1059994-1-lulu@redhat.com>
 <20240723054047.1059994-4-lulu@redhat.com>
 <d8031e518cf47c57c31b903cb9613692bbff7d0d.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8031e518cf47c57c31b903cb9613692bbff7d0d.camel@nvidia.com>

On Tue, Jul 23, 2024 at 07:49:44AM +0000, Dragos Tatulea wrote:
> On Tue, 2024-07-23 at 13:39 +0800, Cindy Lu wrote:
> > Add the function to support setting the MAC address.
> > For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
> > to set the mac address
> > 
> > Tested in ConnectX-6 Dx device
> > 
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> > 
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index ecfc16151d61..7fce952d650f 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -3785,10 +3785,38 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
> >  	destroy_workqueue(wq);
> >  	mgtdev->ndev = NULL;
> >  }
> > +static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev,
> > +			      struct vdpa_device *dev,
> > +			      const struct vdpa_dev_set_config *add_config)
> > +{
> > +	struct virtio_net_config *config;
> > +	struct mlx5_core_dev *pfmdev;
> > +	struct mlx5_vdpa_dev *mvdev;
> > +	struct mlx5_vdpa_net *ndev;
> > +	struct mlx5_core_dev *mdev;
> > +	int err = -EINVAL;
> > +
> > +	mvdev = to_mvdev(dev);
> > +	ndev = to_mlx5_vdpa_ndev(mvdev);
> > +	mdev = mvdev->mdev;
> > +	config = &ndev->config;
> > +
> > +	down_write(&ndev->reslock);
> > +	if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> > +		pfmdev = pci_get_drvdata(pci_physfn(mdev->pdev));
> > +		err = mlx5_mpfs_add_mac(pfmdev, config->mac);
> > +		if (0 == err)
> if (!err) would be nicer. Not a deal breaker though.

	yes, no yodda style please. It, I can not stand.


> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> 
> > +			memcpy(config->mac, add_config->net.mac, ETH_ALEN);
> > +	}
> > +
> > +	up_write(&ndev->reslock);
> > +	return err;
> > +}
> >  
> >  static const struct vdpa_mgmtdev_ops mdev_ops = {
> >  	.dev_add = mlx5_vdpa_dev_add,
> >  	.dev_del = mlx5_vdpa_dev_del,
> > +	.dev_set_attr = mlx5_vdpa_set_attr,
> >  };
> >  
> >  static struct virtio_device_id id_table[] = {
> 


