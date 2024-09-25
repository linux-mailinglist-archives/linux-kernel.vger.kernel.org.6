Return-Path: <linux-kernel+bounces-339573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09342986726
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 21:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8BBD1F22761
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3201459FA;
	Wed, 25 Sep 2024 19:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="grVfBDWT"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4822F143871
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 19:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727293768; cv=none; b=E6AavJ4AmCTrzE0Wkiu/+15AQ/owOKERXRYx4sGn8OD6SxVtdMcu4cLZpuPwhYfbCPp4qi+R/UoQ9WsuW+UiapUz9QspoqxoI3Qq7175j1v7HbVuc6cHYTLXT6/mMoQkKJFiP0ZbJdGLYCpDIkl6RqA96u2qOI43augeKJv6iSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727293768; c=relaxed/simple;
	bh=wHlt1UDNUW4EyY1KSNP5pOfctY2UPWgFJlLnpzAPVic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K53CmMEqcbHToLvGWczBx1Q5O6Pj6bI9ZYXY5R8s4le+q/Y7GCuexl9WVcq8D5XgKLXKpCUgaiukgZew2oeS79BsEQ8bLPqV9uu/3rFQ0W2FbOTa0pPo2I7ScSx4x70lEgdh6LhFPtd9v5Dd6+uHt8+EqgkyHWjf6KqYhsnfNn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=grVfBDWT; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42caeb4d671so243405e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 12:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727293764; x=1727898564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5oZ8xiwz/Qw/3jSJKzIG7b4TVIP0JKJXyRmrBm+owVg=;
        b=grVfBDWTvg+0ZccImOzuO3SpkJtcD2xwY/UeVorcSEwUr4ZGVzPUQDnhApb1LUAKsU
         Qks7mFrAj7OlE/gy7MCPc4asSFRu8Oep3Rg7rrXtpH4ZolrJaTH0/GOTWhFXAtCZ90Ct
         dVQLbg5LDf5fKoM07RirFqrBjuh5PN+CNV3JauhHq5ObIY96EKYPIPhc6ZD6pJpelpe+
         rGGkiosq6uCvkDi/F+F926sQSaJGVQgxZwMUPM1UO5gJddIysECSjVGzRk/RRLV4C7k6
         HRRcdTuqjuTvXepkfvAtKsmZ7V9dO2Ac7YJjT0qCuhw/OUep2Iecq9RBy46k6GWL+X4j
         bA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727293764; x=1727898564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5oZ8xiwz/Qw/3jSJKzIG7b4TVIP0JKJXyRmrBm+owVg=;
        b=Q7ZNWrOGwpjc8nDUrkB7vtF3BfE4ojSlypRza1Oa8ZmdA1Vf+r10nTdXyWqakIhWeY
         0TyVvcgSFAmCCYPMjS/HMLTqP8M5zu7dTUYjScYI+cKCCJvvt6pn6mop4UnxCRhL9xRQ
         DQFJz3SuDI8IG8k6W3KnwYBt9SxqN5Txti2tScJxvD3cCHxcD/5Z65mEZJs56aTah0Tf
         v1q4Gp6Pwbjv6zMGD2ZmY4RBeaiJGQzq5Yacg9cmO9hakD10Mw2OyzSCqIhucrfxQeaM
         +1SG4tVzQKmcJLnvwjsEiwQPRhAefpVmijl2U9qnBA1f82tDF2PlOdVpaVVFqJFc4do3
         p2Gg==
X-Forwarded-Encrypted: i=1; AJvYcCUNo8fyYHHrz7MfSWIhSvjobaqqbOsVzQx05czt+HW+K7oCwZNKbdyNnwNq36yRU7oFrKY4ulnZ+/CDpAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9NRXO7qn37f2fSe3vmjuxopSalR31DMpHYUkQIXKLJSt8gakS
	dMLho6eiTLOMXXJRNHA8SEvZZ/Ne6JrjaV4Aqxg4FmtGU8324bt+FqcicAYld1k=
X-Google-Smtp-Source: AGHT+IFYrMPT2ZaVL6xIu/354c9a0twdXDBSySfzuoKJtCPGg1FhbJnjlrx7JBdLQuBd2QTVnVH3aA==
X-Received: by 2002:a5d:5888:0:b0:378:9560:330 with SMTP id ffacd0b85a97d-37cc24d0103mr1210030f8f.13.1727293764382;
        Wed, 25 Sep 2024 12:49:24 -0700 (PDT)
Received: from krzk-bin.. (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f50078sm252268766b.59.2024.09.25.12.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 12:49:23 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Charles Wang <charles.goodix@gmail.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] HID: hid-goodix: drop unsupported and undocumented DT part
Date: Wed, 25 Sep 2024 21:49:20 +0200
Message-ID: <20240925194921.18933-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop support for Devicetree from, because the binding is being reverted
(on basis of duplicating existing binding) and property was not added to
the original binding.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/hid/hid-goodix-spi.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/hid/hid-goodix-spi.c b/drivers/hid/hid-goodix-spi.c
index de655f745d3f..0e59663814dd 100644
--- a/drivers/hid/hid-goodix-spi.c
+++ b/drivers/hid/hid-goodix-spi.c
@@ -786,14 +786,6 @@ static const struct acpi_device_id goodix_spi_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, goodix_spi_acpi_match);
 #endif
 
-#ifdef CONFIG_OF
-static const struct of_device_id goodix_spi_of_match[] = {
-	{ .compatible = "goodix,gt7986u", },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, goodix_spi_of_match);
-#endif
-
 static const struct spi_device_id goodix_spi_ids[] = {
 	{ "gt7986u" },
 	{ },
@@ -804,7 +796,6 @@ static struct spi_driver goodix_spi_driver = {
 	.driver = {
 		.name = "goodix-spi-hid",
 		.acpi_match_table = ACPI_PTR(goodix_spi_acpi_match),
-		.of_match_table = of_match_ptr(goodix_spi_of_match),
 		.pm = pm_sleep_ptr(&goodix_spi_pm_ops),
 	},
 	.probe =	goodix_spi_probe,
-- 
2.43.0


