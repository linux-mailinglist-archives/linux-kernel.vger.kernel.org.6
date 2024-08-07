Return-Path: <linux-kernel+bounces-278558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1C594B1CE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BFCD2832F3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297AF149C52;
	Wed,  7 Aug 2024 21:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZV8eYLMP"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0318149C74
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 21:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723065196; cv=none; b=UXLqlBs9whKqkEkBSwJNPpTpG01DItWfyaXN1O9QFhakMmol0tzJFDBv8mw8HNFlyfQEhSnMWEx9G7I2r/XOwQw+CI/7aUz6fLzgyJeuJdETjzgQR9AFusz3+ibuj9R2TVwyBv66BciJn84SOYftpYgdBovEc7lL/DCQjbTr9T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723065196; c=relaxed/simple;
	bh=rJvFCJRnLDrd0JLf0SNcK/Py70bAJi9FPN3qr2k2Eb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o2abMBZlnl/n21tVA97eGfZ1rd4Oqankn88/QLqhnddozp85BlWdqGGE+wz32DSAjY2Ya5Z+sNG2qc6EQ46IrdKXCx0Z1S+CZIBCX3y5JnTR2RRk3Cmeg3NNt+s/XapgYLCGeeqhxLBVqqUx4sOsy4nIswF2P16kBJtveLbDbXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZV8eYLMP; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4281c164408so1976805e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 14:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723065193; x=1723669993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lrrDVNBVJjG3BROxuSaWDoClqsHJx/swoKqFmUrOq+Q=;
        b=ZV8eYLMPpxs84KD166tGZM6fdqt7hm8UfeAHwnZQd3k07vSQXqNU+IXBH7xjNsG+X7
         XwxqaGauD+hcJNVW+dT51iGeVvvfhElFBTLiywuvFcoOS2tzvbntt3hjBDXbdVtdGykn
         6t13J17kC84ePGUgGsaDfKebQMXn3nXg7pp7rtU2ORZ8udQ9qT0/TCDFFI255r6TQxfP
         h+AD/2bf5dzwlahApYk6Hf5GRK4ZR6qofUi0LNTN8OZZRb8NK8Rizew+zR14rus2++oj
         M8S1ejktfZ32KZ/f6FYJCe4BEIHM34B4GAhwoc593VspGnEvcu6AFQrFFVi2YtGiAPSt
         C3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723065193; x=1723669993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lrrDVNBVJjG3BROxuSaWDoClqsHJx/swoKqFmUrOq+Q=;
        b=UBgsquyqR4Icl9PWPiUCs3NqDKlbLox3fJ3TIl7GpqvI1HMYcWb4pLLfc16mdjnkxL
         ZGLOx51Du5DB66BTR0Tgu22HSfzklTJzuufLzwwzd3B2s94izrZhgcQdpCcFsZJtZRIy
         3QyajktiGWS7kCcO0DyMfQwq93T0HmGP4XqG21mLD29TO8b+0iGKytVUwQ8JDbM1NJ/X
         H71+VTJNBqMGdL9cUT4xIMJxPUcifWnYMNTFN3MpsxLxcsxsJvBYrAN8120Is3ZL3omS
         slPQBtMxyf81krDcExblfhqSRt/IbY9vdKlHjjzT39yJO/JHyS5KQhlRzBwbGIO+QE5k
         lu8A==
X-Forwarded-Encrypted: i=1; AJvYcCW9fl1oNRJuBzXyRqTUdtUCCe2ye+jqTh4tTq+EJOvenp/vKVpbvVQmVvjQdaDaeL2fr578DXolzs2W/ZeEss7c1tFpyflRRnEmZvyq
X-Gm-Message-State: AOJu0Yyp9TG2R4qz0/SyXeR09hWzGbB/AwO/vt//9iiXoBTPhTad/Or5
	KvweFdrAdjQ6H/TyKx/ieoeZ62CZumSKKylyV4LymqctIuNVoI8h
X-Google-Smtp-Source: AGHT+IFlZVDtRgnqvHYwWAb6ZyYUbQHqkg29elDD1V4sR9zX/+O5uQJsxhTOoILbdcToGU5ScPPjpQ==
X-Received: by 2002:a05:600c:190c:b0:426:6e8b:3dc5 with SMTP id 5b1f17b1804b1-4290af1e8f5mr32875e9.32.1723065192539;
        Wed, 07 Aug 2024 14:13:12 -0700 (PDT)
