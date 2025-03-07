Return-Path: <linux-kernel+bounces-551002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F263A566D0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8E2217593E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB287217675;
	Fri,  7 Mar 2025 11:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TD+a4JAJ"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A4420B1E7
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 11:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347260; cv=none; b=GBlQAHaIhkQMYA99mcsEx4OKUlGiY5K/+TzjcB1INOno8pVnqc8ECgWWrVnLQximMyx3rbde1lhAHkFJy9AL7JswNKhDPpXbGjn8/vFgMYxIhg1WyVhItmczEHspIeFzyI3bJWgKxVMRiESHLW1gZ4XmAr0XSTSxhvq7VmPE49g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347260; c=relaxed/simple;
	bh=mc8GdzR9S6fQkS0ghgXW9r2iwc49GNMDkYndkVxx+To=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JJKpQO7moNcbDVSjepJc7WDbE+un0WgUNCcRmD/Hqbx+6h4bqqOtEmqalGblN/E7GnwpG6uHef4eUs9wQa5bAqyIVysGHDHsJGixUD/k4V0jGvNngMwbYvTWH3XOZxCUXorixv2CF1/DpvFt7PKSeCb754uGhnPYGVeAHY9tpD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TD+a4JAJ; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43943bd1409so11870225e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 03:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741347257; x=1741952057; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gWRrS3x4cauUfBmtdb7CWhXFgQlJhhYmJ5IHCDodbtg=;
        b=TD+a4JAJgyVT/vfEf+d0YdptUcg15GthJfeCmFmgN0uN89UaK9nTy2CD/q4RSn9jfW
         MyO9Q4I+JE3qhLOZUPRnLP4UOyMIYhRedMJWAgNkAt2CWFUA8CIic5+d3xhfGgnctd9a
         6ncQRwdGOsdCXBQJY8ZUX8oQLmgnwpJQshoc7ap0cR5nX/NhEOzRObjlaTCups6uf+Qq
         MZ3nnXj4KiCO8MScMnB1+LX6moTiMXdPLiFJOPYK1QMJ5SLDThQSLHCV+A28CiKto7IU
         WtVaW4MwQIUDUIp4ThTRHh8u3dMI1ECkb2xy5twdCyC5eRaw0HrsbJbZL5TR2Rjpen2i
         TVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741347257; x=1741952057;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gWRrS3x4cauUfBmtdb7CWhXFgQlJhhYmJ5IHCDodbtg=;
        b=vvJ0AXZqDnuvLqQW3TtennQCrLcHMgFvRA2uuRh1YXY9wkH9le2Mit6WBv0fRTXAJ9
         fJgrzwFt9iO7H6bz/b4fGS7cNURnHJlVmHurNPhugsIF2JT+DA+75UqMG5N9YdmSYL0n
         y+XM+Dt6T/P/UPtMR8irslADhYKws1gvLSU7F/PedVzYWuhMSkW35Tl043+WJqvzin04
         pbjo1WbibVuiroYML68ARB+ZoFbR6zZXIBg4fWvzI8B9MAAwQ+A+GBxHV9TMslCaz0u7
         QkHX5B6xU6LWf2bccB5hvq8iTSypJ7P3PWGbC7QVQEXkTd/lTcB4GUnZPFoTzKND64N9
         hycg==
X-Forwarded-Encrypted: i=1; AJvYcCWadbf1ylj4HetpH4t1eyujNU16nSiLjbY28ZsEe6he4A6bZ6WdUDJy0mtFUYBVbiUKmAEf1roJVPETMNo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqsu+Oodwtum4Dae4dYNqwrrYY1d7XU/GHKEuJcFB7Zeom/BNx
	fhiWCnbqfdZ46JMtA37XR7x614NAChczCM2J0lwcHVwhsh8K3r/AnzAlYK8Zc6jjdBSdIgq6omo
	Fac4ZHMNeXOQV9ojcMw==
X-Google-Smtp-Source: AGHT+IHPB/BavFeiIuU4jP5ze2ourrXrXM89F+RxMJStp6R8CgJywz72d2FJ/8Pyx4rbvot/9rkDeqVmllP9YyEi
X-Received: from wmbhc25.prod.google.com ([2002:a05:600c:8719:b0:43b:d212:f974])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:198f:b0:439:6101:5440 with SMTP id 5b1f17b1804b1-43c5a5f7050mr20681135e9.8.1741347257113;
 Fri, 07 Mar 2025 03:34:17 -0800 (PST)
Date: Fri,  7 Mar 2025 11:34:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250307113411.469018-1-vdonnefort@google.com>
Subject: [PATCH v3 0/3] Count pKVM stage-2 usage in secondary pagetable stat
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

Changes since v2: https://lore.kernel.org/all/20250304134347.369854-1-vdonnefort@google.com/
  - Pass a pointer to kvm_hyp_memcache instead of just the flags
    (Oliver)

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
 arch/arm64/kvm/mmu.c              | 22 +++++++++++++++++-----
 arch/arm64/kvm/pkvm.c             |  5 +++++
 4 files changed, 30 insertions(+), 8 deletions(-)


base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


