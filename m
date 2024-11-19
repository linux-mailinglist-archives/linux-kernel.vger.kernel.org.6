Return-Path: <linux-kernel+bounces-414255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 880E29D2553
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 13:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4899D2825DA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 12:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F4E1CC88B;
	Tue, 19 Nov 2024 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZ61ogbz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0C51CBEB8
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732018262; cv=none; b=Y9to1q2dWEEY7OaHz2yWHNP+gmu1QEY97lanMsZrMi5qNtZhykPRyhWCGd1Mz1WQP6vKJTMOHGeuX2I8aBMIDaHiIgMKZnskT66dHjX8OEVTGNsQU24NWJQU76rSnQa1jDH8UqjRK1NCSxCwGiiwzUJikAS/uyjiCzskzcuLD34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732018262; c=relaxed/simple;
	bh=I/WKuNZIb/72amKCFT6zun8ph0MFLDtkptnk5ECw6Bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TOMiI8uNHnNoX8h0nQ9PZzrVYgadmdctW6Y/K2js+u7Rts49zSFRDZpoCv6Nnvp1A7mhpOwS3b0nWbXTjNg5GE19Wwlw/eUsPZbFszDIHaea84w7dWocY7Ro9i+nj7QIg5cIiWwFQkLtro7fCHolW73GFrmDlEj0D2bZivwxqxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cZ61ogbz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732018259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1pI7tMfFo6N7qAAprfaSnS3NWeGTnzmZIZzGrSOrSVc=;
	b=cZ61ogbz7U11FJ44fSYTHNp4GqmrV7yBB+F7T4AsITxgTIb7fXTVu7ZjNf1d0X2WNUtOi2
	ZyGhI+DEp7VCv8xtu2r0vF0HzwEV7iF8J2f1Dj1QXtcDzbHYxgwHKsg0k8WO1CjRAtyqOr
	DDgokNAFT7DXWq60kCUs7eAWbyxdwwc=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-58vOl9IwP0aqqIgdtgPppg-1; Tue, 19 Nov 2024 07:10:58 -0500
X-MC-Unique: 58vOl9IwP0aqqIgdtgPppg-1
X-Mimecast-MFC-AGG-ID: 58vOl9IwP0aqqIgdtgPppg
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-50dc9c959a5so2103915e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 04:10:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732018257; x=1732623057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1pI7tMfFo6N7qAAprfaSnS3NWeGTnzmZIZzGrSOrSVc=;
        b=EVMVF3//myTpamdZXs/Xg9gaaQhvMBAJnWunuBv50KpQJw7TyI26SHkbk8RBdK3sP/
         rwYrHUxNHqdeEhP3yWvnEbMXF87HXCuJGbUd3HLjXKnc5HBKBidM/i2/AhtVgeodeyQs
         e86GheTFXzUCwI6m1C/TWM6blgaMroUdDLjjwEXs6b7jQd0clPi5c3daNpPQufXTJfV8
         jh77gT5rH9kOi/Cxe/9UCViMRaJaIQR1Lt/7TaH5Is7SJijLAmOHZng8B7HjL0Dw6Pi4
         HQ+j0Y8joC3fs3ksDEts/7ModL5eqtL6p9DEonZosrhoo0W4ozz+cHAxzpv+6UWaX8OR
         8rSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNxUDNytJb6PMKiPqZe360BB9fTW3EYKibEz9vMpLDVyiQ8S3Jz6QdeXekDZPX7/hcJVUTfDQD8ecjdPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YytLs6x2k3gU9V0iir5vnPoev36dReD3xYXoGjTd9t8y9ezKEEr
	emvxXqE8JmoP4D6muDC5dccwz0nQOiPf4OOPukXNQKt5kQR70/gsGDKxyuebLyh1JeklMp4ZbcN
	wxJ0Asmr24zYCiw8FgQHElzXMqgPwXSprD+QGxpxQQy3zIpfk5di2S5ERUE7WbMEPYcbwhH5YxZ
	47Ix33HH4dqDRLRdDKhJk5DKg+Ro09W3IH7eHJ
X-Received: by 2002:a05:6122:3bcb:b0:50d:a577:dec0 with SMTP id 71dfb90a1353d-51477eed1b9mr14301085e0c.5.1732018257396;
        Tue, 19 Nov 2024 04:10:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIYs+5pfjdVFKDbgb2W5AjOIyXHoTuM2BVY1IbxBylt3iWe5/9ZG4NqXLW2FjLgfUKaVWmNSSQQYLxkcqFPoc=
X-Received: by 2002:a05:6122:3bcb:b0:50d:a577:dec0 with SMTP id
 71dfb90a1353d-51477eed1b9mr14301066e0c.5.1732018257139; Tue, 19 Nov 2024
 04:10:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67313d9e.050a0220.138bd5.0054.GAE@google.com> <8734jxsyuu.fsf@mail.parknet.co.jp>
In-Reply-To: <8734jxsyuu.fsf@mail.parknet.co.jp>
From: Ming Lei <ming.lei@redhat.com>
Date: Tue, 19 Nov 2024 20:10:46 +0800
Message-ID: <CAFj5m9+FmQLLQkO7EUKnuuj+mpSUOY3EeUxSpXjJUvWtKfz26w@mail.gmail.com>
Subject: Re: [syzbot] [exfat?] possible deadlock in fat_count_free_clusters
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	syzbot <syzbot+a5d8c609c02f508672cc@syzkaller.appspotmail.com>, 
	linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 12:44=E2=80=AFAM OGAWA Hirofumi
