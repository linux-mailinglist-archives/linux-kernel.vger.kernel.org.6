Return-Path: <linux-kernel+bounces-231408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 197BD919868
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 21:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C362B282F4B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 19:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F1E1922DF;
	Wed, 26 Jun 2024 19:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AG8uE/iP"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B55E192B7F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 19:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719430994; cv=none; b=j5Fo0HupysAkDAxmKClcFWc0epdv/s8diBZWS/wTO2fv7aWQLBbczKjumrdRQiFV/OVBsWgPnyO2U8CKdPyZSPTTQwOEZlKhYmbTUy22HCTpmwFzd2rCEwKjWcyMesxT/3VthdH/Py20xyfYxuAkQrgbVISSJ4t1b6f0MdpNcZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719430994; c=relaxed/simple;
	bh=QWIFihsVD1gKqEZxXoCvx6MZhkayfkQXDw2BS2+6928=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fzwDNv1XFoSGr6Su0/7blbs8H01ck3lBVrcKThqZbk91Nbq5lbTGWsf73U3rJndd3mr80JMkMFD+u0LilYfVSUinHU/4UM/urM54FfT1jiLVZC8WRE4Wlb32CdJol6oPcOPDVZE8gjZ3/oz6nIfea1p4DAgvMzLm5DFxh433ArE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AG8uE/iP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42562a984d3so2925215e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 12:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719430992; x=1720035792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itjEXOXzQyQKcMZI8QbOfOw29V9GALUONSBPehBlPuM=;
        b=AG8uE/iPAn59Mx6J5sisOyyGnGJtDzYyrcDMuaCfzw2Cbouv+SY1+r7HU66fB53dG6
         XZXn6w9Iwt9fYkeHM+p5DA8xLvPUhlRSUS+N2OmDMa5V4uukQLzBRmq9kVo7kE6vgUeL
         peenJT2gQYjmjcKEtW5qsJ3N8APvF4nnPwvuxA/aKqYnxQt0uTch+P+hJhqjeMD0ofY/
         mmfomjswZ6rPVAm9Q7HNStS8NgplY9sJ8S2CpiaIw++lir6TdmGByyp1JES9wG7PeyEW
         dV9C2fTGyDnxhrncEB2IWhf3wnb8bfM12DocWea5RUBLZHHJIKtErK6VDOPhxfe7hzvR
         oidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719430992; x=1720035792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itjEXOXzQyQKcMZI8QbOfOw29V9GALUONSBPehBlPuM=;
        b=ARELqV0NaT5RDr9MPEBwRcVm8KLuNwcy1RpIL9AUt9CoX1EBwGMB/yMkyDwNeHvHZN
         ymoVFXNFN/UjZZ8KMTjOE9Ntc6pvc+QGru8BbT2g03pMENtDmwayIoH/Kwfe/s0h7sRz
         N+4kpeautJ9Zl5H5nFl0SOIY/ZPY9H3v+D99vrQsnIzKupiYHtePYxbEX2Mxtmb7PUjA
         JvljrOgww0KesVRDvhQqVTul5+MOp5GFaarBFKYErLvu08EenG6D8gH9FWcBHkPfRLW1
         T/c1wd+4xVhVKZfneOV1vepvgQog1VkUfF2lgIQTQDSuPk0dBlhn050srwrl3cyDSLes
         l4Xg==
X-Forwarded-Encrypted: i=1; AJvYcCXr4RVjfTGLdVci8T+fwH2CFbex290rVFj1ZqWgiJwo1chNIcdAGUJswoQ5WDUDRgUx0BEjJTnrOq3z6H9MeMVT42yzLvH4hb1XI8KN
X-Gm-Message-State: AOJu0YyKEfBJvYgjzzfVHkhk6Xuk7GYRy5gQfUrtf7zMoJPHH273/fHl
	aQwypLp2BItnuNi2ar4sy5WbLV4wRREH3UEPHUalXdNtzEVPeXr4n1Zd7Vs/hRc=
