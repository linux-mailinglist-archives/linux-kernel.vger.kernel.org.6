Return-Path: <linux-kernel+bounces-561996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71ACBA61A0E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 20:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 332767AD5A0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F452204C10;
	Fri, 14 Mar 2025 19:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnlHEMH4"
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55086204875
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 19:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741979103; cv=none; b=AaUmFCUHQi1/xZMS+Ow3ypQ4b8IBqYkQfYBiAS2V+j9xzwWE50bsmocwbKfUvETrA11qwc5k9fBoydUd65mhDG/YhPBH+Oh1utz8/cz02OAzsi9QplODgiqP656RB7A0bVT8wSIczIe2YE81bdZ2PfdM1y955B0jXUR4CmSfA0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741979103; c=relaxed/simple;
	bh=zJLPu1GoqF+5vVclmsqGcWXDg6s2qsbkrCvg0SZ86Z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QaeQTAUCN4cbf6vftml+HPstDOVLBueMHZHQeOX4v+ckfc7ITpi1ICuobZwMUH6rB6Indcbxo1epKk73+gt9ZbXYYbp6/q/myqn9GadWTpxVKXRWzBtqJSRE+BvcGOgFrdptP8BqEgVlKj8k4szJeZhqmQ28bLETNIHfOO4bl78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnlHEMH4; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-524168b16d3so2225026e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 12:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741979101; x=1742583901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+9RYBlSqRiX3sFXlbBUdxZAuHY9PtDnv2uTp7oZT6w=;
        b=TnlHEMH4CR1jhKj51cASKYyHrooVtxUGZHLN9GTyQvkC8YFLePVALRvSvTepZgIpdy
         JvLBP16qbbch9bJ0BFpLR4qQt5Sy/hwLuYgHM0hyQvfvIzRjJjhwhQZsnrwW/0cag9KZ
         GmTO6A7UiPhbgBLfmqUu+pEZ19irKRhUmF+IdiNTzlc+FwOQBKwWqNQXNTSf3eFvIFTj
         PSQtTbnhByiWcbr9EUmo+009Tau8d82Une8Nlvne3iQKe7jRLLGGDNgzHKfwVb8/iyaB
         CtAsLx0C0FcrJNKYFkCW2ZdUNZDcFhGnYrg/yf92XlJwSGkAbbxRwwxM0m1GrmHG2d2t
         HERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741979101; x=1742583901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+9RYBlSqRiX3sFXlbBUdxZAuHY9PtDnv2uTp7oZT6w=;
        b=uH6TPexdi64b5U+YjpLTBuyWNuUhgeDXBLD5dE8X95J/5brpwBshOAu+2dgFqjaiAk
         0pebXnr80vJbLuLsknDTOH5Mxi+r3qVbtItYYNEw1D+HfTecJ45WCvJmWQlMxdFLveMT
         2OrmH2WSKfP7tCYdt0QgGMjgjZLj1mJxAiFXhSueZCb/RajedPs6IwnVA/mKyPo3ydPd
         uIM3hu6kCYV3wYUIOH+pu99WeHjqq5W6kHKFf7IjP5K64rh+hQaAbhyR2oERgPQmGHZQ
         rQ5q5aPNjbPVljI+0rxcAgHCHWh1mwmN4qlj+KKAH3aM8wwx28dvMWmBSxo0Wjpd9gXC
         oMVg==
X-Forwarded-Encrypted: i=1; AJvYcCUWsxcCo2eSLwKFRppdbf9l+qYQqMow3jpeGgjSUEBrg6CV6wL051ixFKbMdtOfNdL1PBG5XJiV8nWbYgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRtTsZiFdKk5Ziin/3jAC7hj41U/vlbbDprFD2jDODKOfEkMnD
	Nv1Wb/labJiRpKA/Do8vFSgaq5o4dkOnGvt/p7YryxwSNcWBF0p3/kUQDl3yRSHUpUAM+vG84D4
	m07n8EAS6ZUVjvG/HAWQ0gEiheZI=
