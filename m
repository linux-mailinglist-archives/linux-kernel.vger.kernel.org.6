Return-Path: <linux-kernel+bounces-527797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2196CA40F90
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 16:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 628691898E41
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 15:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCDC20C494;
	Sun, 23 Feb 2025 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ekcyK6do"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A278A20C485
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 15:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740325313; cv=none; b=mQ3nF5Q1mNQ4hZ1RV3fvFjH7kqmsIJOL+sHzaXcH1W4zmr0Fdh20HoGnetxytGejxOhI9+mgNqUOY4d/2ddzSHSYuG1aEv4+0BieUb/pFYa9uvpf/HaEYEPl48A1xK7HPMG/Cf8auennXirhHkDIZ2WEi2yOp3oeArkg2/ZDgOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740325313; c=relaxed/simple;
	bh=ZGGr8CpUC2KsJpl4JTjnc3CvTn1h9z7S+oOYdP7bE20=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mTUP6BR7WM6ko4mEioWEdMBQ2H7erQ+mvq81WmIVe1xqHePY+FQNO3w40BV1Va8aOti5ZY085i3NqYpRvMGpILgca5b9mIsb2ni0eQUj3Wm7+HuzP6Fh1vyvitkDd+9CTnOQDzQxqP6lvSYX6QbfpTzNAgQKgXe/PoG8C0piDS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ekcyK6do; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740325310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qvywjBt9qiVEE9rGZyn5DkXXMEjJbM4TB/T7cbHYBEo=;
	b=ekcyK6doPUsgd4oGouRVmFk54JqHpXUzte+i/MqkMb7rxnppRJuSDxvELwS+aRRVsAtqOQ
	FfFt9NAc/sxlpJT0i+z2rEaAZJqjd+urSzU0mYIR9DNArw/fRWPqLC9SsdeGjZsajZEg1I
	xdApWG14J80Nx1CWd2aIYffpFNH5yzc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-B0X9Vo8lOo6-dJW4ojwo4g-1; Sun,
 23 Feb 2025 10:41:47 -0500
X-MC-Unique: B0X9Vo8lOo6-dJW4ojwo4g-1
X-Mimecast-MFC-AGG-ID: B0X9Vo8lOo6-dJW4ojwo4g_1740325304
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9510519783BA;
	Sun, 23 Feb 2025 15:41:44 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.28])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1EEEE1800359;
	Sun, 23 Feb 2025 15:41:39 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v6 6/6] vhost: Add check for inherit_owner status
Date: Sun, 23 Feb 2025 23:36:21 +0800
Message-ID: <20250223154042.556001-7-lulu@redhat.com>
In-Reply-To: <20250223154042.556001-1-lulu@redhat.com>
References: <20250223154042.556001-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The VHOST_NEW_WORKER requires the inherit_owner
setting to be true. So we need to add a check for this.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 45d8f5c5bca9..26da561c6685 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1017,6 +1017,13 @@ long vhost_worker_ioctl(struct vhost_dev *dev, unsigned int ioctl,
 	switch (ioctl) {
 	/* dev worker ioctls */
 	case VHOST_NEW_WORKER:
+		/*
+		 * vhost_tasks will account for worker threads under the parent's
+		 * NPROC value but kthreads do not. To avoid userspace overflowing
+		 * the system with worker threads inherit_owner must be true.
+		 */
+		if (!dev->inherit_owner)
+			return -EFAULT;
 		ret = vhost_new_worker(dev, &state);
 		if (!ret && copy_to_user(argp, &state, sizeof(state)))
 			ret = -EFAULT;
-- 
2.45.0


