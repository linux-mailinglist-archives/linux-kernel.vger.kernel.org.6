Return-Path: <linux-kernel+bounces-571795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34979A6C259
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 19:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F39448028C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB0122FDF2;
	Fri, 21 Mar 2025 18:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eAxy/fYc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02AC22E3E2
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 18:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742581631; cv=none; b=EkHkGbNCYRIyMQoHG3LEH5PgIt6P7P1kCFuuTal5rsDm6B+2uknhG4adU6UcKXoxBqllP/9Mm4NV7CK501TqXq9MRNmwODifyCESMkygNKmklATBqCJ15z0kesFuEOsDABODWMdUugcPZNVknPhmLYN1SMgBPs93ZddYelfsC1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742581631; c=relaxed/simple;
	bh=bTQZl+jKYwsLzl4vfj4ptDXiTWI3OAMPApOYg8CTBCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCriqDJ+7BsoUOx1bzbydwtS3TeRmm8FU0tqphqhFC0uj4DUIm1Mk0Z3KqCy0Uu/UqvRK/SrSnq5zQE8UmnkTRKJyzYNxxJ3uBfkZ1VzJLdyWlnFzeQ8Im1pC2NOfLfi6bsunz9O9kPBX5zFYSu/NInezvf5Py/PKImbhmqmvVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eAxy/fYc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742581628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CBvAZI44TSwYckHNoPIjidtJUdEM1gfFKOJZR81EuoM=;
	b=eAxy/fYcv1uI6yp2ZVhJYjHcw71zxa5Q/uxmLU3aOfHj7t4F5BW0AiVmd7LmRHDdPpPXjr
	UmIefqwb8Np0Ep6oYgpSnijf840d8n+mh/+HkxNTnx/mO6PP4JbttBDFddDwOcPXNDom15
	frEPDPt90JSfFmb3RhcX89CynrMUQ6w=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-9-FsOr9FO6uR7RAPg3E3ww-1; Fri, 21 Mar 2025 14:27:07 -0400
X-MC-Unique: 9-FsOr9FO6uR7RAPg3E3ww-1
X-Mimecast-MFC-AGG-ID: 9-FsOr9FO6uR7RAPg3E3ww_1742581626
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-225ab228a37so32402775ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742581626; x=1743186426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBvAZI44TSwYckHNoPIjidtJUdEM1gfFKOJZR81EuoM=;
        b=g1ofJAZ5AsKMqdMkTrXRXUKYlOfu4eUjnDVKmB9oOixzFzoUeetMTnc2BQPSpvHx0N
         T1L9eC581rEsvX7+WigqAhcg0Pv3MKFYwNnoVn0d2ijpy118z701aoPF2sapDkXb3kvO
         yvJpvNqxfPclfBnRZjQcifSlk+Cb0SvL6IFoBD7BIi3PUFqXIEPIVNRC002/sUq0kYty
         K4j1zmgcP92Smtset0JktOIHCSEuISbgRJI0erXoZ5M1tKF4rfVCKVx1P1EmmBGmPLth
         I6NTwqdTUun0OWx+lqe8P39MkWS+EE/0ywjm+v/owwEw+XyhHk5SYG7z1/8xMqT0Gm0y
         eMnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzlxa9TCzlgK/9m6RM0ovRIbqycMIdgFgwCW0mHsv/HVcz5BBSIpgic68k6sOvLj19ncQnUF5nb5ywfso=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtG4GeiOQTzUF082Qa19Np2JuvP14teePihZHEdYv7La26V05b
	hQjnJWpAY+JLh6OUqniKN5Wl8z9rJgOrw9UMaRLqUPwRhTMlNeiaqgI7wvJOTciDTLtGbTPQntr
	wDxL1eeMUKNnRVdYElp5p8g6CEs6Okh9wvEhTGAXLMXdfZiWqKi9MIIiXHZtKvQ==
X-Gm-Gg: ASbGncukJfFMr2S/xOIG3l+ewBdYGnL8bKhHiB8XYXCzPNs7g+5Z+LBjKP/8/QEY5he
	A6ud3J2H2ZZNX+J4ua6oq8hrR/kUrUpIByXSTCdwlJL1CLecYrNjKpJugSNntDyZoFUfqPSCXx6
	f15Y5xk1ePzgA+mCPLgrlFn6VlH1ZgEGgJ2rijl+pDaH/DVZC7wLxsvlatfNawDM3r/MFSL2evt
	7tpuig355JxGu433vgacDTPu8U2a3K7eaF0r6IchQ2Ci6qIWqwlI9Q+wEwITplOx9IqKzvfEttd
	Zm8h/PYu
X-Received: by 2002:a17:902:d4c5:b0:224:e2a:9ff5 with SMTP id d9443c01a7336-22780c68927mr63231005ad.9.1742581626016;
        Fri, 21 Mar 2025 11:27:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHESOlmKUv4omuiIQXNajC9s1OooXjFczUMnufBWcD/XHD7P+eP9u2TgzZG1Ni8l4wIF+1XA==
X-Received: by 2002:a17:902:d4c5:b0:224:e2a:9ff5 with SMTP id d9443c01a7336-22780c68927mr63230655ad.9.1742581625648;
        Fri, 21 Mar 2025 11:27:05 -0700 (PDT)
Received: from redhat.com ([195.133.138.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f3b242sm20686155ad.41.2025.03.21.11.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 11:27:04 -0700 (PDT)
Date: Fri, 21 Mar 2025 14:26:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Melnychenko <andrew@daynix.com>,
	Joe Damato <jdamato@fastly.com>, Philo Lu <lulie@linux.alibaba.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, devel@daynix.com,
	Lei Yang <leiyang@redhat.com>
Subject: Re: [PATCH net-next v2 0/4] virtio_net: Fixes and improvements
Message-ID: <20250321142648-mutt-send-email-mst@kernel.org>
References: <20250321-virtio-v2-0-33afb8f4640b@daynix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321-virtio-v2-0-33afb8f4640b@daynix.com>

On Fri, Mar 21, 2025 at 03:48:31PM +0900, Akihiko Odaki wrote:
> Jason Wang recently proposed an improvement to struct
> virtio_net_rss_config:
> https://lore.kernel.org/r/CACGkMEud0Ki8p=z299Q7b4qEDONpYDzbVqhHxCNVk_vo-KdP9A@mail.gmail.com
> 
> This patch series implements it and also fixes a few minor bugs I found
> when writing patches.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> Changes in v2:
> - Replaced kmalloc() with kzalloc() to initialize the reserved fields.
> - Link to v1: https://lore.kernel.org/r/20250318-virtio-v1-0-344caf336ddd@daynix.com
> 
> ---
> Akihiko Odaki (4):
>       virtio_net: Split struct virtio_net_rss_config
>       virtio_net: Fix endian with virtio_net_ctrl_rss
>       virtio_net: Use new RSS config structs
>       virtio_net: Allocate rss_hdr with devres
> 
>  drivers/net/virtio_net.c        | 119 +++++++++++++++-------------------------
>  include/uapi/linux/virtio_net.h |  13 +++++
>  2 files changed, 56 insertions(+), 76 deletions(-)
> ---
> base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
> change-id: 20250318-virtio-6559d69187db
> 
> Best regards,
> -- 
> Akihiko Odaki <akihiko.odaki@daynix.com>


