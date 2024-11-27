Return-Path: <linux-kernel+bounces-423368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19099DA6A4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 254E4B2AD90
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FF61EE00A;
	Wed, 27 Nov 2024 11:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jlVqIjaI"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489301EBFF4
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 11:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732705303; cv=none; b=PIVbbIz1+HKKpa7/Zogn1ZWj5vUifN2kuYeeo2jWpIKX/dbFeRACLYfagxJcc7DJh7eGoGXGpAT2kLw8KibxIYLyoZ835UUy/JU4daPGoDBIT4icXdU/huvm8+C6KTBTVXsFz9egcclvoGr/a8872oOKEF/VIUsd1jNt5h6RgKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732705303; c=relaxed/simple;
	bh=lozZ7p/MhDuRt6nX+BtkrwBuJHf1C84dqV892qIj6RI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aSCSvAQBjSQOuk/zIB7VNaoOEcH+r4I2CaCeM1E7E7LQZPKUmrnzTAsxDt7vFiINaOpqrOa441xBwJfgnfO00Ubb6uyIOzwIIeQ+Xutrn3CnhMBZKK8MWc+7FB6x6pwr91SpDDRsX8U/SROg+r3OtNd9VpLCy29W1u6MVjj9K4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jlVqIjaI; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa1e6ecd353so442508466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 03:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732705301; x=1733310101; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VB/ikfiNeJLME2Jkz2PKwShANoRD6KN3KhS7opfVViA=;
        b=jlVqIjaIdGwz+w9ViTUCIOrQYfZcRdmM+eCcGyQsn/32+a4NfONrvtQvuxtm0b0RR1
         pK2ezWO53I2ZBg1v31KUlH3PunVEFYyk9uqIjT6+mZ0mJRlKiGlsQ5G6AUJ267uU4N+f
         6lrsEI+QEWEPpFLhPlkEiSA6R/vzVzqhSbSgl7iSlFkEYEmkwT6u9pguqVk9/LIN+yjj
         jVrAd7XAppBxCBY1z2Ctfod9gX7bAXy9H+gYRhhc+YqZh4fRPx4ego6sYGwQRgRoAv6E
         LH9Wwx5BeXti8rhJTdFYKAOO3MBU04ryyOtil320/PXelKyB2W4fdXb6oeWZscrsEJ1a
         mQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732705301; x=1733310101;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VB/ikfiNeJLME2Jkz2PKwShANoRD6KN3KhS7opfVViA=;
        b=JQ73uDj4g38SoVL/+YQEGv/iHkrK2SHAhchBPOYbTos+S6BaGRN55KwyLgXwA0NuAt
         BErq6PBVfrnXBECMdG9uOnu7wgD5TRUmw1vAt3lemxE1rhQNWvO3gHsXtm5kg2Y+WV7m
         nxhwajdE9FJgJRzV+GqmkK9i1K5GH8O/Skgukhc0fUWxr1HqU0CEJJTPiI7H1hWIYYxW
         CFMHq6tVbi1YBAu6ybLjVdncr7K1R/xxGL7lO+6mUys3+uotH5EHLRndIIN9W/iKTUu9
         0hAioVAzg4nRNaTfzOGCIsCtuZHOdAOvsbgIX+D3f2bIAk5AZn5e6o7rRUWBnn228U8Z
         pUdg==
X-Forwarded-Encrypted: i=1; AJvYcCXxQ1sBCHbYuaKlrJs7D9w28gzod/7aacKz9VKc/u9Lj49QMUCzdeYG3l4fVX4Ox/kh+b4K7Pdr3HRaELw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBjEyN/QkbUgFyPSRnCQuVY8KDEWz4HigXxUt3ph+5Ct3KjE/R
	9Qp1b7KzsF0VqHm2l24tvMonHAELscF1kH/mJKGSADrc6vXcgDcMOEJMFTBMJCA=
X-Gm-Gg: ASbGncs3OyJn0T5WKNqZN/6/oJzK1SgWn7+XumIc5C8BLMCh/H/Kp/wVoqeptZZXdgu
	kZUZcVeDWRxgYxr3QEUQ1waznjULnZsRuLnaTxc8437QsGbAKFSyTjarA8q70fFgul2+Qjd/xkP
	GzQ2y5eAmdaEDAylkWINrTIVHmhbcq+YroX7W+adCVWwfmgwXnAmSiZzvKcz+mhO+ePcDi1bjZM
	H82YExZnKb5X2gdzQ+v6Oy4fWW6hcNJyEJg0/CgcGNyuBqOWhG/IYj2CqwqbAU6m46ARhN5kEQA
	Eropa97M5qeq0qxDpO82mEJp3z85tRMq1Q==
X-Google-Smtp-Source: AGHT+IFomp5IYrPwtodVx4NfkTQ1BU4IT3aD00OknD9fip4RuVHiqXSHZTCSxH7nkJmeEnB3wrFv4A==
X-Received: by 2002:a05:6402:1d55:b0:5d0:88ea:6560 with SMTP id 4fb4d7f45d1cf-5d088ea65a4mr876701a12.31.1732705300646;
        Wed, 27 Nov 2024 03:01:40 -0800 (PST)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b339612sm693762966b.84.2024.11.27.03.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 03:01:40 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 27 Nov 2024 11:01:39 +0000
Subject: [PATCH 1/6] arm64: defconfig: enable Maxim TCPCI driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241127-gs101-phy-lanes-orientation-dts-v1-1-5222d8508b71@linaro.org>
References: <20241127-gs101-phy-lanes-orientation-dts-v1-0-5222d8508b71@linaro.org>
In-Reply-To: <20241127-gs101-phy-lanes-orientation-dts-v1-0-5222d8508b71@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jagan Sridharan <badhri@google.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>, 
 kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

Enable the Maxim max33359 as this is used by the gs101-oriole (Google
Pixel 6) board.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d13218d0c30f..5080fe2ce776 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1121,6 +1121,7 @@ CONFIG_USB_MASS_STORAGE=m
 CONFIG_TYPEC=m
 CONFIG_TYPEC_TCPM=m
 CONFIG_TYPEC_TCPCI=m
+CONFIG_TYPEC_TCPCI_MAXIM=m
 CONFIG_TYPEC_FUSB302=m
 CONFIG_TYPEC_QCOM_PMIC=m
 CONFIG_TYPEC_UCSI=m

-- 
2.47.0.338.g60cca15819-goog


