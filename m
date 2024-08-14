Return-Path: <linux-kernel+bounces-285963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BC49514E8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D75B62869FF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 07:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB2013AA32;
	Wed, 14 Aug 2024 06:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2ecE9ap"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D69F13D52A
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 06:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723618782; cv=none; b=DtUA1YLEgp+WiFNZ9thv4+QO3nU80UmjVysSi1Srhww5J1P0xxeQcTO6GIrBgkvHlEztBUukMjnsR6BsE4Bu36fv2Fc7xgq98XmNDDM1H4nHYgTg0ZDMH9F3V/2U8Z1Yr3kYpdzl6dLIySDTU3KRfeFHzKyxev8ajxBdbOEk44M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723618782; c=relaxed/simple;
	bh=Pu3OGCo/CmwwpRnQchJJUnb7pVL/LRupMdZBjzDEC/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mN4DeyppoOXm6Qql8eIGY4s/2k7wEbFMecNmxIWA+sM7NVXy7vC+5Urv9qivZ1reetWrX7A4Qp2mT3YAOWQ6wByLJuAtvN+xNvY0nigdeWk6TUNOzSX0xh8Pmg0lS+l/l9IOSorEpUx3iABZgml3uWOTKBlS/l8ghtGQdEWclQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a2ecE9ap; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723618780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zee9dlwcMuZCG921uf8SrLhdaia1L+j7thLeagByASs=;
	b=a2ecE9apV3NRZbgfrqlILZC7MIjOlPkPs/jgXb6sHxZF9sT1Loyp1IMARrUojuzvE9VYv6
	YO+O/h1bmAp0LriBbhpVETuzwgPWiEqtwsAMlnvmz1duggZ+J9rDIoh7AV42A3E4tE1xp1
	8W7wity2fKo2CAbPgj7RwmGdD1foyRk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-P2oTXpxhMgSDZz7xRw0j9Q-1; Wed, 14 Aug 2024 02:59:39 -0400
X-MC-Unique: P2oTXpxhMgSDZz7xRw0j9Q-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a77f0eca75bso529704566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 23:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723618777; x=1724223577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zee9dlwcMuZCG921uf8SrLhdaia1L+j7thLeagByASs=;
        b=jBJGmvBoljS5rcO5/ukR5YZmRAGXWK6qaRST2Tc0lVXWCb7TAczmEsGOsuTvFiANb9
         mIHnSSLkfAjm0FhGwgs/QM/J2qIABmkuuBPGHu65v+cqn6ce0Hjo45EkWvXuXc/N32HX
         otVf5wm3I7HwtsLIO9w+pXF4KXvVpLYrNymFa2BTb5CYag/uZVQcroCZ8PXdywGx6iQZ
         3TD0060MhO2K2VAFyX8m2nlS4JxygIge0Q3z2UMAIfbGwpUgYrDPRW/7Wdg1GnicQjvx
         1V/oTgEih8h7yKcoEn0XK7Vu36Q022n9cWPIiIFrCh4rrkxWxZQmgDtY9642sjAvISZp
         8GgA==
X-Gm-Message-State: AOJu0YyHe+/02ed/K6KmWpFJ2+YfcLm6XnawkAmkpEImk9yHwEbRBOUy
	ksx7pUZigvqdEC4RiX3d9hIq7DXRCAkEQx3IvvL4AiwMHuSsUPcX/0KRkRAG/vWBiLbgJA2I/7h
	1MrdniJaEVCPSmgrCARRjX1i+nWUw/Xw2+MpQsjzXuYOyp8jZrai0btpDSP6r/L5v7GLHaCtMlr
	TwJ/9Rk6/wQwfLEjZbh4tAN5V1+MMUgnX9DAV1OeI=
X-Received: by 2002:a17:907:e248:b0:a72:7d5c:ace0 with SMTP id a640c23a62f3a-a8366c38ce8mr108211366b.11.1723618777613;
        Tue, 13 Aug 2024 23:59:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyMAjw3UY0D6+5QLVxInfDhyCUgtrNGyRp3D6mJIvUovvpU7E1koWdqS+NoKo4y/Bx+WFK7A==
X-Received: by 2002:a17:907:e248:b0:a72:7d5c:ace0 with SMTP id a640c23a62f3a-a8366c38ce8mr108207766b.11.1723618776638;
        Tue, 13 Aug 2024 23:59:36 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:346:dcde:9c09:aa95:551d:d374])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f414afe2sm137019666b.144.2024.08.13.23.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 23:59:36 -0700 (PDT)
Date: Wed, 14 Aug 2024 02:59:31 -0400
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
Subject: [PATCH RFC 3/3] Revert "virtio_ring: enable premapped mode whatever
 use_dma_api"
Message-ID: <4937ef0c9389fd2031cd0be78ae791d3289b6e94.1723617902.git.mst@redhat.com>
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

This reverts commit f9dac92ba9081062a6477ee015bd3b8c5914efc4.

leads to crashes with no ACCESS_PLATFORM when
sysctl net.core.high_order_alloc_disable=1

Reported-by: Si-Wei Liu <si-wei.liu@oracle.com>
Message-ID: <8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_ring.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index be7309b1e860..06b5bdf0920e 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2782,7 +2782,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
  *
  * Returns zero or a negative error.
  * 0: success.
- * -EINVAL: too late to enable premapped mode, the vq already contains buffers.
+ * -EINVAL: vring does not use the dma api, so we can not enable premapped mode.
  */
 int virtqueue_set_dma_premapped(struct virtqueue *_vq)
 {
@@ -2798,6 +2798,11 @@ int virtqueue_set_dma_premapped(struct virtqueue *_vq)
 		return -EINVAL;
 	}
 
+	if (!vq->use_dma_api) {
+		END_USE(vq);
+		return -EINVAL;
+	}
+
 	vq->premapped = true;
 	vq->do_unmap = false;
 
-- 
MST


