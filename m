Return-Path: <linux-kernel+bounces-345577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E1F98B7B0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ECB22817D8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C04919AD8C;
	Tue,  1 Oct 2024 08:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n6emRMeX"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8A15589B
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727773006; cv=none; b=FlZkygfR6lH+ibg1VpH6tSvIRPP82rkzNl70RXczpqAtV+rovtK8nMWL3Y4q4PJJDj98ac0InDgPpSC8w8vdykGyRRjMfN+2vIn6jXxGDhEkNI7T02Qheluz2K2aJ2VKrmZwgc64syrSRnfpNCtyvRKjcN9W+x3SElJ33NOrTWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727773006; c=relaxed/simple;
	bh=Uz7vQ0GSltZT1cH+/gHWYTyPUrHXLVXUaaMhqLl8rr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+jnUbeSP6V44lKMMCJ3gdcGGQKUFnFQKIDCi+LNESnGF0f64KGaM6XCLF4H8BT4Rx+eIZUZ4seJbMwhPNhMxODtgecqFWvFSHIs6EAWrQIqog7SPXD3Fd3+igi/G0EULp7j38iMSDahwZGl4866exNzqAei4pKc3x99DzJ2jaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=n6emRMeX; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71dba8b05cbso573670b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 01:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727773005; x=1728377805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxKdqDDU6tXvn6MTmJGK79jkley0heKGAVs1SAb6T7o=;
        b=n6emRMeXtQ2laQiDW9T1ZS80lujPvlV7ktF9iddV4ScNZ9KGItOD4yqWpyEp4PI/f2
         2DshHdSP7hk2v5PYBbrw+5Z5cjFGayH8I5SXIIvXfdx4mUr7mUebQ6ZOtKFDzp12lFXQ
         x+Z0qPldiODD0VNmxdWOP8FYTQb7ozKri9xyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727773005; x=1728377805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PxKdqDDU6tXvn6MTmJGK79jkley0heKGAVs1SAb6T7o=;
        b=MhG3Ux97Y/a5AZ/ZXNQSc0z+ce7tEqYcMKKHE00sl3oIrGZxASi2+mH2QdehJandNt
         gxczndtQ1zwBeQJ1UV4EWDeEB3BslOd3oQZ+XRaatdywey2hxWedhOSCPX1Et/KS64OH
         ieSdmGWZXLDrNJMFCOSgyBQVmT8mLrzBdOXnSbhrtYJl1zB9bwEI1/cfDpgCo3x4l+be
         VwOaMd51TCJy7udSRqa1nyTS/1UnpfmX9r0YZDYQ3W2xV89xoaKs8p2DZ2uUYH1mnhyQ
         94VYPOq53nlyKrpp2MpQPSAPv9ntDWQkR4OMatCWa4UdAL16NxnbWj2CwXlCdK6iscAJ
         IPQA==
X-Gm-Message-State: AOJu0Yx5aaPtQPQygGj6uFGIRCZA41J6ARD5CF4aN/9xYdTLbo3GBL+4
	XhwOwoHQHFt5kO43OYhG7NInj0ax3j7FeaTFpAQUYWHOkbyKxzkNQhd8yEtaFg==
X-Google-Smtp-Source: AGHT+IGgSDEpG0ENhowrm0hy5x3WtBTZrepzTXfTLHYZdAqT78BKpzbFbjqTWkBayql2hshS9eQQ+Q==
X-Received: by 2002:a05:6a21:a24c:b0:1cf:3201:c3ad with SMTP id adf61e73a8af0-1d4fa7b56a1mr26064711637.49.1727773004909;
        Tue, 01 Oct 2024 01:56:44 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:8dcb:9ffe:3714:b8ad])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db5eb272sm7805235a12.61.2024.10.01.01.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 01:56:44 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] zram: do not skip the first bucket
Date: Tue,  1 Oct 2024 17:55:56 +0900
Message-ID: <20241001085634.1948384-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20240925005315.89E59C4CEC4@smtp.kernel.org>
References: <20240925005315.89E59C4CEC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A small fixup.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index d3329a67e805..263795c4aef7 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -264,7 +264,7 @@ static struct zram_pp_slot *select_pp_slot(struct zram_pp_ctl *ctl)
 	s32 idx = NUM_PP_BUCKETS - 1;
 
 	/* The higher the bucket id the more optimal slot post-processing is */
-	while (idx > 0) {
+	while (idx >= 0) {
 		pps = list_first_entry_or_null(&ctl->pp_buckets[idx],
 					       struct zram_pp_slot,
 					       entry);
-- 
2.46.1.824.gd892dcdcdd-goog


