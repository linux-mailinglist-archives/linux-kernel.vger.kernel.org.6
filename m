Return-Path: <linux-kernel+bounces-353024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E54992760
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 812611F210D4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 08:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38A418BC0E;
	Mon,  7 Oct 2024 08:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pm47ObGS"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70B118BB99
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 08:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728290662; cv=none; b=APoHi49n/ob6ZY59QlLmSbTPQ9Lp4XlWoghU/CIKwgTVWC321nQh2Uzg/d2U/OzrWUbFr6NHraPn2Ws4jHsLQUzN5QY1MYY7XTd6WVNHPOl0S0Bhtv51vsdV7NeaTU09Xxq5kCAaialEUFgs0Sgf3/atWmm+lteZZwpdnAdLZqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728290662; c=relaxed/simple;
	bh=mKRi/Ji2Fh1sjMKYDaFTsQoiTO1y9q7Tkh+RFrSPlx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eWHIpGh/591dl+6MaTNUpZW/ErKOu5I+5XQgkww5wYiASCd+vhtQrtWko7urcPizRdRU6Uk+38YgG5QW1a7lzRaHdiu3zhP1K2RUxoTg1YM8wsZ8jYdK7gn8MWEKPxvGvS1WB7Z5/10XO0A+OxakS2ReRPS5zVQS7JFhe4YETO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pm47ObGS; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cae102702so31994975e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 01:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728290657; x=1728895457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3LHi3FSgqeToo0bAXx9OkGGmGc4N8ZNIJ0FVCvSLrAE=;
        b=Pm47ObGS1MvwaVKhIMeWpLmH5wPVOgekxLiQPhmOMpiCrTUzowQI94k6HMuR6JmiqF
         5dy132on76cdJqAjvB4ug7vV1girBvOnP+/BsRMfEzlHESx5lzV+ilCNJOjVSb+IeYZC
         ddIvoikvPfqN9f9Ax6Kiah4PIdVYaOA6p6kQqKDfcusZfq2TQnl6HvEX9SEjnA36ZnXJ
         JbZl/X1hlo5EKfOaC5nXGAVFcy49lc3NoaeybCcBcLmtjF/MHKXEcVQOMQyKVsgAjAT7
         oPGMrJo5NfxJx3UUS7+AsyRPf20F6h5NKuEaxQbVFKQMGtJq+7s1nftEluthXR+hve13
         e+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728290657; x=1728895457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3LHi3FSgqeToo0bAXx9OkGGmGc4N8ZNIJ0FVCvSLrAE=;
        b=oGYsFGjWukm9FrppKQNeW9sko8zFYCOXSCd2ODQV3HEfhENfsqyElBnu2W0O06UTFz
         W1sM9oBLhT6OZQNafqLH09lY+Tm1fPlmJ89Fe5cf9jrBRBwUlyNRnrflcgxNO1RMngMp
         JOMI7AF2+Jhiq92Fm7MUTNuluXxClKOI56KiOtNeMp+IRlwDYUgzoBCbQcFBLyKzjfoI
         empb3p81g5KQXzIgjpiTLDWVlKYRP00hmD9QrlJGEIneq8ujFkzy3XDUKXODTDlETm8y
         qR2qU9SyO7zV/Fvu+eDjgVxpZ/xh+C7ppYDcmf0sGYQn7rcjc20qQKKOCTZYIIXsNMwN
         cnOg==
X-Forwarded-Encrypted: i=1; AJvYcCVpGB34Lv+XfMtac8Sshaw2iQTsv9nqOSaQuryGEdHkPbyfiNNHaJeVkjU4ICtHHK1ERwkFmrYLRe+iDvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YylxnkjBcFUjuBHNGnofV82JbkpJnkQTfTorr668jd2CJ5Id6hm
	RGKVezqejkMG4PajPO4phOppU+apgQXqQfJm6G896gsrTLZepY7HFuR4z4Ic2Ms=
X-Google-Smtp-Source: AGHT+IGPW8AlxiTySRc6I/+8scs6PQYUwE3ih2A5K7OfKFBkNDD6AHxmZ1xsS/wmALuniaK6EpqCcA==
X-Received: by 2002:a05:6000:1046:b0:37c:d4a4:3c2 with SMTP id ffacd0b85a97d-37d0eb0be52mr5063548f8f.49.1728290657279;
        Mon, 07 Oct 2024 01:44:17 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1695ebe8sm5196528f8f.79.2024.10.07.01.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 01:44:16 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] iommu/amd: Use atomic64_inc_return() in iommu.c
Date: Mon,  7 Oct 2024 10:43:31 +0200
Message-ID: <20241007084356.47799-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use atomic64_inc_return(&ref) instead of atomic64_add_return(1, &ref)
to use optimized implementation and ease register pressure around
the primitive for targets that implement optimized variant.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/amd/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 8364cd6fa47d..074effba7fbe 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1230,7 +1230,7 @@ static int iommu_completion_wait(struct amd_iommu *iommu)
 	if (!iommu->need_sync)
 		return 0;
 
-	data = atomic64_add_return(1, &iommu->cmd_sem_val);
+	data = atomic64_inc_return(&iommu->cmd_sem_val);
 	build_completion_wait(&cmd, iommu, data);
 
 	raw_spin_lock_irqsave(&iommu->lock, flags);
@@ -2890,7 +2890,7 @@ static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
 		return;
 
 	build_inv_irt(&cmd, devid);
-	data = atomic64_add_return(1, &iommu->cmd_sem_val);
+	data = atomic64_inc_return(&iommu->cmd_sem_val);
 	build_completion_wait(&cmd2, iommu, data);
 
 	raw_spin_lock_irqsave(&iommu->lock, flags);
-- 
2.46.2


