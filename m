Return-Path: <linux-kernel+bounces-431220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3C59E3AA3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78456166E46
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41F520A5C8;
	Wed,  4 Dec 2024 12:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dSRvqY32"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D6E209F53
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 12:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316921; cv=none; b=PC2+PiAhNyeaP6qDH6JldTcFpGD+S4T34/dx4cyEq4P6ETZUoqWyfjGJgYVXN0RbNw8np7Ux8uTjHxhSLK82z2lyQylXCHK/tH10/s/uFkq4P9Ly8v6zRC+lWTKNypwWHhpqOhmlvETb3B6P6oqjy3yTjecXsbh/C87y0CAd+E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316921; c=relaxed/simple;
	bh=saVx3j66yQi6SYE+wOeyLCRXDHSMKU0oWoMw4xOdqbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AomUow5eGwiEg8PqGDDo048LHvFEC9phJ4IINkHA4NsbV9c502emIC9HujvI7fPRDmQ4iC/gCulfx/920Km2NnugG/MIdU1b/VlpS/61/giqdVgkKMqXKq3fkcC1xj6g4Z0Y0lrnYJ3zlIJQX1Fi2Ij/ShVwPhMh2MzX2bG+n0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dSRvqY32; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733316918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8qWcPvM3uPJNBlH29eIda0Org6XNMptmimUFcDc8wZo=;
	b=dSRvqY32SWKGnp+Ac6bqQ6v8EVxPe4dnD6G/WvcZj7YUdCB8w4mQ9SDrHbooEcRA8AMeYM
	tkKOUDjyl/BBw34BAbh6QL+o0zCkjIEgvawigXMHrOja3WxFsmAFerj5lmknN3kMcPG+mQ
	JAs3yhNuKIMf/StXDn//oW3cJ00div4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-c7zab5PVNOqKCZitjbTZZQ-1; Wed, 04 Dec 2024 07:55:17 -0500
X-MC-Unique: c7zab5PVNOqKCZitjbTZZQ-1
X-Mimecast-MFC-AGG-ID: c7zab5PVNOqKCZitjbTZZQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4349fd2965fso62450015e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 04:55:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316916; x=1733921716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qWcPvM3uPJNBlH29eIda0Org6XNMptmimUFcDc8wZo=;
        b=quGGcOBsCrBaQiQU23PbSBGzH2XFavjaqxK13kJdySI7B2YuwAaB+G8iPs9m1MLJtn
         H1FbIEXyOeR1W7lL6bbRxRp6vy2zzc27pjTYAk/oXZdodUiqBna0v6TPBIkCEFOUFmPd
         iKLCUeQ6QUnqFX6b0gh4HqioZPwfa7XDY0PoQM8IZJl4EXiKl2rVuLHlbrYaAVStIUpj
         PW6AylAsC4TZkC1wagwBNY0oGV5FM++1dj2XWiGUUfJxRYFPy2ji4LThp4EsaIvrOuM3
         8TqNYHZbz1frTBjUWsQvoxpyx8zMavWgf6IpZXErvDgnRt0WOlwR4KdnAgzdLPl/gVM0
         i+Gg==
X-Gm-Message-State: AOJu0YyNbz1cD1mujP6GnPC0H9dbk4bzw15qZjzJcnhyUEwQTTxiE6GJ
	J83KLXpTvRA6J80ijr5DRawDmoZy4V494n1nIKTPBNOSskPFrZUX2fCnz519n/yFQZlPZNU29pO
	25gid2eP2ZvQneGnA+BD9aHpNU2cbnQv0fkd+bqAF15xq8Mx8BhP/oTt/1Vx9QOGTx7IFeluOAA
	fVMUjiOFarKOJ4ZAXr/bJxyABcG+geP4TzHnvO43DiqoYt
