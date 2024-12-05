Return-Path: <linux-kernel+bounces-433847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C9B9E5DDB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 19:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2297287172
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B50229B33;
	Thu,  5 Dec 2024 18:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Us+U91RC"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B64422579F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 18:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733421729; cv=none; b=tt+VafyeB5KKCUfDwZ1bpi6ewuoRMn33+sHH+qyszFpcKHz2ylUaH2+Zks36dXRCSK+GvixklFT9rrRkmbAjSxoNRVFwLBhoADIiZz8aBvP2k3F6ZpoMX/SdpsaDD8rB5YHKpcAN0XyBiafcS5k6J/uMXoGQv23suTc/KtlJkZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733421729; c=relaxed/simple;
	bh=nTCkQn59kD1+YTP/O+jZqWcGW57TZWMWdFPzGNuprc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDNOp6YRWYBXsRFqVrOJCPaAugBkTagmY8J1Y1qv4RoaK6oA7ib1mCNgh5UsOEoUMxg6+5kUUQgEHevmOJlKFd0PS1xw177SdY9Bml0FAtWKrCu1U76KSVcD9hfpY4LD3s2Xtpy/t7K2zpNa6xU663R/nCvobixkLhvI646qwa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Us+U91RC; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434a752140eso8624615e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 10:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733421726; x=1734026526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPhM//wJrXG51ke59zvjjRItTECJ1az2JzHOCc8Yads=;
        b=Us+U91RC/tIYwFlVSiEVCkjLupmul78ifiCAt0lVxnisEPHCzyWNFjQRO+u/IJ1g17
         2w0X2AHDSJMBiDkBUl+HPqAFfJ3XTULUzcjfmu+ygxQFMPs5nbFxuDV0ay9O9hIczmnZ
         WdGqAdR6BIXHPcpvA4WcMsWuQhW0y56BQJev0MMmW2POTeZlmSwoIlWN3xmGoIEHq+0F
         c/56ckhI9b1f+CZoafsGhzzNrAASQ1PJlIb7mkIL/7Zynlgs0BsMmEnewQ2eDXg4nrzI
         aXEbgV7ecCayeulfXP//Ygc+5sC2teoIxt0u7mMS+fUGkjwfv6dSCR0SkLrxesMTEgye
         sAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733421726; x=1734026526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPhM//wJrXG51ke59zvjjRItTECJ1az2JzHOCc8Yads=;
        b=n7AvrdKdecO7x87OS4b2u/bILiIIgHJxyltv1G4GLJuoguT2swLCHqthIEIamFI2pv
         Va3QDlY/KbuwR70Vl0oOg0FT165/eiX7zy6LgBM/tvd6Z2ZHRJRg88T/hyACNJK+T46C
         MCr3j1Ydc5J6ciXY1WcVJtS4skOtYM2v2oS65ak+IXLZdgi6I/hy/TXH/3H69eetTzcy
         AHojl/rCQhpfiUUupjxb5OF8hN0ZyV03VjY8WnQNZQ/mevnKerGOagWGu2VKLyil23Zm
         uduiYEmJHLMytAx6PbCz3QoBK2eCGn2GVleCsRU02n9XhnKqn3ubRb/Bz3ofzV80K+t8
         K5pQ==
X-Gm-Message-State: AOJu0Yx0LKwBy3v16b0b1OMUNY154j1jyCKA677h76xsSTGTxXZted6b
	+q13uF0uDDR28WivVg9YW3OeDfHVqi196mqUtPKVwBTv1wnLev8NEwt89YRkz2k=
X-Gm-Gg: ASbGncuea+b+EqqXGU0hL6mPP8PtBpHPcYR6Vh1vKzwEfYvddVCX/3U25Kg7hZUZmmu
	OvnEMW6PdC3OMnrJhPUOCq0gJJc2QefzbBcQieghkubFEwSdcRjgc4akCwRfX3YJMmczxxrMVc4
	tdfEueLr48VOwSt0EFFL2w2/cafh24Kn46S4FwT5fXFDW867Hij7tjsLjNI+nWDakMEgyWBKvzu
	QZtiJcAZ+tOB/JVD3iYCuUm2NJpyBzVkRK+TO1Q45C6H9UiDwPc0gIYkHsm81o49QKOiKVNBVJH
	FzsbVLvAS0PTYjWfR8PKAldN8VqDK6Uv
X-Google-Smtp-Source: AGHT+IHxrmKnYhkbCeS29d3k6ksOUL+fr3q/QtXJQ6fFRSknvcyUZjZ0xuVckzybtdhQNCwqXZo+yA==
X-Received: by 2002:a05:600c:4fd6:b0:434:a9a8:ad1d with SMTP id 5b1f17b1804b1-434ddea64a2mr2257205e9.7.1733421725765;
        Thu, 05 Dec 2024 10:02:05 -0800 (PST)
Received: from ta2.c.googlers.com.com (32.134.38.34.bc.googleusercontent.com. [34.38.134.32])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-386219098d3sm2618228f8f.70.2024.12.05.10.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 10:02:05 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com
Cc: linux-kernel@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	peter.griffin@linaro.org,
	javierm@redhat.com,
	tzimmermann@suse.de,
	daniel.lezcano@linaro.org,
	vincent.guittot@linaro.org,
	ulf.hansson@linaro.org,
	arnd@arndb.de,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 3/4] arm64: dts: exynos: gs101: add ACPM protocol node
Date: Thu,  5 Dec 2024 18:01:59 +0000
Message-ID: <20241205180200.203146-4-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241205180200.203146-1-tudor.ambarus@linaro.org>
References: <20241205180200.203146-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the ACPM protocol node. ACPM protocol provides interface for all
the client drivers making use of the features offered by the
Active Power Management (APM) module.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 23 ++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index 0970f6fc1ef5..ed9815194f65 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -277,6 +277,29 @@ apm_sram: sram@2039000 {
 		ranges = <0x0 0x0 0x2039000 0x40000>;
 	};
 
+	firmware {
+		acpm_ipc: acpm_ipc {
+			compatible = "google,gs101-acpm-ipc";
+			mboxes = <&ap2apm_mailbox 0
+				  &ap2apm_mailbox 1
+				  &ap2apm_mailbox 2
+				  &ap2apm_mailbox 3
+				  &ap2apm_mailbox 4
+				  &ap2apm_mailbox 5
+				  &ap2apm_mailbox 6
+				  &ap2apm_mailbox 7
+				  &ap2apm_mailbox 8
+				  &ap2apm_mailbox 9
+				  &ap2apm_mailbox 10
+				  &ap2apm_mailbox 11
+				  &ap2apm_mailbox 12
+				  &ap2apm_mailbox 13
+				  &ap2apm_mailbox 14>;
+			shmem = <&apm_sram>;
+			initdata-base = <0xa000>;
+		};
+	};
+
 	soc: soc@0 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.47.0.338.g60cca15819-goog


