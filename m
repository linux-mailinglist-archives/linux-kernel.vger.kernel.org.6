Return-Path: <linux-kernel+bounces-535568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBC2A474B0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1BE17A5812
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE591FF61A;
	Thu, 27 Feb 2025 04:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cWch1WXE"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30161F5855
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740631026; cv=none; b=LrPhoa44CrC8jcRN1BrRCXFeE1OmAJEgLRzHKcHOvQHKphSXHBOEzlvP7iTEeDoLwdaPdxCIjUjsNtq4mobmGmS4QONtLaQxm20NBmGsXnwFo/LPDRNDkY16LPgmPblpjpoAuUltjtd34k9do+vR4pzz5T6bsXp3bwDiLKKaqqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740631026; c=relaxed/simple;
	bh=kDJSeyU5s05UEQ7rAR19C1RuUhlLEkX2VbKYXWUOEF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EJjf8x4Jj34Shem68XNq/x4jTrxh6r2ZsR+SRTvfgpQrZpp8w38sgbMcbibd+loD3N2KTMUNPRqcDQUYC/pTzwW1F/iPHArSRehJcnAIKVVuwb8Xk9/62a4SThSPS50tyOCEE+o5gqYYmcFcT90xHEKkxec8qKuiAwySDOg2rk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cWch1WXE; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22104c4de96so7258245ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740631024; x=1741235824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vr9FTPnbuS7T/s7kIrPcS+bzGN5VDCIRcXkQbYpH7iY=;
        b=cWch1WXEJTG8y94tPPgMdJKuUWCo87jiQ1VLePijCjURyMelSk0b/LU6jEahUiLp16
         l+wBcw+wCUl9L8Fi4zOMqXTBcii89BuQUox3pdpLrz/VTcOnNOBxNcArwVb6067BRV2C
         OmUCTWcMVCihAC0R82a+g/FFRFT/T9ojC/5Mk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740631024; x=1741235824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vr9FTPnbuS7T/s7kIrPcS+bzGN5VDCIRcXkQbYpH7iY=;
        b=k7TSB7VxjOmNZk9XaXzAifZZAmcEq7FYWlEVm6zWrYqe532cdh7Xewda4QTZB/6zVc
         RvmmUhW+JScCLiQnRQXSLhCpzT5KOwt7mirSRRMxqxgGdbBsRG2aUFU1CBhyfwYIwdqf
         u9dzJXRuBfuBvdhnXCwKq8oHgLC1dRbT/QS9fJBTdfisAWBkG+vi+vNicEJX6z5SLJ0y
         JwEkFF+zDWSYWWqsChU9YkoPwgwmjvKCMAbnYxO04ruCMF1NXy3Bv/i36PKlvEeHAh8i
         ELTnYyBNadSGbFLA7wnyvCsCahHaxb0ni9zPyjeYHdxyhVHsU4HhWMFCpgnZdFRbjXR2
         CaeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMZ3SF51rndBBhmNAjOd4u55eMFXRVotEAjmzWpJXEt+oX46cNT6LOm5oI8YPNTuVR+fLj6lMHwlSa04c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVR8fp7BnTU1EMzvNdfw6DKyijOfBx8oepnLoeFcMzNfQKYm0s
	tZ4whBt7P5f2dhP62FAwb7esrB/0i0SaIpTwMXDuFwsoJ1zbqVn5mZI1PgRXyg==
X-Gm-Gg: ASbGncsOopTK+PMuwQHVqo6WdgjLsjNGHAYngVD/TVdjJwMr0F5cQ7UEI+L1xvqVwN9
	qLGCGSO2nXVUT+bfWczSRQBIF884RdQUJsYQv2c1Fq5tQzcYTknpoXJenVshCP3bUiZ6TKTPj4E
	BwMduQpco83rgY7P1MLEWthNOX/kzPpxEpeOGZMd+kxK02wGCgDgwYeAf3io79FBsGSnm2eyY1/
	8KMsBkWphDZM+VjPvUa4mwyewBEA9IPqGz+DFfYoEpqKw3A3reOpcJc41gf3obxeRWc6rq3axJ6
	RUiJ6AvTeVgISdCN46ly6BSEX813
X-Google-Smtp-Source: AGHT+IG7lkAWlRB5fX++3hFsx9jC6B8UxClPPlZOhyWNT72+u/H7C4m/UOugG8H83NzmmgRIdsxc9g==
X-Received: by 2002:a17:903:22c7:b0:220:cd7f:cde8 with SMTP id d9443c01a7336-22307b5b218mr158250195ad.29.1740631024159;
        Wed, 26 Feb 2025 20:37:04 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:a9c0:1bc1:74e3:3e31])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223504e4d16sm4908435ad.189.2025.02.26.20.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 20:37:03 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Hillf Danton <hdanton@sina.com>,
	Kairui Song <ryncsn@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v9 06/19] zram: no-warn about zsmalloc handle allocation
Date: Thu, 27 Feb 2025 13:35:24 +0900
Message-ID: <20250227043618.88380-7-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To: <20250227043618.88380-1-senozhatsky@chromium.org>
References: <20250227043618.88380-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We normally use __GFP_NOWARN for zsmalloc handle allocations,
add it to write_incompressible_page() allocation too.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 28aa1c437d83..08fc9821d71c 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1691,7 +1691,8 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 	 * like we do for compressible pages.
 	 */
 	handle = zs_malloc(zram->mem_pool, PAGE_SIZE,
-			   GFP_NOIO | __GFP_HIGHMEM | __GFP_MOVABLE);
+			   GFP_NOIO | __GFP_NOWARN |
+			   __GFP_HIGHMEM | __GFP_MOVABLE);
 	if (IS_ERR_VALUE(handle))
 		return PTR_ERR((void *)handle);
 
-- 
2.48.1.658.g4767266eb4-goog


