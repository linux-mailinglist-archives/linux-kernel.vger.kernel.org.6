Return-Path: <linux-kernel+bounces-554140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4666A59364
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4931E16C7A4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D42175D53;
	Mon, 10 Mar 2025 12:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.com header.i=@yandex-team.com header.b="x72TBAYJ"
Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [178.154.239.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CAA221556
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 12:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741608279; cv=none; b=JjzDMrwmY2BKDsLTfgn4WXSU04Pl1V5B140UPaPAAthJJyQu+0jJ2FTWp3oSbXw78oZRHHtG+6imtK247TxkSxdcjxshFV66QCeEfiYHwP02J1ztbpIYQ7SidtA1EBpI/7KnZ2otrjGOOS2q723EX+bB5LJfOo0ZUELYXRSPBqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741608279; c=relaxed/simple;
	bh=ZiV9jUv1hl43mTkUHz7sC932CxLq046Mkxz7ZY1uga4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CdumMiVLBOpJDKD8rYSvPvq+Sv9zj6kNthHP6+IiV+QCogAPenkxBYMZO1sgUXrUK8TDPD7iUHvXmngEDulubvIF2Fpswzu/6sc1LRGNxg+EPiy9L1GsulUTllED+3yURqBIqp4ssl6DqrmCVvkDJSGV+gfkE4hl/9PYqBHGEK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.com; spf=pass smtp.mailfrom=yandex-team.com; dkim=pass (1024-bit key) header.d=yandex-team.com header.i=@yandex-team.com header.b=x72TBAYJ; arc=none smtp.client-ip=178.154.239.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.com
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:600c:0:640:a431:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id A80A160E06;
	Mon, 10 Mar 2025 15:04:10 +0300 (MSK)
Received: from dellarbn.yandex.net (unknown [10.214.35.248])
	by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id s3o0lL2FT0U0-3q4ic3FI;
	Mon, 10 Mar 2025 15:04:09 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
	s=default; t=1741608250;
	bh=C5c3jBE2oO6bqhBgG572MhRimfpuB96f90y0qeqDqaE=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=x72TBAYJRosfJkV7QqfGY6QJIW4ozXZqVj+oHuUpLHNMH2cZMJvUt085RbtBwN2x+
	 d7TAjQWgFTsAD4ThVtRq38Oxh4sxvtZW/C5NJi3+wwzfXsmGrTOuJh6TQNaT1lZGRs
	 bX2YRijLOeTBrqHRVuYuRUt4MkNUCTd9QMpWNxT4=
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
Subject: [PATCH v2 4/7] kexec, kstate: delay loading of kexec segments
Date: Mon, 10 Mar 2025 13:03:15 +0100
Message-ID: <20250310120318.2124-5-arbn@yandex-team.com>
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

KSTATE's purpose is to preserve some memory across kexec. To make this
happen kexec needs to choose destination ranges after the KSTATE, so
these ranges doesn't collide with KSTATE preserved memory.

Kexec chooses destination ranges on the kexec load stage which might
happen long before the actual reboot to the new kernel. This means that
KSTATE must know all preserved memory before the kexec_file_load(), unless
we delay loading of kexec segments/destination addresses to the latter,
at the point of reboot to the new kernel. So let's do that.

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
---
 include/linux/kexec.h   |   1 +
 kernel/kexec_core.c     |   6 ++
 kernel/kexec_file.c     | 144 ++++++++++++++++++++++++++--------------
 kernel/kexec_internal.h |   6 ++
 4 files changed, 108 insertions(+), 49 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index bd82f04888a1..539aaacfd3fd 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -377,6 +377,7 @@ extern void machine_kexec(struct kimage *image);
 extern int machine_kexec_prepare(struct kimage *image);
 extern void machine_kexec_cleanup(struct kimage *image);
 extern int kernel_kexec(void);
+extern int kexec_file_load_segments(struct kimage *image);
 extern struct page *kimage_alloc_control_pages(struct kimage *image,
 						unsigned int order);
 
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 647ab5705c37..7c79addeb93b 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1017,6 +1017,12 @@ int kernel_kexec(void)
 		goto Unlock;
 	}
 
+	if (kexec_late_load(kexec_image)) {
+		error = kexec_file_load_segments(kexec_image);
+		if (error)
+			goto Unlock;
+	}
+
 #ifdef CONFIG_KEXEC_JUMP
 	if (kexec_image->preserve_context) {
 		/*
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 8ecd34071bfa..634e2ed4cc4c 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -187,6 +187,34 @@ kimage_validate_signature(struct kimage *image)
 }
 #endif
 
+static int kimage_add_buffers(struct kimage *image)
+{
+	void *ldata;
+	int ret = 0;
+
+	/* IMA needs to pass the measurement list to the next kernel. */
+	ima_add_kexec_buffer(image);
+
+	ret = kstate_load_migrate_buf(image);
+	if (ret)
+		goto out;
+
+	/* Call image load handler */
+	ldata = kexec_image_load_default(image);
+
+	if (IS_ERR(ldata)) {
+		ret = PTR_ERR(ldata);
+		goto out;
+	}
+
+	image->image_loader_data = ldata;
+out:
+	/* In case of error, free up all allocated memory in this function */
+	if (ret)
+		kimage_file_post_load_cleanup(image);
+	return ret;
+
+}
 /*
  * In file mode list of segments is prepared by kernel. Copy relevant
  * data from user space, do error checking, prepare segment list
@@ -197,7 +225,6 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 			     unsigned long cmdline_len, unsigned flags)
 {
 	ssize_t ret;
-	void *ldata;
 
 	ret = kernel_read_file_from_fd(kernel_fd, 0, &image->kernel_buf,
 				       KEXEC_FILE_SIZE_MAX, NULL,
@@ -251,22 +278,6 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 				  image->cmdline_buf_len - 1);
 	}
 
-	/* IMA needs to pass the measurement list to the next kernel. */
-	ima_add_kexec_buffer(image);
-
-	ret = kstate_load_migrate_buf(image);
-	if (ret)
-		goto out;
-
-	/* Call image load handler */
-	ldata = kexec_image_load_default(image);
-
-	if (IS_ERR(ldata)) {
-		ret = PTR_ERR(ldata);
-		goto out;
-	}
-
-	image->image_loader_data = ldata;
 out:
 	/* In case of error, free up all allocated memory in this function */
 	if (ret)
