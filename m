Return-Path: <linux-kernel+bounces-553549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB75EA58B4E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 05:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54BEF7A40E4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 04:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDEB1C1F1F;
	Mon, 10 Mar 2025 04:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFhw0FPZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BBC81E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 04:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741582555; cv=none; b=fxjh9TboCCDf9d2VcaaXyoR3Aqv3LGHjw2Vx8QZG5mCGKoeaX6nfo81rGB7AF3cGBoiFT6wMYmXaaa9we6vjSTPGx6zyzdSLzqIy6xOni4nmknjgBRU0xlAArWVj3F63xaDXeccX+nr7xqpZHJFOPr2KmTf7vn6UqsgQQ/O9iU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741582555; c=relaxed/simple;
	bh=s8/EMeFEWEYah/ToEcdcQneRc/EsdPCJPwOwk2JfRWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o95SIKUmcz3QcGE0bNBH58d5M2v65p/hdfE7gfMhMjQ+HxrTT/dF40yndc3WQPJVko8las5FupmWrZAwLRRpOxuIAmZrrqI4N3IZZWayAD4vSLkmpIVfCXTO3ej4tT90d4mjCzdaNCdZ0E7owFeKGkITzBWUwgB2YUvgn2NgfPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bFhw0FPZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741582552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AGNHJW4HHjvj/4hx7d09Bc4jJVzUfVQWIWoaRlJrRIo=;
	b=bFhw0FPZJRp7895r2XsCpumUtAKHqIsw5eKwD2xj0we2J5GQkpm7aDk1bykLTZVBfs+ePf
	z1t72wabJW32fqOkcvarGdURiLLqTd+BOtGO5EQoz9wp6o1D1iX4qkcRj73MwH7p64Fk9C
	bteNc5p2WXi/Tn38E8eG6v4Lz981aOo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-YObJ1RtGN2akhTQEZUO8qQ-1; Mon, 10 Mar 2025 00:55:51 -0400
X-MC-Unique: YObJ1RtGN2akhTQEZUO8qQ-1
X-Mimecast-MFC-AGG-ID: YObJ1RtGN2akhTQEZUO8qQ_1741582550
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2f816a85facso6794003a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 21:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741582550; x=1742187350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGNHJW4HHjvj/4hx7d09Bc4jJVzUfVQWIWoaRlJrRIo=;
        b=gnOmUMdpkXc50wbLY+XSIWHi0TShNno7ANLp+p32KhHQaR/q1zXVaDdoJjGrk8z/47
         lBE5deMxlSbOZOwL5afP9XOuqCzd3ca4KpPwM0xUhUWKs1zW559xN5/iliOauOUUrGkQ
         CUgz85Udbqy0m+le707Q177ht9o8iwOwlBGL79kwjKMQQItK32sx4I3OjfDhUJbbKNUM
         ZOoSTaGikazYtEXKH76QGtws2XI//jTmW4tfXj7LmLGfxSezvRSKCN6Ysi4Ca4k61Id6
         Q8BBOQLsPYyLS13G70ig82mPLtCvgNY3F4+MAqgk35PgK4K1qV32ZIf92Izvt07oq++t
         1v9w==
X-Forwarded-Encrypted: i=1; AJvYcCVjDUJ0IgYkdSnxCvdTpAjV7wYHdQVOZ0bshbogMHy3VopBsqpZW/tNz0F4RH3S9D5o58KQ9cW0RzELO1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGfyquG4pCwFT+cw4hO4z0ZK+3Avuyb4/+4AMYTDVierEcDGz7
	o6tFOyDfKqjvVLdn3zCeK8L9ABpF7hTh6N7e31c/v0DFIuo7X0K8WgO3j2Hh2KbXIuDhHU+E85u
	ExSEUNq1ky++7CNaqVS2GX0c7WMQyzhkzEBd5VFH5ZD3W9xi0YHowZkY5w4P8jd3cQMYiIgNskI
	m/t0yXFnFiqLVgv2p4zy3zvgg2DRkBLm/m4+kz
X-Gm-Gg: ASbGnct9y7EPybM8gTq1KKsFJFfV+58NJkXcFhB+wlMJVBnzHafFzdUM+1i0a0ZDhFM
	cOINuAWS6nVHjPvX1dfp/sFO5jj0oODfDCgWSnmWWHLQGDoArC4CafFVSLz2tq4LORckYWBoI0A
	==
X-Received: by 2002:a17:90b:1dca:b0:2fc:a3b7:108e with SMTP id 98e67ed59e1d1-2ff7ce63264mr18532338a91.4.1741582550418;
        Sun, 09 Mar 2025 21:55:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9Xo0gpzEFD/TRddMKMUNDMbauhJ46adEgdxNBxtmb8EtkPrUSIh1rFd5iEsD5Yp2BE7jzIDOi/82H1hGyNkU=
X-Received: by 2002:a17:90b:1dca:b0:2fc:a3b7:108e with SMTP id
 98e67ed59e1d1-2ff7ce63264mr18532310a91.4.1741582550025; Sun, 09 Mar 2025
 21:55:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a18fc6cf356bc338c69b3cc44d7be8bd35c6d7d0.1741028854.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <a18fc6cf356bc338c69b3cc44d7be8bd35c6d7d0.1741028854.git.christophe.jaillet@wanadoo.fr>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 10 Mar 2025 12:55:38 +0800
X-Gm-Features: AQ5f1JpXzBv8TIF6oxVj41FiZlnmi8yR2xYeZ4UVuxEvdCcbm3NW-Nyvl6onBwo
Message-ID: <CACGkMEtRFtzb-hbt6N8YJo8nfOOvaPcaw4dLkfs5CWN+ypkLeg@mail.gmail.com>
Subject: Re: [PATCH] crypto: virtio - Erase some sensitive memory when it is freed
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Gonglei <arei.gonglei@huawei.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 3:08=E2=80=AFAM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> virtcrypto_clear_request() does the same as the code here, but uses
> kfree_sensitive() for one of the free operation.
>
> So, better safe than sorry, use virtcrypto_clear_request() directly to
> save a few lines of code and cleanly free the memory.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> I've no idea if this is needed or not, but it looks not consistent to me.
>
> If safe as-is, maybe the kfree_sensitive() in virtcrypto_clear_request()
> should be removed instead.
> ---
>  drivers/crypto/virtio/virtio_crypto_core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/=
virtio/virtio_crypto_core.c
> index d0278eb568b9..0d522049f595 100644
> --- a/drivers/crypto/virtio/virtio_crypto_core.c
> +++ b/drivers/crypto/virtio/virtio_crypto_core.c
> @@ -480,10 +480,8 @@ static void virtcrypto_free_unused_reqs(struct virti=
o_crypto *vcrypto)
>
>         for (i =3D 0; i < vcrypto->max_data_queues; i++) {
>                 vq =3D vcrypto->data_vq[i].vq;
> -               while ((vc_req =3D virtqueue_detach_unused_buf(vq)) !=3D =
NULL) {
> -                       kfree(vc_req->req_data);
> -                       kfree(vc_req->sgs);
> -               }
> +               while ((vc_req =3D virtqueue_detach_unused_buf(vq)) !=3D =
NULL)
> +                       virtcrypto_clear_request(vc_req);
>                 cond_resched();
>         }
>  }
> --
> 2.48.1
>
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


