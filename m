Return-Path: <linux-kernel+bounces-383605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA429B1DF2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 14:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91A8B2818EF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 13:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84CF1547F0;
	Sun, 27 Oct 2024 13:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RP1SSjc3"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367D98489;
	Sun, 27 Oct 2024 13:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730037051; cv=none; b=CMoPdTyvCPLnCj77Yxya6T0oAEGFtSHHCEweykhiLrEaZ+OdryZOrU8qGmtI+Kw9MjH84jEXNvCGWJr8gFYaSoHzRW8TKKtv0sb8OhK4j8gDk1iCPCz+TWU6XeiZmZSdFWBwz1HJBrcrm1dXQ8U10vdvXYz2LYiwsfv06qlNoj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730037051; c=relaxed/simple;
	bh=rntz41aukF0GgOif9N9M6U96FYbkXK0Me9t+AAat9vo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pzvQhACI6A15/ur4RI+Zw6nsNivWpUXTN3TaBr04c1KXsA17JoAjQl+vwqbhLBTPJ/iMg5rwY6ddXStKwWp8NYKngiR869nJbBNtoY5dBOmDrr7fKM7J3hKzV5+9usXQ3y5SY+8Ju8/6fVXLuyPzJ69yURWDvIhBG4/rYYOEvZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RP1SSjc3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43159c9f617so34392175e9.2;
        Sun, 27 Oct 2024 06:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730037047; x=1730641847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IjLV1bEDo/MtMx6gk/KnUwVzXIaCsBTVYT7dT2Z8X0U=;
        b=RP1SSjc3h2805fgMIMPMvHg7FdkuDn8bTfy++C3lXnr4qeSbN0lbmm3L0Z3WLNZv5/
         i+lXrvkOssOpwxCg1ustsMNN/qjyKV7iPYkmcOv1/ZnNR91lCq3VWx8uTvU8+uvoXlQR
         AUl2FWAlwlBBPWB58xJhA6VARkx4Qwe6KJUNKNb/8fu+bLGrwAr0Be3YE5TR+rmrL8qT
         XuZShwRkzrroEP2lUbuxnNPgkOBbuiIWEAQdaI+/EpvaVLVaqbOswbpNhuGoWCVPgf2/
         NanHxIy9Mj60i9EPloiEklKfwcE05rwHiWAxqQ+ODj77YoRhHh/59F2xZRE77AOqSJlU
         Y+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730037047; x=1730641847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IjLV1bEDo/MtMx6gk/KnUwVzXIaCsBTVYT7dT2Z8X0U=;
        b=MIeY6Gy95idxw/OdqTv5UnXKE29LSAx7gX/0B78OWoK1U+gW5LZc9kWindGCBGn3wa
         lv9wz0bABgZN9PvMvjcsjjTi8HFl3smn34aU23vKqGwxm9dFuUxVgKjxDBGKXgzznlAn
         KCTCrS8Hug7BPb4sT5UgGBtxGNABczSk/8w4NMrPY5v/UjsVX4JJXyP0VB97emDmNSLS
         MuPj8Wn0e4ERyCKc2UhMfEThYWggOp20SY7k9jjYNXjNuoi1ZMKdqkEDGI+A+/JG6zNc
         rmm8EZjOXNFvjzqGbGrAgvj8r/ozNBuY9uJ37KId/uPgyaLZSQvIOSSGvY371zEaT8nw
         j7Pw==
X-Forwarded-Encrypted: i=1; AJvYcCXm4ZGsFw0I49uvAr9zfctPYojSSXEncaAD3UHv5xpKpwjdujnreMf9TjPBoT0UUIQ/G91I/6K9N/P1Wo+E/U8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa9S8U5iN5I5U7f2hiwIUgSsC+42zx5mowtlZcNtPOcf8aehRN
	ZYQ0sxREd0Rx1M7CTSEP716UoauA7d7roQMjGK2nF52vL2yqGg7q
X-Google-Smtp-Source: AGHT+IFZSdsgh8pvcncgHwHZRd8w844yRAmKPjSvmnyw+tgZwytUA1t/mD3WcP4RP6lpmD54tce6IA==
X-Received: by 2002:a05:600c:458f:b0:431:3bf9:3ebb with SMTP id 5b1f17b1804b1-4319ad047a7mr46439315e9.24.1730037047280;
        Sun, 27 Oct 2024 06:50:47 -0700 (PDT)
Received: from void.void ([141.226.10.223])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b57b5d9sm105627565e9.44.2024.10.27.06.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 06:50:47 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH] freevxfs: fix a typo
Date: Sun, 27 Oct 2024 15:50:27 +0200
Message-ID: <20241027135042.23693-1-algonell@gmail.com>
X-Mailer: git-send-email 2.47.0.149.g3e3ac46130
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo: ivalid -> invalid.

Via codespell.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 fs/freevxfs/vxfs_olt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/freevxfs/vxfs_olt.c b/fs/freevxfs/vxfs_olt.c
index 23f35187c289..48027a421fa3 100644
--- a/fs/freevxfs/vxfs_olt.c
+++ b/fs/freevxfs/vxfs_olt.c
@@ -63,7 +63,7 @@ vxfs_read_olt(struct super_block *sbp, u_long bsize)
 
 	op = (struct vxfs_olt *)bp->b_data;
 	if (fs32_to_cpu(infp, op->olt_magic) != VXFS_OLT_MAGIC) {
-		printk(KERN_NOTICE "vxfs: ivalid olt magic number\n");
+		printk(KERN_NOTICE "vxfs: invalid olt magic number\n");
 		goto fail;
 	}
 
-- 
2.47.0.149.g3e3ac46130


