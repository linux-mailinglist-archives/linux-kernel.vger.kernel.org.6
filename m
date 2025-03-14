Return-Path: <linux-kernel+bounces-561710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77105A6151B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B91173B852E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6BB20299A;
	Fri, 14 Mar 2025 15:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sU+XJX8y"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC2C78F24
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 15:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741966699; cv=none; b=EdDSilDxv9XbsNLaMF1a6EEnLi7bJcBZiLKZ1PJ5A/RO5Wlmn5nTRJDrSZGp2t5lXrgkYEFOXNk05XQvYhTZ0viMaJL0FhDWubDz8Vqc4bV5N6BsnBBvgodApFNk25kAFxVAOxzSSPaY5sTT20/sKEPFfdBHOcmGRH7wGhJe6AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741966699; c=relaxed/simple;
	bh=o5lWvEifxc0qjQ0Mf/yS+nQ6Yi9AnPndoKFhVA2M9Yw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MihnVEi8TxEneMIpWaAgD0OaI/RUxmVbT3gPClgx75RjhfqOz7QuGpwfn6SKx1UI4YPDmsyrZOQWYKlxFVEX44NbfuPy9ynNt61ArM3I+Irghs82O54wdltg8GVPucL2Ekvr4WET93R+C8vQ45R+LNhc4205lUWP9pWdYHChnhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sU+XJX8y; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39149bccb69so2029669f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741966695; x=1742571495; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rRs3uWiyY/mmy9tnZPMQQhl+KBtI48hCPbm64UgfZtU=;
        b=sU+XJX8y1OoRuisxvMZTDkl32849hc4q4EoUDxJZUcI0X3Q+EvJCN1cRjRushyEI7i
         sL+c6ZGrM0E1QWHIzqPvIYa3+Fa4TsxEfjbkDiDEfK+fVaFSyoNbZh74vb145KaEfmCP
         VzSjcUJaOWWURnMrg7QY20xdgnf0ARCMuc4xEXq+EssuQYyGpkNoBcOlQxFY6sbHIsie
         8auNDZF08eNULAcqj08hPfCXuAIp7o/jVz4bgMdi1k+1Ioi6LbQ6eT8CZvM/HNFWuDGl
         GmynQa9Va8V2R8yTjYXhf8AjlVK76L212Gv2lyFn1zztgBNWDV+TeMkXjjfh28S/Pm1e
         knZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741966695; x=1742571495;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRs3uWiyY/mmy9tnZPMQQhl+KBtI48hCPbm64UgfZtU=;
        b=IIjJBMHrI4Jeey3KgmiA18Ozj8Gx3ZfqP1vn4ou1G9jnaoX8CkvLSJON1qfGLEfbvM
         xTGAIVTmPlNBSpeWWd5zHACTd8npnMbn1B5l5oaMQysL1yRd8GPSlzhchX4IJB6qIH86
         STLM05yb8YK9/xhQdFe0yDey5xqDAyY+4SuTySQhCwfsNMqnWFx+Ozw5lsWATENvCfel
         7lnaqcaDiwnugHoX2wizecdKg41xWqnAgb5sg/l7MlUQrNiFKXPsKN/QtzzOjG3uol7S
         D/2JYapNQquuety0sMN14C5J0XKIGbbMzXgZIif7VJlFdj14l/2kB6y3Lxo84/DXTQe7
         m+og==
X-Forwarded-Encrypted: i=1; AJvYcCU7Rvp4yd1ld16Y8fqL8+Gz9RY5K2qve6l3tdsXqIO33HoLAZguuGpOWLJjw6AbJlR7ZeulDn5ZEH1PI5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNRJxVaIVcNcqgAk03iyzPPmOOyJxSKKPJg3II8wWmIzlBRg+7
	M/7m60eBjA1PI0ojwsNcBacaF/3dKUdr/cnUL7IlFvdY2tR50WMoiJ0j9to5XKg=
X-Gm-Gg: ASbGncsL/Wusa+egV4hRS+74TWxV2uH18nj9+ndkx4/vZukLnwJtDjJEJ3Vh/UEqG/S
	jtkmaMF6SQUtouou+mSO3RImmk4f71xOSlokmuyka3N+lvwEvqXy1oFyak92gAl7NRCFMKAUkc0
	YE37yxUyoaos4P04y7LZIEBxlx82tnpjH15jKFBAsb8aFncv+3dGgb2qEucz61+1Ls8dz0Jjeqx
	AL8Tynum9yDGW6DncQM9ganOejodVWo/Nr+k9IlTHUeXVNoN4RBO6nNzMCr3ZrM1TmY4hdIJO97
	eZqeW+L6ntkQbQoaumkddSJbNqZnHriKC1wzBNb6L6GVz67nRah03aC/YxgvcToLwKeoaH0Oq9p
	R+8+Ok+tqtH8=
