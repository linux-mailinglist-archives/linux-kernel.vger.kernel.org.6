Return-Path: <linux-kernel+bounces-224768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EE09126A9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E98AB2675E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA7C155A47;
	Fri, 21 Jun 2024 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="aU1UqmIQ"
Received: from out187-22.us.a.mail.aliyun.com (out187-22.us.a.mail.aliyun.com [47.90.187.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573EE142620
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 13:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718976482; cv=none; b=iBZgiABmBXd8+cqzCU1DhExoZeVUe7pDa61jYIfMtlGcndgNktiPz+cPaMLKXdv3K7inwL7baSd0tVyhxfq+OH5FxxWPgB8Al9itAhNSw4ZmRJn87FErhhngFq0cGhmBvHUZpZOyXIkJUmnWYqU+w9y+KuPz70EYE0CnUdweErA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718976482; c=relaxed/simple;
	bh=kRq4/WsEZLXlCJFmln/C4ReeQ4n7ipG8SbxJa92jr9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dZn6vgrff2Aphs3yGBs4AdOdsDWW+EAEBaqfJdIm/BL2AAkvqKBf1Q/nUre1jpM3AHB61GOkXpIHfRff4Hb8CmVZbJYCMHabI4FE06Bfo+gUpNGlRw+PTvH/Ra/QrxiicaIVvC5F4xiZyIDJCw0FTaLEdjqGxhhHmAd8quSriSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=aU1UqmIQ; arc=none smtp.client-ip=47.90.187.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1718976467; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=CugS5v3cDxB1/HBthQf7zfjVdDNfB+Mjum4rm4qX3EY=;
	b=aU1UqmIQ+03WzvcmkYvnt+U4+G64rdrUUFj+n+UQfgJsbZ6VSGVCxR/OOnU8WZPleaimHZoEc10j2ZY+siCzWX0PDYOnp/MysVzHXw48d1/g+n5A9NeCRr94OXSgJn0BwbGbc02vZVu4a4QxzrjDjPhphCpapjOV0/z9gjx12cc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045129160;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---.Y72MRVS_1718975533;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.Y72MRVS_1718975533)
          by smtp.aliyun-inc.com;
          Fri, 21 Jun 2024 21:12:14 +0800
From: "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To: linux-kernel@vger.kernel.org
Cc: "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
  "Hou Wenlong" <houwenlong.hwl@antgroup.com>,
  "Thomas Gleixner" <tglx@linutronix.de>,
  "Ingo Molnar" <mingo@redhat.com>,
  "Borislav Petkov" <bp@alien8.de>,
  "Dave Hansen" <dave.hansen@linux.intel.com>,
   <x86@kernel.org>,
  "H. Peter Anvin" <hpa@zytor.com>,
  "Xin Li" <xin3.li@intel.com>,
  "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
  "Rick Edgecombe" <rick.p.edgecombe@intel.com>,
  "Paolo Bonzini" <pbonzini@redhat.com>
Subject: [PATCH 0/2] x86/fred: Fix two problems during the FRED initialization
Date: Fri, 21 Jun 2024 21:12:00 +0800
Message-Id: <cover.1718972598.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When I reviewed the FRED code and attempted to implement a FRED-like
event delivery for my PV guest, I encountered two problems which I may
have misunderstood.

One issue is that FRED can be disabled in trap_init(), but
sysvec_install() can be called before trap_init(), thus the system
interrupt handler is not installed into the IDT if FRED is disabled
later. Initially, I attempted to parse the cmdline and decide whether to
enable or disable FRED after parse_early_param(). However, I ultimately
chose to always install the system handler into the IDT in
sysvec_install(), which is simple and should be sufficient.

Another problem is that the page fault handler (exc_page_fault()) is
installed into the IDT before FRED is enabled. Consequently, if a #PF is
triggered in this gap, the handler would receive the wrong CR2 from the
stack if FRED feature is present. To address this, I added a page fault
entry stub for FRED similar to the debug entry. However, I'm uncertain
whether this is enough reason to add a new entry. Perhaps a static key
may suffice to indicate whether FRED setup is completed and the handler
can use it.

Note: I didn't test them on the Intel emulator, as I'm not familiar with
configuring it to boot with my compiled kernel.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Xin Li <xin3.li@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>

Hou Wenlong (2):
  x86/fred: Always install system interrupt handler into IDT
  x86/fred: Add a page fault entry stub for FRED

 arch/x86/entry/entry_fred.c     |  2 +-
 arch/x86/include/asm/idtentry.h | 15 +++++++++++++--
 arch/x86/mm/fault.c             | 19 +++++++++++++++----
 3 files changed, 29 insertions(+), 7 deletions(-)

--
2.31.1


