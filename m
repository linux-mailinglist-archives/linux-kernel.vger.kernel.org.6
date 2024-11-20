Return-Path: <linux-kernel+bounces-416351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B989D4395
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 22:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01E73B23858
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 21:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617FD1C1F0A;
	Wed, 20 Nov 2024 21:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBRGm/nv"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D3F219ED
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 21:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732138517; cv=none; b=q+ENPk0l6RQT5nRPqKJTJPWhxASrdZKTRey2LMWfk07Z+P/tklD1f0auzBoIRlr4v9MiWtXW8HJ2Oud5kVxOhBezFIjugha0x3p/X8J4qfadYJzxaMgb6SxNN3vON9SyErKMWrXiw2i1amuotLuuhG+cGcUe7O3AoIDxnCtgXME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732138517; c=relaxed/simple;
	bh=lM/WKcDKIwOXst1Ru1M19tCM8Fi5ObiOLcFy8LJgHSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pVZP+nV5n2yjBCqR4d8wogieI0Ew6z5LqMzk+oC+jdEOxee0/tEsKev5Kmx/mNHdNR3utcZQxgeU033j1kFErHyd79r0fU4ykKLchbTi/GleDnCv+ibzQcIi9yvymPYP7u78DEedLD7srl89TiBbocGA6U21Y1cnvb0Ic1HxAao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBRGm/nv; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-856f9be0389so80224241.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 13:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732138515; x=1732743315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pv6oNkx5kLI5l81tt9YoIOgWAGXnk3pmvt99mDOzf+I=;
        b=bBRGm/nv/Dz4uUzTpKgeLhko/5WAJyuLVG3aNjhIZGveU1jDOvrO096008izhBbSbZ
         Kv9BQR4G3+MsPZtOGdwTQFXyvlRi+M0A0KLvTyf+22HYQNc0gqWWULxVZgraAqfxvU7B
         qjsvx8pCLDXGg4b58yvmH8KCXMxPWtkbE1HQGMyNNZOsuwP1MoMxg7PXWiw25mHCZlqC
         OzVkq4vz9w2gjnc1gWI3HZfmps63yeqR0EhAY5IQDI1xwdBr07TIOFWO8uRghbWV0oTu
         +aTeZAnCYFg5QD1nj2vxKX/+ciVQ8lxAAXVyDZ4lJs3nbAlTIWn3hvqhRj0PlXtRpTxz
         p1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732138515; x=1732743315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pv6oNkx5kLI5l81tt9YoIOgWAGXnk3pmvt99mDOzf+I=;
        b=PG+JxDAp2G3UW7STgMjDh4zKfQuWpY6WSMTBtzQUSzMhisi9MP7Z8Is9FMD21a1qau
         vHedvbGQDUKHDeF0GVCq3uHiHUsj4AKMMeKy2WAE0fdra3TGXRUZe3Opvp4W/iHN4SWG
         7plIY7BJ64jbKt3JJv/kxfcl1X3l3VJ37gXFFLyj0wAUp15m+MpxGuzly4NGmWSwtzrP
         CAxeY7VDBLnwb2Ip2YVdcbiO1XhFdQ+Bdv0xdOFWplr8q3sBNXMRCEw3ol+wugQO4vbk
         dF5uD4RFOYXFlSuni1tMiGxWH1JNhg99aby6G0lyPqXr1sbvNA8bZ0568W74TQPSKD9v
         lTXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBnL5QfQgVCpP6JozZpE6DNEMacj+ipmEw7PpBh+2Iy6EC40IAa6RQw0nwT0d90e4NkXS0zasbE+wW+38=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb5Pq5pIz6WQeWDUL51bKFybthQfoUbB2O/mAaqWVlxvmuWIMY
	4jFWpN4R9V5blcGQ2YZdpAJ2G7J/tkKqp23jS3yOWaLDIq/8CMfhqYqZMEi1fRYdPh0EPmVwC2c
	VCdmGJEsolOxDa0BurvsOLngOs48=
X-Gm-Gg: ASbGncszLyUSkBlb1a1nEsqEZ1eGhUeOwgjWxKebjtYFK8hgKjffuYPjIqTonjxDQAJ
	1Ry163qp2cM3EvHnjuYXPUAziG/+k/8dYedrplX47+YUCsrrZIpbS37gCuMuOqaMy+w==
X-Google-Smtp-Source: AGHT+IFvm29J3oFLKuPgZZJeJU/V5JpXf/pNMOYGnCoFS57wIUTFTg5ufU+JA0M0pQEWEykYWep6FN21VVG1GartUBg=
X-Received: by 2002:a05:6102:3f8b:b0:4a4:7928:638f with SMTP id
 ada2fe7eead31-4adaf41110cmr6210467137.3.1732138515100; Wed, 20 Nov 2024
 13:35:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c6a2085278292be8ccc24635ad75b0a59f3cd7dd.1731397290.git.baolin.wang@linux.alibaba.com>
 <45509f49416849e6708a4fd57c988b8b0921210a.1731480582.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <45509f49416849e6708a4fd57c988b8b0921210a.1731480582.git.baolin.wang@linux.alibaba.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 21 Nov 2024 10:35:04 +1300
Message-ID: <CAGsJ_4xvkcB6_g+RENBZ-G8aY7HZ4bdVGVgs2f8H7PSACtJrBw@mail.gmail.com>
Subject: Re: [PATCH] docs: tmpfs: update the huge folios policy for tmpfs and
 shmem fix
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, da.gomez@samsung.com, david@redhat.com, 
	hughd@google.com, ioworker0@gmail.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, ryan.roberts@arm.com, wangkefeng.wang@huawei.com, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 7:57=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> Drop 'fadvise()' from the doc, since fadvise() has no HUGEPAGE advise
> currently.
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Reviewed-by: Barry Song <baohua@kernel.org>

I couldn=E2=80=99t find any mention of HUGEPAGE in fadvise() either.

FADV_NORMAL
FADV_RANDOM
FADV_SEQUENTIAL
FADV_WILLNEED
FADV_DONTNEED
FADV_NOREUSE

> ---
>  Documentation/admin-guide/mm/transhuge.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/a=
dmin-guide/mm/transhuge.rst
> index ba6edff728ed..333958ef0d5f 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -382,10 +382,10 @@ never
>
>  within_size
>      Only allocate huge page if it will be fully within i_size.
> -    Also respect fadvise()/madvise() hints;
> +    Also respect madvise() hints;
>
>  advise
> -    Only allocate huge pages if requested with fadvise()/madvise();
> +    Only allocate huge pages if requested with madvise();
>
>  Remember, that the kernel may use huge pages of all available sizes, and
>  that no fine control as for the internal tmpfs mount is available.
> @@ -438,10 +438,10 @@ never
>
>  within_size
>      Only allocate <size> huge page if it will be fully within i_size.
> -    Also respect fadvise()/madvise() hints;
> +    Also respect madvise() hints;
>
>  advise
> -    Only allocate <size> huge pages if requested with fadvise()/madvise(=
);
> +    Only allocate <size> huge pages if requested with madvise();
>
>  Need of application restart
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> --
> 2.39.3
>

