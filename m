Return-Path: <linux-kernel+bounces-570800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C52A6B4A0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACFD017F96F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888FE1EFF93;
	Fri, 21 Mar 2025 06:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="rNASNJcQ"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1871EF36C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742539759; cv=none; b=WeGd5tTk1WUTLtGhZ3NGf5JTJxSeRjBotFazpLwd8IMNIE1+ZFgUxH0TbFwhyo34DmZJhKdXGwXFKEH/HtkAOABzU2LfDM8Q7LPVjlHCeGno6U/KyE7SKiJTAi1IL2rMidWIMJ/veMxXN5SedHAaydnEdJG3ch6rEMlB1bi7xU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742539759; c=relaxed/simple;
	bh=9CUrz9dhvu15FJYjSA2vyaWutvF8gNFVLxLx3NxqRDI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q1/WF2JhXy9K5E/HeRrDpXqrcbbmi5eWkYiwco+WOcUEY1avDs2mpWLfXprArWeeOZadVDz6mMmxtrE1OxQMVQnr2xKzOUZp4Mc9FasyNjkHyoNYUWQKf9p8qx2VIe8j+U/qUL5t7sVtiPkDGa4xQ6D9msKVoQH9qWMwtpvD0GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=rNASNJcQ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2243803b776so3191155ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742539757; x=1743144557; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=50SxeWFRe74DdNLvKUCrTVWbecxWk/tvvWU0un1oLD8=;
        b=rNASNJcQKx1LXxq9KSlD5IcbqCzOKA1fC0dbCdndUZ+60VAcRVfzcOP7xYAqgeTols
         rhAvFaIUg6rvuagZFAmkOwvNvedCQrPrc46SZXMkpkaPqgiiYLHldc53DHUwQDptESZN
         h01kFl0hMTU8kWJv4/vUdnqWhwgTRzlJqhBWmeNjxMiOobKVvEjR3iOfvBq9fL0/XdTv
         KnMpZ7AUo+Fq4X9ghxZg22Ttssgz3ZwCKfFihT6gbIh1tAN2SYQ2dWfkvLlfNOvDdsaT
         uagFyzMqOwZ++bswBrPHwpWStP3HeTRCC0Nhy6Vf93qfdOgaVcXUDohKkF7mtzui0OMw
         sr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742539757; x=1743144557;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50SxeWFRe74DdNLvKUCrTVWbecxWk/tvvWU0un1oLD8=;
        b=UMiYV5wN5A/6kxsxrdiilRK1KfJsBvmBpGpW3PFA8iDzCGVigvjppDNojZ+qgkgU3T
         +w/rmLN4IO3STN7o0AVJBmDQwueiSzQz9ATRIFud/DCQvLigryyhTaPUnzM8zik3eeDj
         fncYseMrauP6g54giI+dJVPRZ5h9CRNivh+61CUkr0+PWRdMqrQD3bQS/cUgJVQPxEHv
         0DzmGMLHOHCpvGE2sZ6cO++iAGHNxzDfIa3U6pP3hlCXoDEl9L9grahZKnVtn78CmlJ9
         o3yAJarObR81RjT25olzOj08Qqk1gwUwdh2gAvFlLBkQtVyVOM2/21jVHMUf4hXdUwCy
         R/4A==
X-Forwarded-Encrypted: i=1; AJvYcCWB8VJOAUbG/Ykz6ufCfMAM3V/VZFbi9TItNL8pBejGTcE3gpj9wk12SVhdHDKBppYa7IYtH685I9A/v3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4DuZtHNn1+eHLvFp/ZQPCDB/6CGpt+p9w5z1ESrb/40Y3xVHt
	ffsUJaJdpE/XPqSzP6XrEVH1QpvjJ+qJsvNXYUnqjO4h0TSUfus+f1FjceTtw8w=
X-Gm-Gg: ASbGncv/6l3EUAwqMnZpyDWUcE4uYkwt2xxINqVfEiqcPe/cPVJhoxszHKu/XAaslWJ
	+EMAlNyYKHc/Hjw7KDuAfZl9EnjhB8Onlri3QJ4qS2q4TesWQ1HxhjXUKNOB8+k7prOgq3z8zSA
	pFlSd3qc2YwyCU4dNRd76iBXayyDt98BVlPVMh8dZYGwXv8l4lsqRTNoQeWq6gjWX/VP4UtkygN
	PPI0zOuiDkHrEnfJ+J+Mh1sHS0w/VxhIF+68RkmYUFnqEMZbzCXiUz0GHkXPdXeIvIamDX+Yi3z
	sYVBmy6jEJYDFLlcIAJs7qTF6il+QNPZdheGdwaKzNMUc51W
X-Google-Smtp-Source: AGHT+IF0uHlKSVlfre+IRVuMyIVROaUprT3kAYWQuGSmWoRdQtDg0pKD8EXS5S828nJMT0659WKQDA==
X-Received: by 2002:a17:903:19e6:b0:223:397f:46be with SMTP id d9443c01a7336-22780e19bbfmr36357865ad.47.1742539757618;
        Thu, 20 Mar 2025 23:49:17 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3030f807533sm1080930a91.49.2025.03.20.23.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 23:49:17 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 21 Mar 2025 15:48:35 +0900
Subject: [PATCH net-next v2 4/4] virtio_net: Allocate rss_hdr with devres
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-virtio-v2-4-33afb8f4640b@daynix.com>
References: <20250321-virtio-v2-0-33afb8f4640b@daynix.com>
In-Reply-To: <20250321-virtio-v2-0-33afb8f4640b@daynix.com>
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
 Akihiko Odaki <akihiko.odaki@daynix.com>, Lei Yang <leiyang@redhat.com>
X-Mailer: b4 0.15-dev-edae6

virtnet_probe() lacks the code to free rss_hdr in its error path.
Allocate rss_hdr with devres so that it will be automatically freed.

Fixes: 86a48a00efdf ("virtio_net: Support dynamic rss indirection table size")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 570f77534dfb..6efec9c50b25 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3580,7 +3580,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 	if (vi->has_rss && !netif_is_rxfh_configured(dev)) {
 		old_rss_hdr = vi->rss_hdr;
 		old_rss_trailer = vi->rss_trailer;
-		vi->rss_hdr = kzalloc(virtnet_rss_hdr_size(vi), GFP_KERNEL);
+		vi->rss_hdr = devm_kzalloc(&dev->dev, virtnet_rss_hdr_size(vi), GFP_KERNEL);
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
-	vi->rss_hdr = kzalloc(virtnet_rss_hdr_size(vi), GFP_KERNEL);
+	vi->rss_hdr = devm_kzalloc(&vdev->dev, virtnet_rss_hdr_size(vi), GFP_KERNEL);
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


