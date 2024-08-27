Return-Path: <linux-kernel+bounces-303257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041A39609CE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294691C22A41
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36BD1A2540;
	Tue, 27 Aug 2024 12:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zxAvnFYS"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAD61A08D6
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761009; cv=none; b=KWuHIFnTiKTEO2+D4BQQGPMVI7daZJRWrT9zlnwTDP1OodWiXgdzGrc6tWgirJcEpsPyO6Mc+TVjcQwxfdovx0CD+xG7Ff+a8F2ADXWP4w1wqOfm2Qu4ygBPZSdQuKy+wVr5Xthf6MdDxBgY1R+aT4vbxHTiOjntiIxjOmRHEdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761009; c=relaxed/simple;
	bh=hstF5/sh5Y44tbVwg/VS7Ydbd2LlFd78AAQ6zy+kvSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZHG5fXsPiw8P4tWLyM83Wt3Aos2XBwV2MapHT/XuBrhmIxR2CRsCwT5kWZtV14vb9OVTsDvkzq7vaAwNFnjpDEigcoioExhfkOF1P6JK2OTJiA/qm+KDDrD3rsCwoWdWllDN2EIqT5R4nklhANad5fFuVE69ASHvFkKmFm0hG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zxAvnFYS; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4280772333eso7866725e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 05:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724761004; x=1725365804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnEbZFJ44c29HA1TxWo0cIEU8ZZqNT1LBIsiqX+Pjlo=;
        b=zxAvnFYSrLKX9zcezHkIuglv8qyDhVkn6ryKWCeF80JOgEUhgtQhuhDZZ4gNkoBQiy
         UUWzo9lKxplj8vxRX0F4ufbBdtSIW5qboFJ0FjPx7wd4oEGMHiqrSfywm7KyM+zE/1n1
         fQhSIcdL4akF36H2B+3PcVX86cunJ2PqA3Yg6Tnvn1DCud6VGSLBwmdasTxT0PRJcIgc
         VQlvREHcGd2V1etidLpNszHx1ukPkd7f6YPseG8tOObXB3fq9wVpWjdHLnV2rwVpcABO
         YZHNG3ufczOi51VFxoiSnLzuGqdxIstWzKWAsMKe7ZuzvyDjcbz6evza7FfyuOPH9aLp
         O/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724761004; x=1725365804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnEbZFJ44c29HA1TxWo0cIEU8ZZqNT1LBIsiqX+Pjlo=;
        b=KD+3Lz0NE4qgJ8AOrwrbPA2Xejmez11rakP3FcdTzEFQDsl42GMCAWZ75k71KFFrh2
         7pjNmFAgFzuw3P+PcVnu0d8S2GxwtJEckNFWGQeI/tVaIA3zYeAqMI5yTsxLRAjGMoCb
         aulX4OvV1zgfwYibWtjAmbhLjh0rUQjEMotSHatZx4vvSVYbJJpyo7YKb2Sa8EuzOuIW
         zT0efsC9iQxfp8qCBoudDoU0txKMR9bDPFU+0jwHnh1FG7KF4xOVIbueGVhn27BLItw+
         08pftq0rKqso4vdpVMkiA3mpH4Ks6pZ2siDyq+2biZzPDOEPBixuvZX83uA81JydNW7D
         TznA==
X-Forwarded-Encrypted: i=1; AJvYcCU9VAqYZsgVm+zvqeabRyshMODjgtNjqYD6vcuCXf8GSE2ZZL4ApKiz7LEPAzYPiZpg0uUD+p9CGcIfXvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNcowekvCfZouGPU8KSdo4VKmN+bICXWMg0hbQ0+wAV+2h1dQF
	z6ylCEFn5fPCCMmNKlaVXee2S0jmnZ6wmKB/N1XM96vqsRHpo5FiDnD5nxzgpSs=
