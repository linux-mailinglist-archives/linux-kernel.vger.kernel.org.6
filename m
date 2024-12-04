Return-Path: <linux-kernel+bounces-431221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B82D9E3AAE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFC052834B2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4985120B818;
	Wed,  4 Dec 2024 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K06GoZ5r"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD73120B21A
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 12:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316926; cv=none; b=OosZeezPCuy7jsQpv2nHqxht2Y0WyF6tTAJC66JdlNPyliatronRTgda32BI0KH7ddS6a7ODfIuXbRpFMmb+Zjz3bUtpCaa0yF4612j0i5OewbaCzMFfhDOrhhvaTHWipBbCRXltiI8j83TAU0bfxcEZbRmgjBTlFlPPSSw17qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316926; c=relaxed/simple;
	bh=N+omNMBxmCIiBaT6aoDaJz2BLDTJK2NT8K0YRXJ+Was=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/dtU+y4N7sW145jo+nFhz9fQatubcX5Ef3m5lfXHVGcxKvc8Y0lrVrtsjEFaD+oI8DbEiHF6ZQ1Plav9tIiNpeOrMs4AE3t9zJYF8nqpRCNpxJnnmbvYk0iofEmA3z1drGuHvWr5zHT1lVxqaPuf5sOF80atSI+Q+dsq275G90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K06GoZ5r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733316922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GxsrWUisM+4YkdsHUV4TP4AYDbO5CJkwL1nd2GKtk5k=;
	b=K06GoZ5rr3R/W2L2FHfsfoQiTojEtr86CwiQuqvyllogryALBF52oqIhMyc42BdokMdHwo
	/XyOI4FOE2e8DPx2J9thMVnNPkz//5jzXyRuyePXP5RYB0+n9BLuCbOp8ZhpfU/uIssfh6
	qmId0FsrRE+YyYqidld09CCGs6wfutc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-zkovl8b7OceWFxTLdeewgg-1; Wed, 04 Dec 2024 07:55:22 -0500
X-MC-Unique: zkovl8b7OceWFxTLdeewgg-1
X-Mimecast-MFC-AGG-ID: zkovl8b7OceWFxTLdeewgg
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4349cbf726cso49760945e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 04:55:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316921; x=1733921721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GxsrWUisM+4YkdsHUV4TP4AYDbO5CJkwL1nd2GKtk5k=;
        b=kPuQ7D0To70e8NCNkcIafNdDIThu0yJJvbZWgjnTuBCbhGtvUOgIZIhgS4ksdLJYMv
         PQAwaXO1SYmoPL6yadeTyO3nCwFkyErdMmOw2Fc7XW+RzdQtxowAzCTgfGy8uU6EItOT
         qk/4Ote1UhwoeEhMLs/yB1WTAaGsS72ZL8CiBDUxa89kQf3SYE9P5J15SvyAvdAnvke0
         KfJHnXRx1hTFmmPJGo8DPWXkJVaIqZZJ6ap6ZoXa3gyk52depl4fyVYFB7tlY9ZRmJ6S
         HIbaYRtZfU7LXU/a9vDZYAVwSrOdAGUcZQEZw+Tmifom3lYb4NjXT8/wOayVZU0yzx5D
         9S4g==
X-Gm-Message-State: AOJu0YyP8QsuW5YwdHZ6Ykr1sBB3v+5346UcDuJ0zkRLOuWZtdOyzDSY
	VQMHCF+dgLtRltrbtGz4yWuKNXv8654eOCejCOxAZFmL1HUVbeYaERwts1QVyD3pk0dOEhF8yjl
	lWt2yxSP2gUnc7qC3mEtaT99Ilcp7zvwM5WZYsY959DfpKKn0Vs5jEYQSBSxRUoqIF89GSZy1KA
	Bxz+U0UugUD6zOg0qkk73C7kLpRt/imYNODWJCzeF54Cub
X-Gm-Gg: ASbGnctnjnRhkR757XHjq+T3Tzz30yBwumO2oRuNrNjf5Wm9v35kjqujVp7zvTEs9LH
	L0dnBVUeKypovirMVydt+mkMYCNzvN+SmBic9WnaIVBWukot4l4vSMMAyRh8VZyQ+aJWc8dfcWe
	okax9tmC662/O7RRNEAjI0m4gdhzGEOJldNA9H357Viscky81HPONROkZgOe3W7PtS9EocNcOib
	Tckxa8iD4MvLWayFsCffM+/TsMBIT6wUtMWLTFiOTffpsG1NmlRBpktwFzk5HT+kqUo54Z9asqO
	hdjA3vAWPaLiVbPJt9zHpPegMCNwRMndgLM=
X-Received: by 2002:a5d:5986:0:b0:382:4115:1ccb with SMTP id ffacd0b85a97d-385fd3cd078mr5363661f8f.7.1733316920851;
        Wed, 04 Dec 2024 04:55:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVrn7snw7RGTPCk/ImHOMtvIc2Zo//ldD8UcsohYWGwkye1iFqtEVkXPmZASBRCfdSRO6pnw==
X-Received: by 2002:a5d:5986:0:b0:382:4115:1ccb with SMTP id ffacd0b85a97d-385fd3cd078mr5363620f8f.7.1733316920347;
        Wed, 04 Dec 2024 04:55:20 -0800 (PST)
