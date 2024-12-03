Return-Path: <linux-kernel+bounces-430182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1AC9E2D60
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AC14283EE1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AC6209F4C;
	Tue,  3 Dec 2024 20:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="p80H0VL/"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5D2208964
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 20:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733258427; cv=none; b=FS0h6mZyXKMkyGB0ZmHL1IdsUVwtq8M4QbDHCZiX7i9Cn5QSmwbv+WVdBW2vjuyt6ylgW8YNgogdDwAkns4cD+g0sRKdwJ0u+JjWJkKLCM33K3K3+TJBiBKwO5fCVTsso+RM1NEqWwh+i8Sl7/N1SinIPM9fzVwP5dHnZE6gZAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733258427; c=relaxed/simple;
	bh=rSeMRzYyG+qr3owWq1fdPRuk1G0UR6sd75t7TH+Te8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7k/X7x6rKXP1+37MalW/lDZapcSlyA2HETs5fA7a5es/VewQ2DcJGJG9fNF/QX53umOnUBzmlP7J1jKCpYwLEl0vHzwgTlyzDVzfRiniHlIs33EEWtQgt+Kgt2lk8jHjR1/gpSaHzk/nD6dYC0xwhftNuUaUjZIaBztSiY41vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=p80H0VL/; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7251d20e7f2so5997510b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 12:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1733258424; x=1733863224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gh+WkW3kMcY8GItbOWmb7Albb9UCyz9TXbZGgcVLwPQ=;
        b=p80H0VL/ZHEQCKRlYsIwGZ8v+qDOwaC+6sz2fuVUzIaoWRIs9w2VABkmVIPFVgQyLc
         9k3oaAZCyz5AcaQcTio/j1HyViDbfjfnEIQPArYkJZlQBT5GB6wiNLFUfLY+0Qzxk88E
         JVyqjFuKELVcfeF6jOXlAnuwf+fQOMoEIV1vOWDDKCVneLusHRIwlGZbq72/lO0t6fQs
         WoHxD2rJez0/Of+NAWwJSExKazn8Ii9OFpdaX17pVNv07V5Wvs4I/C2UVMNgCJQuPWto
         VuMWhhxfosATMxRZpQNYaVO8o6irXSeWjgcPYSOMQvJEpKQfaYitdth2pvSu+iO3FbVG
         zVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733258424; x=1733863224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gh+WkW3kMcY8GItbOWmb7Albb9UCyz9TXbZGgcVLwPQ=;
        b=R9nr3yXGZdbU4KguOKVj7bET098tk2pnJJ4LD5DrfedFKB4+ZNhTFcHDStCYf6r8Qx
         6I9zFI4aCzLNkKfJsR4HXjVQwL+IViSCr7+PNCJE3yc7H1izosjBvk3TJIKW/naiN4pf
         MnB79vB7qgNfHyM11x2m2dEtINrS80xzv56ThBErULuEoZ5eFbCH8+CIJhFKSAeZp9hp
         C8MKRzBnB1ac5xK4gPOSN9F1PCyxFRbWtF+9U69HB0ns5nKR8qhhPNoJCCYvL22iV5xx
         gGQX+f5Qe8CApQbBTCxs2Wx7zRvqooUfRwyW8AsjOhbeCCiv81KQkyie+ByooXXlgTxR
         Nd8g==
X-Forwarded-Encrypted: i=1; AJvYcCUM8Z1tl1nf/TB0rf0qBlb+p/sNkkgceiFzPFp8Ja5rVlEo+n8mBwNcv42xGuXC66rCCI9oae2OPBLj40I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX5qEcx10DfAi/lA1ZrS/oJyTrBVOpyH4+XiBJ5VTKDYXcnLkp
	/JhEbz0+hIHObPBjY+cLj1JuP7TMeRZcfj/hqSETLvV0Q0VzGFdaKclE8WUneYU=
