Return-Path: <linux-kernel+bounces-550307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A64A55DBC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 03:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4792D3B1C3D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 02:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E78B188CB1;
	Fri,  7 Mar 2025 02:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yFDY55Ng"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4746F17A597
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 02:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741315155; cv=none; b=UeK6nSTQG4ZkCGvvnXD89WR0x4C+H/52c5byjcRQb3zAnpUTfENhWwRj0mBv5nVRj6+L2S0RH3Q7eVOBhgYA82J8SVmV0mcKgqb1/r8eS/L4upon5Nn5FlnL+DME0POPa1k+Fx7SMdhoL0i0CCgnVgD+xNdbr4VTS+HaETJlBSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741315155; c=relaxed/simple;
	bh=NWyOZGvVp70tlGmdZEWQ8sDHjKT8tk+xY/WeZhdeWww=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=kFagtPgvIz36eNVteipafPoZhN8Qs5RCaOhC+AR2pt/hpLzoyToSWECzC2islaP7wp1Xq+dqwxCW+3uVUIILgQt1CXSfA2KT/wLVW+C6UfECW6SJiH/otdAlyImupMQttulLlUCfqYSb5fX3KCOaY+a9JIkAXm9YVk1+78TJKNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yFDY55Ng; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fe8c5dbdb0so2543104a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 18:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741315153; x=1741919953; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3YwLtUBA2a3eR+2CmuTfmd2aWCIaAduMpkYNneVBrdI=;
        b=yFDY55NgMDe32bLT7ObWKOtwsj5/86Nukgsy+NUtrDx/UKSXDh+e07wFdeGuJ9bEk9
         2bKXYl8rf8NcP+1SyYaQ54QgoDfR7T8RYqYoXZ9hjV7mB0YRFdA+hduNyfcvlZvD8VO2
         +vz9v8O/HkGCvDgixozWx13y9iLIeJAAWIbTsgRUZ3SqSIVYQsMur+Ympqa69pj18gae
         4WB1l3nUNKb7Fl0wIQ6H65012144gCzZg/0gs2i+TwvecVr5PTboAXzDWcwIOoVYy2to
         9tZa937c/XaWuxh87Iqv0fvaidRakPNbT4rZszJBCuV+LmRVbIxPzz757i/tZQt93pwQ
         F+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741315153; x=1741919953;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3YwLtUBA2a3eR+2CmuTfmd2aWCIaAduMpkYNneVBrdI=;
        b=lrIoCERuePX33GbzKKKGGeIf+H0Ibc6QzzbkqYT7ybl6lx0+qFqV2q0GbWzqllnZia
         Q5+WJnJAqnByGLeCcX79+uz8BmqhyYU4NtaAXIHgP9UQjhmBne0bETUchuUaSX3yvWeu
         xsW4Kbu8XJoyy4d8WwiVPJQoC8GXwYNZEaMEcHLLumP9Ver0AqnIGf+cso0+wTisLZal
         /yJR6XPDZySr+WVwBfgPW6+DeLrxYzvR/bXcjTHd6AR7Cmt9SSZEfdRIdfsS1P2eqfzj
         PrJavp3gO2QW3tU3YBbiiFe7X2I2V/Jo106fX9JBxcGAVcuMflWPTAGzLwfcY47gcAu7
         +8kg==
X-Forwarded-Encrypted: i=1; AJvYcCWFuryuq/Ht2RT9dG8PAGcEFEPFGebUDgA3vfO+hbljmKAEhhXom9q1kC5LrF/VJKaCAAyRsdf5GSaqi1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBQxsuSb/IUQcme6PK0qQRosBazQnGTPefdW4xnmjpBmWTPSil
	Kp5RcNSAKgR74xTvvXYC/5+iJT5yTYtionHqYQ23kzYy4OQzOehwQYrrB+LtUdtDaue01Pz5pGD
	/9iTGTg==
X-Google-Smtp-Source: AGHT+IEolkiQSfDAoU+Ce7TybWwf7ay09+pwJfxEWHQ2tK3T/2E4vteMlcQkSfh9pSvQr98fCC9jXru0BD5F
X-Received: from pjbqj3.prod.google.com ([2002:a17:90b:28c3:b0:2fc:2959:b397])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:180b:b0:2ff:5357:1c7f
 with SMTP id 98e67ed59e1d1-2ff7cf3d0bfmr2290224a91.30.1741315153549; Thu, 06
 Mar 2025 18:39:13 -0800 (PST)
Date: Thu,  6 Mar 2025 18:39:03 -0800
In-Reply-To: <20250307023906.1135613-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250307023906.1135613-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250307023906.1135613-2-irogers@google.com>
Subject: [PATCH v2 2/5] perf x86/topdown: Fix topdown leader sampling test
 error on hybrid
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Andi Kleen <ak@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

When running topdown leader smapling test on Intel hybrid platforms,
such as LNL/ARL, we see the below error.

Topdown leader sampling test
Topdown leader sampling [Failed topdown events not reordered correctly]

It indciates the below command fails.

perf record -o "${perfdata}" -e "{instructions,slots,topdown-retiring}:S" true

The root cause is that perf tool creats a perf event for each PMU type
if it can create.

As for this command, there would be 5 perf events created,
cpu_atom/instructions/,cpu_atom/topdown_retiring/,
cpu_core/slots/,cpu_core/instructions/,cpu_core/topdown-retiring/

For these 5 events, the 2 cpu_atom events are in a group and the other 3
cpu_core events are in another group.

When arch_topdown_sample_read() traverses all these 5 events, events
cpu_atom/instructions/ and cpu_core/slots/ don't have a same group
leade, and then return false directly and lead to cpu_core/slots/ event
is used to sample and this is not allowed by PMU driver.

It's a overkill to return false directly if "evsel->core.leader !=
 leader->core.leader" since there could be multiple groups in the event
list.

Just "continue" instead of "return false" to fix this issue.

Fixes: 1e53e9d1787b ("perf x86/topdown: Correct leader selection with sample_read enabled")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
Tested-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/topdown.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
index f63747d0abdf..d1c654839049 100644
--- a/tools/perf/arch/x86/util/topdown.c
+++ b/tools/perf/arch/x86/util/topdown.c
@@ -81,7 +81,7 @@ bool arch_topdown_sample_read(struct evsel *leader)
 	 */
 	evlist__for_each_entry(leader->evlist, evsel) {
 		if (evsel->core.leader != leader->core.leader)
-			return false;
+			continue;
 		if (evsel != leader && arch_is_topdown_metrics(evsel))
 			return true;
 	}
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


