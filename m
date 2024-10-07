Return-Path: <linux-kernel+bounces-354168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4025B99389C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 22:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717061C23310
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 20:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEA918B491;
	Mon,  7 Oct 2024 20:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="T352ba2h"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D5C81727
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 20:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728334561; cv=none; b=DHCxV0rKPoBi71fWvKXhyImatwxNHpbDnZoYmZ4uToT/17PS8f/ZkL03rJ8G+Y3jK6M3gcKq8YHhtfKlymID/DoG6JCStZ6fXOcG4TAhlwosNV4o1aTCltTBwmIqI9qMuW8Cspk7wSAqEaniV68I36ozjQORNF5mbFPJBqZfOGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728334561; c=relaxed/simple;
	bh=UHPb3s0aO8AlvsA8FlkpPnp/+BstHy9v1B+zYtBQuO0=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=pPrqdB+969qdWwfhLs5SjPrldRAb5udKpICE/qSTkZp1Hi/VXcnPvnLxHjO3w/bc3FnsO71JBDUGrJI4HMyW1VBoLLAUxCvzgvFMsnA9rUlbqjPWY8kS5cg65Y11fy2ubr4Kxb4/OuCy2g5RQfJ8keb+8/tW9vqQXmUy+wY87JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=T352ba2h; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1728334551; x=1728593751;
	bh=UHPb3s0aO8AlvsA8FlkpPnp/+BstHy9v1B+zYtBQuO0=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=T352ba2hlQh6f0u3ry+uY/ZuzT6syWPNy/1CTRzTBpMBun7oi+9jj37SaQ7O61LWd
	 eeHL1MYvNOiQ1ttWe0J/ZSAqYavdotW8M4n8MIC6QbCAxbgaRM5J+d9aQfwP0KzEKe
	 h7WxrAhwJisJQ19ekqYRysfUpeUMhK9e2/t0jDsj5IuTNXrOUCx85Y+XQLAUhOsMid
	 bfSHB5mKJlF5oRHzyQzST8/JGFTuk+MW/kiQNTN+xm0vPiQMUdi0ZQW4EbXg7jBZZp
	 rx4gvDu6gNeYmaDixk7Dr7uvRI05lA0ToOenAuE7AYFNykFfYOAEWCW9wZwmwKiwFR
	 f8JCLEwzwRVhQ==
Date: Mon, 07 Oct 2024 20:55:49 +0000
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
From: Piotr Zalewski <pZ010001011111@proton.me>
Cc: skhan@linuxfoundation.org, Piotr Zalewski <pZ010001011111@proton.me>, syzbot+4d24267b490e2b68a5fa@syzkaller.appspotmail.com
Subject: [PATCH v1] bcachefs: use mutex_trylock in bch2_replicas_entry_validate
Message-ID: <20241007205430.492090-3-pZ010001011111@proton.me>
Feedback-ID: 53478694:user:proton
X-Pm-Message-ID: 20c7915fb4820f21b71d2d7da571445dcd2b1d9b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Use mutex_trylock instead of mutex_lock in bch2_replicas_entry_validate to
prevent potential deadlock[1].

[1] https://syzkaller.appspot.com/bug?extid=3D4d24267b490e2b68a5fa

Reported-by: syzbot+4d24267b490e2b68a5fa@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3D4d24267b490e2b68a5fa
Fixes: 49fd90b2cc33 ("bcachefs: Fix unlocked access to c->disk_sb.sb in bch=
2_replicas_entry_validate()")
Signed-off-by: Piotr Zalewski <pZ010001011111@proton.me>
---
 fs/bcachefs/replicas.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/bcachefs/replicas.c b/fs/bcachefs/replicas.c
index bcb3276747e0..d301832c5a1b 100644
--- a/fs/bcachefs/replicas.c
+++ b/fs/bcachefs/replicas.c
@@ -98,9 +98,10 @@ int bch2_replicas_entry_validate(struct bch_replicas_ent=
ry_v1 *r,
 =09=09=09=09 struct bch_fs *c,
 =09=09=09=09 struct printbuf *err)
 {
-=09mutex_lock(&c->sb_lock);
+=09int acquired =3D mutex_trylock(&c->sb_lock);
 =09int ret =3D bch2_replicas_entry_validate_locked(r, c->disk_sb.sb, err);
-=09mutex_unlock(&c->sb_lock);
+=09if (acquired)
+=09=09mutex_unlock(&c->sb_lock);
 =09return ret;
 }
=20
--=20
2.46.2



