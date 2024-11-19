Return-Path: <linux-kernel+bounces-413727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A13899D1DE5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 03:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA82282964
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 02:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244BE13777F;
	Tue, 19 Nov 2024 02:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yx8B/w5T"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3953FF1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 02:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731981710; cv=none; b=Y0Y3yHJOVupCXEojdTeWO7OeOMYoFrhd8OaD5kKY1LkkCl3CsbI3RKBS4gAEmulR51LxQWzwrK7iosGFFgegGduPD/buoRiXEyvoPQggh91S4SzDC6DUYy4rwvJyrKzl0mFIMQGZL0cfgNCXh4S4w3tT8pdd1Q6vWfhbRx5aJMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731981710; c=relaxed/simple;
	bh=4CzWe3Pkngg0Rn8+xCLUS3Ji7Q6SjGFZsFlNQpLG7+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVgGfNDyWM6zOd0SrS+uYM9XpJ/i13D2egAi67Ksm23R35x5sKF0NBz6wDfwQp7f1N+y+aTpcEFE/fPKhFDlnaHd6zz/KFDLNnuSbmshD+ssmsSiYw+O6MVcjXzkp3M6sF1ALDpGkEscG1m4ZuvGp5BxF1Wyjp23fRs3MCAqzrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yx8B/w5T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731981707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a8nUNLEPwNPPGxVhi+HpyrPTnv0LRBFFFV5oZ0N0j2k=;
	b=Yx8B/w5TNGUaAahwCJZkJ6g2YGwv/Q9sjoDv7tO9IugO8QY/PtTAu2KfkuzbVR8K/2x1zS
	ZJCUbN2yC7S8AO3SCH5rC6GQxG03kPn8CXsqLlS5hoo7xPnNxHUNZGJOiAHByxZbWD4onu
	/8n4Gx7A2uiEtEGZg9R5w9ieONKya5Q=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-OQd10bCgOwO8F2-dbbpJhw-1; Mon, 18 Nov 2024 21:01:44 -0500
X-MC-Unique: OQd10bCgOwO8F2-dbbpJhw-1
X-Mimecast-MFC-AGG-ID: OQd10bCgOwO8F2-dbbpJhw
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d41a81a98fso44421486d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 18:01:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731981703; x=1732586503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8nUNLEPwNPPGxVhi+HpyrPTnv0LRBFFFV5oZ0N0j2k=;
        b=ra4WNMZrN5H+41B/jtm0qZSDkC4fJpBIjo8cIzKvCjYjQtBTaLBppy+28VuJLdlXmG
         zyfFPTvTEuyEeBvMwg3w8yrJV3IfuTUEhaLUkaBSTngK2eJ8kJlBHbazDnY2WjVq1LNg
         HcCCGH2sqIqCFymA5Yf31OrtrxF0TDNVm4MDBAIR0CB7ZlL0/mbcLjTXYVSL8drD8ELZ
         KmlhHh6IDQG+9GVnSv6xsk18B5juQSe/IjBVFy0ZMmcyoXmTeE7G28RXSgbTNDkqEhzs
         jaJMREy3RatTS6oXucCLsGt/uxNKHmT0Ej5Ld2Qzu19cx4sbfzEA5yV2bEmzSeta5Ten
         MJAA==
X-Forwarded-Encrypted: i=1; AJvYcCXWE6GHK5fkC+92yYGwpK2i19xdBxcWHl/2fnFDA9+yRCuy5xXgtsvnQtIvbk1i3Y97lrUc+GRA7pdCHPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjZl5tZcrjKGUNTACMfqrx5drXTG509zResYGT3c8JiAvv4UiN
	vDqtiFl13vhRgROpWMb6abtvlzSf3xtfinFTUqx9SrIRwrdYPzt9cL6PiSO30i/tAD0ljBKaUCg
	1cnHCVvm1EBgpI5NeNCixPQlHKyrbEEglqfi1bzKtRPYe1OBwDvxH4E0hYwSGzy3UwUxnvZcL2T
	xwgIg9KKHCrMjkJ0izhby8Itcfb+SwtdLXGxSS