X-Google-Smtp-Source: AGHT+IFwuWplOyRsVTnwWP9hDzjpPB2Fz832AbMy5akm4Qo/B37yxprGTMiWIsI8eBrUb37930ldcw==
X-Received: by 2002:a05:6000:1a85:b0:390:f902:f961 with SMTP id ffacd0b85a97d-3971ef3a523mr3576489f8f.45.1741966695091;
        Fri, 14 Mar 2025 08:38:15 -0700 (PDT)
Received: from gpeter-l.roam.corp.google.com ([209.198.129.214])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cdafsm5944388f8f.62.2025.03.14.08.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 08:38:14 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH 0/2] Add dma-coherent for gs101 UFS dt node
Date: Fri, 14 Mar 2025 15:38:01 +0000
Message-Id: <20250314-ufs-dma-coherent-v1-0-bdf9f9be2919@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFlN1GcC/x3MTQqAIBBA4avErBsws9+rRAvRsWaRhVYE0t2Tl
 t/ivQSRAlOEsUgQ6ObIu8+oygLMqv1CyDYbpJCNqCuFl4toN41mXymQP3HohZOq7dpBWMjZEcj
 x8y+n+X0/4DkMHmIAAAA=
X-Change-ID: 20250314-ufs-dma-coherent-980f2467690d
To: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-scsi@vger.kernel.org, kernel-team@android.com, 
 willmcvicker@google.com, Peter Griffin <peter.griffin@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1819;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=o5lWvEifxc0qjQ0Mf/yS+nQ6Yi9AnPndoKFhVA2M9Yw=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBn1E1kE5cKvQLvj5p+5qVAv9trKYfZ8ei16ff+B
 z9YeJd+wl+JAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCZ9RNZAAKCRDO6LjWAjRy
 uq9UD/47wDnkd+uHDPcz0khALhZQzKJVJn2IE2m2IexznRG9WHqTq0nvONALdAhgP6iOR95GzTk
 buhR+wkbwEMJCLy4Xu21/WQFe08H40eZtljBwKUa6pKYaMUyLWqk2D+J5tEE5Z5qeaHSFvgfl0I
 /VXX1NW+3uOnew10YZk1QuVJ7UtmIdESlUCL3VhcrMgi1IZR8BWB6e6MZ/ekOnsIwCX9nMUD5wk
 t6lBCkuDGVaXdkIbsQDsu541pAokWIm+96oMohVbZ3EU0BtGZk4CbKfauP73p3POtRatLI8qbUN
 vuKpMwVWaAZ2vtA07o9GDE9XnhBqsR9Aj2KeHcLapVHRZEAQW+FCEu1zbtDzN/l2YJ1UM1avBGp
 ANxs0cjpKjmpJXStyNKEOODbUwJgvHqrzIEAxGZz/nPP4+KqHcYutR4b3nkRgmv2Cr7BoZk1xF1
 XDyOJ3URvPRl66sqSx3fgQ8bMsH+gfSipoq2O09wr1ePpX+xU2aKTRkTh4TralInxmN0xDOyPUy
 M3sTmxXKXmvLZSkWGgC1+t9YmrGE0BhwlLRP7ZFZHYRT4FDGgeaPn4/N32S5YfddBHVxsHZHx+B
 lF84ISrushp9Fktak/z0TwJ6y//hZwsKDARvxSYb8LkhQ6VKF44q7NTSlMwJegIs9ZxjVHwKF1M
 hDyrOsEFbKuKWjw==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

ufs-exynos driver enables the shareability option for gs101 which
means the descriptors need to be allocated as cacheable.

Fix the DT node and update bindings to add the dma-coherent property.

This fixes the UFS stability issues we have seen with the upstream
UFS driver.

Note this DT fix can go in independently of the other UFS fixes series
I sent recently [1], as the bootloader already leaves the sharability
bits enabled.

regards,

Peter

[1] https://lore.kernel.org/linux-scsi/20250226220414.343659-1-peter.griffin@linaro.org/

To: André Draszik <andre.draszik@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Alim Akhtar <alim.akhtar@samsung.com>
To: Avri Altman <avri.altman@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
To: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Cc: kernel-team@android.com
Cc: willmcvicker@google.com

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
Peter Griffin (2):
      arm64: dts: exynos: gs101: ufs: add dma-coherent property
      scsi: ufs: dt-bindings: exynos: add dma-coherent property for gs101

 Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml | 2 ++
 arch/arm64/boot/dts/exynos/google/gs101.dtsi                  | 1 +
 2 files changed, 3 insertions(+)
---
base-commit: b323d8e7bc03d27dec646bfdccb7d1a92411f189
change-id: 20250314-ufs-dma-coherent-980f2467690d

Best regards,
-- 
Peter Griffin <peter.griffin@linaro.org>


