Return-Path: <linux-kernel+bounces-413568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D63F09D1B17
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 23:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F332859B5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 22:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4D51E7C26;
	Mon, 18 Nov 2024 22:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wSMucEB5"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7CE158DAC
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 22:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731968747; cv=none; b=YgIh1pidaMKUwR6W20UIigqdiTe14wVzBH8mlEQGr6a+otrMy4/knRFwRTx2auzErDrj9b6vRNRL7dsLK6QDwJEyWQG9YVDwn5YV5sMxnEsegyTqNDbsCiK8XdB1puMS2SeZVmQ9Z54BCAp5zlz7EbbVbp5diwjsKYW0BSAy1I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731968747; c=relaxed/simple;
	bh=gP4UrWxmVwADGYWCtmu+TyIRa/S+bnajwdjRKoNwMvg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YagSQ1m3TeNavUo1rvHFQYm6CCp+dI8pXtM2gh0QdVvq7JlJWt0Rakf1WTKpkhMJm7jxkfjVVKfpcsAd3SbqUy76DOWN+LrKskK+O1WwS2Mu2xLq+m3JB0pf6ZgyaPP/cHisAYbEedo6kK89Nyt1nJMCGoNC/9pMwKTcWK8rUy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wSMucEB5; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea8a5e862eso62432107b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 14:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731968745; x=1732573545; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=14OsMhdGfdcpS80IHQ9XNfdJp63ZxqrrUOpqJIR6RjE=;
        b=wSMucEB54wQK64K2/YAfcjNw4fzLmbmujoJNfeIn2j2dwFyxEmkkFWZeiQKOAb7k22
         IVkNF8bNFzTFTolD2GPCsrpr2kQdXsz8+3lUO5c+m+kan0mHROxyYmx+EcbZ3RzxM+n0
         TZLTdA/WHU0tl7SzaFpkYkzRXtBGX44Y3NiMVvCGOD17vDQFp0hk0aiyo0Kq0YN+58ln
         rRZtKVkkLr3Qijf6zI07056XgjDrx+t2qV8cwFLYhwSiXifbeEIRUmb9ml6ESXBZ3xT+
         8hZVrFnjhOYK4E0yWdYLMetBc39smYIoniHaXC9r0+t63ixqjrwPwKSFVntzpk9kL0pN
         G0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731968745; x=1732573545;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=14OsMhdGfdcpS80IHQ9XNfdJp63ZxqrrUOpqJIR6RjE=;
        b=ueaXbMsTxdQ7vQFYuhgjP82r6+Wp9lkrPfYB/gD3I5awmS5YpT8RtwdXEcM/mjfq1s
         79ozLQPzGiUKoNNAJeoHiqq9aEVyxLnkSMBeiFsnLuEUiNxM7bG9xb5CPLongWHMAe18
         b/Rttlpqqnx2kPMfweejwMIVor3K7q/mf1BCv4qijyjum/sb0ULwxCpzLLE1X1KNJx3y
         IpJ8GN+673gAxRQaccA7NLQvCLFxevnqt8Gqubskdcs6Gc/pTG5n7Gv+wSX0V1t6LtqX
         tMdE8atKCjlVwqw4ihSkgW74XHW0+Zyr3BXj5tMgmFmSHThgYtSifIjOgYjm6vaV9rHS
         y33A==
X-Forwarded-Encrypted: i=1; AJvYcCXbzFv5hKQYwAgVwwnIMTEsW1yGXaZDVn7lxHbIaWh63CZ9PU/a1dF7MUUbCuMNCJtHfZf/fz81qR2XbAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzGAeXBhg419LEU1sQ093DDTenhQzzfvZp+9MZBgoeuBW2AHZd
	VnfqT7BjviqHSAcZtzgN3spaPDxBAkppBqaaLF/eSV690qOcrJjs9anzx6CMFF/zhhepyZMTTTI
	d
