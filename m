Return-Path: <linux-kernel+bounces-213339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B66C9073F2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22869B23DF7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FE81448E9;
	Thu, 13 Jun 2024 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cU8DrxXR"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D92A94D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718285928; cv=none; b=GsiQPSs8r0x3W//fuBOyTBhwwcC2V4jmhsswzY+Cg5EpqlHStLRtS7+2vF3AW/wza1jsGMwarZXkjfFqWHgmIKmcijqzQC7/h/s28tlTMxHK07akK9hsa3zTMAuhnVrudGaQLlUly+jlrSYCKOTwFjigbofwdLoTb8XJwYJqnG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718285928; c=relaxed/simple;
	bh=/fq0TZJn7YnJzUyVEjTbb5vPCeq8nCTFnjPoXw1SaQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D/YD1aoht7PYcXwDUJDqkMKfgOCrYT9QSrW2ML9Zi5yNzkKxe+gb9m930WjnZjdgDE9ZOar6lGqIdmXDzb68yC47h+Ei9I6OvfiLICl7064nYbnlOYtooMpBzAdKAfo3vA5s5xVovSO2MVvcUe+Gc6CEGWTjJps3NjZjXgQO2GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cU8DrxXR; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4217dbeb4caso9323705e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 06:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718285924; x=1718890724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wd6mMNX2S1BvaXmQq6C+uLeNiInNteHl0yr+fj9gdKI=;
        b=cU8DrxXRkHwAOpX7MedAxaQvrfprJesu3b/7pGE6i/Lz+wdxmfD7Gvg+2aSl7fUPUg
         t3CBWltzX+crJMufGJJQSq9zjrzlFnp9lb3YH4UMzLoTG3gaRPPGKyJwx4Q9XkYDOgEt
         gW4JpD6MU/Aaru4cg2e5BBbJb1cYHOtDEEEPkbDLxvqSUxRlvYyckG6Qj4u5nCoyQaxu
         qMYNzDjdzx6ylhrW76lhNdR9YatUgVfoIhKKelc4OUy7ucw+vi5fH1Hy2Vfu1JXeLv3S
         2ijClMtsRetz2i8DwjkyP8izffH6eONFi1TUzkL3L/U4hi+gWEGpL8AXSToTBa15Cu54
         vVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718285924; x=1718890724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wd6mMNX2S1BvaXmQq6C+uLeNiInNteHl0yr+fj9gdKI=;
        b=Pma4MVwPXyN/By19MLeJpZgIKSgGJt26mujfTdXMh6uRJGtiWfFCefF0qk08mTca4d
         tIGZ764SKI5S6h/i4FHL1ztfiiM0eAnM24AouqIbfIClw/aSdkFstHUJ03xoetd2/4d7
         HRB/LJv9OjB6tqcY5AImqCQvdXO7/cdk1Q3O7uXipx5A4nFqNbpNdfiu75snZlEupx3z
         XdbXxLlvxZhm8AX7ESQWwox3TNo4jsN3m/VYe5iiUsoT/AnVyWuPR6DOxEFFMT899Isy
         RHK6LN8BwbIhgEvoh1scJPFKzOfT/YXVv7UzZlep78jyQQZhMlCSWyPvmGtMM1kuxf1C
         bQaw==
X-Forwarded-Encrypted: i=1; AJvYcCWiW2NGNK1apElu/+zqMo7S9nCrWapOZ59rb6QQwSeHmmL6OmCuGraG++U93UsZXpH4wjSEO09jfRgPMWWON2QvDvA2bthj3DDfJelr
X-Gm-Message-State: AOJu0YwRYF7JUarE84sm685r3kifHHrOHNhg6ItP4u483WpwEgOhqvRP
	xTvWN2atCcGUtqaZEvShxEtaFB9y5d0JhFVmDz93bVjtA6RcIIjCdOVRz7LWaQk=
X-Google-Smtp-Source: AGHT+IFUqr5sGQRcNAQ13+nGKzOjcicanr5LrzrR9lynEZ7s4rDVAOtSSSoEI8XHdMfKIq2OgA/eDA==
X-Received: by 2002:a05:600c:190a:b0:422:fa63:33f0 with SMTP id 5b1f17b1804b1-422fa63360amr11707035e9.38.1718285924382;
        Thu, 13 Jun 2024 06:38:44 -0700 (PDT)
Received: from krzk-bin.monzoon.net (46-253-189-43.dynamic.monzoon.net. [46.253.189.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286eef9eesm63435725e9.9.2024.06.13.06.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 06:38:43 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Olof Johansson <olof@lixom.net>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] MAINTAINERS: ARM: airoha: add entry to cover Airoha SoC
Date: Thu, 13 Jun 2024 15:38:23 +0200
Message-ID: <20240613133840.6949-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Airoha SoC is not covered by any maintainer entry so relevant patches
can be missed.  It seems Mediatek SoC maintainers were covering some
parts of Airoha and Airoha itself is subsidiary of Mediatek, so assign
the Airoha maintenance to Matthias and AngeloGioacchino.

Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fb32a2fe3a79..e7fd595b8f5e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1924,6 +1924,15 @@ F:	include/dt-bindings/reset/actions,*
 F:	include/linux/soc/actions/
 N:	owl
 
+ARM/AIROHA SOC SUPPORT
+M:	Matthias Brugger <matthias.bgg@gmail.com>
+M:	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
+S:	Odd Fixes
+F:	arch/arm/boot/dts/airoha/
+F:	arch/arm64/boot/dts/airoha/
+
 ARM/Allwinner SoC Clock Support
 M:	Emilio López <emilio@elopez.com.ar>
 S:	Maintained
-- 
2.43.0


