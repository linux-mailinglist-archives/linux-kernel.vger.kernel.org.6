Return-Path: <linux-kernel+bounces-538322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C80A49729
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AE553A5259
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA4A25E464;
	Fri, 28 Feb 2025 10:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C2wYK25d"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFC725CC7A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740738347; cv=none; b=adZ3YsFuRQxzuwjFc8AEDgqJJK2fI3MAifJ21u7Go351gkXMyt+h1FYgjUbK2uOD5GWDfK5Y0lvzs1Xw+ncfIfvzQnYO8g0gvid0zHPbhlqJDpjoGPj+ghU3HNH4wWBU8dNYztN+88kQa6vKFe65eXT+4WSxVfEENDAtcZAe3bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740738347; c=relaxed/simple;
	bh=BWZCnyWZRcFFgGDc2fMhBTLM/sH8dFOBJJTpn5YiH3M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=s8VzNr9b4Y2/wVmJBkhyW9DawZdCYf/NCfXfvVGIK3z0iJsyQ76QXLZGLlw5Bh5RPz9E/ihPbtyVOf3C1FlBoCak6XDzlyAdd+0XetVCS8+7QKXKV537jHxk5n2aYKUEvyGZzooJloTAh2drkT6giyk0kdMhtQZrRL0S1Ii9sF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C2wYK25d; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4393e89e910so10939645e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740738344; x=1741343144; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yZiixOEWYaq9wXDNP/eyMuN3kYA78c0bj/N2a/BCkL0=;
        b=C2wYK25drnNVtOn5ZJJPMar+bzCJgWMifmMiFifTu5qds3SxjvgSuJd96x6rbgwCdU
         miKkOdsAe+3EgDrd6PC5G1neIugTkwCtBBULm8pSK6/u8rMON159BcVXb7By8UiVcMEG
         yLF7lVcTB+qSSq3v9sLMQUFpXq4OWWo3QZBjzM7rfzYR8ThAhSEed1P6PNLRac5bm5S/
         dQPsLU7rJvMqk1e5P+arjRktyKrX/Es3hn3uGPbulWBxGuQBangYFBAtgK7WyyOVcMJN
         TLfdXhHxc3gMJpOO66E2cW6rGEx/D/GJRgZaukqtDIxJGEQD10bvFFLBVWlbaVmH0ORV
         10/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740738344; x=1741343144;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yZiixOEWYaq9wXDNP/eyMuN3kYA78c0bj/N2a/BCkL0=;
        b=ND5HscZFXrEthlIpuYtuNwGwpupfY8iYyKN5++Erq7RhdrMMmFhZrczLeRGJ2BDF2Z
         4UvSYnPO0BiLiAMRVnPoavRAiMYEhU6tqKrMvwg/VUeQdx/DfWgCKqJz9UNEQT7VObHW
         2620ZF2lzbyTVDDpm5mtdF9CBF72uh7WwSR5larHGW2RmZm4kYePovwa/M0L9hX1Nb5c
         4LhWvIcqb5qIKN2n9OE187WJu/3pc2qYdc6FVYtIbss9b/fEkb0x7JMR4HFl0lZj9vJx
         ldxZsIGCuYD1QzWxyYDji+k3DxaEeOVB1PkRYGU3bXQ4kLLZdNoE9Sgqz+OF0fek2tP2
         yh5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUKy/Layczh8k8cl3fq0A+GLZjCDYMkPZgab231SAjuJzYfK5jD4yEr5lt/ugwg99sAa4pZJgsQr1BUYIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw51tChynDrjYovS8KUWzkwWpRtplvJvkVkzR9zGsPqqsRAh/iX
	Nne33oI0LNi49DP4xkrepZW8QKJGs/aVz5qSxSYnZa1BpIvm5PKXuRkZQitr4hTyzIf5PmpRH0i
	LC9QxGjMQVa4KkQDUGw==
X-Google-Smtp-Source: AGHT+IHep39Sd5eGh94BVx9flL1lcXtt9eAIYrt+u2ImlSXt8vPoiGgYIDF5HPduTl3nT7mvrQjfLoUwEOlBu9qB
X-Received: from wmbec10.prod.google.com ([2002:a05:600c:610a:b0:439:804a:4a89])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1551:b0:439:9f12:1809 with SMTP id 5b1f17b1804b1-43ba6766c16mr20538485e9.20.1740738344390;
 Fri, 28 Feb 2025 02:25:44 -0800 (PST)
Date: Fri, 28 Feb 2025 10:25:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228102530.1229089-1-vdonnefort@google.com>
Subject: [PATCH 0/9] Stage-2 huge mappings for pKVM np-guests
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

--
Vincent

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
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 218 +++++++++++++-----
 arch/arm64/kvm/hyp/nvhe/mm.c                  |  86 ++++++-
 arch/arm64/kvm/hyp/nvhe/setup.c               |   2 +-
 arch/arm64/kvm/hyp/pgtable.c                  |   6 -
 arch/arm64/kvm/mmu.c                          |   5 +-
 arch/arm64/kvm/pkvm.c                         | 129 +++++------
 11 files changed, 326 insertions(+), 157 deletions(-)


base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
-- 
2.48.1.711.g2feabab25a-goog


