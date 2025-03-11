Return-Path: <linux-kernel+bounces-556960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 424B6A5D194
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 22:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 767FE17CA67
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE357264634;
	Tue, 11 Mar 2025 21:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoAMpjpN"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB9A1EF368
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 21:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741727668; cv=none; b=GeCXl6GXJFo+X9632iTtTl1bouMuvB/fi/MDAdDea38vBBib0A4q7KDxguMvpVaPClTUIWLr9jXZQZNiLPHp5zU34xWmInsqgGZYM0FDXBMI85r3s59dkM2aIdSCkWTFhahKTz90z3XOCd770BCWBzHSVv8GMAaesd5YYHPwCBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741727668; c=relaxed/simple;
	bh=mhb4mSlubHco2O5bi8isNMQT3UyvMofllvqXr9VqKy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XWfBuBAUDgPOiqdkAaSyCeP3wFiKShwxr1k8B7vW5stwyHUigbgw4PiKlOh454iF/KLtqARQadqE4ZTRsmMD4yooEuGe/XYglciXImadtbn9r8yB0WJpb1Tok0PDOm0ZkmxJVhQAtPB9+SYjwWLcGQ3QUoYJoyqeY1Au3M9pRdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoAMpjpN; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-523fa0df55dso196539e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 14:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741727665; x=1742332465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqG9kUgxbEXYOd4Ek5PA84ITaxaQkSg317PvkX7yUco=;
        b=HoAMpjpNw84ui/qputeXIpXpLFFi3fZGzKDB2bg7OnkabZOkMoqy3UjRnaO+Im+1kF
         VXTQFMoqmI6XPPeZgs66i+C9ab974H7ocvNJIyvlBjQ0he+TQN5sfFdV7/ztMhuEH95r
         LDCN1riRQRAJGBIiz4rvpqqI9MOpwkQV+cYIWG6XctcldkpSSgCxcc+9b0dKrsvnPECf
         swgt96vTrGSR2t0qsRimu05XJK63IfupQ5i8qZwJAU3g2g7OgS8n1BOVjzoQ8KjiDLZ+
         c+ZaCO/QiH1qSWXMuIy/rt7qkSRYiuN3+DloZlwMxG2wkpCOGLZKgjUl6xg81jfMPxHn
         f9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741727665; x=1742332465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KqG9kUgxbEXYOd4Ek5PA84ITaxaQkSg317PvkX7yUco=;
        b=mIeuUnNl5YVNswTNPgeSsxB56g+Ic4QfQfwqmD2802IES39obVdOPdWIesPqBuJrjg
         bl/qI0MDqbDGVc4+E/w8Fs+voieojJEQQczMYH+/ru3Ljll0Zx/saDI+jvLyW+HhQ7O0
         PHM2+f402kPJKeU9yeAdLMCLizfNq5d6n2ej1+3yBA9ozqjzNl4x22hWBuMbhIVhJtCc
         Y9u9BsPoCqNd9O8Wiw5N0creI3TxTBVX5sH930jd8MrAl4z4kAfvkkJT+3CzHhcoMMNP
         KvKkGnNjGnr1OZ5NZUcCcPdsRpEuMOFwZ7H1CZcPqc7+MNPvXfdhweleCRfYK7pO1bnn
         hbbQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5wqa1umkTzqO5OwrksHln4NFi4Z75Rz2xXCexKYxDzoGBPOGs38JU6Yalt/7QRs9y82uR34BRFksiKxU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf5N6ZZzF87Mbp0GwodgyB8WXoMlL4det4G2d2POwVcxJwg/kV
	mYePjFJqORuRa/pCyAibRnS22NnP8Ojs4TVRuu1ZYtMuO2XOB56F3qLEEAX9TOmyGFlm+LE2pk8
	mchbJz59ZBt55xB+h3XPKHyy/65U=
X-Gm-Gg: ASbGncv4T5G5OWwzxpNwcmDMUypKPoJkNOED3NFTKNlYalAqRyJECmNo8/mdt6GN42x
	L5k0SUW1sAxnASIkkJ5Um7n2zRfz5LBry9+mquZeYj5/6oK3ixRYAFummRf55TpNkK+TQzm786n
	i3c5JsImOwQYkcZ1/6Nq83Ggz/mFLtUMJnGLjiBCzqx6leC3H5cM43ZkZuTdxjRKTLYsE=
X-Google-Smtp-Source: AGHT+IFMsde9kvz9H2hxN5DQBfoQp771NI4YPU2fCSbpSU7y5AZg+O2+KCDLzGQgK8dbzCFlcN7nDu/O4TTQBw25VCQ=
X-Received: by 2002:a05:6122:1e0e:b0:51f:a02b:45d4 with SMTP id
 71dfb90a1353d-5241964dce9mr3552653e0c.1.1741727665352; Tue, 11 Mar 2025
 14:14:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307145650.568-1-yohan.joung@sk.com> <936351d5-e99c-4c5b-bd8b-8d541122f709@kernel.org>
