Return-Path: <linux-kernel+bounces-433652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3779E5B3D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 499871884388
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C53121D59F;
	Thu,  5 Dec 2024 16:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NptiGSTI"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB3D21D585
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 16:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733415824; cv=none; b=lBANY/DDn4MKfkjCwW1d5LrQR7aKpyX4taYq/CLHlq7G8v1mmTYdCa62Z3Vb9GWIPNEhNrpOiXU+vm+P59iXh6aATnReFRwOYoQ/6upV2Ses9lXKIy+8tX32lLjW4DbcLzwHNgHkjOtjbfPu/cs63iR+YWdzVhRFWe6aGS01jTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733415824; c=relaxed/simple;
	bh=9b2c6CO09v2I5m4bGoHjKnAfAmJodSqsqGJN+YXEifM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ePDHmy1YdspCWi/bE9gbtPnZ6AiRLFWlfbuJMw5I7Kmx+KpgJZco9VL642e15tQdxfUT1qwTYhM+72zM4BNjHxfEVcqMTMlknEbdwlcOsApgXvNvC39xI+EDP8bd3uo2B7vNldt71kgbiEXvDXYh/4i0XZr6zxAaIiQZdvDY8bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NptiGSTI; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7fd1ef74512so432750a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 08:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733415823; x=1734020623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZozouoS6JrePVBbBSW2GJg7z9DL9+h8SxZfTKXZfNfg=;
        b=NptiGSTICPY/jWbhfjwSaAJGfFwrdV9mUJEQZaba/qeAzziBxfp/m32IHB6zW3CQcW
         FzWZK0duk8qOqJu8ollLX3fd2Y6P+8JnmEr71Zjg18r6tsPFBCyMihWFh8EK3GJnWZni
         FpiDEotoKr4iXIrh6LWhVQqSX/6Y/8K5qUipGortb5f5ZZc1JHdL5MKDo6/cXtKuqLud
         dyd8hp1vckvQraIGDnrHd8liAnp3FoajBLOWZGTxJgFC+JiptafthW388ugOXDJeMCIJ
         HG+UgEVFPELpWPzscAZ9WGsj4mFfeUiWL93tI4wl2TixCNCp3OcgG+N+iOfuEW2TPG+D
         CGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733415823; x=1734020623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZozouoS6JrePVBbBSW2GJg7z9DL9+h8SxZfTKXZfNfg=;
        b=S+Cw0IwMSTHvcsYpb+naKofXz4r5TfRSol+BwaKI3KwrWr4Bx3bT288OhobEdRHD8J
         FUTBXtY52NzULASKq/buhAv3l9xe9JwSJyjBXPApaC/q/CgjRI3RyKjrl1a23f89kvMi
         tDdi8+ibAWKU2EUHLWZD+Xasc3XKPXWQAGgLP0G3mZI2weNh5GKAGcHwS6HEROguCc2A
         qMmlDIOIxcvS0KJL9fgaLto8zHNO275airE2cGTC2M1jMI7RTJ+0xzDD75qUo/v9eUeM
         8eqZ1vJegKR5l+iadaMn3eWSId62RHNjTb/Pf/DC9xgK7HX4GNIjLqWcOGN/lTLM+zWu
         HV5w==
X-Forwarded-Encrypted: i=1; AJvYcCU0DkaYO4oCPj+GiLVaav5kGoc3ywsqbxq+LPXi0qRRCbNWLP5pagh+6Bx63B6YQ+ivEMhAKHkszSjJCIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlcTQcpI4Cz3VP6YkSVv5ajZKoAEr2szz2bDqAdvYcZcfsXK75
	b5od+QcjGYtmNcNQeL6f8KkwrAIhPjCs4g5AX+QaQZJ1imjIKGs0
X-Gm-Gg: ASbGncu4tutvOZR7TbSHRN/JuJC5L4kYDZ2PawQve/430bhDmgp+aIJgk5kizkqmzuO
	K3f1AhPdOZWGbDNbilexCkZHfbAAD9h0l2Dr4+fwOVpxH6GjvQ+mjjHLC/LWmnZoouLS3nJ0o3q
	YsY6Ha4yQ34tyvWRIyE10qpR8kHRQYkcNXQkvqK4hJA83JJWV6xTzqZewc8TlD1h7M360/f1KeM
	CBMSuZzBbh90BTQzrkzwtDWPyoSoC1r+61+1ZBBqCja8Fh+mUPtxJr6kpRLOLIJ4ZLgRtJyzc2d
	IyjC
X-Google-Smtp-Source: AGHT+IE7I4dJ6HAI1u8U5kYmOEnih7W9DBu2sYMpTzEYrYoCdM0nbCd9ezH1c1k/RPQaYQkPzALghQ==
X-Received: by 2002:a05:6a20:6a11:b0:1db:ef2f:d6f0 with SMTP id adf61e73a8af0-1e1653c525bmr14773837637.19.1733415822615;
        Thu, 05 Dec 2024 08:23:42 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f26cefsm14479415ad.236.2024.12.05.08.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 08:23:42 -0800 (PST)
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
	jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] sched/topology: Optimize sched_numa_find_nth_cpu() by inlining bsearch()
Date: Fri,  6 Dec 2024 00:23:36 +0800
Message-Id: <20241205162336.1675428-1-visitorckw@gmail.com>
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
128 bytes on x86-64 systems.

Before the patch:
$ size ./kernel/sched/build_utility.o
   text    data     bss     dec     hex filename
  40113   12379    2176   54668    d58c ./kernel/sched/build_utility.o

After the patch:
$ size ./kernel/sched/build_utility.o
   text    data     bss     dec     hex filename
  39993   12371    2176   54540    d50c ./kernel/sched/build_utility.o

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 kernel/sched/topology.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 9748a4c8d668..7790060d12ca 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2173,7 +2173,8 @@ int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node)
 	if (!k.masks)
 		goto unlock;
 
-	hop_masks = bsearch(&k, k.masks, sched_domains_numa_levels, sizeof(k.masks[0]), hop_cmp);
+	hop_masks = __inline_bsearch(&k, k.masks, sched_domains_numa_levels, sizeof(k.masks[0]),
+				     hop_cmp);
 	hop = hop_masks	- k.masks;
 
 	ret = hop ?
-- 
2.34.1


