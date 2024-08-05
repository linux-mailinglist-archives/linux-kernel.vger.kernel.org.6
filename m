Return-Path: <linux-kernel+bounces-274283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3682294760B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C56C7B21438
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 07:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919A1148847;
	Mon,  5 Aug 2024 07:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5Q96vHW"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A86012B6C
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 07:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722843045; cv=none; b=sy3pW0ZXIIPDnhyIm5pwbQ4WC2HgdoQT+ZHNuqPAd2XB1AlQJHyVmrqc9ZNILaxTwAwipHz3M+4+DtbAET6aNnPHV64jtuFvENqI+v9ethGH7PSBsLazsSU9GaW0HljgmPcOrFgdHHMcJT/TibxI8q0/SJ8TEPi67cU67a6ZwA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722843045; c=relaxed/simple;
	bh=0ILe+Bde6Pud8rKBRyfj9vhtauRIsFgXsPRjWGk1ggU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y9nPtCuASUC+PZr6SkjGInlqmCeeuHTxm+yOUUurYj79RMSGZg2R2eseL9DIn43KbCgqw9jGtIM1/xgfaPaoM2UJ0zICFPqUMKnZYuHOqZzyKUrUyWwA8SfM31LTazI3TGOnUhG7hHQrrClKmshLn5i/SuAV22sCpeUzonye08E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5Q96vHW; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7aa4ca9d72so1182104866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 00:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722843042; x=1723447842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X8SUJ1+FigyFIutSgmxfgj+6+zrNcUA6k6k5YjIiTRM=;
        b=B5Q96vHWKVFuhGcP5os3YkHCqib43MdHjvs/vZKf1Dm/6PEJMiKibr0wkGZ1ngCUN4
         Ikk0cPwuzp3oYPIl25E6LAW5GAVOnc65kC1r0A470rsNLqYkpU0MON8W7fAC3MYea7eQ
         a088Nby3z+lzZMmITZzRkzcVhPd7QysHPfR51EIZpfET2EA14KcDtgn0FSDDKxMJEvrv
         s4897vSarR4To+sqEmtekNow3SBc9Rf9sV+v8zbeUsOsUe/9HyTm0vYwR+foYNjtyMgP
         7mSRN2mHBuy15FxpbaXh1A45amtqon85VZv9j+ikZXST0dzMgAbPByxqZ/RzMDV8Q1sN
         5n0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722843042; x=1723447842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X8SUJ1+FigyFIutSgmxfgj+6+zrNcUA6k6k5YjIiTRM=;
        b=oLE5leo/wQTlspq3QfdtuQmnyXMCX4aQt6XUr7coaRcS3L9NtiWN3yXlQsdthGvyR/
         TsWQfTZP7hSaXLYXWLs8bdhgIV+cz2A7iTkn+qbZXluudPf+LMrHSNl0hOU+RfPEc42A
         t8ye1AYsq6DMGyHHP5UVuCeN9rItmXC++mGZbkXALG6LF0/HF/GvwlyoAM46gRCKjP3X
         3fqsjZhibdK0xlH3SLvQsRG5mad8EG0KVk88A/sWFQd+wS6owitaRX+aZKQM7Twkmo0e
         2kXxv9hZS/TIxlIYmEeF0fiSYUVeIQ+vzwH54L3XXLeM9psklCoNK4g5fgYcoKpK8YVc
         0N1Q==
X-Gm-Message-State: AOJu0YyDBruocxtwDGpeu6ptCf+20iVW/dW319K2pSP6CCC3naK2vJpJ
	kKsniG1NwSIOasP2mhnXIsF8PHf3M6KiTFNPI5/P4dSw94vlDu1EqjkFKFdo
X-Google-Smtp-Source: AGHT+IFJ4b0rBBLR5LQrz7ZdFsMkzoiYQ6MjyBiuqef2aC/ONFYP3+UHG7HVrDI3G7WB3dx8c2Bqqw==
X-Received: by 2002:a17:907:2da6:b0:a7a:b9dd:775a with SMTP id a640c23a62f3a-a7dc50a59a3mr808817266b.67.1722843041235;
        Mon, 05 Aug 2024 00:30:41 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d437dfsm418827566b.133.2024.08.05.00.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 00:30:40 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH] workqueue: Correct declaration of cpu_pwq in struct workqueue_struct
Date: Mon,  5 Aug 2024 09:30:29 +0200
Message-ID: <20240805073037.60238-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpu_pwq is used in various percpu functions that expect variable in
__percpu address space. Correct the declaration of cpu_pwq to

struct pool_workqueue __rcu * __percpu *cpu_pwq

to declare the variable as __percpu pointer.

The patch also fixes following sparse errors:

workqueue.c:380:37: warning: duplicate [noderef]
workqueue.c:380:37: error: multiple address spaces given: __rcu & __percpu
workqueue.c:2271:15: error: incompatible types in comparison expression (different address spaces):
workqueue.c:2271:15:    struct pool_workqueue [noderef] __rcu *
workqueue.c:2271:15:    struct pool_workqueue [noderef] __percpu *

and uncovers a couple of exisiting "incorrect type in assignment"
warnings (from __rcu address space), which this patch does not address.

Found by GCC's named address space checks.

There were no changes in the resulting object files.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 1745ca788ede..32729a2e93af 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -377,7 +377,7 @@ struct workqueue_struct {
 
 	/* hot fields used during command issue, aligned to cacheline */
 	unsigned int		flags ____cacheline_aligned; /* WQ: WQ_* flags */
-	struct pool_workqueue __percpu __rcu **cpu_pwq; /* I: per-cpu pwqs */
+	struct pool_workqueue __rcu * __percpu *cpu_pwq; /* I: per-cpu pwqs */
 	struct wq_node_nr_active *node_nr_active[]; /* I: per-node nr_active */
 };
 
-- 
2.45.2


