Return-Path: <linux-kernel+bounces-513295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E4EA34894
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E30D162BEF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48A620010B;
	Thu, 13 Feb 2025 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EFUW/REI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493B51E7C3A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739461847; cv=none; b=p0trAp9NLMju6A5aFA9gFFXgz/eGbrqQXONTRM1txfqf2D71Tvcew4tIYJfF+LK6PYZGF6jc7hi9cFD36oGHmfcrCP0RphtzWqnn4J0+T2F9EwbtdZj7i6mINNFHMrMj54BSJvolEUOzHZ27P2WGMutNw3ghOrUqfWOx4sWHmeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739461847; c=relaxed/simple;
	bh=th8ICZQzwvAj4jti147i6LTZteZNR2JRdjJgrinPxuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rg5LpSrWh7fycY0WnALGDtf940e+D86RwNaDQqyAYGOetp6tg0iBePL7+bhNaV9A3uJ1SOPvCjvEuviRSP935Q/TUKpqi21mFdKbwie+giY9WkbyyX3gBabtf5Uu10MVKpToLcB1ndW6Xo2/M4PdauAKio202XKFfbfvrSNmQW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EFUW/REI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739461844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xk1Yohdv6xG1LIYdCE6weZxWdHnGQzZeQusGiNbS4YE=;
	b=EFUW/REICNRI3Cl0+qB07QS05TWJN6+NLFcWO4XqznDnl2dnr6Je6AAC4WrVG6GeZBwFkC
	pxFECUr7IFfmjsfa8XlsXdBk79Wi4Ajv2ML19DMAKmHVAV/cKQnIjJYK3U/qKETIoS1Yfx
	R0GF97t3Ca8ddZMmw2AsitS2hRhmllk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-xQRG1M1ZOk2Exaus-VHC1w-1; Thu,
 13 Feb 2025 10:50:40 -0500
X-MC-Unique: xQRG1M1ZOk2Exaus-VHC1w-1
X-Mimecast-MFC-AGG-ID: xQRG1M1ZOk2Exaus-VHC1w
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95E9A1801A1A;
	Thu, 13 Feb 2025 15:50:38 +0000 (UTC)
Received: from [127.0.1.1] (unknown [10.44.33.58])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D250E1800365;
	Thu, 13 Feb 2025 15:50:31 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
Date: Thu, 13 Feb 2025 16:49:17 +0100
Subject: [PATCH RFC 3/5] virtio-pci: extend virtio_pci_cap to hold
 page_size
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-virtio-shm-page-size-v1-3-5ee1f9984350@redhat.com>
References: <20250213-virtio-shm-page-size-v1-0-5ee1f9984350@redhat.com>
In-Reply-To: <20250213-virtio-shm-page-size-v1-0-5ee1f9984350@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3726; i=slp@redhat.com;
 h=from:subject:message-id; bh=th8ICZQzwvAj4jti147i6LTZteZNR2JRdjJgrinPxuc=;
 b=kA0DAAgB9GknjS8MAjUByyZiAGeuFK6g0IYF5gNoVdDWEYIgYw+KDGgrgUaUt6Ss3HnaKn8f5
 okCMwQAAQgAHRYhBL7V/PdRLYaAkULoovRpJ40vDAI1BQJnrhSuAAoJEPRpJ40vDAI12zkP/iYs
 PuEmv6T8Yt/q5MJgGj+Z3qujU/ygCd+imitAs8P6jGFZsAI82+UupJ+bTmoQpp9gsV7yR+5sLmT
 ik8o0shqm97DkSwU26UmT4Ny7pHoeo4fOxmMw+7KIxIbIsIUk/zDfT0xGGygXkKKfOy6l9BDL6j
 pyYQ8cG8JUfoCauMj/dwTcAUg+t3S9xq6+artRq85AS38zrlte2kgQqwZwajyjd9Z9+XFZW+cLf
 mbllQF7x8RlU+ibEnds0qwScmLx47kZi6G/K8FlcUpe197W3LlUZkHYmQINMvHeGtN5qUJgDRK+
 Ks8xl0mD2q52Rn0vRnbWElGjQ16fvg/opYjr5uBie3u5W4xbRxovh7xjZbAXM1wyycaNllgLUfv
 JyvrzCpRa2K/R8HNgwySlpZqlf7ybsSHK+Swy6Yl3K3qtqJuS0NhbAh8OhN1xda92SBtflPibBw
 ZlHWC1q89oEjcAORxPJOrHUslXx1NJbuprjTNJntzJwNBmSZmcypQgc0GfYeF0OxLNKUd8X9z+z
 M3F/grb33qsAgdcVRnOhEM5RIQf/LH+DDBYdryYWRgAYK5QHWRuYrhcgDRH7BS1t6SJk8VpSdGV
 4bzh2p+K0TvpZ39fD1Vjwpij0LncXAWsMEJ54MDZxZUYAhvUL79Y+50S2Zjs4C9SC6hDYIgeeeh
 HcTcN
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Turn the 16 bit padding into a page_size field to allow the device to
pass its required page size with format PAGE_SIZE >> 12.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 29 +++++++++++++++++++++++++----
 include/uapi/linux/virtio_pci.h    |  2 +-
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 79616ce5057bf3b2b88cae7e8fb7729efa9dd632..26e9cd5148c0f10209c34d12e65d64490a855d75 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -770,14 +770,16 @@ static void del_vq(struct virtio_pci_vq_info *info)
 	vring_del_virtqueue(vq);
 }
 
