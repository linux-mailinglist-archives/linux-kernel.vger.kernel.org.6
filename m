Return-Path: <linux-kernel+bounces-574160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 390F5A6E166
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83990188B50C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D44F26B95E;
	Mon, 24 Mar 2025 17:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k297gcpG"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0ED26B2B3
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 17:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837627; cv=none; b=igENXaePHrqc2Q9iEX38T/9J+zmJb62S/N7d+I8JyqFv1euaiDwMT0A3ZlT5Gfb+uX3h6SKAQZl5Z9P+YQp5YRDyKA/PM1y+kYLwHG+bh3X6XwZvIuyrnQa9F3dYYjp9t5VyQOi8DByUxfpPkB6TAaqd+GG29QVEIrEzYCx8FaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837627; c=relaxed/simple;
	bh=SPV6f+vG/kNYrdnOrV7Ud4dp6yqxNxakKCs85+jvmag=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jHWkycCw6p+pkUDziiAf2I/U7hn3soaNTDdUzLIScKXNvqBX2MrGyPQIgEqQ7p4POS1Dvukd2Pg+ZKaCDljbxMAyvANiPIV0mjGyZo79RqU6w0NSgDzFEkiT/ccphApDmj2rarO9tsA3b5mjqBxtAzchKg49517m9ESBNcCYKSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k297gcpG; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22651aca434so76033995ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 10:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742837626; x=1743442426; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=3FAxBAfvnTeE02w75JVrD4RSLbO6pRSDBEOxfTgOTwA=;
        b=k297gcpG3+AiZfVEIa1bic5XpHjHyo6FxbO2YOIXeEEjx3v3hugoGxcb2zBZR8uvsg
         EmT1t5jLyF2iIV7gD1/Yf1AWFAR11fZIXmm+/aeltchjq3tUVBeAC77JOFJcgneqqHUo
         bcdKnqy1fIYPIXTQJpQhvnpPSXIAVOAHubTjb/X+vGlX3rBqRpxcgtZYfU2dp3vOjx8B
         vtL+PbgbhSjREx75TThEXGnE5eMleuj9TPBJxe5l1qCQBsLOVKZ0dpYqADM/3/i3io2R
         Dt9GgaLgWEETfkwCbQ+3ngHbH4NrtQR/SSDQjxXSff/QwK1IGhw+cttoLXpVxDCypwxd
         7h5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837626; x=1743442426;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3FAxBAfvnTeE02w75JVrD4RSLbO6pRSDBEOxfTgOTwA=;
        b=VTiFRBy7OtgHnTqWGKgbLwLbK9qnf41qS3fjBT/M3EvVjL6uqN4U6E0mYCJqma+Fyg
         Y7VXncOL1wx7nl73q3RZS0G+xlpAyD0GHy4jdrR8tnX9Gjlsf+XvbFPoewFkCWsU0mXF
         fm0RDHsf5T8OCdGiWw2oJBwkDXUwqJRh15ryMLbX97+I1UFvbX6i/HuvckmePCd0sLeC
         pl2dIJjyotWpUl2oMrq1c7ksop7LMm1N+bDlRePqmjDPEXBhpYGim6hJ7C7pwLbqW+NK
         KuRyKwHq/RkFmsLweQyDtpnQBjI0B+r/CtTUfY0g7SnPgNx0IDM52brTAzYIYqrNr3Iq
         uNLw==
X-Forwarded-Encrypted: i=1; AJvYcCWusyHfcegX090JGU/drvx/SIf2twGGkhnyvquoXo7SUsTHMfOPN1g+6FqkPCqjVFdMAs4n5eery+hEVvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyugW8dQPEtqBA4/USZU9NMrQRmWQZSOgU7TUnVQdChkaF86GVq
	md9mkUgBDMXKCLO5QIKTar4j6H6Hs0rV7IxXNckUu/lGLC7Fwu3I72BPozsWj0JpD4fxwIloF3G
	J42HfUw==
X-Google-Smtp-Source: AGHT+IFNR4hLiVkO6uhlXqD3citXpGRm9BfvjKuSb2pxzfsnHIVx+SR4I6E3SRncE31NfMsm/svDGQp+t39P
X-Received: from pgbeh14.prod.google.com ([2002:a05:6a02:256e:b0:af2:3b16:9767])
 (user=mizhang job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:12d5:b0:1fb:e271:82e2
 with SMTP id adf61e73a8af0-1fe42f35752mr23440489637.11.1742837625714; Mon, 24
 Mar 2025 10:33:45 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon, 24 Mar 2025 17:31:13 +0000
In-Reply-To: <20250324173121.1275209-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324173121.1275209-34-mizhang@google.com>
Subject: [PATCH v4 33/38] perf/x86/intel: Support PERF_PMU_CAP_MEDIATED_VPMU
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

From: Kan Liang <kan.liang@linux.intel.com>

Apply the PERF_PMU_CAP_MEDIATED_VPMU for Intel core PMU. It only
indicates that the perf side of core PMU is ready to support the
passthrough vPMU.  Besides the capability, the hypervisor should still need
to check the PMU version and other capabilities to decide whether to enable
the mediated vPMU.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/events/intel/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index e86333eee266..ab74fdfa6a66 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4943,6 +4943,8 @@ static void intel_pmu_check_hybrid_pmus(struct x86_hybrid_pmu *pmu)
 	else
 		pmu->intel_ctrl &= ~(1ULL << GLOBAL_CTRL_EN_PERF_METRICS);
 
+	pmu->pmu.capabilities |= PERF_PMU_CAP_MEDIATED_VPMU;
+
 	intel_pmu_check_event_constraints(pmu->event_constraints,
 					  pmu->cntr_mask64,
 					  pmu->fixed_cntr_mask64,
@@ -6535,6 +6537,9 @@ __init int intel_pmu_init(void)
 			pr_cont(" AnyThread deprecated, ");
 	}
 
+	/* The perf side of core PMU is ready to support the mediated vPMU. */
+	x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_MEDIATED_VPMU;
+
 	/*
 	 * Install the hw-cache-events table:
 	 */
-- 
2.49.0.395.g12beb8f557-goog


