Return-Path: <linux-kernel+bounces-431216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE0E9E3A8D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AB3D162167
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E7A1F891C;
	Wed,  4 Dec 2024 12:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6nHUCsJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050A51F7079
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 12:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316910; cv=none; b=bJTqZXHPRC2H/gnj8oK8WHxozz3Fg6p4W6BgpLdABjoMlXxanx9S/1Z9DwJJOC1LR2T/tkM08vQSzs6KLOCeSfWMnMd2g33wrzKIAogolmuUyl1uQeu0Wrh6VhZtigS+WhiSJ1zftq/Act+EE+RQMw4wuxqordQpyKVwtIckgVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316910; c=relaxed/simple;
	bh=GU+EylrtNkBl0PCgVUrji2d7nB4cQuMPE/K3NHw4YGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMAfUbaE3swduQoiz7um/zkgu0JmHYDNVGZdRg4bZcMr2kXz3TWYo8Wm8DZ7nglZMqYQk4FRctTRxuR6qREPBqbK/SnZk57X91BX1fJAvARecpbQNT2uEIwFpvJSuFQKUOcRYpw5voM0GkJ7J1sz0UzpCvrHHtYOkpub/CegNWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O6nHUCsJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733316908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3TMBFu0zsYs/BK8mI3BuEemyVvVnFxsrbDwOUtwonV0=;
	b=O6nHUCsJ7VBy/f4+kT+4tfTdhK/ev61TkwjjZmbff2s2hSLFi7tSIAgK3HtznPqESiFD67
	3GPit59iFITU0dpq2t2encr920VrsREEynoNQas1dY6Twbx1LmfOX6U7FTd0C2wr16YROs
	ko1dwVeLZENjU3yZ0sIbtda2Qki/U44=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-TQ_yofWpPtqI2G39CANC8A-1; Wed, 04 Dec 2024 07:55:07 -0500
X-MC-Unique: TQ_yofWpPtqI2G39CANC8A-1
X-Mimecast-MFC-AGG-ID: TQ_yofWpPtqI2G39CANC8A
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385dfa9b758so2188677f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 04:55:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316906; x=1733921706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3TMBFu0zsYs/BK8mI3BuEemyVvVnFxsrbDwOUtwonV0=;
        b=RdS2mxaF/7VPTuMJ+uKqSH5WztsdBVOvMDUOYh8yiXFCPCCLDrsMRtFViV/OTkYTVe
         y48neI97jgpUmbD5UuYS3uSlAUF7syl8w27auk0Go6Zg9740B5MnB4/jrQZY2Cno/GHu
         qyrCBxMDURn5ymxiZVFEuZL7cCm0kFQwBKFFIkggtk4aoj6pRsd1MDEqSIJQL27sxozB
         EHvn2ovFW3MdKqmv8fHurnjeBkz1pUDWfNv44PpJzFpPdavS6KIbhUicucyFsjvSbEu+
         TZ+CqLI2n+uPlMMpt++ozGdpG4qHod26Gm5H5rNjAidEbefY8cDvzYv7lYXO8FU6WTlp
         JUwA==
X-Gm-Message-State: AOJu0Yxc6PW+mhZFGjv8HdaNHGCb7ym6W7G19SsZGcMRn1wq8hMJ++b2
	YMjXSWrCwpSlPL8CAZLGySqCyiEiowcGTIVLQ+BlPBVFNEbZqXKIi6+yKlF+P8AjxbGDu07qMBQ
	DYdo5dniAbryBG6Mh7JW0PVlXdLE3lb4Mb5qzvsBbrvhu0BK+3tnrOdXE1uv7KbRopDSXxdXeGd
	cWC6qtJxT/B5mNQGhoWwNPKXV5d2DFqQVbyV97eLGDNzze
X-Gm-Gg: ASbGncvaYsmadC5PIbL9m4FwaQOlphH2QDBDjW2x9pcAHNPbxgPp7FmTFAHzcmVaKJ0
	WZtGWZMfEIPHNueGxc9eIzxyjzWI+mn5WnsEP/WZwVoJO8F3LNk218ApoT8w1C+5In0u1H5v3D7
	iUgiUb9MCub+zAoY52HMhDwV3W9wl6ICFBeQnpVoo4R+TOuumX0GLramoFwtn5+f0SLli64baFq
	uoObrzKc0bt/71uVR2rsRYkhghsSCeUa8E5QaPWPD5g/3laci4Fpjsi7HIylaqH1Gb9HcvSxB0N
	Gx4mjlbPwnc+Via/4oJpMeZQsCl50otQ7SA=