X-Google-Smtp-Source: AGHT+IF4No28LsKRWaN0NTlD6PDhR1XvnFF1olqMjPVqMhBmdTAToVMw4YfhoMTTHeg+gG+PbElOjQ==
X-Received: by 2002:a05:600c:5118:b0:425:6dfa:c005 with SMTP id 5b1f17b1804b1-42acc8dca6dmr58251725e9.2.1724761004329;
        Tue, 27 Aug 2024 05:16:44 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730815b7e3sm12998658f8f.53.2024.08.27.05.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 05:16:43 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Olof Johansson <olof@lixom.net>,
	Arnd Bergmann <arnd@arndb.de>,
	arm@kernel.org,
	soc@kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 2/3] arm64: dts: samsung: dt for v6.12
Date: Tue, 27 Aug 2024 14:16:34 +0200
Message-ID: <20240827121638.29707-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240827121638.29707-1-krzysztof.kozlowski@linaro.org>
References: <20240827121638.29707-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-6.12

for you to fetch changes up to 4d06000979cda26e914552d486e5364248025fcd:

  arm64: dts: exynosautov920: add initial CMU clock nodes in ExynosAuto v920 (2024-08-23 09:20:52 +0200)

----------------------------------------------------------------
Samsung DTS ARM64 changes for v6.12

1. Exynos7885: Correct amount of RAM on Samsung Galaxy A8.
2. ExynosAutov9: Add new DPUM clock controller and DPUM IOMMU (SysMMU).
3. ExynosAutov920: Add initial (incomplete) clock controllers: TOP and
   PERIC0 controllers.
4. Google GS101: Add reboot and poweroff support.
5. Add binding headers with clock IDs for several devices, used by the
   DTS.

----------------------------------------------------------------
David Virag (4):
      arm64: dts: exynos: exynos7885-jackpotlte: Correct RAM amount to 4GB
      dt-bindings: clock: exynos7885: Fix duplicated binding
      dt-bindings: clock: exynos7885: Add CMU_TOP PLL MUX indices
      dt-bindings: clock: exynos7885: Add indices for USB clocks

Krzysztof Kozlowski (2):
      Merge branch 'for-v6.12/clk-dt-bindings' into next/dt64
      Merge branch 'for-v6.12/clk-dt-bindings' into next/dt64

Kwanghoon Son (3):
      dt-bindings: clock: exynosautov9: add dpum clock
      arm64: dts: exynosautov9: add dpum clock DT nodes
      arm64: dts: exynosautov9: Add dpum SysMMU

Peter Griffin (1):
      arm64: dts: exynos: gs101: add syscon-poweroff and syscon-reboot nodes

Sam Protsenko (1):
      dt-bindings: clock: exynos850: Add TMU clock

Sunyeal Hong (2):
      dt-bindings: clock: add ExynosAuto v920 SoC CMU bindings
      arm64: dts: exynosautov920: add initial CMU clock nodes in ExynosAuto v920

 .../bindings/clock/samsung,exynosautov9-clock.yaml |  19 ++
 .../clock/samsung,exynosautov920-clock.yaml        | 162 +++++++++++++++++
 .../boot/dts/exynos/exynos7885-jackpotlte.dts      |   2 +-
 arch/arm64/boot/dts/exynos/exynosautov9.dtsi       |  46 +++++
 arch/arm64/boot/dts/exynos/exynosautov920.dtsi     |  40 +++--
 arch/arm64/boot/dts/exynos/google/gs101.dtsi       |  15 ++
 include/dt-bindings/clock/exynos7885.h             |  32 ++--
 include/dt-bindings/clock/exynos850.h              |   1 +
 include/dt-bindings/clock/samsung,exynosautov9.h   |  11 ++
 include/dt-bindings/clock/samsung,exynosautov920.h | 191 +++++++++++++++++++++
 10 files changed, 494 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynosautov920-clock.yaml
 create mode 100644 include/dt-bindings/clock/samsung,exynosautov920.h

