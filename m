Return-Path: <linux-kernel+bounces-308693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5567D966083
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1C411F27C0A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DC118F2DA;
	Fri, 30 Aug 2024 11:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSKfJx8w"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFECF17ADF8
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 11:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725016973; cv=none; b=bp8jWN22neEk39QLwt7p66jrUZZfmANS6ZbmsFw9p7ZsNa9o1OgZYFzUOdQCThAV6QLC9WdTIcS4SC/TcbMkmOE0dKO97vIZyVPYRvL5bSkKjEXM5aWm8n/ZkuWVNAHi5wxfihCRSOd2ipEXDqTNbP0K77zMgiN/ht+vQyptViQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725016973; c=relaxed/simple;
	bh=wIwvwUKOG3OEM+ezI3gYak2Vy1upJS1iUcuQZHF6yzA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=epBYVs7wjScNe9J7XwoZ6b3xdPvfWJe5QryaHGOp304dJdKXbxKdu1PookcJhX60WWjHSsJRVikM1V4Pu1OJeX0UVCxkGd4JNxQxRNVG6VWS6QE6E7wM/90QULfIewEQHLdrQLYd6fHbh6EqTx6y93gmLqYL+KaZ5DXVB7peiL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSKfJx8w; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-201f2b7fe0dso14441555ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 04:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725016971; x=1725621771; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wIwvwUKOG3OEM+ezI3gYak2Vy1upJS1iUcuQZHF6yzA=;
        b=jSKfJx8wnv7Iff8E0JsGsgcZL43TPTDDyElBEQCk7iN3YOpNYIpECqDOSgQswqLC+W
         nnjrNtu39BNH99EQRH931ewhtmP2Gd3T2bTzUzTK5yL/BCdyGqRjUodNfEbBNWupfg0G
         wQ3jH5eXDQ0yLzuIn3lwfZqT9PXKAyuRlZoZv3P98FwYGsfUL8KSnajmhaEJL0SF/lvh
         JXJf6yX34rgqDqMx+0zcdCg3p3ZUznwRacGNrqJgA+oqEZGrhJM+ROv/6rT1dsR7iGmJ
         Py9v92tDLmTpaOtkhw4DknnSks5FB9oP87ErggbhpTRTHk3T+p4YM+C2J4SSYomwaDXR
         yCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725016971; x=1725621771;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wIwvwUKOG3OEM+ezI3gYak2Vy1upJS1iUcuQZHF6yzA=;
        b=GjZvIJGiLxZHf7BgOnVPbH8hotaeIQdWWXg8IKeNw4j5RUf+n2D9pM8aEQir4Vbm01
         EQiKOjOqi/jqVIgTGdxJdxXjBGIRyugjL25t51yWmtK+aGVQ+syHORq17EgVlJHZb1qV
         DHqiWPkqzJC7/IalGN1/GmY3Ktngq6s2nlr9pFSLF/kaMLRqRcNcBilPWLO4OECdixes
         6zyxcZfKpwq9RGl5XiU5kzVmsbOIZK/HACXgKk74KWha+f1o4dhXedkadxYrUaEnIZ5X
         utx5DgTmS91dNRLsekTniOYXqMQmrSw5Y298fqHsXjQpQxWl4bsukIp6i5BI7qQ3yFAE
         EXfg==
X-Forwarded-Encrypted: i=1; AJvYcCXEbr75Fa3uYIRzjQAmj7CsJ4hdq/seJnmfnzTGVPgY/+U6G/YWM9dt6amb9ho/bRyXw6eZvyt42ybz9fw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsi+nBX2qjELK/lUfRG2wHR1HPnjH8UcSKUvUuYKaHHminBB5t
	SGrd9UcHWLa5oG/O4YW8cr+6NqBfMRtajKGLCHwdh2wzTdhNr6xs
