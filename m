Return-Path: <linux-kernel+bounces-177147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 764918C3ACE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 06:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26C9B28129B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 04:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018F7146001;
	Mon, 13 May 2024 04:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/Ilp0Bo"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72451E493
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 04:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715576260; cv=none; b=rXFBQI9pvhT7nCqZb5UX2bJ1jFYxhRZtl4baBi1j0okJ5S/6Uc/ANvgi9ck5cIT6h+D42sn0nBdb/kS8/+I9+p94vQS3driML946H8R9RSQADZXcCS3wAGxpNYGKTerjmxpSiqALvknBQ2zhKv7+33Bkdt9fqYATnyI30q6udP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715576260; c=relaxed/simple;
	bh=HfX7F7ojfaf41PdCJZ+kwmTV2ZLK/OS8ZYak0OOG1h0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ANGrRj6ULpjQEykTNBoqKIcqXunNAXfHfCEwlmzATo3vOTQG9IxiENqdKxS2irdYcTr2+5NFDnTd2VerP2EGWDleIGU1IzX3xkkMrrytpfEPdPD0tVnjthBRYow06TCKDcIo8Roqq9M94Vuo/fClJ5DF+OAlRAjGI99hrmJeR60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/Ilp0Bo; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ee954e0aa6so28952685ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 21:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715576258; x=1716181058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CMsOuSvzf4aVI6LsRrkYGtxxdKvIAWtBa8DssIl0GDM=;
        b=I/Ilp0BodUn1OQiZfyEWUl641DXE90bJAh1ujn5wHFLe5XXI9+ZY3auDhOX/NOAnkB
         CPnwzeIvygIoWpTD3hcRgNb3w0zr2jpGXYoDDhGxsOJ5480EkKIpW0qH3/WPNCW2/vsi
         UetLWP2oy9Y44niG9dOdEsSM9EbPxa1HMPo+pfl9D0zKJAuV7Vw49xUqrlJCKRVbOtip
         9xA5/VxrTsyOa4PinOK6rIhluO2sooKuEG7h8dGsC/kaHMY8d1THbCVd6lmUtk/8D5uw
         Ffy5NqOfAigCniT8qfgGmeG/Ai+x9Mc4m7q/K+4KeeIg4wCI7NQXZouPsmuDRt0IeIC+
         z22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715576258; x=1716181058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CMsOuSvzf4aVI6LsRrkYGtxxdKvIAWtBa8DssIl0GDM=;
        b=rul257nK9GHMh19fDdDzPG//4wv3LG+W3n9yfdtQAmV0jL0qe5UB5/o4XwT1mXtm6r
         smebtzsHaHl1itvRe2U1jvfdUy0rZhOR7vYuPdww6B/7Ab8GGLjFJ03NbgfWMKwgfuiG
         uDHLWr9jN9xDWugmiVEKXegh1TnK7IU1qMrsrFFEl2AyZsmmjpciouiQKO0Gtx0VMd2s
         cYyhgH69MKUdMvHoyOiCyH7Cjm/RxwcSwMHWngYXVWIdd/rHZ3mCn60z6wC0dICTLn9h
         cFU2tLWZatuoPK1k91pkLopuXOJcd8I6bWa9EobtaiJpMkq94sMl2Zp8LSAUbZCTUEpB
         O75w==
X-Forwarded-Encrypted: i=1; AJvYcCV9sgIY6s0poh/HIYkrz3stN3/LNRK8Vh/FWSDT4SGWL8K6D5hkCju6F1xH+q86qjxLRjCseZGpMmQU/S1X/RywxJaaj+ErGiuf2tkp
X-Gm-Message-State: AOJu0YyP/5svdMflU86rYrvSoZnt6bMboVkcS11CrSjPLo8X18SxL34/
	f5iSG7+MMEskMZ+f+RHsxhyHd9MKxtRl/G2nygtV/rVABcVaQiH8
X-Google-Smtp-Source: AGHT+IEWKrOn68W8n0UjoB6cxJVuRvPkFOgK91Ok2MZQMNcWfGsTgpeKcUGYT6XnlTTpxQRsuceCcw==
X-Received: by 2002:a17:902:aa45:b0:1e4:9ad5:7522 with SMTP id d9443c01a7336-1ef43e292efmr83830345ad.21.1715576257976;
        Sun, 12 May 2024 21:57:37 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d187fsm69823705ad.27.2024.05.12.21.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 21:57:37 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org,
	sj@kernel.org,
	baolin.wang@linux.alibaba.com,
	maskray@google.com,
	ziy@nvidia.com,
	ryan.roberts@arm.com,
	david@redhat.com,
	21cnbao@gmail.com,
	mhocko@suse.com,
	fengwei.yin@intel.com,
	zokeefe@google.com,
	shy828301@gmail.com,
	xiehuan09@gmail.com,
	libang.li@antgroup.com,
	wangkefeng.wang@huawei.com,
	songmuchun@bytedance.com,
	peterx@redhat.com,
	minchan@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH v5 0/4] Reclaim lazyfree THP without splitting
