Return-Path: <linux-kernel+bounces-518830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD6CA3951C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 298651899E4F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF852417D7;
	Tue, 18 Feb 2025 08:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhRxyWMa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B057E24111C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 08:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866528; cv=none; b=C+LFaWdwmRdemuqucMiuitnyooK3vK0VAkBI66TWnFlBqym8T2sTlYke4yG6gFmS39BduVZ48EpUKPLcYRQoElCvWHL4oSHEoaX2DvZrh7Uu301SUq1ihCi8eoPL/pkOig/iDeXEUVcI5K7e2K+X/Arr7bBUIopnzB63UqcImWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866528; c=relaxed/simple;
	bh=4d7dH4tkF8IEZWbA351ohEadRAb/aWdFd9TsfF1l29s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i3kslu8qQJ4DUkn8229S305UE1AKKlxRu9hpDvuROL9w+UJpJtpZHAZjQE+0mc8Kpt3IMH+C3RBaDi1cVgAlurYHH5CSC0s4eAVxQo2kap4oGrQUiNrMx3iRT7l1XN+DyV09yDLK1Z/YjYw8MA0FQykgX5shA69cFihFbWWiAm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RhRxyWMa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739866524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j7GHXQVLFtRp3ANseK6eUERZ/mhzkiAQmFxjXulM8Zo=;
	b=RhRxyWMaM65FtzQrxLUok/49M8x1YzGhY2bZ4OQYRzY5Nfj2kHctyfRtICRj9A/aSwdWVE
	yotv4SjV6ysjMlpX7d8Kol+Nd+ekePO5Xt/frt2GgIG0srLVhxBdKzLbr25zHwDQINdb/Y
	ZjPNr/L/5/Uq+Ag/ilQ14otQc+gzCio=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167--_okUePiPFqwvoJH35MK9w-1; Tue, 18 Feb 2025 03:15:20 -0500
X-MC-Unique: -_okUePiPFqwvoJH35MK9w-1
X-Mimecast-MFC-AGG-ID: -_okUePiPFqwvoJH35MK9w_1739866520
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fc2e648da3so7536547a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 00:15:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739866520; x=1740471320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7GHXQVLFtRp3ANseK6eUERZ/mhzkiAQmFxjXulM8Zo=;
        b=LC71bc3N8hrsVvs4NWEjZxxNkDkBskgI1ngsG3WvrfoZ7GKDD4dnKu78lJIvI+YJOT
         1gd06VSOj8QseSHzWNjH7ZWX1qWorX7WEQsJOhcH9zNqph8fcG+tf9SkNuLU3X9M4C9w
         eW1tbVCE0ghye5OWSTNufkei3tPV9oFyv5iLNyIQW0Y7caZHap0Hlqig7z6lhJjgFoRN
         DacN5MKklc/EfoSSdMB1tahkFKb7mjKeJauD3Xj7LxUtV9QsTQbzYmKL+UyXoGDRH+Y+
         ctXv/KiWZvoOHNfs1A/tD7ZFHXITGsxfh9xE4gZaR8FwosL6m8z1Olx8FdCO5r3LHhQf
         b1TA==
X-Forwarded-Encrypted: i=1; AJvYcCV+fJwss7oVZ56egxSSVFQUNQaWbkhn6HdKCUN1UiSR6+ZkVxSaJ1djezmrwhB67QvjgGKOUriyvmFEHTk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjpj6FXhIW0fN/NKDzQ0GpnBKj8vmTP8y+fv+UZO6J2Y9q+CsZ
	lstjtisG4Xn+MontlweVj9AhERjiPCUU/0SqiezlIBbGIj5XriGEomffwfOwVOXgP3Ua76D44W+
	ZUOegzSZc/TCxnJSrfbu6G0NY4JO1E7Jvfcvo1IyY/sid81Y2drVK8wJqzb9z2QqRYgYcKa+DD1
	W3BxrgrLkWK+RdKcffkKAqouX3AQGTxE4jrSYA
X-Gm-Gg: ASbGncvFMhHKoVPrbegNA9Ly+xi1Xl+KeJuMswXovOU58UgEP7ls15TaLnY9XFEsHpl
	JA5HRmHUr+C7Pgp1lFgxR/Sn5MstWzVSpsGJrf0KszKZrGde+O6RHlzrDzEqH
X-Received: by 2002:a17:90b:4a81:b0:2f6:539:3cd8 with SMTP id 98e67ed59e1d1-2fc40f22d0fmr23359644a91.18.1739866519778;
        Tue, 18 Feb 2025 00:15:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8sG5MmJpDjalMTr/uoLqJmCBZKgB65yw39zpNwpvQ/c1ljw+ptNbDRRyVCRGv34rDLEx/rjtyse/nlYZVsWo=
X-Received: by 2002:a17:90b:4a81:b0:2f6:539:3cd8 with SMTP id
 98e67ed59e1d1-2fc40f22d0fmr23359607a91.18.1739866519456; Tue, 18 Feb 2025
 00:15:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217194443.145601-1-dtatulea@nvidia.com>
In-Reply-To: <20250217194443.145601-1-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 18 Feb 2025 09:14:43 +0100
X-Gm-Features: AWEUYZlSb2AcHmrjElPSu3z2kApA0bfKQBoGNMw34RhkdhIFFmh1ojpHP4uAaK8
Message-ID: <CAJaqyWcXcW9U7a1bMAngG-eEjw6t5T3XPUdn_hai5OWWTQW85Q@mail.gmail.com>
Subject: Re: [PATCH vhost] vdpa/mlx5: Fix oversized null mkey longer than 32bit
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Jason Wang <jasowang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 8:45=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> From: Si-Wei Liu <si-wei.liu@oracle.com>
>
> create_user_mr() has correct code to count the number of null keys
> used to fill in a hole for the memory map. However, fill_indir()
> does not follow the same to cap the range up to the 1GB limit
> correspondinly.

s/correspondinly/correspondingly/g

Sounds to me the logic can be merged in a helper?

Either way,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> Fill in more null keys for the gaps in between,
> so that null keys are correctly populated.
>
> Fixes: 94abbccdf291 ("vdpa/mlx5: Add shared memory registration code")
> Cc: stable@vger.kernel.org
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  drivers/vdpa/mlx5/core/mr.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index 8455f08f5d40..61424342c096 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -190,9 +190,12 @@ static void fill_indir(struct mlx5_vdpa_dev *mvdev, =
struct mlx5_vdpa_mr *mkey, v
>                         klm->bcount =3D cpu_to_be32(klm_bcount(dmr->end -=
 dmr->start));
>                         preve =3D dmr->end;
>                 } else {
> +                       u64 bcount =3D min_t(u64, dmr->start - preve, MAX=
_KLM_SIZE);
> +
>                         klm->key =3D cpu_to_be32(mvdev->res.null_mkey);
> -                       klm->bcount =3D cpu_to_be32(klm_bcount(dmr->start=
 - preve));
> -                       preve =3D dmr->start;
> +                       klm->bcount =3D cpu_to_be32(klm_bcount(bcount));
> +                       preve +=3D bcount;
> +
>                         goto again;
>                 }
>         }
> --
> 2.43.0
>


