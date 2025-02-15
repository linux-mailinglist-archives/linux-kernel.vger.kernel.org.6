Return-Path: <linux-kernel+bounces-516336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 565C2A36FC5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 18:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CAAE7A2540
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 17:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F991EA7D1;
	Sat, 15 Feb 2025 17:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fX1Tz//n"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA7917B50B
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 17:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739640440; cv=none; b=TwIabLbhJBX95oUzhdq46i/LU97brOmI8/hyVyU7bsPAzFQLeXUHBchmeewha+mMTIjb01zRWxHg1clpbdkUQmW09avEjlnNzLmwZFEXDrl3dxz6f9WGVFXvYwcH4POzqZbsUYPlCC73r4gCjdKjzIuN/cmHCOy1gNQjKsF7Nbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739640440; c=relaxed/simple;
	bh=QHAFdxhkFpz4jbhzRNBpFWzwVIItWw+ibcqHHag4bP0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zwl2vXudOk5AZgjZI/mLowK5fukkBrIWNnXmY7dvJzzHmvORUR8boIfpnAkVUrCIqBGOBYeuRgWC5p9w0DAUB6ugu1XskX2dAQU/kYxnb0ToDXzWyCFkF5jyKTPV2wDvkI2nA7OSqTQbICSQyGbsDGIur8qqObJh12d90WoG1mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fX1Tz//n; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2211cd4463cso1391635ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 09:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739640439; x=1740245239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I51sTcTAgX/1n81QV7txkU31zIruY5EJBnjR0gxuhLk=;
        b=fX1Tz//nh1ktECcTmMdqh+BO5wRRwgJoLgwiY5Vqh7xmUGYjCfJ77/Map3eOTPUiYZ
         NybDenu/uL+mqjAYoP7G8dnZTMcXGvg5aNx4zxTsro/iDgThL0chVZujr73Db/yfm89F
         3ytUgp13duHFKVWJ1n0ugDyfsqsYZciF2H15Kww5iPBTM/cq3/dLFBImFZfiGiSUs9r2
         18VI9EUg4nmia5o/wKD1wScnockCXu7AoH0iHIWP4CR15eXau4y1OhEoLw29aBuVib4Y
         9dtE95vOgb9U3gjmyfDkBz/Bk+EwEIORAi9FAPYpihi4EOckmY2jP5+PvW9sppkGMFXG
         NCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739640439; x=1740245239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I51sTcTAgX/1n81QV7txkU31zIruY5EJBnjR0gxuhLk=;
        b=xOK3ks7IOVOjob/2MUdSD8izW0Bhf2bHLBfeSDDSa+ab5OSpRNlrQXSrebzLjivPkC
         KCIUA3WHqmQIevuegPjtDxAl5PbXN22DhX8gMVE31sCrXW+uxTz0eiDzU0fD74SmG3no
         sWk0MRtYvx483FjMuA2J9M4031YBd7whdUzorYKIWiKH12O6J2M5dOXOtW5FwncXOmEY
         uBEXIDhJs5PrnVdL6Rzk2u5rTVlgX74C+OxWDLJE7OzVIZO5GGiVLLnFkh79PpH7lAG6
         xN4ffpv6FmMwvdxTeYZdyVKYl6ykdMDnPbS/iectzlOZDNiJF5zrJpX2se6cmCJ7YYdI
         UWAg==
X-Forwarded-Encrypted: i=1; AJvYcCVSnbWsrxQCsFa11rJq4l7m6ljVGsvyky9GfQJGET8y4FgDbsEGDL2d8RBW7Htr7obiB4TC2Y/e5llmWHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOjOU1roRmLkibhLFo3UEkz2IOemVDvn0BrlSLkl4Y63ESW1M9
	GBNF7AAhunHw0iiB5eJD71o5uWCMVuvVPGcfo35DOrWfZwnDet8f
X-Gm-Gg: ASbGncvrfxtMHFkUt9sPxvDfNeUBz1BO3vZqb6uYn+PFEGQYyEvJfqftutaG+Ez/gG/
	wjNC9JkHdhxtoioZv34BMQ3LTMdyQDHJEkzKrhD0usH/jj26PtuoGkXAEPQcWGnPRoypyehzS5z
	ytosa6UewA+CCdjwTf3s6OPz6mMtVCHkRY7n6MJTWLEvyLDiyPcrrF38FwF3qYCbk5YPxmykzr3
	Qp89JHq4F0vAc6gj7PX8ActM2ocbAtvAHcql1mEOp1HcNL5Jnsw36XInQ7sW80SH3GrUmp5Z42t
	cLQ0PhzSGRQ0jb0hW5NeOgMPrbGLr2M1MWg3mZiNZLWOUQ==
X-Google-Smtp-Source: AGHT+IGPW3HdpnWdDgOHvstNadYtFFRYnluc57KiRZ7eDmuUpV+w2KLXQu/+hl6/Ug8Z2mq+jVdmmQ==
X-Received: by 2002:a17:903:8c5:b0:220:c63b:d945 with SMTP id d9443c01a7336-22104030d60mr56919065ad.14.1739640438686;
        Sat, 15 Feb 2025 09:27:18 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220ea7a9348sm31816175ad.211.2025.02.15.09.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 09:27:18 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Cc: dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	yury.norov@gmail.com,
	jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2] sched/topology: Optimize sched_numa_find_nth_cpu() by inlining bsearch()
Date: Sun, 16 Feb 2025 01:27:11 +0800
Message-Id: <20250215172711.1767546-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_MITIGATION_RETPOLINE is enabled, indirect function calls
become costly. Replacing bsearch() with an inline version of the binary
search reduces the overhead of indirect function calls, improving
efficiency. This change also results in a reduction of the code size by
91 bytes on x86-64 systems.

$ ./scripts/bloat-o-meter ./build_utility.o.old ./build_utility.o.new
add/remove: 0/1 grow/shrink: 1/0 up/down: 19/-110 (-91)
Function                                     old     new   delta
sched_numa_find_nth_cpu                      442     461     +19
hop_cmp                                      110       -    -110
Total: Before=46675, After=46584, chg -0.19%

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v2:
Use bloat-o-meter to measure code size impact.

v1: https://lore.kernel.org/lkml/20241205162336.1675428-1-visitorckw@gmail.com/

 kernel/sched/topology.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index c49aea8c1025..3ba1476a97de 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2171,7 +2171,8 @@ int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node)
 	if (!k.masks)
 		goto unlock;
 
-	hop_masks = bsearch(&k, k.masks, sched_domains_numa_levels, sizeof(k.masks[0]), hop_cmp);
+	hop_masks = __inline_bsearch(&k, k.masks, sched_domains_numa_levels, sizeof(k.masks[0]),
+				     hop_cmp);
 	hop = hop_masks	- k.masks;
 
 	ret = hop ?
-- 
2.34.1


