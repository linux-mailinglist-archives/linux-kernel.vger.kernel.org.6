Return-Path: <linux-kernel+bounces-257770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28974937EC3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 04:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 532871C2142E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 02:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E21C9449;
	Sat, 20 Jul 2024 02:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="DEK8s0fV"
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B8D8F44
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 02:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721443021; cv=none; b=uHSIXlAJxa58J6VUKFLfoGvONJad4tdSZkZvQ7jqx/7b+q1y2ueYjXP9PHI6YhswqMU8MVxQ918DxCS1CVqKk55+S0VuXZvxiR7hpZN/fyuyYuYgbA/qBMAERToVZrsIQiiexQj15XES0Jl5zI7R63oVZkn6av7Ncq8QkF3xnuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721443021; c=relaxed/simple;
	bh=Kd1qpKcXEedCOn6PdZOwyjGNmRrfVcR/BvItYwSeVPQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ShSH45yNG5V1TUga2AdNkx9kskuszHb5Gj/c3+RV1dNOxpv81zXLV1yPmYCDOcCUjufMEqw1CMGom58nOTI/Enzjnt4gpPd8UJyv6PVm2reiS5XXBZxqdGTQiNwCe8bqSQemTqEVyJWY7YWO00xBbBzbFLkOJBag87otcpdzwoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=DEK8s0fV; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1721442710; bh=kVNLerOKpj4SispH9JP8db2KVzz9aQQTi47iSODUBEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DEK8s0fVELQ2va7lljTttfj6bNaIBRjjFhbrNive6YyMpPigkQl+QYjNrfgHlDWK3
	 lqw2ry2NU/5crxjs40O379VLO0eqzYtVUng0M/BdXmGJjOvZNUyh90ypJ4J/UKC9GX
	 pmfGQNO0cbqfr3lcVb4Wz748ya+r6s/CLGOnVXaM=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 7F014257; Sat, 20 Jul 2024 10:31:48 +0800
X-QQ-mid: xmsmtpt1721442708tmd2ysqgy
Message-ID: <tencent_DC67EC3CBB36D2971037E24A78740777C909@qq.com>
X-QQ-XMAILINFO: NDAhN78L72+TYqMQdjygMcyva3wHJuMUvILaWKz3oSp6vrEf2sATnCJtjNTx0i
	 u+Cvc1JhRHYw6tUHDAv1zjTDRsd6aaZDBDlRfwixGBBrRUgZ2yofs7LEvcX6folR+hTG3zjZckfc
	 iSnlv8CS6RW4ywUfYQlHiaUds1KANbvL3OxQQ6kEH9otft20f+r2J4oF7I+kzq5wQcroS7RnTgEe
	 uOMjZqGymPHeSzI9BNqvEo/wphRpXGd3NqhcJ0gZSSjLFwqUfczAMhicqVK2RLaclTLzxbOclTkz
	 RTKOXVztrBWFNMDWVYAMm1rjGeT05nqbmSuBgtMD3h38G5bJKuw30NRI7nPg7ophVNnOhhTIbsXt
	 7KZ7aosscd1SU/Eo+o32nVRjdcqoaZFU8rhrOtDE//EPPb9cV9gr6RlHTfgpGTuqySBMyjr3LmFt
	 QEr8nBitL8HDJNQ4IcG1FZE1wOKfLwJlMcfTHOug5uVysfF2VvQuW9/RqT+LN12e/sS8pjtomEPp
	 fdvfzXO8QMwgOkKrw80ICgmNCUqWtSae3ETnqLu6Ce9sKD5ojPC2m1EbbZ1Vq8LJeRMWfZqyCX43
	 JIJr6We/4cYBZ1gJmy57ZO5+ep0LNy3yJYeFKYo13UnCkwNasNZ02lLymiJvrmQ6qgTyDtV/zHhG
	 TPVRf82M7/KhX5ZxQ13ModHJyKaEXtw0DOMzjVJPCynLfAJJvmut188FU7Ny4wdEAvQ2VM0rCsNK
	 H/CgtnLDHKFT1sp2EcrBM7kat7zokpO+ng8R9WcDovqtGkIB7klblESAv7GNV0gtsT4RqCYH4B2D
	 /AGiEsaU0nc9QccQ1vGPYfIzkqcZQW2yL6CKKwUW7F13q+LAxezgJNZECSVZk5xHJ0rkiVp0QYnS
	 pQzf+vWIZV0QqGwPHAkkSFkUG/NsRgYw==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+eda89a33c5856f66f823@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs?] INFO: task hung in txBegin
Date: Sat, 20 Jul 2024 10:31:48 +0800
X-OQ-MSGID: <20240720023147.869167-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000001f253b061bb8a953@google.com>
References: <0000000000001f253b061bb8a953@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

with sb rwsem lock to order syncfs and wb worker

#syz test: upstream 50736169ecc8

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 92a5b8283528..660a1ac8912f 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2123,8 +2123,12 @@ static long wb_writeback(struct bdi_writeback *wb,
 			queue_io(wb, work, dirtied_before);
 			queued = true;
 		}
-		if (work->sb)
+		if (work->sb) {
+			printk("sb: %p, %s\n", work->sb, __func__);
+			down_write(&work->sb->s_umount);
 			progress = writeback_sb_inodes(work->sb, wb, work);
+			up_write(&work->sb->s_umount);
+		}
 		else
 			progress = __writeback_inodes_wb(wb, work);
 		trace_writeback_written(wb, work);
diff --git a/fs/sync.c b/fs/sync.c
index dc725914e1ed..111c3c29b139 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -51,6 +51,7 @@ int sync_filesystem(struct super_block *sb)
 	 * methods call sync_dirty_buffer() and thus effectively write one block
 	 * at a time.
 	 */
+	printk("sb: %p, %s\n", sb, __func__);
 	writeback_inodes_sb(sb, WB_REASON_SYNC);
 	if (sb->s_op->sync_fs) {
 		ret = sb->s_op->sync_fs(sb, 0);