Received: from localhost (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-434d52c0bc7sm23529155e9.35.2024.12.04.04.55.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:55:19 -0800 (PST)
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
Subject: [PATCH v2 11/12] virtio-mem: support CONFIG_PROC_VMCORE_DEVICE_RAM
Date: Wed,  4 Dec 2024 13:54:42 +0100
Message-ID: <20241204125444.1734652-12-david@redhat.com>
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

Let's implement the get_device_ram() vmcore callback, so
architectures that select NEED_PROC_VMCORE_NEED_DEVICE_RAM, like s390
soon, can include that memory in a crash dump.

Merge ranges, and process ranges that might contain a mixture of plugged
and unplugged, to reduce the total number of ranges.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 88 +++++++++++++++++++++++++++++++++++++
 fs/proc/Kconfig             |  1 +
 2 files changed, 89 insertions(+)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 73477d5b79cf..8a294b9cbcf6 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2728,6 +2728,91 @@ static bool virtio_mem_vmcore_pfn_is_ram(struct vmcore_cb *cb,
 	mutex_unlock(&vm->hotplug_mutex);
 	return is_ram;
 }
+
+#ifdef CONFIG_PROC_VMCORE_DEVICE_RAM
+static int virtio_mem_vmcore_add_device_ram(struct virtio_mem *vm,
+		struct list_head *list, uint64_t start, uint64_t end)
+{
+	int rc;
+
+	rc = vmcore_alloc_add_range(list, start, end - start);
+	if (rc)
+		dev_err(&vm->vdev->dev,
+			 "Error adding device RAM range: %d\n", rc);
+	return rc;
+}
+
+static int virtio_mem_vmcore_get_device_ram(struct vmcore_cb *cb,
+		struct list_head *list)
+{
+	struct virtio_mem *vm = container_of(cb, struct virtio_mem,
+					     vmcore_cb);
+	const uint64_t device_start = vm->addr;
+	const uint64_t device_end = vm->addr + vm->usable_region_size;
+	uint64_t chunk_size, cur_start, cur_end, plugged_range_start = 0;
+	LIST_HEAD(tmp_list);
+	int rc;
+
+	if (!vm->plugged_size)
+		return 0;
+
+	/* Process memory sections, unless the device block size is bigger. */
+	chunk_size = max_t(uint64_t, PFN_PHYS(PAGES_PER_SECTION),
+			   vm->device_block_size);
+
+	mutex_lock(&vm->hotplug_mutex);
+
+	/*
+	 * We process larger chunks and indicate the complete chunk if any
+	 * block in there is plugged. This reduces the number of pfn_is_ram()
+	 * callbacks and mimic what is effectively being done when the old
+	 * kernel would add complete memory sections/blocks to the elfcore hdr.
+	 */
+	cur_start = device_start;
+	for (cur_start = device_start; cur_start < device_end; cur_start = cur_end) {
+		cur_end = ALIGN_DOWN(cur_start + chunk_size, chunk_size);
+		cur_end = min_t(uint64_t, cur_end, device_end);
+
+		rc = virtio_mem_send_state_request(vm, cur_start,
+						   cur_end - cur_start);
+
+		if (rc < 0) {
+			dev_err(&vm->vdev->dev,
+				"Error querying block states: %d\n", rc);
+			goto out;
+		} else if (rc != VIRTIO_MEM_STATE_UNPLUGGED) {
+			/* Merge ranges with plugged memory. */
+			if (!plugged_range_start)
+				plugged_range_start = cur_start;
+			continue;
+		}
+
+		/* Flush any plugged range. */
+		if (plugged_range_start) {
+			rc = virtio_mem_vmcore_add_device_ram(vm, &tmp_list,
+							      plugged_range_start,
+							      cur_start);
+			if (rc)
+				goto out;
+			plugged_range_start = 0;
+		}
+	}
+
+	/* Flush any plugged range. */
+	if (plugged_range_start)
+		rc = virtio_mem_vmcore_add_device_ram(vm, &tmp_list,
+						      plugged_range_start,
+						      cur_start);
+out:
+	mutex_unlock(&vm->hotplug_mutex);
+	if (rc < 0) {
+		vmcore_free_ranges(&tmp_list);
+		return rc;
+	}
+	list_splice_tail(&tmp_list, list);
+	return 0;
+}
+#endif /* CONFIG_PROC_VMCORE_DEVICE_RAM */
 #endif /* CONFIG_PROC_VMCORE */
 
 static int virtio_mem_init_kdump(struct virtio_mem *vm)
@@ -2737,6 +2822,9 @@ static int virtio_mem_init_kdump(struct virtio_mem *vm)
 #ifdef CONFIG_PROC_VMCORE
 	dev_info(&vm->vdev->dev, "memory hot(un)plug disabled in kdump kernel\n");
 	vm->vmcore_cb.pfn_is_ram = virtio_mem_vmcore_pfn_is_ram;
+#ifdef CONFIG_PROC_VMCORE_DEVICE_RAM
+	vm->vmcore_cb.get_device_ram = virtio_mem_vmcore_get_device_ram;
+#endif /* CONFIG_PROC_VMCORE_DEVICE_RAM */
 	register_vmcore_cb(&vm->vmcore_cb);
 	return 0;
 #else /* CONFIG_PROC_VMCORE */
diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
index 5668620ab34d..6ae966c561e7 100644
--- a/fs/proc/Kconfig
+++ b/fs/proc/Kconfig
@@ -67,6 +67,7 @@ config NEED_PROC_VMCORE_DEVICE_RAM
 config PROC_VMCORE_DEVICE_RAM
 	def_bool y
 	depends on PROC_VMCORE && NEED_PROC_VMCORE_DEVICE_RAM
+	depends on VIRTIO_MEM
 	help
 	  If the elfcore hdr is allocated and prepared by the dump kernel
 	  ("2nd kernel") instead of the crashed kernel, RAM provided by memory
-- 
2.47.1


