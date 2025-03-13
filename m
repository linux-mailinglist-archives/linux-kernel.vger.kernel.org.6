Return-Path: <linux-kernel+bounces-559102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 436EEA5EF95
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A70F23B695C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AA52641D5;
	Thu, 13 Mar 2025 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoIAmTp/"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EF7261398;
	Thu, 13 Mar 2025 09:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741858222; cv=none; b=RUmgXW/oWS5ntjQihsmo5DTIm3IU23yFiJXAfZnJH/c7GQQEbeFMSZdpgiLk0pbrbjnYrazi9bz3dcDsTMJwbIktUH4cKfrnPO6i9vDqdZcH/pDdoU1/Krgp+dPcXJEgNCHbu5ZZ5lvZ38pmLM0txRl0mTcwoYAcmzLRHSxKSO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741858222; c=relaxed/simple;
	bh=IEbeEm6SMfl6Wht9xaKZE9nrf6n4ucdZFe7nG/YqkAE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DeHhmmX4mYuPbJyZupMvBb4rK1H/Ra1ti3Y/4iAc554kzv9fs/eAak+z/THEAKP+rfjYckuejsn9rSWcbWQ/JM2Sh7V6ReKX+IzDznF1lqvlY4Nr0wkgqZV95Z1pwtqhsO+pP3vBXfmeIBQQ323nEbPHXzfuLIiFr/4nA5km7lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XoIAmTp/; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-223fb0f619dso13069785ad.1;
        Thu, 13 Mar 2025 02:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741858219; x=1742463019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DF1eXiWA++7dVvFQ387XbvvBNFJ2uiLqvlepOnibQqU=;
        b=XoIAmTp/KSGQ2achieh9/ZwTKI2LXhAnIqFhgmrnBfyEUcoYzyPNvRPziktJaqx2Sc
         300tuXkc5TQS652Wq8ef/IUCyEr1zAcKVDmHyUsEMhrIMTTNSH6BcYCuIw7H/FfQ/lFE
         5skfDG9ycCcndrp5zMUsJPLmIUzu8Imna6imn1Ru/jhE6IXB3vLe0GG66r7iwRHBLMTd
         aWnVQrO1UIAUcVStWV/CG10mjtrCmF3t/C4LLgI/nFdjTzosNAAoRbRHiR070IZCRqRh
         8AJefRKVIID06n1n1F8x/mexLAFliMvLQUO3fqAlq6YWrGYsb4spLcAxX/4JzP1hdWIE
         E97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741858219; x=1742463019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DF1eXiWA++7dVvFQ387XbvvBNFJ2uiLqvlepOnibQqU=;
        b=RxD1nXp5x39gjtN0EHZ5T998vlLF12oAhU4JOY9uZXVO5huGwcv5g5kfPT+2BVS8QH
         JkOAykDhpM944t0c+dgDlZNkosDc7oTVOUqbQuMlnri6l3HpkAfuHRY/MJfB2jHx2G6q
         oeTeHNfju4TsSXvnbhzEBbCNglkoFuIuswpiOcmGscT27lLZmBvgU4GcPEmR6QDqUkF9
         uGNKDZu8JohgfVSSGkQF6NjPTB8X1SFqjRBHzj3lR6Y6VEaLTq4HM1B2z9zHpLxo3lqn
         vxnQAOQofkks1Cz8jka4DEHyJuUw7zKt+iPxKXOgqsCvjoaMdEaXFeGNDvw1Bj2pbDtU
         VV8A==
X-Forwarded-Encrypted: i=1; AJvYcCVDg8KAn2WX43S0p2t+VllG6J2EJv+Nvwr40nNbDYCTBc8Y+v/zA6LeBZhRakRWuT/PGwMHptLaTE1z2A==@vger.kernel.org, AJvYcCVmA4DAjP8/bXAAafW05jWNSCrunFU4hz80h8aZmVkUlJcd//X6IdiQPOpBlRMmxGKVH1CXzZX9bwSiKUG+@vger.kernel.org
X-Gm-Message-State: AOJu0YweDGGOlqTwuCJY6HgcZkPxx+656ow043KjeEtBuNvoxSfJXg+X
	qKnj5Sgm4HZo5UzHKCTq0H40n+R9/gM8HTKymCon5jc/FuiQB986
