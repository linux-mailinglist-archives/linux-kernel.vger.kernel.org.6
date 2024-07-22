Return-Path: <linux-kernel+bounces-258913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAD9938E67
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 13:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C414CB2143B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955C616D318;
	Mon, 22 Jul 2024 11:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W17zyZbA"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E081EB56
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721649061; cv=none; b=g38v1oy5wvCn9/8ygYQdMmvc8eYMeydVeG9JMH74Kjdw7wGwZ6ayxq6+TQytfR0g31NOEdRkpyqqgsLiMkoeruT/xeTyze7b6wrIKPwS4pAB4z2KB8/bEaKKU4ZgaO0CGjTZ23ejjw/iBfBAaOBriFyeXmMQzSHSJxBXFtLO96Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721649061; c=relaxed/simple;
	bh=700qVXS0V2Jn6WOE47RwatrzOdG1JEBkgis4GO9Q9dM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jH5PKBaslPP975cHZlwpF+5iaRGzB8jxECDumbkn5kIw8BauoL1HuBH1UNlVYIceOOkzguQN08sa/IaCtLTl4A1uiG3AkSJFuBsEyRAsxrPDu5vgoOlOxXCatGZ7z6jxKHU1CMQ3SM9jVCTdk4rdVPWRTAH5hKLFUnM2EZ2oJF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W17zyZbA; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc5549788eso32180525ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 04:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721649059; x=1722253859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHBpaWmjrNZ1mUi3zmdyGdS7Vt8ZJEl138881JB/3WE=;
        b=W17zyZbAyqqPJbozD4hFI1icJTj6boWXcs12UY9sGB7znPyopJS+AHdZbw4HU6Wb6H
         bUBVLyBhosUArEDoRsovfXIcQwOCvCF1B/H56kyJVFB8m2SKWSA7DJU5uUCcjpQMGlzn
         A3eLLHWknMHLphNHiFo5w8qemLr3eKG7M8Ra+anA2j6L0hhl0OvEEgpWbCJxNNEccke4
         89EQy1IkNDjrUy6vk5E0rwQh9b2Yh61J3RDNRlotRtZ1CVeqUAfg9PBGd8PaTDs/pMi5
         OOKPRKd7KMq1KKlEa8zu89T+zr/BhQjOPJV8VOx9bI3VoWJCBVRAP7HF1kIF9Q7Sh1Gz
         XL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721649059; x=1722253859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHBpaWmjrNZ1mUi3zmdyGdS7Vt8ZJEl138881JB/3WE=;
        b=hqXswu1JoReFIBgEE/Cd/N0u7HNkZIXdMj+EqPdJS/eGj3KCHIGmv9QD8uUn8p5/Ts
         kt+6mQxTTmD1NzowUBUluld6uP/hwtSLW/CH/C3Q96LpBMkeIl57GDsOYIzT/80YGig7
         VeqdS7bwedfx3mxgWQ5hu5cBJkjRvg13+TK3ssmyKQl7t51pCVgjzyQTTawxSGyo+jNz
         vnxfZIXM28fT6f6jtyNkvE51y+rORZo+b5FEt+o7cxdrJKcYciSFFMXDkuZ8Q3KFXLDU
         IDuhj3HXmEpVsY5hoAWbvw3+k1B+faW1LmDhiA0Y8l2HSac5Fmx9yv+yqGw7pMy0IHQK
         FvtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOZmhrb2w3HBOErqP7gNj6ElO/PqkSUhXP3r7YrEWPy0k/raHvECTetdQYMBVPS6g5ntBjU5IwFV7z/Y5s6EBxQ4U144E0oQhbNpn6
X-Gm-Message-State: AOJu0YzL2yoqARjmYdqLXFscz33ahn+ASBxl6hA3YyFPC5PK0BThXXTh
	KTXtJ86BmQtWy0Q8otDd0pgun2ysZXFiNNI8nyYITZs2I6Qg0x05
