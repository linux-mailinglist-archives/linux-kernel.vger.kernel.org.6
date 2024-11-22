Return-Path: <linux-kernel+bounces-417698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 719D39D5810
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 03:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01FF91F21833
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 02:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3946D22081;
	Fri, 22 Nov 2024 02:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="erFwWL0C"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B676FC5
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 02:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732241181; cv=none; b=OeqWCE9bZs2knrqmnOaW/c3tWTjKp0et2fecgtJCwP/Qqh7Qbht6WVevk3ZuJhox6pSaJMln80e5DPdo9Iwt9NQyJk+tH3l4raXQEb1bJtztC7uiEKq2WYzy5LQx3UvviZM26t7qStUA6TsHRyKaNBFoUjc+zWF5JYivw7vP9HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732241181; c=relaxed/simple;
	bh=RhaE8shKTZPO6JzquCVDpgNpGWbAmzG4HsdolIvuEHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b8VKozwRLS0SFLHT0k8+ozk4tw4xZY1U1Heuu1eG5h6HQ6JJujN5dt/W2K6oVYlEVO8EIDEbHQ+DaMrk2JPbt1cs7VH0ffKTz8omOAcILX657QgBTl4t4P5pxm+wLixHcFOss70Yn5PB/ySNB+hJAIw9MMmwenTkwFnVP1vv1yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=erFwWL0C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732241177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W9s0+G3dL1tHGqlXD2xX4tdZnShrB90gx3dMfXbojDk=;
	b=erFwWL0CPo/+ANut8qs0PjND7VJaNUCXfVWUbe19qJw9Ut1Q/F/52elWcOVAYyrY4+tyWZ
	vWU9WqpHIwoAl/QfN1SbKvLxXxBslHRqizsZtCvFtMHYJHUwuORldqBT3W7psobFlxeORy
	2PpbvGRstrmp0XR6/lmu1mxHl7VSkLg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-4rplVb36OSKBNB-pzr8nwA-1; Thu, 21 Nov 2024 21:06:14 -0500
X-MC-Unique: 4rplVb36OSKBNB-pzr8nwA-1
X-Mimecast-MFC-AGG-ID: 4rplVb36OSKBNB-pzr8nwA
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-53dd08f5299so665888e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:06:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732241173; x=1732845973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9s0+G3dL1tHGqlXD2xX4tdZnShrB90gx3dMfXbojDk=;
        b=Ti7yTTBueRBS0LmstwcJqavUzEpPilw5yUl7hODxyv/xQGC15PCnO7bsbH8GMSN5Sq
         Lp3Vh2bdI2g4LFVqX9hnRiqfJFnnXJcoFF3NJ7VgZT5UqRVPJ3n3ssBaTh0kh+ZAhRu5
         uM2811mmX33KI5eMHbkt+i1tyEHGdDYVsM+guyS6xR3NB9OC5EW1RFuUfS76yqPuhW58
         QmHXBOLBvS+VHFHrSRqjKbcDnzd7cshcCrYHDRxiAh4upEsrfa96vgV1SNTgSTXrOMkJ
         wG8e2+rFmMQsXbTIAAtBhvJor+NoRk//tLtL5OAu8lK+DSUridBUlsWJQML29MTBwdsI
         8XQA==
X-Forwarded-Encrypted: i=1; AJvYcCXMEjRGyRSI1SJ05V/7/0NHNPcpNQY7lx0olJCGKNLG3OjAeHJVI6xdKUJ/oIRpN6nIL6Dt14aBnqpjFgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnTfYcd7QHILa/GIR0PPMW++5E8VeTztNfqoumXmmPOJ3iIqMp
	zQBn2Q5+T9AyBKxSimqdcZpZs95fnIbSa5SbUwtWNZv+MlKgCWRMeOeOGTFWGhpDrhVgh3vKO8w
	V8MOG9ID6JsI13Vgfg0R6Vc9BE/cA9G9QeGXHYc7Vl57BnUxcj57MIuucoxQA5emm/MjAR+Dj4u
	kgX+S4PXrHw/p6D/+QMOxkc2ZSBIdyXMCrmk6P
