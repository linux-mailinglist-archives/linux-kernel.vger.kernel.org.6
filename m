Return-Path: <linux-kernel+bounces-315356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 708C696C183
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3CF61F29AF6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD161DCB1B;
	Wed,  4 Sep 2024 14:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSSpMrtv"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C531DC04A
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461893; cv=none; b=CGROIZ58yo6yI9nmlU+ZTVWIkKPqhZmEiE07G4p7Wa4Z534WMkg+IClc49V75matgzYYupBYxDzHgMoZBWPX81BBphAyZBe9/hfDUca6epTmlMUA3JH+SmHFrSjXr5YJ3CkSL7+H3mSYgRK5taU0vjQAcABhezAGTX+rv8yolgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461893; c=relaxed/simple;
	bh=l4k4ngWmmPpa1X4RSqWv+A5Bf6GJ61E6+KygT1SynBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iEw7d6Ojzh/LfZkVW9Q8NrCrwFrx0RwoRw1Q/q4CKq5eQ0/nweOLvwPUCLDClaGeKnKf2KdfiuGhpLJ8vaL3GeurvJXawz8Aa7ONHIDtabKT8Q+mI5H5gtJv3GvXR9IyEIRNEdukAlGaUM4Q7M0FQJVd+sqWuoVzr6T3AeAY0SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSSpMrtv; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4fcf40c9ed3so2417654e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 07:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725461891; x=1726066691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zx9HpjsA8VHIH7+I20PJmXupzB9UpsivPvmE9XAiMCU=;
        b=DSSpMrtvoSNawoNsyI8RhEo1MWtbwjhEXthvijkD04JrL8oClM6ejRn7bDwfEr2YIP
         77s62FWfaCNpmNB7QpqQPnxw4B061GsT4c04U552rv/cjQ/b9AYuV3mTM4t5znUGCER/
         X/PyR+H/D4yPT98FGsp/zAfLn1W5eUx3Qog9i06rF+U83+kAdWr5ceyJmpU1xw2U1/6Q
         P7iqKZkKOfma7g5cx44r9/dX44VFAQeYTG/L8tEQzdJZlwAwAXVybJWLzkpLoIIoRnLi
         WiUUMb4eiKRuphoX8wo0/cOn8jBbLPapXCya0URodA7h2X8qijY1N3hNHHp+7gJBLY7S
         0rAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725461891; x=1726066691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zx9HpjsA8VHIH7+I20PJmXupzB9UpsivPvmE9XAiMCU=;
        b=pS4rFLPmW8yrr8cpf0ZYf1n6sDZbood/DTkChUsITGaLKK+hcqeb3ZE0VIggUHAfKx
         eysKbKNcxmmRfHRQ/9ANwLLecOdnrUd5qII/xnq95AxH0GzaOqeaTtmJNFtkkhkKq2ut
         0syDTbYjsX5m1oZEPHUMl2bTQ+UBuHaGb/1i5B2R3d7JdT4rEMalACFyxocd0cLd+MCa
         8WFeZA64r0Dj77TvRKfYYRNFRAyrGNJV+04zwRXh57C4DtlEJjY/0iE7U7aKOk4/ZDtY
         HMTIVzwipNA06wr0eCmGMuRR7286PBLTuv2dWQNahwl0zZz2jIlN2PIn/EW/a1ilQ9Xm
         3r2Q==
X-Gm-Message-State: AOJu0YxBp5wH/e793JhvM2qwcJGGLcAjrKwnC+HIVsqnf2whu2VQykbZ
	77v6bkXmIwIcU9o/GgJbW+WqGSIsD44Dzr5FodbzbFdWaWI567J6om94SB6hZnAs+nhs5qoAaP6
	q8jOKq290IIr6TZCuX28YkLYDyAg=
X-Google-Smtp-Source: AGHT+IHCY9cCLJpt6loXb9m3NULwyXyNIhEMZPz0XzEGdrOBnXyIuuOS6OgAjHv2cyLZHFBZ2FuPGHpdFhlTF4z1XSo=
X-Received: by 2002:a05:6122:181f:b0:500:daf0:8909 with SMTP id
 71dfb90a1353d-500daf08b1dmr6809960e0c.13.1725461890949; Wed, 04 Sep 2024
 07:58:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826202352.2150294-1-daeho43@gmail.com> <45a8a9f3-27b8-433e-a0ac-e457f4cdf1eb@kernel.org>
 <CACOAw_xMipooJy3GrZTc2CSpMoSs9FsErdxjqMWXVQ6iDiEZ0Q@mail.gmail.com>
 <d4f218ad-7a01-4b5b-a438-c0e4e14bbc96@kernel.org> <CACOAw_zvNyD3cmMpJsidEMyrtnZYU4kR4BmE_cygroPyYoiGvA@mail.gmail.com>
 <5c7b34d8-6efa-4716-ab89-a0b7b7583cb2@kernel.org> <CACOAw_w3Tn6HL9hZXFgpjpgu9ySvE_0FbTWMMBuZKgRFBYXXLA@mail.gmail.com>
