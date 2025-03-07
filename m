Return-Path: <linux-kernel+bounces-550930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CA2A56615
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7F1E16F2FC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913552147EB;
	Fri,  7 Mar 2025 11:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="pSvSd49D"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63886213E8D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 11:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741345307; cv=none; b=RORAhKkUzaeKxypOirPBPi9r9qfSbORLfqaHt1B9KnehcqyJLaLzRjBfG3BAUWGBhWTtDRWj5M9kObH8zUVSE3UTshzGxhG+Vb6sOKZEtUjhEzvl7YVhQq+FfF6vxwBoAimjPx1I6JrYUrmrx/bmUq+VsSLqIA2a0IGkikmPins=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741345307; c=relaxed/simple;
	bh=0OHQ36QrTe7B1BaBYHRqBfDehy2+CeWD8fTKK9khYSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=czkqjCJucCDAMusRLvZVu38t4UKiafHC+C6xuKLF/Vv5GwJLQzENosgjEq43n+pWUPrjNVjrWS2C7AAR4bkozSTLJeW9ZRSGZHFna9Rn+Yzp1i82kW644OfDRSjr3RR6j9+554bqrli+BcuW+ELnslNjnIELHx4fygH8tSHjhwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=pSvSd49D; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2241053582dso1856395ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 03:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741345304; x=1741950104; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hESKaeLsTlVoI9NZlnZYgG71APAUJLtsH2I4Uu+Ek7s=;
        b=pSvSd49DoWaQg/f0IZCJ+wGwjbFt4a5hvjUDiz3wJ4lUQFyWw53uwpuwFf2hj6jY5Y
         r3frdY8PkzjsgnQBOgnqgfolfyjWx0EfU1E1sC5gh3fKxCB7vLeJTqIIBEflHsJOoMdn
         R/ja6NKtbcJKrg1Ni/VaJqn16aOpSjD5M3s75q4bL0orOOILL9P4ccV3PYiEeWhbryoP
         DyDl5KWuSqzshm52yQ787w2gYBqyFsX6D9uOtebp3s/fhJsY3P37tj8njvytymqit+4s
         Fx6wLPk1Tsj4Smlm7TxYUW7ibEhjNWTJgJcRP+8cYpkWUyIMPQpIHzC5nE/SHgCvIWqR
         Mpdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741345304; x=1741950104;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hESKaeLsTlVoI9NZlnZYgG71APAUJLtsH2I4Uu+Ek7s=;
        b=biAmku9nnJqioUIgL613Iw+fI3t1mBwc/bqgi96ykT6jvmoFKW5aBGsG5jdAF4i1k0
         F6020SamC7smWHjUJaXz0QmxfoXG3IRj5sNhXjATKYvG1aMzYFHQmKHmQwTyM/Cppb/q
         Krv10kP73t2g+9/01jpp37AezO0JCyJdt7OGFVfSYJXhyPLZ9QsbT457I7I6Sq4jquRv
         MfA5R5+11i7RXva6+J+0j40O6NlGW4VUztkigsLp7tgC9Z3Wlint2GB8MWtoJe5KtXPa
         QRvNRk/Ku4oQ1FTKfI+bwYTGz68LQpBlFZSXpixkL0EOvkuBG6vmxk75nLUI4rIxg+w/
         v5EQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOIxC2cwCqmVng9+asvSYFCNiYyHHB7gl+ex7HA+7RAtJlIKU2pgxl6+ta8eNPswX02Xd5aLwnchlUs3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwujXgnj858ZfkB9pXwp78eXuo0qses6ptAtx10FCx2Zcdrk5Ia
	Sgv0PpE5XRvMyUTGlEUMLkFKtD8duXYURHt1vUzQI71lEPQuE1s0zIjDoOARtjBWjbMKolBbigG
	HqFQ=
X-Gm-Gg: ASbGncsrsiHtgNomnhsUpTeo6M5R3G3GmGnGaAbslKeFwzZSY4cPxnNI5zWXZ1hwBjS
	nHJBlWNVuz89L1WaF20w0egobVQgtWxFeVUFc6c2kDI38W54/9vUo78ffbEioS+FgEBxSD5jUdD
	zdETP87fRZ/dAPM762UhmqjzemzGEf9mOZpnwqyTcoTtmGlsnAfkUcGWt63ios1nK6cAxmwNPHb
	ElfhH4sMgg/HEMSICZeT6X7ldRjgNZktckhv+w16fhKE2KufEPnnbSrj0Vj6fuwURR6cb8qNZaT
	vlgAs8RPUZF0vTtcsY4O7Dsl8W7ANGZp+4wM17JQgYP4ftS1
X-Google-Smtp-Source: AGHT+IFjXPz+rtxm9fbn+OJtTENM9UvJxDY3nmnkxyWgPEnLzrhO14S9pj8Y+h3HFl0juxuW+kAxWw==
X-Received: by 2002:a17:902:d505:b0:223:37ec:63d5 with SMTP id d9443c01a7336-224289945e7mr53616935ad.28.1741345304575;
        Fri, 07 Mar 2025 03:01:44 -0800 (PST)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22410a8ff3csm27196145ad.161.2025.03.07.03.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 03:01:44 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 07 Mar 2025 20:01:18 +0900
Subject: [PATCH net-next v9 2/6] net: flow_dissector: Export
 flow_keys_dissector_symmetric
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-rss-v9-2-df76624025eb@daynix.com>
References: <20250307-rss-v9-0-df76624025eb@daynix.com>
In-Reply-To: <20250307-rss-v9-0-df76624025eb@daynix.com>
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
X-Mailer: b4 0.14.2

flow_keys_dissector_symmetric is useful to derive a symmetric hash
and to know its source such as IPv4, IPv6, TCP, and UDP.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 include/net/flow_dissector.h | 1 +
 net/core/flow_dissector.c    | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
index ced79dc8e8560e25a4dd567a04f5710b53452b45..d01c1ec77b7d21b17c14b05c47e3cdda39651bec 100644
--- a/include/net/flow_dissector.h
+++ b/include/net/flow_dissector.h
@@ -423,6 +423,7 @@ __be32 flow_get_u32_src(const struct flow_keys *flow);
 __be32 flow_get_u32_dst(const struct flow_keys *flow);
 
 extern struct flow_dissector flow_keys_dissector;
+extern struct flow_dissector flow_keys_dissector_symmetric;
 extern struct flow_dissector flow_keys_basic_dissector;
 
 /* struct flow_keys_digest:
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 9cd8de6bebb543c3d672f576e03b29aa86b9d34a..32c7ee31330cf52df05d7a23b3e50d1a1bed9908 100644
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


