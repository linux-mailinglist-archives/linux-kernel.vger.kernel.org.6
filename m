Return-Path: <linux-kernel+bounces-530146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8FCA42FA6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF33C17AF96
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD9A1EDA31;
	Mon, 24 Feb 2025 21:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b98OtZAa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E5E1EBFE6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 21:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740434366; cv=none; b=HFjJgNsbrZ0kezCq1rTcnsw9VhGg39D37xaRZBarCAHApTO0jEj0d3NFLBjOIGGH7QiPqGT8jzercOD5ckNDgn0I9OSTkJuihAnI39f5mfqWXC3UgVeOISfm3hIv+ukuXhzaKnBdxUr0pzsFkXatWbi/Kony9yQ/YyO2BrWDBTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740434366; c=relaxed/simple;
	bh=iyopBc6+eCC+M1Pt6uymDRmCUK1Ju/Llgaq6AN0koVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QvNQzLO45iqcLlMXuhbiZppLLUvmXzvp3SaD3p9yUKXPTpnnpV89a3PuRpelRERl8qB4TpDhoZR2RyifizFnn5Oh71X5j3oCAO+pQ4No07VQsoBw9UGORsmN+RJgLYzN9ldrGuTWhiV60lArGugdGgRTb8t60t7L23xMuH2ZpVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b98OtZAa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740434363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vDPhXGlAvceGOH95ueyoy89QBaIskHOY83k25VR+vSA=;
	b=b98OtZAac1ngfYsi2BlHuakGd6OWWVjDcf4q+cLlKz4qm15SrHfnownk+h+rftwvE/jJD9
	rSssjB82z52V6HtPsT0tSi3UllMGa56pTJ2qREJh2VVxIJZ6T5QbAaa5N5KdcTFPdA/VW8
	k2Dn6bTsO1l26YQRFb+u0G5NThfqq5Q=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-5iTqhX9aPhi37YB8mR_nIA-1; Mon,
 24 Feb 2025 16:59:20 -0500
X-MC-Unique: 5iTqhX9aPhi37YB8mR_nIA-1
X-Mimecast-MFC-AGG-ID: 5iTqhX9aPhi37YB8mR_nIA_1740434358
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 21BAC18EB2C9;
	Mon, 24 Feb 2025 21:59:18 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.65.50])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A161F180035F;
	Mon, 24 Feb 2025 21:59:15 +0000 (UTC)
From: Luiz Capitulino <luizcap@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	david@redhat.com,
	yuzhao@google.com,
	pasha.tatashin@soleen.com
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	muchun.song@linux.dev,
	luizcap@redhat.com
Subject: [PATCH v2 0/4] mm: page_ext: Introduce new iteration API
Date: Mon, 24 Feb 2025 16:59:04 -0500
Message-ID: <cover.1740434344.git.luizcap@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This series is against v6.14-rc4. The introduction is after the changelog.

v1 -> v2
========

- Drop for_each_page_ext_order() (David)
- Make page_ext_iter_begin() and page_ext_iter_next() inline functions
  (David)
- Move loop logic into page_ext_iter_begin() and page_ext_iter_next()
  (David)

RFC -> v1
=========

- Revamped the API by introducing for_each_page_ext macros
- Implemented various suggestions from David Hildenbrand, including page_ext
  lookup optimization
- Fixed changelogs

Introduction
============

  [ Thanks to David Hildenbrand for identifying the root cause of this
    issue and proving guidance on how to fix it. The new API idea, bugs
    and misconceptions are all mine though ]

Currently, trying to reserve 1G pages with page_owner=on and sparsemem
causes a crash. The reproducer is very simple:

 1. Build the kernel with CONFIG_SPARSEMEM=y and the table extensions
 2. Pass 'default_hugepagesz=1 page_owner=on' in the kernel command-line
 3. Reserve one 1G page at run-time, this should crash (see patch 1 for
    backtrace) 

 [ A crash with page_table_check is also possible, but harder to trigger ]

Apparently, starting with commit cf54f310d0d3 ("mm/hugetlb: use __GFP_COMP
for gigantic folios") we now pass the full allocation order to page
extension clients and the page extension implementation assumes that all
PFNs of an allocation range will be stored in the same memory section (which
is not true for 1G pages).

To fix this, this series introduces a new iteration API for page extension
objects. The API checks if the next page extension object can be retrieved
from the current section or if it needs to look up for it in another
section.

Please, find all details in patch 2.

Luiz Capitulino (4):
  mm: page_ext: make lookup_page_ext() public
  mm: page_ext: add an iteration API for page extensions
  mm: page_table_check: use new iteration API
  mm: page_owner: use new iteration API

 include/linux/page_ext.h | 93 ++++++++++++++++++++++++++++++++++++++++
 mm/page_ext.c            |  4 +-
 mm/page_owner.c          | 61 +++++++++++++-------------
 mm/page_table_check.c    | 39 ++++++-----------
 4 files changed, 136 insertions(+), 61 deletions(-)

-- 
2.48.1


