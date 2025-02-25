Return-Path: <linux-kernel+bounces-530515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B1CA4349E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 06:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F25C189F4C0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 05:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA84F256C81;
	Tue, 25 Feb 2025 05:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GvWsYNST"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1E22566FF
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 05:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740461702; cv=none; b=S3Bc1za1eodx7A4BORJS1Xk2XjU2JuALysZvVmh96ZrRVmP1T4aZzNtL2AJlrCQxJHVQHv9qxcuooINW4jirxZs6436wfOZyQ7kLHWbF4xTDUe4xWQQqKXoedndZ8P1zYJb9gXuojjjzEqIe/vfebT2WkNyk0zYpB5sqZl3VhYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740461702; c=relaxed/simple;
	bh=FmjQKYch6XSD5pbW1Tn3YSdPQVc9xHCO/JMUTJbJyPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ThAnJDmgrmarKTI7n8EEjNvLr+4KLcXA/X1CHSAGF3Ek/hqsciO1fbDVuzHEztu/xYam/p/MNHpk0o2AO564cIcM5coZUgiUD3q2myf3UZFqTymlpaUBDdKM17bf7Pxx7OZ7O/NiOdYECx8N/YPef+5gq9lP59N0IoKnKl+BTd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GvWsYNST; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220d601886fso78168845ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 21:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740461700; x=1741066500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6Il8METpmlUQkRbSAgjzH18Gr01cpODvArSkIp0bgs=;
        b=GvWsYNSTIsVy6ueVfKcYCEgMlB5NOeOuS3+/HT+hj66ZyL3SXypWtq/t77Bz7ijcOH
         NhJ0uJ2f9HvlFcPe0sv+R/ycc6PMq+VkLTVVOtigfN5V1ZN4740kicbtlCe3pu7BSby7
         pQRD5lB8LJ5mH5NyeidqnSbqrMD5GiZnpnBCgfia7Fr4wcMQY0g73cKOuNKCAEH65E14
         GdIJVzAHZ9+VtOg/vw7yAkcNEa+FqzxUnFjnnBX9kpPC+dMIaN94GEvWhF5bHjbBCoqL
         N/ZG89QdONEnDblC5FSi00w3RdEsavcCH6cRc84RTPldUwqckCDNs1C9sA84JTmdlgz6
         c18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740461700; x=1741066500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6Il8METpmlUQkRbSAgjzH18Gr01cpODvArSkIp0bgs=;
        b=SdSMKWWs4Dx6WWUS4T7H7hSI591CfddaejR43EY8LdY/whzErTGSosWD1jrRy5J+Xf
         9EAOBD6tG5ENv22wTIAZP4rPlm52xxL+XiZkoYLNRMxR3Td1SaKj/EKgXB+dxHskQcS3
         YN0hsmz1cOfqIMCtnGsmrm/6NHVXpYLASxSvtZwiWm+VtQpXMk+f8ef9FS/cC4RQOcnT
         izH32MEYo2bFXcLEXIBJ7bLqbTiV8iu0PqCpssSwbwHjUNg+3fXAXzddZdqNlXBm3bOo
         3t73SPgx3VmkjNCa7aboNwK+0tG145OjWKzNpHJkpuQybm6xmUeNVsjwJEMgBNb1Ei2c
         /gNw==
X-Forwarded-Encrypted: i=1; AJvYcCVTEsXMr5ZjVRlbdNo+LqWPoog95yigIf2KHhoV+ehESoHbLpWQmx12lD1zDgFosWieVhGNG10uViS3jtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUr8dJYcP5yhFAFbjzBP6uk9vzn3rHwTZyF5Mn8MvOlA6o963N
	LXiY4Xet0zatqql0klUSR294Lc4Qcr+QAl7cwdw/4nBgYJV69I963xVs7aU7hQ==
X-Gm-Gg: ASbGnctK6YoT63Or22KTPzdQd9vSvf1X598eF+Xe1wxct98aBFNnzUoIIPZRxOPsSbX
	H7mMJJ1M7wHHy/nGT2uYnz2ZBaPu2MuipOM5UozNWG0h0I4fJBqvYir8d4/HIFKx3/bLh0RLnfE
	kIQAxtnzvuvtX7E0ZIMgluk0tayj6Q8rdf7AMODrTY6vyPP6rhuSBwOZ7Ooe/E+FiFdcL3oOORX
	7MXe5Kj0+4HV6XIy4VKH0NT/BNMLztwHTsf+Lz39yYHuZ55E/syo0E2V5tq1AUxkds7WZSeYBdC
	1MM702lWswUEBQ1Yq3KW2n1OgsvOHUoiRKNskBIDLW0z+KiSlevcKA==
X-Google-Smtp-Source: AGHT+IGOuK5WVs/FNS54x208S7fpWZaQq234w5cakUj39RKsU7tmbyu7PT7tpCGWSjC4Q4d8G+DFOQ==
X-Received: by 2002:a05:6a20:a103:b0:1ee:de1d:5abc with SMTP id adf61e73a8af0-1f0fc78bfe1mr2892953637.33.1740461700018;
        Mon, 24 Feb 2025 21:35:00 -0800 (PST)
Received: from localhost.localdomain ([36.255.17.214])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a7f9af3sm582101b3a.110.2025.02.24.21.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 21:34:59 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ath11k@lists.infradead.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 2/3] wifi: ath12k: Clear affinity hint before calling ath12k_pci_free_irq() in error path
Date: Tue, 25 Feb 2025 11:04:46 +0530
Message-Id: <20250225053447.16824-3-manivannan.sadhasivam@linaro.org>
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

If a shared IRQ is used by the driver due to platform limitation, then the
IRQ affinity hint is set right after the allocation of IRQ vectors in
ath12k_pci_msi_alloc(). This does no harm unless one of the functions
requesting the IRQ fails and attempt to free the IRQ.

This may end up with a warning from the IRQ core that is expecting the
affinity hint to be cleared before freeing the IRQ:

kernel/irq/manage.c:

	/* make sure affinity_hint is cleaned up */
	if (WARN_ON_ONCE(desc->affinity_hint))
		desc->affinity_hint = NULL;

So to fix this issue, clear the IRQ affinity hint before calling
ath12k_pci_free_irq() in the error path. The affinity will be cleared once
again further down the error path due to code organization, but that does
no harm.

Fixes: a3012f206d07 ("wifi: ath12k: set IRQ affinity to CPU0 in case of one MSI vector")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/net/wireless/ath/ath12k/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 06cff3849ab8..2851f6944b86 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1689,6 +1689,8 @@ static int ath12k_pci_probe(struct pci_dev *pdev,
 	return 0;
 
 err_free_irq:
+	/* __free_irq() expects the caller to have cleared the affinity hint */
+	ath12k_pci_set_irq_affinity_hint(ab_pci, NULL);
 	ath12k_pci_free_irq(ab);
 
 err_ce_free:
-- 
2.25.1