X-Gm-Gg: ASbGncv2sRdHjk510MmAGF8yoqN5ODkeDMPqllBSwuS6F6mrehrlxxPNT0TyM+5IZQ6
	hQYFqYbNnUpoRjwAyHjmbyyxDRDNYKTC+3zF5otO2SCd6Zjm8IaiA/EjfJj1SwuoLkCAY99+dPD
	80GFLDyaitChngQfB2n4lDZRLda34c43eULJAUAwJRD/M4A8AK6rbmB3zS3bIOP8jApRn76gx/X
	jColE8NkJ4MIrVepDRaLsGs5WnXxL2HjFSSd8zhMGH54IY4BkBZRmNHUM+pO+VtXtRdmgw5E/o8
	df+bXAY6EpEaT3xhqb8g6kdGIf/IvbxYtUuHiJEAGGAdk2il+A+MSwpGTTX7wg==
X-Google-Smtp-Source: AGHT+IENeSJ/IswzZ3DorkAIV3dT3SU4Nhv66RaT71103q97yi/XYFYo7f6+vWyZvR7l0in1am2n/w==
X-Received: by 2002:a05:6a00:194c:b0:730:79bf:c893 with SMTP id d2e1a72fcca58-736eb7a0176mr14602942b3a.4.1741858218860;
        Thu, 13 Mar 2025 02:30:18 -0700 (PDT)
