Return-Path: <linux-kernel+bounces-326823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE58976D69
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A87C1F244CC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC4F1BB6B7;
	Thu, 12 Sep 2024 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wt0ufvpF"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FF31B9B24
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726153948; cv=none; b=DB7A9HsjDmuytfUCl+XGnkLnEQ3335+J9/hRzpprDdevx+IrXvOQ8eIQOLV8Uvzz63Eb9mGmJCdvNZ5ON+axHsBu/BscnWgxEQUS85miDeneUFbbxOnALSlCcECEx1iri6XQVCDK3tRkX9sRN6dS4YYOMKssfRmzvZClMgD17Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726153948; c=relaxed/simple;
	bh=I2voFZcLWTdXlH0Xxt1X+l2lqmh24ceGysC1sOnKj2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IPn+V3IKW1EdEKIYSH2vUixKS7dDCIln5AZN69h8El/yxPFOAupzvP2NrPTNK0ZrDRu0DveBDvJr3R2ykhC6vO9wqLar7nWuAqfhsjMTfm4Bs8uYjDJrZnFNoHuDeOxMgNLkysqhZlHVhe0J++sv+/dNTQu7yHyWrlQnFbj12yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wt0ufvpF; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7d666fb3fb9so561930a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726153946; x=1726758746; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hornCASRPZxYyES6JkKYahDm/Amb2BvB/wmy3lSmhe8=;
        b=Wt0ufvpFa2MqQ9fp4BMIclNsuaj2ZNcTK4mNZdiifmP6RkOPj43DGKNt3K4JkBI8n9
         sOiZuuz09bbUxJ7wQm+Z798zX4/8qpZQiuHm7HyATA/MEGNxSaG6hE5yDOGwoC1L9r+N
         W0IF2QuU1kxS3E3IPYlMV4MyR6stZaUb85w8Grv9VO/eSw5az1WX3KA/Dwtc3aVbOZFq
         j2S7WE2dGOcT9FS1jaFVdDg9Q2EfUhVvNi5n+cENhFKM6sr7WQ5bpc2YjKD1y5nH2u4r
         SjhmUusMPxfy8v9AmcxJNQ7fpA+sActhsVkghCGIJSa6GlxkUn+0nvDM+DKfk7T/glEf
         joGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726153946; x=1726758746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hornCASRPZxYyES6JkKYahDm/Amb2BvB/wmy3lSmhe8=;
        b=DPDLZtOTx3Hz2fbwAcyw93uMW/+gDznZMLCJ3ANrmb96D/TDB8JTmPcFxPuV8raNML
         AKPAcka3fP5Zn6gqK86fQ0nmLfzW3bWNKfcNTpjY0+Td8subfKVNe7QuFOslUbNancPo
         OzTE1OffMnNML5528qK1yAp+cTOoa1VBOjxEz6osEfytkRP7phohmcAySOGENqgFxHR4
         BITiNPCMPj4ADQ18W2dPLMyIZAf5cXRtjf1ojz8eDrHBy9sxxOx1aIsDixo5TTYR1V9l
         wzn7qmJzSSW+GcMPxgRh+zhv6rx2rLDXgA8Yskb5sbRCUNKtA6nG5SEMBgFkDZ0JEZdB
         XBZw==
X-Gm-Message-State: AOJu0YxhGjHQXEDZLmck9NfFN3jHVXZy61dHnLOXvBmEmS24UrWbRxOB
	PAts3mcibb82Ze6/a3ZXMCZJK5+a1dNFHzpYiTKCvKMlmG6aLfiaJQVjymADMqWy0NQ0X1chBi+
	eNNvlsDVkS3DP9CL1BrSR9CwylmBnigbDnXPL
X-Google-Smtp-Source: AGHT+IFpigeOxXGsM9No1KNYNjI2xqYtkNJEQG1vrniLwX/lIuN2l+NdeRaljmmGR2d1QqRvBKl43C4rBl0OtQrx2rM=
X-Received: by 2002:a17:902:d2c8:b0:206:892c:b758 with SMTP id
 d9443c01a7336-2074c5ff323mr134718295ad.13.1726153945851; Thu, 12 Sep 2024
 08:12:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6bdd771a4fb7625a9227971b3cf4745c34c31a32.1726153334.git.mst@redhat.com>
In-Reply-To: <6bdd771a4fb7625a9227971b3cf4745c34c31a32.1726153334.git.mst@redhat.com>
From: Marco Elver <elver@google.com>
Date: Thu, 12 Sep 2024 17:11:43 +0200
Message-ID: <CANpmjNNU_-NCjN3qUm0-0_oDoO9TzbuO5zrLixA=M1=ON+5J7g@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_ring: tag event_triggered as racy for KCSAN
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
	syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Sept 2024 at 17:02, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Setting event_triggered from the interrupt handler
> is fundamentally racy. There are races of 2 types:
> 1. vq processing can read false value while interrupt
>    triggered and set it to true.
>    result will be a bit of extra work when disabling cbs, no big deal.
>
> 1. vq processing can set false value then interrupt
>    immediately sets true value
>    since interrupt then triggers a callback which will
>    process buffers, this is also not an issue.
>
> However, looks like KCSAN can not figure all this out, and warns about
> the race between the write and the read.  Tag the access data_racy for
> now.  We should probably look at ways to make this more
> straight-forwardly correct.
>
> Cc: Marco Elver <elver@google.com>
> Reported-by: syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Probably more conservative than the __data_racy hammer:

Acked-by: Marco Elver <elver@google.com>

> ---
>  drivers/virtio/virtio_ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index be7309b1e860..98374ed7c577 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2588,7 +2588,7 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
>
>         /* Just a hint for performance: so it's ok that this can be racy! */
>         if (vq->event)
> -               vq->event_triggered = true;
> +               data_race(vq->event_triggered = true);
>
>         pr_debug("virtqueue callback for %p (%p)\n", vq, vq->vq.callback);
>         if (vq->vq.callback)
> --
> MST
>

