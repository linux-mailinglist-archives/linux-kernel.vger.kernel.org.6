Return-Path: <linux-kernel+bounces-291788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 611579566ED
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BDFA282B62
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53D215EFDF;
	Mon, 19 Aug 2024 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="giqTIwbD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D43D15EFA1
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724059749; cv=none; b=jcR9b/BSvf8Q2s6hSg2/G7ku0bSeOK2xOsCKGgVN3gHXE19Y0QKspdL8jCldEs4h5ShaV2cUMaPf1kdA8CoVAPWeIFGSxPIFU3aJRFRVK6w+GjlNDcA5SbmnCi7hWC8IH63VDf4DRG6XZs7neNYMG80GKW54PpKhEHuxw+b3+qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724059749; c=relaxed/simple;
	bh=oxbJ9jgS2b3BWhr+6VbYkYj8MiliVXAlFphhBQv+NcI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mFAhXsdmPYUr55RuHv39g39AQGPbEXbSVIEdmk45MqHLCAXiH9YGMRS75YVqCx6/g1RMlo31OQ/3LMfPyZF0j/AMC2fiJcDVmIZLdGEyxtQolm7MHWEcKpNfZ7U6Mqj/8Dslc/wn0Oc0JLu0I0auNQn8Z61mHtTP/fcfSofLV9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=giqTIwbD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724059746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U5wQYM12MCFSqwdIiZqRbT7zjsGp18nCTllg/pw0PFI=;
	b=giqTIwbDfT666cwgNfkq+jGq/+qF3G+oI6ZXi1jmimTAl5mplZlwIIRK1dei1p93Cg9SWG
	UssGolS3OGvR+RoOqFgMhPeRLvREwr1HZxs2kr815L6XK01Kc3mKl1E7oafcijyQ2XOHGN
	PItwwdRDFtD8oqWfoOXIsS5v7ipoOEM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-ITxHquRrO0CXaNpk9lwQGw-1; Mon,
 19 Aug 2024 05:29:03 -0400
X-MC-Unique: ITxHquRrO0CXaNpk9lwQGw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 830881954B15;
	Mon, 19 Aug 2024 09:29:02 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.11])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 92F4B195605A;
	Mon, 19 Aug 2024 09:28:58 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [RFC 0/7] vhost: Add support of kthread API
Date: Mon, 19 Aug 2024 17:27:26 +0800
Message-ID: <20240819092851.441670-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),
vhost removed the support for the kthread API. However, there are
still situations where there is a request to use kthread.
In this RFC, the support of kthread is added back. Additionally,
a module_param is added to identify which mode we are using, and
a new UAPI is introduced to allow the userspace app to set the
mode they want to use.

Cindy Lu (7):
  vhost: Add a new module_param for enable kthread
  vhost: Add kthread support in function vhost_worker_queue()
  vhost: Add kthread support in function vhost_workers_free()
  vhost: Add the vhost_worker to support kthread
  vhost: Add the cgroup related function
  vhost: Add kthread support in function vhost_worker_create
  vhost: Add new UAPI to support changing Kthread mode

 drivers/vhost/vhost.c      | 241 +++++++++++++++++++++++++++++++++++--
 drivers/vhost/vhost.h      |   1 +
 include/uapi/linux/vhost.h |   2 +
 3 files changed, 235 insertions(+), 9 deletions(-)

-- 
2.45.0


