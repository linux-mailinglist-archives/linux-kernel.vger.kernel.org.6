Return-Path: <linux-kernel+bounces-355299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8454899502F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B8F0B26ADB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADED1DF24B;
	Tue,  8 Oct 2024 13:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1LmxDvwl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I/OhDTFN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22998190055
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 13:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728394437; cv=none; b=B9JjOAPt/i3DhHLSDlu97L+1ERmTUWLM+NIxSjxQ0oaKccs765XsIoExCv6yrTbr50DWbXDtwlQDWVVjmCo1LyuTR+xusOEuDkETh1r+B5hLN162CCS6hzw8qNGQPdGb15Z1ruPlYAdKj1hfnZUkjYkMljcQmohDnJVz4kJmzgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728394437; c=relaxed/simple;
	bh=NEQfk9yB9JG+PD/NGEoPH3I1T+oFiFFHTcldxCwl+6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jHvQ4y/eaJPWlYh0MO4zjybl+Tg1czwAcd7Ia1rTKUPe7MkQuTbEsk//XY1xi1SXpfneDElE4Yi/dr8tp64VZ2fZ26egGCaFTsyPug4iZvbnR1mBCytMwmXtZxCztK/q3drjaJDLgGErVNLhom9JmWKjcvY75vZqEcRfW3+w0sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1LmxDvwl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I/OhDTFN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Benedikt Spranger <b.spranger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728394434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6BgLtv//7VX3/T9mPQLCPe+CkxNyewsbkBQ2mYybJu8=;
	b=1LmxDvwlGEaHrglEMqiy/Y+W+vkoe4YCxWUPOYo0ol1UUeaCLF1tanFOaD217w9Fe3lRhz
	BAXsftwMwTj9TYGXl6R8tphZ4W1q7Y1UxM3vrJJc2vqZ3GkWYNadnsmOM1TlpykoigDuIM
	ARYhtoWWgmbrn9JN9t4PFSyAauSBUxXGEOpTiC+hRYh6bfU0lR3P+yZv0+Pkb7GmAr3Fln
	Lby/Lb3rX06FcIUxprm3cclsNFx0myH0SZtY3QO24rTMQklmXcchhwdBNj/VN+Lfx6YTIo
	bN7HF5huiSx3+455Vx79kZ903UopPnaRaPws4qrmj6/7dj3Xbx839zenMx2eeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728394434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6BgLtv//7VX3/T9mPQLCPe+CkxNyewsbkBQ2mYybJu8=;
	b=I/OhDTFNa1iQHtYFc6aVIAO1IykJefsblpB+gKkt6bwiVdL+AxNU57llKL8d8lzbPclcDD
	n4Qnx0jtDCIuHoAg==
To: linux-kernel@vger.kernel.org
Cc: linux-mtd@lists.infradead.org,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/1] ubifs: Try to recover from missing znode
Date: Tue,  8 Oct 2024 15:33:42 +0200
Message-Id: <20241008133342.1937674-1-b.spranger@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After powercut on a system using ubifs mounting failed:

2024-09-30T12:38:26.880487+02:00 sonja kernel: UBIFS error (ubi0:0 pid 2178): ubifs_read_node [ubifs]: bad node type (255 but expected 9)
2024-09-30T12:38:26.880506+02:00 sonja kernel: UBIFS error (ubi0:0 pid 2178): ubifs_read_node [ubifs]: bad node at LEB 103:46920, LEB mapping status 0
2024-09-30T12:38:26.880509+02:00 sonja kernel: Not a node, first 24 bytes:
2024-09-30T12:38:26.880510+02:00 sonja kernel: 00000000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff                          ........................

While traversing over zbranches during the journal replay one zbranch
points to a znode, which was not written to the flash and therefore the
flash is empty.

Try to recover from that by inserting an empty znode instead of failing.

Signed-off-by: Benedikt Spranger <b.spranger@linutronix.de>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
---
 fs/ubifs/io.c       | 16 ++++++++++++++++
 fs/ubifs/tnc_misc.c |  6 +++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/fs/ubifs/io.c b/fs/ubifs/io.c
index 01d8eb170382..0bbb426f9006 100644
--- a/fs/ubifs/io.c
+++ b/fs/ubifs/io.c
@@ -1110,6 +1110,22 @@ int ubifs_read_node(const struct ubifs_info *c, void *buf, int type, int len,
 		return err;
 
 	if (type != ch->node_type) {
+		/*
+		 * While recovering, we may face lost data i.e. empty flash.
+		 * Give callsites a hint by returning -ENODATA.
+		 */
+		if (c->replaying) {
+			u8 *b = buf;
+
+			for (l = 0; l < len; l++) {
+				if (b[l] != 0xff)
+					break;
+			}
+			if (l == len) {
+				ubifs_errc(c, "no node, but empty flash");
+				return -ENODATA;
+			}
+		}
 		ubifs_errc(c, "bad node type (%d but expected %d)",
 			   ch->node_type, type);
 		goto out;
diff --git a/fs/ubifs/tnc_misc.c b/fs/ubifs/tnc_misc.c
index d3f8a6aa1f49..4d085fc1300f 100644
--- a/fs/ubifs/tnc_misc.c
+++ b/fs/ubifs/tnc_misc.c
@@ -300,7 +300,11 @@ static int read_znode(struct ubifs_info *c, struct ubifs_zbranch *zzbr,
 	err = ubifs_read_node(c, idx, UBIFS_IDX_NODE, len, lnum, offs);
 	if (err < 0) {
 		kfree(idx);
-		return err;
+		/*
+		 * While recovering we may face a non written znode.
+		 * Inject an empty znode in this case.
+		 */
+		return (err == -ENODATA) ? 0 : err;
 	}
 
 	err = ubifs_node_check_hash(c, idx, zzbr->hash);
-- 
2.39.5