<hirofumi@mail.parknet.co.jp> wrote:
>
> Hi,
>
> syzbot <syzbot+a5d8c609c02f508672cc@syzkaller.appspotmail.com> writes:
>
> > syzbot found the following issue on:
> >
> > HEAD commit:    929beafbe7ac Add linux-next specific files for 20241108
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1621bd87980=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D75175323f20=
78363
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Da5d8c609c02f5=
08672cc
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
>
> This patch is to fix the above race. Please check this.
>
> Thanks
>
>
> From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> Subject: [PATCH] loop: Fix ABBA locking race
> Date: Mon, 11 Nov 2024 21:53:36 +0900
>
> Current loop calls vfs_statfs() while holding the q->limits_lock. If
> FS takes some locking in vfs_statfs callback, this may lead to ABBA
> locking bug (at least, FAT fs has this issue actually).
>
> So this patch calls vfs_statfs() outside q->limits_locks instead,
> because looks like there is no reason to hold q->limits_locks while
> getting discard configs.
>
> Chain exists of:
>   &sbi->fat_lock --> &q->q_usage_counter(io)#17 --> &q->limits_lock
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(&q->limits_lock);
>                                lock(&q->q_usage_counter(io)#17);
>                                lock(&q->limits_lock);
>   lock(&sbi->fat_lock);
>
>  *** DEADLOCK ***
>
> Reported-by: syzbot+a5d8c609c02f508672cc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Da5d8c609c02f508672cc
> Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> ---
>  drivers/block/loop.c |   31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 78a7bb2..5f3ce51 100644
> --- a/drivers/block/loop.c      2024-09-16 13:45:20.253220178 +0900
> +++ b/drivers/block/loop.c      2024-11-11 21:51:00.910135443 +0900
> @@ -770,12 +770,11 @@ static void loop_sysfs_exit(struct loop_
>                                    &loop_attribute_group);
>  }
>
> -static void loop_config_discard(struct loop_device *lo,
> -               struct queue_limits *lim)
> +static void loop_get_discard_config(struct loop_device *lo,
> +                                   u32 *granularity, u32 *max_discard_se=
ctors)
>  {
>         struct file *file =3D lo->lo_backing_file;
>         struct inode *inode =3D file->f_mapping->host;
> -       u32 granularity =3D 0, max_discard_sectors =3D 0;
>         struct kstatfs sbuf;
>
>         /*
> @@ -788,8 +787,9 @@ static void loop_config_discard(struct l
>         if (S_ISBLK(inode->i_mode)) {
>                 struct request_queue *backingq =3D bdev_get_queue(I_BDEV(=
inode));
>
> -               max_discard_sectors =3D backingq->limits.max_write_zeroes=
_sectors;
> -               granularity =3D bdev_discard_granularity(I_BDEV(inode)) ?=
:
> +               *max_discard_sectors =3D
> +                       backingq->limits.max_write_zeroes_sectors;
> +               *granularity =3D bdev_discard_granularity(I_BDEV(inode)) =
?:
>                         queue_physical_block_size(backingq);
>
>         /*
> @@ -797,16 +797,9 @@ static void loop_config_discard(struct l
>          * image a.k.a. discard.
>          */
>         } else if (file->f_op->fallocate && !vfs_statfs(&file->f_path, &s=
buf)) {
> -               max_discard_sectors =3D UINT_MAX >> 9;
> -               granularity =3D sbuf.f_bsize;
> +               *max_discard_sectors =3D UINT_MAX >> 9;
> +               *granularity =3D sbuf.f_bsize;
>         }
> -
> -       lim->max_hw_discard_sectors =3D max_discard_sectors;
> -       lim->max_write_zeroes_sectors =3D max_discard_sectors;
> -       if (max_discard_sectors)
> -               lim->discard_granularity =3D granularity;
> -       else
> -               lim->discard_granularity =3D 0;
>  }
>
>  struct loop_worker {
> @@ -992,6 +985,7 @@ static int loop_reconfigure_limits(struc
>         struct inode *inode =3D file->f_mapping->host;
>         struct block_device *backing_bdev =3D NULL;
>         struct queue_limits lim;
> +       u32 granularity =3D 0, max_discard_sectors =3D 0;
>
>         if (S_ISBLK(inode->i_mode))
>                 backing_bdev =3D I_BDEV(inode);
> @@ -1001,6 +995,8 @@ static int loop_reconfigure_limits(struc
>         if (!bsize)
>                 bsize =3D loop_default_blocksize(lo, backing_bdev);
>
> +       loop_get_discard_config(lo, &granularity, &max_discard_sectors);
> +
>         lim =3D queue_limits_start_update(lo->lo_queue);
>         lim.logical_block_size =3D bsize;
>         lim.physical_block_size =3D bsize;
> @@ -1010,7 +1006,12 @@ static int loop_reconfigure_limits(struc
>                 lim.features |=3D BLK_FEAT_WRITE_CACHE;
>         if (backing_bdev && !bdev_nonrot(backing_bdev))
>                 lim.features |=3D BLK_FEAT_ROTATIONAL;
> -       loop_config_discard(lo, &lim);
> +       lim.max_hw_discard_sectors =3D max_discard_sectors;
> +       lim.max_write_zeroes_sectors =3D max_discard_sectors;
> +       if (max_discard_sectors)
> +               lim.discard_granularity =3D granularity;
> +       else
> +               lim.discard_granularity =3D 0;
>         return queue_limits_commit_update(lo->lo_queue, &lim);
>  }

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>


