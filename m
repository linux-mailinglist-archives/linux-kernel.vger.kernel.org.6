Return-Path: <linux-kernel+bounces-409768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFA59C9123
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EE65282E65
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10C918D651;
	Thu, 14 Nov 2024 17:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Z0tJYeTx"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47AA18C010
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 17:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731606732; cv=none; b=NwLWeyvWzAwUDrhU+jH16VIM1d9Q+e8dXjG+8+kB+wlAFTCxe7tFD3CG8ToGK8roTDiK5UMLizJHdDdZTnENno9RkWoJ1CvURh67Sy4XoW3xOaN/r3QaQkzrdsQ0RRhYevasp2A+eiy0DKVCxDpXemICcnlOubQ8aYvZgDhVt78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731606732; c=relaxed/simple;
	bh=apJSFXQVNjB7nklns7r3B69WAfmXsi7qpL7x89a7NVc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bc2EKGiNHGFINtN4UzSMzM310xDyoMTKwXfk0cGKBhAI/motq5EcEyfuarvywQEmI/Wr1kRCw5BzUeqdeZn3yOuuEYkJI7YR6LVdlkWmNz6J6ojFxXKghu2qsjTGuWzk0A4IHSYzvCCAbxy8I2W382Pzci+QFbcE49D2XCui440=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Z0tJYeTx; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-72061bfec2dso678802b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 09:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731606730; x=1732211530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bpy3QdHD1PzWkQ/hC0jW+9k3dxQdnK5utepjrrTfjd4=;
        b=Z0tJYeTxLY2SOzcxCG/Imt1hqhcayGy+UVMSvjAAHWM25X/Z0J4BqmjeKTWcaCZnMz
         VO1KgBQu+dpBKU6EJ+k2Q3CQRJThiWAjYt6RTfNha5u4BDo4Z3NotFqhO5ov8/gO1hoy
         kJsR9WfqCkpMUzZun9eNlkVQbRsJ6Yjm6kOug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731606730; x=1732211530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bpy3QdHD1PzWkQ/hC0jW+9k3dxQdnK5utepjrrTfjd4=;
        b=KiFMF/upH0fqT0+ls4GAhYyEmHv4iy/FAtRwkisoFE21/MSPalvvfy8q+bihve1q+5
         RrUXdyu4Je/gt8jc6+mzFsMBMrhpu9dvN/796jAKRjwrB6TaSKday6nFdl+tthFPXjMI
         wBzAR599QSp0mH9nGDKpVnFs+80d6/Uayz3L4umE6abH2rYG9/otPidrVlruG1ElvwBO
         n3sfyyqwKll/RIhy+GvreeQprocU8sXe/irIBlYYUZEez47nae3BqAX8LqAEU+D9b0Lc
         7Qi0Cp3pPZV2+su6FfJkXflNnWxZVCOyYyLSHq2ArcrDA/sTm11WAesyLLYyjMq2wRdG
         mcng==
X-Forwarded-Encrypted: i=1; AJvYcCUcU5b2PvWwboTMT4uGivvblrt1GO6sgTbpoJ0PIdW2ED9roH6rXNiTg2/wsw78NbxLHHx3NGIO5fLdmbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV/opwQMPDz7EsBY7i3kYTBnI5Azvc+AplwGcKHMfkGXMDcqwH
	FD4MzULvcTcL2Z8K0B/h3AzcC/k2cL1jTwC+MXud7rxDeGVQKjI+q23aD3mribw=
X-Google-Smtp-Source: AGHT+IEzuOBbg7r/5j57WaldF3llHWkwbSqlB3tC2UE/jWFYwiTb0w9QGbjIr3D5ZFS7w2Dgt5FdwA==
X-Received: by 2002:a05:6a00:1ca6:b0:724:6bac:1003 with SMTP id d2e1a72fcca58-7246bac1753mr3240414b3a.24.1731606729863;
        Thu, 14 Nov 2024 09:52:09 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7246a9bac56sm1559883b3a.141.2024.11.14.09.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 09:52:09 -0800 (PST)
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
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v3] netdev-genl: Hold rcu_read_lock in napi_get
Date: Thu, 14 Nov 2024 17:51:56 +0000
Message-Id: <20241114175157.16604-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
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
 v3:
   - Separate the patches that were a series in v2 (and earlier) as
     they target different trees.

 v2:
   - Simplified by removing the helper and calling rcu_read_lock /
     unlock directly instead.

 net/core/netdev-genl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 1cb954f2d39e..d2baa1af9df0 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -215,6 +215,7 @@ int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info)
 		return -ENOMEM;
 
 	rtnl_lock();
+	rcu_read_lock();
 
 	napi = napi_by_id(napi_id);
 	if (napi) {
@@ -224,6 +225,7 @@ int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info)
 		err = -ENOENT;
 	}
 
+	rcu_read_unlock();
 	rtnl_unlock();
 
 	if (err)

base-commit: 5b366eae71937ae7412365340b431064625f9617
-- 
2.25.1


