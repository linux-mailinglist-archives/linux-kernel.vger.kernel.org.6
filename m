Return-Path: <linux-kernel+bounces-397124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD8E9BD709
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A7072841FA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 20:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C38215C7E;
	Tue,  5 Nov 2024 20:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="jNR27JuP"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF0417BEB7
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 20:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730838516; cv=none; b=LMtRf4J+zjDxLQntvNJgW6fzfKJHdXzqerlTjwUdIy2PtChCg1AQ6HtUpd5JVrcnIry1FYON2QLLPaeOYVBL+hykL48Zbyu8tOjA7GPjjmYXLrGIZu4VFvlEt1PFkvFJkSi1LAQzpNmP7UAkT04yFvB6lVYpjboH2DYXUGqV4H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730838516; c=relaxed/simple;
	bh=r4wQnQB7TOhhaDz2m1Pn1z5j3SZx+o7iBbQS2F+6OQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/EoE9YsNN0/chysQD/MfARc+yFQqa61LfOIw8ObePtoBrJ+4VthC+f2TvzMleXAFH+m6jf1DygvgoP2mwYJ09S+kVZGky3pjSBETFMKt68sGlRGZOFqSKqpM+nDrYtS8KUrt2UNgBil3wSFRKhllxpLJGxtz3m604iEjDZJx1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=jNR27JuP; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21116b187c4so42032815ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 12:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730838513; x=1731443313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQeQW2N8zpTgfzsfBRysnSUZd8G5nyNGiYxO+3VjSwE=;
        b=jNR27JuPxXJ8NBA0lo8BRIgyEVM0oTh4lrWecL4uh5aJottAOTGNYWP5oeAYBhRN2L
         ARugtuyHvF9y7wi3eSkBEDce5Xbq+8dduDFdPdOifd8R48haU18s+TFKuti5YzpU3ntP
         tQcc6Lqo5g1eGkFkyo6/eYXymTcY9JuVlwzw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730838513; x=1731443313;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LQeQW2N8zpTgfzsfBRysnSUZd8G5nyNGiYxO+3VjSwE=;
        b=V0JUBxEcvR/rEHBRkpbBc+VV4Op+e8KyqpFuXeyjG3d2hmrDk4BuZGOctuniwAnqC7
         pHZun2ni36e9cS0tFqlss7otnTIKAF9QJWg4MA/jaU8WSYOrrH5lT9YfXI2SXRIcm/No
         VDSjSvuNM6MFUhuM1bzo50DBTfAUT4KHIWDiEcSZb4NSdtej+YpQDKPuRewdVxjU9owN
         3HUjiqeFFUJTWH1d8/HA1ZL296kL2lLZTrPvrWZmBOXpS0Usq6xphDQzy83hHaj+GU9X
         j8218tjM1Br1j0fZNg6Gjb8P3WCGZdomXD8hi+vcjw1E18I3XQ3XlksAuajiaY1Bf+7n
         Gq0w==
X-Forwarded-Encrypted: i=1; AJvYcCW9t+i0DH36QZWgMmfTOGqVukC5hEMo1yjP+0oQQ5EgthBqf1S7p/hzfO/Fe8dBL2eSJ1gXKUjjYRSN8E4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZwP8HrBle0SEhk/KavAMvFI3GQbenYPDLeYU381Y+5HZ+TGHs
	GLav0Dfn8uBJ25zhcOR2Hzv8sB1SeP2PY368ItjCzI8mLX7JxDHtiDsGsXGrZyQ=
X-Google-Smtp-Source: AGHT+IENnWKhXsUeHfoWFHGstrsTSODyhq9Rx+TVaQWEQ9Ryh4qCgsEm60cTkPZKg6zj/kWO5fN5wg==
X-Received: by 2002:a17:902:ea02:b0:20c:a122:e6c4 with SMTP id d9443c01a7336-2111af3f634mr222617155ad.14.1730838513019;
        Tue, 05 Nov 2024 12:28:33 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2110570865fsm82537165ad.107.2024.11.05.12.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 12:28:32 -0800 (PST)
Date: Tue, 5 Nov 2024 12:28:29 -0800
From: Joe Damato <jdamato@fastly.com>
To: Philo Lu <lulie@linux.alibaba.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew@daynix.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/4] virtio_net: Add hash_key_length check
Message-ID: <Zyp_7ea-1F9VPEBL@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Philo Lu <lulie@linux.alibaba.com>, netdev@vger.kernel.org,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew@daynix.com, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
References: <20241104085706.13872-1-lulie@linux.alibaba.com>
 <20241104085706.13872-3-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104085706.13872-3-lulie@linux.alibaba.com>

On Mon, Nov 04, 2024 at 04:57:04PM +0800, Philo Lu wrote:
> Add hash_key_length check in virtnet_probe() to avoid possible out of
> bound errors when setting/reading the hash key.
> 
> Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 75c1ff4efd13..acc3e5dc112e 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6451,6 +6451,12 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	if (vi->has_rss || vi->has_rss_hash_report) {
>  		vi->rss_key_size =
>  			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
> +		if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
> +			dev_err(&vdev->dev, "rss_max_key_size=%u exceeds the limit %u.\n",
> +				vi->rss_key_size, VIRTIO_NET_RSS_MAX_KEY_SIZE);
> +			err = -EINVAL;
> +			goto free;
> +		}

I agree that an out of bounds error could occur and a check here
is needed.

I have no idea if returning -EINVAL from probe is the correct
solution (vs say using min()) as I am just a casual observer of
virtio_net and not a maintainer.

Acked-by: Joe Damato <jdamato@fastly.com>

