Return-Path: <linux-kernel+bounces-423039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 479109DA1C8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 06:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE13B169032
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 05:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20F913D8B5;
	Wed, 27 Nov 2024 05:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bS8j9MwL"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E25A13C661
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 05:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732686189; cv=none; b=kVlv4KXQnOOZlD7x64M8pqDAZYTDUdrJNMJIi3Nx+AIWKgo2leVzfpkJemvaHs2IC5wW2MPW6DNUnEMuQQa/T546XNc6tW22/OTQJI8sAfBxEny9206WETzRMOP5h1oeMhEl41zdAYTpRprfO0s1EtsK6BeHItmBprQMpmGkzOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732686189; c=relaxed/simple;
	bh=eFQXbOKlo4QI9fdpsg6S7Lp8wDnYBlKqK3Tc2d4MUy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P03QggPHT7U5YnXSs9GvqNyenHb4NwwheQKxE6q/hZaw6MmRuGnIPyJx/DU+nQtym8joLIMGt4mHJDa2jKyMmhzmfRpQMpScBJWi+J99gwu43wpkQV1K48IJSG2uDKWOGxnM+qPvNvfH7WYgZzGqN18j4xynMKAlLajSZ6XF/hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bS8j9MwL; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6ef15421050so31043497b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 21:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1732686186; x=1733290986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aaAX4RZQ1xLyXXEaIAjcxe7Kvkm0fdu7E5v2P3w9co=;
        b=bS8j9MwL83KFVahhEHuR+MLqtRZJBC5ekXQNqJ/MedMrsqFMJtvK1YRzdnhuVScdEc
         ITIEP0K4o5wPHwIgkMko/5Oxw+jDMAx7yOc5FjZ9gadlQlCnngWrs7mddiywdLX8FNbR
         ONRjNRL4p+npsGakz0/t6TK50mdmF8QDkSIdFTlnuej0brWl3MqppmwkEW+W6tkWnIDB
         gKglTcY6il8466l59mvYOsNAqNXa0tN5Mm6HVtoiw8ZFGxCxRUWo7vbRRtaFmz0nniL4
         /w+B7kp1fvjDoLBA8W81U1CElKXOE6NyCc6aPlZiaRo2gsS7exwb56pqcUVem3vehJUf
         kPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732686186; x=1733290986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5aaAX4RZQ1xLyXXEaIAjcxe7Kvkm0fdu7E5v2P3w9co=;
        b=DFu795Ek69FzVU3lkpgnIlk/elut3JDVkqElBmvxSxRJVe2XHhmgJEntQpqdluESp3
         O5qeCJPgnEx7eUyw8qZQiKDSgW75pYcMRiK4v7c806AjrCcrL7lg04DCNYphb1x9Vzzt
         3C0ot/hDuq4q19Hr2zQWemwggf2uLjLusWsupv1q4gsVXCJDmJzv5kqToAlga9mLB4fz
         yS/MCvoFovEa1TkmdErWxx2i0HPGa0Bqzlqt4sVfB/9qMwdN8dUzv/Dy1S3kJpCMC4UV
         HgpCzBE4J+rksSbh0+QW0wjGBvBCU1jXBlU+M66yNJZd30WABLcd6DdDHVehH/uRhv1G
         cOnA==
X-Forwarded-Encrypted: i=1; AJvYcCVO4+DKxQZaIT7NqhZIYVsCyrbDwuIIEfV4QkKTRmx87+md+TdeFb00utapulVSb0XVySpQPqZuiNCQ68M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBKjZUCtW2yK+M0bJFwVKAS93+NjZuY1QLvAVNkEaOZlRzxZXg
	8qt4cPPJvJwkApLq4XUaCG1jPiifqyEtXOd9Wz45UCU8ADhtKJ9KGjI+ohTii9XZ+HF+ZP7EbO0
	fCLCZBK3hlzbpfpjS69gwgZls2J8Hi/9XkMHO
X-Gm-Gg: ASbGncuBm04N48F5b/MqrCTBWd+ySLftRMGrWM+0MVA7fuJbs5wGmefodD8lTHlFePI
	s2XhjTKqhWnJZWnxnet+kT8/MtgxixQ==
X-Google-Smtp-Source: AGHT+IEfi5hkYi2FmLWoEuKrh1fKpnEV3WPMq0hcFnZS8ZxKTwfYhJ2oW3fPYtzBTSWpy0L6yeV6LzTMjR/NV6TC0W8=
X-Received: by 2002:a05:690c:4d09:b0:6ee:86da:3a55 with SMTP id
 00721157ae682-6ef3727ab7cmr25755157b3.28.1732686186260; Tue, 26 Nov 2024
 21:43:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105123807.1257948-1-rrobaina@redhat.com> <2d9292c28df34c50c1c0d1cbf6ce3b52@paul-moore.com>
 <20241113230425.GJ3387508@ZenIV> <19328b27f98.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <20241114040948.GK3387508@ZenIV>
