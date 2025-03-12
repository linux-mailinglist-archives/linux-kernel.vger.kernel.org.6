Return-Path: <linux-kernel+bounces-557658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE40DA5DC16
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F557179B7E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF332417D4;
	Wed, 12 Mar 2025 11:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="tabI5PpA"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B577123F39D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 11:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741780595; cv=none; b=pD1gAFuLlaMnPE97KRJ1xGSgZkQSUIGSdyTcZ9l4yjCbHsnzhjfDobbrwhAHtoswlcVYFPxWn38Kbbmp5anPRDpjyBq6fyWiFMOaevFugui43hKf3LOfqso/1TEztBP3xvZnBG7gyMffYgOqeb0QGYITND80JzBkJi2L+9OGE5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741780595; c=relaxed/simple;
	bh=5jRu52Q1kPSXe6BSqBZdOYqPbm4DaeUHgm3v+MK2O8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C5p9tf3ywYU6zP7kBiuPY7/39IzLb/8mBgi+EeOHamb4KB5r+UCVaVG3i2ks79ezmFeor5KtoA+xxwSGuH0X9Y+ZD3FVLn32ZqZgmkpfIlvrCY84RL+1uz/mxyah/TWg+Qw3T9wKyqVNEou4JwIcf7oFqk0iXRFLeyeq7arTctY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=tabI5PpA; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-224341bbc1dso91100265ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 04:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741780593; x=1742385393; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TCAwKKa1hp4qKIGSTMOyXPQD5trWA7N2WyBVQxGWCbk=;
        b=tabI5PpARrqzHZ3J7N61JaK75etTsNVDJ8AaDDsFTODgfcPJldhZOL+2XhTleIFfqG
         KEN4tQflExseyb+clUEcZNLu1kri62a1t4V1kPL9z0mkU0lw/mbouo04OBIgJz0kzCTg
         5cNb4bhW+ZjbdeGysdw2REQBoO5Jd7+25jZQtd4J+oUiv1TWk5yipv/HeZtDR3kTCHGj
         tpNTa3/NQH6Zi1HN6sTPYFtKOWGOpKth323LBP8kIRCdfJRjFTa5jQ1E6T5l/rZu+nKF
         bisijtyPIxhxh6f/HGMq6ojwkE3+2el5PbdLChp9+RNnVvQfFhA1h5Gm3fd5b4uOnngp
         Wc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741780593; x=1742385393;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCAwKKa1hp4qKIGSTMOyXPQD5trWA7N2WyBVQxGWCbk=;
        b=fJR/bqLM7i6IDs0Xh529MlcuA6a39stXvXpco5pXL2jlWVThlAyaLLtDD7v1zHW67M
         rU5lvBoWWggr7v3k4PLcfkdpYoWJmYJc8J51GWgZndjDNUHk5OEW+q0N7df9OIYQtZ99
         1RUgfcrFRJc/5/nqvQFdsTxi5XgxyRplv7rPePr6YETBfA1wOaRsdbd5retGafDqDIN5
         0yH/wjlPLibeQOibdp5n63fE2pkPMvfmNaBIiivmGcV6OU1v/IosuChVtMvPpsrFDu2B
         BIbskv0ABlfnTrDbze1v+pXA/wBCV+3zwVrY+nsq9ynjkKfxfsnf+8r/r0jd2Z4FM2Un
         rffA==
X-Forwarded-Encrypted: i=1; AJvYcCVmteSJUDgSjbFiuZs/yfcIvsusTpjIFHgtXtED2qeRQJDX2JMMMztVsK+SZO7QAtkYD4lUTL9rTSDs9VM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI7QxuO+NqwqxsP1PMYenuI9PGFzr0RYiRgQ2xRz6uWSKydrGF
	9tDXKloA4wt6ShCWLMrcizVu1eC8lgHQczrlwEJ1x+NP0yShI3ZhLadcDLYmfuo=
X-Gm-Gg: ASbGnct15PPIGBmxHqlv0CvjSqrJdRd8QyJyDbdFQw5A50dhkljMgTePSgqgeX8nmcB
	Yc5OgDGSVYcCVJ1A4lVQ+ljUEVPEtAFy0afiYNlLq10VPIO4wJPCCgPEyp+K1104r30GGIfpqw6
	OZ5w5Wcm4oRA6WHQwS/zj8Lc+JnksunwQ51Q3NEr+L17GcQYhDK1j7mlKmaCbu6SRaTvPlbd0T6
	Std4GIAUGZsVevMOCjFXwevqUncMOuS2RfblBKLaqHT6zHysezfknkzIFxn9GiDzJ1bm1OX+m/z
	b0/AH0TiZDLBuH7rjej3wKmLcQ6byefg7U0/wZfxkkYDtzm2
X-Google-Smtp-Source: AGHT+IEt7ftF0+X9PEZlO2xjYhcH13J+1KUiYMwfGTA62pbfX70/qK8tdqWOcbGMQp5ETZdkFMGsvQ==
X-Received: by 2002:a05:6a21:6e01:b0:1f0:e706:1370 with SMTP id adf61e73a8af0-1f58cbdcb9emr12506243637.35.1741780593100;
        Wed, 12 Mar 2025 04:56:33 -0700 (PDT)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af2f01909a6sm9911068a12.7.2025.03.12.04.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 04:56:32 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 12 Mar 2025 20:55:59 +0900
Subject: [PATCH v3 5/6] KVM: arm64: PMU: Call kvm_pmu_handle_pmcr() after
 masking PMCNTENSET_EL0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-pmc-v3-5-0411cab5dc3d@daynix.com>
References: <20250312-pmc-v3-0-0411cab5dc3d@daynix.com>
In-Reply-To: <20250312-pmc-v3-0-0411cab5dc3d@daynix.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Andrew Jones <drjones@redhat.com>, Shannon Zhao <shannon.zhao@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6

kvm_pmu_handle_pmcr() expects PMCNTENSET_EL0 only contains valid
counters.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 arch/arm64/kvm/pmu-emul.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index 78cfa8b0964d..2d19c6048091 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -831,11 +831,11 @@ void kvm_vcpu_reload_pmu(struct kvm_vcpu *vcpu)
 {
 	u64 mask = kvm_pmu_valid_counter_mask(vcpu);
 
-	kvm_pmu_handle_pmcr(vcpu, kvm_vcpu_read_pmcr(vcpu));
-
 	__vcpu_sys_reg(vcpu, PMOVSSET_EL0) &= mask;
 	__vcpu_sys_reg(vcpu, PMINTENSET_EL1) &= mask;
 	__vcpu_sys_reg(vcpu, PMCNTENSET_EL0) &= mask;
+
+	kvm_pmu_handle_pmcr(vcpu, kvm_vcpu_read_pmcr(vcpu));
 }
 
 int kvm_arm_pmu_v3_enable(struct kvm_vcpu *vcpu)

-- 
2.48.1


