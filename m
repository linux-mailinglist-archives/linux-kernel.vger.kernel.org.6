Return-Path: <linux-kernel+bounces-234658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A30191C928
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 00:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 143D62872FB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 22:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB14612D758;
	Fri, 28 Jun 2024 22:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QlVWQmZi"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8F67B3F3
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 22:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719614114; cv=none; b=nR7Oq0jmngbZnl45h6q5AExoGgdL3yOGLdLicGUWj2Q9uvDn401Is++i/mTXjlSQC5O0NkVHkNJZqrCIAkIK9n/lGMV4Cu60eB/Mz/z1bm12Ct30EKh64/VoM2ABU8fmoYc1xT5HUUqCzoUxyppgVN8hwKm7xxufWhJPgEZyVms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719614114; c=relaxed/simple;
	bh=5wNStx9ZejoI0zvw8AL1hgOTg2MQ1Bl8Y9ACM2hlHFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rm9ffW35CAKaNFCs/3qpQG2tKdz4ScbZnx+QrDgmTpMN+Z+SshdfBu0cJohtVX++MHJozEVrWTj/4+NuvZjkGhPngfaZ4Lk0pTb9F1RzoweJCezNVy7GopGNl/mv7N4zruYYTNogWx3vvewQlTY+2Lq7EjrykgkRo0bh6zL2Cak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QlVWQmZi; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42565697036so13511945e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 15:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719614111; x=1720218911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuVQVXYEmakARqoxnkh1rU+VJ/ryD2HUobF1z0QnBDI=;
        b=QlVWQmZi+En5y/6YgAyHr+W6rek+rGw+Quf4D8ecWft6ZOsRGWMKPIXjFHV3pbPCdu
         7wKUishQVjxA1W/WvJ4ZcH0Tg9+b9PxjqiBxTaT5+hWTZRJ64C9KLpCDXfHLzM9ROqsp
         ejM+I692n4I84F6zKmcCAJgnyiIgpweS0nvo50FKgFgFzs0KC+/lA/4WG5+nBuEcYogd
         t+cUuok061zqIsdRbtTqRqnza0New1Bhxs9jSzthiahnrLzkvb4Q5A9wYlyTKbGGk9HZ
         k/NOa8jORl73g4E3s3ECTjqcga3sW50s5hZHADaJ74Dlo2/iAX/DBoMkOCT4PPQR9uFg
         /TLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719614111; x=1720218911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vuVQVXYEmakARqoxnkh1rU+VJ/ryD2HUobF1z0QnBDI=;
        b=WSOGDJN4jAYVKHWyTsbmncm5mE2N6JNc5vDQ2Z9rADPiHh1dYlQq4fxEyMVZljh7MJ
         Qtqc2edHWAc/q+81JUcoC8bUEauBt8IPkm5FRJ+/xy0ijgPK83VMJ8fS/6fyKJouRNFr
         VnxTWROv8MuI/+2ralSLSKWH25SA0KLaAIlRiqQLKIrO18sdEklihH8aAyEzOi7x3ny0
         MaiHlqrlB7uzYdhSa2Zq1vaogCdpdMxJNUx3zoqWd9OF3LskRerghrToINTfnf46rd5Y
         qeXYSmWTrc5pqSvfkR4zwLD88HLGxZ6qjE68KWfi2oshFzn/1zQ7HIM/0AEaYqcvY2VG
         wM4g==
X-Forwarded-Encrypted: i=1; AJvYcCXWEJJNVKsb79psFNPbxpSdhe0P00uPx542juhTyFkWGmTynV8rJ93tCntPRiVOeqdnGUIPxEyqvazL/xngWhokmmaXSwCBqxEk1yLx
X-Gm-Message-State: AOJu0YxP99EQMCWx+NoObzYvOt9UdlR8V0QW7d4HlzMrr82QME/mdRJz
	x3H6JbXf9dfb51jxomguH52AxdGyGx0LUr/3cx03I9ystQu14qXbV2ujVbbGFUk=
X-Google-Smtp-Source: AGHT+IEn8tAmHmaoIZpdkcK9zHFNnpV4t8ppIqXVWIUjxA89/S4BC6t5GJOvR9iwbTk7m9NttkV38Q==
X-Received: by 2002:a05:6000:1fa5:b0:363:b3ea:7290 with SMTP id ffacd0b85a97d-36760a7c1d3mr2827043f8f.20.1719614111050;
        Fri, 28 Jun 2024 15:35:11 -0700 (PDT)
Received: from gpeter-l.lan ([2a0d:3344:2e8:8510::3aa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a043a16sm3496711f8f.0.2024.06.28.15.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 15:35:10 -0700 (PDT)
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
Subject: [PATCH v2 0/3]  Add syscon-reboot and syscon-poweroff support for gs101/Pixel 6
Date: Fri, 28 Jun 2024 23:35:03 +0100
Message-ID: <20240628223506.1237523-2-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240628223506.1237523-1-peter.griffin@linaro.org>
References: <20240628223506.1237523-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Krzysztof,

This series adds support for syscon-reboot and syscon-poweroff to gs101/Oriole.
It has been tested with reboot and poweroff commands respectively.

Note the syscon-reboot/poweroff has *runtime* dependencies on the exynos-pmu
and clk-gs101 patches in this series, as well as [1] which was just queued by
Lee. Those runtime dependencies are described in more detail here [2].
As you are the maintainer for exynos-pmu and samsung clock drivers I've
included those patches in this series.

For the moment I have left out syscon-reboot-mode dt node as whilst it uses the
same SYSIP_DAT0 register as exynosautov9, and setting this the reboot mode is
correctly reported in the Pixel bootloader. The bootloader is also checking a
scratch register in max77779 chip that isn't currently enabled upstream, and
thus the bootloader doesn't actually enter fastboot.

Kind regards,

Peter

[1] https://lore.kernel.org/linux-arm-kernel/20240621115544.1655458-1-peter.griffin@linaro.org/
[2] https://lore.kernel.org/lkml/ZnymlHiCCIDt2dCJ@google.com/T/#m8b3a5e10ad44ae83a9afed4e4f5cd409493d951e

Changes in v2:
 - Move PMUALIVE_MASK check into tensor_is_atomic() (William)
 - Collect up tags
 - rebase onto next-20240628

Peter Griffin (3):
  arm64: dts: exynos: gs101: add syscon-poweroff and syscon-reboot nodes
  soc: samsung: exynos-pmu: add support for PMU_ALIVE non atomic
    registers
  clk: samsung: gs101: mark gout_hsi2_ufs_embd_i_clk_unipro as critical

 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 15 +++++++++++++
 drivers/clk/samsung/clk-gs101.c              |  2 +-
 drivers/soc/samsung/exynos-pmu.c             | 22 +++++++++++++++++---
 include/linux/soc/samsung/exynos-regs-pmu.h  |  4 ++++
 4 files changed, 39 insertions(+), 4 deletions(-)

-- 
2.45.2.803.g4e1b14247a-goog


