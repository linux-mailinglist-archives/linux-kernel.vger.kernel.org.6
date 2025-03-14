Return-Path: <linux-kernel+bounces-561804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC4AA61677
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32DE461C07
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2DC203711;
	Fri, 14 Mar 2025 16:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yEk4w/wW"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0568156C79
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741970406; cv=none; b=n8QQ1V50rI4unGCs+7/03vPW971ydnfqQOHYWG+P1S2RpHGZOeBFcJ/2npS2PaOGa4/Sx8WGvXnxz9GhPvg6Hat4Ub6TLRtzc/DY+ZYFImzyScRPOu9bvf7JorECmfmFvhKafgiI63d7dYX1UL1IpyPQeAjxjTZ4MiNODuibR4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741970406; c=relaxed/simple;
	bh=VajMfayeKQOz3VOYSjkIp/5rQbCz+OcLxQOVHfXWSdc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MVMLbPZkUJN9KmEaCMA+nunHNwtnd/ErBhWnsxYLFNzwHQyCkwBBHpOpULq32UhX7r8+F0su/vp2MiB3/64Y8OUaP9p3vZT1yWXGSdLzSvSi7gW8fXDU7lrMkohzJRq7KKpImKgRDy3XN6L/n7vv27lt+hAmOgiI/IeGgBFIFjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yEk4w/wW; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e61da95244so4025296a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741970403; x=1742575203; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KhvzLiY857SGZEqzmins+PvzyIr/NTQcyLXE/tMCnFQ=;
        b=yEk4w/wWrrsAK0EdJyl66u1ASaF8V83cVATbkJ3lE4t5ihOkDvYuCqdNZHnWoRB8SA
         7kCu/4ePthXgdaa6nCe4IQN5TPxSTz/3/DQvI8U4eQW8mUKUCCpJcFeKogfHbDvw4KAQ
         EYik9M/CxhaKeoGpS3OdpTAhIbcIHeKh6LzagYcRWUE/r74xiAhniPw27IqlTcI/KqGo
         CKGe11yCTYb+z8KtdUz+zrx18n8nJSfRZfBf8CSEfcn4TmRPReuu1ltMJvguEA3UPLqW
         cLUlS1ctxERXRjbT9s//+tnDlGZqZZrU5LUKuznZmXYX1UmWoZZMsmzjIAEaZ+oDsIbW
         Nclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741970403; x=1742575203;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KhvzLiY857SGZEqzmins+PvzyIr/NTQcyLXE/tMCnFQ=;
        b=H1PjWrDqlwKw2weLSqrABDTXmL2MhxY7vZuovfjkrHaxKouYD3gCZucrH6tmTFqrX2
         mvMpm2D+8y6RUo+Oyo51W6e6CJbFrMRwOPoREF9ikMtjXaawOpuXNqZZNeqLMRECvkVM
         aMQRkTSi21a1NONuuD6Nf6kx9l/JbQ+3Jw3uAodYmKiP8PtAf+9JxNEajDWBk3CY0f2f
         fkpIJ9lJw8Exqqb6hoPeC6XBDUlcIPj6h4+D9iD7RD2pd2PtiIXtZtO23gFcLpzhYlG3
         AYtxY9F8vZeA+Dzt6wBdBDvKTeNZ5wMxKtwS+RutHSJsm6BmTgKfZlVw7HkNP8RioWR7
         LohQ==
X-Forwarded-Encrypted: i=1; AJvYcCUERzYu48pysIT2yBj5uT7kkMtlEO50d7DxEgYVD+daXoV8BA/PSSBQrz5NVS5ZF5o2N4JDnWKkQ3jUwtI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4BZZzM2zoshdagS3ZPTo4s3+gOyTG/Zj8Q/qI5xNSi5Xk+1c3
	qpcFnlCY1CAsDSbLDuTFP0KYb6JXE4gyYGB//nwWBPgYF1IdIg7KBpvH8O4U3hM=
X-Gm-Gg: ASbGnctcCMmtkbWbb7jZisY97swLDW/+oBZagM/drtI4Cs/v7gao8IflD480dLpiSPy
	0q9RxIrnAGVDx4YtsSc7lVSF316CqoEMI3Oot+PW9zsZIffQDPawKrtbOT3T1Yl2+yEfYKamGne
	xvKWwNK+O9Lm9i+4VgDlZ6hx6/byNSQ4/i9c4BJ5LJRkKR/2lIPShdZmLIuyz91wFa26Ofvdr+d
	LcvfgbFfGUiLnm3VXvTU54+gWsFc8Hq6wfcGkmP7ZKIBx1B49wl0i4Mg/oyuvViinvSsagNu2lG
	p1bIHQHI0vTzmGHglQcm4iM057jjDaTJ4thI/9OV6RxxOOmjC6EUWo0YAwvPs2XuLfESoxXCrua
	a4zMITN32x2r0AsHkOTl8cH4wpDnn
X-Google-Smtp-Source: AGHT+IFGfvz33USapJBinW272gepivtVA3O/20eKJ/+H17ddACPCm8qjeCgFc9bP4W9ixUKFcXUt8A==
X-Received: by 2002:a05:6402:4301:b0:5e5:bcd6:4ad8 with SMTP id 4fb4d7f45d1cf-5e89f24c63fmr3817601a12.9.1741970402855;
        Fri, 14 Mar 2025 09:40:02 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816968cd8sm2115727a12.18.2025.03.14.09.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 09:40:02 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH 0/3] firmware: exynos-acpm: read fix & reduce log verbosity
Date: Fri, 14 Mar 2025 16:40:00 +0000
Message-Id: <20250314-acpm-fixes-v1-0-ab03ca8e723f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOBb1GcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDY0MT3cTkglzdtMyK1GJdYxOLZANTCxNzs0RzJaCGgqJUsARQfXRsbS0
 AgKKOcFwAAAA=
X-Change-ID: 20250314-acpm-fixes-348c058476a7
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

While trying to use the ACPM driver, I stubmbled across two issues:

    * acpm_pmic_bulk_read() doesn't return the correct register values
    * superfluous log messages during boot

The patches attached are the result and hopefully self-explanatory.

This driver only exists in linux-next at the moment.

Cheers,
Andre'

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
André Draszik (3):
      firmware: exynos-acpm: fix reading longer results
      firmware: exynos-acpm: silence EPROBE_DEFER error on boot
      firmware: exynos-acpm: convert to dev_err_probe() in client API

 drivers/firmware/samsung/exynos-acpm-pmic.c | 16 ++++++++--------
 drivers/firmware/samsung/exynos-acpm.c      | 13 ++++++-------
 2 files changed, 14 insertions(+), 15 deletions(-)
---
base-commit: 0226d0ce98a477937ed295fb7df4cc30b46fc304
change-id: 20250314-acpm-fixes-348c058476a7

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


