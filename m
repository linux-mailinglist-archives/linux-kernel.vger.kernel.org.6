Return-Path: <linux-kernel+bounces-223672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 859E0911694
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 01:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D00C1F237AF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 23:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10172152790;
	Thu, 20 Jun 2024 23:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KbGzKlsu"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D79A1514E8
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 23:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718925227; cv=none; b=IDktGv9b8l8ELGIZrShMVEdrRrtWjB7v9ew6Fsta/CsadmBOe7GWD1YIXKPHDERb8xFF350X0hvDYjV6pPxcwQZLXd+sqDJnmGvF39+B3jlZU1yvNvAw/GHfgNtl/l6F1Mm5JtclJ8MaLOeHqJUWqM8lcy+3G926erTe+iLplRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718925227; c=relaxed/simple;
	bh=OnEU/sDI6L4n4GuKABhOjlofl7NLYJUjjb44iomKIdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BVEwHZeM4sJxaRzOks3cATpmPYhBlCAIaiP+58gZJuOS+fN0RncHXsBpoQeMQkReY0dIlzGqqK1tL5lRot2mBWA47ICXB560Jc/NV0GFqc7L5s+2ipsyxYajkL0qG/0TSGYe7NoyhCeQt3YWqQV64KRM4Di8pGJOk5K3aOgzMt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KbGzKlsu; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d229baccc4so773557b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 16:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718925224; x=1719530024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zz8ynrGU4z42Aj9sdj4ptAZtRt0FzTqPDvedxGwGE2Y=;
        b=KbGzKlsuFU1MfOfM+Ae5/YotqltjV0hy5HkjLHV/b5SHJ6gHDkITlmrmHo0NkylSKw
         5uJWeA0epi6Ym+UhRcXiV/fEgsTTJnrwrJz/3/pEMBPKK9C9Ir1YVHoaP7lDO/OSG8i1
         /1w98jnfKtR4buUC2EU9haxz2CGUKjqBT1JQa17PpWNZ7AnAttujMQpukXYOC6Rbxuz+
         bi2EbPqojfU1LJ2613JCd/DkZOZ/A3aw6faqLgE54g6gdW6E4LOe1lZo9kJwupOau6Hd
         gH5C2VCe3Kt9wdoG7M90nMBr1EHIKQ5DEm/7Xe6Fb1ZYk+ZCmhTt2vLzqpx3J2q47veK
         P1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718925224; x=1719530024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zz8ynrGU4z42Aj9sdj4ptAZtRt0FzTqPDvedxGwGE2Y=;
        b=eTxL0EtGMxuETHZ7vvbEy4gCy7NuG7rEJ/Udn/KckDe1DP4IkwG5hSSREa7O0EGXvR
         IIcmia/w2H4QKZxNnb7P/jEeobA1h011mSTXPUO7S0uCKbq2tpB3g7nZ81feHm+6slfQ
         T+Ndwe3d9xHEoBGgU3INYIeywW6e+x7EHS8a9IC5S8a1uHHZqbU+KL0x72TBq8vr3W06
         Gx48NsY3ApPZC/ulqnKa0WptiBAuEKhl5lCpYf/0y+8n6ZHQJxYYy1o4Y9v4/1j6oGO7
         aYAcYDWR5sS9o5kL6qS/WjB0n8rbZVSxHz27kT79LBp9To/2YWbPFnlzXfSBUmqnnLZk
         2bYw==
X-Forwarded-Encrypted: i=1; AJvYcCUdB2N9xURp58oMHtG7+p4ZlZUTFAgY+is1P+Qn7TJg/H4GPu4kD+qI3FEWmzqDvMzSkiaPVYfdJ4LE7WkogWoyWfIPVvVbU45I2Xw6
X-Gm-Message-State: AOJu0YyGdwp5ANg1jEYIv9cHIJ+asd1UceYgFrK5pzN2kOYkj+pMQfdG
	8uOuCMGPCjy1z2wH8iBy+Vk4hSmMIK89/xpV1QyEoIuYRbgoPezJHbT8rX+ebgDUqg231713+VI
	A
X-Google-Smtp-Source: AGHT+IGMxuLpMKjIuYdJYrob79SDg2RZvql0ouDIgVaa+eFVMNZbWP3rPhPLCBOfG/l5X2eomxjBsA==
X-Received: by 2002:a05:6808:300f:b0:3d2:2b8e:a7e2 with SMTP id 5614622812f47-3d51baf503fmr6570385b6e.48.1718925224517;
        Thu, 20 Jun 2024 16:13:44 -0700 (PDT)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d5344de45bsm86185b6e.3.2024.06.20.16.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 16:13:44 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Anand Moon <linux.amoon@gmail.com>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-samsung-soc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] hwrng: exynos: Enable Exynos850 support
Date: Thu, 20 Jun 2024 18:13:39 -0500
Message-Id: <20240620231339.1574-7-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240620231339.1574-1-semen.protsenko@linaro.org>
References: <20240620231339.1574-1-semen.protsenko@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add Exynos850 compatible and its driver data. It's only possible to
access TRNG block via SMC calls in Exynos850, so specify that fact using
EXYNOS_SMC flag in the driver data.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
Changes in v3:
  - Added R-b tag from Krzysztof
  - Added A-b tag from Łukasz

Changes in v2:
  - Changed QUIRK_SMC to EXYNOS_SMC to reflect the name change in the
    previous patch

 drivers/char/hw_random/exynos-trng.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/char/hw_random/exynos-trng.c b/drivers/char/hw_random/exynos-trng.c
index 9fa30583cc86..9f039fddaee3 100644
--- a/drivers/char/hw_random/exynos-trng.c
+++ b/drivers/char/hw_random/exynos-trng.c
@@ -320,6 +320,9 @@ static DEFINE_SIMPLE_DEV_PM_OPS(exynos_trng_pm_ops, exynos_trng_suspend,
 static const struct of_device_id exynos_trng_dt_match[] = {
 	{
 		.compatible = "samsung,exynos5250-trng",
+	}, {
+		.compatible = "samsung,exynos850-trng",
+		.data = (void *)EXYNOS_SMC,
 	},
 	{ },
 };
-- 
2.39.2


