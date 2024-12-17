Return-Path: <linux-kernel+bounces-448552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA38D9F41B2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 05:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 657A9188DF76
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 04:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98F71487C1;
	Tue, 17 Dec 2024 04:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uisHgzKG"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D30C61FDF
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 04:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734409373; cv=none; b=NTvieiGjPT5Ll3BPC+2modLpRL4J4UwQxU01dR89eyFY3istbcyl7wr6V8gGcq6g7K1bQ37n+Mi2NfaXHruHQK8xhYjpJoxmtHIWZOc7YhBVeE1Ss83NOLLQZAEtnqvU583s/Y3ESKpKPQhGESuy838OyAy/WeFd18bP6UPk2v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734409373; c=relaxed/simple;
	bh=zqpqLDi9o2HN9pkhqRL/t6PUB037p1nJeo7h79OIEuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0vxlNreZ3BONvneXGB2dq9s49fPeLabX/B1BIf9zsxNKhyLZ2y5Bbq6GNbpDKJ+R9G9uAfq3jCFY4Wg7+JZNeqm14kYae/4HzsMDCWKopo0IVupjWyoYxAykRA38Fy+mu1jVW7KnGJq9NFeEWfu01OHmKvsec+mscoNx4hgEYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uisHgzKG; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21675fd60feso50603225ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 20:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734409371; x=1735014171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=07JoRp2HdL+fGtPDXl2NqAHgCCvT4umPfbJtAb58RtM=;
        b=uisHgzKGo41X8yN2cDoQjf0jPSsWruhMhjAt3ryjllmuG1qyOA+FBJS81GRXRvvu2u
         NxFTrOVDrJBRGrY14sidtok6LIWqXHmwVeJzYn7ZADRv82XC8P5f2r80i4BpKEPhjwKS
         VC7sk7OJDByKM8Wkitvu3S1C8daaAEE2qmPzIMiHAPSkOAsk3Y9bOo6a3zl6A2qB4SNM
         1e2LuXQgTZswZHTanWSE2DW5suGF7eSjg94IKAVh20gy5ol97eqggG5pCro5Is0+i17/
         sPVZmB00nh/rapAfStCWvixT/qpSnDDoNhpB/g8ZcPFN5VT8Mr9KjvvDPYOpi6w25lsK
         y9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734409371; x=1735014171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07JoRp2HdL+fGtPDXl2NqAHgCCvT4umPfbJtAb58RtM=;
        b=kjufo6diY1qtN1b0LIkhCoTnWzB9LF+6fH5mU37edjm2QaCSz6e22/5jW/RkC4A96X
         pOKEoOeOX7Ya07WuOuJ2X1UAbDxILVVFLOz0Jq/qR/LqBN6M59hf6wjxha/QkbJrARZt
         vJhnBWUxKhj48rjApPZcPMDJ2qtucKsXa0i12LQlc3jE3EgJMWnYlnaiaS1c2q/h6quZ
         dMHFNQ9ZLWu9kTHz2OdryRl2xzlLS4QVXBEJryfA2hKiGqyM/o2C7SuavFh4bBBx/sB+
         ZkweQt9e1PPT3+RcIj+ZBv844mJzvjHGoNJ671d4ABMWxtc5vZKxKLjbW3SKMxrzUCTh
         JMXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpLEcfzmEmkYk1OtGbB2mpT40UJQrDJGHIB6bPfGwchEbTMAuXp87kYRgdl1qLbu0LoqM9UmskkQq8uXs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6j5Eg4u5P1r1R9xhXnOqoaURI9EDhEiLytk1JoOL1xGEZc8bC
	2UTfykkIbbJspfCjde1O0BUBYUWDEu9u/Tyg9AEnxmsaGqUJ5PaU0k1Wv8fyd04=
X-Gm-Gg: ASbGnctjpS/KHfnO1xi+rF9usJXtfrhgUB3TFRjVrdr95xDdX2k4DN+QNJUDe2s63cQ
	FnsBuvsU1Q7rHYtHGuC1HE9A2cWdeIRBcjFTfUdYJfv+V/iMtMbacX1P2WhTz3yti3NsIAO0Org
	W/XXYviaBSpoz71AKqOUVvNcG3ndm1mGZ1h2a/Jt3mJuQMqY7WrX6caynY/U5RBgxzZmw4H5I0l
	br5gmLtwTimuEBYMFQgQLUIXf3y3MtqeS+KfBS2ERg4Vwf7I4goBe26AcM=
X-Google-Smtp-Source: AGHT+IEKbIgA6J6tdVvc/CKVL0o8Qbd3JlzKf10BNjP+GnyYPGnHpKt+dWfA7AT7ES0/R2gK7S0k+g==
X-Received: by 2002:a17:902:d484:b0:215:431f:268f with SMTP id d9443c01a7336-21892999536mr230452625ad.10.1734409370906;
        Mon, 16 Dec 2024 20:22:50 -0800 (PST)
Received: from localhost ([122.172.83.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e7227asm50376595ad.272.2024.12.16.20.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 20:22:50 -0800 (PST)
Date: Tue, 17 Dec 2024 09:52:48 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ma Ke <make_ruc2021@163.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, arnd@arndb.de, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] virtio: fix reference leak in register_virtio_device()
Message-ID: <20241217042248.omldhsl4royrfo4o@vireshk-i7>
References: <20241217035432.2892059-1-make_ruc2021@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217035432.2892059-1-make_ruc2021@163.com>

On 17-12-24, 11:54, Ma Ke wrote:
> When device_add(&dev->dev) failed, calling put_device() to explicitly
> release dev->dev. Otherwise, it could cause double free problem.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 694a1116b405 ("virtio: Bind virtio device to device-tree node")

The fixes tag looks incorrect as the problem must be present before this commit
too.

> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>  drivers/virtio/virtio.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index b9095751e43b..ac721b5597e8 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -503,6 +503,7 @@ int register_virtio_device(struct virtio_device *dev)
>  
>  out_of_node_put:
>  	of_node_put(dev->dev.of_node);
> +	put_device(&dev->dev);
>  out_ida_remove:
>  	ida_free(&virtio_index_ida, dev->index);
>  out:
> -- 
> 2.25.1

-- 
viresh

