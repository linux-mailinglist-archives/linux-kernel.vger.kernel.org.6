Return-Path: <linux-kernel+bounces-523396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD91A3D63F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18263189814E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19811F03FA;
	Thu, 20 Feb 2025 10:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CPU7AKFS"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627881EE034
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740046540; cv=none; b=XCc1bQ3+vIVRoBPOkajMAIfhLo9bOHEkmvhRm7LRHvTAyyVl6WKl6lX9FLNjEhTmT9il7unYXkhlUwmztSjCe2icZNQQiqT/1wshJ7QDk2PPDdIp37riIgK+odMEPeGchiGOUujfY5hfQlg8bz+rA2Fj+0OdWo6oCZtTZ+KwTwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740046540; c=relaxed/simple;
	bh=AwGIoFXUjlmwWgvEOb+I3Dk1NKxMqMQORiC+Kje6l6g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PLlJ1dAi7YKdGHGRAV6zsUZwlQUJg0nvz/RCQQU1dHpH3X2gEIP8nW9Oddiqfg8KBdOBHlT+gTerrNjxpjJWxzg3WIPs7DLTf8xEC9hsX3k6xR1TbCMhdfHqL7xm7gKczcOgpOELDPB49tdgY5AKMLoyYnfXqQzEetQK6ntbbx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CPU7AKFS; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fc0d44a876so1143171a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740046537; x=1740651337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fi6x8ig5ZwKEmhmgwjg3TF1oaUzfpPBZi49wWEG256o=;
        b=CPU7AKFS7lRvYok/OkJHSU+2gCOEHJsUPprKX2VVSAazOSgMwDJr6hzhymLXK02/oa
         KQEiTjAkW9cHwG5SX3nIlVcnByKTsu2s2gjh6z7L01S3nfM0H1qa4SSdbizerCpbg9d8
         bUNx3LSdm+AnWqQ9qI8P2XNNGCouOrD2/FlMED0vOlRMIwrh3SN6JHgd0tqKmScRNAYp
         xhELua3O1/5OUTnAIUYNfwS8zRu2QS1TSLcUYepdzH+7kdyVjuLvbj7vTRcBWshv+33P
         uqBdOgopOmpH9VZOrro4RubLzX/+W5CbSNJlUyT8xFFtz1EgqaprWMQINtuyGx/Pp7u6
         LyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740046537; x=1740651337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fi6x8ig5ZwKEmhmgwjg3TF1oaUzfpPBZi49wWEG256o=;
        b=sHAMmp/NPKzG51k0bAYtHBmcp16Cpubk5R9MGIc0SF2ywgNQYJQg9Q3O5wpk6Cr8v3
         uyM422cOZOP+e4g1SYlsiJJVjZRcxRnEIJdw7z4YKF5g4ZLOLHta8sg6X4NGhslXik7S
         XjayUqOA7dN/AEdvRTXP/FB05VGp4PRmHsOODnymHcv16WssopEp5KK5wdm85gLVGy3o
         j+FciKXX8S1cx0NomI2lGl0D7Yz6lpHTb0HZtCkrNCi5DcseZ/IS0gcp0kdCzhJEb6wV
         /LaofXU3p7ZzS9X/+mUcMXVPnhLA2lYq7qAT2E26ZbG9cofCkht121cRgg/+fGQpwXB8
         T8NA==
X-Forwarded-Encrypted: i=1; AJvYcCXqFAo4SYx0Mmy3RVYI+Hnw2OEgMmA9YzU0CSgydJfhiJzeSzQSFm407fhOKvkG/R+U1rWSEyWnQe23Vgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+mEKDZwgeMw6cuud9kLdqwvV/fR+ak4aTuqiWnlPvbsFSZKSM
	YaD2C4Ko7NFm2jetX0Gn8g02YhR0EAA06vkh1mCgm2oII22hZ73GcBqV2iWy/zQ=
X-Gm-Gg: ASbGncsmFkxZG546iZ5sAdZvNKp3nf5o9nJHoOpx4beaNR9zEcE7aCXY2TcxIigC4U7
	m8bIJ9/YtnMDLdDTCtSKd0B3gIMS/IjpBrGh0dI9xE7WqC5iyYuKoJfYk9v/JCRIm66ZB/6r67x
	wtVHTs3XgDrR4RTYQXCfjKr/eAvAd2Hy2ngI2mM0z43Ff+6jqfJ6wrmgzgVZjSvHSVrb1zFQkaf
	qih40oPHJFX3PFdCW6ZPl2nNDEFaTKCVyuKSh9mLaqGWaQ/6BVfwHpevCGFyLlafZL3cVQrWYT7
	Tj99M1RSlsC1jBSVb+3SHwUf6P7CP39E8aei6kRvAOMrrLy/tg==
X-Google-Smtp-Source: AGHT+IGr555DXR3ZVGi1n2qebDlBxN4jaHy47hIUyefBd3dK1itx6GoA15111YZSfPrtvWchGl6xUw==
X-Received: by 2002:a05:6a00:124f:b0:732:5935:c219 with SMTP id d2e1a72fcca58-7326177d652mr37845583b3a.3.1740046537505;
        Thu, 20 Feb 2025 02:15:37 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73271a02648sm8707518b3a.107.2025.02.20.02.15.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 20 Feb 2025 02:15:37 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH] iommu/vt-d: fix system hang on reboot -f
Date: Thu, 20 Feb 2025 18:15:11 +0800
Message-Id: <20250220101511.37602-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When entering intel_iommu_shutdown, system interrupts are disabled,
and the reboot process might be scheduled out by down_write(). If the
scheduled process does not yield (e.g., while(1)), the system will hang.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 drivers/iommu/intel/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index cc46098f875b..76a1d83b46bf 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2871,7 +2871,8 @@ void intel_iommu_shutdown(void)
 	if (no_iommu || dmar_disabled)
 		return;
 
-	down_write(&dmar_global_lock);
+	if (!down_write_trylock(&dmar_global_lock))
+		return;
 
 	/* Disable PMRs explicitly here. */
 	for_each_iommu(iommu, drhd)
-- 
2.39.2


