Return-Path: <linux-kernel+bounces-296819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4230595AF78
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F38C628439E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22C0175D26;
	Thu, 22 Aug 2024 07:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="j/PiB3V7"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB0F1537A3
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724312411; cv=none; b=cEDuzpKgtflAFyc1uMJUDBYr3wEbFJEGEpwbPOD1uiMuKU/tw/zCdFF1NryJm+qmFlUFVjM5TBgZ8SqKthw8IZa4TzplzIyyDKznpcg21ABnxvuAJHbl6aoTzCRK5REX/BCP4iTV1ol2kNsd8Cxf2cOEeQdWoDZj5FN00r8B6KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724312411; c=relaxed/simple;
	bh=dl8YRiLGETojca4YMVFZCFR9mmCL3NBS5XVUDdojMOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RQndWy6y7aW61B1qvq73eoJ58vPRAmB8b+lmkZxT/YAzuKcjBFjnjOOAFwzDF9iY3WX9/f8XUvqCdaEkemeMbPj0kQWTm5vRLXZdh1HPG/BgtPyduyIirhTbYFaLvILtVy7h4Ht2CV8YVqWlBR8wETZ5RtrW5wN4O2wRzxfxbVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=j/PiB3V7; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 47M7d7s52176365
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 22 Aug 2024 00:39:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 47M7d7s52176365
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024081601; t=1724312351;
	bh=umQV+5NHE5EVNtQ5FvrJjhZ2uq6cVuv3BfDZFqOMfoo=;
	h=From:To:Cc:Subject:Date:From;
	b=j/PiB3V7QKoBSW8D73ibSQVI/fp2QqkjV7T/5WJcyqdSqGxqYnvf6NfUiZ7tkQ6LW
	 85nJ4UBs/ImpWlc2XCwyxSBNR/l059fK59hyysffnxlbRFv/cqak0VTcnGgJ47bp4g
	 1Nbo6OIHU/knXXOX0DlVgo+vnSSYMNzSif8TGHyAftrLliR3y2ABob5e04ZeFT8Ejy
	 r/TFrwOZUCGjWmPXrtxRMoaLs5bmviHdaNXWIzUFpyo9vZblgwYEXH3GA34g2CpBdZ
	 rHm4K8PP7Pu+MzAOkAEjUXCmRSs3er+r4hGCcsPna+z7v2jkLX4yRPpVpzoaX8hWuM
	 H1TJNlzHBnZVA==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, andrew.cooper3@citrix.com, seanjc@google.com
Subject: [PATCH v2 0/3] x86: Write FRED RSP0 on return to userspace
Date: Thu, 22 Aug 2024 00:39:03 -0700
Message-ID: <20240822073906.2176342-1-xin@zytor.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set moves writing MSR_IA32_FRED_RSP0 to return to userspace
from context switch.

In the discussion of save/restore host/guest FRED RSP0 for KVM, Sean
proposed to have the kernel write MSR_IA32_FRED_RSP0 on return to
userspace, i.e., arch_exit_to_user_mode_prepare(), instead of on context
switch. [1]

hpa suggested to test ti_work for zero and then process individual bits
in arch_exit_to_user_mode_prepare.  And a quick measurement shows that
in most cases, ti_work values passed to arch_exit_to_user_mode_prepare()
are zeros, e.g., 99% in kernel build tests.  This zero test change was
then sent to Intel 0day tests, and no perf regression is reported.

Besides, per the discussion of how to write MSR_IA32_FRED_RSP0 with the
introduction of WRMSRNS [2], use the alternatives mechanism to choose
WRMSRNS when it's available, otherwise fallback to WRMSR.

[1] https://lore.kernel.org/lkml/ZpkfkSMPiXrS9r2K@google.com/
[2] https://lore.kernel.org/lkml/15f56e6a-6edd-43d0-8e83-bb6430096514@citrix.com/


Andrew Cooper (1):
  x86/msr: Switch between WRMSRNS and WRMSR with the alternatives
    mechanism

Xin Li (Intel) (2):
  x86/entry: Test ti_work for zero before processing individual bits
  x86/entry: Set FRED RSP0 on return to userspace instead of context
    switch

 arch/x86/include/asm/entry-common.h | 13 +++++++++++--
 arch/x86/include/asm/fred.h         | 21 ++++++++++++++++++++-
 arch/x86/include/asm/msr.h          | 25 +++++++++++--------------
 arch/x86/include/asm/switch_to.h    |  6 +-----
 arch/x86/kernel/cpu/cpuid-deps.c    |  1 -
 arch/x86/kernel/fred.c              |  3 +++
 6 files changed, 46 insertions(+), 23 deletions(-)


base-commit: b34bbe44b8222d43d6311d5caa1226ebddda4bfb
-- 
2.46.0


