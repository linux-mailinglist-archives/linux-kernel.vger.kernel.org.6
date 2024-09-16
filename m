Return-Path: <linux-kernel+bounces-330312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B3D979C75
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB96CB23758
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 08:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B51E13FD83;
	Mon, 16 Sep 2024 08:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AGIaLtlJ"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9429913E02A
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 08:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726474126; cv=none; b=JLQ9DSQShs9P4F05gGp8GG7qlHJPpcCUF/6DsXQef8A4Ss3YGvybYVyKgbPKwpMnEoDM5YfeUmvPsjfCmCtsrXyA/n212kX6R9XqYRJgnD6urdoIjE37tISW1r/m3LLiTR6yLADcySX18ra8Zb4/P2yV9EAftyP8pyUQb+klQeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726474126; c=relaxed/simple;
	bh=rqP4urlgJvBv8itNHMQIBpXX+FWTUpB3KudvZnSF/Mk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OKEUUerzPkk49D0zz/+XM5QeISb64qBuD9jUfC3d9JiFMAEpqj4UiBfWrvnMxPFVuqUwG5b8nj02+VWScm9/rYZiShhY+3P5st2GJgaAeoC5okRSA37Tfl9fl0fa76Z6hT4PpQ9XDcykeHBaD68mtALTcuBzzmXAC/I54tRYgnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AGIaLtlJ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3787e067230so2970240f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 01:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726474123; x=1727078923; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TPiai5M60RqcO2MrqKnmNdVu0WGeSw1DQNJICr9QeyI=;
        b=AGIaLtlJB3sWWfT2mfuTlp1p00HJrZrM1zvUzkgn9t4iz9RBmA3gdGLFSrBP2sdcSw
         BmDnlqiut64sFu+MHRDSnUhK9QkXApVTpSfrRRZsAlWnFduZ5n9hj9QKQHlcGwVL4oJz
         4yUusKEMmwB8yvt1QSUNDBfBTNcK+yCOHzWIvsLh462IIifsF33MTJVecJyV9mczFzIM
         tJjpEmLNQq2FORtKjTrxLfvgStFT9jioANDSYxmOlsyiKhohmD1TlRVpBmlgvxbVz3ao
         gj9qJkl2Krji6YK3A0Umau49aUWk7kDavVq2Wp+FHvQ6NH97Yxa9tkz2jrSSBF5qHwhJ
         jB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726474123; x=1727078923;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TPiai5M60RqcO2MrqKnmNdVu0WGeSw1DQNJICr9QeyI=;
        b=Uv0tMejmpaBNuyrbwyer3VjL2P0dXi/cx/ygmd9auzU0StptwdUlu2frjJnhFf8XBc
         sQPjWaifk+KYF0rtFagSMKEau+ruJvApIvRmIx3DllpBgnkVwAjsqvy0g0JO/6Uw2UtZ
         Jb/7Q3jzFe5CHZt0zsPRKGZHqqr+ILZokxJgQTBiF9Kjci1y0MnPsCRXLs+ZC413Stcs
         hFozYznd5jI6BOeyJfp39a44IEmfDuB1vMnE9fqgwC9YCcLyD5WLDTfuJ5z5lt2GNhvv
         MtISCCA3TThpSuVawCx7B1nhGKq2ucG/FBWtgu1lxY30S6eSHoobIDl2P/g0PYT/sSCB
         GloA==
X-Forwarded-Encrypted: i=1; AJvYcCVKbpAVGnvjeaT4tXyUBf8/8OMuNGiX0jXvgQqAmLjgapa4Xr3Bc3DRuTZHuWVGerTZKj9h9ODIVWk/ku4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4SH7KLJJya/7jCHtPqo9IpdCbwktveZH4yRRTb0FbCvHzmG6g
	xWVra2BNgPwb6xoCAm++ohbthcroHr8fkY0fGtQn9MrX5fMhorY6/l473J2Njh4=
X-Google-Smtp-Source: AGHT+IFcCVRFb/Urp1NX/04IsEAYLn5VJB2C5dpD/DqUxz2lYzSO6XjtM6ssTLOL1chuPn7LmmviUw==
X-Received: by 2002:a05:6000:18a9:b0:374:c6af:165f with SMTP id ffacd0b85a97d-378c2cfec9fmr10989664f8f.12.1726474122187;
        Mon, 16 Sep 2024 01:08:42 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42da22b900esm69309465e9.1.2024.09.16.01.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 01:08:41 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 00/11] ARM: dts: amlogic: first easy dtbs fixes
