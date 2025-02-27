Return-Path: <linux-kernel+bounces-535879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1646A47872
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E0BD3B3076
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8070A227BA6;
	Thu, 27 Feb 2025 08:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dLcAGGc/"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4058227EBE
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740646722; cv=none; b=s012YFai39VLqKk+H/FMc/26yTgrL9BcXMgqNXjNUmsbuhi4xIEX8H3R170KG/z91kjWdFt10WvkZZkfn52Ls9O1X5qeO+8o4no+FRCDp29arrDDzl2pqaDibwMz14WSZXqZtzSWA5v6IQKgWOpQAsVDc2cNLUC0KbeOxLjjmRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740646722; c=relaxed/simple;
	bh=ilqZXGcCkGni90rGGjIi+xsTckxt6pvrIPdHxcG7n7U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SpCuApseIWWbonaaZ3sG4TmvpXYFFGgq6Y8lXrQNn3ZPNcMV4Vp4eSAN6Hjlu+9P8x4SWN9gQSj2dTnKn0rFKEmLbWfPrlmTERtMM9AuJOkZeVCbPMhKuuKG6kxTnuWGL7FqrWY7TzZDG8Yl9eHMevkatEBj0VVozpTWZm9Mx/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dLcAGGc/; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2234338f2bbso1430585ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740646720; x=1741251520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Ud3xoFrsbMjlh7W+jRaIlT/a1GZMxSPg4Ghz+aYLks=;
        b=dLcAGGc/M+voFTsM5DBACfSg/0KpqgO2hR6ROiAtmfysemDT0Xp+oA/3TyCngY+C70
         FGib5Rr7O2Wntili6ts21qVmG3jELcC8xgoyc9tlFB23FjVnrL4y406+VilGuRbB7h/c
         DJ08cqkW0LdxpuCU4Ddax0FmxrxImGrG1Z9RwmasbH4FTPgEzaQyuvgpaRV383bBbqjN
         GVqdH8CQiAYK9n3cwwaldqvh/L5gGsX9ettiqpQ9td2pbO7hGkDIrEoSBCHMdj4qDa0I
         FNQX8jmjeLcN9AeXPsUsTyNPeBCrTSEUCPkofoxpLqpshKKSO6XdOc56NrdWK6QTM+vq
         WDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740646720; x=1741251520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Ud3xoFrsbMjlh7W+jRaIlT/a1GZMxSPg4Ghz+aYLks=;
        b=AoKal8Bt9aiJrg5O/vJhJCRUddEfl0OEm/3c5lqMMaA6o6bXNxLADhZNSblCniyaGW
         3erd3jf0L4xQhQG3TNaYvxBGRlggaX7z2AGuZNn4WRCEWWJ8SO8F9rhrmeS+CL330zTU
         ryRvLWY9NRupwd+VTpHtgywOxFBe/VyMePcH8QfKpMc4h/GgjJY+n2r/dPeLrAmGAIAK
         1LcAekaKFNZ6ew893jlzQFgaoJ5BsPCC8NkEEBoUKjW6oZ9KMFa1d/W1S1EFTL8filyf
         214J3Zii3TVTJa3SaNGMkVQ5rQz40EUtHCX2dK1sWNKRyC4IilyJnyMEFAiSUt4UG9e4
         IjOQ==
X-Forwarded-Encrypted: i=1; AJvYcCV868uBnODH+7NMkpk98FVgME9anlsacgydGLWJJ8dR7u5NKJW2EaXT3Fp5OSHk9It/6LyuP0uVhThSX6M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+fp5GNRTKfDcqb8gq8lTXeq8sNifA2x3QkS8x9QVZHbyXDsKD
	bcWyQhOMHPdzyfSQNVwWQ5+kRA+tpM4mCs/O+3+p11MDui+UZej0CCQQWdCUvNY=
X-Gm-Gg: ASbGncsQQl3Br9tQjscDvs6zx3UC5sIQHIipP2Hl30W1eoW0mWSWHwpXrjB0fIfEo6q
	yp+KbsH254m4ULI5vv+ekqMn+jx9eNjCLlFYClZpf7UKO6zY/s1qcqNQCrVHNHT87UKb+5w9qXu
	7hGDW5d6dHng6hkKv+vydxHg56IOjaqIDPkNkE0DV7nj6tIA5S0kqyonHVK9xEtlT60e0ScxGvp
	ONX9V4iTR37gYA74oWrK1I60+nZQSk0auA1/0AdiXashMsJEX+9x3wbXKWfnxxPEMVthSIKchxQ
	m9wJWP7LrktEjI0pXFS5aMTwt6gqbYX5bgHIAvJtEwACO4IVpPMyqLhvQTESg3f8
X-Google-Smtp-Source: AGHT+IEgp6ewNVI4xXhCUng0orTkNWP9Pvx+U8RDbfqCZmZRGJbayFN2rOA1/ZvtRKEqp/SjeRu5EA==
X-Received: by 2002:a17:902:d58c:b0:215:a57e:88d6 with SMTP id d9443c01a7336-2219fec4ee6mr148118715ad.0.1740646719871;
        Thu, 27 Feb 2025 00:58:39 -0800 (PST)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe825ba9b4sm3112759a91.12.2025.02.27.00.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 00:58:39 -0800 (PST)
From: Abel Wu <wuyun.abel@bytedance.com>
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Josh Don <joshdon@google.com>,
	Tianchen Ding <dtcccc@linux.alibaba.com>
Cc: Abel Wu <wuyun.abel@bytedance.com>,
	linux-kernel@vger.kernel.org (open list:SCHEDULER)
Subject: [PATCH v2 0/2] Fix SCHED_IDLE behavior on wakeup preemption
Date: Thu, 27 Feb 2025 16:58:11 +0800
Message-Id: <20250227085815.18131-1-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 6bc912b71b6f ("sched: SCHED_OTHER vs SCHED_IDLE isolation")
defines the behavior of SCHED_IDLE as following:

 - no SCHED_IDLE buddies
 - never let SCHED_IDLE preempt on wakeup
 - always preempt SCHED_IDLE on wakeup
 - limit SLEEPER fairness for SCHED_IDLE

and the middle two of them are broken now.

v2:
 - Collect Reviewed-by tags from Vincent, Josh and Madadi, thanks!
 - Rebased to up-to-date tip. (Madadi)
 - Folded some discussion with Vincent into commit log.

Abel Wu (2):
  sched/fair: Do not let idle entities preempt others
  sched/fair: Fix premature check of WAKEUP_PREEMPTION

 kernel/sched/fair.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

-- 
2.37.3


