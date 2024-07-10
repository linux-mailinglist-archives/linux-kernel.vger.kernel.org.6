Return-Path: <linux-kernel+bounces-247540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8E292D0EA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 13:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 467D11C2313E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236F41922EE;
	Wed, 10 Jul 2024 11:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KZzgvh0q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7CF190497
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 11:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720611773; cv=none; b=EIZUxvaJFYmAANwM8wE7iUXHA81kcqi20Mmk69OtlgbpvNJ/E3D2MEwgp/IoD1hSbAF2VriQ7oF1ksA0oj5+mntImJSbBXRq6G9ShGa2cNeYqOtJrmmWZUxOelbDQX3oH1dyJttz6JhcxcEuVtDfaAypP/1RiAj1qYSvxEMt/8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720611773; c=relaxed/simple;
	bh=Z8OR0lbdBCi/RvDNxw7LRIrhiGA1nGWJviAMSO0Hxk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Axq9j6R21s81v9C1K91W87ju8HY9WjLFjVa9wYu1ZRuLNkq9Q9g2EOe9LRa+X01Z9joItPFFf0g7w2mF4+0+KKWRNb5ghUi+n0zMm7S+6Qj3i4WjgACxR10uH1PjAmG1MPO8Lw6N1hw8Lxu4MmaPFixsZTdZvfleGbY68ewGqVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KZzgvh0q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720611770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zsf+nJBsGvYaVbTxbJtn/Kvhd8j6Wn70g60U3gJwhTI=;
	b=KZzgvh0qvTr97qSpMeDAXbJjDU0KhO8rikO6l9iPs7lb6+XX501Rer8zPlDeRf2PUvvpTK
	z2wa5cTl9VRLUdUDMTkFFnnT0JdH2GASeJTPMoOLmogQXXfs7M0vww+if/u43L0SkZd5lF
	G0cY8Zz3jQjFA1d36F/Yc5mKnIQytNc=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-oq9jy9EiPNqsvlDrp6ZNRg-1; Wed, 10 Jul 2024 07:42:49 -0400
X-MC-Unique: oq9jy9EiPNqsvlDrp6ZNRg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ee8ceb0852so60820021fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 04:42:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720611767; x=1721216567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zsf+nJBsGvYaVbTxbJtn/Kvhd8j6Wn70g60U3gJwhTI=;
        b=H7+vM/O2+7n+KmAs6SHkf0Z2I7tvdv5jmBCpptv6c4p3y8J6LxyN2zwWovYWFVu3et
         D8s0IrG3pIAOPeNtLjmyQphg+GN4hSR1aWIaATL11oxRX0Bs+aXUJhDhqwUC8dObLPQx
         5BagB7kAdFq/AkFjpd4cQgVzhpaPO7XjR+I+IAfbvu/Hdarq92gghZ9sJxukYgm1H6pF
         ixrR4xZe+AFjEqj4JB7EohcVsXeg3ZMXB0wt5YWH6m7S0vjzx4QIs9y0iD9d8gWSS7U9
         QxDDR1NtOAyby4LE8lutsRc7S/nh7X4HOQ3t0+57gG4QrL72HaMMiifwrf356YRfovG3
         F1qw==
X-Gm-Message-State: AOJu0Yy6z8xyAiAoRuhd9BqtTEgu7Zss7Q92XFSw5Nzd9VebY/BK0S3y
	nAUs366Ze2dN2eyG9yqbocn0+8ZpZeRSI/P6YuXrbKr1RkNBrUTGKET8Ez4Bg87GwZ4Ms0UYPrz
	P/DoHh6qA80QI4XQBh5o2VaWp/3ZZc0G9ZKmRrqxrOVE0I3vuC1TGrv/RH6Qys7SpUq4qjTZWkm
	8FXFplp4OviU8av8RKkMmL7Z+h70iEsELromF0vGE=
X-Received: by 2002:a2e:9dd3:0:b0:2ec:51b5:27c8 with SMTP id 38308e7fff4ca-2eeb3171537mr34867051fa.32.1720611766953;
        Wed, 10 Jul 2024 04:42:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGL8nfmB7GUlie0Na5yMQMDltOJr5NPNsulJoickaf21VsdTFgnCEG6hEjAm20dRBEO7XxMg==
X-Received: by 2002:a2e:9dd3:0:b0:2ec:51b5:27c8 with SMTP id 38308e7fff4ca-2eeb3171537mr34866781fa.32.1720611766004;
        Wed, 10 Jul 2024 04:42:46 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:f6ae:a6e3:8cbc:2cbd:b8ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfab753sm5067071f8f.107.2024.07.10.04.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 04:42:45 -0700 (PDT)
Date: Wed, 10 Jul 2024 07:42:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH v2 1/2] virtio_balloon: add work around for out of spec QEMU
Message-ID: <19d916257b76148f89de7386389eeb7267b1b61c.1720611677.git.mst@redhat.com>
References: <cover.1720611677.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720611677.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

QEMU implemented the configuration
	VIRTIO_BALLOON_F_REPORTING && ! VIRTIO_BALLOON_F_FREE_PAGE_HINT
incorrectly: it then uses vq3 for reporting, spec says it is always 4.

This is masked by a corresponding bug in driver:
add a work around as I'm going to try and fix the driver bug.

Message-ID: <cover.1720173841.git.mst@redhat.com>
Fixes: b0c504f15471 ("virtio-balloon: add support for providing free page reports to host")
Cc: "Alexander Duyck" <alexander.h.duyck@linux.intel.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 54469277ca30..eebeab863697 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -589,8 +589,23 @@ static int init_vqs(struct virtio_balloon *vb)
 
 	err = virtio_find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
 			      vqs_info, NULL);
-	if (err)
-		return err;
+	if (err) {
+		/*
+		 * Try to work around QEMU bug which since 2020 confused vq numbers
+		 * when VIRTIO_BALLOON_F_REPORTING but not
+		 * VIRTIO_BALLOON_F_FREE_PAGE_HINT are offered.
+		 */
+		if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING) &&
+		    !virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
+			vqs_info[VIRTIO_BALLOON_VQ_FREE_PAGE].name = "reporting_vq";
+			vqs_info[VIRTIO_BALLOON_VQ_FREE_PAGE].callback = balloon_ack;
+			err = virtio_find_vqs(vb->vdev,
+					      VIRTIO_BALLOON_VQ_REPORTING, vqs_info, NULL);
+		}
+
+		if (err)
+			return err;
+	}
 
 	vb->inflate_vq = vqs[VIRTIO_BALLOON_VQ_INFLATE];
 	vb->deflate_vq = vqs[VIRTIO_BALLOON_VQ_DEFLATE];
-- 
MST


