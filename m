Return-Path: <linux-kernel+bounces-543089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9120A4D153
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 03:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43BF93A7956
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8E113D893;
	Tue,  4 Mar 2025 02:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GiGQb/5+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D23ABA53
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 02:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741053616; cv=none; b=Kos3vXd9KdtapmBvcL88P3ytZLwXbtjgAG3uHDMiYCz9KjSIBeKPF2afnGtFivtI2uWyqdz4/ohM1H1JOKHWJrtWFClhjcIAwj5A/1QlM1kzAjxAn4e3VQkYsPbjCu9AsCswyNNYjEaV6+8FPldB9KEajbpyHp/4kni2IeNIMyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741053616; c=relaxed/simple;
	bh=JHk4X3vZ8MFvsUzR7DvpEVGisQVp8HYBRZBRGMOySDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FHuHgamgOl8IkWaVyVBBduWKpFk4zIiGyg5uH45RTjchmf5hL3hL+MKd8eSbb6N8uBZ1sznWmuwmEPEKKjTu2B04qNeHxC+C/AHDOkKlPBwqaZ4N7vzDrlyTC5ONWAJBnuD3x3sWwXEvKTBX8B26JkhdV52KyRFQJpirM2lGopw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GiGQb/5+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741053613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m6ne55QwhftFYTm3pAMElTqpEZ/LORaNN0Mq/z5tJ9c=;
	b=GiGQb/5+YbGm9ExIwL54VEldW3Ys9tmLH2tdWxcc+EXKF7lIxr3U6PF6ASTqosC/ztlLfq
	audcAErhXuiCNEP73MNr6X5JRN7UrHAngnUGmchGS/SOPzcdKEUBlO1NITngwxXbMLtJLy
	f/dSdV4EO9mZec+F+6pe5Mme8kyYE1c=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-xer7p6iGPcCI7jL5CDto5A-1; Mon, 03 Mar 2025 21:00:11 -0500
X-MC-Unique: xer7p6iGPcCI7jL5CDto5A-1
X-Mimecast-MFC-AGG-ID: xer7p6iGPcCI7jL5CDto5A_1741053611
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5e54335bf7fso2051632a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 18:00:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741053611; x=1741658411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6ne55QwhftFYTm3pAMElTqpEZ/LORaNN0Mq/z5tJ9c=;
        b=W1PMH/y61mNN9PxCrhydhf2Exj74mADcWr4EtIGHPqDy6JKfJzFe8u63azzJpsn790
         68GJr7Qo8NCqYT0lRk4TBAjMMo4FFF7PE5bdDcQAWoxYkZ3DWf4bV91a+DUL5UtBENqP
         ZWWI6lnHHxPGEldZD0duLSUZoVot1GySuxETmVTSqaAXC9kvmqt6btHyeAZoGrlwEY94
         no9g+TfrEyqvWxyOFIV/AWpL+a7BUlPphxQYER7JTBL2BL9El1LVHc5uYz9r5Av7N0Ig
         v0ZUEcZM5j79sJIpXTAkOQBNQ28cQsqTc6X8rrIesB61UVk6prtHfu9xeat5651ZPIXp
         Xirw==
X-Forwarded-Encrypted: i=1; AJvYcCWJ45KfB1uzY1pXNNhAoEbF/asXMwMXht/h+A8JgVPlXYLjrelRqvSZIqFSDdaTE+MRkirL0aAhld/5vKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw540ReE0bHO+ayemW0OTOYPSEScuz/AFay6j26+JXl/SzAH+E0
	4x/nPLILx9HKvSqu2JWppFJe8+Cce/3EigezOY+kshaquNe8BHdLyhPcvL/AnYg0d5QhMGm0KXM
	LxCxTOl2QIVpuCoQUxEtIQA5OVsJyLP6FITgwm/55SKsa7YrJwZfG+nWtJe1opOYFdQHMaqFNYG
	KTy6k7xN9BoC1SiRfRFNeqTLMYHopWNGGtQyEc
X-Gm-Gg: ASbGncuXP13/aTvkZvOFjYzZsY/rlXW0ASGLqMlEGqgxQeBKeSVswXcmuevgm1hdUB9
	PjMiQoxT1zJj0vIdf/pHsN22Yq3jlLOGSGI/iBdssMPBhPhqhSE+J7X6Zp0PAydidmQH1Ng+LNg
	==
X-Received: by 2002:a05:6402:2714:b0:5e0:922e:527a with SMTP id 4fb4d7f45d1cf-5e4d6908f02mr43147292a12.0.1741053610612;
        Mon, 03 Mar 2025 18:00:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGotofsTvb2AxtGxiUYRTOJP55UijhwSHRdhPuwJsFglP+Wr3zMaapIUvoTk6CdgEnWdU6MOBQ50VkHbyyuLfo=
X-Received: by 2002:a05:6402:2714:b0:5e0:922e:527a with SMTP id
 4fb4d7f45d1cf-5e4d6908f02mr43147246a12.0.1741053610281; Mon, 03 Mar 2025
 18:00:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a18fc6cf356bc338c69b3cc44d7be8bd35c6d7d0.1741028854.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <a18fc6cf356bc338c69b3cc44d7be8bd35c6d7d0.1741028854.git.christophe.jaillet@wanadoo.fr>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 4 Mar 2025 09:59:33 +0800
X-Gm-Features: AQ5f1Jqo2O4hK3oJkjenR9LxQveC5GRpuyXs2Lm3CfD0L_mhdi24D2upTktGsNA
Message-ID: <CAPpAL=wW6szqfPm8goUfM=c2cat9-tyuB-UgwRdtx7s23xe81g@mail.gmail.com>
Subject: Re: [PATCH] crypto: virtio - Erase some sensitive memory when it is freed
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Gonglei <arei.gonglei@huawei.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

QE tested this patch with virtio-net regression tests, everything works fin=
e.

Tested-by: Lei Yang <leiyang@redhat.com>

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


