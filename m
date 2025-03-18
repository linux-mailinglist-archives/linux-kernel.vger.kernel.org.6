Return-Path: <linux-kernel+bounces-565582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84787A66B3E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8FDA175B78
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7931EB5C7;
	Tue, 18 Mar 2025 07:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="hflGUlpC"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B385E1CAA76
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 07:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742281714; cv=none; b=svinAeFok6N5jkgYBC/ZJgBNtPdwv2OXdMMWKN40DO8pEUBGRlEk0zXL8/zUe/NvVU9USA88L/oGvqC1k01QsC4q4227UbqNA9Wzc/LBlgbckLw0PJYNDKcJBp/ka4O6KM0KivmKx18Ghc9D3lpSCkLh+TVRZt9DfapgGftpv4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742281714; c=relaxed/simple;
	bh=VsvTnFd3DkZiHU87QuEkN+c0rE9lOFx1+DkhK0pIJw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dmpsapY4h/YwXjRSEJ5RsQ3abaQSUGqqSutHcDK8ttiOGeqHn339zUe99R07QlHJUYI2/Y8BJ33mY/MQEfp51Q3eq8Jm4PWIUCQCxxUZtjcus7+G3UXWOEC3kDlGIUBJN5rFL7+U4cZ7PPElZsfft85edU3MKH/PhGs72HzfN0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=hflGUlpC; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52I781gn903065
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 18 Mar 2025 00:08:05 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52I781gn903065
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1742281685;
	bh=ZYm2Ap6ck6GPwlxDNUvXWeSDS4vu92tw1BUKFQVV5xE=;
	h=From:To:Cc:Subject:Date:From;
	b=hflGUlpCQGg4MGnmngOaG0SdSgEkpLihev7Jui3ZkTE1qIX8NRLrppkT/pJVi/rC3
	 ODivz/D0vUi4N7ZyZHGZ1D5lcy/LtbykHFTgwK0eHIX5GbGpj5KX3ldqLnbBYf9stp
	 diUs/jFsPna5yqWZ/93lZ9Belm9LRt1ETLO1tX1fKstpax2r+vMg+pYD4qSiYC+cy4
	 RiYGZ/ruZoNFF46ygRaYBOo8VtLEwYx9IoW7deh+hTG72Pw1i4APSL+V/fCd3HTlbf
	 DMIWaRkledmk6pnQ0fOTartEU0yIS3n005Mwss7GjTj8bKqinbax78uANZX/CtPYnv
	 1vNB1x7VfnLlA==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: luto@kernel.org, tglx@linutronix.de, mingo@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, brgerst@gmail.com
Subject: [PATCH v2 0/3] x86: Allow variable-sized event frame
Date: Tue, 18 Mar 2025 00:07:58 -0700
Message-ID: <20250318070801.903045-1-xin@zytor.com>
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

Now try another attempt to meet the bar.


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

Link to v1: https://lore.kernel.org/lkml/20240617084516.1484390-1-xin@zytor.com/


Xin Li (Intel) (3):
  x86/fred: Allow variable-sized event frame
  x86: Remove the padding space at top of the init stack
  x86: Get rid of TOP_OF_KERNEL_STACK_PADDING on x86_64

 arch/x86/entry/entry_fred.c        | 22 +++++++++++++++++
 arch/x86/include/asm/processor.h   | 38 +++++++++++++++++++++++-------
 arch/x86/include/asm/thread_info.h | 19 +++++----------
 arch/x86/kernel/process.c          | 21 +++++++++++++++++
 arch/x86/kernel/vmlinux.lds.S      | 18 ++++++++++++--
 include/linux/thread_info.h        |  1 +
 kernel/fork.c                      |  6 +++++
 7 files changed, 101 insertions(+), 24 deletions(-)


base-commit: 6575d1b4a6ef3336608127c704b612bc5e7b0fdc
-- 
2.48.1


