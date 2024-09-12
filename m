Return-Path: <linux-kernel+bounces-326316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2208E976675
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 12:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59399B212CD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 10:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715871A2647;
	Thu, 12 Sep 2024 10:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="L2JOs6KX"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712401A2638
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 10:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726135705; cv=none; b=d7W0RLdt1eYkoxv/fiC+DWC34hqhE+Gqhop0d1G5/37T8IDQlo6/1uomYxHCxrqh3roGhpuVKn2ZnRfA4+Dq+ehDLnFZmiheVkC7K7WV5/itzwLWAL4TBpJ251o8X+hRpmQUT60jhACqWKREEV0CYCXQItMP+5iiQCII11X/57I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726135705; c=relaxed/simple;
	bh=7X1uADLZjCrWywAb/T3yUw6fZRd1yFFwvpgWf8s8fGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pws9gw4AdVO6hFBHUB191cbzvIwGgiv9XaUuHWWkecKLEXkP0SLMr4YzyN37snowsarJjfmjfhOYT+fO3DBKs5+5Gzp4wjQ6GO0hbI9t9LdLhXmhvg/4+KN/Nm2oKBpexODzeiKkrdfPanGrc8fYRhJLq+OETF3JvoRm22IbXAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=L2JOs6KX; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-206f9b872b2so8435685ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 03:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1726135704; x=1726740504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVBE7Pm7Q5s8a6rlCB82bDuJ6/NcBLKBqVzG1T0Sd1Q=;
        b=L2JOs6KXQbMcwd+3KU8DSQ8IXiDnR+rAznRALbxZLFOXTM9DJoFj0/5wyYf2Yio0uQ
         5NUyO4HoBHiau8g84seNfzTVQi7kXno6HcJX2hooNi4Sr8ztKpZDYvRSRqk3GmSwR5oY
         uUBCebYUw0J8gKqh8lwpj2zvVo+EAAP96E4P0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726135704; x=1726740504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVBE7Pm7Q5s8a6rlCB82bDuJ6/NcBLKBqVzG1T0Sd1Q=;
        b=MwZuDudYjT28qre5Qpsqu8zJXPqCL5OeAgK52bKpa3SPVRjQ3SHBbRM9I7NPdf+5yz
         WnlSXC99Qxe00fhZPxmrtz2ZUV0fNvKnsugUHNaor9VPTMd9GltwM167Yf3H8/b34OQN
         NZC3ttP2rxWnDnJBjL5zoQEeXHAMlEX5yBPgdgw4G0CHiMmm2SccbuC9riUPNao4XSmb
         YC3lHYOGeO0Ok1x1Z0tjNIyJdgxyJNagGbxWBelodOlnWLOn6cRVNh5VteiucEbSpmKF
         zNRedH4uiXbIow+sCnvuBo+6F68CZdZrRe66fVX+VU51E+4RLw5ZGiXKmVrMfMzIeLug
         aj8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBn7It0DBv2QU6umQizNeSEfpbD0h14eoVpqf+ARtQFXKKQP1hydMFd/E0nE2bcaKHdePe79n9NwM8FDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBOXyMepXSWfY4HP2WHbE/hM8MAZqyfnyIMBUhKcH5TDVdajo9
	WPuxGzHRRrK9MpskisyjsxzrTd1FS1GGd1d3EYJpdImnof7zk1Nj9BWlN1mddBQ=
X-Google-Smtp-Source: AGHT+IEVKBtDLy6qE1gRasnURzcTt8OTaL/9OrC0QY5wEcDhluu8jE5lROOeLxmdOJQ4ZTZ/UCI/vw==
X-Received: by 2002:a17:902:e94e:b0:1fd:aac9:a72e with SMTP id d9443c01a7336-2076e461637mr31643635ad.43.1726135703805;
        Thu, 12 Sep 2024 03:08:23 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076afe9da3sm11583795ad.239.2024.09.12.03.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 03:08:22 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	kuba@kernel.org,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next v3 4/9] netdev-genl: Dump gro_flush_timeout
Date: Thu, 12 Sep 2024 10:07:12 +0000
Message-Id: <20240912100738.16567-5-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240912100738.16567-1-jdamato@fastly.com>
References: <20240912100738.16567-1-jdamato@fastly.com>
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
 net/core/netdev-genl.c                  | 5 +++++
 tools/include/uapi/linux/netdev.h       | 1 +
 4 files changed, 13 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 351d93994a66..906091c3059a 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -251,6 +251,11 @@ attribute-sets:
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
@@ -601,6 +606,7 @@ operations:
             - irq
             - pid
             - defer-hard-irqs
+            - gro-flush-timeout
       dump:
         request:
           attributes:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 43bb1aad9611..b088a34e9254 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -122,6 +122,7 @@ enum {
 	NETDEV_A_NAPI_IRQ,
 	NETDEV_A_NAPI_PID,
 	NETDEV_A_NAPI_DEFER_HARD_IRQS,
+	NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index e67918dd97be..4698034b5a49 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -160,6 +160,7 @@ static int
 netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 			const struct genl_info *info)
 {
+	unsigned long gro_flush_timeout;
 	u32 napi_defer_hard_irqs;
 	void *hdr;
 	pid_t pid;
@@ -193,6 +194,10 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 	if (nla_put_s32(rsp, NETDEV_A_NAPI_DEFER_HARD_IRQS, napi_defer_hard_irqs))
 		goto nla_put_failure;
 
+	gro_flush_timeout = napi_get_gro_flush_timeout(napi);
+	if (nla_put_uint(rsp, NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT, gro_flush_timeout))
+		goto nla_put_failure;
+
 	genlmsg_end(rsp, hdr);
 
 	return 0;
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 43bb1aad9611..b088a34e9254 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -122,6 +122,7 @@ enum {
 	NETDEV_A_NAPI_IRQ,
 	NETDEV_A_NAPI_PID,
 	NETDEV_A_NAPI_DEFER_HARD_IRQS,
+	NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
-- 
2.25.1


