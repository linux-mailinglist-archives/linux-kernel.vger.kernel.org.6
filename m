Return-Path: <linux-kernel+bounces-558864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE45A5EC51
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F42A189E107
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BD8201013;
	Thu, 13 Mar 2025 07:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="ECdzwPAG"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B251FCFE7
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 07:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741849305; cv=none; b=mHFL+Awp8/WHcsGxTtfVnE/g12q8HkLF5UsgbugQlaeVwEDUFfSLgOUA5cv7fuvKR0MHWu0FdSZcFDVC09W4V4GA6WySc4GjBbFyePT//2uMqJErNJa1Fsih4YKDsbV+DveNMhntMw3bkiribBjPjc+CxOJ3lwyHPs8/w8JHH+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741849305; c=relaxed/simple;
	bh=uj6BiB0IqVm8+xs3f9Zn6aCjK6f7zlPp0hv2djTMvTQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=OqdR1mbMFJ6D6C6F/A0LRUZ2AZ8ABhzPWubNkyJcE83liqOf1chAB9nD27Nm+mHIF3qwqQ0DzPeOrdnRVbLG4s0b1qcXY3H8AjEolV+8I7HqVG3J0lMcH8haZeHKPWJYi1R7OkTkd30PWz33KXNhb0Rfkqddu/1UxjMIGHtNLRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=ECdzwPAG; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-223f4c06e9fso11050135ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 00:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741849303; x=1742454103; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CFouu/EN4lEKQm+2Nyv7q163Sd7hDT7Qc+wcMAoVrxU=;
        b=ECdzwPAGAoCSWTXNIPQAxfcp5P5SO/fvBwY8wBAZUecHrDq/oB25D5UMWszSldfTLP
         p5QDz7GxzNr20zvrqcBBLrPOhOkButkAn7HNPGKGn72o66/xWBn69cIc8OwYKzii2YHF
         UTHRdX1A7gEmF0OytmdVJrL9JF5JwU9BzZgP2kXboWM7r1e4HjB68MGU41+fgxzmdpBd
         qSs08DI12hK+QOphesK44Ut/fK55/lQt0/u3Lyr2X3iiy60Wb7Oh5Qehrr+3n0mE/EtG
         +zdg17kGP3uJaj9moQmRyyLwDMfU7aniXslS0xnqhH4oLBRi7FOKo4xuA1+QLLWqO7uf
         X1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741849303; x=1742454103;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CFouu/EN4lEKQm+2Nyv7q163Sd7hDT7Qc+wcMAoVrxU=;
        b=kEuYUqOx/MkTm+Vgd/lI4EXMc432hrql5XG3yAyZJd1mG4TaIOnOsJ5anGSoJwtgnX
         9HsCivHpU5ytX5e5OpPg2vAip/hxCIs8c+/F+8Zk0N23xUbO1Eu3wO3nz7LqSpouv5T/
         5czm0XOdkHdTMc22W9+8W8zXcfj+a3qN0zY8IdUvd5yMJV+xRCwLiF11hoeKhrpjwPaz
         0dakxk7mFpfYYo1rzobGwqbWlwQTPOYMjzKXB51WrKNzeuywtNduXmXjlz3N6L0zt2hS
         9yg3jAc4DJditPTU/ZAus9alu2o5aO+zmIJ4EjJPXzTpRXhesSPHdHY38uKahc4ptqHV
         GgdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuySfii/pjoPGc4QRS4gB/qUUcbfXOwQ7oTrxdGV5hOZEsy3v/tuB6S9ZR6w4G0esHKDDgJKTqMMdn6OA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqBgYl7WA3m7rgyqiLV4hNRSIt1qQE6BWPBPHRSGTxMjRUPcbq
	pvEp1mJq3jUW8HLn9fLWD87u+h/j0KsvI1PWuaEONJMw1aQWLIiZN9jrRcrOnyA=
X-Gm-Gg: ASbGncsf2oTNQdyMe7aIyH2dmwGtL6x4P1UVeHcg6qbyGkFH8Vy1bPA72mmPt7u3l/W
	aUW/QGE/HofKwTt8XBO69tedDpKiwXnIllj4GSIQb33PiRoQJv7+86G5hOprThQYQRAYFXgusUW
	JmM2WGgpwu/CWvr3vvLSmDJgCCIT4LZ7WSjSl1nGelVHLBroNtObzHVKY/09lEvpi1OH3u+CytM
	T9sZIMu4oalC13cM5PsYLTVc02bYFUSp3iAjMNuzX6Ae5aaBX+WZaYV9KnIOksAp/cAbwtHRHG3
	aon3NXMUVhQKLrp/mN9G/2o3O+AJDIggaeaglc7pLQXK1NBd
