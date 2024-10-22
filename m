Return-Path: <linux-kernel+bounces-375911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 893489A9D17
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A34A2818FD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E717718CC0B;
	Tue, 22 Oct 2024 08:39:32 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C408E172767
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 08:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729586372; cv=none; b=c/FNrek85aZ8u29qRXi9SU+eIT9qCnZet6tVq8xDhaKNzJrkk17ZXsNjR91S6JPPkXv9Km2urIMm/g2dII3+2RJ/z9Xc0erYmHoIz9iPv0Xc1vL+Dg+ZV1YWknMeRo5RsQFKd6rgKL/GiruWAkvT9T+/wJSJmwjx3Ws/fZqNOYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729586372; c=relaxed/simple;
	bh=avCygKW/Qqu1PtvY3vqaHaHxpQ0WtYl+U0nARbnXLyg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T+BZaZCorYqvV05RRNAT5GinCojRycYnCiAG3AiFoElU1MvVx3YsuoNNG5kHFq2SPBFJeiO9Qwk2UPcKpHUFO/pJaQPOPTJPTaHyAc0dknNRQW0oimKJg6DteH7v4T9buIDICfh8o0BCTt+Od9OZYDDa/5HK6ZkTHknG4Bf//Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XXlvx2bGvz4f3jsc
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 16:39:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id BA3061A0568
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 16:39:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.67.175.61])
	by APP3 (Coremail) with SMTP id _Ch0CgCnRoO3ZBdndQiQEg--.6910S4;
	Tue, 22 Oct 2024 16:39:26 +0800 (CST)
From: Zheng Yejian <zhengyejian@huaweicloud.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	foersleo@amazon.de,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	shakeel.butt@linux.dev,
	sieberf@amazon.com,
	yeweihua4@huawei.com,
	zhengyejian@huaweicloud.com
Subject: [PATCH v2 2/2] mm/damon/vaddr: Add 'nr_piece == 1' check in damon_va_evenly_split_region()
Date: Tue, 22 Oct 2024 16:39:27 +0800
Message-Id: <20241022083927.3592237-3-zhengyejian@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241022083927.3592237-1-zhengyejian@huaweicloud.com>
References: <20241021163316.12443-1-sj@kernel.org>
 <20241022083927.3592237-1-zhengyejian@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCnRoO3ZBdndQiQEg--.6910S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tF1rGr4UCF4xWr18ZrWkZwb_yoW8XFWfp3
	s3Ww4UKrykKFZ29w15XFn0van2yrWjgF1UGFyxJFn09r1vgas0kF15trW3Jr1rAFWfZ3yf
	ua1xZrWfWFZrCFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUczV8UUUUU=
X-CM-SenderInfo: x2kh0w51hmxt3q6k3tpzhluzxrxghudrp/

As discussed in [1], damon_va_evenly_split_region() is called to
size-evenly split a region into 'nr_pieces' small regions,
when nr_pieces == 1, no actual split is required. Check that case
for better code readability and add a simple kunit testcase.

[1] https://lore.kernel.org/all/20241021163316.12443-1-sj@kernel.org/

Signed-off-by: Zheng Yejian <zhengyejian@huaweicloud.com>
---
 mm/damon/tests/vaddr-kunit.h | 1 +
 mm/damon/vaddr.c             | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
index a149e354bb26..b9a03e4e29e5 100644
--- a/mm/damon/tests/vaddr-kunit.h
+++ b/mm/damon/tests/vaddr-kunit.h
@@ -300,6 +300,7 @@ static void damon_test_split_evenly(struct kunit *test)
 	damon_test_split_evenly_fail(test, 0, 100, 0);
 	damon_test_split_evenly_succ(test, 0, 100, 10);
 	damon_test_split_evenly_succ(test, 5, 59, 5);
+	damon_test_split_evenly_succ(test, 4, 6, 1);
 	damon_test_split_evenly_succ(test, 0, 3, 2);
 	damon_test_split_evenly_fail(test, 5, 6, 2);
 }
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index dba3b2f4d758..25db0a582c27 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -72,6 +72,9 @@ static int damon_va_evenly_split_region(struct damon_target *t,
 	if (!r || !nr_pieces)
 		return -EINVAL;
 
+	if (nr_pieces == 1)
+		return 0;
+
 	orig_end = r->ar.end;
 	sz_orig = damon_sz_region(r);
 	sz_piece = ALIGN_DOWN(sz_orig / nr_pieces, DAMON_MIN_REGION);
-- 
2.25.1