X-Received: by 2002:a0c:f9c8:0:b0:6d4:1a8a:ade5 with SMTP id 6a1803df08f44-6d42b916b30mr28338286d6.20.1731981703683;
        Mon, 18 Nov 2024 18:01:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRqDulaPRW/bZrFjSc/8bcQfzDYWKud3q8xsut29HBWC/z8H85bhXSWjCX2BdSW4r970zyh5zGm19KVYSPf2c=
X-Received: by 2002:a0c:f9c8:0:b0:6d4:1a8a:ade5 with SMTP id
 6a1803df08f44-6d42b916b30mr28338076d6.20.1731981703422; Mon, 18 Nov 2024
 18:01:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022144838.1049499-1-batrick@batbytes.com>
 <20241022144838.1049499-3-batrick@batbytes.com> <CAOi1vP_S75CpvjRG5DXinG20PUOqc3Kf+nxtRjmZekjDbM+q1g@mail.gmail.com>
In-Reply-To: <CAOi1vP_S75CpvjRG5DXinG20PUOqc3Kf+nxtRjmZekjDbM+q1g@mail.gmail.com>
From: Patrick Donnelly <pdonnell@redhat.com>
Date: Mon, 18 Nov 2024 21:01:17 -0500
Message-ID: <CA+2bHPZeeA0-i-e1TyjYrvCWW+c6uWfxMqaJuehj=1T1=KV1Ng@mail.gmail.com>
Subject: Re: [PATCH 2/3] ceph: correct ceph_mds_cap_peer field name
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Patrick Donnelly <batrick@batbytes.com>, Xiubo Li <xiubli@redhat.com>, 
	"open list:CEPH DISTRIBUTED FILE SYSTEM CLIENT (CEPH)" <ceph-devel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 5:55=E2=80=AFAM Ilya Dryomov <idryomov@gmail.com> w=