@@ -303,10 +314,6 @@ kimage_file_alloc_init(struct kimage **rimage, int kernel_fd,
 	if (ret)
 		goto out_free_image;
 
-	ret = sanity_check_segment_list(image);
-	if (ret)
-		goto out_free_post_load_bufs;
-
 	ret = -ENOMEM;
 	image->control_code_page = kimage_alloc_control_pages(image,
 					   get_order(KEXEC_CONTROL_PAGE_SIZE));
@@ -334,6 +341,70 @@ kimage_file_alloc_init(struct kimage **rimage, int kernel_fd,
 	return ret;
 }
 
+static int kimage_post_load(struct kimage *image)
+{
+	int ret, i;
+
+	ret = kexec_calculate_store_digests(image);
+	if (ret)
+		goto out;
+
+	kexec_dprintk("nr_segments = %lu\n", image->nr_segments);
+	for (i = 0; i < image->nr_segments; i++) {
+		struct kexec_segment *ksegment;
+
+		ksegment = &image->segment[i];
+		kexec_dprintk("segment[%d]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
+			      i, ksegment->buf, ksegment->bufsz, ksegment->mem,
+			      ksegment->memsz);
+
+		ret = kimage_load_segment(image, &image->segment[i]);
+		if (ret)
+			goto out;
+	}
+
+	kimage_terminate(image);
+
+	ret = machine_kexec_post_load(image);
+	if (ret)
+		goto out;
+
+	kexec_dprintk("kexec_file_load: type:%u, start:0x%lx head:0x%lx\n",
+		image->type, image->start, image->head);
+out:
+	return ret;
+}
+
+int kexec_file_load_segments(struct kimage *image)
+{
+	int ret;
+
+	ret = kimage_add_buffers(image);
+	if (ret) {
+		pr_err("failed to add kimage buffers %d\n", ret);
+		goto out;
+	}
+
+	ret = sanity_check_segment_list(image);
+	if (ret) {
+		pr_err("sanity check failed %d\n", ret);
+		goto out;
+	}
+
+	ret = kimage_post_load(image);
+	if (ret)
+		pr_err("kimage post load failed %d\n", ret);
+
+out:
+	/*
+	 * Free up any temporary buffers allocated which are not needed
+	 * after image has been loaded
+	 */
+	kimage_file_post_load_cleanup(image);
+
+	return ret;
+}
+
 SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 		unsigned long, cmdline_len, const char __user *, cmdline_ptr,
 		unsigned long, flags)
@@ -341,7 +412,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	int image_type = (flags & KEXEC_FILE_ON_CRASH) ?
 			 KEXEC_TYPE_CRASH : KEXEC_TYPE_DEFAULT;
 	struct kimage **dest_image, *image;
-	int ret = 0, i;
+	int ret = 0;
 
 	/* We only trust the superuser with rebooting the system. */
 	if (!kexec_load_permitted(image_type))
@@ -398,37 +469,12 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	if (ret)
 		goto out;
 
-	ret = kexec_calculate_store_digests(image);
-	if (ret)
-		goto out;
-
-	kexec_dprintk("nr_segments = %lu\n", image->nr_segments);
-	for (i = 0; i < image->nr_segments; i++) {
-		struct kexec_segment *ksegment;
-
-		ksegment = &image->segment[i];
-		kexec_dprintk("segment[%d]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
-			      i, ksegment->buf, ksegment->bufsz, ksegment->mem,
-			      ksegment->memsz);
-
-		ret = kimage_load_segment(image, &image->segment[i]);
+	if (!kexec_late_load(image)) {
+		ret = kexec_file_load_segments(image);
 		if (ret)
 			goto out;
 	}
 
-	kimage_terminate(image);
-
-	ret = machine_kexec_post_load(image);
-	if (ret)
-		goto out;
-
-	kexec_dprintk("kexec_file_load: type:%u, start:0x%lx head:0x%lx flags:0x%lx\n",
-		      image->type, image->start, image->head, flags);
-	/*
-	 * Free up any temporary buffers allocated which are not needed
-	 * after image has been loaded
-	 */
-	kimage_file_post_load_cleanup(image);
 exchange:
 	image = xchg(dest_image, image);
 out:
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index 12e655a70e25..690b1c21b642 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -34,6 +34,12 @@ static inline void kexec_unlock(void)
 	atomic_set_release(&__kexec_lock, 0);
 }
 
+static inline bool kexec_late_load(struct kimage *image)
+{
+	return IS_ENABLED(CONFIG_KSTATE) && image->file_mode &&
+		(image->type == KEXEC_TYPE_DEFAULT);
+}
+
 #ifdef CONFIG_KEXEC_FILE
 #include <linux/purgatory.h>
 void kimage_file_post_load_cleanup(struct kimage *image);
-- 
2.45.3


