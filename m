Return-Path: <linux-kernel+bounces-513764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2D3A34E6C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 20:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAEFE7A468D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB93F245AFB;
	Thu, 13 Feb 2025 19:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="k8JUe/Xh"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D61245B1A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 19:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739474630; cv=none; b=SeNanEPcXjDkDvA9dgGCffW/4lWc1XTCiHo4mZkDuonhQALqHHvgRVS8M7BjV0rWG3LM5enK1z4ZBD5aPs1bRm1WBBRkTyhTeB4XDVxK5svHkbkXvO7V4wBES/Yqff+dkwVA4A8CrX/thoyz4E/KBNAfmpgm6G361ldnRP42P/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739474630; c=relaxed/simple;
	bh=O19yHCpkqJTXpsHZkKuIx0bHDAhaiab89LoRBXElqsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLtz9ketuUXziLhy2wOj3IDhfENzTF0+W43BSR5PLUoqiRGdIrXMtC+isO+CSJqb2kMQoCBF6t2bCu5J3sMLURf2sVbhrwn879OhSlSdFfTqkX6sbQHSDYdR53fbq0sSFPsYc990rSXqDd/fo/3f+FYzCEZxek3BLgODInFHCVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=k8JUe/Xh; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220bfdfb3f4so26056035ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739474627; x=1740079427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icDgF0dhXJ+X9NyKJop8wxjdfDNUacr6ErfUqD8p/9E=;
        b=k8JUe/XhdiQz15gtIIzsurszeZsdaHQhCPns5OybRpK9ZmL3HLIDEHmyTIxS0oOG2g
         8YB9s2ehxkJ9Nq0kq1v2TdNtMj/SrmuCzDfOyDMkLPFWnMHfZexY+BsS3UQ8jj+3m9e7
         Vk3iQzDJ5LpuH+enTI9wCYkZ5mp0Xq5vCbzKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739474627; x=1740079427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icDgF0dhXJ+X9NyKJop8wxjdfDNUacr6ErfUqD8p/9E=;
        b=wCzDul6wy5XED63pN7wvHLCHIDT2mh86qvTk1HYGx5N4tndBDSLyOJBBZJlcAnMSS8
         1P/P/8b6NhKTcgYZx74ZV2JKL6KDm/TIH/p87wj0tcHafyVkNmQDF42TR3+YVgVixVdF
         Uhys46llN+sOwJKEjx0SlVYbUZBfbHj/6KBnYUf7/3icOBAQy1o5f/ADNMdbOmYnYye3
         Mzbgpg+hWIbla+9KQgHsGunIcC2rm1GbFTT57ABKfcZ1yAChZAEJZeC+cfxaUdMDYO3p
         u2TXP291qX0iYkqxxWtKVjHyzAnZQRpIywRieNsOAoXeIOSMjUvet2njsR4lOZtVxz3p
         giDw==
X-Forwarded-Encrypted: i=1; AJvYcCWj3nbP0PT11cGXKqDpxSIlOW5SnHuKIR5Bve/QP2IEjvQLavidmzoFr0J/jQujuMqsnXV9nfAqCOqXxB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWSnvUsDkl07L/FF+ETAgS8efINeoFwenCl2V4YLGAr5m37bMW
	haUxoRN7f+JT2oadUKjx1CeASIrYdAKVrk02nsNoU3FjfNOA2HnTD4skGUmi0BI=
X-Gm-Gg: ASbGncvobCq0ldB3dumF45O9TSkCXVyjdHUe30lqwU91vLvyxpnLdDJLCfcCiXGWrOc
	6RFcTpqZczRvHv4/AeOJTcoQkZ2S8gTP5BxNRxIuQDt5Gt/X78SMECu/n7MQvO4IfSIDb3faPS/
	b537A+BlJ73njRpXABBe5kUeVlOlaCWf14VQAWyEDEkYFeccD9OHpinzmcnfKyTwoGtpkAeT2hs
	5AjUERg9plJ6wiqeyGuNtxVleqMQkSd7/mwhHDYmrDuydC4t7Pw6nI/qHdeYQp54CRPmFfUPGvj
	NMAoh0Sclz/7ch2Ql0bbNek=
X-Google-Smtp-Source: AGHT+IGWSm8u83uqTS8PspXgmBAMPe2ctcctOKcrElV+Kvu4yuGLuATPkegQA2jTuHjMlGiwUOVI3w==
X-Received: by 2002:a05:6a00:3e0b:b0:730:9946:5972 with SMTP id d2e1a72fcca58-7322c374050mr12054627b3a.1.1739474627147;
        Thu, 13 Feb 2025 11:23:47 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242568a9esm1633458b3a.45.2025.02.13.11.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 11:23:45 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: stfomichev@gmail.com,
	horms@kernel.org,
	kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next RESEND v7 1/3] netlink: Add nla_put_empty_nest helper
Date: Thu, 13 Feb 2025 19:23:11 +0000
Message-ID: <20250213192336.42156-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250213192336.42156-1-jdamato@fastly.com>
References: <20250213192336.42156-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Creating empty nests is helpful when the exact attributes to be exposed
in the future are not known. Encapsulate the logic in a helper.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/netlink.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/net/netlink.h b/include/net/netlink.h
index e015ffbed819..29e0db940382 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -118,6 +118,7 @@
  *   nla_nest_start(skb, type)		start a nested attribute
  *   nla_nest_end(skb, nla)		finalize a nested attribute
  *   nla_nest_cancel(skb, nla)		cancel nested attribute construction
+ *   nla_put_empty_nest(skb, type)	create an empty nest
  *
  * Attribute Length Calculations:
  *   nla_attr_size(payload)		length of attribute w/o padding
@@ -2240,6 +2241,20 @@ static inline void nla_nest_cancel(struct sk_buff *skb, struct nlattr *start)
 	nlmsg_trim(skb, start);
 }
 
+/**
+ * nla_put_empty_nest - Create an empty nest
+ * @skb: socket buffer the message is stored in
+ * @attrtype: attribute type of the container
+ *
+ * This function is a helper for creating empty nests.
+ *
+ * Returns: 0 when successful or -EMSGSIZE on failure.
+ */
+static inline int nla_put_empty_nest(struct sk_buff *skb, int attrtype)
+{
+	return nla_nest_start(skb, attrtype) ? 0 : -EMSGSIZE;
+}
+
 /**
  * __nla_validate_nested - Validate a stream of nested attributes
  * @start: container attribute
-- 
2.43.0


