Return-Path: <linux-kernel+bounces-520802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ED8A3AF69
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 03:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F3471897E04
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 02:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAAB1474CC;
	Wed, 19 Feb 2025 02:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/B8l2iX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8132BAF4
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 02:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739931502; cv=none; b=CvIRqtnoCNSuFWWmYSahHSN5M2rAjrz4Z2hnHuLP2jgu1SBhDVUebZIx5SNBjKn7eES3YsRCtHAiM4dHhEDrBg/iEZeCZvjdhBYTLNQct9qlArKUR9AutiNHMRFlV3ZoWUsnwuljQ6xX8p78GQF1ETpDwTJBNnVEBo9ccxCyyj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739931502; c=relaxed/simple;
	bh=d5gBe3uMzbzbRgMIs5yqF32u3cf3K3rckJ+RBQQLERc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h2hvekRRpSvH9JN9BM1Pek2X1f97C5A8iNfMT6C9d1U5EBt3toOm4Tc4NVoeKuoDd5S7Sf8uDVY/RtBbpN4p2t94p9WCd1I3wKnOwMfmxnUb7b31aapONGlzZfPfKsd38XAp+rW3/ODwTCsXboIHNPqYmbB7RfqI6UScct/BMqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e/B8l2iX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739931499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=I/mn+nVqK2FRLw7VBAQJ/H349Ch26E3Rtf6ayDMSoXY=;
	b=e/B8l2iXMcyrw9a7lupBl6TdfLyIpCBOU2ZlRKfNMmI2asqy2x9aNOGoAvaSSJJOuzH7iL
	9SvKPTezmTmQ2UXqRqMelDhYHXn8pWyvU+TMufKOJMAe8HMftGhSqDog9rhtJZO+dgPOmG
	AYjCCT/v92y6xJregGnV4JMQQxArvuI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-cD9dy8IXPDaf652OcGdbqg-1; Tue,
 18 Feb 2025 21:18:14 -0500
X-MC-Unique: cD9dy8IXPDaf652OcGdbqg-1
X-Mimecast-MFC-AGG-ID: cD9dy8IXPDaf652OcGdbqg_1739931493
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 959811975AFC;
	Wed, 19 Feb 2025 02:18:12 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.65.50])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9D6D01956094;
	Wed, 19 Feb 2025 02:18:09 +0000 (UTC)
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
Subject: [PATCH 0/4] mm: page_ext: Introduce new iteration API
Date: Tue, 18 Feb 2025 21:17:46 -0500
Message-ID: <cover.1739931468.git.luizcap@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hi,

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

All details in patch 1. Also, this series is against Linus tree commit
2408a807bfc3f738850ef5ad5e3fd59d66168996 .

RFC -> v1
=========

- Revamped the API by introducing for_each_page_ext macros
- Implemented various suggestions from David Hildenbrand, including page_ext
  lookup optimization
- Fixed changelogs

Luiz Capitulino (4):
  mm: page_ext: add an iteration API for page extensions
  mm: page_table_check: use new iteration API
  mm: page_owner: use new iteration API
  mm: page_ext: make page_ext_next() private to page_ext

 include/linux/page_ext.h | 67 +++++++++++++++++++++++++++++++++++++---
 mm/page_ext.c            | 48 ++++++++++++++++++++++++++++
 mm/page_owner.c          | 61 +++++++++++++++++-------------------
 mm/page_table_check.c    | 39 +++++++----------------
 4 files changed, 152 insertions(+), 63 deletions(-)

-- 
2.48.1


