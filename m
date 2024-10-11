Return-Path: <linux-kernel+bounces-361680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA02499AB61
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 20:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6904C1F23465
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 18:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE341D0E31;
	Fri, 11 Oct 2024 18:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ZgSUi6K+"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC7A1D0E0F
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 18:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672348; cv=none; b=eT1CIwNXJ3pOluS05ssK+BeRlR/7Fb1uc4r3LUICFekjBOzWm+ZN3m4GH1iEPzx2DRdxMoTTRqReJEe5I6D0ca5vM6Xa4dv1GAEzr0HuUop2YFV70lxc8FTdsk0QGT+QsU9cMpZqmoKtsHxjqLzmupKFXgSlU/rmuM0ScyejiMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672348; c=relaxed/simple;
	bh=q+b9jZGAidjuh8GtSlIIKJ1LqbGOzaugQLHfnQm1lqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AG0bMzRHxUh76jXXjFym1C9NpyR0+gnHMe83EQ6wR8ilCMEG2q1uuZLVS/NUwpc9bjo/Qr7Nw78ANWcJ0jHc9gwxAaNzcl3TDV1M9OBFYzyINnRICVRH6/IJMWRxMqGBP2cLu4F514QlxyOwYOa9+hL/N9G+FXYWFipY/c+YhIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ZgSUi6K+; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e28b75dbd6so1791145a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 11:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728672346; x=1729277146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXIej0C4eoHUHQ4nEdeNbNdLeJSUvgnrgxPSPMx1EiE=;
        b=ZgSUi6K+fg/sFQvrgP4gqFZWja7bxeRtBjGIIsSYjz8p0bbbRpKi4XeAUlLVNNjkzR
         9ha4BKc8FTRCLUGKEUoXjOM+FuuS0GZ466Jo6Q0LlOEYtfKaFnrgaCIFbtsSs9HrUQmJ
         FELVyiIjfwI/LwPBoQJBMFCDN0dSs/dOM15tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672346; x=1729277146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXIej0C4eoHUHQ4nEdeNbNdLeJSUvgnrgxPSPMx1EiE=;
        b=I23UpZhvt8aB2ZvBpCAIplvRlrhrUM0BhUJZvXH9MnIobpX8eeZQHRq5asJT9PU8rW
         6Pw+7g9V2LjAneX9/LJzBMA1fG4omlOAW815ciKgPqK3eLmgh023r/9dxHn6YJe3nKp+
         Up6dstcH3GQe47nflOiqZsH+B5ikgpXVmQ7o/HH5si4IwXWDpZZQCLdFG+CFRPAQSshq
         w7x7Ah6pBz2L1X3R2fagmnwf0u1EC9fl0hphqaoblLPuk8Khj+zCyHsfBw+qMNgjLMPC
         2J3A7IBT8Y00W9bovKovk111Mn0V5ji01seSeJVjkmezO4HkEhaLuWCCLgqE0jAwVYLw
         APJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUxwUTKpW2X9QjvTO16Kj/QxH5kJ4mhBdAcFc/8GXLo8b9WVHlTUbxeCfHBpxEFIXPZK7Mlom4uxkTITE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvBi4oMOquszKKexzPLh7A0QQQJp0Bo+lKggjReMWf8adIw4Sz
	Gr/QtosF0HEyF8L7xKTh5XTa8svSf2+9++SFii0NG4Zy2nL4mlVmseb1G7Rl2/8=
X-Google-Smtp-Source: AGHT+IFnsyEs1/CwI3pWxWqWY7TURNss9/odTFhLrbhqMJEXea7TzszaE0iBWvpXWaM9N7sLxA6ERg==
X-Received: by 2002:a17:90b:4ac3:b0:2e2:e2f8:104 with SMTP id 98e67ed59e1d1-2e3152b0097mr445535a91.8.1728672346549;
        Fri, 11 Oct 2024 11:45:46 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e30d848e1csm687625a91.42.2024.10.11.11.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:45:46 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	willemdebruijn.kernel@gmail.com,
	edumazet@google.com,
	Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next v6 2/9] netdev-genl: Dump napi_defer_hard_irqs
Date: Fri, 11 Oct 2024 18:44:57 +0000
Message-Id: <20241011184527.16393-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241011184527.16393-1-jdamato@fastly.com>
References: <20241011184527.16393-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support dumping defer_hard_irqs for a NAPI ID.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
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
index 358cba248796..f98e5d1d0d21 100644
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


