Return-Path: <linux-kernel+bounces-293416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA42B957EFF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 691962813D7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 07:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC2F16C86B;
	Tue, 20 Aug 2024 07:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebqwC+lr"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5220B16B391
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 07:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724137606; cv=none; b=oUioujxxD2rDylDZTBNrS5sZSrrT0bMi9ClloeaWZ/UdM9DKyUtMnN8bfFyLU7wu87sNEfA1+77mMCAc1S+szHGVj/pmA3OdyG1sOG9p6WCBnvK2GnNL4QsYVp6pLSl2+pcKRaPvYtEjrOiAm3fYwHfk7HoNMcciLNPRVinGqiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724137606; c=relaxed/simple;
	bh=a+u44GbA3782ENZc0cMAncZwcbfncRR90bwx9mR6qhY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s/v+qZMRlYQ/BhEcoDwVcIhD0ZZO0+lI3sbI2R3vFrEL4qwgGTBS/7hLMCVNBC0zRqJEK3PunPIEVE+knlCOpCO8zjQfH3pFY6TsGsQN8Zzk9Kcb6viPpBu4J1c0UhZpX4GWPQfuL/3nI5hXKu/4ecVvynesGyXW8p3j5xKpgKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebqwC+lr; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e13cce6dc85so3138455276.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 00:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724137604; x=1724742404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ylr0M++sqeUWRwMUB+wZ+iUCGUQE+/0oTDCDEtEctOw=;
        b=ebqwC+lrms9rDSxWITX+B92lKaBuO6LhYSLeooQ2deBW8vI2bXzr7VntpluuJZNS7v
         LiBXjBmWbG4asJw/Fqsm+euIuCQTt/xGXETwtBirnjiSBBQcJiXv9KeLy2a+FqGBICEe
         OTeyKMVOnsV2pE635m5pEBBBO9lqB61+3Vl4/U3HE7lsSOMro7fYpZ86PIjSi/eCRVj0
         ElLZMi9V7osoLxAYKJVz1k6VKfloJOo9JHQo4nAXMrNUNUusOgWz2SPkXIfUi+7EuHy9
         JeZJf8eLJMIBFTSSRuc7iowklvm/zeaegfpfE+oiV5TitEeHCOVZbidAuc2AaGGAtiwc
         kAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724137604; x=1724742404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ylr0M++sqeUWRwMUB+wZ+iUCGUQE+/0oTDCDEtEctOw=;
        b=VGNuJwDO5W104RH1tOEWfJCWg+xokD5E3hV5AJESvYpFubGS6HOJAhtTSNvLn7pbPq
         ExbJi0c0qx6rIAtnKVvczrhwZK8EafMLPWOsrpkXSQxByzjWnGov2vel82LpMMdRo6gO
         leOUGYs/hNMR+5RSBvuM/j05f6tizKf7U1FQqw9BUZ9QALx86MGcfI1HNRmadZ8q42sL
         QQY2rJddRg4WKWl6lDUJT5HTF2U8dpVy5P8nh4EcWPL13lal0fxkGnmhoaYCsPLkuf9e
         SgFKU3qPovBKinpJ7GNjEX6XHxQ6LyiSs45wV3+ptP3A7jBtbvjeMyXofe1sVK67Bl3a
         qAVw==
X-Gm-Message-State: AOJu0YzIeUif7fdTpRazsXwXt8rSO5p4Vd0J7z30dSUWGgWvZXxXzG3I
	h9BowxVwCU32ag5YlpKE+O+xlTo4Qfd2mizrPKouBoQ0iAWb4QVm
X-Google-Smtp-Source: AGHT+IGl8G25NphIaGjkdOPDrdxNinp2KuTbrXK2BCdMgRX7UvZJ9GaZHluucfU6gWnJB3i7pFbPWg==
X-Received: by 2002:a05:6902:a91:b0:e05:fea8:4c77 with SMTP id 3f1490d57ef6-e1180ee77f1mr12204122276.14.1724137604179;
        Tue, 20 Aug 2024 00:06:44 -0700 (PDT)
Received: from ip-192-168-2-199.vpc-0e1f72b96c0e0c09f.us-pil.omniva.internal (ec2-54-205-243-232.compute-1.amazonaws.com. [54.205.243.232])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fdd8bfdsm50227576d6.19.2024.08.20.00.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 00:06:43 -0700 (PDT)
From: James Lamanna <jlamanna@gmail.com>
To: sam@mendozajonas.com
Cc: linux-kernel@vger.kernel.org,
	James Lamanna <jlamanna@gmail.com>
Subject: [PATCH] ncsi: Support sparse package ids in ncsi_write_package_info
Date: Tue, 20 Aug 2024 07:05:41 +0000
Message-Id: <20240820070541.156601-1-jlamanna@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For platforms with sparse package ids, where package_num < max(package_id)-1,
a check against package_num would prevent the return of package info.

This removes that check as it breaks these platforms and is an incorrect
comparison (package_id vs number of packages).

Invalid package_ids are checked in the following loop, and
-ENODEV is still returned if there are no matches.

Signed-off-by: James Lamanna <jlamanna@gmail.com>
---
 net/ncsi/ncsi-netlink.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/ncsi/ncsi-netlink.c b/net/ncsi/ncsi-netlink.c
index 2f872d064396..62fabcc000c9 100644
--- a/net/ncsi/ncsi-netlink.c
+++ b/net/ncsi/ncsi-netlink.c
@@ -100,11 +100,6 @@ static int ncsi_write_package_info(struct sk_buff *skb,
 	bool found;
 	int rc;
 
-	if (id > ndp->package_num - 1) {
-		netdev_info(ndp->ndev.dev, "NCSI: No package with id %u\n", id);
-		return -ENODEV;
-	}
-
 	found = false;
 	NCSI_FOR_EACH_PACKAGE(ndp, np) {
 		if (np->id != id)
-- 
2.34.1


