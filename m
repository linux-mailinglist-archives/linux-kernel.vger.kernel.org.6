Return-Path: <linux-kernel+bounces-346846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6404698C9A1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 01:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E15381F24750
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 23:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CD81E0B7C;
	Tue,  1 Oct 2024 23:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="r3rpdxy5"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D911E0B71
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 23:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727826821; cv=none; b=nQgT1JP1ItTJ+W3vMUf6raWR2SP9XbxnspyoS5IQDLBHX7FOhBCaUj8twb8mnvj9ZsdTA/YKIXpYr0kqNVls6CXaV8wSHqzH/u+BFuriTmyZv+07WAATbhRbZroE0wrQlGNrWqAHukv0QE01Jr/aqnSWPYSD/k3pcM0qqXcK34k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727826821; c=relaxed/simple;
	bh=kAEG1Am3qGuk35HDrwWkcGYK2JXUX2VXmCklQAjtsYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rFnfQQTy5TFN1+wSoErRYOD1AujwDhM/gBP/ENVoQ7u9dlcsReP6ke7T8FOTuQJBmqsC+fU81hd9s3ifax7KnEJ+UCk+pfabrGouI40AaREddUwAfXirxUbXdF67BClxW19IEP6e7K+/oaTM4Y2Y/1P4GguEjG5/KwUycyhNdS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=r3rpdxy5; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e109539aedso2675646a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 16:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727826820; x=1728431620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrVj7Azlfps/B75TfmvK6tL6oA2kiOEMADlEWkkR0JI=;
        b=r3rpdxy5WzAxFcJJNI43O4TieaDRF5ppGwabok26WN7D165h0VUvprqM1u/+kzxc/V
         PrHwNvIoP5AYQxvoZy3DxIhzJ+6d8E2tYO2OJXjrJIRcOEpd+/21vFp6XOcokj4DDW5Q
         Q/Smmc6mp97ZI4r1MMKK3VQNOHIlsyNBPJkCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727826820; x=1728431620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lrVj7Azlfps/B75TfmvK6tL6oA2kiOEMADlEWkkR0JI=;
        b=QsyH6y+SxV9ZXOfgtjdQgWhTrP0E+sfZpAoNGhKgr8unRvTjYfxVwbLQ4txGZQcrkB
         do6cv7rgjPONYyf1tXnf1lppv9Djz4O4Jz7JpFZg3N5nO+0LtUvoU4ISHT1HXOqviZx+
         0oopk9wACMpNp27yX676B8Nn8OZPzt9SmDibhkgrcdgtgPUU/MNew1ag5to4sOcCRjll
         rcYZHxyXmvTJNRkusufVHgZ18FtVNS27sTEf9JCda0W3WpKLAt69H8wxoVQjY776xlBQ
         CKZKtpAcUH7ekjRT4qdcKMap+WLdck1mftvi2YRcx4c5VeMD7dgNe+rik945WkIztd8F
         nM3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVP9COIJBpPfLXCN3fU39iiMMr6R9N1+9y51v2WszXVgbVOYSjCPdRylLJe0pvWSMU7w4XXrTJ7Jq24qBc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5OVeYZAU3R20XTx2OZpsVXf1m+VLuciKw/zAIcTgB0eyIVsAK
	mdx6P9WwPTKLF2ZvYsMeiIBMnAJzJmQZPRisX7rbtTO7JOaVRxIQ62ZOFalMFng=
X-Google-Smtp-Source: AGHT+IGpgJ1rgzHrxwtT40rOkt57kYCh2EC90ybm6qKtAfpKHRyK6AeHjlpVi+lwyDuEEFYJtQbb5w==
X-Received: by 2002:a17:90a:8c18:b0:2d3:cd27:c480 with SMTP id 98e67ed59e1d1-2e1849e437bmr1829345a91.33.1727826819796;
        Tue, 01 Oct 2024 16:53:39 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f89e973sm213130a91.29.2024.10.01.16.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 16:53:39 -0700 (PDT)
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
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next v4 2/9] netdev-genl: Dump napi_defer_hard_irqs
Date: Tue,  1 Oct 2024 23:52:33 +0000
Message-Id: <20241001235302.57609-3-jdamato@fastly.com>
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

Support dumping defer_hard_irqs for a NAPI ID.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 Documentation/netlink/specs/netdev.yaml | 8 ++++++++
 include/uapi/linux/netdev.h             | 1 +
 net/core/netdev-genl.c                  | 6 ++++++
 tools/include/uapi/linux/netdev.h       | 1 +
 4 files changed, 16 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 08412c279297..585e87ec3c16 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -248,6 +248,13 @@ attribute-sets:
              threaded mode. If NAPI is not in threaded mode (i.e. uses normal
              softirq context), the attribute will be absent.
         type: u32
+      -
+        name: defer-hard-irqs
+        doc: The number of consecutive empty polls before IRQ deferral ends
+             and hardware IRQs are re-enabled.
+        type: u32
+        checks:
+          max: s32-max
   -
     name: queue
     attributes:
@@ -636,6 +643,7 @@ operations:
             - ifindex
             - irq
             - pid
+            - defer-hard-irqs
       dump:
         request:
           attributes:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 7c308f04e7a0..13dc0b027e86 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -122,6 +122,7 @@ enum {
 	NETDEV_A_NAPI_ID,
 	NETDEV_A_NAPI_IRQ,
 	NETDEV_A_NAPI_PID,
+	NETDEV_A_NAPI_DEFER_HARD_IRQS,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 1cb954f2d39e..de9bd76f43f8 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -161,6 +161,7 @@ static int
 netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 			const struct genl_info *info)
 {
+	u32 napi_defer_hard_irqs;
 	void *hdr;
 	pid_t pid;
 
@@ -189,6 +190,11 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 			goto nla_put_failure;
 	}
 
+	napi_defer_hard_irqs = napi_get_defer_hard_irqs(napi);
+	if (nla_put_s32(rsp, NETDEV_A_NAPI_DEFER_HARD_IRQS,
+			napi_defer_hard_irqs))
+		goto nla_put_failure;
+
 	genlmsg_end(rsp, hdr);
 
 	return 0;
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 7c308f04e7a0..13dc0b027e86 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -122,6 +122,7 @@ enum {
 	NETDEV_A_NAPI_ID,
 	NETDEV_A_NAPI_IRQ,
 	NETDEV_A_NAPI_PID,
+	NETDEV_A_NAPI_DEFER_HARD_IRQS,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
-- 
2.25.1


