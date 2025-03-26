Return-Path: <linux-kernel+bounces-577553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0418A71EA5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7A5F3BBF66
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5139C23FC68;
	Wed, 26 Mar 2025 18:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/4wDeld"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C4517F7
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 18:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743015080; cv=none; b=RpUwC1M4oi/qbyDX1L2f+I0Bxs2hqlfE/NY0PyORvZPd9BEt+n/VfnsNCM/MdmalP9ysxhH5Ze+TVxmtHqoOqUC15RJiR/KdI/1HP31tEUxLXl6VFhp+m07+G0ioaU7ZXHpRF77nv8D52l9WiJtbO5wKZcua7GMVpUspLO+6e3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743015080; c=relaxed/simple;
	bh=GBgLMsZeMRqV2vX/c2owEWiuJ55pmuiwf90upDSGubc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JD00TUqb9EKP2+3zNW/NML9yjE0Y0Z8wepQEPvIOHVno7RscUfWXgWYg/7m68erdjBR6M/6zCH+w2GL7f5g7KF5M590TWl2zBAspERyksHCehU/EaNvtRS/UN43pxxyIkIL+WW7zXiSNmt13Sf17vvFM2IfwSxpwcDhMlATykBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/4wDeld; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-86d3805a551so74383241.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 11:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743015076; x=1743619876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KhwLvVUyaGGXrQ5Rqn/eX6++j06eIfu9CynRqkL4xvQ=;
        b=G/4wDeld7YigB0F5jnAJ/v5RGxaID1+nLZsLGhw/521h+zvewlQ/yM8hg+rj79weGT
         YTufkHcjmLHAB4n0B+rLJxBYWx9yzOruMwf7lc0UYP37RYzZp5IUq28WRW2OmvVgeCFj
         l2D6eL52npQp+eRU3CXK7W4x04iRfMNR5MbJXetzi1c3xTBC/4H8Yd36R8NWqmWDAOY4
         PqpAEH7PwgBt06zk15RNyHeJwoXk47onr9S6uGMDb5CQs7+LxoOTfY1d+bT4aYdIe1BP
         pWtUwGhV+FGcWW0Bs3f9BEmwM+kx/XcofYJHtIUgPvr7k/Z8plaHDMHTFQ2GGEyrys/g
         MF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743015076; x=1743619876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KhwLvVUyaGGXrQ5Rqn/eX6++j06eIfu9CynRqkL4xvQ=;
        b=DzFhAoyuJaMoGIGbINEDO+wxFOVVKT4Pz0aVwCP0eSzBSzCZ4V5ppqKo0O2L3AiR6F
         AYFqsvDChSntNe3ITqV9zq0Le9U5fqUNHtAhq+uAxANBvp1XvdNayAdOWNl4aysEb7yz
         uDEUc7Ajq2RdtbMc2KwBW7RQQnHYTnC+4nhDKcG9NKAtBfaIga8G/csGjowFckG1I0nK
         oZ7tYWjGUyj0xJ+8kFn4slGWK3oPLNwA3WCUKhEqoZuuCdJsPzLc61B9nU4bdy7LsYxL
         8YxZMAdvTX3FYth3Qeehx+5+l9KIYIAVfUrnsUIplfexvwt38PBRBFXFKU9e53O6qaQb
         /C8w==
X-Forwarded-Encrypted: i=1; AJvYcCXLdI0cq6DvTaEDk+j13FZG6lRIikm5v/aoIRg2XpbjQOnzb9wKlGcxtmYy0ZOiv1kNqLCD8zVMrE2g6Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc/G5pzMT2FVcYZnwsalD0sZyA7LxXr6sVMCF+/0osQHHBlv6c
	fEODRaeTdzGFBL5S+W9aOsw7IWJU9Rq2YzlUNjJbQWdXZBNE7slhri2lckQfrPHn0FyoLwPFl+Z
	suA9XiUoGhmljK6hmLa3P9PUhoyw=
X-Gm-Gg: ASbGncv8R4JBPWjhrWVJcIKPLB4bJvqlowr/0jFMp8jCgxC3SLzLw+CC3YyA4SMa1hY
	ii8lxusRcfcwdoYmZxJdF/Ss8cCrq9+pyKRo00i8NtKST3+5l3i0r4Xr6X530msCiR/ywDn2QES
	1a98nFHfHouqmc1/Zgxw0M477Ahr63dzYT7oiPxHFduUVm5UgCwYuByBrv
