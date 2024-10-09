Return-Path: <linux-kernel+bounces-356503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46462996225
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0776A280FC0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0EF188012;
	Wed,  9 Oct 2024 08:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2xV2uc4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A2F16D9DF
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 08:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728461665; cv=none; b=bgMHOKxxY8oRMzDodwX5JvgmJaaGQuCu/2GaBNq8pStkcDAnbPOgu1ewRz2vMYFxYaTcJ+OEVxqPMYeXwjmQKyOkpofq4NlB4yObbgJl6oX8ST/ML9p6FYAxWsmoWAUnisSXE5BZA5jqs74uu9yovgkL+XbOhKT3Nmls8mMOs60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728461665; c=relaxed/simple;
	bh=AXLP2KyrAqjaejcHnTbI8HMVGaKN1T0qdKQjIwPuqBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hxZhxr5/OsIkSaosqxnsiVsrYbEJBVAds7M3J6KohbrhNVZZPIkm/qOsoYmDZKyJjHZPRQG4GlG4tRqKx1kSpKzqoLKczxAaT4n5lblSAZ9j/cn1RMs6L0/HvL9HPLPDxGAlw8RAJJUQiin56oJtVrURLmmHRsiOmyWlNPPZD4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a2xV2uc4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728461662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H7WnLoztQpWL0UuoG5WJ33odis8tMGytHkOB4fwng3Y=;
	b=a2xV2uc4q1vxavas8BzK8kn/5hZXlZTfrOJlH+LsXKZ+FF+39oCNXX3Rho5GuiVi/QGyJB
	zNClLnEF/OlalblNwqNRFB0Td2GGQoYWb4OqIDLTjMYSxwnRJWduycLJt8S/nzmNOhPUrp
	X+v7bPZ3w29KvHvnf+eYoq/4Krsf7AM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-xi4eDfcPP6uAv3tGV_8vgg-1; Wed, 09 Oct 2024 03:45:27 -0400
X-MC-Unique: xi4eDfcPP6uAv3tGV_8vgg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2e281e07f14so2234768a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 00:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728459912; x=1729064712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7WnLoztQpWL0UuoG5WJ33odis8tMGytHkOB4fwng3Y=;
        b=oOmRf1iqtAFFIeMu76/1fgXBu0S4FBFKsKYx+Rx2XHiW1WCrcHQ5yGTtxvM7p6spcX
         uuiDNyKKq40SZmf03uJ/ojamBSeIiIY/CP2P1FgBAZZm2zbtguHiz3vEPqxGwK1ZsNq8
         XUt18GW+tsWIrLZ/OA0sHj2tRXLtELwRLr0yTvU2vk/NUJmgKujcZml0BlVOkvQC36Gh
         KLwZ5b8S7aL3R6Ti1TleGIYQXhyg/awd7ESBC/AVY8l+swCDq6Zowhgjj0NpQgHprZE5
         4o0VRX3qLMKMA6ay9OOMCcavsdDy7PrLSg/z1Pt8jyxjNm/ZhkvgaIeaAEikGC8wrRIY
         OThg==
X-Forwarded-Encrypted: i=1; AJvYcCXJHt3ka9c1SJzJkWXCzTkwiT3vXL5dhJMPSUgxVdX9zCIQQZGNTLjW5xIeyaGjVLff82JOKLRMR1xtC/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPYTCuh5V4RoNjNvFJKE1tgFdjw8zR6Yxu5br/uGfkFBuTcrUh
	vKdYzk+WM97OPxRFHS/t3pHr/HFnz0lULZopdyDkpdbgVdZ6yNsJlyG0DmjYf19ZkZk15ssdWZL
	dNFq6vneg9/CbYHdZTVWXkcc9QAgJwZc1kW2pRsLwG+Lbsjpo6szy/ygOGN7iogFtA4jmcftVZo
	n3oOi53BpWd7Tml+ZcwnUoNKpAJ4CZhT+2JB3k
X-Received: by 2002:a17:90b:4a52:b0:2e2:991c:d795 with SMTP id 98e67ed59e1d1-2e2a2587e6cmr1772597a91.40.1728459911735;
        Wed, 09 Oct 2024 00:45:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUXS3Vu8tqbV1XHkGBTCNaL2VDRz7beWlworvX+yKRqbV5bgZG5ofneJzBijB1Dsili4oRB7g3ygL6aKFSPxI=
X-Received: by 2002:a17:90b:4a52:b0:2e2:991c:d795 with SMTP id
 98e67ed59e1d1-2e2a2587e6cmr1771623a91.40.1728459881543; Wed, 09 Oct 2024
 00:44:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-rss-v5-0-f3cf68df005d@daynix.com> <20241008-rss-v5-5-f3cf68df005d@daynix.com>
In-Reply-To: <20241008-rss-v5-5-f3cf68df005d@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 9 Oct 2024 15:44:30 +0800
Message-ID: <CACGkMEt054F1AZP7V0ocbUce_AvQV_Cw-K21y7Ky1gWa=eSpCA@mail.gmail.com>
Subject: Re: [PATCH RFC v5 05/10] tun: Pad virtio header with zero
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 2:55=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> tun used to simply advance iov_iter when it needs to pad virtio header,
> which leaves the garbage in the buffer as is. This is especially
> problematic when tun starts to allow enabling the hash reporting
> feature; even if the feature is enabled, the packet may lack a hash
> value and may contain a hole in the virtio header because the packet
> arrived before the feature gets enabled or does not contain the
> header fields to be hashed. If the hole is not filled with zero, it is
> impossible to tell if the packet lacks a hash value.
>
> In theory, a user of tun can fill the buffer with zero before calling
> read() to avoid such a problem, but leaving the garbage in the buffer is
> awkward anyway so fill the buffer in tun.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

This sounds like an independent fix that is worth going to -net first.

Thanks

> ---
>  drivers/net/tun_vnet.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> index 7c7f3f6d85e9..c40bde0fdf8c 100644
> --- a/drivers/net/tun_vnet.h
> +++ b/drivers/net/tun_vnet.h
> @@ -138,7 +138,8 @@ static inline int tun_vnet_hdr_put(int sz, struct iov=
_iter *iter,
>         if (copy_to_iter(hdr, sizeof(*hdr), iter) !=3D sizeof(*hdr))
>                 return -EFAULT;
>
> -       iov_iter_advance(iter, sz - sizeof(*hdr));
> +       if (iov_iter_zero(sz - sizeof(*hdr), iter) !=3D sz - sizeof(*hdr)=
)
> +               return -EFAULT;
>
>         return 0;
>  }
>
> --
> 2.46.2
>


