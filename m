Return-Path: <linux-kernel+bounces-179562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C70EF8C6175
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 09:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 795C9281323
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 07:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0B35B5D3;
	Wed, 15 May 2024 07:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LO5Z3Q9t"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D16D46424
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 07:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757446; cv=none; b=siUYfTuTx2o3noe/YEWKtjJ5uaLlL06UyAAWfMBApZlLJI4DLfoImp2AUPV2VEJldGD4F7nxjbcR+/3kVQjBSTpbcpUDuPp3R2l19+gW0G+KE70FHIO5JsvWXik2Yh2bYcvSHLQscgyEK7M6yM31bpGYk117yPvEnKJJwBFxSY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757446; c=relaxed/simple;
	bh=YnHUtLMZwpVLI0sVuuwwM6o13HO9vMtZxnKMkrUR/KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q8yAx2i7V3jL7gZ6CjhdNFohi0+xDnftPn8YEeE9bexwYq1w7lZlbb0Jt5oqRGsNSN8jzEkpoaZEZTS4z76cf+f2M5RJQzzZmiDm0hZrgPh+RZ1f1U+ZHBV17M1SdA9MmCIc7EK1uhXH96tzKgrwmCJWj/NNTK51vm/3fJFosu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LO5Z3Q9t; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ec486198b6so49882595ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 00:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715757444; x=1716362244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKVs+B+0cyVVZhjjQw1NRD02y131beAoNCpGUQE22Zo=;
        b=LO5Z3Q9tbMtRLgU4hrriUYiXGWQbatUGRHUqdFQ8GmElEulIilhJdczdqhlD7j24r3
         Wg/vfrFw+2UCMJ192IWDIvfpG+JpW2wvHIka38x8ZEDgoMHGJpXMTOQjr61At/weeEUp
         M46cAzb6F+/xfEPCrEstxU8oArfne0fJ2p8As=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715757444; x=1716362244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKVs+B+0cyVVZhjjQw1NRD02y131beAoNCpGUQE22Zo=;
        b=SoyS/zzTXh/isNh10b4C0ZXkkh/KIJ42NFPsKfU599lIniYibUw70Zb4SkhRNG1Rp/
         OUPi+hriPjUOD+peJ4lB60LJLfIB4geVuZ97evENJF90wKuWT8jJqxJotyqfdlUpxDcE
         7TUJgBZTzJMIIYHyEnuiJsS5l1MeZMaB22zKifMFSdGCHuCGg5pb8sVDSc1IBEkB06/C
         xC4SL5HyBuUCnoqKTV46RigR5p6bOBKS35FbLKWU6JQ0hyXXOxPxeQ6FILRThJGF7Z/K
         qj4WDNK0ctrIOw1xpYWoylqPFnscsFAmIgwRg1/Bq3NdeM1JKoIIbIziV9F/DXFoeulN
         T5Uw==
X-Gm-Message-State: AOJu0YxIXo+iSTjVSlBSD5a0/NMtcr3FkgbZqN6JXYG2EGYXv2QiMR6T
	IREZXU+VlmYBIz8TqIEAAdHxNQc1uzcrzFy/1ppNFI56Ox4PRhRcdyWDAHQ02A==
X-Google-Smtp-Source: AGHT+IE8qiXvQd9erZoKg5Z5UhnAOTEuylXJnZ57+lB5IHA55FEIIAx2uTY4ujRkG+u9767ycaP2LQ==
X-Received: by 2002:a17:902:cec3:b0:1ee:b23b:ad5 with SMTP id d9443c01a7336-1ef43d2e1e8mr177002205ad.5.1715757443909;
        Wed, 15 May 2024 00:17:23 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:111d:a618:3172:cd5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c136d53sm110941605ad.254.2024.05.15.00.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 00:17:23 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 11/21] zram: extend comp_algorithm attr write handling
Date: Wed, 15 May 2024 16:12:48 +0900
Message-ID: <20240515071645.1788128-12-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240515071645.1788128-1-senozhatsky@chromium.org>
References: <20240515071645.1788128-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously comp_algorithm device attr would accept only
algorithm name param, however in order to enabled comp
configuration we need to extend comp_algorithm_store()
with param=value support.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 75ecdb885d91..7eb500c8fdaa 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1013,9 +1013,33 @@ static ssize_t comp_algorithm_store(struct device *dev,
 				    size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
+	char *args, *param, *val;
+	char *alg = NULL;
 	int ret;
 
-	ret = __comp_algorithm_store(zram, ZRAM_PRIMARY_COMP, buf);
+	args = skip_spaces(buf);
+	while (*args) {
+		args = next_arg(args, &param, &val);
+
+		/*
+		 * We need to support 'param' without value, which is an
+		 * old format for this attr (algorithm name only).
+		 */
+		if (!val || !*val) {
+			alg = param;
+			continue;
+		}
+
+		if (!strcmp(param, "algo")) {
+			alg = val;
+			continue;
+		}
+	}
+
+	if (!alg)
+		return -EINVAL;
+
+	ret = __comp_algorithm_store(zram, ZRAM_PRIMARY_COMP, alg);
 	return ret ? ret : len;
 }
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


