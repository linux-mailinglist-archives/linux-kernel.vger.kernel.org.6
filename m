Return-Path: <linux-kernel+bounces-175838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AA88C2607
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 15:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA26C1C20EF2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA4A12C520;
	Fri, 10 May 2024 13:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zcm6lxP/"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F28612C488
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 13:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715348958; cv=none; b=j8QBda9K4E6gkoIGZy/ikGQtJQxR+JK63Z47kPL4DqVA6WHlF7X0zV/t7a4ZiotIHLYNYV1FBgFuP3+mDrcakDA7ZGTa0MZ03GvGqONuhQ34mxB3blQUwdxaLzDBlomXMO4c77Lnk/zQu62eto9hZJhbEQFBDXbYYV4nuuqXn2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715348958; c=relaxed/simple;
	bh=x27guZ9vKTjIQXTa7fULZKUsS4HoyexGPpIlVP6+hfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gQHfopY8xb9UlMyjY9L9mZKcxldUN9iWmCwfUZNYwgwvgjwOgvCytXgmljNEaTa/gvohZfWZVDmERyHs8J3vg1PU5aIYce5fd8KQJsHotyY6DtMcJroYKDsp2gRRMim7oBn/q5YmAKJ/AoHSGfnaIAWxjn9/nuHvYEchQOQSQmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zcm6lxP/; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-61ae4743d36so20906097b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 06:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715348955; x=1715953755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cMUMJYURHY94vqRajyuSN39xJoZIvziqTdmR++yNIMs=;
        b=Zcm6lxP/pS/NJJywNoa6j4wqR5/al0JwrBHEjWwELJrQxhWGQEDngdgxAKDUWyQwqD
         QVPlf5d7E8lAp1SDlpjy3WHrquAg30mAI41Dnj7rXnV1OQ8Kqc1IiF9VpFGHDj2e0cIk
         hGLt4xptlskSGKOnfmC5bnaXSNxfcPwJBlkF0QP2YGmJlhQfQIPIeuKVujQJmrzz1vbo
         XoCkRuxB/NeIb2Ibwr0yP/Wc7fzFu4zYhHhgbGL6kd7TnYjjPJ7n3IJEVo1U486WzIuR
         XOVavqthpxMM9ACBcaCVupUMJYJqAob5Jlrlv9csHU2AajJVPTu3faKw8Wv+lrezRrR+
         cxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715348955; x=1715953755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cMUMJYURHY94vqRajyuSN39xJoZIvziqTdmR++yNIMs=;
        b=JDxfyhk682X7BaFJ1beeR0YxQ8vq0qGETTdYC+LtP0t9C7xM8cQbGXqoYcrVcNPcN0
         kDn7xC8IQDC9+3ZwYBt9G/WImwSaHRiaE+2scDU49+B9brvvupXWi469Bj5yabX/ZCpj
         3IydJS1eEw6uZ7zmvwznTuJwPqiNiWpfV6P7qFcQ2NWWKRpmEs5wzjtoF9R62hIgh0Sx
         dnNNqHCcAzZBxL9Ued7o/JXODOt8H8vgK72+Sm3MMlafoCxJRxOcK7zltB0h99zF6PHp
         Gy8M0qmJGU+MQuxb7J/ikMuG+CLUhJ41x424FEghQ9k2cr9Vj+UY4nOxTQrSNXN01L6U
         aMwA==
X-Gm-Message-State: AOJu0YyJnaTY8tp7IC67BV3HuDtb3UYx6xxKrVusI02mg/P2WZjMytPC
	dM/vsZ1pnUDL+Ccox5/Y/raxt5iefqYjZ6ZbUV5IhlvYZFyqcF7iOV/Ywg==
X-Google-Smtp-Source: AGHT+IGO7SfWGCZDz2y2v2OJN6Q5pLA4S5PJIF3I0ZYqlYd1skL7TqwiKQ4wsAASxy1Cfm6IGlAjcw==
X-Received: by 2002:a81:4f41:0:b0:620:26f5:c97c with SMTP id 00721157ae682-622b01479cfmr27053657b3.35.1715348954902;
        Fri, 10 May 2024 06:49:14 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:0:1000:8411:88e7:6eff:2864:482c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e346b7asm7301617b3.103.2024.05.10.06.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 06:49:14 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v2] f2fs: allow dirty sections with zero valid block for checkpoint disabled
Date: Fri, 10 May 2024 06:49:08 -0700
Message-ID: <20240510134908.3271725-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

Following the semantic for dirty segments in checkpoint disabled mode,
apply the same rule to dirty sections.

Signed-off-by: Daeho Jeong <daehojeong@google.com>

---
v2: simplified codes with the same logic
---
 fs/f2fs/segment.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6474b7338e81..cb0718cc1e47 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -771,8 +771,10 @@ static void __locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
 			block_t valid_blocks =
 				get_valid_blocks(sbi, segno, true);
 
-			f2fs_bug_on(sbi, unlikely(!valid_blocks ||
-					valid_blocks == CAP_BLKS_PER_SEC(sbi)));
+			f2fs_bug_on(sbi,
+				(!is_sbi_flag_set(sbi, SBI_CP_DISABLED) &&
+				!valid_blocks) ||
+				valid_blocks == CAP_BLKS_PER_SEC(sbi));
 
 			if (!IS_CURSEC(sbi, secno))
 				set_bit(secno, dirty_i->dirty_secmap);
-- 
2.45.0.118.g7fe29c98d7-goog


