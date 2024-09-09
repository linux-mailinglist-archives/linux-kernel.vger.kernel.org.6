Return-Path: <linux-kernel+bounces-320529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BADD9970BA1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 04:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E69A51C21937
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 02:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5823ADDBB;
	Mon,  9 Sep 2024 02:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HfF3YmUs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EE1442F
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 02:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725847320; cv=none; b=V3Tz/lkQkkVX8ha4aET4K6T0WC6ZWWcfnXnHx1MWMgUH5BYU5SVt91oS1+bqS10vY2sX5Dit1pqAVmLsjZSmDMyjMaUBgeljvW6eNAyDdblJupvs8d/VbRelIWvqU/8XrXBd1tchGmDHIpzrWaxWoNn1mi5YqDIXPVHyZNNu9dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725847320; c=relaxed/simple;
	bh=VmhfseNk9AHOZDvhy9xbSUdOWBmV2+3XGFDw0hL1oY4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=H6iii21KNLWxbIE8jCXsQhtkY1ddLEIWr8lJPL5oTGii8d7amLAiAQURx2CmwnzSazaeaaANMug9ZNcFqD4zs+kTtCR9mLhmnAY17tKeXneX1cnbYGjpHd7VHNF/+u0wdticlTGcLpb0SJm583gd03gKi92ikHwYoqz7rMR10g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HfF3YmUs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725847317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RUTpt3GkwgsTxjL3oiazGHbXZH/pkvTdnmwVm/8Qn/k=;
	b=HfF3YmUsIcAuyJuC8DJchqjSen+Gx+PQg0JVU1tbtPBIeRt3R63jmoRzis6zFZ8dvFg+cC
	c6NQHw1Ota5Hjt6ZfhNB/GLjh6y9pFwY88+2wlwoa6DMT6FRClru9k1N5QrMSE6r6VENil
	Ei+xeO+y9e0jTh6+43a7ZgBYZlubJGI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-8av0JBzbMcSCb5Eo6_ur8w-1; Sun,
 08 Sep 2024 22:01:54 -0400
X-MC-Unique: 8av0JBzbMcSCb5Eo6_ur8w-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D98B19560BE;
	Mon,  9 Sep 2024 02:01:53 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.25])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CF5411956086;
	Mon,  9 Sep 2024 02:01:48 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [RESEND PATCH v1 0/7]vhost: Add support of kthread API
Date: Mon,  9 Sep 2024 10:00:38 +0800
Message-ID: <20240909020138.1245873-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),
vhost removed the support for the kthread API. However, there are
still situations where there is a request to use kthread.
In this PATCH, the support of kthread is added back. Additionally,
a module_param is added to enforce which mode we are using, and
a new UAPI is introduced to allow the userspace app to set the
mode they want to use.

Tested the user application with QEMU.

Cindy Lu (7):
  vhost: Add a new module_param for enable kthread
  vhost: Add kthread support in function vhost_worker_queue()
  vhost: Add kthread support in function vhost_workers_free()
  vhost: Add the vhost_worker to support kthread
  vhost: Add the cgroup related function
  vhost: Add kthread support in function vhost_worker_create
  vhost: Add new UAPI to support change to task mode

 drivers/vhost/vhost.c      | 246 +++++++++++++++++++++++++++++++++++--
 drivers/vhost/vhost.h      |   1 +
 include/uapi/linux/vhost.h |   2 +
 3 files changed, 240 insertions(+), 9 deletions(-)

-- 
2.45.0


