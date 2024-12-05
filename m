Return-Path: <linux-kernel+bounces-432978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2102A9E528D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFE4C283331
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8D11E1A25;
	Thu,  5 Dec 2024 10:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="F7RsT8IU"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7581DFE24
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395101; cv=none; b=JIDnf1VdZYkP/4kbfPlbmTC+/qlklxJYluwcv9sbc/JCn2KsBAVL0fPCnhWx0rkf+VlXebx9iMFaWjvYtRH0rjOte01I4GTFdGMTOZJ0rObtdkKH6b9j20Jlz8bFP71aODDZHNgCIWaAyAtqN3O3zi/+Wej0PMRKt+/llyjhXHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395101; c=relaxed/simple;
	bh=HyAJKSANO0n/ESTj5vAArdGzeHYyl5LydIiFKhzGbHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gDNNUFbV47lDTcwnVtKyFxHbzGuppvyzKpfvuDMHt3HrmcSoTBKjNNrDFplrzUNC7urGKRxxlixB/yRJxaD7Cqu7EhqtAKUfNzrTBdC5cszUKEOPj5CUKfunvg2Tus6o7HtFMNZsm+w5orj/l9ynbNgff5y8BtgGrZZV5ynxBQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=F7RsT8IU; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-71d54fc1944so432801a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 02:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733395099; x=1733999899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfWeT6m9rP2RvyJAYvuGAOSzcqpyDy27Avf8NzKYXNE=;
        b=F7RsT8IUo9hLeaDvF+0B8CgySYbOTwJB51dC3x1zW1iHJIE3EJoglS2KPXnNyHPyrz
         ROHvFOzZGbTVvirbGW0Nh/kjJJPlj2ZhmvO527AftzLVbLMudLm2RWEPOdvpbBBF5lGx
         MDsLp+2ZnlALpsfw3WR/OtM6C38+dRQ/oXK8SFcndln4oxItUI/tN1bavSdwLbTcmrn/
         rsxFxPnQeH9ZCWygftsca94b7dXAWkh4YMviz4d22dDQI42i0ofNy79IZNEFvWh4/Q9D
         EAhJOazVYKB9IB9XrFAyvDIlak39Rib/Y706INxeAbj1Kov7sYglpKp4x2gSrjQI4HAs
         IpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733395099; x=1733999899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hfWeT6m9rP2RvyJAYvuGAOSzcqpyDy27Avf8NzKYXNE=;
        b=T2W1NaD1fXJD2kY8uaURQP3Afmoe2XyeewJhUuJHjyC9jz/+EJupLA8cA5pAcvxKQO
         t2amc1czn1wqPn4idr3SVgHuSom5n1sKaumBcf2v/w0dcwKxgvQ9Ei288i/VRt3buKjU
         a4iow9l9oNzjiUI7al4U5+RIiipKjOXCw6TXgOHMJA24jwVX8FQe1IkOKeJINdRWSj3P
         61pwSqPe9lluZsdEXZVRlfBybC0mtoVLvBzmq4RU80PijEVBtQKUfCBn/rm3TCJJqzF4
         DoKu2x7wUvAwMUwZgagcZ5J6zoSG4o/10yUfXu18jAgBqYmgPwKpityRiu1lLHop4Uss
         yHmw==
X-Forwarded-Encrypted: i=1; AJvYcCXIcKUDKVBU2p0iyvCAiyinOeDRw935t/O3IwLEkrum9Jnm/SqfBlG1Ft4qZChJt0fV9tO12POy8rULXaw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw82GP5Dybci28owZaxPWaP4NcD9Rcqk2KKMzonyTcNCsqpRuSs
	bFrIO0vxqRKiqDz/n9YHBugObQVtmXtO0GTX8fJRpZCCPg9jln0+NeupDUncFvw=
X-Gm-Gg: ASbGncvWCKzhwRHfq8AidzhHxVz/V3R2ftx4Lf6/o7Guao79RAtewWY26wIObQn9Cfx
	nUfwLVZBv5fYCz4z3zmvvejl3/omtxFQ/MDfcJ/OeeQgVKYA2NgCnmLx1iPYe9w0isVICtZvhMg
	bWevj3QFPnv2fP3frodCAITZwVUYDIvN45E6JH1gCQS8KP8z+ARwEmRzDugM+VV5gizNYE1F1sk
	fhGVRfL8qOPoEhczhQuK+FK3qGE+Mmf5oX5BLk/UrysgCx9AmwaNvjfZnZRMpzkU/GiKs9DugZH
	8Aa6NeKkqTnFF6jaQAFJoxDuEXRaaIJk
X-Google-Smtp-Source: AGHT+IHmo8dAIPLaAwW/lT+NI/PJnWblM6aaHV5WtIj+KNZJRyA2qtNhsMIENCAwyOOd5jQe2iKEOQ==
X-Received: by 2002:a05:6830:2aa8:b0:71d:4488:19d9 with SMTP id 46e09a7af769-71dad652c1fmr12149732a34.17.1733395099595;
        Thu, 05 Dec 2024 02:38:19 -0800 (PST)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd156f048csm886826a12.39.2024.12.05.02.38.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Dec 2024 02:38:19 -0800 (PST)
From: Xu Lu <luxu.kernel@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	ardb@kernel.org,
	anup@brainfault.org,
	atishp@atishpatra.org
Cc: xieyongji@bytedance.com,
	lihangjing@bytedance.com,
	punit.agrawal@bytedance.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC PATCH v2 10/21] riscv: mm: Reimplement PTE A/D bit check function
Date: Thu,  5 Dec 2024 18:37:18 +0800
Message-Id: <20241205103729.14798-11-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241205103729.14798-1-luxu.kernel@bytedance.com>
References: <20241205103729.14798-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CPU that supports only 4K MMU usually updates access/dirty bit at 4K pte
level. As each software page can contains multiple 4K hardware pages, we need
to traverse all mapping entries to check whether corresponding 4K page
is accessed or dirty during pte_dirty/pte_access functions.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/pgtable.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index bf724d006236..c0f7442c8a9e 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -553,6 +553,29 @@ static inline int pte_huge(pte_t pte)
 	return pte_present(pte) && (pte_val(pte) & _PAGE_LEAF);
 }
 
+#ifdef CONFIG_RISCV_USE_SW_PAGE
+static inline int pte_dirty(pte_t pte)
+{
+	unsigned int i;
+
+	for (i = 0; i < HW_PAGES_PER_PAGE; i++)
+		if (pte.ptes[i] & _PAGE_DIRTY)
+			return 1;
+
+	return 0;
+}
+
+static inline int pte_young(pte_t pte)
+{
+	unsigned int i;
+
+	for (i = 0; i < HW_PAGES_PER_PAGE; i++)
+		if (pte.ptes[i] & _PAGE_ACCESSED)
+			return 1;
+
+	return 0;
+}
+#else
 static inline int pte_dirty(pte_t pte)
 {
 	return pte_val(pte) & _PAGE_DIRTY;
@@ -562,6 +585,7 @@ static inline int pte_young(pte_t pte)
 {
 	return pte_val(pte) & _PAGE_ACCESSED;
 }
+#endif /* CONFIG_RISCV_USE_SW_PAGE */
 
 static inline int pte_special(pte_t pte)
 {
-- 
2.20.1


