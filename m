Return-Path: <linux-kernel+bounces-279347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D40F994BC1C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97378282F6B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F6E18C32B;
	Thu,  8 Aug 2024 11:19:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B81318A921
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 11:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723115940; cv=none; b=tIKXCNAfESjpCLkxJ/U3Bvo22uKdWaf6TloTstGMmF/73wabCa0hejm7+DXR30tLXjtFaB+dOaFHC8Zyav3geDE90k7q51wLir94SRNOKKsdN4Wa0CK6xzx8ZMMx23WhSEHXEaDklE7FqbhLPsFxdegB5Bx5QPj+mfJWm6x3+9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723115940; c=relaxed/simple;
	bh=ufojDwCPaKE113hMBdLWS8YGJ/4CZP0SZx8Y/06CX9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jGdJ2Au+fXLCOAYeaHS4eRMfQ99Xwpq1/9wOYN631Sgi6BBNx6igJwIR9QK2fjH16mwghWxH4k7KVIID/YW3GADSnqhbzDU1Gfl8JhOAx0T2fm26OyTBHc5xfVVx3bnLog9k2PLvsqgVKQnNVMjaWMA59MPQaHlXb4m/Gxn4Rq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61751FEC;
	Thu,  8 Aug 2024 04:19:23 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 371A63F71E;
	Thu,  8 Aug 2024 04:18:56 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <ioworker0@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Gavin Shan <gshan@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 0/2] Shmem mTHP controls and stats improvements
Date: Thu,  8 Aug 2024 12:18:45 +0100
Message-ID: <20240808111849.651867-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

This is a small series to tidy up the way the shmem controls and stats are
exposed. These patches were previously part of the series at [2], but I decided
to split them out since they can go in independently.

---
This applies against today's mm-unstable (275d686abcb59). (although I had to fix
a minor build bug in stackdepot.c due to MIN() not being defined in this tree).
All mm selftests have been run; no regressions were observed.

Changes since v2 [2]
====================
  - swpout stats are now exposed for all orders supported by anon or shmem.

[2] https://lore.kernel.org/linux-mm/20240716135907.4047689-1-ryan.roberts@arm.com/

Thanks,
Ryan

Ryan Roberts (2):
  mm: Cleanup count_mthp_stat() definition
  mm: Tidy up shmem mTHP controls and stats

 include/linux/huge_mm.h |  70 +++++++++----------
 mm/huge_memory.c        | 144 +++++++++++++++++++++++++++++++---------
 mm/memory.c             |   2 -
 mm/shmem.c              |   6 --
 4 files changed, 149 insertions(+), 73 deletions(-)

--
2.43.0


