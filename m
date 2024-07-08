Return-Path: <linux-kernel+bounces-244225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 023BD92A124
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 13:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC1DA1F21D87
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A0B7F7E4;
	Mon,  8 Jul 2024 11:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LQ2uiRb4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E37F7E10B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 11:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720437985; cv=none; b=UGDkNCkkUe3JhpTXz5g1oEKtXg8TwaYwR3Jlz/WzKBNTBXdRgirZTp+ox4y+uO9+Kamjc19XIVnTIGg68a/xNlzEhJZpcH7/b5D50UBSrk0z4ImCuxAJkqrKQebm69fyIBMmn4PAruVwJUfE6NUZkL08PsoB1V3DaG6pJ0geZA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720437985; c=relaxed/simple;
	bh=BiZcXjD0MF9+4zB3dvLvvXJajt6y3TabHLQgZnFuMWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ybf6KSZqW7rHA0QJRv1WRfZ2q8kbAjoBodyBGZJgzbf/0oz/D/GQ2L2kgJGFyiZzgbOl6h5Nw1hd2Fotcloya0BmPOJDmjGgWIxWb0bceFT+OeJdCq7KMwq5RHdKrELHFwugdhjLueX+yIeXEyhunYHCkw124aWCWlyJapUnSzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LQ2uiRb4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720437983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H+1JhCgg1e3xAL9ukropoVjm3oRaKeBDSlDAr3D/8Qw=;
	b=LQ2uiRb4y0F2J7JPP2jAPWoWTFUClBHHxp2E+Qbd89I8uOrZAy+inh3DFb+Y0T01VSpxfT
	7kRMCTXTJgz1y0YPpDMDv0BZun1XsEXlSKFRrtJ0nARZ75C9GkJMGehmCOOj0I860W6vYt
	sA3AjlHCyyCschv7y8MIsnJ2OAY1kCQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-A1wVyI7uOCaV6nw2sfX4wg-1; Mon, 08 Jul 2024 07:26:21 -0400
X-MC-Unique: A1wVyI7uOCaV6nw2sfX4wg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42668699453so9560395e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 04:26:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720437981; x=1721042781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+1JhCgg1e3xAL9ukropoVjm3oRaKeBDSlDAr3D/8Qw=;
        b=iTh+sDXUEna9f82IPcdFszujgNqZigzZ8/asCMHSy6nh+jtNvJo8cs3OHdyDH3ZbgO
         tfAoCPfu8n/yhwAQdoEz7AbaW9di8B0mCH6WNiQXBfdRK7lYpwCRKXZukWaFuVSba5st
         GhahMTU2FrdlQRliJeCH33uWrWwBAn0kFB0u+5R+YgV2Z3q+QIlM4aAHkaMSVOg7d/QD
         Od23rmNwOWdO/g2CuOqRpH6N1sYXcf4ZzqbGEIHNqqs6FboD500rWCyeVYHzTqJxnk1M
         MyIrz124w7x+j2xubnyAi52Mf0Xr85ZwdILOLL74SwdJ/EKoq1kSk5J1sJ0P2yp+Bqot
         C77w==
X-Forwarded-Encrypted: i=1; AJvYcCUR4hqd+np5yzpChG8O60kRSRH9kyedBoEiwzNHsPDAMmNu4Tcz00wo7nFzuD7q+Qt8BcnmknK0z4N7fWAnoz/7O+y6FykqzR9As+By
X-Gm-Message-State: AOJu0YzIuGKo9h2Oo0CTKRSiYvsxqjaFGw1xLRUJK40Qc+jeJgvIM02M
	Cj78FC25SwbNHMdaJo/KFZ1keaDtyz6cUTpe9UAXolTROrwTTeHfi5ox+hUSJhDVnqbecbSe7lW
	t6ETizaujkRpiU+zmzT7UiYtGvApttoBsJxoJ+mzf12QDxvutDEtP9N86MMhAsA==
X-Received: by 2002:a05:600c:1d11:b0:426:6e9a:7a1e with SMTP id 5b1f17b1804b1-4266e9a7b2cmr4958735e9.35.1720437980864;
        Mon, 08 Jul 2024 04:26:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGpA7ji/rZ+8HL55hEF/BG5Syq+7fVBtOtgJNBvAR3h2aS4f0cQ39/TmwMykXfwdCiYI7Sog==
X-Received: by 2002:a05:600c:1d11:b0:426:6e9a:7a1e with SMTP id 5b1f17b1804b1-4266e9a7b2cmr4958475e9.35.1720437980375;
        Mon, 08 Jul 2024 04:26:20 -0700 (PDT)
Received: from redhat.com ([2.52.29.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4265c2a99c7sm59914285e9.1.2024.07.08.04.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 04:26:19 -0700 (PDT)
Date: Mon, 8 Jul 2024 07:26:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, jasowang@redhat.com, parav@nvidia.com,
	sgarzare@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] vdpa/mlx5: Add the support of set mac address
Message-ID: <20240708072603-mutt-send-email-mst@kernel.org>
References: <20240708065549.89422-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708065549.89422-1-lulu@redhat.com>

On Mon, Jul 08, 2024 at 02:55:49PM +0800, Cindy Lu wrote:
> Add the function to support setting the MAC address.
> For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
> to set the mac address
> 
> Tested in ConnectX-6 Dx device
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Is this on top of your other patchset?

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 26ba7da6b410..f78701386690 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3616,10 +3616,33 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
>  	destroy_workqueue(wq);
>  	mgtdev->ndev = NULL;
>  }
> +static int mlx5_vdpa_set_attr_mac(struct vdpa_mgmt_dev *v_mdev,
> +				  struct vdpa_device *dev,
> +				  const struct vdpa_dev_set_config *add_config)
> +{
> +	struct mlx5_vdpa_dev *mvdev = to_mvdev(dev);
> +	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> +	struct mlx5_core_dev *mdev = mvdev->mdev;
> +	struct virtio_net_config *config = &ndev->config;
> +	int err;
> +	struct mlx5_core_dev *pfmdev;
> +
> +	if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> +		if (!is_zero_ether_addr(add_config->net.mac)) {
> +			memcpy(config->mac, add_config->net.mac, ETH_ALEN);
> +			pfmdev = pci_get_drvdata(pci_physfn(mdev->pdev));
> +			err = mlx5_mpfs_add_mac(pfmdev, config->mac);
> +			if (err)
> +				return -1;
> +		}
> +	}
> +	return 0;
> +}
>  
>  static const struct vdpa_mgmtdev_ops mdev_ops = {
>  	.dev_add = mlx5_vdpa_dev_add,
>  	.dev_del = mlx5_vdpa_dev_del,
> +	.dev_set_attr = mlx5_vdpa_set_attr_mac,
>  };
>  
>  static struct virtio_device_id id_table[] = {
> -- 
> 2.45.0


