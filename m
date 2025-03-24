Return-Path: <linux-kernel+bounces-573161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF35A6D3C5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 06:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BC5E7A50EB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 05:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D583919007F;
	Mon, 24 Mar 2025 05:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNDW4DOT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF0918E76F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 05:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742795027; cv=none; b=rR76Cjpy6G+AoMQPPhfqp54xsSiYLuxpaVYuTOWNSKMcR1OuuFKmqXLZpIAB9rD6z27iZ/1DyFRPXVaVzibEIrT+NK16ZfcMMtYSi1ihjsPjS/1SJBVUAIL1QnwxlsEHqZsP3Oz9WyAIV4t6BVo50AYziAkbvLB9hVKvuZ0P/j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742795027; c=relaxed/simple;
	bh=PWQNwj4o+97umD22mpG4yFt/EhzSO5pYFCiU+qailsA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=Bs9ChUjHkRh1LfSjNd7EFwates9bKPlm3g+Ae1kJxrEHTTGKplt51O1nIcnDWvuiDGMvnnQ3Fiu/NBhOjXqKqeDtJ/Ey+dV6lImOHh04Z36zPi8DxLg6d5emXhNH89QuJn+GaBB7NroSmXgZ1Sdr9atDBrj8V0Gfrblnogs8Cso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VNDW4DOT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742795024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rxalDJd2tioM926pC9tYvVuvYVo1mSFnpX2boX7T/cI=;
	b=VNDW4DOTWCdoKcaDCRT+mHu8SmEIwmHVhvlU+CZeisZ2z1TjYBiJepjuFCImes9pDSPcQK
	eKWfplfhfImKYwRGmkXmRAulRFhF7/AvG0XteVeeWym8c7lA/Dx1PGpxH+MrVMvhWsc8Jv
	edqa+FwiE0Eh1yaaN0z/LpvX0sYZ2HA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-Y_mElzBVMxu0EZ2Eq5enpg-1; Mon,
 24 Mar 2025 01:43:42 -0400
X-MC-Unique: Y_mElzBVMxu0EZ2Eq5enpg-1
X-Mimecast-MFC-AGG-ID: Y_mElzBVMxu0EZ2Eq5enpg_1742795021
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0969B1801A07;
	Mon, 24 Mar 2025 05:43:41 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.200])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 46465180A801;
	Mon, 24 Mar 2025 05:43:36 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/19] virtio_ring in order support
Date: Mon, 24 Mar 2025 13:43:14 +0800
Message-ID: <20250324054333.1954-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hello all:

This sereis tries to implement the VIRTIO_F_IN_ORDER to
virtio_ring. This is done by introducing virtqueue ops so we can
implement separate helpers for different virtqueue layout/features
then the in-order were implmeented on top.

Tests shows 5% imporvemnt in RX PPS with KVM guest + testpmd on the
host.

Please review.

Thanks

Jason Wang (19):
  virtio_ring: rename virtqueue_reinit_xxx to virtqueue_reset_xxx()
  virtio_ring: switch to use vring_virtqueue in virtqueue_poll variants
  virtio_ring: unify logic of virtqueue_poll() and more_used()
  virtio_ring: switch to use vring_virtqueue for virtqueue resize
    variants
  virtio_ring: switch to use vring_virtqueue for virtqueue_kick_prepare
    variants
  virtio_ring: switch to use vring_virtqueue for virtqueue_add variants
  virtio: switch to use vring_virtqueue for virtqueue_add variants
  virtio_ring: switch to use vring_virtqueue for enable_cb_prepare
    variants
  virtio_ring: use vring_virtqueue for enable_cb_delayed variants
  virtio_ring: switch to use vring_virtqueue for disable_cb variants
  virtio_ring: switch to use vring_virtqueue for detach_unused_buf
    variants
  virtio_ring: use u16 for last_used_idx in virtqueue_poll_split()
  virtio_ring: introduce virtqueue ops
  virtio_ring: determine descriptor flags at one time
  virtio_ring: factor out core logic of buffer detaching
  virtio_ring: factor out core logic for updating last_used_idx
  virtio_ring: move next_avail_idx to vring_virtqueue
  virtio_ring: factor out split indirect detaching logic
  virtio_ring: add in order support

 drivers/virtio/virtio_ring.c | 856 ++++++++++++++++++++++++++---------
 1 file changed, 653 insertions(+), 203 deletions(-)

-- 
2.42.0


