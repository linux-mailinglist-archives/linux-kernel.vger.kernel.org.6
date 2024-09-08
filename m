Return-Path: <linux-kernel+bounces-320313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CC29708BC
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 18:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AC941F214C7
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 16:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323C31714AE;
	Sun,  8 Sep 2024 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/VaaMII"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B502B9B5;
	Sun,  8 Sep 2024 16:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725812435; cv=none; b=ad9aKvIcdw85hONIQvlTtMjUTyChwijdsS26h2ysflOhcpp+EC4Gh+x9P6NwYTN8ItxLJQkWBySm6nlWXkDzxGZ5nipIoljTf8rmHRpQtnnEv23zkdGFnF6eZczQPR8jcrru/jmDZC7EuKA2EcGDwiMDwi08lOIePSDr/xZX09o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725812435; c=relaxed/simple;
	bh=hiPiTepAb+Fpvuy0MqNdPFDvMpFOPNQ50AG2OJe8f7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T7IJdHSQLZX2609r1MqkmS+qe/na2SCIEKl8a+3d6M7rzFB24XxikmFn8HHYWGZAP49I+PWbj40fhnF/oj4cvPgfLyfLIKletic15NP0T14rjK0Kj4aNq2Cg4osUkC5wDaUTj6SPh4P5H7EoQvLaN2bOWd2KyRj0nnsf0Cz8TpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/VaaMII; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a9aa913442so60767985a.1;
        Sun, 08 Sep 2024 09:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725812433; x=1726417233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R+KJF6T6XBCWzZ+orANPx7bX+BJ+F0qpNOws7FrO2Ek=;
        b=S/VaaMIIJchlufs6QLml/n+Z9HVGgmcEO06nQ+wu7NsuX/AymD8iUM15vRsItA4I2D
         0KHI6pFBqXZoNhGHtT8HDlXmKpjyYM9oIL9LwhpLBu9gv1mZxOvRoRqArnJpdfUVh6/r
         akfrFtYRd+OQDm8+8mjBe/ZoleMbnu1bkW+ciqZZX8kRo+FRzQwtqVJVPInLCXxqZaVi
         KFQC3D+TGAMXWbwTQylWnvdZZ2HBGsIAaqv+03kfjYH6J7FOul9A2pTNgIG2/zjywCd3
         5Cy508R24zABCrq5Xs+Br4+Y4BCaomXWWIF6FIQcTEtoU7Ds/cCijOaYLHgQ0VkE4jzy
         ov+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725812433; x=1726417233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+KJF6T6XBCWzZ+orANPx7bX+BJ+F0qpNOws7FrO2Ek=;
        b=sizf3QiIFg2GIVdEfcHAcKpcogmETawRq9cgw2MT4RE7hQGTEj95RywTKfhQHgtMCQ
         0TvWPYMM+ED+SHfeOSkNTUnGgJuYqkSZmYpDoSUKY5hdDrEKwA+tXYqJQfo5ftwUzopv
         LCtHfQp86g4aNp2SpHxfKFsIo5U1movhwY99Ewl/1KqXs+cQNG1D05bKmpjkPSC+d/EO
         oMGVTSQ2b/Qe33wRiJWW9mwOXc7AMCgci9D7h0Kb0FTIItu5GYLAexeq80yP1Sm5rY3Q
         igJTPXtb2by8KliBxDRcNmNmuvXRu0wql/OFdh8EtUOPY5t+CaQ7HIBKN+IRTqqXPbfv
         CdSA==
X-Forwarded-Encrypted: i=1; AJvYcCUkRwmBFVfRNhqOCsIZ8FRq0fh1tJdCHwFcr5FHDkO7gfaimzWzcQ/SaAM2PcB8gsk8GYI31+eA5A1lxxUM@vger.kernel.org, AJvYcCXwyQsSR+jzY5ERWmAf61x7y3xemH71WYFv3ra3MVNTZYMxEC817eZWCYTGFOLJXxu43iv4nxIFQI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCUATK+tSxtqSYkLyxmyXBr8Fno8Cj+BCgvQNx1J6+WOIYOtUz
	xeAaGXOIugfmqMXHal7QWin7/op9xeQU5peBmVMLvqYuKs1PiNN8qr7rsGib
