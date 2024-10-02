Return-Path: <linux-kernel+bounces-347163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC13198CED4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CB381F2331E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 08:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430A4195FE3;
	Wed,  2 Oct 2024 08:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a5bWtM38"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09525194A6B
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 08:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727858198; cv=none; b=ZvzSSner1bIUV4K4tlgyNPwWJV8zPAr547KLYcilM3qKGyQFQxGbv2E8fJ1mUTJ33Q8AlCDz6T7GZDBwJ49e7EXMGvkYavdDXKbWeHVA3teFYbVmrd3SvlCX2gExuEcdD5ypJcBCixFFnt+6H3XabCZA79/SPLp/oUsnpZyE8vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727858198; c=relaxed/simple;
	bh=bNOrYjkHCBg/Fcd/LdNcDAu/YaCl9tCbo2Xxck+PiHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z0CtzagViYDpft1Dr5MnfgJJDob/s3ruAH4gHdGQQYdv3G1ZIjOBi+z3z0UZjY1caWSaazSa8w4Gs8Ni3V9PVTeit5zuMl24vKIpKArhTGHhbu09g58Flkf6z8KqsnQW8qBDIrAJh0bQWfa2kWtmT3truR9kPdGQ7KwgG9lHPNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a5bWtM38; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42e5e758093so51868145e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 01:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727858195; x=1728462995; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kc6BiyuSD579Sv6LzlSE+1CxGu9PgjAtpw64mVktEYA=;
        b=a5bWtM38berS6MTkRq0hzVwB38eTLheAiA3K9tFXCpYJK0u272XC5zg32EpNqCcAy+
         mpmIyb7ZgQ7j6xpq0tMYDywixYOvV8+rf6ibo2s4SHVquZvmo8cEnEJKdDtSEpH8qRNP
         zAh4sH+0BFaaEg56jVwJPU1YBHjJbPQ3lLBP04JT+PRZkKnU7Iq4y/BNgACbOr8a0htL
         4FJLMYYG5X+laz8JPh/TZq1jY42Z1EairGY01POCR5Wu0Yk16IPswIduYjS50R4de0e2
         99Zd7tRIanhUHq1OmSVd823nyuQ+B3hfRnIkBnVMXRku9l2fL79JHq/Jln5Hpc9q4XGX
         2GvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727858195; x=1728462995;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kc6BiyuSD579Sv6LzlSE+1CxGu9PgjAtpw64mVktEYA=;
        b=X2SW1xIfPkwPHm41TgCGEDtBay6ZZkLNJ2zXXT2xn2QWJedwAqo9VrQRT0kFVrh+RX
         57VtMu8OnSZJRxqFPcVElBmbatpHlci71KTNf9iuKe9VqxTi0Uc1yjOZf3z3Alde0aRr
         JiU1CjOiZi1l6/ZhkJqEhqVj3egRQ9WgtxQY4zg9uVeq0WwBWVDIOv+NPV1Hhj+LHXv8
         abE0F2oLlUw/OGALFEg6pjEI8HrjHOjEMb1SIx44oeA/KcWQpZHyQllx12Unbgz+VTk8
         AiP5XBtt6fmrjUfdpHbDdQ4SDl0RPsbECqYSgUgNjoeMLlg09aw09pYeHrkAZ/kvUTBc
         J58w==
X-Forwarded-Encrypted: i=1; AJvYcCWhSYyJGDWY0E/eIL3nfUbQkCvz2yWfJsh4gxJEjuDSsdLdWDK80JpQHc8o6CrDxt8GDHK3r8qhG5z+4zY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt/MX/YCnNCG5OQnEYsIuTLweNprGzMZOE2CMhNck3aeW+OrUo
	iC/WLvsHXMwyrybe/PcksfqdpDRODbVsXvv4xvKAGQo0ezTAPoqlHFwA1AjF52g=
X-Google-Smtp-Source: AGHT+IE49N9Qfy5+dsTk1nkwupACM5L0mU69EfhPe8nDnMTvJtXqKCmy5mqr/pcTmPLWRDJ6zsXonA==
X-Received: by 2002:a05:600c:896:b0:42f:7717:ac04 with SMTP id 5b1f17b1804b1-42f77957a32mr15915725e9.16.1727858195297;
        Wed, 02 Oct 2024 01:36:35 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79eadd8csm12217495e9.16.2024.10.02.01.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 01:36:32 -0700 (PDT)
Date: Wed, 2 Oct 2024 11:36:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yu Kuai <yukuai3@huawei.com>
Cc: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] blk_iocost: remove some dupicate irq disable/enables
Message-ID: <d6cc543a-e354-4500-b47b-aa7f9afa30de@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

These are called from blkcg_print_blkgs() which already disables IRQs so
disabling it again is wrong.  It means that IRQs will be enabled slightly
earlier than intended, however, so far as I can see, this bug is harmless.

Fixes: 35198e323001 ("blk-iocost: read params inside lock in sysfs apis")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 block/blk-iocost.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 9dc9323f84ac..384aa15e8260 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3166,7 +3166,7 @@ static u64 ioc_qos_prfill(struct seq_file *sf, struct blkg_policy_data *pd,
 	if (!dname)
 		return 0;
 
-	spin_lock_irq(&ioc->lock);
+	spin_lock(&ioc->lock);
 	seq_printf(sf, "%s enable=%d ctrl=%s rpct=%u.%02u rlat=%u wpct=%u.%02u wlat=%u min=%u.%02u max=%u.%02u\n",
 		   dname, ioc->enabled, ioc->user_qos_params ? "user" : "auto",
 		   ioc->params.qos[QOS_RPPM] / 10000,
@@ -3179,7 +3179,7 @@ static u64 ioc_qos_prfill(struct seq_file *sf, struct blkg_policy_data *pd,
 		   ioc->params.qos[QOS_MIN] % 10000 / 100,
 		   ioc->params.qos[QOS_MAX] / 10000,
 		   ioc->params.qos[QOS_MAX] % 10000 / 100);
-	spin_unlock_irq(&ioc->lock);
+	spin_unlock(&ioc->lock);
 	return 0;
 }
 
@@ -3366,14 +3366,14 @@ static u64 ioc_cost_model_prfill(struct seq_file *sf,
 	if (!dname)
 		return 0;
 
-	spin_lock_irq(&ioc->lock);
+	spin_lock(&ioc->lock);
 	seq_printf(sf, "%s ctrl=%s model=linear "
 		   "rbps=%llu rseqiops=%llu rrandiops=%llu "
 		   "wbps=%llu wseqiops=%llu wrandiops=%llu\n",
 		   dname, ioc->user_cost_model ? "user" : "auto",
 		   u[I_LCOEF_RBPS], u[I_LCOEF_RSEQIOPS], u[I_LCOEF_RRANDIOPS],
 		   u[I_LCOEF_WBPS], u[I_LCOEF_WSEQIOPS], u[I_LCOEF_WRANDIOPS]);
-	spin_unlock_irq(&ioc->lock);
+	spin_unlock(&ioc->lock);
 	return 0;
 }
 
-- 
2.45.2


