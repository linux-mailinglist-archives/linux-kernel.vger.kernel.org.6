Return-Path: <linux-kernel+bounces-383330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BB49B1A24
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 19:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B90DF282A54
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 17:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8711D0BAE;
	Sat, 26 Oct 2024 17:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="jHtLJdbU"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF2214A91
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 17:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729964804; cv=none; b=PWbmDCSS1E79pOnXbrBcrL9a3E5A73AdPlC/7cbS81FDCZlIHJ/DfNe5Ys2op7DIyd1E/w8VpgQca3DuM3c9t+38fgEZ4Ml79p1ZTbGvnvcfHxm6/r+7dh2f8FIWh7NuRXgxS4IT8mxTe/SzfoYDhfukawecigbWAtpfsj3Y7MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729964804; c=relaxed/simple;
	bh=iK2ETm0wcmmrbAj8oW9oXQLntNSb0wUcwLYcXgB2wUk=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=EkasDhVzS1w8UhSecx4KCOhQFqCC143OnYSpVd7nDbkayK1tDHaCCU3gtE7f60XLLRJOyrAiMYdG+Z7bOZXW80M6AjCEjNtM5NVrMNa6wmqO3HcD5Zr45lzsBEYZp5/i5686BuJyeMszd5PRCHFWLn1gUXXErEUlNcMtVOdu4rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=jHtLJdbU; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1729964800; x=1730224000;
	bh=tuQGb8EqIUx378UeCmNYLD8fdTFIKGwhhmJKBCspH2Y=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=jHtLJdbUDhNhbIr561dZPJHTluZl4ltVJRW7dj3SLqz4Fwi5cEEegbsmiOkswuzAV
	 psew9W7S7zGw/0CYhkm8uenkqQH+2kVedZW9TzeH+Bwg1NYVXHepRi8eAD9D+X+7if
	 p+orZf1ZlZPuSqLztB+3Ya616wNSJk7OyJXSfvFjC8bWYh/EbtiU9dQ4DCn0LNpOOY
	 xgXPX+pvAYMZ9of0ts/FzeZrH+U5JJwP9SugSJ+iet1sEJCX3/ANBu9sw7fSg+TUt1
	 D+GqHCxTWAWGBJy+w1dT8gVzn5Jxq3PP7f5AarvDvAmj2Bn3IVz5Ti4/dbADinaR0T
	 10BojcRuVGt6Q==
Date: Sat, 26 Oct 2024 17:46:33 +0000
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
From: Piotr Zalewski <pZ010001011111@proton.me>
Cc: skhan@linuxfoundation.org, Piotr Zalewski <pZ010001011111@proton.me>, syzbot+005ef9aa519f30d97657@syzkaller.appspotmail.com, Alan Huang <mmpgouride@gmail.com>
Subject: [PATCH v2] bcachefs: Fix NULL ptr dereference in btree_node_iter_and_journal_peek
Message-ID: <20241026174155.233430-3-pZ010001011111@proton.me>
Feedback-ID: 53478694:user:proton
X-Pm-Message-ID: 43d449c52e690306e9d7c82fde7a628aa1b10356
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add NULL check for key returned from bch2_btree_and_journal_iter_peek in
btree_node_iter_and_journal_peek to avoid NULL ptr dereference in
bch2_bkey_buf_reassemble.

When key returned from bch2_btree_and_journal_iter_peek is NULL it means
that btree topology needs repair. Print error message with position at
which node wasn't found and its parent node information. Call
bch2_topology_error and return error code returned by it to ensure that
topology error is handled properly.

Reported-by: syzbot+005ef9aa519f30d97657@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3D005ef9aa519f30d97657
Fixes: 5222a4607cd8 ("bcachefs: BTREE_ITER_WITH_JOURNAL")
Suggested-by: Alan Huang <mmpgouride@gmail.com>
Suggested-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Piotr Zalewski <pZ010001011111@proton.me>
---

Notes:
    changes in v2:
        - make commit message more verbose.
        - set topology error, print error message and return
          appropriate error code.

    link to v1: https://lore.kernel.org/linux-bcachefs/20241023072024.98915=
-3-pZ010001011111@proton.me/

 fs/bcachefs/btree_iter.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/bcachefs/btree_iter.c b/fs/bcachefs/btree_iter.c
index 15ac72b1af51..40c824779b15 100644
--- a/fs/bcachefs/btree_iter.c
+++ b/fs/bcachefs/btree_iter.c
@@ -880,6 +880,18 @@ static noinline int btree_node_iter_and_journal_peek(s=
truct btree_trans *trans,
 =09__bch2_btree_and_journal_iter_init_node_iter(trans, &jiter, l->b, l->it=
er, path->pos);
=20
 =09k =3D bch2_btree_and_journal_iter_peek(&jiter);
+=09if (!k.k) {
+=09=09struct printbuf buf =3D PRINTBUF;
+
+=09=09prt_str(&buf, "node not found at pos ");
+=09=09bch2_bpos_to_text(&buf, path->pos);
+=09=09prt_str(&buf, " within parent node ");
+=09=09bch2_bkey_val_to_text(&buf, c, bkey_i_to_s_c(&l->b->key));
+
+=09=09ret =3D bch2_fs_topology_error(c, "%s", buf.buf);
+=09=09printbuf_exit(&buf);
+=09=09goto err;
+=09}
=20
 =09bch2_bkey_buf_reassemble(out, c, k);
=20
@@ -887,6 +899,7 @@ static noinline int btree_node_iter_and_journal_peek(st=
ruct btree_trans *trans,
 =09    c->opts.btree_node_prefetch)
 =09=09ret =3D btree_path_prefetch_j(trans, path, &jiter);
=20
+err:
 =09bch2_btree_and_journal_iter_exit(&jiter);
 =09return ret;
 }
--=20
2.47.0



