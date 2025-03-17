Return-Path: <linux-kernel+bounces-563980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F205A64B3D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 224747A5759
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECC6238D2B;
	Mon, 17 Mar 2025 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="j+lLz8eL"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B8E2356AA
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742209103; cv=none; b=DAj8aHsDyhMghQ3yqy+Dl3JTR7CB+YtWoPTHEs3JYZF3p+xXMjH1SFNqS6bT4tSZQ7qvvxYA6M7NtFrr3gaOmq+BmBjU0EH0fEsGwutWEbyc8QhUqluXrjrp3AI7MSN+WV5h82wzVuPEfcqw5GHYKgH9EveLNmeDyDeCk0JqZwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742209103; c=relaxed/simple;
	bh=tjt6UJr/WhYJJgKlXXv2tzURIehZ2/2wH4imLUM3bx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=p4c6Ly4wmZ5ZqPWb9TTAehFUFHMd3C1NXMObAHDHY56IxDLkgAh95mRDUij486IzS4DQR8I8ViSVcDogVyWoUDY/KECv3b//RGm3Jic2JByhx/qphIZ1M2I31z6NCqUD/8Gwl4axWZNo3zbUtMRJL+ny7wQNsWxqHHS52f/M4ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=j+lLz8eL; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2240b4de12bso29524195ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 03:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742209101; x=1742813901; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DgNJjOB2VNdnBavlgHvSgZbzYgc2stuH8jHGRqRaRcM=;
        b=j+lLz8eLakE81+m0yuyOwLTi6gTHraSkvo0Bi4u+gW2U2Sl6vi0Aw8laftxhDCcw5v
         JGKhFhWq07jScGJH8mIIgEIZ6MIor4gD/Euj8PmubgbLmqqdWPkHHq5EWA8zEzNttsCa
         uEy9bxX07xU9LUtF5EJqBmBFrMylPUqTZGsBq6Hx/rgdu9MwdXwqVVvm0YPhJ84i4MyJ
         Q2/l36HDxR3ugO4kS8QTXuQtpme3NWj2u8eShO+TKyr2mgwC1loyGGZAInZMG//1oYWG
         orUfUxb1Y9Hi1awZR1Y/UvzN7ACW+lq3JakHZYAeD6XQd/HIl1JFjQ7OkyEWGM4RKfRt
         uxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742209101; x=1742813901;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DgNJjOB2VNdnBavlgHvSgZbzYgc2stuH8jHGRqRaRcM=;
        b=NSRnBW1CKw+iQY2X5B6tAZHooOiWtRX9fCN1Y1iPy8xKdxpLHkPFIuhP0QGR/p8kHb
         vYswmCOwtxwe4QQnCNYmavJdIB9kLKA2XZHrMDy4nQgV09ksI2++55s8QE0pT+ukmIqn
         p/W/fbgAPLYsF4X5ylUCTeSZVARXHUnr470lnZUSDHFraCUKQJM6Er9vq4rHCyvPzoFh
         dCItvqsRukqOPBMS0NSxBKw1ZI9U/RVwWwBewsin43cO86j6mMn3QXMi9bHCUN6VQJXX
         VWUMJ52ST02Zyk6lFBzd99LBNerXrdSpOnpaUqJDJOckBQ8VbQoODPDvYAdCTrin9Ney
         +yYw==
X-Forwarded-Encrypted: i=1; AJvYcCVKaoE8XpvOCaWa9TaOKeGQSYvoqLnMcs6qlbFU5KGNajYmQMc8oPO+h9TZNAMOH3oVMY5X8P+cpfryCYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8VU+G42uvPhbH7v07rsJchnkxmSkGFLQV/8Tlw4vmheYYTfKY
	Z6avO67Re8zCUPZ7d/eLX/XS26Xrx9EV+nyK0NLFsGivRb+LTzgVePrpGBUjNkv2rvPzZL6gIN1
	qTVI=
X-Gm-Gg: ASbGncuVFse2Cq7QfSEmujMINj32SOvRdGqVKhqlOycAJjz+wFY+Ut1jwy+uRbkBzmh
	D0dmX/3AyRZI6vCvl9lhOVsDt2TBBjY1NPsRGukg3mHjghsYs0gyYu07rjAPeG2JHK9vRJs+0TT
	cX8jZPBZ4zy0WYbsVw3UVa2f5sn+06VvHl/XCA0HwM2R27n0HnNuLlGh+Jz9zwsnhgvUoKvBXvS
	vQ5u4PnsnUF/p49ERZ5tztus7NI+rnNwpJS+Wm/1UliH1pJH313A9CTWTOdIMFazMPHZvnXeOID
	9wm4snbAgtjfgBENK2OKWY+kNDxdhafROVcu/WXOUIfNoQOoUBnMkoi2o2A=
X-Google-Smtp-Source: AGHT+IGYq7HCRRL8m4VKOQxjMlmqfYplWsVLO77u9xzWoCNDu3x4nlybmlZH5cMRcZ12ODXkwSAaKg==
X-Received: by 2002:a17:903:11c4:b0:21f:85ee:f2df with SMTP id d9443c01a7336-225e0a896a9mr153965305ad.15.1742209101298;
        Mon, 17 Mar 2025 03:58:21 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c688856fsm72665785ad.14.2025.03.17.03.58.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 03:58:21 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 17 Mar 2025 19:57:52 +0900
Subject: [PATCH net-next v11 02/10] net: flow_dissector: Export
 flow_keys_dissector_symmetric
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-rss-v11-2-4cacca92f31f@daynix.com>
References: <20250317-rss-v11-0-4cacca92f31f@daynix.com>
In-Reply-To: <20250317-rss-v11-0-4cacca92f31f@daynix.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
 Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6

flow_keys_dissector_symmetric is useful to derive a symmetric hash
and to know its source such as IPv4, IPv6, TCP, and UDP.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 include/net/flow_dissector.h | 1 +
 net/core/flow_dissector.c    | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
index ced79dc8e856..d01c1ec77b7d 100644
--- a/include/net/flow_dissector.h
+++ b/include/net/flow_dissector.h
@@ -423,6 +423,7 @@ __be32 flow_get_u32_src(const struct flow_keys *flow);
 __be32 flow_get_u32_dst(const struct flow_keys *flow);
 
 extern struct flow_dissector flow_keys_dissector;
+extern struct flow_dissector flow_keys_dissector_symmetric;
 extern struct flow_dissector flow_keys_basic_dissector;
 
 /* struct flow_keys_digest:
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 9cd8de6bebb5..32c7ee31330c 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1862,7 +1862,8 @@ void make_flow_keys_digest(struct flow_keys_digest *digest,
 }
 EXPORT_SYMBOL(make_flow_keys_digest);
 
-static struct flow_dissector flow_keys_dissector_symmetric __read_mostly;
+struct flow_dissector flow_keys_dissector_symmetric __read_mostly;
+EXPORT_SYMBOL(flow_keys_dissector_symmetric);
 
 u32 __skb_get_hash_symmetric_net(const struct net *net, const struct sk_buff *skb)
 {

-- 
2.48.1


