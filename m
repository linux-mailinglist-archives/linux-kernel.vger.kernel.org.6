Return-Path: <linux-kernel+bounces-248610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D98892DFB5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 07:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66961F22365
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 05:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B227E0FC;
	Thu, 11 Jul 2024 05:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LWFdP8ol"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574AD3AC1F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 05:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720676593; cv=none; b=hm44nRKNJY8a4Cdz9UPUSKIzBqKJAmRhxoJg9HEoz1KexA7VvZLSEGwwLzgui05lJgAUtKbozp8vfN5CyCORq/iM449F3V10jmPbbGQnU9GE7sVCyOzyvh9kI+7GBCN06O3Wb+ctDpnTJRWFRD0Tu2D5p/atONJUwRZROYTnzeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720676593; c=relaxed/simple;
	bh=7QB5Vzj/c5P20hgymiWAifspE8Y4KIWhb/23Txb/tOg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JpUwLktD4g6U5cAAqKjptWNoelu59zQtja5kvl9BD9bOYwKsOtk9izTspVzNUQEeOYRitwzHnYb/mqrnkCE3FtNBatQzAhJuUIOjVunQ+N675tpz23JC0i37E3j731as+9AR2PnaNhoSuPF/U/U0bu0WP7YSCEJI0mErHMjeTZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LWFdP8ol; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720676582; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=u47PfWzz2FJOZ82dozbNoz0ZxoMQZbCxCxb8RnhAKuM=;
	b=LWFdP8olb+LpL6BCiglqBnXd4sBww9e6lnPTY17tDppldWyiHf09SzfkFZt7K5b95pmJwRVo3XZ7tzKkb7m5ktqpRAp5Y531qLNj0oY96q6HVKQqZMYzXDcn2CL+gvxsY/md2iZcJHa3QDrvZEBl0LqCMT2LYGuuNXviJL6+U8w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045220184;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0WAIkxYZ_1720676581;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WAIkxYZ_1720676581)
          by smtp.aliyun-inc.com;
          Thu, 11 Jul 2024 13:43:01 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	ziy@nvidia.com,
	ioworker0@gmail.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Some cleanups for shmem
Date: Thu, 11 Jul 2024 13:42:47 +0800
Message-Id: <cover.1720668581.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series does some cleanups to reuse code, rename functions and simplify
logic to make code more clear. No functional changes are expected.

Baolin Wang (3):
  mm: shmem: simplify the suitable huge orders validation for tmpfs
  mm: shmem: rename shmem_is_huge() to shmem_huge_global_enabled()
  mm: shmem: move shmem_huge_global_enabled() into
    shmem_allowable_huge_orders()

 include/linux/shmem_fs.h | 11 +-----
 mm/huge_memory.c         | 11 ++----
 mm/shmem.c               | 84 ++++++++++++++++++++--------------------
 3 files changed, 46 insertions(+), 60 deletions(-)

-- 
2.39.3


