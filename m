Return-Path: <linux-kernel+bounces-294660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B6D959101
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 01:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F881F23194
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 23:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E65D1C8FA0;
	Tue, 20 Aug 2024 23:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="niLKJi3K"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23E6166F17
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 23:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724195854; cv=none; b=rf9kVVQqifblvDXMGVkD2/eboQb/09xlvVJp5HQpWKebcoTtgXyzXBsLUXAIsebD60Lh1IBZdBJuvkEtklNEyYbrxoYU9dAs+9quF2YCZGfaHgtrmmXAfYz95cdcxzm0GMffapFY6a2l/IGQjrVwjeC6QIo9OK+8LnPyf7vHbOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724195854; c=relaxed/simple;
	bh=XIitAwc2m/XIDG0E+BXyhLhiDlqGkwDvEQ2KrtnoW/E=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BRtFERzeCe5b/B5/n5H0fzNfoQ4/CFKT8RYqxilkkYb/TazFwBQtwlMgZu3OybQ6J1Dc0ZGNXmYuQsnMVKTdQI5zv1RDcWHzAqgCAVGHwnX3U1TCH/6cmTtUCAr+8VUCh67PPnottcZiLx3Tc2o+T8tsXyGw2+xfCd6FrNVWvGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=niLKJi3K; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4280921baa2so8397145e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 16:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1724195851; x=1724800651; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYTQ5x5CeStFc2/B521mMkl8hxPWD6L8NQAxmM43O7o=;
        b=niLKJi3K+5o9O8d+KfDE/kS+J5Sr419ZOVKDZzRd1dKZ6sju9JW94g9zZb3pzXLbKA
         WK2AikgFEayfsahRL6hdV8WwkR5erwra9ONYXfFSyfj+FkCwb8Wu99olxITT6PFabiUL
         sCmGJ9Edcs/iYDZRkk+bH59coKWl90Sb4iYqASReUQDcgt7/aYket8X5jRI5aLaOVXDI
         Rg8Zkca8btFOvXE70GMt/7EmLsbKgJp5Hzeqn/wPvsRS5K/YGaSzN/ZyQcDAAyIMYnaX
         0CDnsx3CEIyzhbxDeQiyyLcTsr1ZtiljkRwJkIF+sVGK7exy/wZQ1otjuwWHeldlGCeN
         77ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724195851; x=1724800651;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYTQ5x5CeStFc2/B521mMkl8hxPWD6L8NQAxmM43O7o=;
        b=j4djBwHe8OHWTp+AShg4+BH4mMHY1KWNxrtjga0wB6NCdwogOLBRZf3ZPezvvkLVt5
         Mnc/SyClxGfO5AdL+DBSXCGUF7X3HfcJAEBMiw4qkv2d9zBEg4JId44RuwGYzhbOvyg9
         HETTOlpEyVzyvhoL96m6tI72M/8O/eF/RWBuOjGGAa40RProOWG1cPfBAZ2myGDOQv/i
         LrHAqLhz77tBr4wpSS3GK4z2p9RcXh8lJssedLyMQ3p1Rpb1g0vDNnpEou6MY4KhXBOH
         v7KqFDoBRB2ksHJ1oGOQ9qNNbxQQ5QzPSycOB/IAq2xIFB7V4AUW3Hb4XNB02dyDGNQU
         Ophg==
X-Forwarded-Encrypted: i=1; AJvYcCWniN+rW7qcx+QdagaGZ1ZmCpYc1tTUjC9Ddk1vMMoQI0evfpe1JtcZZTdmUGfpnwSE+tp4NDFe/GJiDqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH/kTJoyydSOFbLm1mwyuoFIEfrISCr835Dxy76uwaRVqnhVNg
	kmH/MkHAkdNtEHR+xWFzn3rBTT3YC8I/Ek5lVHuWNv9g/sXFiR2MurpQr17rth4=
X-Google-Smtp-Source: AGHT+IF4mDjdThKSBPxP/wA2ZFRyHKOXq4oRI3+x/erbrgvHiqhkdibYDhdHRcvB60/WbdhWlJCuAg==
X-Received: by 2002:a5d:59a9:0:b0:365:da7f:6c13 with SMTP id ffacd0b85a97d-372fd580272mr171785f8f.2.1724195850790;
        Tue, 20 Aug 2024 16:17:30 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:1050:bb01:8164:778c:a10:dcfc])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83839359f7sm819139566b.131.2024.08.20.16.17.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2024 16:17:30 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [RESEND PATCH v4] ext4: Annotate struct ext4_xattr_inode_array
 with __counted_by()
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <20240813070707.34203-1-thorsten.blum@toblux.com>
Date: Wed, 21 Aug 2024 01:17:19 +0200
Cc: linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <90467BBB-59F4-48C5-AD18-4FDDAE3CF321@toblux.com>
References: <20240813070707.34203-1-thorsten.blum@toblux.com>
To: tytso@mit.edu,
 adilger.kernel@dilger.ca,
 Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
