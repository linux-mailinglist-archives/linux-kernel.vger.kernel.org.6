Return-Path: <linux-kernel+bounces-346848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B94EB98C9A7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 01:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 481421F21FB9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 23:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333881E1327;
	Tue,  1 Oct 2024 23:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="t+8yrxtO"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077D61E00A2
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 23:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727826833; cv=none; b=fJSXwlIH/xyd/XHjy5W4/hnZZggflsk2RuNT3llaUmxxkSHH+Q+5Bk0vf6YzwsiOfQLa1sItNkZrwLpHWqtCjDRfdlsMhl7zKxEANZu8cZt8qCen2wbOIsb4yGbITisC7lbvkPSHmGpYxoA0zxjvhS2v25LXhxP5nxj4HoOvOIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727826833; c=relaxed/simple;
	bh=A4ctw+2b8yq0sCbFcjdY3SVzbWEsxT2TUGSyUg6wK0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RNEy+WG6VM9i1wb8YihS8jbLZgkIQTpLx8GqMzJsf6n8846ROb48an8IchxoFQsY6gHcGuegKgjP8BR8xDharCERze5zGBEiIFgldvpDWuEQVmcov5VTL4YmdBmS0aYI6EMt0bGLGd53J3CCTM1e9KnNE6xVXpQOIhhtObRQyl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=t+8yrxtO; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso4607265a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 16:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727826830; x=1728431630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQII9ub/bVtxy0ntEn1HGx1uSFXeUqoutb/T7bvVeMk=;
        b=t+8yrxtO5Y8sW0RctPlO9mtJZCzMt8sLCn93CwLonDirnK/LcLh0yewHcD32G4/20s
         UHIc1iOguDL8aU7jso/NpAc7q7JRoF5gySmeAX+zZrICQA03tySjU4xNWdTZuevRceF3
         VVFrLuP7rexiDWxJFJyFFPI6ybijM2u/uWxiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727826830; x=1728431630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQII9ub/bVtxy0ntEn1HGx1uSFXeUqoutb/T7bvVeMk=;
        b=RGJ+si9xdLOpHVfUqAUq4SUEFZVt1ifXZVCKuju+H+cdOA2j9PAicG3VUHvj3bVqpL
         /8i1qPHS+jnbBUPFphaIu2i19Ak1CE24sVuJLn6FT5tDU6qQJwUCiy7zka+zYNbVx5KY
         nRQyz85kKfNaRGnun18gDRbWSjLnWHNYwIwbrv/GR9EwOWEAiLEeeMO69XXfNpxOkHhh
         xGP6QOdu1+bu1Koz9lXcbY0oaCmqJJ4nzF6QbvIeA52FsP/4zTc2idltjTXJAKNE/Jj/
         TnoumgTBZ2ya89a3iey0kQh4BVy3PMQvU3moOzk4hsd+LSwEP/raLo+XtUoMMGbAXviZ
         YBqg==
X-Forwarded-Encrypted: i=1; AJvYcCUALbIrVCotx/N8Uv2A3b1xu5+/9u6fGrdLLCIZOwxvctW1VrVVSg9P0v2fDzVf31K9STVoW1W6eXQGoSI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6o+K0UFMywQuJEdCJF6IXyFm2Gm8P/0FmmF+tZvMXgRXo1BjW
	O3K4BQRGsfbon4UFKVKsMoMYANZZ3aLeWtnJrcfXHBMzDi3SHNgZy3dBrgNdsDI=
X-Google-Smtp-Source: AGHT+IH6y8TLEoNcS3CIY1eRqDcl6J9ZIkBmPCtlp4ki4860wF8VxL5+YVU+aQ3guijKYC2ciYrGKQ==
X-Received: by 2002:a17:90a:f192:b0:2e0:59af:b998 with SMTP id 98e67ed59e1d1-2e184943fdfmr1601328a91.39.1727826830385;
        Tue, 01 Oct 2024 16:53:50 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f89e973sm213130a91.29.2024.10.01.16.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 16:53:50 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	willemdebruijn.kernel@gmail.com,
	Joe Damato <jdamato@fastly.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next v4 4/9] netdev-genl: Dump gro_flush_timeout
Date: Tue,  1 Oct 2024 23:52:35 +0000
Message-Id: <20241001235302.57609-5-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241001235302.57609-1-jdamato@fastly.com>
References: <20241001235302.57609-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support dumping gro_flush_timeout for a NAPI ID.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 Documentation/netlink/specs/netdev.yaml | 6 ++++++
 include/uapi/linux/netdev.h             | 1 +
 net/core/netdev-genl.c                  | 6 ++++++
 tools/include/uapi/linux/netdev.h       | 1 +
 4 files changed, 14 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 585e87ec3c16..bf13613eaa0d 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -255,6 +255,11 @@ attribute-sets:
         type: u32
         checks:
           max: s32-max
+      -
+        name: gro-flush-timeout
+        doc: The timeout, in nanoseconds, of when to trigger the NAPI
+             watchdog timer and schedule NAPI processing.
+        type: uint
   -
     name: queue
     attributes:
@@ -644,6 +649,7 @@ operations:
             - irq
             - pid
             - defer-hard-irqs
+            - gro-flush-timeout
       dump:
         request:
           attributes:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 13dc0b027e86..cacd33359c76 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -123,6 +123,7 @@ enum {
 	NETDEV_A_NAPI_IRQ,
 	NETDEV_A_NAPI_PID,
 	NETDEV_A_NAPI_DEFER_HARD_IRQS,
+	NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index de9bd76f43f8..64e5e4cee60d 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -161,6 +161,7 @@ static int
 netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 			const struct genl_info *info)
 {
+	unsigned long gro_flush_timeout;
 	u32 napi_defer_hard_irqs;
 	void *hdr;
 	pid_t pid;
@@ -195,6 +196,11 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 			napi_defer_hard_irqs))
 		goto nla_put_failure;
 
+	gro_flush_timeout = napi_get_gro_flush_timeout(napi);
+	if (nla_put_uint(rsp, NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT,
+			 gro_flush_timeout))
+		goto nla_put_failure;
+
 	genlmsg_end(rsp, hdr);
 
 	return 0;
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 13dc0b027e86..cacd33359c76 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -123,6 +123,7 @@ enum {
 	NETDEV_A_NAPI_IRQ,
 	NETDEV_A_NAPI_PID,
 	NETDEV_A_NAPI_DEFER_HARD_IRQS,
+	NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
-- 
2.25.1


