Return-Path: <linux-kernel+bounces-353833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D32DB993362
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B3FC1F246B6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCDB1DB94F;
	Mon,  7 Oct 2024 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="J1sbWIIY"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0971DB342
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728318959; cv=none; b=V5zTbNQALli5VS3exrHZ4UGANIt80DmxLOcz0A1qh7zZMVjvuMfezZMY1YFdWnUROCpppv6hJ8GfEGTlC0pQxzoB04bM4x2iJ7vWKZ9O6rL+HGKpNGMlnchybntCdBMP3EDJbTQCIXJioKig7TopG26kjUvC/rqKVj9Cn3YGvfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728318959; c=relaxed/simple;
	bh=XWRRmYhbIsGnPQa0UxnUE2+vH7hB5dKVgAhDvK4tq/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hl3XO3/0/2953bQBVkThpEZOosO07jaBu0acNgPRpTwyCJ+lwTeNEooawhV+3bQKzkjtStd2WnQOHROe28UwtW9LL3JvfpoquqU8cqmZDQ82t46xhQTbv5tQzMOYS0hXYuZkRojKBlXj9VTwdFK2tm3RkoQYhf8ukyG2/R/KBbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=J1sbWIIY; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e25ccdffcc5so3978542276.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 09:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728318957; x=1728923757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGLVVCKHdNtO/ioaopKZCdho+ecoPCau6mCNU2xBYcs=;
        b=J1sbWIIYrj5CKMu/nTkPtGa+lM72NkEqOe6oMtpLZqp9tXATmacb2Cqr7jsRLj1faw
         hyb8hpRwKjgylgCLDi3VH1wjJz4+lyOToEoeMsbyjgxro5St0r5JhduR1asM27bHGxPU
         NAImOQh23TkQnlooaP2LjqzbHRIuc1JUoGVhr0s5diDikCU6IPBX42mJc1NrDmN6qq/h
         lfH2yRHastJpLSf6mWpUvqHCrzYYKps0KMv3j1QlKnYyMD8Lt65oADbGQkSXOiZmqEVY
         sUExpsAPb0xytj2NPo8gXlkm79PobnJDSMsug2ph7YP4MzpYRRTHMonqrJKyvB3haJ2P
         gnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728318957; x=1728923757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FGLVVCKHdNtO/ioaopKZCdho+ecoPCau6mCNU2xBYcs=;
        b=N38FjwWMmKDIXutK5Q+R1KBkylIAqVt5OvwEQ5Qcp/96o8hxenSgzGOyo6TrMHwYyA
         F8bzpVvgxidnS5SMx5ZpwO0jJzA4IHFDGIGjCv/86sdJby6nFUWOVQQutBbkws9vC1zk
         LQTHC4HQAj0273THaoalZoY0/THwK5l2vMcWxjs+j9otdyQStF7IzAeHRii9rna0V9dq
         e3MgsxKgHLO4qB7ZMUKm4L1dgu58dFqAJxWxGFVYlbi4bhbPrgi4WCsEdYyFKuKz3+0X
         /wHxlrnBtJlf7pv60g1XcPKAxo9ZRlbIeMMpVKzVOBVlhyMgSltCLyRl/GtyjkwfOHQg
         dzIg==
X-Forwarded-Encrypted: i=1; AJvYcCXJ8eolzSSkk1kbWCY5WKJSyN+Ni/RSBUhEuk2kml7hoMHOZTLfyeGC3Z0raUC/85FfGkB9MCaV8zlTGRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSh+NwtxnNGXCZpL71/Quk8aMoe6ysbfH4Tg7MD/ghTJvz0T1f
	mPQrxoGmt0nNolLrIFtsPTVV+xhXda7v+F1yItjU8xJLjLnH0QnHDrOqJ1rDzPIs1mYrmPVHJX6
	k1gbPC5bb35vMUbxlYwzaOJh/M4roJagC8NAU
