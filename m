Return-Path: <linux-kernel+bounces-326749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 571DF976C85
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89DAC1C2386C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECDE1B9826;
	Thu, 12 Sep 2024 14:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hXZc3PIm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB541ACDF9
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726152354; cv=none; b=TQGLrp3DOf7x3p1rq55gCV9oBPODj4HF+m/v2y9aYLndhOXzkpsKGr+x2ulZprZUXQQD6jLnFMJ2MG0W6z0C4O8NIlWyU7KkN0zijEgxP9Gac+QnJ2Yj5FQpT+hu7B+aKWxw4MYIYDTzUjSIkdJL2PXoY6510x4PR2j/QyjfLwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726152354; c=relaxed/simple;
	bh=bDNWpJKzhrF3VLCZRlkouzN2c2h29O1kt92gs8u0Cd8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=binJ5++AhqpeksfoNwuu4GjzHh7jMqoIDBzpFaGEuER0oMwLoVCT3/5XppW3hi5uO1bNyCuM9CPedc7Z7ZMFaXWz1Crj8cOwnkryOAvkTSU3dB8LmJ4FS99BJrRoe427p/jBsE70tGCW0leRWXgj/X8h19dgdRm0fbPp+x4dT5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hXZc3PIm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726152351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Gxo+YbK0LSE4pTUF6ewOWgrq+3ntyBNDfI8Bopy+BNM=;
	b=hXZc3PImd1Z1Hk2RJi5l2ZySbvhaPbj7oZCDXi6R6cfXf7w/CNywi6wBFd9XYlmmb9hVqd
	MAK+2d4MTrUK18s/uDkDRnhWb0bjTMoJr/DXB6GqICVRu9nVTFuMX4IgBKAlAlRXKb5yYO
	kkpKwR0W9qjqh+SKpFVjGa/AZttvOMs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-VofHZyVSNqeEYxHjVuCrrw-1; Thu, 12 Sep 2024 10:45:50 -0400
X-MC-Unique: VofHZyVSNqeEYxHjVuCrrw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cceb06940so7866755e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726152349; x=1726757149;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gxo+YbK0LSE4pTUF6ewOWgrq+3ntyBNDfI8Bopy+BNM=;
        b=UPrX8S/As1dth+5N14bqGn9Px9MN9bBJvjRZcJL9KbQi/77fem4m4igVlAoCYPhzA5
         JJoJmVDl2oEXSgbNxnPTBnCtTD/suLwAQdTcNayXNGkGLSy3uLOx9UuJTzPCu2wqF+Cy
         KOXkJnQHrIWbM8sVCEXrVyWjGUTAaf09XipaohHyAiceKRhavBLxT7laCYcaT31Qwa6I
         BcR/hdEaOOJVgcDp2loeKen6yz9TuHEhSD5PP2Q/XRXI3bAyUkOEAagcCar8CNum8y6U
         BCrV15dsN10wvhpOuZuDDqXggilET3Vb7SXrAKy2WkvStp1nTTO3a/NtixkY2fSaEsxO
         IC7g==
X-Gm-Message-State: AOJu0Yy81XPyXW74PpmgxaYiF3zx+7SCxT804vn509PwJ3Cgr2B7opqA
	qf6oMWgkOaFUKZih0ToYbXxClP0QtsshxkUwXyfIY6CbFTsaPutuv4tbps9zXdUpcBCi6OOFcjV
	5DzggJJJGI4bHA0bV3+zQ/J9+yuP9mGEoDCNhsWg/KMD1CJPACkOSrcaFax2inLwerRiOZGCO1W
	EMvYeorB4kbIghg32j1sXFSMe51zuPjMHDQhrxBdI=
X-Received: by 2002:a05:600c:3581:b0:42c:c401:6d67 with SMTP id 5b1f17b1804b1-42cdb4e6966mr24733365e9.6.1726152348691;
        Thu, 12 Sep 2024 07:45:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSTr4UGE5sTddlBtoIDKITpSKo52BFe23QJb7ewHaHb9juwa9mzhKxt4NIv4kesVcFbq/Fzg==
X-Received: by 2002:a05:600c:3581:b0:42c:c401:6d67 with SMTP id 5b1f17b1804b1-42cdb4e6966mr24732825e9.6.1726152347628;
        Thu, 12 Sep 2024 07:45:47 -0700 (PDT)
Received: from redhat.com ([2a02:14f:177:45a6:a4e6:75a4:a286:2745])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb1b172c7sm161732395e9.35.2024.09.12.07.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 07:45:47 -0700 (PDT)
Date: Thu, 12 Sep 2024 10:45:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Marco Elver <elver@google.com>,
	syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH] virtio_ring: tag event_triggered as racy for KCSAN
Message-ID: <39fbceb9a794b7c412b17c4ac6c2dd285d1bd3e5.1726152335.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

event_triggered is fundamentally racy. There are races of 2 types:
1. vq processing can read false value while interrupt
   triggered and set it to true.
   result will be a bit of extra work when disabling cbs, no big deal.

1. vq processing can set false value then interrupt
   immediately sets true value
   since interrupt then triggers a callback which will
   process buffers, this is also not an issue.

However, looks like KCSAN isn't smart enough to figure this out.
Tag the field __data_racy for now.
We should probably look at ways to make this more straight-forwardly
correct.

Cc: Marco Elver <elver@google.com>
Reported-by: syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index be7309b1e860..724aa9c27c6b 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -194,7 +194,7 @@ struct vring_virtqueue {
 	u16 last_used_idx;
 
 	/* Hint for event idx: already triggered no need to disable. */
-	bool event_triggered;
+	bool __data_racy event_triggered;
 
 	union {
 		/* Available for split ring */
-- 
MST


