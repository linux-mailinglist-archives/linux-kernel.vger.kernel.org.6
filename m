Return-Path: <linux-kernel+bounces-241901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF069280E4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 05:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B22C7284EE6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 03:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A252A374D9;
	Fri,  5 Jul 2024 03:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="0IKqpZJg"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A2014AA0
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 03:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720149662; cv=none; b=fMX7u1DbTEopr2GF34UGpzvMpQ5UiDnRabaRGQadU/8+Gec7xAG6PUaVcekiqZ0jhFaJxpg+9HTnf28K/vg2Wmt2N8OmOp9smwHMyjr5pFP5kS/LQgV+4ZVTvjeuxB4a1ZMV6ArBMcOHWSGZJZ+KGDptRQA/di0kLw/99WSUW6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720149662; c=relaxed/simple;
	bh=8w+l88N0ay0DP5baXPiAOfw5yIbPXiW0S1kxxDfJ4g4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MbaTg6kFD6xvjj8853YK3ZiaD/hbxbQaPGYZQh3bj1HEJC3PcnkI+0qLKDFyJBsGFVqMUE0ERAfqUfauWC6lsJT3ZYRVJUQNgXS6yLnj3VqbBZmP02PGgjYymk92fmh0fp4wB2RidxDRwdgk/hs3mE4rXfDq44hR1gxw+M2vx3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=0IKqpZJg; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7021702f3f1so738475a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 20:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1720149658; x=1720754458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4m+wLWb9gkModAj2RkagVThSSmZ6lzDQL2hRBJ4sn6M=;
        b=0IKqpZJgEb7zOeNHrzFg5EsrBTOwXBkYI3lFEDC7H5ErkPQCNXEVfbxNANom4bKzkz
         LwF33hkfzuyNTocdvzd+ipL9jtKJarKJym91341V/BNQAH2/4+iS1aMrEfFA4f9NelPM
         vzWU9zPBAIIGdfzjaScIgKZvB2BjUZMNev6yA8zQBsgiqsZULLZiNnhL5jguW+N9b2Hv
         m4D+8kWUWyjOfypQiT0rvBzb8jDW8FmNdc7iJUhp9Sms+AqR94AmpktwfqlB3gPLG0SC
         MTc1VQsPgAOdRYABuk3AO4OpviYbb8maZfCUAiSc75IOL5XnlLVg0IIE0UQpIeT6zDiv
         x0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720149658; x=1720754458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4m+wLWb9gkModAj2RkagVThSSmZ6lzDQL2hRBJ4sn6M=;
        b=UflfFBbwLdVSR7+M8mXkXUeWnx8VicPyepyI4cNlFvWOW3t+wrP/XD3/qr4uPHGWPg
         8j8fW1UZKbUPMRH0NCz1WqbcIvpQNKCei0kG6QJ/L8Gibuzis/al7UMGTx7YZT5yTJoH
         xcOw0//Smy4zEqQerE5S+dHFoviAqvVJHvylyUJlM8+z/48KQ6TdRPQQ6kYCRsBzVHky
         Wne+LXvrL9b3Ql4SI0egPXZZMVznt8wiurqbcJiHgacZmOutXqwVMhRP2xFXlSk9qdQq
         CrDcA6WZorYVbyqU5MFcX3z/ZOrBVSjBWPdUIvE2aupCJiAW+EjCbM1dDsM3NVtaBVyG
         SEYg==
X-Forwarded-Encrypted: i=1; AJvYcCWksUv44uBJNef4Gng2YE4DOdhUhyewnYJ0LirYcPRKSY0LayJUcTDQmU3elFXUw9hDLi1/B1Wxo57Tl5xo1u4Gmuwhxs3GRViaHi17
X-Gm-Message-State: AOJu0YwtmSgN1m+3ygWYr5Kx76IoAK1rUR/Qm2ZgsxDYph5kkyVeypw7
	wP5xcg2YKw2yiLLH15GvkmpOnPHde8+wi27f47bLS3KLhX9d2g/I+FU/LxJRnao=
X-Google-Smtp-Source: AGHT+IFn2XdhgB88bdLcHkqaGNa+vFp/NLHEl4eeGjUKhR5UGYOLVChbMaJJftp5OFbUBLt+g2QsXg==
X-Received: by 2002:a9d:7382:0:b0:701:f4b0:bef9 with SMTP id 46e09a7af769-7034a74cdebmr3575073a34.14.1720149657296;
        Thu, 04 Jul 2024 20:20:57 -0700 (PDT)
Received: from echken.smartx.com ([103.172.41.204])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70afaa8126dsm2433163b3a.197.2024.07.04.20.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 20:20:56 -0700 (PDT)
From: echken <chengcheng.luo@smartx.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	echken <chengcheng.luo@smartx.com>
Subject: [PATCH] Support for segment offloading on software interfaces for packets from virtual machine guests without the SKB_GSO_UDP_L4 flag.
Date: Fri,  5 Jul 2024 03:20:48 +0000
Message-Id: <20240705032048.110896-1-chengcheng.luo@smartx.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running virtual machines on a host, and the guest uses a kernel
version below v6.2 (without commit https://
github.com/torvalds/linux/commit/860b7f27b8f78564ca5a2f607e0820b2d352a562),
 the UDP packets emitted from the guest do not include the SKB_GSO_UDP_L4
flag in their skb gso_type. Therefore, UDP packets from such guests always
bypass the __udp_gso_segment during the udp4_ufo_fragment process and go
directly to software segmentation prematurely. When the guest sends UDP
packets significantly larger than the MSS, and there are software
interfaces in the data path, such as Geneve, this can lead to substantial
additional performance overhead.

Signed-off-by: echken <chengcheng.luo@smartx.com>
---
 net/ipv4/udp_offload.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 59448a2dbf2c..6aa5a97d8bde 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -402,6 +402,13 @@ static struct sk_buff *udp4_ufo_fragment(struct sk_buff *skb,
 	if (unlikely(skb->len <= mss))
 		goto out;
 
+	if (skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST)) {
+		/* Packet is from an untrusted source, reset gso_segs. */
+		skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(skb->len - sizeof(*uh),
+							 mss);
+		return NULL;
+	}
+
 	/* Do software UFO. Complete and fill in the UDP checksum as
 	 * HW cannot do checksum of UDP packets sent as multiple
 	 * IP fragments.
-- 
2.34.1


