Return-Path: <linux-kernel+bounces-426015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2F29DEDC1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 300F7B21E7C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 00:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778D929B0;
	Sat, 30 Nov 2024 00:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GsPGlvs5"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736EF19A
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 00:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732925669; cv=none; b=u3NzvhggGl8eHzqch/gjTT4KcCcPNTABQXwUFixtliREAnTyIwFVbjIig5XcD/Jy52HbqroUDAzZFqjWxgo7m2w1Qebk4U3+fMnA5TGF8AYrLgW126OoeILqwZy0nswT2Z9bhRLRwAdlCWI2mw2mFi4sbLh85PSokX9dD0ALH0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732925669; c=relaxed/simple;
	bh=fIW5X8p4akL+99rAUyvfz1McmCobJzGIw5O5AOWEAQI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Uqiylz0uw7E3MLuPUy7XdSxYclwGHBIemG7TVWFr91h4VT2FONBjsFYlX0vUkE74W+2XhIoM3oIg9Re+4Ln+u+0c22ixLgz+CaqRuZ1O58iLJf4Al+5i+KVCqZ1Q4zNK95iF55OuUIjAk5vhgcnzRs2WNKTdGaMxUHqDoJDcPPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GsPGlvs5; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7f71e2fc065so1737616a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 16:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732925668; x=1733530468; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Msn5ydSsXJvK7W3o2JvmJ38LPMa5eKoJY2o5aCZVyQY=;
        b=GsPGlvs5XFuTtekiulwIHwugSLfFRaoojUA3bbYV0i6nJeTssHAKwC88NqPEelULnb
         906SKMny6PyiaYasMAU7gPpaQwDPK2ltPXH4AQ9boIkjDNaInhW9qkJnBINFkenQGO1t
         btM4QpZ/laf0WL/VqxG8Y/RjheDHMfBU0wcbpB6dVnoL7hCTFL7LLAy+zrCsLgP6Jmew
         7uHcNS30XZZPhbhNNremIhe7fKI+SOol7MAXeAzhlTnB8okN9ioAYmjTYcSIMyBdmKM8
         M8qcXaovWMX11QBlCvzZYf+7je+nWMtIjosi37qsVfyRBouGouwY7R8kLTNomjUNbUbv
         Ro3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732925668; x=1733530468;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Msn5ydSsXJvK7W3o2JvmJ38LPMa5eKoJY2o5aCZVyQY=;
        b=hnOf0OzRUns7wTEXWTUTrQNmWHOkFwhwK5Ia4tAs30Xp/6iFeVQSnAdZHFBVihjQ23
         +mia0MrzheWTvaYep7KAlUkXWptVokYlMNoXBD4+orqXkWiTzRcQ1ZOpJ+eARrTKEu9t
         B7CPPy8zis+xQjfE8muHz6JJv42mRWhuIjgmpCq6SsjlW8maNXKz+p+iknMNcqtaoLQG
         02+sIVLti3mVQApvhDqQ/+IoVV68FaBH6lfzdX5YjRUlhP2TOxJOHA3bhzLrhCjPxEmT
         O0Gb3NoQ/ezp71l2iQJSHmcaeGrP8fA94QEO3ZG3SDJVLTmrZZl/cJz77qFAtgBMYYDL
         i4+w==
X-Forwarded-Encrypted: i=1; AJvYcCU7qVfmAnRZ+3JdlTpFKDA++IHGgZnJCDuZicWkrB3fYaCndiq9HmzXXGdDrSSzRCrG4pxAISZhGW0X3c0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqfsXtFtPeNw5cmOHacoZlPlyIbRuVd5gQZIsb/pZD2FRcbMny
	/PXAuPPuYdUPo3T0taLU2xo0e2zJt0tYG0hTCsaFB1Sx5Um8GkcmwZY6NAgDx8lNgPvQOm4s1/W
	l1A==
X-Google-Smtp-Source: AGHT+IEZ5ARDUBAksQwZjcJ+vr4ytuA3q37Am5GZLCfm/nnP/vqItHhnwL+g58/Cgk/lpSFI0Dl6QgR1MCA=
X-Received: from pfaw9.prod.google.com ([2002:a05:6a00:ab89:b0:724:fde8:58a])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a10f:b0:1e0:cc21:19a2
 with SMTP id adf61e73a8af0-1e0e0aaf55bmr19045608637.1.1732925667676; Fri, 29
 Nov 2024 16:14:27 -0800 (PST)
Date: Fri, 29 Nov 2024 16:14:22 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241130001423.1114965-1-surenb@google.com>
Subject: [PATCH 1/2] alloc_tag: fix module allocation tags populated area calculation
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, pasha.tatashin@soleen.com, rppt@kernel.org, 
	yuzhao@google.com, souravpanda@google.com, 00107082@163.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com, 
	kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"

vm_module_tags_populate() calculation of the populated area assumes that
area starts at a page boundary and therefore when new pages are allocation,
the end of the area is page-aligned as well. If the start of the area is
not page-aligned then allocating a page and incrementing the end of the
area by PAGE_SIZE leads to an area at the end but within the area boundary
which is not populated. Accessing this are will lead to a kernel panic.
Fix the calculation by down-aligning the start of the area and using that
as the location allocated pages are mapped to.

Fixes: 0f9b685626da ("alloc_tag: populate memory for module tags as needed")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202411132111.6a221562-lkp@intel.com
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
Applies over mm-unstable

 lib/alloc_tag.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 2414a7ee7ec7..668c4e128fa4 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -393,19 +393,20 @@ static bool find_aligned_area(struct ma_state *mas, unsigned long section_size,
 
 static int vm_module_tags_populate(void)
 {
-	unsigned long phys_size = vm_module_tags->nr_pages << PAGE_SHIFT;
+	unsigned long phys_end = ALIGN_DOWN(module_tags.start_addr, PAGE_SIZE) +
+				 (vm_module_tags->nr_pages << PAGE_SHIFT);
+	unsigned long new_end = module_tags.start_addr + module_tags.size;
 
-	if (phys_size < module_tags.size) {
+	if (phys_end < new_end) {
 		struct page **next_page = vm_module_tags->pages + vm_module_tags->nr_pages;
-		unsigned long addr = module_tags.start_addr + phys_size;
 		unsigned long more_pages;
 		unsigned long nr;
 
-		more_pages = ALIGN(module_tags.size - phys_size, PAGE_SIZE) >> PAGE_SHIFT;
+		more_pages = ALIGN(new_end - phys_end, PAGE_SIZE) >> PAGE_SHIFT;
 		nr = alloc_pages_bulk_array_node(GFP_KERNEL | __GFP_NOWARN,
 						 NUMA_NO_NODE, more_pages, next_page);
 		if (nr < more_pages ||
-		    vmap_pages_range(addr, addr + (nr << PAGE_SHIFT), PAGE_KERNEL,
+		    vmap_pages_range(phys_end, phys_end + (nr << PAGE_SHIFT), PAGE_KERNEL,
 				     next_page, PAGE_SHIFT) < 0) {
 			/* Clean up and error out */
 			for (int i = 0; i < nr; i++)

base-commit: 539cd49425a4e9a66d601d9a8124f5c70e238d56
-- 
2.47.0.338.g60cca15819-goog


