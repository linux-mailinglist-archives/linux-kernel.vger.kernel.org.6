Return-Path: <linux-kernel+bounces-298461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9C795C79B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7B621F265F9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D72142E9D;
	Fri, 23 Aug 2024 08:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NO+Y8rn6"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CF51428EA
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400655; cv=none; b=bqiM0y7fL59j+hBlWQ+W2+yXkRhpYVMOs53O2hbGuMUh5DZGTfXQ8mwvpGYJpw7XWhZhpD9PckgKivqhdupdOAfetsl4EBBxgMgkcmfKE3JEs3UsWKb+xPvnK6C91U9BUPI+NhOoZikVH2O6Nw06rk1BagIy0A7IP0MqtTjVHmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400655; c=relaxed/simple;
	bh=ETAthASDPH8WtSbCcbYRTCwQXknUlhBa7aRwsFMQAS8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oHXAFqnonxdIdHcONwfWt5yzh3X1cf7Iazitwk2B+kAwX/swhoJ/4zOz0KhT1sbf5L6S3uw9u49g/hcWSjpL8uWVh5CXEvSPLXs03MNlvN56Q4fVOBUTlj73s5Wpx57BpPXFFXITZGw2WWe7YHiGsXglWkoialFr916+o+w5vxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NO+Y8rn6; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71423273c62so1328594b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 01:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724400653; x=1725005453; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ETAthASDPH8WtSbCcbYRTCwQXknUlhBa7aRwsFMQAS8=;
        b=NO+Y8rn6bM2XsVqAKEFDEt1voNUzkNmZ1huAjFwNvz+KMJ9M5ywyzHLLiJC+PjXkpc
         MbBZYrXyquvt+bxeQeGD1SB9soccyNisMLpSwHShMRx42ar/PXLYLfjjHHNxbjsiutCf
         CBwZAjT4DgTQ2fe+l0suC2jOMMRC75OR2k176DfmpDXgy5/G+0YB7NwV+O67UCsqoGPA
         YQFyj0YsqMIPwuKzJVyNT8ZaSxRn38Ygqmo9WJF3vm1rBbb4Ffu6ENIHwCo8l+jIdm5N
         e+FBJXwIPaazd7o+UJcJtNgcXNNoVUfxrvDAYXm9SBY7FRubEXfsGscq548aDliaIRQu
         G9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724400653; x=1725005453;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ETAthASDPH8WtSbCcbYRTCwQXknUlhBa7aRwsFMQAS8=;
        b=wp+JvC6rDnIiM2cI77cuEaqXMmuYkrfyH1PDDMJNT1Kz2K5xSDJorvx/KZjWZiCJOL
         YuTmPPAQ2sGJG8xsRBnfIlaEi5EbXcvKne6WtthBW7ahZ+pos1dh8cHlS+FoLqS22PeL
         tctr5Un9Mm9EUtcq44Gij413VyJqWY5MlLcYQ/0+gWb4+XA7bxmOXXDZzwDPGVgUnOlu
         TTbVGJLOjcV7wD/jyR9JLs9CLUbRBCkIewhk3rTm7N/23LVx+uG4VHBwzr9KmfJ0KvMn
         /M7uHstCBUOXl2jB26AlmV3lmzZb/8lHY62xer9Nw0sph/cjiVrYDEVpID/+0mkUfo9X
         vRDw==
X-Forwarded-Encrypted: i=1; AJvYcCVhyEfbG5ZnglxGrzX6YlU7KiATQwP8Nqk9LJF81sRnHx0gfsJcdbQhuUdFja0jQhdt8ZsOruQMYNd6Rxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOiTDe7+/18wYMOj66hDEh5eSsJ1avcnFQLiCyz/w3QqKG/tMW
	ty4LkAqOrHBPeCOkmvlIHYTQ9OxyvaokWHWLyKaIrPqGvqFWpbtq
X-Google-Smtp-Source: AGHT+IHMHe0QUMSMm3o29/8qucakMVbwkzlxHiNbMsJhKnsjwuZwBdZwj61Hmx4oZi/bydxYMA3VRw==
X-Received: by 2002:a05:6a00:888:b0:70d:2ba1:2402 with SMTP id d2e1a72fcca58-71445f3cc63mr1508228b3a.29.1724400652429;
        Fri, 23 Aug 2024 01:10:52 -0700 (PDT)