X-Gm-Gg: ASbGnctPpR8T40GPbJGPIFXTiJ309HUf/452RlkqZjg7z+y6oUqSAC/cFLqUgfZmrRQ
	aaL2gxHGQ3pZ+LHMvVe0TUuzfXNBL+EeUKMfU0Uts+6LZpXUY3Wz/20kjDrlOUZZ8s4nwkTZuxh
	dvrhBBBsA+TueL1QieXETb7tzI4Zc5P/vkL5lSj0iHQQBOie691YsB82Q9950m+ri+OJVYqM10q
	8lEskE0Ci/trEMc4BIu3xO/HW529u94NT6aYEVUO0QVc0t2SEPAY2atxoE4uwb+Qfosk+eiYMqR
	M1PNve4ZLv/zURC23kQNX+vGcA==
X-Google-Smtp-Source: AGHT+IHu1DUrZWKsZf2sxYqF3mSf+fZSaDb0CZwptZ+kh51z1iAIA1GqYtP7epMmpdosj0IIbBaGhg==
X-Received: by 2002:a05:6a00:3998:b0:71e:5e04:be9b with SMTP id d2e1a72fcca58-7257fa70dc6mr4903784b3a.12.1733258424461;
        Tue, 03 Dec 2024 12:40:24 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417614f5sm10922852b3a.7.2024.12.03.12.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 12:40:23 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tIZgy-00000006GzU-1Z32;
	Wed, 04 Dec 2024 07:40:20 +1100
Date: Wed, 4 Dec 2024 07:40:20 +1100
From: Dave Chinner <david@fromorbit.com>
To: Jinliang Zheng <alexjlzheng@gmail.com>
Cc: cem@kernel.org, djwong@kernel.org, hch@infradead.org,
	dchinner@redhat.com, chandanbabu@kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: Re: [RESEND PATCH v2] xfs: fix the entry condition of exact EOF
 block allocation optimization
Message-ID: <Z09stGvgxKV91XfX@dread.disaster.area>
References: <20241130111132.1359138-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130111132.1359138-1-alexjlzheng@tencent.com>

On Sat, Nov 30, 2024 at 07:11:32PM +0800, Jinliang Zheng wrote:
> When we call create(), lseek() and write() sequentially, offset != 0
> cannot be used as a judgment condition for whether the file already
> has extents.
> 
> Furthermore, when xfs_bmap_adjacent() has not given a better blkno,
> it is not necessary to use exact EOF block allocation.
> 
> Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> ---
> Changelog:
> - V2: Fix the entry condition
> - V1: https://lore.kernel.org/linux-xfs/ZyFJm7xg7Msd6eVr@dread.disaster.area/T/#t
> ---
>  fs/xfs/libxfs/xfs_bmap.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> index 36dd08d13293..c1e5372b6b2e 100644
> --- a/fs/xfs/libxfs/xfs_bmap.c
> +++ b/fs/xfs/libxfs/xfs_bmap.c
> @@ -3531,12 +3531,14 @@ xfs_bmap_btalloc_at_eof(
>  	int			error;
>  
>  	/*
> -	 * If there are already extents in the file, try an exact EOF block
> -	 * allocation to extend the file as a contiguous extent. If that fails,
> -	 * or it's the first allocation in a file, just try for a stripe aligned
> -	 * allocation.
> +	 * If there are already extents in the file, and xfs_bmap_adjacent() has
> +	 * given a better blkno, try an exact EOF block allocation to extend the
> +	 * file as a contiguous extent. If that fails, or it's the first
> +	 * allocation in a file, just try for a stripe aligned allocation.
>  	 */
> -	if (ap->offset) {
> +	if (ap->prev.br_startoff != NULLFILEOFF &&
> +	     !isnullstartblock(ap->prev.br_startblock) &&
> +	     xfs_bmap_adjacent_valid(ap, ap->blkno, ap->prev.br_startblock)) {

There's no need for calling xfs_bmap_adjacent_valid() here -
we know that ap->blkno is valid because the
bounds checking has already been done by xfs_bmap_adjacent().

Actually, for another patch, the bounds checking in
xfs_bmap_adjacent_valid() is incorrect. What happens if the last AG
is a runt? i.e. it open codes xfs_verify_fsbno() and gets it wrong.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

