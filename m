Return-Path: <linux-kernel+bounces-335176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1531D97E241
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 17:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9AF8B20E81
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 15:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AC7C2E3;
	Sun, 22 Sep 2024 15:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="QqX3Y5mI"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03E3BE68
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 15:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727018294; cv=none; b=cAeOcvchsxFwhX1BhGVJ+WoOL7d0c9kNTg/AfkjP8tUq76O2CK3QIph718r+BNsNIsF9I/qBKbIQtahS/NsjVPaLB93W2Se/l8FWkHNMwWN/KP/YV3VnNM8VjeAiBq9ij33UEch7OlyTp6BgpfMa+zW5uMFMWTjsdMsp3e/EBL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727018294; c=relaxed/simple;
	bh=o0PCcxHd82z4EJ9oGJMyN1wlnE2UuTApJQqxJ3pdQKI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Y1zQDor077MRdjRIic7otO6k/NiA8oqSAI/JiZ5eXSejzTbnC2hlckUji+Vk11RjGS5giFbmLn7YTRdQP4AS35v764xn22dHTpW4VlPOQWS1ZgCx0wZV87kRRoMKet0lfl3ul7SwdjZq9D25pqEnw3n/qBQMLhA53lrdaR+xaIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=QqX3Y5mI; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1727018284; x=1727277484;
	bh=sBZ5bv5Sk1lAmqEu/dz72AECosQNyacTBI4VFrqpdGc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=QqX3Y5mI6ecSBfeaAGaXq0aMaWviwdsMQr7OapyLbOnczRQzyX6fH6VzjQhoSi6ur
	 o8UbwJOQfH3Jj/IjfFfKgrVFBPeFbocl6Sv1r7CfSaeuvfBelU7aEf+ulnc5K0F/8P
	 adXw9hK+7RQBu+FKOgUyK+SVPQg11t/aK+vixLhbQheAeM5fLYf7EaTZ2KTXlBkEJP
	 1JhuHz3tA38nRm0701MDMxs+hWWrEMQ43fstsHm1bhLnj4pkaBmu2rG0y6flS/vbW1
	 5PMnyOerDavXBQ+9TA8PNl/efS2LTTWaa+N+RDpjvEWIi+xJabmUINS1kMiXuKQpMb
	 vcdDq5t6Ke8JQ==
Date: Sun, 22 Sep 2024 15:18:01 +0000
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
From: Piotr Zalewski <pZ010001011111@proton.me>
Cc: skhan@linuxfoundation.org, Piotr Zalewski <pZ010001011111@proton.me>, syzbot+6f655a60d3244d0c6718@syzkaller.appspotmail.com
Subject: [PATCH v2] bcachefs: memset bounce buffer portion to 0 after key_sort_fix_overlapping
Message-ID: <20240922151618.737458-2-pZ010001011111@proton.me>
Feedback-ID: 53478694:user:proton
X-Pm-Message-ID: cffce745d57c7a4e63db1d1f825e76f04c99ff52
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Zero-initialize part of allocated bounce buffer which wasn't touched by
subsequent bch2_key_sort_fix_overlapping to mitigate later uinit-value
use KMSAN bug[1].

After applying the patch reproducer still triggers stack overflow[2] but
it seems unrelated to the uninit-value use warning. After further
investigation it was found that stack overflow occurs because KMSAN adds
too many function calls[3]. Backtrace of where the stack magic number gets
smashed was added as a reply to syzkaller thread[3].

It was confirmed that task's stack magic number gets smashed after the code
path where KSMAN detects uninit-value use is executed, so it can be assumed
that it doesn't contribute in any way to uninit-value use detection.

[1] https://syzkaller.appspot.com/bug?extid=3D6f655a60d3244d0c6718
[2] https://lore.kernel.org/lkml/66e57e46.050a0220.115905.0002.GAE@google.c=
om
[3] https://lore.kernel.org/all/rVaWgPULej8K7HqMPNIu8kVNyXNjjCiTB-QBtItLFBm=
k0alH6fV2tk4joVPk97Evnuv4ZRDd8HB5uDCkiFG6u81xKdzDj-KrtIMJSlF6Kt8=3D@proton.=
me

Reported-by: syzbot+6f655a60d3244d0c6718@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3D6f655a60d3244d0c6718
Fixes: ec4edd7b9d20 ("bcachefs: Prep work for variable size btree node buff=
ers")
Suggested-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Piotr Zalewski <pZ010001011111@proton.me>
---

Notes:
    changes in v2:
        - instead of adding __GFP_ZERO flag to bounce buffer alloc,
          zero initialize only the part untouched by subsequent
          bch2_key_sort_fix_overlapping to make the solution more
=09=09  performant

    link to v1: https://lore.kernel.org/linux-bcachefs/20240916224746.69297=
3-1-pZ010001011111@proton.me/

---
 fs/bcachefs/btree_io.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/bcachefs/btree_io.c b/fs/bcachefs/btree_io.c
index cb48a9477514..2a0420605bd7 100644
--- a/fs/bcachefs/btree_io.c
+++ b/fs/bcachefs/btree_io.c
@@ -1195,6 +1195,10 @@ int bch2_btree_node_read_done(struct bch_fs *c, stru=
ct bch_dev *ca,
 =09set_btree_bset(b, b->set, &b->data->keys);
=20
 =09b->nr =3D bch2_key_sort_fix_overlapping(c, &sorted->keys, iter);
+=09memset((uint8_t *)(sorted + 1) + b->nr.live_u64s * sizeof(u64), 0,
+=09=09=09btree_buf_bytes(b) -
+=09=09=09sizeof(struct btree_node) -
+=09=09=09b->nr.live_u64s * sizeof(u64));
=20
 =09u64s =3D le16_to_cpu(sorted->keys.u64s);
 =09*sorted =3D *b->data;
--=20
2.46.0



