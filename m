Return-Path: <linux-kernel+bounces-258474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADF4938871
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 07:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CFA41C20D8B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 05:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED37D199C2;
	Mon, 22 Jul 2024 05:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ufKnUEqA"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7A117BCA
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 05:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721627015; cv=none; b=Nx85uJ2+TFkJ02XjOr/FZJXLWCCi7aiEY5H36//k+Jabkrd7gRwhZJyR9wajHAlpp2/05/QBfkyvQWJ7XmwSy3ApUHG3fAgUpxRukBVo5GPHc7Tq2VNEoMy4m6rr0k2UQEfq5wRE+hsMWhuwIdp0FLWhzmW36vbcAeXaSedbm68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721627015; c=relaxed/simple;
	bh=4dHJI0E49abFZZceDA5boYa/Gtz7FXhhYhdLIIL/tgA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YmrJ54rXNWVg+VhC3L4xhss3ZR/ZumzBk8mdmy3V+y1RwW7gPWXCLP2uRnj9afT7MShXCSKk13hBLdKFgF6FnJH5P85r3TIFlyKslVgWPRNikB1GAL+8718KKKBDpW/xJzK+q5a7pHl5tgVR+AYYEEeE4xHSre+W68NO+JVFmt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ufKnUEqA; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721627005; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=IpL4REOrt0xtn2kcu/X7boZLMf0cUiemo/aideYObZI=;
	b=ufKnUEqAltZz811pBgBk+NDTAckConmYwA0WmeXnAZMx4uTPdvtcneLE7ivR6254Btdjf8ON6/DBGGXCZpFoEDhRg3DTs5w/X4oXfa2YMdU8iiHuEu6wBIuwKuZdHC7dgIzW4Aefq0Ag7Ts7SqLOXz1VpsKArUuX0j9StblN6dE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0WAzHzpP_1721627003;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WAzHzpP_1721627003)
          by smtp.aliyun-inc.com;
          Mon, 22 Jul 2024 13:43:24 +0800
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
Subject: [PATCH v3 0/3] Some cleanups for shmem
Date: Mon, 22 Jul 2024 13:43:16 +0800
Message-Id: <cover.1721626645.git.baolin.wang@linux.alibaba.com>
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

Changes from v2:
 - Add reviewed tag from Ryan. Thanks.
 - Pass vma instead of mm to shmem_huge_global_enabled(), per Ryan.

Changes from v1:
 - Add a dummy function in case CONFIG_TRANSPARENT_HUGEPAGE is not
 enabled, which fixes a building error reported by kernel test robot.

Baolin Wang (3):
  mm: shmem: simplify the suitable huge orders validation for tmpfs
  mm: shmem: rename shmem_is_huge() to shmem_huge_global_enabled()
  mm: shmem: move shmem_huge_global_enabled() into
    shmem_allowable_huge_orders()

 include/linux/shmem_fs.h | 11 +----
 mm/huge_memory.c         | 11 ++---
 mm/shmem.c               | 93 +++++++++++++++++++++-------------------
 3 files changed, 54 insertions(+), 61 deletions(-)

-- 
2.39.3


