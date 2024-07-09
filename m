Return-Path: <linux-kernel+bounces-246183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FF992BEA3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06AA01F22E9B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3523819D8A3;
	Tue,  9 Jul 2024 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ceNCeZpf"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEA53612D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 15:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720539693; cv=none; b=V3/4dg3VXlbgWLQ0Af1n8xqwG3iGkVkr2+kC+dpb0rFxYuqJ6XeJzZnioq1I3E86hBYkrSOdaIIK35XMKhw8aN0STgeAe/JbUCssmdyrjJWR9ppnz5sVeQ1HK+gLIoj1DXTqf+fT7ZIBC0npy75WOv+D7LiLjK4ifeAIYOKLYrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720539693; c=relaxed/simple;
	bh=L/YLyuFVpcalfodXh6iSUAseC5/BrLWhVSI8KkE2tkc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h9ayunt3eNaqq8nQdKgUhZDePO55IYYvdUfjoeR1tFVihsRpEkAnoZW/KDqKVPZfgK/7KbW9LAEhxPVlA8u+jvh21OcQ94nl3WD97EBTZY5agDPm/lsOLZMpFRKR5R+G60iDJuucSAko/sCbZ046MYO1yspDcyeJPcS1ThtDO6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=ceNCeZpf; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 469FemH03543378
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 9 Jul 2024 08:40:59 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 469FemH03543378
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1720539660;
	bh=4u6YpzKMMp/pyOORgFJw/J79spsRWRinGVyURWEku1Q=;
	h=From:To:Cc:Subject:Date:From;
	b=ceNCeZpfiJR6aBz2gLM89MmpT0RD5PdMLC7LUWHrYdGV4vqpAE2cljfGFJhGKAyJG
	 of77CiEQUpXox+nhl4KR2le1YRFItW/zutZ5AOOkyAb9kr51enpf3OsrZaPQfATGrU
	 AN6v1pAamgRzQUantMvKLNelp6749l2Xl5H/iNk7UEZvsMc+7dlT8TegnJPv+POL5f
	 qzD+fwAE9Fz7asHFQ38INr0pKFcgFMKID3IkaQlOHcFR1TwAJA0D/NdIyb6QQpB8uY
	 ZAHcKQVKIhwaTFGLj0FZnbpMqu/JjF51vP4ptdYQVEXMBCZCJveRQUc61XBqvX43vL
	 drNWjPQ6DQhwQ==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, peterz@infradead.org,
        andrew.cooper3@citrix.com, nik.borisov@suse.com,
        houwenlong.hwl@antgroup.com
Subject: [PATCH v2 0/3] Enable FRED earlier
Date: Tue,  9 Jul 2024 08:40:45 -0700
Message-ID: <20240709154048.3543361-1-xin@zytor.com>
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


Link to v1:
https://lore.kernel.org/lkml/20240703085426.274801-1-xin@zytor.com/

Changes since v1:
* Drop the patch that changes wrmsrl() to wrmsrns().
* Use strncmp() instead of strcmp().


Xin Li (Intel) (3):
  x86/fred: Parse cmdline param "fred=" in cpu_parse_early_param()
  x86/fred: Split FRED RSP initialization into a separate function
  x86/fred: Enable FRED right after init_mem_mapping()

 arch/x86/include/asm/fred.h  |  2 ++
 arch/x86/kernel/cpu/common.c |  9 ++++++---
 arch/x86/kernel/fred.c       | 28 +++++++++++++++++++---------
 arch/x86/kernel/setup.c      | 11 ++++++++++-
 arch/x86/kernel/smpboot.c    |  6 ++++++
 arch/x86/kernel/traps.c      | 30 ++++--------------------------
 6 files changed, 47 insertions(+), 39 deletions(-)


base-commit: aa9d8caba6e40b0b02a6f2b5f2bd9177cd76cacf
-- 
2.45.2


