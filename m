Return-Path: <linux-kernel+bounces-548720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B000A54899
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AFBB1895BDE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83C320297E;
	Thu,  6 Mar 2025 11:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UVPOFh1A"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50351624C7
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258849; cv=none; b=Yu9XGy+EPeufenzDGUxQXVeuSlnDRRJBB2YmRfc6/sksFxxd7Y36iISR5+NXs24zp/KFsW5nP9OSWqGRUFrn2vRhcTpH15nYZpuKRyjsxvuGy5u62/2FHgCTNL2Q6CeqwNffvTM5aceD7EXVFqY1C+YCiTSnWcwj1qHd56VPavw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258849; c=relaxed/simple;
	bh=cXOUGzXJisDnk0/ye+2VvQdHhCVvaIPyZYsa3alQEpw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=irtsYN8aJL8eq8xAoePYjDV7KogWUewCyxzv2tKKVlRVwevTypl+wu0DvVCsf4RhoDDxjQqQZ6Hob3IT5F3FUQ6xfTS2GKzGLd6VOx9YM59ZUuWVVV8CnGXhopLeScpPz3XPNa73Ovg4ua4H6JBHoTdgfMlibQDRxB7s+dfCGeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UVPOFh1A; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4394c747c72so1942255e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 03:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741258845; x=1741863645; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PvJOjZ7gASzBfvYGoJZPS5obCWwIrSTS1iwOGHLb12c=;
        b=UVPOFh1AM1lqLn5lwZjzhSDMo7OuZ7OARe5FaTDQ+GjKoFJ8p6bYX3vQPZ+Jm09+58
         x2t2uuvAadptpwIizJCLchtp4Di/Bk7T0aNWDqG+xdJ2veki7Dh9whZiu3x8Z0CTdEFS
         zilXY2v8UPWKzW1UPYb62wQGbbvBdv1bQHAO+Gen0sVot1O/tHQn79KcX/Y4Hp2xnRBB
         g8nRx0BYezmKJhnqwM9MU12QuJgksaypMer2orKV8cjYM+vimMyjzoVJXAr9SHFm24JH
         /SvIqEhGuae1B+Xvbd9UPMy/Qy8Eiu48TFSrCOj6/47LBBhqCilNl4fvTBPyp7YFE3Ap
         kR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741258845; x=1741863645;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PvJOjZ7gASzBfvYGoJZPS5obCWwIrSTS1iwOGHLb12c=;
        b=GJHK6ES2rpD60xcFVOt3OufzU9BlIw1lUVExeOVRtZa5Lic5v5P2OrZRGxukxssJas
         h1lBcBAOZ4l1T94KtA6yZwQScYmPgChGIMCgrm+23wecscPoE+gXuSUf/ZkN6Htp51TY
         h49X4Gj/iCDVYmKkdkehc1yW3Dn5ta6tISBZCWAgtTqrVZv57YY3JBBQZdv54w39ZRiA
         ZTxvpU4pjOjTsrqpl8yHKQ6+LHdZL58v6gKkD6nhe2fPPK8Lf4D1J1CIirORld74F2BL
         1p1LvbmnbwkSVEJ+FibHZP6NQ0TC+jm8uN3UANl8TNSfu+4cI5o8HoC75JJRZBvYlFBd
         kA7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWRUvagqSiTzQvEM1jcVeQgqaUaRiwBSFvutlm9OaBeC1IqJPpdh6WbwoMEoYsIQlSp1JAd5uJG3MlJzyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKGG5S0TFdmDHn/81wMej213lsdRAF6tblb77z6sBdIsmJRstR
	h5Uxkf+1Srh/vAxYipfhvUpLSxyuj+b1zAprTddyxvJvfGMA4UQSVUadwu6IbaXaBKlgDm5gNMD
	7n233lwoqzB+MRtCxhw==
X-Google-Smtp-Source: AGHT+IEGIm+qxrHFi7YMwd4v2mWCai/lo65N8Xe9xbdmYtOuCPL/1azW8IfDSK4oVWN0pRfPGkpSLhGS4zv1Dg9I
X-Received: from wmbet7.prod.google.com ([2002:a05:600c:8187:b0:43b:c6a4:89a0])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:190f:b0:43b:b756:f0a9 with SMTP id 5b1f17b1804b1-43bd295286dmr61943825e9.11.1741258845390;
 Thu, 06 Mar 2025 03:00:45 -0800 (PST)
Date: Thu,  6 Mar 2025 11:00:29 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250306110038.3733649-1-vdonnefort@google.com>
Subject: [PATCH v2 0/9] Stage-2 huge mappings for pKVM np-guests
From: Vincent Donnefort <vdonnefort@google.com>
To: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org
Cc: qperret@google.com, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi all,

This series adds support for stage-2 huge mappings (PMD_SIZE) to pKVM
np-guests, that is installing PMD-level mappings in the stage-2,
whenever the stage-1 is backed by either Hugetlbfs or THPs.

The last patch of that series is an optimization for CMOs using a shared
PMD_SIZE fixmap.

Changes since v1: https://lore.kernel.org/all/20250228102530.1229089-1-vdonnefort@google.com/

  - WARN_ON() on !PAGE_ALIGNED size for guest CMOs (Quentin)
  - check_range_allowed_memory() before accessing the Vmemmap (Quentin)

Quentin Perret (2):
  KVM: arm64: Convert pkvm_mappings to interval tree
  KVM: arm64: Add a range to pkvm_mappings

Vincent Donnefort (7):
  KVM: arm64: Handle huge mappings for np-guest CMOs
  KVM: arm64: Add a range to __pkvm_host_share_guest()
  KVM: arm64: Add a range to __pkvm_host_unshare_guest()
  KVM: arm64: Add a range to __pkvm_host_wrprotect_guest()
  KVM: arm64: Add a range to __pkvm_host_test_clear_young_guest()
  KVM: arm64: Stage-2 huge mappings for np-guests
  KVM: arm64: np-guest CMOs with PMD_SIZE fixmap

 arch/arm64/include/asm/kvm_pgtable.h          |   7 +-
 arch/arm64/include/asm/kvm_pkvm.h             |   2 +
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |   8 +-
 arch/arm64/kvm/hyp/include/nvhe/mm.h          |   4 +-
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            |  16 +-
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 236 +++++++++++++-----
 arch/arm64/kvm/hyp/nvhe/mm.c                  |  86 ++++++-
 arch/arm64/kvm/hyp/nvhe/setup.c               |   2 +-
 arch/arm64/kvm/hyp/pgtable.c                  |   6 -
 arch/arm64/kvm/mmu.c                          |   5 +-
 arch/arm64/kvm/pkvm.c                         | 129 +++++-----
 11 files changed, 342 insertions(+), 159 deletions(-)


base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
-- 
2.48.1.711.g2feabab25a-goog


