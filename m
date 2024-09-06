Return-Path: <linux-kernel+bounces-318596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A78996F055
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8154EB22AA1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9141CB313;
	Fri,  6 Sep 2024 09:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZG+vGvcB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A511CB318
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 09:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725616370; cv=none; b=Vub4+Vr8kSnmsywP/gXeBFY0bTJ3BFlncQFfp9psA2p1rtCJNZgc7edyrJmuTrqFQOCoE7t8VZ0YdgJ7mWz0RZhOitVskA7viNVVZ9CAUX6kzqTJEdK/TZ8vILeINjKZNlqCdxnm6O3yUXxIFPRe8dNy3fQU1RHOC4uEzrFtAJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725616370; c=relaxed/simple;
	bh=y/2q/oU3B2T/Sj3xYbJ3TRbapgrDhvFRSSna1J7JF/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esbka0ngxp0itUsdJ7Ekjlyv1x6FF3cpgLmf/5nYbF4z8AK/DU6taJ2RsQkDLFaIvBONdzmHCloU47smkUcAt2NZIcKgMt2VieQw5DwLaF1nzfrcUAjWsi4GJ7PzQVX+Q/K6jFte5ttz6cYsOwtRfrhzmW9QEEXpt/LJ9XfUkH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZG+vGvcB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725616368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pft5+JeYXYrsom9XC/wwmdmDEnhGm2vJUjZuwg+BsyM=;
	b=ZG+vGvcBat8KQdY7dxajoInjusF0CSabUTDkgOSN5pV0TD1s4CEsg/hb5HUoUML8kjnPBO
	rEkNdcBcqAVZec7lA5NZJgybZKXK7ZzQ8icjWsWIwN5MVj8O0lFU6ETPE9Gzlum5vfg+1h
	FF7I/26U/W7Se1AZDfHwyz/9gmF73j4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-DGBP_EOjPTGlriLSNnt65g-1; Fri, 06 Sep 2024 05:52:46 -0400
X-MC-Unique: DGBP_EOjPTGlriLSNnt65g-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42c82d3c7e5so15048365e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 02:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725616365; x=1726221165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pft5+JeYXYrsom9XC/wwmdmDEnhGm2vJUjZuwg+BsyM=;
        b=NT/EgGoCt2FXiUSCWNwnQ4o2PEfr7FIdTyML4v+GlYv4n9PkH8V7Sv+4czcyWJjk4f
         9eY+7t5bgEPwRTcnY6PysV61TlKQbSxu4Xw+yhAobVxXUpGJWE8+GxGeFuRz2+Edgxno
         FQQbdnEF8ffZnhxI7JBMtsuXtOzD5DpE5qDq3zbX6vjzz4FtepNK2kCIL5KuNV0S1rZA
         Qk9ltO4EQu7VpKXiK8Be/IhR2Aw4QIGqb0U6IKnHoBsz0ai4jTS8hQoXOL1A/c34LHDc
         RIoZZ1YQaXDfjzUhVCTMPxIpVeInQ/ifamLtoRsXhRjz0n6d8NU8zcnXmTbGloOLvXTm
         DgXA==
X-Gm-Message-State: AOJu0YwZ17Aru6xMhSj9gO7qc1pWgtAeB4VaWuKtDHtl2h0Qqn7E8eDm
	Mk6Fql9oCtT0/uMt4kQJmjpSADdZEztn9jtiuVPWI99zaPub/G2CR1z7IoFp95Ah9cbeo3T/DjT
	sxOev187D0AkuK3VDBbae8EF9X07mhdCCOzP4YEdxkUxW0WvQAVKobPWnwEB6xzzoCou2Z6YjPB
	17FU9InWLy/NaHGkv0fnzqhgg5KV1aR3lw4xS3CvEctQ==
X-Received: by 2002:a05:600c:1913:b0:426:5d0d:a2c9 with SMTP id 5b1f17b1804b1-42c9f97dbfamr13581855e9.10.1725616365133;
        Fri, 06 Sep 2024 02:52:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF21JiRX7kMArBtpqaDQnryw6ZUluOTmbApXNoVkHLpPhwvwYOfjmZQYcgbTEuY9mkhpcPeag==
X-Received: by 2002:a05:600c:1913:b0:426:5d0d:a2c9 with SMTP id 5b1f17b1804b1-42c9f97dbfamr13581415e9.10.1725616364521;
        Fri, 06 Sep 2024 02:52:44 -0700 (PDT)
Received: from redhat.com ([155.133.17.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05d3171sm14716285e9.28.2024.09.06.02.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 02:52:43 -0700 (PDT)
Date: Fri, 6 Sep 2024 05:52:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, Si-Wei Liu <si-wei.liu@oracle.com>,
	Darren Kenny <darren.kenny@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [RFC PATCH v2 6/7] Revert "virtio_net: big mode skip the unmap check"
Message-ID: <3db7fcc631c2f1dd6a62e5d90fecf3e5c32ca4e2.1725616135.git.mst@redhat.com>
References: <cover.1725616135.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725616135.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

This reverts commit a377ae542d8d0a20a3173da3bbba72e045bea7a9.

leads to crashes with no ACCESS_PLATFORM when
sysctl net.core.high_order_alloc_disable=1

Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Reported-by: Si-Wei Liu <si-wei.liu@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0a2ec9570521..6f3c39dc6f76 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -983,7 +983,7 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
 
 	rq = &vi->rq[i];
 
-	if (!vi->big_packets || vi->mergeable_rx_bufs)
+	if (rq->do_dma)
 		virtnet_rq_unmap(rq, buf, 0);
 
 	virtnet_rq_free_buf(vi, rq, buf);
@@ -2367,7 +2367,7 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
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


