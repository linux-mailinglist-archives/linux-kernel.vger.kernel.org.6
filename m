Return-Path: <linux-kernel+bounces-533838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F02A45F57
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 673563B5680
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5ED219315;
	Wed, 26 Feb 2025 12:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="PV2I+fJB"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6BC21930C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572838; cv=none; b=M1dnZhrMgAmttWsZ9mZZqFKcTzgw1G1cK3MejEf5fbdA5X1yGJaWQ7OXxk0q+69HzDNu0Xh5guweHnqBbBMP6hVnMOLSx4mKcVAWndfU0XxadwLcEcDSa35V5I4VNLtqExExdbxYv/6o61OTQ/b0Xp7svEbfYi/69WKOMUzwAWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572838; c=relaxed/simple;
	bh=FNi++gCcba5S/Duswuq7S4BY348opi/XrzM24HOeHjM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=g0RwJxOKxBQbHjrYbGGMQPd3K9XaBRTnufeH98E2/7Iwd1NAXF3WWH0lXBfWnZuGyxTDNSDPxrwNPk3tlmPLHY6YGAaVnUiQJEoZB5gCQelGm9yeLrJ9cQgHLDW/SWTBYPTc4WXYvgquT2wF4lNDaeJcT3LZQNQHSEmWSCvg9sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=PV2I+fJB; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=bWGS9xmVUTg5M3b34VrZ8WzlTWbZpIBbMUV45ofQZbk=; b=PV2I+fJB1az6C6vZEm/cmETrto
	uZ0sUN8rr6od0oiQqJCNkRakjsZMmDLhcgOXldW5nWaIZwISKaNS8lm3n4XQE/HXZ5XPiEiXrRqdJ
	EZbiq//LSlBKALKb5CbaLPezrDN0GdpWk7l/6v76IW2mC+IhH7jNagbpLIC4UVa9/O0EkAnZKV0wP
	QwehIpb28hOs01x6rBw4s+gzlWmrJ+xtmqFt9P+uuFvbHnRd+xyWT7voUJIFMQV/HIQgpMqvTKMwx
	ltSxYHxsnXno8V1FUuuR8CtPLzohW+0wlgSi9JmISVUzHf74Yb0DqhGdsCYpumhGU6nCCrjNlEMpb
	sWWHpEXQ==;
Received: from 253.red-79-144-234.dynamicip.rima-tde.net ([79.144.234.253] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tnGV0-000xB8-5F; Wed, 26 Feb 2025 13:26:56 +0100
From: =?utf-8?q?Ricardo_Ca=C3=B1uelo_Navarro?= <rcn@igalia.com>
Date: Wed, 26 Feb 2025 13:26:27 +0100
Subject: [PATCH] mm: shmem: remove unnecessary warning in shmem_writepage()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250226-20250221-warning-in-shmem_writepage-v1-1-5ad19420e17e@igalia.com>
X-B4-Tracking: v=1; b=H4sIAHIIv2cC/y2NQQqDQAxFryJZN+BEdKRXKUUGm9EsTCVTHEG8u
 0Nx997i/X9AYhNO8KwOMN4kyVeLuEcF4xx0YpRPcaCa2pqowxsc5mAqOqEopnnhZcgmP15DSdj
 HPpJvGudHKEurcZT9//J6n+cFUDlKlXUAAAA=
X-Change-ID: 20250226-20250221-warning-in-shmem_writepage-e7f8f273317c
To: Hugh Dickins <hughd@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
 Luis Chamberlain <mcgrof@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>
Cc: Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>, 
 kernel-dev@igalia.com, Pengfei Xu <pengfei.xu@intel.com>
X-Mailer: b4 0.14.2

Although the scenario where shmem_writepage() is called with info->flags
& VM_LOCKED is unlikely to happen, it's still possible, as evidenced by
syzbot [1]. However, the warning in this case isn't necessary because
the situation is already handled correctly [2].

[2] https://lore.kernel.org/lkml/8afe1f7f-31a2-4fc0-1fbd-f9ba8a116fe3@google.com/

Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Closes: https://lore.kernel.org/lkml/ZZ9PShXjKJkVelNm@xpf.sh.intel.com/ [1]
Suggested-by: Hugh Dickins <hughd@google.com>
Cc: Florent Revest <revest@chromium.org>
Signed-off-by: Ricardo Cañuelo Navarro <rcn@igalia.com>
Fixes: 9a976f0c847b ("shmem: skip page split if we're not reclaiming")
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 4ea6109a80431e5eeae15278064d5c86412f9fc9..a5eaad03038e8ca56a54d096159892e01c7a5bfe 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1548,7 +1548,7 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 	if (WARN_ON_ONCE(!wbc->for_reclaim))
 		goto redirty;
 
-	if (WARN_ON_ONCE((info->flags & VM_LOCKED) || sbinfo->noswap))
+	if ((info->flags & VM_LOCKED) || sbinfo->noswap)
 		goto redirty;
 
 	if (!total_swap_pages)

---
base-commit: ac9c34d1e45a4c25174ced4fc0cfc33ff3ed08c7
change-id: 20250226-20250221-warning-in-shmem_writepage-e7f8f273317c

Cheers,
Ricardo


