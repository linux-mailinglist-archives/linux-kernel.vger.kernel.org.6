Return-Path: <linux-kernel+bounces-333055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E31EA97C2E3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 04:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86C25B21CD4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 02:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B924C111A8;
	Thu, 19 Sep 2024 02:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pvj7O9IH"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DE9320F
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 02:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726714587; cv=none; b=uZcwCHRJsctrIHUae2tSLTueVpif3IC6pzLs3MfMfeWgKoK5m717rpVyKOdEWmunuk1ccX+deYhFWB+4jReGc943zpTGp0fc1JnQKHxgljJ3VzKXIwpzruzN1MZpsRk3NryzfjtwgT/hJjCSkQvRbXaB2b8ejTdUR7lAMwgFv0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726714587; c=relaxed/simple;
	bh=GZ+RTczQJfePcptdgNfZsIeWdOXqyYX5hSsLaiJDSxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cjFWd61Ywm6gNOZprWox5v/TjtJn5LRtFJFAhVMVNcVTLqsJD78Q1XM8rWV9/aBdyQdzeR9rr27a8Rs4cxyP++iezP9NXByfuQ/RYGEnGGaB0YzPgcBtS9hyFhVwf2h0zmVqzuSui295umKXk11xRP0KcJnj9G7xxaZg+eps9Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pvj7O9IH; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-206f9b872b2so3365695ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 19:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726714585; x=1727319385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5GJhA0mjEPdtfqnf/P6njWML6hfKb60sWwrvJGKoU+s=;
        b=Pvj7O9IH1y/+4fltFdZjG0ZcpEa3qJx/81IT2n2N2uFb32EYMFLUFGuGTRIJUMWRW+
         qM6QI4eW1yMN0dCU2dBdzvAjVvnHFYiARdLV8MRXwWkERAZCU5AP2RKOmk5W7XNJX3kD
         uEyxc5jIB7y3kjxxVNi60sdiEk0xSaXd8UsW5oOMwvFMPYu6UHCntjBCuHXn6jq3aYt8
         pTPtrJ4VUrYzz03jtTX3MJ77Dkp6kehwS7BJ9o+M/NdXs6g4/oxz9TqxHSYlxixIfU5c
         mO6yp9ay6eV/VTwq3pVkGYl6Z/2ltOA9/N0vqkkPTVEHdFSR2FqPOsojKiUOyp4IJkmr
         CjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726714585; x=1727319385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5GJhA0mjEPdtfqnf/P6njWML6hfKb60sWwrvJGKoU+s=;
        b=hG2Hbqj3EYQHx5j2tzkGSLqna+LlElQQ27VP01jt/tdyisLkURK/HxIow34jna7F/l
         Y8FrHy8tzhsyMWn7mWNJ5+rfPf2Gr47vTfhvwhj77MgXqs3ZUMrzDhgaFn4CCXBb9lOz
         0L87S6GJGfuwK33kcn94ZK09IAzs/nECenLGoPkGWCRxHsUCHFqoIQ79EFMkNnnedfFL
         sbdcBO8uCF+EVZx2XCZ2f/3RugVLpeWXCqmY44TaDqqJ0I9n1BdUYwYNYui8iBx4O5gt
         wJ045jvdBxQzI+3ghHvjp7YZQY9W5S0mOMpAzQn/kvgLM3ITBHKtYi0j11Fq2ToNWkV5
         JYTw==
X-Forwarded-Encrypted: i=1; AJvYcCXLWzG7cPxMST6738cPFjDFvO5Qa333+C5R2pjKy/PnFeGFk1a9m7lFhDY9orIiLj/D3T6ivdTMSsa+FeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaUayC6nArwq7/8Xw0yrgcABjsabfqoz8/9liK7nPeJoHQFOzY
	aqvpqmA+mMy+SYjQjnvvd3NLXFTFXnOM6GSVKXL7QLnybxb1j5lp
X-Google-Smtp-Source: AGHT+IHIzIrN7dSCPrbE7fe3ybp0UNqueC5VHEPzo/kjfCC7reDC/kUQyqMyZ+se7vzPcIhbgfXgSg==
X-Received: by 2002:a17:903:1252:b0:204:e310:8c7b with SMTP id d9443c01a7336-2076e3f7347mr313393475ad.34.1726714584737;
        Wed, 18 Sep 2024 19:56:24 -0700 (PDT)
