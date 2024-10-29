Return-Path: <linux-kernel+bounces-387355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6359B4FD4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B30E1F211C1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA8F1A0700;
	Tue, 29 Oct 2024 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtlC7YV/"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1641991D2
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730220837; cv=none; b=kICpXwSD2iEwfbxVWSniiyjR3EkRCXS5hk1SyAEr0gwHZu9C1PxWC0lruyCZ12jYo6cfgih9nGnpApefj8iVnmfmhKLJwmK4FmUAv0H0bx2xs2cPIuR+La4F91/HzLc0I6aoLdEXQVYORh0vDbBOKC7RH858qBZe7T3sBJIJmLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730220837; c=relaxed/simple;
	bh=wxyqIPnyP9zRzkZna9oC4ura7T1CUwg4rAEM+B1W7w8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gAbqCb1KJFTPrMSqsPbKx7btcmmH0xFdq+MmFYK+t5b/tzKvm/i+12YFIY/Vrl+HGiKBq0p3ZLHIhDlKqvJDB+O2jewiHO9CgyUZ5VlE9fu7eepZT8oVJ9TgNFRs6Bf1xKcimuVVu5FyDrjBcjAfhZlUNq742gIlmhzrxzq8CzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtlC7YV/; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-50d431b0ae2so10375e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 09:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730220834; x=1730825634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ir049WLIZ+CFdRAvVePLkMs6z/UO0y4AKRZXzYgeCX0=;
        b=ZtlC7YV/NKiXMc2pb7QEXs5GMJUZL/opHwO0jv9+jQr75fcvVQaT6QnHFa2ve+XbCJ
         3NO8RwKgKk2u/QWSUZRqzht3+EfSTeuIXjm/M1p007nrJdVTUTdmc2EDKXAgDsBYOjjM
         OBdMN31svjBlJvCUJ58T+IPmotBIb3QU6n68UXfLEgphsvdcJH42pT9PnmyPl3lN2Flp
         BxFQIHbtLYMaqWisTm0QorrT6VozClK1mxR53p6rx6HH0FWy73KcsvhxTUG0zvzxM/gk
         VVf5KxR0rHEkQxfrw81JbInXh2tADa3C2yovZ2A+I6ZdyGN6oO2NoFGmNdrx4ObvaGmD
         RWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730220834; x=1730825634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ir049WLIZ+CFdRAvVePLkMs6z/UO0y4AKRZXzYgeCX0=;
        b=Ue/WqA0uvYiaNyXo9w7EyCd204C9UYOJjkEfdUHd/RdacfVK8pqKRMoUAGfk9CZJDh
         /JoaG8lugHXRgXRC8Di2EO0fgWpTP2oSVPsdu8L4ArKN3UMUK7HA0uA1LJ3qNo++MFFK
         C5zJ1EE2YXb6aKOYpSlCzUYUd7NpO1dvGVRZ79uEMmZG6OurL5w9bl8zUVedYGIPdcJt
         luou/KQawHoWMZlPhXyiaIj4QvVpCCsL7Tl/efpyQU+995StoaHd7Km/WZUp8GWYqrSn
         3wc1UULWpieoYKtInxuT/CCySKKqhMJ64rSFp/qybaz/y/ufapFOs4GsFesXX//gAgn4
         cMGw==
X-Forwarded-Encrypted: i=1; AJvYcCXg3o1uLY1oO1yab5XqOdjTGiLxK/+JaWuNiHxjT0EEobbGaqERiAuztcKz23k9v3b5v2j/gg8XySyLE7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPK7X1cuJ1mtxFdYRshtA9eAsRIDjMvY08LfhxE7QtrRbtB9ca
	IWzcnJUDlOnNAIXUsDOTk52VDKBcVC5mtcyLWFw1+zJfnXGzfsB36HxVELtAjcJronqyOcs1qJD
	ClSk/bOcbAdkmzJO6HwQ5ye3xAB4=
