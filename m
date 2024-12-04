Return-Path: <linux-kernel+bounces-431212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CAC9E3A7C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D87282DDF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599471DE4E1;
	Wed,  4 Dec 2024 12:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GONRlE/S"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B1F1CDA09
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 12:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316899; cv=none; b=GwNA6xmR1NOma/02ves7mmOVd4j5oZvWgjdokWzULHkGKNHQbgXd82m5I3uCe3CCqOqZwzrj5Dt5R3mvKxgm9y+MQ0i5F4qxwHUBTh6MoGYc+TN+hCsImhdQFNH8Vd+s3hKI185CUReajsu3nOEop62nbjXOQl7yXjcU/79WP8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316899; c=relaxed/simple;
	bh=WdYleG7wq0/QsvZ4l+B0SUHHNWJZ0MpP6g4l1w+mx3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KkFaAaEbxPjByrbjrUk6NIs9EzhfKGijqSaISJuVwqr5PAS6pqi1VXQSl+NtQcoDy4Cs6tH1G+6/xPEYrtWtMgY6K+HRRtKJOXiEVRZ2QJ0xmuMLWEiSseSCNa0cyfRyxv6rJ6Aj7ujQe6nCNPwTZF+/ppAcsbhSIiGi+ootyZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GONRlE/S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733316897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EkAK23ba+nOdc62V3txwBduSNZiyWl3c9gCUE/mLOOA=;
	b=GONRlE/SeF+2FdZTlHIAGz3oa4X62vGXtccTLntozzWin1ZloS1WP/FtH82HyeQNMFhr+K
	imh3spkMNNfPoS/IsDa/y7f5trLhBuNcMd43KvT8bBBDcZUGFQ7vAV0zmyn2cCjEI4wEen
	R6UrHOhlrQPUBu21EKBLHcSPba7Gg1o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-_2h_Eqk1MHS8nF9oiV4Ezw-1; Wed, 04 Dec 2024 07:54:55 -0500
X-MC-Unique: _2h_Eqk1MHS8nF9oiV4Ezw-1
X-Mimecast-MFC-AGG-ID: _2h_Eqk1MHS8nF9oiV4Ezw
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3860bc1d4f1so379796f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 04:54:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316894; x=1733921694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EkAK23ba+nOdc62V3txwBduSNZiyWl3c9gCUE/mLOOA=;
        b=GJ4WpZ0N5vlPVzBEECcOxo4Rar/60C6FGFx30UDpKu78nKxT5IgYmOQOIsPmjB32oz
         E3mrjwzh5G0jQTgX3k9EscExohL6e5z++VGyh8RQiZYly1Zbob/SkVPtHIot+BKvIpCz
         t63IUHePGJ6UF0xksoCKooWviyIG/r1fNbmic/xB3aDiFsqr29qvyciYLSqVvI6jUTWU
         1pk6sW82felGWpmxdXDSPYqXN8FPuHA02V/eu6Ha3MgBBrxgF2apQcScrUa/mv9C/agK
         pwdqKNCA0PscA8RhtNSmBft0iOXWnmq+U0b05x84OqROK3cbYgn/Y7GlCqXm68/yjjxC
         3Lew==
X-Gm-Message-State: AOJu0YyN3JS5cMNlqrmFpPxuhcK71UZUNIaY5WUvC5E11LHKGpYBlIyI
	lBDVkJRUYsBd5MahFJ6tn13i1V1HN/7m5QsRN/RDjQfr3sVmlD9ib/fnTFSHOEvxB7htlAkO90a
	QwDcEU470kBC+gYfcOK0E2buyEZYJvp521/dB6EROpc5SdLX81vuZwFAyTNGJsSSlqh+9l1nFnc
	NAMsQTu3Q4WEnbW4FtA7YrjaaJbVUqMsGcEm27xrEcAyT0
X-Gm-Gg: ASbGnctPrAQ8YmZvrHbd8MAQzTXS+RrODghrPvJJZgvtlKzFLyhlU4cQKjXbQEnFATa
	SmroF9wamGvIUZPG1NtZrG40QccMp9HLBd60G6Eo2+mWdp+vldsNUSBUS5j/RzUi91uTU+ZMeNW
	mk7V/K7zjdZIRgIc7S2GC/JZQ8lrDMsZ7Whov8PvWi1PTUAxDZ4Izfr7s2n4mxdZjjww79Vvevm
	BxkmWTn0ZpcNDwCr+jQzJYeYhRnWBlXOfOgCr0BKdZQCGkVx9wzNzGwr+INTofvOovXt/7aCwK+
	SESxgwe7MWQ6etsqw+20qAVWR9ozG7HCYvM=
