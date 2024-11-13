Return-Path: <linux-kernel+bounces-406992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C749C672C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 03:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93BFD1F2158E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 02:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C5C13D53D;
	Wed, 13 Nov 2024 02:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="FyL92bcT"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC1B13AD33
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 02:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731464292; cv=none; b=sVqz1lT7ikFEi5SgLoVKgMdGSdkAeKEdAMzYZDodfmxpfKcKf0qL65zc5B+S7xLPNZiCQbttqMb2krvsrrwzohoPLhQR0X3YVN+DNO8PI46OcylO9PxitrlTbTRKUHvVrgwvPDw4Cp20rwBbUQQySKr3cmKzUPHkjxoM1z3GZyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731464292; c=relaxed/simple;
	bh=VBaKG7sS3+bFmnPdr4IqHzNMfBCmbNJFBokvNs/FN3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dNypBqY0v5muNZFFEANPdhOeZ63aU/XJMMbpWskAjFKXdwLiTgKHecRHkwfQ3j/h7XvSGwoTHcjd8ExZQaN0CNd/WJ+a3NFEkzM9elSwtMbX311ASYd4HCPwlxbSv/AQTEkpovp+6wHfLz5clgW9D9hbflJCIbnXaDjx+t7BCF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=FyL92bcT; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c803787abso2235255ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 18:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731464289; x=1732069089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKBid5QRb/kAhtogYHDhzeEdvI0mEg25tnKEi7AhX6E=;
        b=FyL92bcT5FMc9roNmTkc73hyyelyRZqtesXbJoylmSOcr//jSCHmm2JtwMmg9Ha74u
         WYwzKG5dANmDe5NMjoQ5rWzTK1geMmxoZxZEAvKsqCuzgjLsWR+of2/E9HOn8V1ejvGQ
         HKnYbqnTGpRypf+NBcogpdL62e1It7aRTdImY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731464289; x=1732069089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lKBid5QRb/kAhtogYHDhzeEdvI0mEg25tnKEi7AhX6E=;
        b=VnrUl+23Fu0d+H5YM0yfKeHVP8ohKgpi2/J6v3Ev3o54uFvgwQPHd7Ev5fO9tzCEhv
         GAjXOKnVBGOP/oYPCwXGwoc2juM0+hC9hj3ihGKt+g15jSKy3nMBQ27J1AT4qfdFrh8t
         apH/EnyJmI5Zr+PwCXrxp/Rwan58e/uMCIxpdRQDbnkRLM3NJHQOWXHaGLKhXQxJHKjv
         ZViCR9D76jxfV2DqJ7rDlzxBarMknwbvpttpdcpYCfl+WQ3KdL7F/4amZhtDDqr9ZcvD
         u27PbnRk26lLxH64YFXJCpf13h+lV6DvitkkfTptfzAgUfC7N0MShD5gYF5G44q+JYpv
         ornQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOMWcEURzsz7NYFlnQSmLaOkgcHoMSDASXdKnA/TVnO1geVARbG+qoiKLTC3AuIwjs2Nz4GUemnC5UThM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8zudXzSqvrRUr74j01MFA+fRCycpNjpVaJ7h0JTvzrKibX/U6
	U59pFjN6+JaXQZTZBSRAb350A8GqUulfTBKFlbtjASB9j38ngH8RHbWlatoyZOM=
X-Google-Smtp-Source: AGHT+IHI5KSL7qnXQ088ADYDMAiYRAqIH80E+3/aTvBMuDhB8SyMPvP3rnQzeByPamSOepx19J3iNA==
X-Received: by 2002:a17:903:228d:b0:20c:5d5a:af6f with SMTP id d9443c01a7336-211836e6dcemr267759715ad.10.1731464289523;
        Tue, 12 Nov 2024 18:18:09 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dcb1dfsm100209505ad.14.2024.11.12.18.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 18:18:09 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	kuba@kernel.org,
	mkarsten@uwaterloo.ca,
	Joe Damato <jdamato@fastly.com>,
	stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [net v2 1/2] netdev-genl: Hold rcu_read_lock in napi_get
Date: Wed, 13 Nov 2024 02:17:51 +0000
Message-Id: <20241113021755.11125-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241113021755.11125-1-jdamato@fastly.com>
References: <20241113021755.11125-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hold rcu_read_lock in netdev_nl_napi_get_doit, which calls napi_by_id
and is required to be called under rcu_read_lock.

Cc: stable@vger.kernel.org
Fixes: 27f91aaf49b3 ("netdev-genl: Add netlink framework functions for napi")
Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 v2:
   - Simplified by removing the helper and calling rcu_read_lock /
     unlock directly instead.

 net/core/netdev-genl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 765ce7c9d73b..0b684410b52d 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -233,6 +233,7 @@ int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info)
 		return -ENOMEM;
 
 	rtnl_lock();
+	rcu_read_lock();
 
 	napi = napi_by_id(napi_id);
 	if (napi) {
@@ -242,6 +243,7 @@ int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info)
 		err = -ENOENT;
 	}
 
+	rcu_read_unlock();
 	rtnl_unlock();
 
 	if (err)
-- 
2.25.1