X-Gm-Gg: ASbGnctVsFvK223QYsGz0mtP4VbYZP7xbe00jHXvwtaDUs0aYjGcnguLZAGflekibuF
	wTV/it/fMj5vx2K29YKWBnWw/7jHKBXaNMAYt+c8HD5zoeY8wlGHFpYnvCpdOLXTNwouNq4IA8l
	lgaG00TLE90/qsO0ih8CJ1d1mGaY2D0oXqtrdwj5lJ4wZ7rT2438y3RFA604s=
X-Google-Smtp-Source: AGHT+IHSxr4sqDV0Iyx6V7mpVn8a9lgdX17/Sft3eqo4Vh/Gr7EPaIw21V6PYc/Ax4PeyjP764VH/SCjWs4fEQFX9Ag=
X-Received: by 2002:a05:6122:91c:b0:523:a88b:9ac5 with SMTP id
 71dfb90a1353d-524499d5a99mr2787065e0c.9.1741979100992; Fri, 14 Mar 2025
 12:05:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250314120658epcas1p2d3ec037c294d4c907ce7fa2fe1c3aa27@epcas1p2.samsung.com>
 <20250314120651.443184-1-youngjin.gil@samsung.com>
In-Reply-To: <20250314120651.443184-1-youngjin.gil@samsung.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Fri, 14 Mar 2025 12:04:50 -0700
X-Gm-Features: AQ5f1JoR6iPCcAf1uBQxQ_-rGg6lhmrsBSsfLKffnPDtVLsKGXJBC4ZLXOW0OU4
Message-ID: <CACOAw_xVx_xHV9iVspKYK_sRnNYeqv1Ldk1teWyE-vyUNF1-Sw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid atomicity corruption of
 atomic file
To: Yeongjin Gil <youngjin.gil@samsung.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, daehojeong@google.com, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 5:28=E2=80=AFAM Yeongjin Gil <youngjin.gil@samsung.=
com> wrote:
>
> In the case of the following call stack for an atomic file,
> FI_DIRTY_INODE is set, but FI_ATOMIC_DIRTIED is not subsequently set.
>
> f2fs_file_write_iter
>   f2fs_map_blocks
>     f2fs_reserve_new_blocks
>       inc_valid_block_count
>         __mark_inode_dirty(dquot)
>           f2fs_dirty_inode
>
> If FI_ATOMIC_DIRTIED is not set, atomic file can encounter corruption
> due to a mismatch between old file size and new data.
>
> To resolve this issue, I changed to set FI_ATOMIC_DIRTIED when
> FI_DIRTY_INODE is set. This ensures that FI_DIRTY_INODE, which was
> previously cleared by the Writeback thread during the commit atomic, is
> set and i_size is updated.
>
> Fixes: fccaa81de87e ("f2fs: prevent atomic file from being dirtied before=
 commit")
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
> Reviewed-by: Sunmin Jeong <s_min.jeong@samsung.com>
> Signed-off-by: Yeongjin Gil <youngjin.gil@samsung.com>
> ---
>  fs/f2fs/inode.c | 4 +---
>  fs/f2fs/super.c | 4 ++++
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index aa2f41696a88..83f862578fc8 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -34,10 +34,8 @@ void f2fs_mark_inode_dirty_sync(struct inode *inode, b=
ool sync)
>         if (f2fs_inode_dirtied(inode, sync))
>                 return;
>
> -       if (f2fs_is_atomic_file(inode)) {
> -               set_inode_flag(inode, FI_ATOMIC_DIRTIED);
> +       if (f2fs_is_atomic_file(inode))
>                 return;
> -       }
>
>         mark_inode_dirty_sync(inode);
>  }
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 397df271885c..c08d52c6467a 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1534,6 +1534,10 @@ int f2fs_inode_dirtied(struct inode *inode, bool s=
ync)
>                 inc_page_count(sbi, F2FS_DIRTY_IMETA);
>         }
>         spin_unlock(&sbi->inode_lock[DIRTY_META]);
> +
> +       if (!ret && f2fs_is_atomic_file(inode))
> +               set_inode_flag(inode, FI_ATOMIC_DIRTIED);
> +
>         return ret;
>  }
>
> --
> 2.34.1
>
>

Reviewed-by: Daeho Jeong <daehojeong@google.com>

Thanks!

>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

