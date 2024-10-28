Return-Path: <linux-kernel+bounces-385564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A2F9B38B3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3DF81C20444
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CB91DF74C;
	Mon, 28 Oct 2024 18:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9AleaI0"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292F61DED53
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 18:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730138714; cv=none; b=ibKQ81eOR3Q1t1wkraEbHSrNSq05o/uCgpDxZHaace77XDgyb8hDgeAo+kg3L4ZjtkSL3YNKb6KfmVfkEQfUMALqYhv0DP9mHtxwXRCGT0NdxqzEHkXhTdAxEDMk+lckOr29mmIsD4ysmi+Ji/Q5otrz2s26IKqFEUKMYIY0Bq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730138714; c=relaxed/simple;
	bh=1Uy6Hnw/z1Iupn4hIVi2vS6uZREymLr44674Ux7s2UE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T/qr8LxungvCV4IfVsHLbhkcvrEg4DeyltXDyuRhl0kFOoHz4aFs5aUCJHPPjUPwO9s23r2KqzOgnGTHwt65ZNoUlgswmorE01NOeElZs7D3lG78VlhfGkP0UNlgyo3u43FWciVBktlJATzSz+SG2gEeNNS3cK7IqPIB62iLndg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9AleaI0; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3e5fcf464ecso3104855b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730138711; x=1730743511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wswnbw8lU1S7U5OtdXiVOyVdMtF0YmqSGDwUZ9wzt4g=;
        b=W9AleaI0xjMOuxzgdhtsPlnuQ8ZIcAorG1CfbcuOmWny4KHptdEWswBkdGIFsqj9AI
         ptfadbkWjQgC0BEUZteSQycoxqTBe0Id866pJxWtY9QTa+VwHZGluQSPy/y5rYQyeRym
         IWFdfC8vdfcEq8t7LBQdA3+3ZNHBMfKqmlcECZ4Noyrtu4l/jHU2YVSXM3qzT4IY65C0
         EpskvvDdWt/e99PcB3raVGJwaQygD9XVDg7cjjsKSm+FQDkAId9FyHLHZIx2RzY0XHHH
         Nb3nv2aEjdIQx8JD5udC4sLFHtsaE72IpScuynxHXSaTRqvA0WyElJO7V3JAHuY/Xfbm
         c0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730138711; x=1730743511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wswnbw8lU1S7U5OtdXiVOyVdMtF0YmqSGDwUZ9wzt4g=;
        b=QAicrPUdxHQSa42gpGwhqwK6RdlQqoYIDw4lJsKzDCZJ3bODA1zb+Lyx7XQEnit/oz
         qxQCzdQVYeGqoh5PVg+xtwhs6EZbD3pev/3eSdb/Y0C6ADXiFNHwpsNu/CJvni6akHn4
         5xzBonIl9+3HzDeMvLgbwA1/nsk4C93UBGuZGkMGI2bQKxcEgfqzk6LsrIhGAbQ1DmVO
         +xvSYvUpq2X20KJ9q75Vo3cBax+3dFe1hRTfxHyIs2+rJBBTp/JGfH8GTRXJKJytp55S
         zLuf5aWgQdmCT/AZSRwQvEXT3XpkkMUzuIg4Imvc9yOTa1GpfUFaiqUyYnqfkGQw2Ok2
         Z8YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYPadIXYGDPJDoo+uhpWp9Mkw2G8gT1z4RCabuOlEgSiY2i2wPL5Li9zVd7T7Rf2tk7s/Cl3r20yoMKso=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9M0khulSv4TaMREpv1S9e+XS+mVchlyxp112kxzDh5TCGpsgD
	OxiCMGrQdhaq/zOGid9QPEz+NRmMjcZS83uDYBf2cliH/irIf/qAcbeQmtRNnH/38qYp1V7ZUPM
	WPBuvj5BZeI8U36jsFq3sf64uPWI=
X-Google-Smtp-Source: AGHT+IHPNrC5vf1ML24eVNYAP5ct4DSvt3rL9mZBLn7KPA1QPcJgfE52/9sBY+Ej74RzxNvGmdlg39oVrmDWNBOCNVU=
X-Received: by 2002:a05:6808:2e8f:b0:3e6:3eff:30bb with SMTP id
 5614622812f47-3e63eff31ffmr6708579b6e.9.1730138711120; Mon, 28 Oct 2024
 11:05:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910135636.471-1-yohan.joung@sk.com>
In-Reply-To: <20240910135636.471-1-yohan.joung@sk.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Mon, 28 Oct 2024 11:05:00 -0700
Message-ID: <CACOAw_xp94tOAeh=yG93Oh+-y95vh+JzHGpqWmJhYUt4obCvUg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] mkfs.f2fs: adjust zone alignment when using
 convention partition with zoned one
To: Yohan Joung <jyh429@gmail.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 6:58=E2=80=AFAM Yohan Joung <jyh429@gmail.com> wrot=
e:
>
> When formatting conventional partition with zoned one, we are already
> aligning the starting block address of the next device to the zone size.
> Therefore, we do not align the segment0 address to the zone alignment.
> This reduces the wasted zone_align_start_offset.
>
> Signed-off-by: Yohan Joung <yohan.joung@sk.com>
> ---
>  mkfs/f2fs_format.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> index 37d23f3..71f5ec8 100644
> --- a/mkfs/f2fs_format.c
> +++ b/mkfs/f2fs_format.c
> @@ -252,11 +252,19 @@ static int f2fs_prepare_super_block(void)
>
>         set_sb(block_count, c.total_sectors >> log_sectors_per_block);
>
> -       zone_align_start_offset =3D
> -               ((uint64_t) c.start_sector * DEFAULT_SECTOR_SIZE +
> -               2 * F2FS_BLKSIZE + zone_size_bytes - 1) /
> -               zone_size_bytes * zone_size_bytes -
> -               (uint64_t) c.start_sector * DEFAULT_SECTOR_SIZE;
> +       if (c.zoned_mode && c.ndevs > 1) {
> +               zone_align_start_offset =3D
> +                       ((uint64_t) c.start_sector * DEFAULT_SECTOR_SIZE =
+
> +                       2 * F2FS_BLKSIZE + segment_size_bytes - 1) /
> +                       segment_size_bytes * segment_size_bytes -
> +                       (uint64_t) c.start_sector * DEFAULT_SECTOR_SIZE;
> +       } else {
> +               zone_align_start_offset =3D
> +                       ((uint64_t) c.start_sector * DEFAULT_SECTOR_SIZE =
+
> +                       2 * F2FS_BLKSIZE + zone_size_bytes - 1) /
> +                       zone_size_bytes * zone_size_bytes -
> +                       (uint64_t) c.start_sector * DEFAULT_SECTOR_SIZE;
> +       }

How about using a variable like "alignment_bytes" to accommodate both
"segment_size_bytes" and "zone_size_bytes"?

               zone_align_start_offset =3D
                       ((uint64_t) c.start_sector * DEFAULT_SECTOR_SIZE +
                       2 * F2FS_BLKSIZE + alignment_bytes - 1) /
                       alignment_bytes * alignment_bytes -
                       (uint64_t) c.start_sector * DEFAULT_SECTOR_SIZE;

Thanks,

>
>         if (c.feature & F2FS_FEATURE_RO)
>                 zone_align_start_offset =3D 8192;
> --
> 2.25.1
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

