Return-Path: <linux-kernel+bounces-406993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AACB9C672D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 03:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C59901F2195B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 02:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84ACC146588;
	Wed, 13 Nov 2024 02:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Z0VQbA8O"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF3E13C90A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 02:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731464294; cv=none; b=BqIT6e3xJnD86RzwCMShMC7x3YBbfrXtk1H31/4jzrovQw4ApSCDp9tJPc10Kbcxy226Wz7T4R71YxXyHrbTXm2ako+oKa/cGyDzwlZ/G0SmHgdQ8OOMlOwPdRPLrD6IGwJUgs4Jke9zookgHiB6EkcI8a9mS5m/NfS+eYzsEFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731464294; c=relaxed/simple;
	bh=nrCk1dGkV8Sk4CWrmNxr+NTAfkg/eL3xFyL1TKB1XTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JYi6mZzvNt2xSpXR7lpM4tUBlbjaTbbsPloPCNvp77ge3vEccGrFa5X87jFopllncoWIo2ArIyYR1MFeL8DxT81KYZjPjlJY1N1129v0g8OXavydz+AWWLzteFEgKqSZuB38OGNrg0Y0pbQcQpTnW9+8yyTvcxVK0slfnvlFgL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Z0VQbA8O; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-210e5369b7dso66116575ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 18:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731464292; x=1732069092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1aEFQWTe78u6F+IZ6BU8S97709C2TVDqgfHG0ZtS8A=;
        b=Z0VQbA8O4AJol381I51hQJho+TTjOoAW3ruNPPXibqHSuxbYmRMsE9W8Crz0uNTaPV
         kkTTK4pqFOxf9HW0QozkiCZ38gu1N+fx4cn9k44WTOhWZZYMUZ0P9NWNukUwFmF6MVTT
         RzeeLEd46hFsyx9AYVUZRmAkRwuaiSeRz/3Co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731464292; x=1732069092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y1aEFQWTe78u6F+IZ6BU8S97709C2TVDqgfHG0ZtS8A=;
        b=TfupNJuN7EfJjRaPcXXAOX7iuoSI+7FWVRIyo/60ASx8zlleWcI048wVlgvmtTIUwX
         5sfKmnAOEYuPuDRT1bColWkcuMTYwNb+anP3TUnMRU/hnIxJgIVWH1YJ9TIjJXtvwGeX
         UDwTPQzAqjJFTJKoGhR32RGni3Z2AjKJYnAnyO0iJcxmS+m9qilj2i9UjemqKFC8raPi
         oaf0hikEenocDxjV+t7DvIABafCUCy6nfkUE2ppQPCgDnl3aoUH45mwWpNPHP0lWcdNE
         Tm9XwNBGUxxEiY1hfuyTO/4uL2RgtWj8wD4EPhuNz2RBtJSkuNEvcmp3JMNz6/G4rTg+
         pjEw==
X-Forwarded-Encrypted: i=1; AJvYcCUx5JXaSmiA6U4BrgC+X29PxNJnsgx77M76zPV9H3F0gHvQlwzrws15/MjViMa/hp5u6LdwV01T2h874sY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbmXU7NhasEp00yjhmWJpEdXcYVoG37OOki8BKECyXf6Tk1AT4
	ptg0Es3nbdtJmxHWxZ9j0k1vvMNld69A3bO0aMMISwMnjy8Jrr3vloeVOj6aYsg=
X-Google-Smtp-Source: AGHT+IH+cykyQhf5ILYAg+A7Oqq7FgSl5NS8ZGdD/OwOXspf8aJbdID8nejTn8/tmddQsmmSIfN1Ow==
X-Received: by 2002:a17:903:18b:b0:20c:763e:d9cc with SMTP id d9443c01a7336-21183c7e021mr262269115ad.7.1731464291905;
        Tue, 12 Nov 2024 18:18:11 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dcb1dfsm100209505ad.14.2024.11.12.18.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 18:18:11 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	kuba@kernel.org,
	mkarsten@uwaterloo.ca,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [net v2 2/2] netdev-genl: Hold rcu_read_lock in napi_set
Date: Wed, 13 Nov 2024 02:17:52 +0000
Message-Id: <20241113021755.11125-3-jdamato@fastly.com>
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

Hold rcu_read_lock during netdev_nl_napi_set_doit, which calls
napi_by_id and requires rcu_read_lock to be held.

Closes: https://lore.kernel.org/netdev/719083c2-e277-447b-b6ea-ca3acb293a03@redhat.com/
Fixes: 1287c1ae0fc2 ("netdev-genl: Support setting per-NAPI config values")
Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 v2:
   - Simplified by adding rcu_read_lock/unlock instead of using the
     helper proposed in the RFC.

 net/core/netdev-genl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 0b684410b52d..9527dd46e4dc 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -348,6 +348,7 @@ int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *info)
 	napi_id = nla_get_u32(info->attrs[NETDEV_A_NAPI_ID]);
 
 	rtnl_lock();
+	rcu_read_lock();
 
 	napi = napi_by_id(napi_id);
 	if (napi) {
@@ -357,6 +358,7 @@ int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *info)
 		err = -ENOENT;
 	}
 
+	rcu_read_unlock();
 	rtnl_unlock();
 
 	return err;
-- 
2.25.1


