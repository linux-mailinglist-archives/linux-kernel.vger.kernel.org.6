Return-Path: <linux-kernel+bounces-333994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2B997D12B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B32DB215E9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 06:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090812AF11;
	Fri, 20 Sep 2024 06:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k77nWqAa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F6F33F6
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 06:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726813826; cv=none; b=VSR8RKkkvHyxHspf34wHGroBc4FMMPkR5BEAH0dgd9pEjI2fbVENjbic6WF+FLHLuw7Zz7QZJCHUXZ9EU/CIZplkPkLPJj3NtxrrmUUmPMzZ+zyphnn6A8ImnVIrHsASkONrwi6l9F2oAc+t2pe7LfD7q2hoqJEVWIqha7uew1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726813826; c=relaxed/simple;
	bh=Pe+WAPxzuTGsBBQQqGPEUm+5Sp6gIwkpDFcWs09U3uk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=isPNxzkJKGc0i0+gLMhbhc29FaSyu9XP+5Zk6JrPCxawmkei5aq6fpfJgiDm+3btRvmcLUZwN3Psq7PBueF2+/52IVyl5YMI6W3DMzHxhN14OzkED5LMLAFrUR1H2MAk5VH5dvfgHs3YCiIDz9mrClXuUkl3bHMrWlf55vlxR4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k77nWqAa; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726813824; x=1758349824;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=Pe+WAPxzuTGsBBQQqGPEUm+5Sp6gIwkpDFcWs09U3uk=;
  b=k77nWqAaR2kZ3iwND1jF+NHpsBmuON3UBeTtH+NogxkQcBBktZ4I67h1
   Tq8p2hwjtyTPZotEbFA88Xy8n0W93+JT4bZnq0rMVYkqpcDrRewACttLf
   O7lf68QpLnr77gVdAKGQtjLAWmz7Dp7k2bjrWjjOMTY7l7LtRSgbw3ElN
   XcO3rktTNkCktcBeyPCX/5u3Xm/P+WecHPfclJScsLVQq34cJULBNOaDG
   tqud+886Rm/tG2alBKkW9LCjPbaIjKNZlxFb1G9GtZlClOM+fRcOkmvtX
   1RPf8zAfNDNTxTOBVw2Yu/2ABd8ve36qROHxkOA3J40ZzwKPWmxrdGo48
   w==;
X-CSE-ConnectionGUID: jCrIK8CRQqaLbXm/TDvHCA==
X-CSE-MsgGUID: DuLck5FbRx+IVs81rGJq8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25955158"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="25955158"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 23:30:23 -0700
X-CSE-ConnectionGUID: s4VNOZFQR3KH1wrfl6dlxA==
X-CSE-MsgGUID: qjxvegbvR/WQmnZ/0KgEAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="70203435"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 23:30:21 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Waiman Long <longman@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Alistair Popple
 <apopple@nvidia.com>,  Dave Jiang <dave.jiang@intel.com>,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memory tier: Remove unused default_dram_perf_ref_source
In-Reply-To: <20240919191357.49976-1-longman@redhat.com> (Waiman Long's
	message of "Thu, 19 Sep 2024 15:13:57 -0400")
References: <20240919191357.49976-1-longman@redhat.com>
Date: Fri, 20 Sep 2024 14:26:48 +0800
Message-ID: <87y13mvo0n.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi, Waiman,

Waiman Long <longman@redhat.com> writes:

