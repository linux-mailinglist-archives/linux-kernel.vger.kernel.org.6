Return-Path: <linux-kernel+bounces-540925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4E5A4B67A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 04:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCAD416BB96
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDEF1C84CF;
	Mon,  3 Mar 2025 03:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OM4rpPP4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36811C3314
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 03:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740972349; cv=none; b=BEANl+6kk08SBoJyIZXbjf9P3rYTMNYUfAlzorAPIY9HkaQb7/m/U95TA72oupeAA56d607nqPDOomUZZ1M1i9BWNX0fksEd/05AQmhBzyuUW9BbkstG1lcJC/B0+puEaSxisEwyhM09tqfYHo7o0D/14FGO1XwHIOkxgmNOAEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740972349; c=relaxed/simple;
	bh=7fBJ+9SkI851aRpJLiCAVAcdqfXjwH5g0lFDk3gGWVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t3Ugp1yuwg1hr0U8Koz72L79nYEu/bSbzoCMUP0Bg9fBREP7GmP/Ar0G/0mOlD87DGDRb16oQ4SlxNJmwe3siVi+OuQkilXl/IMkbA2nE/u97vROgPpbTXGB3fabEjzW4AYpj33Jb6fNTd8XU2d1k7ieXIDsakeqRotM46Sr1mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OM4rpPP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281E5C4CED6;
	Mon,  3 Mar 2025 03:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740972348;
	bh=7fBJ+9SkI851aRpJLiCAVAcdqfXjwH5g0lFDk3gGWVs=;
	h=From:To:Cc:Subject:Date:From;
	b=OM4rpPP4GFlRA/XDbjnPWZe1YXGy5r5ZL6IbUFzaPpMMzsh2NrLb39V2Wb24gdl4A
	 tits4FnyopTerfSpURwHWpTH5/heyR3erk/9cxz2Lo6L8Y5mCDQZj47AptfyyuP4bj
	 DjiXPTO6KeQP59rvPJdPVf6LQq82DrlvzSN4Db4YOutDi+0e91P9uD4c0KVKRG+fDY
	 eycw+nwpLdhJhbeU3pVz9ByHzl1xbXquzib91HVfx5SEqn+Mlf4TGqPlGbWjaXxuN5
	 xZBCalowRpKnRUQygOELr2EYj1txyLFPKIreiyi94g1T4V5VG15oI8MJ0tbfVZwNbv
	 IKVayumeCjylg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to call f2fs_recover_quota_end() correctly
Date: Mon,  3 Mar 2025 11:25:00 +0800
Message-ID: <20250303032500.1310215-1-chao@kernel.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

f2fs_recover_quota_begin() and f2fs_recover_quota_end() should be called
in pair, there is some cases we may skip calling f2fs_recover_quota_end(),
fix it.

Fixes: e1bb7d3d9cbf ("f2fs: fix to recover quota data correctly")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 7a8fcc1e278c..3c875dc07266 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4805,10 +4805,10 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		}
 	}
 
+reset_checkpoint:
 #ifdef CONFIG_QUOTA
 	f2fs_recover_quota_end(sbi, quota_enabled);
 #endif
-reset_checkpoint:
 	/*
 	 * If the f2fs is not readonly and fsync data recovery succeeds,
 	 * write pointer consistency of cursegs and other zones are already
-- 
2.48.1


