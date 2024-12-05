Return-Path: <linux-kernel+bounces-433835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9A49E5DB7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34B9B16809E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCDC218E98;
	Thu,  5 Dec 2024 17:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EXY5r2CL"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7F1227BAC
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 17:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733421236; cv=none; b=b9sicfqyx1DCegrfSrLvd27/x/m9tq/6P4qmL7xdqNvxeKax8rO3i9VmppVC7FKjMSyOZaZ1z3YTIak0vjapyd337P74M2mjr0GV3rVi8GrTdzbWhIbYAjIpAuqP3fkWXevxG2Q3/cVjRnc1ilCg7irR4qYhJPFyDK0gLmtNdng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733421236; c=relaxed/simple;
	bh=8/1zyw3Y2D1EAPmlvkuWT0eqZ0o1r4sI1K0ufpWK6b8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KA2TnS/OCY9gIBpRkl3+SECYQ/TzmAEDpv1IfZRCD2qlv1+P9Sre2fnwuL0nxyPLSWLTqHNMpulw/P/8PFVVk8r4XX0H71DQZCbBZRhRaZ3L92D3nlXq1wOnRFC8RRuadmLnn04IgcsMqeeCkRy8xw8Q7bWMtQwusbcnPdIAdt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EXY5r2CL; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385e35912f1so944752f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 09:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733421233; x=1734026033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUjYGZM8Wn9lXxLMeS6SbGdYzdUSKeJjfxwmycYz8PI=;
        b=EXY5r2CLXQ2400Juovm2sIS5YM2q+v5bT+JxqdUJx0ZQW4gJ3W1BG5IwC4ieLluKH0
         nbeyRW98UW3Zv2MV0E/iyulywftheXUqHhgqyqCeJT4Sq/RJ2EBQmOpjD1RroJ5PTqFZ
         nWbzqE05t4t9idBO+Y8jNB2o3W0+iuFJZoCKkOLCcI63zwtmdvndgZ1G5j3Q3m3Y3BEO
         aldsQfCfZ0bQizpdAxwRJxtKUm421adJ2GAVjMrMF7wLwUdpX0uP2a7d4Edp3peSFhqF
         6EqN5KEm5Qe1WbmfZwoJ/2gROl8uohueS9F1HSlvWa7AfGF8PKAcvrxBIBFOVgxXyesN
         i6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733421233; x=1734026033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUjYGZM8Wn9lXxLMeS6SbGdYzdUSKeJjfxwmycYz8PI=;
        b=AO79z5Oow0kdIBDv3IxxISP43OFSr5OOyWZ7KBCIpN7BAZB1xP2G8nd/lv4ZKKKSmu
         EjK8iQ5Qe9KzpXCZvyQX2NPsrh11OtFrp3nFTAMVy0nIrUYMxUEYBUUkT1DZR0NH23cS
         oykdqG7/rbEvczipI0NkTkLdwMAmrrTs8RRlk9X1FfP6z6ZIR7+3DhsLHBscNg8yzQqi
         kkhWkAK6bOBVkG+QU2DXol1vceFDzlAU3cxWXkAClHa+yApdXCHyP0FiaQiadQ1tBoHE
         m65Tyaa+IgmcfABV4UVUGzlAu06ea9bDFLmiYruD5WDADWlbiOPD3BkDNQ+KnHxWjlkv
         qgnw==
X-Gm-Message-State: AOJu0YynGZf1g/gfU/WuU2pmPeJrieDKTJstjetiZjS+5omgK6sOadRT
	m/FY31jnqAWk7dudbgcY6jCU5MtBROqtpAp8KYqO5bE7OitND3PoE7yONcPT/PU=
X-Gm-Gg: ASbGncs/a0C84CV23aN7zzOt1ScjG2kU+DjrrBzLVldekHDmHCbfcOz4TulzcBSheEP
	9HkSdi0EDSVytH+zj3Z5LvxdC52bAPDgcii1quPLqQjEAcunTPBvRm6ypfubJ9IVCz3WJTH68i5
	cNpA78Xr+pOkU3qlUPxVL1V8DaPQSBOaiNrQ574ViT4NPg7NXHqh5fdnx5Bi7ggi4rCSygmfydf
	7MnnHIH8Q0xIkBoLNSQrIjOVXQcqRnIVxDdE8NodhK2zzXDUxAPjYBTbc2d8ywoYVQXb9iRxi4R
	R8wki90DYt+fGsAaUnrRVWN6FDBFp41z
X-Google-Smtp-Source: AGHT+IGVQz+uq4dtBtqtBu1Y8X22ebMDa5YP2r6YCdjfCnpf2qvqcplq7ge2zv2BqYCM+IMoonQK5w==
X-Received: by 2002:a05:6000:188f:b0:385:fa3d:1988 with SMTP id ffacd0b85a97d-3862b33d273mr12625f8f.8.1733421233156;
        Thu, 05 Dec 2024 09:53:53 -0800 (PST)
Received: from ta2.c.googlers.com.com (32.134.38.34.bc.googleusercontent.com. [34.38.134.32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d5280fc4sm67882835e9.24.2024.12.05.09.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 09:53:50 -0800 (PST)
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
Subject: [PATCH v3 3/3] MAINTAINERS: add entry for the samsung exynos ACPM mailbox protocol
Date: Thu,  5 Dec 2024 17:53:45 +0000
Message-ID: <20241205175345.201595-4-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241205175345.201595-1-tudor.ambarus@linaro.org>
References: <20241205175345.201595-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add entry for the samsung exynos ACPM mailbox protocol.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e930c7a58b1..5cff01641f23 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3023,6 +3023,7 @@ F:	drivers/*/*s3c24*
 F:	drivers/*/*s3c64xx*
 F:	drivers/*/*s5pv210*
 F:	drivers/clocksource/samsung_pwm_timer.c
+F:	drivers/firmware/samsung/
 F:	drivers/memory/samsung/
 F:	drivers/pwm/pwm-samsung.c
 F:	drivers/soc/samsung/
@@ -20712,6 +20713,15 @@ F:	arch/arm64/boot/dts/exynos/exynos850*
 F:	drivers/clk/samsung/clk-exynos850.c
 F:	include/dt-bindings/clock/exynos850.h
 
+SAMSUNG EXYNOS ACPM MAILBOX PROTOCOL
+M:	Tudor Ambarus <tudor.ambarus@linaro.org>
+L:	linux-kernel@vger.kernel.org
+L:	linux-samsung-soc@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/firmware/samsung,exynos-acpm-ipc.yaml
+F:	drivers/firmware/samsung/exynos-acpm*
+F:	include/linux/soc/samsung/exynos-acpm-protocol.h
+
 SAMSUNG EXYNOS PSEUDO RANDOM NUMBER GENERATOR (RNG) DRIVER
 M:	Krzysztof Kozlowski <krzk@kernel.org>
 L:	linux-crypto@vger.kernel.org
-- 
2.47.0.338.g60cca15819-goog


