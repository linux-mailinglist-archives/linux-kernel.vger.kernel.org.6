Return-Path: <linux-kernel+bounces-309883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B5996717B
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 14:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E89D1F21594
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 12:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4E617E005;
	Sat, 31 Aug 2024 12:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="VUyTsahQ"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F59193
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 12:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725106649; cv=none; b=MHgNvtuDic45qQfD7f/a6C+D3EDupAf1V9QaykiOrs0Ng+XartEygbx1xgr3zkWMfeFs7ClYol2PzI8iLSO1nqNdwdhOtDUG3JqNG+HXCkIVQmWxvqkqEuENtl0oCyfq1PUFRUu5Py4PQGJKa/xj2pHKhKJBQ4298w2XSskbKTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725106649; c=relaxed/simple;
	bh=vStrJNgxv7jluDND4edIjDhOQsUyuYYkJfiHb2+oZUA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B604QPJ4Ypq0+0ghesLlmOD+DtNfRf0CkH2KgKpEHY5/egI96EMrD0lTqmWmfcXiS4V+inFUBAZqVxah/j1Orvi3tlRdlbkgE4cqdxQm47RM7fARfBdZm3GgmFgBC0KbXHX5SbFifEMMgsvMk3ByzXMz9OKSWgWAvXKGXrLTEgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=VUyTsahQ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71433096e89so2272920b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 05:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1725106647; x=1725711447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N9vo0rxBDwLLQLuN0jh+7it+dIzexEc+nX/9gftDvCo=;
        b=VUyTsahQAGaJucepbFSKQG0yO75E1dYAtZuW3DpbwUeNbthwEw8zL7NuizOW3KSW5X
         UCRg51+4k7Dde1ncKDhUErzq62eCPYfmPRte6LFOK3GJw9IJCizwtBEEGv6NN9NTCpMY
         Z/wbvuC3epNWoqwwgs2o2P/i5UfS+CTL+BMYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725106647; x=1725711447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N9vo0rxBDwLLQLuN0jh+7it+dIzexEc+nX/9gftDvCo=;
        b=hLj+bnZuQj/6K0RK3qwOK3OXv/uAVnI/KsPsWu4F/KWCHFx4BUKqvUwILjz/iMOVNj
         6fOS0MP4XG3wbMA6WEZdx/d+fIyGiEFVSZTdYnjFJN9OHMDttqo/ovw0ZAxIFuDY+ad5
         KkQslMucPmzSFL/YKdthax6cCNcLN841SyQ0nZGfMHGwJmUaQf3XMx576F6w3PrgNwo2
         C0IRBWxgmWrkrHbhFLC1biOKmNG6ACvwdkR2hzi/fdQREZ7qvQXkCIeoHEV/1DTjiws1
         iBIjvDEJFJ8kQsWa8uPRES6ejKt9h/hyGXsfcAEOUWf6Us6muFvzjWyKEoWqLYOAqUtL
         vSiw==
X-Forwarded-Encrypted: i=1; AJvYcCV0V2Mu+dZgmovVQv4yI3vBDhuvfG33qAkizMH6OxhyjL2MNXS6ZQy1fC3O8tBzSo6TwWGG+Ch5rxXP2k0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC0v+CpbDYt+uDSEd55tgJX7Kqk4+N/T6MTOu5KkzlLciMF6wE
	aAFEq4QkaZqNUtTOJznaX6nmH6cILpHOQzRtWJOv3k2h/Sf2jgpffPCaL1hRBqECGfoXQmiEYDr
	SO3c=
X-Google-Smtp-Source: AGHT+IEWVTjw1mkR38vOPZGIpsHvZYPxa/2cs8gJfJ7WI6kldGRvYlYX/irEafDBtNVI99nvIv+eBA==
X-Received: by 2002:a05:6a20:2a29:b0:1cc:d73a:93f1 with SMTP id adf61e73a8af0-1cece5d1375mr2103569637.42.1725106646757;
        Sat, 31 Aug 2024 05:17:26 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8aba505bfsm458583a91.8.2024.08.31.05.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 05:17:26 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	Joe Damato <jdamato@fastly.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	stable@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Daniel Jurgens <danielj@nvidia.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] netdev-genl: Set extack and fix error on napi-get
Date: Sat, 31 Aug 2024 12:17:04 +0000
Message-Id: <20240831121707.17562-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In commit 27f91aaf49b3 ("netdev-genl: Add netlink framework functions
for napi"), when an invalid NAPI ID is specified the return value
-EINVAL is used and no extack is set.

Change the return value to -ENOENT and set the extack.

Before this commit:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                          --do napi-get --json='{"id": 451}'
Netlink error: Invalid argument
nl_len = 36 (20) nl_flags = 0x100 nl_type = 2
	error: -22

After this commit:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --do napi-get --json='{"id": 451}'
Netlink error: No such file or directory
nl_len = 44 (28) nl_flags = 0x300 nl_type = 2
	error: -2
	extack: {'bad-attr': '.id'}

Cc: Amritha Nambiar <amritha.nambiar@intel.com>
Cc: stable@kernel.org
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Fixes: 27f91aaf49b3 ("netdev-genl: Add netlink framework functions for napi")
Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 net/core/netdev-genl.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 05f9515d2c05..a17d7eaeb001 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -216,10 +216,12 @@ int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info)
 	rtnl_lock();
 
 	napi = napi_by_id(napi_id);
-	if (napi)
+	if (napi) {
 		err = netdev_nl_napi_fill_one(rsp, napi, info);
-	else
-		err = -EINVAL;
+	} else {
+		NL_SET_BAD_ATTR(info->extack, info->attrs[NETDEV_A_NAPI_ID]);
+		err = -ENOENT;
+	}
 
 	rtnl_unlock();
 
-- 
2.25.1


