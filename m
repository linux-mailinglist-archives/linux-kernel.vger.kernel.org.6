Return-Path: <linux-kernel+bounces-526302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7ABA3FCEC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A44D47B0F70
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5495424BD13;
	Fri, 21 Feb 2025 17:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b52MpnWz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1256924C66A
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 17:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740157602; cv=none; b=iSyLb2cAztFj0UBdYihiWVEVbWKJ5bxy2774NqeKHqO8idoy5eR0gk408o2o3Tk5rDQ+/69J2vIDum2k1YLDcxZMxOBzCd1MicYWRqpm3+v2TVBm59E4OoZJNIRgAR9/UnqB0QofanplKiLBxe/4gh4CDwWu7J38UhXe01A45fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740157602; c=relaxed/simple;
	bh=V6EaOwBFX+1JslXbpLD2c1d1PfxGv3uM7IyU5g8Z3Cc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uIc3k3fUlg9L90OlKj2uRjxe0Qw1jsAlY4LZeVUbK5hM6KvexhgAZFomfD8xi+dkwJqnwO7RTc1wemgxVKnZL0eCu2KO9YbQ6XGTI+HbBTuH/FB6LDo2pd8keLcb/zAw2W4a3CjSwGW0xqULq7L/s4GFeKBQ2iB4wTtV8V54z8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b52MpnWz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740157600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DPPgpqmJ+YG+3SDYIopKnv0LWWUDy/TFlJMPIfTEKMg=;
	b=b52MpnWz/6a3ZSxAMGm3HV2jRnMmjdNEZpTV/To9h4Kej8jNqzV4Ylh9y8DEB8hUlRaF2O
	czCINp56p9E+8+Qvcn0+IahOGUslHs49IL+COtllkLOu99zogCL346oYq/iLpGGymB7dV/
	/PdzLBzbhShysfghoQI7BAqvk/+QDj0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-qWK9XoGDPdaBm1ZGtoM1Qg-1; Fri,
 21 Feb 2025 12:06:36 -0500
X-MC-Unique: qWK9XoGDPdaBm1ZGtoM1Qg-1
X-Mimecast-MFC-AGG-ID: qWK9XoGDPdaBm1ZGtoM1Qg_1740157595
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DCABA180036F;
	Fri, 21 Feb 2025 17:06:34 +0000 (UTC)
Received: from eperezma-thinkpadt480s.rmtes.csb (unknown [10.44.32.170])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 453CD180094B;
	Fri, 21 Feb 2025 17:06:28 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	linux-kernel@vger.kernel.org,
	German Maglione <gmaglione@redhat.com>,
	virtualization@lists.linux.dev,
	Stefano Garzarella <sgarzare@redhat.com>,
	yama@redhat.com,
	Vivek Goyal <vgoyal@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	mst@redhat.com,
	Jason Wang <jasowang@redhat.com>
Subject: [RFC v2 0/5] virtiofs: map buffer out of virtqueue lock
Date: Fri, 21 Feb 2025 18:06:21 +0100
Message-ID: <20250221170626.261687-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This is useful for some setups like swiotlb or VDUSE where the DMA
operations are expensive and/or need to be performed with a write lock.

After applying these patches, fio read test goes from 1124MiB/s to
1263.14MiB/s.

v2:
* Follow current add_premapped virtio API
* Disable notification more aggressive too.

---
Sending this series to obtain feedback if this is the right way to go &
to profile it properly.

TODO: Profile multiqueue.
TODO: Handling errors.
TODO: Do the same for hiprio queue.
TODO: Can we batch maps? virtiofs always sends many buffers.

Eugenio Pérez (5):
  vduse: add virtio_fs to allowed dev id
  virtiofs: Move stack sg to fuse_req
  virtio_ring: add api for premapped out and in buffer chain
  virtiofs: perform DMA operations out of the spinlock
  virtiofs: Disable notifications more aggresively

 drivers/vdpa/vdpa_user/vduse_dev.c |  1 +
 drivers/virtio/virtio_ring.c       | 35 ++++++++++++
 fs/fuse/fuse_i.h                   |  7 +++
 fs/fuse/virtio_fs.c                | 85 +++++++++++++++++++++---------
 include/linux/virtio.h             |  7 +++
 5 files changed, 110 insertions(+), 25 deletions(-)

-- 
2.48.1


