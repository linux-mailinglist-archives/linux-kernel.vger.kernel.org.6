Return-Path: <linux-kernel+bounces-356106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7551995C84
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 02:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB93281D48
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 00:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B3C2D613;
	Wed,  9 Oct 2024 00:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Zl9J5qaQ"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BE82C859
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 00:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728435350; cv=none; b=dKL7AqDLsnzaLlpIrgkL443WJNqdK7essmScZlyktB7m20ymJAW6u8KSSmEmh0EH6k8LsOjV5zM7Qj8vrS3W3G4G9qJyCSpOTT7D7HM3lEW3jbsi9U35SmNsmlGhgJrngz/IaZwUoY3GrVh3MfRIlVwJ1ud4aX1YUn6uwIMG8L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728435350; c=relaxed/simple;
	bh=xH668O18crr5A1NH6k8Aj+JP8S+91oltJLMlwh58J78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LTo27k1Ms+cTlKdionWpgT5LMqjiDLk5Ea7BF2hfgmWzKtvakoX37qncC3yvGc2yWEYshxZNL2l8tH3P83LyowODPZ8t57YSLtetoOfM+XBiyH0tzRrzJal8HHM6j4fPYA3d1xtxF8SqYfI+6OdR/pTHAovYlfpdM9fGz07yC6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Zl9J5qaQ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20b95359440so53949595ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 17:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728435348; x=1729040148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqUcKdW42CrdR2Dee2W+Xtk6g2oMU7HQioOPLi4n5sw=;
        b=Zl9J5qaQZi+UghVH3h2kfroIOeWVJ/hgQg9C+B+DNgblOSnvfeYtEVj2Fx2hg7Ce/p
         3svvzN5bieYuhXTJaGmRFCHToR/KGfDTkDn+fvtu1ICWX/RHcovFkTv/fqxLtEOmNbDn
         AfymLN1kmIJgnpAQJbJdSBrblDAKT3UjoBy+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728435348; x=1729040148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqUcKdW42CrdR2Dee2W+Xtk6g2oMU7HQioOPLi4n5sw=;
        b=hTsu/Csc3UpF74rNy+Kdvtoy+Xyk9FG/d8aXO5WhpvQukI6yztnG/cV3W3D3wqBhQ4
         2rlUt/i3ynhdGZ2asSdGgwy1CBXLTIFnJCyIx0Msm37nGOvnGDnlbQXN/TAjpWsEcCVU
         cfSduvEKTr5rbYXG5LA3bOmuj738FT6LtrXAIgDcyclI8lhipxEkx7aBjIVkidFHD1r+
         A+VzB5Ylp0WMJJcPt88hGPkSdZ8rxVuUXT6pOIp7VP5MAkxkQZ62whNH3s4bmXWDmH4V
         3yO/NmpBKoAvuEB1YYgdmK1Mu5Gdrw9j88hkNibBbWWif83ied6GhrKMeP5D8mr7jxZv
         pKGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvsCgxT30xRq3n0G/pkHtaeZ2CedLZonth99O/4gfisx5z3DcgAYWQamLnVgJn0j867FnBRZm4pU6D+sY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBsOLMSQPM+9hQJSqlCictIRxSu1eP9ge+DWl0+rMTJEodbrWJ
	ZFjuRA3tRRSCwgdMvL1DK5EkdqIH5DbvGVC9p7nrk3BJckO+NFAxuBXw0lSBNJQ=
X-Google-Smtp-Source: AGHT+IGfMGlqV4u9Qk5t0M3OQWhoi/AtJl6chgAjQYihLIPfXcXG6om5Wm1XMryvJEMq2Go13N+ZEg==
X-Received: by 2002:a17:903:41c5:b0:20c:637e:b28 with SMTP id d9443c01a7336-20c637e0b3bmr11984985ad.39.1728435348225;
        Tue, 08 Oct 2024 17:55:48 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138cec92sm60996045ad.101.2024.10.08.17.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 17:55:47 -0700 (PDT)
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
	Daniel Jurgens <danielj@nvidia.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next v5 2/9] netdev-genl: Dump napi_defer_hard_irqs
Date: Wed,  9 Oct 2024 00:54:56 +0000
Message-Id: <20241009005525.13651-3-jdamato@fastly.com>
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
2.34.1


