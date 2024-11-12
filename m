Return-Path: <linux-kernel+bounces-406641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8617C9C63BF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 22:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF7FAB3C723
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DDA20ADEC;
	Tue, 12 Nov 2024 19:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rByxKugT"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2432209F2C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 19:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731440801; cv=none; b=DcGeLQKXG04P1gyb7pAPSYw2Vnqu5Cv2y37vxFu5cJ+MCOjCjd0LmBaRTOtITSaeZOmgM6CY4iSNfAUvH5GBEyHskfOFCGaiuiAzzLOGnzMhQ0WQ7VUoiTq1dYhUFctZsvGj7+GcryKAaNDlpvt2eURD7qol8XAEKOkrkFv+/oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731440801; c=relaxed/simple;
	bh=G24aAjcpq1+VD9Y/uTMzJdk3DVb2TE9A/uFr+9u3Oaw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hjLUwcq1VoTwyEQW8Ad6lQteiCWetucy+7WOXo/0tSxwkuJupC8kN+sQKfejTRxaMXLRG/+WpPt/BI+1Thphxq79jstsbzlAcSfAzaeK9dsbv8x9/Y8prvAXPv5vJPO9VRB4738BkZ6QgMDs5yWNHaN8gIi7bDJlVXcm2TNmOGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rByxKugT; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea8a5e86e9so106236257b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731440798; x=1732045598; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AF2x/+p0Ylc/bREwxFLzNInsnbwCcKcjFFUkvhkDU9U=;
        b=rByxKugT/6ZOiTZpmCzNKFlYqUY1QdUdeoCzurDFQCpjO2Z5uecx+h+gQxccQ4ADzd
         4pLOP1TIKzRvZi0rdZZ/wLB4ALEKCvQMRUr/dsWG/IH1lhxiBcxZaX32sPY0DrOajmcR
         4tm5zDJl1Pyuf5tjln1KPxF1Ycb4/zhHja9LWEhw6ZgJwYrmx3Ln3ZMFPMcNhN6n/r1Q
         je7wpx3g94PNe2VWX/8SDNmwcHQ4u3MaiqDmJ2nqLVjC+ijwaFv+r7yI7kcwxk/uM4zn
         UJFw26Myk88Y1rc65ryx1B1Q/6G/HDbEbRvKgNl9Cqn6EIiq3xYuIueBx4VA/JqLzZ6G
         I2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731440798; x=1732045598;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AF2x/+p0Ylc/bREwxFLzNInsnbwCcKcjFFUkvhkDU9U=;
        b=Al261BlNSuM0+A2HpctCmnyn+5GQmHbjm8bJJ6sEhmXfj/31jHnA/S1kspZFlZ/oGa
         0+O07r1ZVLMRg6Qb+yNTlNYL6jQgxVuMCIh+x0eoOgiq9dJVZpizOFiZLNY03Jzbf+8G
         W3YI8IzCBAid1yWhMg5DL8m7ZLNmv6IW120umOD+4kcMS9ZjyCRGlhPJQYcpo3OBi9F8
         heGYwjgPSabaMcxZHL5MSuE4uhxmWd6hmi1Fmgbfm2J7jMnz85FD4PCPb4+6WSf6daAg
         usOaWC5+s5emTbFsgnbuTEyLzNA9nlxdgiJmx1Gox4WaSZppOHRvz5vKeN4kzgn76Npe
         xZZA==
X-Forwarded-Encrypted: i=1; AJvYcCV8RsuELCFqxiS3FYaAyZTZWeHY5bUFezOe+xA9DXXlHiqD46OgYry97ZUcWoP+L/usSr9p0mMnXqT5STo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnOO2tuUwjFAuv/Q5P8pUn08ICloW0wuPOysy+9iV1S7jBdDIJ
	HG86UKvPgtbO//esx+ry1GHX1y7/i3yNZ3RiIhcI0AOI4pW7UqDZv+1Z5nw7P1n/gE5wmysx4tI
	2aA==
X-Google-Smtp-Source: AGHT+IF+BMXEGFengzAG7xehuXVjUsqxJgcqQAvYQMfiQ3XjdzIdwAEC7IOyWs75X6Z3wEv7wHoO0ySBEjE=
X-Received: from surenb-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:cad5:5dc6:1298:ec42])
 (user=surenb job=sendgmr) by 2002:a05:690c:3349:b0:6e3:d670:f62a with SMTP id
 00721157ae682-6ecb343d0b9mr2037b3.3.1731440798550; Tue, 12 Nov 2024 11:46:38
 -0800 (PST)
Date: Tue, 12 Nov 2024 11:46:30 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241112194635.444146-1-surenb@google.com>
Subject: [PATCH v2 0/5] move per-vma lock into vm_area_struct
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, liam.howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com, 
	oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com, 
	peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, 
	brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	minchan@google.com, jannh@google.com, shakeel.butt@linux.dev, 
	souravpanda@google.com, pasha.tatashin@soleen.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Back when per-vma locks were introduces, vm_lock was moved out of
vm_area_struct in [1] because of the performance regression caused by
false cacheline sharing. Recent investigation [2] revealed that the
regressions is limited to a rather old Broadwell microarchitecture and
even there it can be mitigated by disabling adjacent cacheline
prefetching, see [3].
This patchset moves vm_lock back into vm_area_struct, aligning it at the
cacheline boundary and changing the cache to be cache-aligned as well.
This causes VMA memory consumption to grow from 160 (vm_area_struct) + 40
(vm_lock) bytes to 256 bytes:

    slabinfo before:
     <name>           ... <objsize> <objperslab> <pagesperslab> : ...
     vma_lock         ...     40  102    1 : ...
     vm_area_struct   ...    160   51    2 : ...

    slabinfo after moving vm_lock:
     <name>           ... <objsize> <objperslab> <pagesperslab> : ...
     vm_area_struct   ...    256   32    2 : ...

Aggregate VMA memory consumption per 1000 VMAs grows from 50 to 64 pages,
which is 5.5MB per 100000 VMAs. This overhead will be addressed in a
separate patchset by replacing rw_semaphore in vma_lock's implementation
with a different type of lock.
Moving vm_lock into vm_area_struct lets us simplify vm_area_free() path,
which in turn allows us to use SLAB_TYPESAFE_BY_RCU for vm_area_struct
cache. This should facilitate vm_area_struct reuse and will minimize the
number of call_rcu() calls.

Suren Baghdasaryan (5):
  mm: introduce vma_start_read_locked{_nested} helpers
  mm: move per-vma lock into vm_area_struct
  mm: mark vma as detached until it's added into vma tree
  mm: make vma cache SLAB_TYPESAFE_BY_RCU
  docs/mm: document latest changes to vm_lock

 Documentation/mm/process_addrs.rst | 10 +++--
 include/linux/mm.h                 | 54 +++++++++++++++++-----
 include/linux/mm_types.h           | 16 ++++---
 include/linux/slab.h               |  6 ---
 kernel/fork.c                      | 72 +++++++-----------------------
 mm/memory.c                        |  2 +-
 mm/mmap.c                          |  2 +
 mm/nommu.c                         |  2 +
 mm/userfaultfd.c                   | 14 +++---
 mm/vma.c                           |  3 ++
 tools/testing/vma/vma_internal.h   |  3 +-
 11 files changed, 92 insertions(+), 92 deletions(-)


base-commit: 931086f2a88086319afb57cd3925607e8cda0a9f
-- 
2.47.0.277.g8800431eea-goog


