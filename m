Return-Path: <linux-kernel+bounces-246753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 214FD92C634
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 00:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A4C281D42
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 22:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AF5187863;
	Tue,  9 Jul 2024 22:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHQFAzYm"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61C6187841
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 22:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720563615; cv=none; b=Pd+DV9QNmX6T4ki1FIAkdU58/PzVL2mZEVRFoAuakCD9IJB1eO/Ayxw26WuZQ9gecmqyv5HCArhBqZQ1NEc7sX9bMr9P9oNz9TnC7RxUcOy8Zs/JghqCbk64ZFNRMnQ1oCW4lRVc7sYRRZy+bxxrenS5D+KItbvP61l258hBriE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720563615; c=relaxed/simple;
	bh=GKkuS6aol8CZ5SlzbQBMPwMv3m8kuZUjoJcFHemLrlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AASbwGr5Oro6JP7gcoTrRxSUJ8sYEaW3tWbYk+dSLnk4ZLAapq3IH5uHiTvQBp/XOwIwMh8QMywYReW7A/md0hZnpUrd/wYFLxQWTz1LV7izDg47/ULH1w1m1YcEzuqxliJUa1TVOZut8tCzwySfu7mk14kaqLkFvq3ksAf43P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHQFAzYm; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-81023efbe36so1366752241.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 15:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720563612; x=1721168412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8Czy7doaX+k4ZwzWElj3/dmGSVBZ1YnkOPpAJR0P1k=;
        b=MHQFAzYmETjOqcop4McVCjK1yyQZrvOWOQ/oKVbyUfDErk2gploqpvt9YbKaLF++zn
         U8vLPHV2lwiTjhd0ie15Rgc/Q8voag7sULLeP7UfaVBddBE8aX5seHLTIFpHUoRcGhQ6
         sb+3V49FPemL+qxlju2Pmp57jOT6MwKjPCdChZP0KxkvwdVrTRUUtTo47cXguQ8EXksw
         d0tpjytROcGCQ2JL9zaIL4KrSG/5LyX4aU7e5r9Hp3wgDaEfRyzhlgmWIJDoMbZdEzXa
         3cB2yMQAupwYzQoTc2AlOe19XJ3wpeW6LSGs5m1SZPP2TCOlRv3BMynyDLnPeYNeN7fW
         krpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720563612; x=1721168412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8Czy7doaX+k4ZwzWElj3/dmGSVBZ1YnkOPpAJR0P1k=;
        b=s0+akXgzBiaO7+PUc5w8L+v9OWg6a8Poq0UetTLz/H5C0sQQZ66NmXPR9xtLGsRdAP
         lPeP1oYFxulhPWaFCWj+U1lAQYH46QvoW/7lpMwwawO6KdzLOoRRDVlZeVnkf+QZbdPi
         AvSnIo0E9QVhjIIN+OuramZyZefJ/PEmZNpaZ63fOk+vw5BuZZuhj0ZWa9yg0FydEvew
         wH/wC1+T+uJMs0IONy26/tZArEo2b+Royq0XaCxsaZr7M3zi+weg7r3FPHdJfi6KVEOx
         YzcPJHvTwDvdjSIACi3WHzESCLI4Wj1ODutty8c+GJMikm3D4gLHNusAxjwhWVh/IIbx
         jWTA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ9t8q2Jfs1aihiV3WR0Iwc4RUzRT4s4aaVQy1QX9ysbXUXkcmZdvYnXiTsR8aTf19zMhxXsraK92Px9487oG4T55/cwVB+U7psj+u
X-Gm-Message-State: AOJu0YwywBC8Inqblp0B9z/I+nqllCuKu+tE6F8N86np/xV0QTEv87hY
	Vz1kXMwrBNT3zFOer57qEglukxUR46ELTeTrOc9pymVJfkXtuOXwCB7LqxzH82SO1LcNgzS3fC5
	E1DvZY1VPVmgf2SsqPNAwFGTxbuo=
X-Google-Smtp-Source: AGHT+IErL4gRn1VUDNYOKxDX+Hizc+WQ3e6bmzEUKMPWNueaUxvSd5CsMaZNbrn4mHAW15yv9vTChUtedadBTRTWfCk=
X-Received: by 2002:a05:6102:d92:b0:48f:3bcf:58a5 with SMTP id
 ada2fe7eead31-4903219912bmr3494848137.19.1720563612615; Tue, 09 Jul 2024
 15:20:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240704010121epcms2p4cff8b25d976d4a1b820ba18f1eb5aa90@epcms2p4>
 <20240704010121epcms2p4cff8b25d976d4a1b820ba18f1eb5aa90@epcms2p4> <460c4708-3ec6-4fbc-8f6c-7f8e5f901061@kernel.org>
In-Reply-To: <460c4708-3ec6-4fbc-8f6c-7f8e5f901061@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Tue, 9 Jul 2024 15:20:01 -0700
Message-ID: <CACOAw_yP2himsj6YuE4vmpGebadHe+PtkLQyP8ZJRZSPkn6m7A@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix null reference error when checking
 end of zone
To: Chao Yu <chao@kernel.org>
Cc: daejun7.park@samsung.com, "jaegeuk@kernel.org" <jaegeuk@kernel.org>, 
	"daehojeong@google.com" <daehojeong@google.com>, 
	"linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nayeon Kim <nayeoni.kim@samsung.com>, 
	Siwoo Jung <siu.jung@samsung.com>, Seokhwan Kim <sukka.kim@samsung.com>, 
	Dongjin Kim <dongjin_.kim@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 12:17=E2=80=AFAM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/7/4 9:01, Daejun Park wrote:
> > This patch fixes a potentially null pointer being accessed by
> > is_end_zone_blkaddr() that checks the last block of a zone
> > when f2fs is mounted as a single device.
>
> blkzoned feature depends on multiple device feature? One regular
> device and one seq-zone device?
>
> Thanks,
>
> >
> > Fixes: e067dc3c6b9c ("f2fs: maintain six open zones for zoned devices")
> > Signed-off-by: Daejun Park <daejun7.park@samsung.com>
> > ---
> >   fs/f2fs/data.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index b6dcb3bcaef7..1aa7eefa659c 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -925,6 +925,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
> >   #ifdef CONFIG_BLK_DEV_ZONED
> >   static bool is_end_zone_blkaddr(struct f2fs_sb_info *sbi, block_t blk=
addr)
> >   {
> > +     struct block_device *bdev =3D sbi->sb->s_bdev;
> >       int devi =3D 0;
> >
> >       if (f2fs_is_multi_device(sbi)) {
> > @@ -935,8 +936,9 @@ static bool is_end_zone_blkaddr(struct f2fs_sb_info=
 *sbi, block_t blkaddr)
> >                       return false;
> >               }
> >               blkaddr -=3D FDEV(devi).start_blk;
> > +             bdev =3D FDEV(devi).bdev;
> >       }
> > -     return bdev_is_zoned(FDEV(devi).bdev) &&
> > +     return bdev_is_zoned(bdev) &&
> >               f2fs_blkz_is_seq(sbi, devi, blkaddr) &&
> >               (blkaddr % sbi->blocks_per_blkz =3D=3D sbi->blocks_per_bl=
kz - 1);
> >   }
>

Reviewed-by: Daeho Jeong <daehojeong@google.com>

Thanks,


>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

