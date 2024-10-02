Return-Path: <linux-kernel+bounces-348044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA76198E1E7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04E85B2149E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79761D1E78;
	Wed,  2 Oct 2024 17:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="s7wB8Qcn"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0D81CF7C0
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 17:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727891551; cv=none; b=rTwI2OpZeiYrxQKOOc38MtrsNAO5wsO1zUKLTugauTQwneDJhB4GHT97ay8UKgs4V6qFsftZtr4rvgc5eN2Rk6WdwMjiLYkpjBjkzOo7DL5g5L3XNjafayzkUwTfqVnP6RBWGYs7k40arlJdJfp0DcBVAlEGUzR3QikXb/sF7B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727891551; c=relaxed/simple;
	bh=wk8p6lzukF8yBA3uxE2CqSo+Vhoww/sOQAA3V6pgf4M=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Xj3J6Y/BKjiBjmr9RRCxDwaxDNKAthvmftHjPl/EHRTQvGvJrfTsFAu8eGPRTrixgioe+p4iaOjWCyQfbeBoHSV0KPyyul+erJim7wr8Qljm6UPs+0aug+D8ncg94SCluyc2bWy75JLLTF88RoSAiE+YdZDmAw8DxgmBD0yDp9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=s7wB8Qcn; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1727891543;
	bh=wk8p6lzukF8yBA3uxE2CqSo+Vhoww/sOQAA3V6pgf4M=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=s7wB8Qcne2VlJIdwZeNh3AGZwNaDoTvI38QX/U/Pa/qkZ6eUaoRmpaa6mBZNLP+V2
	 Zb74XaF8ZD/lNoHBL4g1y6ZUNByPyjx/Xs+3lsl+nhhLZeXH/4bSm8W6ucQF61RVyJ
	 GzrvRxDJSvs+NqI0H6L/HmdLPzHM1Up+OoWK4KbE=
Received: by gentwo.org (Postfix, from userid 1003)
	id 2BD4840687; Wed,  2 Oct 2024 10:52:23 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 2A6384025F;
	Wed,  2 Oct 2024 10:52:23 -0700 (PDT)
Date: Wed, 2 Oct 2024 10:52:23 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Vlastimil Babka <vbabka@suse.cz>
cc: Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
    Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Hyeonggon Yoo <42.hyeyoo@gmail.com>, Yang Shi <shy828301@gmail.com>, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, 
    Huang Shijie <shijie@os.amperecomputing.com>
Subject: Re: [PATCH v3] SLUB: Add support for per object memory policies
In-Reply-To: <2cbdf455-f12f-4c40-9d08-527857fb2621@suse.cz>
Message-ID: <7914434f-73f8-7527-9b40-5c4557e2ce1e@gentwo.org>
References: <20241001-strict_numa-v3-1-ee31405056ee@gentwo.org> <2cbdf455-f12f-4c40-9d08-527857fb2621@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 2 Oct 2024, Vlastimil Babka wrote:

> OK, but we should document this parameter in:
> Documentation/admin-guide/kernel-parameters.rst
> Documentation/mm/slab.rst

mm/slab.rst is empty? I used slub.rst instead.

Here is a patch to add documentation:


From 510a95b00355fcbf3fb9e0325c1a0f0ef80c6278 Mon Sep 17 00:00:00 2001
From: Christoph Lameter <cl@gentwo.org>
Date: Wed, 2 Oct 2024 10:27:00 -0700
Subject: [PATCH] Add documentation for the new slab_strict_numa kernel command
 line option

Signed-off-by: Christoph Lameter (Ampere) <cl@linux.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 10 ++++++++++
 Documentation/mm/slub.rst                       |  9 +++++++++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1518343bbe22..89a4c0ec290c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6544,6 +6544,16 @@
 	stifb=		[HW]
 			Format: bpp:<bpp1>[:<bpp2>[:<bpp3>...]]

+	slab_strict_numa	[MM]
+			Support memory policies on a per object level
+			in the slab allocator. The default is for memory
+			policies to be applied at the folio level when
+			a new folio is needed or a partial folio is
+			retrieved from the lists. Increases overhead
+			in the slab fastpaths but gains more accurate
+			NUMA kernel object placement which helps with slow
+			interconnects in NUMA systems.
+
         strict_sas_size=
 			[X86]
 			Format: <bool>
diff --git a/Documentation/mm/slub.rst b/Documentation/mm/slub.rst
index 60d350d08362..84ca1dc94e5e 100644
--- a/Documentation/mm/slub.rst
+++ b/Documentation/mm/slub.rst
@@ -175,6 +175,15 @@ can be influenced by kernel parameters:
 	``slab_max_order`` to 0, what cause minimum possible order of
 	slabs allocation.

+``slab_strict_numa``
+        Enables the application of memory policies on each
+        allocation. This results in more accurate placement of
+        objects which may result in the reduction of accesses
+        to remote nodes. The default is to only apply memory
+        policies at the folio level when a new folio is acquired
+        or a folio is retrieved from the lists. Enabling this
+        option reduces the fastpath performance of the slab allocator.
+
 SLUB Debug output
 =================

-- 
2.39.5




