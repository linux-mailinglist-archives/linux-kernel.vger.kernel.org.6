Return-Path: <linux-kernel+bounces-248836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FE192E285
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 693FD28A36E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4364156F39;
	Thu, 11 Jul 2024 08:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmnNML4I"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B752B155A24
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686948; cv=none; b=ImVvG0xfRL6y+UcksVkwCdIwBY2ahQWFZbM52M6WQiGk+mTA1opS4DOEwodkEqa2kVRHWdo2E6+rQ+4aAjmIqUWu06hqL8YPGKV9uczQC571D+P5mcDuLgav9gNgShZwuzBJEfSKlzyvmPNoWaa2VcLpQbp+ml5MDhu9ZAqzQvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686948; c=relaxed/simple;
	bh=eVrzFQh2gzasohNtJrVRYNU4IlzKN8XLynoUq7Ij4uI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HVU6gsniQUZkb8fip1sQhBa2UKzPR132oYKYMU203+h5mTkULhPhsxqW2SU2bzO8UJI1lmqTf5fS3d4ormbPmcnnmNQZQvDb0Vq+l/TqdQYEdcn4Hv89Mp3JLzF3wzN7pByz7bWW2Hwa7iGCI8W5HrJuDfkWfrM2peQHUdn6k4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmnNML4I; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c96170d23eso525440a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 01:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720686946; x=1721291746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qq8kwvZKqPvz6y5zTKRIEuAEAuvxbyjF4fZE1ScwzjY=;
        b=CmnNML4I6CseQlSQb9FM07nl1yw6xpCUJW/4U6VlpnU0Ty0QmPdLtha02WNLguz/WM
         4YdGBt0lM3UA30ajHuiFqiTC16xdHYIgm28SyWaVeNrqnqZqy2yiiBGAZw6TxPT47fEn
         lIQgqJFGJCu5QS0KLDVryzYMhS8WLR+AfcCMLMv1jR1GJNi7HXfAFyOPXA/zLzkR6TWE
         JrEWYeyVol9ZIwaKsmd+l/rebdcGIeD6ABX/Sx5V01sDOTyorRJ4k9ffJAf/rJkQCdaO
         x5cNefCrji30OE2BTtORTYqUWxJliU1h3ucDU/t18IorNPwyomjhN6vqEKBl8yaOyfw0
         i0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720686946; x=1721291746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qq8kwvZKqPvz6y5zTKRIEuAEAuvxbyjF4fZE1ScwzjY=;
        b=m/KHnOWFLH8U56Q/5xjjoECbSLpwOMwNHQkOjE4xfBP7qAXlH/Hl9R5kfASHgz0CE+
         e4LqZxZZibo/ti2JFGw3Lh7E5kf3RLLAC5heZomfyr+cI6tYOZA97woxDo2/yayhO67v
         q4MP4Q1MB8hBfmoiCFZeO1zIxVjHDqyHOtYno35QsJhSerDtg+GmBhbUvFGK+gxNzpaV
         fNnMbxzsraKOHHVAx1qlcOdM5NMtTLBaIYhnu2GNP6fci8czvByRS3kC0PUFmSW1pBRP
         ecGxE3inEwIkrayfrG4GybUgR4oUnHnyI5iogxZauGFaorHRbPqgU4V8bMG6OZJqD6gf
         tRXw==
X-Gm-Message-State: AOJu0YwLZvEsqJVp5hzvzMcieYkAo7uxEDFoT4q+4xuRCRTeCaLZU4Bt
	GD9LLIY2XnvWpZvppOPJ6cOOOSqD5nFetCmQ5OtvsftqSnZ2r2+rC/FmmA==
X-Google-Smtp-Source: AGHT+IGUt6WETC4rSEgAs5YuoG2vVIdNcXGM8Z3YHTLFZ7MSQqVNZVFNLu7K3+WPmzye3AnrP6ybKg==
X-Received: by 2002:a17:90b:120c:b0:2c9:64fb:1c7e with SMTP id 98e67ed59e1d1-2ca35c32e30mr6510506a91.14.1720686945637;
        Thu, 11 Jul 2024 01:35:45 -0700 (PDT)
Received: from localhost ([47.89.225.180])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ca34e6a252sm5084517a91.14.2024.07.11.01.35.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2024 01:35:45 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH] workqueue: Simplify pool_allowed_cpus()
Date: Thu, 11 Jul 2024 16:38:31 +0800
Message-Id: <20240711083831.4273-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

For cpu worker pools, attrs->affn_strict is true; attrs->__pod_cpumask
and attrs->cpumask are the same.  Skip the pool->cpu test
in pool_allowed_cpus() and use pool->attrs->__pod_cpumask.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 8b2a0fe4a85e..5d362290c2e8 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2646,7 +2646,7 @@ static struct worker *alloc_worker(int node)
 
 static cpumask_t *pool_allowed_cpus(struct worker_pool *pool)
 {
-	if (pool->cpu < 0 && pool->attrs->affn_strict)
+	if (pool->attrs->affn_strict)
 		return pool->attrs->__pod_cpumask;
 	else
 		return pool->attrs->cpumask;
-- 
2.19.1.6.gb485710b


