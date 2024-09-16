Return-Path: <linux-kernel+bounces-330548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EBB97A006
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 13:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169E21F22789
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B88E153824;
	Mon, 16 Sep 2024 11:08:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE7914E2DA
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 11:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726484890; cv=none; b=JbwRB8Pcete//VtEVTJAJkeDwtBeNpsdkLLJ9jRPciEIr3nzvUiBR0PQxG0LZiXX+2bqESC0sKRGZBw5De0uVT4NcK6Bp34cjCE7evbVcKJiOUKx5kSJ05NXqLKhzCiImQF85RLfqgBPeZcoH9FLvYCvDXHj8FLtv+s3dIUPSdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726484890; c=relaxed/simple;
	bh=uaEZ1MbpwYgSroam1wjoGjSbo4ur6XhSd2/N4jHG8pQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H7YVVcc5Wx+34/CToMVdb4H54Rb5g5RXAmzbHZVhGEf4GmfN2n8gBkTZJYmFejbfWE117CrG1R1yjTqEUjnoWG4LsnIoZklNCNcHW0xnhFukFqbsW5aE7vXe+b8Po98JeIoDa8D4lvK0NDZjo2RmvKLoh57W7HWCbxZjRv8OKy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEF4711FB;
	Mon, 16 Sep 2024 04:08:33 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.42.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 44EA23F64C;
	Mon, 16 Sep 2024 04:07:58 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	willy@infradead.org
Cc: ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	baohua@kernel.org,
	hughd@google.com,
	ioworker0@gmail.com,
	wangkefeng.wang@huawei.com,
	baolin.wang@linux.alibaba.com,
	gshan@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v2 0/2] Compute contiguous empty PTEs for mTHP efficiently
Date: Mon, 16 Sep 2024 16:37:52 +0530
Message-Id: <20240916110754.1236200-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We use pte_range_none() to determine whether contiguous PTEs are empty
for an mTHP allocation. Instead of iterating the while loop for every
order, use some information from the previous iteration to eliminate
some cases.

v1->v2:
 - Break into two patches

v1: https://lore.kernel.org/all/20240913091902.1160520-1-dev.jain@arm.com/

Dev Jain (2):
  mm: Make pte_range_none() return number of empty PTEs
  mm: Compute first_set_pte to eliminate evaluating redundant ranges

 mm/memory.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

-- 
2.30.2


