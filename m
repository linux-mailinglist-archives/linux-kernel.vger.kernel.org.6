Return-Path: <linux-kernel+bounces-256631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA68935147
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 19:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86C011F222B1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 17:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2313D966;
	Thu, 18 Jul 2024 17:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x6YezqWA"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D2763A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 17:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721324072; cv=none; b=TnDvLHqpUbO7vxdSbsV5jAQZNgDcWKd4lTrdOKaudWS5Lgggr1DSiXKe8vuF7BVGUmV+qi3rtUH6xz0hoVkH4S5YyFT66Aa4+GlywxC22tlG5pcd/CBvfQsUM9g9Jg7sxLl7LjNJ0g8XwlTbBH3/VOASibc/55UOpIWyB+iYlfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721324072; c=relaxed/simple;
	bh=CUHwvzK4V4eEqiHPrEkeBIjYw9V1Jkc88exvlaLUyxM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=f+dMf9gAKZNy5jDX13Fah3zXjElnWZGANW5eAuz0Z81SBdTMj+/sCEKhWy95Wyz2698H9ojYOFvMxh0fCxEt7MqsMlz6E+VlT339sIsn5G/ms1AXAifX7J9XSSALl9b8kyZVO2mWw78yb6PDkK9y2mGZ5rbFuCDZ7Jq4B3Fh6Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maskray.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x6YezqWA; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maskray.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-668e964ffd9so8400187b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 10:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721324070; x=1721928870; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2bPXOft7a0DVPxryCI2cNdVhhqnEsyUQPtbGOfbLI5A=;
        b=x6YezqWAa4S5Binalb9QJsf84vwlbdRKsk7YxvQv5dvmQcrZk9dmpV9LBNV0Nz/R7d
         CHjbTWZPM7+TSRl+ji0t3UYSdRf0zrug2FzPWUCLXbgSFWq0UaRr2GQMJVIUy0UfqUbX
         /IR3wv5x7Ql9PQyVHToD40qbk7c5DpMwGdTfAq9/s/NexL0Feru/ugnnpzIXtrt7bsRv
         eWA3Kmw9NbtszaycC2XzhsN2MtfjIIS4+zPRl5B3FO/31q3nrJ0nA9E14KSkKukkTSwg
         rHmdk8gATEveOP2Fmvmq+bCJLG7HiVi9C1RRylihbkaAcoiTR2+NmHjlY2Of6hs8dE2b
         9AUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721324070; x=1721928870;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2bPXOft7a0DVPxryCI2cNdVhhqnEsyUQPtbGOfbLI5A=;
        b=RgireM70PxPNP+LGR1dTrW9TftExuvkfqIKbtOQG2QwqNQBcUZePIRp2jAodEfODm0
         evq6lu6KkTah9icfckOl/TDDcR9IWnhqZQcWOrNbBAKmclAOJhfsxWqxHafzmvdyIi5h
         e/E6g1N6Z6GDQo/120x6vAkIt0hYBmAp0rGBzIN5tiRml33izd1INv8TtdqkhTLtZa4p
         jKwEkLyrlCRTPF6K2e+52sefnJ4yZvA6eeaGZ8xnpwFu1Jo3rUdy4DisZVDeJxQCqt7N
         mP5l8SjfD1cEVMYPZ1WyHvg0mxkDa2hmjNITV5olTwMzlcTAJGu7gFroj7JX0Juus5vV
         vNzQ==
X-Gm-Message-State: AOJu0YyirL9ReXCYhpfhpntDwLKWIrFSw3pdHBiDR7A7u9C/3I46qLtH
	3AYHi2HPbI4lPKkjt7UwdB0WaDjGX1lRynfZknC/R1UUZBCRFKL+2usy132zR3hrqnbr21LNJED
	56WXGmQ==
X-Google-Smtp-Source: AGHT+IFTq+/cpSAPzHRrHWCy4g9drFEpQsAZ1O48hw2tifp6CjMKfyB846WCIKQEGoJuuPOHlISWzdbhuGbb
X-Received: from maskray.svl.corp.google.com ([2620:15c:2d3:205:3158:f77d:549c:7b32])
 (user=maskray job=sendgmr) by 2002:a05:690c:3:b0:650:a16c:91ac with SMTP id
 00721157ae682-666040cca3amr2358647b3.8.1721324069699; Thu, 18 Jul 2024
 10:34:29 -0700 (PDT)
Date: Thu, 18 Jul 2024 10:34:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <20240718173423.1574395-1-maskray@google.com>
Subject: [PATCH] arm64/vdso: Remove --hash-style=sysv
From: Fangrui Song <maskray@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"

glibc added support for .gnu.hash in 2006 and .hash has been obsoleted
for more than one decade in many Linux distributions.  Using
--hash-style=sysv might imply unaddressed issues and confuse readers.

Just drop the option and rely on the linker default, which is likely
"both", or "gnu" when the distribution really wants to eliminate sysv
hash overhead.

Similar to commit 6b7e26547fad ("x86/vdso: Emit a GNU hash").

Signed-off-by: Fangrui Song <maskray@google.com>
---
 arch/arm64/kernel/vdso/Makefile   | 2 +-
 arch/arm64/kernel/vdso32/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index d63930c82839..d11da6461278 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -21,7 +21,7 @@ btildflags-$(CONFIG_ARM64_BTI_KERNEL) += -z force-bti
 # potential future proofing if we end up with internal calls to the exported
 # routines, as x86 does (see 6f121e548f83 ("x86, vdso: Reimplement vdso.so
 # preparation in build-time C")).
-ldflags-y := -shared -soname=linux-vdso.so.1 --hash-style=sysv	\
+ldflags-y := -shared -soname=linux-vdso.so.1 \
 	     -Bsymbolic --build-id=sha1 -n $(btildflags-y)
 
 ifdef CONFIG_LD_ORPHAN_WARN
diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index cc4508c604b2..25a2cb6317f3 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -98,7 +98,7 @@ VDSO_AFLAGS += -D__ASSEMBLY__
 # From arm vDSO Makefile
 VDSO_LDFLAGS += -Bsymbolic --no-undefined -soname=linux-vdso.so.1
 VDSO_LDFLAGS += -z max-page-size=4096 -z common-page-size=4096
-VDSO_LDFLAGS += -shared --hash-style=sysv --build-id=sha1
+VDSO_LDFLAGS += -shared --build-id=sha1
 VDSO_LDFLAGS += --orphan-handling=$(CONFIG_LD_ORPHAN_WARN_LEVEL)
 
 
-- 
2.45.2.1089.g2a221341d9-goog


