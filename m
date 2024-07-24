Return-Path: <linux-kernel+bounces-260967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A068593B107
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34E531F244B6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 12:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B796D1586DB;
	Wed, 24 Jul 2024 12:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxauoBC6"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6372B1E488
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 12:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721825193; cv=none; b=ovUAdYZbPZFij9sgbzworpLLh8FcxsC504BzjkgYjBDCXIrC3zkSY1hNam6e9/EGVdFU0OTl7vJjn5oW7E16y5lq/+4DRzG9Cxfzh2RhQnNxqTRIhgHPnqDbH99vrU2fIb52U+n2PAE6RgFDcWV+21499KTOwXcXi85ppsIcJ8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721825193; c=relaxed/simple;
	bh=0AZhu1CqSlcr+8oQ3C7NJ/hTzRyRuEdil+y/O+4HUBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aSZHHgMWXVxnS1x+xTgbrB4lCZ9wr0nDf8MC/Xp4y1HJavun9rOVmex5RH6t4juZmYYac3HOn8nboTgCaEtMy22demUA9e8Tq15IZPYryqYXSR5kPA8AW8NtHc4emhENyUX5W3ILwnaCtY7tjiwE/+lt+GZ7g8yozghmlf0N5Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxauoBC6; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7163489149eso1260435a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 05:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721825191; x=1722429991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBJWQ1t6QCM1T5bdDmDCHfCfTpW6DNC9TA/sHMK/e6E=;
        b=LxauoBC6Er15pmsfcgHzVPi/fqsIqHDRap4ioVFGYyzkd+lFUC8G0A4Wql2+5vdz5W
         Pm7jm8XsMRV/xSAQCiPJ0NORujANswwUA7x4TuHCTBfOPGp1q+SwmSTukaRKuzM31NmI
         6LnmI8QDC8SaRW0uzUbq2JXQo8sb3dcpCZajImomAAAWw/omrHtxfJe/88sCyoOsWZ6i
         iT9ycNMeXXtdn+9170mHA1Rb4plJZdm32NMm9Kvtk4mcrD2Mtjkm5EmDBtND7bDeZgog
         oDglTMVAUQHdIO0H9qNpn+s4UzY7Ef4NvWMnd2yCioXEzltbHGWPF6Fcz3GpOgf7PyPk
         JqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721825191; x=1722429991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBJWQ1t6QCM1T5bdDmDCHfCfTpW6DNC9TA/sHMK/e6E=;
        b=IqkuvThJpsY8w8MPqEr3LtxdGIySu9GsLYB3mG6aQuZfKajYbEdRVXrIH2QD3FUWJY
         IOowApTMSMsK7JH0Tbryw8R0OeL0zGusakatpqgP5p3P66uYc17rLJUCpdpOyK92IChT
         Oal5FCYZT9p//OEkQfbbwcxYwOOdbL6LSFuExevaBzNvizPGc2e+gjj9AchsYhbMuKNy
         9eXrdoMgtN+5Q/ulmzM/VSRLw9Cep+60+i/L6P4cQ0ByaTQuBxSJujhDRsPdnzRd+Dsr
         2xX+rTx5P1emEx23GUUgFHCLuEX/bU7it3LovXiJtKz6pT+NTnp0uTVvTtjj9nPYcaCc
         YWTQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2Cv0sdSqqBfgAxNU7gvcKUx+g04CXbrsXKJOBOvyLtm2N4Gtv4qlNpx2S0DpaLjW35dZK6X91VmFJ1LQYWj4EZQn90XW0f4Qb+Zhs
X-Gm-Message-State: AOJu0YyPeY/STui36iYo2WKngU2lsE9HiWOXztxZw2Oc3mciYus4t3B5
	MIN4uhXhT5TwGjjruMtzAZvjFEM5o+Yd4O0dsBgOHLd39axhxX2n
