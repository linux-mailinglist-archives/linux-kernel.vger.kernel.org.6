Return-Path: <linux-kernel+bounces-516905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C5BA37982
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 02:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A82D168DE6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 01:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C36A76026;
	Mon, 17 Feb 2025 01:52:53 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364BD224D7
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 01:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739757172; cv=none; b=hLG8DqITVvSJ838l1nL+xqNbjdzkf1C0GrrVngkCWQpuPaXiFaUoLoIEF849xCvWwoO+bYqXSj1quqWFOMBr8rPT1TiXNqsvt6nZUvBUJNl0J7aDYBtLzWKbMpzHY269FFbTgrCs/X44oY8WtYkL0sy+HVtqn5HuHeZvH/rG7J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739757172; c=relaxed/simple;
	bh=lSqWNaNxL6k/CeFpCstKSiDRzrbiccdITu5zf0YC5/o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eCfxtslwybZsCk/cIr2ChEfOTtE9Hml09JnIok526cMiX+0dwMwjcOHu4x3gQInc4io8z9GO/y+kkpoLDzYEfU+5nn1p0a0h7fs4CZdRapAvzhNDhZqowsWBewrpFXpWothS13dJrSyL8pLqbxus3vxEFUWs1Me6SBJ/shZBbfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Yx5K93k1Rz1xx90;
	Mon, 17 Feb 2025 09:53:17 +0800 (CST)
Received: from kwepemg100017.china.huawei.com (unknown [7.202.181.58])
	by mail.maildlp.com (Postfix) with ESMTPS id 278CF1A0188;
	Mon, 17 Feb 2025 09:52:47 +0800 (CST)
Received: from huawei.com (10.175.124.71) by kwepemg100017.china.huawei.com
 (7.202.181.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 17 Feb
 2025 09:52:46 +0800
From: Wupeng Ma <mawupeng1@huawei.com>
To: <akpm@linux-foundation.org>, <david@redhat.com>, <osalvador@suse.de>,
	<nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <mhocko@suse.com>
CC: <mawupeng1@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/3] mm: memory_failure: unmap poisoned filio during migrate properly
Date: Mon, 17 Feb 2025 09:43:26 +0800
Message-ID: <20250217014329.3610326-1-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg100017.china.huawei.com (7.202.181.58)

From: Ma Wupeng <mawupeng1@huawei.com>

Fix two bugs during migrate folio if folio is poisoned.

Changelog since v2:
- re-order patches
- fix compile errors
- modify patch #2 as suggested 

Changelog since v1:
- update ttu flag inside unmap_poisoned_folio.
- check folio ref count before unmap HWpoisoned folio.

Ma Wupeng (3):
  mm: memory-failure: update ttu flag inside unmap_poisoned_folio
  mm: memory-hotplug: check folio ref count first in do_migrate_range
  hwpoison, memory_hotplug: lock folio before unmap hwpoisoned folio

 mm/internal.h       |  5 ++--
 mm/memory-failure.c | 61 +++++++++++++++++++++++----------------------
 mm/memory_hotplug.c | 26 +++++++++----------
 3 files changed, 46 insertions(+), 46 deletions(-)

-- 
2.43.0


