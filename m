Return-Path: <linux-kernel+bounces-295107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C1D9596E2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED37C1C2039A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 08:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636781A4AC2;
	Wed, 21 Aug 2024 08:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YgJu+bvt"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D29E199FA3
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 08:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724228387; cv=none; b=rTPgztVQSlytlTFts4oWrjXYq/YaKpvvbRotINKxD6G2uASiTWCtTuJn8J3fz4aL9jEAc40sYEJquyhL8IgCLhC1/eylzsE9wPftvKc97ioT0PF36CHgkFfTtVaUMSIs6SUu2h5D5mIL/6kOPcqTvoYwWV29j6bv9B/ggNC+OdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724228387; c=relaxed/simple;
	bh=yDALv7oJp6DYj4uXpgdGiO5A+F1mvOQOyud1tIP6NFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rNzAp2a6+uDrGBEjq7rLAfh5590AhEX2UKnLP8rxiRL9GDB3TE+nXc8NzBUmKKAV86sACnaTg0hnGxdPDV9NG45+NKQ7jEzRFJAANIEZls56Vclc7h6u5LQOqtapzUgnCw7v6fvKAHFaIMZrJzuhJpHhvBtQvLbz00gMK6BTB8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YgJu+bvt; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7c6aee8e8daso4420274a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 01:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724228386; x=1724833186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkLNXpSDw35lj4Q8QTsPG+BhSNUK5Ar50Dqo0ISPkHo=;
        b=YgJu+bvtUp2DJmrfv+ISknWMWaBG8ZQRcyd8K1vcZ9IMkHB+x6LkzGyX5Ra1bGbNK4
         vpRp0T5M3BbjVmhTZTm6EnF8hlshYUTWtg6dlAAwKxGCQkJ7OOEYHZS/RbW29Jghxlj+
         5yzuq4+ZLXn4a6yL1hZxAYCeTCB0dvMwWgwu0cS9Ki441kldNRdp7p8+7tIKix2/0kxe
         FMfnquWdHAorX/PHTEPpHQlSKVhugsfDlrSE17N5Hs+2dTZwrPxXztgvjxcYJZMBJ6HA
         YLMpl2Tx79BBV0KtCcq5w84EFN2jZ7PbX3jnGjSDPm7oxXSSCwXxm/b/YT3PnvvYhFO+
         7P0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724228386; x=1724833186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkLNXpSDw35lj4Q8QTsPG+BhSNUK5Ar50Dqo0ISPkHo=;
        b=uouxjLkcLIokuW2TCRkJ/K8teTZdmr0Ks0DqdaYroR6tPcjTCEXgi+vRrkzaQEWFFl
         +zRj3iR216TsBvEURza7yHo0X2vNjSabzYcU1aS4v7AvXk+DssPtztq0v7oHANY/ooCU
         hpY5oazUuUYK5lGk4ZIKNYVHLrqi9bLxRaMKPyBpMQynbZiQQMsMPmaAgFeuaXoOdP4q
         c1/qywQXKJRfbztSuMUOtoPRu9DtHiVlpSYin7wkPXwrwwZh16u0b3BoVYhn6mGlMVcj
         mnitZGCS6ylz5fXpgtYGiobptAFA6OXY5nmxl4f015PQi5IDhz9tk7nVrRDwKmdot86l
         d7Fw==
X-Gm-Message-State: AOJu0YxVYeZN3fJHTVIoGwk6VneZ4KhnTwl8TAcnKmnUTzrSdSxGFr09
	a5C+UXkiFKrzC+y3fvhSuUde5RcbqZG2mM2b9sxbUwZh1i66DnK6xKO4SovBUXY=
X-Google-Smtp-Source: AGHT+IFyY3NlNyztu6E70clqH4irJgHSXlPUHA4AtOW6RrWWSbwAKaoUYDBEK6KZMX7nlR++kviHPA==
X-Received: by 2002:a17:90a:e7c6:b0:2cf:cc0d:96cc with SMTP id 98e67ed59e1d1-2d5e99c8b75mr1585510a91.9.1724228385781;
        Wed, 21 Aug 2024 01:19:45 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eb9049b0sm1091453a91.17.2024.08.21.01.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 01:19:45 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	hughd@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	vishal.moola@gmail.com,
	peterx@redhat.com,
	ryan.roberts@arm.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 03/14] powerpc: assert_pte_locked() use pte_offset_map_readonly_nolock()
Date: Wed, 21 Aug 2024 16:18:46 +0800
Message-Id: <a69c4631ab86ff9aad3f576c4f88979a223bbc55.1724226076.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1724226076.git.zhengqi.arch@bytedance.com>
References: <cover.1724226076.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In assert_pte_locked(), we just get the ptl and assert if it was already
held, so convert it to using pte_offset_map_readonly_nolock().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/powerpc/mm/pgtable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 7316396e452d8..ae4d236b5cef7 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -398,7 +398,7 @@ void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
 	 */
 	if (pmd_none(*pmd))
 		return;
-	pte = pte_offset_map_nolock(mm, pmd, addr, &ptl);
+	pte = pte_offset_map_readonly_nolock(mm, pmd, addr, &ptl);
 	BUG_ON(!pte);
 	assert_spin_locked(ptl);
 	pte_unmap(pte);
-- 
2.20.1