Date: Mon, 16 Sep 2024 10:08:29 +0200
Message-Id: <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-0-0b20ed4f0571@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH3n52YC/52NTQqDMBCFryJZd4pJrdSuvEdxkZ8xDmgiEyst4
 t0bPUJXj+89+N4mEjJhEs9iE4wrJYohg7oUwg46eARymYUqVVU2UsISZ7KgpzH6I3m6KXjPaWH
 UExgKjoJP0NMHE9SNq1VlHsZaJ7JxZjyHLHx1mQdKS+Tveb7Ko/3vZ5VQQo9aG1PdG1mbdqSgO
 V4je9Ht+/4Dqu9BTecAAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3355;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=rqP4urlgJvBv8itNHMQIBpXX+FWTUpB3KudvZnSF/Mk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm5+eEFBDCJRr0IWadjwoOIQnZHKQ3vEeTTdIDJHbR
 1OQqcQmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZufnhAAKCRB33NvayMhJ0QMhD/
 sGdTuYNtS+aFKuEGfoJB3/m6Vo8xC1/ugz/vjZyUnV8Y9sx6acLuzmGhn8c2SBMCPDDMTefMBHUmEe
 zULOke8PCKwsD0IKuYd8IqH/+/mYJlHOxtyulaqs17xDxQBZtLGIbDHdXhRTjkS858GPtSYtTNwgWk
 nwT5BKsJ2FoLl5tTmpHaHteFIFd9Irynu0YCpZIb/34GHLZwuC6VOG0aoFyloc/+H+OVTa1DFbvpuE
 65p+yvd8edpPazb4OyJkVKRMFr0KLGBXlK0nQVoR/Ko84UkfhycCiaorhqkUYt95fNVvt855SEKBYe
 A20cOc4SuJgMfmg7sX1bvRRH9MYgGUMyS+R5q6/3moyclXT+z+aB/lDFTv8Re31/Zd4bHa5IlG4r71
 p8DmNep9WTq/8WQnoE+lfpZ38g2QYCMzJgy4R6HTJ2uXcgwtsGgxwbyLncIlw4PYM3ic/ZLneLXQLQ
 M+P6SHlhKlgVx3ukgs+nQ26gFryhGbau+lwwov3PwtkgZ4g0b2IdRmYRZxTQIB0EU2vLWPObvDBw94
 y5mEKKe3tqwPoYOVf0CJR69p6jss1ZkGSyBEOIKHFDczHWHLIogbyidpWHvxJaeyAnWM2WxCcdtw5t
 VL3VbZ2HveqzV4E4JPI28oL/vXoWHINsxZyGzq/G74+ZLRdYkct4yIimfhNw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

This is the easy fixes to start and fully document the ARM Amlogic
Device Trees, remaining work includes:
- amlogic,meson-hhi-sysctrl:
https://git.codelinaro.org/neil.armstrong/linux/-/commit/1be8f8c67e5b83fa4069ccbcfa80d0614f668a65
- pinctrl: Unevaluated properties are not allowed ('reg', 'reg' were unexpected)
https://git.codelinaro.org/neil.armstrong/linux/-/commit/8b408ad0781b4eb28a86aa04be136bc04ef73f0c
https://git.codelinaro.org/neil.armstrong/linux/-/commit/b6e9df5a7a642ee757e3aa0c84236338151d9f6d

This depends on the submitted bindings patch to fix more checks:
- https://lore.kernel.org/all/20240911-topic-amlogic-arm32-upstream-bindings-fixes-covert-realtek-rt5640-v1-1-6b3745e34540@linaro.org/
- https://lore.kernel.org/all/20240911-topic-amlogic-arm32-upstream-bindings-fixes-meson-pinctrl-gpio-line-names-v1-1-4345ba336ea4@linaro.org/
- https://lore.kernel.org/all/20240911-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v1-1-b7bfae886211@linaro.org/
- https://lore.kernel.org/all/20240911-topic-amlogic-arm32-upstream-bindings-fixes-amlogic-hhi-sysctrl-v1-1-b8c3180b2fba@linaro.org/
- https://lore.kernel.org/all/20240911-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson8-clkc-v1-1-e0b8623c090d@linaro.org/

With all those changes, we finally get fully documented ARM32 Amlogic DT !

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Collected reviews from Martin
- Fixed /memory node name fix
- Removed meson6 DT instead of fixing
- Added a few more patches to fix all DT checks errors
- Link to v1: https://lore.kernel.org/r/20240911-topic-amlogic-arm32-upstream-bindings-fixes-v1-0-feaabb45916b@linaro.org

---
Neil Armstrong (11):
      ARM: dts: amlogic: meson6: fix clk81 node name
      ARM: dts: amlogic: meson8: fix soc thermal-zone node name
      ARM: dts: amlogic: meson8: fix ao_arc_sram node name
      ARM: dts: amlogic: meson6: remove support for ATV1200 board
      ARM: dts: amlogic: meson8b-odroidc1: fix invalid reset-gpio
      ARM: dts: amlogic: fix /memory node name
      ARM: dts: amlogic: meson8: use correct pinctrl bank node name
      ARM: dts: amlogic: add missing phy-mode in ethmac node
      ARM: dts: amlogic: meson8-minix-neo-x8: fix invalid pnictrl-names
      ARM: dts: amlogic: meson8b-ec100: add missing clocks property in sound card
      ARM: dts: amlogic: meson8b-ec100: add missing gpio-line-names entry

 arch/arm/boot/dts/amlogic/Makefile                |  2 -
 arch/arm/boot/dts/amlogic/meson6-atv1200.dts      | 33 ----------
 arch/arm/boot/dts/amlogic/meson6.dtsi             | 73 -----------------------
 arch/arm/boot/dts/amlogic/meson8-minix-neo-x8.dts |  5 +-
 arch/arm/boot/dts/amlogic/meson8.dtsi             |  8 +--
 arch/arm/boot/dts/amlogic/meson8b-ec100.dts       |  8 ++-
 arch/arm/boot/dts/amlogic/meson8b-mxq.dts         |  2 +-
 arch/arm/boot/dts/amlogic/meson8b-odroidc1.dts    |  4 +-
 arch/arm/boot/dts/amlogic/meson8b.dtsi            |  8 +--
 arch/arm/boot/dts/amlogic/meson8m2-mxiii-plus.dts |  2 +-
 10 files changed, 21 insertions(+), 124 deletions(-)
---
base-commit: 292f97a2f8ac6b645ccd7766a06310351b9d9fdc
change-id: 20240911-topic-amlogic-arm32-upstream-bindings-fixes-69d624b8bccd

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


