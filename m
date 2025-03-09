Return-Path: <linux-kernel+bounces-553320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B800A5876A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 19:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E5F87A4BF9
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 18:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352911F8739;
	Sun,  9 Mar 2025 18:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BUvAfBfP"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BE41F8737
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 18:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741546573; cv=none; b=Z023f5Im27Fymq1bT1mTG4Drboe2P+gnfp3dqxyTcQkEOaYQCHhS09NfEYs3yQTC0uBUIDcVcN1/SWXKb70MgzDrjlTYlJfQ7mzARVsPJJL+bwTPlNJ+R7LLC5pgkAMdTzGPbjhwjUFdwlaIvHOypu+EbW92p1TacAuToE/2pww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741546573; c=relaxed/simple;
	bh=kUxIzjT34djjsSWrouN9kcaq2cVWYfP4zf9wrxF60YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n25iYMSE1fJKC0jnwp1IADypbS52OM4l+FXZ8GPoZR+L4m3LrnbkDpU6bsXkeWPNZuhbY8Y5F4U8ICX83mLXy0JSvFMDnUL0onXnGHIdQwuOhcChZjK3UC70YQqq55bEmBDVtDjYbdPa9sRvGAy6V2jyTWJ7ygZ7xOMkb/iU+IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BUvAfBfP; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43ceeb85ab2so616595e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 11:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741546570; x=1742151370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csnV4M7t8mG+4gzOzlbb+RIrtUw1t0+Fx7m4dlnVHBE=;
        b=BUvAfBfPzS8V5fAnWkJ1+FUAenq+Lgdi/BXByG7jddMToWlLBusdiYntynvy17Lzzd
         aG5Alq7Ai0X9s7ghBLejAxE3irhkno0QvQMvOWPnlHfbIQyEg5UKcfjGuMHc7fXENqW6
         pwqETGZLEHYs0BCBCeHuj7OQ7QVCs0uU3x4jrXIi3cMD4GflM4kmg21fLp6IxnsIOHfI
         zNixhMvQxoOagigtHK0IJ9/jKdcyClc8VnZQ2XJ4JEwuYS18eZwpVzHANxnlbxj0Ei4h
         vyvMgRW56JzIKvHIvNUMW5E745TE8vdXY7cfg9iFCym02/yVwMcasEecbORouV0wAGas
         8OLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741546570; x=1742151370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csnV4M7t8mG+4gzOzlbb+RIrtUw1t0+Fx7m4dlnVHBE=;
        b=Q+Gsiusy86S4Z5HPfi9EGe9rsKHvc5EYwe3i58qju0X0pxOG5xAoQr1IAdxaGSLph5
         Zqkpss2/sCfqz0vLXYIo5iud2D3RuL7KZh7pFEy9Yx4w/5CcgEXsZPKRnjXmmzcXUzJc
         ac6Ot+oLJ8VLINDUxHys6tSFyKD9cbnIH3I0pr3QmmjW4budHVGim51nJH7QKbec/k2n
         E9kKOq/UEG4+Oqx9V9NCII+s3Tu1+FEPjKmNFVqLvDjnKGoU+MrObA+5go/5e+X5cEzY
         LqDpmPmCNzAuKXi5/dwtiauSTSMpdI7m/ALxgO4vBkuHS2N2DLFJbZ7UDoEyu9cRcGN0
         IksA==
X-Forwarded-Encrypted: i=1; AJvYcCU2e2xR0NVSOK2Nn2JKxBW2PqOhTeV30MV0jhq5oNlcuVoB79rUurBC/gSo217vNNFef+YaFQX+gLhSXfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6XJndE2zi2sxEh3A+pbVOSTqbqwwdTp7jamboXA+PL/wf6MED
	pJFRFYt/+eGrGiP9R3A2ubtVpITV18IFVsZi04ptDQG3QEHfmBF4+Oj1pjAAmD4=
X-Gm-Gg: ASbGncvXpvDmPIAfkKWjMxOEmbLlW7qJ9mNLpdiFUVDRistDC8aay0Cgkq096Vw5muD
	NiK6xEkvD2vRiz6X7qrAYNyTF5EtyTEXtb8S5xtTV6i+mbQa7U7niiztn3AovvQOkusCTz6/k3h
	6NMRS0AH9PKgaWolJdwY1M6BUx0hcU3Od8howmP+5ZPDGV7IMobaLHHZ15Ap8ACVECFQp4dgvbn
	6c7BZLlacLOkMxIJnrZxj7Hs3z/n4xwO/wxVLSBJMBHc67+rGacxbXWCmaLVwfvn2N2WJsu62DE
	zYJpMVBMPSGO1spILjT6+pH//rOCRDOUaXgWCTBSZyhA3YeJ52zpediPsOo=
X-Google-Smtp-Source: AGHT+IHOjQZl6au5AX9pwx89qj1PiY9uUWPbWjZhcAqE7l92MV4Sd5wk3pnxNKw3T6EVY3vWBvszTg==
X-Received: by 2002:a05:600c:3588:b0:43b:ca39:a9b8 with SMTP id 5b1f17b1804b1-43ce6b12816mr15245875e9.2.1741546570242;
        Sun, 09 Mar 2025 11:56:10 -0700 (PDT)
Received: from krzk-bin.. ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cee22c13fsm44263945e9.40.2025.03.09.11.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 11:56:09 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>,
	soc@lists.linux.dev
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 3/4] ARM: samsung: soc/drivers for v6.15
Date: Sun,  9 Mar 2025 19:55:57 +0100
Message-ID: <20250309185601.10616-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250309185601.10616-1-krzysztof.kozlowski@linaro.org>
References: <20250309185601.10616-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-6.15

for you to fetch changes up to c8222ef6cf29dd7cad21643228f96535cc02b327:

  soc: samsung: exynos-chipid: Add NULL pointer check in exynos_chipid_probe() (2025-02-15 14:37:19 +0100)

----------------------------------------------------------------
Samsung mach/soc changes for v6.15

1. S3C: Drop linux/fb.h header.
2. Exynos ChipID: Check if memory allocation succeeded.

----------------------------------------------------------------
Chenyuan Yang (1):
      soc: samsung: exynos-chipid: Add NULL pointer check in exynos_chipid_probe()

Thomas Zimmermann (1):
      ARM: s3c: Do not include <linux/fb.h>

 arch/arm/mach-s3c/devs.c                   | 1 -
 arch/arm/mach-s3c/setup-fb-24bpp-s3c64xx.c | 1 -
 drivers/soc/samsung/exynos-chipid.c        | 2 ++
 3 files changed, 2 insertions(+), 2 deletions(-)

