Return-Path: <linux-kernel+bounces-191756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EF28D13BD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 07:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02F9DB21F57
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 05:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F8A4C622;
	Tue, 28 May 2024 05:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JhkGo7pM"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBDE1C6B8
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 05:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716873377; cv=none; b=AwKvaYSXZN39mEqn0xfyoZtzS8q95WmzzlN7bAdIBuTk9zVhpJXnpnqsdO4/tAGUyy+pVdJGBt7Y+PLrYMPriFeGT3ncmR+z5Hk+CGghExStbIprc024Z0vrwnGjZkut+ztAlYzNsm1c+Kp9z5jxmS+yYw4NZ23SycN4hXcqvTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716873377; c=relaxed/simple;
	bh=uV0w/FbbATdQz0x74mEbQb3mYslfFqBkWHzAlCYOP4M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hKwddqBo/tAGqsdzyD7R+RTiZjhAIPQJDOTh300896Xd1ubXdLWAyh2J+pCyik822xW1A4OsxMCHkKrIZF2g4mYBnJmz2PJPLzn0NsDzik9GCpRpxN0JoHbdknkRZzUeNmfaNYpGDI1DcjW5+rlAMvB+ffBe4a7otTgodnKimXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JhkGo7pM; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: david@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716873369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VyRL8PBNU9YE+eypKTSOzSwD/xk7CoKAHbGpdBJ6A7U=;
	b=JhkGo7pMI1uvH2mLl7uk17ANX6vq51AQImkqe9eqrQpwl0+CylpC2S6wTQjQdyVIRisJEx
	h9+iTkxcu3loHl4XgFb1ThSv3xDqxQDn5gAsACKUTWJkPHzKFMHfSkbqGhFI1jyE5BC57g
	VfHW+W/t3+aKhm6At3EUZNlpn7GVnr4=
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: hughd@google.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: chengming.zhou@linux.dev
X-Envelope-To: yang.yang29@zte.com.cn
X-Envelope-To: ran.xiaokai@zte.com.cn
X-Envelope-To: xu.xin16@zte.com.cn
X-Envelope-To: aarcange@redhat.com
X-Envelope-To: shr@devkernel.io
X-Envelope-To: zhouchengming@bytedance.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
Subject: [PATCH v3 0/2] mm/ksm: fix some accounting problems
Date: Tue, 28 May 2024 13:15:20 +0800
Message-Id: <20240528-b4-ksm-counters-v3-0-34bb358fdc13@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGloVWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUyML3SQT3eziXN3k/NK8ktSiYl2zRDMTU6NUI+M0Q3MloK6CotS0zAq
 widGxtbUACeNhKmEAAAA=
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, hughd@google.com, aarcange@redhat.com, 
 Stefan Roesch <shr@devkernel.io>, Xiaokai Ran <ran.xiaokai@zte.com.cn>, 
 xu xin <xu.xin16@zte.com.cn>, Yang Yang <yang.yang29@zte.com.cn>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, zhouchengming@bytedance.com, 
 Chengming Zhou <chengming.zhou@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716873365; l=1393;
 i=chengming.zhou@linux.dev; s=20240508; h=from:subject:message-id;
 bh=uV0w/FbbATdQz0x74mEbQb3mYslfFqBkWHzAlCYOP4M=;
 b=LNZ8d7Xrd57vF1RIH/+QDF04AnuHLosEglbn4JWu12rmDyYEkXq7Onal4rpuOsmAKAQytuzJO
 ZJc62++FZfzDiRzhRrPjNPBj6/LLmj4t2ZOgBiKTC5Hln0N30dgL+VA
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=kx40VUetZeR6MuiqrM7kPCcGakk1md0Az5qHwb6gBdU=
X-Migadu-Flow: FLOW_OUT

Changes in v3:
- Collect Reviewed-by tag from xu xin, thanks!
- Improve the changelog of patch-2, per xu xin.
- Rebase and retest based on v6.10-rc1.
- Link to v2: https://lore.kernel.org/r/20240513-b4-ksm-counters-v2-0-f2520183a8ca@linux.dev

Changes in v2:
- Add Fixes and Acked-by tags from David Hildenbrand, thanks!
- Inline atomic_long_read(&ksm_zero_pages), per David Hildenbrand.
- Don't include the last two optimization patches to keep this fix
  simple.
- Link to v1: https://lore.kernel.org/r/20240508-b4-ksm-counters-v1-0-e2a9b13f70c5@linux.dev

We encounter some abnormal ksm_pages_scanned and ksm_zero_pages during
some random tests.

1. ksm_pages_scanned unchanged even ksmd scanning has progress.
2. ksm_zero_pages maybe -1 in some rare cases.

Thanks for review and comments!

Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
Chengming Zhou (2):
      mm/ksm: fix ksm_pages_scanned accounting
      mm/ksm: fix ksm_zero_pages accounting

 fs/proc/base.c           |  2 +-
 include/linux/ksm.h      | 17 ++++++++++++++---
 include/linux/mm_types.h |  2 +-
 mm/ksm.c                 | 17 +++++++----------
 4 files changed, 23 insertions(+), 15 deletions(-)
---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240528-b4-ksm-counters-6a6452e23f17

Best regards,
-- 
Chengming Zhou <chengming.zhou@linux.dev>


