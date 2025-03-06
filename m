Return-Path: <linux-kernel+bounces-550020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE402A55A12
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 23:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE4C5177E7E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474A727CCE1;
	Thu,  6 Mar 2025 22:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WWNdYmLL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D478F27CB0C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 22:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741301115; cv=none; b=EVGZpCoYDdzlYViZ75xaCQw/0rcf0H/9MNQRPqHPfpez9UQG6Vo2Gg5uMol+4w0GG3IYq/X6qoOD4QB3CfqKvKVOa9M/BhGxoXn/SUcjywFP++fK1a757E/455UHqNS1o+o7nKiRfMbgMEKBbelkuIz8moV5QL8oqRd/fW5z1LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741301115; c=relaxed/simple;
	bh=Sp6uQiXHhEHz/2JiiHF/qNdM12VtMMkojU/jB1lMqiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ud3VdCAggnQpxV4AUaVisWNF0iot5GhipGhZUPKRgOGBdy+5RRIBUODGqcskYQkL27P3fCoq+4esRVZ0zEzYLf5dD+v6T5OIogc42XVipRp6F1fX31tgE5HJvJ1/zeKlePTnQ/IcdMuwexWLT5HvOdNOdRWWWjjazlBHxFZMwj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WWNdYmLL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741301112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jizhA/rqhXJwS3A3pxZ/QRAfj5aycaqM9rDetHR50vU=;
	b=WWNdYmLLhi3YHzVRwxdZzzH++VcJqcAQnzmvFO+qeka+SxxTulYYt+ez2Mnpweqsfmbxdr
	JTbkJx/9h1UmBQVNCMKt2fpAi7HML6WrgVstejpP3jj8I03okrho33oFx6NstcfCDwEr7O
	ok0TATTuqz5K8y6l3LRW6mM+ltAEOAw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-FqxMgNPlNeesPetHBR-TRg-1; Thu,
 06 Mar 2025 17:45:04 -0500
X-MC-Unique: FqxMgNPlNeesPetHBR-TRg-1
X-Mimecast-MFC-AGG-ID: FqxMgNPlNeesPetHBR-TRg_1741301103
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 366F6195609E;
	Thu,  6 Mar 2025 22:45:02 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.88.191])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1763E180174C;
	Thu,  6 Mar 2025 22:44:58 +0000 (UTC)
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
Subject: [PATCH v3 0/3] mm: page_ext: Introduce new iteration API
Date: Thu,  6 Mar 2025 17:44:49 -0500
Message-ID: <cover.1741301089.git.luizcap@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This series is against v6.14-rc5. The introduction is after the changelog.

v2 -> v3
========

- Change the new API to take a PFN number instead of a struct page, which
  solves header file issue (David)
- Optimize page_ext_get()/page_ext_put() in __folio_copy_owner (David)

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

Please, find all details in patch 1.

I tested this series on arm64 and x86 by reserving 1G pages at run-time
and doing kernel builds (always with page_owner=on and page_table_check=on).

Luiz Capitulino (3):
  mm: page_ext: add an iteration API for page extensions
  mm: page_table_check: use new iteration API
  mm: page_owner: use new iteration API

 include/linux/page_ext.h | 93 ++++++++++++++++++++++++++++++++++++++++
 mm/page_ext.c            | 13 ++++++
 mm/page_owner.c          | 84 +++++++++++++++++-------------------
 mm/page_table_check.c    | 39 ++++++-----------
 4 files changed, 157 insertions(+), 72 deletions(-)

-- 
2.48.1