X-Google-Smtp-Source: AGHT+IErjP0D6RKllvAb7gUkYZwg48gl2oGqB/1lqa8kY/FIEYH8slpwneV2kGtGyF3uvURQmH7Tjw==
X-Received: by 2002:a17:902:e54d:b0:202:e83:eb11 with SMTP id d9443c01a7336-2050c3fac93mr65673575ad.29.1725016970833;
        Fri, 30 Aug 2024 04:22:50 -0700 (PDT)
Received: from [127.0.0.1] ([103.85.75.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152b3175sm25047205ad.54.2024.08.30.04.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 04:22:50 -0700 (PDT)
Message-ID: <df71a155cb7b9cad2cc2d8c4262dfcc075f18946.camel@gmail.com>
Subject: Re: [PATCH v2] ocfs2: fix null-ptr-deref when journal load failed.
From: Julian Sun <sunjunchao2870@gmail.com>
To: Joseph Qi <joseph.qi@linux.alibaba.com>, ocfs2-devel@lists.linux.dev
Cc: lbec@evilplan.org, mark@fasheh.com, 
	syzbot+05b9b39d8bdfe1a0861f@syzkaller.appspotmail.com, 
	"linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, Heming Zhao <heming.zhao@suse.com>
Date: Fri, 30 Aug 2024 19:22:47 +0800
In-Reply-To: <fe86da76-555d-424a-828f-ea99b05b363f@linux.alibaba.com>
References: <20240823083150.17590-1-sunjunchao2870@gmail.com>
	 <07dea72e-8b93-4095-9347-4ff765a2539d@linux.alibaba.com>
	 <cf4174af158587cabd525ae23d35c0b399eade47.camel@gmail.com>
	 <fe86da76-555d-424a-828f-ea99b05b363f@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-08-30 at 18:58 +0800, Joseph Qi wrote:
>=20
>=20
> On 8/30/24 6:11 PM, Julian Sun wrote:
> > On Fri, 2024-08-30 at 17:40 +0800, Joseph Qi wrote:
> > >=20
> > >=20
> > > On 8/23/24 4:31 PM, Julian Sun wrote:
> > > > During the mounting process, if journal_reset() fails
> > > > because of too short journal, then lead to
> > > > jbd2_journal_load() fails with NULL j_sb_buffer.
> > > > Subsequently, ocfs2_journal_shutdown() calls
> > > > jbd2_journal_flush()->jbd2_cleanup_journal_tail()->
> > > > __jbd2_update_log_tail()->jbd2_journal_update_sb_log_tail()
> > > > ->lock_buffer(journal->j_sb_buffer), resulting in a
> > > > null-pointer dereference error.
> > > >=20
> > > > To resolve this issue, a new state OCFS2_JOURNAL_INITED
> > > > has been introduced to replace the previous functionality
> > > > of OCFS2_JOURNAL_LOADED, the original OCFS2_JOURNAL_LOADED
> > > > is only set when ocfs2_journal_load() is successful.
> > > > The jbd2_journal_flush() function is allowed to be called
> > > > only when this flag is set. The logic here is that if the
> > > > journal has even not been successfully loaded, there is
> > > > no need to flush the journal.
> > > >=20
> > > > Link:
> > > > https://syzkaller.appspot.com/bug?extid=3D05b9b39d8bdfe1a0861f
> > > > Reported-by:
> > > > syzbot+05b9b39d8bdfe1a0861f@syzkaller.appspotmail.com
> > > > Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> > > > ---
> > > > =C2=A0fs/ocfs2/journal.c | 9 ++++++---
> > > > =C2=A0fs/ocfs2/journal.h | 1 +
> > > > =C2=A02 files changed, 7 insertions(+), 3 deletions(-)
> > > >=20
> > > > diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
> > > > index 530fba34f6d3..da0ffcc5de0a 100644
> > > > --- a/fs/ocfs2/journal.c
> > > > +++ b/fs/ocfs2/journal.c
> > > > @@ -968,7 +968,7 @@ int ocfs2_journal_init(struct ocfs2_super
> > > > *osb,
> > > > int *dirty)
> > > > =C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ocfs2_set_journal_p=
arams(osb);
> > > > =C2=A0
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0journal->j_state =3D OCF=
S2_JOURNAL_LOADED;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0journal->j_state =3D OCF=
S2_JOURNAL_INITED;
> > > > =C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D 0;
> > > > =C2=A0done:
> > > > @@ -1039,6 +1039,7 @@ void ocfs2_journal_shutdown(struct
> > > > ocfs2_super *osb)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int status =3D 0;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct inode *inode=
 =3D NULL;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int num_running_tra=
ns =3D 0;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0enum ocfs2_journal_state=
 state;
> > > > =C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BUG_ON(!osb);
> > > > =C2=A0
> > > > @@ -1047,8 +1048,9 @@ void ocfs2_journal_shutdown(struct
> > > > ocfs2_super *osb)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0goto done;
> > > > =C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0inode =3D journal->=
j_inode;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0state =3D journal->j_sta=
te;
> > > > =C2=A0
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (journal->j_state !=
=3D OCFS2_JOURNAL_LOADED)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (state !=3D OCFS2_JOU=
RNAL_INITED && state !=3D
> > > > OCFS2_JOURNAL_LOADED)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0goto done;
> > > > =C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* need to inc inod=
e use count - jbd2_journal_destroy
> > > > will
> > > > iput. */
> > > > @@ -1076,7 +1078,7 @@ void ocfs2_journal_shutdown(struct
> > > > ocfs2_super *osb)
> > > > =C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BUG_ON(atomic_read(=
&(osb->journal->j_num_trans)) !=3D 0);
> > > > =C2=A0
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ocfs2_mount_local(os=
b)) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ocfs2_mount_local(os=
b) && state =3D=3D
> > > > OCFS2_JOURNAL_LOADED) {
> > >=20
> > > The only intent of the new introduced state is to identify if
> > > journal
> > > is
> > > truly loaded or not.
> > > So it seems that the simplest way to fix this is just check
> > > JBD2_LOADED
> > > here.
> > >=20
> > > if (ocfs2_mount_local(osb) &&
> > > =C2=A0=C2=A0=C2=A0 (journal->j_journal->j_flags & JBD2_LOADED)) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0...
> > > }
> > Hi, Joseph, thanks for your review and comments.=C2=A0
> >=20
> > Yeah! It's absolutely the simplest and cleanest way to fix this
> > issue.
> > Thanks for your suggestion.
> > >=20
> > > BTW, could you please also replace 'osb->journal->j_num_trans' to
> > > 'journal->j_num_trans'?
> > Sure.
> > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0jbd2_journal_lock_updates(journal->j_journal)=
;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D jbd2_journal_flush(journal->j_jour=
nal,
> > > > 0);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0jbd2_journal_unlock_updates(journal-
> > > > >j_journal);
> > > > @@ -1174,6 +1176,7 @@ int ocfs2_journal_load(struct
> > > > ocfs2_journal
> > > > *journal, int local, int replayed)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0osb->commit_task =3D NULL;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0journal->j_state =3D OCF=
S2_JOURNAL_LOADED;
> > >=20
> > > It seems that this has to be moved just after
> > > jbd2_journal_load().
> > > Anyway, I don't think we have to introduce a new state. See
> > > above.
> > >=20
> > Agreed. And now OCFS2_JOURNAL_LOADED is set when
> > ocfs2_journal_init()
> > succeed, it may led to some misunderstanding: the journal was not
> > really loaded when OCFS2_JOURNAL_LOADED was set. I would like to
> > rename
> > it to OCFS2_JOURNAL_INITED in another patch to make it clearer.
>=20
> Umm... You can treat it as ocfs2 journal state only, not jbd2.
> Also jbd2 doesn't have 'initialized' state either.
> So I don't think we have to do this change in the fix.
>=20
> Joseph=C2=A0=20
Got it. Thanks for your explanation.

Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>

