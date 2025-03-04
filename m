Return-Path: <linux-kernel+bounces-544271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D44C4A4DF87
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B082176EBE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34E7204689;
	Tue,  4 Mar 2025 13:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kjAfoxLQ"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D062040A8
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 13:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741095834; cv=none; b=bKicixIfCWazR/6B8QVmJJ8GFJY/gPbO8uuRzhoveCerYNENTCGaLl/Iqw6jP43+tE7BlW5+li7Akc9f1Bhvpazf4zUyHn/wxdXcBmuz0/HO4WuSzG3Lutp/jFdEP2Vvp2G5T8kLQRBFwIxvu+aFCBDGD21wly5NQKRX1rKcpAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741095834; c=relaxed/simple;
	bh=80+eCrT6Rmn5Jg/jRx7FsLXSYZEFXC8qPz/qSbLB/YA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nG9u9qGPKLxrYBmbpN18NgAy5dJZ5/r+LrqpKn0Q6QZK0K9r9af9oPUlQASzkdpB2dhgnuM859mDJllUtNoqk+t9dL/o4tZ5OTEuh7D3lCIK23T6Mgbjb8Ji9X72jGNIx2G9AIpyQFnK4Ab+SZlnXO3Uiz0kF8GJoBTmnqJTT3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kjAfoxLQ; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4394c489babso31127915e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 05:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741095831; x=1741700631; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uj43tHXd4oUvGh93mFvuqSAi4hbUgB5iGKnK2cXXgbo=;
        b=kjAfoxLQiOmgbkSud03OGbdd/CwosOCHa9DJjH5tMeMzk7P2mXpTPyj8X0lcyVX65X
         eHt1hHVWTdHsnX7he8W3Gg43AKlmvDU/D64O84cSbQxCCp0lVueFO+On7ik2T4TRT/KA
         k2g6l2w2FysPQCcH2+9TW15db8tEf5V06MBkuh+Lr+CgpsaJKWWkvkOTUkOlOyega45L
         0y9/69ogEIjkzg9k3bRDuq9n70FoYfoZGli+53pgMwA1WP2rxJlTTao9eTwfxAMP5X2F
         buNQdLZj1ddxDoF5/HedR/xkr3v3/MmhtaxPJEVLyIIsgmiuRTYZwwh0+CcygoSOrEk9
         SXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741095831; x=1741700631;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uj43tHXd4oUvGh93mFvuqSAi4hbUgB5iGKnK2cXXgbo=;
        b=a7hHNLCuH823MimDwUmC4k+uPwdAHET/iuPWr6of74L2xdPSL0HpA63/mqGUzQjYWj
         wJQmAACU4p+RaEC8oi/2B6KsVeWzpg9o3nU39+jwJ/+c15E/MBiAkHXFts15nudeAlE3
         rQhvegYv8v1RCjUqmf/cG3RGe7ynAjDN/Jh2WAzFMvSt5dQETU0hBJcJvQjQY33OldQ8
         x0DTLoEzUhnWF5VJvaLjM2XRmhX8OEc1fy9GtYdItX2lltZ9CPrjM0BFBsTaQFX+cwfZ
         0E31mlGrtK5vJow/DV4zuyX6Vg3X6amj8u8CdXCt3ZT2ml+0TvAlzMkPS4wYStppMpAG
         1n3w==
X-Forwarded-Encrypted: i=1; AJvYcCX4sW/pMPtuj+LavdvKdwcDXe86/R0w5yMK3QXngo5qFr71R8prkh4I36iIF2bI87ynvaLRtSZ6SbXA/CM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVbkqRoUCsQwS4yrzVVXSoPRJonBD6e0tkEcxpXO2qT6LfBqO5
	AwmEO7W6IrXQv0CKATheO51OwxnySRwvZt9MuASyPVHKbAUn6tr4U+eBtvMhVjyG8XN4x5oqplP
	jooYZKuOrQXOv5BphQw==
X-Google-Smtp-Source: AGHT+IFG5YXAtgs7Ad4x4+52R1NyxCiNTd9hIFuV0gbUB92z2vGjINs/6+xkAMSQEv2wr8uDuVNZWAe24g0ESfG4
X-Received: from wmij20.prod.google.com ([2002:a05:600c:4114:b0:43b:cacd:235e])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c8c:b0:439:98ef:5d6 with SMTP id 5b1f17b1804b1-43ba6766cddmr131565855e9.22.1741095831304;
 Tue, 04 Mar 2025 05:43:51 -0800 (PST)
Date: Tue,  4 Mar 2025 13:43:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250304134347.369854-1-vdonnefort@google.com>
Subject: [PATCH v2 0/3] Count pKVM stage-2 usage in secondary pagetable stat
From: Vincent Donnefort <vdonnefort@google.com>
To: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org
Cc: qperret@google.com, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

This series allows to count stage-2 related memory when using pKVM. The
value can be found in the /proc/meminfo field SecPageTables.

Changes since v1: https://lore.kernel.org/all/20250228121355.1377891-1-vdonnefort@google.com/
  - Flags to kvm_hyp_memcache
  - Separate stage-2 memcache
  - Account for PGD

Vincent Donnefort (3):
  KVM: arm64: Add flags to kvm_hyp_memcache
  KVM: arm64: Distinct pKVM teardown memcache for stage-2
  KVM: arm64: Count pKVM stage-2 usage in secondary pagetable stats

 arch/arm64/include/asm/kvm_host.h |  4 ++++
 arch/arm64/kvm/hyp/nvhe/pkvm.c    |  7 ++++---
 arch/arm64/kvm/mmu.c              | 18 +++++++++++++-----
 arch/arm64/kvm/pkvm.c             |  5 +++++
 4 files changed, 26 insertions(+), 8 deletions(-)


base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
-- 
2.48.1.711.g2feabab25a-goog


