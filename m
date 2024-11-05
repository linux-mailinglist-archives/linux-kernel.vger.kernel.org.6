Return-Path: <linux-kernel+bounces-396214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D549BC96C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9585B1C236D0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09ED71C8773;
	Tue,  5 Nov 2024 09:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ah4fEv1r"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8021CEAA0
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 09:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730799495; cv=none; b=W8XSVIZrU8CXrI5GOpIqpMRtdJvgQ+y/4tP0OEPxDY4jUlW4wFjT3UqzUGkOS62i0kiANcQxB1s49XEDIYt6zYpNxrdVU5eBzeFdeOmiqBI12DMUEXJUn81L/tZTqlwTK5J7/sPd+iNs+lnOCHKnjqCksMW8/KJhtveiWTlTfoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730799495; c=relaxed/simple;
	bh=4p4VWrO8uF1H+WyvXfit2++bNDgDMcVv1cZ3lUw+ww4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=otX9pWFuGlb6ThE5tMVv7irQ04p0risgpLt+DGZVawiNSn6rpKobK8WPb5otLpCQZcRZqi7LJKhwHxQjla3S9dqDFvnuk5jVR2M+voPQqoVmpKscMtu6JlvIgGUcM/qnWoK4vORZFdWqdKf/wrZ9HM84+UtYWJLRB/TrG+QbSP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ah4fEv1r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730799491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jt6NevPgsvI0U19HJM+9OIG7cBpWuW+de+wvjLoj4rw=;
	b=Ah4fEv1rc1QYDJaVjqBTxabdLvmlLdB9akincqbaE9kgucGFtnh8Zu5a3B0btHthCeAb2Q
	zNDIrWsoDMzpA6gO3f2UYbz6B2JZ2p8Gl32zaJv3YYZdVU6Jqm45SVf6t6J1Vb+ZRbjXwE
	wSzbNpI3OZ8zOEg93vgGT7Meacx4PqE=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-bJfU1E33PN-skILvwfUmYg-1; Tue, 05 Nov 2024 04:38:10 -0500
X-MC-Unique: bJfU1E33PN-skILvwfUmYg-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-7e6cc094c2fso4735514a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 01:38:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730799489; x=1731404289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jt6NevPgsvI0U19HJM+9OIG7cBpWuW+de+wvjLoj4rw=;
        b=i874w/ChXvW4J5lOM4yEQPbji/uFyx/yUB7rcfqDzXNejFJE7K9cS+jBzvYh2LKR09
         LyjoXSmxFn6UHNSC9EpCz+rd7fqiDTwfthugXwW1dN64fB3t1F8hqkPbtkLlsveKxFUW
         867fZnMavyC3a7S20qiijGQ6aRAgvIgkXA1y9SczIXQar9L+LnsnjJS/j7eUYmKjB2og
         pyvjSRHJjgBVjp807DmUnqC53EJI1N8/21Hr4b4DGotJ8WKxRgKoczNX7AKi2Vlftl3q
         KryrCRJnMUbdMKD/A2Oh7qVY+rrG0e0okTYhCiKX1vP5pIIY3cyzoeEr16GSZj4ZZuU6
         +n3A==
X-Forwarded-Encrypted: i=1; AJvYcCWiym+aod1sSJYIujk/uPK36wUZnczWHQvab4YhiK03FDQoGLamaYcd/8pawxBsdf99cwUnx0YZtuy1SS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM7oCedDKHIub+wA2k7X5cIS2TMdqieJ3WYV8YatOjUoctZF4l
	tppAoxFTX+y+8nxiGQ8IxO650xFOs04TZ8nmQNMW+CxkgBfmAebZFwyzefRy9zrC/wEGls4fvBE
	hoXRMWNXSsWhulJHltyI/AAUjPOZ4qtylSoemgpxy+iiWzgnl03cPZOZ3jOpzlh+6p2PbfNEDh9
	Kwg+ttcG0X676KrFJ8Ft+vAzYKX9HmBVQy4Yt3
X-Received: by 2002:a17:90b:17c6:b0:2e0:89f2:f60c with SMTP id 98e67ed59e1d1-2e93e0ac496mr28583117a91.11.1730799489153;
        Tue, 05 Nov 2024 01:38:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfBptF6b+UYP/PMKuCsLN5l+Hz/l7bBxZshwZZZaQhmYBx4WQ2HXBLxNHL7GTxTu95PAoJg9Ii6581pMoCwkU=
X-Received: by 2002:a17:90b:17c6:b0:2e0:89f2:f60c with SMTP id
 98e67ed59e1d1-2e93e0ac496mr28583022a91.11.1730799487601; Tue, 05 Nov 2024
 01:38:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105072642.898710-1-lulu@redhat.com> <20241105072642.898710-6-lulu@redhat.com>
In-Reply-To: <20241105072642.898710-6-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 5 Nov 2024 17:37:55 +0800
Message-ID: <CACGkMEt8XO6AvGp4i6PEoCyL=S5QrGvXhZnBdzjr6CvuxdQpYw@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] vhost: Add kthread support in function vhost_worker_queue()
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 3:27=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> The function vhost_worker_queue() uses vhost_task_fn and
> selects the different mode based on the value of inherit_owner.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/vhost.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 603b146fccc1..8b7ddfb33c61 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -238,13 +238,18 @@ EXPORT_SYMBOL_GPL(vhost_poll_stop);
>  static void vhost_worker_queue(struct vhost_worker *worker,
>                                struct vhost_work *work)
>  {
> +       if (!worker && !worker->fn)
> +               return;
> +
>         if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
>                 /* We can only add the work to the list after we're
>                  * sure it was not in the list.
>                  * test_and_set_bit() implies a memory barrier.
>                  */
>                 llist_add(&work->node, &worker->work_list);
> -               vhost_task_wake(worker->vtsk);
> +               worker->fn->wakeup(worker->dev->inherit_owner ?
> +                                          (void *)worker->vtsk :
> +                                          (void *)worker->task);

Logically, it looks better to introduce the ops before introducing
back the kthread behaviour?

Thanks

>         }
>  }
>
> --
> 2.45.0
>


