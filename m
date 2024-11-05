Return-Path: <linux-kernel+bounces-395870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA069BC42E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 05:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81B9D1C211B8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 04:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0020218873A;
	Tue,  5 Nov 2024 04:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ygy45SAK"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A351885AA
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 04:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730779380; cv=none; b=gUmhosRy42iaJ8v5A/SqVhmGF0BnD1GWZ9fP8+91H2SwBC2bfBt3KdRCSqQas1P0uJlAC0ysSyHibSt6hb+1L6qxH5/9MSZxNJrzLJsWwWSafgS0sqVdtrcKcrzLesnc/4Q6EcPqMw8+Gx4pbzQjNkInVTk5egupW+QPfUXhvKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730779380; c=relaxed/simple;
	bh=URGX7UNkO6Wq2uX58kruJx1Xl1044sWpXGFarX5ImV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qVks9OW/Ae3RX0GHdZVORaUF1qllyazpp2y2xSTcbgJhDRUJ6KeZ83sYZO6RaivM23jMGWYjWFCSZqC/SWW1yVJRU21zZF2fiQI+0yHxIj3bVtIm8T5XRCF8kDPr35ljiFUXi6PObzwl60hJ/0am68I+i4wZXLyPRs+tnmBE/zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ygy45SAK; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d4ddd7ac1so459899f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 20:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730779377; x=1731384177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBEt5P6xYcA5S7b/BGrFed1Q52573hHqNiv7t7aKqrA=;
        b=Ygy45SAKGph580JiORNZOrTOoS5W92yFyf8SDA7N6ICj74h85NAFPWKiot/gU3aEad
         X4wRhsYF9eg75u+LHwrSKiiqJ6BtkLxS48cC4HTWc9ns/7MfiFeZoNwEvPu1Qpa+ol46
         dWrrXy+3QTqMxTeTnaIw6oNbpTv4YDRVr267866sIxJkW4ZZJA7jV2EXIQ0bd6Fwa2Ri
         BocxKQhcWh9uzocdv3yXdC0LvT0u0ghakWI71hvUTN18hkXuxfx0mc3ZI9EMAUBibhxv
         VRvXsCRaflbEHoIMNp7F4EfAo8eF8OKhdgaT97hRpKyoQKdRiA9juO7DAChz4ghSJLHL
         9iQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730779377; x=1731384177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eBEt5P6xYcA5S7b/BGrFed1Q52573hHqNiv7t7aKqrA=;
        b=kXy41Ve7vFmeu7MM+cucz5tezC+4ZXUYdDglKt1NBe7ASzTGXlRajtAgT23RTfZxjS
         3JSzzYZcV0m8kwDlM1DXMOZ+J+Wr/qvLYYgF+5+5xWZUemdaas/rgldkXHDyMYUvmhX+
         zXaPnCCrZHQefiDU+aIPxN4slr7qEi9yrHNEqAJfwSsY4SQSSpzmKYZNew84x1wRDh2t
         JWIwDTmks9TMMM05tD9lDj83aBAbV1g2RtrgEz5/zLhWIo6Uvo+Hd+KBPb20HSxj+pxO
         jrgv9hvkCKienWUX6PTU4svdk+y1ywq1LLFEIH2k0vn6TFxWYWHQ0AcmwhPfQ+7sJYxp
         g41Q==
X-Forwarded-Encrypted: i=1; AJvYcCXUS6XZ039TjqKyh6fJ1a3f/H18ZrpXakZTPwwHXvBkxfLCXFdjRs4DkjQMTC8QZL30QPOHYwRHR6lZgiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdVDJgxIxjqoSXuEULu5KOnXZjthe7Ljkl+el7Fd/YIgEX1bny
	ylpLLxAuFDqjiFUUQDxpid/fut1UQr7Gor6mk1G60c9mVHWEDgAary5wWdnWxY7Ev0dwDHJlYvc
	t7SIRJ8U9EAr+OlsfOef7dNltECSW60cI
X-Google-Smtp-Source: AGHT+IHdfas4uEFFjdqoAU0U4KIzi90JMz11Re/gB8Fd0gv6iAzJDcc95SKB/4HlMNsGUFjBoR1ZPUVzk2NxL8At0X0=
X-Received: by 2002:a05:600c:19c7:b0:431:5632:448d with SMTP id
 5b1f17b1804b1-4319ad76115mr134201935e9.9.1730779376546; Mon, 04 Nov 2024
 20:02:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1730685372-2995-1-git-send-email-zhiguo.niu@unisoc.com> <888aaf87-1363-4c1f-bd95-d119c72d7b30@kernel.org>