X-Google-Smtp-Source: AGHT+IGwBkeoS6sd4gr1aVfLZJRs0JzkD14L3FH0hyzdzb19dFr293HoSTDrObTuCpab1NYYs9Aa167HcOdZGI8s8NI=
X-Received: by 2002:a67:e716:0:b0:4bb:b809:36c6 with SMTP id
 ada2fe7eead31-4c586fa2576mr1413775137.11.1743015076250; Wed, 26 Mar 2025
 11:51:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1742978761-16264-1-git-send-email-zhiguo.niu@unisoc.com>
 <e4fb11ea-a97b-4ba0-aa28-f6f93e5a6134@kernel.org> <CAHJ8P3JWABsntymD3u5=0YR7=0it5x0PP49S4ftwBEjC1UreOA@mail.gmail.com>
 <8a72691e-28ef-4b6b-a855-62fd6c2743dc@kernel.org>
In-Reply-To: <8a72691e-28ef-4b6b-a855-62fd6c2743dc@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Wed, 26 Mar 2025 11:51:05 -0700
X-Gm-Features: AQ5f1JoRxqsXwsgId_2_iZ1biEmq72GTY2n2d4UtnIf563T_zKnJWRq8-UhLLL0
Message-ID: <CACOAw_wX3QPvpaCWW2gfKH_9Zf_=Tku14+RL6CatU9f2d2AiGQ@mail.gmail.com>
Subject: Re: [f2fs-dev] [RFC PATCH] f2fs: remove some redundant flow about FI_ATOMIC_DIRTIED
To: Chao Yu <chao@kernel.org>
Cc: Zhiguo Niu <niuzhiguo84@gmail.com>, daehojeong@google.com, ke.wang@unisoc.com, 
	linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org, Hao_hao.Wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 5:12=E2=80=AFAM Chao Yu via Linux-f2fs-devel
<linux-f2fs-devel@lists.sourceforge.net> wrote:
>
> On 3/26/25 18:51, Zhiguo Niu wrote:
> > Chao Yu <chao@kernel.org> =E4=BA=8E2025=E5=B9=B43=E6=9C=8826=E6=97=A5=
=E5=91=A8=E4=B8=89 17:26=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On 3/26/25 16:46, Zhiguo Niu wrote:
> >>> Commit fccaa81de87e ("f2fs: prevent atomic file from being dirtied be=
fore commit")
> >>> adds the processing of FI_ATOMIC_DIRTIED in the following two positio=
ns,
> >>> [1]
> >>> f2fs_commit_atomic_write
> >>>  - __f2fs_commit_atomic_write
> >>>   - sbi->committed_atomic_block +=3D fi->atomic_write_cnt;
> >>>   - set_inode_flag(inode, FI_ATOMIC_COMMITTED);
> >>>   - if (is_inode_flag_set(inode, FI_ATOMIC_DIRTIED)) {
> >>>   -    clear_inode_flag(inode, FI_ATOMIC_DIRTIED);
> >>>   -    f2fs_mark_inode_dirty_sync(inode, true);
> >>>   - }
> >>> [2]
> >>> f2fs_abort_atomic_write
> >>>   - if (is_inode_flag_set(inode, FI_ATOMIC_DIRTIED)) {
> >>>   -    clear_inode_flag(inode, FI_ATOMIC_DIRTIED);
> >>>   -    f2fs_mark_inode_dirty_sync(inode, true);
> >>>   - }
> >>>
> >>> but [1] seems to be redundant:
> >>> The atomic file flag FI_ATOMIC_FILE is still set here, so f2fs_mark_i=
node_dirty_sync
> >>> still does not set the dirty state to vfs. If FI_ATOMIC_DIRTIED was o=
riginally set
> >>> when atomic file is committing, then FI_ATOMIC_DIRTIED is just cleare=
d here, and
> >>> then do the repeating action of setting FI_ATOMIC_DIRTIED?
> >>> So is it enough to do this only in [2]?
> >>
> >> Hi Zhiguo,
> >>
> >> I checked the code again, finally, I got this, could you please take
> >> a look?
> >>
> >> Ping Daeho as well.
> >>
> >> Subject: [PATCH] f2fs: fix to set atomic write status more clear
> >>
> >> 1. After we start atomic write in a database file, before committing
> >> all data, we'd better not set inode w/ vfs dirty status to avoid
> >> redundant updates, instead, we only set inode w/ atomic dirty status.
> >>
> >> 2. After we commit all data, before committing metadata, we need to
> >> clear atomic dirty status, and set vfs dirty status to allow vfs flush
> >> dirty inode.
> >>
> > Hi Chao,
> > these looks more clear.
> >> Signed-off-by: Chao Yu <chao@kernel.org>
> >> ---
> >>  fs/f2fs/inode.c   |  4 +++-
> >>  fs/f2fs/segment.c | 10 ++++++----
> >>  fs/f2fs/super.c   |  4 +++-
> >>  3 files changed, 12 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> >> index 5c8634eaef7b..f5991e8751b9 100644
> >> --- a/fs/f2fs/inode.c
> >> +++ b/fs/f2fs/inode.c
> >> @@ -34,7 +34,9 @@ void f2fs_mark_inode_dirty_sync(struct inode *inode,=
 bool sync)
> >>         if (f2fs_inode_dirtied(inode, sync))
> >>                 return;
> >>
> >> -       if (f2fs_is_atomic_file(inode))
> >> +       /* only atomic file w/ FI_ATOMIC_COMMITTED can be set vfs dirt=
y */
> >> +       if (f2fs_is_atomic_file(inode) &&
> >> +                       !is_inode_flag_set(inode, FI_ATOMIC_COMMITTED)=
)
> >>                 return;
> >>
> >>         mark_inode_dirty_sync(inode);
> >> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >> index dc360b4b0569..28659a71891a 100644
> >> --- a/fs/f2fs/segment.c
> >> +++ b/fs/f2fs/segment.c
> >> @@ -376,10 +376,12 @@ static int __f2fs_commit_atomic_write(struct ino=
de *inode)
> >>         } else {
> >>                 sbi->committed_atomic_block +=3D fi->atomic_write_cnt;
> >>                 set_inode_flag(inode, FI_ATOMIC_COMMITTED);
> >> -               if (is_inode_flag_set(inode, FI_ATOMIC_DIRTIED)) {
> >> -                       clear_inode_flag(inode, FI_ATOMIC_DIRTIED);
> >> -                       f2fs_mark_inode_dirty_sync(inode, true);
> >> -               }
> >> +
> >> +               f2fs_bug_on(sbi, !is_inode_flag_set(inode, FI_ATOMIC_D=
IRTIED));
> > but FI_ATOMIC_DIRTIED may  not be set when atomic file is committing?
> > thanks!
>
> inc_valid_block_count() will set FI_ATOMIC_DIRTIED for inode at least?
>
> - __f2fs_commit_atomic_write
>  - __replace_atomic_write_block
>   - inc_valid_block_count
>    - f2fs_i_blocks_write
>     - f2fs_mark_inode_dirty_sync

Maybe, no write scenario? open -> atomic_write_start -> no write -> commit?

>
> Thanks,
>
> >> +
> >> +               /* clear atomic dirty status and set vfs dirty status =
*/
> >> +               clear_inode_flag(inode, FI_ATOMIC_DIRTIED);
> >> +               f2fs_mark_inode_dirty_sync(inode, true);
> >>         }
> >>
> >>         __complete_revoke_list(inode, &revoke_list, ret ? true : false=
);
> >> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> >> index 9a42a1323f42..a5cc9f6ee16a 100644
> >> --- a/fs/f2fs/super.c
> >> +++ b/fs/f2fs/super.c
> >> @@ -1532,7 +1532,9 @@ int f2fs_inode_dirtied(struct inode *inode, bool=
 sync)
