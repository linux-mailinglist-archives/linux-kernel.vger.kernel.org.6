Return-Path: <linux-kernel+bounces-576454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07991A70F9D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 04:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17F8E7A5F84
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 03:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B781624DD;
	Wed, 26 Mar 2025 03:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="E2cEcyjA"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A3B63CB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 03:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742960315; cv=none; b=KXlJaYlJDy8W1+l+93gVLldJj2Zhm3RUUmEEyEV8ogSqX/6a1tAiBqgh9KituXR+56HMdyTJiErmBe3TZfUkxxATuOsSKsBUZLX5Asu7Utim7ra57Y1cFrkfRJLBRzbNTrGm3bF5XAzvAo9c86go0ZVd4SW1gMTDGsiLIu/yeOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742960315; c=relaxed/simple;
	bh=fAPxI4cutbBlbW6umxm6sw8slgXvnL+wIh0+SJp/exU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ARGNLXSdxyJ5IKAq7+Z5MmaIKAT28L71T41oql8zUIZcMFmoOfSFN4KXSuKdlt/sCIA9phkeyxzbRCixo7CUGqVlhNwdDv3H52Jxs2Do459Pva2X2ObOE7kdC5cUM2BqP7DrXYjsv5L8nQZyh9FEadm68HsnyxNx4nlsnKmYsVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=E2cEcyjA; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742960303; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=LLS0Fjj/QuyFInoxqhJkLq2hmKsOBRvrM0rip5RLIAw=;
	b=E2cEcyjAmsq/FiS1jTZpxrazSVp4bHpmzWIqlSBoEW0JSM5/mQ5mej+iaiB6mxdRjHxqtzfGUi81W9rDqK/wDhSxELbx1ZrOW4euDriKLK5bWfq8oCUoW5wi0a8ze+g6TN+J7QF44eEyVBGawa/9bdXG42SQpSLO3lZLtpgTl7Y=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WT1ka-I_1742960302 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 26 Mar 2025 11:38:23 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Fix mincore() tmpfs test failure
Date: Wed, 26 Mar 2025 11:38:09 +0800
Message-ID: <cover.1742960003.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 fixes the failure of mincore() tmpfs selftest. While testing the
mincore() syscall, patch 2 provides some improvements for mincore() when
mTHP is enabled.

Baolin Wang (2):
  selftests: mincore: fix tmpfs mincore test failure
  mm: mincore: use folio_pte_batch() to batch process large folios

 mm/mincore.c                                  | 27 +++++++++++++++----
 .../selftests/mincore/mincore_selftest.c      | 25 +++++++++++++++--
 2 files changed, 45 insertions(+), 7 deletions(-)

-- 
2.43.5


