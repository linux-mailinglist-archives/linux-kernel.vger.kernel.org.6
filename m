Return-Path: <linux-kernel+bounces-186245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E2B8CC1A6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E189C1F2332C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CFB130E27;
	Wed, 22 May 2024 12:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LOvzzPqj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC17E17C9
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 12:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716382642; cv=none; b=S/gYFEoA4pnezK+TJu+QzQzipTSZVay/LV6GvobCvQR3rD/7+FECp49egEy7lWeRgLefCyeNGNwH6bW5e7x+6oxusB3LhqNUPTOvIK68BJdy9FYQaUvrcGJVOIkMKt6L427oP6aGYHjnFTSjHYhfkfjoWmwkNMhUlurKoQ8S8G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716382642; c=relaxed/simple;
	bh=R7VE9+fLKmBOLpnrP084vfG0UQrc8BBWSiV8jddInkk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nAGkCVV2LxtoHkpfIlmlK0IW/ginjX+G6AdOzGeryLZZbYIBubQ/HUEPAbGLpipy//Mn7svFmv5N7k8SxTdP5XlbTtN99/1i/sIY75zC3RV9kt+zOwF0iDh2F5ffzXZs3yMi7a7/58kZ1wxxyCrSqgIxeoYRZTC+QeanIEClRN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LOvzzPqj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716382639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o/utX1MEHc2TwOEpLKg+wlbdf8OjMA6nlb8SpmUn5jQ=;
	b=LOvzzPqjNjoPKNEbRzmiU87KbrZBaPrvtduEd2/dzFgZUCUNcYOIMKJIYbQNmv4tKA4sI/
	n37QhyswLyph/5Fp6ypnjp0J+OTYyE37Ts3Y7DD57s9UZpsU1SBG00FT2B+TdyeJ2hPYhs
	IHwDBRWlxsSoyiWHgsEtETIg7a5/hkM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-AwzxaaifN8WmtjwIMvUPeQ-1; Wed, 22 May 2024 08:57:15 -0400
X-MC-Unique: AwzxaaifN8WmtjwIMvUPeQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C2EE185A780;
	Wed, 22 May 2024 12:57:15 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.195.53])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 13B5040C6EB7;
	Wed, 22 May 2024 12:57:13 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2 0/3] mm/memory: cleanly support zeropage in vm_insert_page*(), vm_map_pages*() and vmf_insert_mixed()
Date: Wed, 22 May 2024 14:57:10 +0200
Message-ID: <20240522125713.775114-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

There is interest in mapping zeropages via vm_insert_pages() [1] into
MAP_SHARED mappings.

For now, we only get zeropages in MAP_SHARED mappings via
vmf_insert_mixed() from FSDAX code, and I think it's a bit shaky in some
cases because we refcount the zeropage when mapping it but not necessarily
always when unmapping it ... and we should actually never refcount it.

It's all a bit tricky, especially how zeropages in MAP_SHARED mappings
interact with GUP (FOLL_LONGTERM), mprotect(), write-faults and s390x
forbidding the shared zeropage (rewrite [2] s now upstream).

This series tries to take the careful approach of only allowing the
zeropage where it is likely safe to use (which should cover the existing
FSDAX use case and [1]), preventing that it could accidentally get mapped
writable during a write fault, mprotect() etc, and preventing issues
with FOLL_LONGTERM in the future with other users.

Tested with a patch from Vincent that uses the zeropage in context of
[1]. Vincent will post that patch based on this series soon. (not tested
with FSDAX, but I don't expect surprises).

[1] https://lkml.kernel.org/r/20240430111354.637356-1-vdonnefort@google.com
[2] https://lkml.kernel.org/r/20240411161441.910170-1-david@redhat.com

v1 -> v2:
* "mm/memory: move page_count() check into validate_page_before_insert()"
 -> Added
* "mm/memory: cleanly support zeropage in vm_insert_page*(), ..."
 -> Fixed "return true;" for never-writable VMAs

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vincent Donnefort <vdonnefort@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>

David Hildenbrand (3):
  mm/memory: move page_count() check into validate_page_before_insert()
  mm/memory: cleanly support zeropage in vm_insert_page*(),
    vm_map_pages*() and vmf_insert_mixed()
  mm/rmap: sanity check that zeropages are not passed to RMAP

 include/linux/rmap.h |  3 ++
 mm/memory.c          | 97 ++++++++++++++++++++++++++++++++------------
 mm/mprotect.c        |  2 +
 3 files changed, 77 insertions(+), 25 deletions(-)


base-commit: 29c73fc794c83505066ee6db893b2a83ac5fac63
-- 
2.45.0


