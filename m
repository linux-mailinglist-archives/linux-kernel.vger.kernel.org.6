Return-Path: <linux-kernel+bounces-527445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B1DA40B62
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 20:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87F45702575
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 19:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6166A21B9C8;
	Sat, 22 Feb 2025 19:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QaY3TEe/"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFA6217641
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 19:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740251736; cv=none; b=etN+aXPwlC1/2pISOuo3vq7oW7EP1BLzfZtXIHSt5UGhDhFJnrVf8ppckX7vYnLKhyRhL32lFW6eDtIblfq9n5eFtgtvOgVdminckat1iQN0QHrPzx3ZahZv0r1QzxlG+gsXfeeCCjEWMqVpsE8mlPsjwfAcQCpLZX3h0pqnds0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740251736; c=relaxed/simple;
	bh=8Y2ZMgshy3DSser0k2/0xpJbIFztqzldqJ0EgMTN7TA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q2qoJxfZuuIUN2y/BW7JvN6yBvHlhzfdZgEET3Grbfz/d9Dj+qBkNYqwnvtr2FRZuOvSCZ3HcylVzYo28i7G9XDMsDs3E1hoLdr5O71H3/hAWk1Bg3OZvPxAMAxGi3H2UzKjMmS643BJ2P8DLPiWsxZaCc6cnDzMFaatfuzl7nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QaY3TEe/; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2210305535bso102565775ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 11:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740251734; x=1740856534; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bokme88KuMNdn1f3MKxdjhr0HIEvbFywaglPVkH9x/0=;
        b=QaY3TEe/dhjGqEuEEc/5BX0kQkxYluD5PyWZHJKQxf1d6M8M/8Y/7dLHRUmAY9uSBg
         V6EgIOaklEuorPEupYLmWrTOyWISyxHTn01obRMNOW74atG5exqzX91lfujwh2OUMiBZ
         S66WdFdQlcxwQOTs5bzetH3HWsobzFfUFpQww1aX/rMYt7bzPpMFnLqNemckwDk5Lr24
         v1ZWqT9tIzshOZU0nTgtS2EX4YQnxzRshkIFRKKNXL/8gYjjCw6wfDkeZQtQATq1P8q1
         v8/72sqgjCPUocV++K0qOnwHfDZdvRQQVknJjNvbv5Reo7jynnDThhtNPpl/6AcztieU
         Uu+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740251734; x=1740856534;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bokme88KuMNdn1f3MKxdjhr0HIEvbFywaglPVkH9x/0=;
        b=n8NYqghdKqSmInZ9EM5ZOt/lj9kPlYkgk9iU5Dw3ABTR16Gyn7BZlKGbmmn5k9RXyn
         dSTrDU/HNlxYt+gyNzvGY0Hrv3rXf9wWhTwhkBt5uODon/5mOircNCovLyoksZsCZ09n
         V6MDggkNaITS/IcDO3xT4phDSBoQYUNOmZjjli3qKZJp81ugQ7RhG9KT/eJi3K8DPb4Y
         G9qvy/bd+q34GTj6iiTkSHKV1xCzDsUkrpSwFMsmG+wb+HTKpPxvu+92e5o+IP1kIPZ/
         DmNHnoN26LndV680ZqYg5bEGMvnlbbjvE1w2s7qnAXDJa/U84ycpUXKsKa0fglcBJXrV
         cxAg==
X-Forwarded-Encrypted: i=1; AJvYcCXEY7M296S4+bBTaKJPnRDiUtETpegT/b0X5cWsGPRzbHI7rJ4NlYRLD74OKOfj49fXd0nED+G1tapQYNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfWtY4iA59JW1WX39T3LGZIdPqlbV0EWlk7o2VBYYhMAUQIJ1z
	BVgyjS5b0InAjz9LgBQhRuPxJDFgte5CSIriUbqPm/69QKgIVnks3Gx2AtOj1NNG2De1MzsqZeL
	l1GBZy+5cpmtL+560IBD8GA==
X-Google-Smtp-Source: AGHT+IEFy9MOMqoUL+PCw3IyeJmCuFhQ91qsxJxZ5c9JuF+IqC2mtPSjn0iWhVp1Rk9Pf+OhOvRwARWSRX9mbFDPmw==
X-Received: from pful4.prod.google.com ([2002:a05:6a00:1404:b0:732:3440:ffcc])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1746:b0:730:8d0c:1066 with SMTP id d2e1a72fcca58-73426da62camr15650719b3a.24.1740251733766;
 Sat, 22 Feb 2025 11:15:33 -0800 (PST)
Date: Sat, 22 Feb 2025 19:15:16 +0000
In-Reply-To: <20250222191517.743530-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250222191517.743530-1-almasrymina@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250222191517.743530-9-almasrymina@google.com>
Subject: [PATCH net-next v5 8/9] net: check for driver support in netmem TX
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	asml.silence@gmail.com, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

We should not enable netmem TX for drivers that don't declare support.

Check for driver netmem TX support during devmem TX binding and fail if
the driver does not have the functionality.

Check for driver support in validate_xmit_skb as well.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>

---

v4:
- New patch

---
 net/core/dev.c         | 3 +++
 net/core/netdev-genl.c | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 8c7ee7ada6a3..ba83b18fa703 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3921,6 +3921,9 @@ static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device
 
 	skb = validate_xmit_xfrm(skb, features, again);
 
+	if (!skb_frags_readable(skb) && !dev->netmem_tx)
+		goto out_kfree_skb;
+
 	return skb;
 
 out_kfree_skb:
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 6e7cd6a5c177..6c5d62df0d65 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -972,6 +972,13 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_unlock;
 	}
 
+	if (!netdev->netmem_tx) {
+		err = -EOPNOTSUPP;
+		NL_SET_ERR_MSG(info->extack,
+			       "Driver does not support netmem TX");
+		goto err_unlock;
+	}
+
 	binding = net_devmem_bind_dmabuf(netdev, DMA_TO_DEVICE, dmabuf_fd,
 					 info->extack);
 	if (IS_ERR(binding)) {
-- 
2.48.1.601.g30ceb7b040-goog


