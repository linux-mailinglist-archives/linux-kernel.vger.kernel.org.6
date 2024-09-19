Return-Path: <linux-kernel+bounces-333028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E3497C269
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 03:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DCFC2836BC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 01:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F415F9CB;
	Thu, 19 Sep 2024 01:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gS8+Fq9c"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D826AD2D
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 01:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726709021; cv=none; b=H5FBGXuwnMOhnQ5Wv5pJRJG4g3eXYYYVC+BrW25pxT6L+olzpqb56KmmBdW3yRqkxcZd9qtbUPkKE4IuRl6yOEWWLTjawQJCtXuwzXlUiA3m9fDvu9s66OxZgsLM1eDoaaSrzulkSVKirUenk0tg1aQc0zht5G9c4XW3aDuRoNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726709021; c=relaxed/simple;
	bh=qP9jzz1u/WoZBLLLBBOR8cMn4qrq9BlYy7sSObfc9gE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YvpmhJKpwFoaQRbEfai+LaxA8aDQxfujUKcTc92tHVU2Z1WyaZqPb6Gg1erm6L7ktJRtbqjZwK289Bzjsx+RXoW4h9GoIedbNMx7dptNY8TcKpROE93x+LMRBa/rClvBabqPtFGeYK/vbcyw8MPxQtsu6vGhsUY5AaW7BEEXwAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gS8+Fq9c; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42ca5447142so420065e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 18:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726709018; x=1727313818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nc8TnxZcy0YR73tSERxQDGYOdOm2aQYHENKlCi39G8=;
        b=gS8+Fq9ckLtrBA6Ckp016H1Bapa/Vv+S96ib0iCbwTKnfrtQv7hUMC4h6Bp+utvI8h
         rRVLQ7U8hITQl4y0IHOZkH41WoOhazAl1/FKQMc/vndmeedA0ODHGumZUy9HMEzxcWI+
         ae6EV1ZYFHnkJrGF57NEXEymNpskYBMSB82iUeUOxoe6K7BkkCZCgsOy7klyw/E7Z6WX
         2RF8Fcn7KeR97UfddNujpW9RNgr7LUDXcEZGnloakMMxf7w8KQbw18vvrXU4hana0SRE
         GVKbvbDb6ePvUsqr/9UIw95yJ1iPeN2uIb/kYoi5FKECcMx8siEAUjpmw+CXGZzoyrKq
         a4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726709018; x=1727313818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3nc8TnxZcy0YR73tSERxQDGYOdOm2aQYHENKlCi39G8=;
        b=rAvtKRiVVTyqtv3x91gN6G1lkXzQfpnzCohtJHeVYfTLlJsrFJQeFhfscB2Olnjz5Y
         11LolhLjiuwUZFndDA/SakderfrP4vvQ0nGQqDLSXI2oRFFMBIL/vmh5doFUbxssab8Q
         IWXINXblk9zSS59RxmiElGcFjhOHkUgIxnPuNRQwV9io1T9B4/v1ygk2U3m2Zyg7Mwux
         0tmi0xGp2U0IHh1lhEuEstu6I0xLTwyVXMvs4D0fqAvLtOkfI2BKXK5NwDxddPD60fx9
         CkkoObDHlVVOzHpTXl2SWopWmFqcomcSakn0G5yhsbT7EPNBvd7wc4uHPqS0qOyc8VEt
         ZEGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHptI4XBeHum08U85R2WaF5vnd02dMU9l7rZ+7PQc/ZOzE6Cr6/01TqB+2wGI+aO6vD/mFVcrehZghwqY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6TlSMXFI3XIxMzsi3vZ9EpfsQi/irFpvh9RCidbKn0Ma5tdfd
	Z54gSnPQKEVD8izKjZlzmGV1VgJGMGsxZ/HPSyyZjM5zyJxt9iDH115WNF0dVa/u8OQqdVFkClr
	Q4KuKks+TcdDKuOhoKi9rCjlldCA=
X-Google-Smtp-Source: AGHT+IEm3LMcM9PCILFtcZOMBc/sDEE84WrXK/XFe69ZsdfrGDbWYgqJ/F1ugpWhJxTWXELz449Gsezcy+AtZVOeHcQ=
X-Received: by 2002:a05:6000:2c5:b0:374:c2ce:eb1e with SMTP id
 ffacd0b85a97d-378c2d1186amr7465753f8f.8.1726709017538; Wed, 18 Sep 2024
 18:23:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1726283507-16611-1-git-send-email-zhiguo.niu@unisoc.com>
In-Reply-To: <1726283507-16611-1-git-send-email-zhiguo.niu@unisoc.com>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Thu, 19 Sep 2024 09:23:25 +0800
Message-ID: <CAHJ8P3+=Ft_LOWHXPDdXQnQA=BsGhDLF0KYWWD6T3KHB-TEgWg@mail.gmail.com>
Subject: Re: [PATCH] f2fs-toos: use getpagesize() to get default blocksize in Android
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	xiuhong.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,
please ignore this patch,  we can resove this by "-b" parameter .
thanks!
Zhiguo Niu <zhiguo.niu@unisoc.com> =E4=BA=8E2024=E5=B9=B49=E6=9C=8814=E6=97=
=A5=E5=91=A8=E5=85=AD 11:12=E5=86=99=E9=81=93=EF=BC=9A
>
> When 16K page/block size is enabled in Android platform,
> a error maybe detected in mount process in kernel if "-b"
> parameters is not specified in mkfs.f2fs.
> Just as the following check:
> if (le32_to_cpu(raw_super->log_blocksize) !=3D F2FS_BLKSIZE_BITS)
>
> So use getpagesize() to get correct default blocksize.
>
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> Signed-off-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
> ---
>  lib/libf2fs.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/lib/libf2fs.c b/lib/libf2fs.c
> index ecd22d4..98ee0ae 100644
> --- a/lib/libf2fs.c
> +++ b/lib/libf2fs.c
> @@ -685,8 +685,17 @@ void f2fs_init_configuration(void)
>
>         memset(&c, 0, sizeof(struct f2fs_configuration));
>         c.ndevs =3D 1;
> +#ifdef WITH_ANDROID
> +       c.blksize =3D getpagesize();
> +       c.blksize_bits =3D log_base_2(c.blksize);
> +       if ((1 << c.blksize_bits) !=3D c.blksize) {
> +               c.blksize =3D 1 << DEFAULT_BLKSIZE_BITS;
> +               c.blksize_bits =3D DEFAULT_BLKSIZE_BITS;
> +       }
> +#else
>         c.blksize =3D 1 << DEFAULT_BLKSIZE_BITS;
>         c.blksize_bits =3D DEFAULT_BLKSIZE_BITS;
> +#endif
>         c.sectors_per_blk =3D DEFAULT_SECTORS_PER_BLOCK;
>         c.blks_per_seg =3D DEFAULT_BLOCKS_PER_SEGMENT;
>         c.wanted_total_sectors =3D -1;
> --
> 1.9.1
>

