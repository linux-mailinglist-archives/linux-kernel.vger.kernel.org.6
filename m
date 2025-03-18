Return-Path: <linux-kernel+bounces-565595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AAAA66B75
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E0D916E110
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD851EB5D3;
	Tue, 18 Mar 2025 07:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Bpzl3pkM"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649E51B0402
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 07:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742282421; cv=none; b=Y/y0M1HuEwaRd/SnwkS1bYlg6yuJyxjc06B8OEObvRqP7BLfNndgICi55E5nDn8EDLeFoaN2iZE/kAFXZkg9u+n946yCK/ywqRiIRZe6M/b+L7GmYLjxLOveupISBFOhUh02+Q1tse0DW6oGd+mCrZXdwptYsdlWm9a/oOyZdCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742282421; c=relaxed/simple;
	bh=LIM/cWYgkWDrAFT8YOpT+er8DQIJr0pEkJ/j0Zb+0vQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u9RvruVNibC3tDnzObQqnujlbsF8r414jajZkGHXgRppG5KWcCz3v4ROyJ7y7C67geV35x+hzFlArhw820jVsZEMwh/HAjxB3MwIH96o/5+ChV8wrks8nC/0OkYBWs8WYyNHzq0Mlh5ounCvCXeIojtW4cpAg2EHcw5wfq/a+sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Bpzl3pkM; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52I7JmWU907380
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 18 Mar 2025 00:19:53 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52I7JmWU907380
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1742282395;
	bh=mWRHHFiv6g2eViKELPH0G6am+Z6+jx1pEJOSe/BpwGw=;
	h=From:To:Cc:Subject:Date:From;
	b=Bpzl3pkML+KKFEVqMiZQmVb1qGS3pzNf/+DDLHvvjYBcv1Jr0W3JIWWIZF55VNxEH
	 nVmd+lriMqoeeS40na6H8oqf1v1Xor1obcYPvwzvg2KU9EWtJLEtfW+WMZ3tDvoNBg
	 NHAwa9fxAiM+7JFdaNNOR9BjdCly4JnKA7mTl8vOPb2uhBBA9vNFM957oH3y/F7fk1
	 WTRntb7NyeYXXs5024JsBzXA2zNTJNPblRiYSUXUYPptJ57jDM2NB+3HcAJSHioOI9
	 aYW1kz5BIkD18Zn8NE85ZHduLkp8xpffPFYms+x+FF1u5VtaNsutLaqgb1gXCWJNGo
	 nO5M/uPwQ12KQ==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: luto@kernel.org, tglx@linutronix.de, mingo@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, brgerst@gmail.com
Subject: [RESEND PATCH v2 0/3] x86: Allow variable-sized event frame
Date: Tue, 18 Mar 2025 00:19:44 -0700
Message-ID: <20250318071947.907364-1-xin@zytor.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Sorry, used the v1 directory to send v2 accidently.  So resend.


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


base-commit: 6575d1b4a6ef3336608127c704b612bc5e7b0fdc
-- 
2.48.1


