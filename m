Return-Path: <linux-kernel+bounces-574964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D81A6EC08
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93A7D7A32BC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB591C8611;
	Tue, 25 Mar 2025 08:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlhDJntn"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7A61A239D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 08:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742893191; cv=none; b=gH8pzqNiJAgIKD3oxZqhIacJbI2rc0/BWyITZLOjTNNiREvbzysz/MppZMw4DYJHgH8+AcdLN5MNC+x41pGl9u0Q5iq5Bp8dT5iuQH6WYZDcPDqNfNZTShsPPr2ZxAC7//GMjxN2k9vJ3aHx6v3AE4257zjF7aCHeuykyY5KUcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742893191; c=relaxed/simple;
	bh=ofLmYNjdbpyhD44h5YU4MrDqG5F9Y4nedaNje98DxbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJA9gFOWGlAZSav3RBHSKIBFmEObFVJ6qlg0pr8DuoNUnrPbr3sHwDyRlcivjFuPkMd5UfXZLmEJBwZdLXes3rn8wsbYhzH4bTd16LB44ZmJYxItQcA3rFuA8sLc2i3W1l3uB7Ljf5CXQNxkdify2HhFPc965jK4FkHqq70hWSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlhDJntn; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39127effa72so580206f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 01:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742893187; x=1743497987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glsT11ch6LS6yViOCJ/VQP3qGlWpbr1oPnawjwbltqU=;
        b=jlhDJntnkDWCUR3O+mAb0xFCxuDkz8Ik33aW5I1iE+eKmPNsGc1E4hzPtEixGw0z7K
         OYaDp6EV+WXFE9qg4U67KXPKsFGWD4rVPTWu+3YIPXxv6zt0CPDUDIDWmnkoZyi9Y+Be
         Dtm4H6AaLdeqZdtJcxEwrQFvNXbUzPGHH6UjfE55/GNRuVM+xPrbzoQBRteBemfKwiud
         ccTqrPFWXFtwoWL445Fr1clA//wO1mcvNxSkTMrC3pDNVuqZYhc/qfnes3ljZn5aMFdX
         I5QQBkyxjbuN2c/CNOpHEWESI7+6snl2tcJHBIknEbys+3l91eMOFLf/Xdp51YKrf+Qe
         UbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742893187; x=1743497987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=glsT11ch6LS6yViOCJ/VQP3qGlWpbr1oPnawjwbltqU=;
        b=HFWrKbIhKRHIM/GAMztCfRr0wnvngNI4yjBJyn+DHQ88MJ0s6kU7af3PKh9Gsw7H+r
         fnNB/lGurIbjGgOOqTyVF3m+22QnU35CFiCixwzSeP1Y3FW0JhucBpP9Thfmfa0KWuNV
         khCYzELaKWKcs8lS65dH1DCdMf/AoG752wKceR2QB+O3Zlt4RtIYi6qR8HdiDe2+l4Tt
         RC/MwVNjhs7dkgLjNIyFD6rgi3hhRi1ipjp9MhStxuHxsrUSSoG64Pe0NRT+onKlTD16
         BB/kesCt/7Abpo9w2NQ/ZOnl3EkrBlxfm0IYpxtghclzcoIl/yAKdGGLtR3ERpm1qQVw
         SaYA==
X-Forwarded-Encrypted: i=1; AJvYcCVPQfMB7N2IbeLD6Tn2AXZHmNDMpy/9NFxQ8j+Cez6Q1QUPjWAILbffZpACbiPLX9VhLxA3vSx3+pNL6ws=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcJ44EyGTxHiq/pqIId1UM0OWyORr5dchQy07H0ECdoXFL6V+O
	JjjN8esPGj696MBALg3MbEmVCA/PcvipwVj7N6Gmg6/LP/kbvvRDSNXONB/7eIX0O67B2bdF1in
	oaVK5WTU1k7B4CBXpuS0BDR2Bu6c=
X-Gm-Gg: ASbGnctYBohkqfy0dnZIqBQmU0hWPyF93l1C8OeL8kCvEdNUo2hRBdjEKMwNjwvOD+d
	mXkQMC6evoHZaFMEgE+0UlVTpUAvb/4QCcDSqVDkd7Qg5nakZ7jRd8G8Aq/sIX00yLjx9yOarb8
	xwnIKJLbt8vQX8TLTPFZWxaQ54dNY=
