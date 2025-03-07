Return-Path: <linux-kernel+bounces-550344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B2BA55E2F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 04:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F3E43B43B5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 03:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CE1190696;
	Fri,  7 Mar 2025 03:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Odh0RDbV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32EC19047A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 03:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741317562; cv=none; b=op6aLe/L+j+v5AMF3rOoPv1LUpj8aEuRbNxVd19nXl905lhA6pMpvAHyf2Wbq7rew2ov2eTx3RZUFJvodC6/JvocIg6+jKy5a69ex2jQThKFwJxM947+m5Ttkcbc8R0QH5UDzgiKEM/dWs1qSbMtMRAg9/fPx+s4fsnBWBZm4EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741317562; c=relaxed/simple;
	bh=/keky7JufEKUaL6kOFuuqPbL6o9BiIYlwIBW/tfOt24=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MtqwN1jbEnTFGWxwk8tWpFYlox2g9zuwaTE+Yrv44Gest/Thl2SDiya/FYjqsgdTXBL5WNN1U/kYW8RfSm9pjqRqu9ZJs4iPMFOyxIXMqIgzOQd7AOxhDWmOKM5oDsQRwgBog/r8oHzLp0Eet2Buprzw+EHWEn3e8V3ifZDVlAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Odh0RDbV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A7BC4CEE7;
	Fri,  7 Mar 2025 03:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741317561;
	bh=/keky7JufEKUaL6kOFuuqPbL6o9BiIYlwIBW/tfOt24=;
	h=From:To:Cc:Subject:Date:From;
	b=Odh0RDbVygEDWWz4gVFH7MXY0pbnnggxgqYHPiefWQsNHmnMIln4n7vtO1QaufaYQ
	 hFqyeIpwVICnJpBCVEBCuoSRVg+hgKg5CvUq4tzqEOovrpJTrjfK6ujWvkhdgnPD9V
	 luZC2zyQJd0MXY0WTBk1nuQOVMp8vCdOtw7dwr8/XhcnnE7bfD3dkVSOrXBjwxt8KD
	 xLZKA7KezNLy6e1y6eS4HTi2fyUgBRSt0fCUlaD8Adt1BoKJjgVdjoahI4LoNVG2Nd
	 LiCh/fs3WKlVUWognS7rB3U2C0cB3PkI5cyFK3+89YXNXtKv02lqeyHcW4E9Sh9cYx
	 gp6jE92VI2VQQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: disalbe nat_bits by default
Date: Fri,  7 Mar 2025 11:18:38 +0800
Message-Id: <20250307031838.19164-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's disable nat_bits by default.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/node.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 56873c41436e..3148d9e44e7f 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -3286,6 +3286,9 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
 	if (!nm_i->nat_bitmap)
 		return -ENOMEM;
 
+	/* disable nat_bits feature by default */
+	disable_nat_bits(sbi, true);
+
 	err = __get_nat_bitmaps(sbi);
 	if (err)
 		return err;
-- 
2.40.1


