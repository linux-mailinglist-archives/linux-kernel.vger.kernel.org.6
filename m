Return-Path: <linux-kernel+bounces-308542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D83D965E50
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42ED91C24F14
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0B718DF66;
	Fri, 30 Aug 2024 10:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FphOJAR4"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBBB18E344
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725012714; cv=none; b=TC4+3Td3w8Af4mlm5bE4aiITAeKuIxIPQWuGIobgHjcB5pqUiwkU0//b1c/xA33ILLnfvcfCaiPjlLNLHNGW8aHy6jzVbTTEDJNirON6frz/TiSovEfSbmbRnHzeAyJM50yOghtYbAvlrwP/DopmX86kQlgUNwHgR1HkJkwdXo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725012714; c=relaxed/simple;
	bh=26Ca6vMm1oviq71AbCgAIOw9/GdoUlRwpZXXZkEb4Fk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IzHI45Ud6wJ6NMtuw834eWMeb4EMSge+ceuwnsntO45UXmm5yvegdNdklzdQkACS5YVVT+839vz0aN2z+m1u4oUokgNx3pH0BxJZ83V2D84yba/sAdlrgdUyuQfyWcevqIDUIYOnroDO+NsIKLITT0TkfymQe3yQZa7RVKtogxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FphOJAR4; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fee6435a34so12301475ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 03:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725012712; x=1725617512; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=26Ca6vMm1oviq71AbCgAIOw9/GdoUlRwpZXXZkEb4Fk=;
        b=FphOJAR4ndyvT4AdQhxc/LH/aMbCZKurogIajrDUUbAWrsxLsIlS7T4BxPMnxwexbk
         MQwCxKBYA2sKlp5MCr3x+smcrdkD36kssgDMBZAWByFSUYMsv0wh3gT4o24RHtJ8BjsX
         wrpIz3po9rGDODrvq6QwsYKYPw8eCuQeDLNd+6dwC9dtvMh1SOytEzDwQNh+bBJLUGBT
         At97C+l1cprin9ub6+UL6ivtLWmLLOt6phm9RTu6bCo1udbrv3YnFZ4ovJ1CJ/M98OM4
         o9JL5Y0eur5RymU222V9rDoe4tnOMhI9hm5ZB1LMCLqM69OX9T+h6b13mcH+70uSyWkF
         7fnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725012712; x=1725617512;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=26Ca6vMm1oviq71AbCgAIOw9/GdoUlRwpZXXZkEb4Fk=;
        b=wGHO/Xp0dOQDnaDZwajYqHBLwQY5uP/Bs75dHQ8/BBBzp9PfKiawcDMpZFS78ayM7l
         7aUC0RhMlKLPQbxyvpSm5TyuUJHzsMRrS7Nmz/a2e2hHXfR58lvVVs6WeJXEgfXjgoid
         fJ57GNeyYTBls3olcTi93SVO1mff90iyl1UPCacs1N02StGpNLrFgwybU3WJ517IkEYY
         dJybDMCKx2VraO7Bsvx+U2spTvK6VKb35HRq+BR5KrVMzkgihhtHNSmtwBu1DF3k5spK
         p5NShegZnANQ2EV76Zi1ZSV4bSYMilDfvEIJvlscDrEXjs+FtXPVvVqKQBoDkkUKLMUN
         t+0g==
X-Forwarded-Encrypted: i=1; AJvYcCWeRnhBPWh0/GJXSLnrhSHq3vk1vrCBn7EIG0W/Vj7Q3G/9HTR2bDWGV0uEQdAt9jPHwHnbkutyCPVTBEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1l6EAsQvHlAZlBgcVUaI63qCEUYudkY5oItx4YbWZnAb07dRH
	3V6fmAqXZ+qScBWFAozBqYKvWg6tBcB+6Lq/NcyQOBORnuSUGpMX
X-Google-Smtp-Source: AGHT+IEPl32t/Wy2FfG64Z9IGfE7a6++/+S6tHLrG4sBCisl4W+4mnWpNDiEmFvkNBahXNHCyeWqgg==
X-Received: by 2002:a17:902:c94b:b0:202:1176:5e39 with SMTP id d9443c01a7336-2050c4891cdmr51843845ad.56.1725012711735;
        Fri, 30 Aug 2024 03:11:51 -0700 (PDT)
