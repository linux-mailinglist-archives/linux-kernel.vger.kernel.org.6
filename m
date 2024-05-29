Return-Path: <linux-kernel+bounces-194546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC798D3DE4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 20:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A8721C22367
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 18:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18F91C2312;
	Wed, 29 May 2024 18:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CC4UcVbw"
Received: from mail-vk1-f202.google.com (mail-vk1-f202.google.com [209.85.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5751C0DC2
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 18:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717005921; cv=none; b=ZgoyY6wSx2e2JYTkJGAt2ZHiQHNGeCjhAzTM2QtBfgde3XGVT6JWW+JQtcNAoR0Dp+P4MUU0ZmE3zLKTGgXHpxFVhpOJN518uFEEJT6sORTVww3ez90acl6DdmVNdYe4YA0j/NvcTmQFIoY3wKz5DiX4Fd4O8shYLEL3AxuLNno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717005921; c=relaxed/simple;
	bh=rClDOFeTBM3INZgvPf3xqhdotKn3Xjpsol6JPcgeiiY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dGAh8HlmrxGkIY0NCcXfz5uF7/gCPxg7qsz7A5QOWLsgjAkxwsQ7o68a2fjL/gdw0mtfttZE3SRVeRbIcaiIDK3ZlomOg3yIlH0VPlD8lWxOYfuviniAbw6qnG0ai4s5BWveV+5+eT977KY2r7L7AyPdEcKWaTD5EdgJb80yfgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CC4UcVbw; arc=none smtp.client-ip=209.85.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-vk1-f202.google.com with SMTP id 71dfb90a1353d-4e4f007b7beso20151e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 11:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717005918; x=1717610718; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nPLVZGS8AMw+CagEZYqGOZQVma0bD0XI55fQjmFacis=;
        b=CC4UcVbwULTuGVoAfXx6HOyqloX49BTtf0JjisU9VF0+bW40Ee1I0GJa9LZERIqQav
         jZ0hGCrSf3iKYqQM+gdaqIh/H627pYv4M8orIF9963maJRklsNYZeNECH4dEjdn/0bJp
         DFuQG38Gxpj0dI+k2CxVNgRbRTsv5BztRWfOiA75gndMG8g7IA/EsxbLX0qXPGjSucys
         POEviCxs2pZKLFZAKzX5/EgIzi/9Vqu82w410h4g+IAB/rih/pKF4372+HacUVhg/wX2
         8ODDZeFz1Vr08RzMm+/txHByVx7LqPO1iOGRSmSv4prndSwT91oVvkHk6vYGTxwWyAtr
         iwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717005918; x=1717610718;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nPLVZGS8AMw+CagEZYqGOZQVma0bD0XI55fQjmFacis=;
        b=PFiSwHMIo7LAk90cCmXdwQU7wGMbrEZxLMyWfyifwNIW5fVEu38Lqd/Kg6KdqAVbKE
         ArXca+i+bJl5G8Lvdz1NjKfzJRtVW26IZiaeuHeVgib3wgMg9L5lYtYy/2/jJ548pi+Z
         dT6qdxKn/ZkZUcj7jiR3faL1E35PBGEOA86TWCsOWSdRRZT6Z/Z3+XbTBuF8/ALhf59W
         OjlXpu2mBqsmkcvnKVaUujj+/t8+16qYzCFP1ZNOmzPpsAWeXHiF/khccgay8OHkc8b1
         rw5fsPEzvuTHgOvaNn9jCiWUpxqR7k08cOvu5oppci0KAcS6LsrX8rYSWWcJmzN1QV7Y
         edAg==
X-Forwarded-Encrypted: i=1; AJvYcCU2bo0DWbn7b8qD9EpJm68Sz6buVzJ8DCCazF/dzWOPBZG9YeDevCEsqB9cNRd6rhSs5J2p0OTnkbTSXSRrQdkUxaMyWJWDaRiz1Lgk
X-Gm-Message-State: AOJu0YyU1Qs5AX0w9KbpAv6HQbRw3KCLU4aj5jNFeGFtvfIZc6wOdL9U
	+Q86FtGIi51htqAHX39YEOBcYzGdDvlUExywA+i25Y8EUcTFRhQFzCYmqU71vQTlQchT9IKC26G
	zxvlUn/0DjD2Tvq4bBA==
X-Google-Smtp-Source: AGHT+IHYErK4IEAw4AodIy6/uS9D/1KylfkBeNLUgQvcCMlB4bZF6bJgSfUsGpPUaVK45i5PNzhTyn3VxbK8rZqg
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6122:2006:b0:4d8:797b:94e0 with
 SMTP id 71dfb90a1353d-4e4f0112182mr502860e0c.0.1717005918294; Wed, 29 May
 2024 11:05:18 -0700 (PDT)
Date: Wed, 29 May 2024 18:05:04 +0000
In-Reply-To: <20240529180510.2295118-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240529180510.2295118-1-jthoughton@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240529180510.2295118-2-jthoughton@google.com>
Subject: [PATCH v4 1/7] mm/Kconfig: Add LRU_GEN_WALKS_SECONDARY_MMU
From: James Houghton <jthoughton@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Ankit Agrawal <ankita@nvidia.com>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Bibo Mao <maobibo@loongson.cn>, 
	Catalin Marinas <catalin.marinas@arm.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, Huacai Chen <chenhuacai@kernel.org>, 
	James Houghton <jthoughton@google.com>, James Morse <james.morse@arm.com>, 
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Raghavendra Rao Ananta <rananta@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Sean Christopherson <seanjc@google.com>, Shaoqin Huang <shahuang@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Add this option so that one building the kernel can choose whether or
not they want to support walking the secondary MMU.

We want users to be able to blindly enable all lru_gen features to have
the best possible performance most of the time. Walking the secondary
MMU is mainly useful for be able to do proactive reclaim, and it is
possible that doing this can harm VM performance.

This option should be enabled by users who run VMs and also care to do
proactive aging/reclaim with MGLRU.

With this config option enabled, a user can still disable the
new functionality at runtime through sysfs.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 mm/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index b4cb45255a54..3ac4b1dbf745 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1222,6 +1222,14 @@ config LRU_GEN_STATS
 
 	  This option has a per-memcg and per-node memory overhead.
 
+config LRU_GEN_WALKS_SECONDARY_MMU
+	bool "Walk secondary MMUs when aging"
+	depends on LRU_GEN && LRU_GEN_WALKS_MMU
+	help
+	  This option allows multi-gen LRU to walk secondary MMU page tables
+	  when aging. This allows for proactive reclaim, but this can reduce
+	  overall performance (e.g. for a KVM VM).
+
 config LRU_GEN_WALKS_MMU
 	def_bool y
 	depends on LRU_GEN && ARCH_HAS_HW_PTE_YOUNG
-- 
2.45.1.288.g0e0cd299f1-goog


