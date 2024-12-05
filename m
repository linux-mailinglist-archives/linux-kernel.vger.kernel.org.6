Return-Path: <linux-kernel+bounces-432975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A5E9E528A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C81181673FF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A221DF980;
	Thu,  5 Dec 2024 10:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NNp+Cndm"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154251DF748
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395089; cv=none; b=ChrJU2N5Trt6tj9mS4LSu5QHEf7+zY8GLxeh69bqYFCWbdbliNIqEvrVEEIcMTQ2HNumS0m2rTdNZEllYn8i5gkA10YMHnyOrhJEBdKjneBatah2J8eSilcDvFMwnSZEyduiAY3vcWjVSCL8QaBraC8h067Oak2o52aVaE5l3zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395089; c=relaxed/simple;
	bh=l5MuxZWDOeWyprgQyypSfLl0LW6lklDXjU9sKESU9IY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NnDQ5IL9aU0FSk11vWh4ZAjk7MLxnawSEWxDPVBCYiAFYCWdKZJZoXTqlWWJXgeK5sVcwkf7LSlQEyOgwUhuQ6l7thg1qBw3/xycmH0rKxnp+a9hH6N4q+bLpg6TjplDZqBYPyY78JiMKUOQhFZvysqblsNfsdibR1Zm87zOrDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NNp+Cndm; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-71d46ace74aso371775a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 02:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733395087; x=1733999887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cw560nhmcCgMtoVMwQuAveKPR5/TXRAfvCK89A67aqo=;
        b=NNp+Cndm+KS57k21i/wUyQfcTJXavb+n9b/Oe9pbLLUA1pdYcvZqiM67UwpLL5LYnG
         m7hcHOQ2MR5zYm27rmuteX7qwHPtg5Asjxm4RooRJw8RVz/D7lvrWohm9atj10xZTOQm
         HZbIZCvfzSnpHpDnd0w02oGPZXWrdcD5oMWHtXmBh9bX9lTKc+UmUPMnmPdFa+st4TZa
         lrt3wL7gvG6iZ6lYHU50Iah9X5XGG6D8oXPvW8MXE3MAg6zo/UjdJIOh/TUWHAxH2Txn
         D2Q64rXQC1XlUcW4UEaDTN77qU5A1Y0ToaDNcR/B01W7sfUZgKZk7erA53ggQncC0lmb
         ZfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733395087; x=1733999887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cw560nhmcCgMtoVMwQuAveKPR5/TXRAfvCK89A67aqo=;
        b=v8vo28rsvgPrjXXEfkJ2w+wIyNEXJ5PMC2za0i9ZKn7yrsIhpnOTU6O7ii0hbpspge
         //v6R7uLqjo4VtlPN5C1X7aucUmlsP0iuV0Gn5tzV9h3IdnrN0G8++hfva/wK6GtOrp6
         /lvvmmalNhgsA/+K9aiumqK3HEFr4P15RhSUrZ/BUFR1mNKtZ1KgCGkvOsDsosqAwzbg
         y+qqDm6d8OF3s+xuK/LEgtJ/4ba7jBYOi/oOaa4p1245GT3VCXDwjldGXy6E0tDJrsBN
         M7Tf84AvSze9ZZe5ZRVne6mA0eSl70OKd/oe3BBFpm9cKSbCAWeqmn84eWHI9w5/pNV9
         A7nw==
X-Forwarded-Encrypted: i=1; AJvYcCWNZcg5NKgtyMhHGrpAvkDetAyVHJWvW8f43axNkeNowT+zlErm/S9dd6upLtvug3ho0VnOfsItyJOmJJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4lPZy2y5KUUYBg6XFz2z4Bb7Iy1cW/a7xGsmxqyNOrD9YERHR
	PRr5mpuVm+5KWsPDeucRjImUQqyCQ/J5WD1hL8Jwu7QamQ3OreVyhr3MX3GO9CQ=
X-Gm-Gg: ASbGncsiZdCGG4ENIHYV4FinZqteZosBftKYskamnP9Y/AYlDIlBwSljt7OhmXxyPH4
	JR+LgC2mImWnCLBXQAn/UhNlC+URWeGsj9x52H7FqWoIGc55ZUkym3ka9B61Q1yjDWhL0/+d8HR
	drnDs+KfMEYIbb3eb+PlVt3OMuqVVsBftJFyw5qMt79WyLXYCPYc3kb3tX2OH4aL3QvTdEYfpaa
	r2e5ucHjrbfem2jlXDXn19jc+J/g2txoXr/+WD883rBZshqrgDn2SShniDwZRj8u4LOkfAql9Yp
	FHXT3PpmicPdNXWlVKDzwu6mKKjAU7xF
X-Google-Smtp-Source: AGHT+IFgLX/MNdvVLEUe2bcmja2NfdcbWMv5BT39DW17XBNTzPIKVvGRlTw6+0l7AjGg6yRiky8Jng==
X-Received: by 2002:a05:6830:6016:b0:71d:54fb:da56 with SMTP id 46e09a7af769-71dad5f33bbmr12858019a34.2.1733395087266;
        Thu, 05 Dec 2024 02:38:07 -0800 (PST)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd156f048csm886826a12.39.2024.12.05.02.38.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Dec 2024 02:38:07 -0800 (PST)
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
Subject: [RFC PATCH v2 07/21] riscv: mm: Reimplement page table entry get function
Date: Thu,  5 Dec 2024 18:37:15 +0800
Message-Id: <20241205103729.14798-8-luxu.kernel@bytedance.com>
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

This commit reimplements ptep_get/pmdp_get/... functions. As pte
structures now contains multiple mapping entries, we can not use
READ_ONCE to fetch its value. Instead, we use traditional dereference
way.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/pgtable.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index d3da8aee213c..ba4a083b7210 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -704,6 +704,36 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
 	WRITE_ONCE(*ptep, pteval);
 }
 
+static inline pte_t ptep_get(pte_t *ptep)
+{
+	return *ptep;
+}
+#define ptep_get	ptep_get
+
+static inline pmd_t pmdp_get(pmd_t *pmdp)
+{
+	return *pmdp;
+}
+#define pmdp_get	pmdp_get
+
+static inline pud_t pudp_get(pud_t *pudp)
+{
+	return *pudp;
+}
+#define pudp_get	pudp_get
+
+static inline p4d_t p4dp_get(p4d_t *p4dp)
+{
+	return *p4dp;
+}
+#define p4dp_get	p4dp_get
+
+static inline pgd_t pgdp_get(pgd_t *pgdp)
+{
+	return *pgdp;
+}
+#define pgdp_get	pgdp_get
+
 void flush_icache_pte(struct mm_struct *mm, pte_t pte);
 
 static inline void __set_pte_at(struct mm_struct *mm, pte_t *ptep, pte_t pteval)
-- 
2.20.1


