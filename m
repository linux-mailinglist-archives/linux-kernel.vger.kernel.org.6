Return-Path: <linux-kernel+bounces-542812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA31A4CE14
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 23:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59F587A7A04
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 22:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DBD20E313;
	Mon,  3 Mar 2025 22:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8IkKKnS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FAB1DDA3C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 22:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741040252; cv=none; b=AhnGuEE4BQDoYFfCfpwgixGWEyNPNGLwg70nfmNavWy5D8QQ+Pf+Q3vqz0qfGk7F7r3KjP/qlRAwfczn0E7ds/V6VxsvD9QZn1QVailGRtgvrhzxmuH+TjmT82qC7VBPW1mgOjxxJIjZ+j+vyjpbMpdVfYCG7sTbuRBZ8reIrgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741040252; c=relaxed/simple;
	bh=3Dhep88DZZmRiLR4JWC42gaVSxkJVdFR1Myn7cDYqJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N8dvueDOZcuPIfOGBp91RLADABHuOHOlBZRIDOQGZmjjGOs4faSjAnfx2ECtcOKN31tvA7Ti/9wKV+Vice2HTQWshFlM2rVsq6op35qr6vguj63FwzqydfzfYFqWQwifm30wYX8PmxWTuZ9dEFQZDsdIsa2zHAnhbzmzFfdCZLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8IkKKnS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476DCC4CEE5;
	Mon,  3 Mar 2025 22:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741040252;
	bh=3Dhep88DZZmRiLR4JWC42gaVSxkJVdFR1Myn7cDYqJ8=;
	h=From:To:Cc:Subject:Date:From;
	b=k8IkKKnSuXX9oOfKUomPgZ7LlFvIL5SR4515wYm59tc2uZ5PIjBjagYViP42eluJ1
	 +i7vI38FZeb29Q8uumRm08MMoc1Kajy5RCIP7K2JO52x88tntP2CaAwbA5MVEKuQb2
	 JhUUTkLVMy3NrcbivsDlUWkT4pHB0KR+V4GFvuz89SVaK9ByRzRCDcQ9kOzmTJbCz4
	 U4cUsOP62FGX/N2k1fT8b9RaKLwBV0uHXtoPFZcbD2j0obA9jcHquAuXz/Ys5iiv86
	 NIpr4u8rRjLmZsEt9imeuvcnNe0rmQhvYnq3P/SHKO6PQQWsWIKtGFnLywyjjQOZwM
	 anBGgrZjSx+hQ==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: set highest IO priority for checkpoint thread
Date: Mon,  3 Mar 2025 22:17:30 +0000
Message-ID: <20250303221730.1284822-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The checkpoint is the top priority thread which can stop all the filesystem
operations. Let's make it RT priority.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index bd890738b94d..8dbb815a35c0 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -21,7 +21,7 @@
 #include "iostat.h"
 #include <trace/events/f2fs.h>
 
-#define DEFAULT_CHECKPOINT_IOPRIO (IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, 3))
+#define DEFAULT_CHECKPOINT_IOPRIO (IOPRIO_PRIO_VALUE(IOPRIO_CLASS_RT, 3))
 
 static struct kmem_cache *ino_entry_slab;
 struct kmem_cache *f2fs_inode_entry_slab;
-- 
2.48.1.711.g2feabab25a-goog


