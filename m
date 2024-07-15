Return-Path: <linux-kernel+bounces-253043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD78931BBD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 22:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77269B2159B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 20:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58CD13C3DD;
	Mon, 15 Jul 2024 20:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H3RxzQnr"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09A17EF04
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 20:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721074990; cv=none; b=RPinVQE4l9VNwFcb+wSWvn8XQkbwAajFS4bEl4N+9jv/skpP4k6doxxOA4PA5bJbx9hkh1H495wGWm1XfliaTagjpNdE3AO71eBM/AKZnTQjQ36AJ4tRRSa4yA8q3cv9mVh3zTz34NCIkiijNF6KtcoCJWpVWX/coRIsKQgCNuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721074990; c=relaxed/simple;
	bh=wKcJC/TQQJ5hsiRXBQE5LgixCLhnnv8Q1ON9MKB1yLI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VqY+wenptSyl/FwEXOJSm8YiLphrOLC5aSFWDF/8L3pacvn/YXXFZVLfhdm9myM0cEuK21LoyOXYDxndH4Lycw9KLwyKuTW32AtJrGrQBLSMdk+ULi+JWZvaXgl92Zz0syMsHGdWydkj+iWuA8nC8800TxMfd8zMHqkxruHI+a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H3RxzQnr; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3d9dd7e5f6eso2127566b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 13:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721074988; x=1721679788; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/M/SQ3yhUFPnWUkqHtKb793cWpyAWaWiy63HuW6xq/w=;
        b=H3RxzQnrOwf5/PALmVFjBaKVhkd7iasuaBjKhcfuz/hU6GDi3Ox4iJIeHntEZWj/bV
         8LVd5skXdR8aPFAHuBkgYUqOua0dLjJOdGM5X+VRn3p6rpso6eiLYnsKbllwKhiUbJ22
         KRlHBtG/ffCqMcr34ngt8RUFDRe1pSsyH/HiaVBFyXj8oert7dJPeOVCPrL5/8rKnIAV
         qTPXcHPbSLGOsWJukUjZgG65YKd5uMIuh57BdfDeoxNsLZvEfJE9recFHgcVCfV2BT/r
         GUyQCPV4dXKRLoQrv44s9kF8eATTNKlfjwigCz3DrMD+5NdgQwEaOsjgAildOl8mEzjt
         9iYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721074988; x=1721679788;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/M/SQ3yhUFPnWUkqHtKb793cWpyAWaWiy63HuW6xq/w=;
        b=LJdO+EVIz3ofeWMvx4qXA6jYO6sJa79KnMwxknqSmOPIJUlA5jNXfa/npOmHVxaq8B
         QkEdA+dvItVRPzYPlnFYExleyIdkUGOVLhwHYsVx1h76iHgegCxyzOSAtFdBO5FdO9xw
         cxJm/xo8TWL6ESTxmhc717OupSm7mYKkbWp+X2ew+xZhjQ6vrGvJfcqrdljKhrh4qS3z
         PXs8VUTAPq/Y1Ic3nFzG0YG8CIy+rATsAzC9Z+5vUsaGXPjEseGkZtOmiPifJY6qDzg0
         5+Y6XP+O3ox7sw5Uq2uvL41zXJVOq0gPPnsWBqf8F/kVBQACivqM+ek1bxARaKMOIdty
         un9w==
X-Forwarded-Encrypted: i=1; AJvYcCUmGRuq0jCcvQqh1DhqEB1NAivMNauejVhH4NLuQWkfXfbgta0n+3mtj/B3YIoQMuDlhJFgYpmBQZ/T5eAwVM+TwBfNnUGcsYNrS7pb
X-Gm-Message-State: AOJu0Yzx+hc6Y/LMbCT0PiyoDY/NElAFpulEBZqCtTw7JsHo5FdG9pfL
	0PQSa5xedlho4owQN/FzUQXE6jFE79mvL7NKjogcl/rq1MvR2/O5gzbrGFMQMsd5XDh5nG7bJIU
	6
X-Google-Smtp-Source: AGHT+IGPdWkVufwnmw9GbYLmNd5GtKQPpIudgOzgzgClCWdsuROkVbuwHwpLSNGGoexh8AYzwac75w==
X-Received: by 2002:a05:6870:6587:b0:25e:1061:6541 with SMTP id 586e51a60fabf-25eae75e8f4mr15351092fac.7.1721074987780;
        Mon, 15 Jul 2024 13:23:07 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:750c:19a4:cf5:50a9])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-26075176228sm1068955fac.29.2024.07.15.13.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 13:23:07 -0700 (PDT)
Date: Mon, 15 Jul 2024 15:23:05 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chengming Zhou <chengming.zhou@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] mm/zswap: fix a white space issue
Message-ID: <c15066a0-f061-42c9-b0f5-d60281d3d5d8@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

We accidentally deleted a tab in commit f84152e9efc5 ("mm/zswap: use only
one pool in zswap").  Add it back.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 mm/zswap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 66decab33d14..adeaf9c97fde 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -803,7 +803,7 @@ static void zswap_entry_free(struct zswap_entry *entry)
 		atomic_dec(&zswap_same_filled_pages);
 	else {
 		zswap_lru_del(&zswap_list_lru, entry);
-	zpool_free(entry->pool->zpool, entry->handle);
+		zpool_free(entry->pool->zpool, entry->handle);
 		zswap_pool_put(entry->pool);
 	}
 	if (entry->objcg) {
-- 
2.43.0


