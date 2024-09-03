Return-Path: <linux-kernel+bounces-313402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E72796A500
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 19:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA6C3B255F5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C68D18BC3A;
	Tue,  3 Sep 2024 17:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWBMDbfP"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0461E492
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725383236; cv=none; b=dmM3nfXynquB4I45XbNp1X/ezki8lgzMf8wn7J92a3abKudn/ylpGG0ubu3iiZzgGw41zL0SY14B6GjRJs3R4VrvktcrDUfpd6RCbDEj0j8mbdFzKcjagSdWWCodjvZeWaEAw/Z/uFi8MWkFDO+wmBYmbxUkwhJR5v5toODcaZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725383236; c=relaxed/simple;
	bh=/At984T0ZsNtT4ZvNVPYrhUpAai8vqOKiO6SG5EWbK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XIjO3KbURatkaR3nGrnvQsqkc5xKgLhaWlPaQasgJOw6rUdxRQbirFmENXLg0tT48K7z0coUth19nwPzNL9GkruQcVFLdFyJxzGT4ZeGF4KMGsRRIdQGhQmoyBjzYnThjQHJJfuMi3wzGP63D0mqrWK+tQpyNzOf87oCVDvmt3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWBMDbfP; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3df0d9c0fbfso2957897b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 10:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725383234; x=1725988034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmRrBdk0YyoahIQU+4VJgU7fDaRp5Sd7lIsYquyayUs=;
        b=gWBMDbfPIujhJZEj+INrAxdIKcXd1ZX8ZVbS7y0Ix6lit3tdW/P8puI0lfcMEZCSu7
         XHkWGt8IL0nLbV6ZuzAloQB2KDAiX+hSaGg/CGd49YknFaQkfOfar9+B+yk6wHIaVt3k
         dR5sayk7YM6uMEffizu9AN5NT3PhKHydOxXdv23x9r6b3ryqLJnJkFeso+5yMcPQi1qp
         O0o3o4UXHooiWmUeX+NvlFxdf7PC27StjZKF7bz5l0b2Ozzkx+W8mvID1LiFgWhvVYwp
         r+fbxCfHezaTcJg709GcsxZI/PRUZVrF8e1qcvTLV8byYMURkML8xo5oeRoEcr8HMnyd
         kX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725383234; x=1725988034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZmRrBdk0YyoahIQU+4VJgU7fDaRp5Sd7lIsYquyayUs=;
        b=tLTfalU4oH8IT32WLFG3FdIk2WV1Hh2TWfmrf38dLi9oIM6TksbwMFgK1toigiPWmX
         Tu2CQbGp5sqBgzguVEP5UTWPGyP1yCCfzkQVg6H9x/oebPw4b7BrEaKOGhxnejkRzZC/
         VsO4UjABYoVcaDVcItvHLNOqXMtn2vq5VJMhH4b4RSEPrZyKj44BoJPMzCoJU/xosVD7
         /5/d2rTE4i5hfmmvUWL6gieDHdHwJ5rIUMUaVFiBhMUtP4Fykoa7o2o3v6asz+P8/WlM
         vlnOH370P/1h2k2cg/2ZFuQm1tUUk1RpbHzpGeiyyoJr7XFLrSWN5jR/Zdu/C8bWoWXW
         5KQQ==
X-Gm-Message-State: AOJu0YzYu2QEO4j6ufWT2GkQJrvsHgYdrUSbl0pSgXa67igzTXaPk8Xr
	ThFGBykoBImwitqhq5o3PsuheJ0mHKPMKYOzWNnT1m8+ZBwJbdqh/JFfA6coUIFj0XG5OU/ZKMd
	QxfSKc7ugIT9IaVvuso97Wu1NM8sNQg==
X-Google-Smtp-Source: AGHT+IGtQP6rYLYrnyeSqFZBp/F2I6FKttWBIQHRzg4h2pTNZPirp68TFtEoomZJkK4/ytsYL0bsc5Q1ACp0ApSgjhA=
X-Received: by 2002:a05:6808:190c:b0:3de:16f1:7653 with SMTP id
 5614622812f47-3df1d643e3dmr14213686b6e.25.1725383234001; Tue, 03 Sep 2024
 10:07:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826202352.2150294-1-daeho43@gmail.com> <45a8a9f3-27b8-433e-a0ac-e457f4cdf1eb@kernel.org>
