Return-Path: <linux-kernel+bounces-397128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6699BD713
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5AC71C23C50
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 20:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870FB215C7C;
	Tue,  5 Nov 2024 20:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="OqJr2dhv"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD2C29CE8
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 20:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730838696; cv=none; b=ui/krmQfpoC7o9RNGesNFNoO7JDGZGp8dsirtRaF7n2y6QuozwodyHCYaUtV7L9QIl9q1iCorh1cbBjjmBUrP0SVf9ABeQrszPw6xPgIPU3XBm+/fSNXuteXJfJhjEl8VmcruYydtPk2YiM+pMMdW6W4UNRR0jLNmQ/eo33RTD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730838696; c=relaxed/simple;
	bh=njXvbbUSXT8lEjmP/9Q1IPocvcnbvTecO5498SE8Yc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lV4YcNAOjO8eBH0cPBKCKu9MjHAy/jza2bLf3etEC2SY8ZD/RbFW9hoZO96J6ZlwBHG0cL0DSb0p4G7VxLA4fA1lWRc9P6pKDEN8YHVxi8d6EcTUwj7WE12DLycHS4xkAEcyzpGhC/ynZde45yzzg3fZp1CtakM3ns/j9D1OXg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=OqJr2dhv; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-723f37dd76cso621578b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 12:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730838695; x=1731443495; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UhUU35PCwT4qTbZoZwuMAItdxx0KbqWaKmuzg/Mfzrs=;
        b=OqJr2dhvKej2lddFg90e68fvAhPsyOtYPFgWGSfgsp2axyPcmjl/wHlO0PMu7uzo5n
         K46SbtUgSJoJUw1XB4TXx7qocKNmnGc/GkB9U4KHpDn2pdFtvVJaD0h6PUotVuS/hQiq
         RgyzzsWIYL/YCmBqJlchNBxxozkXhCW7SEjUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730838695; x=1731443495;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhUU35PCwT4qTbZoZwuMAItdxx0KbqWaKmuzg/Mfzrs=;
        b=RaX96PCPI5QFIl+EVefrGk1+UGLS+8+bALgbYtslT7E7CYA00JEFXFbNhH2lrHPIqe
         IXnj4/3M+0h1oUZw8r1oDI52/5V7nnB01bmcK1bIvBGulVS0SzbfRMGgL2L7HvG+2olZ
         y7YAhuhH3iYDTZkOh2L2UIWPr8Ps9zckfU6TgEhAVRU4rtdx4C3hylJfOTA7dE0JbY/M
         Sti11d0UjIOsuK4ya4DlkhMOXkaG/7cVbDBviKNHH1I2GPweGpr25pIqgjBjuqlYff29
         Wiry2vK44JaFNNuKH/d6oF85E2Gesh8F+CMtV6RZ48gHaRgHDWJ9Am5xlb5g19wbPOH5
         zTFA==
X-Forwarded-Encrypted: i=1; AJvYcCXy7B7rtbavO2GsjEUctjWEOsOg1vxJNeDHWh+uDGoJa5OdWGiQ3FE4fi4NyhLIhF14/b/zocEUp8El6Rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX1oFhjw2AYpOJ5pjVoGB0CCPsNuW8DzzAin9KsHtawOmyVRZP
	fIBO1BHdZV7uUtEBR7AFc9D/VNLLAx60EnkWXzg/TKI1GgolF5dtQfn+DubQFls=
X-Google-Smtp-Source: AGHT+IHfc4XjOAk9aNraA/Fb/T/Rh+mWy4yMsOn09WygNpR/JUFt2lVx6QttW/7pfHEYXrMQoVD0wA==
X-Received: by 2002:a05:6a20:12c7:b0:1db:eb2c:a74 with SMTP id adf61e73a8af0-1dbeb2c0b32mr7662206637.12.1730838693979;
        Tue, 05 Nov 2024 12:31:33 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1e592asm10212449b3a.60.2024.11.05.12.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 12:31:33 -0800 (PST)