In-Reply-To: <936351d5-e99c-4c5b-bd8b-8d541122f709@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Tue, 11 Mar 2025 14:14:14 -0700
X-Gm-Features: AQ5f1JpHNXduvvfjOezKagK1wrXMn2WxKuf9wrSzfMefo1jaJhijXiqOWL2NafM
Message-ID: <CACOAw_xpcjaSPXTrPaZZzed6UbfLpdBEww8HDmUHU3yacaq7sg@mail.gmail.com>
Subject: Re: [PATCH] f2fs: optimize f2fs DIO overwrites
To: Chao Yu <chao@kernel.org>
Cc: Yohan Joung <jyh429@gmail.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	Yohan Joung <yohan.joung@sk.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 5:00=E2=80=AFAM Chao Yu <chao@kernel.org> wrote:
>
> On 3/7/25 22:56, Yohan Joung wrote:
> > this is unnecessary when we know we are overwriting already allocated
> > blocks and the overhead of starting a transaction can be significant
> > especially for multithreaded workloads doing small writes.
>
> Hi Yohan,
>
> So you're trying to avoid f2fs_map_lock() in dio write path, right?
>
> Thanks,
>
> >
> > Signed-off-by: Yohan Joung <yohan.joung@sk.com>
> > ---
> >  fs/f2fs/data.c | 20 ++++++++++++++++++++
> >  fs/f2fs/f2fs.h |  1 +
> >  fs/f2fs/file.c |  5 ++++-
> >  3 files changed, 25 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 09437dbd1b42..728630037b74 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -4267,6 +4267,26 @@ static int f2fs_iomap_begin(struct inode *inode,=
 loff_t offset, loff_t length,
> >       return 0;
> >  }
> >
> > +static int f2fs_iomap_overwrite_begin(struct inode *inode, loff_t offs=
et,
> > +             loff_t length, unsigned flags, struct iomap *iomap,
> > +             struct iomap *srcmap)
> > +{
> > +     int ret;
> > +
> > +     /*
> > +      * Even for writes we don't need to allocate blocks, so just pret=
end
> > +      * we are reading to save overhead of starting a transaction.
> > +      */
> > +     flags &=3D ~IOMAP_WRITE;
> > +     ret =3D f2fs_iomap_begin(inode, offset, length, flags, iomap, src=
map);
> > +     WARN_ON_ONCE(!ret && iomap->type !=3D IOMAP_MAPPED);
> > +     return ret;
> > +}
> > +
> >  const struct iomap_ops f2fs_iomap_ops =3D {
> >       .iomap_begin    =3D f2fs_iomap_begin,
> >  };
> > +
> > +const struct iomap_ops f2fs_iomap_overwrite_ops =3D {
> > +     .iomap_begin    =3D f2fs_iomap_overwrite_begin,
> > +};
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index c6cc2694f9ac..0511ab5ed42a 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -3936,6 +3936,7 @@ void f2fs_destroy_post_read_processing(void);
> >  int f2fs_init_post_read_wq(struct f2fs_sb_info *sbi);
> >  void f2fs_destroy_post_read_wq(struct f2fs_sb_info *sbi);
> >  extern const struct iomap_ops f2fs_iomap_ops;
> > +extern const struct iomap_ops f2fs_iomap_overwrite_ops;
> >
> >  static inline struct page *f2fs_find_data_page(struct inode *inode,
> >               pgoff_t index, pgoff_t *next_pgofs)
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 82b21baf5628..bb2fe6dac9b6 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -4985,6 +4985,7 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *=
iocb, struct iov_iter *from,
> >       const ssize_t count =3D iov_iter_count(from);
> >       unsigned int dio_flags;
> >       struct iomap_dio *dio;
> > +     const struct iomap_ops *iomap_ops =3D &f2fs_iomap_ops;
> >       ssize_t ret;
> >
> >       trace_f2fs_direct_IO_enter(inode, iocb, count, WRITE);
> > @@ -5025,7 +5026,9 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *=
iocb, struct iov_iter *from,
> >       dio_flags =3D 0;
> >       if (pos + count > inode->i_size)
> >               dio_flags |=3D IOMAP_DIO_FORCE_WAIT;
> > -     dio =3D __iomap_dio_rw(iocb, from, &f2fs_iomap_ops,
> > +     else if (f2fs_overwrite_io(inode, pos, count))
> > +             iomap_ops =3D &f2fs_iomap_overwrite_ops;
> > +     dio =3D __iomap_dio_rw(iocb, from, iomap_ops,
> >                            &f2fs_iomap_dio_write_ops, dio_flags, NULL, =
0);
> >       if (IS_ERR_OR_NULL(dio)) {
> >               ret =3D PTR_ERR_OR_ZERO(dio);

I think we can add the overwrite check in f2fs_iomap_begin() before
setting the map.m_may_create, instead of adding a new function
f2fs_iomap_overwrite_begin().
What do you think?

>

