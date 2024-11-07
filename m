Return-Path: <linux-kernel+bounces-399274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1F49BFCEA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 04:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28D831F22868
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 03:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73E174E09;
	Thu,  7 Nov 2024 03:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3Z2gx/w"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5A41863F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 03:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730949556; cv=none; b=ousrQfjCITq6qpAfA76T7WvxMvfODdJt6fiaWeHicREdP5ld2fEWd80KSXeObgBmfpJL0ilHbfwfy1nk2f+6uR+u8omkZ9n42o/WXFjoiJmGA92r5BgABEDntf2XkVdNrdwMlKee1DF5LTME4KDAY7siH34B3LgI6i0gVli4bag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730949556; c=relaxed/simple;
	bh=J6IVV0RPagciuJQYvm1eHDaj0TUPJZ3O62COugVfxsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lU8SoRaR3ZNEJt414Ls0PY6KZXdUsyOb52HxnDVjah6nhj0LyTZCZvkt+DOorvU+OO3V7zaFFHp6+91lf/iMOOQ4HwkolC0hW+ctwxVIE1MSRDNQCmVUkmb++eC8SZxLqYMYrUDwxcp/c2+JHjD50D1Kd0cpOB6Av0+Jx6BZ/EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3Z2gx/w; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3807e72c468so66504f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 19:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730949552; x=1731554352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9i6iU2j4fsq9YuVwHW6fI2V1rvkHGx0ZfuUTvvlwbmo=;
        b=a3Z2gx/wQ0hz69VOBYHvG70vJ1PNsYDAWI0pj8qyBYQLNwEg8DHDbptrRIPO0QSDud
         UW+KpiahKItZ3nF5Ai+bJLA/MesedppfWy9os7uj7/XZ/u2T6tG6VAzJAaAK9TipvdXU
         Kx8jHAcCCR+J0J57Ab4e1n3uo8SG0x+U30s40Ftkhl6fIMVPpam5K6CIATSWUjN/B3Fn
         kZLghkUgDF2YrVzmtlroFiNl72iCi0N2eDqmTa5AxEpFwJyCIV5/VDDNEdzviqltaWvJ
         P5IWZ3ydBfJGwnApxoQfFNOoSi4Y+T5uGRbg9xQz7tvNmYAUzUHOTY4YdSPMT4xW6PRz
         arAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730949552; x=1731554352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9i6iU2j4fsq9YuVwHW6fI2V1rvkHGx0ZfuUTvvlwbmo=;
        b=SCtdTUJC+g6abLccXfBnzDc36DN95qLu97ZagXBfRrC68YggljNU4c9eJbzbrSkiZj
         yWv1OOrXgM8zOvgHRr6DRIMUokgdTQdFLzXB7p51xTG1RAxVEX7hU5n8xDrONUgnfv1R
         EWXqHeVQF5Le+ctTlG3MBQpjjHzbYOVPBOWfOxzTsguF6MPhtehu3i3xyVTFfuuXdmiM
         NXl6Prg0gvvKcYcSWRl2Jr2tHGiSfDFlfUfOy6rc7o35z+QRAARkNNL7Xxx/ji1+xda5
         sC4ea6pHDOSaQuD/lhnYwvM9QKlYNRYAU0f/e2hfqLOIOQs+t5gIWnAhyBb9tEAODwg3
         udbw==
X-Forwarded-Encrypted: i=1; AJvYcCVi2uA7g2Qw+8bmb7T1J4xUv3sKCn++X8Mg69v7qvqQxKCcN81pWnUBLgrgCop24zNofAFoG5DObZu25Iw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHwXtFy5d7rwRZLbqTo2R1p/cEdhE2/FeHlG489qt6LczMFW2N
	4Fct6VSpilrxPiuduL/KTa9+ag7AAtfCJuX7ckasGCctUT0cZKj+yqs3SYa+pabldHXOI3qp2q5
	gB3B06XcKAH9Bhi7gosKdVZKIkawFOc+V
