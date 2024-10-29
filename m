Return-Path: <linux-kernel+bounces-386468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BAB9B43DD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7CDA281B09
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8616F20370E;
	Tue, 29 Oct 2024 08:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RN5q8tOZ"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D6E2036F4
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 08:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730189410; cv=none; b=mXVXo/0zFfsqmZYYPh20uy14nQxnEV0vQAezf70GHCRwFAQ8tuqybP4Von97WuZdLZq0u+7dQsLAv1lrY3BfW9zA2UCxf28mVyrJuGxcma02ttIDN5hlQ13lPnqRWupvcx7qvFDxwe8g7nE2QHUEwZbTiEOW++0L8KkkcCDTsCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730189410; c=relaxed/simple;
	bh=BiKzbp1jPxmy2zZUEQHW41SCWuFugkSatqygtUEc7hc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PMf9O6kG9I6kY0e6xQ4B+R2/zWX1PT0Y45BdTbaCv88M53H8OUNqPVkFw7JiBM3wVIf4a+ni0Em0k5Utk8u7ykYVvhwNP3pGU1x78E6vH3QpjB7+wssxPwT4QYkhSxYDZhp3D4pigNuY/ZtyzwwKMP/H7hT4KvdrRVaLicKchPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RN5q8tOZ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4315855ec58so6421375e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 01:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730189406; x=1730794206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UJk4K1NEYom8w+Pd7ggik8xB+/zfQw0G3X6wkeyzU9U=;
        b=RN5q8tOZgVKXEnrKnEXVPAmIR+/1kh5MED1KqpCgwG/RWQMaIMF6BuwEGhNQcY1I1w
         ONpJUHkkNOnYuEKagFj6nL18PR/ZWsmWJVYZPs/CAyf2wEvNizrCnS7yRPkY6dV+pVFz
         j3oPLc9k4RH6NtkZs+B4Vx2v/oJLGBYJHTz2m/hen0cSeVU0Qkw5dyp8yb0C5nzn2Kh8
         NCRnQFqDsvRahRRIVkODAZAcBYhoZIanXaPkLkgZzL7vF7k9CK83dgIPm7uetx2GQfra
         12gEDoIsYxOy5mn72h7Onm6MOFfVp3S2RngWm0UwmLNptuDaWixN4KFp+QE7SuqNcG1o
         821g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730189406; x=1730794206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UJk4K1NEYom8w+Pd7ggik8xB+/zfQw0G3X6wkeyzU9U=;
        b=LGUjUFxMVsYv9Nilh6nEJ2DH1q1pkAio4nruHjRpoItcG/iHLZkoIs7o8r4fmpeT2S
         c4wKsVE+VY+zdcxjcfSCyA7E6nv1XJuJeT+SduNFnMaOe1ZJsFZBYnkiX1FgbyFFqG/0
         k9OvgZn6ky7+LPJuE1QRbhEgsycZyAi4yreA71k/vrXSZMwuLnw17Vw2k2b8pe9TFmBM
         E2W7eGRoyG5F7NrggK5jpR9oIaZjuy5H0h6QRUN72vXkOrJ2j6EYp4zNQRw7x8KJ59Np
         vlr9ccIJWG3snjcsbaXw20MvmjWxUgJoTbLA/TYyO+nTPPykGr8jIX3XDToeydRYlZkp
         mpDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUy02tcgiX+K0oQySfGTMWp4jUKecMs7prVDTM+SN8/kyLro78qrwhOLvxsCF8/Piu70nFiCDvvK2fdj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlEaD7VR63sZuoQFaAT94zDbcDwmmfoU2HvPZPV+AtFWaQJufp
	k5fFB2ti26Qor9FLydic0yJj4lNXDr9svzsVr0Oyl5kJ3G51pGMrDi2Xgl+XJnU=
X-Google-Smtp-Source: AGHT+IHnLTXH3vKK9bio7SjMSZy36YKvL0zVstM38RToyHUADBXCTaWksKX2nxZaf0pDqrVA4QHoMg==
X-Received: by 2002:a05:600c:5494:b0:431:4a7e:a121 with SMTP id 5b1f17b1804b1-4319ad4ee8emr37678985e9.9.1730189406260;
        Tue, 29 Oct 2024 01:10:06 -0700 (PDT)
Received: from krzk-bin.. ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b55f784sm165467485e9.19.2024.10.29.01.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 01:10:05 -0700 (PDT)
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
Subject: [GIT PULL 1/3] samsung: drivers for v6.13
Date: Tue, 29 Oct 2024 09:09:59 +0100
Message-ID: <20241029081002.21106-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
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

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-6.13

for you to fetch changes up to fd0b3581666860610ac770d4b582df42e0065c58:

  soc: samsung: exynos-chipid: Add support for Exynos9810 SoC (2024-10-27 20:53:54 +0100)

----------------------------------------------------------------
Samsung SoC drivers for v6.13

Add Samsung ChipID driver support for new SoCs: Exynos8895, Exynos990
and Exynos9810.

----------------------------------------------------------------
Igor Belwon (2):
      dt-bindings: hwinfo: exynos-chipid: Add compatible for Exynos 990 chipid
      soc: samsung: exynos-chipid: Add support for Exynos 990 chipid

Ivaylo Ivanov (2):
      dt-bindings: hwinfo: samsung,exynos-chipid: add exynos8895 compatible
      soc: samsung: exynos-chipid: add exynos8895 SoC support

Markuss Broks (2):
      dt-bindings: hwinfo: samsung,exynos-chipid: Add Samsung exynos9810 compatible
      soc: samsung: exynos-chipid: Add support for Exynos9810 SoC

 Documentation/devicetree/bindings/hwinfo/samsung,exynos-chipid.yaml | 3 +++
 drivers/soc/samsung/exynos-chipid.c                                 | 3 +++
 2 files changed, 6 insertions(+)

