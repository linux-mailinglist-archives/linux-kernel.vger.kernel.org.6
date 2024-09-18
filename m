Return-Path: <linux-kernel+bounces-332940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 481CB97C111
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 22:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D67E5B2245A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 20:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E101CC14D;
	Wed, 18 Sep 2024 20:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cfbogPtS"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B881CB52A
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 20:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726692844; cv=none; b=G4F28MiKgphK0VrjG1pJK2O2Xlz6VE1VqY6k4Y+EHNPKzTOz1xciGvOvVtd3NgRrmU709m66zjJ1ZiBLDj5ekCwet/JFN72PcJFAmD6pZaQW/qLdx8hYzDvT5jBepvrY1YylUuNts74ZGMd3sRHUc0HvCEtN+gwWchAww1C3hU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726692844; c=relaxed/simple;
	bh=aSdFYlUtz6P5Eo1j6ju7Ac/ao+lpyvnXe6lnLzmL3WA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gxc9nvbrs9VLzDt/qDhmZPR2we0hBYIM4n4eEkv/JD5ZFPgAQqTwkhgpaEqeHLKjAj/oiEZQUhSfaOlWF5QI4VIEKJwJyHS38Lc5y3YBzPVPTSJwfq4k6uHH9QR82h40GlaRCYzzZ/nmu7OirbzDrFYDxBjqX16g1396wL9/sbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cfbogPtS; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1dc0585fbfso291998276.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 13:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726692842; x=1727297642; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OkrE8WmvzpBAiiKTV2LkBvEEkr6B/d2pJWlGO3Ml/wo=;
        b=cfbogPtSj8ie6NDwzOBjkw9KUvVueBVQFtgEXEPTJ+ZK3iic5Mlg8KrD8udtheKggD
         OOpHHBYUPzlUD3pyA68SwubY74nrvzHj4eWW4ywCKRHNax4ACrRs4GTtlVenEgx3pbVP
         1D9YLCV1w6wk7FpnI+5G9++9cXC4wPp06Ih880t2hPJiuG8dOmErdchgWtsQ5z7jGaGs
         fYXPhcoV8UxMeYORpNdcxMrcGXd+3olnZWNMJ5HQa1e6ArbT1Rs1rOGy5vWcaHWc8n4C
         Yf+Tgon+Qbncf/MpxDUQrnx0eekfRSZ0YDf05kaLWhcTb8EZPpejr0RyjW6g9YhuSyyv
         72Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726692842; x=1727297642;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OkrE8WmvzpBAiiKTV2LkBvEEkr6B/d2pJWlGO3Ml/wo=;
        b=WdAIwYBRIcwaHQ0la4MSvR6KmOyQcgKucztW0ljUNZ7iipdA8/CL7UKOt/Jn0mZteb
         nbi8McSS4DK9NPTj7clLkaFqP0WCC3Xe7fscjoSvyvOH76cr51deJorYOCAWRwm9qwWQ
         wbk8+aOmtvJjrkZnpmpHLOJirTeQSddHpxWeLNKc4I1RWAtwOM6EyI9GU9XY2ea1cvA1
         Jn/59YGlFaVfIE9alKQXBiO+m4jMx1cL5ou+/66NHcJV9/NyO91MkIrfMqpaZ2uQIx8q
         qRQ7XJtyvqKQRAm7M0lz61GDZSOH+60cpBHpYaAMNadICsyo3RoHKB2WXiNfCqirQPRk
         ShPg==
X-Forwarded-Encrypted: i=1; AJvYcCUW/NZDk0zjh+O+gI21bIpuyD89rKBHKzY+3x0ddtLLpabCvmEuRjwNHOlmQNInAMlCCMzzadm0uZNHCCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOe+zkax3Uv0z3IWbp3i2AbeaDf8OQjEz9adHHhHzmvE+mz/kF
	knUCYhTDVZ6vHmRGrCAXdLIhoknP/yQ8SIXMe/XglwKq4trSQyG/GSe5qtSbLwEx5eeoHOU4gSt
	iPsxrWzPO/opO3KlpgDU3XA==
