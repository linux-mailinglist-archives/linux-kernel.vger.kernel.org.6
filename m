Return-Path: <linux-kernel+bounces-370806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEB49A3246
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 03:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 753421C21DA9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 01:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BEE55E53;
	Fri, 18 Oct 2024 01:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvE+0QO5"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC639383B1
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 01:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729216393; cv=none; b=ZQO8fAg9uY+lu52TpHia9LMWncf82Qj6VxyPIi3S0qe0SVVsIGWlK/dVpXkwMq8aIkAE5Z2BsQ3+GrNVz2Xh3pTXdT3fO+fC5QNRKsbS0ldUXuLDBFc/yhZWPS2TNjMqZYmqwqV09XmLm/KHW/F8uNVW/CtYhtbZkQ8M05qplwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729216393; c=relaxed/simple;
	bh=EeKpX7NUZUq8zMtV7FB9erh3TKxGrsk1Lw/mghF0G3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aXdjpr+Iai6ncOnfkEN2PtcCr5YYnr4G0xM33cAm3XkwJzqr5pMgrauyo1nt0yrXPw00+1ZXZ2U8NhjCMK/12+klhrUT/9PGV6PmDjNu9t1o+CPrvMmQMcyEjwejzHGwKmAEpidJ5VySAzoeAoumOo2if0yOz8L3VyMteZ261kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvE+0QO5; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4314ff68358so2636745e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 18:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729216390; x=1729821190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zSHdJlPUbayXLLcfATCEIdb8eH6mankQ/VadBAff7g=;
        b=FvE+0QO5EGm6P+HfSCcAlyVE8A9Ukl0gr3Ykl1Cq3pWmxxfjiXZRRd6ug2k0xpqrm1
         vVsZgx63vTBfp/aVuWD6u6r8+WhQPs/nEvnDrbGSEfDkt55jPfx2txeDeL/9OpljFiV9
         igahLb/lq08NMaEPsd3slagBNH0LXCgwPVWc5be9zxY3oU8t3F+xSqEOq7CZpi8N6MAu
         F3gz6AB8XO0673kIdIQ6X/LvbChvth4HVUhsQ0Ed3QC6d+xbyvvay3aQeOpeHTCYm2DV
         jgui+S+ABsH8OsebphlKx/dtmFevIZs+CBCwDFU8dnVVj4bM9AZHAsfaBIW4NMWXMu/A
         iP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729216390; x=1729821190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1zSHdJlPUbayXLLcfATCEIdb8eH6mankQ/VadBAff7g=;
        b=W35QaXfcj3gpc2sITVBkI2C912t0LSfxKMVJbZDWMuJJf90ECovJ9BcKgHVNaBoOy2
         kdVqJiZJ0Fm4wa78bc6Z96C3DL5gigKPLktP3ClQKQOEp4Jzmmtv2mJtn5GNdq+FytId
         XcMmDtnHbNYtcNjJDyzY1J/yikPcspjqs4+341er/H6O0Suchh0fZRaWlzJ1xxE4jU39
         gJsLIkm0znCf7LZDzaU1lxZb3IsmF2TgzeP4T5u6NHpIYsAVDFBTvwI8Tryl+ERqQ8gW
         RXuokmDW4T26rga79ks/I+iYH2Z55k3rZuUo+jzKT6br0I0Otps2zx+JieBvnToP9oTs
         wY4g==
X-Forwarded-Encrypted: i=1; AJvYcCVcTz9YMwdaXt02x/QWjTbIdD8N4g8oCyeMy1kmZSmMjoLTLWfvnG2wuGKi217fCRSi+H4GW3RN8nmHU1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwwhcyD/TXx2F+M4ROnoECaxPbqClDdru7dX2Zec9Fr2zGaedt
	GH9MzmGy7q2zIKz06wppE2+X5OlhctoFOUXzX7PBQR9EMCWKw+y1bbQCIvchinrqcEfjINq3dKa
	LJIsNSojcGyqQPwkDSGEs/RyFqiQ=
X-Google-Smtp-Source: AGHT+IFW22XGmxmpGx3e2cHqyt8VryX3WIKRioJuCFz5mCW9CyRfz8JruPy/YmT26mUzckqqU1NlUWv/HMqLMLId5C0=
X-Received: by 2002:a5d:6481:0:b0:37d:468c:1f38 with SMTP id
 ffacd0b85a97d-37eab715171mr258721f8f.12.1729216389794; Thu, 17 Oct 2024
 18:53:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009102745.1390935-1-hanqi@vivo.com> <bdd890de-4794-4133-bca1-9c7e067e6e5c@kernel.org>
In-Reply-To: <bdd890de-4794-4133-bca1-9c7e067e6e5c@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Fri, 18 Oct 2024 09:52:58 +0800
Message-ID: <CAHJ8P3KhfuCSNwyc16QYQQYMNzjVKc4ey5CTZ2XK4893aW4mCQ@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: modify f2fs_is_checkpoint_ready logic to
 allow more data to be written with the CP disable