X-Google-Smtp-Source: AGHT+IGlFLOkvqgLQoad7JIPOSLXkZC37ZBSFekySUSnVOY7c3NB6TdbLk5QHx4qnk7I2u+fUirodl2TMiGq3jgQXmw=
X-Received: by 2002:a05:6000:1864:b0:391:10c5:d1b4 with SMTP id
 ffacd0b85a97d-3997f90c5c0mr5641935f8f.7.1742893187080; Tue, 25 Mar 2025
 01:59:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325081321.3296714-1-chao@kernel.org>
In-Reply-To: <20250325081321.3296714-1-chao@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Tue, 25 Mar 2025 16:59:35 +0800
X-Gm-Features: AQ5f1Jqb4RDwBaBuaX-qxrbYUKJDl4U_AwjAIlhbhcx9wnk7MrjM02VFoCUQO30
Message-ID: <CAHJ8P3+tfdMZ=MNdiYx0HCwf0vWuf9ezJONsrvEhh3DbcQhMiw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add a fast path in finish_preallocate_blocks()
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
=E4=BA=8E2025=E5=B9=B43=E6=9C=8825=E6=97=A5=E5=91=A8=E4=BA=8C 16:15=E5=86=
=99=E9=81=93=EF=BC=9A
>
> This patch uses i_sem to protect access/update on f2fs_inode_info.flag
> in finish_preallocate_blocks(), it avoids grabbing inode_lock() in
> each open().
>
> Signed-off-by: Chao Yu <chao@kernel.org>

Reviewed-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
thanks=EF=BC=81
> ---
> v2:
> - get rid of read lock during querying FI_OPENED_FILE once we held
> inode lock.
>  fs/f2fs/file.c | 37 ++++++++++++++++++++-----------------
>  1 file changed, 20 insertions(+), 17 deletions(-)
>
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index abbcbb5865a3..a71946976761 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -554,19 +554,21 @@ static int f2fs_file_mmap(struct file *file, struct=
 vm_area_struct *vma)
>
>  static int finish_preallocate_blocks(struct inode *inode)
>  {
> -       int ret;
> +       int ret =3D 0;
> +       bool opened;
>
> -       inode_lock(inode);
> -       if (is_inode_flag_set(inode, FI_OPENED_FILE)) {
> -               inode_unlock(inode);
> +       f2fs_down_read(&F2FS_I(inode)->i_sem);
> +       opened =3D is_inode_flag_set(inode, FI_OPENED_FILE);
> +       f2fs_up_read(&F2FS_I(inode)->i_sem);
> +       if (opened)
>                 return 0;
> -       }
>
> -       if (!file_should_truncate(inode)) {
> -               set_inode_flag(inode, FI_OPENED_FILE);
> -               inode_unlock(inode);
> -               return 0;
> -       }
> +       inode_lock(inode);
> +       if (is_inode_flag_set(inode, FI_OPENED_FILE))
> +               goto out_unlock;
> +
> +       if (!file_should_truncate(inode))
> +               goto out_update;
>
>         f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>         filemap_invalidate_lock(inode->i_mapping);
> @@ -576,16 +578,17 @@ static int finish_preallocate_blocks(struct inode *=
inode)
>
>         filemap_invalidate_unlock(inode->i_mapping);
>         f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> -
> -       if (!ret)
> -               set_inode_flag(inode, FI_OPENED_FILE);
> -
> -       inode_unlock(inode);
>         if (ret)
> -               return ret;
> +               goto out_unlock;
>
>         file_dont_truncate(inode);
> -       return 0;
> +out_update:
> +       f2fs_down_write(&F2FS_I(inode)->i_sem);
> +       set_inode_flag(inode, FI_OPENED_FILE);
> +       f2fs_up_write(&F2FS_I(inode)->i_sem);
> +out_unlock:
> +       inode_unlock(inode);
> +       return ret;
>  }
>
>  static int f2fs_file_open(struct inode *inode, struct file *filp)
> --
> 2.48.1
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