X-Received: by 2002:a05:6000:1847:b0:385:ecdf:a30a with SMTP id ffacd0b85a97d-385fd3ee334mr5400398f8f.33.1733316893994;
        Wed, 04 Dec 2024 04:54:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvdtkWkEwxi8mpcTLDx5Tk+eqhyWjoc+BX5ypLCUE7CH8mOKCeowIphEqt4hXFtq1npl/2WQ==
X-Received: by 2002:a05:6000:1847:b0:385:ecdf:a30a with SMTP id ffacd0b85a97d-385fd3ee334mr5400356f8f.33.1733316893544;
        Wed, 04 Dec 2024 04:54:53 -0800 (PST)
Received: from localhost (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-434d52c12a4sm23880495e9.30.2024.12.04.04.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:54:52 -0800 (PST)
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
Subject: [PATCH v2 02/12] fs/proc/vmcore: replace vmcoredd_mutex by vmcore_mutex
Date: Wed,  4 Dec 2024 13:54:33 +0100
Message-ID: <20241204125444.1734652-3-david@redhat.com>
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

Now that we have a mutex that synchronizes against opening of the vmcore,
let's use that one to replace vmcoredd_mutex: there is no need to have
two separate ones.

This is a preparation for properly preventing vmcore modifications
after the vmcore was opened.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/vmcore.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 586f84677d2f..e5a7e302f91f 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -53,7 +53,6 @@ static struct proc_dir_entry *proc_vmcore;
 #ifdef CONFIG_PROC_VMCORE_DEVICE_DUMP
 /* Device Dump list and mutex to synchronize access to list */
 static LIST_HEAD(vmcoredd_list);
-static DEFINE_MUTEX(vmcoredd_mutex);
 
 static bool vmcoredd_disabled;
 core_param(novmcoredd, vmcoredd_disabled, bool, 0);
@@ -248,7 +247,7 @@ static int vmcoredd_copy_dumps(struct iov_iter *iter, u64 start, size_t size)
 	size_t tsz;
 	char *buf;
 
-	mutex_lock(&vmcoredd_mutex);
+	mutex_lock(&vmcore_mutex);
 	list_for_each_entry(dump, &vmcoredd_list, list) {
 		if (start < offset + dump->size) {
 			tsz = min(offset + (u64)dump->size - start, (u64)size);
@@ -269,7 +268,7 @@ static int vmcoredd_copy_dumps(struct iov_iter *iter, u64 start, size_t size)
 	}
 
 out_unlock:
-	mutex_unlock(&vmcoredd_mutex);
+	mutex_unlock(&vmcore_mutex);
 	return ret;
 }
 
@@ -283,7 +282,7 @@ static int vmcoredd_mmap_dumps(struct vm_area_struct *vma, unsigned long dst,
 	size_t tsz;
 	char *buf;
 
-	mutex_lock(&vmcoredd_mutex);
+	mutex_lock(&vmcore_mutex);
 	list_for_each_entry(dump, &vmcoredd_list, list) {
 		if (start < offset + dump->size) {
 			tsz = min(offset + (u64)dump->size - start, (u64)size);
@@ -306,7 +305,7 @@ static int vmcoredd_mmap_dumps(struct vm_area_struct *vma, unsigned long dst,
 	}
 
 out_unlock:
-	mutex_unlock(&vmcoredd_mutex);
+	mutex_unlock(&vmcore_mutex);
 	return ret;
 }
 #endif /* CONFIG_MMU */
@@ -1518,9 +1517,9 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
 	dump->size = data_size;
 
 	/* Add the dump to driver sysfs list */
-	mutex_lock(&vmcoredd_mutex);
+	mutex_lock(&vmcore_mutex);
 	list_add_tail(&dump->list, &vmcoredd_list);
-	mutex_unlock(&vmcoredd_mutex);
+	mutex_unlock(&vmcore_mutex);
 
 	vmcoredd_update_size(data_size);
 	return 0;
@@ -1538,7 +1537,7 @@ EXPORT_SYMBOL(vmcore_add_device_dump);
 static void vmcore_free_device_dumps(void)
 {
 #ifdef CONFIG_PROC_VMCORE_DEVICE_DUMP
-	mutex_lock(&vmcoredd_mutex);
+	mutex_lock(&vmcore_mutex);
 	while (!list_empty(&vmcoredd_list)) {
 		struct vmcoredd_node *dump;
 
@@ -1548,7 +1547,7 @@ static void vmcore_free_device_dumps(void)
 		vfree(dump->buf);
 		vfree(dump);
 	}
-	mutex_unlock(&vmcoredd_mutex);
+	mutex_unlock(&vmcore_mutex);
 #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
 }
 
-- 
2.47.1


