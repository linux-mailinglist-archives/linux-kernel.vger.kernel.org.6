Return-Path: <linux-kernel+bounces-515180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8E0A36158
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 658653AE4A6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E0D266B59;
	Fri, 14 Feb 2025 15:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fc4y4bbv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335222673AD
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739546262; cv=none; b=tmgB3A+GXDdGY3ZfZPTLGiRaft7sIKboSN181MG8+UBHsDPC+Cwc6/DaMbjkWxx2abLBxqrqKcQSaZ5Bew3acgf/xzV8aw9l2yJ/VlrUEAZscsE6HtwVPYNGoQrLUI2v5fy7ABZhb6yS87RVX7WFA4qwcbuRv7RkV1Z8SOvUIIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739546262; c=relaxed/simple;
	bh=7EDZ4tXBkHpIJ9CoAo/NVeLfmDjVx9PeVjky5GHdvhY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rP2BTpZahCHpbfJf3xf47+m9Aeq8IonQv1IwWjl2DxZODJt6aTuEho5brlg2JmlWFEaZRg9rcpkkMKTEWO8S7Q4QfCe8yL3nbtZh1P9Z0CUqBZy4C6aTmK+5sLGQccyUMBNL3EFKq+zxmFb25Y+WqvAuzc4obLhk7WuxFgP9THg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fc4y4bbv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739546260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DekdyXlfpswcUHk0jxahOCfTGUZTgIpr9Gk6V3yn7pg=;
	b=fc4y4bbvVoOWSWybRnxbzXlNboCoSG+th2JbY/kWkwVHCogzl5Bak2f19FqqtmOV7GuEuM
	wUJgFc97ZDR8t1iSf5l+uKC0C0j3PGsVWwhKEZQYdBnxRrj1n5rrWlZaoBp3WWxhfb3jk4
	3F7b2SkK/tvleIWvb4hlI5vmMx0pceM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-q-KyvkXDMtiAAc9C7OVc4A-1; Fri,
 14 Feb 2025 10:17:37 -0500
X-MC-Unique: q-KyvkXDMtiAAc9C7OVc4A-1
X-Mimecast-MFC-AGG-ID: q-KyvkXDMtiAAc9C7OVc4A_1739546255
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D4B55196E078;
	Fri, 14 Feb 2025 15:17:34 +0000 (UTC)
Received: from [127.0.1.1] (unknown [10.45.225.8])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F0EFE19373C4;
	Fri, 14 Feb 2025 15:17:27 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
Date: Fri, 14 Feb 2025 16:16:57 +0100
Subject: [PATCH RFC v2 3/5] virtio-pci: extend virtio_pci_cap with
 page_shift
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-virtio-shm-page-size-v2-3-aa1619e6908b@redhat.com>
References: <20250214-virtio-shm-page-size-v2-0-aa1619e6908b@redhat.com>
In-Reply-To: <20250214-virtio-shm-page-size-v2-0-aa1619e6908b@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Daniel Verkamp <dverkamp@chromium.org>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, fnkl.kernel@gmail.com
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Sergio Lopez <slp@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3924; i=slp@redhat.com;
 h=from:subject:message-id; bh=7EDZ4tXBkHpIJ9CoAo/NVeLfmDjVx9PeVjky5GHdvhY=;
 b=owEBbQKS/ZANAwAIAfRpJ40vDAI1AcsmYgBnr15uwGf8F4G/kehICMQxKpgR7le2iueBrH1IB
 aoMt7iEgSGJAjMEAAEIAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCZ69ebgAKCRD0aSeNLwwC
 Ndz6EAC6GcgM/kZfZqEP8xpFrXioeEAjpawCwoV+Askh+9a1h8ZJSu/SpecP0DwgyTlPUbMgZeK
 YHSLk3xb1lrg/CSGqca6U6H+P69Lqbp43umLKMSWxHfna4X6ZoXvBNAlj/HyD2GK8vi3+fFZ9nN
 iDuhIegUdr+PUJ0ciB/1QCEv34SQBs4ERnXzEA1QEN3P99xMxElEq0HT9BCnOengxeMN9+448L6
 kFd0qcQ0oSud1d6Y7PGauuNTYfZSnENgRadBPWG0/5kvU2vJSIeox0m9+cYvTimqivcr7z9rZNV
 WTph/DVUzY5OtdSh1ouGYxuu0rtVZ5ndpJMcAz4aa/YVmuMIl9ulgwdfStEsawj6g5SQZYREif/
 qTy2x/rWqU7pYnX9F2tWJ82s1oecKgeI1U+bxjxs5/Z5Pky6HDtCDZeDK/ptbd3s53Re3Xc+baF
 uorEbyAOwX7w4z3pcHn6F9Bgha0Mol55K07rFhFC5o9yxvV7PoEQbgr/foJ0Ez/Ef1zZIiPaNsc
 c9CIjO+g/XNz2TT4NlcHWbgJda5E2u+FD5PASOoqNcYUZ8SPVV/ReLstfgnbfDQDnQ/4fGs193p
 sMLz9TFusIuGNc+TtTQcUprSUdgf6HMXZtmLdAZDP7dkNb7Z/iLxBjq+E8L4V+Ozwr++sitQwGC
 yCBsbwv4qVmJrEg==
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

