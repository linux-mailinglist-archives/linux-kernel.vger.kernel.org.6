Return-Path: <linux-kernel+bounces-515653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6FAA36755
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 22:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C1A97A4B4C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 21:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B161DE2A9;
	Fri, 14 Feb 2025 21:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="LkNu7q6E"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66721DA31F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 21:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739567593; cv=none; b=UUnInq8H9BR51lM6m8WWkHKHbBehkdj6xDAdHwQXRtaocdPct0C+Q3854FM6YLnGO7DbD73PSJEzWIqHBKc3meAQHWmmJiYGvswM9egJvNui+URntd+fyQyGIyym31ln79i3STrpQG6etjeEMo3qcHMLZiybPE8Kd79FqmB2Ox4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739567593; c=relaxed/simple;
	bh=fgaREE9e6jz5S5ZRiFkiZ2u/DNlIlA4sG+vDOPb2x/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PHnxZsfSQIWtsSFBr0tRCnIDNwlFld2q0JWu0RUGr1s5Qd/UR0oN3L88dYbmx8EhYFMBuwpkoZ/vlVs2fCMYqcKT23XboC9FUYVPDjrXe8vbeshHpuWO2SseMA4U0xUXm5XVeWZzSMVXYsLDDEGs6sIyuOqdqZqYdZmIHQkya/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=LkNu7q6E; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21f6d2642faso67860085ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 13:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739567590; x=1740172390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h50Y3zF4tCkc/2EOdw4zLXgmcTIrGB/eNO65/LtZobs=;
        b=LkNu7q6E66cr1tsNbLyRLwWYxV7/5nUoETzU/U9bqY2BqJ8gFMl7zKSImgeEpRlxNw
         9AngJX2+nQmE+uxaIUxKMOZJn0KsURDC5QSeTcNrrtDozt8eBKFfhQx1ImNxSgRwJxGf
         ulsElxXqRVCOx86g6cshIESAXbP8W+mdINOSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739567590; x=1740172390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h50Y3zF4tCkc/2EOdw4zLXgmcTIrGB/eNO65/LtZobs=;
        b=TrvtLv98v1qoV0aOf6C/jzM6Zl4u3+kIhZi1lJVeD/hasPjrNYoVqHwRtvaNmi1nD7
         piPqYp4VPqKEnrXVINj2/+/Bi+/xtHgIqDUWcJ0dLXsYlxfEBIAPaeSXdHqq7+i74hoV
         GlWjkaUp7TClb+JVtboTZ5KqoNSNiyk0jiutbak/SYuXQbJGMu12cW19WHR+0UB/E6WT
         WOUevJWZr6XPhXKM8NeXg1enaTovmtaigZrsP8+HV0HNglaimoW4pEVHdMlw2WrWxgt0
         /dYyILzlc3FMi+bwJQPYCS84yRCvRfGmvNl8qZA6V4xe0EQ85QnRXlvveel1IzrjYjnN
         +qgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdPR6UMwmD6YJ2As89+91NinoAs1dDJYXiAWTJpgRtDlxo83WE+iN0ENK4g3ySPOAC85tlSOgyZC7M5n0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHSt7Fo3ZJ49AvjKxBnaydquRkmnkY+H+yMde3l3Lfad9vfT7Z
	nqx4YDG/jGznDxbUr1leuWkkN+vZqJODMBl3Npz3LXEusyfzWNDiChcDOZFUiJ8=
X-Gm-Gg: ASbGnctvVyLI+g7EWMI5pM/JnSj+FIwCMNmpjo/ezaTFpwfMFGDGfMgGZofrfEUA7GH
	/FEzH+VCZJKs7RbnmZawNpb0sOlYaaSij4DiE+ULs+M61kr4EINMwpC5NDO/FuVykLjSCO910LR
	f3i9LQcNTZn4o0tkAFpZXA+XOcH80K5fSW13gxyk95RE5zRzbNlX8yeCPe8X/j9SQ2TGuRzPe62
	g31hG+uA1PIJG9H88MEY2o1munvP4TEVHdLwJxnwPKr0fnMxRSXXtmR1hbGGb69SDXAIjw/CcMy
	WN1M4HTU8q+Wu0O2R1Ekc90=
X-Google-Smtp-Source: AGHT+IHLzbQ5GQfrunSH/5MZfcXL0ig2ibFP6/HEsx6LkPpxC/41PemipAIBEq3dtSX+KfEf55fVPQ==
X-Received: by 2002:a17:902:d542:b0:215:f1c2:fcc4 with SMTP id d9443c01a7336-221040bc31bmr12353955ad.41.1739567589935;
        Fri, 14 Feb 2025 13:13:09 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55908a7sm33285265ad.240.2025.02.14.13.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 13:13:09 -0800 (PST)
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
Subject: [PATCH net-next v8 1/3] netlink: Add nla_put_empty_nest helper
Date: Fri, 14 Feb 2025 21:12:29 +0000
Message-ID: <20250214211255.14194-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250214211255.14194-1-jdamato@fastly.com>
References: <20250214211255.14194-1-jdamato@fastly.com>
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
 v4:
   - new in v4

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


