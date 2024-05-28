Return-Path: <linux-kernel+bounces-191757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D13BC8D13BE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 07:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CCA6B20813
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 05:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBCE4D59B;
	Tue, 28 May 2024 05:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q1ZEBPE/"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92824AEC6
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 05:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716873377; cv=none; b=Qof3xJsCatJfj9ScmSfflIOBLEs0RkR5EWAqCBFfAB43WmchKEFfQd8DhWEOSlfZ4FgwtlgZ98oiQB15ecKA+MhsnG5HIsg2Olhj9cNSIZ0upmnI5ZP7evBf6ZYORnKhuYqqicHvU6JKqhtEzPth5UNqrhWt+qQPZPGEZ5Gi7TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716873377; c=relaxed/simple;
	bh=I3AyPihtBw6v/kXRFwy8BYIjkHVHQUMXiLhcJd/AZFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MunGcqRQ/uH+pxl8D0nK1Ti5/bBFl/13QVopHYtOo6bScIFzMTaslL5WjVWQFa/8AsIQUIRuRBGinZx5XvIE5NSripJ5Lt4/TJBFghcGgsoXHg2hizj7xu2aYT8nldouXhNOv0SO8Lc9QJUxACW2DeyUTLEkIOKz9EoyoZ7DIHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q1ZEBPE/; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: david@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716873373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H2q4GPXNTNFmR1Ksr4G1yjztrayX+tl7+eFPihVoBD8=;
	b=Q1ZEBPE/q4fHg8Je8XFCu/biA2QJcfaEmLTsAUHRlXk6TvadUoKdas57oD91Z9Oz1Lca8w
	QXe9YiV3KFqeaz9DQomLLWxSV6tjLmrdDYJoo8F9+l/fmJcD+3j2UEWuxuREznqa1dMbkV
	tr+LlH5Va6j3zrVWD7OtGcGCm3Mb+JE=
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: hughd@google.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: chengming.zhou@linux.dev
X-Envelope-To: yang.yang29@zte.com.cn
X-Envelope-To: ran.xiaokai@zte.com.cn
X-Envelope-To: xu.xin16@zte.com.cn
X-Envelope-To: aarcange@redhat.com
X-Envelope-To: shr@devkernel.io
X-Envelope-To: zhouchengming@bytedance.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
Date: Tue, 28 May 2024 13:15:21 +0800
Subject: [PATCH v3 1/2] mm/ksm: fix ksm_pages_scanned accounting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-b4-ksm-counters-v3-1-34bb358fdc13@linux.dev>
References: <20240528-b4-ksm-counters-v3-0-34bb358fdc13@linux.dev>
In-Reply-To: <20240528-b4-ksm-counters-v3-0-34bb358fdc13@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, hughd@google.com, aarcange@redhat.com, 
 Stefan Roesch <shr@devkernel.io>, Xiaokai Ran <ran.xiaokai@zte.com.cn>, 
 xu xin <xu.xin16@zte.com.cn>, Yang Yang <yang.yang29@zte.com.cn>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, zhouchengming@bytedance.com, 
 Chengming Zhou <chengming.zhou@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716873365; l=1429;
 i=chengming.zhou@linux.dev; s=20240508; h=from:subject:message-id;
 bh=I3AyPihtBw6v/kXRFwy8BYIjkHVHQUMXiLhcJd/AZFQ=;
 b=5BOhUtspN8CEJo3Rjn/zn0koSkZ5Z5fXC8av4Kw9U2D6t3iY1FXptgYg5qbP1UMG7SyDVZ+91
 tpQAl61j6VtB6kqIleL8anS0uliyBTikBoS4NYOlZFlUwQCfvnb2hyz
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=kx40VUetZeR6MuiqrM7kPCcGakk1md0Az5qHwb6gBdU=
X-Migadu-Flow: FLOW_OUT

During testing, I found ksm_pages_scanned is unchanged although the
scan_get_next_rmap_item() did return valid rmap_item that is not NULL.

The reason is the scan_get_next_rmap_item() will return NULL after
a full scan, so ksm_do_scan() just return without accounting of the
ksm_pages_scanned.

Fix it by just putting ksm_pages_scanned accounting in that loop,
and it will be accounted more timely if that loop would last for
a long time.

Fixes: b348b5fe2b5f ("mm/ksm: add pages scanned metric")
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: xu xin <xu.xin16@zte.com.cn>
Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 mm/ksm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 452ac8346e6e..9e99cb12d330 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2754,18 +2754,16 @@ static void ksm_do_scan(unsigned int scan_npages)
 {
 	struct ksm_rmap_item *rmap_item;
 	struct page *page;
-	unsigned int npages = scan_npages;
 
-	while (npages-- && likely(!freezing(current))) {
+	while (scan_npages-- && likely(!freezing(current))) {
 		cond_resched();
 		rmap_item = scan_get_next_rmap_item(&page);
 		if (!rmap_item)
 			return;
 		cmp_and_merge_page(page, rmap_item);
 		put_page(page);
+		ksm_pages_scanned++;
 	}
-
-	ksm_pages_scanned += scan_npages - npages;
 }
 
 static int ksmd_should_run(void)

-- 
2.45.1


