Return-Path: <linux-kernel+bounces-306958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D7A964603
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BA8D284A55
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946BC196C6C;
	Thu, 29 Aug 2024 13:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="aFO1iV4r"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F4915E5C0
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 13:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724937187; cv=none; b=TEDUcdjeBZoL0U5nkQvezm3bOfro1TfB+pC/Gyg/8w5cH5NVpI96H6ceYuiEvnT203wNeGMhl7BjrPz9EKFdCwqPt7sJbOzMtXIPXe8WXj7jGhQVhc82Y9mFR5ZvPypQc6q15Y3xHhgdjRoVcYthE/1wyAMAq4nkaZe6f8d+9Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724937187; c=relaxed/simple;
	bh=hI4+39auvENKp36mFZMcEI8Wdw4l29SOp94j/CNObFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OCopo1B0mZm0B8YZW7yj5vrtXfHST3Oy7Rp0SRp7KSZWVDAXlvrg9f+mS3Xk0cd8ORTijlP7ki5KRy93BA7+gYlkX3ge9V4Q+OSw3EXbjfrduoiqjjtLSZnPYepspCo31WIRGS4X8GB9UNDFRAZgudrUsYaZCuY7osP93n4jkeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=aFO1iV4r; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2020ac89cabso6410445ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 06:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1724937186; x=1725541986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwTZLEJ2ZNvenqmXoy3WWd4FEjeXbWDB+TnZ5AXOvhg=;
        b=aFO1iV4rweXgViHmecblQiVE/N7wC6Gt8Suo+QyIXbeUuL0Zd6DNz1E2+eQkW5lIIm
         UX498E/QnOwlewLP2uwbWufdfVIm3t++q1i/SXbwqUXcXx40sY6thcfQhWrCPIby5QDL
         NyfpqU7YpU0JtnMdgD4zCzXgSYVDI5kBhlG0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724937186; x=1725541986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QwTZLEJ2ZNvenqmXoy3WWd4FEjeXbWDB+TnZ5AXOvhg=;
        b=sQ0xHfY1O09syIkmIamTRSmfj7R9EWlLCp3li2/W3/rfhyzUKdNifvAX3YwHu0I5ti
         Ahmtck4lw/TXiseZltGAauY1rsP2Ut3NtZK5aWvDNbzMKR/Yx3IQMIrwIlH++TQOAMwq
         +lSiWotsP+2k8brD1HO1WU6K13HbJRa4GcDR38maA49qS7y/kGUSUmUkUAq35OkstnEm
         6+Tqx6uF1aIAsP4dlkEbZhwQpamUSUVVatnglxBsLzxY6Dw5AkLqj42OZ4o9NA5HcDNY
         EdUYjREb8iXoLe2WvPxxSQxH0PG+T2IQ6WSgc8L0ZhD6uMgEX8UHCTkedqPwcXj7+max
         E4Zg==
X-Forwarded-Encrypted: i=1; AJvYcCWKttulYOVn+M6YzRNjtPBL3hTrYMkAZuEKgNWTu4bcKIFxaZzk8U7JX64mj1siDSFzJ+2fI9A7E785Mcc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu+wnGJMyt9Xw6Xymm3+tliDjDmC9BB4o3ex6N0eSyPUvzCpss
	LXhgNDFWj4Jd+MeHbXwAUinyVur+WMGC2MHXzQOYZlmZKQly4DvELeB9/Ym44GE=
X-Google-Smtp-Source: AGHT+IHEgtDmE2CuvduFpYds2GdlAP6Z4Pt5/esDzsjD/wrNuL1lTsangnC1P7Fn1KVRiDEbmgMxJA==
X-Received: by 2002:a05:6a20:c886:b0:1ca:ccd0:582b with SMTP id adf61e73a8af0-1cce0fea613mr2633025637.10.1724937185537;
        Thu, 29 Aug 2024 06:13:05 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152b13c9sm10991065ad.62.2024.08.29.06.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 06:13:05 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	hch@infradead.org,
	willy@infradead.org,
	willemdebruijn.kernel@gmail.com,
	skhawaja@google.com,
	kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 2/5] netdev-genl: Dump napi_defer_hard_irqs
Date: Thu, 29 Aug 2024 13:11:58 +0000
Message-Id: <20240829131214.169977-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240829131214.169977-1-jdamato@fastly.com>
References: <20240829131214.169977-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support dumping defer_hard_irqs for a NAPI ID.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Reviewed-by: Martin Karsten <mkarsten@uwaterloo.ca>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
---
 Documentation/netlink/specs/netdev.yaml | 6 ++++++
 include/uapi/linux/netdev.h             | 1 +
 net/core/netdev-genl.c                  | 5 +++++
 tools/include/uapi/linux/netdev.h       | 1 +
 4 files changed, 13 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 959755be4d7f..ee4f99fd4574 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -244,6 +244,11 @@ attribute-sets:
              threaded mode. If NAPI is not in threaded mode (i.e. uses normal
              softirq context), the attribute will be absent.
         type: u32
+      -
+        name: defer-hard-irqs
+        doc: The number of consecutive empty polls before IRQ deferral ends
+             and hardware IRQs are re-enabled.
+        type: s32
   -
     name: queue
     attributes:
@@ -593,6 +598,7 @@ operations:
             - ifindex
             - irq
             - pid
+            - defer-hard-irqs
       dump:
         request:
           attributes:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 43742ac5b00d..43bb1aad9611 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -121,6 +121,7 @@ enum {
 	NETDEV_A_NAPI_ID,
 	NETDEV_A_NAPI_IRQ,
 	NETDEV_A_NAPI_PID,
+	NETDEV_A_NAPI_DEFER_HARD_IRQS,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 05f9515d2c05..79b14ad6f4bb 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -160,6 +160,7 @@ static int
 netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 			const struct genl_info *info)
 {
+	int napi_defer_hard_irqs;
 	void *hdr;
 	pid_t pid;
 
@@ -188,6 +189,10 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 			goto nla_put_failure;
 	}
 
+	napi_defer_hard_irqs = napi_get_defer_hard_irqs(napi);
+	if (nla_put_s32(rsp, NETDEV_A_NAPI_DEFER_HARD_IRQS, napi_defer_hard_irqs))
+		goto nla_put_failure;
+
 	genlmsg_end(rsp, hdr);
 
 	return 0;
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 43742ac5b00d..43bb1aad9611 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -121,6 +121,7 @@ enum {
 	NETDEV_A_NAPI_ID,
 	NETDEV_A_NAPI_IRQ,
 	NETDEV_A_NAPI_PID,
+	NETDEV_A_NAPI_DEFER_HARD_IRQS,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
-- 
2.25.1


