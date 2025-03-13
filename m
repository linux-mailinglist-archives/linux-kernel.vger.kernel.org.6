Return-Path: <linux-kernel+bounces-558863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A0AA5EC4C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CE3C3AF78E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3107F1FFC71;
	Thu, 13 Mar 2025 07:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="N9z5AYpR"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFC21FFC69
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 07:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741849299; cv=none; b=czNdY1XO+UOrpb8e4s/1ELXkN17BIZwtfd1Q0GKbF4pErLcc6Fhy9gk6Bz3uW53hWbdEKgRKn0zjKFjjft3WW4CyRv+5v8e9hs10RzxlKw0+fHkEgZRDEaH6kremR8PIa+4DtXQZ3GY3Jj/EwGe/WcNZmQzTNTlXfoi3bNJoNpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741849299; c=relaxed/simple;
	bh=tjt6UJr/WhYJJgKlXXv2tzURIehZ2/2wH4imLUM3bx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=pvB6KiYMr8J0Og4Gxycrp/PmIrcAt6fRk6XFqer6Hj5t96JfyF+SagU4MkeDFcXgkn1ah9xB05H6+simfXCztyAcALt7r227hOBPWtGb57n9Cr/qdIB2UZO0UfW/+eqX2+ErBntWlNm8f6sV+CogglPCdLlk5JRLDJSMt65M/MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=N9z5AYpR; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-223f4c06e9fso11048855ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 00:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741849297; x=1742454097; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DgNJjOB2VNdnBavlgHvSgZbzYgc2stuH8jHGRqRaRcM=;
        b=N9z5AYpRTofOvsMI8/LwRH3mSDceutebZIF40gGr1Wln4VrZqMJJxmSf1IN25vD9Bc
         XuHixSgts+t26afNcN0yLL502JAakibg5hlGjLEWp+kkGJs2ndzlZTii8AKKoyPiUkkQ
         2LAuA2Z+Qc4+yK3341SYhq1awEmnVeFYiyYRUpGuwi6PTfySqYXNKNo3U64bz7G4rNIe
         9QKbrsWC6KIWTLJIc7cU75WZBZtmuH1EwGg+jSTsbIGUfF38miFZq0n0VM1rObCdzozp
         VpTGXEiCKyyaxKxNrbxiBfY+hen+n2wsF+Ppal9ctqlT6l5E4cMAJj6gj3wjgJv42i9T
         nSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741849297; x=1742454097;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DgNJjOB2VNdnBavlgHvSgZbzYgc2stuH8jHGRqRaRcM=;
        b=kk4mRSYA4Ux4T6x2L9+cufFeqBkB62SHWM+zfrvLI2RHoDVFb0MLsleM+w88/HYj8+
         tH4MxkWGuZJXoUeWisoSxWSiJ3zNVbShIN9KwknEAVCRWzybsLB77sW0R485nqUzVPIH
         /9qC5MAbO1EJTAEWdx6HnMg/RjE5ZtfUbaLMWZxkvqi2Lvr/ZtWtvPklgA/GryNLgtDf
         p0b6pVItgQwNVpYwRnVkEz5/PUbUDUzMWWS1Fhde7xCHSP40+UV9/ucbwqUXDvNFM9h/
         rOqE1F1wHptuzpwqBx079FwfnvZgPl9OKzjj9jW4WjhON5g2EpjsUd+N2cKvZJuqzwXK
         lmbg==
X-Forwarded-Encrypted: i=1; AJvYcCV93XPsSdX2VEvECWA1Kt/Gb9KaQIQv6e0emaRJY4c2OyZS5a+ay5gXfjdGLc4aYsVFMoEUxO4ddK0SXvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzoh2YMtodWvDBbFTnpiuhVo5+MpeJQKxXCwrhdPOe3CVNhzmbA
	onF3hYZsTpZY1u3d2F0ifEhecPpTV8+hKqkXyk/f8rrTkTkb2hAU8PCHsnDE9kA=
X-Gm-Gg: ASbGncu57xZcCAhHRaxBH7BWj0LAOw+dalTT0wa3+5tm+ipQgFi9EJ4fhF/iuHSdORi
	+v/OABA07/lxZJgkn6aldNyuDcog18wvTMEn8IHWKuxfdAwGKgZWoi1BFvkrGJbbHGySdg2fGp0
	Fi2DljfQBDyGK7EoIc5p/9tlLXzfFAJA7u9QG1zcXuLgpuqcDAT5v/Ut8YQsIR9IQ/EIeKFaHlm
	JoJ+yk3Bqjxv8cUdq7qXa/V1RqIZK1QvtpZCzptgNtVNPd38zzVPPq0B9st2RIVOlPwbW+O1AnJ
	mrgcGw+JPDEl5UvRKtTDpUYnkCZd2sDACTaymRfOcfgxBPb1MfIcUZ5iKGo=
X-Google-Smtp-Source: AGHT+IF5wWHOyH5JHVoHtTy7K1X2eW3fNA4SOZ5Z2GJbYtGXN3r5z7f/KOO/C3Z0RJnF3qBJwnVUzw==
X-Received: by 2002:a17:902:f548:b0:215:a303:24e9 with SMTP id d9443c01a7336-225c651d65emr18870555ad.3.1741849297043;
        Thu, 13 Mar 2025 00:01:37 -0700 (PDT)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c6bbeb7esm6519955ad.193.2025.03.13.00.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 00:01:36 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 13 Mar 2025 16:01:05 +0900
Subject: [PATCH net-next v10 02/10] net: flow_dissector: Export
 flow_keys_dissector_symmetric
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-rss-v10-2-3185d73a9af0@daynix.com>
References: <20250313-rss-v10-0-3185d73a9af0@daynix.com>
In-Reply-To: <20250313-rss-v10-0-3185d73a9af0@daynix.com>
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


