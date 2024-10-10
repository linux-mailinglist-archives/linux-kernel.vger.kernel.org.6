Return-Path: <linux-kernel+bounces-359721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B69998F85
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 531451F25D0A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D41A1CEAB6;
	Thu, 10 Oct 2024 18:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="w58brkkt"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720301CDA23
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 18:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728583973; cv=none; b=KeHVO2AM8wLnssIwcPl8bG5mFez7I02jwIe8Zdg5HugdShkauvwA7+A7qwInnXXGq+ErQQLOWq/GigWaikhQ1hgaVLuZ2LGGxy9GmREORwcshsHS3sW7ToZ+j3VnQ6xik0k5gQ4LyAZTlDVbdq3Uh2conUJ2FUv8yOKBJnDR0gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728583973; c=relaxed/simple;
	bh=ldQLIidAq3XSrv1H+wr586pudMJ5rZs4x1TZh0YPAbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U+7ul0SHEsgbhVcaJsi7aPzvkocyaP2J/aZCJ3g2ghDK55n9cgHJaiosj9fsDvNdRnuHOVQz3jpfnfseZfws//5pu/16wpvl3xQweywMutnWoFjppOiykie+mb9W7BmTP/l43tV7CwYt/y/BbXSKBKxYsUTvPPwTta5Yx+84yLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=w58brkkt; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-20c56b816faso11651125ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1728583972; x=1729188772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j2Ikuhi33gkCIoLfXtInuXs32ry1GdG7/p1R2O08x7Q=;
        b=w58brkktEhQWz7RcTWZhy1WH5wJe4yF91xIA7/dJrpcQQmmojdotyIkx1WCicFuToe
         T+8O3Fsdd7ItNEV/ALx8afey2WUL4pGPLTFkZ+WdrtxeBZovCF5CyY21qykNTywKZEuH
         3vHYT1nulYDJ3Xfx/3+IfKgx2nhNo+PNS42fpyW4L366a0KCv0izhlK9i2zRco9ZixYC
         Ijix4lxrRbC8oLgoxwu2tuJq6BbNt3/fgTceEkCenpSprLLTxZY5JAHSspwmzbNDITak
         5B+x5R/C9ix065RfRoWDnimbNCNaKuiO0PS6LzLNlzK4e/jaySNcE7ALy+qAy0/46r56
         OvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728583972; x=1729188772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j2Ikuhi33gkCIoLfXtInuXs32ry1GdG7/p1R2O08x7Q=;
        b=S0Wo016mg7qHSP+2CJQBqthGXntjetWI4vshebLQRNnd53znu4aIh+GMzAp45ggsUC
         Awbo2451LZ6pUQOc9JM0mXcNvC7O6M8x6GemT3naVBcpGczh/7hvK7ny+A8pEBEAIS88
         VjDd3RQ7ri24w4L1NEZYVjZi+TVuMjR952h5Seia7ryRXjfXUjd7mY7fxG4f07tD1Gxd
         fMfC4gngvwxdnIgzoqY1lySQ0DkWVlRjHFEIvyhpczF39/vSiYUk+Ia7qUBFngXnL7St
         RBbdrjXqeOK1lmrSLaCDP90PgBXEBdwrfrzcb/P1d2zg34Gz7278dv/Ry4mxkZhHZuzG
         gbKg==
X-Forwarded-Encrypted: i=1; AJvYcCUqwPA+DdRahF3OtOBf6SGrmAp+7/Yn2wGIkuQKwWdQtgC5a7jAL6r5Fxj8KNCVb4nzzCY3yRlYaA1aI/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNjbxuBulLieIaBPCKvpUmqrjYjZefjCtV0NiMsb/3rf+sqRW+
	1SG1L+MtE/7P1u8A4sWbo8rQquBKRfDnVLFXJ/gwJq7skeMIFZrkKsITqGIdI7OEspx1m4EE6Pd
	2w6oFjQ/Dj1Y=
X-Google-Smtp-Source: AGHT+IGrb5VGtSEu9KmvvevlzQDjJSErZq0lhnojNnBzr72kJlQ7bv63piP0wdViZzr+N15omjEafw==
X-Received: by 2002:a17:903:244e:b0:20c:5b98:8cd7 with SMTP id d9443c01a7336-20c637f84aemr120365205ad.38.1728583971732;
        Thu, 10 Oct 2024 11:12:51 -0700 (PDT)
Received: from localhost.localdomain ([81.17.122.16])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7ea448e468asm1306575a12.4.2024.10.10.11.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 11:12:50 -0700 (PDT)
From: "Everest K.C." <everestkc@everestkc.com.np>
To: akpm@linux-foundation.org
Cc: "Everest K.C." <everestkc@everestkc.com.np>,
	skhan@linuxfoundation.org,
	linux-mm@kvack.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] mm/execmem: Remove logically deadcode in execmem.c
Date: Thu, 10 Oct 2024 12:10:58 -0600
Message-ID: <20241010181102.5522-1-everestkc@everestkc.com.np>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NULL check of variable `area` within the `mas_for_each` loop is
unnecessary, as the varialbe `area` can never be NULL. So, the
`continue` statement inside the if block is never reached.

Remove the if block that performs the NULL check.

This was reported by Coverity Scan:
https://scan7.scan.coverity.com/#/project-view/51525/11354?selectedIssue=1600362

Fixes: d44c3485820e ("execmem: add support for cache of large ROX pages")
Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
---
 mm/execmem.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/execmem.c b/mm/execmem.c
index 9c6ff9687860..97706d8ed720 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -75,9 +75,6 @@ static void execmem_cache_clean(struct work_struct *work)
 	mas_for_each(&mas, area, ULONG_MAX) {
 		size_t size;
 
-		if (!area)
-			continue;
-
 		size = mas_range_len(&mas);
 
 		if (IS_ALIGNED(size, PMD_SIZE) &&
-- 
2.43.0