X-Gm-Gg: ASbGncuYP7QRtvel0qmsuLAStlAu5O3BU3lhsQEwOzJg+/AkspwtK04uR/gSKp0J1n7
	lAPSTGoa/n/98rKPtQDLJ9HKeWJzT9DTTxsMDTEuPB5F3hn0P/U7tRxbhdJesSbFFPBqLcBBpFC
	CMmMz/Izdc0edEPLAd9tVtHeWJNOX0p6PbzEPI4Z6LiKQG0Tcy1A5kxw1AKJcAe4IZ5BwWLDgoU
	IdzIQ77qWxHN8B8y593D01hGIaDSJhS1OCAfbw5QoBWTkAzWMZirGOXBzY8b5Ek6IiUYzi57xTB
	ck5xvsFAx63K1Y5YdKAsY3SShnzoGSvXQzM=
X-Received: by 2002:a05:600c:4fc9:b0:434:a986:11cf with SMTP id 5b1f17b1804b1-434d09c0faamr58500055e9.8.1733316916588;
        Wed, 04 Dec 2024 04:55:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0Ukl1ZPphCA+wOQqYI2PG+9UegKLtZCsee5cNCt9biGs2cCCF0gJFsDeKmcsipWxLJl404A==
X-Received: by 2002:a05:600c:4fc9:b0:434:a986:11cf with SMTP id 5b1f17b1804b1-434d09c0faamr58499655e9.8.1733316916209;
        Wed, 04 Dec 2024 04:55:16 -0800 (PST)
Received: from localhost (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-434d52a3139sm24274545e9.28.2024.12.04.04.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:55:14 -0800 (PST)
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
Subject: [PATCH v2 10/12] virtio-mem: remember usable region size
Date: Wed,  4 Dec 2024 13:54:41 +0100
Message-ID: <20241204125444.1734652-11-david@redhat.com>
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

Let's remember the usable region size, which will be helpful in kdump
mode next.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 126f1d669bb0..73477d5b79cf 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -133,6 +133,8 @@ struct virtio_mem {
 	uint64_t addr;
 	/* Maximum region size in bytes. */
 	uint64_t region_size;
+	/* Usable region size in bytes. */
+	uint64_t usable_region_size;
 
 	/* The parent resource for all memory added via this device. */
 	struct resource *parent_resource;
@@ -2368,7 +2370,7 @@ static int virtio_mem_cleanup_pending_mb(struct virtio_mem *vm)
 static void virtio_mem_refresh_config(struct virtio_mem *vm)
 {
 	const struct range pluggable_range = mhp_get_pluggable_range(true);
-	uint64_t new_plugged_size, usable_region_size, end_addr;
+	uint64_t new_plugged_size, end_addr;
 
 	/* the plugged_size is just a reflection of what _we_ did previously */
 	virtio_cread_le(vm->vdev, struct virtio_mem_config, plugged_size,
@@ -2378,8 +2380,8 @@ static void virtio_mem_refresh_config(struct virtio_mem *vm)
 
 	/* calculate the last usable memory block id */
 	virtio_cread_le(vm->vdev, struct virtio_mem_config,
-			usable_region_size, &usable_region_size);
-	end_addr = min(vm->addr + usable_region_size - 1,
+			usable_region_size, &vm->usable_region_size);
+	end_addr = min(vm->addr + vm->usable_region_size - 1,
 		       pluggable_range.end);
 
 	if (vm->in_sbm) {
@@ -2763,6 +2765,8 @@ static int virtio_mem_init(struct virtio_mem *vm)
 	virtio_cread_le(vm->vdev, struct virtio_mem_config, addr, &vm->addr);
 	virtio_cread_le(vm->vdev, struct virtio_mem_config, region_size,
 			&vm->region_size);
+	virtio_cread_le(vm->vdev, struct virtio_mem_config, usable_region_size,
+			&vm->usable_region_size);
 
 	/* Determine the nid for the device based on the lowest address. */
 	if (vm->nid == NUMA_NO_NODE)
-- 
2.47.1


