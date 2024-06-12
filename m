Return-Path: <linux-kernel+bounces-211271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FF6904F57
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA5AB284813
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50DF16DEC8;
	Wed, 12 Jun 2024 09:31:59 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E621216DEBC
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718184719; cv=none; b=dv34AOcGf0gzET1ALpcVTWPN69WB4Mb2OygXUHhBek5UlDSQx/oJdQVvKFBunxKG3Xwu9+D5mPluvEggphlj2quOJ8qqezHY0fRADsuiHiQY8wu0l4Z/wF8YcIn8g/i7jk4BbYd/SR96AhYnAS15teSdUrppar4C/ZoPmklnnIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718184719; c=relaxed/simple;
	bh=8eAtBtYwyhL+lg3rWQrxS5y/3P9gHZ+KMEUN8eVQcWc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VwN3Krwaqcz+djFV579qQU3Cu6fTkU9FhkM+/rljUD6iSDVZIcHXUD6673VdYrk4OtZtjnaQQxsXngG6ddFtMLLZn3ba21CznhDLUQjLiI8/GmOMCzW6b5d2tTfXmaIU9Vr5U4xVU2ZtT2GaFNrVw7qUvVshbfzY8fPB5uWXU8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VzgJ70ZdFz3NtZ0;
	Wed, 12 Jun 2024 17:30:31 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 502AA180045;
	Wed, 12 Jun 2024 17:31:54 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.26) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Jun 2024 17:31:54 +0800
From: Xiu Jianfeng <xiujianfeng@huawei.com>
To: <akpm@linux-foundation.org>, <muchun.song@linux.dev>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <osalvador@suse.de>
Subject: [PATCH v3 -next 0/3] mm/hugetlb_cgroup: rework on cftypes
Date: Wed, 12 Jun 2024 09:24:06 +0000
Message-ID: <20240612092409.2027592-1-xiujianfeng@huawei.com>
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

Changes from v2:
 - Add Reviewed-by tag of Oscar (the 1st patch)
 - Rebuild cft->private unconditionally

Changes from v1:
 - Fix smatch warnings of 'tmpl->name'

Xiu Jianfeng (3):
  mm/hugetlb_cgroup: identify the legacy using cgroup_subsys_on_dfl()
  mm/hugetlb_cgroup: prepare cftypes based on template
  mm/hugetlb_cgroup: switch to the new cftypes

 include/linux/hugetlb.h |   5 -
 mm/hugetlb_cgroup.c     | 302 ++++++++++++++++++++++------------------
 2 files changed, 164 insertions(+), 143 deletions(-)

-- 
2.34.1


