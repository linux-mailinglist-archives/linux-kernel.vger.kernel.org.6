Return-Path: <linux-kernel+bounces-364957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5196E99DBAD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 03:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97B32B22AEA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C2615531B;
	Tue, 15 Oct 2024 01:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRNgSrbG"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E67A184F
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728956029; cv=none; b=Hfj8zVT/WLo2xTowYG4Z4wA/s8Tq5IbUWzybxGjdVR6vVBdBZmEYsnRFqEBrin0xl70Yo6oK9u/RCVGr/WtvdnDJAsrihzjCogkgcFIRYaNgZ7rOZgI9LzqKmPNjDGPHsDsxTjEd2sJlGgfuzEANEUZDytm//ABDWdbUDCVmi+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728956029; c=relaxed/simple;
	bh=bGWf++BT2vSXQXO9NtpABnmFty/6BVF6bM7nrLh32Gc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ftkR1+PlZTZ8SeY09JfLAnDKbihzg9hPMkEo9igAyuTZHw1+LTT9sRWibiiSDxJjZjIDHLNjIAUYYAgb0c7fAIRfquepDCyttXcER9+8/00Y1MomXl3YhxJcOcHuvFtN3ReF7zTdeB1ZCTIsvZlnopsuW7CWd0eDkBOa1EERTi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRNgSrbG; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ea12e0dc7aso3044478a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 18:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728956027; x=1729560827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/FgRTRf0le7Jh2w75CMwMOtbUSojhg+y46VXsqNVeW4=;
        b=NRNgSrbG6ckjqEGikP26Cq5GH3YozOK0o6k2FTtZadG/BEh1mMTN5ADFacu5g4xDtl
         Rk/CxzIbBtmjFKiDTsRqmNHtxiqc+V21g505up/AW1asIMtwHSBbmVWaZgnzYiIsEkCm
         MTd/W5JSUFJCuSe2ps9tzzb9VUKqOfulI5C1yWMuwzPZeMBBR/HZQMVflbemnV/jYvOe
         vOhsNSUFhAkexTySZLBRZMHxaUVfuMaSqfSyQJhHs7riWMjrcXPyg2Jfpf0hG1qyGNW7
         Vz41SF4BnPzdeeJOihvs8v4OkRIfEQ609MKvsiZ5wFMpfG2BKsFCAVOpG2LWr4v1uuIY
         t0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728956027; x=1729560827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/FgRTRf0le7Jh2w75CMwMOtbUSojhg+y46VXsqNVeW4=;
        b=PVYgWW39H5rhG2IONmhqHiyfbl2jyzjMpOHJZSp2l5qP5ayJ0jHcY6VWySWty+arIF
         0VhvTbfrOot/q0XdoLeM1jMvmBfelOAmaIjNldUV4LVZE1OCgH4zs0CS8htnWhP7y3Wg
         K3ZjREApxV8WT466RPWibQviY6OI40h5urQsWmeXFHDwj9ZlsqFnNXnBcY+SvUVSY+9n
         WcZ7lmllhQesWXYWiTqkSZGjdbW++px3KT2JPArzUlROpZNVyuEYMrcJHFvaOKo5VjFX
         4YPQtIBWoIhchCZpuflHGp9iB07gYx2YpYH0pf0Up/Lner84DP6OxhbM+kzRH23/GgEq
         I7VA==
X-Forwarded-Encrypted: i=1; AJvYcCUq/j7nRiHn04urkHN6YE1g/ID9yIC199/5F5H7/84BZPxPIE94ouXSDggU+/6RqxKNB2xN0Gb9csO3Pkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu/s2PsE4NEnhDsMF3w92YShtcDzwnBtxvd2C5KmHXDm+IO+ZY
	Llb8GuiqOoRP6Mo8AVd/0PSKKFbNzkghY9PxqHbPHh2IOUoCunqs
X-Google-Smtp-Source: AGHT+IE2VbhYvinnTtnp8gdiPFs7AssOulNu8P5FQjpDVoCidl6hRwDILWFOZsBNBRYKYFDJk0Ss8Q==
X-Received: by 2002:a05:6a20:9f4a:b0:1d5:1729:35ec with SMTP id adf61e73a8af0-1d8c955c8ebmr16914023637.7.1728956026633;
        Mon, 14 Oct 2024 18:33:46 -0700 (PDT)
Received: from dw-tp.. ([171.76.80.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e77508562sm189349b3a.186.2024.10.14.18.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 18:33:45 -0700 (PDT)
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
Subject: [RFC RESEND v2 00/13] powerpc/kfence: Improve kfence support
Date: Tue, 15 Oct 2024 07:03:23 +0530
Message-ID: <cover.1728954719.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resending v2 for review comments.

This patch series addresses following to improve kfence support on Powerpc.

1. Usage of copy_from_kernel_nofault() within kernel, such as read from
   /proc/kcore can cause kfence to report false negatives.

   This is similar to what was reported on s390. [1]
   [1]: https://lore.kernel.org/all/20230213183858.1473681-1-hca@linux.ibm.com/

   Hence this series adds patch-1 as a kfence kunit test to detect
   copy_from_kernel_nofault() case. I assume the same might be needed for all
   other archs as well (Please correct if this understanding is wrong).

   Patch-2, thus adds a fix to handle this case in ___do_page_fault() for
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
rather than 16MB mapping. This should be improved in future.

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


