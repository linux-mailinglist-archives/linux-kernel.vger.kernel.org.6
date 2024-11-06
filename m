Return-Path: <linux-kernel+bounces-397928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBBD9BE28D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B24DE1F22431
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B0C183CD6;
	Wed,  6 Nov 2024 09:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K9uzxNfa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774E41D54CF
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 09:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730885495; cv=none; b=oEAKduK8RQydGT0B9K9oXuYRx5j/pw9TDaRqUUB2ZXBgFiudLYjGaBdk4fasoel2mUZiWTF6LoF2CZaCRoMgxWkrASHAi24sFRpvrjKdtd7yCKSzHrCZTdGU4kpulLwQaznm+ULfQV/XAGNa6X6B4muyVn91cw/5yX+yzHc2vPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730885495; c=relaxed/simple;
	bh=JiQ4UZeYNmZjPUCdRREOzBbUPxshCp9ydNEIQdTxnkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mV3Vl+jMIjmUY8emFB/M44TBmUWxynMLVbXU40rKWwOnZYtlfZ825jIQ9ILncM2CP7WikcRax5+F5yJpG3cZcRnI5E+AFxEUcIUqOKKbgkGnoz6JNjUTR/DUn+M73htQzY4fb/oFhpTEtBeauieP0g5s8/IcbXvCoIN+qADEzFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K9uzxNfa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730885492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v58eFNnRCpQyAQvqQmmVaZ0uMDgtCEI/dBsjoJSUfhk=;
	b=K9uzxNfaZtvwBfnhh1khO6ao/+vMtsQ3CVlWXc3h/D0RjoKyRi5Z1w6NqL5tzA+i5TNizT
	sdyz5fzkL0B7UZPWh5Hj8P5zARYTFFz9hl0JX4rhBz1Zq+C2ZpfHi/+S4Gtm+3B5VW9qk7
	G5kQlOvrHZXgWqdMVhxhMU90ogLq9hw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-FvYl3x6oM8mwxbHJygS6dw-1; Wed, 06 Nov 2024 04:31:30 -0500
X-MC-Unique: FvYl3x6oM8mwxbHJygS6dw-1
X-Mimecast-MFC-AGG-ID: FvYl3x6oM8mwxbHJygS6dw
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-539e03bfd4aso4391455e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 01:31:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730885489; x=1731490289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v58eFNnRCpQyAQvqQmmVaZ0uMDgtCEI/dBsjoJSUfhk=;
        b=AeRXylgwpvJc67oMm445NGy0SAHThPPeLVBvNQqFDt23luV6Dkgy5jM87/CrgO1WnB
         v+iSEdXq03tgOyvqW3sjTFXK9sxUs0j2Hm4QIbP7c4eBtMKX4zL6ppZl7yUDZJ9WUgmI
         h+pmAX2l6OjQ5cQ7qFfh7+qYJBqvojPkPOaZIDx9cE/mE5UWdj5QBAQ3gK4CSk4RP3AV
         Dnu4b0H4q3ivUl9F9I3lrq/Omg19/CR/pZpu//7HHpAMhELxOFaKea8tlOyERBT6X7Gn
         BrEZ1SYZwSart3r3iK6D8jNZ6115c89tPDTvuGWnr+/l08hMq+8GB9uczkLYOHZN+UVo
         XDaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEruy/dAu938ybfGdu53Nb6vj+n93bzeL3VYE0h5bFC9R6J4POCms8c8RfMpDZ9NKQVCsIprZ6B4IYzdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWZz+lRceGZOGDsa80gymxZfskj5fUKzOakMdVZysik1cw7Xf6
	XLU0X5oeYK9xjeIomR1Hv/D137BK2+AEF1PXb3n1ytfkeB7pHMU1suxZhyXFyHCWOZIq86en4/j
	DNHGyRjNBg/x5htDAvTCzM5geXlRhOeFIKi2s+5ANK5lJMSk6q3Aj+fEzNPLl3w==
X-Received: by 2002:ac2:4e06:0:b0:52c:fd46:bf07 with SMTP id 2adb3069b0e04-53b34a2e4d0mr17637559e87.49.1730885488746;
        Wed, 06 Nov 2024 01:31:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHSH1SBaQr5jBIsa52gGokkq9bGzxMCBLmYIc/MQMKZVJdyqq8Vzi2SdL9vrY12cUu256ODw==
X-Received: by 2002:ac2:4e06:0:b0:52c:fd46:bf07 with SMTP id 2adb3069b0e04-53b34a2e4d0mr17637538e87.49.1730885488282;
        Wed, 06 Nov 2024 01:31:28 -0800 (PST)
Received: from redhat.com ([2a02:14f:178:e74:5fcf:8a69:659d:f2b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10eaafdsm18588441f8f.63.2024.11.06.01.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 01:31:27 -0800 (PST)
Date: Wed, 6 Nov 2024 04:31:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philo Lu <lulie@linux.alibaba.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew@daynix.com, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/4] virtio_net: Make RSS interact properly with
 queue number
Message-ID: <20241106043106-mutt-send-email-mst@kernel.org>
References: <20241104085706.13872-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104085706.13872-1-lulie@linux.alibaba.com>

On Mon, Nov 04, 2024 at 04:57:02PM +0800, Philo Lu wrote:
> With this patch set, RSS updates with queue_pairs changing:
> - When virtnet_probe, init default rss and commit
> - When queue_pairs changes _without_ user rss configuration, update rss
>   with the new queue number
> - When queue_pairs changes _with_ user rss configuration, keep rss as user
>   configured
> 
> Patch 1 and 2 fix possible out of bound errors for indir_table and key.
> Patch 3 and 4 add RSS update in probe() and set_queues().
> 
> Please review, thanks.

Looks reasonable.

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Philo Lu (4):
>   virtio_net: Support dynamic rss indirection table size
>   virtio_net: Add hash_key_length check
>   virtio_net: Sync rss config to device when virtnet_probe
>   virtio_net: Update rss when set queue
> 
>  drivers/net/virtio_net.c | 119 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 100 insertions(+), 19 deletions(-)
> 
> --
> 2.32.0.3.g01195cf9f