X-Google-Smtp-Source: AGHT+IHMnCKj/L8qumQO35MXRgmOOBpLRXITDLkE2JHuYnlF1uX8MtmRoQF/PE4lBXFoP3VKXpQqHk5de4DKSnvSRQU=
X-Received: by 2002:a05:6902:2301:b0:e1a:9379:5aac with SMTP id
 3f1490d57ef6-e28937e4569mr9008649276.30.1728318957146; Mon, 07 Oct 2024
 09:35:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66f7b10e.050a0220.46d20.0036.GAE@google.com> <CAHQche-Gsy4=UT6+znKyPRDEHQm9y-MQ+zacoqfywKaz7VA2kg@mail.gmail.com>
 <CAHC9VhSHSD5QF8w2+n9f1DAEfQAwW5eA0skSuap2jdMWrLfGWQ@mail.gmail.com> <05e893036fa8753e0177db99dd48eb9d2e33476a.camel@huaweicloud.com>
In-Reply-To: <05e893036fa8753e0177db99dd48eb9d2e33476a.camel@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 7 Oct 2024 12:35:46 -0400
Message-ID: <CAHC9VhSEMSwzxjXUHLCWXoGj3ds8pQJ-nH6WQuRDzBkx6Svotw@mail.gmail.com>
Subject: Re: [syzbot] [integrity?] [lsm?] possible deadlock in
 process_measurement (4)
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Shu Han <ebpqwerty472123@gmail.com>, 
	syzbot <syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, hughd@google.com, jmorris@namei.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	roberto.sassu@huawei.com, serge@hallyn.com, stephen.smalley.work@gmail.com, 
	syzkaller-bugs@googlegroups.com, zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 11:31=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Wed, 2024-10-02 at 23:09 -0400, Paul Moore wrote:
> > On Sat, Sep 28, 2024 at 2:08=E2=80=AFPM Shu Han <ebpqwerty472123@gmail.=
com> wrote:
> > >
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > > WARNING: possible circular locking dependency detected
> > > > 6.11.0-syzkaller-10045-g97d8894b6f4c #0 Not tainted
> > > > ------------------------------------------------------
> > > > syz-executor369/5231 is trying to acquire lock:
> > > > ffff888072852370 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at: ino=
de_lock include/linux/fs.h:815 [inline]
> > > > ffff888072852370 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at: pro=
cess_measurement+0x439/0x1fb0 security/integrity/ima/ima_main.c:250
> > > >
> > > > but task is already holding lock:
> > > > ffff88807ac9a798 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock_=
killable include/linux/mmap_lock.h:122 [inline]
> > > > ffff88807ac9a798 (&mm->mmap_lock){++++}-{3:3}, at: __do_sys_remap_f=
ile_pages mm/mmap.c:1649 [inline]
> > > > ffff88807ac9a798 (&mm->mmap_lock){++++}-{3:3}, at: __se_sys_remap_f=
ile_pages+0x22d/0xa50 mm/mmap.c:1624
> > > >
> > > > which lock already depends on the new lock.
> > >
> > > This issue (if not a false positive?) is due to the possible `prot`
> > > change caused by the processing logic for READ_IMPLIES_EXEC in do_mma=
p(),
> > > so the remap_file_pages() must perform LSM check before calling do_mm=
ap(),
> > > this is what the previous commit want to do.
> >
> > My apologies for the delay on this, I was traveling for a bit and
> > missed this issue while away.
> >
> > Looking quickly at the report, I don't believe this is a false positive=
.
> >
> > > The LSM check is required to know what the `prot` is, but `prot` must=
 be
> > > obtained after holding the `mmap_write_lock`.
> > >
> > > If the `mmap_write_lock` is released after getting the `prot` and bef=
ore
> > > the LSM call in remap_file_pages(), it may cause TOCTOU.
> >
> > Looking at the IMA code, specifically the process_measurement()
> > function which is called from the security_mmap_file() LSM hook, I'm
> > not sure why there is the inode_lock() protected region.  Mimi?
> > Roberto?  My best guess is that locking the inode may have been
> > necessary before we moved the IMA inode state into the inode's LSM
> > security blob, but I'm not certain.
> >
> > Mimi and Roberto, can we safely remove the inode locking in
> > process_measurement()?
>
> I discussed a bit with Mimi. Her concern was the duplicate iint
> structure creation during concurrent file accesses. Now that inode
> integrity metadata have been moved to the inode security blob, we can
> take the iint->mutex out of the ima_iint_cache structure, and store it
> directly in the security blob. In this way, we can remove the inode
> lock.
>
> Will write a patch and see if it passes our tests.

That's great, thanks Roberto.  Assuming all goes well we'll want to
backport this everywhere we merged the remap_file_pages() patch.

--=20
paul-moore.com

