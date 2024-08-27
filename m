Return-Path: <linux-kernel+bounces-302478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C962B95FF2E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 04:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FDEA284CA7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 02:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBE7F9FE;
	Tue, 27 Aug 2024 02:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XqUirjam"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6835C133
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 02:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724726193; cv=none; b=M7MV0nnLupiR68Id9CVw5OSzAGDxl43jZ/OnjkdInuQFZFcGL+GJFpfa3CC+944to5FwjMG1MRTYz/X/j6pMeOnEoAP29rh8Bg/V37dok3i3IsoNdgs6UOZuxwibVr0/XTZm8tjU6hmqG7VHQ7Ubm5l6TamhkE63GrXEcs7eVEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724726193; c=relaxed/simple;
	bh=7ddS/d4k9G7fIIVMSSKcG/CFyccl7w4CLYXz60LhSL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=We35nyrIzPTlvqs1+wzy3Yt5I/cbasy1IFtNuuoBac2yHRPHb1NK6IdcymEYazZbs0eEgeH+J8IGp5GQHUgfnH7q7j48atMq4E5fjjlKTAnScXGKGbFrGj9VSN8stf+DlG4ktuON2Z8We0qinuI/kIoio6E0+R7F700gvS4aREE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XqUirjam; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724726190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iU3u8Ft1rxly7qkOmUJIntRTHvbC1QrMgAzfkIxaRHI=;
	b=XqUirjampnejje1wDVrtFuxOfL32/gYnlekxl/Ist2tFn8j2fYPUwkziZBB455A+5Eteb8
	waCIWYK7wGb0j7E7F5T1deaAweMIbZEM25HIrNNsHbhw/wj98bCJdyBTpYS1giPZwBOiyj
	+FzCTEuBzsHve78fANvAOwajUEAWxQ8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-j3IKJeACOvaCC8s8pAamFg-1; Mon, 26 Aug 2024 22:36:28 -0400
X-MC-Unique: j3IKJeACOvaCC8s8pAamFg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2d3c976e426so6153546a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 19:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724726187; x=1725330987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iU3u8Ft1rxly7qkOmUJIntRTHvbC1QrMgAzfkIxaRHI=;
        b=LOjxqjSk50zSZtRg7JF2I43bh9BDz0jdauE/r2Irtl1q3PMUd8hT5vV4Ef6ZnfHq0A
         DSkwrHsfeNX9v7xQLwVqssnuGts/qVZrgTK+d60GYAfIAJTOu3XV5YDbxHvVT2Zq7Set
         Osp5dpckHNIHtjH4m3d7szd4YpKbKJ5AielWnOz9RTvJ8banI7iaGNiHGNdJYJyrM9DH
         CH3YBSZaQpQ58Rg7LbiPd++1B1fxaOzqfSmma/qkk/88R2ICIgIcesEyCz9FImUJUyuJ
         4PmNxs59v872SO9GcYQ4Pr6QdGBTW6eKCawq8pfD4heuLjbUzNVRLoC8fcIXi4TrjtkR
         R3GA==
X-Forwarded-Encrypted: i=1; AJvYcCU5YAyYGh2splzjRBWq1XI1IOLqAaPmMq4FRwQNXYiFCl8xsaOCse5+n9Y4wGy8q2+bt6BQ/HMWD+S3pdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk4iRUDdI9ejL9/WZ85EkEL2LNiIG4Yj+0q2eF/xtMunDEESdR
	EdWQje0NlULCg84AS5wJsm0TpOckHtoF8QfVcRVLfgBtvTMAmrH0Q5WNzLrjKXgfV/VBXdmxpAa
	snlen9qykyP58t+nGcNs53OQ5KSg602zsl2OAGs8l2QBfvfJ9XMRyJ7fUUkpsCoWv2tV0jFzUCJ
	0bxUaorXqw6Kz2ldfdt5NvZU4txOfslWbSgC7P
X-Received: by 2002:a17:90a:5108:b0:2cf:28c1:4cc2 with SMTP id 98e67ed59e1d1-2d8257c4727mr1924670a91.3.1724726187021;
        Mon, 26 Aug 2024 19:36:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3adO54WTlhNtTNU0aZk27uMQbtk5OcBZNZSjU+LPEYCH81ylxQtc+elyvOSocFRRguXTJm5rf4p50RQ7tM3Y=
X-Received: by 2002:a17:90a:5108:b0:2cf:28c1:4cc2 with SMTP id
 98e67ed59e1d1-2d8257c4727mr1924651a91.3.1724726186522; Mon, 26 Aug 2024
 19:36:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819092851.441670-1-lulu@redhat.com> <20240819092851.441670-3-lulu@redhat.com>
In-Reply-To: <20240819092851.441670-3-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Aug 2024 10:36:13 +0800
Message-ID: <CACGkMEtQaJ+o2WXnWw8iCF=9q7kx+CyVnn_YUgbNEo-ontHRqA@mail.gmail.com>
Subject: Re: [RFC 2/7] vhost: Add kthread support in function vhost_worker_queue()
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 5:29=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Added back the previously removed function vhost_worker_queue() and
> renamed it to vhost_worker_queue_khtread(). The new vhost_worker_queue()
> will select the different mode based on the value of the parameter.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

It looks like a partial revert of some previous commit, please mention
the commit id in the change log as least.

So did for the following 3 or 4 patches.

Thanks

> ---
>  drivers/vhost/vhost.c | 30 ++++++++++++++++++++++++++++--
>  drivers/vhost/vhost.h |  1 +
>  2 files changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index da701f6b3f2c..6261c9df468e 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -236,8 +236,8 @@ void vhost_poll_stop(struct vhost_poll *poll)
>  }
>  EXPORT_SYMBOL_GPL(vhost_poll_stop);
>
> -static void vhost_worker_queue(struct vhost_worker *worker,
> -                              struct vhost_work *work)
> +static void vhost_worker_queue_task(struct vhost_worker *worker,
> +                                   struct vhost_work *work)
>  {
>         if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
>                 /* We can only add the work to the list after we're
> @@ -249,6 +249,32 @@ static void vhost_worker_queue(struct vhost_worker *=
worker,
>         }
>  }
>
> +static void vhost_work_queue_kthread(struct vhost_worker *worker,
> +                                    struct vhost_work *work)
> +{
> +       if (!worker)
> +               return;
> +
> +       if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
> +               /* We can only add the work to the list after we're
> +                * sure it was not in the list.
> +                * test_and_set_bit() implies a memory barrier.
> +                */
> +               llist_add(&work->node, &worker->work_list);
> +
> +               wake_up_process(worker->task);
> +       }
> +}
> +
> +static void vhost_worker_queue(struct vhost_worker *worker,
> +                              struct vhost_work *work)
> +{
> +       if (use_kthread) {
> +               vhost_work_queue_kthread(worker, work);
> +       } else {
> +               vhost_worker_queue_task(worker, work);
> +       }
> +}
>  bool vhost_vq_work_queue(struct vhost_virtqueue *vq, struct vhost_work *=
work)
>  {
>         struct vhost_worker *worker;
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index bb75a292d50c..c7f126fd09e8 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -27,6 +27,7 @@ struct vhost_work {
>  };
>
>  struct vhost_worker {
> +       struct task_struct      *task;
>         struct vhost_task       *vtsk;
>         struct vhost_dev        *dev;
>         /* Used to serialize device wide flushing with worker swapping. *=
/
> --
> 2.45.0
>