-static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
-				   u8 *bar, u64 *offset, u64 *len)
+static int virtio_pci_find_shm_cap(struct virtio_device *vdev, struct pci_dev *dev,
+				   u8 required_id, u8 *bar, u64 *offset, u64 *len,
+				   u16 *page_size)
 {
 	int pos;
 
 	for (pos = pci_find_capability(dev, PCI_CAP_ID_VNDR); pos > 0;
 	     pos = pci_find_next_capability(dev, pos, PCI_CAP_ID_VNDR)) {
 		u8 type, cap_len, id, res_bar;
+		u16 res_psize = 0;
 		u32 tmp32;
 		u64 res_offset, res_length;
 
@@ -808,6 +810,23 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
 		 * Looks good.
 		 */
 
+		if (__virtio_test_bit(vdev, VIRTIO_F_SHM_PAGE_SIZE)) {
+			pci_read_config_word(dev, pos + offsetof(struct virtio_pci_cap,
+								 page_size), &res_psize);
+			if (!res_psize) {
+				dev_err(&dev->dev, "%s: shm cap with invalid page size on "
+					"a device with VIRTIO_F_SHM_PAGE_SIZE feature\n",
+					__func__);
+				res_psize = 4096 >> 12;
+			}
+		}
+
+		/* For backwards compatibility, if the device didn't specify a
+		 * page size, assume it to be 4096.
+		 */
+		if (!res_psize)
+			res_psize = 4096 >> 12;
+
 		/* Read the lower 32bit of length and offset */
 		pci_read_config_dword(dev, pos + offsetof(struct virtio_pci_cap,
 							  offset), &tmp32);
@@ -829,6 +848,7 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
 		*bar = res_bar;
 		*offset = res_offset;
 		*len = res_length;
+		*page_size = res_psize;
 
 		return pos;
 	}
@@ -841,11 +861,12 @@ static bool vp_get_shm_region(struct virtio_device *vdev,
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	struct pci_dev *pci_dev = vp_dev->pci_dev;
 	u8 bar;
+	u16 page_size;
 	u64 offset, len;
 	phys_addr_t phys_addr;
 	size_t bar_len;
 
-	if (!virtio_pci_find_shm_cap(pci_dev, id, &bar, &offset, &len))
+	if (!virtio_pci_find_shm_cap(vdev, pci_dev, id, &bar, &offset, &len, &page_size))
 		return false;
 
 	phys_addr = pci_resource_start(pci_dev, bar);
@@ -865,7 +886,7 @@ static bool vp_get_shm_region(struct virtio_device *vdev,
 
 	region->len = len;
 	region->addr = (u64) phys_addr + offset;
-	region->page_size = 4096 >> 12;
+	region->page_size = page_size;
 
 	return true;
 }
diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index 8549d4571257142ac6c9dad5c01369923791a85a..fb0ccb7a125d8178c1f78333c4d2f43540e1764b 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -127,7 +127,7 @@ struct virtio_pci_cap {
 	__u8 cfg_type;		/* Identifies the structure. */
 	__u8 bar;		/* Where to find it. */
 	__u8 id;		/* Multiple capabilities of the same type */
-	__u8 padding[2];	/* Pad to full dword. */
+	__u16 page_size;	/* Device page size (PAGE_SIZE >> 12). */
 	__le32 offset;		/* Offset within bar. */
 	__le32 length;		/* Length of the structure, in bytes. */
 };

-- 
2.48.1


