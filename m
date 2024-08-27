Return-Path: <linux-kernel+bounces-303256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBFB9609C9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95E10282836
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BB61A0B05;
	Tue, 27 Aug 2024 12:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mt1DyWL7"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6581319DF97
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761006; cv=none; b=ePcGwSqKL+yf+wZ0Q1iTYPUiycBd+JiT0qbiSmsM9P54CUcn5CZBjuhWF4gONFb77D+00DRE/zsYoNJq/k8qzA8bbXMdS/NJTIR8k9ttdu/SJJ0qVue4HruCZp0QgiLMXRhGxced6xaosljX2D1YbEIEbqEfk1JgjOcvSObN0Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761006; c=relaxed/simple;
	bh=nep7vEaigqYcGCVuwcX1KbQzok96E19XfomX5Tfihx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V85ISYCOJGSi7VKmHdcvJZz4KCA1DBJJTbUgB2usb3QbCEnATKXUBV9KrHyMwRh31Ouuym8l0nYHux+5WtiO8WpRw1bQX+pMIm/j7SWveCjHougfFa+MJHJ7gL6eZOukV8we/egw8vS0fmPVpZykvZsUDfP6RUHRTI4hPDUCqPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mt1DyWL7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42802e90140so3609435e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 05:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724761003; x=1725365803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oEwWKAl5wGRDwroJblbu7pL64awe1nGTFISfN3cbkak=;
        b=Mt1DyWL7027yn8BbKvGaau4Cewu7Ammk8oGoY86JdOzp9NZgv5/e96+4yZdnTkepbt
         oDvOdyal2LJpFDk4c8kqOVPD+ECJmbuZhn7/RMSJzIncI52Pt5dFP5adoGxExErB3Mvr
         QQVFdsDrtvJanTsMMxohG4E59l0FPLhYvWWy9ZaPJC4axyucRiejgL0Y0dBQKtCVSjIA
         y0suQmW7ISRve0AxVOrThBzbltmVaghBSro2Zqx47ENJdPK/cavjDmApS2jfyJYE6AJu
         xjuEs7LpThkCCWdH1B6+HB0oWegCcKz1XTq0DkgRpu+QhpcALDVPgZsmElJbMFiNzDA7
         FlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724761003; x=1725365803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oEwWKAl5wGRDwroJblbu7pL64awe1nGTFISfN3cbkak=;
        b=JqTYgpcTNt+jeHpw8ePYKMarhY0eqjWM00KC9rwsund7T6z+iT/KopEBLm3U853YMN
         UmG0HEKvT2vZNyjcml0lxyrGeCtXrkVuUpFwQpWV06cjUDXLEh6mwxTTSAIS1ZEY8J+t
         yBmVio4ymfStj468uigh83kRsUwLmwoFG0JUEOZCmvMURK6kMIe8BnJbbD5AJsb3NP7H
         NYU+tnj6p6nJ7X8FqIIxtn7uvxv/oXpcHDYJbV/ncvx/xstCKxAp35xNdDs4hKno1Xmg
         oTCbIYZ3TMBbrN/44SzBQJSnTBLNdLsftSC+bp260QwUslRLCzcMZTs2zPmnwLQo6H/j
         fTnw==
X-Forwarded-Encrypted: i=1; AJvYcCVbI4AbdxcuyrZ4QiY2fKIQvrpYmo4J7HULi+9MOxXzpqa6tl49x9j8YjCpkqnmexhAs4egmeX8nxOjWmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9gW1ulua1mOSzceJATQtEnBnmHb7dzWTfut+sdfJbAwU+uHd3
	zYcrTfc6hHKoPmVYZ/EPlyz9vNeRMi9wua06zelJYjRsPdJi3ebNBe1wtpmTDKc=
X-Google-Smtp-Source: AGHT+IGI2jkuW2aZw6VxP7IpTsq60+7tPJdvBVRUUpM0SYoTCjpfgtxRq+29vHOWeEMfK0msqpZx+Q==
X-Received: by 2002:a05:6000:154f:b0:368:4c5:12ec with SMTP id ffacd0b85a97d-3731191d5c5mr5082598f8f.8.1724761002343;
        Tue, 27 Aug 2024 05:16:42 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730815b7e3sm12998658f8f.53.2024.08.27.05.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 05:16:41 -0700 (PDT)
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
Subject: [GIT PULL 1/3] samsung: drivers for v6.12
Date: Tue, 27 Aug 2024 14:16:33 +0200
Message-ID: <20240827121638.29707-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
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

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-6.12

for you to fetch changes up to 259f5082721f1d17b4e5b9dc2bb430821afd95aa:

  dt-bindings: media: s5p-mfc: Remove s5p-mfc.txt binding (2024-08-26 14:34:51 +0200)

----------------------------------------------------------------
Samsung SoC drivers for v6.12

1. Improve Samsung USI (Universal Serial Interface) DT binding,
2. Cleanup old Samsung MFC TXT binding.

----------------------------------------------------------------
Aakarsh Jain (1):
      dt-bindings: media: s5p-mfc: Remove s5p-mfc.txt binding

Krzysztof Kozlowski (1):
      dt-bindings: samsung: exynos-usi: add missing constraints

 Documentation/devicetree/bindings/media/s5p-mfc.txt       |  0
 .../devicetree/bindings/soc/samsung/exynos-usi.yaml       | 15 +++++++++------
 2 files changed, 9 insertions(+), 6 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/s5p-mfc.txt

