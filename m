Return-Path: <linux-kernel+bounces-445789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5769F1B9A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 01:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1AF164578
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 00:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202927DA9C;
	Sat, 14 Dec 2024 00:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PS/SVhCA"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C13313A26F
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 00:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734137603; cv=none; b=IrOqm2vDZAiLEc4MoNYqtR+WioptcZt+W10E7h0kSZFa327aMkQGYBW0bvBNXb/D7KyA2KpwYY6IE01Rfr+creoq4mVpvkzb8k/aTnv5wToRtDwoPYB8glKXSpCKHwuKGiv6mLfj2BTA+XiWmjVfxrTvI43NxE091RlbjYm1OLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734137603; c=relaxed/simple;
	bh=0U4zcnqAM+KNnaDs1qdzfHSYLMjiJX0a1xgu5GDyZrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mNd0pSWrUzHlIYenDDNIKy144KzCxlL2VdfcUkQZdRFV27zDNdIjWUmNITBd6ne9Lo9EIHcZoTEOwo0SnwHTJV/vvFMawFleIiqAWI+d9eQooCLXZEiS+jm4SgA3VuFKF7EyfSwpq21MCT9pxwHT7jy98Bf2IWwbh7VHEaTCumU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PS/SVhCA; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2eeb4d643a5so2017313a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734137601; x=1734742401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nevtJ7/NdNl+3R/l/o9OoX53K9dVtdSsX5xkWCrYzfY=;
        b=PS/SVhCAkcmyNf6MBKpLf1h38taoACTzmNvKUhpMesqWOGCxLxpXfR7eUps1YtNyFV
         jwl8eKpVozbME8IoVWETe4yt9Z2sH99+YS/Oo+oxjZgWTt4LRZQCtGIsDLpgddeqhnsr
         jEvKuSICPqgOK/N+X9fvr5EglnS8aRiiZ9Z5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734137601; x=1734742401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nevtJ7/NdNl+3R/l/o9OoX53K9dVtdSsX5xkWCrYzfY=;
        b=u1msiV2W09mgpggAyKHV77qTsbRTvAyZ0NjxprEWTX7kKqp6hWPegXSa5TUfZvW65W
         YgFsTyMhVMmybnD2Hwy/TCwFi2rNUJyrD5YS18FBkqiwwN0Rm1Fc2DDGaP3cxu4k3SvX
         Bzorcbf9SOzNiTbOb9XcPMJ5Nj60JVBalT8FbE371vvISbj9mdLTfKWNftKGse655LIz
         BfSBeyUwvMoWq1J8KrqCqX/h83Tzebuo1g/JC8tHg2B3hlUV8wcZZMaL53LClBPHhWJn
         n9qb8L40VSW512mrKSyRMV2uTTQRcG9VVyaoOcZqPIuWJydcNvQj65KaUmc46V1LuZzV
         paTw==
X-Forwarded-Encrypted: i=1; AJvYcCUbZAnhPRbLTy8+oCPgFJfdr/Ho2BXJyC8tDgxzglFQCtc1afulOLIWcKCmafMHktzDTR+/Dvf9ulegDi8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmk+don12G2k1WJY6tzoFjr4HStdoiTXiNpZvEMIuS/9t9nUhB
	u5hyfLnjx6prAd5+Sb0OyA7v0ruwNFQahOn/t/Vj6jntGK3jvAIrnALp9kDY6w==
X-Gm-Gg: ASbGnct+yy2j+qhZgg5Ld52hNBN6VJtG5uwj4CmTo1+EjIsNINukvYZpyoXP80nUUCl
	vm49Z117C1e0J+sP4sOt+HxS96j76hUBwiyi00sHx9VbSQuLEgJpI2JpznfFsBct2XlsG6UUrcg
	xaG1w+Z+2osn59U9ADkDd7790CW243fEAathGEo7n9LMGGn0+HxzjypzEow0hfekqhoO+Hqpro4
	Kb3N0WOS6t+QbMW9NWqjJQM2295OP+e53/GdIkkZVfYcBCQdZ8TsIbyjv1DotFIUKaxaRmCl2OD
X-Google-Smtp-Source: AGHT+IFJ8Kx/APKjEY2akHY9UEwVqJx5Yk5K0Is7GrRpeWUBuPmnbC0N3jdlyzrLaN+NBvohTNedbA==
X-Received: by 2002:a17:90b:28c8:b0:2ea:b564:4b31 with SMTP id 98e67ed59e1d1-2f28fd73e92mr6735419a91.19.1734137601489;
        Fri, 13 Dec 2024 16:53:21 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:ae86:44a5:253c:f9bf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142f9e186sm3788270a91.41.2024.12.13.16.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 16:53:20 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-msm@vger.kernel.org,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Julius Werner <jwerner@chromium.org>,
	linux-arm-kernel@lists.infradead.org,
	Roxana Bradescu <roxabee@google.com>,
	Trilok Soni <quic_tsoni@quicinc.com>,
	bjorn.andersson@oss.qualcomm.com,
	Douglas Anderson <dianders@chromium.org>,
	stable@vger.kernel.org,
	James Morse <james.morse@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] arm64: errata: Add QCOM_KRYO_3XX_GOLD to the spectre_bhb_firmware_mitigated_list
Date: Fri, 13 Dec 2024 16:52:07 -0800
Message-ID: <20241213165201.v2.6.Ic6fdf0e43851269d10596da7e6ceae959431f9fa@changeid>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241214005248.198803-1-dianders@chromium.org>
References: <20241214005248.198803-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Qualcomm Kryo 200-series Gold cores appear to have a derivative of an
ARM Cortex A75 in them. Since A75 needs Spectre mitigation via
firmware then the Kyro 300-series Gold cores also should need Spectre
mitigation via firmware.

Unless devices with a Kryo 3XX gold core have a firmware that provides
ARM_SMCCC_ARCH_WORKAROUND_3 (which seems unlikely at the time this
patch is posted), this will make devices with these cores report that
they are vulnerable to Spectre BHB with no mitigation in place. This
patch will also cause them not to do a WARN splat at boot about an
unknown CPU ID and to stop trying to do a "loop" mitigation for these
cores which is (presumably) not reliable for them.

Fixes: 558c303c9734 ("arm64: Mitigate spectre style branch history side channels")
Cc: stable@vger.kernel.org
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I don't really have any good way to test this patch but it seems
likely it's needed.

NOTE: presumably this patch won't actually do much on its own because
(I believe) it requires a firmware update (one adding
ARM_SMCCC_ARCH_WORKAROUND_3) to go with it.

Changes in v2:
- Rebased / reworded QCOM_KRYO_3XX_GOLD patch

 arch/arm64/kernel/proton-pack.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index 3b179a1bf815..f8e0d87d9e2d 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -845,6 +845,7 @@ static const struct midr_range spectre_bhb_firmware_mitigated_list[] = {
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
 	MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_2XX_GOLD),
+	MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_3XX_GOLD),
 	{},
 };
 
-- 
2.47.1.613.gc27f4b7a9f-goog


