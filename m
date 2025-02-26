Return-Path: <linux-kernel+bounces-533269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D320A4579C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38147178F08
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D7E258CFE;
	Wed, 26 Feb 2025 08:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8Ke4lcF"
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EA5258CCB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740557059; cv=none; b=jbtk3zK6lbLFp6Pk/t4wl6iX4qIap7apzRVq5/8HXCqMyraO9bOek9DpGDtLa0/gFVb+/6Unn1IjUKRYolcR3PxsxeHQx1QjFFCTLl6NGcTU6hyuAhydi4HKS4lpKSRD9ANPLKbUcySzQjRtAytlSXSe55VNKDTiE8DhAaYxth8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740557059; c=relaxed/simple;
	bh=jsumqoAZtsnV93FqZKBwSFrqg/j51Y+YhAKy+e5uYxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gS57VCfqGlW+LTXb4BfV6CXgf1YOyJIun+84G/fyst2z0uJT6YxL0C6ypoG2XTxTjve0QNDewbZxqu/BS2JsxlTDAAesE9AT8LoBj8ntH88ET2+7/svXW8XB4mF+SLWIUI73vzZcPv5Go6IejVxFwYLTffR1dlzaEZsiTXJzx9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8Ke4lcF; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2fe82430bb4so106257a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 00:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740557058; x=1741161858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uhge1RzCIgKYICCXPIteVGJArxw+qifw/5nzfDaF6yA=;
        b=E8Ke4lcFLCK38xQ+1IRrQ3QLwpiZNZWObG0LFkwocG2MfwkgLA7O5b9WdKevxSYZG1
         G0M96nbJVkJ4bzLfhkN7FUkt+O3Db+9YIbczF6fFBogFs7OPrS73dBE+3M9niklqchj9
         coXqcAQhI++fhRzNbeJJ5jKR9+jq0cEinRTrkTBB6b42S5+7gpSrdN1FJs5GQReUwGiy
         DfC6wcZu+Rn7INF2tLY/L1BZSpFp7nnoUqxhBh89dsuC1WZ6wIYrFW8RzAJ3X4WgaJmn
         g8rMUCcaYIoGThFre6neN47gcaiAq2wNNinSqCyoj7GMxT/DxiRjJSWNo67WhZ13sMxu
         S8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740557058; x=1741161858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uhge1RzCIgKYICCXPIteVGJArxw+qifw/5nzfDaF6yA=;
        b=jJIcgXksaHiA2VY8x3++ZpOlAQIN97NtHP2O7/b90ibeLSxG51xzMaqodh978cLogb
         4LDpmwERP0Ss2yGvTfsqD2MGAeME+wnv+aGXFqesSQMLER7yJev/ieAwLR9CpMs3uMRI
         17wQsw6Dkaf5ASIdEJa+4r7jvnV50rreMIP1RhjpYKbzUzZYS5iM4wEbEW0Yx0Cn126E
         DG++mzyY+9EHAdrAy8FyzR8m4MUSKsNsHerUI75pfURZJj+Yj28vZWvxpTTZDWrOdOZY
         dbIazV1spEQXdwxUaGHsocR9rMc/SszNMoUowgPmcTqLUHk8jlOKBLfcP0Ijc9ifReI6
         INLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtmYDqIWVJKGb07ErgktwtfumWtFhb8Rac6kMtmegfuugYZFivhl3BOgk+RBNJSKV/rjsqQzU19DGHmJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjIa1GE6iTm74LEaM/nGMurb0e89sS65TFlrmfgPBFfpsWwfma
	HXG8sReYEh6LXiFAfNz9kRUwhwctbfXOhKfavcNCe1kwH904ldnG
X-Gm-Gg: ASbGnctNbcDrGVgNNE7HQnbWrfeHoIXp+Loe/cyfLe5rAGaaZ6ASUByHdttjZLoMvep
	vZr/gTnQv0JTvQWWwraJr+LISuxziAknOOphEARm6rAE54z8RADEExHPkuRtb2H7HFkyZMrbuVE
	S6VHFNduFeSNWOVMa/LPu32dlRCUVBPS+B+XlYIOtdxK1exr/dpjgx3AvYUYMJJv3NOy7Ix1Usm
	FmpkemNqFdx/cZ3VacrRg+zXt8L5R2iEx4LEICw28yh6huPBMnI7TdUOCyhVPD+xE8yUkTaxZSe
	6Wcjf0W8xpoqm3WpCTDLntmvebM=
X-Google-Smtp-Source: AGHT+IEDDzTqf15l3tFjA018Ley5b7a6ScYZq99mwQ2F46rQF4a8741e37Wl35PpKDxXeG3ScOoXFw==
X-Received: by 2002:a17:90b:1d84:b0:2fc:3262:9465 with SMTP id 98e67ed59e1d1-2fce7b4f5dcmr13725402a91.5.1740557057730;
        Wed, 26 Feb 2025 00:04:17 -0800 (PST)
Received: from SaltyKitkat.. ([2403:18c0:5:400:bca6:d6ff:fe8f:8ac0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe825d2ed3sm844156a91.29.2025.02.26.00.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 00:04:17 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: nphamcs@gmail.com
Cc: Sun YangKai <sunk67188@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org (open list:ZSWAP COMPRESSED SWAP CACHING),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] [fix] mm: zswap: use ATOMIC_LONG_INIT to initialize zswap_stored_pages
Date: Wed, 26 Feb 2025 16:04:09 +0800
Message-ID: <20250226080410.10433-1-sunk67188@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is currently the only atomic_long_t variable initialized by
ATOMIC_INIT macro found in the kernel by using
`grep -r atomic_long_t | grep ATOMIC_INIT`

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 mm/zswap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index ac9d299e7d0c..23365e76a3ce 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -43,7 +43,7 @@
 * statistics
 **********************************/
 /* The number of compressed pages currently stored in zswap */
-atomic_long_t zswap_stored_pages = ATOMIC_INIT(0);
+atomic_long_t zswap_stored_pages = ATOMIC_LONG_INIT(0);
 
 /*
  * The statistics below are not protected from concurrent access for
-- 
2.48.1


