Return-Path: <linux-kernel+bounces-574134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 759EFA6E111
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58302172C38
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE722264638;
	Mon, 24 Mar 2025 17:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YCadjtt+"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A7B267399
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 17:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837594; cv=none; b=g5TN6/R9b1f8koRwK00nOyrZmpJ97kPdCGppQWWj14BugwFMxJcIfrupXDTHVP8hvRXKl13DQgDX3/lmT1AMi4cjlBK3R2DEEpz7dl+ZB67DJ3tN/lQPMpLBBRM2ZHBMXJrH/5yFl8hM3Y6U9UReLDv9JUVrdcm+eGAze1vD96E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837594; c=relaxed/simple;
	bh=aKPDqW/NC3IvupYuKRIdymXqUgDQVOkH4kyaS7aodbE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fYwH1kahRvORBltT0xwoKuLn4D7NtUxrzogpxO7ATBPwLD3WZ5JGEMi1+JF2qMxW5IbyWknywexRKEMcgRL66SaBSshUq6pWZp/E0tZzh0djv0mMM3NYTMxSvqU7vUF9+W6UnXofjFJYC55VRxcKxpZXWOP69+xtZ8CnNcPvLLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YCadjtt+; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff69646218so12406764a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 10:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742837592; x=1743442392; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=PnRSUNVr3rnNCPEtvYKiZWXoNmnUmRmeili7I7gz5MU=;
        b=YCadjtt+xNLo2kEuettF4P4eY0pvfsAeFyXOW/vW61BR1K7hZ5viOPAJvOH40hsci8
         1pWilOaplTmSFDf3oQLJJtpiSSWxUuRejwYp5Ermueug8s5buJooEqJu1OqZejiDxUnJ
         YD6jiCferK7djoEpfKXL7kURpMHfkernIqfVtdmI9baYS1XoZWbJULOe78iyU1mTiTru
         +etBCNTpTvbhYS0ROP2tWqGb+s+HOfI1Dx989POW8fLs6Kg4+OcRP3jPtpkwCEb/QQQn
         GHyg0S5mducRRavtwn0MKqyyUsh3gjZ7/vyy4G3pj6avK88S2cGiuWaMndsDRJ2hsC8q
         205w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837592; x=1743442392;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PnRSUNVr3rnNCPEtvYKiZWXoNmnUmRmeili7I7gz5MU=;
        b=sw+gZROrDFzzRXLF1L7fL0SsHv5N1a4Z6RU/1W8/A4mqCKJOaclv6qM3R+ic5mq1vt
         c4pziYVDc8gcQebeS05LlQio28WE/wADmhyy+ciET3e6q2LoI9vuJY75/JiLY9NS8Fe9
         gFWDi6i9Zt09SVihwn3LDla+9iT4Wgk+z9E2lfo3jXz4w2AMjkdCRoc3nKwsaLqxQ2LP
         niaOPR1sNIbK6rdc84jjtKXdgWkA6XiCqcll9uWLlxo8CIrORD1SkSWq+9BFngu0QivG
         ysyx22q4QgwXwYO1Jzo0uSC55SnPVJgPKXHg8iKOh/sYpwOCZfJpWjyWEzOR8iszytpa
         PUkg==
X-Forwarded-Encrypted: i=1; AJvYcCWLglmAnLUB+wdiS8Lt+aofgibFMsttc93oTXIN0bAZBr2F1F9eBuRs9g6XqYOwPmJIDSW1IWF7kLQ5PFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcWKBXY6gBSgEwZQkpkTvQ74Ub2KKn+4Orwpm1FN9bSCJ7mjUq
	XX/ne27E1II9KFhqhfBvQpwcKe2wQqh2D5mmwnJutMYUCzALy2x5OAwfx/YsFqbIMfCh1MPP8al
	BrHqKGg==
X-Google-Smtp-Source: AGHT+IEW+7GJcDXGG6CURiKG3q1Lc5zKORtSrc56gB/zRY+t9aZM8BPwlqJUyaIgVCLGS/H1C2BVYJ2TtCKc
X-Received: from pjbqx3.prod.google.com ([2002:a17:90b:3e43:b0:2ff:5f6a:835c])
 (user=mizhang job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4fcc:b0:2f4:434d:c7ed
 with SMTP id 98e67ed59e1d1-3030fea7d0cmr26492841a91.16.1742837591632; Mon, 24
 Mar 2025 10:33:11 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon, 24 Mar 2025 17:30:52 +0000
In-Reply-To: <20250324173121.1275209-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324173121.1275209-13-mizhang@google.com>
Subject: [PATCH v4 12/38] perf/x86/core: Do not set bit width for unavailable counters
From: Mingwei Zhang <mizhang@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Yongwei Ma <yongwei.ma@intel.com>, 
	Xiong Zhang <xiong.y.zhang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Jim Mattson <jmattson@google.com>, Sandipan Das <sandipan.das@amd.com>, 
	Zide Chen <zide.chen@intel.com>, Eranian Stephane <eranian@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Nikunj Dadhania <nikunj.dadhania@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Sandipan Das <sandipan.das@amd.com>

Not all x86 processors have fixed counters. It may also be the case that
a processor has only fixed counters and no general-purpose counters. Set
the bit widths corresponding to each counter type only if such counters
are available.

Fixes: b3d9468a8bd2 ("perf, x86: Expose perf capability to other modules")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/events/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 96a173bbbec2..7c852ee3e217 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -3107,8 +3107,8 @@ void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
 	cap->version		= x86_pmu.version;
 	cap->num_counters_gp	= x86_pmu_num_counters(NULL);
 	cap->num_counters_fixed	= x86_pmu_num_counters_fixed(NULL);
-	cap->bit_width_gp	= x86_pmu.cntval_bits;
-	cap->bit_width_fixed	= x86_pmu.cntval_bits;
+	cap->bit_width_gp	= cap->num_counters_gp ? x86_pmu.cntval_bits : 0;
+	cap->bit_width_fixed	= cap->num_counters_fixed ? x86_pmu.cntval_bits : 0;
 	cap->events_mask	= (unsigned int)x86_pmu.events_maskl;
 	cap->events_mask_len	= x86_pmu.events_mask_len;
 	cap->pebs_ept		= x86_pmu.pebs_ept;
-- 
2.49.0.395.g12beb8f557-goog


