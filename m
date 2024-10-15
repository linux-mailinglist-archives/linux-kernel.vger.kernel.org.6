Return-Path: <linux-kernel+bounces-365551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E93299E430
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE96028195C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B2A1E6321;
	Tue, 15 Oct 2024 10:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Fn+OrZ2t"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592BC4683
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988738; cv=none; b=kjEAHA3I9nYq/ATWDA23jY0XWI2NOaBBeGQtAuRvJ/ACakwP+bIOV2ORNm0I5F8nJqjT/NmEjnUtchfBcTpLtDZMKxo6ZsJMR2qt8BkRsd1iIWwG6EWzhMSUWYBqmmwUPMfOF2latQg9Tk0h7DGfbP1PoQCH/Ny3N6luqdtj5zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988738; c=relaxed/simple;
	bh=DK49QwsTGRhM/RL/912zwVmvCrGGlabyG+07aLu7pzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jjBiKSzEopVq+RMCmgAB403QzU5CNZ28eB7wgWUUUD0HIicOiIOo5KAcM1WJYEWXBEFDk9F54enPvoZ6NL5WvDN+/6oyhsvwwLPkuV3D+1HBm0MVWXSYe9zUZm21OGhCxLSa/NBVDhCTtDaufffgO+vxtu7ajJ+5AosZM7hpomE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Fn+OrZ2t; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728988728; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=zbwwe56n6BEAFKi92J7UJBALAvIEtYC5JMMy8xDigbg=;
	b=Fn+OrZ2ttX8YhQxOLEqRJYbnOZvvrGDBdFxbwcxDmz+tBYof5Dc6n/vGzgTmIlDZu5f/8/h/2jmnWjK2cTnmZGC1lE4mC1tONcDSxHl9QoRmSH1F8CDuJmb1iF4uzSNupfYFd9lz3euo7oPCTUTdG4I3NQcVZnlvef3EcmTHO6c=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WHDQB3x_1728988727 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Oct 2024 18:38:47 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
	Hongzhen Luo <hongzhen@linux.alibaba.com>
Subject: [PATCH v4] erofs: fix blksize < PAGE_SIZE for file-backed mounts
Date: Tue, 15 Oct 2024 18:38:36 +0800
Message-ID: <20241015103836.3757438-1-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust sb->s_blocksize{,_bits} directly for file-backed
mounts when the fs block size is smaller than PAGE_SIZE.

Previously, EROFS used sb_set_blocksize(), which caused
a panic if bdev-backed mounts is not used.

Fixes: fb176750266a ("erofs: add file-backed mount support")
Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
v4: Remove unnecessary parentheses.
v3: https://lore.kernel.org/all/20241015070750.3489603-1-hongzhen@linux.alibaba.com/
v2: https://lore.kernel.org/linux-erofs/20241015064007.3449582-1-hongzhen@linux.alibaba.com/
v1: https://lore.kernel.org/linux-erofs/20241015033601.3206952-1-hongzhen@linux.alibaba.com/
---
 fs/erofs/super.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 320d586c3896..14031141bde8 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -631,7 +631,11 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 			errorfc(fc, "unsupported blksize for fscache mode");
 			return -EINVAL;
 		}
-		if (!sb_set_blocksize(sb, 1 << sbi->blkszbits)) {
+
+		if (erofs_is_fileio_mode(sbi)) {
+			sb->s_blocksize = 1 << sbi->blkszbits;
+			sb->s_blocksize_bits = sbi->blkszbits;
+		} else if (!sb_set_blocksize(sb, 1 << sbi->blkszbits)) {
 			errorfc(fc, "failed to set erofs blksize");
 			return -EINVAL;
 		}
-- 
2.43.5