X-Google-Smtp-Source: AGHT+IGglH1MwiuQb6nf3SblZvhLMFNMZKCm/U6KRL3GGVpCYBWH8kXimB5ATPz5Ij0DZlhI64+AMN+To08XeyX1Gw==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a25:a1a3:0:b0:e1a:6bf9:aa83 with SMTP
 id 3f1490d57ef6-e1d9db9e12fmr70673276.3.1726692842109; Wed, 18 Sep 2024
 13:54:02 -0700 (PDT)
Date: Wed, 18 Sep 2024 20:53:17 +0000
In-Reply-To: <20240918205319.3517569-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240918205319.3517569-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240918205319.3517569-5-coltonlewis@google.com>
Subject: [PATCH v2 4/6] KVM: x86: selftests: Test read/write core counters
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Mingwei Zhang <mizhang@google.com>, Jinrong Liang <ljr.kernel@gmail.com>, 
	Jim Mattson <jmattson@google.com>, Aaron Lewis <aaronlewis@google.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Run a basic test to ensure we can write an arbitrary value to the core
counters and read it back.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 .../selftests/kvm/x86_64/pmu_counters_test.c  | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
index 5b240585edc5..79ca7d608e00 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
@@ -641,11 +641,65 @@ static uint8_t nr_core_counters(void)
 		return AMD_NR_CORE_EXT_COUNTERS;
 
 	return AMD_NR_CORE_COUNTERS;
+}
+
+static uint8_t guest_nr_core_counters(void)
+{
+	uint8_t nr_counters = this_cpu_property(X86_PROPERTY_NUM_PERF_CTR_CORE);
+	bool core_ext = this_cpu_has(X86_FEATURE_PERF_CTR_EXT_CORE);
+
+	if (nr_counters != 0)
+		return nr_counters;
+
+	if (core_ext)
+		return AMD_NR_CORE_EXT_COUNTERS;
+
+	return AMD_NR_CORE_COUNTERS;
+
+}
 
+static void guest_test_rdwr_core_counters(void)
+{
+	bool core_ext = this_cpu_has(X86_FEATURE_PERF_CTR_EXT_CORE);
+	uint8_t nr_counters = guest_nr_core_counters();
+	uint8_t i;
+	uint32_t esel_msr_base = core_ext ? MSR_F15H_PERF_CTL : MSR_K7_EVNTSEL0;
+	uint32_t cnt_msr_base = core_ext ? MSR_F15H_PERF_CTR : MSR_K7_PERFCTR0;
+	uint32_t msr_step = core_ext ? 2 : 1;
+
+	for (i = 0; i < AMD_NR_CORE_EXT_COUNTERS; i++) {
+		uint64_t test_val = 0xffff;
+		uint32_t esel_msr = esel_msr_base + msr_step * i;
+		uint32_t cnt_msr = cnt_msr_base + msr_step * i;
+		bool expect_gp = !(i < nr_counters);
+		uint8_t vector;
+		uint64_t val;
+
+		/* Test event selection register. */
+		vector = wrmsr_safe(esel_msr, test_val);
+		GUEST_ASSERT_PMC_MSR_ACCESS(WRMSR, esel_msr, expect_gp, vector);
+
+		vector = rdmsr_safe(esel_msr, &val);
+		GUEST_ASSERT_PMC_MSR_ACCESS(RDMSR, esel_msr, expect_gp, vector);
+
+		if (!expect_gp)
+			GUEST_ASSERT_PMC_VALUE(RDMSR, esel_msr, val, test_val);
+
+		/* Test counter register. */
+		vector = wrmsr_safe(cnt_msr, test_val);
+		GUEST_ASSERT_PMC_MSR_ACCESS(WRMSR, cnt_msr, expect_gp, vector);
+
+		vector = rdmsr_safe(cnt_msr, &val);
+		GUEST_ASSERT_PMC_MSR_ACCESS(RDMSR, cnt_msr, expect_gp, vector);
+
+		if (!expect_gp)
+			GUEST_ASSERT_PMC_VALUE(RDMSR, cnt_msr, val, test_val);
+	}
 }
 
 static void guest_test_core_counters(void)
 {
+	guest_test_rdwr_core_counters();
 	GUEST_DONE();
 }
 
-- 
2.46.0.662.g92d0881bb0-goog


