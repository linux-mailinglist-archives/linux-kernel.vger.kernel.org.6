Return-Path: <linux-kernel+bounces-379749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CC29AE327
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE3201F23152
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4A11C75FA;
	Thu, 24 Oct 2024 10:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5is9arf"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB541C07F3
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 10:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767495; cv=none; b=JZyRhqX5m0U9T6xneasLdXzDdkZfGU69TpF4RAZDVGTKPqHNxB+aDMK2EGLPku5Q67XG/ZS+4zkD395iY+KtG3tveI1+H3I0wBeCBCDpgPoBxzC/K8pbEmsGezrt22VkVeU7dPV1Vzy9TO/V1+6uwHjBzIaR0Cs4icLas71me6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767495; c=relaxed/simple;
	bh=fH/avE1wCiXE0JKUS41iySaag9GfaWjZ+91HXVlG2Gc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GY1COn57Jy5HEQbDKky2ab0JCQj92J6f1XN6JsMlBofk4qwnH+gyVDgMiRETxALpqThLRxcbF7w9js61Yv2R+QrlskPKbF5+awpwq1hb5IZx1ftsrfxpzI5u1yfReW9IMLQmaLIfH2gIXtWy7usm4T9tSzR6/CiikXG2lO/nJnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5is9arf; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43159469053so964255e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 03:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729767491; x=1730372291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zv4SMHXvV0Lwj3C1Vjp7KHVDJuw2pOpFawGmV23O5A=;
        b=M5is9arf+jlhPDjFR7BKHGJnWvDyemzfiXltDC+5x0Usb1H9ywZk6WYPnutmMb1Hft
         k+ko8BOzu9x7UTVmhPWhHIUH4DcjpQp/X8S2p2NuOysgGBPbGTPKj5pv68eZ7M239fK9
         odoGwG4bvnS+uHN+2yJTrn5VPno2JgBFzhepssooxIfjewX38yuPEBReh1e4RUaBzfR4
         74uo0DLiLd9ijv1q9N7TcrVJ+OM9SJ5XsPgtb974Mw/93BulD3QJrZv5A9JZWiYnX3zh
         qngrEXQkU3va6gY42lk5+fV1UAhXhLGWN4OOtNaapeKGDsxLM8EmSYVdiz6QO7txS42f
         7p6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729767491; x=1730372291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zv4SMHXvV0Lwj3C1Vjp7KHVDJuw2pOpFawGmV23O5A=;
        b=euB+wjqIdHH1+xKUhqwA0yxkjKluNdNGGlhUV17l3hv0qSHdoyjd1rpHs1KPjVfCtH
         V7AWX/KCw810c08+SM7BlFi5v2ItA0EYqfXRzTSoPjWwVnAXVEnAoL16dPieXbdTSTEn
         pW4b+4n460325jQ7OkMjWfNN0e5sfoXROgqTCzbk6VpjQyxXi6VbKqBbX1lPMv98otYl
         s8HNwEFMADjWMoNUHESKeRaGm1W/oikeUc6m+pbBxhfJa21Cl+VWHHoMqCRE5MbLkK5s
         bTKmTtUEH8wmizd+BpBlppCQUsW9zxHXaxMX0axPM3SE35FO90IT+QzzojMwI3dk1qXm
         FZ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXGZ6B/brbGSxbSL2/OphccoAVDVYRcuLkWYdazDIxhe4YhonXPfB/Bo3tQj5kEWfStNjkM+GsTV1+mzl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwktVBVCNzMXR5oVI3DVQNCks8DsMaIvPCTwga7R13knDp1of62
	3f7YdpETnAlHdI69jGT/fv1m7sf32JlRSYFikdKPblXHIbaGzaKY7x80ZstC9wQKc+CuKg2ki5Z
	yDBKQ1sBXyDI+23YGmRnoYEp5X10=
X-Google-Smtp-Source: AGHT+IF3V+ObpOWRQ5gjk0uIrskTuM/wJAHieZfGNYPmC6LXK/5o/EYX7DdEOnP8BUfj1Xd60A26cASjhsbWE27wUG4=
X-Received: by 2002:a05:600c:350f:b0:42c:b9c8:2b95 with SMTP id
 5b1f17b1804b1-431841a3515mr22899395e9.6.1729767490993; Thu, 24 Oct 2024
 03:58:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1729762134-380-1-git-send-email-zhiguo.niu@unisoc.com> <a224e560-2937-4edd-93d8-8077de6054b1@kernel.org>