X-Google-Smtp-Source: AGHT+IF5IR4Uor1FQMJzAE08YCFSu5KhOkkxnvUkSEc0CHM5BbOv2wVieBgTO1nP8Ry51Ykxh1hUVd9B0ZmhCSDGAYw=
X-Received: by 2002:a05:600c:548d:b0:431:5632:448d with SMTP id
 5b1f17b1804b1-432ae84c727mr6600365e9.9.1730949552125; Wed, 06 Nov 2024
 19:19:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107014602.3638020-1-chao@kernel.org>
In-Reply-To: <20241107014602.3638020-1-chao@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Thu, 7 Nov 2024 11:19:01 +0800
Message-ID: <CAHJ8P3LUTz9XGji5Xa2Jy-KeSuaG9HhtDhxz_aM1hE=-K+zsGw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: clean up w/ F2FS_{BLK_TO_BYTES, BTYES_TO_BLK}
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, Zhiguo Niu <zhiguo.niu@unisoc.com>, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
=E4=BA=8E2024=E5=B9=B411=E6=9C=887=E6=97=A5=E5=91=A8=E5=9B=9B 09:50=E5=86=
=99=E9=81=93=EF=BC=9A
>
> f2fs doesn't support different blksize in one instance, so
> bytes_to_blks() and blks_to_bytes() are equal to F2FS_BYTES_TO_BLK
> and F2FS_BLK_TO_BYTES, let's use F2FS_BYTES_TO_BLK/F2FS_BLK_TO_BYTES
> instead for cleanup.
>
> Reported-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
feel free to add:
Reviewed-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
thanks!
> ---
>  fs/f2fs/data.c | 68 +++++++++++++++++++++-----------------------------
>  1 file changed, 29 insertions(+), 39 deletions(-)
>
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index b33aca24b9ef..0e8390cbdb5b 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1819,16 +1819,6 @@ bool f2fs_overwrite_io(struct inode *inode, loff_t=
 pos, size_t len)