X-Google-Smtp-Source: AGHT+IF41bM6O52nxyqfLS5xcbnmD0BRXYmKkq1aTZiZh+PP5DLgrJ3Gf/DAzNS+0zNbGzXZ+/OHfQ==
X-Received: by 2002:a17:903:189:b0:221:8568:c00f with SMTP id d9443c01a7336-225c64097abmr19829395ad.0.1741849302826;
        Thu, 13 Mar 2025 00:01:42 -0700 (PDT)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c6bbe84esm6495685ad.176.2025.03.13.00.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 00:01:42 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 13 Mar 2025 16:01:06 +0900
Subject: [PATCH net-next v10 03/10] tun: Allow steering eBPF program to
 fall back
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-rss-v10-3-3185d73a9af0@daynix.com>
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

This clarifies a steering eBPF program takes precedence over the other
steering algorithms.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 Documentation/networking/tuntap.rst |  7 +++++++
 drivers/net/tun.c                   | 28 +++++++++++++++++-----------
 include/uapi/linux/if_tun.h         |  9 +++++++++
 3 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/Documentation/networking/tuntap.rst b/Documentation/networking/tuntap.rst
index 4d7087f727be..86b4ae8caa8a 100644
--- a/Documentation/networking/tuntap.rst
+++ b/Documentation/networking/tuntap.rst
@@ -206,6 +206,13 @@ enable is true we enable it, otherwise we disable it::
       return ioctl(fd, TUNSETQUEUE, (void *)&ifr);
   }
 
+3.4 Reference
+-------------
+
+``linux/if_tun.h`` defines the interface described below:
+
+.. kernel-doc:: include/uapi/linux/if_tun.h
+
 Universal TUN/TAP device driver Frequently Asked Question
 =========================================================
 
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index d8f4d3e996a7..9133ab9ed3f5 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -476,21 +476,29 @@ static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
 	return txq;
 }
 
-static u16 tun_ebpf_select_queue(struct tun_struct *tun, struct sk_buff *skb)
+static bool tun_ebpf_select_queue(struct tun_struct *tun, struct sk_buff *skb,
+				  u16 *ret)
 {
 	struct tun_prog *prog;
 	u32 numqueues;
-	u16 ret = 0;
+	u32 prog_ret;
+
+	prog = rcu_dereference(tun->steering_prog);
+	if (!prog)
+		return false;
 
 	numqueues = READ_ONCE(tun->numqueues);
-	if (!numqueues)
-		return 0;
+	if (!numqueues) {
+		*ret = 0;
+		return true;
+	}
 
-	prog = rcu_dereference(tun->steering_prog);
-	if (prog)
-		ret = bpf_prog_run_clear_cb(prog->prog, skb);
+	prog_ret = bpf_prog_run_clear_cb(prog->prog, skb);
+	if (prog_ret == TUN_STEERINGEBPF_FALLBACK)
+		return false;
 
-	return ret % numqueues;
+	*ret = (u16)prog_ret % numqueues;
+	return true;
 }
 
 static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
@@ -500,9 +508,7 @@ static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
 	u16 ret;
 
 	rcu_read_lock();
-	if (rcu_dereference(tun->steering_prog))
-		ret = tun_ebpf_select_queue(tun, skb);
-	else
+	if (!tun_ebpf_select_queue(tun, skb, &ret))
 		ret = tun_automq_select_queue(tun, skb);
 	rcu_read_unlock();
 
diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
index 287cdc81c939..980de74724fc 100644
--- a/include/uapi/linux/if_tun.h
+++ b/include/uapi/linux/if_tun.h
@@ -115,4 +115,13 @@ struct tun_filter {
 	__u8   addr[][ETH_ALEN];
 };
 
+/**
+ * define TUN_STEERINGEBPF_FALLBACK - A steering eBPF return value to fall back
+ *
+ * A steering eBPF program may return this value to fall back to the steering
+ * algorithm that should have been used if the program was not set. This allows
+ * selectively overriding the steering decision.
+ */
+#define TUN_STEERINGEBPF_FALLBACK -1
+
 #endif /* _UAPI__IF_TUN_H */

-- 
2.48.1


