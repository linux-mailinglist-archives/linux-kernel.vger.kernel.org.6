Return-Path: <linux-kernel+bounces-314097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2E196AECC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 04:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 491AE1C2166B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 02:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1F23B782;
	Wed,  4 Sep 2024 02:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1I0SuUz"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4223EEC5
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 02:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725418374; cv=none; b=d48WJ9E7upWjjjucc1J1/sqXqvMgv5IIecuRpILThz/YD0QgcCF2Ecloyl2LdvH7RgglRrKpRt+NfEbgdqN7yWpDYO8Hyt372BVkHpXTFpoVEDDxLLFlXlvsh7ShNAZjFgkzQpvHcADXIz0p3S9nOa90pLirS5kxUolMDLT2vXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725418374; c=relaxed/simple;
	bh=sC1HEzIUnmlDuluVSOuZmfOvISAWrLC6JUiHD8QcR/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TLUXciBWjxstQeeaBdVK8Zf4zx+aOxAGh2e5L1VbqKm7BvMO602WpBSmY5nonytd3VBRFyXysnqzliu039f03TAHzPPBGvs+OyFnYH9A0b2KQMMjbvt6qrWqsbTgFtxkdiYVeoVKf9YzL53/pE/OcpM/asLROzYXcZOviVI3y7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1I0SuUz; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-844f07f6205so115513241.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 19:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725418372; x=1726023172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOOBx3QtPTmrvcsY+NQ7mLw9fjjRxUnCt6gWbxiIBig=;
        b=e1I0SuUzf7mYc1tO5R2/qrY2RqkUr8s0LWL7ao4Nm3j4yDOm7UP/YR2eJLBtHMygcS
         vIWzMsn020uMFX7dTxat2ju/jLA111a3x5e25kzeYEAO+m17oto5r/SoiUPaVWUjvDAI
         HNxob0gR2UFspTiADGtUyGS0GCTe4YLbhA5W614LKUXE+w4a9rhB9AVk3XXyvTX09wOZ
         EoEBNOJQcqDdZoZQ1w5rwKcgCKL8pqZsiJNSJo9UpCUsgR4jDa04Xs5nzeaSL58YbXZz
         dZ1gJzZQlvBuM3UMy6Zp7cmAe3DZqk/S/5yBQspuG/soxukYiuwUcKKLPO7PrO+GnFKq
         oKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725418372; x=1726023172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gOOBx3QtPTmrvcsY+NQ7mLw9fjjRxUnCt6gWbxiIBig=;
        b=Lho+8lrtW7ygrzGm663TiOmULJNuk3+D83RLhq9EC8wx3xyBBuwUlcONcRUpl33/iC
         ak17+vOz8NOvd++TeoxXni3zMuNvv5ZJSwU0rFm1k3LFtVvYSYp7kAV6tCZgshmlHAJ9
         cRkhFvukWbA0ePhKYikktmH8n97TI95HXoUPGJVtksNL3GkYW7jwKcUJD3JHU9EPjyRJ
         tdSFMguKetYTrduzfdBcMpm5sy4/nytohEVLPQaZAs3eeWTySTJFE/3EDywDou4c1Tof
         lnR9xFW7j2PJv1AelrBreA6dZBvJpdNVTqDlpC8AK7jdS+CeWfYGWjXCkHukdmvlXD3T
         11UQ==
X-Gm-Message-State: AOJu0YxDDpkTJ3F+dFusW5BeMYgVN1qqma72Gw2DZ2BdDGeAi4lgvWeJ
	0HZDhh73UzWm18hRT6S15+mdYz4evxshgFkN7qQ6Yu5ebI1oxLjeG0t5OIjaBWuDiaa/Nsgp3iV
	8hd3BcgZL/ylJ40D5kaq/abFkzS8=
