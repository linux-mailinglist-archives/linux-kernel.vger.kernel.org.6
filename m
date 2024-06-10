Return-Path: <linux-kernel+bounces-208128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF589902127
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43A4E287C95
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55717F499;
	Mon, 10 Jun 2024 12:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wczqxt6x"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB074D8AB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718020956; cv=none; b=mgR1QY2WXbedcLm2voa+HXbzcFuaf/NL0mO7KsFgJNaNbkZw4lDTlomAXspaUqmraB0CWlTO6tKosc2aGsHQPXjfGsM7vw5f7CRcPGaYRub0HHiKG3TzGgW3h+OXnKlIq6A+KgxSmfaBKdVsMmdf2BjW8amUGnLMXEIaslcfrN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718020956; c=relaxed/simple;
	bh=/J8Ceo0Ki62a3kVYpxtqOWLGxQqfruh6wipVZOBmjlU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PIO/xmHRgdzkf1DDhK0B5gTVgAXtgb05roix2dOuQbnY/CGhxDf5mxF8mUsvfCH9SUk6xtTEL5eipRg1hw+PpooXB1aT9HvDnEg6RrmhZLYVO94Hor76CHfEXeJ1eAJ9F8dQ7LFGANMwsk0NGb/7v9yQF2kpLQ8yn5V54i90sws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wczqxt6x; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-6ce533b6409so3258158a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718020954; x=1718625754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Jta2NpH0Yo3jq0n3rdl7lcfRrUI+PWrFp0wIskmVQ4=;
        b=Wczqxt6xzFFyJUedQG21e5PJp/+ZtQcfflLq81Q/bnX2pE0diN9K8f6vgJ/kVlrHKA
         eyVIBqVKw5CSmFEkSujoGU0Vix/mfAZXBP+VZdGs10Ripa8ZrkszbxuUMJ4iC2EFFB85
         jRfwmOtzYfzRolh2R2TmwgVcD3QU1q5DTgkm8rUkeHEjqv/0ha/AmgBxfiHTZIn45Msi
         siDH/IwnA1Vlt6rAOvhYnfcOAZZmUMeV00Es+a+b34T6z3OLOrw8ryqluiu2LfDc23Re
         7uZd38iMq0DLQqNFksw9qLo8a5amPBie5SAoDe4s5vjQF05UtPFUhrWVfYbxl8ttKqkn
         DQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718020954; x=1718625754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Jta2NpH0Yo3jq0n3rdl7lcfRrUI+PWrFp0wIskmVQ4=;
        b=kDhWYV+nWRgA6N3Ma/VyydbQKXgxOWUQIPYZpnOMV3IWs8nasjN47zgZp5xveBN+aI
         wiQNki3CYbuW8sxNbN7ksmnFL4cSlTqZmUf6X+K1mSU3v3ZVvd/3WjyzCfA+QaubyoNT
         8aF6Cpri4r1WXcWpWXu/MjH/BcFGBLTHPhSkQPjWh9vxKiMM3+LnBPC99mh5o3gdvUrT
         k0JAisImREeuPBCDknMKrlS9Vgnc3vLna2Xne/dytSgWpf+9Zvfc1+y3B8cCrCMX8yqd
         Frp8qw/hopONapSIFEl/t+dKALayTiuJ2EgMzPFTGPplEL3/Yinbes2n+eyZKmFn5tqQ
         /gMw==
X-Forwarded-Encrypted: i=1; AJvYcCV4CP1gG20XKRM4ICTAKxdocMB6bGVsWmxJCBR9hJ4a+ZFMFx2A/Q4eSPcV91N63HXrkEd0CyJwy1GPR1gaEZ9nIx2AOPSKQZn0FI0I
X-Gm-Message-State: AOJu0Yw2Sv1syL5ZSFKust2KCxOmQO5YjSWv78WNwuC/oB/OKUjKGH8z
	RUjeqaSic1MDQzPQfiO5yNgg/7FaQNetctkkLzgxioOHKetKYQnP
X-Google-Smtp-Source: AGHT+IHRNhyGYjU+bbHW3Rl/BwTn9HYeOw84bchXR2tVdnHVYoifBRotkcCaIuC++at7Grjg8V1JGQ==
X-Received: by 2002:a17:90a:d581:b0:2c0:238c:4ee6 with SMTP id 98e67ed59e1d1-2c2bc9ba465mr8733353a91.2.1718020954042;
        Mon, 10 Jun 2024 05:02:34 -0700 (PDT)
Received: from LancedeMBP.lan.lan ([2403:2c80:6::304c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c302f0ebdcsm2478478a91.23.2024.06.10.05.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 05:02:33 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org,
	sj@kernel.org,
	baolin.wang@linux.alibaba.com,
	maskray@google.com,
	ziy@nvidia.com,
	ryan.roberts@arm.com,
	david@redhat.com,
	21cnbao@gmail.com,
	mhocko@suse.com,
	fengwei.yin@intel.com,
	zokeefe@google.com,
	shy828301@gmail.com,
	xiehuan09@gmail.com,
	libang.li@antgroup.com,
	wangkefeng.wang@huawei.com,
	songmuchun@bytedance.com,
	peterx@redhat.com,
	minchan@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH v7 2/4] mm/rmap: add helper to restart pgtable walk on changes
Date: Mon, 10 Jun 2024 20:02:07 +0800
Message-Id: <20240610120209.66311-3-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240610120209.66311-1-ioworker0@gmail.com>
References: <20240610120209.66311-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the page_vma_mapped_walk_restart() helper to handle scenarios
where the page table walk needs to be restarted due to changes in the page
table, such as when a PMD is split. It releases the PTL held during the
previous walk and resets the state, allowing a new walk to start at the
current address stored in pvmw->address.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 include/linux/rmap.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 7229b9baf20d..5f18509610cc 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -710,6 +710,28 @@ static inline void page_vma_mapped_walk_done(struct page_vma_mapped_walk *pvmw)
 		spin_unlock(pvmw->ptl);
 }
 
+/**
+ * page_vma_mapped_walk_restart - Restart the page table walk.
+ * @pvmw: Pointer to struct page_vma_mapped_walk.
+ *
+ * It restarts the page table walk when changes occur in the page
+ * table, such as splitting a PMD. Ensures that the PTL held during
+ * the previous walk is released and resets the state to allow for
+ * a new walk starting at the current address stored in pvmw->address.
+ */
+static inline void
+page_vma_mapped_walk_restart(struct page_vma_mapped_walk *pvmw)
+{
+	WARN_ON_ONCE(!pvmw->pmd);
+	WARN_ON_ONCE(!pvmw->ptl);
+
+	if (pvmw->ptl)
+		spin_unlock(pvmw->ptl);
+
+	pvmw->ptl = NULL;
+	pvmw->pmd = NULL;
+}
+
 bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw);
 
 /*
-- 
2.33.1