X-Google-Smtp-Source: AGHT+IGWDM3DwoIoL/vXTEgHYvo5VkmJMcLfpXnfszmZQCj0MNu7rhwgZQmWCAM6dDFsg9ve+yfHtw==
X-Received: by 2002:a05:620a:4547:b0:7a9:ac57:ff5a with SMTP id af79cd13be357-7a9ac58052dmr522393885a.39.1725812432755;
        Sun, 08 Sep 2024 09:20:32 -0700 (PDT)
Received: from localhost.localdomain (d24-150-189-55.home.cgocable.net. [24.150.189.55])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7a9a7a1ff6bsm139874185a.122.2024.09.08.09.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 09:20:32 -0700 (PDT)
From: Dennis Lam <dennis.lamerice@gmail.com>
To: jglisse@redhat.com,
	corbet@lwn.net
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dennis Lam <dennis.lamerice@gmail.com>
Subject: [PATCH] docs:mm: fix spelling mistakes in heterogeneous memory management page
Date: Sun,  8 Sep 2024 12:19:28 -0400
Message-ID: <20240908161928.3700-1-dennis.lamerice@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Dennis Lam <dennis.lamerice@gmail.com>
---
 Documentation/mm/hmm.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/mm/hmm.rst b/Documentation/mm/hmm.rst
index 0595098a74d9..f6d53c37a2ca 100644
--- a/Documentation/mm/hmm.rst
+++ b/Documentation/mm/hmm.rst
@@ -66,7 +66,7 @@ combinatorial explosion in the library entry points.
 Finally, with the advance of high level language constructs (in C++ but in
 other languages too) it is now possible for the compiler to leverage GPUs and
 other devices without programmer knowledge. Some compiler identified patterns
-are only do-able with a shared address space. It is also more reasonable to use
+are only doable with a shared address space. It is also more reasonable to use
 a shared address space for all other patterns.
 
 
@@ -267,7 +267,7 @@ functions are designed to make drivers easier to write and to centralize common
 code across drivers.
 
 Before migrating pages to device private memory, special device private
-``struct page`` need to be created. These will be used as special "swap"
+``struct page`` needs to be created. These will be used as special "swap"
 page table entries so that a CPU process will fault if it tries to access
 a page that has been migrated to device private memory.
 
@@ -322,7 +322,7 @@ between device driver specific code and shared common code:
    The ``invalidate_range_start()`` callback is passed a
    ``struct mmu_notifier_range`` with the ``event`` field set to
    ``MMU_NOTIFY_MIGRATE`` and the ``owner`` field set to
-   the ``args->pgmap_owner`` field passed to migrate_vma_setup(). This is
+   the ``args->pgmap_owner`` field passed to migrate_vma_setup(). This
    allows the device driver to skip the invalidation callback and only
    invalidate device private MMU mappings that are actually migrating.
    This is explained more in the next section.
@@ -405,7 +405,7 @@ can be used to make a memory range inaccessible from userspace.
 
 This replaces all mappings for pages in the given range with special swap
 entries. Any attempt to access the swap entry results in a fault which is
-resovled by replacing the entry with the original mapping. A driver gets
+resolved by replacing the entry with the original mapping. A driver gets
 notified that the mapping has been changed by MMU notifiers, after which point
 it will no longer have exclusive access to the page. Exclusive access is
 guaranteed to last until the driver drops the page lock and page reference, at
@@ -431,7 +431,7 @@ Same decision was made for memory cgroup. Device memory pages are accounted
 against same memory cgroup a regular page would be accounted to. This does
 simplify migration to and from device memory. This also means that migration
 back from device memory to regular memory cannot fail because it would
-go above memory cgroup limit. We might revisit this choice latter on once we
+go above memory cgroup limit. We might revisit this choice later on once we
 get more experience in how device memory is used and its impact on memory
 resource control.
 
-- 
2.46.0


