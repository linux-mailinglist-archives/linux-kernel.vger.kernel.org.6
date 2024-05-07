Return-Path: <linux-kernel+bounces-171937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBC78BEAE7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 19:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0FBE1F22B81
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1823816C871;
	Tue,  7 May 2024 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtxI4VSX"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297471607A7
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 17:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715104594; cv=none; b=aJBbobs6YtcsVUlUZe4i3dEVeB2Ln+QnYamfxjaZAS3PqF0t4rXj7EKAJ41sPhkoW+OgIfe7JKmIgjY8AkHE28SHGN5l1hYc7kCoFdtbms2xCcai4D1JF+lSVjelcRR1jPZw6Y0Kh3xVZkkYo7GSTWrchlp6ZMBZPm57OvDWBGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715104594; c=relaxed/simple;
	bh=l50Vqp2ua5FSimEFnJjrmoroRGW3yD9rBbW6y+IZyMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dQKtgrP7Mzj9rbHs5gzHr6oP+DVAkHo+DeUiAkwmtQXGbR1xUDBgd+VByuWRMazPpXnn/MIvMlLbtYoVXkFu4WDzUkoaygN0iTLlpLMkObJNR3mOr7xZ8qCac50g0qOM4aWo71WIZ4+iTKn9EezAKcPDKTwbD3P3kxTtRLHMhrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtxI4VSX; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f467fb2e66so2703881b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 10:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715104592; x=1715709392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ive3waDoK8gwDGEBUE2bkX5N+SnSEytp7ihvp6Bzhck=;
        b=gtxI4VSX1hXW/2317mYablrhK7oeHe3wvtpEgmLxhc6oUEJQys5oMkAN1ICtRV1u+n
         tPzeIJh2dT2E3xKTW9bpHNp81eBd1++444vft3Be+LlMLjjCdSvlwjMhJUKO32Stb2St
         ASao/nYPuSQY2t9wA85ji2GdoANszh6t83XiTrNm+W9omAZGkGFjXrUauxRO/Y1ZE8uS
         Fn+9qQcdGGa1o/dlwy2dimDpuiZO8hcY/AxDhZOOJI7uneayWD6TomDSWuF0gtOShu0D
         JZQhzvW4wNe3FhtKrB+GqV9lA4Enw8wXEmtSbts4KHj2DajlDUZmTL05tvLPTvl+4hxl
         aKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715104592; x=1715709392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ive3waDoK8gwDGEBUE2bkX5N+SnSEytp7ihvp6Bzhck=;
        b=ooIzJLrVy230aqQWhWr9gAlAV8/rVbWFm0UQegCJF1t1bv5lAQ6bCpDEgAh/SZlFgp
         iBvPzyeyEBK4do0Oqmq98dFgkKM61pDkZWf2zgrwsKQRk7zMLUAnUo1cZPVNmt6r3YcK
         qOldS+x29dJHSZDWWchABKEaw2cAU2B5BsDwBKQbieT1s29QygTIYuazkwKh3pSBKyO4
         qYf0z7dDA7GZB9an0J+Hu7IB8vbKZlT3wm6AtyhiPxbhKWn76viYguxmVpi4qO//ssV+
         g8so4GPunD960RST5bZUtIoC3iD6ORB8NgR9x9JzajzUnF3gLxRXZqSFfI3XqduMex7C
         IZvw==
X-Gm-Message-State: AOJu0YyOWFrjf3P0N9N6nSEV7zmcxyb+5runDAkavGVslt1AScqPi8sc
	Y4bpheY1vmYOv+MDPcnYxbUVYF+PCDuS4eeOdRCWJiaP/lemXn4/XBpEpA==
X-Google-Smtp-Source: AGHT+IEjfRxzUs2wpGVAcI782dPodkBNSPfsWEd5VtY3GAR+bB9Wpak17hBN3oRvPuKogBnyQFbt9Q==
X-Received: by 2002:a05:6a00:3a98:b0:6ea:d114:5ea1 with SMTP id d2e1a72fcca58-6f49c236254mr358654b3a.17.1715104592171;
        Tue, 07 May 2024 10:56:32 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:0:1000:8411:1c98:67c4:cc33:3971])
        by smtp.gmail.com with ESMTPSA id fc16-20020a056a002e1000b006f4596a2753sm6269387pfb.40.2024.05.07.10.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 10:56:31 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: allow dirty sections with zero valid block for checkpoint disabled
Date: Tue,  7 May 2024 10:56:28 -0700
Message-ID: <20240507175628.2460390-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
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
 fs/f2fs/segment.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6474b7338e81..2463398b243f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -771,8 +771,11 @@ static void __locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
 			block_t valid_blocks =
 				get_valid_blocks(sbi, segno, true);
 
-			f2fs_bug_on(sbi, unlikely(!valid_blocks ||
-					valid_blocks == CAP_BLKS_PER_SEC(sbi)));
+			if (!is_sbi_flag_set(sbi, SBI_CP_DISABLED))
+				f2fs_bug_on(sbi, unlikely(!valid_blocks));
+
+			f2fs_bug_on(sbi, unlikely(valid_blocks ==
+					CAP_BLKS_PER_SEC(sbi)));
 
 			if (!IS_CURSEC(sbi, secno))
 				set_bit(secno, dirty_i->dirty_secmap);
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


