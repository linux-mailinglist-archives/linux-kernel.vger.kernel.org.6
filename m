Return-Path: <linux-kernel+bounces-431222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CDA9E3AD8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3062AB28D86
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F7820C03F;
	Wed,  4 Dec 2024 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T9D+TN+y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B80420C002
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316929; cv=none; b=OQX1GzlrLOrs0dT6YQiPGWQNp7nikuqnnN33bEIYNNB+Vxz2YLzZ81YQG74k3RpfnHz+UpKBmV0VGXmxlqn4svG6xHT2F0w7mrg8BQw3HKjkkW0LQThiZ7yv3Hfvb8kE0efKY1VMfqIhzUQ3tF6SuqPYEeH7DizFqNmk4y8CdzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316929; c=relaxed/simple;
	bh=uRjaOZTjHUvybJWAv9vGsJi33hCxx6hpGz/B8OQ605Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnTQgitynwSkECW810x4yanGuXvCsnsqF8DY+EB2uQJI4NQHoUILURu54nMCDkegLEf7TVSm4KfUT5ccK4irWpz16Dl7pV9Xe4N5H2ZLUfAS7ldUco3C1zhSZNRO4f2cxrK1x9/LSeZ942j+LQNviqXbmuuuuSbSAw2Kubcj8qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T9D+TN+y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733316927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QMLpjiP43p31BywTFNffjh3NzCBHssnVGTYWU2BwGcs=;
	b=T9D+TN+y7duHdT4O6/BdTN0Q7c1DaPX9YpL7IHUOMg0adAYYIAILjwx3ErMs9HujfQsV99
	vUqZV0/TJHqPyW3LUFU42YYbO6FmkYLbm9vfJDgecaChKEzK5uFnP5kr934A63lX+nOiOf
	6lf2a/PmZSlv9QaLG09v29vMT9LC7v0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-VShdZC6WN0qrAMr8sQQP_Q-1; Wed, 04 Dec 2024 07:55:25 -0500
X-MC-Unique: VShdZC6WN0qrAMr8sQQP_Q-1
X-Mimecast-MFC-AGG-ID: VShdZC6WN0qrAMr8sQQP_Q
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4349f32c9a6so55271035e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 04:55:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316924; x=1733921724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMLpjiP43p31BywTFNffjh3NzCBHssnVGTYWU2BwGcs=;
        b=jV7XJOIotPO+UrbFrqzr7B8H6q2ZbRY9aI63upR17DI7qPnZ7+H3ib6dBidygQSLIa
         1elQ1BNx/+pKdXDxR0VwbygW7UyM7wi3nP6Akiosa6VO16qMQ52GmqLAHSawU5xqKQtS
         NS2FtraWUnzTmzqeHfJXva+SAayBqtkIbd4WtVnhHofTCLYPtPY2SMxjACNBYp9naFP5
         i2mJK7UQpOZTGNQHcxmIDwRYETLb0o3W3lbxRQ7/Zq1v9Qyt3mDpQu7mpBJu1hNhlnvv
         ZVSNuqSidugdHyCTTzUfo5qLb5otj32yzPDfvjkiLSNn7+LV+6qjEHf9WIzSA/bkrDLW
         aOVw==
X-Gm-Message-State: AOJu0YwN5khX8uXF66Y/AOoKrQ9mnRCBEuQT4OkxoZiSUwlmVCn+tZaV
	u1Nj8yx7DTorUdxOPTFnaa5nBx6MEm5V4jNk4PvDh2j+eRm2xXrTH5/VOl5sMETC+AAdr9r7v1T
	41bZ+VQerAq3SvHGEcpwQ7CAjGXWoFSc0F2d4PcdTdQEKUdy7hep7m/4+LRRt32UkL2dVN0KSev
	AievTwU3cHQPXlkXZy/gwsweesYErXuULBNzYRHBFvJHr1
X-Gm-Gg: ASbGncsYRvh4Grul/I/HjjlU2Eps9lIoPipLxxlzEpxjPgUrDFNLxFcIR63cUfQUSaD
	a5Rz+b2eKX/ECdLfSd/MH7hBb2byDQAnoZIaiWc6EBnoNy35Mp2m4hYZb2nwNb0uPlfiScq5Mwb
	3gcyrHKUnY9+hCnsGD1paN2TWqmNcg2aN55AbZdT9wluHvcezZVQwDQ6d9IgPINtvH7bVPaYiVs
	2z3FHWtLOjEyNU3zbyY2bfBuK0JLU6H/3nv8Wu4KBLfnFhy8N7OGmtqT418eSsbu/q2VFRTuU6r
	qA0dx4qs4KuKl1JQkveKIsoFAJd2HBRdrv8=
