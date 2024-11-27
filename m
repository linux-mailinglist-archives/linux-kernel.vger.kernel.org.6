Return-Path: <linux-kernel+bounces-423541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9449DA964
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 534E3281985
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4C41FCF73;
	Wed, 27 Nov 2024 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ryliNAdZ"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88D25B1FB
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 13:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732715627; cv=none; b=Ru8KzwDqpATGT5Mx/gf95eQYaWia5haG5bIh2pDTKX6ffxuzdak67MKqzuKLIl/Ri22xeV5dx9DpnyZM/CM8J5zfoyYmS/zGaOfxSNMZ57eDm5Aotf0WitgkJ1MucBMN1I0d9feoGwI9YjYHn7Lvlpz0Au+DDK9G2Njo5pSMmeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732715627; c=relaxed/simple;
	bh=VRWUvgzx7rYlrQvUSNUWj7CN6so9aLh1ETeRlJx8kcQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pasNQwWa/tTtTacWJxbaVeA/J3buDlGdUXwucG7aYNCPqe0AZ3Nd/jteBKkF1qXmRLAdYjXvsDxP6XJ1JSdt8ON2nvyvUbLduDOEmLKCAJ5CbFuArypMvGVE4GpsWMHLhkkDkqROMEF/DLKBKxuwmBsqIEycqG2cExZHhDveDCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ryliNAdZ; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-38242c5b4ffso3844094f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 05:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732715624; x=1733320424; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LgK9zCbOe2BiCOOWFF1Icjmyl+tnwoEPsdpHpZDH+bk=;
        b=ryliNAdZon8PTMfb3CWuu+Fx754gjtsqqwjDQLQ5+Bc/1Nr0hftsD0hjsbInm83hCp
         2R/4QQSAVoKiWywT14cxtpjSFBVPMCHwEy+LJSQRPGldtZ722IbVpAnhFVZ6ebdw/EXl
         +JziejkGFdbo+FBQQ/YgoMfN/K9PEFuLaOKapkmHEnZti0qE6dKkTawQfVZDOIV1zIhF
         m27RRcAV2TbYnVbtkaxjcL2lxzUk0FJV8XorF0dXa0nPacle+/Rdel0B3/Eia6jN9v0c
         KhkKGB7s3SfFcSrj2LR/6u0VGhoYtYUKgO2G7pfVBpL9JXY69jxWDCaIcVGbNQMqzzZt
         VpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732715624; x=1733320424;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LgK9zCbOe2BiCOOWFF1Icjmyl+tnwoEPsdpHpZDH+bk=;
        b=c16LiFag5yNXGphpGbBi2JKGduPB650miJDrvgj/sUwE1Opt4pN3Jxrj5pkKoGIzcP
         2YKG8j9L45qNWQoBZWrOiHHh4AmSfrD11QU9YBV5QdZtv+aLfeQITki3gS/elOL40sS9
         YsmVzIi+UCAUYuS0ZUnALVYEZReqcUxJmtiLjCvjuEyhVtFvghzhKPlw9qLhkpT0Fphe
         Tx19tbm6k24DaUoiXYhRfVv9lCZLjbqG0rIDy75KJbj9XQwWU0QXe4/w2r5OJp3C8HD5
         twCFkooDVn7jW9j593j/U5eMH1sUZ0Zy1TKtPrzjFXJ41bEtUc3i7ySXt2SNxQB6EFYp
         QMAw==
X-Forwarded-Encrypted: i=1; AJvYcCV7vNFDTC+AqWmH/2yGUb2/cVVI+xVjqPfLtG1CsVai2cH6dCsWzrl5Ja5ecxT3qjt9waiFwQPUoVg5IH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhXsYsj2LI2dNAxK1mSaYluhyhHvkAC16PvPlhUCXSRyfOVNgr
	kKatYwClwRhxiWNAL5H1aBRmhTrRVE2XJaqyyx+3Bk5iS28rTm5IlyNgciN+f06QGd24ccJtogt
	qF3k8BHiK7lsK6g==