> >>         }
> >>         spin_unlock(&sbi->inode_lock[DIRTY_META]);
> >>
> >> -       if (!ret && f2fs_is_atomic_file(inode))
> >> +       /* if atomic write is not committed, set inode w/ atomic dirty=
 */
> >> +       if (!ret && f2fs_is_atomic_file(inode) &&
> >> +                       !is_inode_flag_set(inode, FI_ATOMIC_COMMITTED)=
)
> >>                 set_inode_flag(inode, FI_ATOMIC_DIRTIED);
> >>
> >>         return ret;
> >> --
> >> 2.48.1
> >>
> >>
> >>>
> >>> Cc: Daeho Jeong <daehojeong@google.com>
> >>> Fixes: fccaa81de87e ("f2fs: prevent atomic file from being dirtied be=
fore commit")
> >>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> >>> ---
> >>>  fs/f2fs/segment.c | 4 ----
> >>>  1 file changed, 4 deletions(-)
> >>>
> >>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >>> index 396ef71..d4ea3af 100644
> >>> --- a/fs/f2fs/segment.c
> >>> +++ b/fs/f2fs/segment.c
> >>> @@ -376,10 +376,6 @@ static int __f2fs_commit_atomic_write(struct ino=
de *inode)
> >>>       } else {
> >>>               sbi->committed_atomic_block +=3D fi->atomic_write_cnt;
> >>>               set_inode_flag(inode, FI_ATOMIC_COMMITTED);
> >>> -             if (is_inode_flag_set(inode, FI_ATOMIC_DIRTIED)) {
> >>> -                     clear_inode_flag(inode, FI_ATOMIC_DIRTIED);
> >>> -                     f2fs_mark_inode_dirty_sync(inode, true);
> >>> -             }
> >>>       }
> >>>
> >>>       __complete_revoke_list(inode, &revoke_list, ret ? true : false)=
;
> >>
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

