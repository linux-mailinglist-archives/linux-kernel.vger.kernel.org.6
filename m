Return-Path: <linux-kernel+bounces-530516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D10A434A5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 06:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2A3189FBD7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 05:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF43B2561C6;
	Tue, 25 Feb 2025 05:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XCzWZ9Dp"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A9D190664
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 05:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740461706; cv=none; b=TICVYtg+Ru22btPA+hq++eEs/2K2VOOCNH05BWHodeRky5L9aBzg24hGcmHs9YatKJDBUvpTpuNmN0JFDgqxK8lnyrl2Vy4pt34aEhnm4xqWwkW31H3rwPyBRz7tCGFjTm/b04R7s6yvOCBpdnYpkf2Z3LDqkdkIrl/z1sZF4Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740461706; c=relaxed/simple;
	bh=m0ENAYkK9uSzSQgO0nychnr6WiQxO2uAemDG45GIDpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J744NPvP3zqjID0432SwPffb1PEtlA9s+frwSsjA/wjK+P25jiaH7BP1fY4lW6e3S7v6o8COJ8D/p1CyiwNKu2uwroVcu3yj8DTz0Q1qyR1rchl3qYOF0UlkSpPEaasNhKGPD5nkw3LEe51BU2ZXxV338gKVvRI+rXKhYB3r72k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XCzWZ9Dp; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220d601886fso78169355ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 21:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740461702; x=1741066502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYmnWqCfl4BTw5dpDwtuCHljGqr5uXG7tQyflbiZ1TI=;
        b=XCzWZ9DpJfpUhieCl8OvFY+EfDWk/cJL0RAhHrDsUD6/YRxTBeZuxaGFvf3jE+6Y5R
         7wWgYtsEeo1msxdc01+ZFx3K9u5RsWKaVV0Qt3jdT5BVYVfGca8uKJaDZ+qF/d5Sq02x
         feJLwKbPfzUOnJ1XkYpIkoXfn7QB0kQ3fEkx+VfPlLWJfIzkcX7Ncz1sT92/3fEtzH9N
         3F171KxK+622g0DovPjnksnVGQVaHSZac0pwrXnoKHi1HMnWkPcD0X6X6MKyYX5WTmoZ
         PNYq4DfaFMTwlh7xzyxmwDME80ibQ10X/X0yyIfYOcL1UINGP1gf6WwX0/iTV4fR+gsJ
         aMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740461702; x=1741066502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AYmnWqCfl4BTw5dpDwtuCHljGqr5uXG7tQyflbiZ1TI=;
        b=l4KX6Fq9Hlmiyjdvh+V1MsSg0lUr/4maowDRhFFNosR6KHq0oDv41i3M+ca7YmRqGN
         VV1ipg2rceic4epPNYn1jpliQcrACyE83iQWCuqoHlVOITdkPE4pwBd3oiyC1ayuykDQ
         7aKmIDSNSyJTTZcoPcWmHg1GzLAMkVOPMa5eavgTm0jyPK2MYMsqFwH2fpNA2su2MgbX
         D+aFP+TcZh9knOXcyIRr444CAwODZQk0/+5tyajWezefTGv4Vd829zjEHn5nhoFyGc0v
         KUr+us4FwyGakakFmrSokGwKJzCeDZf2KTAMkc37rpOoWlmahvUQjt2aInVGIB//MwGZ
         DRkg==
X-Forwarded-Encrypted: i=1; AJvYcCV03vgvcAotap3zb13EngbO/76hwNrPxPLdZhv79isiO3Ckeu2GNCD/kFDtwYybaKCVuT42tJRTEyFcWWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmF+kggD1KBBD1H+tvalhPCppvjtD6bhU58/VKtr4JRB3zd9gv
	NMxJBVF2KvOquEX9M5DeG2m56WTScWr0RhhqlJUiiwmseM2afKrcHIx3a2k0Kg==
X-Gm-Gg: ASbGncv+ulMHfxRt7KLoluc4D+w2CqYnPeQzY2sJGwwOD35qPxAh4IR+K9SChdyJtYc
	++vQt8zHM/E+4UAH5EJyLTtGIj4kyeZJzCHU6YMOEXNmf6m/WnBGYBvvIEX+dQXvBnVeB++/2W3
	f17LA/CYcvS10UpJw/fukSuvc569K3X9R7GuC82Ro2e7eMmT0iXlHtA27F9kw43/tVupC24Z4c1
	Z6xZiZjhpBAwJ4HwTSN98wUVT6g5Zy21cHmI2JfsXJmMVbC6wb/6j8Dxw7MmlVhZ5ZU0MWvJbyp
	pk+SMX9LwlPyC3rswzm19GsBt9tsn1kDKEvSV0G2PsX4dvOprcMPXA==
X-Google-Smtp-Source: AGHT+IEHljzwJD36eza1aeKcaU2dWlFSTtvnEQrg+fmzOtR5w21SUg7QvbAbtZaZAXH1YQPPhdGwlg==
X-Received: by 2002:a05:6a00:2e9c:b0:730:8526:5db4 with SMTP id d2e1a72fcca58-734790f8cfemr3218117b3a.13.1740461702511;
        Mon, 24 Feb 2025 21:35:02 -0800 (PST)
Received: from localhost.localdomain ([36.255.17.214])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a7f9af3sm582101b3a.110.2025.02.24.21.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 21:35:02 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ath11k@lists.infradead.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 3/3] wifi: ath11k/ath12k: Replace irq_set_affinity_hint() with irq_set_affinity_and_hint()
Date: Tue, 25 Feb 2025 11:04:47 +0530
Message-Id: <20250225053447.16824-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250225053447.16824-1-manivannan.sadhasivam@linaro.org>
References: <20250225053447.16824-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

irq_set_affinity_hint() API is deprecated now, so let's use the recommended
equivalent irq_set_affinity_and_hint().

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-05266-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/net/wireless/ath/ath11k/pci.c | 2 +-
 drivers/net/wireless/ath/ath12k/pci.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index eaac9eabcc70..be2791cd79d5 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -735,7 +735,7 @@ static int ath11k_pci_set_irq_affinity_hint(struct ath11k_pci *ab_pci,
 	if (test_bit(ATH11K_FLAG_MULTI_MSI_VECTORS, &ab_pci->ab->dev_flags))
 		return 0;
 
-	return irq_set_affinity_hint(ab_pci->pdev->irq, m);
+	return irq_set_affinity_and_hint(ab_pci->pdev->irq, m);
 }
 
 static int ath11k_pci_probe(struct pci_dev *pdev,
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 2851f6944b86..9883cb2de548 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -646,7 +646,7 @@ static int ath12k_pci_set_irq_affinity_hint(struct ath12k_pci *ab_pci,
 	if (test_bit(ATH12K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
 		return 0;
 
-	return irq_set_affinity_hint(ab_pci->pdev->irq, m);
+	return irq_set_affinity_and_hint(ab_pci->pdev->irq, m);
 }
 
 static int ath12k_pci_config_irq(struct ath12k_base *ab)
-- 
2.25.1


