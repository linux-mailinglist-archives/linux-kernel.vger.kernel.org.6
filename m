Return-Path: <linux-kernel+bounces-417356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0776A9D52EC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B38441F21EB6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEA01DED4C;
	Thu, 21 Nov 2024 18:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hFstuxpQ"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD2E1DE4FE
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732215205; cv=none; b=igO7x6wls1blPoA3pvzbx3d/IrhTeC79YnJv30Jq3149KyaXaBcA51EzLtPXbu6vZhdoyhXtWPiV3UTi48hexARfTIi/yZvp+4nlBgnJu1zExPhprCdA7XPl/uejoHc0bvyV9+6xB15NePMs2jYdMltISANTs6GZG4YcsyvXkf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732215205; c=relaxed/simple;
	bh=/MlTsvEZhBm6lsxe7EmxCdECCTQKt4d+z1t/zvxQERw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FVNzkBys9MgV0bvGtYKWmUL2kBapCZ4UJrLlFWrL0Dbtdx33CmXKTdcl7elrcSVc6ENrqPmhMrzLljh9Y7s66Sy8pvSghIex+Ityd4iEJ7Bwh3cFk2REtJpmxMsxKfYcUMvJq4XwhfPsKgRxUrxu7Z5B1r6O0RhySa9qwJwISqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hFstuxpQ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e330f65bcd9so1568165276.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 10:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732215202; x=1732820002; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=rsHo0Py3TPU7pbh7g3h3HouheNFLNCt6iVoC0xc8Ffg=;
        b=hFstuxpQUnAlVZ3bZY0abEGefUG6T5jzWCjPKELKL2luMCA0BgWlYBnf/t8KI/Fcag
         gpjsF21oDoUURQfgS4Wtb3BXl+i//gNyaPJOEEjy94US8YihoTUdtW4SitxRCesVEUea
         vxHJdK4GDFgE30iC1NVwzwk3rhAHsEz/WzYnSvpT6QoXZn6VNSgF1bkyRmSRRfz8V28D
         mqOkCcoeTfkTgrENC3dl7X04Z54uYxMrQJFtuhQdY1xPkHd158oMT3CfiyF0wWNtQcRE
         VBs35tgJczBa26nosQ4/hsw0AJLMnOMQpyqBse7zc2u04zwX6FF31jQidRu6qcUJI78z
         LHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732215202; x=1732820002;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rsHo0Py3TPU7pbh7g3h3HouheNFLNCt6iVoC0xc8Ffg=;
        b=El7jZv5v5lVJnhikIa/if7jNvFecFNSmUVlmeynEszA2CKqg9XAW/ElKHD3M0h84Qa
         8OR9t7aLIPRy+1RVS2zFD0PHvYiqbx+7xtsugVdUV3LPOH8SLe087CI+Q+qaqecCKIZQ
         F+6OyjX1X2oWp3oJ5tP3gziYAc0cG3SD4YWjTFj0r/oWmVpdvEQqp5Ye2qmFI3qOfbNA
         LgYzbCqNZ+6jlOQ4c0elXxJ3osFOEoAs134v1j/DnoyujI0RY5BlhlsI4Cmj9qvkC6vz
         ULD1w29Pdq3IXv3e5X8s8smo70KFbbpQf8XWAOWLWYAV08aqHJSYwZJZa9EaT34BEQos
         G2jg==
X-Forwarded-Encrypted: i=1; AJvYcCU61Z+2ELEKQzXlJlg8XELuLu1rvfLKeuvKnFfAiQtPqXS1K4nvk4ca+M4PCxycZ3h5tO9KxQGAeZJILHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YySshPLL4LGTwUcWx8kMEeWbVnoaLbtPKlP+OLGg6/zRFSUGZpp
	pbV12VNQLY2Hq+68n0HiZm917A7z1wk7/wDk5pG7m2XxX56cjD4Mz4BY0CrLYQdfnRRMTkgzuxm
	hskQ9rw==
X-Google-Smtp-Source: AGHT+IEa89oTDs6AEs0b6qM9YtZe6l8s01zJVqD4TK4bwVkMk4+VBxvLRHFEIhtWa5nFhIw1lpDFQnaYmZLg
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a25:e90b:0:b0:e2e:317a:d599 with SMTP id
 3f1490d57ef6-e38f700d9c3mr998276.2.1732215202627; Thu, 21 Nov 2024 10:53:22
 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu, 21 Nov 2024 18:52:55 +0000
In-Reply-To: <20241121185315.3416855-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241121185315.3416855-1-mizhang@google.com>
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241121185315.3416855-4-mizhang@google.com>
Subject: [RFC PATCH 03/22] x86/aperfmperf: Introduce restore_host_[am]perf()
From: Mingwei Zhang <mizhang@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Perry Yuan <perry.yuan@amd.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jim Mattson <jmattson@google.com>

Round out the {host,guest}[am]perf APIs by adding functions to restore
host values to the hardware MSRs. These functions:

1. Write the current host value (obtained via get_host_[am]perf()) to
   the corresponding MSR
2. Clear the per-CPU offset used to track the difference between guest
   and host values

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/include/asm/topology.h  |  2 ++
 arch/x86/kernel/cpu/aperfmperf.c | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index fef5846c01976..8d4d4cd41bd84 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -309,6 +309,8 @@ extern u64 get_host_aperf(void);
 extern u64 get_host_mperf(void);
 extern void set_guest_aperf(u64 aperf);
 extern void set_guest_mperf(u64 mperf);
+extern void restore_host_aperf(void);
+extern void restore_host_mperf(void);
 
 extern void arch_scale_freq_tick(void);
 #define arch_scale_freq_tick arch_scale_freq_tick
diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index 8b66872aa98c1..4d6c0b8b39452 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -135,6 +135,22 @@ void set_guest_mperf(u64 guest_mperf)
 }
 EXPORT_SYMBOL_GPL(set_guest_mperf);
 
+void restore_host_aperf(void)
+{
+	WARN_ON_ONCE(!irqs_disabled());
+	wrmsrl(MSR_IA32_APERF, get_host_aperf());
+	this_cpu_write(host_aperf_offset, 0);
+}
+EXPORT_SYMBOL_GPL(restore_host_aperf);
+
+void restore_host_mperf(void)
+{
+	WARN_ON_ONCE(!irqs_disabled());
+	wrmsrl(MSR_IA32_MPERF, get_host_mperf());
+	this_cpu_write(host_mperf_offset, 0);
+}
+EXPORT_SYMBOL_GPL(restore_host_mperf);
+
 static bool __init turbo_disabled(void)
 {
 	u64 misc_en;
-- 
2.47.0.371.ga323438b13-goog


