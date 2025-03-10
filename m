Return-Path: <linux-kernel+bounces-554138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25281A59361
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F513A6ADE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6381AA1F4;
	Mon, 10 Mar 2025 12:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.com header.i=@yandex-team.com header.b="Zt+/vVXD"
Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [178.154.239.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCB8215F49
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 12:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741608265; cv=none; b=QZjh5pKBmiI+U+Bk5wun6qo1K8oRY9XA1xVsP8LFbK3IY/IAaizyFkYiifcWp0Tpxs3OOsNGhKQoMKSHXpH7YFu1AUaNi34RBQ/dkD/lZ4CcF2sGKOgQELis2xl/v/OsxmF6cPkX9LmT+r0eieRhcXtBBBD7IaFW74s9PbbWswM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741608265; c=relaxed/simple;
	bh=gYFjsqXR8gnavjmf/To2k/w9el2VyW5ETtk72eDoBLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJ5zkJOVz6QvhYOggQYJGdG6Gae7xeUJi9X0fF0tRuR4hh8ydpdRFl8PSxU5wYQfB4hvjE182tOmeD9GdJHGUFWHuCr3TGH0bQTmlYXSvT1jOvGXzad9MaXnruyvmiPYn8umZ/gzkUzHIwyBFVR+hvnJl8+AXD4S7Q0h/Uk9MWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.com; spf=pass smtp.mailfrom=yandex-team.com; dkim=pass (1024-bit key) header.d=yandex-team.com header.i=@yandex-team.com header.b=Zt+/vVXD; arc=none smtp.client-ip=178.154.239.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.com
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:600c:0:640:a431:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 5958960DCE;
	Mon, 10 Mar 2025 15:04:08 +0300 (MSK)
Received: from dellarbn.yandex.net (unknown [10.214.35.248])
	by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id s3o0lL2FT0U0-61iTaEl4;
	Mon, 10 Mar 2025 15:04:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
	s=default; t=1741608247;
	bh=dCfHmi7JSqwfRn9hK0doUgOfig37g7tF5ZyIee0j3QQ=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=Zt+/vVXDKpSCu8KDQZJ8u8uEpxL5R4fTTyn3U+HF42BdMdqDXozWrf/zuiX14bZkH
	 oTU0E2qHEUTnKlbABGK7W3Ny4IiGns9mKIZhLDvhYoLMNrAZ/l3Mgu8cIFmpSlrxFX
	 CW2cOcIjkxXIsVbLsjrUPNEkV+dqhsmZyuQeWDOQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net; dkim=pass header.i=@yandex-team.com
From: Andrey Ryabinin <arbn@yandex-team.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Graf <graf@amazon.com>,
	James Gowans <jgowans@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>,
	kexec@lists.infradead.org,
	Pratyush Yadav <ptyadav@amazon.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Rientjes <rientjes@google.com>,
	Andrey Ryabinin <arbn@yandex-team.com>
Subject: [PATCH v2 3/7] kexec: exclude control pages from the destination addresses
Date: Mon, 10 Mar 2025 13:03:14 +0100
Message-ID: <20250310120318.2124-4-arbn@yandex-team.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250310120318.2124-1-arbn@yandex-team.com>
References: <20250310120318.2124-1-arbn@yandex-team.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kexec relies on control pages allocated after all destination ranges
have been chosen. To be able to preserve memory across kexec we need
to be able to pick destination ranges after the control pages
allocated. Add check for control pages to locate_mem_hole() callbacks
so it excludes control pages, hence we can allocate them in any order.

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
---
 kernel/kexec_core.c     | 18 ++++++++++++++++++
 kernel/kexec_file.c     | 18 ++++--------------
 kernel/kexec_internal.h |  3 +++
 3 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index c0bdc1686154..647ab5705c37 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -264,6 +264,24 @@ int kimage_is_destination_range(struct kimage *image,
 	return 0;
 }
 
+int kimage_is_control_page(struct kimage *image,
+			unsigned long start,
+			unsigned long end)
+{
+
+	struct page *page;
+
+	list_for_each_entry(page, &image->control_pages, lru) {
+		unsigned long pstart, pend;
+		pstart = page_to_boot_pfn(page) << PAGE_SHIFT;
+		pend = pstart + PAGE_SIZE * (1 << page_private(page)) - 1;
+		if ((end >= pstart) && (start <= pend))
+			return 1;
+	}
+
+	return 0;
+}
+
 static struct page *kimage_alloc_pages(gfp_t gfp_mask, unsigned int order)
 {
 	struct page *pages;
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index a024ff379133..8ecd34071bfa 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -464,7 +464,8 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 		 * Make sure this does not conflict with any of existing
 		 * segments
 		 */
-		if (kimage_is_destination_range(image, temp_start, temp_end)) {
+		if (kimage_is_destination_range(image, temp_start, temp_end) ||
+			kimage_is_control_page(image, temp_start, temp_end)) {
 			temp_start = temp_start - PAGE_SIZE;
 			continue;
 		}
@@ -498,7 +499,8 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
 		 * Make sure this does not conflict with any of existing
 		 * segments
 		 */
-		if (kimage_is_destination_range(image, temp_start, temp_end)) {
+		if (kimage_is_destination_range(image, temp_start, temp_end) ||
+			kimage_is_control_page(image, temp_start, temp_end)) {
 			temp_start = temp_start + PAGE_SIZE;
 			continue;
 		}
@@ -671,18 +673,6 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
 	if (kbuf->image->nr_segments >= KEXEC_SEGMENT_MAX)
 		return -EINVAL;
 
-	/*
-	 * Make sure we are not trying to add buffer after allocating
-	 * control pages. All segments need to be placed first before
-	 * any control pages are allocated. As control page allocation
-	 * logic goes through list of segments to make sure there are
-	 * no destination overlaps.
-	 */
-	if (!list_empty(&kbuf->image->control_pages)) {
-		WARN_ON(1);
-		return -EINVAL;
-	}
-
 	/* Ensure minimum alignment needed for segments. */
 	kbuf->memsz = ALIGN(kbuf->memsz, PAGE_SIZE);
 	kbuf->buf_align = max(kbuf->buf_align, PAGE_SIZE);
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index d35d9792402d..12e655a70e25 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -14,6 +14,9 @@ int kimage_load_segment(struct kimage *image, struct kexec_segment *segment);
 void kimage_terminate(struct kimage *image);
 int kimage_is_destination_range(struct kimage *image,
 				unsigned long start, unsigned long end);
+int kimage_is_control_page(struct kimage *image,
+			unsigned long start,
+			unsigned long end);
 
 /*
  * Whatever is used to serialize accesses to the kexec_crash_image needs to be
-- 
2.45.3


