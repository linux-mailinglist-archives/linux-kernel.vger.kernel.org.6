Return-Path: <linux-kernel+bounces-510584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FE0A31F10
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38AAF1883FA9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 06:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50381FF7D4;
	Wed, 12 Feb 2025 06:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PUevrnX6"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5801FCF4F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 06:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739342009; cv=none; b=l96VZ6KWNATcOMa5h9htTJ7W6scefAPwJPpskK497kP6QlSYlRBCO5AixvdTEwJiH2VVQb6cvt1wFUrJTa2jxhzaa86bbLuR6vSl0S9jwmc6u19Be72Fi7PBx3lPvsDQ2GbBOur6x4intwJTgHVPLB50326u96ZetHL6//hQVck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739342009; c=relaxed/simple;
	bh=Axm24glkz+ptvP6aGlVEW9BVP4weLfzYaUzPtrth5jM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AqNyhMD9DL5c6smJ2NvR6QIa9Wz/yS43cbMMDV3EbyYDDMHYsi9hKhrKGq2rEQmzeROWsR5igDfcVYFEW9y37+r1ifkEYlBj+k+ShD4t9jguTva2lAT+0Qfm+cslEKyylonhCXRi0+1+wWgaQUBWRhGg5tBNSLBAGgsU0tbp8Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PUevrnX6; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f44353649aso9490939a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 22:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739342007; x=1739946807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8HQ6KKZTY10gG1FVyTeRkLW7p1KkTSFkDVXwYemgoI=;
        b=PUevrnX6/eVrPtzTPOcEdWP6ZrbDNroSBhI6Q6IE+Lmpul95SMtpgPkJnL2Mg3tfwh
         TvY1EKtH64Fwcrddn+IwNLW2LV9CWK6Z4T6PVmgp5qJSzNI7EFrzN3ChZUMRHBqpWsKX
         t4yCYGvnfGov0PwsxzZy6PvyQJNRljc1+sits=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739342007; x=1739946807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8HQ6KKZTY10gG1FVyTeRkLW7p1KkTSFkDVXwYemgoI=;
        b=dTFZzmo3ynstd4X0QA70WVhS09SNgb2aDA06siVrECkgDZxkjzptWYF0FSqDbjM8yE
         /3Mb9YSCOOd05WZVtDnN5wAicZgb/0s/HAUjJmTPrC1DrVWxnt+jLfefuIKUuyThOLSd
         X2kiq+WP62AC8mcKycVWlRU0C7rsGUAeY+kTLraTAn1q/8izRoHfplWCia6rsVyKFCew
         lpj4bxMCeVHsf9tzysXBRpuY8zD1jrC/Z86h9UdpzkB8LGFsATnwdzW9apqhGVLcEY/4
         RbiDDHLrPCmWxBjxR9K0mfXu9ZloqpCV7aSht4kDMYFbw7hHqpA3ALmmiYFOcOsRgITw
         rjqA==
X-Forwarded-Encrypted: i=1; AJvYcCVks2OeamlZ3TBMbbpfToud4B2kyN+VotbC0pAHTE4GfoQF6wU7+xxMGoqxc81QtArm4WCm8d7HspTEnfk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6uzTS409+u8O3LciiiVy0E4tIOdMc9w3vHgfVOxgt8DjxfKvc
	gQ1N82JyO9+Lwh0af91015HCqjzWlKa7EYSOYSEZfrgZE2NVr66CkRbFdEPIoQ==
X-Gm-Gg: ASbGnctxaDmQo7lwFzf/dxxM9U9CFrnpCQ/3Td9Lz9FRqL35TvzvQVvvtIsvkdpyiM/
	FpXn0t3rMeR0JdnOU0p3blmqnZsFLtFmLn5YN56NMqS98Km0y2srSudhFSIDia2b0eSiyz1xHQx
	HID/VmBoUERyPoAueGUcirk15hD7sJhyfjqUmxh2Q02g3TI8IXl1SCRCNx+4kpWiKHL8Mehs6me
	8x6nBkXu9VbKOXET9SYb/PfNu/mf7QhrtyRQ82Rog0n2xdGbbokKEWbrK9exQDzf8cxc9Fmnj01
	XMA/T1adVA3Mwk5TVQ==
X-Google-Smtp-Source: AGHT+IEQRw5PJmq7wTBgXFBNQOsAEHuqWdKMzAKbQj8udw0upyNAtfwplObq30KxfZI8V98xY/jwVA==
X-Received: by 2002:a05:6a00:22d3:b0:730:8e97:bd76 with SMTP id d2e1a72fcca58-7322c591b87mr2706438b3a.9.1739342007145;
        Tue, 11 Feb 2025 22:33:27 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:69f5:6852:451e:8142])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-730851fa25bsm5556237b3a.180.2025.02.11.22.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 22:33:26 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v5 17/18] zram: do not leak page on writeback_store error path
Date: Wed, 12 Feb 2025 15:27:15 +0900
Message-ID: <20250212063153.179231-18-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
In-Reply-To: <20250212063153.179231-1-senozhatsky@chromium.org>
References: <20250212063153.179231-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure the page used for local object data is freed
on error out path.

Fixes: 330edc2bc059 (zram: rework writeback target selection strategy)
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index f4644c29f74e..10239aea5ce0 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -787,7 +787,7 @@ static ssize_t writeback_store(struct device *dev,
 	unsigned long index = 0;
 	struct bio bio;
 	struct bio_vec bio_vec;
-	struct page *page;
+	struct page *page = NULL;
 	ssize_t ret = len;
 	int mode, err;
 	unsigned long blk_idx = 0;
@@ -929,8 +929,10 @@ static ssize_t writeback_store(struct device *dev,
 
 	if (blk_idx)
 		free_block_bdev(zram, blk_idx);
-	__free_page(page);
+
 release_init_lock:
+	if (page)
+		__free_page(page);
 	release_pp_ctl(zram, ctl);
 	atomic_set(&zram->pp_in_progress, 0);
 	up_read(&zram->init_lock);
-- 
2.48.1.502.g6dc24dfdaf-goog


