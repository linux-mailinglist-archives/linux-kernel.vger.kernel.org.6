Return-Path: <linux-kernel+bounces-445786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D02A9F1B93
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 01:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D89D17A0FD3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 00:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E6269D31;
	Sat, 14 Dec 2024 00:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GHL4kUZj"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8153A1CD
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 00:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734137598; cv=none; b=KC4UCkFq/nboUwDjcPiXrHE3DAjAASMTfwDyrXoAwmtqaT1xDPzE4g3RjmeFHcGFAMUhrUKVJOmZ8pcu8F+/yALfqsQGrsaYxc3/fLI7B474fjNV+gWZruHFHy7vf3fUBbDbaVJKPExxPqTGWMKM8suEwVpBHVxfdOlc5oAgD84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734137598; c=relaxed/simple;
	bh=DRY0q/4lkC+b+1JUfhPJH5/uaKyj3aTDNMkw3d4TEtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ec3DEGG+JaDBGJeceHTXOXUCl5U68csdbqOpvnYP2qm8gLdXm9N4oZFH9TtFQE3GgLtWiyrbn6Wyu8c0aLZO4S6uB0+zoFXtvfbEb3RQmKUQfKj/00Jgon+PjA+gBNeJEKQhaxdERnBeg88Xa7QAkcJJKrMfIMhDdh70m3bHBXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GHL4kUZj; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7fc41b4c78bso1202675a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734137595; x=1734742395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDl/86yemlzCX5AmWhge7CoGQnGj7feSxXoMoerczhc=;
        b=GHL4kUZjkPzxKX1jDExTn8dwjkfBeXQlCWHpgGr0ReFoOfNeVe6FmegXcR7b4eZEn+
         oZw0cYSWuW5TtTdSZLsEMEC29biGthIEZPi6iu2z1rTty6sskaE8S/AJVmpSxFEZPluV
         YfzD/h2JNRDR4y6yccpfDsbdqTGuK0bHta9dI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734137595; x=1734742395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDl/86yemlzCX5AmWhge7CoGQnGj7feSxXoMoerczhc=;
        b=D5+7skN0T5Gj+GfFaHcrmtXkvflGjENtXfg5615Z1tJsWZOPdNKZcyHqJlwFBHKJjR
         sDje9aTZVhgwfvW1S6eoXCVAJJPCHhXaAcIgbGDbrK11jSMU2/BucsarMpfUuqx7QcIO
         UOjbHwWqNd3PBxVgUMVshbGWKmqWUJfntYUkrmO+rZtZlL7D/OGiRIoZfSvqB5M8xGsu
         RW8X+L3jYaC5NR3eXqhINir7E2fowf/aC42aWCHFHcxtvnR9XUtzcFXPrQ9Nk8Ptvj3p
         rlBnypNkOAnSr6TILiPg8O99kG82+wd/03ESKj/NBFs2ZcEioiqUwTR3Na3eECIYpSH6
         MYWg==
X-Forwarded-Encrypted: i=1; AJvYcCWCOnZR+IHL8vetpZGu/Sa2dIaBpA8M4rs1zPQ+J2E2Nq0c1ztEMdEaW3tTH4XWxsCw5GOkzL6WLEyYCkw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0HtFUK/9/1AAmdPULPtlrK40m3Q1+QxHv7ap27IYHrNqKadBe
	EZq7fCibRhETOfS/AZpw53mCgY7ugvyQC1rUed10gVrrAtSMwJj1tdzKBTDP5A==
X-Gm-Gg: ASbGnctU+ei0bQS1V6Wwve5rhwULIQ97gYCPk0iMtKVungwEWqxMocizMvM+72iwlp8
	dLX4qXTfAmNHDnQftEW0ShcDs9iMFoB1yWQtK9ZG7Nbl9JH20xRNaLi8Ka5cnIJpP/Bx04asi6v
	Vt7Ec6ximfdf3HAJuphpo4IeJK+foLEXP/swhoIaFUJAzprQ3ocrXizObNE2TdBZcE728Hmtkgh
	XxFeVbsSgV+AH+uMGxc4DECKeclZRXBFdHrbaZN4L8yPtRUICHfG1thBo+rd1HEOAN7HHfBGMTl
X-Google-Smtp-Source: AGHT+IEWnlkjBeBQBC3iIoArI1oOo5CsVi/i/Wbk8mN1sXE73heVuvKgGafObymqxw6xhGs3c8XA1A==
X-Received: by 2002:a17:90b:4b51:b0:2ee:d186:fe48 with SMTP id 98e67ed59e1d1-2f2900a6737mr6197559a91.28.1734137595490;
        Fri, 13 Dec 2024 16:53:15 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:ae86:44a5:253c:f9bf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142f9e186sm3788270a91.41.2024.12.13.16.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 16:53:14 -0800 (PST)
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
Subject: [PATCH v2 4/6] arm64: errata: Add QCOM_KRYO_2XX_GOLD to the spectre_bhb_firmware_mitigated_list
Date: Fri, 13 Dec 2024 16:52:05 -0800
Message-ID: <20241213165201.v2.4.Ia3dfc0afadbfbee81bb2efb0672262470973dd08@changeid>
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
ARM Cortex A73 in them. Since A73 needs Spectre mitigation via
firmware then the Kyro 200-series Gold cores also should need Spectre
mitigation via firmware.

Unless devices with a Kryo 2XX gold core have a firmware that provides
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
likely it's needed. If nothing else the claim is that that Qualcomm
Kyro 280 CPU is vulnerable [1] but I don't see any mitigations in the
kernel for it.

NOTE: presumably this patch won't actually do much on its own because
(I believe) it requires a firmware update (one adding
ARM_SMCCC_ARCH_WORKAROUND_3) to go with it.

[1] https://spectreattack.com/spectre.pdf

Changes in v2:
- Rebased / reworded QCOM_KRYO_2XX_GOLD patch

 arch/arm64/kernel/proton-pack.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index 04c3f0567999..3b179a1bf815 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -844,6 +844,7 @@ static unsigned long system_bhb_mitigations;
 static const struct midr_range spectre_bhb_firmware_mitigated_list[] = {
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
+	MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_2XX_GOLD),
 	{},
 };
 
-- 
2.47.1.613.gc27f4b7a9f-goog


