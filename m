Return-Path: <linux-kernel+bounces-510354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E341A31B98
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 02:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46D193A72DE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 01:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDA5154426;
	Wed, 12 Feb 2025 01:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDtEYgV9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D93146A68
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 01:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739325296; cv=none; b=Di8NiX8rUa2X03tTqM826eKwBuFMJnupynRIx5NCxybkvA0bMhhBNsFRAeKG3VIKxb+5fp/xLfn9EI0jbqb4+WQgj7ZI5/m7PM+GbaEinveXnf8rwTQqX53MfxKQkQmeOp4ieTQOVt+LFbdEgkyZheHcGZpOSebKXP5k+Ip3vho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739325296; c=relaxed/simple;
	bh=K4ihjAlWy2h4llZLGypkm22M0Vmbx1QNncg3WdOCYpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iNXdYuRg5bmx6yQsOCMnBJy78DVdmzx1AOUvXtSaVVb/LatraGyM9v2sjXNcXXKiSRBWU7BXIhMyf1PUWi1yrw5mFtXnQ5e9am1iYxgppoO35N0PPa+O5MPqdk6OZkZiba7CmZNCWEoATsQPqijJRDyQkLOSiG0FhbeAwW8hCeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDtEYgV9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEAB9C4CEE5;
	Wed, 12 Feb 2025 01:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739325295;
	bh=K4ihjAlWy2h4llZLGypkm22M0Vmbx1QNncg3WdOCYpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HDtEYgV9OLcFn3FVEl44az+67gxXQd1OuWCFOw8DWKz0Xad4vHDwNb0P9fGHez4ik
	 mH06Y+NPQq1JYf0SGR4WpxyC+YiRTsd633I+Oc40/ARLeDK8CqhUx/3UdGlfLfzWMd
	 Y4B8o1rORaln24eyyl1ujVkv8HP+9hrJEWbb0KWlwrJIUuibckKKN8cO32P7yz194g
	 E0furaTOXRNOFHcKfpseMtjkX4wRnQ3O27/Hnv3mZn9eSXWO9eZNo/mIeQ2XsglNeO
	 r8KnvU07RkIgGs73Bh0lfJn7tVCsvnqyoCUB/IbYcoJw5yFNuWXMspuNz8CAe33zfm
	 FWn26e3rE8uRQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] f2fs: add dump_stack() in f2fs_handle_critical_error()
Date: Wed, 12 Feb 2025 09:54:13 +0800
Message-ID: <20250212015413.666375-2-chao@kernel.org>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
In-Reply-To: <20250212015413.666375-1-chao@kernel.org>
References: <20250212015413.666375-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To show call stack, so that we can see who causes critical error, note
that it won't call dump_stack() for shutdown path.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 24ded06c8980..1af78b75906b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4221,6 +4221,8 @@ void f2fs_handle_critical_error(struct f2fs_sb_info *sbi, unsigned char reason)
 
 	if (shutdown)
 		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
+	else
+		dump_stack();
 
 	/*
 	 * Continue filesystem operators if errors=continue. Should not set
-- 
2.48.1.502.g6dc24dfdaf-goog


