Return-Path: <linux-kernel+bounces-383209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E38639B187F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 15:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C1BB282E2D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 13:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442CCC148;
	Sat, 26 Oct 2024 13:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="CfG29EH1"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48D079FD
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 13:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729950066; cv=none; b=P3nDYM/OOCLv28bFIumobBCpQ+j4Tk21sF8QpHuYkgL+8ixh5PqsDuoMHx+U30h/h+vdRt2NSD2kqWy7+GYmusydq8kbJXbc87HVFrP3SbcL/Y0w4bNXoq4QmiD3RnzJPGm4bTn1hIRma7gGfhX/5ER99jgRxHvxr6G0PjAIybc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729950066; c=relaxed/simple;
	bh=DEpLeEzPHyHeDAGXiY/8eO94ocEp1xG5C8vc1GWSa7E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WYn4LjuW+05Jbw9sSdygsodU0XuhCRCFwLQvJwxWk2OjZlt0qnyJiMXSSJZdZTHjYrZFO96wdSO84poxPsvjX+BOksNAhpQ7wlw3cgF701MR9pDjKX5ax78TpuAVSoeC0/uRNz0j3J9tiPtgFwHS701aD1iFiZcg/OEG/SeXelg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=CfG29EH1; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1729950052; x=1730209252;
	bh=DEpLeEzPHyHeDAGXiY/8eO94ocEp1xG5C8vc1GWSa7E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=CfG29EH1wMduHeX/tKdntSH8o9wmfLufImiiCNWj4y3Gmg62yrwe3nXpdQ19Om3XX
	 111Gl+bl/BuBN5zTee7ksKCx60y55mhp7fh9corCO7EdUzU8lSrMAkfW6JaA/QDfVV
	 GAapEm6VyD3wJL476vnr84lPiIQpNEm+0RWUJ/Xw/bMjKLptrMW46yw4uiKuWY22u8
	 VBh2TKvlCOMvFBkCq0c9mQ37juym5Zyuc8CthLkHmI9c33fcrpYaxqs/SVik496oKd
	 RR7LFTPvTwJPmGmqtlVoTQwf1dhn+E6tPZ8zc/trkRBH8LsjSyNu4PqvGJjdK7JCrG
	 F2skoRMt+1Pxg==
Date: Sat, 26 Oct 2024 13:40:47 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
From: Piotr Zalewski <pZ010001011111@proton.me>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, syzbot+2b6a17991a6af64f9489@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] bcachefs: init freespace inited bits to 0 in bch2_fs_initialize
Message-ID: <ZE-D4gWuaHm-NpPnk8yUxXY4ouYy492LCPmnEgWG3fiIleDRGZU9SjbSbYiVWPa2_OYirT-Jx_E7b5NsSh9s6Txvnkc0KRsGHNKHH1umkDE=@proton.me>
In-Reply-To: <zks5hk34if64nu4t7tsnjc2om4cdyo7fs62fgyxjzetr6njo72@ajmllmpmex45>
References: <20241026001004.10470-2-pZ010001011111@proton.me> <zks5hk34if64nu4t7tsnjc2om4cdyo7fs62fgyxjzetr6njo72@ajmllmpmex45>
Feedback-ID: 53478694:user:proton
X-Pm-Message-ID: 8f935a0f5fc82f7c3c0c04a47e6eb2e2798f5fcf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Saturday, October 26th, 2024 at 2:30 AM, Kent Overstreet <kent.overstree=
t@linux.dev> wrote:

> On Sat, Oct 26, 2024 at 12:15:49AM +0000, Piotr Zalewski wrote:
>=20
> > Initialize freespace_initialized bits to 0 in member's flags and update
> > member's cached version for each device in bch2_fs_initialize.
> >=20
> > It's possible for the bits to be set to 1 before fs is initialized and =
if
> > call to bch2_trans_mark_dev_sbs (just before bch2_fs_freespace_init) fa=
ils
> > bits remain to be 1 which can later indirectly trigger BUG condition in
> > bch2_bucket_alloc_freelist during shutdown.
> >=20
> > Reported-by: syzbot+2b6a17991a6af64f9489@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D2b6a17991a6af64f9489
> > Fixes: bbe682c76789 ("bcachefs: Ensure devices are always correctly ini=
tialized")
> > Suggested-by: Kent Overstreet kent.overstreet@linux.dev
> > Signed-off-by: Piotr Zalewski pZ010001011111@proton.me
> > ---
> >=20
> > Notes:
> > changes in v3:
> > - v2 rebased
> >=20
> > changes in v2:
> > - unconditionally set freespace initialized bits to false at
> > the top of bch2_fs_initialized instead of only if
> > bch2_trans_mark_dev_sbs fails
> >=20
> > Link to v2: https://lore.kernel.org/linux-bcachefs/20241021174151.37692=
-2-pZ010001011111@proton.me/
> > Link to v1: https://lore.kernel.org/linux-bcachefs/20241020170708.67044=
-2-pZ010001011111@proton.me/
> >=20
> > fs/bcachefs/recovery.c | 8 ++++++++
> > 1 file changed, 8 insertions(+)
> >=20
> > diff --git a/fs/bcachefs/recovery.c b/fs/bcachefs/recovery.c
> > index fdf2aa2ffc13..8d4c93a1f5aa 100644
> > --- a/fs/bcachefs/recovery.c
> > +++ b/fs/bcachefs/recovery.c
> > @@ -1029,6 +1029,7 @@ int bch2_fs_initialize(struct bch_fs *c)
> > struct bch_inode_unpacked root_inode, lostfound_inode;
> > struct bkey_inode_buf packed_inode;
> > struct qstr lostfound =3D QSTR("lost+found");
> > + struct bch_member *m;
> > int ret;
> >=20
> > bch_notice(c, "initializing new filesystem");
> > @@ -1045,6 +1046,13 @@ int bch2_fs_initialize(struct bch_fs *c)
> > SET_BCH_SB_VERSION_UPGRADE_COMPLETE(c->disk_sb.sb, bcachefs_metadata_ve=
rsion_current);
> > bch2_write_super(c);
> > }
> > +
> > + for_each_member_device(c, ca) {
> > + m =3D bch2_members_v2_get_mut(c->disk_sb.sb, ca->dev_idx);
> > + SET_BCH_MEMBER_FREESPACE_INITIALIZED(m, false);
> > + ca->mi =3D bch2_mi_to_cpu(m);
> > + }
> > +
>=20
>=20
> I'm also adding a write_super() call here: that's what updates
> ca->mi.freespace_initialized which the freespace init path will later
>=20
> check.

Do you want me to send v4? Or you will add it with separate patch?

Best regards, Piotr Zalewski

> > mutex_unlock(&c->sb_lock);
> >=20
> > c->curr_recovery_pass =3D BCH_RECOVERY_PASS_NR;
> > --
> > 2.47.0

