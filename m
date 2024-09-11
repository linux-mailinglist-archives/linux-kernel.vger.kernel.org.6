Return-Path: <linux-kernel+bounces-324393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E8F974BF8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93A441C25C81
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2060D558BB;
	Wed, 11 Sep 2024 08:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aqYaD6S+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1486443144
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726041685; cv=none; b=ouc2pIIN9ocwhqMsjg2lbdQaO6fW0R+Rum1T7GQQsaHk0Mf1/+dh75/4RhAZroVfXuwNgORF3XjFiFsGPYkBLFbIYLsXrphl4FPUy2hhsbajnyi1LGZUp4ZFATLFDGSFZLVKdAxN6iOcmQ3adKZnMr88EnwofUN65eJdRL88t/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726041685; c=relaxed/simple;
	bh=S7YFPOr47KnzpX+EfvhDAL9kUueFzGcx6/bEZmJEe1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VtUTJqfXgwFHjiyUvlUy9bb+CdJ9wJbds8g/0pisTiUg1CN1Q2dO9PGmZ93906rrjj6MOwBiAeVkAzswltJ7LkCPN/9BUJ/N6qMiKadKcn+15TitzgkqnHLheKpJIfe9MOAgXEug7OfAaFpxVS693bI+A5ovRPB58qqyXCYRfGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aqYaD6S+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726041681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S7YFPOr47KnzpX+EfvhDAL9kUueFzGcx6/bEZmJEe1U=;
	b=aqYaD6S+mMFk6vP2IFPcNZvdjVWtp2RMlujHgZZk0bCRA3KKnOJH4h79cXji4onl3oZk46
	ey5jjC8Q1/FoJH3t3k0NtGScnpY5bkDwzhlUmBIYFhK4Iqlhb6NT/sPqkQ16DH8Nkuijnb
	4+FC7MX5HWg8gTZk8vij4GwFEiQwlSE=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-WMeAjus1OYKTMxmNTJxQqQ-1; Wed, 11 Sep 2024 04:01:20 -0400
X-MC-Unique: WMeAjus1OYKTMxmNTJxQqQ-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-6d9e31e66eeso222851307b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 01:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726041680; x=1726646480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7YFPOr47KnzpX+EfvhDAL9kUueFzGcx6/bEZmJEe1U=;
        b=aIXifVk22+Zwzh/W8RpT78C3Sx8vtqv/8qAo8hwQdQztUIWZ1M+eo+bAovzwiCl8FX
         T59VTPOG8h2U8/53sE3IJkbv95fn0Iwvw+8OOmlzS2joYtjuADYhRBHTZ7w9vOpQ0dF1
         X9MJVrjd1+933kuZz9guaMGDibSyxsi1ANV7pxiuOGEuk0Wp7CehLIEQLGXWeFOCKaES
         e+h8A6w6p0cx6X3FvOlQi1DYo9jSgFZ8W+Oe5c4L00KrNeMUpkNclscxTsNpDucz55+g
         VrZtWYVe0AQuiAH1F+szTJcPNst4r1zsqy2iJc640Rx9X6FlczF5zjPoyATpfjwdGYJB
         clzg==
X-Forwarded-Encrypted: i=1; AJvYcCW411QQvrVM+kbkjRprfIXxAQpAkzylHVgGOXUfaec0KWg5ILVsEOJ7WiqsuHxjQnmgkEJoQ/J0cDEoXoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcrsv8u+WGaXo8L5sD9OSRG7/jdGvdZ1dr04UCVDS4+iXadgPU
	Yup05PGtoUCmu7piVOj/uQnt0UBt2PA9AL0E0Aav+M2K5NoGeFGYsWWR3umTZxaZPEFdtPpYTG+
	53qoEPzL1OyDG/3Q1G2Kq7Txq6uQ4E5cRepwammRnb5u0j8elkQDf1l634OgUiP3jg9mPUszdak
	nl7uHSSq7tWMchO0Ys/G/jH6iRYu6+n8X5yUlT
X-Received: by 2002:a05:690c:6512:b0:64a:3e36:7fd1 with SMTP id 00721157ae682-6db44d9e360mr200120217b3.10.1726041680280;
        Wed, 11 Sep 2024 01:01:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGycL15wVUOnoLYy7HKMCqM5sIYCNMn+FEaCTz3f8kQpDk/ygjQU73LezZOKgf3VnEGDHaAdRqQdFmHRUiFMw=
X-Received: by 2002:a05:690c:6512:b0:64a:3e36:7fd1 with SMTP id
 00721157ae682-6db44d9e360mr200119947b3.10.1726041679985; Wed, 11 Sep 2024
 01:01:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816090159.1967650-1-dtatulea@nvidia.com> <20240816090159.1967650-2-dtatulea@nvidia.com>
 <c59afb55-78b1-48b3-bafa-646b8499bf1c@nvidia.com>
In-Reply-To: <c59afb55-78b1-48b3-bafa-646b8499bf1c@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 11 Sep 2024 10:00:44 +0200
Message-ID: <CAJaqyWcEt7=3j2uoToZH=no-gPvRsXwW7RLtFcbD7_-nQ0Dqyw@mail.gmail.com>
Subject: Re: [PATCH mlx5-vhost v2 01/10] net/mlx5: Support throttled commands
 from async API
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	virtualization@lists.linux-foundation.org, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 11:33=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
>
>
> On 16.08.24 11:01, Dragos Tatulea wrote:
> > Currently, commands that qualify as throttled can't be used via the
> > async API. That's due to the fact that the throttle semaphore can sleep
> > but the async API can't.
> >
> > This patch allows throttling in the async API by using the tentative
> > variant of the semaphore and upon failure (semaphore at 0) returns EBUS=
Y
> > to signal to the caller that they need to wait for the completion of
> > previously issued commands.
> >
> > Furthermore, make sure that the semaphore is released in the callback.
> >
> > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > Cc: Leon Romanovsky <leonro@nvidia.com>
> > Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Same reminder as in v1: Tariq is the maintainer for mlx5 so his review
> also counts as Acked-by.
>

Not sure if it was the case when you send the mail, but this series is
already in the maintainer's branch:
* https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/
* https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/commit/?h=
=3Dvhost&id=3D691fd851e1bc8ec043798e1ab337305e6291cd6b

Thanks!