X-Google-Smtp-Source: AGHT+IHaqSLX7qNc1UhlL7DMMonDFnZRihYI5SIMh0lBI+T2x10S5W6DAGbzQyiEudeWnrky5v96GHNZfoI=
X-Received: from yabinc-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:bc56:3202:f6e1:c119])
 (user=yabinc job=sendgmr) by 2002:a05:690c:2e08:b0:6ee:9a08:7686 with SMTP id
 00721157ae682-6eeaa3a3e90mr127907b3.4.1731968744961; Mon, 18 Nov 2024
 14:25:44 -0800 (PST)
Date: Mon, 18 Nov 2024 14:25:40 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241118222540.27495-1-yabinc@google.com>
Subject: [PATCH v2] arm64: Allow CONFIG_AUTOFDO_CLANG to be selected
From: Yabin Cui <yabinc@google.com>
To: Rong Xu <xur@google.com>, Han Shen <shenhan@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Cc: Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"

Select ARCH_SUPPORTS_AUTOFDO_CLANG to allow AUTOFDO_CLANG to be
selected.

On ARM64, ETM traces can be recorded and converted to AutoFDO profiles.
Experiments on Android show 4% improvement in cold app startup time
and 13% improvement in binder benchmarks.

Signed-off-by: Yabin Cui <yabinc@google.com>
---

Change-Logs in V2:

1. Use "For ARM platforms with ETM trace" in autofdo.rst.
2. Create an issue and a change to use extbinary format in instructions:
   https://github.com/Linaro/OpenCSD/issues/65
   https://android-review.googlesource.com/c/platform/system/extras/+/3362107

 Documentation/dev-tools/autofdo.rst | 18 +++++++++++++++++-
 arch/arm64/Kconfig                  |  1 +
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/autofdo.rst b/Documentation/dev-tools/autofdo.rst
index 1f0a451e9ccd..a890e84a2fdd 100644
--- a/Documentation/dev-tools/autofdo.rst
+++ b/Documentation/dev-tools/autofdo.rst
@@ -55,7 +55,7 @@ process consists of the following steps:
    workload to gather execution frequency data. This data is
    collected using hardware sampling, via perf. AutoFDO is most
    effective on platforms supporting advanced PMU features like
-   LBR on Intel machines.
+   LBR on Intel machines, ETM traces on ARM machines.
 
 #. AutoFDO profile generation: Perf output file is converted to
    the AutoFDO profile via offline tools.
@@ -141,6 +141,22 @@ Here is an example workflow for AutoFDO kernel:
 
       $ perf record --pfm-events RETIRED_TAKEN_BRANCH_INSTRUCTIONS:k -a -N -b -c <count> -o <perf_file> -- <loadtest>
 
+   - For ARM platforms with ETM trace:
+
+     Follow the instructions in the `Linaro OpenCSD document
+     https://github.com/Linaro/OpenCSD/blob/master/decoder/tests/auto-fdo/autofdo.md`_
+     to record ETM traces for AutoFDO::
+
+      $ perf record -e cs_etm/@tmc_etr0/k -a -o <etm_perf_file> -- <loadtest>
+      $ perf inject -i <etm_perf_file> -o <perf_file> --itrace=i500009il
+
+     For ARM platforms running Android, follow the instructions in the
+     `Android simpleperf document
+     <https://android.googlesource.com/platform/system/extras/+/main/simpleperf/doc/collect_etm_data_for_autofdo.md>`_
+     to record ETM traces for AutoFDO::
+
+      $ simpleperf record -e cs-etm:k -a -o <perf_file> -- <loadtest>
+
 4) (Optional) Download the raw perf file to the host machine.
 
 5) To generate an AutoFDO profile, two offline tools are available:
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fd9df6dcc593..c3814df5e391 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -103,6 +103,7 @@ config ARM64
 	select ARCH_SUPPORTS_PER_VMA_LOCK
 	select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
 	select ARCH_SUPPORTS_RT
+	select ARCH_SUPPORTS_AUTOFDO_CLANG
 	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION if COMPAT
 	select ARCH_WANT_DEFAULT_BPF_JIT
-- 
2.47.0.338.g60cca15819-goog


