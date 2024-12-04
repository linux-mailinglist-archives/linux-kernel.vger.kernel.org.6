Return-Path: <linux-kernel+bounces-430565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B89919E32E3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 06:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44DDAB25ACD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 05:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05B0189902;
	Wed,  4 Dec 2024 05:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="tA25twWE"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5E7188006
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 05:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733288887; cv=none; b=bbX+w0xE4d1NYO1o5pQveRcd7KvxdLkiKrVo1eaf1psb9gSS+swlP/H7v66fuetvB+WNfu9dtY4o2h4/f2oOiLECirLBkbz2zcMFti2K4EPmxfBpJzcBeP+vlB9JFPf5+7QEaLdJZzq8LnEnVtBf/v7IHqA6Ig8DRZG1HfSbF9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733288887; c=relaxed/simple;
	bh=QyB99KR/E5dyuun3oXDM9y/WJ8QG5my98H0Do5AE/aY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ew8KJ3p348pl3B8e100XhMkfUUTRH2kC9BfFzppCbrsoKFRDZpEX8BJxt7+lY0q37vPdi+SWA3l70rMfnnnMIQUwtfJ3EzpXFURJ91gdVjYRA4OrKTU3gNrLGVb3Ty0Sy0iMMrpXTFWueD2h/4C3ThrYUFyl0tb35rq9E2BTuiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=tA25twWE; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 085703F767
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 05:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733288884;
	bh=/pCx9eaXWcL4ixwAWHstQXvOGcUbbmljwAztWY9crP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=tA25twWEuEa95gb/WvkSsWO8gOpoK2ee1ZMjyAYQh17VuktUoz8bJtOHof0mf4Q3L
	 4NvsdkhoEYE/g+/30JzCPWuWpXHk1C6SBMkiLIs6EKEoj4jK+1KcKY4Z+2eMIaP/a+
	 Fl6z4rMQHjDuRetTqPTD56lkDC4hcCATlNakOszMiBCBVLdRaPm1Kq91B5HhEkGXgA
	 k+XmcwiI0ORKKIeFJtBmQIMOHXoVAnOcD5PIuJ5E7ky4Ua44LQzZgRIMisbyp3SAB/
	 UYMvjZ5jl0r4yKscS5UcS61j1jZ+zskpyL6B/rzqK9dfZPC0yAWhtwlbN2MydkJSB4
	 w0gIvRhQGEyKg==
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-71d45ffb04cso3382710a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 21:08:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733288882; x=1733893682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pCx9eaXWcL4ixwAWHstQXvOGcUbbmljwAztWY9crP4=;
        b=FMnRp7XZvkDEGP/hOSwm565ZbmTMglESxtWK5ig0YjeuafRFeuGp3P5zkskgGHuWwa
         V4n0JBUwf6FMMSLVqWmtBzvGZqbffsO3R3/kG5EkL4bZjpbOSY6IMAGS/fMSGWKiE1nl
         L2O8aFpclErjoaKESFm0CDl+LoIH5drbwfveaHuQvyyjbtLnKwy5BIb1T1l6N/xM4jTp
         uURWwhVlg7PDBAqRsQIvDp2iMMLDBzWvQVgVJQoQL1PSMDLC5hSJMqXm30S28jUn/3OP
         kWJTEJ+Frip2fyy2ivfSAaF6iJGY8nUJL9gLxWXHJKFu+dyoTLZMTRbRaMgclMxqoykP
         0k/w==
X-Forwarded-Encrypted: i=1; AJvYcCXhzBv9GNrUIPQFBkq/meCEOTl8f8Uq+CmPRM4ezPcIhfUKyOYCo4C0W6ROfoSL5ZXXd93qD80m1eASSWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZmc8+8vbZ+OWZT/OrA7oXbkSKf4/Yt4I08YlNq3DH0LEckc3D
	vT8Ma02835tl3djKn9cYAYmUSH1A0eLudISKE66pVSxM+kXuZjl0WkDFA6+l+lXLbxcdWU625yx
	DR9A4xkCjRRGjkdNIa1nQd0VM5mokSoiDgP2BNLTtdIKXpyWVWDE1tRCYJxw+KVOZUEejeEEthm
	qI7Q==
X-Gm-Gg: ASbGncs0lvvymIaPG+YqzAMR+dH2wTCbGZGm4vMGW43rR+crVePMgDcsxhyqQ84TLWX
	pG4oHixa3PNUsc6Vh1vlWGL3goLv3rZ7ccWdQkA6588xysMlst8Sqmt+vLjfSTm3792GkLuCa7A
	V/o4QQuBz7aiO3wfxrm/RAXKpkBpIeGcWeNCIP+Bco0R6pzpKgpXABnGnlS3fvV7OFN+8FNLh+7
	P/FrXJQA2qMmcDgqLWa+2aJNtJI1SKbQhLO750Ftn6VC220yv8tDefETBlZ2iitHMIG
X-Received: by 2002:a05:6359:5f8b:b0:1c3:38a:2143 with SMTP id e5c5f4694b2df-1caea790375mr503389155d.0.1733288882545;
        Tue, 03 Dec 2024 21:08:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEs3DkY/VwOKGPPt8+iJ+sQPX2t2a1HIu9jL1g2fxiv2RrXsi55RCQsiq+IatRf8oAeRlGmPQ==
X-Received: by 2002:a05:6359:5f8b:b0:1c3:38a:2143 with SMTP id e5c5f4694b2df-1caea790375mr503387455d.0.1733288882234;
        Tue, 03 Dec 2024 21:08:02 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:9c88:3d14:cbea:e537])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd0a0682d6sm145466a12.10.2024.12.03.21.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 21:08:01 -0800 (PST)
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
Subject: [PATCH net-next v3 2/7] virtio_net: replace vq2rxq with vq2txq where appropriate
Date: Wed,  4 Dec 2024 14:07:19 +0900
Message-ID: <20241204050724.307544-3-koichiro.den@canonical.com>
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

While not harmful, using vq2rxq where it's always sq appears odd.
Replace it with the more appropriate vq2txq for clarity and correctness.

Fixes: 89f86675cb03 ("virtio_net: xsk: tx: support xmit xsk buffer")
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 48ce8b3881b6..1b7a85e75e14 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6213,7 +6213,7 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
 {
 	struct virtnet_info *vi = vq->vdev->priv;
 	struct send_queue *sq;
-	int i = vq2rxq(vq);
+	int i = vq2txq(vq);
 
 	sq = &vi->sq[i];
 
-- 
2.43.0


