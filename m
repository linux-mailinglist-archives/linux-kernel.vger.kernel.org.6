Return-Path: <linux-kernel+bounces-228191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D76915C25
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 04:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E6512826A5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 02:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA483D3AC;
	Tue, 25 Jun 2024 02:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="esmQgy7/"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BED43A8F0
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 02:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719282242; cv=none; b=jvQ/wKCn3297zn6YO/YAsTzswj1D45GiXH+NUDiJEGeGj790kluOvpEJHEH+AKHVifKIU8CmCEtHG4Q+kEephlc1IIJvaJkPu5wS0Pqi/foiNbsz5AZuVRbqRef5PlCa6jexbzhJJF+QcTfKq0fKng1hfffYTw0jaiE9ziI95Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719282242; c=relaxed/simple;
	bh=HOFe4gQh1he1RkxCvR+ERaAc6DhQZhwU0Ej5HE+hZKc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BbkmDR1Wm/hAlE0klvKJj/CAVdLInBkkUzh0uhDHs64stbSqiBRtFrrjoTQB7ZqLbxK9icBOp+DOJeJ0z1UaI+MqJopAzoR/StHJAD2VzebK/yb3et4rNHQlesrfUrfk+7p7XE8SszWuMXfANO7w0PjUPLRB4fjhWr1Xo8gNIo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=esmQgy7/; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f9e2affc8cso29057425ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 19:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719282239; x=1719887039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qzm1hduKRRbAxkUcBnmHKI4fBaYnqgHeK2tEbBYc8Gc=;
        b=esmQgy7/aOI49RpK7LoOH0UQAq5mgazZB/IzY9HAiwR94hgCMJn7rKhOUhSi3BIQ9y
         lSEHz3X0tX49AaxeE0xY5/sH5RhcpUIoiravk4Lu2qHX3fNC7YDKMhvtmRQRqo74UQbq
         1cH6IAPmv3XgI+k2PJoS/xTIF+6VzeERCbBC7Y3R1IG1i50PY716/ElTp98Jwk6X4uet
         Gz5GVcwD4ijYAio7UbsDV1Y4F6vLDSWAleLUWjpuX5h53Ravbgh4s7/ol6y/Gb2XiqCo
         Dssn8HbsFe3RwPf1BfX9xeaDhIsM8Xwfrc3LDUNysRSzuNTt9cZc8iZcMky+HU+vvHF7
         Dhkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719282239; x=1719887039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qzm1hduKRRbAxkUcBnmHKI4fBaYnqgHeK2tEbBYc8Gc=;
        b=Z4zbgoDBTx7xDNYIEj8fxFT+SUPrXoliLo/nJuTukBATJchmFLKuFUcngL/cXBQfTg
         J8vbzBWMjWXmaSq3IHtKn0qUQoW2lld2HdJhFbRAF1d5soFtDVEfZ/Rmtj08ciYkz8L6
         64ngyyhz2kLNYBSVjf5YEfT997jJBulES2aJUVQnhUMF87fk+BmAOYHzcBtRbPQSdTQn
         6zbVwIBNfIBXC+YSPmKAJivB3QDwvrQfAll7raFASoFCpW+tRYakEcjU5HF7v8CmM+I7
         /PFGefEifizFrjN1KFLDGyTAO9vGyFYWihkvK5XcMPsw/wziwPchEh7PsQ9/Lq5V3cjC
         2ahA==
X-Forwarded-Encrypted: i=1; AJvYcCVywh/Usxh08l3T/53e/aCDJHGn8mdxwk94loXkL1f1QOi22XwJeDEamGPLUfJkdq3phTvLJMb5OFy7Q5A8F8drlRL2/Axn0Ptsi4/A
X-Gm-Message-State: AOJu0YwJb2lzgXz7nngh7hTeLwhARQz29eo/q3cv6zllyREcQGlzVCep
	rzhbxZOHZhiL0ThRxH+8aRYPsKadg3oGkjNrwFp+GDItseWcqDdG4WIxVwO56b8=
X-Google-Smtp-Source: AGHT+IGsqb57dVxWL/Ml4r5D/R2RFk9sxDrqW6p21LQLMaQEG1XbIgWVnE+aoAVQ4+UABxFzuR4CCw==
X-Received: by 2002:a17:902:d50b:b0:1f6:dfbc:7f1c with SMTP id d9443c01a7336-1fa23ee51fcmr68860485ad.35.1719282239556;
        Mon, 24 Jun 2024 19:23:59 -0700 (PDT)
Received: from L4CR4519N7.bytedance.net ([203.208.189.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3d8bd8sm69386525ad.209.2024.06.24.19.23.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Jun 2024 19:23:59 -0700 (PDT)
From: Rui Qi <qirui.001@bytedance.com>
X-Google-Original-From: Rui Qi
To: linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Rui Qi <qirui.001@bytedance.com>
Subject: [PATCH] mm/memory-failure: allow memory allocation from emergency reserves
Date: Tue, 25 Jun 2024 10:23:42 +0800
Message-Id: <20240625022342.6158-1-qirui.001@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rui Qi <qirui.001@bytedance.com>

we hope that memory errors can be successfully handled quickly, using
__GFP_MEMALLOC can help us improve the success rate of processing
under memory pressure, because to_kill struct is freed very quickly,
so using __GFP_MEMALLOC will not exacerbate memory pressure for a long time,
and  more memory will be freed after killed task exiting, which will also
reduce memory pressure.

Signed-off-by: Rui Qi <qirui.001@bytedance.com>
---
 mm/memory-failure.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 05818d09b4eb..0608383f927a 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -451,7 +451,7 @@ static void __add_to_kill(struct task_struct *tsk, struct page *p,
 {
 	struct to_kill *tk;
 
-	tk = kmalloc(sizeof(struct to_kill), GFP_ATOMIC);
+	tk = kmalloc(sizeof(struct to_kill), GFP_ATOMIC | __GFP_MEMALLOC);
 	if (!tk) {
 		pr_err("Out of memory while machine check handling\n");
 		return;
@@ -1931,7 +1931,7 @@ static int folio_set_hugetlb_hwpoison(struct folio *folio, struct page *page)
 			return -EHWPOISON;
 	}
 
-	raw_hwp = kmalloc(sizeof(struct raw_hwp_page), GFP_ATOMIC);
+	raw_hwp = kmalloc(sizeof(struct raw_hwp_page), GFP_ATOMIC | __GFP_MEMALLOC);
 	if (raw_hwp) {
 		raw_hwp->page = page;
 		llist_add(&raw_hwp->node, head);
-- 
2.39.3 (Apple Git-145)


