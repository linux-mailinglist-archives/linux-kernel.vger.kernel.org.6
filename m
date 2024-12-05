Return-Path: <linux-kernel+bounces-432667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BBC9E4E73
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41555161603
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C951B3946;
	Thu,  5 Dec 2024 07:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BwNlhfV9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89E81AF4F6
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 07:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383957; cv=none; b=rpipFpWxzWohK4VX/5VlVRReDAYUcs4IJlaaN7Pv0sKgudB237KSCotK88I7tuPSv2BeOzoIbRs1NYEpDGuWy9CyPRjNELfkWzHZpkuDDIa2J5fAWDCZ9lAr7KRg43uY+ScSDJ4gZXS2zx9Ri8SCCqTWmhs+5wMadtfPOBKMEvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383957; c=relaxed/simple;
	bh=ki6pIKSupwzYj6s/3NRHiuQu5GRhGkrv5KRSIGzJ568=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FJSODKaPKdXAAgJAWq8rJSfx2gVESJwJTTOkp9c1czQm+8me4VXxt2w9FgaToTn/gFmGthcKEtYY6Y5BzUsdcAUCYnt+ckjGHXTR02S7Q3mFC/3G2Lvffb9zTJHEFlvVcA/iMS/0YGnpF57BPfHcFVVslVedN0OTWRuU4JLO9xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BwNlhfV9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733383954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ki6pIKSupwzYj6s/3NRHiuQu5GRhGkrv5KRSIGzJ568=;
	b=BwNlhfV9smGw/FzH1Ph0ivj2WXGwlrGPwgv6spGY8Px4BRjO40ePkKzr38meScAolkMCHD
	x50XKdEEbGnzh4jXin0gYVc141AmUuV4NVPd5QULQrBO6xJx9YdRl6X8rEU/W3Ux1hFwCz
	ehe2e5yxrRno1f+/BS6YTQt+vSlu818=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-sa4pSNbRPS-cvoCAxEcTnA-1; Thu, 05 Dec 2024 02:32:33 -0500
X-MC-Unique: sa4pSNbRPS-cvoCAxEcTnA-1
X-Mimecast-MFC-AGG-ID: sa4pSNbRPS-cvoCAxEcTnA
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2eebfd6d065so806092a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 23:32:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733383951; x=1733988751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ki6pIKSupwzYj6s/3NRHiuQu5GRhGkrv5KRSIGzJ568=;
        b=ALQtyoYTVboSX1uqeCdW69kMCP0UTZZVKPtxmX7VQ8k0URuPt+11WMXmT3VEZ6vkQM
         CEm82t0oPfQdpiABL4VVAhbWFtGA+CMUvd3qMVlaVIIYT5X9hvCrpxN3bUoEETjQJhQx
         tytq6pqRxBe9o9zW/0voG5cA1FbVnHgfG7GDmh47UaleH2jfCOJvsa7orB1lDpVj0hBJ
         aLtZI7jpztpzu9S1+3xPVvIiWo7s2yFGOnnSe7b2DmgKWSeY4icHxFauaxpR1I8HDC9b
         loNRCC1/EmSfLmMFj2EZFYJfP9lCSlMQqK7R3TRmL+kf+TJMC0c3Sf3fx6ojGceJRFzD
         aPuA==
X-Forwarded-Encrypted: i=1; AJvYcCV8BPFbyVyc+iFQ2Qmz6W1UbcKbI5buNx66v/GuXl52FvRPhkkzpOBWMWhAcj34y1uPK1jYZRYDVbqCyIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVsedXf7YDWvWZQ/bkVZsKp2IRB6dunv4QAoaPicMnoCXJl4+O
	BmvMvkUluiMOHkDjsajp8T0Iw6U5vxwUiB7EjOxxDdA2UqwZx2YRl6VAXaKcpqxKMCo+1y8M1JY
	NShcyb0lJSPS0yceFZiJwZImDtE1J6RqPrxuHFElxuDw7xunGglCzQkgpcgdefp5fpsNQCESoNh
	1rp2a96XrrjNjYQNLL/Wfx5lTRuh2WLMBrH3qJ
X-Gm-Gg: ASbGncuOWTbp/xvMdme3SmGiAiwxAyIZjAZALczv2nb9YbfCtJKSji6fU9m5nbQOZnz
	Yc5/srVxZLwNJyB3ymKDgAgDx/TVi8+ZR
X-Received: by 2002:a17:90b:4b86:b0:2ea:4c8d:c7a2 with SMTP id 98e67ed59e1d1-2ef012446e8mr12752049a91.24.1733383950957;
        Wed, 04 Dec 2024 23:32:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH00pmkLuLXttemKJiKF9Q/OxhVoQePAQMlOpYi0wt7eK+3w9Uxtm8XqdoXThMNr2b4ra7bR0qWU9AsuFmRg/c=
X-Received: by 2002:a17:90b:4b86:b0:2ea:4c8d:c7a2 with SMTP id
 98e67ed59e1d1-2ef012446e8mr12752030a91.24.1733383950636; Wed, 04 Dec 2024
 23:32:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204050724.307544-1-koichiro.den@canonical.com> <20241204050724.307544-6-koichiro.den@canonical.com>
In-Reply-To: <20241204050724.307544-6-koichiro.den@canonical.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Dec 2024 15:32:18 +0800
Message-ID: <CACGkMEvHUQDfAjeSBdNd0iotrgyjkbXuZBH7ehs6dZ74prspdw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/7] virtio_net: ensure netdev_tx_reset_queue
 is called on tx ring resize
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 1:08=E2=80=AFPM Koichiro Den <koichiro.den@canonical=
.com> wrote:
>
> virtnet_tx_resize() flushes remaining tx skbs, requiring DQL counters to
> be reset when flushing has actually occurred. Add
> virtnet_sq_free_unused_buf_done() as a callback for virtqueue_reset() to
> handle this.
>
> Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
> Cc: <stable@vger.kernel.org> # v6.11+
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


