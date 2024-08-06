Return-Path: <linux-kernel+bounces-276929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67391949A2A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8719B21BBB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9C216A940;
	Tue,  6 Aug 2024 21:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiH0oTiU"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6168214BF9B
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 21:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722979734; cv=none; b=U/ARS6BWyujp3c3pxzC/tf9vfLeclyZcZ2cq3rhksvTP+b9RFF72vRRQWw2hvibFim/SN4ozoboJAiKSjzKizncjd6gM9OTsp+kurqfTMFrhP1wEzfa2s+Tq8YVC+vTLMYOdnZl4wKG07dmvKgCHAdyYe0dqLDK15CovWyajEv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722979734; c=relaxed/simple;
	bh=Ebyw2uHyljNpbHWOaf5UgCEuZbTfXbTik6B56ITyzHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sNnTEZZEqN6Wzc7Y3shgxNRQFT5X6/oVATA1g5029k/iJdlwzTAPPXLlobtLMbp+gpjI8LEjVLEbaWBOsZiEa3uDmHq5CyKY0aTzBQx4rQsdjt4wSqZ+GSLzfHLT37exYTCI357g8HfZFSjRZpex9secw/zVqsCiiuctHhtiOZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BiH0oTiU; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42812945633so8334695e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 14:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722979731; x=1723584531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N1kf54se3bA1VKFLDqEHyhqjLVhHdwhvGmRgNozRq7k=;
        b=BiH0oTiUMmqz9CnjkwcgePDx/LAtP8zlZfzbB9QdFt333tRH2BNitiRH53UwhwpX8k
         8VDkcB8qZHFYSk8mEWSaOKznKiS8eE/oIXFF1oPbU3KuycXqyUGgZ/4EpzYcCdqt6siN
         hvVoGGMgAvo89rMnEvHqqUwZl/P3VEsu83nVEelumpvpUJYxHEL6E3R4T8hoQn3VDsxW
         sr3OsUj0eR/mbRdoU4hMDGPPm0xnqPgFugNmS7bTRKoP6Yx6uRTOiwjXw6Y6633BA1p0
         ijNr578TDO85cmKtDGVnhcs//YjHrdOZWtDvXBVNAS89j1sdf7eAPm2+U4hF3asY9Oi8
         NKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722979731; x=1723584531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N1kf54se3bA1VKFLDqEHyhqjLVhHdwhvGmRgNozRq7k=;
        b=ojVquMpmYi5OwrRvaZGgeuEhnqViDVKI7BePNXm7Hsp0eIrxjbj+Zhp6xQXMefuT18
         tC133B+9zWOEYz8Vgw7yh0HptQsMZkcxEbXktPRYqU7PXzW4lgQmNG1uOiL6DUsAysig
         trFFaaKEY3jXiVfYPmgseSg195Om4NBc93eTr+i0FT5ARN0SXwPxNYz5XhBVUzJp+K5f
         RbCd4IWnDmlu8gTpHuChki4h/mRpyW5VuOHqeGNZR0cUlcEC108remNzvv2GcmrHDy1F
         QfVq687GEf4iVWzI6Di+HLL4pWEd02VQszkPlglaQNSq/NmqLePFdxI5CM6JKZm6i+rU
         ZLkw==
X-Forwarded-Encrypted: i=1; AJvYcCUvxUriOzAK0ws/xCgm5FqbUeBPWtfUpC6T+fMlhxO1Sand+p5fCZf9nt/iGSjta0IUspMJtZXGVaCZjsLHq2WtcemHXqpDANVb/hIl
X-Gm-Message-State: AOJu0Yy5GKsXsrwVsu/2YXzDy4ZyiOw3bcp4od6UNORaTIVsegx69wws
	STY2WJZ2pOyPChhx6viAyDQCW/DHI2rDBamM0YinpxtydOho4x9J
X-Google-Smtp-Source: AGHT+IGB58aBNWBH3dAac8tkraDidlqK+KGJ/IdwzuWrIkrYfenXhBVb4kewVfKzVMMUhaFtkMp+hQ==
X-Received: by 2002:a05:600c:3ca8:b0:428:2e9:6573 with SMTP id 5b1f17b1804b1-428e6b005eemr113150815e9.17.1722979730339;
        Tue, 06 Aug 2024 14:28:50 -0700 (PDT)
Received: from PC-PEDRO-ARCH.lan ([2001:818:e92f:6400:96b:aa92:afc0:2d3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290501f0d5sm1858545e9.31.2024.08.06.14.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 14:28:49 -0700 (PDT)
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
Subject: [PATCH 0/7] mm: Optimize mseal checks
Date: Tue,  6 Aug 2024 22:28:01 +0100
Message-ID: <20240806212808.1885309-1-pedro.falcato@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Optimize mseal checks by removing the separate can_modify_mm() step, and
just doing checks on the individual vmas, when various operations are
themselves iterating through the tree. This provides a nice speedup.

While I was at it, I found that is_madv_discard() was completely bogus.

Note that my series ignores arch_unmap(), which seems to generally be what we're trending towards[2]. It should
be applied on top of any powerpc vdso ->close patch to avoid regressions on the PPC architecture. No other
architecture seems to use arch_unmap.

Note2: This series does not pass all mseal_tests on my end (test_seal_mremap_move_dontunmap_anyaddr fails twice). But the
top of Linus's tree does not pass these for me either (neither does my Arch Linux 6.10.2 kernel),
for some reason (mremap regression?).

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

[1]: mmap1_process does mmap and munmap in a loop. I didn't bother testing multithreading cases.
[2]: https://lore.kernel.org/all/87o766iehy.fsf@mail.lhotse/
Link: https://lore.kernel.org/all/202408041602.caa0372-oliver.sang@intel.com/

Pedro Falcato (7):
  mm: Move can_modify_vma to mm/internal.h
  mm/munmap: Replace can_modify_mm with can_modify_vma
  mm/mprotect: Replace can_modify_mm with can_modify_vma
  mm/mremap: Replace can_modify_mm with can_modify_vma
  mseal: Fix is_madv_discard()
  mseal: Replace can_modify_mm_madv with a vma variant
  mm: Remove can_modify_mm()

 mm/internal.h | 30 ++++++++++++++++------
 mm/madvise.c  | 13 +++-------
 mm/mmap.c     | 36 ++++++++++-----------------
 mm/mprotect.c | 12 +++------
 mm/mremap.c   | 33 ++++++------------------
 mm/mseal.c    | 69 +++++++++++----------------------------------------
 6 files changed, 63 insertions(+), 130 deletions(-)

-- 
2.46.0