X-Google-Smtp-Source: AGHT+IH6M0HvSoPJFLKPUL5jhfc+xNB6S7usqtaEDwG6DOU1XH4t2Wf/WLzP9XxIEsHXMbYpzciKtA==
X-Received: by 2002:a05:6a21:9989:b0:1c3:b1b3:75cf with SMTP id adf61e73a8af0-1c45e5d127fmr3556808637.14.1721825190542;
        Wed, 24 Jul 2024 05:46:30 -0700 (PDT)
Received: from AHUANG12-3ZHH9X.lenovo.com (220-143-182-11.dynamic-ip.hinet.net. [220.143.182.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f28bc6fsm92998615ad.65.2024.07.24.05.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 05:46:30 -0700 (PDT)
From: Adrian Huang <adrianhuang0701@gmail.com>
X-Google-Original-From: Adrian Huang <ahuang12@lenovo.com>
To: urezki@gmail.com
Cc: adrianhuang0701@gmail.com,
	ahuang12@lenovo.com,
	akpm@linux-foundation.org,
	hch@infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	peterz@infradead.org,
	sunjw10@lenovo.com
Subject: Re: [PATCH 1/1] mm/vmalloc: Add preempt point in purge_vmap_node() when enabling kasan
Date: Wed, 24 Jul 2024 20:46:24 +0800
Message-Id: <20240724124624.27673-1-ahuang12@lenovo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Zp-K_A60DjlDhlRt@pc636>
References: <Zp-K_A60DjlDhlRt@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> It works great and does not generate the soft-lock-up splat :)
> See below some comments:

Great. Thanks for the confirmation.

<snip>

>> +     kasan_release_vmalloc(start, end, start, end, KASAN_VMALLOC_TLB_FLUSH);
>> +
>>
> Do we need it here? We just did the TLB flush for en entire range in the
> __purge_vmap_area_lazy(). So, it is two times invoked and looks odd to me.
>
> Am i missing something?

1. The TLB flush for the entire range in __purge_vmap_area_lazy() is for
the vmalloc virtual address (VMALLOC_START->VMALLOC_END).

2. The TLB flush in purge_vmap_node() is for the KASAN shadow virtual address 
(the shadow offset 'CONFIG_KASAN_SHADOW_OFFSET' is defined in .config).

BTW, I found my first patch has the potential risk. We need to flush TLB of
the KASAN shadow virtual address firstly. Please see the following patch for
detail. (I put the comment in the following patch). The following patch
also works well on my 256-core machine.

If you're ok with the patch, I'll submit it for upstream review. And, may I
have your tag(s): tested-by/reviewed-by? (If possible, could you please have
a test for the following patch).

Thanks.

---
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 70d6a8f6e25d..ddbf42a1a7b7 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -55,6 +55,9 @@ extern p4d_t kasan_early_shadow_p4d[MAX_PTRS_PER_P4D];
 int kasan_populate_early_shadow(const void *shadow_start,
 				const void *shadow_end);
 
+#define KASAN_VMALLOC_PAGE_RANGE 0x1 /* Apply exsiting page range */
+#define KASAN_VMALLOC_TLB_FLUSH  0x2 /* TLB flush */
+
 #ifndef kasan_mem_to_shadow
 static inline void *kasan_mem_to_shadow(const void *addr)
 {
@@ -511,7 +514,8 @@ void kasan_populate_early_vm_area_shadow(void *start, unsigned long size);
 int kasan_populate_vmalloc(unsigned long addr, unsigned long size);
 void kasan_release_vmalloc(unsigned long start, unsigned long end,
 			   unsigned long free_region_start,
-			   unsigned long free_region_end);
+			   unsigned long free_region_end,
+			   unsigned long flags);
 
 #else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
 
@@ -526,7 +530,8 @@ static inline int kasan_populate_vmalloc(unsigned long start,
 static inline void kasan_release_vmalloc(unsigned long start,
 					 unsigned long end,
 					 unsigned long free_region_start,
-					 unsigned long free_region_end) { }
+					 unsigned long free_region_end,
+					 unsigned long flags) { }
 
 #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
 
@@ -561,7 +566,8 @@ static inline int kasan_populate_vmalloc(unsigned long start,
 static inline void kasan_release_vmalloc(unsigned long start,
 					 unsigned long end,
 					 unsigned long free_region_start,
-					 unsigned long free_region_end) { }
+					 unsigned long free_region_end,
+					 unsigned long flags) { }
 
 static inline void *kasan_unpoison_vmalloc(const void *start,
 					   unsigned long size,
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index d6210ca48dda..88d1c9dcb507 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -489,7 +489,8 @@ static int kasan_depopulate_vmalloc_pte(pte_t *ptep, unsigned long addr,
  */
 void kasan_release_vmalloc(unsigned long start, unsigned long end,
 			   unsigned long free_region_start,
-			   unsigned long free_region_end)
+			   unsigned long free_region_end,
+			   unsigned long flags)
 {
 	void *shadow_start, *shadow_end;
 	unsigned long region_start, region_end;
@@ -522,12 +523,17 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
 			__memset(shadow_start, KASAN_SHADOW_INIT, shadow_end - shadow_start);
 			return;
 		}
-		apply_to_existing_page_range(&init_mm,
+
+
+		if (flags & KASAN_VMALLOC_PAGE_RANGE)
+			apply_to_existing_page_range(&init_mm,
 					     (unsigned long)shadow_start,
 					     size, kasan_depopulate_vmalloc_pte,
 					     NULL);
-		flush_tlb_kernel_range((unsigned long)shadow_start,
-				       (unsigned long)shadow_end);
+
+		if (flags & KASAN_VMALLOC_TLB_FLUSH)
+			flush_tlb_kernel_range((unsigned long)shadow_start,
+					       (unsigned long)shadow_end);
 	}
 }
 
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index e34ea860153f..12cdc92cdb83 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2193,8 +2193,22 @@ static void purge_vmap_node(struct work_struct *work)
 	struct vmap_area *va, *n_va;
 	LIST_HEAD(local_list);
 
+	unsigned long start;
+	unsigned long end;
+
 	vn->nr_purged = 0;
 
+	start = list_first_entry(&vn->purge_list, struct vmap_area, list)->va_start;
+
+	end = list_last_entry(&vn->purge_list, struct vmap_area, list)->va_end;
+
+	/*
+	 * Since node_pool_add_va() returns vmap_area(s) to its pool, the
+	 * returned vmap_area(s) might be grabbed immediately via node_alloc()
+	 * by other core. We need to flush TLB firstly.
+	 */
+	kasan_release_vmalloc(start, end, start, end, KASAN_VMALLOC_TLB_FLUSH);
+
 	list_for_each_entry_safe(va, n_va, &vn->purge_list, list) {
 		unsigned long nr = (va->va_end - va->va_start) >> PAGE_SHIFT;
 		unsigned long orig_start = va->va_start;
@@ -2205,7 +2219,8 @@ static void purge_vmap_node(struct work_struct *work)
 
 		if (is_vmalloc_or_module_addr((void *)orig_start))
 			kasan_release_vmalloc(orig_start, orig_end,
-					      va->va_start, va->va_end);
+					      va->va_start, va->va_end,
+					      KASAN_VMALLOC_PAGE_RANGE);
 
 		atomic_long_sub(nr, &vmap_lazy_nr);
 		vn->nr_purged++;
@@ -4726,7 +4741,8 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 				&free_vmap_area_list);
 		if (va)
 			kasan_release_vmalloc(orig_start, orig_end,
-				va->va_start, va->va_end);
+				va->va_start, va->va_end,
+				KASAN_VMALLOC_PAGE_RANGE | KASAN_VMALLOC_TLB_FLUSH);
 		vas[area] = NULL;
 	}
 
@@ -4776,7 +4792,8 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 				&free_vmap_area_list);
 		if (va)
 			kasan_release_vmalloc(orig_start, orig_end,
-				va->va_start, va->va_end);
+				va->va_start, va->va_end,
+				KASAN_VMALLOC_PAGE_RANGE | KASAN_VMALLOC_TLB_FLUSH);
 		vas[area] = NULL;
 		kfree(vms[area]);
 	}

