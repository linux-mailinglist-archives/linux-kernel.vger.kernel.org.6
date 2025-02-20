Return-Path: <linux-kernel+bounces-524835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA70AA3E7A8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 914C5422C30
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118EF264F8A;
	Thu, 20 Feb 2025 22:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YEWe2GK/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74B61E9B35
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 22:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740091264; cv=none; b=di/crYYkAfpDTlKQIzAvuxPVT5HWNoRdNNIZvJfak4vexkxuPoGk0x2pYOSSGzGTJg9zvFSemzudZxgnFPyxh9A5MswK2rC0ji0ooIXqm7danZNvHo7gbrVSz4mSzSDy61e7ycEe+T8sX2M1M2FP4r4rhOAzvSma4DsBiJD5wVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740091264; c=relaxed/simple;
	bh=EIrBcICY0nrw3MiybWqAJxN/+0dIBBq+xKit13UVocY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FgLuxFDVnEWtFn/txKyryfxyPuOiDpU13WZRETK2cXezcT4g787qSBHD+VtDe3+tq0XQZb31Qej3zT99ZlqJJqCurBPs5eE7cut4AKa3FM7CiMk9F3/rLTkT7SBqo0MisYJQGBAxwcQTzoJ1DV1jEEfKkpWyaFolh3vkpUHyEEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YEWe2GK/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740091261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=J5LpLD6cTC7YmXPFF3jLaaukEkMquqSf1+9EQ43LXwI=;
	b=YEWe2GK/b4XN0I2H68HOyOl6zxo8tHATURWHDfoywC0qCdpCDG2POjTOSQ1Z9BZNY6KN2K
	mL6Lmy4JPB02Z05bLnMe6sjyUWMihmJzwy6WRuFTMDGDrgfp0RnO5OTk5JCIaJLX9caN3x
	FlyAX0K2LlAC7qNINELMAyJpRvOawrM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-iANXzaygMg2TP7RitqHV-g-1; Thu,
 20 Feb 2025 17:40:58 -0500
X-MC-Unique: iANXzaygMg2TP7RitqHV-g-1
X-Mimecast-MFC-AGG-ID: iANXzaygMg2TP7RitqHV-g_1740091256
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DAFDC19373DC;
	Thu, 20 Feb 2025 22:40:55 +0000 (UTC)
Received: from [127.0.1.1] (unknown [10.44.32.26])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EF92E1800362;
	Thu, 20 Feb 2025 22:40:47 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
Subject: [RFC PATCH v4 0/4] virtio: obtain SHM page size from device
Date: Thu, 20 Feb 2025 23:40:29 +0100
Message-Id: <20250220-virtio-shm-page-size-v4-0-ddaed7b6f734@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF2vt2cC/4XNSw7CIBCA4as0rMXw6ANceQ/jAssgs6htoCFq0
 7tLu6oxjct/JvPNRCIEhEhOxUQCJIzYP3KUh4K03jzuQNHmJoKJigkuacIwYk+j7+hg8jriG2g
 N2jDVNhYsJ/l0CODwubKXa26PcezDa/2S+DL9AyZOGa0AuNNalbJi5wDWm/HY9h1ZxCS2Srmji
 KwYw2uuodZM3X4UuVEE21FkVlRTOudqJ3Wjv5R5nj93Mzs9RQEAAA==
X-Change-ID: 20250213-virtio-shm-page-size-6e9a08c7ded1
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3549; i=slp@redhat.com;
 h=from:subject:message-id; bh=EIrBcICY0nrw3MiybWqAJxN/+0dIBBq+xKit13UVocY=;
 b=owEBbQKS/ZANAwAIAfRpJ40vDAI1AcsmYgBnt69qjlgonWU9HEStbjBbIjyYw0uN/m6xlT0Xi
 gl3E7bgyviJAjMEAAEIAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCZ7evagAKCRD0aSeNLwwC
 NbIkEACEE1+9IXPhjSFvatetiBQqLdx5UGlmuYMV1/kU25PHSvKTzrDfJkHYkhrRr1xY7l6WCow
 kIPQyZacDGJnM6LnwXVen3p5L6/KlONB8bMY6gqKWqdswmeJkRQj+YgctanZzyz2GGh94o45p0H
 uRnMOu+BcnmpcwIAo5dlHOfRA2eUDIjRoANeRowVfP66WqFhHugT4qccAKxZmtD08dS55eBIog7
 uOBwBZ4Twjw5ecVVZlhJiQBW2I9xSUuNxILXJHnU7cDAmVLSVOHRUQ9Ye1aimifr8K+5i6vuO8i
 BS/CSwMzljEmhRJWangGEQ/TR4F3EtEKjX10dUo2v1E9ucHzg7C1s+hlCWQtww73hfclun9SFKq
 mk59upsekuZ7v0ucw4WyZFcUFiC4BdSWiqZoKb5aKgExs/WcXY7QIEfPXleQwiaoPwoK/VQI2f9
 CDGIoURjN1nlZXy54syyaX9HxL8qbkPGZXlXOEwQlpDBhGOQiS7Qc16hh2UiC9DdPAXjAg85fH3
 HynYL2FhGB6B9scXwZoGtOGqdDTViKSsxCBdTVUgLA+CFFOAPMPYGBlbJcwmB2NlkPbXqND5/cB
 71JmyEsW2FXYCGrxSPmyPXfiFqDIDcASd/oLAmgBaw+hQNJUJyN4A6ZdzcrevAzOXnkLQ9CKCKZ
 blRpRhEN0VHolbQ==
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

