Return-Path: <linux-kernel+bounces-540016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86219A4AC6D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 15:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90761896493
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 14:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E311E5B66;
	Sat,  1 Mar 2025 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vP3RPgHM"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3896C1E47A9
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740840630; cv=none; b=RKLRh2afgpRw1m4atXZQfbp/VogrxSkyeCh/RO5ap3e9mWms5A9UTHaTO6/Vde7R9yLSI+yDeQvcRgfX06w/nPjsJZG/szgKO2ZkuAcsUqftXQffxuF0hqzXUwK6Fd6jNZmn8v5GWT7N5mGuBMjtUhEkqr6K0iZf6Fzkr645OqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740840630; c=relaxed/simple;
	bh=SjANaxWCmJNj7oi93bssrFLPFZbesMUZ2Sr1VspqT/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u4KkgjrwggwV5kT40sJgCwFz3XhgH1JHW0BVAnIoWRtIHZORs/17Kk0sbtc2jy4LDhJ/91kYJJ3wNUA8KWDDcGJXfco4UXo9hdjfMMSXirhMGr8XnmcF3Ukj82ia4wAUwVsfBnPaAnE5naZMjDcsgqRvy2SvShQlD+6S+2OHjEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vP3RPgHM; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740840618; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=BOTXNFCiusEeI6Bv6xOR/ZPHNnysL9qJrOFxRXLReDE=;
	b=vP3RPgHMSzIAPHz8aTu6ZjY4xUOztAbZMm80vDbi1CkVUidoqg9QC/s1ISypt+VU7ysizTTesi3TmMc/+pF68NoyAtu931nagBseUxS4yLk5D/PW+/oBa+pSr8i2GMf/0xz481pR+RosnNEr47DOZOHNNcj7HuqT9IaUQeuclz4=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WQSjMs._1740840617 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 01 Mar 2025 22:50:18 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
	Hongzhen Luo <hongzhen@linux.alibaba.com>
Subject: [RFC PATCH v6 7/7] erofs: implement .fadvise for page cache share
Date: Sat,  1 Mar 2025 22:49:44 +0800
Message-ID: <20250301145002.2420830-8-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250301145002.2420830-1-hongzhen@linux.alibaba.com>
References: <20250301145002.2420830-1-hongzhen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch implements the .fadvise interface for page cache share.
Similar to overlayfs, it drops those clean, unused pages through
vfs_fadvise().

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 fs/erofs/ishare.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
index e68bb1a6cf4b..a7c2be5d6f25 100644
--- a/fs/erofs/ishare.c
+++ b/fs/erofs/ishare.c
@@ -230,6 +230,14 @@ static int erofs_ishare_mmap(struct file *file, struct vm_area_struct *vma)
 	return 0;
 }
 
+static int erofs_ishare_fadvice(struct file *realfile, loff_t offset, loff_t len,
+				int advice)
+{
+	struct file *file = realfile->private_data;
+
+	return vfs_fadvise(file, offset, len, advice);
+}
+
 const struct file_operations erofs_ishare_fops = {
 	.open		= erofs_ishare_file_open,
 	.llseek		= generic_file_llseek,
@@ -238,6 +246,7 @@ const struct file_operations erofs_ishare_fops = {
 	.release	= erofs_ishare_file_release,
 	.get_unmapped_area = thp_get_unmapped_area,
 	.splice_read	= filemap_splice_read,
+	.fadvise	= erofs_ishare_fadvice,
 };
 
 void erofs_read_begin(struct erofs_read_ctx *rdctx)
-- 
2.43.5


