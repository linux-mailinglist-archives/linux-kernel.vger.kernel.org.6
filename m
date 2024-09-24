Return-Path: <linux-kernel+bounces-337603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B19F984C3B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46915285603
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 20:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D458113B5B4;
	Tue, 24 Sep 2024 20:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdMYEGjt"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A481386C6
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 20:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727210343; cv=none; b=ZOgmQ9Av3V0+2iTtbm/2PoDk9oklKFVRbfoIrjMoYAdLEsdJ+vK79qOJ1L2UiO4/gOJlIfvXlPH5dNJWHTvjEbsdOuCJEQsq0JS2hHUOUuR0LOyt2gbQF+qH91oT8KnonpZssSGWXLVLwSQACdA+0otc1EbrlpV+47wRUc5/GG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727210343; c=relaxed/simple;
	bh=CLwdTkyeC8h6qTESY/t5C91SZ7fHtv0zdnLtFpbxCcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AH7/2UiUy17O1gVE7hWgFvGTljC1bD1kzhuushNAnLqVmB0nz41WVGDnKwlJC4oaSBj44wVxi6HZ08N/8Cdg1VSEQNJ7xKnbvARbnjTQwP4yVPqdWzdLfCXTMLpTAuuDoAsZxbs5ZO/h+hJdUM9oFap/BNPkZt4GnTT+NzA4p2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdMYEGjt; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-846c44bfbe7so1199001241.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 13:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727210340; x=1727815140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9pDtP0TFeh4f8em2lTQ9/4Ega78aws9KodDKklh867Q=;
        b=PdMYEGjtw3Y4jsaOy14uBPOlG5k+zt68BxO+USrgyj9nS51SgEPL2MMzB9eTaL+Y42
         ebkcfWJ6Zx5cHbhIEAwuOveKdlN7mfmziPIwufQ3SafddJCJLnWVWu3l7nl1q8+hIUdr
         ea6W8INxHDc03HXOD5NKbc/KxFzFCBBQaVTq6edCPPUliJTDDbKocPJquMsupg/bGbZs
         60RuXHM5RNrjQzRuucOB9z2udnitcKVZIHsgSA2p4KqIKn3Ezf8ObQv8EyCQxEp03zkQ
         bBNwA7Dc6mEDESrMRozUTNFoW1Sf9Z03tMej4s6WxdNNxY4UhUDJ8m9lHlS5mGJ7MjCw
         lBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727210340; x=1727815140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9pDtP0TFeh4f8em2lTQ9/4Ega78aws9KodDKklh867Q=;
        b=YqFMCoeuyKHRuTrbq/huF2XMwdeD56QKrP69sz5liP7yvi+zp4dx5VeRq7RiEk36ET
         acj5cZkVCJbY9beyyEesS7MYxfR0OcvkCZ3jVXz9v/nr8I7Qb1jh0R35S9968uVfw1ej
         fbt775LMNraIRgml95ip5nOAMzj4EQOsemO52QNQjM5i0PBLrp3w8B0NB83IDnw6hvAe
         gVMJ9QxrptnLognK41NBhsRkUGH0D8cKfiEpvGonswlT7vkbi8gVGGTx8nnYROdWsdHh
         VE5tikLywpSc4exKEe575hvX/be7av6DlfAWjZWtvdYlZw3XGcM7mRQVyBL9ZM5gprMn
         G0Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUszf0/eHFyjO9kcPuBtiJL+w4oiuwANd36CQ4nuLhJsJM7lT0nsqNA8mKac1xWzB6qGYRKPalJOfHpBxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT1bBN+Vjn3zrOg6RHh6vraJEMBFeUeY6gPos0Fs25puR/bO5Y
	GFh9Kw/sCYQ2bX1fvjJQbjVnGRhP4Oh2DHBzL0J5HiCv0xG/J9TGUh0iK4uRZ0GnVmoxvx1j8ju
	HYRAF0TpUxjqvwb82hAxXiiQYSjE=
X-Google-Smtp-Source: AGHT+IE3/viCbvqxP6nX7bP+UETwVo3ZV3e6Mbz9lMQ8f54XnKROpQG6cTrdUZ9HbQpc7P+xHrpBXoL2LMA8d4JzmkE=
X-Received: by 2002:a05:6122:4681:b0:4ef:6865:8ffd with SMTP id
 71dfb90a1353d-505c20a4069mr768586e0c.10.1727210340321; Tue, 24 Sep 2024
 13:39:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924023007.2471817-1-chao@kernel.org>
In-Reply-To: <20240924023007.2471817-1-chao@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Tue, 24 Sep 2024 13:38:48 -0700
Message-ID: <CACOAw_y_csdZmj26C8bXNVxRirq2XBYpiFXN2EnJTTdPr6BmAQ@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: device alias: add sanity check for
 device alias inode
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 7:32=E2=80=AFPM Chao Yu via Linux-f2fs-devel
<linux-f2fs-devel@lists.sourceforge.net> wrote:
>
> Do sanity check for extent info of device alias inode, in order to
> avoid unexpected error caused by fuzz test.
>
> Cc: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>
> To Daeho and Jaegeuk,
>
> Merge this into initial patch or merge it separately is both fine
> to me.

I am going to merge this into my one. Thanks~!

>
>  fs/f2fs/extent_cache.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> index 0c8a705faa8b..5bf9e4c2b49c 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -24,6 +24,7 @@ bool sanity_check_extent_cache(struct inode *inode, str=
uct page *ipage)
>         struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
>         struct f2fs_extent *i_ext =3D &F2FS_INODE(ipage)->i_ext;
>         struct extent_info ei;
> +       int devi;
>
>         get_read_extent_info(&ei, i_ext);
>
> @@ -38,7 +39,36 @@ bool sanity_check_extent_cache(struct inode *inode, st=
ruct page *ipage)
>                           ei.blk, ei.fofs, ei.len);
>                 return false;
>         }
> -       return true;
> +
> +       if (!IS_DEVICE_ALIASING(inode))
> +               return true;
> +
> +       for (devi =3D 0; devi < sbi->s_ndevs; devi++) {
> +               if (FDEV(devi).start_blk !=3D ei.blk ||
> +                       FDEV(devi).end_blk !=3D ei.blk + ei.len)

ei.blk + ei.len -> ei.blk + ei.len - 1?

> +                       continue;
> +
> +               if (devi =3D=3D 0) {
> +                       f2fs_warn(sbi,
> +                               "%s: inode (ino=3D%lx) is an alias of met=
a device",
> +                               __func__, inode->i_ino);
> +                       return false;
> +               }
> +
> +               if (bdev_is_zoned(FDEV(devi).bdev)) {
> +                       f2fs_warn(sbi,
> +                               "%s: device alias inode (ino=3D%lx)'s ext=
ent info "
> +                               "[%u, %u, %u] maps to zoned block device"=
,
> +                               __func__, inode->i_ino, ei.blk, ei.fofs, =
ei.len);
> +                       return false;
> +               }
> +               return true;
> +       }
> +
> +       f2fs_warn(sbi, "%s: device alias inode (ino=3D%lx)'s extent info =
"
> +                       "[%u, %u, %u] is inconsistent w/ any devices",
> +                       __func__, inode->i_ino, ei.blk, ei.fofs, ei.len);
> +       return false;
>  }
>
>  static void __set_extent_info(struct extent_info *ei,
> --
> 2.40.1
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