There's an incresing number of machines supporting multiple page sizes
and, on these machines, the host and a guest can be running with
different pages sizes.

In addition to this, there might be devices that have a required and/or
preferred page size for mapping memory.

In this series, we extend virtio_shm_region with a field to hold the
page size. The PCI and MMIO transports are updated to read the page
shift for each region and derive the page size accordingly. For the PCI
transport we're borrowing 8 bits from the 16 bit padding, so the
transition is seamless. But for MMIO we need to access a new register,
which could potentially be interpreted by the VMM as an error. For this
reason we're gating this behavior, for every transport, behind the
VIRTIO_F_SHM_PAGE_SIZE feature bit.

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
Changes in v4:
- Validate page_shift before deriving the page size from it
  (thanks Daniel Verkamp).
- Use an unsigned integer in left shift (thanks Daniel Verkamp).
- Link to v3: https://lore.kernel.org/r/20250220-virtio-shm-page-size-v3-0-874fff6f3979@redhat.com

Changes in v3:
- Merge patch 2 (virtio: introduce VIRTIO_F_SHM_PAGE_SIZE) into the
  changes for virtio-pci (thanks Dmitry Osipenko).
- In virtio_gpu_getparam_ioctl(), return ENOENT instead of EINVAL
  if the device lacks a host visible region (thanks Dmitry Osipenko).
- Link to v2: https://lore.kernel.org/r/20250214-virtio-shm-page-size-v2-0-aa1619e6908b@redhat.com

Changes in v2:
- Use "page_shift" instead of "page_size" in the transport-related
  structures to clarify its contents (thanks Daniel Verkamp).
- Update the command for "page_shift" in "virtio_pci_cap" to clarify
  that it's only relevant for VIRTIO_PCI_CAP_SHARED_MEMORY_CFG regions.
  (thanks Daniel Verkamp).
- Instead of a derived value, store page size in virtio_shm_region.
- Update the cover page to reflect that the functionality is gated
  behind the VIRTIO_F_SHM_PAGE_SIZE feature bit.
- Link to v1: https://lore.kernel.org/r/20250213-virtio-shm-page-size-v1-0-5ee1f9984350@redhat.com

---
Sergio Lopez (4):
      virtio: introduce VIRTIO_F_SHM_PAGE_SIZE
      virtio-pci: extend virtio_pci_cap with page_shift
      virtio-mmio: read shm region page size
      drm/virtio: add VIRTGPU_PARAM_HOST_SHM_PAGE_SIZE to params

 drivers/gpu/drm/virtio/virtgpu_ioctl.c |  5 +++++
 drivers/virtio/virtio_mmio.c           | 20 ++++++++++++++++++++
 drivers/virtio/virtio_pci_modern.c     | 32 ++++++++++++++++++++++++++++----
 drivers/virtio/virtio_ring.c           |  2 ++
 include/linux/virtio_config.h          |  1 +
 include/uapi/drm/virtgpu_drm.h         |  1 +
 include/uapi/linux/virtio_config.h     |  7 ++++++-
 include/uapi/linux/virtio_mmio.h       |  3 +++
 include/uapi/linux/virtio_pci.h        |  3 ++-
 9 files changed, 68 insertions(+), 6 deletions(-)
---
base-commit: 4dc1d1bec89864d8076e5ab314f86f46442bfb02
change-id: 20250213-virtio-shm-page-size-6e9a08c7ded1

Best regards,
-- 
Sergio Lopez <slp@redhat.com>