rote:
>
> On Tue, Oct 22, 2024 at 4:49=E2=80=AFPM Patrick Donnelly <batrick@batbyte=
s.com> wrote:
> >
> > See also ceph.git commit: "include/ceph_fs: correct ceph_mds_cap_peer f=
ield name".
> >
> > See-also: https://tracker.ceph.com/issues/66704
> > Signed-off-by: Patrick Donnelly <pdonnell@redhat.com>
> > ---
> >  fs/ceph/caps.c               | 23 ++++++++++++-----------
> >  include/linux/ceph/ceph_fs.h |  2 +-
> >  2 files changed, 13 insertions(+), 12 deletions(-)
> >
> > diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> > index bed34fc11c91..88a674cf27a8 100644
> > --- a/fs/ceph/caps.c
> > +++ b/fs/ceph/caps.c
> > @@ -4086,17 +4086,17 @@ static void handle_cap_export(struct inode *ino=
de, struct ceph_mds_caps *ex,
> >         struct ceph_inode_info *ci =3D ceph_inode(inode);
> >         u64 t_cap_id;
> >         unsigned mseq =3D le32_to_cpu(ex->migrate_seq);
> > -       unsigned t_seq, t_mseq;
> > +       unsigned t_issue_seq, t_mseq;
> >         int target, issued;
> >         int mds =3D session->s_mds;
> >
> >         if (ph) {
> >                 t_cap_id =3D le64_to_cpu(ph->cap_id);
> > -               t_seq =3D le32_to_cpu(ph->seq);
> > +               t_issue_seq =3D le32_to_cpu(ph->issue_seq);
> >                 t_mseq =3D le32_to_cpu(ph->mseq);
> >                 target =3D le32_to_cpu(ph->mds);
> >         } else {
> > -               t_cap_id =3D t_seq =3D t_mseq =3D 0;
> > +               t_cap_id =3D t_issue_seq =3D t_mseq =3D 0;
> >                 target =3D -1;
> >         }
> >
> > @@ -4134,12 +4134,12 @@ static void handle_cap_export(struct inode *ino=
de, struct ceph_mds_caps *ex,
> >         if (tcap) {
> >                 /* already have caps from the target */
> >                 if (tcap->cap_id =3D=3D t_cap_id &&
> > -                   ceph_seq_cmp(tcap->seq, t_seq) < 0) {
> > +                   ceph_seq_cmp(tcap->seq, t_issue_seq) < 0) {
> >                         doutc(cl, " updating import cap %p mds%d\n", tc=
ap,
> >                               target);
> >                         tcap->cap_id =3D t_cap_id;
> > -                       tcap->seq =3D t_seq - 1;
> > -                       tcap->issue_seq =3D t_seq - 1;
> > +                       tcap->seq =3D t_issue_seq - 1;
> > +                       tcap->issue_seq =3D t_issue_seq - 1;
> >                         tcap->issued |=3D issued;
> >                         tcap->implemented |=3D issued;
> >                         if (cap =3D=3D ci->i_auth_cap) {
> > @@ -4154,7 +4154,7 @@ static void handle_cap_export(struct inode *inode=
, struct ceph_mds_caps *ex,
> >                 int flag =3D (cap =3D=3D ci->i_auth_cap) ? CEPH_CAP_FLA=
G_AUTH : 0;
> >                 tcap =3D new_cap;
> >                 ceph_add_cap(inode, tsession, t_cap_id, issued, 0,
> > -                            t_seq - 1, t_mseq, (u64)-1, flag, &new_cap=
);
> > +                            t_issue_seq - 1, t_mseq, (u64)-1, flag, &n=
ew_cap);
> >
> >                 if (!list_empty(&ci->i_cap_flush_list) &&
> >                     ci->i_auth_cap =3D=3D tcap) {
> > @@ -4268,14 +4268,14 @@ static void handle_cap_import(struct ceph_mds_c=
lient *mdsc,
> >                 doutc(cl, " remove export cap %p mds%d flags %d\n",
> >                       ocap, peer, ph->flags);
> >                 if ((ph->flags & CEPH_CAP_FLAG_AUTH) &&
> > -                   (ocap->seq !=3D le32_to_cpu(ph->seq) ||
> > +                   (ocap->seq !=3D le32_to_cpu(ph->issue_seq) ||
> >                      ocap->mseq !=3D le32_to_cpu(ph->mseq))) {
> >                         pr_err_ratelimited_client(cl, "mismatched seq/m=
seq: "
> >                                         "%p %llx.%llx mds%d seq %d mseq=
 %d"
> >                                         " importer mds%d has peer seq %=
d mseq %d\n",
> >                                         inode, ceph_vinop(inode), peer,
> >                                         ocap->seq, ocap->mseq, mds,
> > -                                       le32_to_cpu(ph->seq),
> > +                                       le32_to_cpu(ph->issue_seq),
> >                                         le32_to_cpu(ph->mseq));
> >                 }
> >                 ceph_remove_cap(mdsc, ocap, (ph->flags & CEPH_CAP_FLAG_=
RELEASE));
> > @@ -4350,7 +4350,7 @@ void ceph_handle_caps(struct ceph_mds_session *se=
ssion,
> >         struct ceph_snap_realm *realm =3D NULL;
> >         int op;
> >         int msg_version =3D le16_to_cpu(msg->hdr.version);
> > -       u32 seq, mseq;
> > +       u32 seq, mseq, issue_seq;
> >         struct ceph_vino vino;
> >         void *snaptrace;
> >         size_t snaptrace_len;
> > @@ -4375,6 +4375,7 @@ void ceph_handle_caps(struct ceph_mds_session *se=
ssion,
> >         vino.snap =3D CEPH_NOSNAP;
> >         seq =3D le32_to_cpu(h->seq);
> >         mseq =3D le32_to_cpu(h->migrate_seq);
> > +       issue_seq =3D le32_to_cpu(h->issue_seq);
> >
> >         snaptrace =3D h + 1;
> >         snaptrace_len =3D le32_to_cpu(h->snap_trace_len);
> > @@ -4598,7 +4599,7 @@ void ceph_handle_caps(struct ceph_mds_session *se=
ssion,
> >                 cap->cap_id =3D le64_to_cpu(h->cap_id);
> >                 cap->mseq =3D mseq;
> >                 cap->seq =3D seq;
> > -               cap->issue_seq =3D seq;
> > +               cap->issue_seq =3D issue_seq;
>
> Hi Patrick,
>
> This isn't just a rename -- a different field is decoded and assigned
> to cap->issue_seq now.  What is the impact of this change and should it
> be mentioned in the commit message?

You are right. This change slipped in by accident with some other
changes I have not yet pushed. I will revert this one.

--=20
Patrick Donnelly, Ph.D.
He / Him / His
Red Hat Partner Engineer
IBM, Inc.
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D