>         return true;
>  }
>
> -static inline u64 bytes_to_blks(struct inode *inode, u64 bytes)
> -{
> -       return (bytes >> inode->i_blkbits);
> -}
> -
> -static inline u64 blks_to_bytes(struct inode *inode, u64 blks)
> -{
> -       return (blks << inode->i_blkbits);
> -}
> -
>  static int f2fs_xattr_fiemap(struct inode *inode,
>                                 struct fiemap_extent_info *fieinfo)
>  {
> @@ -1854,7 +1844,7 @@ static int f2fs_xattr_fiemap(struct inode *inode,
>                         return err;
>                 }
>
> -               phys =3D blks_to_bytes(inode, ni.blk_addr);
> +               phys =3D F2FS_BLK_TO_BYTES(ni.blk_addr);
>                 offset =3D offsetof(struct f2fs_inode, i_addr) +
>                                         sizeof(__le32) * (DEF_ADDRS_PER_I=
NODE -
>                                         get_inline_xattr_addrs(inode));
> @@ -1886,7 +1876,7 @@ static int f2fs_xattr_fiemap(struct inode *inode,
>                         return err;
>                 }
>
> -               phys =3D blks_to_bytes(inode, ni.blk_addr);
> +               phys =3D F2FS_BLK_TO_BYTES(ni.blk_addr);
>                 len =3D inode->i_sb->s_blocksize;
>
>                 f2fs_put_page(page, 1);
> @@ -1948,16 +1938,16 @@ int f2fs_fiemap(struct inode *inode, struct fiema=
p_extent_info *fieinfo,
>                         goto out;
>         }
>
> -       if (bytes_to_blks(inode, len) =3D=3D 0)
> -               len =3D blks_to_bytes(inode, 1);
> +       if (F2FS_BYTES_TO_BLK(len) =3D=3D 0)
> +               len =3D F2FS_BLKSIZE;
>
> -       start_blk =3D bytes_to_blks(inode, start);
> -       last_blk =3D bytes_to_blks(inode, start + len - 1);
> +       start_blk =3D F2FS_BYTES_TO_BLK(start);
> +       last_blk =3D F2FS_BYTES_TO_BLK(start + len - 1);
>
>  next:
>         memset(&map, 0, sizeof(map));
>         map.m_lblk =3D start_blk;
> -       map.m_len =3D bytes_to_blks(inode, len);
> +       map.m_len =3D F2FS_BYTES_TO_BLK(len);
>         map.m_next_pgofs =3D &next_pgofs;
>         map.m_seg_type =3D NO_CHECK_TYPE;
>
> @@ -1974,7 +1964,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_=
extent_info *fieinfo,
>         if (!compr_cluster && !(map.m_flags & F2FS_MAP_FLAGS)) {
>                 start_blk =3D next_pgofs;
>
> -               if (blks_to_bytes(inode, start_blk) < maxbytes)
> +               if (F2FS_BLK_TO_BYTES(start_blk) < maxbytes)
>                         goto prep_next;
>
>                 flags |=3D FIEMAP_EXTENT_LAST;
> @@ -2011,14 +2001,14 @@ int f2fs_fiemap(struct inode *inode, struct fiema=
p_extent_info *fieinfo,
>         } else if (compr_appended) {
>                 unsigned int appended_blks =3D cluster_size -
>                                                 count_in_cluster + 1;
> -               size +=3D blks_to_bytes(inode, appended_blks);
> +               size +=3D F2FS_BLK_TO_BYTES(appended_blks);
>                 start_blk +=3D appended_blks;
>                 compr_cluster =3D false;
>         } else {
> -               logical =3D blks_to_bytes(inode, start_blk);
> +               logical =3D F2FS_BLK_TO_BYTES(start_blk);
>                 phys =3D __is_valid_data_blkaddr(map.m_pblk) ?
> -                       blks_to_bytes(inode, map.m_pblk) : 0;
> -               size =3D blks_to_bytes(inode, map.m_len);
> +                       F2FS_BLK_TO_BYTES(map.m_pblk) : 0;
> +               size =3D F2FS_BLK_TO_BYTES(map.m_len);
>                 flags =3D 0;
>
>                 if (compr_cluster) {
> @@ -2026,13 +2016,13 @@ int f2fs_fiemap(struct inode *inode, struct fiema=
p_extent_info *fieinfo,
>                         count_in_cluster +=3D map.m_len;
>                         if (count_in_cluster =3D=3D cluster_size) {
>                                 compr_cluster =3D false;
> -                               size +=3D blks_to_bytes(inode, 1);
> +                               size +=3D F2FS_BLKSIZE;
>                         }
>                 } else if (map.m_flags & F2FS_MAP_DELALLOC) {
>                         flags =3D FIEMAP_EXTENT_UNWRITTEN;
>                 }
>
> -               start_blk +=3D bytes_to_blks(inode, size);
> +               start_blk +=3D F2FS_BYTES_TO_BLK(size);
>         }
>
>  prep_next:
> @@ -2070,7 +2060,7 @@ static int f2fs_read_single_page(struct inode *inod=
e, struct folio *folio,
>                                         struct readahead_control *rac)
>  {
>         struct bio *bio =3D *bio_ret;
> -       const unsigned blocksize =3D blks_to_bytes(inode, 1);
> +       const unsigned int blocksize =3D F2FS_BLKSIZE;
>         sector_t block_in_file;
>         sector_t last_block;
>         sector_t last_block_in_file;
> @@ -2080,8 +2070,8 @@ static int f2fs_read_single_page(struct inode *inod=
e, struct folio *folio,
>
>         block_in_file =3D (sector_t)index;
>         last_block =3D block_in_file + nr_pages;
> -       last_block_in_file =3D bytes_to_blks(inode,
> -                       f2fs_readpage_limit(inode) + blocksize - 1);
> +       last_block_in_file =3D F2FS_BYTES_TO_BLK(f2fs_readpage_limit(inod=
e) +
> +                                                       blocksize - 1);
>         if (last_block > last_block_in_file)
>                 last_block =3D last_block_in_file;
>
> @@ -2181,7 +2171,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, =
struct bio **bio_ret,
>         struct bio *bio =3D *bio_ret;
>         unsigned int start_idx =3D cc->cluster_idx << cc->log_cluster_siz=
e;
>         sector_t last_block_in_file;
> -       const unsigned blocksize =3D blks_to_bytes(inode, 1);
> +       const unsigned int blocksize =3D F2FS_BLKSIZE;
>         struct decompress_io_ctx *dic =3D NULL;
>         struct extent_info ei =3D {};
>         bool from_dnode =3D true;
> @@ -2190,8 +2180,8 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, =
struct bio **bio_ret,
>
>         f2fs_bug_on(sbi, f2fs_cluster_is_empty(cc));
>
> -       last_block_in_file =3D bytes_to_blks(inode,
> -                       f2fs_readpage_limit(inode) + blocksize - 1);
> +       last_block_in_file =3D F2FS_BYTES_TO_BLK(f2fs_readpage_limit(inod=
e) +
> +                                                       blocksize - 1);
>
>         /* get rid of pages beyond EOF */
>         for (i =3D 0; i < cc->cluster_size; i++) {
> @@ -3957,7 +3947,7 @@ static int check_swap_activate(struct swap_info_str=
uct *sis,
>          * to be very smart.
>          */
>         cur_lblock =3D 0;
> -       last_lblock =3D bytes_to_blks(inode, i_size_read(inode));
> +       last_lblock =3D F2FS_BYTES_TO_BLK(i_size_read(inode));
>
>         while (cur_lblock < last_lblock && cur_lblock < sis->max) {
>                 struct f2fs_map_blocks map;
> @@ -4200,8 +4190,8 @@ static int f2fs_iomap_begin(struct inode *inode, lo=
ff_t offset, loff_t length,
>         pgoff_t next_pgofs =3D 0;
>         int err;
>
> -       map.m_lblk =3D bytes_to_blks(inode, offset);
> -       map.m_len =3D bytes_to_blks(inode, offset + length - 1) - map.m_l=
blk + 1;
> +       map.m_lblk =3D F2FS_BYTES_TO_BLK(offset);
> +       map.m_len =3D F2FS_BYTES_TO_BLK(offset + length - 1) - map.m_lblk=
 + 1;
>         map.m_next_pgofs =3D &next_pgofs;
>         map.m_seg_type =3D f2fs_rw_hint_to_seg_type(F2FS_I_SB(inode),
>                                                 inode->i_write_hint);
> @@ -4212,7 +4202,7 @@ static int f2fs_iomap_begin(struct inode *inode, lo=
ff_t offset, loff_t length,
>         if (err)
>                 return err;
>
> -       iomap->offset =3D blks_to_bytes(inode, map.m_lblk);
> +       iomap->offset =3D F2FS_BLK_TO_BYTES(map.m_lblk);
>
>         /*
>          * When inline encryption is enabled, sometimes I/O to an encrypt=
ed file
> @@ -4232,21 +4222,21 @@ static int f2fs_iomap_begin(struct inode *inode, =
loff_t offset, loff_t length,
>                 if (WARN_ON_ONCE(map.m_pblk =3D=3D NEW_ADDR))
>                         return -EINVAL;
>
> -               iomap->length =3D blks_to_bytes(inode, map.m_len);
> +               iomap->length =3D F2FS_BLK_TO_BYTES(map.m_len);
>                 iomap->type =3D IOMAP_MAPPED;
>                 iomap->flags |=3D IOMAP_F_MERGED;
>                 iomap->bdev =3D map.m_bdev;
> -               iomap->addr =3D blks_to_bytes(inode, map.m_pblk);
> +               iomap->addr =3D F2FS_BLK_TO_BYTES(map.m_pblk);
>         } else {
>                 if (flags & IOMAP_WRITE)
>                         return -ENOTBLK;
>
>                 if (map.m_pblk =3D=3D NULL_ADDR) {
> -                       iomap->length =3D blks_to_bytes(inode, next_pgofs=
) -
> -                                                               iomap->of=
fset;
> +                       iomap->length =3D F2FS_BLK_TO_BYTES(next_pgofs) -
> +                                                       iomap->offset;
>                         iomap->type =3D IOMAP_HOLE;
>                 } else if (map.m_pblk =3D=3D NEW_ADDR) {
> -                       iomap->length =3D blks_to_bytes(inode, map.m_len)=
;
> +                       iomap->length =3D F2FS_BLK_TO_BYTES(map.m_len);
>                         iomap->type =3D IOMAP_UNWRITTEN;
>                 } else {
>                         f2fs_bug_on(F2FS_I_SB(inode), 1);
> --
> 2.40.1
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