In-Reply-To: <a224e560-2937-4edd-93d8-8077de6054b1@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Thu, 24 Oct 2024 18:57:59 +0800
Message-ID: <CAHJ8P3J+OZHhKNSSXc_RM8Xn=1nvfCk8_rqknjXsq==VpvuFPQ@mail.gmail.com>
Subject: Re: [PATCH] f2fs-tools: correct some confused desc about unit
To: Chao Yu <chao@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, Hao_hao.Wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B410=E6=9C=8824=E6=97=A5=E5=
=91=A8=E5=9B=9B 18:49=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2024/10/24 17:28, Zhiguo Niu wrote:
> > F2FS_BLKSIZE may be 4KB, 16KB, so use F2FS_BLKSIZE to replace
> > some hardcode desc about unit in some f2fs_io cmd, also
> > adjust "-c" parameters in mkfs man, to be consistent with
> > commit c35fa8cd75ac ("mkfs.f2fs: change -c option description").
> >
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > ---
> >   man/mkfs.f2fs.8         | 2 +-
> >   tools/f2fs_io/f2fs_io.c | 6 +++---
> >   2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/man/mkfs.f2fs.8 b/man/mkfs.f2fs.8
> > index de885be..8b3b0cc 100644
> > --- a/man/mkfs.f2fs.8
> > +++ b/man/mkfs.f2fs.8
> > @@ -122,7 +122,7 @@ block size matches the page size.
> >   The default value is 4096.
> >   .TP
> >   .BI \-c " device-list"
> > -Build f2fs with these additional comma separated devices, so that the =
user can
> > +Build f2fs with these additional devices, so that the user can
> >   see all the devices as one big volume.
> >   Supports up to 7 devices except meta device.
> >   .TP
> > diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
> > index 95f575f..ee4ed0e 100644
> > --- a/tools/f2fs_io/f2fs_io.c
> > +++ b/tools/f2fs_io/f2fs_io.c
> > @@ -1013,7 +1013,7 @@ static void do_randread(int argc, char **argv, co=
nst struct cmd_desc *cmd)
> >
> >   #define fiemap_desc "get block address in file"
> >   #define fiemap_help                                 \
> > -"f2fs_io fiemap [offset in 4kb] [count in 4kb] [file_path]\n\n"\
> > +"f2fs_io fiemap [offset in F2FS_BLKSIZE] [count in F2FS_BLKSIZE] [file=
_path]\n\n"\
> >
> >   #if defined(HAVE_LINUX_FIEMAP_H) && defined(HAVE_LINUX_FS_H)
> >   static void do_fiemap(int argc, char **argv, const struct cmd_desc *c=
md)
> > @@ -1617,8 +1617,8 @@ static void do_move_range(int argc, char **argv, =
const struct cmd_desc *cmd)
> >   #define gc_range_desc "trigger filesystem gc_range"
> >   #define gc_range_help "f2fs_io gc_range [sync_mode] [start] [length] =
[file_path]\n\n"\
> >   "  sync_mode : 0: asynchronous, 1: synchronous\n"                   \
> > -"  start     : start offset of defragment region, unit: 4kb\n"       \
> > -"  length    : bytes number of defragment region, unit: 4kb\n"       \
> > +"  start     : start offset of defragment region, unit: F2FS_BLKSIZE\n=
"      \
> > +"  length    : bytes number of defragment region, unit: F2FS_BLKSIZE\n=
"      \
>
> I think we'd better unify default block size to 4096 since in most of
> places in f2fs_io.c, we use 4096 as default IO/buffer size.
>
> git grep -n "4096" tools/f2fs_io/f2fs_io.c
> tools/f2fs_io/f2fs_io.c:212:    args.block_size =3D 4096;
> tools/f2fs_io/f2fs_io.c:662:    buf_size =3D bs * 4096;
> tools/f2fs_io/f2fs_io.c:666:    buf =3D aligned_xalloc(4096, buf_size);
> tools/f2fs_io/f2fs_io.c:877:    buf_size =3D bs * 4096;
> tools/f2fs_io/f2fs_io.c:881:    buf =3D aligned_xalloc(4096, buf_size);
> tools/f2fs_io/f2fs_io.c:901:            if (posix_fadvise(fd, 0, 4096, PO=
SIX_FADV_SEQUENTIAL) !=3D 0)
> tools/f2fs_io/f2fs_io.c:903:            if (posix_fadvise(fd, 0, 4096, PO=
SIX_FADV_WILLNEED) !=3D 0)
> tools/f2fs_io/f2fs_io.c:979:    buf_size =3D bs * 4096;
> tools/f2fs_io/f2fs_io.c:981:    buf =3D aligned_xalloc(4096, buf_size);
> tools/f2fs_io/f2fs_io.c:994:    aligned_size =3D (u64)stbuf.st_size & ~((=
u64)(4096 - 1));
> tools/f2fs_io/f2fs_io.c:997:    end_idx =3D (u64)(aligned_size - buf_size=
) / (u64)4096 + 1;
> tools/f2fs_io/f2fs_io.c:1004:           ret =3D pread(fd, buf, buf_size, =
4096 * idx);
> tools/f2fs_io/f2fs_io.c:1222:           char *buf =3D aligned_xalloc(4096=
, 4096);
> tools/f2fs_io/f2fs_io.c:1224:           while ((ret =3D xread(src_fd, buf=
, 4096)) > 0)
>
> git grep -n "F2FS_BLKSIZE" tools/f2fs_io/f2fs_io.c
> tools/f2fs_io/f2fs_io.c:1034:   start =3D (u64)atoi(argv[1]) * F2FS_BLKSI=
ZE;
> tools/f2fs_io/f2fs_io.c:1035:   length =3D (u64)atoi(argv[2]) * F2FS_BLKS=
IZE;
> tools/f2fs_io/f2fs_io.c:1042:                           start / F2FS_BLKS=
IZE, length / F2FS_BLKSIZE);
>
> We can add a new macro F2FS_DEFAULT_BLKSIZE and use it instead of magic
> number and F2FS_BLKSIZE, what do you think?
Dear Chao,
It is a good  suggestions,  will update it.
now it is a little confused when I use f2fs_io fiemap in 16KB page system. =
^^
thanks!
>
> Thanks,
>
> >
> >   static void do_gc_range(int argc, char **argv, const struct cmd_desc =
*cmd)
> >   {
>

