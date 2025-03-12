Return-Path: <linux-kernel+bounces-557659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE95A5DC17
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14B43B537B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423D723F42A;
	Wed, 12 Mar 2025 11:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="hRDLXru1"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358D024501E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 11:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741780599; cv=none; b=MaAySrlgljDJUV+eTAxipSuwp1igfpLQeGLJVOzO4JVnv1dzA1fzdh9awcNG6m81QA2pD2m+pPVAPPxTulQQJLTUcDhnQaIWt1r9WEAoF6Bi7KLkJHEC1BwKwmxiCn5R9GR2/ZdVhYgs3g+idDOT02IoJitNNPi4JE3+LeJ6GAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741780599; c=relaxed/simple;
	bh=HzzfwQzBMa06gpOYm7ED9Z4TNgABvoHrMUKZXgLGOoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nNhIgANGNkO2KSCz2O/swuPs7/AKpb1WsP160ldZi66R4LnIAs2zkTS8Z5lycMxQK06751oUZOQDqYlhHa7noJi1Jr/rnl4gNtDP+RGoluOL7ObyHik3x+xX2NY/eIqOWweK1oqWsS0SS+p8ACri2j7SdNqgOqQ53MX5822AJu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=hRDLXru1; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22355618fd9so124762115ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 04:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741780597; x=1742385397; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u2W4Xv+9VQWQQBSPngguZ3XObUjYW0AuhHcxMG6Wj0Y=;
        b=hRDLXru1x5Yej7QYsI9zqFpP0u+2kNee6ctEfJ1WFijqggxofnUosdicEClpxgIaMg
         r5/6QAtSy8jEXCykBidMjMIBLoTKHYQ4/5qeq5u0X143wy+dQvJpHuYUGw0ojsmOdxDt
         CIW6nWtFn/dkf3NhtRDRKpWO9wnn0MQJVIz2YdrvTC8Q3GXK7GMcoqeo58Rjm3sUlGQA
         WT0st++TKvxDU1H4WmrKCePPVK6KFb3855tPm4BSx/gk9F8ffukklGneA3UyKFQk4+3F
         MYem+1pqSQTjVihpCweGbzjb6RZ3CUUznpnQ4hMvtdYe0lpg//31FpdUKKaozUiYgF87
         0zyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741780597; x=1742385397;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u2W4Xv+9VQWQQBSPngguZ3XObUjYW0AuhHcxMG6Wj0Y=;
        b=u9zT3Wxi4RZ7r2kxpgyMMwJBU4/+szb60DcarzmQi2Tdbn0pc+XftblX4ENmCjGGPM
         AkRGj+V1GlEYUStHZJd8EDS1/KFyKYZZ9XthwyaA5w7tx1w9twwwQzOzQQc3qWufL29V
         ByEIBQAi+ZdEh9Dax2U+v2Lvy6++ca42RogosEoDqah2Cu7yAqGNWuMTfdYcBStAuxBm
         L+QG/+SEJC0/vcX1CF8Y4IyQY4QZEAx6cv3xv5EOggqM0tqjnOVRKifcEDC/EVbROsmJ
         3c584T3PuHXCRqIFDQI7LHEj3+nkeddcn7Ar3XGPRGA/vFlDtJGFz8KGThnAfqypkckL
         tPjg==
X-Forwarded-Encrypted: i=1; AJvYcCWNFtO4IfTts6E4yLhgv5A2zRQ2GsgSRnn2Q6udZhQW6iP60yZ3PfBKgKQhL9nHp6EhgDATNnMNQlwdX8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQKJ01zeYWJJqJELnJ/6fafl/PXTZpK6R6KqV/ZSAutJUIQsYl
	0DCzFK5mOV+Je9bsbfCCTDl5MM3W6hS+rWOUleLUrkqltUhRCz7Or1pCFeKRmKYle/4iJ7J6TxM
	O8sc=
X-Gm-Gg: ASbGncuukuJgB+t+bzkdzRN5dB9kFrgnaAlZRqHlaSmMj6wOOfuigwV4BtbxFgqXmiM
	azRuIM0IH1PrnHCKPI/8ubzEhqkh1qnKaCqbi5ryNEidAsXOxxgMxgr5fGvxY04lYF6tisPIN6Q
	EY338K+degIsq5KoL72vF+i5VkgHXs8mkQcjtQGwEbC1eGnTBbcJuNrVhgH0+BYOo+7NT7NpLNI
	B5SbZZxxe4iOhQUUGWH6MZBtPYUmfXeVNYR6LY7T5ZT3XCYioC23Y1WgoBW+hPCQebVNeedTBJB
	zYlzEkABaiSZQYQifw04AcTPD743+jLBnxP0Wn6HkYPDe/nJ
X-Google-Smtp-Source: AGHT+IFKd8JzPs00shGeDPszPVRqf7Tdd+CUl4POW8V13KNLbNVMybkA3YJRReDGIm9qT/E2zqWsNQ==
X-Received: by 2002:a05:6a21:9d48:b0:1f5:8a1d:38fd with SMTP id adf61e73a8af0-1f58caefbf9mr12020498637.2.1741780597517;
        Wed, 12 Mar 2025 04:56:37 -0700 (PDT)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-736d4f20913sm6410407b3a.13.2025.03.12.04.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 04:56:37 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 12 Mar 2025 20:56:00 +0900
Subject: [PATCH v3 6/6] KVM: arm64: Reload PMCNTENSET_EL0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-pmc-v3-6-0411cab5dc3d@daynix.com>
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

Disable counters that are no longer included in PMCNTENSET_EL0. It is
not necessary to enable counters included in PMCNTENSET_EL0 because
kvm_pmu_handle_pmcr() does so if appropriate.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 arch/arm64/kvm/pmu-emul.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index 2d19c6048091..b14655dda6db 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -831,6 +831,8 @@ void kvm_vcpu_reload_pmu(struct kvm_vcpu *vcpu)
 {
 	u64 mask = kvm_pmu_valid_counter_mask(vcpu);
 
+	kvm_pmu_disable_counter_mask(vcpu, ~__vcpu_sys_reg(vcpu, PMCNTENSET_EL0));
+
 	__vcpu_sys_reg(vcpu, PMOVSSET_EL0) &= mask;
 	__vcpu_sys_reg(vcpu, PMINTENSET_EL1) &= mask;
 	__vcpu_sys_reg(vcpu, PMCNTENSET_EL0) &= mask;

-- 
2.48.1


