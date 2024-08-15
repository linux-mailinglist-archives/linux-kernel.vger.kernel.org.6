Return-Path: <linux-kernel+bounces-287377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABBB952722
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 02:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 308891C214CE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 00:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED972BA20;
	Thu, 15 Aug 2024 00:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTjUI5eB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405BDB644
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 00:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723682864; cv=none; b=DXX9UYEhdEo+w3EUVE5cNRFXeUq9P2ivmoBCJlrGmxlPZmTDX98rDFc2c+iGyusTxv3EvGG4MhIXtTsvls4M29S70Akf9c9VOJ+kXRKdUZtmH+V1qEG13Tbeb7e0vi25SqvbEDDifTSPRL4ZEqXkBLwWFX2Go5wuxAJgr9JsRAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723682864; c=relaxed/simple;
	bh=r4BuNVkYuudg6mssyMhySpqB69LfFwKvJIwhIwlq9vw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p5Y404rx+XvVZcpx/lqs55BRVVi7DIe12CdTrDSh8rFdpI6ynHPAXbas8GHJdn5HwDo5x0cvfrYh6xerPmcjovTXDogJIx4dL05KQuGFR8MKoCMYYax+LdITxLy4uYV7vYiByPfKgmhjmDst/qcDJoBTMlrJMEXt/irFbo9rRiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTjUI5eB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322EDC116B1;
	Thu, 15 Aug 2024 00:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723682863;
	bh=r4BuNVkYuudg6mssyMhySpqB69LfFwKvJIwhIwlq9vw=;
	h=From:To:Cc:Subject:Date:From;
	b=WTjUI5eBcl/eUzAvbxSR7N3TpnNseMvcrBzAHKcSyZ5GQG+DkxhjwB1IpTzfy4noD
	 eJhFX8H5ZZ+HZnskPK/q5Gn7IxS1m6Q3Iz8Dr7rEZ5YDfXq/hakAhl3xBiK2kzW+jh
	 9PBjPGZG9qo31nhOkfTDSJRRZ6xhCq4iMH6nAFdLjzp//pmdHGFKxaaRsF+9GXyzJg
	 DVlXsOTzH5gQamzdrM44uFTuQlsQ7Roig51x9Rt9YReLxy0ccV8P2/3ulkFfyuOchP
	 Q6HiTt2nPqG+JTPN9beKqmeFyH3957mSAuF3OeK7D3qAlSd5blWlQzlT/KlxsA/nKp
	 bla2ShBXs4LIw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH RESEND] f2fs: Use sysfs_emit_at() to simplify code
Date: Thu, 15 Aug 2024 08:47:28 +0800
Message-Id: <20240815004728.983290-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

This file already uses sysfs_emit(). So be consistent and also use
sysfs_emit_at().

This slightly simplifies the code and makes it more readable.

Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 fs/f2fs/sysfs.c | 45 +++++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index ed4bf434207a..654a541dcc45 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -188,50 +188,50 @@ static ssize_t features_show(struct f2fs_attr *a,
 	int len = 0;
 
 	if (f2fs_sb_has_encrypt(sbi))
-		len += scnprintf(buf, PAGE_SIZE - len, "%s",
+		len += sysfs_emit_at(buf, len, "%s",
 						"encryption");
 	if (f2fs_sb_has_blkzoned(sbi))
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+		len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "blkzoned");
 	if (f2fs_sb_has_extra_attr(sbi))
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+		len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "extra_attr");
 	if (f2fs_sb_has_project_quota(sbi))
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+		len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "projquota");
 	if (f2fs_sb_has_inode_chksum(sbi))
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+		len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "inode_checksum");
 	if (f2fs_sb_has_flexible_inline_xattr(sbi))
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+		len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "flexible_inline_xattr");
 	if (f2fs_sb_has_quota_ino(sbi))
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+		len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "quota_ino");
 	if (f2fs_sb_has_inode_crtime(sbi))
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+		len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "inode_crtime");
 	if (f2fs_sb_has_lost_found(sbi))
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+		len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "lost_found");
 	if (f2fs_sb_has_verity(sbi))
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+		len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "verity");
 	if (f2fs_sb_has_sb_chksum(sbi))
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+		len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "sb_checksum");
 	if (f2fs_sb_has_casefold(sbi))
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+		len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "casefold");
 	if (f2fs_sb_has_readonly(sbi))
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+		len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "readonly");
 	if (f2fs_sb_has_compression(sbi))
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+		len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "compression");
-	len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+	len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "pin_file");
-	len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
+	len += sysfs_emit_at(buf, len, "\n");
 	return len;
 }
 
@@ -329,17 +329,14 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 		int hot_count = sbi->raw_super->hot_ext_count;
 		int len = 0, i;
 
-		len += scnprintf(buf + len, PAGE_SIZE - len,
-						"cold file extension:\n");
+		len += sysfs_emit_at(buf, len, "cold file extension:\n");
 		for (i = 0; i < cold_count; i++)
-			len += scnprintf(buf + len, PAGE_SIZE - len, "%s\n",
-								extlist[i]);
+			len += sysfs_emit_at(buf, len, "%s\n", extlist[i]);
 
-		len += scnprintf(buf + len, PAGE_SIZE - len,
-						"hot file extension:\n");
+		len += sysfs_emit_at(buf, len, "hot file extension:\n");
 		for (i = cold_count; i < cold_count + hot_count; i++)
-			len += scnprintf(buf + len, PAGE_SIZE - len, "%s\n",
-								extlist[i]);
+			len += sysfs_emit_at(buf, len, "%s\n", extlist[i]);
+
 		return len;
 	}
 
-- 
2.40.1


