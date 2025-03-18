Return-Path: <linux-kernel+bounces-565885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E12BA6709D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 545B53ADCBF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F17209695;
	Tue, 18 Mar 2025 09:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="oXLIOhHA"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69138209696
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291846; cv=none; b=fNccPn0E3Mki/MWZ8ep3k9i6Bb3YSalzI3doTspE4JZYafr0X/Xfz3Tvkm0YyiGpeMPcDLak3E0MoklY4jU0/IWMkAw6EYTzHjso7cv01RKoWoIowz/Iz+L+cbELpFNam6US3pmbGb8VB0/EANRoYp2l1OknMfVZakZ0/q/mQ9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291846; c=relaxed/simple;
	bh=PTPRleizS1Yo/Zj2lCHknRUrDScXS7LpuAGSZt5GrG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nG32m1IPdXEWIMRGpMGFcugP+CreRZDveyS/EgX/LNjpoxTobGHcOZE3cT/wp1Fgvlt9GzeK5cmK1tmOv9OcpjutJPRvbFiyTfki15JiV+ShWHlD0D1EFBfGdme8XyPpQQsEn7C+bKla41pDn1UixL7+pwjNpNEW3PrNL+E5pwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=oXLIOhHA; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-224171d6826so2579385ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 02:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742291840; x=1742896640; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wp+TkaR3KA/C/LJhQd39jSgt/1NvtxrTDAfmjY+x69o=;
        b=oXLIOhHAhV10Z2A570QWtBlOh7NEPNDR9tLgewiBfnLklZBhn56079pbqUAsBCuIif
         wHvc7bHlPoSYzgOjJUbIrFeWpozstExJZjVE0pe47dYPgu2OfaDeBm12i3r2KPCDN+UT
         JU2bVcqNvc5XRyliWGntIdVNpq6qlvNVCNfO5j/7kDCJdlksyWCR5chnDgmQKl2QkZ7F
         8WBqX1W3KOXORw0h0xE1YZiiYc5Mk2KfbGNl1AmAs/dcFaV03uspdjCDuZCtaqoSv6mE
         M1GpKNp2mI2huLCMX9HFITIz4+MbbKnTUrMblvI+SF4dyQt3WzRfkrfQioIsQJN3MhGQ
         +mHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742291840; x=1742896640;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wp+TkaR3KA/C/LJhQd39jSgt/1NvtxrTDAfmjY+x69o=;
        b=bw2iYs8c0Oh6/lnk1ofGJ+QZNpQyGKXJ0/wIcYhWtM8BiHJdA1hQNIMp4U8VJXwFn7
         qVdjoRAr4JjPTK5zEievBNJYBigFUg2zYGMysUAwQH1HKXJuHeeehX+Iav07eyjJPc0i
         4+TKZk/mIfDd0xZigJUqPp9DsMuM2q0KlPKGC7DwGY7Ml/VReNCjHMVBkNIUw/LZzDbk
         nKcKBeh2MJGvzfhekRn/H26Kf5PU3qXJGr5RKP3BxdLQUzvukObSquMAjeHzQZoQvzNt
         MRIxRzB20lXlxfYK+9/e+5YEn2jUTCM1q2l5yqXxacAVE+kRH8jjqAdWPEgv3Kh/3VyK
         tdgg==
X-Forwarded-Encrypted: i=1; AJvYcCVmvKIWLHPxGIadwLNLWM8Pgd9ZjPIF+mrdkDjdIaNxGM2WkaG45ThwDJESAp5MXU9Q/5IRQTmyibBvXBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDpN/eP9Rzp40Y+KQm3mm7go4oJPQHteZUChmuDYXKJatD3pfH
	WjGvlwnxYdsAcVMPsrt7uFTcnjMh3lQTf87F4E91rdbdJ12Jl/uwSxYGQRDjNXM=
