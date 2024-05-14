Return-Path: <linux-kernel+bounces-178542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5778C4F39
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 12:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766A028224F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 10:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545B413D60E;
	Tue, 14 May 2024 10:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mMOcalef"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940B213AA4E
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 10:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681203; cv=none; b=gS8kXNsl89LiiujVfwnI/lvWr7pRi0ScR1Auq8kLtsRzzwpYu/aSVT+gqmbltuvou1oOyrV+Jftslps6R6FZD39Pzyoe1YmEtfMk5773VdtxkRtYs57aAXHT5X5c2pSoWgl0tAGMXWoNHcrQTBYix+lI+4qH5FBKgghOAZ12ac8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681203; c=relaxed/simple;
	bh=ZZGB3QQLbx9thwXnWrDjUTHhrcBF4DS6mic9U+ZCYqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DUmxtXmXlTlahIz8tGQP5ekIs3Zx4nyB9AfiLFAWIhYMgZjlmmmhjYn6cdZAfXZENqpiZC6LccPa2cbdW5xM5vCZJcSumKiAPpAuKt6W3d7vKOmfuKys+rWiSCDwWuIP/LV2OMN9/Wzm0Gi8A7VrGUGhz2NesVNVwo4fKyK21WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mMOcalef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C607C2BD10;
	Tue, 14 May 2024 10:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715681203;
	bh=ZZGB3QQLbx9thwXnWrDjUTHhrcBF4DS6mic9U+ZCYqk=;
	h=From:To:Cc:Subject:Date:From;
	b=mMOcalef94Gh7a4egYXlueneWoXw30OU3pbBDxR3l8zG7ZbOpnl8fcldb62LJLynq
	 YhMYcB6MpyGOdBELmjE1IOpVb8hUgk9JyeOcvI4VldNR3q7HWx+jJK1uVmOAb+Cbzv
	 7275LoXGYGtdfnc0x9NNM0anf28AjFyyUjnWerr0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: jfs-discussion@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	syzbot+9dfe490c8176301c1d06@syzkaller.appspotmail.com,
	Dave Kleikamp <shaggy@kernel.org>
Subject: [PATCH] jfs: xattr: fix buffer overflow for invalid xattr
Date: Tue, 14 May 2024 12:06:34 +0200
Message-ID: <2024051433-slider-cloning-98f9@gregkh>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 34
X-Developer-Signature: v=1; a=openpgp-sha256; l=1239; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=ZZGB3QQLbx9thwXnWrDjUTHhrcBF4DS6mic9U+ZCYqk=; b=owGbwMvMwCRo6H6F97bub03G02pJDGnO5qv+b1nnWaSilLdEzibVtaXv8oadskYB7Qu7DRaG3 fGu5t/UEcvCIMjEICumyPJlG8/R/RWHFL0MbU/DzGFlAhnCwMUpABP5f4hhNrvzNc2T0jbeNbJv vpZpn7rxaeG72wwLdhQ2sfvOuvJ2L/dlsbrGm7/E79b3AwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

When an xattr size is not what is expected, it is printed out to the
kernel log in hex format as a form of debugging.  But when that xattr
size is bigger than the expected size, printing it out can cause an
access off the end of the buffer.

Fix this all up by properly restricting the size of the debug hex dump
in the kernel log.

Reported-by: syzbot+9dfe490c8176301c1d06@syzkaller.appspotmail.com
Cc: Dave Kleikamp <shaggy@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/jfs/xattr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/jfs/xattr.c b/fs/jfs/xattr.c
index 0fb7afac298e..9987055293b3 100644
--- a/fs/jfs/xattr.c
+++ b/fs/jfs/xattr.c
@@ -557,9 +557,11 @@ static int ea_get(struct inode *inode, struct ea_buffer *ea_buf, int min_size)
 
       size_check:
 	if (EALIST_SIZE(ea_buf->xattr) != ea_size) {
+		int size = min_t(int, EALIST_SIZE(ea_buf->xattr), ea_size);
+
 		printk(KERN_ERR "ea_get: invalid extended attribute\n");
 		print_hex_dump(KERN_ERR, "", DUMP_PREFIX_ADDRESS, 16, 1,
-				     ea_buf->xattr, ea_size, 1);
+				     ea_buf->xattr, size, 1);
 		ea_release(inode, ea_buf);
 		rc = -EIO;
 		goto clean_up;
-- 
2.45.0


