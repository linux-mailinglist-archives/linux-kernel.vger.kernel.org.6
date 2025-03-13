Return-Path: <linux-kernel+bounces-559357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8150EA5F29E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F7031899D86
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E0D266EEE;
	Thu, 13 Mar 2025 11:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p97kCvOs"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FB8266B47
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866051; cv=none; b=u8l0tAcxAEhS6SwB1H3YbompyaQByT6dN0dVazjjHQLz2hWmKQp8D77jDxKwU4AHlbQIlK50FW8yyO0JMiU0wpOBE613zQvdRTymKghWJgH3GgmAKxFT/RLtk2I7XCOdEpCJCzjVPLuW73woAWLjgv9hjEdT2OZXbi78cAuDlS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866051; c=relaxed/simple;
	bh=Eh3Y5LXG17wzb3mkSprvbBwR21QXQxiAZRBUjytc0qM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ELL9rCNx3Jh4N+DNAauyDc8ND0qIvoPmCOOWtceyTuyvY5M+wwS1Sgq364sD0IkRkC52ioM7FW0ZswHhkprsuBSkdQ/CHHBPJn0/kV9PS0Me7VkDKvqV5r4sMPRd3wtgzh++miBGhnrI+7R8dSgfFyxG+bOKeVO78OH0VtGMSsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p97kCvOs; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43bd0586b86so6128735e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 04:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741866047; x=1742470847; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/j+Oz7cHBDK6gF/9kTqWJDu+O9+gPpwr8SGXRwE61TQ=;
        b=p97kCvOsfmhgnv7dWmMGxMl7+iq3LCXnMrVraXlnjfgBWouaK0In368SJsEm75bm54
         6duEomrl20LYdlcJ4Qz1ThpHWGSZR0/9OvkAxJHdM2eVWyoaMERV/STfnX5hKaMs4yZE
         YjOfqSovj4s7lX3DIx5qys62wD6YvkR4G8VT++P2J/FzMGucmhZxIMAckRUpj6QrH/Ur
         LyK/mZT0+GA6p8EjMgLBq+OEuzkUeuFqzKFohFkw3S+wMINt1oi0qlHK9kO3XHMvCM7t
         tSb3dk+zsPHCoJYHddj9vuPuw10HuBugf7TxAYMGzZjPIW6l7KR+KW1n9iSsg1gfAW0z
         5TLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866047; x=1742470847;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/j+Oz7cHBDK6gF/9kTqWJDu+O9+gPpwr8SGXRwE61TQ=;
        b=MGin1Zo9uPMQtyJpDibaqMLIijZMUdpqZ5uBJdgk2WrTXhu+OGs6frLnwFE321mQcL
         iiVC9XRVOLLiUSlfsuvNZ0p4/OjYjs5C0GEelfAxtPdFR8Ih4aAh11oSzGbvq3j03P+4
         ZmY+cuz4V01vGcPB+QnjniT6YGSUuzCGJcx/Ue75hn8nLOhbjbOirEeoWsGObJfRxQFg
         DhMYJuOqqt6L76/gG76cWitEwLIbe2ijfWc5u816mEdEO1eGRCUZ0ulchbq9aw6nOmXh
         q9r2d3sBLZZ+a8ola5fW6qXzGLefw7R/E64dWO+ZBKe/3wbVAc75miPF/CwYq4M9zTZ7
         1wYg==
X-Forwarded-Encrypted: i=1; AJvYcCUfKKtVUX23d36pm1vwgLAaVR4LcPwbkN7khMxaBOGge5GlqBoEsqqxJyrIqXeoCgyPesAO+xweo9lK23c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL3hVaXvXTbGQJqvkBkPhVrzqno1kxjiTgxLXgcmjcQlivl+F0
	QErPK1IDbtSZmxmTpffD1pHQYdHcD5vY6MjD7ccCSv8ifsqpW2ku+8qF+0vk5OO/LYASh9Ntczc
	lsMYI6ucV6Qwa0RZ2gQ==
X-Google-Smtp-Source: AGHT+IHT/XL50MODZw7JAAt6rGzgQd+Y4OENiN5kXRm9oqFCYFwRAIdO78t5s5DxhHV14BZpOtcnvF2TqxK+OAfE
X-Received: from wmbbi10.prod.google.com ([2002:a05:600c:3d8a:b0:43d:abd:278f])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5618:b0:43b:ce3c:19d0 with SMTP id 5b1f17b1804b1-43cdfb7db88mr180301615e9.29.1741866047681;
 Thu, 13 Mar 2025 04:40:47 -0700 (PDT)
Date: Thu, 13 Mar 2025 11:40:35 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250313114038.1502357-1-vdonnefort@google.com>
Subject: [PATCH v4 0/3] Count pKVM stage-2 usage in secondary pagetable stat
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

Changes since v3: https://lore.kernel.org/all/20250307113411.469018-1-vdonnefort@google.com/
  - Remove unnecessary void * cast (Marc)
  - Rename reclaim_guest_pages() -> reclaim_pgtable_pages() (Marc)
  - Remove unnecessary PAGE_ALIGN(pgd_sz)

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

 arch/arm64/include/asm/kvm_host.h             |  4 ++++
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  2 +-
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         |  2 +-
 arch/arm64/kvm/hyp/nvhe/pkvm.c                |  8 +++----
 arch/arm64/kvm/mmu.c                          | 22 ++++++++++++++-----
 arch/arm64/kvm/pkvm.c                         |  5 +++++
 6 files changed, 32 insertions(+), 11 deletions(-)


base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


