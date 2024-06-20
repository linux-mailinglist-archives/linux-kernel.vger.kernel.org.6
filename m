Return-Path: <linux-kernel+bounces-222182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F00A790FDFA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65AD1F254FD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 07:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD5F1803A;
	Thu, 20 Jun 2024 07:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxE7JZbO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0DC482C8
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 07:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718869505; cv=none; b=RVAVoSsxlh5yz5rKO12bGWMe2+P0n9ooGZg/EZCvG35NiYTv4+/30E1EituFhWhnywi9vvLyKRxWIIKKxFEli76cTlCa2MghRDNmNol783CzJePBiuBshv611u6+1PRr8i4rhLzJRjFZzUd9iMvca5+XN1pShK3hql+CWNsfsHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718869505; c=relaxed/simple;
	bh=jriSfG3yE8FF/6EIGZsE4m9KeLD7WIHU7POZs2Y87aM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KJ/EfqOEhC9U3aX0Y65HxqwIOENKpPq47qWGw3wAx2P7F0h8busfjoQt6sLA0MXETOS3yayClNQpVh7tryu2bZSxGXyv84k7cR1gtCjT4CJSej6QiyK7U3nVXfExxu4Bew4f2L++EJK5UdvhLrI+OZOp4RZrp5gxSsO2z4rTVCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TxE7JZbO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718869503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=FLGfD3eNgl/6ZqS6Hg5LlUxNxxeA+GusPPmU/ACDKiU=;
	b=TxE7JZbOIR50SJ4T7I8Gif0uP7QeDIbT8gX/6ma56y1vG8DrNuhaS/d0hh03UmjKzkjNrT
	ATk4mlvIygDVFflrSsR0jGl8PaMw84eR3lgRENB8IuaywTtzi9BbudVHqP6ob1dGabECj8
	J/KVa67RQ9ps+oR2nYmbnSRvI+0LGjI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-BAJenjV5O0mtX3jTuTnFBg-1; Thu, 20 Jun 2024 03:45:01 -0400
X-MC-Unique: BAJenjV5O0mtX3jTuTnFBg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a6efe58a1aeso23311866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 00:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718869498; x=1719474298;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FLGfD3eNgl/6ZqS6Hg5LlUxNxxeA+GusPPmU/ACDKiU=;
        b=nNb/hXGqp55ERjLQW35gtbpy2ZRsgydTXhqFk//2QPdTPqQ401mu9XEVPl7IeazQEG
         kXcwFx6TPSznSIrzMxxeM5d/sCwKS/Q5UsBo3HURyt18uCZ9eAJT/Agb/b5TWLvG5pHj
         f0NRHitg4R6f5MhDiUDw7adHaOyxPAtrlpPbQ/YfQ3wxCeTW0L29HuJRsQQgL538OlK0
         FXzsrsXiDYBUu7S9GYZ1lk9SlLutTk0hlJJGfb0GQ5HIkI5TzKIaTrhg1uIlJ79rLPpP
         ZtpQGcvCcXXSzRgAnVRpkdR9YOqTAUv+jHDLWiUhfLazS07Ky6+srCDacq39+BIVVRHV
         yEVA==
X-Gm-Message-State: AOJu0YwIK+K5AsS6EcfFpyqZkkQVQIhByHV7sV86qZFDIDFam2Aw6KWj
	GAurtfst/Pt9wZCnCHWs1EhbdQarz7CfR1zPUseXVYhAZ+IF2ig4I/MZ0pzqDFXUOKC/0Ro46vI
	mFOS6l72B16+75vv6PnJenQxxUm5cRHVVZULDq1vczXd5L5oDTsUNEFfvDeMJc33JClexRoy/TB
	wbbYFdM4LvzS1WBIIFn/tbrNpQXG5265CvpYZLuXa2dA==
X-Received: by 2002:a17:906:3944:b0:a6f:4a42:1976 with SMTP id a640c23a62f3a-a6fab648b2amr244126566b.37.1718869498282;
        Thu, 20 Jun 2024 00:44:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7rXUumkKpuJQU4WxiFQxdfftMFik/0/wxkymNN3g+4BHNw8Xis8UnHK3Oq+VbGL1wV+yXGQ==
X-Received: by 2002:a17:906:3944:b0:a6f:4a42:1976 with SMTP id a640c23a62f3a-a6fab648b2amr244123466b.37.1718869497562;
        Thu, 20 Jun 2024 00:44:57 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f9b3feb7esm181368366b.172.2024.06.20.00.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 00:44:56 -0700 (PDT)
Date: Thu, 20 Jun 2024 03:44:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH net-next] net: virtio: unify code to init stats
Message-ID: <fb91a4ec2224c36adda854314940304d708d59ef.1718869408.git.mst@redhat.com>
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

Moving initialization of stats structure into
__free_old_xmit reduces the code size slightly.
It also makes it clearer that this function shouldn't
be called multiple times on the same stats struct.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Especially important now that Jiri's patch for BQL has been merged.
Lightly tested.

 drivers/net/virtio_net.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 283b34d50296..c2ce8de340f7 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -383,6 +383,8 @@ static void __free_old_xmit(struct send_queue *sq, bool in_napi,
 	unsigned int len;
 	void *ptr;
 
+	stats->bytes = stats->packets = 0;
+
 	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
 		++stats->packets;
 
@@ -828,7 +830,7 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
 
 static void free_old_xmit(struct send_queue *sq, bool in_napi)
 {
-	struct virtnet_sq_free_stats stats = {0};
+	struct virtnet_sq_free_stats stats;
 
 	__free_old_xmit(sq, in_napi, &stats);
 
@@ -979,7 +981,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 			    int n, struct xdp_frame **frames, u32 flags)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
-	struct virtnet_sq_free_stats stats = {0};
+	struct virtnet_sq_free_stats stats;
 	struct receive_queue *rq = vi->rq;
 	struct bpf_prog *xdp_prog;
 	struct send_queue *sq;
-- 
MST


