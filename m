Return-Path: <linux-kernel+bounces-194384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C9A8D3B5B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 17:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5704C1C22E83
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB733181334;
	Wed, 29 May 2024 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vUDJgssi"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88193181D10
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 15:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716997778; cv=none; b=X94iZkgXG7yhJPC2ZzAZN2a3UW+A56HOI9fSEYvm8FDvSm7XfAFnII4HJg2zbKkT4Dq355b67i3oj7tJfIrjMnGiFkDNuU/aQuq/LvEQA4bFKQHVlEzZpCbQlnDgzAUrtnQTInOlPJCJxTDn4jHWha/wylcdAPeAPfpEAuMA98Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716997778; c=relaxed/simple;
	bh=nCxOvU30J+3cwE9+wgCZqqift3Fn4rGZbaIndjfgVV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P9ygv29EBq8YtmVgn90GNcoYVlzZmgFHDl9t5YmSdj2oAOEGimy0XeXqWqnlh9Fe98s1VLHBl4/aDdyC+ojDJy8ehO7A9JbrpFoUXYWcRWkQfZU45WlIcpBv78miT5G1aqKBtFM5lwY4UJi89g6v9bsL4izStfrvAlBKHKEFwzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vUDJgssi; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716997770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iT76y12aHL4ImtbcXTa98+kFBHSfVFYyCaRgIBXgWd8=;
	b=vUDJgssiVKzM3a+MnBGnLQwbXjVcO7oKlRNifePZPj2q6omSHZw1mErz5A9VJc19ewx1rl
	51MNKrjdb8eAhb19hXOPGjChWLjJ4iV5cQ9qT1Mr9UiuVXYMp3BY9D1TbI1zdrQgcaBxwd
	x2hfIAyah1AKSghtNZLjn+43mbq5d4Y=
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: riel@surriel.com
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: kernel-team@fb.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: syzbot+17416257cb95200cba44@syzkaller.appspotmail.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: Rik van Riel <riel@surriel.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Facebook Kernel Team <kernel-team@fb.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+17416257cb95200cba44@syzkaller.appspotmail.com
Subject: [PATCH] mm: vmscan: reset sc->priority on retry
Date: Wed, 29 May 2024 08:49:11 -0700
Message-ID: <20240529154911.3008025-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The commit 6be5e186fd65 ("mm: vmscan: restore incremental cgroup
iteration") added a retry reclaim heuristic to iterate all the cgroups
before returning an unsuccessful reclaim but missed to reset the
sc->priority. Let's fix it.

Reported-and-tested-by: syzbot+17416257cb95200cba44@syzkaller.appspotmail.com
Fixes: 6be5e186fd65 ("mm: vmscan: restore incremental cgroup iteration")
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/vmscan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index b9170f767353..731b009a142b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6317,6 +6317,7 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
 	 * meaningful forward progress. Avoid false OOMs in this case.
 	 */
 	if (!sc->memcg_full_walk) {
+		sc->priority = initial_priority;
 		sc->memcg_full_walk = 1;
 		goto retry;
 	}
-- 
2.43.0