X-Gm-Gg: ASbGncsXKPbfICFx1jTyimEW8RZ31cX0woaikhmlOEm1i/MAugrVQ30oD5VXDJGtaXG
	no84PUMqzJm7oCra4/DDyDoNa3YLgM75e
X-Received: by 2002:a05:6512:230b:b0:53d:cb8e:5204 with SMTP id 2adb3069b0e04-53dd39b51c3mr408202e87.51.1732241172684;
        Thu, 21 Nov 2024 18:06:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUuGjgYLaGtXG6zZVga1OmcViNS6Hyrc6j1t1v2X5r08l+4FK+qeatP/uu/WByBoQg+OqWVODMGtxng8oZBmA=
X-Received: by 2002:a05:6512:230b:b0:53d:cb8e:5204 with SMTP id
 2adb3069b0e04-53dd39b51c3mr408195e87.51.1732241172242; Thu, 21 Nov 2024
 18:06:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118114157.355749-1-yukuai1@huaweicloud.com> <20241118114157.355749-6-yukuai1@huaweicloud.com>
In-Reply-To: <20241118114157.355749-6-yukuai1@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Fri, 22 Nov 2024 10:06:00 +0800
Message-ID: <CALTww28JrdXoNXQNPxx2Sg9L2iL20jZZ80Y-qZzqcyF780M1fg@mail.gmail.com>
Subject: Re: [PATCH md-6.13 5/5] md/md-bitmap: move bitmap_{start, end}write
 to md upper layer
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: song@kernel.org, linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 7:44=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> There are two BUG reports that raid5 will hang at
> bitmap_startwrite([1],[2]), root cause is that bitmap start write and end
> write is unbalanced, and while reviewing raid5 code, it's found that

Hi Kuai

It's better to describe more about "unbalanced" in the patch. For
raid5, bitmap is set and cleared based on stripe->dev[] now. It looks
like the set operation matches the clear operation already.

> bitmap operations can be optimized. For example, for a 4 disks raid5, wit=
h
> chunksize=3D8k, if user issue a IO (0 + 48k) to the array:
>
> =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=90
> =E2=94=82chunk 0                                                     =E2=
=94=82
> =E2=94=82      =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC
> =E2=94=82  sh0 =E2=94=82A0: 0 + 4k  =E2=94=82A1: 8k + 4k  =E2=94=82A2: 16=
k + 4k =E2=94=82A3: P       =E2=94=82
> =E2=94=82      =E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC
> =E2=94=82  sh1 =E2=94=82B0: 4k + 4k =E2=94=82B1: 12k + 4k =E2=94=82B2: 20=
k + 4k =E2=94=82B3: P       =E2=94=82
> =E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=BC
> =E2=94=82chunk 1                                                     =E2=
=94=82
> =E2=94=82      =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
> =E2=94=82  sh2 =E2=94=82C0: 24k + 4k=E2=94=82C1: 32k + 4k =E2=94=82C2: P =
       =E2=94=82C3: 40k + 4k=E2=94=82
> =E2=94=82      =E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC
> =E2=94=82  sh3 =E2=94=82D0: 28k + 4k=E2=94=82D1: 36k + 4k =E2=94=82D2: P =
       =E2=94=82D3: 44k + 4k=E2=94=82
