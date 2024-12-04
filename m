Return-Path: <linux-kernel+bounces-430568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B60649E32ED
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 06:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A83B285265
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 05:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A435918E379;
	Wed,  4 Dec 2024 05:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="nDC+V+XV"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC7718DF65
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 05:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733288899; cv=none; b=UzjELJpCWEQGvBOXcfADJywPB/mzIsoDfZvNSZiG7fVkY7U7VrdC6bBPqsqqHZj1JSZBltw+yf0HUo0CU6p7is84snSbU6QFqrKrjB6ttQNME/zqv8JYPG3+33mSwA9vC5lI9y1OkjH9BPCXvpPFN/y1XkL7LqP8oyIMghcopUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733288899; c=relaxed/simple;
	bh=gLYoI15BjmtBU7oAvSpTarPfyfyGSgvB72KHD0BKUnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LjcU7dj3TJFKXHF1FsYdvuFJhmlV/cMidML4B2Vug22bz3whk2B5PF2SN/oRfNt2z6QpwelS/DOg2g8yBeOJBBwlphb2E5t8DXtx9y9svZDQ0xONozWpu43lH45xbVvTG5F8AOWGZpZs7F/obsyZ5phFjiJfQM1uTKJfcS/68VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=nDC+V+XV; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DDE6140C4B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 05:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733288895;
	bh=ObVc7Whi17Pu6UUwsCZaDHkuVEONGWJHt7EBpIl7aAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=nDC+V+XVcAD7b1H+1pBB2uwhAywejnQ/hMRFp+/jG23uEQ8xcyCd7DNJrJB5NRwup
	 pvzi+glCd2gAoKxP0vu813xGDVgcIFujukFGUtEpnFIZKnW7Cy0vQITQoxXgl6btHo
	 4Sx585rAL4o+J0zI9xb34fZHydysrUaDjQ8VywfhtJAmfOXOlLaKYo7Ynlaj6bb4el
	 mczlFqveJECYWvEtov3SuxjDvDtmgt9NdFgRrloBTcWfYA5ey1YGTC4w5+CpsxJ+og
	 LJps9Cvx3XxGE4mN5wyK3zv2rmUcvxGqy278oTtB0KT82YJiU8kmNmGTNBaxQdEgLA
	 bDX+oXzAcSLOg==
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7fbbb61a67cso3790706a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 21:08:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733288894; x=1733893694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ObVc7Whi17Pu6UUwsCZaDHkuVEONGWJHt7EBpIl7aAs=;
        b=QSlEhCkTlBy77ve24iy5PWCyQuILtsgV7AbRAH4ZQ8ydWfFTNOOaWlBHpGb2ATwDiX
         nAxh2gcTDQHMwoChdrKHQx1GjssQrF0w+x7nIZk6eI8ktnlv1T52m1xNRCF8YP/INn5w
         u337N+B9/Vyt1y5IFVv+/xNr2nbuGRFtJJbY9FiC1tNMVRpVhEmYtBu8Luxiv5gqJpvZ
         ubCtS/lgaxI1rcfQ8U5JinT+YkVzU2fFyf+JrZGsTtcanUqZeVMolFF1T2niR/OjAyZt
         Ds0DRt47AYroiOBRHdB4nvrNuNvJq1JFK1MfG7TVZfKlUhI03/+gIQTj8CwBzZOFvzCf
         j06A==
X-Forwarded-Encrypted: i=1; AJvYcCU3ELU0uwdZXcaGJYO2ElsEOzB3igoXg4nTimUtk+2JvFT5iVICO9jhUvIACACmeMZjpQddwPGa4uzkHnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVi7a2znk7WRknZpJ3702SbMfmkoZbDCcNhCsaCQ1Mg5LuU6QE
	bRkZakDMkXZ4hbgj6cTdc4HXfynWcgfxxz6Jp1SdRGFb/Lo+1Jw9ruNuSR3wG0obPmvendSqYgh
	WqDvpHF1cEWLPUgj+TdozhlxEBF8kj7TgT4o+pumRKpbFmE9A3XM+bgRgI839wW7KWx/gkoPwO+
	k4VA==
X-Gm-Gg: ASbGncvXtmTL3cr+1HyG4e7OzPdC0jSVEj48ptMRCQbLGrZaw6cXnPZGIXl0OlSGf8w
	HAetoS14zyW/LCpCLeUVCsYUbW28qKWcuPJnPDpjoQI0/O/p15XpOD3bfQcWRqgEqFzlCfS6mCg
	2aPwWOJAwz1H0qL8+ltp1O872ZYXLQ4lOWQh4S0HlNFu68UVTS9DN/4mUSdhPYv3urvT2f7rQsB
	K+5C/y1QPokQ2bIHQLcJ6vmUU+e4+rgJ4RiLWeY83b8spiHZH9WszQNXNvF5UTW9t5A
X-Received: by 2002:a05:6a20:3948:b0:1e0:c7cf:bc2d with SMTP id adf61e73a8af0-1e16bdd328amr5699742637.3.1733288894411;
        Tue, 03 Dec 2024 21:08:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFj+uUlyY1C0BsWmALoxtojbbY8sLNjryjJ+hUDmswkw3F7P+vqgijj+KJpqRsQ36IWx1WReA==
X-Received: by 2002:a05:6a20:3948:b0:1e0:c7cf:bc2d with SMTP id adf61e73a8af0-1e16bdd328amr5699705637.3.1733288894118;
        Tue, 03 Dec 2024 21:08:14 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:9c88:3d14:cbea:e537])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd0a0682d6sm145466a12.10.2024.12.03.21.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 21:08:13 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net-next v3 5/7] virtio_net: ensure netdev_tx_reset_queue is called on tx ring resize
Date: Wed,  4 Dec 2024 14:07:22 +0900
Message-ID: <20241204050724.307544-6-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204050724.307544-1-koichiro.den@canonical.com>
References: <20241204050724.307544-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtnet_tx_resize() flushes remaining tx skbs, requiring DQL counters to
be reset when flushing has actually occurred. Add
virtnet_sq_free_unused_buf_done() as a callback for virtqueue_reset() to
handle this.

Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
Cc: <stable@vger.kernel.org> # v6.11+
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/net/virtio_net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 2a90655cfa4f..d0cf29fd8255 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3395,7 +3395,8 @@ static int virtnet_tx_resize(struct virtnet_info *vi, struct send_queue *sq,
 
 	virtnet_tx_pause(vi, sq);
 
-	err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_buf, NULL);
+	err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_buf,
+			       virtnet_sq_free_unused_buf_done);
 	if (err)
 		netdev_err(vi->dev, "resize tx fail: tx queue index: %d err: %d\n", qindex, err);
 
-- 
2.43.0


