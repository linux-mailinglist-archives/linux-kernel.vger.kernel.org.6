Return-Path: <linux-kernel+bounces-556368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2F5A5C4DA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B66E3B399C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82AC25EFB3;
	Tue, 11 Mar 2025 15:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="JvwAxaH+"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74F425E808
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 15:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705583; cv=none; b=rCrIedBSYrdLe5HJ2phEinemL+v6fUdq5wgQzvXnGYA2uUaXJ/g1PlrE9gFx3iZQpIf9kSFJ4vX10PbdfGzvUkGPlcPu9zhCqkC6IoUs2/gdNQPMCFmbYm7PPOyAECzAfpk1IiNW/4WdDKHUu3ErWY/n+B3ZvDBQeuPmZlK9jCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705583; c=relaxed/simple;
	bh=x55CRst2EELB6Twy47K84CTION8NSXOLyNJziGCLwg4=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=l00mGd8fB9l5J+DLzYoqAUBReENb+nwfn9rs5eancZlOI7GPWwiDtaHeP7/nl5aaJ1eqiwK+nDI2PMxWxumW9evoYL9anRvOsMmOv7jIZPBvLTFRHulwVA2iR34s2IGEjcW7/xpLSkqzTPADBfqR67kEgyJ0ryp+DP4z0RohqSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=JvwAxaH+; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1741705573; x=1741964773;
	bh=x55CRst2EELB6Twy47K84CTION8NSXOLyNJziGCLwg4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=JvwAxaH+lZBCg9JPca0w0osp4GnAEKSG416BhB3OIdgEPv1yi+4ry8/4NimjKw39B
	 WXqZiTiu6XEHEMsD/FGnEIUBCtthPn4LT4FQMY9u+S2d0TBC508+sQ1U207axvJaOM
	 ysxcuWb1FMs3C+iSmHk+byTxWGCYErPImXjsR2aQZHgsEw/rEj6cLorhahEiERb1Su
	 g/qweuFXdJR0SE4HvAaiAXx+WtZHRKt02qGIREhyh2ekW+ZBfXK5Rn6L4CnjnZUr3h
	 OOAiYvfwXECs/KMsRW3rxfz11l47/NYc0Bz5tMLh/IMsa1l7qU2SrLDTdq2fWCzhhm
	 9XcRC+oTUPKKA==
Date: Tue, 11 Mar 2025 15:06:10 +0000
To: syzbot+c17ad4b4367b72a853cb@syzkaller.appspotmail.com
From: Roxana Nicolescu <nicolescu.roxana@protonmail.com>
Cc: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] bcachefs: Initialize from_inode members for bhc_io_opts
Message-ID: <20250311150606.127577-1-nicolescu.roxana@protonmail.com>
Feedback-ID: 136600343:user:proton
X-Pm-Message-ID: 94f2d0f51b63559c1248d2c4379aab0ba1857824
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

When there is no inode source, all "from_inode" members in the structure
bhc_io_opts should be set false.

Fixes: 7a7c43a0c1ecf ("bcachefs: Add bch_io_opts fields for indicating whet=
her the opts came from the inode")
Reported-by: syzbot+c17ad4b4367b72a853cb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3Dc17ad4b4367b72a853cb
Signed-off-by: Roxana Nicolescu <nicolescu.roxana@protonmail.com>
---
 fs/bcachefs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/bcachefs/inode.c b/fs/bcachefs/inode.c
index 04ec05206f8c..339b80770f1d 100644
--- a/fs/bcachefs/inode.c
+++ b/fs/bcachefs/inode.c
@@ -1198,6 +1198,7 @@ void bch2_inode_opts_get(struct bch_io_opts *opts, st=
ruct bch_fs *c,
 =09=09opts->_name##_from_inode =3D true;=09=09=09\
 =09} else {=09=09=09=09=09=09=09\
 =09=09opts->_name =3D c->opts._name;=09=09=09=09\
+=09=09opts->_name##_from_inode =3D false;=09=09=09\
 =09}
 =09BCH_INODE_OPTS()
 #undef x
--=20
2.34.1