X-Received: by 2002:a05:6000:156e:b0:385:fa2e:a33e with SMTP id ffacd0b85a97d-38607c0e1e7mr3561620f8f.43.1733316905828;
        Wed, 04 Dec 2024 04:55:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3Vs5XvVpD9wVjl4Do+O4dwdUFKsmLeUCgsK0LBk5udBDNdRPox9DV3gXL42llKQONJirIJg==
X-Received: by 2002:a05:6000:156e:b0:385:fa2e:a33e with SMTP id ffacd0b85a97d-38607c0e1e7mr3561572f8f.43.1733316905408;
        Wed, 04 Dec 2024 04:55:05 -0800 (PST)
Received: from localhost (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-385ed8dee66sm10241947f8f.104.2024.12.04.04.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:55:04 -0800 (PST)
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
Subject: [PATCH v2 06/12] fs/proc/vmcore: factor out allocating a vmcore range and adding it to a list
Date: Wed,  4 Dec 2024 13:54:37 +0100
Message-ID: <20241204125444.1734652-7-david@redhat.com>
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

Let's factor it out into include/linux/crash_dump.h, from where we can
use it also outside of vmcore.c later.

Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/vmcore.c           | 21 ++-------------------
 include/linux/crash_dump.h | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 8d262017ca11..9b72e255dd03 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -709,11 +709,6 @@ static const struct proc_ops vmcore_proc_ops = {
 	.proc_mmap	= mmap_vmcore,
 };
 
-static struct vmcore_range * __init get_new_element(void)
-{
-	return kzalloc(sizeof(struct vmcore_range), GFP_KERNEL);
-}
-
 static u64 get_vmcore_size(size_t elfsz, size_t elfnotesegsz,
 			   struct list_head *vc_list)
 {
@@ -1116,7 +1111,6 @@ static int __init process_ptload_program_headers_elf64(char *elfptr,
 						size_t elfnotes_sz,
 						struct list_head *vc_list)
 {
-	struct vmcore_range *new;
 	int i;
 	Elf64_Ehdr *ehdr_ptr;
 	Elf64_Phdr *phdr_ptr;
@@ -1139,13 +1133,8 @@ static int __init process_ptload_program_headers_elf64(char *elfptr,
 		end = roundup(paddr + phdr_ptr->p_memsz, PAGE_SIZE);
 		size = end - start;
 
-		/* Add this contiguous chunk of memory to vmcore list.*/
-		new = get_new_element();
-		if (!new)
+		if (vmcore_alloc_add_range(vc_list, start, size))
 			return -ENOMEM;
-		new->paddr = start;
-		new->size = size;
-		list_add_tail(&new->list, vc_list);
 
 		/* Update the program header offset. */
 		phdr_ptr->p_offset = vmcore_off + (paddr - start);
@@ -1159,7 +1148,6 @@ static int __init process_ptload_program_headers_elf32(char *elfptr,
 						size_t elfnotes_sz,
 						struct list_head *vc_list)
 {
-	struct vmcore_range *new;
 	int i;
 	Elf32_Ehdr *ehdr_ptr;
 	Elf32_Phdr *phdr_ptr;
@@ -1182,13 +1170,8 @@ static int __init process_ptload_program_headers_elf32(char *elfptr,
 		end = roundup(paddr + phdr_ptr->p_memsz, PAGE_SIZE);
 		size = end - start;
 
-		/* Add this contiguous chunk of memory to vmcore list.*/
-		new = get_new_element();
-		if (!new)
+		if (vmcore_alloc_add_range(vc_list, start, size))
 			return -ENOMEM;
-		new->paddr = start;
-		new->size = size;
-		list_add_tail(&new->list, vc_list);
 
 		/* Update the program header offset */
 		phdr_ptr->p_offset = vmcore_off + (paddr - start);
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 788a45061f35..9717912ce4d1 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -121,6 +121,20 @@ struct vmcore_range {
 	loff_t offset;
 };
 
+/* Allocate a vmcore range and add it to the list. */
+static inline int vmcore_alloc_add_range(struct list_head *list,
+		unsigned long long paddr, unsigned long long size)
+{
+	struct vmcore_range *m = kzalloc(sizeof(*m), GFP_KERNEL);
+
+	if (!m)
+		return -ENOMEM;
+	m->paddr = paddr;
+	m->size = size;
+	list_add_tail(&m->list, list);
+	return 0;
+}
+
 #else /* !CONFIG_CRASH_DUMP */
 static inline bool is_kdump_kernel(void) { return false; }
 #endif /* CONFIG_CRASH_DUMP */
-- 
2.47.1