If VIRTIO_F_SHM_PAGE_SIZE has been negotiated and cfg_type is
VIRTIO_PCI_CAP_SHARED_MEMORY_CFG, the driver must read the page_shift
field, derive the supported page size from it, and honor it when
requesting the map of memory into the shared memory region to the
device.

Extend virtio_pci_cap to hold that field, and use it to feed
virtio_shm_region with the corresponding page size.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 22 +++++++++++++++++-----
 include/uapi/linux/virtio_pci.h    |  3 ++-
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index ab0e1d9148057c431676bfacfe5f68cc97eebb12..562a8e1c2bfe6876cffabe26f02cd61ad7fea2cd 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -770,14 +770,15 @@ static void del_vq(struct virtio_pci_vq_info *info)
 	vring_del_virtqueue(vq);
 }
 
-static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
-				   u8 *bar, u64 *offset, u64 *len)
+static int virtio_pci_find_shm_cap(struct virtio_device *vdev, struct pci_dev *dev,
+				   u8 required_id, u8 *bar, u64 *offset, u64 *len,
+				   u32 *page_size)
 {
 	int pos;
 
 	for (pos = pci_find_capability(dev, PCI_CAP_ID_VNDR); pos > 0;
 	     pos = pci_find_next_capability(dev, pos, PCI_CAP_ID_VNDR)) {
-		u8 type, cap_len, id, res_bar;
+		u8 type, cap_len, id, res_bar, page_shift = 0;
 		u32 tmp32;
 		u64 res_offset, res_length;
 
@@ -808,6 +809,15 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
 		 * Looks good.
 		 */
 
+		/* Read the page shift if supported. The page_shift variable is
+		 * initialized to zero above, so if this feature isn't supported it
+		 * will result in a page_size of 4096, a default safe value.
+		 */
+		if (__virtio_test_bit(vdev, VIRTIO_F_SHM_PAGE_SIZE)) {
+			pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
+								 page_shift), &page_shift);
+		}
+
 		/* Read the lower 32bit of length and offset */
 		pci_read_config_dword(dev, pos + offsetof(struct virtio_pci_cap,
 							  offset), &tmp32);
@@ -829,6 +839,7 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
 		*bar = res_bar;
 		*offset = res_offset;
 		*len = res_length;
+		*page_size = 1 << (page_shift + 12);
 
 		return pos;
 	}
@@ -841,11 +852,12 @@ static bool vp_get_shm_region(struct virtio_device *vdev,
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	struct pci_dev *pci_dev = vp_dev->pci_dev;
 	u8 bar;
+	u32 page_size;
 	u64 offset, len;
 	phys_addr_t phys_addr;
 	size_t bar_len;
 
-	if (!virtio_pci_find_shm_cap(pci_dev, id, &bar, &offset, &len))
+	if (!virtio_pci_find_shm_cap(vdev, pci_dev, id, &bar, &offset, &len, &page_size))
 		return false;
 
 	phys_addr = pci_resource_start(pci_dev, bar);
@@ -865,7 +877,7 @@ static bool vp_get_shm_region(struct virtio_device *vdev,
 
 	region->len = len;
 	region->addr = (u64) phys_addr + offset;
-	region->page_size = 4096;
+	region->page_size = page_size;
 
 	return true;
 }
diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index 8549d4571257142ac6c9dad5c01369923791a85a..1a76df52b4eccf548df78a8ee7d3a04591f55522 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -127,7 +127,8 @@ struct virtio_pci_cap {
 	__u8 cfg_type;		/* Identifies the structure. */
 	__u8 bar;		/* Where to find it. */
 	__u8 id;		/* Multiple capabilities of the same type */
-	__u8 padding[2];	/* Pad to full dword. */
+	__u8 page_shift;	/* Page shift for VIRTIO_PCI_CAP_SHARED_MEMORY_CFG. */
+	__u8 padding[1];	/* Pad to full dword. */
 	__le32 offset;		/* Offset within bar. */
 	__le32 length;		/* Length of the structure, in bytes. */
 };

-- 
2.48.1


