Return-Path: <linux-kernel+bounces-243538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 474CC92975E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 12:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0145E28187E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 10:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA5C1865A;
	Sun,  7 Jul 2024 10:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="ZCdogprd"
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B821CD11
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 10:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720346992; cv=none; b=rs4E0Q+FAdAVcWQE07pbrfipbCHU7VO3I0NO0CdjH9WNxWo5Q903CA4O14UscW53odjWZrCXcN7e0QCeokVAjaC6g3q95CQW6txlZOyiXjdNTHRyuURmIo0RiDjXQSYyvEYYzhA1i1ITMoOALhy2/DruO4KHXSxg4NZzVuly/YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720346992; c=relaxed/simple;
	bh=SrwtoTTtJK7sTcD84hR0btp+/fBzrTU34WTiXFVFALc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oMmCZmkFSu5Vi3xWMBsyC2MdtGSdwYoitxOoCEsEvsCaFNIEXC2OVGobDmYtExlW2L/RjNNyVE+SWiUpMe71slERMd6yjxvEOPiQhXofYLq/0DK8hWsbzVGp0M3vudXmHsk7hNrAgsYR/zpTGu5GDlj0mpwkpRaxssECw2e0o2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=ZCdogprd; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 10092 invoked from network); 7 Jul 2024 11:43:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1720345387; bh=CVIbqEHK9s+AkubKdyBU6i0P/CUzIgLv+yRoav3XzW4=;
          h=From:To:Subject;
          b=ZCdogprdvtndoWuA5YoiHsc64bHbIHIhtkzq0tFMAvxJMAI5kJy9ZXLzd85pJUqVR
           TTA0o7A+sHKeJ8J032QJRJMquh87jhugLxzS8QnIOJn88xsLXxW/OyDmnGF6iv4OER
           hcJOVeGNF+DWvxEDctureWWXXHNeeUxKDWSNj7g8=
Received: from 83.5.245.171.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.5.245.171])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <ms@dev.tdt.de>; 7 Jul 2024 11:43:07 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: ms@dev.tdt.de,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	linus.walleij@linaro.org,
	nico@fluxnic.net,
	olek2@wp.pl,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/1] mtd: cfi_cmdset_0001: Disable write buffer functions if FORCE_WORD_WRITE is 1
Date: Sun,  7 Jul 2024 11:43:02 +0200
Message-Id: <20240707094302.784948-2-olek2@wp.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240707094302.784948-1-olek2@wp.pl>
References: <20240707094302.784948-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: 9b284323245603c8a33756b45b75f870
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [UdNQ]                               

Some write buffer functions are not used when FORCE_WORD_WRITE is set to 1.
So the compile warning messages are output if FORCE_WORD_WRITE is 1. To
resolve this disable the write buffer functions if FORCE_WORD_WRITE is 1.

This is similar fix to: 557c759036fc3976a5358cef23e65a263853b93f.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 drivers/mtd/chips/cfi_cmdset_0001.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/chips/cfi_cmdset_0001.c b/drivers/mtd/chips/cfi_cmdset_0001.c
index c10693ba265b..5404637e54e2 100644
--- a/drivers/mtd/chips/cfi_cmdset_0001.c
+++ b/drivers/mtd/chips/cfi_cmdset_0001.c
@@ -62,8 +62,10 @@
 
 static int cfi_intelext_read (struct mtd_info *, loff_t, size_t, size_t *, u_char *);
 static int cfi_intelext_write_words(struct mtd_info *, loff_t, size_t, size_t *, const u_char *);
+#if !FORCE_WORD_WRITE
 static int cfi_intelext_write_buffers(struct mtd_info *, loff_t, size_t, size_t *, const u_char *);
 static int cfi_intelext_writev(struct mtd_info *, const struct kvec *, unsigned long, loff_t, size_t *);
+#endif
 static int cfi_intelext_erase_varsize(struct mtd_info *, struct erase_info *);
 static void cfi_intelext_sync (struct mtd_info *);
 static int cfi_intelext_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len);
@@ -305,6 +307,7 @@ static void fixup_use_point(struct mtd_info *mtd)
 	}
 }
 
+#if !FORCE_WORD_WRITE
 static void fixup_use_write_buffers(struct mtd_info *mtd)
 {
 	struct map_info *map = mtd->priv;
@@ -315,6 +318,7 @@ static void fixup_use_write_buffers(struct mtd_info *mtd)
 		mtd->_writev = cfi_intelext_writev;
 	}
 }
+#endif /* !FORCE_WORD_WRITE */
 
 /*
  * Some chips power-up with all sectors locked by default.
@@ -1720,6 +1724,7 @@ static int cfi_intelext_write_words (struct mtd_info *mtd, loff_t to , size_t le
 }
 
 
+#if !FORCE_WORD_WRITE
 static int __xipram do_write_buffer(struct map_info *map, struct flchip *chip,
 				    unsigned long adr, const struct kvec **pvec,
 				    unsigned long *pvec_seek, int len)
@@ -1948,6 +1953,7 @@ static int cfi_intelext_write_buffers (struct mtd_info *mtd, loff_t to,
 
 	return cfi_intelext_writev(mtd, &vec, 1, to, retlen);
 }
+#endif /* !FORCE_WORD_WRITE */
 
 static int __xipram do_erase_oneblock(struct map_info *map, struct flchip *chip,
 				      unsigned long adr, int len, void *thunk)
-- 
2.39.2