X-Google-Smtp-Source: AGHT+IEanAXzQz2JfFkPumCoGo/D3vUbINKmkGH6+oIAboE2p+v9BV/4GYXavt/meX6T5yihQ7MV4oDeZJcukioNzn8=
X-Received: by 2002:a05:6122:16a0:b0:50d:5095:f01c with SMTP id
 71dfb90a1353d-51050d69921mr2185145e0c.7.1730220834352; Tue, 29 Oct 2024
 09:53:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029134551.252-1-yohan.joung@sk.com>
In-Reply-To: <20241029134551.252-1-yohan.joung@sk.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Tue, 29 Oct 2024 09:53:43 -0700
Message-ID: <CACOAw_wGAeMiw=UZ7dL6DC8bq7vxKqB0uKOm6o0wp5B_L7BwDQ@mail.gmail.com>
Subject: Re: [PATCH v2] mkfs.f2fs: adjust zone alignment when using convention
 partition with zoned one
To: Yohan Joung <jyh429@gmail.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	Yohan Joung <yohan.joung@sk.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Daeho Jeong <daehojeong@google.com>

Thanks,

On Tue, Oct 29, 2024 at 6:45=E2=80=AFAM Yohan Joung <jyh429@gmail.com> wrot=
e:
>
> When formatting conventional partition with zoned one, we are already
> aligning the starting block address of the next device to the zone size.
> Therefore, we do not align the segment0 address to the zone alignment.
> This reduces the wasted zone_align_start_offset.
>
> Test result
> segment0 blkaddr 389583 -> 119251
> Add one additional section to main
>
> Signed-off-by: Yohan Joung <yohan.joung@sk.com>
> ---
>  mkfs/f2fs_format.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> index a01b19e..52a1e18 100644
> --- a/mkfs/f2fs_format.c
> +++ b/mkfs/f2fs_format.c
> @@ -266,6 +266,7 @@ static int f2fs_prepare_super_block(void)
>         uint32_t log_sectorsize, log_sectors_per_block;
>         uint32_t log_blocksize, log_blks_per_seg;
>         uint32_t segment_size_bytes, zone_size_bytes;
> +       uint32_t alignment_bytes;
>         uint32_t sit_segments, nat_segments;
>         uint32_t blocks_for_sit, blocks_for_nat, blocks_for_ssa;
>         uint32_t total_valid_blks_available;
> @@ -305,10 +306,12 @@ static int f2fs_prepare_super_block(void)
>
>         set_sb(block_count, c.total_sectors >> log_sectors_per_block);
>
> +       alignment_bytes =3D c.zoned_mode && c.ndevs > 1 ? segment_size_by=
tes : zone_size_bytes;
> +
>         zone_align_start_offset =3D
>                 ((uint64_t) c.start_sector * DEFAULT_SECTOR_SIZE +
> -               2 * F2FS_BLKSIZE + zone_size_bytes - 1) /
> -               zone_size_bytes * zone_size_bytes -
> +               2 * F2FS_BLKSIZE + alignment_bytes  - 1) /
> +               alignment_bytes  * alignment_bytes  -
>                 (uint64_t) c.start_sector * DEFAULT_SECTOR_SIZE;
>
>         if (c.feature & F2FS_FEATURE_RO)
> @@ -327,7 +330,8 @@ static int f2fs_prepare_super_block(void)
>
>         if (c.zoned_mode && c.ndevs > 1)
>                 zone_align_start_offset +=3D
> -                       (c.devices[0].total_sectors * c.sector_size) % zo=
ne_size_bytes;
> +                       (c.devices[0].total_sectors * c.sector_size -
> +                        zone_align_start_offset) % zone_size_bytes;
>
>         set_sb(segment0_blkaddr, zone_align_start_offset / blk_size_bytes=
);
>         sb->cp_blkaddr =3D sb->segment0_blkaddr;
> --
> 2.25.1
>

