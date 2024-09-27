Return-Path: <linux-kernel+bounces-341937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C1A988895
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 17:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 354C2B20ACA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 15:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6311F1C1AA1;
	Fri, 27 Sep 2024 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIdYjV1q"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517BE1C172F
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 15:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727452431; cv=none; b=jdRennRwcnYwi22yXnA3NAxqhXZk9Q2KXUiuQl8mFm22dfGbFZEMbWhn6B74ATz1psxtJxYTdEbXtHsWSPEspGlSIckWKzH4jAKXB34bQ/o4WIMP0n4GqSKr6k2ajzxaNHadAf33vAgFW+lMrfQFolLMdRqUg/GakRQ4hkQLEY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727452431; c=relaxed/simple;
	bh=uboxNsRB7ArLOm3mSGXpF8THhv/G0jZ9YlhH+F8pR2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qeHtItaDR8RcrrpIjRItmtJLso//xIbxPkJloD8GzFLzGGJAptI1GOak+xr1k1GdSD5Bj04njuCvMHp5oZTA8msue3En+BbVGLaCO0FEHoXnTlTQzBTz12dNVo8fOD2v12V3KLrUAX1+UQLDdLCNnTlSRYBUFzUrA9rdpw3xIU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIdYjV1q; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c883459b19so990095a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727452429; x=1728057229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4IRmEJMqjv5amw97Du5XxRNvdkZ4L299x6VApzs7etY=;
        b=MIdYjV1qws+Y2QC+BX7Ww/5ANXRHp79vmWkHQ/5zpKlO9Hmhi0eV3YGvYGJ4MXDeFF
         0JBvuVbZQ9f0ZmG4b23wBzptKghCkwuCJgMxxs9ssNPsyc64In9bSFuIQbYL7aQEs9WS
         DJDbG4qNAurmS9nnzoHdWdVME0qj9qBBlni5FbyPQ6UqzuxLWRwZcVb7AoaK57+QNL6E
         YoNby3MQ/XkIAvuL2Ec1NbvPz9mm7/ybUwAqJxQQii7uHcqcy/TBvHOq0ckGw/AOwYad
         GxBUPmL5DLnCG+UkcrObiYl2gG8zgkL++IaFUJfX5XwkXnsYYAkro/9+TIrrglVEdmPi
         PTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727452429; x=1728057229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4IRmEJMqjv5amw97Du5XxRNvdkZ4L299x6VApzs7etY=;
        b=IV0W6fBD0NPb7wv44nW4PvnjvvVg7HxqSI9zb+8iZblfb0ajUE0q/vzwKgwJUqiSbF
         hg01fv48OAkIz51EIcOAA16VS6UhyqLiwCST+fGkt+7h7qQqX1pyMeoIq0MvikQI3ugK
         7DQu6L6u3wHD5JTa6Y3LXm84mgHVWiRCQuwGddhdljYy2UX8jeCGfYxl5b7yv6a/13gC
         uXHlEBezhzwddITI8aeM45MHBA1CM6PCdnI+FkE3JKeXuAflWXAFSBijX5LT9KTfd6il
         +4mpzSe6AuZGIm1WUAPilWkzaPlgfmBCjcEyPR4zTod6KFFKOKmcx5Nf5EmZQbcapY/O
         0f5w==
X-Forwarded-Encrypted: i=1; AJvYcCX7+fEGrGCrcauzCz5uMLSHI610k4dXVogqDthi3u1MubUp2u9MWEC+qzWESi7H9LVP+gUMR3zwzJNjFrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPfUSmSV3HfzqGHHzEEyA42yvjC2wnTo1J5uOkw/gSYpxwqRUJ
	jL98B2I0/OfmqyMNFKlppIhsGuFQa+sqe9gNYDeIuTZxVrxor6SVsmhIWK0k
X-Google-Smtp-Source: AGHT+IHMLG4fe4vh5hjZD6liBWNFix6vxIV8H4R21+IftzrGiEu+AGKa392WyEYa/bDKIoqpw+3ssw==
X-Received: by 2002:a17:906:4fc8:b0:a8d:3338:a492 with SMTP id a640c23a62f3a-a93c48f1d78mr284887966b.7.1727452428254;
        Fri, 27 Sep 2024 08:53:48 -0700 (PDT)
Received: from alessandro-pc.station (net-37-119-37-200.cust.vodafonedsl.it. [37.119.37.200])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c297bb9bsm146918766b.168.2024.09.27.08.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 08:53:47 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	anupnewsmail@gmail.com
Subject: [PATCH] virtio: Fixes errors: uninitialized symbol
Date: Fri, 27 Sep 2024 17:53:27 +0200
Message-ID: <20240927155330.450702-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fix solves multiple Smatch static checker uninitialized errors:

drivers/virtio/virtio_ring.c:1516 virtqueue_add_packed()
error: uninitialized symbol 'prev'.

drivers/virtio/virtio_ring.c:1524 virtqueue_add_packed()
error: uninitialized symbol 'head_flags'.

drivers/virtio/virtio_ring.c:645 virtqueue_add_split()
error: uninitialized symbol 'prev'.

Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---
 drivers/virtio/virtio_ring.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index be7309b1e860..001ea503d52c 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -553,7 +553,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	struct scatterlist *sg;
 	struct vring_desc *desc;
-	unsigned int i, n, avail, descs_used, prev, err_idx;
+	unsigned int i, n, avail, descs_used, prev = 0, err_idx;
 	int head;
 	bool indirect;
 
@@ -1411,8 +1411,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	struct vring_packed_desc *desc;
 	struct scatterlist *sg;
 	unsigned int i, n, c, descs_used, err_idx;
-	__le16 head_flags, flags;
-	u16 head, id, prev, curr, avail_used_flags;
+	__le16 head_flags = 0, flags;
+	u16 head, id, prev = 0, curr, avail_used_flags;
 	int err;
 
 	START_USE(vq);
-- 
2.43.0


