Return-Path: <linux-kernel+bounces-530463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A09A4A433CE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 04:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F506189DB01
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 03:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D11A1624F8;
	Tue, 25 Feb 2025 03:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XqQAFeu9"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B411A2A1BA
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 03:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740455192; cv=none; b=nvp55GG4AhjmTSCEsE5sZi0Nlu1xmwLF2HOP67xeLAjfdomQFmXUO84yJ5PJR6NWIPQ173t2wL3idYJ/MsTpxZYT0vsUdhChG7B+g1f2z/CswN8j2E79wcV8XEQ+akdczZKgdndAB3wibrIXsGiyLHXIDb9qe5Sg5LjsOXlQnkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740455192; c=relaxed/simple;
	bh=+Ao5l71m8R2KBR4pKhSeuqtrK/FFUTZNCirhHcI/U+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JUGsPdja6mspN3CgfHoxUwh+kezv4a/Qz5hiMRjI/L7bAyi4oU/v3pUh0CoOTXXXE9qQCMuXLifRiLvlhnSNaalO1Rldj162cMStBWJlciuYMLqpYpfivcBkgI6+WMrGkBf0cuMLR3ggQ1XpdPww6YZhlZ1/zdKn7q106qYm5Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XqQAFeu9; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220e989edb6so139802035ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740455189; x=1741059989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0Ocxe5/W3x8AaSNUp1nmQA6Ns9xuyK5JD/uD9z0OJg=;
        b=XqQAFeu9+jAY7gKK2np4vO4g91b9uWMd/6TX7uoukDIaD/obEG/vESFDxfKesdbDoM
         DUhZSnz6YFmvEDmpJ/nWXcwRcGca7LDIIKRDNxDtW2hjagjoenxWRFn4/kcvQXf3ACwl
         zJDVmBz48yBwHLGQMaHqSbxVJmbCZbQdfveZIEfNlYxG/y799JFM4vRo7yeCq+nhdKP1
         Q+5kr2LA3g3RrNO2bmwI2bN4c50lMhba78Jbd+BDEVb4CwQBNN9S1j46EM/7O6ZtGOUC
         k7tXgspl9UxEDV8bfxvY+EQ3QwjNTMjGgtNLzJafFP4GWzb1jmwV2nUqgBedoxCyHI37
         fAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740455189; x=1741059989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0Ocxe5/W3x8AaSNUp1nmQA6Ns9xuyK5JD/uD9z0OJg=;
        b=Fcm4JB5nAToJj0ninWQ2UwVwYFQ+E5BbQewtE958J/JxMsf0oLv2tPkVtb1RSWtvZJ
         VL8IrRJEjHXIoc26otHEe66xABpYzbQubzQnXTjmzI10CuJNgzftnEW9ThvSdCY7Mnoh
         oLgdgoBQtG9yWrrjQcreIIiKF3ensvN/YfAAh0BCvMddpuf+HGCqRdPYZUc5G6GWN4Ip
         loIrGsy7t4EMZBKNKr6fgIHLrcDIEX0ehSaMlCUpv6e9fB5WyAMdOJdCA3sQX/VjTLU8
         BJEcM197sifREK5mSLCUU+XgsdCG2fscesf8GVMR34FNCfkTH8Q1yU4Ze1W0wbMhFnkW
         fmcg==
X-Forwarded-Encrypted: i=1; AJvYcCUJVg6sh0jvH7Kpr92cLuR+r3E5wRf5DxLZOPShZVzdDzk7voiwQgyc53OgLVZ6u0Hkvmj5IxBoF3R0SM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh1f2g+mZ+NP6NKECaXo4fZQLD1l9rdAjiDTzhYgBXmq1SYPi9
	6Ys2n/vzata/M1BwlCyNkZMg8Ch+oJ7Y/pfW0JBMQbhNAnNIAqhPXjgQfQwTTMiN/5KLFb+8bEz
	3
X-Gm-Gg: ASbGnctppqsVh2qyM77LVzxyzGAO0kZihzwgRosvL7raOQr0efxAA7x5RSjDZ/L+7yU
	K8bt4BikZ07oMGBCZRT2fT4FaBJjJRfYTWeUlv0l0sto554zgiVq2QA0OYSFTRT/kbviL40G5N3
	iLb1rYZUX3p3uUCmm8yoT+tghbNlc5e475fK5NiDKcyEyKsuiKKAlObJmaoeGMFHdfepNZdt2D6
	NTGM/yx2NURr1cNWWzk9mDlQu1YwRKXwGT6DmzOlOlYzY1S1h6sLSbvbQqoCkb1iSxsCvoRSTyi
	RJOENDPWzN1J4WIMItv+ThJ6NyCWXsF5BQ9sBaO7o7xHhhEr8++nopzZxb6RBhF05A==
X-Google-Smtp-Source: AGHT+IGBfXw23ytiI6FvQDqnu6HA+6X81xKlY5Cdi/AJkyrR2YGvsG8wye6vZ+K3tNu1qHLJYKOiEg==
X-Received: by 2002:a05:6a00:22c9:b0:731:771:38f2 with SMTP id d2e1a72fcca58-734790de607mr3427312b3a.8.1740455188892;
        Mon, 24 Feb 2025 19:46:28 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a81f014sm409429b3a.156.2025.02.24.19.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:46:28 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	kevin.brodsky@arm.com,
	riel@surriel.com,
	vishal.moola@gmail.com,
	david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	willy@infradead.org,
	yuzhao@google.com,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	arnd@arndb.de,
	dave.hansen@linux.intel.com,
	rppt@kernel.org,
	alexghiti@rivosinc.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	linux-riscv@lists.infradead.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 1/6] mm: pgtable: make generic tlb_remove_table() use struct ptdesc
Date: Tue, 25 Feb 2025 11:45:51 +0800
Message-Id: <5be8c3ab7bd68510bf0db4cf84010f4dfe372917.1740454179.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1740454179.git.zhengqi.arch@bytedance.com>
References: <cover.1740454179.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now only arm will call tlb_remove_ptdesc()/tlb_remove_table() when
CONFIG_MMU_GATHER_TABLE_FREE is disabled. In this case, the type of the
table parameter is actually struct ptdesc * instead of struct page *.

Since struct ptdesc still overlaps with struct page and has not been
separated from it, forcing the table parameter to struct page * will not
cause any problems at this time. But this is definitely incorrect and
needs to be fixed. So just like the generic __tlb_remove_table(), let
generic tlb_remove_table() use struct ptdesc by default when
CONFIG_MMU_GATHER_TABLE_FREE is disabled.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/asm-generic/tlb.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index b35b36fa7aabf..54f579750c8e5 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -232,10 +232,10 @@ static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page);
  */
 static inline void tlb_remove_table(struct mmu_gather *tlb, void *table)
 {
-	struct page *page = (struct page *)table;
+	struct ptdesc *ptdesc = (struct ptdesc *)table;
 
-	pagetable_dtor(page_ptdesc(page));
-	tlb_remove_page(tlb, page);
+	pagetable_dtor(ptdesc);
+	tlb_remove_page(tlb, ptdesc_page(ptdesc));
 }
 #endif /* CONFIG_MMU_GATHER_TABLE_FREE */
 
-- 
2.20.1