Date: Mon, 13 May 2024 12:56:22 +0800
Message-Id: <20240513045626.84016-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This series adds support for reclaiming PMD-mapped THP marked as lazyfree
without needing to first split the large folio via split_huge_pmd_address().

When the user no longer requires the pages, they would use madvise(MADV_FREE)
to mark the pages as lazy free. Subsequently, they typically would not re-write
to that memory again.

During memory reclaim, if we detect that the large folio and its PMD are both
still marked as clean and there are no unexpected references(such as GUP), so we
can just discard the memory lazily, improving the efficiency of memory
reclamation in this case.

Performance Testing
===================

On an Intel i5 CPU, reclaiming 1GiB of lazyfree THPs using
mem_cgroup_force_empty() results in the following runtimes in seconds
(shorter is better):

--------------------------------------------
|     Old       |      New       |  Change  |
--------------------------------------------
|   0.683426    |    0.049197    |  -92.80% |
--------------------------------------------

---

Changes since v4 [4]
====================
 - mm/rmap: remove duplicated exit code in pagewalk loop
    - Pick RB from Zi Yan - thanks!
 - mm/rmap: integrate PMD-mapped folio splitting into pagewalk loop
    - Remove the redundant alignment (per Baolin Wang)
    - Set pvmw.ptl to NULL after unlocking the PTL (per Baolin Wang)
 - mm/mlock: check for THP missing the mlock in try_to_unmap_one()
    - Check whether the mlock of PMD-mapped THP was missed
      (suggested by Baolin Wang)
 - mm/vmscan: avoid split lazyfree THP during shrink_folio_list()
    - No need to check the TTU_SPLIT_HUGE_PMD flag for unmap_huge_pmd_locked()
      (per Zi Yan)
    - Drain the local mlock batch after folio_remove_rmap_pmd()
      (per Baolin Wang)

Changes since v3 [3]
====================
 - mm/rmap: integrate PMD-mapped folio splitting into pagewalk loop
    - Resolve compilation errors by handling the case where
      CONFIG_PGTABLE_HAS_HUGE_LEAVES is undefined (thanks to SeongJae Park)
 - mm/vmscan: avoid split lazyfree THP during shrink_folio_list()
    - Remove the unnecessary conditional compilation directives
      (thanks to Barry Song)
    - Resolve compilation errors due to undefined references to
      unmap_huge_pmd_locked and split_huge_pmd_locked (thanks to Barry)

Changes since v2 [2]
====================
 - Update the changelog (thanks to David Hildenbrand)
 - Support try_to_unmap_one() to unmap PMD-mapped folios
   (thanks a lot to David Hildenbrand and Zi Yan)

Changes since v1 [1]
====================
 - Update the changelog
 - Follow the exact same logic as in try_to_unmap_one() (per David Hildenbrand)
 - Remove the extra code from rmap.c (per Matthew Wilcox)

[1] https://lore.kernel.org/linux-mm/20240417141111.77855-1-ioworker0@gmail.com
[2] https://lore.kernel.org/linux-mm/20240422055213.60231-1-ioworker0@gmail.com
[3] https://lore.kernel.org/linux-mm/20240429132308.38794-1-ioworker0@gmail.com
[4] https://lore.kernel.org/linux-mm/20240501042700.83974-1-ioworker0@gmail.com

Lance Yang (4):
  mm/rmap: remove duplicated exit code in pagewalk loop
  mm/rmap: integrate PMD-mapped folio splitting into pagewalk loop
  mm/mlock: check for THP missing the mlock in try_to_unmap_one()
  mm/vmscan: avoid split lazyfree THP during shrink_folio_list()

 include/linux/huge_mm.h |  15 ++++++
 mm/huge_memory.c        | 117 +++++++++++++++++++++++++++++++++-------
 mm/rmap.c               |  73 ++++++++++++++-----------
 3 files changed, 153 insertions(+), 52 deletions(-)

-- 
2.33.1


