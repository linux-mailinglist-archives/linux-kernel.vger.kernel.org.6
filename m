Return-Path: <linux-kernel+bounces-286702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 756D6951DFD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7A361C21BE4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C651B3F1F;
	Wed, 14 Aug 2024 15:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H5N63MMX"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE551B3745
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 15:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723647860; cv=none; b=pwWCQyLkB4MXP93pg1PjaiC1HYezjhC/4TOtdVcFbnr1Bb7L2/CpztH4Eb19CWLHFY6KGsnfPD3krxNZRBJIHvVwiKZt+flDLjLXkW07zGj1Hvfy2RlvRtFwuxrxH1h6OM5ea0kgbKkHuYRFaaDLLeJ+p1t9niEj7SEi7291Tao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723647860; c=relaxed/simple;
	bh=iH0p1V4eqat+M+Ev3ANGFPe7vqJ4jJ5CZXeTzvo7Cdg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tEM+CNgPYpLP4B4IdcDOXw7usdp/KKJW5/YqVA5zX6LWq1lSH+B5fGUbD76j6AjnLSkUrf9kH0731BYxx1fzFhbs0jhlayOeHQMcVLSIO1mo63+dNbqL6c1z7bYpcFV26zhdyMzrKI8eo1KuY0EkPgqD2tqvEvS2bv4FWokQEas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H5N63MMX; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-428141be2ddso49802675e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723647856; x=1724252656; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9XvQrRhyjQYZnQbMs3EjboskCKHEKhPSKVqnPioFGZ4=;
        b=H5N63MMXysNxuQII24p1ekBVXN5EGMX5OKt3hrNtOcoI0rgAa7MiOB+J85rWk1tYrV
         6rkvXHDLoOpP24TZ96Dugk66FJl4EjCSwtTGFHW6EEeSNlM0EYxaj+Swy800rNDIIFf9
         3bf5IQ4KdIuTG+4PJdTaVW2dF6Q4h64N1rWGoBG6JO4sDF2rojkEGUtpWB8sqCHwL/yB
         EC6GlySnNLiYuQ+rstGx9azYDkmysc4+vSQxloh/HQsrHjSvQon4aXVCHGcl4pUZrT0Z
         8yeft0Epsy/CpdXrcroqtwnX85V2mbN5YIjO5/dx7rHoVbacjr+rwXvPFppGTbEI3Ook
         916w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723647856; x=1724252656;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9XvQrRhyjQYZnQbMs3EjboskCKHEKhPSKVqnPioFGZ4=;
        b=gMn0VF0+wOIvU+8FVtngQxhVo4JR3J0zmQ1ZS5nZyziAsXXRhFzCkb+Gj72H+Xdwm1
         AwChJYOk4zSBl2VR0H5tc9bee3GJQ+7WHFke6ePyzY9TcoaLiQwvLrWfmFXw3XD4NQlu
         3OUxep2lRiPz6WnICUG3+55VQAILDVSXoM2N0VQCs8UVxsEiFpa+XCFVPNSq7b6TYxVH
         TAg6e2VJy1aOmZB8rtlO7PBIflQJb6XGWg8qMYRz7vago0ytfsvkRDnNtXWWR4w464K3
         Wc+yxbSEahFXbtF8hBdMAWT7AO73ZGFG1BQJBbV8O9y8ijtaL7JGAJeTrS0I233Nx7xs
         qZ6g==
X-Gm-Message-State: AOJu0Yy1HjaB/ktNYJ/owcU5Lg/DPl6FQsFTur/XazYdSlLKEoFf0zCY
	xzpRj1Uq6DqeNCCd4wqcTsiI4Cua2AsMe5UP5I+/kl562rY0qpbnXqpHSdtiJpxSNeMYzkS5hcn
	F
X-Google-Smtp-Source: AGHT+IHmH/lZvjGcJ8hd1XXOkhepYdrTq38ZINMbfl6cgbN+vgIZhEXaS4U/b6MJaA+KEgX05jhvHQ==
X-Received: by 2002:a05:600c:1f96:b0:426:6308:e2f0 with SMTP id 5b1f17b1804b1-429dd25f8f2mr20826075e9.26.1723647856256;
        Wed, 14 Aug 2024 08:04:16 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded7cfbasm22313425e9.45.2024.08.14.08.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 08:04:15 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/7] regulator: Use scoped device node handling to simplify
 error paths
