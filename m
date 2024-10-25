Return-Path: <linux-kernel+bounces-382001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8C59B0797
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B1B4B23ED8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86155167D80;
	Fri, 25 Oct 2024 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LebQPXrf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B66B165F04
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 15:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729869139; cv=none; b=kf4fN3y+O0sSVS72Hpc3MNJTOCauomwPqE7ChraZqySrhsrS4OS7zhDoqjDgneB/w35vaq+fvy2RjXxJvaXi26x0fw4maEm3TKJXMMdN38+zmid/s0SiZnjxcV/dQR6Y+DAz0RjKcf7ZPXsvJJ8EDzE3QwxxPdkSCsBKsLJZDm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729869139; c=relaxed/simple;
	bh=B7PrUz5VAdfRkpHKAqsUYQXPd2NhJV/DByAXCQR//kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gCPLH4PkA55LWEmsJ02cu0L5GNaUNpqKDMGzqdJG2wyWbFNavP0+sD0fo/58eNuz98QcDRXA29y4DpFc6t3R59LUpQ/BZ8cK+BkmGV6W8k170jS3/BCmRKz2edn1rzzW+oHse/ooFaLu5Stslv+2FT24LR9g/4TyLqxwnRIEcXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LebQPXrf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729869136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RBGqG14Ir1TauPvJbSz3jQOA9+mQRgCc4BCTlJgnkuA=;
	b=LebQPXrfVL7RSUI6S2s+LGqKXscTgYneJrnx4c/I5q/gEVhCzhrdnbAhCOprfYv0ccMju+
	r7CMfgXrdYWtyZQdbyET0Th/KkD0wvPNz2wvtqq6gnjp3aDMVS5PMPhSN9aGMVzdyl8A6U
	leZv7uzOou8K8J8wjH7uMCXy01ocINU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-pkIUU_7mPiOuJegdS3U3rg-1; Fri,
 25 Oct 2024 11:12:13 -0400
X-MC-Unique: pkIUU_7mPiOuJegdS3U3rg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C5211955F43;
	Fri, 25 Oct 2024 15:12:10 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.65.27])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AF463300018D;
	Fri, 25 Oct 2024 15:12:02 +0000 (UTC)
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
Subject: [PATCH v1 03/11] fs/proc/vmcore: disallow vmcore modifications after the vmcore was opened
Date: Fri, 25 Oct 2024 17:11:25 +0200
Message-ID: <20241025151134.1275575-4-david@redhat.com>
In-Reply-To: <20241025151134.1275575-1-david@redhat.com>
References: <20241025151134.1275575-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Let's protect all vmcore modifications by the vmcore_mutex and
disallow vmcore modifications after the vmcore was opened: modifications
would no longer be safe. Properly synchronize against concurrent opening
of the vmcore.

As a nice side-effect, we now properly protect concurrent vmcore
modifications.

No need to grab the mutex during mmap()/read(): after we opened the
vmcore, modifications are impossible.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/vmcore.c | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index b91c304463c9..6371dbaa21be 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -243,33 +243,27 @@ static int vmcoredd_copy_dumps(struct iov_iter *iter, u64 start, size_t size)
 {
 	struct vmcoredd_node *dump;
 	u64 offset = 0;
-	int ret = 0;
 	size_t tsz;
 	char *buf;
 
-	mutex_lock(&vmcore_mutex);
 	list_for_each_entry(dump, &vmcoredd_list, list) {
 		if (start < offset + dump->size) {
 			tsz = min(offset + (u64)dump->size - start, (u64)size);
 			buf = dump->buf + start - offset;
-			if (copy_to_iter(buf, tsz, iter) < tsz) {
-				ret = -EFAULT;
-				goto out_unlock;
-			}
+			if (copy_to_iter(buf, tsz, iter) < tsz)
+				return -EFAULT;
 
 			size -= tsz;
 			start += tsz;
 
 			/* Leave now if buffer filled already */
 			if (!size)
-				goto out_unlock;
+				return 0;
 		}
 		offset += dump->size;
 	}
 
-out_unlock:
-	mutex_unlock(&vmcore_mutex);
-	return ret;
+	return 0;
 }
 
 #ifdef CONFIG_MMU
@@ -278,20 +272,16 @@ static int vmcoredd_mmap_dumps(struct vm_area_struct *vma, unsigned long dst,
 {
 	struct vmcoredd_node *dump;
 	u64 offset = 0;
-	int ret = 0;
 	size_t tsz;
 	char *buf;
 
-	mutex_lock(&vmcore_mutex);
 	list_for_each_entry(dump, &vmcoredd_list, list) {
 		if (start < offset + dump->size) {
 			tsz = min(offset + (u64)dump->size - start, (u64)size);
 			buf = dump->buf + start - offset;
 			if (remap_vmalloc_range_partial(vma, dst, buf, 0,
-							tsz)) {
-				ret = -EFAULT;
-				goto out_unlock;
-			}
+							tsz))
+				return -EFAULT;
 
 			size -= tsz;
 			start += tsz;
@@ -299,14 +289,12 @@ static int vmcoredd_mmap_dumps(struct vm_area_struct *vma, unsigned long dst,
 
 			/* Leave now if buffer filled already */
 			if (!size)
-				goto out_unlock;
+				return 0;
 		}
 		offset += dump->size;
 	}
 
-out_unlock:
-	mutex_unlock(&vmcore_mutex);
-	return ret;
+	return 0;
 }
 #endif /* CONFIG_MMU */
 #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
@@ -1482,6 +1470,10 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
 		return -EINVAL;
 	}
 
+	/* We'll recheck under lock later. */
+	if (data_race(vmcore_opened))
+		return -EBUSY;
+
 	if (!data || !strlen(data->dump_name) ||
 	    !data->vmcoredd_callback || !data->size)
 		return -EINVAL;
@@ -1515,12 +1507,16 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
 	dump->buf = buf;
 	dump->size = data_size;
 
-	/* Add the dump to driver sysfs list */
+	/* Add the dump to driver sysfs list and update the elfcore hdr */
 	mutex_lock(&vmcore_mutex);
-	list_add_tail(&dump->list, &vmcoredd_list);
-	mutex_unlock(&vmcore_mutex);
+	if (vmcore_opened) {
+		ret = -EBUSY;
+		goto out_err;
+	}
 
+	list_add_tail(&dump->list, &vmcoredd_list);
 	vmcoredd_update_size(data_size);
+	mutex_unlock(&vmcore_mutex);
 	return 0;
 
 out_err:
-- 
2.46.1


