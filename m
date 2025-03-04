Return-Path: <linux-kernel+bounces-544307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30455A4DFFA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9AE188DE6E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1184204680;
	Tue,  4 Mar 2025 13:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uztDXE1h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED3C2045A5
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 13:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096703; cv=none; b=SSSoYJ1DZelF0FkN2kwv6mrAQkk1KxUD5XO8gZJ4vtfvf8EGHtKIr20ottug0E3y/RZX2WAeNOoy/OA685IPnuR8txvsgHJY9cts/d99psCGAg/ybki8deEOUDAph8+/eHWgD8jkDT4nBWjy8O2eu4ariWCk7X9Kjy0ZoNnLcL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096703; c=relaxed/simple;
	bh=5Dhxcn4XfdIXC+i03AuvG4ZS4Abl3HthSEHQozvK9vo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wo0EKCMkjdUOXbZ44Xbg5Sec+mBp1T95G+Xl9JOjhvv9uR2OTODGlWMUZHMnWosodh2olORW4/eSP8cq2btdlbGHHeVlxRGYoh/lYTS/Qd2FleusMotIk2Onetxjb+Zbe1lcaIJKi0b7q0rhvXF5hsN/lXon1ZWUOVPmtViEqMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uztDXE1h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6FEBC4CEE5;
	Tue,  4 Mar 2025 13:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741096702;
	bh=5Dhxcn4XfdIXC+i03AuvG4ZS4Abl3HthSEHQozvK9vo=;
	h=From:To:Cc:Subject:Date:From;
	b=uztDXE1hQILVZ7CgiA+cVNSFsXQD5C1z+HuyBbhkwrLA1Y8wSQSezVcyjHoRXgFmb
	 EMH9tm590GhPwS0DSjjBxcYSD2bosiUsoXF26IYC/jP47Kw8EMSA5C6GzCnzAN2B0E
	 0IVB04PXIdH+5RggXtQs9+bMG319QEY3EfHfZM+TZnDeU6Mr9kJlU5j3m3qyc+p99t
	 oEAB6Z04yD0iwFbQvTqrJvf2PgTf107YiciERugeZtr1mWepSNPY220kRsrDUNmb0+
	 qp2zYqBRIBy6EX10o8UVsynZu/5d9OPmGerWDf9/9buAJOT3UojUTdfXBASHmOu4TB
	 qxF5h0yZVCHkg==
From: Borislav Petkov <bp@kernel.org>
To: riel@surriel.com
Cc: Manali.Shukla@amd.com,
	akpm@linux-foundation.org,
	andrew.cooper3@citrix.com,
	jackmanb@google.com,
	jannh@google.com,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhklinux@outlook.com,
	nadav.amit@gmail.com,
	thomas.lendacky@amd.com,
	x86@kernel.org,
	zhengqi.arch@bytedance.com,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH v15 00/11]  AMD broadcast TLB invalidation
Date: Tue,  4 Mar 2025 14:58:05 +0100
Message-ID: <20250304135816.12356-1-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Hi all,

these are Rik's patches from here:

https://lore.kernel.org/r/20250226030129.530345-1-riel@surriel.com

with a bunch of dhansen's and mine edits ontop.

Some stuff is still in-flight but I'm sending the current state because
a bunch of things have changed and we'll need a good base to discuss the
remaining changes pending.
 
Preliminary build and boot tests look good but that doesn't say a whole lot.

Thx.

Rik van Riel (11):
  x86/mm: Consolidate full flush threshold decision
  x86/mm: Add INVLPGB feature and Kconfig entry
  x86/mm: Add INVLPGB support code
  x86/mm: Use INVLPGB for kernel TLB flushes
  x86/mm: Use broadcast TLB flushing in page reclaim
  x86/mm: Add global ASID allocation helper functions
  x86/mm: Handle global ASID context switch and TLB flush
  x86/mm: Add global ASID process exit helpers
  x86/mm: Enable broadcast TLB invalidation for multi-threaded processes
  x86/mm: Do targeted broadcast flushing from tlbbatch code
  x86/mm: Enable AMD translation cache extensions

 arch/x86/Kconfig.cpu                     |   4 +
 arch/x86/include/asm/cpufeatures.h       |   1 +
 arch/x86/include/asm/disabled-features.h |   8 +-
 arch/x86/include/asm/mmu.h               |  12 +
 arch/x86/include/asm/mmu_context.h       |  10 +-
 arch/x86/include/asm/msr-index.h         |   2 +
 arch/x86/include/asm/tlb.h               | 126 ++++++
 arch/x86/include/asm/tlbflush.h          |  96 ++++-
 arch/x86/kernel/cpu/amd.c                |  10 +
 arch/x86/mm/tlb.c                        | 506 +++++++++++++++++++++--
 tools/arch/x86/include/asm/msr-index.h   |   2 +
 11 files changed, 730 insertions(+), 47 deletions(-)

-- 
2.43.0


