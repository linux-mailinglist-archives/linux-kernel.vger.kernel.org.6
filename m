Return-Path: <linux-kernel+bounces-399557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 210909C00AE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7FED1F234D5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 08:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11851DF728;
	Thu,  7 Nov 2024 08:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="RymHR9Bh"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCFF1DEFC4
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 08:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730969898; cv=none; b=rpxkV0WaqaCzxg90zH1p0urCtRwiewE0wcAMoLLgvI2U4a//6PRxG+ZzgEAJz4BhNbL9yct5PQS3Jte1p63vOYJ8Sirw20CTxiKX6rd01rrDXFPsxt6x37RUEgI8iVbERGu2kDTyGe/65t+qR7nYOe5pBIv5ALFsDdQvKdx/mhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730969898; c=relaxed/simple;
	bh=XrCKTdSFrneJtpr4KeJ/1FrI8UZO5czXGK0I+q8xUNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EvMgIxeCN2mdLcrhgUDre1uokmqM3a/E2/wRyXS2JI/W4d79wil/+++I/x7YsP2CuLxryPaaKYaxkWC+cx0J7fjkm0bEWD4Nb6hfhuuIkg7kVLglRmsZOOZDU+RtldSkWVh7HzfcP1E6huf1Kw4BmEJy6bhjtr4RgD0QVJ8Uxt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=RymHR9Bh; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-460ad0440ddso3694911cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 00:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1730969893; x=1731574693; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I8US13aD05PtGROBNY39A0+lWIja+wUH11z2O2DFmBA=;
        b=RymHR9Bh0pgRR0IgSOT1+bFskjCR/mYgDnSV7HKzrbTZ9eRwNDWMKx1scs6Gnq4wss
         8zqZwYZI9jWagHV1/Fr+wp47gCtksRxi7j3DCAy0wRqMD+ItwLItkW5pxrsLiVKezUTf
         k6ND8RTgrxZix8Br4q1FaULboE4itmWIvlMXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730969893; x=1731574693;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I8US13aD05PtGROBNY39A0+lWIja+wUH11z2O2DFmBA=;
        b=HxbeweQirRn1z2Bau6WH5/lmQKA5HwXz3bdEgW2Kq2Hn1IF92NmwNsjXpE0nghF2GK
         2aCLhsKZsum3JLuM0UfDW/s/pKrw+4wAMpXqdIip+LBwbRLTMY7sHjZMkq0zV4/hJQT6
         g5FXIPDSM8jmX33aWrFA3+Q6xQtavPDldwrn6XlcY2JGcjSmhbwT35tsK4uUAw/fFYny
         0r2xUk/Uybl0MRpvwTFT0YULDhRqIDfSrFX4Lls9qkPOZQTfMVeZw1gHiTWgaW559f8U
         u4Y7oMS4BGdNSQov7R0259OKYgmcolJhsEOSKxVrFZET2EwDg8AHGMWc8zIEu7gTncTk
         kjMw==
X-Gm-Message-State: AOJu0Yy9HbwW5NMhwkM0FzAwpqWqPSp3yxWiAdtE1IP5TF5aFhdihB90
	4GBbM0+d2bWpwMjdwFPYVcClswefo4198XjAqOI+o6rv3njsch3UEtvRmeFn0YYbZcKDjAH10z4
	oBKkOf8aJj+k/z+z9GF4xlc82EC3P7M4z49TBgA==
X-Google-Smtp-Source: AGHT+IHxPaWfeaWr7QYviaFixyD3GiKGEj6bLFLoEq9c1pZwSytCfLOCtXu+dknJoRl+41zTEmU1wKDp6CHqkFdc/0c=
X-Received: by 2002:a05:622a:1a0a:b0:462:f690:d202 with SMTP id
 d75a77b69052e-462f690d251mr43546551cf.40.1730969892756; Thu, 07 Nov 2024
 00:58:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024164726.77485-1-hreitz@redhat.com>
In-Reply-To: <20241024164726.77485-1-hreitz@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 7 Nov 2024 09:58:02 +0100
Message-ID: <CAJfpeguWjwXtM4VJYP2+-0KK5Jkz80eKpWc-ST+yMuKL6Be0=w@mail.gmail.com>
Subject: Re: [PATCH] virtio-fs: Query rootmode during mount
To: Hanna Czenczek <hreitz@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	virtualization@lists.linux.dev, Miklos Szeredi <mszeredi@redhat.com>, 
	German Maglione <gmaglione@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Oct 2024 at 18:47, Hanna Czenczek <hreitz@redhat.com> wrote:

> To be able to issue INIT (and GETATTR), we need to at least partially
> initialize the super_block structure, which is currently done via
> fuse_fill_super_common().

What exactly is needed to be initialized?

> @@ -1762,18 +1801,12 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
>         sb->s_d_op = &fuse_dentry_operations;
>
>         mutex_lock(&fuse_mutex);
> -       err = -EINVAL;
> -       if (ctx->fudptr && *ctx->fudptr)
> -               goto err_unlock;
> -
>         err = fuse_ctl_add_conn(fc);
>         if (err)
>                 goto err_unlock;
>
>         list_add_tail(&fc->entry, &fuse_conn_list);
>         sb->s_root = root_dentry;
> -       if (ctx->fudptr)
> -               *ctx->fudptr = fud;

This is wrong, because we need the fuse_mutex protection for checking
and setting the private_data on the fuse device file.

If this split is needed (which I'm not sure) then fud allocation
should probably be moved to part2 instead of moving the *ctx->fudptr
setup to part1.


> @@ -1635,8 +1657,16 @@ static void virtio_kill_sb(struct super_block *sb)
>         struct fuse_mount *fm = get_fuse_mount_super(sb);
>         bool last;
>
> -       /* If mount failed, we can still be called without any fc */
> -       if (sb->s_root) {
> +       /*
> +        * Only destroy the connection after full initialization, i.e.
> +        * once s_root is set (see commit d534d31d6a45d).
> +        * One exception: For virtio-fs, we call INIT before s_root is
> +        * set so we can determine the root node's mode.  We must call
> +        * DESTROY after INIT.  So if an error occurs during that time
> +        * window (specifically in fuse_make_root_inode()), we still
> +        * need to call virtio_fs_conn_destroy() here.
> +        */
> +       if (sb->s_root || (fm->fc && fm->fc->initialized && !fm->submount)) {

How could fm->submount be set if sb->s_root isn't?  Or sb->s_root set
and fc->initialized isn't?

Seems it would be sufficient to check fm->fc->initialized, no?

Thanks,
Miklos

