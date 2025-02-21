Return-Path: <linux-kernel+bounces-526307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C00A3FD22
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 205D0865A5D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2AB24E4C0;
	Fri, 21 Feb 2025 17:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DbuGiDjU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8B824C694
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 17:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740157630; cv=none; b=V3BqaVE5IlF90ooXytUINT14tY7ukMLCo1DYijAFMoWEG7oCl+4qj99NgCJ1jiKhzbjYgfu/oYb7wgmPDOvcHbeWpW0qBWBHx+AwwyBzTmm8PM+Z5wLRBstyJBi7n0s4kKd8gtVzjC76DL3gy9559atm5mCmElZshvhPsVbF/IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740157630; c=relaxed/simple;
	bh=kk51s7J3anVkFfT7F/aodbxST59c5FZiYH2rR7cImhk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RZkogCcWmvGPQz50NxjDm4SI+f7eiQwygUrbwO/8CKv6M2Uwl8LL4L+aNCauKLWXB6h89mSZd11fiPMs4fSzB655DA9xM841P7uUGfa9AvtCnxEuR1onrrQz2nqYyaA8G1b4KeT7OCG4K0/m/O50EqRSvsbRygmUNXBNfLOLYQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DbuGiDjU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740157627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5VKeHk03WHwQgaZaTfgIKUzZliixkLtjHpWevmfgD1Q=;
	b=DbuGiDjUkB0j5jrudUc1ayFyzUiK73zHM7+lcYGfnmL+RdrHXP/qR3dvwsLu2tnheC4iZT
	eSfHqQDl+Y/wFp5B13pzJ2Ebr9Z1J8Gc4jtjgYJdAcqOSoLDhvyrxn0gMYKdigF2kQfe9v
	7e6Xxhq16hMG7X+aK2IRdsH/oW9VJ0c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-P476CK1tOI2mKZv3PlzE8Q-1; Fri,
 21 Feb 2025 12:07:03 -0500
X-MC-Unique: P476CK1tOI2mKZv3PlzE8Q-1
X-Mimecast-MFC-AGG-ID: P476CK1tOI2mKZv3PlzE8Q_1740157622
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5BE6618D95F3;
	Fri, 21 Feb 2025 17:07:02 +0000 (UTC)
Received: from eperezma-thinkpadt480s.rmtes.csb (unknown [10.44.32.170])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D9AD51800358;
	Fri, 21 Feb 2025 17:06:57 +0000 (UTC)
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
Subject: [RFC v2 5/5] virtiofs: Disable notifications more aggresively
Date: Fri, 21 Feb 2025 18:06:26 +0100
Message-ID: <20250221170626.261687-6-eperezma@redhat.com>
In-Reply-To: <20250221170626.261687-1-eperezma@redhat.com>
References: <20250221170626.261687-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Disable notifications right before scheduling, instead of waiting until
the work is running.

After applying this patch, fio read test goes from 1191MiB/s to
1263.14Mib/s

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 fs/fuse/virtio_fs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index e19c78f2480e..3d6981c0f3c3 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -915,6 +915,8 @@ static void virtio_fs_vq_done(struct virtqueue *vq)
 
 	dev_dbg(&vq->vdev->dev, "%s %s\n", __func__, fsvq->name);
 
+	/* Shceduled, don't send more notifications */
+	virtqueue_disable_cb(vq);
 	schedule_work(&fsvq->done_work);
 }
 
-- 
2.48.1