X-Google-Smtp-Source: AGHT+IENBRa9rPvI6TtSBIQWGOPOw17L31IEWTUJU5QaoCJJEvx/YHqQOT/FfUSaAo/7LPiQc418I1n6R9AtM8HYFG0=
X-Received: by 2002:a05:6122:328f:b0:4f5:14f9:e12c with SMTP id
 71dfb90a1353d-4fff16ee678mr22343219e0c.13.1725418371659; Tue, 03 Sep 2024
 19:52:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826202352.2150294-1-daeho43@gmail.com> <45a8a9f3-27b8-433e-a0ac-e457f4cdf1eb@kernel.org>
 <CACOAw_xMipooJy3GrZTc2CSpMoSs9FsErdxjqMWXVQ6iDiEZ0Q@mail.gmail.com> <d4f218ad-7a01-4b5b-a438-c0e4e14bbc96@kernel.org>
In-Reply-To: <d4f218ad-7a01-4b5b-a438-c0e4e14bbc96@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Tue, 3 Sep 2024 19:52:31 -0700
Message-ID: <CACOAw_zvNyD3cmMpJsidEMyrtnZYU4kR4BmE_cygroPyYoiGvA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: prevent atomic file from being dirtied
 before commit
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	kernel-team@android.com, Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 7:26=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/9/4 1:07, Daeho Jeong wrote:
> > On Mon, Sep 2, 2024 at 3:08=E2=80=AFAM Chao Yu <chao@kernel.org> wrote:
> >>
> >> On 2024/8/27 4:23, Daeho Jeong wrote:
> >>> From: Daeho Jeong <daehojeong@google.com>
> >>>
> >>> Keep atomic file clean while updating and make it dirtied during comm=
it
> >>> in order to avoid unnecessary and excessive inode updates in the prev=
ious
> >>> fix.
> >>>
> >>> Fixes: 4bf78322346f ("f2fs: mark inode dirty for FI_ATOMIC_COMMITTED =
flag")
> >>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> >>> ---
> >>>    fs/f2fs/f2fs.h    |  3 +--
> >>>    fs/f2fs/inode.c   | 10 ++++++----
> >>>    fs/f2fs/segment.c | 10 ++++++++--
> >>>    3 files changed, 15 insertions(+), 8 deletions(-)
> >>>
> >>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >>> index 465b2fd50c70..5a7f6fa8b585 100644
> >>> --- a/fs/f2fs/f2fs.h
> >>> +++ b/fs/f2fs/f2fs.h
> >>> @@ -801,7 +801,7 @@ enum {
> >>>        FI_COMPRESS_RELEASED,   /* compressed blocks were released */
> >>>        FI_ALIGNED_WRITE,       /* enable aligned write */
> >>>        FI_COW_FILE,            /* indicate COW file */
> >>> -     FI_ATOMIC_COMMITTED,    /* indicate atomic commit completed exc=
ept disk sync */
> >>> +     FI_ATOMIC_DIRTIED,      /* indicate atomic file is dirtied */
> >>>        FI_ATOMIC_REPLACE,      /* indicate atomic replace */
> >>>        FI_OPENED_FILE,         /* indicate file has been opened */
> >>>        FI_MAX,                 /* max flag, never be used */
> >>> @@ -3042,7 +3042,6 @@ static inline void __mark_inode_dirty_flag(stru=
ct inode *inode,
> >>>        case FI_INLINE_DOTS:
> >>>        case FI_PIN_FILE:
> >>>        case FI_COMPRESS_RELEASED:
> >>> -     case FI_ATOMIC_COMMITTED:
> >>>                f2fs_mark_inode_dirty_sync(inode, true);
> >>>        }
> >>>    }
> >>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> >>> index 1eb250c6b392..5dd3e55d2be2 100644
> >>> --- a/fs/f2fs/inode.c
> >>> +++ b/fs/f2fs/inode.c
> >>> @@ -35,6 +35,11 @@ void f2fs_mark_inode_dirty_sync(struct inode *inod=
e, bool sync)
> >>>        if (f2fs_inode_dirtied(inode, sync))
> >>
> >> It will return directly here if inode was dirtied, so it may missed to=
 set
> >> FI_ATOMIC_DIRTIED flag?
> >
> > Is it possible for it to be already dirty, since we already made it
> > clean with f2fs_write_inode() when we started the atomic write?
>
> Some ioctl interfaces may race w/ atomic write? e.g. set_pin_file won't
> check atomic_file status, and may dirty inode after we started atomic
> write, so we'd better detect such race condition and break ioctl to
> avoid ruin atomic write? and maybe we can add f2fs_bug_on() in
> f2fs_mark_inode_dirty_sync() to detect any other missing cases?
>

How about exchanging the positions of f2fs_write_inode() and
set_inode_flag() in f2fs_ioc_start_atomic_write()?

...
        f2fs_write_inode(inode, NULL);

        stat_inc_atomic_inode(inode);

        set_inode_flag(inode, FI_ATOMIC_FILE);
...

> Thanks,
>
> >
> >>
> >> Thanks,
> >>
> >>>                return;
> >>>
> >>> +     if (f2fs_is_atomic_file(inode)) {
> >>> +             set_inode_flag(inode, FI_ATOMIC_DIRTIED);
> >>> +             return;
> >>> +     }
> >>> +
> >>>        mark_inode_dirty_sync(inode);
> >>>    }
> >>>
> >>> @@ -653,10 +658,7 @@ void f2fs_update_inode(struct inode *inode, stru=
ct page *node_page)
> >>>        ri->i_gid =3D cpu_to_le32(i_gid_read(inode));
> >>>        ri->i_links =3D cpu_to_le32(inode->i_nlink);
> >>>        ri->i_blocks =3D cpu_to_le64(SECTOR_TO_BLOCK(inode->i_blocks) =
+ 1);
> >>> -
> >>> -     if (!f2fs_is_atomic_file(inode) ||
> >>> -                     is_inode_flag_set(inode, FI_ATOMIC_COMMITTED))
> >>> -             ri->i_size =3D cpu_to_le64(i_size_read(inode));
> >>> +     ri->i_size =3D cpu_to_le64(i_size_read(inode));
> >>>
> >>>        if (et) {
> >>>                read_lock(&et->lock);
> >>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >>> index 78c3198a6308..2b5391b229a8 100644
> >>> --- a/fs/f2fs/segment.c
> >>> +++ b/fs/f2fs/segment.c
> >>> @@ -196,9 +196,12 @@ void f2fs_abort_atomic_write(struct inode *inode=
, bool clean)
> >>>                truncate_inode_pages_final(inode->i_mapping);
> >>>
> >>>        release_atomic_write_cnt(inode);
> >>> -     clear_inode_flag(inode, FI_ATOMIC_COMMITTED);
> >>>        clear_inode_flag(inode, FI_ATOMIC_REPLACE);
> >>>        clear_inode_flag(inode, FI_ATOMIC_FILE);
> >>> +     if (is_inode_flag_set(inode, FI_ATOMIC_DIRTIED)) {
> >>> +             clear_inode_flag(inode, FI_ATOMIC_DIRTIED);
> >>> +             f2fs_mark_inode_dirty_sync(inode, true);
> >>> +     }
> >>>        stat_dec_atomic_inode(inode);
> >>>
> >>>        F2FS_I(inode)->atomic_write_task =3D NULL;
> >>> @@ -365,7 +368,10 @@ static int __f2fs_commit_atomic_write(struct ino=
de *inode)
> >>>                sbi->revoked_atomic_block +=3D fi->atomic_write_cnt;
> >>>        } else {
> >>>                sbi->committed_atomic_block +=3D fi->atomic_write_cnt;
> >>> -             set_inode_flag(inode, FI_ATOMIC_COMMITTED);
> >>> +             if (is_inode_flag_set(inode, FI_ATOMIC_DIRTIED)) {
> >>> +                     clear_inode_flag(inode, FI_ATOMIC_DIRTIED);
> >>> +                     f2fs_mark_inode_dirty_sync(inode, true);
> >>> +             }
> >>>        }
> >>>
> >>>        __complete_revoke_list(inode, &revoke_list, ret ? true : false=
);
> >>
>

