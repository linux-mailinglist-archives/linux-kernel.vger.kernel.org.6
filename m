Return-Path: <linux-kernel+bounces-574149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651FAA6E123
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00DE37A4BF0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3241C269AE4;
	Mon, 24 Mar 2025 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JyQJFp7t"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A571A268C6F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 17:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837613; cv=none; b=N+8N9S07BFVlnke9aTfHENzMRuQBErURJr50ZG+l8nFV5EkIpVW3DKoE1rfjpqYQm5YzYMQQMHMOlpnbMTSRqClraq29b5c2VBMbPBpMYFQF2F7MS9vfCU0nvTlVYXyu9vWeZKZWRidbPXR3omty9X/MLVmeNi0sLiXuyvw1xTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837613; c=relaxed/simple;
	bh=e5TykSXhWcjiHTlVnT5EVQdmrLLoGQPyiymnk17gYkY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oczg/G6petnqMgPYSDYcrSm+asfrnF9Mvr3+tpblwwFHbPaumEkvXU8cHWhp1RS7/3N4jm5FEL44HEmr+8lA/16sMXK+7ii9bFjR/SLOgHjbqMVcqsIXD8Ksz6jOyFbLaA+aSOFwnjssanmvJNYqLv+TV0QAdUdkMBsdEiBeN9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JyQJFp7t; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff58318acaso13392776a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 10:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742837611; x=1743442411; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=XEyrlidpGrXPVy+91ZT3XWvyzIHfkJ7R/xos7wEnLbQ=;
        b=JyQJFp7tk5/XUK/YI0VTxLgfOFlFJFpSYykUuH3oDnuwf2ZePUDvcBK0LQk5MLAwSL
         LMVYpCl7nTTGmMGWyj2Va0oObNMO6gaqSmxYaXksYP/vIIIHPFtoae6blKRE8HbTDlo7
         stOwKKoITG6wbD8DrR/pJWt3754FADxEBVFn+C0C+w5aHHEDRyfFIdB15DY80RdT6AqB
         PitHdWdoa2OqZWBDjO/9swmNW4ZKzpYEfQuLoIIqskB+nkIvT+BBCH+Np6zu4ZJiMmgd
         f9+YhNI/um+VpSpfbeGrEZKCcdfb45yRwjKKVbRov+HCAQfsMLGjN4oSCqY0OxzrPKRM
         V8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837611; x=1743442411;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XEyrlidpGrXPVy+91ZT3XWvyzIHfkJ7R/xos7wEnLbQ=;
        b=PnzkBv9E/0ZVBZlPx2mVwsBwUNeHIGMLu89oUMIPVFsj6jWqHvp8EjJTH/QXGIfHqs
         DuGssSZSoGeeXbhseNZliM+oixwJb5aziSc4D3Q8isobNlIPfBkUHURq86PW1N1ZzwxI
         7ryFO1lV1qpqhp3jpu9nndsmTkDUlEkRF0X9r9/K4ClNM6rvRMlTWzxcqyNSfbPQZL22
         dNhTBYEwQwEnsuZJbhJhuBUqnd6S/+tLCX9TEuCX+35jJimkHz7LkDR40IUsOhM41sHs
         C3jTzF0uoEh2BhYYW8oqiVkPH41Fz3VuvrIi/su/pbqOUC0LvOz9XS2IFkp3QlWzxYji
         TNMg==
X-Forwarded-Encrypted: i=1; AJvYcCVezvd3NudIhPYTZhYyQHqJEZ48NV3Wy3oWmwqgmxgrK1KnRdrN3ZrX+b/DeJdBNyCmZy/sbTiXppO0a0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvM3uwzreYROcX7MqBJKntMY8dMJp5YJjwh2HgR3BQc2E081/r
	9iIOSm9qsVS6f2bJ14MVoNqtNv4ad5agiZhzL3VEyMBsJ7fkQqdFm42oNSL2wXRZ5oA8OhACR7k
	+CR1FMw==
X-Google-Smtp-Source: AGHT+IHd9nbaxHBmU/fV94phikYnv83+4tNG/MgzkHkbPYI6qikEaqz7CMK9KVUvtgRvzrdBVwsQp4ULQLs1
X-Received: from pjtd15.prod.google.com ([2002:a17:90b:4f:b0:2f7:d453:e587])
 (user=mizhang job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c43:b0:2fa:137f:5c61
 with SMTP id 98e67ed59e1d1-3030fe856edmr26058407a91.12.1742837611219; Mon, 24
 Mar 2025 10:33:31 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon, 24 Mar 2025 17:31:04 +0000
In-Reply-To: <20250324173121.1275209-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324173121.1275209-25-mizhang@google.com>
Subject: [PATCH v4 24/38] KVM: x86/pmu: Exclude PMU MSRs in vmx_get_passthrough_msr_slot()
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

Reject PMU MSRs interception explicitly in
vmx_get_passthrough_msr_slot() since interception of PMU MSRs are
specially handled in intel_passthrough_pmu_msrs().

Signed-off-by: Mingwei Zhang <mizhang@google.com>
Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/kvm/vmx/vmx.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 38ecf3c116bd..7bb16bed08da 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -165,7 +165,7 @@ module_param(allow_smaller_maxphyaddr, bool, S_IRUGO);
 
 /*
  * List of MSRs that can be directly passed to the guest.
- * In addition to these x2apic, PT and LBR MSRs are handled specially.
+ * In addition to these x2apic, PMU, PT and LBR MSRs are handled specially.
  */
 static u32 vmx_possible_passthrough_msrs[MAX_POSSIBLE_PASSTHROUGH_MSRS] = {
 	MSR_IA32_SPEC_CTRL,
@@ -691,6 +691,16 @@ static int vmx_get_passthrough_msr_slot(u32 msr)
 	case MSR_LBR_CORE_FROM ... MSR_LBR_CORE_FROM + 8:
 	case MSR_LBR_CORE_TO ... MSR_LBR_CORE_TO + 8:
 		/* LBR MSRs. These are handled in vmx_update_intercept_for_lbr_msrs() */
+	case MSR_IA32_PMC0 ...
+		MSR_IA32_PMC0 + KVM_MAX_NR_GP_COUNTERS - 1:
+	case MSR_IA32_PERFCTR0 ...
+		MSR_IA32_PERFCTR0 + KVM_MAX_NR_GP_COUNTERS - 1:
+	case MSR_CORE_PERF_FIXED_CTR0 ...
+		MSR_CORE_PERF_FIXED_CTR0 + KVM_MAX_NR_FIXED_COUNTERS - 1:
+	case MSR_CORE_PERF_GLOBAL_STATUS:
+	case MSR_CORE_PERF_GLOBAL_CTRL:
+	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
+		/* PMU MSRs. These are handled in intel_passthrough_pmu_msrs() */
 		return -ENOENT;
 	}
 
-- 
2.49.0.395.g12beb8f557-goog


