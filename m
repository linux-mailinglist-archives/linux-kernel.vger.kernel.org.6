Return-Path: <linux-kernel+bounces-513291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A731A34891
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39879162799
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977841AAE17;
	Thu, 13 Feb 2025 15:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WKz4yGET"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CE9176AA1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 15:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739461825; cv=none; b=S4hawy9nFVkGqZ1U5/fqP+S0I9bfdnOwPGVKFJqsskLiyJj4Ev5HE6gb3gcw/zOzZ3YlJt/64qPsnhITbK+b9QDvRhULKxqB09U8dkCXZx7oopoG03+oWTmNmhQC8iy+xh3U0po/gUEiseraRdEE2tzhR1p5evdwhOf7VyJZD+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739461825; c=relaxed/simple;
	bh=SbPUSm3ifegqv7YqorRMY++Q4GLCzSK0nJ0dyTpQQJs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QinJrpVNeFiaKf4v8r3iC8JWBQMJ+Sap1yEJsIL2+9PV3QPidKXIWkM0cy0SjYfYky/unr5W/JfbzDkMAXEuilmJ0N4Rn7jIB5zKxXwJDszRgYhPWnJm5tJIiDWNbD12eu62Hxv7HPvGlGjEI1Jppbk+8wLoYaSqVAYmDXqVf/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WKz4yGET; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739461823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0Y+jKRKsEjO1TFaud7eeAl4edw665Vb/FbaZRDoam2o=;
	b=WKz4yGETKHSibSMqoAMS1IHZHGKp10TMD7V1Gjh4FJ33OG9hywCQ0lnxUcp/lRbf+en4jJ
	pEZAjPygyklnF5gpuqFm1apWcXCBfwBcrmN9ybRwSxgyRZkpLAe5jAPRBWVbx0GSv4zIXF
	qwvzy7iDeg1UkJbgM3MjbGyPvE7WGew=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-0y3rFR6hN_mtWCj48wSuHQ-1; Thu,
 13 Feb 2025 10:50:20 -0500
X-MC-Unique: 0y3rFR6hN_mtWCj48wSuHQ-1
X-Mimecast-MFC-AGG-ID: 0y3rFR6hN_mtWCj48wSuHQ
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B7B561800373;
	Thu, 13 Feb 2025 15:50:17 +0000 (UTC)
Received: from [127.0.1.1] (unknown [10.44.33.58])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 445121800360;
	Thu, 13 Feb 2025 15:50:09 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
Subject: [RFC PATCH 0/5] virtio: obtain SHM page size from device
Date: Thu, 13 Feb 2025 16:49:14 +0100
Message-Id: <20250213-virtio-shm-page-size-v1-0-5ee1f9984350@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHoUrmcC/x2MywqAIBAAf0X23IIaPX8lOkhutYdK3JAo+vek4
 zDMPCAUmQR69UCkxMLHnsEUCqbV7Qsh+8xgta20NSUmjicfKOuGwWUtfBPW1DndTo0nbyCnIdL
 M178dxvf9AAM0pylmAAAA