Received: from PC-PEDRO-ARCH.lan ([2001:818:e92f:6400:96b:aa92:afc0:2d3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429057a92c8sm45869525e9.23.2024.08.07.14.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 14:13:12 -0700 (PDT)
From: Pedro Falcato <pedro.falcato@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	oliver.sang@intel.com,
	torvalds@linux-foundation.org,
	jeffxu@google.com,
	Michael Ellerman <mpe@ellerman.id.au>,
	Pedro Falcato <pedro.falcato@gmail.com>
Subject: [PATCH v2 0/6] mm: Optimize mseal checks
Date: Wed,  7 Aug 2024 22:13:03 +0100
Message-ID: <20240807211309.2729719-1-pedro.falcato@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[based on mm-unstable, 98808d08]

Optimize mseal checks by removing the separate can_modify_mm() step, and
just doing checks on the individual vmas, when various operations are
themselves iterating through the tree. This provides a nice speedup and restores
performance parity with pre-mseal[3].

This series also depends on (and will eventually very slightly conflict with)
the powerpc series that removes arch_unmap[2].

will-it-scale mmap1_process[1] -t 1 results:

commit 3450fe2b574b4345e4296ccae395149e1a357fee:

min:277605 max:277605 total:277605
min:281784 max:281784 total:281784
min:277238 max:277238 total:277238
min:281761 max:281761 total:281761
min:274279 max:274279 total:274279
min:254854 max:254854 total:254854
measurement
min:269143 max:269143 total:269143
min:270454 max:270454 total:270454
min:243523 max:243523 total:243523
min:251148 max:251148 total:251148
min:209669 max:209669 total:209669
min:190426 max:190426 total:190426
min:231219 max:231219 total:231219
min:275364 max:275364 total:275364
min:266540 max:266540 total:266540
min:242572 max:242572 total:242572
min:284469 max:284469 total:284469
min:278882 max:278882 total:278882
min:283269 max:283269 total:283269
min:281204 max:281204 total:281204

After this patch set:

min:280580 max:280580 total:280580
min:290514 max:290514 total:290514
min:291006 max:291006 total:291006
min:290352 max:290352 total:290352
min:294582 max:294582 total:294582
min:293075 max:293075 total:293075
measurement
min:295613 max:295613 total:295613
min:294070 max:294070 total:294070
min:293193 max:293193 total:293193
min:291631 max:291631 total:291631
min:295278 max:295278 total:295278
min:293782 max:293782 total:293782
min:290361 max:290361 total:290361
min:294517 max:294517 total:294517
min:293750 max:293750 total:293750
min:293572 max:293572 total:293572
min:295239 max:295239 total:295239
min:292932 max:292932 total:292932
min:293319 max:293319 total:293319
min:294954 max:294954 total:294954

This was a Completely Unscientific test but seems to show there were around 5-10% gains on ops per second.

Oliver performed his own tests and showed[3] a similar ~5% gain in them.

[1]: mmap1_process does mmap and munmap in a loop. I didn't bother testing multithreading cases.
[2]: https://lore.kernel.org/all/20240807124103.85644-1-mpe@ellerman.id.au/
[3]: https://lore.kernel.org/all/ZrMMJfe9aXSWxJz6@xsang-OptiPlex-9020/
Link: https://lore.kernel.org/all/202408041602.caa0372-oliver.sang@intel.com/

Changes in v2:
 - Rebased on top of mm-unstable
 - Removed a superfluous check in mremap (Jeff Xu)

Pedro Falcato (6):
  mm: Move can_modify_vma to mm/internal.h
  mm/munmap: Replace can_modify_mm with can_modify_vma
  mm/mprotect: Replace can_modify_mm with can_modify_vma
  mm/mremap: Replace can_modify_mm with can_modify_vma
  mseal: Replace can_modify_mm_madv with a vma variant
  mm: Remove can_modify_mm()

 mm/internal.h | 30 ++++++++++++++++++++--------
 mm/madvise.c  | 13 +++---------
 mm/mmap.c     | 13 +-----------
 mm/mprotect.c | 12 +++--------
 mm/mremap.c   | 30 ++++------------------------
 mm/mseal.c    | 55 ++++-----------------------------------------------
 mm/vma.c      | 23 ++++++++++-----------
 7 files changed, 49 insertions(+), 127 deletions(-)


base-commit: 98808d08fc0f78ee638e0c0a88020fbbaf581ec6
-- 
2.46.0


