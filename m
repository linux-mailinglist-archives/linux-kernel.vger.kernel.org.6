Return-Path: <linux-kernel+bounces-315350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2339C96C165
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5F1E1F27A94
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AFF1DC19C;
	Wed,  4 Sep 2024 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqiTUrEp"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C411739FFE
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 14:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461774; cv=none; b=MH0psMaVoYvxC6Ivp5OCARc3l1qO2oa2l9d7av6i9N89BXfyY/2eP2UAoCEeOIEHs5A61mEaIeV9TvFyOBm1gjPoBRJ44shmfPugm0Jlgpzw0BcCfbj7qr2IKybem1H2sCCgmiCkOFYyM5BH2QCcgzS6ZhBrSU/kuKPyO5e3ETU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461774; c=relaxed/simple;
	bh=VF2mAOA5BpDUJRqU4MKDJ+m6OCOG4ytDxTkzWMu+KIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GmTmhc5Blpi+hatmg/Fwr6ZYDup9/By9rY0QZHeVqoN8Ks/hK6nY23LxV8WpS2zADWReO8n55VvoW9fJnLuOE/nunMoMMTS4iN0mr8NFCiEMS1b1L8Z3e1P2T8n3+8NqRDSyNJUeYyS9hWgLkN7QhAnGMCMcVlDk/jmSkuj2eWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqiTUrEp; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-846c0a741cbso1316476241.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 07:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725461771; x=1726066571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mv1qCt8F474vafEhA0DGJJgZHiK7TpJKV1L+IiHKQb0=;
        b=lqiTUrEp9pqzLusmsUuUbKPHuT/6l63WnGlHkYVPq9YQd/T9wfm/0Weau8jtU741+E
         QslxdcbQ2i3fdEUcQo4TGWVGwg1mYgIF7SmyoVSXXBKGdTmg35lVs7llWpQQAIeubJx4
         58VgtKKzZWqV4J95PIbL+QbshXt1Jf270mT2sTbcs5yXKBiQ4dYvxHiX2L81Sl4LHRin
         pvB79smH5KNkSE9WC5rLCpXca302GUVzTNFbeXv9e+vHpd6OzxptXAcn+ZxEAi5UwXYV
         c5asQb3UtHsbDydhNYfuvvuf6Ak0xuOhHfxVarwuqvbJOPPh7oA3gug1CH/4wcE6bG8T
         fRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725461772; x=1726066572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mv1qCt8F474vafEhA0DGJJgZHiK7TpJKV1L+IiHKQb0=;
        b=gbh1zKjbs2UPtYrFK1yIfd1lfsLWiPE3rPdMkBIEeuteUejCA4NoDwcrrQZII2d2ZG
         oF1YuR4Qi4ox5jD1dtgHYKzvHeJKHVaOk7mJNp14Lh15Q3oIs/IrSBCUngQi0W1oOaKR
         w0UmhFH5/WQrLZdw8rhFu6FPDDhbf9yjSlbckreWAgYLf8OFJijBZTn9laG8Z0kxp6iQ
         hdJDIcvRmUZ9ztVneE51CIpB4Ag7JJ6K5nZCQJe8OsH0BKxaUa2h3T4Rs5jTITwBZqIo
         II8t1xCQcAed0LXJXMVY2QbtmU1u6pSTZM0+7f9J+g3n9XHe3Xg15Gz4XX4gKJHsxQv8
         SETg==
X-Gm-Message-State: AOJu0Yy5tXQm+OKk+p7IWSVzvI3pqX97Ms2Qeu2r10UjnJK7eDbJg99F
	H/hQIkzGYeDjWUrmbGGFglNzyHQdnjBYoalCnNr9leLwSC2Kpf9L9INel10Pu5AJnW20XvFdvvn
	gHY0byuwC0x12YO/CHg3yQw5Ch033KIok
X-Google-Smtp-Source: AGHT+IGrtjk+3mFhmj//ttltf2z4auKM9vgMxHZF/o7qDRBGmpDpvLudN+B5vKtAPNnc7fxZB1w5NFa4fwwp/upJ3mA=
X-Received: by 2002:a05:6122:2902:b0:500:daf1:4b05 with SMTP id
 71dfb90a1353d-500daf16bc1mr6270711e0c.1.1725461771469; Wed, 04 Sep 2024
 07:56:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826202352.2150294-1-daeho43@gmail.com> <45a8a9f3-27b8-433e-a0ac-e457f4cdf1eb@kernel.org>
 <CACOAw_xMipooJy3GrZTc2CSpMoSs9FsErdxjqMWXVQ6iDiEZ0Q@mail.gmail.com>
 <d4f218ad-7a01-4b5b-a438-c0e4e14bbc96@kernel.org> <CACOAw_zvNyD3cmMpJsidEMyrtnZYU4kR4BmE_cygroPyYoiGvA@mail.gmail.com>
 <5c7b34d8-6efa-4716-ab89-a0b7b7583cb2@kernel.org>
