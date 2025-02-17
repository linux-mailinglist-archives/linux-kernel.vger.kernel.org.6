Return-Path: <linux-kernel+bounces-515174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B31AAA36146
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E7927A1AB3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F089245B1B;
	Fri, 14 Feb 2025 15:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+rh6DFI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C974D8C8
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739546244; cv=none; b=K6cdQTSepk7uJ6yS7rDnTedhoKz09/LJp6m55HsCy9QQmyAtE/WLjkb8uP/88CyWHzheFCMpYdx4sVu9xLUgFpUla6Q2xp6eVbANphBUaiSProngd8p5uqDSVUY+mdUWc14EvTaAMpFld0FEAjdY3Dajxu7RQ4DQFQjCm8Pycrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739546244; c=relaxed/simple;
	bh=LawTWS7KOXk3HVDTnMegANC7KH7FoN89BtX6z8oH154=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MJhoOI867ZQsLw0jCdgmCUpdN1ajFSUJU88/09GuR0JqoDRFyktRVnmj6n7gIm4OUnE0AwKnMj+L5VJ0E0yhgpnteQpHs/+jRTMdEchtR74vkhdpxn6i3Ar0psK1vh++dZSu6Ga3xY1vRi6QAaDMmCMI562M+0+v88nog7kWORs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A+rh6DFI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739546241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Bm3yPaKny4y1a4wn4hjcXyuIFC/DbFK31ecJtKtC8CY=;
	b=A+rh6DFIWyj+gl/INB9hTBjq1LGwx06SUzXl3EDnT6IBURUuOejQfZWNu6KPtsQ0MPhr0s
	kw7lm7xtL5DE9AKVlWxIvjZAEfzV0v9aEarXS0TQQMOEVgOsbWqAUb1TQ2fNtIveAPLyoH
	Q6182OhC4ekNucZ+i3HWU+Ig3mqaTps=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-nAru-cGAMM6QP76sQBfVCg-1; Fri,
 14 Feb 2025 10:17:15 -0500
X-MC-Unique: nAru-cGAMM6QP76sQBfVCg-1
X-Mimecast-MFC-AGG-ID: nAru-cGAMM6QP76sQBfVCg_1739546234
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C7861801A0D;
	Fri, 14 Feb 2025 15:17:13 +0000 (UTC)
Received: from [127.0.1.1] (unknown [10.45.225.8])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 32F8919373C4;
	Fri, 14 Feb 2025 15:17:05 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
Subject: [RFC PATCH v2 0/5] virtio: obtain SHM page size from device
Date: Fri, 14 Feb 2025 16:16:54 +0100
Message-Id: <20250214-virtio-shm-page-size-v2-0-aa1619e6908b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGZer2cC/4WNQQ7CIBBFr9LM2jFARUtX3sN0QcpUZtHSQEPUh
 ruLvYDL93/++zskikwJ+maHSJkTh6WCOjUwers8CdlVBiWUFkq2mDluHDD5GVdb68QfwisZK7r
 x5shJqNM10sSvQ/sYKntOW4jv4yXLX/pHmCUK1ERyMqa7tFrcIzlvt/MYZhhKKV9XI3N+uQAAA
 A==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2945; i=slp@redhat.com;
 h=from:subject:message-id; bh=LawTWS7KOXk3HVDTnMegANC7KH7FoN89BtX6z8oH154=;
 b=owEBbQKS/ZANAwAIAfRpJ40vDAI1AcsmYgBnr15rLEbtSDv1wv6zy9aRQxVCJWKd6CqI6u8yW
 fu5t99W2b+JAjMEAAEIAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCZ69eawAKCRD0aSeNLwwC
 NcAOEACk2q7//SbCHM1dsPBaw1RmOdp75RLuucyZOvzjc8AIQwARgRZZUnJzr/7FVlqx872Voz9
 Q14izG3P5VKkJ9OB2qrCFiBBYMKuVGxryryE2rgXE95K4Epsoz6VM8nuqtGlvFuwTdt5ozVMjfA
 PhQ8WCKeS8cl2Bu+cj6GTYdu9rJDuCHmquAhOpJ9ADabT8M1tZTZ1hsiibudt3WAQoDGMluiRW2
 XqrlpaAgOYE+ROMUwaIcLi7lj0WrIyiDZ8+oS8dJzSXNGID4CeA8c6y1oSJOgy/TQeWMXOeGHWp
 eVbf83LQhbnSUAn99kRfB8ucM6ntpXRdpb3evInFU/jDoLhcEJgurOkVYIURiOk+63kckQ5NTuQ
 /EXaXcyMdvwBwYTuVxSxsJaXOiVzxiMUh3eZm9X1YORj5s2Fuu1xya6FIEXD7eAcMxPhxD3G+7o
 v/dGt+EF/avClopZwDSs5jqkyDH0Xg3FgXI6EPnaFFZpgWqS63CXPjdKFYr4vVJfUlZWAtvLTyo
 JdL8uJlX7XfD3D6UdlVNNKemZsZEGVXCTIGi6SmyMC9URKI3xCxZjGH1+NJSiYuMvhaFVTbfjDM
 cLuWGx9vXnLuY6fHZnBd/Chj61DysyTZMzBugc54InQRUIi3kHk3m0CSM0gr2bwa4op3GT2CBJg
 m0JZEH0rGSTFG0w==
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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
Sergio Lopez (5):
      virtio_config: add page_size field to virtio_shm_region
      virtio: introduce VIRTIO_F_SHM_PAGE_SIZE
      virtio-pci: extend virtio_pci_cap with page_shift
      virtio-mmio: read shm region page size
      drm/virtio: add VIRTGPU_PARAM_HOST_SHM_PAGE_SIZE to params

 drivers/gpu/drm/virtio/virtgpu_ioctl.c |  5 +++++
 drivers/virtio/virtio_mmio.c           | 11 +++++++++++
 drivers/virtio/virtio_pci_modern.c     | 24 ++++++++++++++++++++----
 drivers/virtio/virtio_ring.c           |  2 ++
 include/linux/virtio_config.h          |  1 +
 include/uapi/drm/virtgpu_drm.h         |  1 +
 include/uapi/linux/virtio_config.h     |  7 ++++++-
 include/uapi/linux/virtio_mmio.h       |  3 +++
 include/uapi/linux/virtio_pci.h        |  3 ++-
 9 files changed, 51 insertions(+), 6 deletions(-)
---
base-commit: 4dc1d1bec89864d8076e5ab314f86f46442bfb02
change-id: 20250213-virtio-shm-page-size-6e9a08c7ded1

Best regards,
-- 
Sergio Lopez <slp@redhat.com>


