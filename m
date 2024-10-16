Return-Path: <linux-kernel+bounces-368505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF499A1095
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 19:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7E5E281F8B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04D1210C38;
	Wed, 16 Oct 2024 17:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XHy9yOHP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C609187342
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729099639; cv=none; b=shOyHgfjSWmXt8hGH5N8kWXYz40Ze3+AUwBJ0nnK40OcbMhId9/NhRfn2Ab53DPqiAGXrBo3E02M9K2FAtaGfcKIIblrzfHlP22Fd6mGNxha/7dskBG66jgbC4acxzgBG00y5jNgpfBnqI7skTi9VVAgsJPUcGSA/ad/2aKa/jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729099639; c=relaxed/simple;
	bh=fzLmjTYv50o4SO1uhihHDhxEFGjJN+CktGLAz3N15Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QS6l5O3nLCGdr4RFFM1j2aErZ5Asp6Ix9u/rlfJpOV9h18NROdWpxM25TNVecZqavLleGpZYJxvX80OrRaT+JejeLWgQpivyv7xihjFt+1OxV7iIwLgWC5VKXYvu5F7rL7jnuCxICbU/mL9k0HortBOV/FYjZmTfXCf+vaGQZEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XHy9yOHP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729099636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=mm9TWMoNEKmC5/H75qa50GgVA8uFrq/T9r2miRc0UHg=;
	b=XHy9yOHPLqIiocxvFjK6TfjEy8wBdj6JDs10vNRPgWxzPQoDA7tvjoLPGQlMHx+YU/Zd6e
	2THAD6/wZ06L/KOMUiz9PzIXA424vhQCfwawx9ulbKzgyAeTFfUpLGiHH+ml9h2ryBgxnH
	983M4vLbv/gjwHk1q59+kY3feESz+7k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-SqEBuLPuN4Kr3o0MLKL2tQ-1; Wed, 16 Oct 2024 13:27:15 -0400
X-MC-Unique: SqEBuLPuN4Kr3o0MLKL2tQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d67fe93c6so3443f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 10:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729099633; x=1729704433;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mm9TWMoNEKmC5/H75qa50GgVA8uFrq/T9r2miRc0UHg=;
        b=TnhotYDtfuNFLdaSSwQH+AIxIEPAvrZbcOKiMKZZrQPZerq0UlxGiiycZuwEeYDQEt
         +k7lWuNF0b26xoJJQZvMM6tgpkSlr4QGU7mvv+eVgRCylDR0+6Y75G6GBCFMI/TCdWRu
         tZI3mUYRBd63y60ovSOp2xeawWxoDEzFJhQ3JSgH9Bqw1WpjBXpC6ZnVeIozHBrAkCm4
         NQJybvMeSPL9/kSUzT7AafU3cZNe2u6VGzWrWcXDujOcv8vtPFPV8ec5p3W4/GbARcvY
         d756ORoqC8mPrZWOrX3hA4cT9vL4dmCH4tdz1Z8pNrzELIP+NUhOWy2xfpJD1nmiMblf
         WFxA==
X-Gm-Message-State: AOJu0YxfHGp/tmg+nJPQ6pJxn/sMtjejBELfwPQdoBrpGkSxrhzmT9as
	6kEJJlWqAJmRLlbRzg1kX/FcSryrdub+lJWbTUaSY4TOa2I/WHElYN5By149lZmep5gCwAXa+fg
	MAEi5jM/uYROMYRbWw0ffNiE2FylKCheij2ERUnGug56Ma3I6TV8lM1ltiCuvPVbYWo4I+Hxlz9
	yNq2CkrvW04vOnzx29rS/G73caORY1ztogiEHD59g=
X-Received: by 2002:a5d:6703:0:b0:37d:4dd5:220f with SMTP id ffacd0b85a97d-37d551fba84mr12804143f8f.26.1729099633430;
        Wed, 16 Oct 2024 10:27:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/2kqVFlb2DtsXVfaMvtF8YMmP+fSHaEOFSLeUgaj7tCoSNI0g7YeZxeafsJNPE7r4ODqUXg==
X-Received: by 2002:a5d:6703:0:b0:37d:4dd5:220f with SMTP id ffacd0b85a97d-37d551fba84mr12804117f8f.26.1729099632938;
        Wed, 16 Oct 2024 10:27:12 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:b9f1:592:644a:6aa0:615c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc445fesm4832875f8f.113.2024.10.16.10.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 10:27:12 -0700 (PDT)
Date: Wed, 16 Oct 2024 13:27:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: "Colin King (gmail)" <colin.i.king@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: [PATCH] virtio_net: fix integer overflow in stats
Message-ID: <53e2bd6728136d5916e384a7840e5dc7eebff832.1729099611.git.mst@redhat.com>
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

Static analysis on linux-next has detected the following issue
in function virtnet_stats_ctx_init, in drivers/net/virtio_net.c :

        if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_CVQ) {
                queue_type = VIRTNET_Q_TYPE_CQ;
                ctx->bitmap[queue_type]   |= VIRTIO_NET_STATS_TYPE_CVQ;
                ctx->desc_num[queue_type] += ARRAY_SIZE(virtnet_stats_cvq_desc);
                ctx->size[queue_type]     += sizeof(struct virtio_net_stats_cvq);
        }

ctx->bitmap is declared as a u32 however it is being bit-wise or'd with
VIRTIO_NET_STATS_TYPE_CVQ and this is defined as 1 << 32:

include/uapi/linux/virtio_net.h:#define VIRTIO_NET_STATS_TYPE_CVQ (1ULL << 32)

..and hence the bit-wise or operation won't set any bits in ctx->bitmap
because 1ULL < 32 is too wide for a u32.

In fact, the field is read into a u64:

       u64 offset, bitmap;
....
       bitmap = ctx->bitmap[queue_type];

so to fix, it is enough to make bitmap an array of u64.

Fixes: 941168f8b40e5 ("virtio_net: support device stats")
Reported-by: "Colin King (gmail)" <colin.i.king@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c6af18948092..b950d24b1ffa 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4112,7 +4112,7 @@ struct virtnet_stats_ctx {
 	u32 desc_num[3];
 
 	/* The actual supported stat types. */
-	u32 bitmap[3];
+	u64 bitmap[3];
 
 	/* Used to calculate the reply buffer size. */
 	u32 size[3];
-- 
MST


