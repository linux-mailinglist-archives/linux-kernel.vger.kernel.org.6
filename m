Return-Path: <linux-kernel+bounces-372116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 552439A449E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 820151C22DFD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8102558BC;
	Fri, 18 Oct 2024 17:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3IaOlnx"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F84F288BD
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729272622; cv=none; b=Pi/ZHMvLs5z1UjyY2bjQU9RYDJPzwSAK/yIh3g/f8g1WMKa2gLSOP9nTTRDNPnsGDsIdelRMNk0/7eb6nbXEEXIUXNUFvMuxp3VYw3+MX5xOwWOq0XLftRvyXXakbs9HRepkBO69ChTjmYWIQmWgfuT1kL4LiLQgRcgu9F+4INg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729272622; c=relaxed/simple;
	bh=n81g+ZLV/jsWhPxAwo9v+YunVT3vJkDmH/rxAMOtrh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PqGHqPO/9fJVl4JbrK4PDFWGnrdlOuwLcPgPSF0fjjaEHFkiKXW/XmHXY2jPweHs1NIrT6OSkGqbgHTws2olDWThAAR+7Fvl2TttnG6P4za6NIw7sQNPMlR47I3qt70XZTY/z7LO1OfV4BgKkQFXZcWZ6jfdd5NCRv2GtLM6ies=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3IaOlnx; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7ea79711fd4so1700225a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729272619; x=1729877419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/kexGPHg7BP7JEy0b70rSKtUMi9zN66ceCEdb7Ha4D0=;
        b=T3IaOlnxP+s24Qz/TF3qMlRc8ytPo152WQNfVNke1+reT23+RnmQfuzzn2hOdFsxx4
         IsXUAxOtHJPytXiiY3cDaxHVl8Hox5vbyf4EhAW2jUWlilxX5kZjMXWGHg+tPEI/UEl7
         GGTfplk6uW/2S0q1/dQ6UXb8hjJxM2TfQWiByLHu3WddctTC4IFkTWz3Cd565hOhvNsd
         fZjAynMMB0lMmvbPna5jW1KLXX67ErkIGJVLxES7Q3opnXZBO0aHYizSUmz1oVMBZujI
         nX2Bo9Pckb6OMeU6N4nDAthsc6+bQGbWmAaxKQp5cbjCLi1eNEEPbB1XKJ/K1mdq91PK
         eMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729272619; x=1729877419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/kexGPHg7BP7JEy0b70rSKtUMi9zN66ceCEdb7Ha4D0=;
        b=btzUQYttJHuqAj3We1BQKNEINF2QIWyyZGRfnDs+Bfd6lxTTPS+pzIFcKjLMApQxoo
         wQHzTlwUttY2n/tsqc+mVAdHEmMngr2jqaowcRpFnlweQWWuU4TroC5tc4CYU9tpb6rg
         2jC5tjGDblDm0pioxxs5q4wxATc7YVy6pbE5wZdAoRand21bweuv3CXSJuP7tyzuhrhw
         0jSx5eCnW4bfRkz/uWwBOQMN4UXFdM6zvXipH0/57yuOSYfNYNIRRRXPT3PTtrAauZVo
         6uX3T3n10uPp/9hP3oYpv1o3LB9o0RPiSM4FSAxGxSe9XeiekOvGruwDcv6AUlFltVWV
         poKw==
X-Forwarded-Encrypted: i=1; AJvYcCWyHl5+OrXk47g4ndmJWhfTMwopeWySVwkQxfRQWw0FYBn/nW3m/dzkb5PlAduyrzX719kff2nsZMnYWJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5gW+EFBH27G15JypZEbUG7qYyBR7CKIduhh6AcI1whcWUTFkY
	H9wZjdfyOe8WbJon2xNZZtyMsrvP0VAbMQ4DAl9Fgih1UXwyLxrK
X-Google-Smtp-Source: AGHT+IEbOGLNKLJrJFImzQpsiOOXU0drvvKYT531il5KzE7IqW3k2drNkmi6NFk+P7Ia/vyxbbkhgQ==
X-Received: by 2002:a05:6a21:164a:b0:1d6:e6b1:120f with SMTP id adf61e73a8af0-1d92c4dffb5mr4996670637.11.1729272619178;
        Fri, 18 Oct 2024 10:30:19 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.80.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea3311f51sm1725242b3a.36.2024.10.18.10.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 10:30:16 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Hari Bathini <hbathini@linux.ibm.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Donet Tom <donettom@linux.vnet.ibm.com>,
	Pavithra Prakash <pavrampu@linux.vnet.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v3 00/12] powerpc/kfence: Improve kfence support (mainly Hash)
Date: Fri, 18 Oct 2024 22:59:41 +0530
Message-ID: <cover.1729271995.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2 -> v3:
============
1. Addressed review comments from Christophe in patch-1: To check for
   is_kfence_address before doing search in exception tables.
   (Thanks for the review!)

2. Separate out patch-1, which will need a separate tree for inclusion and
   review from kfence/kasan folks since it's a kfence kunit test.

[v2]: https://lore.kernel.org/linuxppc-dev/cover.1728954719.git.ritesh.list@gmail.com/

Not much of the change from last revision. I wanted to split this series up
and drop the RFC tag so that this starts to look ready for inclusion before the
merge window opens for powerpc-next testing.

Kindly let me know if anything is needed for this.

-ritesh

Summary:
==========
This patch series addresses following to improve kfence support on Powerpc.

1. Usage of copy_from_kernel_nofault() within kernel, such as read from
   /proc/kcore can cause kfence to report false negatives.

   This is similar to what was reported on s390. [1]
   [1]: https://lore.kernel.org/all/20230213183858.1473681-1-hca@linux.ibm.com/

   Patch-1, thus adds a fix to handle this case in ___do_page_fault() for
   powerpc.

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

Summary of patches
==================
Patch-1 adds a fix to handle this false negatives from copy_from_kernel_nofault().

Patch[2-8] removes the direct dependency of kfence on debug_pagealloc
infrastructure. We make Hash kernel linear map functions to take linear map array
as a parameter so that it can support debug_pagealloc and kfence individually.
That means we don't need to keep the size of the linear map to be
DRAM_SIZE >> PAGE_SHIFT anymore for kfence.

Patch-9: Adds kfence support with above (abstracted out) kernel linear map
infrastructure. With it, this also fixes, the boot failure problem when kfence
gets enabled on Hash with >=16TB of RAM.

Patch-10 & Patch-11: Ensure late initialization of kfence is disabled for both
Hash and Radix due to linear mapping size limiations. Commit gives more
description.

Patch-12: Early detects if debug_pagealloc cannot be enabled (due to RMA size
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
rather than 16MB mapping. This should be improved in future.

v1 -> v2:
=========
1. Added a kunit testcase patch-1.
2. Fixed a false negative with copy_from_kernel_nofault() in patch-2.
3. Addressed review comments from Christophe Leroy.
4. Added patch-13.


Ritesh Harjani (IBM) (12):
  powerpc: mm/fault: Fix kfence page fault reporting
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
 arch/powerpc/mm/fault.c                  |  11 +-
 arch/powerpc/mm/init-common.c            |   1 +
 6 files changed, 301 insertions(+), 108 deletions(-)

--
2.46.0


