Return-Path: <linux-kernel+bounces-386470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13ED99B43E1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 464C11C21AF1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FD82038D5;
	Tue, 29 Oct 2024 08:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GeIhQlLz"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB8920371F
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 08:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730189413; cv=none; b=OxHzsMxZP0ks2O7a5njARedGafMQbwH1XaQQhPjTBEK2fW5Jfg12Si7dfFl5d7X7CpEHfVkoNn1A7JzyoapPGKhN3+Eh1M6oCCtcIXPI7J1nYi9msCcAXt/sguPih9jqcShAGcwY9S+9kAyPuCpiOZzk2FMDAP+hoe57n0FXzvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730189413; c=relaxed/simple;
	bh=OBIiL49540geMYYq7nS5eOLkYE1Imle7/TDrBQNL0nY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rVEv0faXrG9cMzF0JVa9Y7CA5da7fLfRrAN3DvibjSqsJhK36lz5eLp5vIhz4sLZ2ZTItUoIzcdx/LDTAPIZ6AUygQdRiKlf17oKyBwawPYldopm4CH6Bzcw3Oo5oxa8lHVoh3pxlZL5vSFT9UYEbv6tDupl0DlKXcyY752ZMKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GeIhQlLz; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4314ff68358so6433135e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 01:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730189409; x=1730794209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+nlHQgxHoo0N+w71NQjPtnfHRpsgGAqUyUZpSjSJNUE=;
        b=GeIhQlLzyb1c0ziDyuEpL3iekx6aUj3zobaD0BvgULNSqZXtetEs54ILy1+fe5ooCz
         go3+kvf/IdiN0BQBZXbadE0okEJAoDIvd62pKvE/QVT3ywb0dmnkt3cxHEO0+04v2K+W
         xgN1WA1j7GnODP8WcU8D6iaV5+Y8O4t+3YTsV1erIoAQn+w2GSaSeXSYF0kM8Xc48MTP
         cYYQyEXfTem9l9LAAsFRlp/KsZurPkoamj9h0DuWMCnOL1gSiUzHMMOtH/a5BAarw7FH
         4+zB8R7tbYSIRv9aHLsqVoiXFtKkndo/88aivvjLUMHHuW+IGm9SskYHYmP7arjh8ll7
         YXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730189409; x=1730794209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+nlHQgxHoo0N+w71NQjPtnfHRpsgGAqUyUZpSjSJNUE=;
        b=RMj3MgN7ck0uWn9s8A8UeqdzIdJSnOVk4r/BzmNGV26E0Aiwvk2ZoL/aFPSH5d2+hu
         Xy8WmWJ7lVD6l4JE5Usk4I3wiJyawvdOwxMgmy20T3nYqjn99Hayb2r+SJC4a+B7A3JM
         QYvgyg58pfLf3dL/V8m0BO/cTRKPj2AuF55nOioQYMXaZGKcOI9p6mvIfA90C1l/2yd2
         p80fCVFNE4XJqcI5gmqxvlNXKIWDQMmGoZUzJC1gBRdQsFU2GFk9NCkWkeolm3XsGi8m
         Igg2NjQ8OMP58ZIQfIefgdcI7yFl9JuET7olLJjax7fyVdYmVD3B6WQygHMjY2Yu6BhP
         AfZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6J6gtVrgraHQ58MvH9YtyAedCoNrYnm3Uy+itzF4tq3ueO7oxbBGcI1MX6pFOtF2I232fT3pxBxPZHzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYpFRs40zpbb1S9Z/bRZoa0cEVKIjp4GLJHsEFNgC8yG1fmnZN
	mKuKDux8jutAi8OvpkhTuibEzGQuj5FIVAeoT2dz2hdq7N1VeRM1hI1OWQriQLQ=
X-Google-Smtp-Source: AGHT+IFBTmPkpYxqqzdZgLFMhy6wv545YoQN7O/maEIdRbbG/bFpFO5cny/nfyU9IGP8/iORnhBuaw==
X-Received: by 2002:a05:600c:3ba4:b0:42c:c59a:ac21 with SMTP id 5b1f17b1804b1-4319ac79b20mr37591015e9.2.1730189409495;
        Tue, 29 Oct 2024 01:10:09 -0700 (PDT)
Received: from krzk-bin.. ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b55f784sm165467485e9.19.2024.10.29.01.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 01:10:09 -0700 (PDT)
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
Subject: [GIT PULL 3/3] ARM: samsung: soc/mach for v6.13
Date: Tue, 29 Oct 2024 09:10:01 +0100
Message-ID: <20241029081002.21106-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029081002.21106-1-krzysztof.kozlowski@linaro.org>
References: <20241029081002.21106-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-6.13

for you to fetch changes up to 3a6ad95d97eb62a7b7c804ef7eeb329a1f697d00:

  ASoC: samsung: Remove obsoleted declaration for s3c64xx_ac97_setup_gpio (2024-09-30 12:47:23 +0200)

----------------------------------------------------------------
Samsung mach/soc changes for v6.13

Few minor cleanups in platform data headers: drop unused declarations.

----------------------------------------------------------------
Gaosheng Cui (2):
      ARM: samsung: Remove obsoleted declaration for s3c_hwmon_set_platdata
      ASoC: samsung: Remove obsoleted declaration for s3c64xx_ac97_setup_gpio

 include/linux/platform_data/asoc-s3c.h  |  2 --
 include/linux/platform_data/hwmon-s3c.h | 10 ----------
 2 files changed, 12 deletions(-)

