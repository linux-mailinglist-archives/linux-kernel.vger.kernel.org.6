Return-Path: <linux-kernel+bounces-329674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA79979487
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 05:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6799D1C2205C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 03:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7472311CAF;
	Sun, 15 Sep 2024 03:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0u7LlW5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEEA184E
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 03:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726370573; cv=none; b=FeoMCQXtpjmPsekOP2udu7IUnFsTrSeBGfjVs+gs19G2wD8N+VCFYdBjhcxBy4vFS7ApHn3sd0gG21OYRGeQm/Et4hQ9nOm9UzpJxLAH5lUpZ8pAJt6A0+UD8sfw8Q1OGBj7qLZs87tJLhCRIrimu+/HzjJ7RqRAnFNMtETIP8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726370573; c=relaxed/simple;
	bh=D4z2LbQM31Eu7rMfhCESWIT1U9N9nZd8stN4GhNdeA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cjVHZDr3u3o3cHe3k4YIXPlOFFzX1ewiSj1Yqoi9jblDGGg+9fuSGpZ+Q73XATp9xNkxridDsDIdI0EdoexvQb37wT1IccSgXHMy6+USfdFP34AwcSox1Y5cKPqpvRnlR1IBHfJ4sXAgbtmtZYSbobbF6ocpcS/UaG+7y2zTnxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0u7LlW5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A56EC4CEC3;
	Sun, 15 Sep 2024 03:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726370573;
	bh=D4z2LbQM31Eu7rMfhCESWIT1U9N9nZd8stN4GhNdeA4=;
	h=From:To:Cc:Subject:Date:From;
	b=d0u7LlW5hygmEwzKpXkmkpP+JbUwYbvmanPcZjyv9t9YJWhycTmYTbXNbRjnQq1hK
	 6VmEUWXUvXJGcN19G2D8oVJ6tP5TNbff3rugqacEKNCeyrOAlsdYsXBI3fTzm9txDq
	 uAmiohsdmTOBLRWuAoKAuybdaxKJRWMLdcSIj4skH2c3J+LvV2fwOxpG0dH4Io4kjG
	 YV/ZFS9Bblbr4Cqqko+7AAaiP74+sVe/tiRjNMCzTpAYDgfmr5e7J+osWthaCrtl0d
	 txbQkbKGraH7rjV5Ae6AiZ35/V+jv9jm8HVq6Rj9zrud3KTzv3+iFc1QHioPRXIN6r
	 ByjGs9Z5c0/mw==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: allow F2FS_IPU_NOCACHE for pinned file
Date: Sun, 15 Sep 2024 03:22:51 +0000
Message-ID: <20240915032251.2300459-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch allows f2fs to submit bios of in-place writes on pinned file.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/sysfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index d18931b7b094..c56e8c873935 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -792,7 +792,8 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 	if (!strcmp(a->attr.name, "ipu_policy")) {
 		if (t >= BIT(F2FS_IPU_MAX))
 			return -EINVAL;
-		if (t && f2fs_lfs_mode(sbi))
+		/* allow F2FS_IPU_NOCACHE only for IPU in the pinned file */
+		if (f2fs_lfs_mode(sbi) && (t & ~BIT(F2FS_IPU_NOCACHE)))
 			return -EINVAL;
 		SM_I(sbi)->ipu_policy = (unsigned int)t;
 		return count;
-- 
2.46.0.662.g92d0881bb0-goog


