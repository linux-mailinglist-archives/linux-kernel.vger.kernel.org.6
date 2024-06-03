Return-Path: <linux-kernel+bounces-199088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C568D81FA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 806A2B25826
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F396128833;
	Mon,  3 Jun 2024 12:12:49 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489668665A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 12:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717416768; cv=none; b=OdXBKfOYgdsMgaePct3WzgDs1oYWBcJ9mz3i5G5YDyLlCxwojvP+nhRd6EQ+1hXiwbZXY9ODgdQKXhl07G51D3qNSRKsrj4lseJvBmf3i1s2NC86cO+44TT8ebczvdn+vpcWeaz7Z6+PzENoKKRexD7BqMc3ubr/AleYq01VMG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717416768; c=relaxed/simple;
	bh=AvUWYGDHtuHLcncmswdVuG69zTNb7cxVXEL5p2+4Zig=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rbdXIUCmgqJWTUr6RIVCCtzTyByrK72IiAd3pG43HTwbDLZzAJfP/8TvAOWNty44WrPeqGtl5sbcqSSdnWjMMqzWoqeD5Nyg3V4oXozGzJWVQuofSGJbMOsX48akpXXDF5OLwmF1ZubGyvZmpiu/jDffvogoGFhP7CpkxhXOVqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VtCDF1WGRzmXVV;
	Mon,  3 Jun 2024 20:08:13 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B911180060;
	Mon,  3 Jun 2024 20:12:43 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.26) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 20:12:43 +0800
From: Xiu Jianfeng <xiujianfeng@huawei.com>
To: <akpm@linux-foundation.org>, <muchun.song@linux.dev>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next 0/3] mm/hugetlb_cgroup: rework on cftypes
Date: Mon, 3 Jun 2024 12:05:03 +0000
Message-ID: <20240603120506.1837322-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500023.china.huawei.com (7.185.36.114)

Hi,

This patchset provides an intuitive view of the control files through
static templates of cftypes, improve the readability of the code.

Xiu Jianfeng (3):
  mm/hugetlb_cgroup: identify the legacy using cgroup_subsys_on_dfl()
  mm/hugetlb_cgroup: prepare cftypes based on template
  mm/hugetlb_cgroup: switch to the new cftypes

 include/linux/hugetlb.h |   5 -
 mm/hugetlb_cgroup.c     | 303 ++++++++++++++++++++++------------------
 2 files changed, 165 insertions(+), 143 deletions(-)

-- 
2.34.1