In-Reply-To: <5c7b34d8-6efa-4716-ab89-a0b7b7583cb2@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Wed, 4 Sep 2024 07:56:00 -0700
Message-ID: <CACOAw_w3Tn6HL9hZXFgpjpgu9ySvE_0FbTWMMBuZKgRFBYXXLA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: prevent atomic file from being dirtied
 before commit
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	kernel-team@android.com, Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 8:35=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/9/4 10:52, Daeho Jeong wrote:
> > On Tue, Sep 3, 2024 at 7:26=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
> >>
> >> On 2024/9/4 1:07, Daeho Jeong wrote:
> >>> On Mon, Sep 2, 2024 at 3:08=E2=80=AFAM Chao Yu <chao@kernel.org> wrot=
e:
> >>>>
> >>>> On 2024/8/27 4:23, Daeho Jeong wrote:
> >>>>> From: Daeho Jeong <daehojeong@google.com>
> >>>>>
> >>>>> Keep atomic file clean while updating and make it dirtied during co=
mmit
> >>>>> in order to avoid unnecessary and excessive inode updates in the pr=
evious
> >>>>> fix.
> >>>>>
> >>>>> Fixes: 4bf78322346f ("f2fs: mark inode dirty for FI_ATOMIC_COMMITTE=
D flag")
> >>>>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> >>>>> ---
> >>>>>     fs/f2fs/f2fs.h    |  3 +--
> >>>>>     fs/f2fs/inode.c   | 10 ++++++----
> >>>>>     fs/f2fs/segment.c | 10 ++++++++--
> >>>>>     3 files changed, 15 insertions(+), 8 deletions(-)
> >>>>>
> >>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >>>>> index 465b2fd50c70..5a7f6fa8b585 100644
> >>>>> --- a/fs/f2fs/f2fs.h
> >>>>> +++ b/fs/f2fs/f2fs.h
> >>>>> @@ -801,7 +801,7 @@ enum {
> >>>>>         FI_COMPRESS_RELEASED,   /* compressed blocks were released =
*/
> >>>>>         FI_ALIGNED_WRITE,       /* enable aligned write */
> >>>>>         FI_COW_FILE,            /* indicate COW file */
> >>>>> -     FI_ATOMIC_COMMITTED,    /* indicate atomic commit completed e=
xcept disk sync */
> >>>>> +     FI_ATOMIC_DIRTIED,      /* indicate atomic file is dirtied */
> >>>>>         FI_ATOMIC_REPLACE,      /* indicate atomic replace */
> >>>>>         FI_OPENED_FILE,         /* indicate file has been opened */
> >>>>>         FI_MAX,                 /* max flag, never be used */
> >>>>> @@ -3042,7 +3042,6 @@ static inline void __mark_inode_dirty_flag(st=
ruct inode *inode,
> >>>>>         case FI_INLINE_DOTS:
> >>>>>         case FI_PIN_FILE:
> >>>>>         case FI_COMPRESS_RELEASED:
> >>>>> -     case FI_ATOMIC_COMMITTED:
> >>>>>                 f2fs_mark_inode_dirty_sync(inode, true);
> >>>>>         }
> >>>>>     }
> >>>>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> >>>>> index 1eb250c6b392..5dd3e55d2be2 100644
> >>>>> --- a/fs/f2fs/inode.c
> >>>>> +++ b/fs/f2fs/inode.c
> >>>>> @@ -35,6 +35,11 @@ void f2fs_mark_inode_dirty_sync(struct inode *in=
ode, bool sync)
> >>>>>         if (f2fs_inode_dirtied(inode, sync))
> >>>>
> >>>> It will return directly here if inode was dirtied, so it may missed =
to set
> >>>> FI_ATOMIC_DIRTIED flag?
> >>>
> >>> Is it possible for it to be already dirty, since we already made it
> >>> clean with f2fs_write_inode() when we started the atomic write?
> >>
> >> Some ioctl interfaces may race w/ atomic write? e.g. set_pin_file won'=
t
> >> check atomic_file status, and may dirty inode after we started atomic
> >> write, so we'd better detect such race condition and break ioctl to
> >> avoid ruin atomic write? and maybe we can add f2fs_bug_on() in
> >> f2fs_mark_inode_dirty_sync() to detect any other missing cases?
> >>
> >
> > How about exchanging the positions of f2fs_write_inode() and
> > set_inode_flag() in f2fs_ioc_start_atomic_write()?
> >
> > ...
> >          f2fs_write_inode(inode, NULL);
> >
> >          stat_inc_atomic_inode(inode);
> >
> >          set_inode_flag(inode, FI_ATOMIC_FILE);
> > ...
>
> Oh, I'm not sure I've got your point, after exchanging we still may suffe=
r
> below race condition, right?
>
> - f2fs_ioc_start_atomic_write
>   - set_inode_flag(inode, FI_ATOMIC_FILE)
>   - f2fs_write_inode(inode, NULL)
>                                         - f2fs_ioc_set_pin_file
>                                          - set_inode_flag(inode, FI_PIN_F=
ILE)
>                                           - __mark_inode_dirty_flag()
                                                 =3D> This attempt will
be blocked by the below condition.

+       if (f2fs_is_atomic_file(inode)) {
+               set_inode_flag(inode, FI_ATOMIC_DIRTIED);
+               return;
+       }

Plz, refer to the above comment.

> - f2fs_ioc_commit_atomic_write
>
> So that I proposed a fix for this:
> https://lore.kernel.org/linux-f2fs-devel/20240904032047.1264706-1-chao@ke=
rnel.org
>
> Thanks,
>
> >
> >> Thanks,
> >>
> >>>
> >>>>
> >>>> Thanks,
> >>>>
> >>>>>                 return;
> >>>>>
> >>>>> +     if (f2fs_is_atomic_file(inode)) {
> >>>>> +             set_inode_flag(inode, FI_ATOMIC_DIRTIED);
> >>>>> +             return;
> >>>>> +     }
> >>>>> +
> >>>>>         mark_inode_dirty_sync(inode);
> >>>>>     }
> >>>>>
> >>>>> @@ -653,10 +658,7 @@ void f2fs_update_inode(struct inode *inode, st=
ruct page *node_page)
> >>>>>         ri->i_gid =3D cpu_to_le32(i_gid_read(inode));
> >>>>>         ri->i_links =3D cpu_to_le32(inode->i_nlink);
> >>>>>         ri->i_blocks =3D cpu_to_le64(SECTOR_TO_BLOCK(inode->i_block=
s) + 1);
> >>>>> -
> >>>>> -     if (!f2fs_is_atomic_file(inode) ||
> >>>>> -                     is_inode_flag_set(inode, FI_ATOMIC_COMMITTED)=
)
> >>>>> -             ri->i_size =3D cpu_to_le64(i_size_read(inode));
> >>>>> +     ri->i_size =3D cpu_to_le64(i_size_read(inode));
> >>>>>
> >>>>>         if (et) {
> >>>>>                 read_lock(&et->lock);
> >>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >>>>> index 78c3198a6308..2b5391b229a8 100644
> >>>>> --- a/fs/f2fs/segment.c
> >>>>> +++ b/fs/f2fs/segment.c
> >>>>> @@ -196,9 +196,12 @@ void f2fs_abort_atomic_write(struct inode *ino=
de, bool clean)
> >>>>>                 truncate_inode_pages_final(inode->i_mapping);
> >>>>>
> >>>>>         release_atomic_write_cnt(inode);
> >>>>> -     clear_inode_flag(inode, FI_ATOMIC_COMMITTED);
> >>>>>         clear_inode_flag(inode, FI_ATOMIC_REPLACE);
> >>>>>         clear_inode_flag(inode, FI_ATOMIC_FILE);
> >>>>> +     if (is_inode_flag_set(inode, FI_ATOMIC_DIRTIED)) {
> >>>>> +             clear_inode_flag(inode, FI_ATOMIC_DIRTIED);
> >>>>> +             f2fs_mark_inode_dirty_sync(inode, true);
> >>>>> +     }
> >>>>>         stat_dec_atomic_inode(inode);
> >>>>>
> >>>>>         F2FS_I(inode)->atomic_write_task =3D NULL;
> >>>>> @@ -365,7 +368,10 @@ static int __f2fs_commit_atomic_write(struct i=
node *inode)
> >>>>>                 sbi->revoked_atomic_block +=3D fi->atomic_write_cnt=
;
> >>>>>         } else {
> >>>>>                 sbi->committed_atomic_block +=3D fi->atomic_write_c=
nt;
> >>>>> -             set_inode_flag(inode, FI_ATOMIC_COMMITTED);
> >>>>> +             if (is_inode_flag_set(inode, FI_ATOMIC_DIRTIED)) {
> >>>>> +                     clear_inode_flag(inode, FI_ATOMIC_DIRTIED);
> >>>>> +                     f2fs_mark_inode_dirty_sync(inode, true);
> >>>>> +             }
> >>>>>         }
> >>>>>
> >>>>>         __complete_revoke_list(inode, &revoke_list, ret ? true : fa=
lse);
> >>>>
> >>
>

