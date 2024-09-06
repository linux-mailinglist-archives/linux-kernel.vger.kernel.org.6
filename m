Return-Path: <linux-kernel+bounces-318005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EAA96E6FF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 02:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2387328199C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 00:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A8812E7E;
	Fri,  6 Sep 2024 00:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VCtnP7Mu"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C7717991
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 00:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725584030; cv=none; b=tIcCxmfcs+P51AM2byUPItYEzw5CKSYiEdm5SQ7haQPBXEKFo8Ub0+U3K4JiVuJeQLWozTKttXE/F0Z4E+RTUtpF8+bc7a2afRbNNQybN75aX+uaurk6SpVF/KLYRYRt6goBPFtPGP6LHQesEgS1yjNumisgBwEI3HUI21ptNww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725584030; c=relaxed/simple;
	bh=8QiPjJzrLpvD25zhOViCCUV/LfRx7e5oratGTFkkefg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CEPkRIobPNNm5V8+uscNV02xkdx08vokp1I8YOuQZLfch9+Na7TWoM9heXCfKe0XZhQKhSV1odGxO1vVgD455sWUYsJZkjRqQNKcBUq6qq8qZhz7/EK2baQWcV0nn1knJWdlK1Xqwi/P3nfsiQCxPji48iUQ7b1YFN/Savw32tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VCtnP7Mu; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725584027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Yp/Qwl66bzNTJKTHCnRrU5pVmyEM46AHrp3iaoTD3Z4=;
	b=VCtnP7MulFQjVFxLMtYPcDDFkG+w1qksQWwT2SNjiPOXoPn3tjitepuK72yPs0t3pHrQLz
	Nf4mF1QkGX2mosLhQBLunKyk7Iwjtx8+qUpErQMw5LpRc+mQjwGIBVZEy9pYn0kfA7G0k+
	Lj+gLbHl0IEFChxtj6YfFjlj6jdSC94=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH] mm/show_mem.c: report alloc tags in human readable units
Date: Thu,  5 Sep 2024 20:53:37 -0400
Message-ID: <20240906005337.1220091-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

We already do this when reporting slab info - more consistent and more
readable.

Cc: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 mm/show_mem.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/show_mem.c b/mm/show_mem.c
index 691e1b457d04..1b448e1ebd09 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -459,15 +459,18 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
 				struct codetag *ct = tags[i].ct;
 				struct alloc_tag *tag = ct_to_alloc_tag(ct);
 				struct alloc_tag_counters counter = alloc_tag_read(tag);
+				char bytes[10];
+
+				string_get_size(counter.bytes, 1, STRING_UNITS_2, bytes, sizeof(bytes));
 
 				/* Same as alloc_tag_to_text() but w/o intermediate buffer */
 				if (ct->modname)
-					pr_notice("%12lli %8llu %s:%u [%s] func:%s\n",
-						  counter.bytes, counter.calls, ct->filename,
+					pr_notice("%12s %8llu %s:%u [%s] func:%s\n",
+						  bytes, counter.calls, ct->filename,
 						  ct->lineno, ct->modname, ct->function);
 				else
-					pr_notice("%12lli %8llu %s:%u func:%s\n",
-						  counter.bytes, counter.calls, ct->filename,
+					pr_notice("%12s %8llu %s:%u func:%s\n",
+						  bytes, counter.calls, ct->filename,
 						  ct->lineno, ct->function);
 			}
 		}
-- 
2.45.2