Received: from [127.0.0.1] ([174.139.202.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434250f5asm2509485b3a.69.2024.08.23.01.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 01:10:51 -0700 (PDT)
Message-ID: <37703318b16023c0b6d7e5e2acac0412e22747b4.camel@gmail.com>
Subject: Re: [PATCH] ocfs2: fix null-ptr-deref when journal load failed.
From: Julian Sun <sunjunchao2870@gmail.com>
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: ocfs2-devel@lists.linux.dev, jlbec@evilplan.org, mark@fasheh.com, 
	syzbot+05b9b39d8bdfe1a0861f@syzkaller.appspotmail.com, 
	"linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Date: Fri, 23 Aug 2024 16:10:47 +0800
In-Reply-To: <ae1eb591-ba89-4290-8c17-4cc7816ce666@linux.alibaba.com>
References: <20240819131120.746077-1-sunjunchao2870@gmail.com>
	 <26da607a-530d-4dc1-9040-bf56b406b98f@linux.alibaba.com>
	 <CAHB1NaiJJmf838FwSGM8UZX6ebQn8L2hhFxNAcdmRDfBo1VUyg@mail.gmail.com>
	 <eb9f35a7-e3ab-47cf-a043-c03f11c21c97@linux.alibaba.com>
	 <e7acce1eb19af9798f0c64bdba5fe75688f37c2c.camel@gmail.com>
	 <ae1eb591-ba89-4290-8c17-4cc7816ce666@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-08-23 at 14:13 +0800, Joseph Qi wrote:
>=20
>=20
> On 8/23/24 10:22 AM, Julian Sun wrote:
> > On Fri, 2024-08-23 at 09:59 +0800, Joseph Qi wrote:
> > >=20
> > >=20
> > > On 8/20/24 11:19 PM, Julian Sun wrote:
> > > > Joseph Qi <joseph.qi@linux.alibaba.com> =E4=BA=8E2024=E5=B9=B48=E6=
=9C=8820=E6=97=A5=E5=91=A8=E4=BA=8C 21:03=E5=86=99=E9=81=93=EF=BC=9A
> > > > >=20
> > > > >=20
> > > > >=20
> > > > > On 8/19/24 9:11 PM, Julian Sun wrote:
> > > > > > During the mounting process, if the jbd2_journal_load()
> > > > > > call fails, it will internally invoke journal_reset()
> > > > > > ->journal_fail_superblock(), which sets journal-
> > > > > > >j_sb_buffer
> > > > >=20
> > > > >=20
> > > > > > This description is not right.
> > > > > > journal_reset() fails because of too short journal, then
> > > > > > lead
> > > > > > to
> > > > > > jbd2_journal_load() fails with NULL j_sb_buffer.
> > > > yeah. That's exactly what I described.
> > > > >=20
> > > > > > to NULL. Subsequently, ocfs2_journal_shutdown() calls
> > > > > > jbd2_journal_flush()->jbd2_cleanup_journal_tail()->
> > > > > > __jbd2_update_log_tail()->jbd2_journal_update_sb_log_tail()
> > > > > > ->lock_buffer(journal->j_sb_buffer), resulting in a
> > > > > > null-pointer dereference error.
> > > > > >=20
> > > > > > To resolve this issue, a new state OCFS2_JOURNAL_INITED
> > > > > > has been introduced to replace the previous functionality
> > > > > > of OCFS2_JOURNAL_LOADED, the original OCFS2_JOURNAL_LOADED
> > > > > > is only set when ocfs2_journal_load() is successful.
> > > > >=20
> > > > >=20
> > > > > > Or set OCFS2_JOURNAL_LOADED only after JBD2_LOADED?
> > > > I don't think this is correct. We first call
> > > > ocfs2_journal_init(),
> > > > which allocates some resources, before calling
> > > > jbd2_journal_load().
> > > > If
> > > > ocfs2_journal_init() succeeds but jbd2_journal_load() fails,
> > > > this
> > > > solution may lead to a resource leak.
> > > > If there is anything important I'm missing, please let me know,
> > > > thanks.
> > > >=20
> > >=20
> > > Okay, seems except iput(inode) and kfree(journal), we may have to
> > > do
> > > the
> > > following cleanup:
> > > 1) ocfs2_inode_unlock(journal->j_inode);
> > > 2) brelse(journal->j_bh);
> > > 3) OCFS2_I(inode)->ip_open_count--
> > > 4) jbd2_journal_destroy()
> > > ...
> > >=20
> > > So it seems that introducing a new state will be more clear.
> > >=20
> > > > > > The jbd2_journal_flush() function is allowed to be called
> > > > > > only when this flag is set. The logic here is that if the
> > > > > > journal has even not been successfully loaded, there is
> > > > > > no need to flush the journal.
> > > > > >=20
> > > > > > Link:
> > > > > > https://syzkaller.appspot.com/bug?extid=3D05b9b39d8bdfe1a0861f
> > > > > > Reported-by:
> > > > > > syzbot+05b9b39d8bdfe1a0861f@syzkaller.appspotmail.com
> > > > > > Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> > > > > > ---
> > > > > > =C2=A0fs/ocfs2/journal.c | 9 ++++++---
> > > > > > =C2=A0fs/ocfs2/journal.h | 1 +
> > > > > > =C2=A02 files changed, 7 insertions(+), 3 deletions(-)
> > > > > >=20
> > > > > > diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
> > > > > > index 530fba34f6d3..6f837296048f 100644
> > > > > > --- a/fs/ocfs2/journal.c
> > > > > > +++ b/fs/ocfs2/journal.c
> > > > > > @@ -968,7 +968,7 @@ int ocfs2_journal_init(struct
> > > > > > ocfs2_super
> > > > > > *osb, int *dirty)
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ocfs2_set_journal_params(osb);
> > > > > >=20
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0 journal->j_state =3D OCFS2_JOURNAL_LO=
ADED;
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 journal->j_state =3D OCFS2_JOURNAL_IN=
ITED;
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D 0;
> > > > > > =C2=A0done:
> > > > > > @@ -1039,6 +1039,7 @@ void ocfs2_journal_shutdown(struct
> > > > > > ocfs2_super *osb)
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int status =3D 0;
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct inode *inode =3D NULL;
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int num_running_trans =3D 0;
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 enum ocfs2_journal_state state;
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BUG_ON(!osb);
> > > > > >=20
> > > > > > @@ -1047,8 +1048,9 @@ void ocfs2_journal_shutdown(struct
> > > > > > ocfs2_super *osb)
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 goto done;
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inode =3D journal->j_inode;
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 state =3D journal->j_state;
> > > > > >=20
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0 if (journal->j_state !=3D OCFS2_JOURN=
AL_LOADED)
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (state !=3D OCFS2_JOURNAL_INITED)
> > >=20
> > > This is not right.
> > > What if journal has already been loaded?
> > Hi, Joseph
> >=20
> > Thanks for your review and comments.
> >=20
> > I'm not sure if I fully understand what you mean.=20
> > Because the functionality of OCFS2_JOURNAL_INITED is completely
> > equivalent to the original OCFS2_JOURNAL_LOADED, so do you mean
> > that
> > there might be an issue with the original OCFS2_JOURNAL_LOADED? If
> > so,
> > I will dig it into and try to fix.
> > But in any case, that should be a separate patch.
> >=20
> > If there is any misunderstanding, please let me know, thanks.
>=20
> Now you separate original OCFS2_JOURNAL_LOADED into
> OCFS2_JOURNAL_INITED
> and OCFS2_JOURNAL_LOADED. And ocfs2_journal_shutdown() will be called
> after OCFS2_JOURNAL_LOADED is set, e.g. normal umount, or error
> happens
> after ocfs2_check_volume(). You changes break the this logic.
>=20
> BTW, cc linux-kernel as well.

I see. Thanks very much for the clarification.
I will send patch v2 to fix it.
>=20
> Thanks,
> Joseph

Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>

