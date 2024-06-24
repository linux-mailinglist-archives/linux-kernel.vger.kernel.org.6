Return-Path: <linux-kernel+bounces-226582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 331E691409B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 04:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4378281049
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 02:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99B779EA;
	Mon, 24 Jun 2024 02:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J9UVjswd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B516D3C17
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 02:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719197144; cv=none; b=bsHYIXZPVd+9V3M/NH5rQWHGIWdapr+JPq/o53RVr7Kr7ChlL5EPGyRhmpakH/HUvaaLbOAuLfpI2coBYUyajIQg9fQoZmdYaeqys094E/0OhHtiamwoJV/5Z4B1BJYWBQ9Y9ukbkCbY4JRabmk2oLGsNfXLAUdwuyQEx33nfZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719197144; c=relaxed/simple;
	bh=XC92MEoBDuw+dzFXqg9PSnivP55kcPz5nKy8QVj2YPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ohHdKfsfMYhBcctuudKPiiuw7b6rCNyLl4RNnF8r0Kusrexh9rxdXJl+XUDGpWpqEuWcsRYSninmknVnbGURkKAoqlq0RNJcR5bOWTPDMhLIMTsFqgCDyqdCQ7akdNDeJ5LHOT+ezPZ6uYNTo/seIQvvMH7p0uZ/pw48TG0ZpOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J9UVjswd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719197141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CXcVRtn1cUdwEJYQmAZMfv47gdXae0jBBlAV4W8th1w=;
	b=J9UVjswdcfL8miJ1RFBxgvV5JpYRTFdFVT/HlmGqhuk2Bjg2BenQawA/RFi3ccblOMLLbT
	3Aj9UplqH/xZUDvUZlX9mFYLrtj2gLYWcHe4MQCc7mkxIUgyI+e+GuE9O125rh1Bf49dlY
	fITFTFa/qpH5jiQRHchd6TNjABw75Ho=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-mTyUWo52McarW2ud3gBJtg-1; Sun,
 23 Jun 2024 22:45:37 -0400
X-MC-Unique: mTyUWo52McarW2ud3gBJtg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 76752195608C;
	Mon, 24 Jun 2024 02:45:35 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.150])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8D0AF3000218;
	Mon, 24 Jun 2024 02:45:27 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	venkat.x.venkatsubra@oracle.com,
	gia-khanh.nguyen@oracle.com
Subject: [PATCH V2 0/3] virtio-net: synchronize operstate with admin state on up/down
Date: Mon, 24 Jun 2024 10:45:20 +0800
Message-ID: <20240624024523.34272-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi All:

Currently, we don't synchronize the opersteate with the admin state
currently when prevent the link status to be propagated to the stacked
device on top of the virtio-net.

This patch fixes this issue.

Changes since V1:
- Try to reuse the virtio core facility to enable and disable the
  configure interrupt

Jason Wang (3):
  virtio: allow nested disabling of the configure interrupt
  virtio: export virtio_config_{enable|disable}()
  virtio-net: synchronize operstate with admin state on up/down

 drivers/net/virtio_net.c | 72 +++++++++++++++++++++++-----------------
 drivers/virtio/virtio.c  | 26 ++++++++++-----
 include/linux/virtio.h   |  5 ++-
 3 files changed, 63 insertions(+), 40 deletions(-)

-- 
2.31.1


