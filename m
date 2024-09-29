Return-Path: <linux-kernel+bounces-343016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 443319895F4
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 16:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7558A1C2094A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 14:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B36517ADE8;
	Sun, 29 Sep 2024 14:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="JRENhPLi"
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D0B16A943
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 14:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727620021; cv=none; b=Ouv9sZIe4LfidioKTtxuMb9D0gmwNe7qtXgyz88vdZaRrRiFQhKUTOOvBOjOM4ALlhN0YoFCTdLxG/oDOo2LvydksROhYxTRVO+fIDemeFUl2P0rRr6R5ROJRnbvE+iKr12RzMMC8eQlutt9HH7gquWoOYUIUUqjc4lKvCIrnsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727620021; c=relaxed/simple;
	bh=g8a7s1gzHLOaSdNudAfUG58AcGoPlXc1ruh3Hjdn8cc=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=kA1Pxiv0o1lXM5HBfzJMHBUQ7Q5uAvGmhkKNY5TTmY5j5kQ4MJFdeikYumUqXlUb9lVOwd6vqzQJ7vV8JTe+o9RopfgF3f7BwEaD12acQ9tntzdx+KR2OOlb1f/4CEp/nhoJcask/hgTLc0FDHidU+pXMPjtoMg/Q80yPgSlAaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=JRENhPLi; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=7n54obalj5ak7fhlgq47zg2n4e.protonmail; t=1727620009; x=1727879209;
	bh=g8a7s1gzHLOaSdNudAfUG58AcGoPlXc1ruh3Hjdn8cc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=JRENhPLiutgdNUjgKEGjEJO/lPFhRWz4vgDfQpMM0yNsi+qbJ1BEoB8zA7WaVaBeI
	 VgDKdG6ZPVIpsEA8ljRpWW/YNoJjeC0PlhjwXHcdlenXuO6qadwlrQQCBJox8Ka4y8
	 ZzNw7MAy1AEVUQAck+dAfUEnHRCO13Agrwrcdjv/gf9RsadXr/dpRwMn0cyG0JphtR
	 mYbBDHA8Y2ahBmmuztoHc+xKxmWGozWPQabPkzPWz5t8xujvlQ9a97O2vQlsOaUUK3
	 OjIr2eb3rCNSboitmjrT80Vfh9IQHzvoIPLzs3CFOETNoXwmf1yzpqEx9jiS+zKHBs
	 TNlPjhWTUjAbQ==
Date: Sun, 29 Sep 2024 14:26:45 +0000
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
From: Piotr Zalewski <pZ010001011111@proton.me>
Cc: skhan@linuxfoundation.org, Piotr Zalewski <pZ010001011111@proton.me>, syzbot+cf7b2215b5d70600ec00@syzkaller.appspotmail.com
Subject: [PATCH v1] bcachefs: add check for btree id against max in try read node
Message-ID: <20240929142348.4028284-2-pZ010001011111@proton.me>
Feedback-ID: 53478694:user:proton
X-Pm-Message-ID: f1d406aacf54818805e4e1b2e500a61fe82d9504
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add check for read node's btree_id against BTREE_ID_NR_MAX in
try_read_btree_node to prevent triggering EBUG_ON condition in
bch2_btree_id_root[1].

[1] https://syzkaller.appspot.com/bug?extid=3Dcf7b2215b5d70600ec00

Reported-by: syzbot+cf7b2215b5d70600ec00@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3Dcf7b2215b5d70600ec00
Fixes: 4409b8081d16 ("bcachefs: Repair pass for scanning for btree nodes")
Signed-off-by: Piotr Zalewski <pZ010001011111@proton.me>
---
 fs/bcachefs/btree_node_scan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/bcachefs/btree_node_scan.c b/fs/bcachefs/btree_node_scan.c
index b28c649c6838..a24b4004e8f0 100644
--- a/fs/bcachefs/btree_node_scan.c
+++ b/fs/bcachefs/btree_node_scan.c
@@ -171,6 +171,9 @@ static void try_read_btree_node(struct find_btree_nodes=
 *f, struct bch_dev *ca,
 =09if (BTREE_NODE_LEVEL(bn) >=3D BTREE_MAX_DEPTH)
 =09=09return;
=20
+=09if (BTREE_NODE_ID(bn) >=3D BTREE_ID_NR_MAX)
+=09=09return;
+
 =09rcu_read_lock();
 =09struct found_btree_node n =3D {
 =09=09.btree_id=09=3D BTREE_NODE_ID(bn),
--=20
2.46.2