In-Reply-To: <20241114040948.GK3387508@ZenIV>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 27 Nov 2024 00:42:55 -0500
Message-ID: <CAHC9VhTyp6ao8n0EVp_JdgRXFfP0nLkf0YMKPmiAurFJ_CM0fQ@mail.gmail.com>
Subject: Re: [PATCH v1] audit: fix suffixed '/' filename matching in __audit_inode_child()
To: Al Viro <viro@zeniv.linux.org.uk>, Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, eparis@redhat.com, 
	rgb@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 11:09=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
> On Wed, Nov 13, 2024 at 10:23:55PM -0500, Paul Moore wrote:
> > > And while we are at it,
> > > parentlen =3D parentlen =3D=3D AUDIT_NAME_FULL ? parent_len(path) : p=
arentlen;
> > > is a bloody awful way to spell
> > > if (parentlen =3D=3D AUDIT_NAME_FULL)
> > >  parentlen =3D parent_len(path);
> > > What's more, parent_len(path) starts with *yet* *another* strlen(path=
),
> > > followed by really awful crap - we trim the trailing slashes (if any)=
,
> > > then search for the last slash before that...  is that really worth
> > > the chance to skip that strncmp()?
> >
> > Pretty much all of the audit code is awkward at best Al, you should kno=
w
> > that.
>
> Do I ever...
>
> > We're not going to fix it all in one patch, and considering the nature
> > of this patch effort, I think there is going to be a lot of value in ke=
eping
> > the initial fix patch to a minimum to ease backporting.  We can improve=
 on
> > some of those other issues in a second patch or at a later time.
> >
> > As a reminder to everyone, patches are always welcome.  Fixing things i=
s a
> > great way to channel disgust into something much more useful.
>
> > >
> > > > +       if (p[pathlen - 1] =3D=3D '/')
> > > > +               pathlen--;
> > > > +
> > > > +       if (pathlen !=3D dlen)
> > > > +               return 1;
> > > >
> > > > return strncmp(p, dname->name, dlen);
> > >
> > > ... which really should've been memcmp(), at that.
> >
> > Agreed. See above.
>
> OK, my primary interest here is to separate struct filename from that stu=
ff
> as much as possible.  So we will end up stomping on the same ground for
> a while here.  FWIW, my current filename-related pile is in #next.filenam=
e;
> there will be a lot more on the VFS side, but one of the obvious targets =
is
> ->aname, so __audit_inode() and its vicinity will get affected.  We'll ne=
ed
> to coordinate that stuff.

[Sorry for the delay, it took me a bit longer than expected to get
through my inbox upon returning home, but I should be mostly caught up
now.]

We've talked a bit in other threads about the struct filename changes
you're working on, and while I haven't looked at your next.filename
branch, the stuff you were talking about doing made sense.  As far as
cross-tree conflicts go, I don't think we'll have too many problems
there as I don't foresee any major audit work happening in the
immediate future; sure we'll likely have a small number of fixes but
those should be easy enough to manage with your changes.  I'm assuming
your next.filename finds its way into linux-next?  If so, that should
give us a heads-up regarding conflicts.  If there is a nasty
collision, I'm confident we can figure something out.

> Anyway, regarding audit_compare_dname_path(), handling just the last '/' =
is
> not enough - there might be any number of trailing slashes, not just one.

Good reminder, thanks.  I see that Ricardo has sent an updated patch,
I haven't looked at it yet (waiting for the merge window to close),
but hopefully he has taken that into account (hint: now would be a
good time to verify that Ricardo <g>).

> Another fun issue with looking for matches is this:
>
> mkdir /tmp/foo
> mkdir /tmp/foo/bar
> mkdir /tmp/blah
> ln -s ../foo/bar/baz /tmp/blah/barf
> echo crap > /tmp/blah/barf
>
> The last one will create a regular file "baz" in /tmp/foo/bar and write
> "crap\n" into it.  With the only pathname passed to open(2) being
> "/tmp/blah/barf".  And there may be a longer chain of symlinks like that.
>
> What do you want to see reported in such case?

In the absence of anyone pushing third party requirements on the audit
subsystem to meet various security certification goals, my guiding
light has been to try and do the simplest thing that makes sense.
Looking at this quickly, there are three different types of events:
mkdir, symlink, and a file lookup/write.

The mkdir events in the example above are trivial, you log the usual
info when walking the pathname and call it good.

The symlink is mostly the same as mkdir, but you've got the relative
path to contend with so the current working directory is more
important and should be logged as well.

The file lookup/write can be a bit more complicated if we have all of
the symlink information as part of the pathname lookup/walk, but if we
don't have that I think we can manage with just the "/tmp/blah/barf".
Users/admins that really care about links will likely be logging the
various link*/symlink*/unlink* syscalls for the directories/files they
care about.

Of course if anyone has any requirements or reasoned opinions about
what we should log here, I'd love to hear it.  This includes you Al.

--=20
paul-moore.com

