Return-Path: <linux-kernel+bounces-285962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEAF9514E6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1257EB27140
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 07:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A417F13D502;
	Wed, 14 Aug 2024 06:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dbYUxSrm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D52313A268
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 06:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723618779; cv=none; b=kr3lxMg9EdjXSdgMXXfhjQU/MJ+ln1wLIjWdn/FLhjB+f5BAirHH0LavTWYGLLnyV4Pylz6h6FUdm+VmifKCIWpdQLwf9p2B+0xsRVAS9AJZvIlib7iCkHzQo1qIaf8mlULoIPIJ21Q+3tX6GzSLxv45nuGnZk+7w/vpzdHgWN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723618779; c=relaxed/simple;
	bh=wAxdMfby2D0SF7vG2bXiTceu6vtAkYDeWydXCxbOGjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3RUBA78HSaRzH+C+HVFRBsbyeGlk72VBWlObBWnkIe+RYaVbOJ1oHmxhsOUcGDWtm7gS7gkoSe+zo/X6x0GdMPTbPF893+bnV8sjmDWm49cTTC+/EqRJteUL1oNHHspVbYdz5Vn7hXhMc63g/3GicsTXZ8IuX/zPUwxuHaudCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dbYUxSrm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723618776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjtZOVWMEdjuvEgST87XVo9JV/srJgiwPjlW1KSOBo8=;
	b=dbYUxSrmVJt2P/ZuWynlDWmWlP/mhX1DymosiMvw3SXpDOyAYFLhB2TZQmRA6f4OCfWnxu
	83YavUxJAqr2iLkUcvpXZe9r9U9V8E7AqWLtIWAGHb+lQ2+PQ628xwTEpEZDkLICt1ro5C
	w/kKi1QdntgkI7ToVzMxdkr9p3dtW4k=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-ZuIr746ZPBWSroOCzMkUKg-1; Wed, 14 Aug 2024 02:59:34 -0400
X-MC-Unique: ZuIr746ZPBWSroOCzMkUKg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-58bd84067fdso4373912a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 23:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723618772; x=1724223572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjtZOVWMEdjuvEgST87XVo9JV/srJgiwPjlW1KSOBo8=;
        b=k04uZoL7Rdk099547tPJQuae72eVn3VcrI1LCHfoXp2NGQUkbm0xuVsit47YFms73S
         KVxpTKmMwA76nCtRvygb5jTv19sBc88XqUGOKL7FBZmkipPMbxOOhfpbBukPQSFH4etU
         X1Kyujg8LUgBYV+X6p9gxpszYQ4NIsW8jhwZ5VHktAyqZTy41gxk7wCTVHODf5dWgLrK
         EHDq7u14OwPaGgO9qlO9CPmkdJVF9k4dI1WnoL84uWfYb8g8Pqr0NvSWnJ9YNQJLqLZk
         gwvovka0iuVglu1vQ4Swo00rkppUbzfDr+/yTdrURIzVt8DF3v6pFIeNm9ciNsIw5bzA
         Z/+A==
X-Gm-Message-State: AOJu0YxKIJtN4E5PASL1hER8JIA8j4Q/Q0+sJi3wXzWXAnUzFdttaxLG
	JzOg+KBwIMWr0DLAo2oMlqFyJp888JdbAgGYi3yPs0cc601Wp1MdLFKFLUCs2ExWx/XwyJh4f8s
	zsmu66r4o4XIHsgRE0BMDMjXucH5hkBIDLDWrVNNRHe4CHRcNGje6P4czAj3CvQHFfabBnPRGgE
	mRnLFp0arNJf17qKgA9YNvVxhEpK6EaRa52gscWyQ=
X-Received: by 2002:a05:6402:50d0:b0:5a2:1693:1a2f with SMTP id 4fb4d7f45d1cf-5bea1c73b19mr1085403a12.12.1723618772455;
        Tue, 13 Aug 2024 23:59:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGS5NxWULN01540o+nnvytUndXUAOiwrbEfd3SI9/UCLbqsnAOKNseZbBkApLr7BKpp8webpQ==
X-Received: by 2002:a05:6402:50d0:b0:5a2:1693:1a2f with SMTP id 4fb4d7f45d1cf-5bea1c73b19mr1085366a12.12.1723618771588;
        Tue, 13 Aug 2024 23:59:31 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:346:dcde:9c09:aa95:551d:d374])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd1a5dfdddsm3576796a12.59.2024.08.13.23.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 23:59:30 -0700 (PDT)
Date: Wed, 14 Aug 2024 02:59:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	Darren Kenny <darren.kenny@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Si-Wei Liu <si-wei.liu@oracle.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PATCH RFC 2/3] Revert "virtio_net: big mode skip the unmap check"
Message-ID: <dde48b251db8b192ee026798e1180476b2183537.1723617902.git.mst@redhat.com>
References: <cover.1723617902.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723617902.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

This reverts commit a377ae542d8d0a20a3173da3bbba72e045bea7a9.

leads to crashes with no ACCESS_PLATFORM when
sysctl net.core.high_order_alloc_disable=1

Reported-by: Si-Wei Liu <si-wei.liu@oracle.com>
Message-ID: <8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 4f7e686b8bf9..88a57a3fdeff 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -964,7 +964,7 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
 
 	rq = &vi->rq[i];
 
-	if (!vi->big_packets || vi->mergeable_rx_bufs)
+	if (rq->do_dma)
 		virtnet_rq_unmap(rq, buf, 0);
 
 	virtnet_rq_free_buf(vi, rq, buf);
@@ -2296,7 +2296,7 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 		}
 	} else {
 		while (packets < budget &&
-		       (buf = virtqueue_get_buf(rq->vq, &len)) != NULL) {
+		       (buf = virtnet_rq_get_buf(rq, &len, NULL)) != NULL) {
 			receive_buf(vi, rq, buf, len, NULL, xdp_xmit, &stats);
 			packets++;
 		}
-- 
MST


