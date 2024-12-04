Return-Path: <linux-kernel+bounces-431049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2012F9E3878
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD47C282A6E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611471B6547;
	Wed,  4 Dec 2024 11:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bT/DB+mw"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551F81B652B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 11:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733310658; cv=none; b=UVLy2x5AFJEBwqES1rDsgxmGYj/gBjk6an6/XYjqWXAQRgH4YOBsSLKXgyxo1Cv15dZ58Lp50ZrKM77GHO98XqxGzI705WGZHdw3q7znpQ1GLWnsiniLq9FREFjrma20I2W/5mkCf3YBlgijggn5bu9TybrH7yWhOQSihTk/q/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733310658; c=relaxed/simple;
	bh=N971sMAHwsLpjF7GuEYy3BPBTJ8uwywgaL1ODtjcCkk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=De003/9mtLgkgdx0BsMAUZmTuVduGbw699Ham1D3JZD+2ThshwmDWbIW+ccFaHdPBxVLecd1/LJjtZaZcueKcdl+XAiboQLvqPc7O7pfSW2eT4I4mpi3HMTfr9CMZ8J/23oGXOiKW/nnn/B6PgYmNY53WnSYTXxNgRZQIpFU5Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bT/DB+mw; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-215c4000c20so16423915ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 03:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733310656; x=1733915456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkuROlRprAHSTBsp8RZw3I2mnycKFd5DDkO/yWw4n1g=;
        b=bT/DB+mw6XoyNhu8XH88IskK6h2UiQl5YFwBj7PIIuYpxlHABSYxH29UBnAltxdO54
         h5pTLOkdpRLaseVpgKGRnAiXbLuqyQnYz0zBIhQ3tZnvMy4938ipojnqQdPC0HMLbtmq
         KtkHnk7B1mTEbunmhDsEXC1kKoNFmbV4urGB19Xd9Ysyk6hPI45IIzHY+Qn05lqDu/J/
         l3g4AOnd8ZR04ujrzuwb0AdwJ6t5E4FNJo5pZF1QNo+4SRznaKHzB/PbMq8OMh+zzY94
         I2YmSKTPcTrCZWVDDEDrFzG20e8H+MkVM9rrYDSnWk8hBFdg57dxN/f652pFTcq1h3iM
         6dgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733310656; x=1733915456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QkuROlRprAHSTBsp8RZw3I2mnycKFd5DDkO/yWw4n1g=;
        b=Syvuay5ZBRhXPXn5n0MwzLiXFqYK0m6IpD5UNibySKOh3JN+z5oFqHDBvbOfU9IIEL
         3ZxSx1OCKa0A4qqi/NTRpKjdR00NnV7WWhSfVuCn3Z8kOq3u0hhPO6qgcNfFVUZ55lKt
         jxYJKeSEvRhaLFbJD23ppms5vMQYH8D/pm/41MyG2ZqONOGUSDVQp2rc4RIAOY787dqJ
         a+vWqGtLGldvWB7n1DtlbMRtIE30ZiAxFU7ZD4IiZbPUGQd152r+FUJKasotiWm63zTp
         BbZnziuGuVHB94XHnoBVs9EddA8JS1ziwdNNBbBJVLeBHHxTa8JASFfxYf+pUEDmrMii
         q2GQ==
X-Forwarded-Encrypted: i=1; AJvYcCUN5gJKTWN+XmH+U+DOP1A81NypV1Cot9bNbeweYPQ21i1AeShPRTFLtCmYfui/oh+YZf1RnNR/whNAxtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSAMOaY0hUw1mIJUsJFUuS+AG+o1/EDvge2NwFiJiUylmTafbr
	HXv6CiTnJx0CkbnKOcTcTwlKZYbrSVZMBhqJPTL8KeyvTjhYEmjSSwxb99JLbf4=
X-Gm-Gg: ASbGncsTu4uXWucqzgMVtAry7RAJDzwdlnXdK5Jniai55JnoXSiPcwlNUSgCvDbOxyX
	mchm7d7aOvfQ5QBNW99c74YDAAbDq+fp0gc/td8MFhx0T/w8OyyreTNMtvMhPgM7yLh+k/wbjxR
	kpAoQEUYw6p6Pd2+lMTsUpB/cRojANDrKQ/Ao0g1mqro1nEZpitR1rtZQ5aW6NUAUZaRgcFNXst
	adp6jyZarioZOGelkMiPTHJ7lvPkaXBaezoNNMZAlWQD3TJoTIQkEMoBikZf1NjdRN8riVOEQOr
	fhNPYm5iCRBy9I4=
X-Google-Smtp-Source: AGHT+IEu/5U9u+MTuBZhWK2lULLFn2ChhXdgNwcwoaBBrqVb6T6ZJFfs9ziJlEdo4kgFVcC+MHm1Dw==
X-Received: by 2002:a17:902:dac7:b0:215:72aa:693f with SMTP id d9443c01a7336-215bd1b476emr75201455ad.9.1733310656657;
        Wed, 04 Dec 2024 03:10:56 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21527515731sm107447495ad.192.2024.12.04.03.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 03:10:55 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	peterx@redhat.com,
	akpm@linux-foundation.org
Cc: mgorman@suse.de,
	catalin.marinas@arm.com,
	will@kernel.org,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	x86@kernel.org,
	lorenzo.stoakes@oracle.com,
	zokeefe@google.com,
	rientjes@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 05/11] mm: skip over all consecutive none ptes in do_zap_pte_range()
Date: Wed,  4 Dec 2024 19:09:45 +0800
Message-Id: <8ecffbf990afd1c8ccc195a2ec321d55f0923908.1733305182.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1733305182.git.zhengqi.arch@bytedance.com>
References: <cover.1733305182.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Skip over all consecutive none ptes in do_zap_pte_range(), which helps
optimize away need_resched() + force_break + incremental pte/addr
increments etc.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/memory.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index abe07e6bdd1bb..7f8869a22b57c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1665,17 +1665,30 @@ static inline int do_zap_pte_range(struct mmu_gather *tlb,
 {
 	pte_t ptent = ptep_get(pte);
 	int max_nr = (end - addr) / PAGE_SIZE;
+	int nr = 0;
 
-	if (pte_none(ptent))
-		return 1;
+	/* Skip all consecutive none ptes */
+	if (pte_none(ptent)) {
+		for (nr = 1; nr < max_nr; nr++) {
+			ptent = ptep_get(pte + nr);
+			if (!pte_none(ptent))
+				break;
+		}
+		max_nr -= nr;
+		if (!max_nr)
+			return nr;
+		pte += nr;
+		addr += nr * PAGE_SIZE;
+	}
 
 	if (pte_present(ptent))
-		return zap_present_ptes(tlb, vma, pte, ptent, max_nr,
-					addr, details, rss, force_flush,
-					force_break);
+		nr += zap_present_ptes(tlb, vma, pte, ptent, max_nr, addr,
+				       details, rss, force_flush, force_break);
+	else
+		nr += zap_nonpresent_ptes(tlb, vma, pte, ptent, max_nr, addr,
+					  details, rss);
 
-	return zap_nonpresent_ptes(tlb, vma, pte, ptent, max_nr, addr,
-					 details, rss);
+	return nr;
 }
 
 static unsigned long zap_pte_range(struct mmu_gather *tlb,
-- 
2.20.1