Date: Wed, 14 Aug 2024 17:04:04 +0200
Message-Id: <20240814-cleanup-h-of-node-put-regulator-v1-0-87151088b883@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGTHvGYC/x2NWwqAIBAArxL73YK9QLpK9CG51kKorBmBdPekz
 4FhpkAiYUowNwWEbk4cfIWubWA7jN8J2VaGXvWj0t2I20nG54gHBoc+WMKYLxTa82muIKiVddX
 UgxsmqJUo5Pj5D8v6vh9oAOq5cQAAAA==
To: Matti Vaittinen <mazziesaccount@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, arm-scmi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1380;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=iH0p1V4eqat+M+Ev3ANGFPe7vqJ4jJ5CZXeTzvo7Cdg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmvMdmd+tmcteMBql83WlVuhACQS93WzBw8oMPj
 AV6xtrkFf2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZrzHZgAKCRDBN2bmhouD
 19bKD/93motsO9ftIadx261e7kNMivGz4JoHeOh1m5TRM7Kk6m2sJE4pXZaOgkXsJik6Et7Mvqd
 AZKA7lclS4PrvpzTrvDVPcEIv9Y7vgKxlnvLV1oQp2SCplhK0dn0PIbS760UMl5gYv/TvNCKJUe
 O6qbI6MF9qwoz46qgn47zFpPPV/muo0s8I1qB4IBENZLcRF390zBtn6WjoyRSrMJp7h/DT3aM5y
 0hbqZCCtooU5IUPtLkRMPdSmgVhGTXzKfOoczB8oLsz7yrXW9ULE4e7rIr/PwCBsSG6WjQ7kgjV
 /V969nWY2hikvDHOv0hLD2RikD/HJU2umVC7z33f/SDy5XlgmnnrsXEscpSFzCo5LYFf8Qe1job
 v+RVCRExOdKbzAXiTNSHV/MZvKXoU24q3WxKT48raQlIvAaOX17J9u1dhptMjPeLlOuFqeb9hbd
 aGSg1+pkfVLP2d10TNhfFQFJ45KPV2DO4xj6ZXtRU7w9urnXFEcjWSgI64Tq94KhDdbqI2lEOTL
 /8+sMrdz6drAVAqYe/kIrh1LL51aZFtnYzU+qlgC0Z6/mlfncaBfiu+wgVnob4ae59v98IPm9xa
 fvoHAh6/EfiZ2cfLC1dhp7BKY9HzIse8L7Ia4UmDQz301tRpQbTAOmGvLcGTquOqoO4WrDHcfJw
 Qx63gwZEjZZsuwg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Hi,

Make code a bit smaller/simpler, with less of_node_put() thanks to
cleanup.h.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (7):
      regulator: bd718x7: Use scoped device node handling to simplify error paths
      regulator: bd96801: Use scoped device node handling to simplify error paths
      regulator: max8997: Use scoped device node handling to simplify error paths
      regulator: s5m8767: Use scoped device node handling to simplify error paths
      regulator: qcom-rpmh: Simplify with scoped for each OF child loop
      regulator: qcom-smd: Simplify with scoped for each OF child loop
      regulator: scmi: Simplify with scoped for each OF child loop

 drivers/regulator/bd718x7-regulator.c   | 19 ++++++-------------
 drivers/regulator/bd96801-regulator.c   | 17 ++++++-----------
 drivers/regulator/max8997-regulator.c   | 11 +++++------
 drivers/regulator/qcom-rpmh-regulator.c | 11 +++--------
 drivers/regulator/qcom_smd-regulator.c  | 11 +++--------
 drivers/regulator/s5m8767.c             | 17 ++++++-----------
 drivers/regulator/scmi-regulator.c      |  8 +++-----
 7 files changed, 32 insertions(+), 62 deletions(-)
---
base-commit: 7b3754ef5d53bb1431e25f65126280993c2e640b
change-id: 20240814-cleanup-h-of-node-put-regulator-80df40883f35

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


