Return-Path: <linux-kernel+bounces-567408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC4AA6858E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35C1442172C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 07:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B975A2500CE;
	Wed, 19 Mar 2025 07:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="XyTcHm/d"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A2520D4FA
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 07:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742368246; cv=none; b=I+LwIsQpKBdbBWEx0KXHVAsayUVkV+LH3PglJB5+hvYkwxcVfT50lBENoNTvDeM+70s/7k56opYmYaaQohZExQANeBegMorlnrfyG8DI0YpbkLM90OVWD3gm0i5RgaSQSuEHy/D8vHvsS4HYxlDbK5a9HHmVT9C2iD47XrQYi9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742368246; c=relaxed/simple;
	bh=qt+cQ5KpK5kokqSaKVqBAS8s62MB8SczhDGEKAcaqeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mTAuRL6Rowq+Bzm/PEMs8fAdVvL3i55WZrO5uxolD2kTHoBcjjsHLhjHqecciDsOtRTayiqA7M1kwovxsf0qIC3RQR8WLcRKleCqTICB8LLDk20QbS2PX39UJj17jv0RS+CVvXIB2xccghZBPvOIy+byswDZcsKfp7YdK6WIXR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=XyTcHm/d; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52J7A9qd1391002
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 19 Mar 2025 00:10:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52J7A9qd1391002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1742368216;
	bh=lAcdrGTlxllVc2wa+BONcvpizR4tnpiXm/B9l7UeaWA=;
	h=From:To:Cc:Subject:Date:From;
	b=XyTcHm/dKa0mVcP4F0TeDEpC4fnWOPkGah6VQ4GYITDmbaaNcd+1K+Ozet9evv8As
	 AyRxRAV68n7csJND8DzYyutu14IHW/A8mvoWT55DnYorVG3eBR475PqzsrNoTjffFI
	 f/1B/tjDmu8M63WZyhe5QVH3s4MoN8S1DS00ZEkrJSlaPw2Ezw9KWERQUpJJxtWnMp
	 b0tkmanRvRQg/efNcZI89QwdJhHwck6ScvgKcbPdgLY8AZYFu0gwGSs6MFN//2EtCD
	 wHiMxFMKkmuCDiC9DUfFgpJXfG9dY+VfVrlQYDcA72qQyoO475pwYnoBTipju9coo5
	 lSzq3GGPMDFbg==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: luto@kernel.org, tglx@linutronix.de, mingo@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, brgerst@gmail.com
Subject: [PATCH v3 0/3] x86: Allow variable-sized event frame
Date: Wed, 19 Mar 2025 00:10:06 -0700
Message-ID: <20250319071009.1390984-1-xin@zytor.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was initially posted as part of the FRED patch series and turned
down due to its unacceptable quality:
  https://lore.kernel.org/lkml/20230410081438.1750-31-xin3.li@intel.com/

Now comes another attempt to meet the bar.


A FRED event frame could contain different amount of information for
different event types, e.g., #MCE could push extra bytes of information,
or perhaps even for different instances of the same event type. Thus
the size of an event frame pushed by a FRED CPU is not fixed and the
address of a pt_regs structure that is used to save the user level
context of current task is not at a fixed offset from top of current
task kernel stack.

This patch set adds a new field named 'user_pt_regs' in the thread_info
structure to save the address of user level context pt_regs structure,
thus to eliminate the need of any advance information of event frame
size and allow a FRED CPU to push variable-sized event frame.

With the above change, we can

1) Remove the padding space at top of the init stack because there is
   no user level context for init task.

2) Get rid of TOP_OF_KERNEL_STACK_PADDING on x86_64, which was defined
   to 0 for IDT to keep the code consistent with 32bit.


Link to v2: https://lore.kernel.org/lkml/20250318071947.907364-1-xin@zytor.com/


Change in v3:
* Replace "(struct pt_regs *)TOP_OF_INIT_STACK - 1" with
  (struct pt_regs *)__top_init_kernel_stack (Brian Gerst).

Change in v2:
* Rebase on latest tip/master.


Xin Li (Intel) (3):
  x86/fred: Allow variable-sized event frame
  x86: Remove the padding space at top of the init stack
  x86: Zap TOP_OF_KERNEL_STACK_PADDING on x86_64

 arch/x86/entry/entry_fred.c        | 10 ++++++++++
 arch/x86/include/asm/fred.h        |  2 +-
 arch/x86/include/asm/processor.h   | 32 +++++++++++++++++++++---------
 arch/x86/include/asm/thread_info.h | 19 ++++++------------
 arch/x86/kernel/process.c          | 21 ++++++++++++++++++++
 arch/x86/kernel/vmlinux.lds.S      |  7 +++++--
 include/linux/thread_info.h        |  1 +
 kernel/fork.c                      |  6 ++++++
 8 files changed, 73 insertions(+), 25 deletions(-)


base-commit: 60c162a51180cb2b05d7505a565ab079bfa9cf12
-- 
2.48.1