In-Reply-To: <CACOAw_w3Tn6HL9hZXFgpjpgu9ySvE_0FbTWMMBuZKgRFBYXXLA@mail.gmail.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Wed, 4 Sep 2024 07:58:00 -0700
Message-ID: <CACOAw_w2A2KpK3F58rot-QLRgstGKmPi5e5+RXzFTm1pqpF9SQ@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: prevent atomic file from being dirtied
 before commit
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	kernel-team@android.com, Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 7:56=E2=80=AFAM Daeho Jeong <daeho43@gmail.com> wrot=
e:
>
> On Tue, Sep 3, 2024 at 8:35=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
> >
> > On 2024/9/4 10:52, Daeho Jeong wrote:
> > > On Tue, Sep 3, 2024 at 7:26=E2=80=AFPM Chao Yu <chao@kernel.org> wrot=
e:
> > >>
> > >> On 2024/9/4 1:07, Daeho Jeong wrote:
> > >>> On Mon, Sep 2, 2024 at 3:08=E2=80=AFAM Chao Yu <chao@kernel.org> wr=
ote:
> > >>>>
> > >>>> On 2024/8/27 4:23, Daeho Jeong wrote:
> > >>>>> From: Daeho Jeong <daehojeong@google.com>
> > >>>>>
> > >>>>> Keep atomic file clean while updating and make it dirtied during =
commit
> > >>>>> in order to avoid unnecessary and excessive inode updates in the =
previous
> > >>>>> fix.
> > >>>>>
> > >>>>> Fixes: 4bf78322346f ("f2fs: mark inode dirty for FI_ATOMIC_COMMIT=
TED flag")
> > >>>>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > >>>>> ---
> > >>>>>     fs/f2fs/f2fs.h    |  3 +--
> > >>>>>     fs/f2fs/inode.c   | 10 ++++++----
> > >>>>>     fs/f2fs/segment.c | 10 ++++++++--
> > >>>>>     3 files changed, 15 insertions(+), 8 deletions(-)
> > >>>>>
> > >>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > >>>>> index 465b2fd50c70..5a7f6fa8b585 100644
> > >>>>> --- a/fs/f2fs/f2fs.h
> > >>>>> +++ b/fs/f2fs/f2fs.h
> > >>>>> @@ -801,7 +801,7 @@ enum {
> > >>>>>         FI_COMPRESS_RELEASED,   /* compressed blocks were release=
d */
> > >>>>>         FI_ALIGNED_WRITE,       /* enable aligned write */
> > >>>>>         FI_COW_FILE,            /* indicate COW file */
> > >>>>> -     FI_ATOMIC_COMMITTED,    /* indicate atomic commit completed=
 except disk sync */
> > >>>>> +     FI_ATOMIC_DIRTIED,      /* indicate atomic file is dirtied =
*/
> > >>>>>         FI_ATOMIC_REPLACE,      /* indicate atomic replace */
> > >>>>>         FI_OPENED_FILE,         /* indicate file has been opened =
*/
> > >>>>>         FI_MAX,                 /* max flag, never be used */
> > >>>>> @@ -3042,7 +3042,6 @@ static inline void __mark_inode_dirty_flag(=
struct inode *inode,
> > >>>>>         case FI_INLINE_DOTS:
> > >>>>>         case FI_PIN_FILE:
> > >>>>>         case FI_COMPRESS_RELEASED:
> > >>>>> -     case FI_ATOMIC_COMMITTED:
> > >>>>>                 f2fs_mark_inode_dirty_sync(inode, true);
> > >>>>>         }
> > >>>>>     }
> > >>>>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> > >>>>> index 1eb250c6b392..5dd3e55d2be2 100644
> > >>>>> --- a/fs/f2fs/inode.c
> > >>>>> +++ b/fs/f2fs/inode.c
> > >>>>> @@ -35,6 +35,11 @@ void f2fs_mark_inode_dirty_sync(struct inode *=
inode, bool sync)
> > >>>>>         if (f2fs_inode_dirtied(inode, sync))
> > >>>>
> > >>>> It will return directly here if inode was dirtied, so it may misse=
d to set
> > >>>> FI_ATOMIC_DIRTIED flag?
> > >>>
> > >>> Is it possible for it to be already dirty, since we already made it
> > >>> clean with f2fs_write_inode() when we started the atomic write?
> > >>
> > >> Some ioctl interfaces may race w/ atomic write? e.g. set_pin_file wo=
n't
> > >> check atomic_file status, and may dirty inode after we started atomi=
c
> > >> write, so we'd better detect such race condition and break ioctl to
> > >> avoid ruin atomic write? and maybe we can add f2fs_bug_on() in
> > >> f2fs_mark_inode_dirty_sync() to detect any other missing cases?
> > >>
> > >
> > > How about exchanging the positions of f2fs_write_inode() and
> > > set_inode_flag() in f2fs_ioc_start_atomic_write()?
> > >
> > > ...
> > >          f2fs_write_inode(inode, NULL);
> > >
> > >          stat_inc_atomic_inode(inode);
> > >
> > >          set_inode_flag(inode, FI_ATOMIC_FILE);
> > > ...
> >
> > Oh, I'm not sure I've got your point, after exchanging we still may suf=
fer
> > below race condition, right?
> >
> > - f2fs_ioc_start_atomic_write
> >   - set_inode_flag(inode, FI_ATOMIC_FILE)
> >   - f2fs_write_inode(inode, NULL)
> >                                         - f2fs_ioc_set_pin_file
> >                                          - set_inode_flag(inode, FI_PIN=
_FILE)
> >                                           - __mark_inode_dirty_flag()
>                                                  =3D> This attempt will
> be blocked by the below condition.
>
> +       if (f2fs_is_atomic_file(inode)) {
> +               set_inode_flag(inode, FI_ATOMIC_DIRTIED);
> +               return;
> +       }
>
> Plz, refer to the above comment.

By the way, I need to change this patch a little bit to prevent a
direct inode dirtying case by VFS layer.
Plz, wait for the 2nd one.

>
> > - f2fs_ioc_commit_atomic_write
> >
> > So that I proposed a fix for this:
> > https://lore.kernel.org/linux-f2fs-devel/20240904032047.1264706-1-chao@=
kernel.org
> >
> > Thanks,
> >
> > >
> > >> Thanks,
> > >>
> > >>>
> > >>>>
> > >>>> Thanks,
> > >>>>
> > >>>>>                 return;
> > >>>>>
> > >>>>> +     if (f2fs_is_atomic_file(inode)) {
> > >>>>> +             set_inode_flag(inode, FI_ATOMIC_DIRTIED);
> > >>>>> +             return;
> > >>>>> +     }
> > >>>>> +
> > >>>>>         mark_inode_dirty_sync(inode);
> > >>>>>     }
> > >>>>>
> > >>>>> @@ -653,10 +658,7 @@ void f2fs_update_inode(struct inode *inode, =
struct page *node_page)
> > >>>>>         ri->i_gid =3D cpu_to_le32(i_gid_read(inode));
> > >>>>>         ri->i_links =3D cpu_to_le32(inode->i_nlink);
> > >>>>>         ri->i_blocks =3D cpu_to_le64(SECTOR_TO_BLOCK(inode->i_blo=
cks) + 1);
> > >>>>> -
> > >>>>> -     if (!f2fs_is_atomic_file(inode) ||
> > >>>>> -                     is_inode_flag_set(inode, FI_ATOMIC_COMMITTE=
D))
> > >>>>> -             ri->i_size =3D cpu_to_le64(i_size_read(inode));
> > >>>>> +     ri->i_size =3D cpu_to_le64(i_size_read(inode));
> > >>>>>
> > >>>>>         if (et) {
> > >>>>>                 read_lock(&et->lock);
> > >>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > >>>>> index 78c3198a6308..2b5391b229a8 100644
> > >>>>> --- a/fs/f2fs/segment.c
> > >>>>> +++ b/fs/f2fs/segment.c
> > >>>>> @@ -196,9 +196,12 @@ void f2fs_abort_atomic_write(struct inode *i=
node, bool clean)
> > >>>>>                 truncate_inode_pages_final(inode->i_mapping);
> > >>>>>
> > >>>>>         release_atomic_write_cnt(inode);
> > >>>>> -     clear_inode_flag(inode, FI_ATOMIC_COMMITTED);
> > >>>>>         clear_inode_flag(inode, FI_ATOMIC_REPLACE);
> > >>>>>         clear_inode_flag(inode, FI_ATOMIC_FILE);
> > >>>>> +     if (is_inode_flag_set(inode, FI_ATOMIC_DIRTIED)) {
> > >>>>> +             clear_inode_flag(inode, FI_ATOMIC_DIRTIED);
> > >>>>> +             f2fs_mark_inode_dirty_sync(inode, true);
> > >>>>> +     }
> > >>>>>         stat_dec_atomic_inode(inode);
> > >>>>>
> > >>>>>         F2FS_I(inode)->atomic_write_task =3D NULL;
> > >>>>> @@ -365,7 +368,10 @@ static int __f2fs_commit_atomic_write(struct=
 inode *inode)
> > >>>>>                 sbi->revoked_atomic_block +=3D fi->atomic_write_c=
nt;
> > >>>>>         } else {
> > >>>>>                 sbi->committed_atomic_block +=3D fi->atomic_write=
_cnt;
> > >>>>> -             set_inode_flag(inode, FI_ATOMIC_COMMITTED);
> > >>>>> +             if (is_inode_flag_set(inode, FI_ATOMIC_DIRTIED)) {
> > >>>>> +                     clear_inode_flag(inode, FI_ATOMIC_DIRTIED);
> > >>>>> +                     f2fs_mark_inode_dirty_sync(inode, true);
> > >>>>> +             }
> > >>>>>         }
> > >>>>>
> > >>>>>         __complete_revoke_list(inode, &revoke_list, ret ? true : =
false);
> > >>>>
> > >>
> >

