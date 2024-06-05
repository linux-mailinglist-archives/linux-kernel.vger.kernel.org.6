Return-Path: <linux-kernel+bounces-201840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7353D8FC424
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 253D61F22004
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78F018C32D;
	Wed,  5 Jun 2024 07:09:12 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E4C190490
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717571352; cv=none; b=tNRqwb4h9TF1xfasK5noOsGCjl3w+LoR2dZdc2jcPg///WGOqjAZKbOHt7r5g5VRXL+cwF4HjHMVgDh+XFNbGugakaDWcI5JRDM3HIR7/4bT/cqTIPB2gJ6MJRBO+ashCq5oEqlI5M2cT3HCy/imfjj7pfH3MJ5Vt/rXhIQ6WWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717571352; c=relaxed/simple;
	bh=CfJUbCNxbSlksYpJxwKjszpSqNrdUgSd7FuWLKh1Jzw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=usIArgfaadDIC70UZArziS1zSzK4YymNOaa2Iu538nbsfKUJuzarCLUcP4oATz6lucp4QzNQUPYcg3BxAdVMLI5T15QiWFqLIMc3wkAKP99/F77vB6rZFiW3krs/ivazgJNciwyWi3hxvKqQZKIqG99OfwnpTiAAaf38v7TTses=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VvJPg0mhTzwRQQ;
	Wed,  5 Jun 2024 15:05:11 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 8DCFA140428;
	Wed,  5 Jun 2024 15:09:07 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.26) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 15:09:07 +0800
From: Xiu Jianfeng <xiujianfeng@huawei.com>
To: <akpm@linux-foundation.org>, <muchun.song@linux.dev>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 -next 0/3] mm/hugetlb_cgroup: rework on cftypes
Date: Wed, 5 Jun 2024 07:01:30 +0000
Message-ID: <20240605070133.1941677-1-xiujianfeng@huawei.com>
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