To: Chao Yu <chao@kernel.org>
Cc: Qi Han <hanqi@vivo.com>, jaegeuk@kernel.org, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
=E4=BA=8E2024=E5=B9=B410=E6=9C=8817=E6=97=A5=E5=91=A8=E5=9B=9B 17:57=E5=86=
=99=E9=81=93=EF=BC=9A
>
> On 2024/10/9 18:27, Qi Han wrote:
> > When the free segment is used up during CP disable, many write or
> > ioctl operations will get ENOSPC error codes, even if there are
> > still many blocks available. We can reproduce it in the following
> > steps:
> >
> > dd if=3D/dev/zero of=3Df2fs.img bs=3D1M count=3D55
> > mkfs.f2fs -f f2fs.img
> > mount f2fs.img f2fs_dir -o checkpoint=3Ddisable:10%
> > cd f2fs_dir
> > dd if=3D/dev/zero of=3Dbigfile bs=3D1M count=3D50
> > sync
> > rm bigfile
> > i=3D1; while [[ $i -lt 10000000 ]]; do (file_name=3D./file$i; dd \
> > if=3D/dev/random of=3D$file_name bs=3D1M count=3D0); i=3D$((i+1)); done
> > stat -f ./
> >
> > In f2fs_need_SSR() function, it is allowed to use SSR to allocate
> > blocks when CP is disabled, so in f2fs_is_checkpoint_ready function,
Hi Chao and Qi,
based on this comment  and codes, I have some doubts:
unusable blocks are calculated  from  invalid blocks of Dirty segment
in f2fs_get_unsuable_blocks then minus ovp_hole,
but SSR is allowed when the checkpoint is disabled.
So actually SSR can not use most invalid blocks of Dirty segments?
Is this a contradiction?
Thanks!

> > can we judge the number of invalid blocks when free segment is not
> > enough, and return ENOSPC only if the number of invalid blocks is
> > also not enough?
>
> Can you please try below patch?
>
>  From 38b7c97dcc55ba83de4220c3dc54c2eb66148dd5 Mon Sep 17 00:00:00 2001
> From: Chao Yu <chao@kernel.org>
> Date: Thu, 17 Oct 2024 17:07:05 +0800
> Subject: [PATCH] f2fs: revalidate empty segment when checkpoint is disabl=
ed
>
> If checkpoint is off, let's set segment as free once all newly
> written datas were removed.
>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>   fs/f2fs/segment.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index f8d6e601e084..9bad13d70afb 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -853,6 +853,17 @@ static void locate_dirty_segment(struct f2fs_sb_info=
 *sbi, unsigned int segno)
>         valid_blocks =3D get_valid_blocks(sbi, segno, false);
>         ckpt_valid_blocks =3D get_ckpt_valid_blocks(sbi, segno, false);
>
> +       /*
> +        * If checkpoint is off, let's set segment as free once all newly
> +        * written datas were removed.
> +        */
> +       if (is_sbi_flag_set(sbi, SBI_CP_DISABLED) &&
> +               valid_blocks =3D=3D 0 && ckpt_valid_blocks =3D=3D 0) {
> +               __remove_dirty_segment(sbi, segno, DIRTY);
> +               __set_test_and_free(sbi, segno, false);
> +               goto out_lock;
> +       }
> +
>         if (valid_blocks =3D=3D 0 && (!is_sbi_flag_set(sbi, SBI_CP_DISABL=
ED) ||
>                 ckpt_valid_blocks =3D=3D usable_blocks)) {
>                 __locate_dirty_segment(sbi, segno, PRE);
> @@ -863,7 +874,7 @@ static void locate_dirty_segment(struct f2fs_sb_info =
*sbi, unsigned int segno)
>                 /* Recovery routine with SSR needs this */
>                 __remove_dirty_segment(sbi, segno, DIRTY);
>         }
> -
> +out_lock:
>         mutex_unlock(&dirty_i->seglist_lock);
>   }
>
> --
> 2.40.1
>
> >
> > Signed-off-by: Qi Han <hanqi@vivo.com>
> > ---
> >   fs/f2fs/segment.h | 21 +++++++++++++++++++++
> >   1 file changed, 21 insertions(+)
> >
> > diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> > index 71adb4a43bec..9bf0cf3a6a31 100644
> > --- a/fs/f2fs/segment.h
> > +++ b/fs/f2fs/segment.h
> > @@ -637,12 +637,33 @@ static inline bool has_enough_free_secs(struct f2=
fs_sb_info *sbi,
> >       return !has_not_enough_free_secs(sbi, freed, needed);
> >   }
> >
> > +static inline bool has_enough_available_blocks(struct f2fs_sb_info *sb=
i)
> > +{
> > +     unsigned int total_free_blocks =3D sbi->user_block_count -
> > +                                     valid_user_blocks(sbi) -
> > +                                     sbi->current_reserved_blocks;
> > +
> > +     if (total_free_blocks <=3D sbi->unusable_block_count)
> > +             total_free_blocks =3D 0;
> > +     else
> > +             total_free_blocks -=3D sbi->unusable_block_count;
> > +
> > +     if (total_free_blocks > F2FS_OPTION(sbi).root_reserved_blocks)
> > +             total_free_blocks -=3D F2FS_OPTION(sbi).root_reserved_blo=
cks;
> > +     else
> > +             total_free_blocks =3D 0;
> > +
> > +     return (total_free_blocks > 0) ? true : false;
> > +}
> > +
> >   static inline bool f2fs_is_checkpoint_ready(struct f2fs_sb_info *sbi)
> >   {
> >       if (likely(!is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
> >               return true;
> >       if (likely(has_enough_free_secs(sbi, 0, 0)))
> >               return true;
> > +     if (likely(has_enough_available_blocks(sbi)))
> > +             return true;
> >       return false;
> >   }
> >
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

