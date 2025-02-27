Return-Path: <linux-kernel+bounces-535590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A96ADA474D6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F9A7189124F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97E1232365;
	Thu, 27 Feb 2025 04:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UhkefBHV"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3117230242
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740631087; cv=none; b=PnTgp3uc3bzz2Kjix2mAznORV12vRxshdvxBzCp8DiwxfiiCSPM6RmCo0x5pfBv5XFFOHyYEFgHq0wFMsw9v5/tLcay5+Tsudlc2A8ceRZvIhJXeeirU6lus7y/nbpsa0edDJFQZKk7h2z1FBKupiC9ayIpV1S4lha64z0y0Brc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740631087; c=relaxed/simple;
	bh=W31aHz42Z/T5ZpbsLubBQm+2xkwzX3XN0l4V3Rn0VQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nSCUcgCeUjehoiUUnmnucum1Lkui8eTuJIehcu/BwH7J0a4JnRwJAUeVMG+w5+PLIkDrp5DSTz8F5YP4k/jSX/2PIsNsZUS4F4OotibQueK9sjYXG8vxjxxL4n6GGUuV4jxK5sLZYtgSMr6kljldxJrcpGuDNtlapDKgO2WzeqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UhkefBHV; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fea65dcc3cso566810a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740631085; x=1741235885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Z7L+E0AxAkJHYT9s94E/nR5ku/ie8tNmkgfIKxsvlQ=;
        b=UhkefBHVdCIsifzaBS1fW7KMPVCa1OjzaB6XI8yonREKNEV3i5hZhJ/G2HPU2e6CT6
         q+P6Oo5UfL77T+IDVK0F2vZf7NthrEKEm9Ji8FJv1rZ9G+w8wjGixOthJn2wQmGW3x+b
         n4l5XPFwnKVkS7AV0dvf9AOGS4tT6MllfgM/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740631085; x=1741235885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Z7L+E0AxAkJHYT9s94E/nR5ku/ie8tNmkgfIKxsvlQ=;
        b=sLDgkpI+dIBECUT7864pHlUeq1QBNhfaIC3mio5DkIBc4o55OF8EpyYbMUzzr40bJV
         jJe8VCP0lkMrNXjR+1OL/WQGl6Fdm2omv0FxobQ2Yl5s9GK17wIjz+x0PbUiqlwpgSlq
         eMqoznfTW9I2IpUkoWhrsHC6BMceEoqEfQdQDJIgtmHct5q/Zg44JyBcitQpNOdRxUle
         TsmmKDUpCNqVfWcGKRHfST5zjBonn13ooPSIDGnpx7g4dm9EGiIBBZkz6chEeZDTVFyL
         q87SGYxfBCcF049JwKy/2mLspikeerUvZuo3fJ9P9Fgh7Shp7C1OS12tXi7DN82DeZtT
         Sp6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZfudPXu3Px6DSm/71Bfitv+FKAOoprz1oU9zI338qPc7FH6NwYCwEFS4Wda2HdLuV31lfHF9T3Cqy224=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQEN9fkF2qymywEt001tSozmHvpeYuZeCXuUfUmkjHdBAf1YNd
	mp8Sw7Qwm6prUhPCRjmOAT6iF+fT+SgQrTEUdmnThckxbL1uRUsD4TRV7lZLNA==
X-Gm-Gg: ASbGncuNXSEEbllHcEZkmCz+zxSvTJobh5nV3VqktdL/bUmme88Bkews3WAB+6Nka6u
	H+Ko8HhNYZHw8TdUrl0J+UUVJ7zC/J+JWNumYxjbWqhO9/FpcgTDGXvV1NFAi81plAxwUjCVBtO
	oAm7UUfjjjdJieLYEVIcmJ++JAM8avm5XyPx6qM5/qJ9HJjXbVC15HuTbzTUnIcS/ZtxqT7wRup
	fFYCQFlx/Scjut5hx0ouYRKOOfA7pPCt0ZjwfFh320KRFuxCUGyTkOMjoD/K7DZ6f4fka+XJAGo
	MFp008xr8EAi0ciF/Qi24K9vOYvh
X-Google-Smtp-Source: AGHT+IHkiQZTH+QyI09NsnNe2+VUmytHTF3AQc8esT3P6nxO5c5MPzYujs2/5+Dmg9L+ktNJZYSfyg==
X-Received: by 2002:a17:90b:548f:b0:2ee:5958:828 with SMTP id 98e67ed59e1d1-2fce86adf6cmr41590472a91.9.1740631085050;
        Wed, 26 Feb 2025 20:38:05 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:a9c0:1bc1:74e3:3e31])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223501d2901sm5005945ad.30.2025.02.26.20.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 20:38:04 -0800 (PST)
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
Subject: [PATCH v9 17/19] zram: do not leak page on recompress_store error path
Date: Thu, 27 Feb 2025 13:35:35 +0900
Message-ID: <20250227043618.88380-18-senozhatsky@chromium.org>
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

Ensure the page used for local object data is freed
on error out path.

Fixes: 3f909a60cec1 ("zram: rework recompress target selection strategy")
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 1e2ba3590a39..e8375fcdb36e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2013,7 +2013,7 @@ static ssize_t recompress_store(struct device *dev,
 	struct zram_pp_slot *pps;
 	u32 mode = 0, threshold = 0;
 	u32 prio, prio_max;
-	struct page *page;
+	struct page *page = NULL;
 	ssize_t ret;
 
 	prio = ZRAM_SECONDARY_COMP;
@@ -2157,9 +2157,9 @@ static ssize_t recompress_store(struct device *dev,
 		cond_resched();
 	}
 
-	__free_page(page);
-
 release_init_lock:
+	if (page)
+		__free_page(page);
 	release_pp_ctl(zram, ctl);
 	atomic_set(&zram->pp_in_progress, 0);
 	up_read(&zram->init_lock);
-- 
2.48.1.658.g4767266eb4-goog