X-Google-Smtp-Source: AGHT+IHf3hRl4FiSWjZFHAamQpDN+8F/4VMWm5wuICul3s3cWrt4/hEksQasE1z/shg3fFpyhRBlZA==
X-Received: by 2002:a17:903:2444:b0:1fc:a869:7fb7 with SMTP id d9443c01a7336-1fd746230d6mr62249525ad.54.1721649059129;
        Mon, 22 Jul 2024 04:50:59 -0700 (PDT)
Received: from AHUANG12-3ZHH9X.lenovo.com (220-143-182-11.dynamic-ip.hinet.net. [220.143.182.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f452c5csm52749525ad.234.2024.07.22.04.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 04:50:58 -0700 (PDT)
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
Date: Mon, 22 Jul 2024 19:50:54 +0800
Message-Id: <20240722115054.6295-1-ahuang12@lenovo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZppQo7Biyg5Yc0Ai@pc636>
References: <ZppQo7Biyg5Yc0Ai@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I tried to simulate the reported splat and i can reproduce it with KASAN
> enabled. I use qemu on my 64-core system, it allows me to specify 255
> cores while running VM. The kernel is 6.10.0-rc5.
>
> The kernel should be built with CONFIG_KASAN=y and CONFIG_KASAN_VMALLOC=y
>
> The "soft lockup" can be triggered when the kernel is compiled within a
> VM using 256 jobs and preemption is disabled:
>
> echo none > /sys/kernel/debug/sched/preempt
> make -C coding/linux.git/ -j256 bzImage
>
> <snip>
> watchdog: BUG: soft lockup - CPU#28 stuck for 22s! [kworker/28:1:1760]
> CPU: 28 PID: 1760 Comm: kworker/28:1 Kdump: loaded Not tainted 6.10.0-rc5 #95
> Workqueue: events drain_vmap_area_work
> RIP: 0010:smp_call_function_many_cond+0x1d8/0xbb0
> ...
> <snip>

Great to hear you're able to reproduce the issue.

I keep debugging, and the original patch (https://lore.kernel.org/all/ZogS_04dP5LlRlXN@pc636/T/) shows purge_vmap_node() iteratively releases kasan vmalloc
allocations and flushes tlb for each vmap_area. There are 2805
flush_tlb_kernel_range() calls in ftrace log.
  * One is called in __purge_vmap_area_lazy().
  * Others are called in kasan_release_vmalloc(): Called by purge_vmap_node().
    - [Rough calculation] Each flush_tlb_kernel_range() runs about 7.5ms.
      -- 2804 * 7.5ms = 21.03 seconds (That's why a soft lock is trigger)

If we combine all tlb flush operations into one operation in the call path
'purge_vmap_node()->kasan_release_vmalloc()', the running time of
drain_vmap_area_work() can be saved greately. The idea is from the
flush_tlb_kernel_range() call in __purge_vmap_area_lazy().
And, the soft lockup won't not be triggered. Please refer to the following patch.
Here is the test result based on 6.10:

[6.10 wo/ the patch below]
  1. ftrace latency profiling (record a trace if the latency > 20s): Commands
     echo 20000000 > /sys/kernel/debug/tracing/tracing_thresh
     echo drain_vmap_area_work > /sys/kernel/debug/tracing/set_graph_function
     echo function_graph > /sys/kernel/debug/tracing/current_tracer
     echo 1 > /sys/kernel/debug/tracing/tracing_on

  2. Run `make -j $(nproc)` to compile the kernel source

  3. Once the soft lockup is reproduced, check the ftace:
     cat /sys/kernel/debug/tracing/trace
        # tracer: function_graph
        #
        # CPU  DURATION                  FUNCTION CALLS
        # |     |   |                     |   |   |   |
          76) $ 50412985 us |    } /* __purge_vmap_area_lazy */
          76) $ 50412997 us |  } /* drain_vmap_area_work */
          76) $ 29165911 us |    } /* __purge_vmap_area_lazy */
          76) $ 29165926 us |  } /* drain_vmap_area_work */
          91) $ 53629423 us |    } /* __purge_vmap_area_lazy */
          91) $ 53629434 us |  } /* drain_vmap_area_work */
          91) $ 28121014 us |    } /* __purge_vmap_area_lazy */
          91) $ 28121026 us |  } /* drain_vmap_area_work */


