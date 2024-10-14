Return-Path: <linux-kernel+bounces-363198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF1099BEE9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 06:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 687F8B23AEE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 04:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214F41AC420;
	Mon, 14 Oct 2024 03:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1wxFrZo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CF31ABEB4;
	Mon, 14 Oct 2024 03:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878375; cv=none; b=LWL2zTIzATbclMx/dNPfg+ddI3XG0S/lEW/jUrgkrve4eAe2nUkglUgGRZfcMP+sRzOKTB/+oBXBtrBxGMdYGH8w1EX9yu2GO9BCtVvcveKPJwdFp/dMwvaE3e4NNOFtaWFpUTf7nJYphrauFFNQJeyqhMvU4tpktfpHIC/Lc1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878375; c=relaxed/simple;
	bh=UpKsm2lNgI49+wqWUa/Fc5V4yIsG7t3brcdwVJurR5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RDD148CGK3S1cfXqKFoSYAkFHTEiU38+JamXx4fwyJ9Y5/f1D8/+5zYclNoyYECiLKE0dzmCChe1BKoCXyb3UOqW6bZ3bNqpauUliUHb5E6Ru1PLJ3fbwQpAUxOr8E2I8bv3hv45eRNlERsP7TQjXN+l4VLAOt00iiyYovgYbJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1wxFrZo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FEDC4CECF;
	Mon, 14 Oct 2024 03:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878375;
	bh=UpKsm2lNgI49+wqWUa/Fc5V4yIsG7t3brcdwVJurR5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y1wxFrZo7shnHVUlpiLgWzdB1peFpn6R52SJDsi1XRnRS0wSsRKKf5Esv73KtYQqz
	 JZO9d/WdTCxAgvEcLJk1Cxjl9wskukTqL/00Q3cX0t32cOtxvPvcPSo0B+z+M+g28w
	 +ud181nIhYZ09ubmr6YYugcy8rrY045kmZBv6s6FOFAcC7tblpZGG2jfz0OjPJ8AUi
	 tZnjjOq16cPZwpW428dfJ92l8LoQnvUK2U6Vu/Neqpfj8w6kAhYbhqyt9fk8OrTPRb
	 CgbGAYxvzK304sqg8a/IiHwih3Ho250KMnIuibS2nFC3/X2dY40IIpS7/qxKo1FyI7
	 D3B4zu4aLT9nQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	syzbot+3bfd2cc059ab93efcdb4@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 4/8] fs/ntfs3: Additional check in ni_clear()
Date: Sun, 13 Oct 2024 23:59:19 -0400
Message-ID: <20241014035929.2251266-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014035929.2251266-1-sashal@kernel.org>
References: <20241014035929.2251266-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.167
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit d178944db36b3369b78a08ba520de109b89bf2a9 ]

Checking of NTFS_FLAGS_LOG_REPLAYING added to prevent access to
uninitialized bitmap during replay process.

Reported-by: syzbot+3bfd2cc059ab93efcdb4@syzkaller.appspotmail.com
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/frecord.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index da21a044d3f86..f05f1630ed98c 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -101,7 +101,9 @@ void ni_clear(struct ntfs_inode *ni)
 {
 	struct rb_node *node;
 
-	if (!ni->vfs_inode.i_nlink && ni->mi.mrec && is_rec_inuse(ni->mi.mrec))
+	if (!ni->vfs_inode.i_nlink && ni->mi.mrec &&
+	    is_rec_inuse(ni->mi.mrec) &&
+	    !(ni->mi.sbi->flags & NTFS_FLAGS_LOG_REPLAYING))
 		ni_delete_all(ni);
 
 	al_destroy(ni);
-- 
2.43.0


