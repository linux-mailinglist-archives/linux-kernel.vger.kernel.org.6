Return-Path: <linux-kernel+bounces-525528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5A3A3F0DE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03347179779
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B07320A5D8;
	Fri, 21 Feb 2025 09:45:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1805E205AA3
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740131107; cv=none; b=QTgpwCOUKYQDQo4CWb3l2LCSqQmcHMr99JvMrKvFh6Sjtp4EDXq8tBQViuGX8j88DmAcNFtn7YyribypoNsDaqu9jamxR7GufSfx5amD7P+2LXqnGkgaFSbRn9H9NFMqM7WLGl6h4eoilttCeExYpfx7yhSg4kypGBQzZHuvasI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740131107; c=relaxed/simple;
	bh=qInxcXKONmORwdp2TguQqZ28TmF1tiCUcpKSP2hbjpc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=llscTPvoE7DTeFc9nY18bXxTl/oHzhBeGHhRaVja4jinFKeyqknzoz5Nd/VBEXXg3jgF/JdgO7s6JUhI0SSKYCNe/vZzB2Yym0lBzSfH56JLCruzWRCC2KiyDhIb6/krWiIsrwDc0GUaC3uMpxc1rqFaHiaUri8B1SPUiCYZllw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C594F1007;
	Fri, 21 Feb 2025 01:45:15 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.40.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 02D033F59E;
	Fri, 21 Feb 2025 01:44:54 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] arm64/mm/hotplug: Drop some redundant WARN_ON()
Date: Fri, 21 Feb 2025 15:14:47 +0530
Message-Id: <20250221094449.1188427-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series drops some redundant WARN_ON() tests which are not required any
more while unmapping and freeing up kernel page table pages during a memory
hot remove operation.

This series applies on v6.14-rc3

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (2):
  arm64/mm/hotplug: Drop redundant [pgd|p4d]_present()
  arm64/mm/hotplug: Replace pxx_present() with pxx_valid()

 arch/arm64/mm/mmu.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

-- 
2.30.2


