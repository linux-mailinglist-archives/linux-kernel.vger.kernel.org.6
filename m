Return-Path: <linux-kernel+bounces-444216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCE79F02FD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 04:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68EA8188470A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 03:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8D113A26D;
	Fri, 13 Dec 2024 03:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R293WNRw"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3377F9
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 03:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734059908; cv=none; b=POZNd2Y6ohYHX8PpzLooLpwf8QWU2ivxTJsbVSdbTLcawOWtWp1UvrVtJ46npF7b865g7wQuJrt3x47TsyH81GTk8YUCHHemOir0nymcvaLoDkP/46X7YT2KOvEFe4xFSm6uK/uE3sCk/vKnpH+Z3JJsClqsU+3z0IkXGMlB9NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734059908; c=relaxed/simple;
	bh=rFyUVbLxwOnCRz+41NdtIFeT2B1Xa4EkRyyEAFburgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dDlQ96I6JmbvoYGwqPjR+dKPHuXCX6ZYNKz/dsZWjMpIDwSfaASqulUKs40s+myEwftifGcBOwrfg5u4Oa83/3xyQbyQOZVSSAWZYjAmIpsDnPyZm1qhsfHYAwvsqgD4Ajoyll0+w4JOeI5HxdPPFrJNjgmvf+shJfCjBpJ2NmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R293WNRw; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-728e729562fso1061420b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 19:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734059906; x=1734664706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1dxqTMMwD+vdj1yqjgk3Wb4znitd3vyThSqpdf367JA=;
        b=R293WNRwShmEZzC2g2fXBDU7WK5mcNtei7enSnB3D62lXrmuv/9YBjEO78IpdgVese
         UF7avFsSHvplcIDzWd6PeLcwow7Vu0GdXyAS0Dy1kPNRpAPhSLf0meYNVjy172RnfOa9
         KJzpSE+/mcBURcg4G26WX/QHwaDym5s5bHQ8rjvLgM0P17LuqOghlwkLWFZUoKikY0N8
         X5Jh+l0wsb6j8uQc9OsTuOysK5/Y2t3XvbirsyVuHNE567bm7P+zdNK+dYIvKbqjyEjJ
         6rgkTeDz8LRmYEa6MpxFAGFTvF2OpNq2sOVfmJu8O/4AR23Esmy73Y0hiMzcia+1SxT5
         TwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734059906; x=1734664706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1dxqTMMwD+vdj1yqjgk3Wb4znitd3vyThSqpdf367JA=;
        b=SfRpubWMx04MICFUXbmhLabC5HrHK3b/uLXbx1NQLbcND2t0iXbAUTh7A7jTrmw5SG
         VFFAOYIsR8ZKN2HwvKlJCgqRx6HMuSpMY9hj/3RJdQqHW6bZbBYMG9eAWEiBx4PxveWb
         dTNwpz+m6THHaqOWcqI0o2/fqmK8jwiD4qtscd7z/O8nlmB5koBrV1NslKXbRSyP9fOC
         D9Uc+IikJx/D1Wg70miIbV2WNtXm/P4ovT78PhTx0Aqj466N1/11FSm2j7xPUb8xBc17
         TguHyEJEivN8V6hni/IyDBGj6THDKmkqcUL0oluNDUAT+yNrc0UNQA8GNtw3yLu7kxIP
         hKJw==
X-Forwarded-Encrypted: i=1; AJvYcCWgMRCoccbd8249WeAXba7Xix/izFl43l1XQ+JU9QMHbV458uSUj7a4A6+OBzswzltqB1ZC+Iv75jkQ4lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbP48mP4cfxcFUP8nYm0M85hs0DumOlbd6FoxYxyUzbYb+femn
	H0AccoLmSW/BMITzZqBgZ37FRg9wBgOEoNnesIKN5XzE9YKSFgwSLtsg+A==
X-Gm-Gg: ASbGncsobs/7RNE1LugPIS/4F68q/aAjDhNcAkYJ4lBkn8msoRgBUyMuaXhIH13ieHn
	ujznLPR3N+QwUS8bnjiD69CaUD7YPBGTYKB877aHyEn25oZnQHd9ZUoSlv+a2gdw1Tr+ZwVgeJb
	srNFwKqvnckKF7s2ZTUVyFttLZcI7C3TG37cjrubDiefniNydASoZZY/DpKUM4Q2pvfIxYaGWKH
	RzNdugY0eav1lbWzFVkcROpbqdQE3VlzcDfi1oFl3hAJNyE00k2vYdNJEq0+yMa76SWnq1z
X-Google-Smtp-Source: AGHT+IFxfLIv/zX/tt9L+6JvNezfXY9Irjpwlt3zALWICnKMq/wRks0+Y0w0LsihnkehsDRjH5tjpw==
X-Received: by 2002:a05:6a00:2788:b0:728:e40d:c5fc with SMTP id d2e1a72fcca58-7290c261ca6mr1643285b3a.22.1734059905604;
        Thu, 12 Dec 2024 19:18:25 -0800 (PST)
Received: from localhost.localdomain ([119.28.17.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725e7fa00c2sm8603259b3a.156.2024.12.12.19.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 19:18:25 -0800 (PST)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH] mm: fix outdated incorrect code comments for handle_mm_fault()
Date: Fri, 13 Dec 2024 11:18:20 +0800
Message-ID: <20241213031820.778342-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.41.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 mm/memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index d9af83dd86bb..d7342a726845 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6159,7 +6159,8 @@ static vm_fault_t sanitize_fault_flags(struct vm_area_struct *vma,
 }
 
 /*
- * By the time we get here, we already hold the mm semaphore
+ * By the time we get here, we already hold either the VMA lock or the
+ * mmap_Lock (FAULT_FLAG_VMA_LOCK tells you which).
  *
  * The mmap_lock may have been released depending on flags and our
  * return value.  See filemap_fault() and __folio_lock_or_retry().
-- 
2.41.1