> Commit 3718c02dbd4c ("acpi, hmat: calculate abstract distance with HMAT")
> added a default_dram_perf_ref_source variable that was initialized but
> never used. This causes kmemleak to report the following memory leak:
>
> unreferenced object 0xff11000225a47b60 (size 16):
> =C2=A0 comm "swapper/0", pid 1, jiffies 4294761654
> =C2=A0 hex dump (first 16 bytes):
> =C2=A0 =C2=A0 41 43 50 49 20 48 4d 41 54 00 c1 4b 7d b7 75 7c =C2=A0ACPI =
HMAT..K}.u|
> =C2=A0 backtrace (crc e6d0e7b2):
> =C2=A0 =C2=A0 [<ffffffff95d5afdb>] __kmalloc_node_track_caller_noprof+0x3=
6b/0x440
> =C2=A0 =C2=A0 [<ffffffff95c276d6>] kstrdup+0x36/0x60
> =C2=A0 =C2=A0 [<ffffffff95dfabfa>] mt_set_default_dram_perf+0x23a/0x2c0
> =C2=A0 =C2=A0 [<ffffffff9ad64733>] hmat_init+0x2b3/0x660
> =C2=A0 =C2=A0 [<ffffffff95203cec>] do_one_initcall+0x11c/0x5c0
> =C2=A0 =C2=A0 [<ffffffff9ac9cfc4>] do_initcalls+0x1b4/0x1f0
> =C2=A0 =C2=A0 [<ffffffff9ac9d52e>] kernel_init_freeable+0x4ae/0x520
> =C2=A0 =C2=A0 [<ffffffff97c789cc>] kernel_init+0x1c/0x150
> =C2=A0 =C2=A0 [<ffffffff952aecd1>] ret_from_fork+0x31/0x70
> =C2=A0 =C2=A0 [<ffffffff9520b18a>] ret_from_fork_asm+0x1a/0x30

Good catch!

> Fix this memory leak by removing default_dram_perf_ref_source.

We should have used that information.  So, I suggest the fix as below.
Is it OK for you?

---------------------------8<---------------------------------------
From 32e6d70f531718cf99064a43fdffc8639aedcc5c Mon Sep 17 00:00:00 2001
From: Huang Ying <ying.huang@intel.com>
Date: Fri, 20 Sep 2024 09:47:40 +0800
Subject: [PATCH] memory tiers: use default_dram_perf_ref_source in log mess=
age

Commit 3718c02dbd4c ("acpi, hmat: calculate abstract distance with HMAT")
added a default_dram_perf_ref_source variable that was initialized but
never used. This causes kmemleak to report the following memory leak:

unreferenced object 0xff11000225a47b60 (size 16):
  comm "swapper/0", pid 1, jiffies 4294761654
  hex dump (first 16 bytes):
    41 43 50 49 20 48 4d 41 54 00 c1 4b 7d b7 75 7c  ACPI HMAT..K}.u|
  backtrace (crc e6d0e7b2):
    [<ffffffff95d5afdb>] __kmalloc_node_track_caller_noprof+0x36b/0x440
    [<ffffffff95c276d6>] kstrdup+0x36/0x60
    [<ffffffff95dfabfa>] mt_set_default_dram_perf+0x23a/0x2c0
    [<ffffffff9ad64733>] hmat_init+0x2b3/0x660
    [<ffffffff95203cec>] do_one_initcall+0x11c/0x5c0
    [<ffffffff9ac9cfc4>] do_initcalls+0x1b4/0x1f0
    [<ffffffff9ac9d52e>] kernel_init_freeable+0x4ae/0x520
    [<ffffffff97c789cc>] kernel_init+0x1c/0x150
    [<ffffffff952aecd1>] ret_from_fork+0x31/0x70
    [<ffffffff9520b18a>] ret_from_fork_asm+0x1a/0x30

This reminds us that we forget to use the performance data source
information.  So, use the variable in the error log message to help
identify the root cause of inconsistent performance number.

Fixes: 3718c02dbd4c ("acpi, hmat: calculate abstract distance with HMAT")
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Reported-by: Waiman Long <longman@redhat.com>
---
 mm/memory-tiers.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 4775b3a3dabe..0f5ba5c6e0c6 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -749,10 +749,10 @@ int mt_set_default_dram_perf(int nid, struct access_c=
oordinate *perf,
 		pr_info(
 "memory-tiers: the performance of DRAM node %d mismatches that of the refe=
rence\n"
 "DRAM node %d.\n", nid, default_dram_perf_ref_nid);
-		pr_info("  performance of reference DRAM node %d:\n",
-			default_dram_perf_ref_nid);
+		pr_info("  performance of reference DRAM node %d from %s:\n",
+			default_dram_perf_ref_nid, default_dram_perf_ref_source);
 		dump_hmem_attrs(&default_dram_perf, "    ");
-		pr_info("  performance of DRAM node %d:\n", nid);
+		pr_info("  performance of DRAM node %d from %s:\n", nid, source);
 		dump_hmem_attrs(perf, "    ");
 		pr_info(
 "  disable default DRAM node performance based abstract distance algorithm=
.\n");
--=20
2.39.2