X-Google-Smtp-Source: AGHT+IHfX7OcBD6RtAgL4xteSdf1Nw93HCLkwb+4A6AZaX/B1Vh/4GYCHbWGaSDfQ4ZAgSMPHvr94Q==
X-Received: by 2002:a05:600c:3011:b0:424:ac9c:7228 with SMTP id 5b1f17b1804b1-424ac9c7c26mr20195405e9.4.1719430991709;
        Wed, 26 Jun 2024 12:43:11 -0700 (PDT)
Received: from gpeter-l.lan ([2a0d:3344:2e8:8510:24d9:a20a:2de5:8eda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c837eb2bsm36728905e9.39.2024.06.26.12.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 12:43:10 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	s.nawrocki@samsung.com,
	cw00.choi@samsung.com,
	mturquette@baylibre.com,
	sboyd@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH 2/3] soc: samsung: exynos-pmu: add support for PMU_ALIVE non atomic registers
Date: Wed, 26 Jun 2024 20:42:59 +0100
Message-ID: <20240626194300.302327-3-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
In-Reply-To: <20240626194300.302327-1-peter.griffin@linaro.org>
References: <20240626194300.302327-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Not all registers in PMU_ALIVE block support atomic set/clear operations.
GS101_SYSIP_DAT0 and GS101_SYSTEM_CONFIGURATION registers are two regs
where attempting atomic access fails.

As documentation on exactly which registers support atomic operations is
not forthcoming. We default to atomic access, unless the register is
explicitly added to the tensor_is_atomic() function. Update the comment
to reflect this as well.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/soc/samsung/exynos-pmu.c            | 16 ++++++++++++++--
 include/linux/soc/samsung/exynos-regs-pmu.h |  4 ++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
index 624324f4001c..5556acc7c092 100644
--- a/drivers/soc/samsung/exynos-pmu.c
+++ b/drivers/soc/samsung/exynos-pmu.c
@@ -129,14 +129,26 @@ static int tensor_set_bits_atomic(void *ctx, unsigned int offset, u32 val,
 	return ret;
 }
 
+static bool tensor_is_atomic(unsigned int reg)
+{
+	switch (reg) {
+	case GS101_SYSIP_DAT0:
+	case GS101_SYSTEM_CONFIGURATION:
+		return false;
+	default:
+		return true;
+	}
+}
+
 static int tensor_sec_update_bits(void *ctx, unsigned int reg,
 				  unsigned int mask, unsigned int val)
 {
 	/*
 	 * Use atomic operations for PMU_ALIVE registers (offset 0~0x3FFF)
-	 * as the target registers can be accessed by multiple masters.
+	 * as the target registers can be accessed by multiple masters. Some
+	 * SFRs don't support this however as reported by tensor_is_atomic()
 	 */
-	if (reg > PMUALIVE_MASK)
+	if (reg > PMUALIVE_MASK || !tensor_is_atomic(reg))
 		return tensor_sec_reg_rmw(ctx, reg, mask, val);
 
 	return tensor_set_bits_atomic(ctx, reg, val, mask);
diff --git a/include/linux/soc/samsung/exynos-regs-pmu.h b/include/linux/soc/samsung/exynos-regs-pmu.h
index aa840ed043e1..f411c176536d 100644
--- a/include/linux/soc/samsung/exynos-regs-pmu.h
+++ b/include/linux/soc/samsung/exynos-regs-pmu.h
@@ -657,4 +657,8 @@
 #define EXYNOS5433_PAD_RETENTION_UFS_OPTION			(0x3268)
 #define EXYNOS5433_PAD_RETENTION_FSYSGENIO_OPTION		(0x32A8)
 
+/* For Tensor GS101 */
+#define GS101_SYSIP_DAT0					(0x810)
+#define GS101_SYSTEM_CONFIGURATION				(0x3A00)
+
 #endif /* __LINUX_SOC_EXYNOS_REGS_PMU_H */
-- 
2.45.2.741.gdbec12cfda-goog


