Return-Path: <linux-kernel+bounces-535042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D88DA46E1D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2A8169EF6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEF4271822;
	Wed, 26 Feb 2025 22:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j+I8pKwq"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F99827129A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 22:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740607473; cv=none; b=dariBK8I4Wl+1u+qDCHumv+JpfYn72aQjeR6d2Vap35KEZdLHvCydGsLBPnSlev92mmCNHBscOPRVcRKqFxTdEf0As9QueJuOXWN7mrN8o+P/7UHwH3cD66sE/IFG21zx/9l4BlOWavEvkMscoIU//NnOMw7EP/j7YiikPgp9WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740607473; c=relaxed/simple;
	bh=qiJ5NgMCW+3w1jlKpr4Qxl9Za0XkMmw59lyuniMavhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WMWew/yy82/PmAR3nyb7lTbGo2cWKnCFrsBwJdOo9CErmqVdfg1XwHflgGTUKXnLX/d2kGAe3igRjL+D4GDL5Kj0c0QDdUVNs9dHj4BqixB85KsHkuhgK392ck9udVj9HR+1CPLBojmHCtHxuQUtHlSj6Yi0ttStQriNNAm1AyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j+I8pKwq; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2212a930001so6858925ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740607471; x=1741212271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVSwZvqHp4KclUxAlGtZReiZmGLJRUAId7nnJAavdso=;
        b=j+I8pKwqaYJqCfqWZPsBRXvs4z07NZzQ09hIeY4Ya4cnMLbZIoBpftqQcXWk9D3lV3
         +THBIzqAdjZR3tRWr2IshtH4m/jE5BAPazAzQPgbLAjzCUsJcVtxeep0gGDxGbmx2gFL
         UsjaQDjc6/OhoIQc1vTilF8BBbcyJ8NER0ukGUsIElskI2DclsMoaeK+i0pe9H1zXmNx
         wCfQhldsdjvTSryXVjap7/PH7/i9M+/pzMMNd1rM+yklqTwoM+qX4a6SAsuY889St56l
         1kXXOWoLOMOIQKT4RD8SNdfqT6A/+oRLo35+WtXfd54sCr+s/+KLcHR2gb1wNqeM5UcH
         MMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740607471; x=1741212271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVSwZvqHp4KclUxAlGtZReiZmGLJRUAId7nnJAavdso=;
        b=DDsNx7QY3hr1avAaoxBxdltghhCmbJTyni+RR7M4jOBdgsgQH7LZMI++a5h1lqeZpk
         Fatl1v28jii6QoRDGIM5v6X3NoSsxstwXI1Sb5UFnbpNOloH+wrR8niinY1+VbNAjivs
         q2NY6iu15fsns7Q8DJfZtnYDlWPnwennPsxU+TWh8zL7oS3cnODe2aKKt+ebONCOslIW
         RMjCo111YodxQAoSaWIcvUWiCIUrXDRGXWZBWR1mmKDKLjAaBF5+zYKamMD82YvaBm8C
         SwebooA/v0Soq1mMnz5vZLKkx6qc5Gc1WDLS7+smB75pssexgVwrKeU5y1c1vVHLtmLN
         FuqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkGx1hSuqOgoDQXqbjAG1pmBPC5aTTY3lcGDd+KgjJvRqeU+etIu/hHDiK4UAUQhUDKlCTJQgPwPlGkuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKlEd0AGYR/JyB/LIZ473krS+Mk/v6a0GU2wNhIh31D18ix2T5
	7PxXGirc/7M7J9spRvO3veYGZrbiDZWKUFqPFlFYXk2ZmRL55alNEMZiqm7lTQA=
X-Gm-Gg: ASbGncvB4iM5UPRJbDtLfP8kY+2ztZu5Wyyl6wikBc4Gmf53pYtswIEycwf3IWbJXZV
	5Ep4SE+MzHhuAh/cG7BHyViIzWHA+dI7CDt/Ton0NUq81OsdriYWUR/WO3GYy4Y7LLWX5OnW2Pq
	00dCoeu6QKbR0eQcQXSLC1xqY6/W329Fwkr+I5wWtFYps6Iqvycp+sV6s5pSr8ghzQXXgkLqfDm
	YKAf9cp88NxVVnhkLpyQ5yag1anFsS+GEmne6eXXIlaB7EW7FE7+VGME4ssa56Akwuh8r6z4QBu
	fPxZpivu/NqTZ47+OhroDV47+hpQFyB0fdtR3ZRz7LsbC0B2cdj/ZD3Y
X-Google-Smtp-Source: AGHT+IHv2DLo5yokOufzr6ieTPFjBCf/BVk00fjUAV4YbzWaoAbBY7sSAOQrP6QEylsN4Iqip6zQ3Q==
X-Received: by 2002:a17:902:d2c9:b0:221:f61:14c3 with SMTP id d9443c01a7336-221a0ed8294mr315855585ad.18.1740607471584;
        Wed, 26 Feb 2025 14:04:31 -0800 (PST)
Received: from gpeter-l.roam.corp.google.com ([104.134.203.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22350534004sm1044145ad.252.2025.02.26.14.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 14:04:31 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
To: alim.akhtar@samsung.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	krzk@kernel.org
Cc: linux-scsi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	willmcvicker@google.com,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	ebiggers@kernel.org,
	bvanassche@acm.org,
	kernel-team@android.com,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH 6/6] scsi: ufs: exynos: put ufs device in reset on .exit() and .suspend()
Date: Wed, 26 Feb 2025 22:04:14 +0000
Message-ID: <20250226220414.343659-7-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To: <20250226220414.343659-1-peter.griffin@linaro.org>
References: <20250226220414.343659-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GPIO_OUT[0] is connected to the reset pin of embedded UFS device.
Before powering off the phy assert the reset signal.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/ufs/host/ufs-exynos.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index 4c3e03a3b8d9..64e2bf924213 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -1517,6 +1517,7 @@ static void exynos_ufs_exit(struct ufs_hba *hba)
 {
 	struct exynos_ufs *ufs = ufshcd_get_variant(hba);
 
+	hci_writel(ufs, 0 << 0, HCI_GPIO_OUT);
 	phy_power_off(ufs->phy);
 	phy_exit(ufs->phy);
 }
@@ -1700,6 +1701,8 @@ static int exynos_ufs_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op,
 	if (status == PRE_CHANGE)
 		return 0;
 
+	hci_writel(ufs, 0 << 0, HCI_GPIO_OUT);
+
 	if (!ufshcd_is_link_active(hba))
 		phy_power_off(ufs->phy);
 
-- 
2.48.1.658.g4767266eb4-goog


