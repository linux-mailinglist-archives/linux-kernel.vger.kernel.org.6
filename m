Return-Path: <linux-kernel+bounces-515588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A09A36681
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 20:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52B961897ED2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491C71C8618;
	Fri, 14 Feb 2025 19:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ORsqiN44"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147F51C84C0
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 19:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739562773; cv=none; b=CYfkBi/y9uW/nyNT7tNY04ChyKKWgFL3CNUcF/0cWfaT204jRJTRQLTnNXkiL9M28dtT6cgWrXp0B8va6oI4ymQA6VU9ptpRM4b+H/ndmdrDGch9AZiNpNm/+6VcTsDRdkttpUT7xG3TbGYxDpquQbebf3zLNUZudv1mLA+pcLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739562773; c=relaxed/simple;
	bh=lminIA9YKzIR/dX/Qd2rKmJLSTDazl1DekqNGsyi9bQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BW5BsfuhBPSB3ceIVSByVgtopc4yF9zbolHSflpYfE1jF1oz/LdYP41HIqTGHZupIhxdEmYn0CFrqnL5FHOWdymWbkGHb6h9Y2UZJ1yWw9OJR1KNV23JRoz5C/E7moWX5JQRrEGLXujtwnNEAModIarP3hNGyXcrI7Ad/c4BeXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ORsqiN44; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739562772; x=1771098772;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lminIA9YKzIR/dX/Qd2rKmJLSTDazl1DekqNGsyi9bQ=;
  b=ORsqiN44kuEaOb4i4ouXdQOvY62L3crh4g+pUWytBUyro0ZhrJJYc+uj
   oVMa88kgiF9OmnTUopFg4XunUIsp+ot9fS/0/n7aPW9OjjIawWqD7ylD6
   9CzVcer2n6gkXuEFEYUZ+eOrs4ZIfjCcgyLGuYnMLrr6fBEUmRU+rv61R
   YrunAljNiA6Sl029r8w2/eON7bMXgLakhKYvc0ZWnikkI2BljmOPhe0d4
   u/00B2nY6gS0xNnIsNFIE7uakIbjkmKlPbfImSJYJ5kDtjaVAPF3mDPbr
   WdjR/Ir6/YO3a0ALHXPVvPoAmhzI80OREQjJUQzLdK17ZERmGqn0qXftR
   g==;
X-CSE-ConnectionGUID: gwiBy66zRiGyUs7ClaIAJQ==
X-CSE-MsgGUID: Wevye0bdQ1G6Q50lL/UN7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40357610"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="40357610"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 11:52:52 -0800
X-CSE-ConnectionGUID: +iJVkAjhRWeyIZx+nblQ/g==
X-CSE-MsgGUID: XB7oURZOQaGaMNyrfSQ1EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="144396129"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO rapter.intel.com) ([10.245.246.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 11:52:49 -0800
From: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
To: linux-kernel@vger.kernel.org
Cc: osalvador@suse.de,
	42.hyeyoo@gmail.com,
	byungchul@sk.com,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	akpm@linux-foundation.org,
	max.byungchul.park@sk.com,
	max.byungchul.park@gmail.com
Subject: [RFC 1/1] x86/vmemmap: Add missing update of PML4 table / PML5 table entry
Date: Fri, 14 Feb 2025 21:51:51 +0200
Message-ID: <20250214195151.168306-2-gwan-gyeong.mun@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214195151.168306-1-gwan-gyeong.mun@intel.com>
References: <20250214195151.168306-1-gwan-gyeong.mun@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

when performing vmemmap populate, if the entry of the PML4 table/PML5 table
pointing to the target virtual address has never been updated, a page fault
occurs when the memset(start) called from the vmemmap_use_new_sub_pmd()
execution flow.

This fixes the problem of using the virtual address without updating the
entry in the PML4 table or PML5 table. But this is a temporary solution to
prevent page fault problems, and it requires improvement of the routine
that updates the missing entry in the PML4 table or PML5 table.

Fixes: faf1c0008a33 ("x86/vmemmap: optimize for consecutive sections in partial populated PMDs")
Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 arch/x86/mm/init_64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 01ea7c6df303..7a4d8cea1a2e 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -912,6 +912,7 @@ static void __meminit vmemmap_use_new_sub_pmd(unsigned long start, unsigned long
 {
 	const unsigned long page = ALIGN_DOWN(start, PMD_SIZE);
 
+	sync_global_pgds(start, end - 1);
 	vmemmap_flush_unused_pmd();
 
 	/*
-- 
2.48.1