> =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=98
>
> Before this patch, 4 stripe head will be used, and each sh will attach
> bio for 3 disks, and each attached bio will trigger
> bitmap_startwrite() once, which means total 12 times.
>  - 3 times (0 + 4k), for (A0, A1 and A2)
>  - 3 times (4 + 4k), for (B0, B1 and B2)
>  - 3 times (8 + 4k), for (C0, C1 and C3)
>  - 3 times (12 + 4k), for (D0, D1 and D3)
>
> After this patch, md upper layer will calculate that IO range (0 + 48k)
> is corresponding to the bitmap (0 + 16k), and call bitmap_startwrite()
> just once.
>
> Noted that this patch will align bitmap ranges to the chunks, for example=
,
> if user issue a IO (0 + 4k) to array:
>
> - Before this patch, 1 time (0 + 4k), for A0;
> - After this patch, 1 time (0 + 8k) for chunk 0;
>
> Usually, one bitmap bit will represent more than one disk chunk, and this
> doesn't have any difference. And even if user really created a array
> that one chunk contain multiple bits, the overhead is that more data
> will be recovered after power failure.
>
> [1] https://lore.kernel.org/all/CAJpMwyjmHQLvm6zg1cmQErttNNQPDAAXPKM3xgTj=
Mhbfts986Q@mail.gmail.com/
> [2] https://lore.kernel.org/all/ADF7D720-5764-4AF3-B68E-1845988737AA@flyi=
ngcircus.io/
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md.c          | 29 +++++++++++++++++++++++++++++
>  drivers/md/md.h          |  2 ++
>  drivers/md/raid1.c       |  4 ----
>  drivers/md/raid10.c      |  3 ---
>  drivers/md/raid5-cache.c |  2 --
>  drivers/md/raid5.c       | 24 +-----------------------
>  6 files changed, 32 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index bbe002ebd584..ab37c9939ac6 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -8723,12 +8723,32 @@ void md_submit_discard_bio(struct mddev *mddev, s=
truct md_rdev *rdev,
>  }
>  EXPORT_SYMBOL_GPL(md_submit_discard_bio);
>
> +static void md_bitmap_start(struct mddev *mddev,
> +                           struct md_io_clone *md_io_clone)
> +{
> +       if (mddev->pers->bitmap_sector)
> +               mddev->pers->bitmap_sector(mddev, &md_io_clone->offset,
> +                                          &md_io_clone->sectors);
> +
> +       mddev->bitmap_ops->startwrite(mddev, md_io_clone->offset,
> +                                     md_io_clone->sectors);
> +}
> +
> +static void md_bitmap_end(struct mddev *mddev, struct md_io_clone *md_io=
_clone)
> +{
> +       mddev->bitmap_ops->endwrite(mddev, md_io_clone->offset,
> +                                   md_io_clone->sectors);
> +}
> +
>  static void md_end_clone_io(struct bio *bio)
>  {
>         struct md_io_clone *md_io_clone =3D bio->bi_private;
>         struct bio *orig_bio =3D md_io_clone->orig_bio;
>         struct mddev *mddev =3D md_io_clone->mddev;
>
> +       if (bio_data_dir(orig_bio) =3D=3D WRITE && mddev->bitmap)
> +               md_bitmap_end(mddev, md_io_clone);
> +
>         if (bio->bi_status && !orig_bio->bi_status)
>                 orig_bio->bi_status =3D bio->bi_status;
>
> @@ -8753,6 +8773,12 @@ static void md_clone_bio(struct mddev *mddev, stru=
ct bio **bio)
>         if (blk_queue_io_stat(bdev->bd_disk->queue))
>                 md_io_clone->start_time =3D bio_start_io_acct(*bio);
>
> +       if (bio_data_dir(*bio) =3D=3D WRITE && mddev->bitmap) {
> +               md_io_clone->offset =3D (*bio)->bi_iter.bi_sector;
> +               md_io_clone->sectors =3D bio_sectors(*bio);
> +               md_bitmap_start(mddev, md_io_clone);
> +       }
> +
>         clone->bi_end_io =3D md_end_clone_io;
>         clone->bi_private =3D md_io_clone;
>         *bio =3D clone;
> @@ -8771,6 +8797,9 @@ void md_free_cloned_bio(struct bio *bio)
>         struct bio *orig_bio =3D md_io_clone->orig_bio;
>         struct mddev *mddev =3D md_io_clone->mddev;
>
> +       if (bio_data_dir(orig_bio) =3D=3D WRITE && mddev->bitmap)
> +               md_bitmap_end(mddev, md_io_clone);
> +
>         if (bio->bi_status && !orig_bio->bi_status)
>                 orig_bio->bi_status =3D bio->bi_status;
>
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index de6dadb9a40b..def808064ad8 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -831,6 +831,8 @@ struct md_io_clone {
>         struct mddev    *mddev;
>         struct bio      *orig_bio;
>         unsigned long   start_time;
> +       sector_t        offset;
> +       unsigned long   sectors;
>         struct bio      bio_clone;
>  };
>
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index b9819f9c8ed2..e2adfeff5ae6 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -422,8 +422,6 @@ static void close_write(struct r1bio *r1_bio)
>
>         if (test_bit(R1BIO_BehindIO, &r1_bio->state))
>                 mddev->bitmap_ops->end_behind_write(mddev);
> -       /* clear the bitmap if all writes complete successfully */
> -       mddev->bitmap_ops->endwrite(mddev, r1_bio->sector, r1_bio->sector=
s);
>         md_write_end(mddev);
>  }
>
> @@ -1616,8 +1614,6 @@ static void raid1_write_request(struct mddev *mddev=
, struct bio *bio,
>
>                         if (test_bit(R1BIO_BehindIO, &r1_bio->state))
>                                 mddev->bitmap_ops->start_behind_write(mdd=
ev);
> -                       mddev->bitmap_ops->startwrite(mddev, r1_bio->sect=
or,
> -                                                     r1_bio->sectors);
>                         first_clone =3D 0;
>                 }
>
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index efbc0bd92479..79a209236c9f 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -428,8 +428,6 @@ static void close_write(struct r10bio *r10_bio)
>  {
>         struct mddev *mddev =3D r10_bio->mddev;
>
> -       /* clear the bitmap if all writes complete successfully */
> -       mddev->bitmap_ops->endwrite(mddev, r10_bio->sector, r10_bio->sect=
ors);
>         md_write_end(mddev);
>  }
>
> @@ -1487,7 +1485,6 @@ static void raid10_write_request(struct mddev *mdde=
v, struct bio *bio,
>         md_account_bio(mddev, &bio);
>         r10_bio->master_bio =3D bio;
>         atomic_set(&r10_bio->remaining, 1);
> -       mddev->bitmap_ops->startwrite(mddev, r10_bio->sector, r10_bio->se=
ctors);
>
>         for (i =3D 0; i < conf->copies; i++) {
>                 if (r10_bio->devs[i].bio)
> diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
> index ba4f9577c737..011246e16a99 100644
> --- a/drivers/md/raid5-cache.c
> +++ b/drivers/md/raid5-cache.c
> @@ -313,8 +313,6 @@ void r5c_handle_cached_data_endio(struct r5conf *conf=
,
>                 if (sh->dev[i].written) {
>                         set_bit(R5_UPTODATE, &sh->dev[i].flags);
>                         r5c_return_dev_pending_writes(conf, &sh->dev[i]);
> -                       conf->mddev->bitmap_ops->endwrite(conf->mddev,
> -                                       sh->sector, RAID5_STRIPE_SECTORS(=
conf));
>                 }
>         }
>  }
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 95caed41654c..976788138a6e 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -3578,12 +3578,6 @@ static void __add_stripe_bio(struct stripe_head *s=
h, struct bio *bi,
>                  * is added to a batch, STRIPE_BIT_DELAY cannot be change=
d
>                  * any more.
>                  */
> -               set_bit(STRIPE_BITMAP_PENDING, &sh->state);
> -               spin_unlock_irq(&sh->stripe_lock);
> -               conf->mddev->bitmap_ops->startwrite(conf->mddev, sh->sect=
or,
> -                                       RAID5_STRIPE_SECTORS(conf));
> -               spin_lock_irq(&sh->stripe_lock);
> -               clear_bit(STRIPE_BITMAP_PENDING, &sh->state);
>                 if (!sh->batch_head) {
>                         sh->bm_seq =3D conf->seq_flush+1;
>                         set_bit(STRIPE_BIT_DELAY, &sh->state);
> @@ -3638,7 +3632,6 @@ handle_failed_stripe(struct r5conf *conf, struct st=
ripe_head *sh,
>         BUG_ON(sh->batch_head);
>         for (i =3D disks; i--; ) {
>                 struct bio *bi;
> -               int bitmap_end =3D 0;
>
>                 if (test_bit(R5_ReadError, &sh->dev[i].flags)) {
>                         struct md_rdev *rdev =3D conf->disks[i].rdev;
> @@ -3663,8 +3656,6 @@ handle_failed_stripe(struct r5conf *conf, struct st=
ripe_head *sh,
>                 sh->dev[i].towrite =3D NULL;
>                 sh->overwrite_disks =3D 0;
>                 spin_unlock_irq(&sh->stripe_lock);
> -               if (bi)
> -                       bitmap_end =3D 1;
>
>                 log_stripe_write_finished(sh);
>
> @@ -3679,10 +3670,6 @@ handle_failed_stripe(struct r5conf *conf, struct s=
tripe_head *sh,
>                         bio_io_error(bi);
>                         bi =3D nextbi;
>                 }
> -               if (bitmap_end)
> -                       conf->mddev->bitmap_ops->endwrite(conf->mddev,
> -                                       sh->sector, RAID5_STRIPE_SECTORS(=
conf));
> -               bitmap_end =3D 0;
>                 /* and fail all 'written' */
>                 bi =3D sh->dev[i].written;
>                 sh->dev[i].written =3D NULL;
> @@ -3691,7 +3678,6 @@ handle_failed_stripe(struct r5conf *conf, struct st=
ripe_head *sh,
>                         sh->dev[i].page =3D sh->dev[i].orig_page;
>                 }
>
> -               if (bi) bitmap_end =3D 1;
>                 while (bi && bi->bi_iter.bi_sector <
>                        sh->dev[i].sector + RAID5_STRIPE_SECTORS(conf)) {
>                         struct bio *bi2 =3D r5_next_bio(conf, bi, sh->dev=
[i].sector);
> @@ -3725,9 +3711,6 @@ handle_failed_stripe(struct r5conf *conf, struct st=
ripe_head *sh,
>                                 bi =3D nextbi;
>                         }
>                 }
> -               if (bitmap_end)
> -                       conf->mddev->bitmap_ops->endwrite(conf->mddev,
> -                                       sh->sector, RAID5_STRIPE_SECTORS(=
conf));
>                 /* If we were in the middle of a write the parity block m=
ight
>                  * still be locked - so just clear all R5_LOCKED flags
>                  */
> @@ -4076,8 +4059,7 @@ static void handle_stripe_clean_event(struct r5conf=
 *conf,
>                                         bio_endio(wbi);
>                                         wbi =3D wbi2;
>                                 }
> -                               conf->mddev->bitmap_ops->endwrite(conf->m=
ddev,
> -                                       sh->sector, RAID5_STRIPE_SECTORS(=
conf));
> +
>                                 if (head_sh->batch_head) {
>                                         sh =3D list_first_entry(&sh->batc=
h_list,
>                                                               struct stri=
pe_head,
> @@ -5797,10 +5779,6 @@ static void make_discard_request(struct mddev *mdd=
ev, struct bio *bi)
>                 }
>                 spin_unlock_irq(&sh->stripe_lock);
>                 if (conf->mddev->bitmap) {
> -                       for (d =3D 0; d < conf->raid_disks - conf->max_de=
graded;
> -                            d++)
> -                               mddev->bitmap_ops->startwrite(mddev, sh->=
sector,
> -                                       RAID5_STRIPE_SECTORS(conf));
>                         sh->bm_seq =3D conf->seq_flush + 1;
>                         set_bit(STRIPE_BIT_DELAY, &sh->state);
>                 }
> --
> 2.39.2
>

This patch looks good to me.

Reviewd-by: Xiao Ni <xni@redhat.com>


