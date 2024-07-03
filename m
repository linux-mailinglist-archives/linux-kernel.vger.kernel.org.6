Return-Path: <linux-kernel+bounces-239084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60ED89255F8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9230C1C248B2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 08:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D238313CA95;
	Wed,  3 Jul 2024 08:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="n4zN+OEU"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32A813B5A5
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 08:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719996912; cv=none; b=je9JkZD9rW+sFUxmo0HdY2+zEUteimf2yuQN9K9xQQ+otc4rE7Mpt5Go+Keqf+KY8cLqP2wdr0/B+u5IL8RdBemsGYI/ZTQ9v2nLJBLEdl4y1p0yK7WHctFU6L1qY1tN5DT0hiHKg+5T32CTLXQVFll4yC6qzjIqRzgea4OPRws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719996912; c=relaxed/simple;
	bh=Ukxmgg0srBdOTa7AcFstIUg77+VdPhRhRqpAGgrQQpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tt4K9mszX4uLlLt+Tyg5v2DrSAltHEEQuaNrVKYyslfnBIb5JCtikRKZFpvPhV9Uj+zfEhCBr1mMz/C+1Q/6spNtR7AXwldxjtOfWuSrCk+sJmnTwdo6yumONf2b0Lz91vwE0kI/wivgGwRTq0lxUQbNOmttJTiFPO5LlDhwzu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=n4zN+OEU; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 4638sQ16274819
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 3 Jul 2024 01:54:30 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4638sQ16274819
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1719996871;
	bh=pZTV+OGhNN4DFQrZeVdekS2nXzNI1T5U3Yqgnk+2i8s=;
	h=From:To:Cc:Subject:Date:From;
	b=n4zN+OEUJEP2TkDaGq1zM43VhooqY/6HBM3sehH5BZGt6cVrYJbb9+hzaokV7vVdF
	 /+T8WB1j7mKbzsER3/xawk9x/8qac+pjZb8Km9KBx8pp4WzJzit96R6cJQMZwnPt6O
	 xSLLHF/xgvmz+dk6NYAfrR8CA1vbi8DEeyh51Hb3pBVr5cY/dnJivIMN/YyOJnnUVH
	 qKYn2Nj92jBD2Ulpr21oA9ByoT9B6kmjOLdw5VYPtQkm33cbGoZs2dsT+EBlRQ1j5u
	 V2jC6n5VhRg5KhMvWq4aOgsBURjkUSYyok3RBt21Rcuw9asaT2i+H/VKathlrFZ3wL
	 /T7rhXzmu/avg==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, peterz@infradead.org,
        andrew.cooper3@citrix.com, nik.borisov@suse.com,
        houwenlong.hwl@antgroup.com
Subject: [PATCH v1 0/4] Enable FRED earlier
Date: Wed,  3 Jul 2024 01:54:22 -0700
Message-ID: <20240703085426.274801-1-xin@zytor.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wenlong Hou from Ant group reported two problems during the FRED
initialization:
https://lore.kernel.org/lkml/cover.1718972598.git.houwenlong.hwl@antgroup.com/

The first problem is that spurious_interrupt() gets called on the
HYPERVISOR_CALLBACK_VECTOR vector.  Because kvm_guest_init(), being
executed way before trap_init() in which it is decided that whether
FRED will be enabled or not, calls sysvec_install() to install
HYPERVISOR_CALLBACK_VECTOR's interrupt handler into FRED system
vector dispatch table or IDT depending on whether FRED is enabled.

The other problem is that the #PF handler gets a wrong faulting
address from the stack instead of CR2 before FRED is enabled.
Because the #PF handler fetches its faulting addresss from the
stack or CR2 based on whether FRED is available rather than active.

This patchset fixes the 2 problems with suggestions from tglx:

  1) Parse cmdline param "fred=" in cpu_parse_early_param() to
     minimize the gap mentioned above, before kvm_guest_init().

  2) Enable FRED right after init_mem_mapping() to switch to FRED
     from early IDT ASAP, avoid intermediately using the IDT #PF
     handler.


Xin Li (Intel) (4):
  x86/fred: Parse cmdline param "fred=" in cpu_parse_early_param()
  x86/fred: Write to FRED MSRs with wrmsrns()
  x86/fred: Split FRED RSP initialization into a separate function
  x86/fred: Enable FRED right after init_mem_mapping()

 arch/x86/include/asm/fred.h  |  2 ++
 arch/x86/kernel/cpu/common.c |  9 ++++---
 arch/x86/kernel/fred.c       | 50 +++++++++++++++++++++---------------
 arch/x86/kernel/setup.c      |  7 ++++-
 arch/x86/kernel/smpboot.c    |  6 +++++
 arch/x86/kernel/traps.c      | 30 +++-------------------
 6 files changed, 54 insertions(+), 50 deletions(-)


base-commit: e70c87e103e2e3842bf4c55a66c83560a1387925
-- 
2.45.2