X-Change-ID: 20250213-virtio-shm-page-size-6e9a08c7ded1
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2664; i=slp@redhat.com;
 h=from:subject:message-id; bh=SbPUSm3ifegqv7YqorRMY++Q4GLCzSK0nJ0dyTpQQJs=;
 b=owEBbQKS/ZANAwAIAfRpJ40vDAI1AcsmYgBnrhSsWyIbxUAlgUtYgYz1iRByHa4EIlCTgfujK
 JQgSn4pp/KJAjMEAAEIAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCZ64UrAAKCRD0aSeNLwwC
 NStrEACD6yQgv1tPtc0cpojYfXRIfQlhDL/XV9gkfuh7RlAdFwVB0q0LUWVKV3W9IFezAsljfJo
 Vr+DtEJ2yWn+Qdh+Xzro4UCBZAySoiPv9AHNnIYbLHIPoBZ5Z8bqwyRQEkTw6Nd83s1h060qyhC
 EhuB3v6bEYqhqDDdc+hxWqBgscYS7S2Q054fUuOokxSJ174N5lqFZOcQDVbgy/TmmWfzV3VmMy3
 +Qt6DGjnGDA5UBol2354Q15YHcKp5+EdSCrZIHPv/bdKQk3C2j77BARu9I4JeBFez7IZuJ+eSGP
 gzq4rO6F+8hdQCapAykeZE4DIoibdY1KGyMcG8Nakhw8MOp8zBh4kqyOSbuzziEydclGaKr1ubj
 g75TvvJW6WRYjdzGgdkC5qqY2fmFHCfi3S5sEGuP7dik2Rcwl5nyJqzHrc5PSzxd5+YUtY6Xy0a
 w4AIbdVXs0k7SoO1Fw/ywi9Y0VQvRROZZIhZWUwXggUAd4zjpJcdoM/qj1ZzC75GnxUikJZ1FBs
 lsNZht8bqWLBfcbHdcmJZu/KNVaU1CUbtgYNz2FmIYB5RMmJBZZlj2ayH2dGVJ4oVhpNBYQvcAj
 mCJ8W309zpxuir27duPN6VNxLAlLdua/b/86UxDuxW3cOROaICpn47s49ySESY8WwAPTFFtQgRd
 uMKbKbOBAqgYM5w==
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

There's an incresing number of machines supporting multiple page sizes
and, on these machines, the host and a guest can be running with
different pages sizes.

In addition to this, there might be devices that have a required and/or
preferred page size for mapping memory.

In this series, we extend virtio_shm_region with a field to hold the
page size. This field has a 16-bit size to accommodate into the existing
padding virtio_pci_cap, simplifying the introduction of this additional
data into the structure. The device will provide the page size in format
PAGE_SIZE >> 12.

The series also extends the PCI and MMIO transports to obtain the
corresponding value from the device. For the PCI one, it should be safe
since we're using an existing 16-bit padding in the virtio_pci_cap
struct. For MMIO, we need to access a new register, so there's a risk
the VMM may overreact and crash the VM. I've checked libkrun,
firecracker, cloud-hypervisor and crosvm, and all of them should deal
with the unexpected MMIO read gracefully. QEMU doesn't support SHM for
the MMIO transport, so that isn't a concern either.

How the SHM page size information is used depends on each device. Some
may silently round up allocations, some may expose this information to
userspace. This series includes a patch that extends virtio-gpu to
expose the information via the VIRTGPU_GETPARAM ioctl, as an example of
the second approach.

This patch series is an RFC because it requires changes to the VIRTIO
specifications. This patch series will be used as a reference to
propose such changes.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
Sergio Lopez (5):
      virtio_config: add page_size field to virtio_shm_region
      virtio: introduce VIRTIO_F_SHM_PAGE_SIZE
      virtio-pci: extend virtio_pci_cap to hold page_size
      virtio-mmio: read shm region page size
      drm/virtio: add VIRTGPU_PARAM_HOST_SHM_PAGE_SIZE to params

 drivers/gpu/drm/virtio/virtgpu_ioctl.c |  5 +++++
 drivers/virtio/virtio_mmio.c           | 13 +++++++++++++
 drivers/virtio/virtio_pci_modern.c     | 31 ++++++++++++++++++++++++++++---
 drivers/virtio/virtio_ring.c           |  2 ++
 include/linux/virtio_config.h          |  1 +
 include/uapi/drm/virtgpu_drm.h         |  1 +
 include/uapi/linux/virtio_config.h     |  7 ++++++-
 include/uapi/linux/virtio_mmio.h       |  3 +++
 include/uapi/linux/virtio_pci.h        |  2 +-
 9 files changed, 60 insertions(+), 5 deletions(-)
---
base-commit: 4dc1d1bec89864d8076e5ab314f86f46442bfb02
change-id: 20250213-virtio-shm-page-size-6e9a08c7ded1

Best regards,
-- 
Sergio Lopez <slp@redhat.com>


