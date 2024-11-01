Return-Path: <linux-kernel+bounces-392882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CB29B9940
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 21:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65ACF1C211C4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B691D89FA;
	Fri,  1 Nov 2024 20:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EjCck6oN"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89B4168DA
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 20:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730492083; cv=none; b=TcRwcD/a/UbhHSrvIxoObsQMCqCeuK3Vws6udAxd0LRq1DkicYX00LfTPSpONhMWLS12myS+kKNO2FHPBwsB0SYMrKefcR9Abd+CONFhuJdxQtggltmIlydM20FLnK1CruzGSVXGHDCIM0ndJRGS+tSlYMNTd+k4fEfjHKxJWy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730492083; c=relaxed/simple;
	bh=YsHBQjVeukgiF0mLVyQ7z49qSKbNAlnQAGKQrAS+u9c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ojXwnA3KLXzTO+f/pBu+HMDNVPIvFeYvtNNjHJMIyvRWRwQV4vKyEjNjF5gZu9SCiAzRbFLx8U1QMMYBn74/HiURMqIFqyubwu7t2XU6afGrNsORcwy+ZwZ5zJfTEAK0Iuo4hHCfDiwJwjA2qXj+JEWkA3GcvUwOHXToXRwQiEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EjCck6oN; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02fff66a83so4037445276.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 13:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730492081; x=1731096881; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wGf4kfRu+fiBCGnFRgjw7Tn3sict5XvT3MA9L9ZNqdw=;
        b=EjCck6oNYShMUXpHCLHUPUtv+RF9yCCjxCQsDWCLSYwg9qYKmZ/otM/5gHs0vJTbMn
         JOU9KKVWIlibAnKxPdxGpXRcoSzuaF6bt81/0Vxg8tls2j+YQ8RqdTH+VVru3Brd/ZIi
         rKtybK1No3otz/6Ob5bOJCvfIZoUvMJp126tWb6yaaJTe/+sk1Ml3QLZcPeSxauYknNl
         q8OTadSqx27s7XEnx3NHe6gIJtJvSxnxG2mp70fsQ5KiATYJVKpRSxoghqldLFmPFy2X
         sizY2CnC+IbWlTDhxQEcrfhyWNpaFtFj/0T1CP7uptrks6VcN8yCl3u5Vn+zNLvMB0Vv
         aJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730492081; x=1731096881;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wGf4kfRu+fiBCGnFRgjw7Tn3sict5XvT3MA9L9ZNqdw=;
        b=CHd6E0Une/LkdtT5nNaxgm5dW9KA821F9N7/6S7W06BVq6Y+1IDWsiqjGaPbGKJb7r
         b2Uqdel/K9V59gVkwKLsNw1Oyj+Nozq4vHIDTyFHqjFmCkFpWqu9nerE4WZXlfMw34xX
         JqMh1XntJqLNLXVAeF7DSclfbAnC3JQyoYMIrC+a8GG5hT408S1HHc8mfbjpVldB+iIi
         DqJRaWbJdWUXUHb6GIviMt+DxzRNEIE1OHtq5y4+2gETkPkiKJJLc5z0fjJcQDiiUJXU
         nUlHfQAW8KzfL+++ILzUxbRSw4ZHivGen5N7BtzWo0T6WYu8eXN/kGTIcQIfh7aKanjN
         lB1g==
X-Forwarded-Encrypted: i=1; AJvYcCWBj1t2ncfc/YfrvpuihsAbhJ4XAllj5qz1/T23HalC2KiLBJqoGNQ0oRkHL6j7Gr8JR0pXIc6ESNaAcqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhGSJ2uzccwwepLV6jyIJ1wiAxV0Ajmvn8o5d0RTvqlL+xdy8q
	BgfgXiYFbmMoknc16rp6Jw37XcgSiqpmNlOktqlySFL1jPxONjYmy9apLzKzEXGq1jxSC214qdw
	3hcIBwQ==
X-Google-Smtp-Source: AGHT+IFKUq9UkCVnquHIeEnY0lt1SY9kCSyOVPlXg3Vgcx53r7lvlzqQBkEIrxYj/oMvI7EA/qtTa8TDA+mB
X-Received: from vipin.c.googlers.com ([35.247.89.60]) (user=vipinsh
 job=sendgmr) by 2002:a5b:7c5:0:b0:e30:dcd4:4bc with SMTP id
 3f1490d57ef6-e30e5b37923mr4697276.9.1730492080765; Fri, 01 Nov 2024 13:14:40
 -0700 (PDT)
Date: Fri,  1 Nov 2024 13:14:36 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241101201437.1604321-1-vipinsh@google.com>
Subject: [PATCH v3 0/1] Remove KVM MMU shrinker
From: Vipin Sharma <vipinsh@google.com>
To: seanjc@google.com, pbonzini@redhat.com, dmatlack@google.com
Cc: zhi.wang.linux@gmail.com, weijiang.yang@intel.com, mizhang@google.com, 
	liangchen.linux@gmail.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Based on the feedback from v2, this patch is now completely removing KVM MMU
shrinker whereas earlier versions were repurposing KVM MMU shrinker
behavior to shrink vCPU caches. Now, there is no change to vCPU caches
behavior.

KVM MMU shrinker is not very effective in alleviating pain during memory
pressure. It frees up the pages actively being used which results in VM
degradation. VM will take fault and bring them again in page tables.
More discussions happened at [1]. Overall, consensus was to reprupose it
into the code which frees pages from KVM MMU page caches.

In the previous version of this patch series, it was decided to just
remove the shrinker and revisit feature to reduce vCPU cache size if
someone has a need.

[1] https://lore.kernel.org/lkml/Y45dldZnI6OIf+a5@google.com/

v3:
- Remove KVM MMU shrinker.
- No repurposing for any other use.

v2: https://lore.kernel.org/kvm/20241004195540.210396-1-vipinsh@google.com/
- Add a new selftest, mmu_shrinker_test.

v1: https://lore.kernel.org/kvm/20240913214316.1945951-1-vipinsh@google.com/
- No global counting of pages in cache. As this number might not remain
  same between calls of mmu_shrink_count() and mmu_shrink_scan().
- Count cache pages in mmu_shrink_count(). KVM can tolerate inaccuracy
  here.
- Empty mmu_shadow_page_cache and mmu_shadowed_info_cache only. Don't
  empty split_shadow_page_cache.

v0: Patches 1-9 from NUMA aware page table series.
https://lore.kernel.org/kvm/20230306224127.1689967-1-vipinsh@google.com/

Vipin Sharma (1):
  KVM: x86/mmu: Remove KVM mmu shrinker

 arch/x86/include/asm/kvm_host.h |   1 -
 arch/x86/kvm/mmu/mmu.c          | 111 ++------------------------------
 2 files changed, 5 insertions(+), 107 deletions(-)


base-commit: a27e0515592ec9ca28e0d027f42568c47b314784
-- 
2.47.0.163.g1226f6d8fa-goog


