Return-Path: <linux-kernel+bounces-307379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A32964CA8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 19:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 682CE1C2310B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4271B6548;
	Thu, 29 Aug 2024 17:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gVfufPsC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB741B151F
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 17:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724951610; cv=none; b=aLCYWHLMJxt26ziMb3oO6rLL0ePaXLsuXJxMZWu+fgTqUaGWqrCvp5wUGhrqrb/EO5ofBCySGuns0L2CD3yF/wMPb4mwfht13K2kFljhiaj/mjqQ5p8R/VvtnHcCTqN9bCa+NNKJBZAiduvETTLuwgnpbtlFnfJtjfknQfch3KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724951610; c=relaxed/simple;
	bh=ULZgVzZQEVeW14csxACTHaIhrGVoWfY1nAJLC6fS0wk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V9oeuyaQlVIPt1GYd0Xi3qs/TXA0z9yuPkRdmGF3MvmtR9XqT4ild10EVcqy3JP0liLyPEYie+0eQy2yZlBvGYgpbtW0Xj0uQuI22kQej6KxrwJxIE3ZpH9a3t+CckQElSpb0/0R/IZt4R1Si7r4ujLPEYzzBGnVLS/BukkDgM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gVfufPsC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724951607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7RulHBFlrK+Dikd6+7/LyodQMXb8hyWyQicOlpD/FiQ=;
	b=gVfufPsC7mq0UmlitoQCcFk7Rlp0VIinYIyaseDV22laL4Zwk+A2fXlROy5HpXh4ZvWObO
	LiiG1XTCI/PDO0f1asdoeN3WyceWi1BQQTfhA0G6HeChTVKLtX1LI039/j/SkJToRWyINW
	YgLN3imYRSkjjwbi6b91bxe5UjasmpI=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-xzG2xtTwOoSakiWxV92XAQ-1; Thu, 29 Aug 2024 13:13:23 -0400
X-MC-Unique: xzG2xtTwOoSakiWxV92XAQ-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6adcb88da08so20024497b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 10:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724951603; x=1725556403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7RulHBFlrK+Dikd6+7/LyodQMXb8hyWyQicOlpD/FiQ=;
        b=w2QjF+NdgM880IrsN31tJnwAT6WSMV+oV031w9fR77hWmC19XChMu5LBTYAzMoEfzS
         SGJ+2DWWuoYvuV8s78ANhvKZr+lJLVloh6/6G7M4d8EigSC9k+3vIS+W3wPU5pkTnZEb
         8Ei+flIcY2Iq/FbmTMsh3F2pCdmNdky0hlQzNT81/YhFqoXiiEhXKAkafz9xSgQVqtLq
         +KwosW+NEE8oT52RP7PsbPK0vcxcgusdA90E5e0QK6qltohfEkmLgi2PLpgMw8NB13Dy
         lrArFN73tmMZrt8fsyXj9SHPcy2VO65P2py4d95UrOD+3PmWnITUF+w3eYT+3mdfC4eU
         Wx3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVozgA829aW8ap8ezqUYCL0ykbPkrRm1+2j8gXJTXCi7hLiJxl4WVSTKBzKYAWTeGyuco+maGvl1IXZLag=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsojolPxkzC9O9GXQ4wKHp41VUPYLDMEzwmklqM1yH34+3oarW
	gjvdtwGWpH3pQxnmQiP+UNoAa73emBndVdfDIJuiRc7HgeBieW7EHxgjqMad8Yt5+pGI52YN78L
	/cp4vwJAqgatP93Xuvi2YbuqP0KiVvIJeOaJDqn0S8BlOs+ESYcTMiEvf7ZCrkY6wwlsRc5rP1C
	5WVFNwxBUVazvMb0fIZGZuyK3gGNmIk7dyRpGF
X-Received: by 2002:a05:690c:4d43:b0:650:859b:ec8d with SMTP id 00721157ae682-6d276404c5dmr41338807b3.10.1724951603150;
        Thu, 29 Aug 2024 10:13:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWLGUl+iNDTcbJR2coSAb9n1xDdZKJRQUk15SulJLUN8J5uqhs1YN2kMYvluqhQIeacQ3whnDxGvsIxupEJrs=
X-Received: by 2002:a05:690c:4d43:b0:650:859b:ec8d with SMTP id
 00721157ae682-6d276404c5dmr41338607b3.10.1724951602855; Thu, 29 Aug 2024
 10:13:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821114100.2261167-2-dtatulea@nvidia.com> <20240821114100.2261167-9-dtatulea@nvidia.com>
 <CAJaqyWfANjzrKk9J=hJrdv6c8xd5Xx81XyigPBvc--AxQQK_gg@mail.gmail.com> <bccae5ab-45d3-447e-aed9-d1955da0b109@nvidia.com>
