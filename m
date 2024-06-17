Return-Path: <linux-kernel+bounces-216928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 899DA90A8B2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C73B1F238BD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED98D19066A;
	Mon, 17 Jun 2024 08:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="mZDV5Khv"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD3D61FFC
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 08:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718613974; cv=none; b=NfhX1jnK+9+TfqgD8CpZu3g8/LHNj4i0EjD+USR4WE/1N4Tl8uxBfL3YtPyvRvRcfcYiiLwHSO5nANDiyG9ZuBlNJBwBY+mM2b5H5Yg4GD2Q9uD3Fb3j4HwrmPaObY3vTrWko4imahfxcGDOKoyrDhyVQKzWKlG7J6gTV3ErGFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718613974; c=relaxed/simple;
	bh=DOAYRReyFRWOnfnDQGobFNh8zXTKtnHWuI8vSW65t+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lMsDZ/TJj8rABpP2rirgffwbHgN/FZtDk0WkEHU9jTUjA+5b2nTp5KbWupWltNh3wz+e1YLUvKoiZRtdXNe6nSUCGVH9nwTNRW1nD+ScU86d3hB31jZTQlt46W5PfMeEqpKZxWRj7a/US5O0bwOxW3Ut4/BNfFgM6oV2jlJfnUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=mZDV5Khv; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 45H8jGt11484406
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 17 Jun 2024 01:45:20 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 45H8jGt11484406
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1718613921;
	bh=qhj1xCmcO+DRp17c2nMSxkbXeEmpemPE+gGRmM9FPE0=;
	h=From:To:Cc:Subject:Date:From;
	b=mZDV5KhvBcAy1ofbBJJb9BhBKSiKfDQ6e+rayXr30EbpfyG+gKG7FTD5014szE1lg
	 k03CNyfU6lA8xI1fWQurPFfGl0PuBWbqhwZ+9mXZ8wxMEujMaDQRqrm29sREEKo1Iv
	 ORoAK/0EYqBn927eZHP4zVhjd28Kj86w3So8tlZ11LBGcRABRjIm3CdF/Ndp/DOo8F
	 SoC/0BJc3xUlkfmfUV8RqmYMWlkvh3uSuuUK7fnkpDf3vzeW3IJhYOwaD485ylo9ue
	 F6lDa9w8dzfpd2hKOHa1to5duF3zEsYJi6mXFdgS+VClFaNZ7BInODVqbFwCVMMuAd
	 1GAcJQyW/KaGg==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, brgerst@gmail.com
Subject: [PATCH v1 0/3] x86: Allow variable-sized event frame
Date: Mon, 17 Jun 2024 01:45:12 -0700
Message-ID: <20240617084516.1484390-1-xin@zytor.com>
X-Mailer: git-send-email 2.45.1
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

And this is another attempt to meet the bar.


a FRED event frame could contain different amount of information for
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


Xin Li (Intel) (3):
  x86/fred: Allow variable-sized event frame
  x86: Remove the padding space at top of the init stack
  x86: Get rid of TOP_OF_KERNEL_STACK_PADDING on x86_64

 arch/x86/entry/entry_fred.c        | 22 +++++++++++++++++
 arch/x86/include/asm/processor.h   | 38 +++++++++++++++++++++++-------
 arch/x86/include/asm/switch_to.h   |  2 +-
 arch/x86/include/asm/thread_info.h | 19 +++++----------
 arch/x86/kernel/process.c          | 21 +++++++++++++++++
 arch/x86/kernel/vmlinux.lds.S      | 18 ++++++++++++--
 include/linux/thread_info.h        |  1 +
 kernel/fork.c                      |  6 +++++
 8 files changed, 102 insertions(+), 25 deletions(-)


base-commit: 49b33979e3bf0a5424420d14f026de12f34e8b1e
-- 
2.45.1


