Return-Path: <linux-kernel+bounces-417710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD229D5838
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 03:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3A19280D7B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 02:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD7170816;
	Fri, 22 Nov 2024 02:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJVtE32/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D719230988
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 02:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732241808; cv=none; b=UR2hZMLh5xSAPyXBkcMa65C1qBS7TU9NMxtEQJRD1e+VT2w2rHn7O+dqgav8hQrZNmTAXLb5xWTdl03iQQ3avshOWkwZl7GglUmxUkLkPlHdkSjspbRWC9uSrYkSZG1pXn+HCOqTclz4nnM51+e8HTFvu3QsAhS5NwZHIeZ6GDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732241808; c=relaxed/simple;
	bh=K3a44Y8zZIg4IBF42XotKwxs5GT84G28gXmNEumijHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=khf2ufUp5RCjgKUvYKoG0Yg800848n2kmUIMKwgVnjmqYmtC8tJzRw0ZOkw2IFXxQp2yDTVHA3EhocQ9TvXMb5snwd38pW6DoUDmJ/5sOU1K5AolTHkV5g8etEagaevz6GkX3U1WJ+nkdGxvAmR2WcO4gXyQL8kjC/T0a4W/GVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UJVtE32/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732241805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=niGUghmC2ufgphugT1QWkVX9h3uIq2VADkrr0G0uSPE=;
	b=UJVtE32/gr6VyYyxQJ8TcyuW3rygP070eVj+XrrqwXawfCZbxEgfgcpFpfkwLbBGPjt9eF
	KD2Xk8AalOaBIIPxoPO5zZpFeLJTF6eKmu42Ihgjl2NSSI2UN3VXERHhDIU7CwpW6v3SyG
	/p/huhMeoW8g0Ab+P3tdXhz8H1Mbu4I=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-6DbaZVAsOu6S_P4pBV88cw-1; Thu, 21 Nov 2024 21:16:43 -0500
X-MC-Unique: 6DbaZVAsOu6S_P4pBV88cw-1
X-Mimecast-MFC-AGG-ID: 6DbaZVAsOu6S_P4pBV88cw
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-539f49f2443so1349976e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:16:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732241802; x=1732846602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=niGUghmC2ufgphugT1QWkVX9h3uIq2VADkrr0G0uSPE=;
        b=xBirSmSc6bcME5qXgs6/4SEILBBgG3x0Yf3zo5wR72aOkFRixwdyclouL0Agoew52D
         b0yUxul2wcsEavQXvvWRxt1VMX7bs6PVgCPzSeKV/EhR6WuT3nfIH4Ro9ATDZpbcnltu
         3tI6PSx83/Sm8DqE2/KMbLFzOaJOz9HhEubdPwFAO3MLcWsQMn8R93CfA2DSnYo1jy7t
         EXBIEjRlgzigjAr2dk2x2rctFu473Jvf8koklN2vwx6evQEZqPC9hTEkun4SXymBWRlA
         AP1XK+MWZDUmREweF3K9fftLDB+cZFvGP3+E/pLYXLUTHC/n8m2wKzImrgde/7AjyMrC
         d3lg==
X-Forwarded-Encrypted: i=1; AJvYcCXo1alAbRZYqVWW2W9OgNq0pa8E/hVpo3lgRR8nxLsXYdo/pK/8W5UfFh4TJW2uyIafTiPiPc/chynjcl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAW0692CvIDZQFpl0T27UXqqZ9rNhM5T5BxFT1Y4BkEzrRnd92
	8pbQQg/+w7eqrrpTgdfS1VkzYIBcZ7BBOPeWbPcGqAJlxz9PV/eLth4o639N4Vw/kXjfGtNBGj/
	8HfpOKetRvlNsaeAYN5OqXb+Ag0gOCKmGyKpy3HRQtfsAthwOg7AuJ9l8IPzuXBHy+J4T4uTWIm
	IQPaRuJuyFV5Ipgw196h3nnbMBdRaMnpHKWib9
X-Gm-Gg: ASbGncu4BtbdU4ND92Fba3Omv91BnjEUjyqKGuxLF28I2wJ1feH4c3U6PP3dZ1OEYsc
	8G5HMjHRAj2o1mG1tIqJb0qdqIEx2xA7m
X-Received: by 2002:a05:6512:3da2:b0:53d:a504:9334 with SMTP id 2adb3069b0e04-53dd39a4e1amr589724e87.44.1732241801802;
        Thu, 21 Nov 2024 18:16:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0twYx0xADoC5Enq++SxNbVIKQMDnR3VMyxwvjzHGr9BV0l86QU4nA+XpsjILa6P2c1b8GTVUJcaoDCW2I2pU=
