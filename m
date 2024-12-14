Return-Path: <linux-kernel+bounces-445784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD909F1B8A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 01:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 497271881F88
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 00:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4318168B1;
	Sat, 14 Dec 2024 00:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YMpYUjip"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE30617543
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 00:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734137593; cv=none; b=c/C5coyiYoMczN2gm6qpBMNZR8oMrvpTjmTosddxXJ0zn4oyz8a8OslhXIaRm2wS6A48RB1bENI41yrLqx17cy95rIot+BRKTSVGhIlso2Iz4fSyOwwFZdGIzpWa2cmj2hz6sigPEpB5OHIP6QGIkRhrIgkpmoETiql/PJM4kpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734137593; c=relaxed/simple;
	bh=XJYoVV8JvXnn2NiRA98wpV2UEbpgwE4/KHVxl3uEyMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPsDje0CF1FpeEHZnAiPrVYc/MZrbDYIA+nWI9mZL+n7eXn+0qeShIoUA16nKM2BElKCMFdq8+HW4Rm/oqhsfEn0qG6nDVVNux+8yq8BsHryhXr6u7Qa35oCYEfz7pC6mb7BQvXnxK4lF9+wOrVpr5/LSpvfzU87mPKOnIQGk3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YMpYUjip; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-8019338c2b2so1710307a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734137591; x=1734742391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lb40kxSySziI3vHFr8SIoDrNL6+Q2SvOcQax38nrL70=;
        b=YMpYUjipeqgd3d+86PYmi/8aaRdHXrJB+kDlh/kGvDKOI/oPhe4BawB4oowi4YjciO
         Mwn1u117Ukt3WScrLoOAJgIMDqV1UhKg+GNTWqkR+KvpHpY8NqHfWycYGfAm20Z9ggmu
         ECbKxBttSkpIpTheg8qAdzhT7MQGmSNqwD5lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734137591; x=1734742391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lb40kxSySziI3vHFr8SIoDrNL6+Q2SvOcQax38nrL70=;
        b=dcROjplAcJeutRlbiD2WrS9XUSXyjwUFPJXTJWn0CgZYxaDMDvOqUKs3CQGUKEPd3l
         OH8aLGPj6R4F6/JAvLkSv6gKqUgmK19d1XWWP5AX+O6MpB8n0m1FDBWkSLYhh4omdoaf
         ioBCFAUZA6MVAIV2ZLdgLpZrd8QNAsiQD51yg4Gg+sFjZynTqosmy9psX/8G+Jurmaqv
         teiL7qE2CMUD9AGrfxOrDTViWf8gOhsH11O9iy2cqzSgicWFRUaG+fZEyZHSbJoWKbK2
         UtqcoB5a7hrBp0A38pXfoKGK2TKFcK3UcyFRfC+6/8cORiOoHt2PO8sYWGcfCSwraEOn
         utSg==
X-Forwarded-Encrypted: i=1; AJvYcCWMBgO9QY6b+21zqrThxsa9dicxqHyKkEKx+Kgr1HzolmEfQZmkoXdvWxtfg+HR1kwbI4FwmFNhAYsDuoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrCs1AzfksDMA5bPmJUPmIL7ed2AFqtFkb2tSyKkoLfMPdqN4+
	CNw/2Zb8uJb55FEokr5tDFLNrHr8xVUj7wONPunn4kgnV2F3DZbHTIJ7dmWDCw==
X-Gm-Gg: ASbGncsUODifJYiM3K4yh+f8IMI+n3ubIFRRl/iXUqBbTF4KYKLgTAp/aTtkQGY4oCw
	zJRejQsnUm42KCEodfLaI18K0rnbzVEOCEaPk/Ji5TchhsMA2J0iubkUQRk4hckzia7awp95Ney
	ofgaByxF6cJPries8+NNdPOIgHDSWg0JhCcI8uiIUHTzet63bf0Mh8WLQtc5WomwHnU2/edVfMS
	HcnTn/4MY/SzZOkiDXoYrMqF1xdo4ZJ+oL2JogTGkqnSoVFvqQOrxjf5nUz2mObiuX9P9PyFOKw
X-Google-Smtp-Source: AGHT+IHA02wdX7gbQpc2VM52GOd1+IrxDgEcszoQJP7VGIrV4tHzcaG0wjdjW5xSAzMH6mwnDjKcmA==
X-Received: by 2002:a17:90a:d450:b0:2ee:f687:6ad3 with SMTP id 98e67ed59e1d1-2f290d96c48mr6152633a91.28.1734137590982;
        Fri, 13 Dec 2024 16:53:10 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:ae86:44a5:253c:f9bf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142f9e186sm3788270a91.41.2024.12.13.16.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 16:53:10 -0800 (PST)
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
Subject: [PATCH v2 2/6] arm64: errata: Add KRYO 2XX/3XX/4XX silver cores to Spectre safe list
Date: Fri, 13 Dec 2024 16:52:03 -0800
Message-ID: <20241213165201.v2.2.Iab8dbfb5c9b1e143e7a29f410bce5f9525a0ba32@changeid>
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

The 2XX cores appear to be based on ARM Cortex A53. The 3XX and 4XX
cores appear to be based on ARM Cortex A55. Both of those cores appear
to be "safe" from a Spectre point of view. While it would be nice to
get confirmation from Qualcomm, it seems hard to believe that they
made big enough changes to these cores to affect the Spectre BHB
vulnerability status. Add them to the safe list.


Fixes: 558c303c9734 ("arm64: Mitigate spectre style branch history side channels")
Cc: stable@vger.kernel.org
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- New

 arch/arm64/kernel/proton-pack.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index 39c5573c7527..012485b75019 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -851,6 +851,9 @@ static const struct midr_range spectre_bhb_safe_list[] = {
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A35),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A53),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A55),
+	MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_2XX_SILVER),
+	MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_3XX_SILVER),
+	MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_4XX_SILVER),
 	{},
 };
 
-- 
2.47.1.613.gc27f4b7a9f-goog


