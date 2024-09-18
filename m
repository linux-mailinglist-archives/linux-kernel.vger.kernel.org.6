Return-Path: <linux-kernel+bounces-332254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1159B97B74A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 06:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DBE02822C4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 04:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D9913A3F2;
	Wed, 18 Sep 2024 04:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rx9EQ2U8"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB709132105
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 04:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726635524; cv=none; b=u3dK816xFgepk2a1/Ec+0QyXBZ3vdyO0yF7tAz/nGs8DhF7CWaSiSxaJpRH8H8Ji4Litl59KMuvolvfAIU9TOsSR5Uw8Shq0A9TEAna+DhqhRp0PDbf2D2UsvdlEQ/PzKAKt0hm7gJUATRgvwcnMROXWcoui7ouwU1lWESXcWwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726635524; c=relaxed/simple;
	bh=8j2+FYeuRuf8tWXJJbFOjalnyEYNgQXvrl88Z1OkhRY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jy0+IwwrITtlR6h7HHegZYldoNeTa0edk7CG2cvll0u+8owfd3Ws+c3efKcEBDkvhEbgAc5l6jtpwxCQjYfkvMxw9bdCgybvMJAywto4bp7QsOzB00RJuMa5AuEiy1YAYOvP/XrrLsVdBs+b01pcBmFYVL2cCDXVHjcKrJ9iXkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rx9EQ2U8; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-206aee4073cso64199715ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 21:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726635522; x=1727240322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3elvcLsmZsluZcNvW9TPv7XtWE+ZMD0wypHYaobQ9EQ=;
        b=Rx9EQ2U8/d0itMQv/Mufr7VXPC/qUlbYtsELrB6JdT83h+p8b+vCEaraCHoSdmyxpL
         CJ9YMLC2ADMUo+AYigbyS4hXvynVpVyftAUA+KeFfJh589Q7EtpBnG2KOc5r9l9NrnRR
         y4pwN9n7PdOWSbLvibQXPfFpv95+/jr9w8U/a/irXQhFhPR1gWFOa6sWw/5Xnd6W8pUv
         h+X232Nc1PXM40dXPORVo+f2tyZeroPSMQ0f9YV9A3SVk7FhlKGsn1DGii/J2BXRHXRw
         /FkGT/mp9Jvjv9xWY449k85vPKJKUfcMZ92mVQ0ql0VaaFekISp4R1JGfvu2LLoVmc+Y
         9sgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726635522; x=1727240322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3elvcLsmZsluZcNvW9TPv7XtWE+ZMD0wypHYaobQ9EQ=;
        b=LvLa/hikImeHNmm9t6hQu9SoO9f+YTzO33dHHC3u+ZruSlSqkaOivFYqx3z4OnwLlx
         P4zwPq/c/cITfwjzejivqGvUSJ224Z0uept29+oDtLi/ramQplnEDHMwFYuwWDUo4+CX
         SnmbUZKHLdLjTslId1GykZyDEAPmi12TARRGey6PO0ETgU9UKL8ltKN51HnrwmOuUYFT
         5BT3f9Teeb4eiN1Qu7ap1KBaFmbzUzTNIFMeED7blTJxxKeVzw0jTOPtklLY9ehBVL7O
         ugGl8y/Uqw8DYEHq6zCW3e00Fk4pIxOyGr783iZ7VcGVh43kxbYtFAyOfMZbO50x2ZIa
         NxCw==
X-Forwarded-Encrypted: i=1; AJvYcCV0Zypv3fhztBNt0i5tPSNEI+9J/Sv7wa0ynZpEor2VOMNRxDBMyLmuxZ2o4EZ0m6gqX5ot1Jq+b3lYLtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ8/xRtlmfvhieDtjjSjfjjLuJ++irGkQ2ZErd1DK6qPUnmF8I
	bHPY4XmhkpCaxYZFs3XBn/a5UuJ4tVT02eSOQV6CVzEQOwK/4Gky
X-Google-Smtp-Source: AGHT+IEWM55DTS7RQ7ge4nS2Mm/YGbzcC/k1QdWC+lIkgDbts7374x/37/BxicOE0n54aqs+nbf72g==
X-Received: by 2002:a17:903:24c:b0:206:b04e:71b3 with SMTP id d9443c01a7336-2076e423359mr359589895ad.51.1726635521883;
        Tue, 17 Sep 2024 21:58:41 -0700 (PDT)
Received: from xiaoa.mioffice.cn ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db4998b4f3sm6684369a12.72.2024.09.17.21.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 21:58:41 -0700 (PDT)
From: Xiang Gao <gxxa03070307@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	gaoxiang17 <gaoxiang17@xiaomi.com>
Subject: [PATCH] mm/page_alloc: Add some comments for specific scenarios to make it easier to understand why unmovable and reclaimable allocations can steal from moveable pageblocks by default.
Date: Wed, 18 Sep 2024 12:58:36 +0800
Message-Id: <20240918045836.10825-1-gxxa03070307@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: gaoxiang17 <gaoxiang17@xiaomi.com>

Signed-off-by: gaoxiang17 <gaoxiang17@xiaomi.com>
---
 mm/page_alloc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 91ace8ca97e2..cc8a7a0772cb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1818,6 +1818,13 @@ static bool can_steal_fallback(unsigned int order, int start_mt)
 	if (order >= pageblock_order)
 		return true;
 
+	/*
+	 * The reasons why unmovable and reclaimable allocations can steal from
+	 * moveable pageblocks by default aside from the above comments, a different
+	 * and better understood scenario is: System initializations are all movable
+	 * pageblocks. If you want to alloc unmovable and reclaimable pages,
+	 * you have to steal from moveable pageblocks or it may fail.
+	 */
 	if (order >= pageblock_order / 2 ||
 		start_mt == MIGRATE_RECLAIMABLE ||
 		start_mt == MIGRATE_UNMOVABLE ||
-- 
2.34.1