X-Received: by 2002:a05:600c:1910:b0:434:a962:2aa2 with SMTP id 5b1f17b1804b1-434d0a178d4mr49286725e9.33.1733316924515;
        Wed, 04 Dec 2024 04:55:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFzA2SYKI5zve6AhLcTcIqYEQR+M/xeFfejA5VMHPdifDyO5ycBtXVIAK8EC4IQe7u0N0Ewg==
X-Received: by 2002:a05:600c:1910:b0:434:a962:2aa2 with SMTP id 5b1f17b1804b1-434d0a178d4mr49286335e9.33.1733316924087;
        Wed, 04 Dec 2024 04:55:24 -0800 (PST)
Received: from localhost (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-434d52c0bc7sm23531055e9.35.2024.12.04.04.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:55:22 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kexec@lists.infradead.org,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 12/12] s390/kdump: virtio-mem kdump support (CONFIG_PROC_VMCORE_DEVICE_RAM)
Date: Wed,  4 Dec 2024 13:54:43 +0100
Message-ID: <20241204125444.1734652-13-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241204125444.1734652-1-david@redhat.com>
References: <20241204125444.1734652-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's add support for including virtio-mem device RAM in the crash dump,
setting NEED_PROC_VMCORE_DEVICE_RAM, and implementing
elfcorehdr_fill_device_ram_ptload_elf64().

To avoid code duplication, factor out the code to fill a PT_LOAD entry.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/Kconfig             |  1 +
 arch/s390/kernel/crash_dump.c | 39 ++++++++++++++++++++++++++++-------
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 0077969170e8..c230bad7f5cc 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -240,6 +240,7 @@ config S390
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE	if PCI
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK
+	select NEED_PROC_VMCORE_DEVICE_RAM if PROC_VMCORE
 	select NEED_SG_DMA_LENGTH	if PCI
 	select OLD_SIGACTION
 	select OLD_SIGSUSPEND3
diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index cd0c93a8fb8b..f699df2a2b11 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -508,6 +508,19 @@ static int get_mem_chunk_cnt(void)
 	return cnt;
 }
 
+static void fill_ptload(Elf64_Phdr *phdr, unsigned long paddr,
+		unsigned long vaddr, unsigned long size)
+{
+	phdr->p_type = PT_LOAD;
+	phdr->p_vaddr = vaddr;
+	phdr->p_offset = paddr;
+	phdr->p_paddr = paddr;
+	phdr->p_filesz = size;
+	phdr->p_memsz = size;
+	phdr->p_flags = PF_R | PF_W | PF_X;
+	phdr->p_align = PAGE_SIZE;
+}
+
 /*
  * Initialize ELF loads (new kernel)
  */
@@ -520,14 +533,8 @@ static void loads_init(Elf64_Phdr *phdr, bool os_info_has_vm)
 	if (os_info_has_vm)
 		old_identity_base = os_info_old_value(OS_INFO_IDENTITY_BASE);
 	for_each_physmem_range(idx, &oldmem_type, &start, &end) {
-		phdr->p_type = PT_LOAD;
-		phdr->p_vaddr = old_identity_base + start;
-		phdr->p_offset = start;
-		phdr->p_paddr = start;
-		phdr->p_filesz = end - start;
-		phdr->p_memsz = end - start;
-		phdr->p_flags = PF_R | PF_W | PF_X;
-		phdr->p_align = PAGE_SIZE;
+		fill_ptload(phdr, start, old_identity_base + start,
+			    end - start);
 		phdr++;
 	}
 }
@@ -537,6 +544,22 @@ static bool os_info_has_vm(void)
 	return os_info_old_value(OS_INFO_KASLR_OFFSET);
 }
 
+#ifdef CONFIG_PROC_VMCORE_DEVICE_RAM
+/*
+ * Fill PT_LOAD for a physical memory range owned by a device and detected by
+ * its device driver.
+ */
+void elfcorehdr_fill_device_ram_ptload_elf64(Elf64_Phdr *phdr,
+		unsigned long long paddr, unsigned long long size)
+{
+	unsigned long old_identity_base = 0;
+
+	if (os_info_has_vm())
+		old_identity_base = os_info_old_value(OS_INFO_IDENTITY_BASE);
+	fill_ptload(phdr, paddr, old_identity_base + paddr, size);
+}
+#endif
+
 /*
  * Prepare PT_LOAD type program header for kernel image region
  */
-- 
2.47.1