X-Received: by 2002:a05:6512:3da2:b0:53d:a504:9334 with SMTP id
 2adb3069b0e04-53dd39a4e1amr589716e87.44.1732241801379; Thu, 21 Nov 2024
 18:16:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118114157.355749-1-yukuai1@huaweicloud.com> <20241118114157.355749-2-yukuai1@huaweicloud.com>
In-Reply-To: <20241118114157.355749-2-yukuai1@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Fri, 22 Nov 2024 10:16:29 +0800
Message-ID: <CALTww28iG8rUWNkYLcHkAM0o0k-9F_hjvZhBx=4VW=fhugkOsA@mail.gmail.com>
Subject: Re: [PATCH md-6.13 1/5] md/md-bitmap: factor behind write counters
 out from bitmap_{start/end}write()
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
> behind_write is only used in raid1, prepare to refactor
> bitmap_{start/end}write(), there are no functional changes.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md-bitmap.c   | 57 +++++++++++++++++++++++++---------------
>  drivers/md/md-bitmap.h   |  7 +++--
>  drivers/md/raid1.c       | 12 +++++----
>  drivers/md/raid10.c      |  6 ++---
>  drivers/md/raid5-cache.c |  3 +--
>  drivers/md/raid5.c       | 11 ++++----
>  6 files changed, 56 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
> index c3a42dd66ce5..84fb4cc67d5e 100644
> --- a/drivers/md/md-bitmap.c
> +++ b/drivers/md/md-bitmap.c
> @@ -1671,24 +1671,13 @@ __acquires(bitmap->lock)
>  }
>
>  static int bitmap_startwrite(struct mddev *mddev, sector_t offset,
> -                            unsigned long sectors, bool behind)
> +                            unsigned long sectors)
>  {
>         struct bitmap *bitmap =3D mddev->bitmap;
>
>         if (!bitmap)
>                 return 0;
>
> -       if (behind) {
> -               int bw;
> -               atomic_inc(&bitmap->behind_writes);
> -               bw =3D atomic_read(&bitmap->behind_writes);
> -               if (bw > bitmap->behind_writes_used)
> -                       bitmap->behind_writes_used =3D bw;
> -
> -               pr_debug("inc write-behind count %d/%lu\n",
> -                        bw, bitmap->mddev->bitmap_info.max_write_behind)=
;
> -       }
> -
>         while (sectors) {
>                 sector_t blocks;
>                 bitmap_counter_t *bmc;
> @@ -1737,21 +1726,13 @@ static int bitmap_startwrite(struct mddev *mddev,=
 sector_t offset,
>  }
>
>  static void bitmap_endwrite(struct mddev *mddev, sector_t offset,
> -                           unsigned long sectors, bool success, bool beh=
ind)
> +                           unsigned long sectors, bool success)
>  {
>         struct bitmap *bitmap =3D mddev->bitmap;
>
>         if (!bitmap)
>                 return;
>
> -       if (behind) {
> -               if (atomic_dec_and_test(&bitmap->behind_writes))
> -                       wake_up(&bitmap->behind_wait);
> -               pr_debug("dec write-behind count %d/%lu\n",
> -                        atomic_read(&bitmap->behind_writes),
> -                        bitmap->mddev->bitmap_info.max_write_behind);
> -       }
> -
>         while (sectors) {
>                 sector_t blocks;
>                 unsigned long flags;
> @@ -2062,6 +2043,37 @@ static void md_bitmap_free(void *data)
>         kfree(bitmap);
>  }
>
> +static void bitmap_start_behind_write(struct mddev *mddev)
> +{
> +       struct bitmap *bitmap =3D mddev->bitmap;
> +       int bw;
> +
> +       if (!bitmap)
> +               return;
> +
> +       atomic_inc(&bitmap->behind_writes);
> +       bw =3D atomic_read(&bitmap->behind_writes);
> +       if (bw > bitmap->behind_writes_used)
> +               bitmap->behind_writes_used =3D bw;
> +
> +       pr_debug("inc write-behind count %d/%lu\n",
> +                bw, bitmap->mddev->bitmap_info.max_write_behind);
> +}
> +
> +static void bitmap_end_behind_write(struct mddev *mddev)
> +{
> +       struct bitmap *bitmap =3D mddev->bitmap;
> +
> +       if (!bitmap)
> +               return;
> +
> +       if (atomic_dec_and_test(&bitmap->behind_writes))
> +               wake_up(&bitmap->behind_wait);
> +       pr_debug("dec write-behind count %d/%lu\n",
> +                atomic_read(&bitmap->behind_writes),
> +                bitmap->mddev->bitmap_info.max_write_behind);
> +}
> +
>  static void bitmap_wait_behind_writes(struct mddev *mddev)
>  {
>         struct bitmap *bitmap =3D mddev->bitmap;
> @@ -2981,6 +2993,9 @@ static struct bitmap_operations bitmap_ops =3D {
>         .dirty_bits             =3D bitmap_dirty_bits,
>         .unplug                 =3D bitmap_unplug,
>         .daemon_work            =3D bitmap_daemon_work,
> +
> +       .start_behind_write     =3D bitmap_start_behind_write,
> +       .end_behind_write       =3D bitmap_end_behind_write,
>         .wait_behind_writes     =3D bitmap_wait_behind_writes,
>
>         .startwrite             =3D bitmap_startwrite,
> diff --git a/drivers/md/md-bitmap.h b/drivers/md/md-bitmap.h
> index 662e6fc141a7..e87a1f493d3c 100644
> --- a/drivers/md/md-bitmap.h
> +++ b/drivers/md/md-bitmap.h
> @@ -84,12 +84,15 @@ struct bitmap_operations {
>                            unsigned long e);
>         void (*unplug)(struct mddev *mddev, bool sync);
>         void (*daemon_work)(struct mddev *mddev);
> +
> +       void (*start_behind_write)(struct mddev *mddev);
> +       void (*end_behind_write)(struct mddev *mddev);
>         void (*wait_behind_writes)(struct mddev *mddev);
>
>         int (*startwrite)(struct mddev *mddev, sector_t offset,
> -                         unsigned long sectors, bool behind);
> +                         unsigned long sectors);
>         void (*endwrite)(struct mddev *mddev, sector_t offset,
> -                        unsigned long sectors, bool success, bool behind=
);
> +                        unsigned long sectors, bool success);
>         bool (*start_sync)(struct mddev *mddev, sector_t offset,
>                            sector_t *blocks, bool degraded);
>         void (*end_sync)(struct mddev *mddev, sector_t offset, sector_t *=
blocks);
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index cd3e94dceabc..e6e1228d9b3a 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -420,10 +420,11 @@ static void close_write(struct r1bio *r1_bio)
>                 r1_bio->behind_master_bio =3D NULL;
>         }
>
> +       if (test_bit(R1BIO_BehindIO, &r1_bio->state))
> +               mddev->bitmap_ops->end_behind_write(mddev);
>         /* clear the bitmap if all writes complete successfully */
>         mddev->bitmap_ops->endwrite(mddev, r1_bio->sector, r1_bio->sector=
s,
> -                                   !test_bit(R1BIO_Degraded, &r1_bio->st=
ate),
> -                                   test_bit(R1BIO_BehindIO, &r1_bio->sta=
te));
> +                                   !test_bit(R1BIO_Degraded, &r1_bio->st=
ate));
>         md_write_end(mddev);
>  }
>
> @@ -1614,9 +1615,10 @@ static void raid1_write_request(struct mddev *mdde=
v, struct bio *bio,
>                             stats.behind_writes < max_write_behind)
>                                 alloc_behind_master_bio(r1_bio, bio);
>
> -                       mddev->bitmap_ops->startwrite(
> -                               mddev, r1_bio->sector, r1_bio->sectors,
> -                               test_bit(R1BIO_BehindIO, &r1_bio->state))=
;
> +                       if (test_bit(R1BIO_BehindIO, &r1_bio->state))
> +                               mddev->bitmap_ops->start_behind_write(mdd=
ev);
> +                       mddev->bitmap_ops->startwrite(mddev, r1_bio->sect=
or,
> +                                                     r1_bio->sectors);
>                         first_clone =3D 0;
>                 }
>
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index ff73db2f6c41..61ac074e821f 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -430,8 +430,7 @@ static void close_write(struct r10bio *r10_bio)
>
>         /* clear the bitmap if all writes complete successfully */
>         mddev->bitmap_ops->endwrite(mddev, r10_bio->sector, r10_bio->sect=
ors,
> -                                   !test_bit(R10BIO_Degraded, &r10_bio->=
state),
> -                                   false);
> +                                   !test_bit(R10BIO_Degraded, &r10_bio->=
state));
>         md_write_end(mddev);
>  }
>
> @@ -1489,8 +1488,7 @@ static void raid10_write_request(struct mddev *mdde=
v, struct bio *bio,
>         md_account_bio(mddev, &bio);
>         r10_bio->master_bio =3D bio;
>         atomic_set(&r10_bio->remaining, 1);
> -       mddev->bitmap_ops->startwrite(mddev, r10_bio->sector, r10_bio->se=
ctors,
> -                                     false);
> +       mddev->bitmap_ops->startwrite(mddev, r10_bio->sector, r10_bio->se=
ctors);
>
>         for (i =3D 0; i < conf->copies; i++) {
>                 if (r10_bio->devs[i].bio)
> diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
> index b4f7b79fd187..4c7ecdd5c1f3 100644
> --- a/drivers/md/raid5-cache.c
> +++ b/drivers/md/raid5-cache.c
> @@ -315,8 +315,7 @@ void r5c_handle_cached_data_endio(struct r5conf *conf=
,
>                         r5c_return_dev_pending_writes(conf, &sh->dev[i]);
>                         conf->mddev->bitmap_ops->endwrite(conf->mddev,
>                                         sh->sector, RAID5_STRIPE_SECTORS(=
conf),
> -                                       !test_bit(STRIPE_DEGRADED, &sh->s=
tate),
> -                                       false);
> +                                       !test_bit(STRIPE_DEGRADED, &sh->s=
tate));
>                 }
>         }
>  }
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index f5ac81dd21b2..84f3d27e0fa4 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -3564,7 +3564,7 @@ static void __add_stripe_bio(struct stripe_head *sh=
, struct bio *bi,
>                 set_bit(STRIPE_BITMAP_PENDING, &sh->state);
>                 spin_unlock_irq(&sh->stripe_lock);
>                 conf->mddev->bitmap_ops->startwrite(conf->mddev, sh->sect=
or,
> -                                       RAID5_STRIPE_SECTORS(conf), false=
);
> +                                       RAID5_STRIPE_SECTORS(conf));
>                 spin_lock_irq(&sh->stripe_lock);
>                 clear_bit(STRIPE_BITMAP_PENDING, &sh->state);
>                 if (!sh->batch_head) {
> @@ -3665,7 +3665,7 @@ handle_failed_stripe(struct r5conf *conf, struct st=
ripe_head *sh,
>                 if (bitmap_end)
>                         conf->mddev->bitmap_ops->endwrite(conf->mddev,
>                                         sh->sector, RAID5_STRIPE_SECTORS(=
conf),
> -                                       false, false);
> +                                       false);
>                 bitmap_end =3D 0;
>                 /* and fail all 'written' */
>                 bi =3D sh->dev[i].written;
> @@ -3712,7 +3712,7 @@ handle_failed_stripe(struct r5conf *conf, struct st=
ripe_head *sh,
>                 if (bitmap_end)
>                         conf->mddev->bitmap_ops->endwrite(conf->mddev,
>                                         sh->sector, RAID5_STRIPE_SECTORS(=
conf),
> -                                       false, false);
> +                                       false);
>                 /* If we were in the middle of a write the parity block m=
ight
>                  * still be locked - so just clear all R5_LOCKED flags
>                  */
> @@ -4063,8 +4063,7 @@ static void handle_stripe_clean_event(struct r5conf=
 *conf,
>                                 }
>                                 conf->mddev->bitmap_ops->endwrite(conf->m=
ddev,
>                                         sh->sector, RAID5_STRIPE_SECTORS(=
conf),
> -                                       !test_bit(STRIPE_DEGRADED, &sh->s=
tate),
> -                                       false);
> +                                       !test_bit(STRIPE_DEGRADED, &sh->s=
tate));
>                                 if (head_sh->batch_head) {
>                                         sh =3D list_first_entry(&sh->batc=
h_list,
>                                                               struct stri=
pe_head,
> @@ -5787,7 +5786,7 @@ static void make_discard_request(struct mddev *mdde=
v, struct bio *bi)
>                         for (d =3D 0; d < conf->raid_disks - conf->max_de=
graded;
>                              d++)
>                                 mddev->bitmap_ops->startwrite(mddev, sh->=
sector,
> -                                       RAID5_STRIPE_SECTORS(conf), false=
);
> +                                       RAID5_STRIPE_SECTORS(conf));
>                         sh->bm_seq =3D conf->seq_flush + 1;
>                         set_bit(STRIPE_BIT_DELAY, &sh->state);
>                 }
> --
> 2.39.2
>

Reviewed-by: Xiao Ni <xni@redhat.com>