Received: from [127.0.0.1] ([103.85.75.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152b33eesm24116395ad.32.2024.08.30.03.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 03:11:51 -0700 (PDT)
Message-ID: <cf4174af158587cabd525ae23d35c0b399eade47.camel@gmail.com>
Subject: Re: [PATCH v2] ocfs2: fix null-ptr-deref when journal load failed.
From: Julian Sun <sunjunchao2870@gmail.com>
To: Joseph Qi <joseph.qi@linux.alibaba.com>, ocfs2-devel@lists.linux.dev
Cc: lbec@evilplan.org, mark@fasheh.com, 
	syzbot+05b9b39d8bdfe1a0861f@syzkaller.appspotmail.com, 
	"linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, Heming Zhao <heming.zhao@suse.com>
Date: Fri, 30 Aug 2024 18:11:48 +0800
In-Reply-To: <07dea72e-8b93-4095-9347-4ff765a2539d@linux.alibaba.com>
References: <20240823083150.17590-1-sunjunchao2870@gmail.com>
	 <07dea72e-8b93-4095-9347-4ff765a2539d@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-08-30 at 17:40 +0800, Joseph Qi wrote:
>=20
>=20
> On 8/23/24 4:31 PM, Julian Sun wrote:
> > During the mounting process, if journal_reset() fails
> > because of too short journal, then lead to
> > jbd2_journal_load() fails with NULL j_sb_buffer.
> > Subsequently, ocfs2_journal_shutdown() calls
> > jbd2_journal_flush()->jbd2_cleanup_journal_tail()->
> > __jbd2_update_log_tail()->jbd2_journal_update_sb_log_tail()
> > ->lock_buffer(journal->j_sb_buffer), resulting in a
> > null-pointer dereference error.
> >=20
> > To resolve this issue, a new state OCFS2_JOURNAL_INITED
> > has been introduced to replace the previous functionality
> > of OCFS2_JOURNAL_LOADED, the original OCFS2_JOURNAL_LOADED
> > is only set when ocfs2_journal_load() is successful.
> > The jbd2_journal_flush() function is allowed to be called
> > only when this flag is set. The logic here is that if the
> > journal has even not been successfully loaded, there is
> > no need to flush the journal.
> >=20
> > Link: https://syzkaller.appspot.com/bug?extid=3D05b9b39d8bdfe1a0861f
> > Reported-by: syzbot+05b9b39d8bdfe1a0861f@syzkaller.appspotmail.com
> > Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> > ---
> > =C2=A0fs/ocfs2/journal.c | 9 ++++++---
> > =C2=A0fs/ocfs2/journal.h | 1 +
> > =C2=A02 files changed, 7 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
> > index 530fba34f6d3..da0ffcc5de0a 100644
> > --- a/fs/ocfs2/journal.c
> > +++ b/fs/ocfs2/journal.c
> > @@ -968,7 +968,7 @@ int ocfs2_journal_init(struct ocfs2_super *osb,
> > int *dirty)
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ocfs2_set_journal_param=
s(osb);
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0journal->j_state =3D OCFS2_J=
OURNAL_LOADED;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0journal->j_state =3D OCFS2_J=
OURNAL_INITED;
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D 0;
> > =C2=A0done:
> > @@ -1039,6 +1039,7 @@ void ocfs2_journal_shutdown(struct
> > ocfs2_super *osb)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int status =3D 0;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct inode *inode =3D=
 NULL;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int num_running_trans =
=3D 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0enum ocfs2_journal_state sta=
te;
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BUG_ON(!osb);
> > =C2=A0
> > @@ -1047,8 +1048,9 @@ void ocfs2_journal_shutdown(struct
> > ocfs2_super *osb)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0goto done;
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0inode =3D journal->j_in=
ode;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0state =3D journal->j_state;
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (journal->j_state !=3D OC=
FS2_JOURNAL_LOADED)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (state !=3D OCFS2_JOURNAL=
_INITED && state !=3D
> > OCFS2_JOURNAL_LOADED)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0goto done;
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* need to inc inode us=
e count - jbd2_journal_destroy will
> > iput. */
> > @@ -1076,7 +1078,7 @@ void ocfs2_journal_shutdown(struct
> > ocfs2_super *osb)
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BUG_ON(atomic_read(&(os=
b->journal->j_num_trans)) !=3D 0);
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ocfs2_mount_local(osb)) =
{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ocfs2_mount_local(osb) &=
& state =3D=3D
> > OCFS2_JOURNAL_LOADED) {
>=20
> The only intent of the new introduced state is to identify if journal
> is
> truly loaded or not.
> So it seems that the simplest way to fix this is just check
> JBD2_LOADED
> here.
>=20
> if (ocfs2_mount_local(osb) &&
> =C2=A0=C2=A0=C2=A0 (journal->j_journal->j_flags & JBD2_LOADED)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0...
> }
Hi, Joseph, thanks for your review and comments.=C2=A0

Yeah! It's absolutely the simplest and cleanest way to fix this issue.
Thanks for your suggestion.
>=20
> BTW, could you please also replace 'osb->journal->j_num_trans' to
> 'journal->j_num_trans'?
Sure.
>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0jbd2_journal_lock_updates(journal->j_journal);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D jbd2_journal_flush(journal->j_journal=
, 0);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0jbd2_journal_unlock_updates(journal->j_journal);
> > @@ -1174,6 +1176,7 @@ int ocfs2_journal_load(struct ocfs2_journal
> > *journal, int local, int replayed)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0osb->commit_task =3D NULL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0journal->j_state =3D OCFS2_J=
OURNAL_LOADED;
>=20
> It seems that this has to be moved just after jbd2_journal_load().
> Anyway, I don't think we have to introduce a new state. See above.
>=20
Agreed. And now OCFS2_JOURNAL_LOADED is set when ocfs2_journal_init()
succeed, it may led to some misunderstanding: the journal was not
really loaded when OCFS2_JOURNAL_LOADED was set. I would like to rename
it to OCFS2_JOURNAL_INITED in another patch to make it clearer.
> Joseph
>=20
> > =C2=A0
> > =C2=A0done:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return status;
> > diff --git a/fs/ocfs2/journal.h b/fs/ocfs2/journal.h
> > index e3c3a35dc5e0..a80f76a8fa0e 100644
> > --- a/fs/ocfs2/journal.h
> > +++ b/fs/ocfs2/journal.h
> > @@ -15,6 +15,7 @@
> > =C2=A0
> > =C2=A0enum ocfs2_journal_state {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0OCFS2_JOURNAL_FREE =3D =
0,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0OCFS2_JOURNAL_INITED,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0OCFS2_JOURNAL_LOADED,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0OCFS2_JOURNAL_IN_SHUTDO=
WN,
> > =C2=A0};

Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>