Received: from dw-tp.. ([171.76.85.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d2823sm71389105ad.148.2024.09.18.19.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 19:56:24 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Hari Bathini <hbathini@linux.ibm.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Donet Tom <donettom@linux.vnet.ibm.com>,
	Pavithra Prakash <pavrampu@linux.vnet.ibm.com>,
	Nirjhar Roy <nirjhar@linux.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	kasan-dev@googlegroups.com,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v2 00/13] powerpc/kfence: Improve kfence support
Date: Thu, 19 Sep 2024 08:25:58 +0530
Message-ID: <cover.1726571179.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series addresses following to improve kfence support on Powerpc.

1. Usage of copy_from_kernel_nofault() within kernel, such as read from
   /proc/kcore can cause kfence to report false negatives.

2. (book3s64) Kfence depends upon debug_pagealloc infrastructure on Hash.
   debug_pagealloc allocates a linear map based on the size of the DRAM i.e.
   1 byte for every 64k page. That means for a 16TB DRAM, it will need 256MB
   memory for linear map. Memory for linear map on pseries comes from
   RMA region which has size limitation. On P8 RMA is 512MB, in which we also
   fit crash kernel at 256MB, paca allocations and emergency stacks.
   That means there is not enough memory in the RMA region for the linear map
   based on DRAM size (required by debug_pagealloc).

   Now kfence only requires memory for it's kfence objects. kfence by default
   requires only (255 + 1) * 2 i.e. 32 MB for 64k pagesize.

This series in Patch-1 adds a kfence kunit testcase to detect
copy_from_kernel_nofault() case. I assume the same should be needed for all
other archs as well.

Patch-2 adds a fix to handle this false negatives from copy_from_kernel_nofault().

Patch[3-9] removes the direct dependency of kfence on debug_pagealloc
infrastructure. We make Hash kernel linear map functions to take linear map array
as a parameter so that it can support debug_pagealloc and kfence individually.
That means we don't need to keep the size of the linear map to be
DRAM_SIZE >> PAGE_SHIFT anymore for kfence.

Patch-10: Adds kfence support with above (abstracted out) kernel linear map
infrastructure. With it, this also fixes, the boot failure problem when kfence
gets enabled on Hash with >=16TB of RAM.

Patch-11 & Patch-12: Ensure late initialization of kfence is disabled for both
Hash and Radix due to linear mapping size limiations. Commit gives more
description.

Patch-13: Early detects if debug_pagealloc cannot be enabled (due to RMA size
limitation) so that the linear mapping size can be set correctly during init.

Testing:
========
It passes kfence kunit tests with Hash and Radix.
[   44.355173][    T1] # kfence: pass:27 fail:0 skip:0 total:27
[   44.358631][    T1] # Totals: pass:27 fail:0 skip:0 total:27
[   44.365570][    T1] ok 1 kfence


Future TODO:
============
When kfence on Hash gets enabled, the kernel linear map uses PAGE_SIZE mapping
rather than 16MB mapping.


v1 -> v2:
=========
1. Added a kunit testcase patch-1.
2. Fixed a false negative with copy_from_kernel_nofault() in patch-2.
3. Addressed review comments from Christophe Leroy.
4. Added patch-13.


Nirjhar Roy (1):
  mm/kfence: Add a new kunit test test_use_after_free_read_nofault()

Ritesh Harjani (IBM) (12):
  powerpc: mm: Fix kfence page fault reporting
  book3s64/hash: Remove kfence support temporarily
  book3s64/hash: Refactor kernel linear map related calls
  book3s64/hash: Add hash_debug_pagealloc_add_slot() function
  book3s64/hash: Add hash_debug_pagealloc_alloc_slots() function
  book3s64/hash: Refactor hash__kernel_map_pages() function
  book3s64/hash: Make kernel_map_linear_page() generic
  book3s64/hash: Disable debug_pagealloc if it requires more memory
  book3s64/hash: Add kfence functionality
  book3s64/radix: Refactoring common kfence related functions
  book3s64/hash: Disable kfence if not early init
  book3s64/hash: Early detect debug_pagealloc size requirement

 arch/powerpc/include/asm/kfence.h        |   8 +-
 arch/powerpc/mm/book3s64/hash_utils.c    | 364 +++++++++++++++++------
 arch/powerpc/mm/book3s64/pgtable.c       |  13 +
 arch/powerpc/mm/book3s64/radix_pgtable.c |  12 -
 arch/powerpc/mm/fault.c                  |  10 +-
 arch/powerpc/mm/init-common.c            |   1 +
 mm/kfence/kfence_test.c                  |  17 ++
 7 files changed, 318 insertions(+), 107 deletions(-)

--
2.46.0


