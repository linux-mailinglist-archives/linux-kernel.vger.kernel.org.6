Return-Path: <linux-kernel+bounces-562398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B64F4A62555
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 04:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 367867AC4B8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 03:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC50518A6AD;
	Sat, 15 Mar 2025 03:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mv7iJsM4"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B4F1662E9
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 03:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742008912; cv=none; b=inOBCFtdKRcU+TejcmpwuL5v8fNwENVLZxlLwHrWc/+xZKxJiMIvw0xbLstY4K+Qgu06mo8FzDaKMWYRYcgh5NXR4yyBDVq3NB8Q4Zw0Q53DyVqMngvNQbRDXXME+0KqG6ggvpW+GsBtLaeklc7LfOpFAvUaRl3IvSAJg1S8+MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742008912; c=relaxed/simple;
	bh=58Kkdy1QlvdfBEuLJA2KBjrWGtga1wrtrRCSqTVz2ZY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DdN4B5n/4Q9ShmI2R2JL8lc8/hUSHH77SPt+rGdI0upkTzHIiWF7bJI+PdGHimrw47AELQunCfF2bV9zMjtCtRMcaua/Ge1+Tn+vNzjVNFii0fDzwL+uQoMSKc/NPKCWyjzqzc/Fa4ei0eUxC1ZayC70xVQmWRkqFGD61XO363I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mv7iJsM4; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff53a4754aso910591a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 20:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742008910; x=1742613710; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVCPNlPV716eA7La4uOIv6jwtGosj4v+uOcJZBxhxmM=;
        b=mv7iJsM4YK1ysBrvvQGHh0HLyWNRZa/W/yrGrMdPiOrYErVA4o3xy41ZBm9DEXFleI
         TLkKxqhjeTOaXcJNr1xt0o5EDV1bM5hqZgydtKY0nI7Sl/8eAcP6XxzMY4RR5FR3jj2+
         30olLO9pf9ZIl8HEd5E/stSOxK4KxMtzs+vAQrXaFT2sLdtTI9S5ctJprcFO+URU/S0K
         sMFxkufZ8Ev94fdQOAgByYYhJNZoVu8WP7+WJMrj4qbOBWW318m0yj4IMZWiaj+Na3O8
         JFvHPxzD5ajwIZoqFJPvtNeIGEqtylHXPXO/LLu/s1jwpDNmbh/Z/CIbfRzW+H5txUGx
         9Vww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742008910; x=1742613710;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CVCPNlPV716eA7La4uOIv6jwtGosj4v+uOcJZBxhxmM=;
        b=cNqBFc4c6sxAHzTT1SGIa8Pdf+Rrc5VFEa/QhxqVo613JwWCWOwsHjlP5ekR3YVXtD
         uM4UYpckQ20Bw/eXBYc9ZbCOGiEbsqP5XAHjhVDK6KKt4sv2/Cv8fmpk0dH3ELEvD0hk
         iYcD2Yjuk7a1SVOIbcluKY0rsZ2P/ql1w+udzxZws1/lQwWVCySLnTT+8+b6D2xQXuga
         bH3PC8pagO06AtOGCt2r0+K09yr6RhBk8ckB+k5QOuvkrDaeC39nNPC7bZvaiZfrYkPi
         CTQpOWOix2kPTnc2GAkMOGZT9aTM4gdVSyYvE4XWpKhToAnlmKobm1GY6liMfCJbm0ch
         yALw==
X-Forwarded-Encrypted: i=1; AJvYcCXfDkEPXTxn5BR1KAy8MczR71N4bMt0OdRtY6I5WHemhHjqZ+MULhFsw8YifCX8BnY+SL+bbZ9A1+aXxKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyehYfOpNm1MYgMAQxSAC1c7ouMqrQIgrCk1TDbmNCuz9OE0a4U
	Lbiry0tW3I+FOV/0WPQScvAtfvON8HDAwZPK6nwlhQTT2hSEKpu9D5kA0rdFGYiQLbG8PP17rMM
	ttg==
X-Google-Smtp-Source: AGHT+IGW8BzaRRhRtE1NpejkWAjQCEpQYH7Vd03oALl0yO1WNIEFXABlD9h6ktTlwxQxaDA8jNMrdESFAOo=
X-Received: from pjbpw13.prod.google.com ([2002:a17:90b:278d:b0:2fa:284f:adb2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d64f:b0:2ff:69d4:6fe2
 with SMTP id 98e67ed59e1d1-30151cff09bmr6553454a91.16.1742008910387; Fri, 14
 Mar 2025 20:21:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 14 Mar 2025 20:21:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250315032148.2377902-1-seanjc@google.com>
Subject: [PATCH] iommu/amd: Fix a stale comment about which legacy mode is
 user visible
From: Sean Christopherson <seanjc@google.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Update a stale comment about which of the legacy modes is visible to the
user, i.e. can be forced via amd_iommu_intr=legacy.

Fixes: b74aa02d7a30 ("iommu/amd: Fix legacy interrupt remapping for x2APIC-enabled system")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 23caea22f8dc..f7877abd0091 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -968,12 +968,13 @@ static inline int get_hpet_devid(int id)
 }
 
 enum amd_iommu_intr_mode_type {
+	/*
+	 * The legacy format mode is not visible to users to prevent the user
+	 * from crashing x2APIC systems, which for all intents and purposes
+	 * require 128-bit IRTEs.   The legacy format will be forced as needed
+	 * when hardware doesn't support 128-bit IRTEs.
+	 */
 	AMD_IOMMU_GUEST_IR_LEGACY,
-
-	/* This mode is not visible to users. It is used when
-	 * we cannot fully enable vAPIC and fallback to only support
-	 * legacy interrupt remapping via 128-bit IRTE.
-	 */
 	AMD_IOMMU_GUEST_IR_LEGACY_GA,
 	AMD_IOMMU_GUEST_IR_VAPIC,
 };

base-commit: ea9bd29a9c0d757b3384ae3e633e6bbaddf00725
-- 
2.49.0.rc1.451.g8f38331e32-goog


