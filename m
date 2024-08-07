Return-Path: <linux-kernel+bounces-277335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A205949F68
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99C5FB24EB6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 05:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4928197A97;
	Wed,  7 Aug 2024 05:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="V5/QXc+I"
Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AF119049C
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 05:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723009841; cv=none; b=hv5cRRI2A9g4wcmrq2RJS8NgD32qS06QhOA7pTTViOf9r/xB1huy7elqQha6XjAbZAl44cCbbOFoJkZtToeJHjEM16NOi5Odi4fvB3eusisS9tAvpxuDk60U2XHmMH8kOa20aonas4PiFonMUNayKcRKzBm+jICiwNCKxcNRynA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723009841; c=relaxed/simple;
	bh=febvQWaZnqmdad7PGnnrmMnHJdXRPeGNOw4hR8Lnm3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZSZh2vxYIqjCieeI/VIon5VooO2b+rUNcVM8SFi2kK+LMicYBAq5Upaf39QQv/djQ6iQpAWEIDuNfIkWzVad7aT5tXAbGbZ7ANxR0Ik8JIUbT8YTPhrhNc8AdH0VXuMhmIk2X1z725S9FH/utX+HY8hMM8ZOvTP9Ru90Dl8kS7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=V5/QXc+I; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 4775lNim682395
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 6 Aug 2024 22:47:26 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4775lNim682395
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024071601; t=1723009647;
	bh=iTY45Cvu/zFVlNAp6GmlzGeApLzxLn6O/c984yX/0vs=;
	h=From:To:Cc:Subject:Date:From;
	b=V5/QXc+I4POga6/ygwQEroTohbztJWpCCk6v0QST2y5YgdqYsAgoS+acXMzTD+y6H
	 6CjF5hLmsSs6COhs/Pruo0OqD3USiVQ5D8MF6L3+fZ4YfKahD28hJgAwOA9NRYJ8RL
	 GGezInLYTOYyuexlseGDLh70qFexpwDeqlwaInUKQz/qHrAXHeQW5Ib4uMlLOR8X0l
	 Kz2Nuq0cJfU/6L0TqCovmRmmHKjc4zv56yIp8q9Ip1KXHN9xhTkrY2pmtj5wYSOsO9
	 +sMWZpLvkTN72+f6LN2BILgGxrQrPn+r0yCKuDPNp2j49jniBEs85fmBHKEqyKZjyA
	 IdoszQUbf9/mw==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, andrew.cooper3@citrix.com, seanjc@google.com
Subject: [PATCH v1 0/3] x86: Write FRED RSP0 on return to userspace
Date: Tue,  6 Aug 2024 22:47:19 -0700
Message-ID: <20240807054722.682375-1-xin@zytor.com>
X-Mailer: git-send-email 2.45.2
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

 arch/x86/include/asm/entry-common.h | 21 ++++++++++++++-------
 arch/x86/include/asm/msr.h          | 28 ++++++++++++++--------------
 arch/x86/include/asm/switch_to.h    |  3 +--
 arch/x86/include/asm/thread_info.h  |  2 ++
 arch/x86/kernel/cpu/cpuid-deps.c    |  1 -
 5 files changed, 31 insertions(+), 24 deletions(-)


base-commit: 9ebdc7589cbb5c976e6c8807cbe13f263d70d32c
-- 
2.45.2