X-Gm-Gg: ASbGncsYbPFlsQZ0hsqlYg6m3UJMimiNYkRke4sS/kxOilkNTZDv2SG4gJt+QaAZWht
	cpH2GP6MmoJznFSNZk2cGPRB//sPzNJtChKU4Zs3Z8vFYqnBX6smHGfjekTMIpFPwuZqe2j5nAf
	GU3sT06oRivwnY23pcBv31OoNgeFHe6nzIj4G3PeDBtEEZ25v5YdS7sx0wsqKzjIZTL8uodly2t
	mLNFUzXJLH4OvMD88Pz0RcRmgQyjhN+l8N28O+vhrduiAGoS4v4yTSGRHjYyGmqGt8rQr5PnN/F
	DMWF9qWtwWFf8+ge8dnO4SeRlQDWBDO9xgOaIJ+RVQrPu6WU
X-Google-Smtp-Source: AGHT+IEau+wjrdRHJMlS5nyOT1rvXp0wuHKf/Prbu5sQ6Jh/4b7CF8c7TS8qmvF6EWe5N8kKungcAQ==
X-Received: by 2002:a05:6a00:b91:b0:736:42a8:a742 with SMTP id d2e1a72fcca58-737223b9098mr15931032b3a.11.1742291840607;
        Tue, 18 Mar 2025 02:57:20 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-737116b0ec4sm9074760b3a.159.2025.03.18.02.57.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 02:57:20 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 18 Mar 2025 18:56:54 +0900
Subject: [PATCH net-next 4/4] virtio_net: Allocate rss_hdr with devres
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-virtio-v1-4-344caf336ddd@daynix.com>
References: <20250318-virtio-v1-0-344caf336ddd@daynix.com>
In-Reply-To: <20250318-virtio-v1-0-344caf336ddd@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Melnychenko <andrew@daynix.com>, Joe Damato <jdamato@fastly.com>, 
 Philo Lu <lulie@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6

virtnet_probe() lacks the code to free rss_hdr in its error path.
Allocate rss_hdr with devres so that it will be automatically freed.

Fixes: 86a48a00efdf ("virtio_net: Support dynamic rss indirection table size")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/virtio_net.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 4153a0a5f278..6cbeba65a4a4 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3580,7 +3580,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 	if (vi->has_rss && !netif_is_rxfh_configured(dev)) {
 		old_rss_hdr = vi->rss_hdr;
 		old_rss_trailer = vi->rss_trailer;
-		vi->rss_hdr = kmalloc(virtnet_rss_hdr_size(vi), GFP_KERNEL);
+		vi->rss_hdr = devm_kmalloc(&dev->dev, virtnet_rss_hdr_size(vi), GFP_KERNEL);
 		if (!vi->rss_hdr) {
 			vi->rss_hdr = old_rss_hdr;
 			return -ENOMEM;
@@ -3591,7 +3591,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 
 		if (!virtnet_commit_rss_command(vi)) {
 			/* restore ctrl_rss if commit_rss_command failed */
-			kfree(vi->rss_hdr);
+			devm_kfree(&dev->dev, vi->rss_hdr);
 			vi->rss_hdr = old_rss_hdr;
 			vi->rss_trailer = old_rss_trailer;
 
@@ -3599,7 +3599,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 				 queue_pairs);
 			return -EINVAL;
 		}
-		kfree(old_rss_hdr);
+		devm_kfree(&dev->dev, old_rss_hdr);
 		goto succ;
 	}
 
@@ -6702,7 +6702,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 			virtio_cread16(vdev, offsetof(struct virtio_net_config,
 				rss_max_indirection_table_length));
 	}
-	vi->rss_hdr = kmalloc(virtnet_rss_hdr_size(vi), GFP_KERNEL);
+	vi->rss_hdr = devm_kmalloc(&vdev->dev, virtnet_rss_hdr_size(vi), GFP_KERNEL);
 	if (!vi->rss_hdr) {
 		err = -ENOMEM;
 		goto free;
@@ -6985,8 +6985,6 @@ static void virtnet_remove(struct virtio_device *vdev)
 
 	remove_vq_common(vi);
 
-	kfree(vi->rss_hdr);
-
 	free_netdev(vi->dev);
 }
 

-- 
2.48.1