Received: from Barrys-MBP.hub ([118.92.30.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711694e34sm927243b3a.140.2025.03.13.02.30.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Mar 2025 02:30:18 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: minchan@kernel.org,
	qun-wei.lin@mediatek.com,
	senozhatsky@chromium.org,
	nphamcs@gmail.com
Cc: 21cnbao@gmail.com,
	akpm@linux-foundation.org,
	andrew.yang@mediatek.com,
	angelogioacchino.delregno@collabora.com,
	axboe@kernel.dk,
	casper.li@mediatek.com,
	chinwen.chang@mediatek.com,
	chrisl@kernel.org,
	dan.j.williams@intel.com,
	dave.jiang@intel.com,
	ira.weiny@intel.com,
	james.hsu@mediatek.com,
	kasong@tencent.com,
	linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-mm@kvack.org,
	matthias.bgg@gmail.com,
	nvdimm@lists.linux.dev,
	ryan.roberts@arm.com,
	schatzberg.dan@gmail.com,
	viro@zeniv.linux.org.uk,
	vishal.l.verma@intel.com,
	ying.huang@intel.com
Subject: Re: [PATCH 0/2] Improve Zram by separating compression context from kswapd
Date: Thu, 13 Mar 2025 22:30:05 +1300
Message-Id: <20250313093005.13998-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <CAGsJ_4yw17rLJPgS6CNXfXNVQnv2pf0PnLSA4UVAR1sUWDhP5Q@mail.gmail.com>
References: <CAGsJ_4yw17rLJPgS6CNXfXNVQnv2pf0PnLSA4UVAR1sUWDhP5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Mar 13, 2025 at 4:52 PM Barry Song <21cnbao@gmail.com> wrote:
>
> On Thu, Mar 13, 2025 at 4:09 PM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > On (25/03/12 11:11), Minchan Kim wrote:
> > > On Fri, Mar 07, 2025 at 08:01:02PM +0800, Qun-Wei Lin wrote:
> > > > This patch series introduces a new mechanism called kcompressd to
> > > > improve the efficiency of memory reclaiming in the operating system. The
> > > > main goal is to separate the tasks of page scanning and page compression
> > > > into distinct processes or threads, thereby reducing the load on the
> > > > kswapd thread and enhancing overall system performance under high memory
> > > > pressure conditions.
> > > >
> > > > Problem:
> > > >  In the current system, the kswapd thread is responsible for both
> > > >  scanning the LRU pages and compressing pages into the ZRAM. This
> > > >  combined responsibility can lead to significant performance bottlenecks,
> > > >  especially under high memory pressure. The kswapd thread becomes a
> > > >  single point of contention, causing delays in memory reclaiming and
> > > >  overall system performance degradation.
> > >
> > > Isn't it general problem if backend for swap is slow(but synchronous)?
> > > I think zram need to support asynchrnous IO(can do introduce multiple
> > > threads to compress batched pages) and doesn't declare it's
> > > synchrnous device for the case.
> >
> > The current conclusion is that kcompressd will sit above zram,
> > because zram is not the only compressing swap backend we have.
>
> also. it is not good to hack zram to be aware of if it is kswapd
> , direct reclaim , proactive reclaim and block device with
> mounted filesystem.
>
> so i am thinking sth as below
>
> page_io.c
>
> if (sync_device or zswap_enabled())
>    schedule swap_writepage to a separate per-node thread
>

Hi Qun-wei, Nhat, Sergey and Minchan,

I managed to find some time to prototype a kcompressd that supports
both zswap and zram, though it has only been build-tested.

Hi Qun-wei,

Apologies, but I’m quite busy with other tasks and don’t have time to
debug or test it. Please feel free to test it. When you submit v2, you’re
welcome to keep yourself as the author of the patch as v1.

If you’re okay with it, you can also add me as a co-developer in the
changelog. The below prototype, I'd rather start with a per-node thread
approach. While this might not provide the greatest benefit, it carries
the least risk and helps avoid complex questions, such as how to
determine the number of threads. - And we have actually observed a
significant reduction in allocstall by using a single thread to
asynchronously handle kswapd's compression as I reported.

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index dbb0ad69e17f..4f9ee2fb338d 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -23,6 +23,7 @@
 #include <linux/page-flags.h>
 #include <linux/local_lock.h>
 #include <linux/zswap.h>
+#include <linux/kfifo.h>
 #include <asm/page.h>
 
 /* Free memory management - zoned buddy allocator.  */
@@ -1389,6 +1390,11 @@ typedef struct pglist_data {
 
 	int kswapd_failures;		/* Number of 'reclaimed == 0' runs */
 
+#define KCOMPRESS_FIFO_SIZE 256
+	wait_queue_head_t kcompressd_wait;
+	struct task_struct *kcompressd;
+	struct kfifo kcompress_fifo;
+
 #ifdef CONFIG_COMPACTION
 	int kcompactd_max_order;
 	enum zone_type kcompactd_highest_zoneidx;
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 281802a7a10d..8cd143f59e76 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1410,6 +1410,7 @@ static void __meminit pgdat_init_internals(struct pglist_data *pgdat)
 	pgdat_init_kcompactd(pgdat);
 
 	init_waitqueue_head(&pgdat->kswapd_wait);
+	init_waitqueue_head(&pgdat->kcompressd_wait);
 	init_waitqueue_head(&pgdat->pfmemalloc_wait);
 
 	for (i = 0; i < NR_VMSCAN_THROTTLE; i++)
diff --git a/mm/page_io.c b/mm/page_io.c
index 4bce19df557b..7bbd14991ffb 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -233,6 +233,33 @@ static void swap_zeromap_folio_clear(struct folio *folio)
 	}
 }
 
+static bool swap_sched_async_compress(struct folio *folio)
+{
+	struct swap_info_struct *sis = swp_swap_info(folio->swap);
+	int nid = numa_node_id();
+	pg_data_t *pgdat = NODE_DATA(nid);
+
+	if (unlikely(!pgdat->kcompressd))
+		return false;
+
+	if (!current_is_kswapd())
+		return false;
+
+	if (!folio_test_anon(folio))
+		return false;
+	/*
+	 * This case needs to synchronously return AOP_WRITEPAGE_ACTIVATE
+	 */
+	if (!mem_cgroup_zswap_writeback_enabled(folio_memcg(folio)))
+		return false;
+
+	sis = swp_swap_info(folio->swap);
+	if (zswap_is_enabled() || data_race(sis->flags & SWP_SYNCHRONOUS_IO))
+		return kfifo_in(&pgdat->kcompress_fifo, folio, sizeof(folio));
+
+	return false;
+}
+
 /*
  * We may have stale swap cache pages in memory: notice
  * them here and get rid of the unnecessary final write.
@@ -275,6 +302,15 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
 		 */
 		swap_zeromap_folio_clear(folio);
 	}
+
+	/*
+	 * Compression within zswap and zram might block rmap, unmap
+	 * of both file and anon pages, try to do compression async
+	 * if possible
+	 */
+	if (swap_sched_async_compress(folio))
+		return 0;
+
 	if (zswap_store(folio)) {
 		count_mthp_stat(folio_order(folio), MTHP_STAT_ZSWPOUT);
 		folio_unlock(folio);
@@ -289,6 +325,38 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
 	return 0;
 }
 
