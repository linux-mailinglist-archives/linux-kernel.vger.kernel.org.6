Return-Path: <linux-kernel+bounces-190963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA718D04E4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE70E1C211E2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DD0171656;
	Mon, 27 May 2024 14:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WdcOzz9I"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F94F170828
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819978; cv=none; b=M7T11HE4fPDaexRq5xSVvcihbqkkR3nvydEN6Qgb54RcUwji79YpI/Kcyh99CBRxhsRZff5VT4y5Tt8LwBH7L8FNnEp8/vWxCUDrgqYUUzELrOnIQT6Wh1xMKcGO40eUFWFxntG5Zs3b6ugYRyy9L+1ounAwScWxKUSS4MLCV2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819978; c=relaxed/simple;
	bh=Th6flGQrgEICY4BFAb32zGR1x8yV5aU/F10SCLnIldA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tusNdArninmPx2fSOllGuXq5r4eODnFWSpgpWKaGCczo59DNwOjaPexM0HgHNIFEuY5G4dKX5VNPQYcySoi5cU17KY0Ae0Sxi6sYsj5wcfROgvPMu3gaOdFGxyiDypP/djWrgCjM+82gSb73LfGJr7ZFgBpe+7bIMs1357Ln4S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WdcOzz9I; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5295f012748so3685927e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716819974; x=1717424774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjTbB47lhtg0PaxHpHSV+ev3VLrPkOO85FcCwtdMOr8=;
        b=WdcOzz9IhLaz5Mo4VEzpUGRMS+C608dF3VrdPzlgkAdqW8RVlCvrUStcF64LIfPXrR
         sKsUTuvBIOESdJXZL4hDd0y4Vbd+oHoAAblxVZtfcZcOW3zWESz273lNsXLdAbXDC2Gl
         TKcOVzagaRTMrvH/jtUtP3q71ez/8Luu3MNw+JCi0fUzimzFzRlZ5mwvo6BwdmeCvwhA
         ygRDwTIoUxuJ73AnIZ9FxF//cI46hK34HEU9ylNmPCn/g+DcIkGTYG4u9aD0c9+PEQaE
         RXc7Y/gVyd0aSlt2ABkI6LfD2r99xSD5dfsx2zQO9X9BalusczlIzuAwkKHMRxs8qhuc
         qURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716819974; x=1717424774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjTbB47lhtg0PaxHpHSV+ev3VLrPkOO85FcCwtdMOr8=;
        b=GS4xi+RZWE18p0YJk8O9ue+fCV1XQnhRFHsUewRhCtodPGKjqswS8nedhIW7uZnh3t
         nhAJfE1Idlfxcum82wsBZw+9Fp/imBCRQySZ9y+3mSGfcdgDdnRgN0sEBndgfyY+n7sk
         2r6JcTNkLEMKuUpho2nQoiG1maEG3zgUF4mWg7seMh243VqqF/bHtbmJxLMsrTyp3OhT
         2eciyztVMIwv/S93zBwcSlWGdaRc27lI6PF486C4iy6msq2SrjIxq1zuIodR96rQK+2W
         JNQvEHKAt/8T/p5+dKQJ2IyrEm3R7p75rS8D+gVqapRMDB8XugLiL6q099gfb46Jj7Kk
         N1LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk0d9cZaotr73GyZXeO4K4QIBo8VdhPNva1p3yyzNSXOBSYMnstdYQmVtnDtKCQ5CpDRMIpApgGig/SAivpaBj5YIOmIbKltBX8DRy
X-Gm-Message-State: AOJu0YzeMfQOjgK+eBVbp0t3LZ8ouyoeiWVXPC1VdRk3myXjFXplhHw9
	eCzWger57fH+H8k4242ZGlLjbQod8utwlc5ElBFmvGV8L/rZwq8f8R7CX0b7db0=
X-Google-Smtp-Source: AGHT+IHROwLUTMrWjmP0xh3ZK9H8kROHkOyC9/3gwwdjBZr0Ond0GgOAOqXLU1YQx0oMT2Wjx7S+wA==
X-Received: by 2002:a19:5f07:0:b0:51f:3cb3:48a4 with SMTP id 2adb3069b0e04-529646e3b70mr5388521e87.1.1716819974755;
        Mon, 27 May 2024 07:26:14 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-529711fa7f3sm562002e87.258.2024.05.27.07.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 07:26:14 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-pm@vger.kernel.org
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-rt-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] cpuidle: psci: Drop redundant assignment of CPUIDLE_FLAG_RCU_IDLE
Date: Mon, 27 May 2024 16:25:55 +0200
Message-Id: <20240527142557.321610-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527142557.321610-1-ulf.hansson@linaro.org>
References: <20240527142557.321610-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using the hierarchical topology and PSCI OSI-mode we may end up
overriding the deepest idle-state's ->enter|enter_s2idle() callbacks, but
there is no point to also re-assign the CPUIDLE_FLAG_RCU_IDLE for the
idle-state in question, as that has already been set when parsing the
states from DT. See init_state_node().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
Changes in v2:
	- None.
---
 drivers/cpuidle/cpuidle-psci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 782030a27703..d82a8bc1b194 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -234,7 +234,6 @@ static int psci_dt_cpu_init_topology(struct cpuidle_driver *drv,
 	 * of a shared state for the domain, assumes the domain states are all
 	 * deeper states.
 	 */
-	drv->states[state_count - 1].flags |= CPUIDLE_FLAG_RCU_IDLE;
 	drv->states[state_count - 1].enter = psci_enter_domain_idle_state;
 	drv->states[state_count - 1].enter_s2idle = psci_enter_s2idle_domain_idle_state;
 	psci_cpuidle_use_cpuhp = true;
-- 
2.34.1