X-Google-Smtp-Source: AGHT+IFX+RPxfsTxBF2uedBvPaPPaDfX+VfKCPL1ZkMBXNYt1hBypGVgbleoZsTSed9aiiG0gdgG0p5LlymEFoQ=
X-Received: from wmee13.prod.google.com ([2002:a05:600c:218d:b0:434:9939:10da])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4802:b0:382:3afd:126a with SMTP id ffacd0b85a97d-385c6ebe5f6mr2728312f8f.35.1732715624380;
 Wed, 27 Nov 2024 05:53:44 -0800 (PST)
Date: Wed, 27 Nov 2024 13:53:29 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFgkR2cC/x3MSQqAMAxA0atI1gbaIIpeRVw4RA3YgVZFkN7d4
 vIt/n8hchCO0BUvBL4lirMZuixg3ke7McqSDaSo0poaPMKF8XQeZ2cM2xNVu4wTVdRMNUPOfOB Vnn/ZDyl9UrmeYGIAAAA=
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=928; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=VRWUvgzx7rYlrQvUSNUWj7CN6so9aLh1ETeRlJx8kcQ=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnRyRdE2k0cYM4vlf6PjwbYqBZlP7G2DYBBCsPv
 6HHr8havCuJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ0ckXQAKCRAEWL7uWMY5
 Rre3EACa1v3Wq83Vg13daQF9vKZPS1RVOkozXkfGafrh2EVQ+igtHkTiIAuPqwFbV4D+gwgdu1e
 oQFXvgE1qGxVlJatPq8USmSHzxuGHgF16Rrg77Ns79SW3SGsCkpJWwSy6zj9Rn/7rOILbbb/i6w
 TbJHV26JfeUYHQ9BkbQb03Tf2vLYM4hqnQ/Ho+FIJ7RtAH9FWXZQhouiyofH7OAYZ3eDI6nq9rq
 Qoft8WZ1feNdEt407dNLZl0TSTjJnkF2m71D3QqMb0ufOUdIpq1HzGmo+TrDQAaqMvucDDIZFIy
 QTDAbaaOz7w9J4YvDqWEMX0tyZ+kZaWuy7dfFlRMjMFq6mUBhKJiOCiVGB1KAO0QDsguPJwxpD/
 mphwOcEH6mGxAZQHgl2rMWZIHVGVTMJUQamh5r7iQDn7eiLPmAcWiVPR61NVjWIWn6YS8qphWpA
 McCqyU0GZDxHQoJyg62jmBGuJBQc2K3ax5poOH1aVfeWYYR5GsC6NsW/TN/R5UycYCjkHJEQ7t9
 dJGktcH9O3MOeMObY+NG1aCyJ6GnyQApY9A4TcAqa1KRvZYEy6UKV3b+8uivOkngXRqjjt96tCj
 D9pL4n+f+2evX2UQfkd2FH0QVREPJgJZZaGzGZUcB33SzXZtxmOBqFPVyV8+uJkSVOLalKBggM/ mTAikKcM8vEccyg==
X-Mailer: b4 0.13.0
Message-ID: <20241127-lru-stop-comment-v1-1-f54a7cba9429@google.com>
Subject: [PATCH] mm/zswap: add LRU_STOP to comment about dropping the lru lock
From: Alice Ryhl <aliceryhl@google.com>
To: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This function has been able to return LRU_STOP since commit b49547ade38a
("mm/zswap: stop lru list shrinking when encounter warm region"). To
reduce confusion, update the comment to also list LRU_STOP as an option.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 mm/zswap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index f6316b66fb23..9718c33f8192 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1156,7 +1156,7 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
 
 	/*
 	 * It's safe to drop the lock here because we return either
-	 * LRU_REMOVED_RETRY or LRU_RETRY.
+	 * LRU_REMOVED_RETRY, LRU_RETRY or LRU_STOP.
 	 */
 	spin_unlock(&l->lock);
 

---
base-commit: aaf20f870da056752f6386693cc0d8e25421ef35
change-id: 20241127-lru-stop-comment-09dab2427b6e

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