+int kcompressd(void *p)
+{
+	pg_data_t *pgdat = (pg_data_t *)p;
+	struct folio *folio;
+	struct writeback_control wbc = {
+		.sync_mode = WB_SYNC_NONE,
+		.nr_to_write = SWAP_CLUSTER_MAX,
+		.range_start = 0,
+		.range_end = LLONG_MAX,
+		.for_reclaim = 1,
+	};
+
+	while (!kthread_should_stop()) {
+		wait_event_interruptible(pgdat->kcompressd_wait,
+				!kfifo_is_empty(&pgdat->kcompress_fifo));
+
+		if (kthread_should_stop())
+			break;
+		while(!kfifo_is_empty(&pgdat->kcompress_fifo)) {
+			if (kfifo_out(&pgdat->kcompress_fifo, &folio, sizeof(folio))) {
+				if (zswap_store(folio)) {
+					count_mthp_stat(folio_order(folio), MTHP_STAT_ZSWPOUT);
+					folio_unlock(folio);
+					return 0;
+				}
+				__swap_writepage(folio, &wbc);
+			}
+		}
+	}
+	return 0;
+}
+
 static inline void count_swpout_vm_event(struct folio *folio)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
diff --git a/mm/swap.h b/mm/swap.h
index 0abb68091b4f..38d61c6a06f1 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -21,6 +21,7 @@ static inline void swap_read_unplug(struct swap_iocb *plug)
 void swap_write_unplug(struct swap_iocb *sio);
 int swap_writepage(struct page *page, struct writeback_control *wbc);
 void __swap_writepage(struct folio *folio, struct writeback_control *wbc);
+int kcompressd(void *p);
 
 /* linux/mm/swap_state.c */
 /* One swap address space for each 64M swap space */
@@ -198,6 +199,11 @@ static inline int swap_zeromap_batch(swp_entry_t entry, int max_nr,
 	return 0;
 }
 
+static inline int kcompressd(void *p)
+{
+	return 0;
+}
+
 #endif /* CONFIG_SWAP */
 
 #endif /* _MM_SWAP_H */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2bc740637a6c..ba0245b74e45 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7370,6 +7370,7 @@ unsigned long shrink_all_memory(unsigned long nr_to_reclaim)
 void __meminit kswapd_run(int nid)
 {
 	pg_data_t *pgdat = NODE_DATA(nid);
+	int ret;
 
 	pgdat_kswapd_lock(pgdat);
 	if (!pgdat->kswapd) {
@@ -7383,7 +7384,23 @@ void __meminit kswapd_run(int nid)
 		} else {
 			wake_up_process(pgdat->kswapd);
 		}
+		ret = kfifo_alloc(&pgdat->kcompress_fifo,
+				KCOMPRESS_FIFO_SIZE * sizeof(struct folio *),
+				GFP_KERNEL);
+		if (ret)
+			goto out;
+		pgdat->kcompressd = kthread_create_on_node(kcompressd, pgdat, nid,
+				"kcompressd%d", nid);
+		if (IS_ERR(pgdat->kcompressd)) {
+			pr_err("Failed to start kcompressd on node %d，ret=%ld\n",
+					nid, PTR_ERR(pgdat->kcompressd));
+			pgdat->kcompressd = NULL;
+			kfifo_free(&pgdat->kcompress_fifo);
+		} else {
+			wake_up_process(pgdat->kcompressd);
+		}
 	}
+out:
 	pgdat_kswapd_unlock(pgdat);
 }
 
@@ -7402,6 +7419,11 @@ void __meminit kswapd_stop(int nid)
 		kthread_stop(kswapd);
 		pgdat->kswapd = NULL;
 	}
+	if (pgdat->kcompressd) {
+		kthread_stop(pgdat->kcompressd);
+		pgdat->kcompressd = NULL;
+		kfifo_free(&pgdat->kcompress_fifo);
+	}
 	pgdat_kswapd_unlock(pgdat);
 }
 

> btw,  ran the current patchset with one thread(not default 4)
> on phones and saw 50%+ allocstall reduction. so the idea
> looks like a good direction to go.
>

Thanks
Barry

