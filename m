Return-Path: <linux-kernel+bounces-565881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B82A6707F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C39E17A627D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE61207DE7;
	Tue, 18 Mar 2025 09:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="VYE+pb0g"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC19207A3E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291826; cv=none; b=GXlEtif+r/iB9RLlIHvsMAbRFqPZ8U9wNXiJaMs04DxqjtmOJcvIx3GHDZDS32dC3jqQOVWDehH3HmuXTOTELJTdrGA+zUmtvuzwgTG1+AuKnGaWXFSN5A4goCHeIMferZc1fdoPJQDKb0l0w7OvbIpO8XI4+YrDhzw6Cw21gd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291826; c=relaxed/simple;
	bh=y7xGmXz1+joLuyF7rRKoRaRnhcPRU8zLLhDGbCzRvUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kd0of1EFl6maZinD5hnCzVhUDeoJxwTILLpC+z9iB5oRNLAYWpESEuryud3qMpqYJ63TGQtxJp7CAtHIbHS25bbQUq9Dut8YKZPiWHEpibS/oowJPyg7xph4Tu5nlZTzS89an+jVl2TrvTx7ECaN8Mt3fXhGjqCWz5EzTWkLva0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=VYE+pb0g; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-225477548e1so92862665ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 02:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742291824; x=1742896624; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VFcdkuZXdG0nFv0JVqG4IlwwkUXBEREwH0bBsZlwErc=;
        b=VYE+pb0gott8bXBnveB/YaMuIqCVjTM4+OzTRmcJq0mgofuKNn80ebEBJlfl7zHSgV
         NpHP2SOLr1JyDyASJM15U8mkOXoYK474ks600F9F705p82n/M+o/mnWq2/Q/tH3FbGvr
         XNrqWVoPnvQIjTmjCwXj5h2M2no3fRzO6k9UU1N/RS7LB7sliMaBmXKBwJFQS5md9ORd
         FU++dJ8QPuOXZ2ZCtjTHhe22SslJ2FtRhJUhFEFZ4604vzWhMl3poInMW1GIAG88l9hC
         XmYwNMGUpbagKnWD3lIqKa67e7iZvjaKmmK8ink/xVVkbOZHQfwihFUptCIAwVt9LyNx
         HX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742291824; x=1742896624;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFcdkuZXdG0nFv0JVqG4IlwwkUXBEREwH0bBsZlwErc=;
        b=hAj+LCQu3Y0WG3fs4VdYj42FC4vWx2N90ta7r5VvKzsGrb4U1iTiuRFmqdqp0Hcex8
         rcU/XyjD7aWM7cJmczGW5a/kazLNyhGY3PAildtcqCpB3Nc35O1ZvKacFRRCBs+JYWv4
         iTTzkNdd9EbmXOP0nK4MmGNyZH/8ZMxiich7EMUULZ1U7chXKfCmk5Q1GEFyonwC32mx
         60SwUIuS6aoWxlPIAoeXgN8Eg2DMA7sE/Rv73egf4DiQsP5Juu/4FAEUrt7K5K/DgITT
         66/eJSH0a+5zZsDZabVPW7phoUeSbP2C7KV2FTC1wGYqS2TGEqwbNAmCKd65V3t8ol5d
         eL3w==
X-Forwarded-Encrypted: i=1; AJvYcCWH2Juvx0NpwjGeDTOzXi7WG6Vu4yUFMaEAtFZASiNZleTznZrZ95FHMQK8mLEjsu9xu3nVvtdX+Dzjzlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwUrOHVKJV1Tkgc4n68qYOqwwYA7KDrpFGhMy8Y/tgUREFCaex
	erpDqcxrqYbNgGM6InadxCHgwJcBa3BzAbmgWN6pqB2XtzqalZPBtVTogB0ASsk=
X-Gm-Gg: ASbGncuxQxydUss6QSVZeT7/+ZbO5qyImtCRIVJGw7MAKR64DpZ1fpnAP9zh+7Sg74M
	Et1zqPRWpBBwF27HflA1ANvBlg8ORLLU3EgIJ4BN/aw7k0/trBv487YrEhK9vd6j1R8GBkwCFMe
	B6G/n4G71FV8mo2SkH/0hSXtPtC5YuN5+A6kfhoehOKokiS2FpDXb9DISE3xJ4z2w6MI5NYPR8+
	WqY7YzspBMF323PE7/vEQLfPoHXJpzGY2ICFzS5O5krjpf8EhoHMJflUDGyB1HpaMADKRzLwwSV
	5+wOsEbQxkGIoSztNCS6vrZG0XrRKVF12VkYXvWhQZWivqHO
X-Google-Smtp-Source: AGHT+IEDg7sBznXHtheXcTwTR0qQJ5XZCTzq1W3+7+Ny1lJUvohFaD6bIzC8LuHltfp6YLS3zy5cUg==
X-Received: by 2002:a05:6a00:2d95:b0:736:4d44:8b77 with SMTP id d2e1a72fcca58-7372236edfbmr23606104b3a.8.1742291824189;
        Tue, 18 Mar 2025 02:57:04 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-737115781f3sm9150521b3a.76.2025.03.18.02.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 02:57:03 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 18 Mar 2025 18:56:51 +0900
Subject: [PATCH net-next 1/4] virtio_net: Split struct
 virtio_net_rss_config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-virtio-v1-1-344caf336ddd@daynix.com>
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

struct virtio_net_rss_config was less useful in actual code because of a
flexible array placed in the middle. Add new structures that split it
into two to avoid having a flexible array in the middle.

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
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


