Return-Path: <linux-kernel+bounces-530514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A15A4348C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 06:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD267175180
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 05:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF312566F1;
	Tue, 25 Feb 2025 05:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x3Ko8wH5"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A69E2561CB
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 05:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740461699; cv=none; b=qQXFrTJ0vi0ezhZow4Pt4auD1oYZWqlmEk+tGCrpoL9wBoy4WYVtR1O717NRDrDmK5MEJLAF7D84QmP5jTea4h2qsBf5zkisbzJqI9yurbzG4WKlFDPTqjcwVIXC7WjYniUCnDQWeN4ace09laowyhvwEJp491yo1tN1SInmoZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740461699; c=relaxed/simple;
	bh=LdVk8C3dYDmty4gxkSuuGDDu8zkpk1p5J4v3VnCRaC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FltPnofc+0noUg0TFZiEYARbcYMQiQyY5nGgdvbpFKwKTIxCAgZVicy+V9hFFlI+lABXwImDJyPhZ8W/jOCyxy3eNTTcgy33OGf8IkRE/KtXwWzIY8l2WbPXLv5nQZtEqpaNRkh50nYxJd91W5gnvn4oHfZ13gRPXzTyuQYTqrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x3Ko8wH5; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fbfe16cc39so10347138a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 21:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740461697; x=1741066497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Alp/86Yl8dv5OV9OIvJcS/PHlfX7ulpzzZhhzjQV/Tg=;
        b=x3Ko8wH5y0SutybJLEXTKcO6rncamISSQugXgiyYV8h1OhRXzX04W1KSZedh6vrDDX
         vFYQ7akej4z3CMCMzKdy/JZ3vFzn74sm+itk/OuUnhnVTRSm5FW/kgjE9r1P4qlO7slJ
         nROorqbMhqGGMQhoHIAFyt69aojvB7/nLHgPefsx4kMCaDGV0hUpPG03d+8Xesllh8A0
         JnRLsdTrSWrOtAZcdK5CG8+RA3DGxfmJkEajy3ngjHTIJ5tlqJ+S988BKXc+zqgDJe1M
         +xTm8KHRZasiC4fpJ09YtS/CKire6fSv/n1uhSjnAW67ukdhmTVL1KcwT4y3L4i6ykUb
         O/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740461697; x=1741066497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Alp/86Yl8dv5OV9OIvJcS/PHlfX7ulpzzZhhzjQV/Tg=;
        b=npPwNczfUtue6NtdlGxHogIFTMjk7Pn2NqB2zYV3/4V6Q7T+kiIUwt0dsl6XMdmmMz
         BCnd8JXaZbJvfOrBEJjPuweQD2np/AoHm0XK3hooBSjqIsZxXdACWCgMEr52HnoSRSa1
         cQRhJVdLcx8xuaQIDl5zzsD3J81/y5q/TkN05xn/6B9z+v8FUKCnKVuTjyuxHyuXRkK+
         Of8TAObyS3ObLPQZDWIdCLal9q4kprzplNjX3MOhY5Cgzd4csGLkBQdBr3IVKb89FmGE
         gXsTvBZVq0yA2m5vN7l2xqszMh3EwNA6zyJM+flf48tf3wK8ZkFLDFAB0dXv8BHOwu7R
         N17w==
X-Forwarded-Encrypted: i=1; AJvYcCUApaxAN7uL8f06+OkjaCxXCAAiINrXZP04ch7qFzc8EE3WMbpBaK07ZOPIFEQp0OJEjIGxmo2M2rtXdfk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb1akze+UchBKRkvSo5tw8MGVVvqjYE+xsG0sEg4xOpqEG4JpR
	J8oUWN0zy8Z4erA8IvfFakIFf/Ft9qguOl+kc0bFgH88gzPzP4w0jOEaWe4nEA==
X-Gm-Gg: ASbGncvrKgi734u/SUQUqFRrcAtK/FvD4CUQe9N9phSjaClbuPsiuXUMzTfXmQtf9L3
	PhneaSm7s8xiV57YDI3QiRN9byD0VVcLawMnjtOdgBnzzVJ4/wwUWAiSIkCyiRoh1Oeufg6FNSd
	+zgZoIP5WBMW8Z+g0a/u2O20UUC6b1vzOPHp8KtFzZK5IS5ahQI4h97fZFzrMlKaZZa6rnw9Z9x
	ThM+X7a+4RkDL0qh0R1jjoo9+vUZJWbbLNte6XPV1qPW2pk7hYPXObKJfwo6eVKhtuMp8gxmsKi
	DvemhiSTaCnlGmBXwQmd+ZBf0VW4uQT9bnw+tcDTIEAFAUN+2espKw==
X-Google-Smtp-Source: AGHT+IHmuD1aWu/v1EBbeaPKC/rVSjBidCILD+wsg56kWI0wnKQ941LQEdS/f9KRvfrcz7v3nfAKMw==
X-Received: by 2002:a05:6a20:a103:b0:1ee:dcd3:80e6 with SMTP id adf61e73a8af0-1eef517dd67mr30705278637.0.1740461697436;
        Mon, 24 Feb 2025 21:34:57 -0800 (PST)
Received: from localhost.localdomain ([36.255.17.214])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a7f9af3sm582101b3a.110.2025.02.24.21.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 21:34:56 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ath11k@lists.infradead.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Baochen Qiang <quic_bqiang@quicinc.com>
Subject: [PATCH v2 1/3] wifi: ath11k: Clear affinity hint before calling ath11k_pcic_free_irq() in error path
Date: Tue, 25 Feb 2025 11:04:45 +0530
Message-Id: <20250225053447.16824-2-manivannan.sadhasivam@linaro.org>
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
ath11k_pci_alloc_msi(). This does no harm unless one of the functions
requesting the IRQ fails and attempt to free the IRQ. This results in the
below warning:

WARNING: CPU: 7 PID: 349 at kernel/irq/manage.c:1929 free_irq+0x278/0x29c
Call trace:
 free_irq+0x278/0x29c
 ath11k_pcic_free_irq+0x70/0x10c [ath11k]
 ath11k_pci_probe+0x800/0x820 [ath11k_pci]
 local_pci_probe+0x40/0xbc

The warning is due to not clearing the affinity hint before freeing the
IRQs.

So to fix this issue, clear the IRQ affinity hint before calling
ath11k_pcic_free_irq() in the error path. The affinity will be cleared once
again further down the error path due to code organization, but that does
no harm.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-05266-QCAHSTSWPLZ_V2_TO_X86-1

Cc: Baochen Qiang <quic_bqiang@quicinc.com>
Fixes: 39564b475ac5 ("wifi: ath11k: fix boot failure with one MSI vector")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/net/wireless/ath/ath11k/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index b93f04973ad7..eaac9eabcc70 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -939,6 +939,8 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 	return 0;
 
 err_free_irq:
+	/* __free_irq() expects the caller to have cleared the affinity hint */
+	ath11k_pci_set_irq_affinity_hint(ab_pci, NULL);
 	ath11k_pcic_free_irq(ab);
 
 err_ce_free:
-- 
2.25.1


