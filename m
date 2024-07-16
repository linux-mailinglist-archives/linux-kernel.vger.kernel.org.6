Return-Path: <linux-kernel+bounces-253657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E1E93246B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 12:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B28DD2852D4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 10:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14918198E9A;
	Tue, 16 Jul 2024 10:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cNpjIv7L"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CAE1990DC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 10:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721127251; cv=none; b=qPK8/gg4IsjrSnroUW5VLFwnyHZi//7t+wo5lSqAQqRAcdR67Xr5CKaXcbxrDSqJdowNs4SaBKLX6YGelvTH3NA9UZ+CHCZYO0GgSeeV1z1eWXAR2v3Luj7EIhyrP5HzSRsBw905NGS5gwvlm17FTYosPxTm2/tWu3EYdJo3+dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721127251; c=relaxed/simple;
	bh=+w/bnjZ/tn+nq8poqu+IGSDPvhb5UpTzj50jHOkdDW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAAwXa79hkBvFzqNLVw5S3a0UBstFL6A1HUWPNXer+m2zx85dK4uXAdOjaCX5dheKhF5woYgzut6TtA4D6E2jqJXmJeXpfvBtEtMESNSx/wJhTlS/kEzLzN1+FFahZFstSFNV6sy5u2ffyVkjjKou9ZTa0rZ6P12a70fyfx6+9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cNpjIv7L; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4266f3e0df8so35968155e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 03:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721127248; x=1721732048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyuo7ymVcbzU+lbv0ozx2Wp1zadLF4u4V/2ydSe41UA=;
        b=cNpjIv7LHcp7Iqi8lsZV9oDQNceLM6funX5RD/mkTkyYQs9dSeGmdxSGvjACTJL4MP
         DSJ4zeb09jIXmwJcsF1DPpM9hoA6MfZDV2Vlr4mpeOA2s79+DFoxZLCjTjH+3jZW5QUe
         q7ljlG2r0Gd/kjG+zR6ajw8uuCnw0WVN6El6HAP3P5iozC2S86PHca2YBtWIRC7Yc91d
         yHHMXzJ77ZdKrbcbKLZbr1g4zhoo2U1WowqDpCfcVDlAwT6PiAPKeYYJJhtTXwHAxw+Z
         umnSzaCQcXQnXNBG2aT4TtwPOgC+G/bpjia2UxmfleCHAKNXQzoccCJekJfE3OQwMnpx
         f7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721127248; x=1721732048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyuo7ymVcbzU+lbv0ozx2Wp1zadLF4u4V/2ydSe41UA=;
        b=oJsrSh9EYaTDOJl9yFDeLlgQMHfUi5DANVhz3vosa3qJoH/nHCg52BPxDMmGAdpzRN
         oaWxeXytQfGRkXFoMaA4Y5GLYq/ghAoHd7M50vel/usRf+WEBiYGS5kgLOkjEtpznjBq
         LJXl5s9CpNW5jX4xz4gtE+yYRDE75XtltBYclBDz/1IgYDFbM4FVvIrXvH1X7q2u/2fB
         TRoRXlxKx3hY14NvvdXnbpOxbAM+ay1lN9tM2c8jAeCTxpzVL9uuJXrXompC6a0qREdD
         mLenqhYLyLTD4OXYNF3PEGZyERRQmj+yThP29G32PdK4fTqfvO/qyA3NnDA9VFADd+vL
         bqQA==
X-Forwarded-Encrypted: i=1; AJvYcCUUXdJyZLtZbiuEN/yHLLhNEk/kSU5tfOjQmXIj24yP8rFyZXmX1+Nd8g6bNGlvFyXq3qWWj+JWEmVKzzrArKD7cWcwiUkygFif/o8K
X-Gm-Message-State: AOJu0Yzi3lok2lakOegUZ9tZSLZ8C1+bePdQOD6TXrNkBhqnxpIcCIPS
	ZwVwkbzVtbfe/x88iAhCcp8MwdAXsRUO4bVewjO706C/XZRmJiq5nlg8WQqjopM=
X-Google-Smtp-Source: AGHT+IGu0CFER4lOm7lC+0CLH03MwpuK6ZEYW93hhMMbm1SLzfoJbXRKPTT7qeYX96r2r9ne8vQUaw==
X-Received: by 2002:a05:600c:444a:b0:426:6389:94c4 with SMTP id 5b1f17b1804b1-427ba6b154cmr11340165e9.37.1721127248012;
        Tue, 16 Jul 2024 03:54:08 -0700 (PDT)
Received: from rayyan-pc.broadband ([2a0a:ef40:ee7:2401:197d:e048:a80f:bc44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680daccbafsm8608295f8f.51.2024.07.16.03.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 03:54:07 -0700 (PDT)
From: Rayyan Ansari <rayyan.ansari@linaro.org>
To: devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: Rayyan Ansari <rayyan.ansari@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	de Goede <hdegoede@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH 1/3] ARM: dts: qcom: {a,i}pq8064: correct clock-names in sata node
Date: Tue, 16 Jul 2024 11:45:59 +0100
Message-ID: <20240716105245.49549-2-rayyan.ansari@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716105245.49549-1-rayyan.ansari@linaro.org>
References: <20240716105245.49549-1-rayyan.ansari@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the clock-names in the AHCI SATA controller node to adhere to
the bindings.

Signed-off-by: Rayyan Ansari <rayyan.ansari@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 4 ++--
 arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index 81cf387e1817..277bde958d0e 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
@@ -889,9 +889,9 @@ sata0: sata@29000000 {
 				 <&gcc SATA_PMALIVE_CLK>;
 			clock-names = "slave_iface",
 				      "iface",
-				      "bus",
+				      "core",
 				      "rxoob",
-				      "core_pmalive";
+				      "pmalive";
 
 			assigned-clocks = <&gcc SATA_RXOOB_CLK>,
 					  <&gcc SATA_PMALIVE_CLK>;
diff --git a/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
index da0fd75f4711..dd974eb4065f 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
@@ -1292,7 +1292,7 @@ sata: sata@29000000 {
 				 <&gcc SATA_A_CLK>,
 				 <&gcc SATA_RXOOB_CLK>,
 				 <&gcc SATA_PMALIVE_CLK>;
-			clock-names = "slave_face", "iface", "core",
+			clock-names = "slave_iface", "iface", "core",
 					"rxoob", "pmalive";
 
 			assigned-clocks = <&gcc SATA_RXOOB_CLK>, <&gcc SATA_PMALIVE_CLK>;
-- 
2.45.2