[6.10 w/ the patch below]
  1. Repeat step 1-2 in "[6.10 wo/ the patch below]"

  2. The soft lockup is not triggered and the ftrace log is empty.
     cat /sys/kernel/debug/tracing/trace
     # tracer: function_graph
     #
     # CPU  DURATION                  FUNCTION CALLS
     # |     |   |                     |   |   |   |


  3. Setting 'tracing_thresh' to 10/5 seconds does not get any ftrace log.

  4. Setting 'tracing_thresh' to 1 second gets ftrace log.
      cat /sys/kernel/tracing/trace
      # tracer: function_graph
      #
      # CPU  DURATION                  FUNCTION CALLS
      # |     |   |                     |   |   |   |
        51) $ 1019695 us  |    } /* __purge_vmap_area_lazy */
        51) $ 1019703 us  |  } /* drain_vmap_area_work */
       198) $ 1018707 us  |    } /* __purge_vmap_area_lazy */
       198) $ 1018718 us  |  } /* drain_vmap_area_work */

  5. Run the following test_vmalloc command without any issues
     modprobe test_vmalloc nr_threads=$(nproc) run_test_mask=0x1 nr_pages=4

Could you please test this patch in your VM environment? 

---
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 70d6a8f6e25d..ddbf42a1a7b7 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -55,6 +55,9 @@ extern p4d_t kasan_early_shadow_p4d[MAX_PTRS_PER_P4D];
 int kasan_populate_early_shadow(const void *shadow_start,
 				const void *shadow_end);
 
+#define KASAN_VMALLOC_PAGE_RANGE 0x1 /* Apply existing page range */
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
index e34ea860153f..d66e09135876 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2193,8 +2193,15 @@ static void purge_vmap_node(struct work_struct *work)
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
 	list_for_each_entry_safe(va, n_va, &vn->purge_list, list) {
 		unsigned long nr = (va->va_end - va->va_start) >> PAGE_SHIFT;
 		unsigned long orig_start = va->va_start;
@@ -2205,7 +2212,8 @@ static void purge_vmap_node(struct work_struct *work)
 
 		if (is_vmalloc_or_module_addr((void *)orig_start))
 			kasan_release_vmalloc(orig_start, orig_end,
-					      va->va_start, va->va_end);
+					      va->va_start, va->va_end,
+					      KASAN_VMALLOC_PAGE_RANGE);
 
 		atomic_long_sub(nr, &vmap_lazy_nr);
 		vn->nr_purged++;
@@ -2218,6 +2226,8 @@ static void purge_vmap_node(struct work_struct *work)
 		list_add(&va->list, &local_list);
 	}
 
+	kasan_release_vmalloc(start, end, start, end, KASAN_VMALLOC_TLB_FLUSH);
+
 	reclaim_list_global(&local_list);
 }
 
@@ -4726,7 +4736,8 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 				&free_vmap_area_list);
 		if (va)
 			kasan_release_vmalloc(orig_start, orig_end,
-				va->va_start, va->va_end);
+				va->va_start, va->va_end,
+				KASAN_VMALLOC_PAGE_RANGE | KASAN_VMALLOC_TLB_FLUSH);
 		vas[area] = NULL;
 	}
 
@@ -4776,7 +4787,8 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 				&free_vmap_area_list);
 		if (va)
 			kasan_release_vmalloc(orig_start, orig_end,
-				va->va_start, va->va_end);
+				va->va_start, va->va_end,
+				KASAN_VMALLOC_PAGE_RANGE | KASAN_VMALLOC_TLB_FLUSH);
 		vas[area] = NULL;
 		kfree(vms[area]);
 	}