In-Reply-To: <bccae5ab-45d3-447e-aed9-d1955da0b109@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 29 Aug 2024 19:12:46 +0200
Message-ID: <CAJaqyWcxuyo3uN6Y9-LXjPtd+rJmeXi-BrDadAnuLhT3EyUieA@mail.gmail.com>
Subject: Re: [PATCH vhost 7/7] vdpa/mlx5: Postpone MR deletion
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Si-Wei Liu <si-wei.liu@oracle.com>, virtualization@lists.linux-foundation.org, 
	Gal Pressman <gal@nvidia.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cosmin Ratiu <cratiu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 5:23=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
>
>
> On 29.08.24 17:07, Eugenio Perez Martin wrote:
> > On Wed, Aug 21, 2024 at 1:42=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia=
.com> wrote:
> >>
> >> Currently, when a new MR is set up, the old MR is deleted. MR deletion
> >> is about 30-40% the time of MR creation. As deleting the old MR is not
> >> important for the process of setting up the new MR, this operation
> >> can be postponed.
> >>
> >> This series adds a workqueue that does MR garbage collection at a late=
r
> >> point. If the MR lock is taken, the handler will back off and
> >> reschedule. The exception during shutdown: then the handler must
> >> not postpone the work.
> >>
> >> Note that this is only a speculative optimization: if there is some
> >> mapping operation that is triggered while the garbage collector handle=
r
> >> has the lock taken, this operation it will have to wait for the handle=
r
> >> to finish.
> >>
> >> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> >> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> >> ---
> >>  drivers/vdpa/mlx5/core/mlx5_vdpa.h | 10 ++++++
> >>  drivers/vdpa/mlx5/core/mr.c        | 51 ++++++++++++++++++++++++++++-=
-
> >>  drivers/vdpa/mlx5/net/mlx5_vnet.c  |  3 +-
> >>  3 files changed, 60 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/co=
re/mlx5_vdpa.h
> >> index c3e17bc888e8..2cedf7e2dbc4 100644
> >> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> >> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> >> @@ -86,8 +86,18 @@ enum {
> >>  struct mlx5_vdpa_mr_resources {
> >>         struct mlx5_vdpa_mr *mr[MLX5_VDPA_NUM_AS];
> >>         unsigned int group2asid[MLX5_VDPA_NUMVQ_GROUPS];
> >> +
> >> +       /* Pre-deletion mr list */
> >>         struct list_head mr_list_head;
> >> +
> >> +       /* Deferred mr list */
> >> +       struct list_head mr_gc_list_head;
> >> +       struct workqueue_struct *wq_gc;
> >> +       struct delayed_work gc_dwork_ent;
> >> +
> >>         struct mutex lock;
> >> +
> >> +       atomic_t shutdown;
> >>  };
> >>
> >>  struct mlx5_vdpa_dev {
> >> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> >> index ec75f165f832..43fce6b39cf2 100644
> >> --- a/drivers/vdpa/mlx5/core/mr.c
> >> +++ b/drivers/vdpa/mlx5/core/mr.c
> >> @@ -653,14 +653,46 @@ static void _mlx5_vdpa_destroy_mr(struct mlx5_vd=
pa_dev *mvdev, struct mlx5_vdpa_
> >>         kfree(mr);
> >>  }
> >>
> >> +#define MLX5_VDPA_MR_GC_TRIGGER_MS 2000
> >> +
> >> +static void mlx5_vdpa_mr_gc_handler(struct work_struct *work)
> >> +{
> >> +       struct mlx5_vdpa_mr_resources *mres;
> >> +       struct mlx5_vdpa_mr *mr, *tmp;
> >> +       struct mlx5_vdpa_dev *mvdev;
> >> +
> >> +       mres =3D container_of(work, struct mlx5_vdpa_mr_resources, gc_=
dwork_ent.work);
> >> +
> >> +       if (atomic_read(&mres->shutdown)) {
> >> +               mutex_lock(&mres->lock);
> >> +       } else if (!mutex_trylock(&mres->lock)) {
> >
> > Is the trylock worth it? My understanding is that mutex_lock will add
> > the kthread to the waitqueue anyway if it is not able to acquire the
> > lock.
> >
> I want to believe it is :). I noticed during testing that this can
> interfere with the case where there are several .set_map() operations
> in quick succession. That's why the work is delayed by such a long
> time.
>
> It's not a perfect heuristic but I found that it's better than not
> having it.
>

Understood, thanks for explaining! Can you add the explanation to the macro=
?

It would be great to find a mechanism so the work is added in low
priority fashion, but I don't know any.

> >> +               queue_delayed_work(mres->wq_gc, &mres->gc_dwork_ent,
> >> +                                  msecs_to_jiffies(MLX5_VDPA_MR_GC_TR=
IGGER_MS));
> >> +               return;
> >> +       }
> >> +
> >> +       mvdev =3D container_of(mres, struct mlx5_vdpa_dev, mres);
> >> +
> >> +       list_for_each_entry_safe(mr, tmp, &mres->mr_gc_list_head, mr_l=
ist) {
> >> +               _mlx5_vdpa_destroy_mr(mvdev, mr);
> >> +       }
> >> +
> >> +       mutex_unlock(&mres->lock);
> >> +}
> >> +
> >>  static void _mlx5_vdpa_put_mr(struct mlx5_vdpa_dev *mvdev,
> >>                               struct mlx5_vdpa_mr *mr)
> >>  {
> >> +       struct mlx5_vdpa_mr_resources *mres =3D &mvdev->mres;
> >> +
> >>         if (!mr)
> >>                 return;
> >>
> >> -       if (refcount_dec_and_test(&mr->refcount))
> >> -               _mlx5_vdpa_destroy_mr(mvdev, mr);
> >> +       if (refcount_dec_and_test(&mr->refcount)) {
> >> +               list_move_tail(&mr->mr_list, &mres->mr_gc_list_head);
> >> +               queue_delayed_work(mres->wq_gc, &mres->gc_dwork_ent,
> >> +                                  msecs_to_jiffies(MLX5_VDPA_MR_GC_TR=
IGGER_MS));
> >
> > Why the delay?
> >
> See above.
>
> >> +       }
> >>  }
> >>
> >>  void mlx5_vdpa_put_mr(struct mlx5_vdpa_dev *mvdev,
> >> @@ -848,9 +880,17 @@ int mlx5_vdpa_init_mr_resources(struct mlx5_vdpa_=
dev *mvdev)
> >>  {
> >>         struct mlx5_vdpa_mr_resources *mres =3D &mvdev->mres;
> >>
> >> -       INIT_LIST_HEAD(&mres->mr_list_head);
> >> +       mres->wq_gc =3D create_singlethread_workqueue("mlx5_vdpa_mr_gc=
");
> >> +       if (!mres->wq_gc)
> >> +               return -ENOMEM;
> >> +
> >> +       INIT_DELAYED_WORK(&mres->gc_dwork_ent, mlx5_vdpa_mr_gc_handler=
);
> >> +
> >>         mutex_init(&mres->lock);
> >>
> >> +       INIT_LIST_HEAD(&mres->mr_list_head);
> >> +       INIT_LIST_HEAD(&mres->mr_gc_list_head);
> >> +
> >>         return 0;
> >>  }
> >>
> >> @@ -858,5 +898,10 @@ void mlx5_vdpa_destroy_mr_resources(struct mlx5_v=
dpa_dev *mvdev)
> >>  {
> >>         struct mlx5_vdpa_mr_resources *mres =3D &mvdev->mres;
> >>
> >> +       atomic_set(&mres->shutdown, 1);
> >> +
> >> +       flush_delayed_work(&mres->gc_dwork_ent);
> >> +       destroy_workqueue(mres->wq_gc);
> >> +       mres->wq_gc =3D NULL;
> >>         mutex_destroy(&mres->lock);
> >>  }
> >> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net=
/mlx5_vnet.c
> >> index 1cadcb05a5c7..ee9482ef51e6 100644
> >> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >> @@ -3435,6 +3435,8 @@ static void mlx5_vdpa_free(struct vdpa_device *v=
dev)
> >>         free_fixed_resources(ndev);
> >>         mlx5_vdpa_clean_mrs(mvdev);
> >>         mlx5_vdpa_destroy_mr_resources(&ndev->mvdev);
> >> +       mlx5_cmd_cleanup_async_ctx(&mvdev->async_ctx);
> >> +
> >>         if (!is_zero_ether_addr(ndev->config.mac)) {
> >>                 pfmdev =3D pci_get_drvdata(pci_physfn(mvdev->mdev->pde=
v));
> >>                 mlx5_mpfs_del_mac(pfmdev, ndev->config.mac);
> >> @@ -4044,7 +4046,6 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_d=
ev *v_mdev, struct vdpa_device *
> >>         destroy_workqueue(wq);
> >>         mgtdev->ndev =3D NULL;
> >>
> >
> > Extra newline here.
> Ack.
> >
> >> -       mlx5_cmd_cleanup_async_ctx(&mvdev->async_ctx);
> >>  }
> >>
> >>  static const struct vdpa_mgmtdev_ops mdev_ops =3D {
> >> --
> >> 2.45.1
> >>
> >
>


