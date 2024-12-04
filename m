Return-Path: <linux-kernel+bounces-430570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A5B9E32F7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 06:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F567B2A072
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 05:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB681187FF4;
	Wed,  4 Dec 2024 05:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="RNb3nZ/D"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D091217F4F6
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 05:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733288908; cv=none; b=iU1Tjj5L4MqAJ7iRwVTWThIIYmXsrXAld2xDe36AtPr+fySaucPrgLQVs9GdT4XnRanJskE/ejOt5tq61ZXlwFMhhRvIS3c7btdUQLKE2kTsCLzrpRLUP5mot7dSZTp/FQkguhClIwRxry8DErtDUJ9QiAUmhCq9pRxPzDHzcjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733288908; c=relaxed/simple;
	bh=pJkC/sg81thrf+L+DBV2A5EohoZuMx0x87sK8yW3WmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDSULIkH4qEbmU5xHoaqIMiyM1e1B3cZOBNvlWhMUiRVwRLouCB3cRxo4gNTY1C6RiNmfdHJf8W1czhqs1AcFxoR5enYbzDbrrg1Vvy94IIgntWhAQKcLT45RiORGWQYChFJU5t8HEFtyLLazwpMauY8FW0jB2atsQWYfsQxPf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=RNb3nZ/D; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 165E93F767
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 05:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733288904;
	bh=9uM+qY4J1GQbqjmyDa0r1OVtoI70UH7O4H6kctiyohw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=RNb3nZ/Dju3MXmIt9xCp+I4QFIndzYDkC/bRwMxnumYQWyT/B6V4YBglTrwW+2Fk5
	 Bu53TcRURs+UlO1BUyrU33SvY94U87Yv/JG+N4aHh5QoaJ9hLrQ9un5y+qDxiBGDd9
	 x8M5gikXmBqbddu96hCLd85ieoaox0EaWlm3nAEr51ZX3zWBHGF5PnUKQl4oqPnvZ0
	 Ynme3mGq51tb4QNoFGntWjJJjApoX+ZgaMXvEL5IMcNWYdQmzeC2FSnYlm45QNmCpO
	 8EdM1iVOI2xsk2jS7aDN0Eo0KXVARkoqugQhxQWNMIis+nGYigoXb9boBpTLDazFnA
	 MPFKjfCLsCShQ==
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-7eaa7b24162so6144187a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 21:08:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733288902; x=1733893702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9uM+qY4J1GQbqjmyDa0r1OVtoI70UH7O4H6kctiyohw=;
        b=maM2Lx8gtdZWNF8Bf/zgn/DgH9EB30SrxD9/2YythDrLz3WPKyEG+jZgYi/RNPxgpU
         SUxuuNoM4vk/Nov+ns3T8co+UIS0qFFORYvM7h901oY+ghr9CCTETeeSDC2yTe57SRKo
         /Pb2L7pEbBk7FFqn2HO6Ki4YgGsPO4pvyYK2jRWxOcosR0HKTiX2IiQO0K3h2v+f/u+J
         fqa9rkyKqPlH/h5ZIbBOWjQWrtaxYWsGB0QQRjEjj5yFvWvQMlyaDVuBa4I2k8acTSWK
         I8Qlb7FBwsdMR6aGxvOsvhtfX0WinyCfdwtskS41Ob/Pd4UYDdZ5y/8wmBNOdYwwUhkA
         eeNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeapLe7Sw4ip/ty9VbU4PGouDhOgDj4qjjXYWAx8av48IHUIGM6l+nCtIAgC9qLA9tSBzQ+jrBivbsVZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrmUseU/5TL5EjG90QXw3rjQPgCQ6E9g0lLS1hU7ZYI1ujQIXX
	qNC0DGoabZpyG7yPPq7vIRscZjgrfHO26057RyNVALRiIwI+PuLKyoGXML36HVpvBOxatHaFW8A
	XmRAFsYcOgbYkZ+wwD/1OYpvxjGtb03Qc/WIMs6EkWKAKsP0EP5BWMlb3ezD2sGdvrfzmHpiCvt
	5cKw==
X-Gm-Gg: ASbGnctTwtULvxKD98Ac90qpotnAD5y1FBmsEvAPKrFEsShcJvugeJ3TLgcELJP+JN0
	ZGNS+93Aol5c78j1Mn37T/12hYyKUUrw3hFv3VS0vg49/eq1bu/rZEV67zCNqU7iCkLfzhThA+Q
	40uh65TfiYRmgBuSn0X+OtLYzM9Oz/Kq8vv5ToPJoa+gmbzKKa+cN+pKDIYTlqetKUVDiJG0M9D
	WL4QVnoeVs/7z9W+hCugllEXcjnf7F//fuQJirtRXnnsFm8xTB/GDiOIA05rdjcS9UU
X-Received: by 2002:a05:6a20:9144:b0:1e0:d796:b079 with SMTP id adf61e73a8af0-1e1653bb99dmr8288069637.17.1733288902450;
        Tue, 03 Dec 2024 21:08:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtD8y79hadaHZvvNeugnEdk8crgadqfqLkx2GLITOJPtd6W8UtDItN+uiyqRlDo7jPSUc/FA==
X-Received: by 2002:a05:6a20:9144:b0:1e0:d796:b079 with SMTP id adf61e73a8af0-1e1653bb99dmr8288032637.17.1733288902122;
        Tue, 03 Dec 2024 21:08:22 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:9c88:3d14:cbea:e537])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd0a0682d6sm145466a12.10.2024.12.03.21.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 21:08:21 -0800 (PST)
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
Subject: [PATCH net-next v3 7/7] virtio_net: ensure netdev_tx_reset_queue is called on bind xsk for tx
Date: Wed,  4 Dec 2024 14:07:24 +0900
Message-ID: <20241204050724.307544-8-koichiro.den@canonical.com>
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

virtnet_sq_bind_xsk_pool() flushes tx skbs and then resets tx queue, so
DQL counters need to be reset when flushing has actually occurred, Add
virtnet_sq_free_unused_buf_done() as a callback for virtqueue_resize()
to handle this.

Fixes: 21a4e3ce6dc7 ("virtio_net: xsk: bind/unbind xsk for tx")
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/net/virtio_net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 5eaa7a2884d5..177705a56812 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5740,7 +5740,8 @@ static int virtnet_sq_bind_xsk_pool(struct virtnet_info *vi,
 
 	virtnet_tx_pause(vi, sq);
 
-	err = virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf, NULL);
+	err = virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf,
+			      virtnet_sq_free_unused_buf_done);
 	if (err) {
 		netdev_err(vi->dev, "reset tx fail: tx queue index: %d err: %d\n", qindex, err);
 		pool = NULL;
-- 
2.43.0