X-Mailer: Apple Mail (2.3776.700.51)

On 13. Aug 2024, at 09:07, Thorsten Blum <thorsten.blum@toblux.com> =
wrote:
>=20
> Add the __counted_by compiler attribute to the flexible array member
> inodes to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
>=20
> Remove the now obsolete comment on the count field.
>=20
> In ext4_expand_inode_array(), use struct_size() instead of offsetof()
> and remove the local variable count. Increment the count field before
> adding a new inode to the inodes array.
>=20
> Compile-tested only.
>=20
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
> Changes in v2:
> - Adjust ext4_expand_inode_array() as suggested by Gustavo A. R. Silva
> - Use struct_size() and struct_size_t() instead of offsetof()
> - Link to v1: =
https://lore.kernel.org/linux-kernel/20240729110454.346918-3-thorsten.blum=
@toblux.com/
>=20
> Changes in v3:
> - Use struct_size() instead of struct_size_t() as suggested by Kees =
Cook
> - Remove the local variable count as suggested by Gustavo A. R. Silva
> - Increment count before adding a new inode as suggested by Gustavo
> - Link to v2: =
https://lore.kernel.org/linux-kernel/20240730172301.231867-4-thorsten.blum=
@toblux.com/
>=20
> Changes in v4:
> - Remove unnecessary count assignment and adjust copying the whole
>  struct as suggested by Gustavo
> - Link to v3: =
https://lore.kernel.org/linux-kernel/20240730205509.323320-3-thorsten.blum=
@toblux.com/
> ---
> fs/ext4/xattr.c | 22 ++++++++++------------
> fs/ext4/xattr.h |  4 ++--
> 2 files changed, 12 insertions(+), 14 deletions(-)
>=20
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 46ce2f21fef9..263567d4e13d 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -2879,33 +2879,31 @@ ext4_expand_inode_array(struct =
ext4_xattr_inode_array **ea_inode_array,
> if (*ea_inode_array =3D=3D NULL) {
> /*
> * Start with 15 inodes, so it fits into a power-of-two size.
> - * If *ea_inode_array is NULL, this is essentially offsetof()
> */
> - (*ea_inode_array) =3D
> - kmalloc(offsetof(struct ext4_xattr_inode_array,
> - inodes[EIA_MASK]),
> - GFP_NOFS);
> + (*ea_inode_array) =3D kmalloc(
> + struct_size(*ea_inode_array, inodes, EIA_MASK),
> + GFP_NOFS);
> if (*ea_inode_array =3D=3D NULL)
> return -ENOMEM;
> (*ea_inode_array)->count =3D 0;
> } else if (((*ea_inode_array)->count & EIA_MASK) =3D=3D EIA_MASK) {
> /* expand the array once all 15 + n * 16 slots are full */
> struct ext4_xattr_inode_array *new_array =3D NULL;
> - int count =3D (*ea_inode_array)->count;
>=20
> - /* if new_array is NULL, this is essentially offsetof() */
> new_array =3D kmalloc(
> - offsetof(struct ext4_xattr_inode_array,
> - inodes[count + EIA_INCR]),
> - GFP_NOFS);
> + struct_size(*ea_inode_array, inodes,
> +    (*ea_inode_array)->count + EIA_INCR),
> + GFP_NOFS);
> if (new_array =3D=3D NULL)
> return -ENOMEM;
> memcpy(new_array, *ea_inode_array,
> -       offsetof(struct ext4_xattr_inode_array, inodes[count]));
> +       struct_size(*ea_inode_array, inodes,
> +   (*ea_inode_array)->count));
> kfree(*ea_inode_array);
> *ea_inode_array =3D new_array;
> }
> - (*ea_inode_array)->inodes[(*ea_inode_array)->count++] =3D inode;
> + (*ea_inode_array)->count++;
> + (*ea_inode_array)->inodes[(*ea_inode_array)->count - 1] =3D inode;
> return 0;
> }
>=20
> diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
> index bd97c4aa8177..e14fb19dc912 100644
> --- a/fs/ext4/xattr.h
> +++ b/fs/ext4/xattr.h
> @@ -130,8 +130,8 @@ struct ext4_xattr_ibody_find {
> };
>=20
> struct ext4_xattr_inode_array {
> - unsigned int count; /* # of used items in the array */
> - struct inode *inodes[];
> + unsigned int count;
> + struct inode *inodes[] __counted_by(count);
> };
>=20
> extern const struct xattr_handler ext4_xattr_user_handler;
> --=20
> 2.46.0
>=20

Could someone take another look at this?

Thanks,
Thorsten=

