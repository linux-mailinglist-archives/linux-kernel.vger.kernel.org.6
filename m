Return-Path: <linux-kernel+bounces-283462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7390B94F53E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E3841C2107C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 16:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14125187849;
	Mon, 12 Aug 2024 16:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jrr5QlJk"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE24D18733E
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 16:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481351; cv=none; b=uOLqf4Upq22aXH6polwc8mh/wDjEeswAyKR9anLMVEtP4nPztX4IIZVo5vEBNSHkSrcfv+XPDjOFLCXEBXZCIFDET8w+8U1C6N1RsNA460lss6mwrj5CisPlTeRipky/1C5m32H98k7vN/UMeFLdVYTBSgjp1XFKOUqTTf9NExU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481351; c=relaxed/simple;
	bh=cyEqwtJdd73Z0XZVi41RqSUaVwXAJZY8AuIAhW9WDHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XO9m8nDwgcv4JZzdez32hs/85oND4hAbUQEBQQ6OPLX0pVYIhlaeP8iaA0lkTFDoMxQgGdeZM+gou+9LQ6qccKyQ6RlNrNoYuwS4eHOnOVY+gA1CBSoRZjBS0uGC2QVUDm8e5k5aiOTS7TaSzhv4hSZp95il8XZTsnAas4233ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jrr5QlJk; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42807cb6afdso325e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 09:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723481348; x=1724086148; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DJlU1qRayR5F9JUx5MXjL9SPDXmWr10IpUL5fPzVi5M=;
        b=jrr5QlJkrAeiL6YYo8aqEvpIYe5Rs5W4q34Nkle1saIIvWO/zaKlCtPd1c2yw5kvMg
         RW84C2XurUApx7ZVzBxlI8/gevTZ2TnDr+3zsia5rzfkMfLyF6/jgOAu0GlsPYPJcD12
         TREldQH5fOVes+htr7+AiVthxK9LAoZjsC9kmwtuCitN4ESAu42M3UYaDUr5kP/lTQe0
         oyYmxevmqmzvvfBL3NlaJ0G28SDI8k1CQs+lPocmibQmikDsZUsl8Jo9GlZUmubiVi3K
         a9G1bHnO3oWCcM35HD5mV/oO2cq6JhO615TAgyKMlB+JIrBhN6EzcIVkIqUenzVMMc52
         WWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723481348; x=1724086148;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJlU1qRayR5F9JUx5MXjL9SPDXmWr10IpUL5fPzVi5M=;
        b=JB924uiahV37hUB+m7SVFOfWSnVNGmgNFiMrflFvi8J8wdut6NeD9sLthsaBkr3G1F
         iIFkNAUG0cbbEYQAzejdq7e4enypMQnQAYfXV28qFyrBrRlMSaNLbs6UYkoMWUhbi76V
         7IVBHBhGZSj4X/FJIDWtXFk+/Vz/y1yebPV5cgV0G6WbkAqQnPRtlDU2tx2EwkKdlZV3
         8eMKgM5apl5rxqb8LpnfVy7xkc+5dq2ooZpj3K0JvDENjy3LA6qv3IL1GPIqv0iaa3H4
         wpXWpQDMu2QRU5Yzm1RSCoeQfAQFVXoFv08eNdB3wfA/cm01ErjGeWdfx25rE9f/t/Mf
         OmMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMVGwlpxaiuFoPRLfZIKe7SO6NXcxO2GrNmTEY9J5SPRW/owks10bCMgJzPf9FGa+eJC6fBD2cKWJ5Qrb8n3wghPXYp67jPzzLe8PJ
X-Gm-Message-State: AOJu0Yzciu6NoDZkEUwJYi+7pEvEYrbm+ql3v7z+EPqIvfCGpZOPh4up
	2dXOLsLG6Iak08ttlhBv+skYevVM/Ded0/CX6wPNMK6ajV7ooKPWj0a4S2nIUw==
X-Google-Smtp-Source: AGHT+IF3zlvPwjqUofQiL0ZC5eEQF3fcknxLRKQAkZEkHYcLKefHOkHnk0bRtOc+kUzO6CYwrPRQqA==
X-Received: by 2002:a05:600c:1d9d:b0:428:e6eb:1340 with SMTP id 5b1f17b1804b1-429c7ab73f3mr3104265e9.4.1723480961010;
        Mon, 12 Aug 2024 09:42:41 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:731e:4844:d154:4cec])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4ecc7ab6sm7913066f8f.104.2024.08.12.09.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 09:42:40 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Mon, 12 Aug 2024 18:42:16 +0200
Subject: [PATCH 1/2] userfaultfd: Fix pmd_trans_huge() recheck race
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240812-uffd-thp-flip-fix-v1-1-4fc1db7ccdd0@google.com>
References: <20240812-uffd-thp-flip-fix-v1-0-4fc1db7ccdd0@google.com>
In-Reply-To: <20240812-uffd-thp-flip-fix-v1-0-4fc1db7ccdd0@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Pavel Emelyanov <xemul@parallels.com>, 
 Andrea Arcangeli <aarcange@redhat.com>, Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723480955; l=1791;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=cyEqwtJdd73Z0XZVi41RqSUaVwXAJZY8AuIAhW9WDHE=;
 b=aJA7M7sFrH6fD8l5+lxzjeojnHNOZEjoqfdSfrX7+15r0/hEZsfJhoS9jBzIQjwlC/09kjeLt
 aliIZZ7VCkXCOia7BI5iwegqhOGJUdxnMWHy2QCvS7PsVHzM0h5yHQr
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

The following race can occur:

  mfill_atomic                other thread
  ============                ============
                              <zap PMD>
  pmdp_get_lockless() [reads none pmd]
  <bail if trans_huge>
  <if none:>
                              <pagefault creates transhuge zeropage>
    __pte_alloc [no-op]
                              <zap PMD>
  <bail if pmd_trans_huge(*dst_pmd)>
  BUG_ON(pmd_none(*dst_pmd))

I have experimentally verified this in a kernel with extra mdelay() calls;
the BUG_ON(pmd_none(*dst_pmd)) triggers.

On kernels newer than commit 0d940a9b270b ("mm/pgtable: allow
pte_offset_map[_lock]() to fail"), this can't lead to anything worse than
a BUG_ON(), since the page table access helpers are actually designed to
deal with page tables concurrently disappearing; but on older kernels
(<=6.4), I think we could probably theoretically race past the two BUG_ON()
checks and end up treating a hugepage as a page table.

Cc: stable@vger.kernel.org
Fixes: c1a4de99fada ("userfaultfd: mcopy_atomic|mfill_zeropage: UFFDIO_COPY|UFFDIO_ZEROPAGE preparation")
Signed-off-by: Jann Horn <jannh@google.com>
---
 mm/userfaultfd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index e54e5c8907fa..ec3750467aa5 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -801,7 +801,8 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 			break;
 		}
 		/* If an huge pmd materialized from under us fail */
-		if (unlikely(pmd_trans_huge(*dst_pmd))) {
+		dst_pmdval = pmdp_get_lockless(dst_pmd);
+		if (unlikely(pmd_none(dst_pmdval) || pmd_trans_huge(dst_pmdval))) {
 			err = -EFAULT;
 			break;
 		}

-- 
2.46.0.76.ge559c4bf1a-goog


