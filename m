Return-Path: <linux-kernel+bounces-544440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC43EA4E134
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3709417B6F9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3925326157F;
	Tue,  4 Mar 2025 14:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYnxe8HE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0D82641C9
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098722; cv=none; b=hRNGDSI2t5RgG9CgezZxDrOOHegX98L2mR8A91PWbzUt7hC1WUYb0iO0HbOKTkwCCIyi7x0xjS9UpURqwRQscHJ1SZfMjBeTLQGVsqmeHB3/muDVR1V2BZVAv6cRIXSiYQBHdkgyM/znKNQPd4VCD15y8GtUkons9DnEDMK6j3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098722; c=relaxed/simple;
	bh=a9j6QpFVvC1kQHVzIJ7k1C44ic+xmFpkFIFNsVCpjWk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=foLOSg6amOaRgDCOy8+DJQ9WtE2JuEieb7RT9mlGA3qwrI2+wFdxs+IEUONM+OCgxDuxnLsn8kPspmbKW1Os7AMd7Od76Mt8yUszxaVOHehumuDCxuWN6uzQjHJTtObW0u5L1eyTK24YD8lkdKS0NjSWbkP1zF4XlGVECLnIQ4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYnxe8HE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEACCC4CEE5;
	Tue,  4 Mar 2025 14:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741098722;
	bh=a9j6QpFVvC1kQHVzIJ7k1C44ic+xmFpkFIFNsVCpjWk=;
	h=From:To:Cc:Subject:Date:From;
	b=pYnxe8HElzhQsEyHmNY8B//czBd/ROEAlj/LD3WW/186YnJlrutSRj5N4g0rM7W13
	 28cbCx390Vnn3dVFl9zYhpmXF+L/DDGko/CT7bFfTAnIOVnAB6rf/IA8NMOZM90JVM
	 jGsaoEKDCvPWpkGhk7LmAdLVNLJlkxZ4ELYWkd2d9gVG3nHGX2UEGCJyo2VEKON+37
	 ETit50801rSuXmGIMmxRTFCf2IcKdG5cHJmDUWdP7PQ2dSPjszA3eYVAG8x/3lPeL8
	 CvahUWowU2pqi5r3bpCTTv0URLdymi8xZgYVij5KhXzZ/r12r8af5V3jWpUg6o/3h9
	 J4UMeLhLdsbSg==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Brendan Jackman <jackmanb@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Gregory Price <gourry@gourry.net>,
	Dan Williams <dan.j.williams@intel.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/page_alloc: add dummy in_mem_hotplug() helper
Date: Tue,  4 Mar 2025 15:31:51 +0100
Message-Id: <20250304143157.856892-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The in_mem_hotplug() prototype was only added to the CONFIG_MEMORY_HOTPLUG
case but is missing from the alternative:

mm/page_alloc.c: In function 'set_pageblock_migratetype':
/home/arnd/arm-soc/mm/page_alloc.c:424:17: error: implicit declaration of function 'in_mem_hotplug' [-Wimplicit-function-declaration]
  424 |                 in_mem_hotplug() ||
      |                 ^~~~~~~~~~~~~~

Add an empty stub like we have for similar functions.

Fixes: b4cfcc26f507 ("mm/page_alloc: add lockdep assertion for pageblock type change")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/memory_hotplug.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index ff9511d9b9e6..508a1d074527 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -224,6 +224,10 @@ static inline void put_online_mems(void) {}
 
 static inline void mem_hotplug_begin(void) {}
 static inline void mem_hotplug_done(void) {}
+static inline bool in_mem_hotplug(void)
+{
+	return false;
+}
 
 static inline bool movable_node_is_enabled(void)
 {
-- 
2.39.5


