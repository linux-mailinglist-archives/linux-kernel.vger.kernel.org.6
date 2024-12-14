Return-Path: <linux-kernel+bounces-445788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE079F1B96
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 01:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5DE7188ED59
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 00:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA341369B6;
	Sat, 14 Dec 2024 00:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dnexty68"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6057DA95
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 00:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734137601; cv=none; b=QeWzHErH7pe6HlIWwfUwLyiV5XY1AU7/B8T2xs+CdC18iLpkHcjzGAFiCwAvmTK/rGky97YkaJgDbLP/Zn2RdjVnHy0lNI3xNmyGMtPYQzc/6NoFpoT3zFzKt/aOgfMyV44udnnuZfc2CVzg+PJpJDndJtdE12jUUtQkhrLaL8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734137601; c=relaxed/simple;
	bh=wtOPnKbsorF7XJRH1GXzXj2KmpV4JSzbTQjjrqjiA1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aVVi1StXHXdDHGSPqTLHoj6Ba9kx8oUum17o9B/tLa15eALGnDVZ95+lqKeMqri1XUaEbrOnt6M//oEY79XJaN+/Nd8nlVxPKnW9w0oraeII9YSRXKxASY+qZnZYOYjTjvzL52hMPTZEmoBHbfuqoKdaOjtnvDcPi6p4Nf5M/1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dnexty68; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2efd81c7ca4so1578852a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734137598; x=1734742398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrdqv5su9sKfrkNYXwk3VMWny97c1fSpv0cdthxhYIM=;
        b=dnexty68MmZaR2XUnmm8HfrxZKDViRGTfHbMiwe8Du5vrjkrHxU2BiyoSs4MR2U1LT
         eK6VvUTg30WllBGRgxU4qJfL1G4jyZq1W/2+daHbUWuztmkSoe0xgMrOExMZwLA6WGIJ
         CCHPcvCsY7eVFf6q/M++P0NBfDvhlzS9kRSTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734137598; x=1734742398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wrdqv5su9sKfrkNYXwk3VMWny97c1fSpv0cdthxhYIM=;
        b=ht3X4jnTtnIiHoB6N+EGuhq+j29WMNbFItt+fg0Q001OqTJQzYbMsmtbCjnHfrXgE1
         en6AdhhgbRTC1a0KtsmFAJr85kU/lS3a2uR06bIOWqk/sbFKV2vufrXJbxRkSm5l19fL
         AsEczYCemLD1Qcgy+2MN5O+GiohZemIzk/NqVT6vcSjuCBmvhYKSMzJdDKoABuXM/LW6
         BliH1Wmj41OrdXy3Cgw+/K41YahNQ88lKJlGzDrHzd/z85ARhvY51eEXT2ppfHnKps6h
         eB6xLZcteT2wE+Gb5QfkZ/PEsIyYnaKvve6LPQTYPbRR79UyxzCy69N8UagOqS+exjIG
         zatg==
X-Forwarded-Encrypted: i=1; AJvYcCU2kBuz4jNLUkvD8sRT+W1kwdHi9ScM6pFyB67f1V3p+PUrgpFQTFiF/Famdh1cpecqbd9vhnlFoNPcQsA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb8acfxTu1QxZvjmY8Wz0lAYO+ZkmnJ77HRr8QzMdUywiFKd9C
	PBJvEVcinYEhX3G0Uvw5mCJmWWopr4KK6VgufQXLVOkkInzzw9M7aQQ6HJnILQ==
X-Gm-Gg: ASbGnctXQHce2kj0+h/rQeyNNCiGQeksKDXIhGHkbkJfzyy6depWwTU7yLntbSCRy0K
	5GHSbxJwqjLep83Cy64ygbZGrxCdSZE5ZeWvrcBJicOLYc1gDR+sG9M0aMvYWtZ8Ke+uZ5Vim8n
	GCuiw1wD/KGPwESSinMsAn9sKzelYfD/rnugDtHPuRQguXd5AbLOZiH10QuWPQR+QlcSIwZ885i
	HPgO/2iz//o4M9XORxEPOrH/lwjQehrHF+AQOiuqKteS2aFfHy43mf6cTgqjaxYjYQnSSGRfxyz
X-Google-Smtp-Source: AGHT+IHOcPfHNBrkQn6M2DPoYqrW9wGOVpvFmhjU4MB0966dHygCTCiPIakP//mkJvwDEs162n4ynA==
X-Received: by 2002:a17:90b:4b81:b0:2ee:b66d:6576 with SMTP id 98e67ed59e1d1-2f2901b3256mr7290054a91.30.1734137598295;
        Fri, 13 Dec 2024 16:53:18 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:ae86:44a5:253c:f9bf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142f9e186sm3788270a91.41.2024.12.13.16.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 16:53:17 -0800 (PST)
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
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	D Scott Phillips <scott@os.amperecomputing.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] arm64: cputype: Add QCOM_CPU_PART_KRYO_3XX_GOLD
Date: Fri, 13 Dec 2024 16:52:06 -0800
Message-ID: <20241213165201.v2.5.I18e0288742871393228249a768e5d56ea65d93dc@changeid>
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

Add a definition for the Qualcomm Kryo 300-series Gold cores.

Cc: stable@vger.kernel.org
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 arch/arm64/include/asm/cputype.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 488f8e751349..c8058f91a5bd 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -119,6 +119,7 @@
 #define QCOM_CPU_PART_KRYO		0x200
 #define QCOM_CPU_PART_KRYO_2XX_GOLD	0x800
 #define QCOM_CPU_PART_KRYO_2XX_SILVER	0x801
+#define QCOM_CPU_PART_KRYO_3XX_GOLD	0x802
 #define QCOM_CPU_PART_KRYO_3XX_SILVER	0x803
 #define QCOM_CPU_PART_KRYO_4XX_GOLD	0x804
 #define QCOM_CPU_PART_KRYO_4XX_SILVER	0x805
@@ -195,6 +196,7 @@
 #define MIDR_QCOM_KRYO MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO)
 #define MIDR_QCOM_KRYO_2XX_GOLD MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_2XX_GOLD)
 #define MIDR_QCOM_KRYO_2XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_2XX_SILVER)
+#define MIDR_QCOM_KRYO_3XX_GOLD MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_3XX_GOLD)
 #define MIDR_QCOM_KRYO_3XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_3XX_SILVER)
 #define MIDR_QCOM_KRYO_4XX_GOLD MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_4XX_GOLD)
 #define MIDR_QCOM_KRYO_4XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_4XX_SILVER)
-- 
2.47.1.613.gc27f4b7a9f-goog