Date: Tue, 5 Nov 2024 12:31:30 -0800
From: Joe Damato <jdamato@fastly.com>
To: Philo Lu <lulie@linux.alibaba.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew@daynix.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 4/4] virtio_net: Update rss when set queue
Message-ID: <ZyqAovoIOYkNvtys@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Philo Lu <lulie@linux.alibaba.com>, netdev@vger.kernel.org,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew@daynix.com, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
References: <20241104085706.13872-1-lulie@linux.alibaba.com>
 <20241104085706.13872-5-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104085706.13872-5-lulie@linux.alibaba.com>

On Mon, Nov 04, 2024 at 04:57:06PM +0800, Philo Lu wrote:
> RSS configuration should be updated with queue number. In particular, it
> should be updated when (1) rss enabled and (2) default rss configuration
> is used without user modification.
> 
> During rss command processing, device updates queue_pairs using
> rss.max_tx_vq. That is, the device updates queue_pairs together with
> rss, so we can skip the sperate queue_pairs update
> (VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET below) and return directly.
> 
> Also remove the `vi->has_rss ?` check when setting vi->rss.max_tx_vq,
> because this is not used in the other hash_report case.
> 
> Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 65 +++++++++++++++++++++++++++++++---------
>  1 file changed, 51 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 59d9fdf562e0..189afad3ffaa 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3394,15 +3394,59 @@ static void virtnet_ack_link_announce(struct virtnet_info *vi)
>  		dev_warn(&vi->dev->dev, "Failed to ack link announce.\n");
>  }
>  
> +static bool virtnet_commit_rss_command(struct virtnet_info *vi);
> +
> +static void virtnet_rss_update_by_qpairs(struct virtnet_info *vi, u16 queue_pairs)
> +{
> +	u32 indir_val = 0;
> +	int i = 0;
> +
> +	for (; i < vi->rss_indir_table_size; ++i) {
> +		indir_val = ethtool_rxfh_indir_default(i, queue_pairs);
> +		vi->rss.indirection_table[i] = indir_val;
> +	}
> +	vi->rss.max_tx_vq = queue_pairs;
> +}
> +
>  static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>  {
>  	struct virtio_net_ctrl_mq *mq __free(kfree) = NULL;
> -	struct scatterlist sg;
> +	struct virtio_net_ctrl_rss old_rss;
>  	struct net_device *dev = vi->dev;
> +	struct scatterlist sg;
>  
>  	if (!vi->has_cvq || !virtio_has_feature(vi->vdev, VIRTIO_NET_F_MQ))
>  		return 0;
>  
> +	/* Firstly check if we need update rss. Do updating if both (1) rss enabled and
> +	 * (2) no user configuration.
> +	 *
> +	 * During rss command processing, device updates queue_pairs using rss.max_tx_vq. That is,
> +	 * the device updates queue_pairs together with rss, so we can skip the sperate queue_pairs
> +	 * update (VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET below) and return directly.
> +	 */
> +	if (vi->has_rss && !netif_is_rxfh_configured(dev)) {

Does there need to be an error case when:

vi->has_rss && netif_is_rxfh_configured(dev)

to return EINVAL? I noted that other drivers don't let users adjust
the queue count and return error in this case.


> +		memcpy(&old_rss, &vi->rss, sizeof(old_rss));
> +		if (rss_indirection_table_alloc(&vi->rss, vi->rss_indir_table_size)) {
> +			vi->rss.indirection_table = old_rss.indirection_table;
> +			return -ENOMEM;
> +		}
> +
> +		virtnet_rss_update_by_qpairs(vi, queue_pairs);
> +
> +		if (!virtnet_commit_rss_command(vi)) {
> +			/* restore ctrl_rss if commit_rss_command failed */
> +			rss_indirection_table_free(&vi->rss);
> +			memcpy(&vi->rss, &old_rss, sizeof(old_rss));
> +
> +			dev_warn(&dev->dev, "Fail to set num of queue pairs to %d, because committing RSS failed\n",
> +				 queue_pairs);
> +			return -EINVAL;
> +		}
> +		rss_indirection_table_free(&old_rss);
> +		goto succ;
> +	}
> +

