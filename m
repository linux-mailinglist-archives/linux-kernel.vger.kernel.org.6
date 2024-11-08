Return-Path: <linux-kernel+bounces-401377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2B99C1962
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383BF1C24627
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F3B1E130F;
	Fri,  8 Nov 2024 09:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="L+UlUgr4"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72BA1DED55
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 09:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731058935; cv=none; b=epYePgaXJaQbBnJbMNdHucAkPvD2I4P5Ly20Y7Tn5HdfhxAGs9ybwIxB0Rm1TYfM1AztpdKxt15X1MjffCyBN5WgFirUC19kBBWU0uW/3mIfuEc/aFNoGvrkEMKxLF6ufhC96qVqUVHCXf4kn+nTvtDXx2ft5G51dvxZ7D8uJMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731058935; c=relaxed/simple;
	bh=+eP/vcqaNzokUp6cjLnVBBHiJRRLVRpuYTF+IIIoO0U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rCzYR9To2PeMKc/NbEo0446e9XutO3we/bZRtQnlEfjqrdEfZaHtHlRYn+qjIxBfuRRURN61V3+gGBYs1JuZpaVh54uLCiqHRwpqDuv4WfFG3//EHNPLcPZe1leGGN/H7BX+pwJAWfFMG4mQuAS7RMhbDXWHTRqGKBK4GGgIAvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=L+UlUgr4; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cf3e36a76so20689725ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 01:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1731058933; x=1731663733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ca2TdIiKwWZF1eqEUaePHRgoBLNi1vfBOb48mxhddGY=;
        b=L+UlUgr4g5bwZsMhn9i4YzmOTjQnhiASN7hIMfwWUwRZXlJTpKjZjocKRPcKtks5NI
         8m70yGo8HTIvAwqBzAuzvosUWB+WH//AsjZcV1h84SkkNQGL+wTij648kQCn8W3Ik98F
         /2xzEV/kTCnnfKV7tUPEh8OzFJWXQy2aoKdltxVLDEtm0RkWO9KXprcUOnGotwspYzwe
         k4lRSIhioUbER9XV6F8kGYedIfZxOmNvhIUAOQSIH4qeq/CyxwsoeOr6yUJsWcN2/qOv
         Xm9Zj9hkdXLVD/CZWIgqipnnGDsQoPlAAcAHVvazcj3eXuWsVQGIepDLy4Rvx/hNX9uP
         vslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731058933; x=1731663733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ca2TdIiKwWZF1eqEUaePHRgoBLNi1vfBOb48mxhddGY=;
        b=e3s8OKUFb5NEcKtlPWvF2c0iA2Cgh6iCGK4Iachy+jbsYR6/piHmp6YY1lmTOdimZF
         QUrW9bLj0giZPq4Iu33mDyphqfuawOv9Q0irh0HfhMecVZ8UgCtchytXFCIxX/UU5sL7
         d2jT/UWGYVXRfD7IZBdbb7gxz5MQgVURH99k1Kx5CSF9VKx5CMC2tEA18ps8GQfu+0zL
         zrpqxqICOsO2jac2GBlrwGCcpYqzQiD6YgmwB6Ipi7OVPRC2sSpAz5PCUYJpfyA+w0Mt
         BiIWaijPNhtd1XhospzWkz5pHd96SsyNVB7eW7VMPFqffPHW7aC+2cBbugXVPVg2h9NN
         tMWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDrvqDAGu7vbRMUdjSLvwduByDw8tf3rKWWfn3oVvLWIW4M7v1Ack3AHvUS1ORqjmhznByY8vuXlNWM1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqotKh3r5figTMknSP5MJqmn2YOc8qcOmrNDNnmKXv5gxZTAG5
	h8wAZWhBcuqw6ZYCTlHDDUGcUk6RD+GnJwgWz2FY/01uwPEwE4vpMzpDVwLKVhk=
X-Google-Smtp-Source: AGHT+IHJaqY7CpnOjmx21Vtn/dox+6VYyb5PPSRH/wKo8sslUsDpZCDMWRowhL4+E2s/DAq8UCWDeQ==
X-Received: by 2002:a17:903:1d1:b0:20c:f261:2516 with SMTP id d9443c01a7336-211834f3842mr26435005ad.8.1731058933057;
        Fri, 08 Nov 2024 01:42:13 -0800 (PST)
Received: from localhost ([106.38.221.124])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177de041dsm26255915ad.103.2024.11.08.01.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 01:42:12 -0800 (PST)
From: Jian Zhang <zhangjian.3032@bytedance.com>
To: netdev@vger.kernel.org
Cc: openbmc@lists.ozlabs.org,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] mctp i2c: notify user space on TX failure
Date: Fri,  8 Nov 2024 17:42:06 +0800
Message-Id: <20241108094206.2808293-1-zhangjian.3032@bytedance.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, there is no error handling mechanism for TX failures, causing
user space to remain unaware of these failures until a timeout occurs.
This leads to unnecessary waiting and delays.

This update sends an immediate error notification to user space upon TX
failure, reducing wait times and improving response handling for failed
tx.

Signed-off-by: Jian Zhang <zhangjian.3032@bytedance.com>
---
 drivers/net/mctp/mctp-i2c.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
index 4dc057c121f5..e9a835606dfc 100644
--- a/drivers/net/mctp/mctp-i2c.c
+++ b/drivers/net/mctp/mctp-i2c.c
@@ -485,6 +485,7 @@ static void mctp_i2c_xmit(struct mctp_i2c_dev *midev, struct sk_buff *skb)
 	struct mctp_i2c_hdr *hdr;
 	struct i2c_msg msg = {0};
 	u8 *pecp;
+	struct sock *sk;
 	int rc;
 
 	fs = mctp_i2c_get_tx_flow_state(midev, skb);
@@ -551,6 +552,14 @@ static void mctp_i2c_xmit(struct mctp_i2c_dev *midev, struct sk_buff *skb)
 		dev_warn_ratelimited(&midev->adapter->dev,
 				     "__i2c_transfer failed %d\n", rc);
 		stats->tx_errors++;
+
+		sk = skb->sk;
+		if (sk) {
+			sk->sk_err = -rc;
+			if (!sock_flag(sk, SOCK_DEAD))
+				sk_error_report(sk);
+		}
+
 	} else {
 		stats->tx_bytes += skb->len;
 		stats->tx_packets++;
-- 
2.30.2