In-Reply-To: <45a8a9f3-27b8-433e-a0ac-e457f4cdf1eb@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Tue, 3 Sep 2024 10:07:03 -0700
Message-ID: <CACOAw_xMipooJy3GrZTc2CSpMoSs9FsErdxjqMWXVQ6iDiEZ0Q@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: prevent atomic file from being dirtied
 before commit
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	kernel-team@android.com, Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 3:08=E2=80=AFAM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/8/27 4:23, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > Keep atomic file clean while updating and make it dirtied during commit
> > in order to avoid unnecessary and excessive inode updates in the previo=
us
> > fix.
> >
> > Fixes: 4bf78322346f ("f2fs: mark inode dirty for FI_ATOMIC_COMMITTED fl=
ag")
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> >   fs/f2fs/f2fs.h    |  3 +--
> >   fs/f2fs/inode.c   | 10 ++++++----
> >   fs/f2fs/segment.c | 10 ++++++++--
> >   3 files changed, 15 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 465b2fd50c70..5a7f6fa8b585 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -801,7 +801,7 @@ enum {
> >       FI_COMPRESS_RELEASED,   /* compressed blocks were released */
> >       FI_ALIGNED_WRITE,       /* enable aligned write */
> >       FI_COW_FILE,            /* indicate COW file */
> > -     FI_ATOMIC_COMMITTED,    /* indicate atomic commit completed excep=
t disk sync */
> > +     FI_ATOMIC_DIRTIED,      /* indicate atomic file is dirtied */
> >       FI_ATOMIC_REPLACE,      /* indicate atomic replace */
> >       FI_OPENED_FILE,         /* indicate file has been opened */
> >       FI_MAX,                 /* max flag, never be used */
> > @@ -3042,7 +3042,6 @@ static inline void __mark_inode_dirty_flag(struct=
 inode *inode,
> >       case FI_INLINE_DOTS:
> >       case FI_PIN_FILE:
> >       case FI_COMPRESS_RELEASED:
> > -     case FI_ATOMIC_COMMITTED:
> >               f2fs_mark_inode_dirty_sync(inode, true);
> >       }
> >   }
> > diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> > index 1eb250c6b392..5dd3e55d2be2 100644
> > --- a/fs/f2fs/inode.c
> > +++ b/fs/f2fs/inode.c
> > @@ -35,6 +35,11 @@ void f2fs_mark_inode_dirty_sync(struct inode *inode,=
 bool sync)
> >       if (f2fs_inode_dirtied(inode, sync))
>
> It will return directly here if inode was dirtied, so it may missed to se=
t
> FI_ATOMIC_DIRTIED flag?

Is it possible for it to be already dirty, since we already made it
clean with f2fs_write_inode() when we started the atomic write?

>
> Thanks,
>
> >               return;
> >
> > +     if (f2fs_is_atomic_file(inode)) {
> > +             set_inode_flag(inode, FI_ATOMIC_DIRTIED);
> > +             return;
> > +     }
> > +
> >       mark_inode_dirty_sync(inode);
> >   }
> >
> > @@ -653,10 +658,7 @@ void f2fs_update_inode(struct inode *inode, struct=
 page *node_page)
> >       ri->i_gid =3D cpu_to_le32(i_gid_read(inode));
> >       ri->i_links =3D cpu_to_le32(inode->i_nlink);
> >       ri->i_blocks =3D cpu_to_le64(SECTOR_TO_BLOCK(inode->i_blocks) + 1=
);
> > -
> > -     if (!f2fs_is_atomic_file(inode) ||
> > -                     is_inode_flag_set(inode, FI_ATOMIC_COMMITTED))
> > -             ri->i_size =3D cpu_to_le64(i_size_read(inode));
> > +     ri->i_size =3D cpu_to_le64(i_size_read(inode));
> >
> >       if (et) {
> >               read_lock(&et->lock);
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 78c3198a6308..2b5391b229a8 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -196,9 +196,12 @@ void f2fs_abort_atomic_write(struct inode *inode, =
bool clean)
> >               truncate_inode_pages_final(inode->i_mapping);
> >
> >       release_atomic_write_cnt(inode);
> > -     clear_inode_flag(inode, FI_ATOMIC_COMMITTED);
> >       clear_inode_flag(inode, FI_ATOMIC_REPLACE);
> >       clear_inode_flag(inode, FI_ATOMIC_FILE);
> > +     if (is_inode_flag_set(inode, FI_ATOMIC_DIRTIED)) {
> > +             clear_inode_flag(inode, FI_ATOMIC_DIRTIED);
> > +             f2fs_mark_inode_dirty_sync(inode, true);
> > +     }
> >       stat_dec_atomic_inode(inode);
> >
> >       F2FS_I(inode)->atomic_write_task =3D NULL;
> > @@ -365,7 +368,10 @@ static int __f2fs_commit_atomic_write(struct inode=
 *inode)
> >               sbi->revoked_atomic_block +=3D fi->atomic_write_cnt;
> >       } else {
> >               sbi->committed_atomic_block +=3D fi->atomic_write_cnt;
> > -             set_inode_flag(inode, FI_ATOMIC_COMMITTED);
> > +             if (is_inode_flag_set(inode, FI_ATOMIC_DIRTIED)) {
> > +                     clear_inode_flag(inode, FI_ATOMIC_DIRTIED);
> > +                     f2fs_mark_inode_dirty_sync(inode, true);
> > +             }
> >       }
> >
> >       __complete_revoke_list(inode, &revoke_list, ret ? true : false);
>

