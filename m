Return-Path: <linux-kernel+bounces-349847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD6998FC22
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 04:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 296F61C2302A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 02:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6404C62A;
	Fri,  4 Oct 2024 02:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KHj/ZjC3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2214AECE
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 02:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728007242; cv=none; b=luMnQfee+TY7Yk5He0exLFzQPUD3UVnromUg8UvWs2NuS2G0H/iJZsz+B7jmklrfXo0lNf/+DR26ocCeNZi46HWbTm1QM5ZRmGSJkv4lXNGxt83sKf2o8x01wGKj5ciFTwtKdUxlv9wKDPM2OdRqPwgSy7xjeLcbML5v/tbAb2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728007242; c=relaxed/simple;
	bh=gM+UhBnXUXjuBqKMUIBkJEkaZoSzsbYH910Eh3g1cjY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aFNGvPOnvYNPXA6RSLY4xuWjC8Vul5G5P/JWaBZnGyW35qvWDNMxbryeLsrjwcIKhR8HBh9SfjBI6ycgEE1Sjax0PAC3CZ1eZBG8JzGe8menQ2Amng2i61e/+UeXTZZ1T7tsVsHiyfdqkuTHjVlGBaCHMfiUY8qPB8cUcMvmvHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KHj/ZjC3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728007239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ubHS+/4Up+CXlv+MFQxp5V5OJdlnjpJuzakK52oVNZ0=;
	b=KHj/ZjC32BxaHbiD5FBjK55Ra4doDi+5yZO1oW0U0jK6K1NdOSveFAXSGiC2SxaLikrJ6f
	STNcVUrv5vZDGm87QSrf7L/fd781cTXI4WVgJTP63MqlPgHRmhEyAQD2pg3S3YcZHpW6U7
	v1htb8fLBQva3jHDPBj0QFHQhgH5dHc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-jfNAovzgPhyIIdrDehespw-1; Thu,
 03 Oct 2024 22:00:38 -0400
X-MC-Unique: jfNAovzgPhyIIdrDehespw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99D9A195608A;
	Fri,  4 Oct 2024 02:00:37 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.45])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3EC3C19560A2;
	Fri,  4 Oct 2024 02:00:33 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v2 7/7] vhost: Add new UAPI to support change to task mode
Date: Fri,  4 Oct 2024 09:58:21 +0800
Message-ID: <20241004015937.2286459-8-lulu@redhat.com>
In-Reply-To: <20241004015937.2286459-1-lulu@redhat.com>
References: <20241004015937.2286459-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add a new UAPI to support setting the vhost device to
use task mode. The user space application needs to use
VHOST_SET_INHERIT_FROM_OWNER to set the mode.
This setting must be set before VHOST_SET_OWNER is set.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c      | 18 +++++++++++++++++-
 include/uapi/linux/vhost.h |  2 ++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 08c9e77916ca..0e5c81026acd 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2341,8 +2341,24 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
 {
 	struct eventfd_ctx *ctx;
 	u64 p;
-	long r;
+	long r = 0;
 	int i, fd;
+	bool inherit_owner;
+
+	if (ioctl == VHOST_SET_INHERIT_FROM_OWNER) {
+		/* Is there an owner already? */
+		if (vhost_dev_has_owner(d)) {
+			r = -EBUSY;
+			goto done;
+		}
+		if (copy_from_user(&inherit_owner, argp,
+				   sizeof(inherit_owner))) {
+			r = -EFAULT;
+			goto done;
+		}
+		enforce_inherit_owner = inherit_owner;
+		goto done;
+	}
 
 	/* If you are not the owner, you can become one */
 	if (ioctl == VHOST_SET_OWNER) {
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index b95dd84eef2d..1e192038633d 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -235,4 +235,6 @@
  */
 #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
 					      struct vhost_vring_state)
+
+#define VHOST_SET_INHERIT_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, bool)
 #endif
-- 
2.45.0


