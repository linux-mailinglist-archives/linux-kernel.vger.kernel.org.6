Return-Path: <linux-kernel+bounces-425389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1561B9DC176
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 10:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88789B21640
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07E617A58C;
	Fri, 29 Nov 2024 09:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ot+cqwyk"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CF714F135
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 09:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732872410; cv=none; b=WwJgh+yGsGuS/CPbl7TCdvfztXy/v6QnMXdpOjCcilPmlKwB7TkwE7MYzAROm84uDxflNbe+LG90SaGf9C86HzQy0qaKG6BdVoifNRvbb4G/E4SpbFc+p34CcvObWEuAM+InmnprvVKNw8hZp4h5OpdRCFE/tFTCjw+ai10BB4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732872410; c=relaxed/simple;
	bh=MHlRYTDbzpte/oyaFieIs0N72WclEbQwNH1n/UIc3uI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SOinklrTZ1Psi7rLVIkCt7S1cRuir1jQdYFf0zQdQVs02pfDs2nKjSmGT30A5GgAiSBK/zhpZK+lLpL7YAyqBI6//0jgOjixdCH2iA4SzJvE6imC6oHA5gbWkr/gomKxpqBSds2jlzaEJlfdyTQFFWEXki7dBn45SfnAuJnBCIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ot+cqwyk; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21271dc4084so11650025ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 01:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732872408; x=1733477208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/FAcNUtBN6sCO+JgOTDya+HEEM74CaemwD9wkIfazI=;
        b=Ot+cqwykEJ6tpRizYZrjGGudxgT2+5Eo9NfsK6wGtjTq4l3pZjEgiH+0swVKVKO7KH
         AahO+SOxSswK9Xx0WGozHh1RbLODzY9h+3m5IyZN886pl6kavX8mUMHIoSeC+9PjT73I
         8ppzS3t7xPmyJa+T+4cMIeGfQ4nyGxg74WC3XGirIg4oIRWUl0t/748OYTkRuiqbiko4
         tjpImJhzRMXAC6WPAsL7QWLLmA1CxerKDV33Rl46XzxJkVpeEi7NPBVYTuOlgTdR/AEH
         JoGaqsZSFURplxNxIWavekQ2oIEznKXxpgdhOEYHdZDIjHruosiPrN0CWoIphUltiqgl
         2pyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732872408; x=1733477208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/FAcNUtBN6sCO+JgOTDya+HEEM74CaemwD9wkIfazI=;
        b=LcVYtJFeKYyW2Pizoz7slYfJp+322p2TYSb2MFScQ+QHPSI6tOTx2on69t9YbMN9HL
         iXCNrvCsX6Md6PNvvH8+9iybmp80YfW36WnKzuptHfhzm/Ep9SZzjn9clb2iK/ftiI6x
         KZmxB5/KbiEQjmNPyRgP4rBd6DC4EDZd6wPzbJEgPx2mX0jdCaV+TzEFcUuEUaTCAqH7
         e1oAhX7HKuqZrcZ7921vs2qK6I+FQF5swY2uhR0fK3GIo27qrtiuP3dTuV0hcNHsILy5
         Y1Sm36qDZg2ua7DC/toMZcWRk9uCEiLBjFmGvsSHP4wHexKHqauaUD7HwGzRUjWRcRwm
         fL9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVxlOowfyiIB44MugpmkVIO2UNBeCazFt9OhfkrA3QlRP1tMS0U+yXWKl5o4mkDz4YbNfsCoW389PZ3kbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFvjrIMwll6/SC07czEBFjFGpS33iWYNxAxdKN8qG9eaHynaBF
	lFtC9skxivA5qwyhErf2yFtlu1oQ2Was0W59dQhzbD8eonWE1iW9kkmL3+qCdg==
X-Gm-Gg: ASbGncv9aNZ5lCCalDsWZBxZIGwkkXuL5JAdXl3Jxb5745gijaUFauRJhK2+UyFj4j6
	NbOg5lEfTUDtSRKCA8WAui/0GOS2wIY6bi/SEAl2uXXAXHxsf9fdc7YHrv4XDRTvTSn5lkUvQ/w
	SGbm7wFMD4qYoq0ZRp+8eTvTA4BNGtTuaxHfh8wfTfVMpxwjv/63DAlx4jwAn873z+Nf9Egb0lw
	2ZlyM3ny3komO3GPYpuaEUmL3+32B/dQgIgsqhqM5/olX1QNhM33AM2NSgV6AdIvHIpEK46uTFc
	Tg==
X-Google-Smtp-Source: AGHT+IHN+l6NK+tC7x8F9oy13xLI5GVuVEUr9/bO5jZlgYXRjM7dncdGqnj1qr9Z+oTM9kC3RI9r8w==
X-Received: by 2002:a17:902:ecc1:b0:215:4d90:4caf with SMTP id d9443c01a7336-2154d904ddamr4433805ad.14.1732872408394;
        Fri, 29 Nov 2024 01:26:48 -0800 (PST)
Received: from localhost.localdomain ([117.213.97.61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521987f17sm26648115ad.211.2024.11.29.01.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 01:26:48 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: kw@linux.com,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	lpieralisi@kernel.org,
	shuah@kernel.org
Cc: kishon@kernel.org,
	aman1.gupta@samsung.com,
	p.rajanbabu@samsung.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhelgaas@google.com,
	linux-arm-msm@vger.kernel.org,
	robh@kernel.org,
	linux-kselftest@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	stable+noautosel@kernel.org
Subject: [PATCH v2 1/4] PCI: qcom-ep: Mark BAR0/BAR2 as 64bit BARs and BAR1/BAR3 as RESERVED
Date: Fri, 29 Nov 2024 14:54:12 +0530
Message-Id: <20241129092415.29437-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241129092415.29437-1-manivannan.sadhasivam@linaro.org>
References: <20241129092415.29437-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On all Qcom endpoint SoCs, BAR0/BAR2 are 64bit BARs by default and software
cannot change the type. So mark the those BARs as 64bit BARs and also mark
the successive BAR1/BAR3 as RESERVED BARs so that the EPF drivers cannot
use them.

Cc: stable+noautosel@kernel.org # depends on patch introducing only_64bit flag
Fixes: f55fee56a631 ("PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index e588fcc54589..f925c4ad4294 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -823,6 +823,10 @@ static const struct pci_epc_features qcom_pcie_epc_features = {
 	.msi_capable = true,
 	.msix_capable = false,
 	.align = SZ_4K,
+	.bar[BAR_0] = { .only_64bit = true, },
+	.bar[BAR_1] = { .type = BAR_RESERVED, },
+	.bar[BAR_2] = { .only_64bit = true, },
+	.bar[BAR_3] = { .type = BAR_RESERVED, },
 };
 
 static const struct pci_epc_features *
-- 
2.25.1


