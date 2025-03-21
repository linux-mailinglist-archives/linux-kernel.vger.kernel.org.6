Return-Path: <linux-kernel+bounces-570797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC03A6B499
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03F4D7A719C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778551E7C28;
	Fri, 21 Mar 2025 06:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="MwHkEHTi"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717231EC009
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742539742; cv=none; b=mlm7KO15d5AtYGHRsKx4Yh9Nld8XWkSkBigYJBNe1llMKtTqMtmFbuJg+3kBmaU9D9YPLtfKsJ7CYLwKnhYK5ZSrPZiWg+JPAu67G3yWeiDmP+6Ty5sNCZbMCpAn0NLqmgxbl9uMUyS75jpiwrhA6wIxSurdYaxSSfJubd0Dnh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742539742; c=relaxed/simple;
	bh=JjapcMVDGbOLgMkpCmBgvZCv2tls7EkMlHjM4nzx7nc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VG2aukyeSvOWxY3yQzfkB33zmbAIJaHp943lwReiW7cyyPg4rY/C4fdQPWFyU7FUCZ8xQ1wRqCWZtVbLmo4YS0mXZualt5gatlwPkWotY1j59XN2Ws0NBzXxVu+DhABJzHgn9u/a3glxqDOmiyMm2fcfOrdKEEiAeR170CxAIYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=MwHkEHTi; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22398e09e39so32957445ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742539741; x=1743144541; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b/ZmhDXoFm25C2TQibSTkJHDcTfVUeG1ViV6OOg3xRE=;
        b=MwHkEHTiKDEeNOyho//Cj5YIGbXiWDHlEToCwMMiDc2SD8naWH/fH4SDgNS5AAY8T+
         P/EyId5Hfo3xy8SErJuDVF9ZgtnNknJFku/xi3AjbFigt3TL4i9LVxHtUnQMOvMLgcIt
         lVgwWpwOh1TQq6S4mNPb9r5HrW7JrH125qjS0mSw2tmIPUZF6bT76P30avhXsTrd03/g
         NRqryO0lzBfd1DoT0FwkqwvAPxwUpwCJltSw0y49QUkwQsThND73sOTRXoBOjC1zDkbm
         bH7/fuXin9V7nGY6t0we4DqpW5j6+gPP6fuPm2fFuQz+b9V87rXrHc1w6RxaH42UUbH8
         lRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742539741; x=1743144541;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/ZmhDXoFm25C2TQibSTkJHDcTfVUeG1ViV6OOg3xRE=;
        b=MNQqKr8u3pntLGLGKg7Uf9oT+ssXddOw1HVoonGh5raBk29Ln1okR3uDKGx27n3vJ4
         2xTx8CzOyTiNTva83er6R/i00l7z9qw8iw6MWVDEIdlPCTQCxPXRURS11UaLKwKX4T5a
         fEB+LrUSx25wG9N2Yrl9UKdnixRAmtghpFPEuzhzWc0rcj8N3HTFoVdu5HspjbrnP0Ff
         GEjIPOfO/WH1rVG/VPVeEBgIVhBUOs6eNJmshR4AWRRvNCunDx/z2OhdTYTXKno8rY0C
         wYpnRPSe807KooOVY3h3HautW1eihtZxJT6sdAW2iPh/AJ3W4vqULMVonGf41NQWpMoT
         qRjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtx2aVwabXH85vm7iGq8L3KDA++cIkyQ/GKRoSmugRSmcI52QbDE7HFygkzxt53IuEa0rgB1RQVbpbutU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsy8SaHXgJEOAhU8AvRhpRS03Pnzn48g/ENkx1kRoIAalrGnEX
	+JNzFdYoMzTT2dlLRewdxX6M4wUQgie8pkatqQPNyBHzjzattp9b89fJ4egFRYY=
X-Gm-Gg: ASbGncuy2BS6IbzYzn3c23qHJWKZmW3ooxhbQ6mGPNqZz9HFqXV1ISqk3CzAxnuh+ob
	SJP5SpkU1xCzjV6dNIJYl69ksc2sp2SVZiJzNL0ixanQv6q79p7jNNEJaAubPxW1c7HJJP2br6t
	R9kybxOPcMMdCJ+9vAbKu7ci1rc4mw0UMcLL10GhyKZpc9M1Cb+MPvaoWzeqmi/sXnWToMo0ees
	mI48ha+MqYi8R/+ea5paEx76MVBMx3TOYWnLMc5Ua4JWIepfRx2zrb2brdS/B4/Gt4vBJFARNrg
	/A/kdEgEjhdrS4yvviZAasg4LNHt3wJKULaa66oBJ5AA1tVX
X-Google-Smtp-Source: AGHT+IFY57i8l2zIDhAAWUOoYbKyLPQPPGn+mWn2Fuj0WlYT5jMKi+NUy5SRU1dEXrfFRpylN+S9vg==
X-Received: by 2002:a17:903:22c4:b0:224:2715:bf44 with SMTP id d9443c01a7336-22780c7b0d9mr33833585ad.19.1742539740663;
        Thu, 20 Mar 2025 23:49:00 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22780f3977fsm9212645ad.14.2025.03.20.23.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 23:49:00 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 21 Mar 2025 15:48:32 +0900
Subject: [PATCH net-next v2 1/4] virtio_net: Split struct
 virtio_net_rss_config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-virtio-v2-1-33afb8f4640b@daynix.com>
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

struct virtio_net_rss_config was less useful in actual code because of a
flexible array placed in the middle. Add new structures that split it
into two to avoid having a flexible array in the middle.

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/virtio_net.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index ac9174717ef1..963540deae66 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -327,6 +327,19 @@ struct virtio_net_rss_config {
 	__u8 hash_key_data[/* hash_key_length */];
 };
 
+struct virtio_net_rss_config_hdr {
+	__le32 hash_types;
+	__le16 indirection_table_mask;
+	__le16 unclassified_queue;
+	__le16 indirection_table[/* 1 + indirection_table_mask */];
+};
+
+struct virtio_net_rss_config_trailer {
+	__le16 max_tx_vq;
+	__u8 hash_key_length;
+	__u8 hash_key_data[/* hash_key_length */];
+};
+
  #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1
 
 /*

-- 
2.48.1


