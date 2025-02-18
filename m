Return-Path: <linux-kernel+bounces-518967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C202A3967A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A92151894311
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8833E22E3EA;
	Tue, 18 Feb 2025 09:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="qmdWGDbL"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C8822E019
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739869636; cv=none; b=DHWTE34kop8GFLlsVXXcsyaHmii/b+9+QoKNTkXNWUwR6NXkYM+1zi13sL3t5wlPP8SeGzuUg8JcOJzZ1jK0EsJlGPzSZio4C6pW6PiVWY1RxtU5dCbiBTvmy3uUpNp9GZN9LUc9cKOFu6ahG00WG7fE1NXGUNl/llB1fQ6CbHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739869636; c=relaxed/simple;
	bh=V6siWVB94BUBB6jBj3ebnaicEq3lFZHszgU93IMsniM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=na4YLBLQ6dq5esOiuEqIDOAmmcafQP5dnHtYtDb7EzhIPHWaZY3zgB7PSgJIFPv6lUXrnQk6TB800ZyTDrRThUYqMSs+J2xv9HrQERrgMoMjzjLKddubWxXleZ/9HPcbTpBvX/JW95QRhzdpe09oKz06HQLpL4QWTF4cwkr58pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=qmdWGDbL; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-471c8bcb4a9so40869621cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 01:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1739869631; x=1740474431; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fbFS7RZBcrA+GC03runhBHiC/eEvuCTkD7j7UDaMQRg=;
        b=qmdWGDbLpg515pSqkMBAgoLYGje5YL5YlHTHpJNke3HPqbon6Ua/1k1oxkGqjDG5Yy
         Gq96JSsuLgNvwda3lCxMLyEBFt1YRr/Naxr583McjRD6O/Udo0fON6jd5TmQxOOTkL/C
         7lyZOzfCNNI+7fmCkDso2ixKdqImiE+BGUFh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739869631; x=1740474431;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fbFS7RZBcrA+GC03runhBHiC/eEvuCTkD7j7UDaMQRg=;
        b=h2ygq4XOWXkgPc45ljSnNQIk+zYuY0qp4+A9GIHcrfA0gPAg4/Ur0jVY4tTYbnXjZR
         qEIjy1PnsoQY8PAg8N4OxadWilZli85r+dh1kCsCjZe02a8jU3O3WHzrneGWCGO4SgLF
         VKYzSXsUeANw2nHlZBU4Swy/3UzGloafE77D9UTa+y4g/VyuV+7GsZlccMBSi4c7ChzV
         OV+uJ8FTwJ0oJt0AYkdaKlCpU0G61HlD+1Bi6xWCdAUyiBHcN4EAIpDbxNtS3DDLqcmD
         Fse/WMNbDAOz3QKs4rvaV+pbHUE9IVeLqB/Q8noSTZGCgmYPVkNa3LfDN/QqbcxS4s+F
         OwmA==
X-Forwarded-Encrypted: i=1; AJvYcCUT2CbiJ2H4vlcxBLKXvr0M03gBqjD863HEk5xEbkyBGLl/qJ6ffrUBxBlpfOvjEF1tda+vN32PlQn5YMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNictp4z8bYn6IvykQmOerQV9K0wLnMjdbNyRda3EuHmLJHxdB
	/ZahVSzl8Ps0d3lEqsLNLGP6rw0dzCU+wVPbzhA1TSJRQ4QC8Xow7GtWrpzUS8Rsp+dyThrS+Ux
	SDIhb558Obc0rji4hAND28AhgzmkyCW0lrLO+2g==
X-Gm-Gg: ASbGnctzjdFUPki12PWQ/kKAHB2Nk7zA97LN/kjYyyS5ebp0FIw/uHQnnHMzEcoeGqS
	CLxN5tKSZwlN/cD801RksoU+mXjIKNRgW4BoJ0YctdMGPKERHEpw22mdzIRqKC2PIibRuvVo=
X-Google-Smtp-Source: AGHT+IHO0WiXpE20jw5jR/lmxsoUW8V0GbKJCKSfHlrxnO3HrU7Vb3OjBwge4nQyHf3TtYN9kD68GyH92qM424tAcfE=
X-Received: by 2002:ac8:5e53:0:b0:471:87dd:fbee with SMTP id
 d75a77b69052e-471dbcde6b4mr174745411cf.4.1739869630962; Tue, 18 Feb 2025
 01:07:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217133228.24405-1-luis@igalia.com> <20250217133228.24405-3-luis@igalia.com>
In-Reply-To: <20250217133228.24405-3-luis@igalia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 18 Feb 2025 10:07:00 +0100
X-Gm-Features: AWEUYZmgaspYOE0vmLhDJFrd6oAQWWOfcfAbI896UYiT11k8XCYR_jm9BKijtAU
Message-ID: <CAJfpegtJTUBa7zhY7S-vPCDc+QaJPCg+pH4NR4vN_GgwSAROGA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] fuse: add new function to invalidate cache for all inodes
To: Luis Henriques <luis@igalia.com>
Cc: Bernd Schubert <bschubert@ddn.com>, Dave Chinner <david@fromorbit.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Matt Harvey <mharvey@jumptrading.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Feb 2025 at 14:32, Luis Henriques <luis@igalia.com> wrote:
>
> Currently userspace is able to notify the kernel to invalidate the cache
> for an inode.  This means that, if all the inodes in a filesystem need to
> be invalidated, then userspace needs to iterate through all of them and do
> this kernel notification separately.
>
> This patch adds a new option that allows userspace to invalidate all the
> inodes with a single notification operation.  In addition to invalidate
> all the inodes, it also shrinks the sb dcache.

What is your use case for dropping all inodes?

There's a reason for doing cache shrinking that I know of, and that's
about resources held by the fuse server (e.g. open files) for each
cached inode.  In that case what's really needed is something that
tells the fuse client (the kernel or in case of virtiofs, the guest
kernel) to get rid of the N least recently used inodes.


> Signed-off-by: Luis Henriques <luis@igalia.com>
> ---
>  fs/fuse/inode.c           | 34 ++++++++++++++++++++++++++++++++++
>  include/uapi/linux/fuse.h |  3 +++
>  2 files changed, 37 insertions(+)
>
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index e9db2cb8c150..64fa0806e97d 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -547,6 +547,37 @@ struct inode *fuse_ilookup(struct fuse_conn *fc, u64 nodeid,
>         return NULL;
>  }
>
> +static int fuse_reverse_inval_all(struct fuse_conn *fc)
> +{
> +       struct fuse_mount *fm;
> +       struct inode *inode;
> +
> +       inode = fuse_ilookup(fc, FUSE_ROOT_ID, &fm);
> +       if (!inode || !fm)
> +               return -ENOENT;
> +       iput(inode);
> +
> +       /* Remove all possible active references to cached inodes */
> +       shrink_dcache_sb(fm->sb);
> +
> +       /* Remove all unreferenced inodes from cache */
> +       invalidate_inodes(fm->sb);

After a dcache shrink, this is unnecessary.  See " .drop_inode =
generic_delete_inode," in fs/fuse/inode.c

Thanks,
Miklos

