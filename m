Return-Path: <linux-kernel+bounces-192180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 044318D1989
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91D8C1F24A44
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2117316C879;
	Tue, 28 May 2024 11:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FW1Z3aJe"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAE516C852
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 11:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716895901; cv=none; b=ohiz0B9e+dRTmWxhCHDnp5hf2PWjkv/Kz05iWB+xicmWmq9RKMJywBR1JVajGbPCnDfJaSHY6uXjOrYrk+WfO3rahKCrb9PRxQMUkazpCir+uRIhArKkODxq94tLYloF/aI1vZeyPN5DZIOdI17MsVTnP9xlQr2Sp9rvudFwViE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716895901; c=relaxed/simple;
	bh=fxpm/LIsZGIggWDXRYpJ5fdEVDu5rMF9yE2zhO+FJIY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t1ieB6yWcsX7RQuj6llZpjRg6QzBM7DLIYYE+XD7jlgDq8944rkRBZ7bbLujlNcv482o30UaYmuHGomD2UUV0Ss2nOoB8LaJHv0PpLWpvKTTzQq/zh9bTJTt1wtbEnf25Gxibr7aEHL/21gbjAKuqLghecOSiyvjyS5qKJVR25k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FW1Z3aJe; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2bf196037a7so150316a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 04:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1716895898; x=1717500698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NZzIHFKMEX46WqWH8vqiSdYuoVinlSIylJzQrt6zn/E=;
        b=FW1Z3aJe8SU8zuVcxrrHtisGqpbNo9/oH+VGp58wmH3QxAxIfNdkow3M3qxgY9vicg
         fUiAjgZWnaSy2DryEIRvn9L6/2vPEDrP5sRpjv0nbSjNB1GgBtbeEUb/kBiNpZlKjFUP
         eBZ6Km9DuD3Dn5Kfd/SEddPzE36AH5bOc/5WLrZEIYzil1TJd+Euc5+oPVMq4fIrcRXo
         B+qEP8LHPTcCtQvcq6wMje6Ch9nl8k81FiOhCokw72ALbpINSD4GFXHlnN3Ca5i4IZCk
         xNu5hNpr2/D6aj08VcocyjBKpMWhLwDYBU2WRbxbfaRRabRCzeSQ9dFp6JsnUJ33ondo
         ix3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716895898; x=1717500698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZzIHFKMEX46WqWH8vqiSdYuoVinlSIylJzQrt6zn/E=;
        b=sG84VsSlnPAAaVOr2hKgDeqRTKZCA2MlMdK4V3jqJiwdVuiuWzJMXygEW2geMOMZHb
         c3sN0L3ZRgJckHhBAIAeQVGZtbRo8mvmxVBFPyMBxeFR2o6SF+3QdgfDzAjfCuFqEsXI
         hjrK9ftIbaw40kHcnvjmx2DncZmm6egMOmHM3LhtZ1Gg5yLYqD57uLqGKJvPgouyrHw0
         +k6C15I68V3CDmY4/xlVmPMHy0uNQeG8vPgK4WCZZtE5sAPZDXwHL4bd32AoRSw2Tam+
         YRb+3D9KjkCZ7iOjQV0udKiLeS05q4rOX2kWR/KufvFcO7OMdEorIz/toJMtFyH92R5S
         nTtg==
X-Gm-Message-State: AOJu0YzWvbG4WAQrOyfnjbsWdCxsB7UgAmB8UzUcVEmP8n4znQLx21Bh
	iPUOhlfUDC+LXQTnbwgkhZGdt1X+i/NKpmqUAQ9js7oBPc7DIAOsXldhNFBZ/E5rhA5yu2eJyOx
	M
X-Google-Smtp-Source: AGHT+IHx4q/jVO1m3ZPLPPYQ69fEzVm1LxS04qP0WCoXPN2w1kp0nZwqrYv9bgiSkYlG47JMEiYEFw==
X-Received: by 2002:a17:90b:11d4:b0:2bf:f584:a861 with SMTP id 98e67ed59e1d1-2bff584a883mr2993500a91.3.1716895898433;
        Tue, 28 May 2024 04:31:38 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bf5f50c3f2sm7553500a91.15.2024.05.28.04.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 04:31:38 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: mgorman@suse.de,
	peterz@infradead.org,
	mingo@redhat.com
Cc: linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH] sched/numa: return earlier in task_numa_work()
Date: Tue, 28 May 2024 19:30:24 +0800
Message-Id: <20240528113024.92864-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a new mm has been allocated, we can return directly after
initializing the mm->numa_next_scan to avoid redundant calling
of the time_before().

No functional change intended.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 kernel/sched/fair.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8a5b1ae0aa55..b78528a6312e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3228,6 +3228,7 @@ static void task_numa_work(struct callback_head *work)
 	if (!mm->numa_next_scan) {
 		mm->numa_next_scan = now +
 			msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
+		return;
 	}
 
 	/*
-- 
2.20.1


