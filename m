Return-Path: <linux-kernel+bounces-268440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 767329424A5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 05:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B6C285C4A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 03:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A923617BCC;
	Wed, 31 Jul 2024 03:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KkAyTvpV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2D818638
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 03:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722394807; cv=none; b=AV1HIh6Sjt6llqIjchS85T0dRWK1WLdNh/YUN+k3ZBnZSq0zVGUPOyvzipVk9eGzdo6vuxAL6iwSKbmx2nPTNQlRkRNWLGhdFDr2yLuprDxRKUAWstBZrBuYomhZuNLtcC3iSmXeXW7tAKNR236AizRp40JsDKj+L8dxtJ4UCB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722394807; c=relaxed/simple;
	bh=Q+Q1m+vLids3NlJc16uiC90sWDgJXboiteurhSqjF1M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=m1Thg8KymIB2/Txre7grvGeDCqhkjG2F1ZpKuhxwZKU1qtQ4t4SylHEfdyRaDlmt0Vva09iSY8T4G2luetZGgr0qqMEmvZ7wOKDNtHT2Fg+PZcY8s3iOV5bxW/PRhYsORM/KxKCDePVqnUBXu1sXeYVwddqO6OdhZMs0LCkH9hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KkAyTvpV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722394803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g3ueNxcpvWBth7FZxP9OVlHGH7k6EvAMvYrp/ny07d0=;
	b=KkAyTvpVz7XQtAUED6ZXnzef2tp6slA8gl8VIHiG9YOWyqfmZsrQEzGF3D8oQq9e41yr6L
	Lr3YVdaZ8t+ZAQCPJaFBgdZrpHR1kpDBwdFtjovleioDPJxfnbqZEhw7wqPhQfIt0dEkPY
	Gp/lCuSemSD8UHqQPtqo0oGcuCRK8qY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-QDOpaav9Oh-L1lZxILXxiw-1; Tue,
 30 Jul 2024 23:00:01 -0400
X-MC-Unique: QDOpaav9Oh-L1lZxILXxiw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1096719560B0;
	Wed, 31 Jul 2024 03:00:00 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.247])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 00A7819560AA;
	Wed, 31 Jul 2024 02:59:53 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4 net-next 0/3] virtio-net: synchronize op/admin state
Date: Wed, 31 Jul 2024 10:59:44 +0800
Message-ID: <20240731025947.23157-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi All:

This series tries to synchronize the operstate with the admin state
which allows the lower virtio-net to propagate the link status to the
upper devices like macvlan.

This is done by toggling carrier during ndo_open/stop while doing
other necessary serialization about the carrier settings during probe.

Changes since V3:

- when driver tries to enable config interrupt, check pending
  interrupt and execute the nofitication change callback if necessary
- do not unconditonally trigger the config space read
- do not set LINK_UP flag in ndo_open/close but depends on the
  notification change
- disable config change notification until ndo_open()
- read the link status under the rtnl_lock() to prevent a race with
  ndo_open()

Changes since V2:

- introduce config_driver_disabled and helpers
- schedule config change work unconditionally

Thanks

Jason Wang (3):
  virtio: rename virtio_config_enabled to virtio_config_core_enabled
  virtio: allow driver to disable the configure change notification
  virtio-net: synchronize operstate with admin state on up/down

 drivers/net/virtio_net.c | 84 ++++++++++++++++++++++++++--------------
 drivers/virtio/virtio.c  | 59 +++++++++++++++++++++-------
 include/linux/virtio.h   | 11 +++++-
 3 files changed, 109 insertions(+), 45 deletions(-)

-- 
2.31.1


