Return-Path: <linux-kernel+bounces-356108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9D4995C89
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 02:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7678C283180
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 00:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9B318EAD;
	Wed,  9 Oct 2024 00:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="UK5ZlGjo"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E55643AD2
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 00:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728435361; cv=none; b=D8yYRhQVdaP2Cbxqa0CFZDmzR8u/rwsR1l6oEeMdVendUEi1w0CrBkDeg3u2FBpwaEshGeNJ1LmjSia7mPPs/OL1G+1KqELWCPCVLbca/hWP+Q7frTGicwj/QQFOxkFMOZkCBI8Q8l+0K9AAdZ8QBE1AtIWuPX337FK1ztomG/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728435361; c=relaxed/simple;
	bh=fmuhBTf3bfBIF3wPJkt513NrrZF6VgNGcvDr2NU+JRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AQ8zHR6b61Ec03vVVhWHi2/HPjBAAniek8D/nKoGmqZHF2XbBLwTrBsU12/EII1RzCoCHcxxSCqeXJjW6BP+3ZcU9p+iCaOXGkcoS+1uin7mP2/CU4dMTKf7Qr9reSJjMvf4PNNeINuHc8Z+KoAo6XpIbpUWpq8vsaqkDO8QPUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=UK5ZlGjo; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20b5affde14so45486885ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 17:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728435359; x=1729040159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wozl6FR6jO7LtfNZu3T9/AIWhCZAnrXDluBkWDgGbTE=;
        b=UK5ZlGjok2PnRZ5DCGgpaad4wjQMwclmXoxPRRCbvCUFDrZpCzLYAywVBO7XGGI8cS
         JfWPyzubJ4MgIlQQQ9jr5WT+oS2i4EZCxjggLAFBNqQgkCzl5lT2hh9JrL+xK5Y/TAjZ
         qKgPOV34tKbLsxLO+hE/kmyaH1um2JeB50xGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728435359; x=1729040159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wozl6FR6jO7LtfNZu3T9/AIWhCZAnrXDluBkWDgGbTE=;
        b=CMbv3QSVC3dw1LaZjP0C5R9KRAtKeqzw5bAnGK/8CYd2YzwBWdlz2gnbAnVNCSt0zi
         YxEl4HaB8/GHhymQ0DIwFEhv3GERMogUX2jL0T9P3bOzDZGwoxo6r8oRPpPRf6lxXyR1
         ywTwYhKjK8P09SyrBbj2fIM9M/17Fla4nV0gjhzHe2bT0kXW5qQSxvvelx5NiodJv7Jc
         LF+DSSS+2peU9c8WO9i+Z1Uf5MVCDwcaBK0bj34oV2OfCZP5ZHpV3OUx2pMlLaHTQOOE
         tCWEOD38bKOZVRD1ALVf7fqI7zskijxcLNhv17V/Rx4WtJnHERWF0vqkEtaxTXkcRdIz
         swfg==
X-Forwarded-Encrypted: i=1; AJvYcCUuMFSnQf9zU8AXwouhZR6XJY+KiVm9vfnY73Ug6UfK2G3K20IZfp/thPby6sHHWBTumUYRxq32odUtgGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2w4UKSiW/ug59w3BVxwWEmtaBzian9etj5lmPzw5oTy5sRW9e
	OpH3D3T0A7mSNUwepUHD6b4ISAfjtHQ9kUgJHejyXMYq2yvrDC9+GXk+444gyM8=
X-Google-Smtp-Source: AGHT+IEqXufwgSngAKNnN6AE5Vf68UGEK4jh8JF0urWXXFYD7O9enYEJi71s3fUkRUjlzqvzi1A9yA==
X-Received: by 2002:a17:903:22cb:b0:20b:6458:ec6b with SMTP id d9443c01a7336-20c63738e4cmr14191925ad.25.1728435359509;
        Tue, 08 Oct 2024 17:55:59 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138cec92sm60996045ad.101.2024.10.08.17.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 17:55:58 -0700 (PDT)
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
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next v5 4/9] netdev-genl: Dump gro_flush_timeout
Date: Wed,  9 Oct 2024 00:54:58 +0000
Message-Id: <20241009005525.13651-5-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241009005525.13651-1-jdamato@fastly.com>
References: <20241009005525.13651-1-jdamato@fastly.com>
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
2.34.1