In-Reply-To: <888aaf87-1363-4c1f-bd95-d119c72d7b30@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Tue, 5 Nov 2024 12:02:45 +0800
Message-ID: <CAHJ8P3J+8xEwNL3S6JoR=E0_RczgwvHAGp8jZs5GZESza6n9LQ@mail.gmail.com>
Subject: Re: [PATCH V2] f2fs: fix to adjust appropriate length for fiemap
To: Chao Yu <chao@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, Hao_hao.Wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=885=E6=97=A5=E5=91=
=A8=E4=BA=8C 11:15=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2024/11/4 9:56, Zhiguo Niu wrote:
> > If user give a file size as "length" parameter for fiemap
> > operations, but if this size is non-block size aligned,
> > it will show 2 segments fiemap results even this whole file
> > is contiguous on disk, such as the following results:
> >
> >   ./f2fs_io fiemap 0 19034 ylog/analyzer.py
> > Fiemap: offset =3D 0 len =3D 19034
> >          logical addr.    physical addr.   length           flags
> > 0       0000000000000000 0000000020baa000 0000000000004000 00001000
> > 1       0000000000004000 0000000020bae000 0000000000001000 00001001
> >
> > after this patch:
> > ./f2fs_io fiemap 0 19034 ylog/analyzer.py
> > Fiemap: offset =3D 0 len =3D 19034
> >      logical addr.    physical addr.   length           flags
> > 0    0000000000000000 00000000315f3000 0000000000005000 00001001
>
> Hi Zhiguo,
>
> Any testcase to reproduce this bug? w/o this patch, it looks output
> from fiemap looks fine?
>
> f2fs_io fiemap 0 19034 file
> Fiemap: offset =3D 0 len =3D 19034
>         logical addr.    physical addr.   length           flags
> 0       0000000000000000 0000000004401000 0000000000005000 00001001
>
Hi Chao,
Sorry I didn't write clearly enough about the test case, and i put the
note below the ""Singed-off" tag.
let me describe it again=EF=BC=8C f2fs_io fiemap has been modified by me fo=
r
testing in my local, and  the length parameter
is the real file size of the file, not the block numer. because user
also pass the real file size to fiemap ioctl.
so with the new f2fs_io fiemap, a contiguous file on disk may be shown
2 segments if the length is not block size alinged.
such as:

ums9632_1h10:/data # ls -l ylog/ap/analyzer.py
-rw-rw-rw- 1 root system 19006 2008-01-01 00:00 ylog/ap/analyzer.py
ums9632_1h10:/data # ./f2fs_io fiemap 0 19006 ylog/ap/analyzer.py
Fiemap: offset =3D 0 len =3D 19006
        logical addr.    physical addr.   length           flags
0       0000000000000000 0000000020baa000 0000000000004000 00001000
1       0000000000004000 0000000020bae000 0000000000001000 00001001

but if we pass a length that is block size alinged, it will show one
whole segment in fiemap log.
ums9632_1h10:/data # ./f2fs_io fiemap 0 20480 ylog/ap/analyzer.py
Fiemap: offset =3D 0 len =3D 20480
        logical addr.    physical addr.   length           flags
0       0000000000000000 0000000020baa000 0000000000005000 00001001
Thanks.
> Thanks,
>
> >
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > ---
> > V2: correct commit msg according to Chao's questions
> > f2fs_io has been modified for testing, the length for fiemap is
> > real file size, not block number
> > ---
> >   fs/f2fs/data.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 306b86b0..9fc229d 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -1966,8 +1966,8 @@ int f2fs_fiemap(struct inode *inode, struct fiema=
p_extent_info *fieinfo,
> >                       goto out;
> >       }
> >
> > -     if (bytes_to_blks(inode, len) =3D=3D 0)
> > -             len =3D blks_to_bytes(inode, 1);
> > +     if (len & (blks_to_bytes(inode, 1) - 1))
> > +             len =3D round_up(len, blks_to_bytes(inode, 1));
> >
> >       start_blk =3D bytes_to_blks(inode, start);
> >       last_blk =3D bytes_to_blks(inode, start + len - 1);
>

