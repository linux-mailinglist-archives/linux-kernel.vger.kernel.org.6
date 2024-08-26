Return-Path: <linux-kernel+bounces-301454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B63395F11D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26ECBB23F71
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212F8187FEA;
	Mon, 26 Aug 2024 12:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BD2LqgiU"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3AA172798
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 12:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724674491; cv=none; b=b7X9v9SjpdTW2UAm++M5O535Ne8AwXqtUdzn0Pa52J+KMIxTIYWKvMHTUIjWLRyU5K9pypgQ3D1KAOQRZeU8xXD4iRzGnSLp4SXaX+JB1T1mHM7tNG3n9PzVE6e4N16qMaH/ws/vu272TntD4BDq6DDiGbMcJraDm1QUBRIo+Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724674491; c=relaxed/simple;
	bh=PMAG5/gig7pArsoHvKL9Qukbrnz+b5ucBC4N3vJCw+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IqEOWdw3kXKZcsF9geUz7uhNCYUZ//xobVsOqz7jDnNgqVYsxOYdWEfTYYPAJejoR6OxMux1IdU10l/lLF51o09Tys6aFhYrINuTK5Gi3UhyChMg6e2EOkJhX8GA+7B1LT4xI5v47DH2RUg2eOb5BQ6T41q/ka+USBmztm60ktk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BD2LqgiU; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7142e4dddbfso3163715b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 05:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724674489; x=1725279289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N+LVdNryLjaGNN9ifDLmqexf/yv699MnrXI0tyPkCAA=;
        b=BD2LqgiUihXEVvQC8EhE/L+EdciRGfPEAfusUk0+xn04PbRRu5HvqtcpOOk4JY5RbW
         d8QRq7lkoEtI+6o6w9wl+YBOGUtS/J4ifx6VdpafDZYWbrY7C5TeJ+truQ+qO4QB52wy
         UJpsSktxkfaR3gR872FY+eSB2ZsdQuJeDvK1C2gaczr2HnnT596mOcGV9VsgVMZkA07v
         acBmK41z9nMTRwuRqk1M1lgff7RvLcynJOhaZhQjuISeQRFs01UExLQaeXnCgEdvulWM
         Ty5+489jXIUXczBKK4rxftLFV6z0j6/l/6/3ETxyk4hc9UedF6flOiHw2HA22uvwaolI
         PxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724674489; x=1725279289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N+LVdNryLjaGNN9ifDLmqexf/yv699MnrXI0tyPkCAA=;
        b=aSdjtIj35xyVrV9bjDREhGs+lXuFD6T05JILHIHNJwT3fO5EiGUQ+/3UyUkbM7ukll
         IBzZUXoRajKUJJg/B0UjFU/SSoLilqZ8Z8+euGpR7hDv5L2PXvjuiBmvJSKjljG8aOSx
         R9m3oTTAfW/c8DZnGe01hd/4FTa4DHxv9zmxryefO0Od9CbSWZnX50Gjpi3kdKPPL8bd
         ODDhAe7rQo+Aa/nadqrbrJTlKkBe9UVc6zF3li8mxwM0ULxTiKg+NNq/y5k7kxEf2UE4
         9aMWU2Qe+nbgtjENCsFjv5zAuD0tFiaWbJ6htGFFe3Unm1bC43SI+UF8feARRY0MNAfZ
         5ObQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuycDgQOrvVknv14vLhJXs83gXlSPiwPCVErb7fZT94pnXBnuwcErlEsfNSRbjFsrz1zeZgpmRUDHPSeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrIgSLtTNEeCzADML3yLqOfNrjFop24sieYEz543j2YF19JXRB
	dckpAxSNbzsuccLWmGz8WlMd+1fES4PxnM7DSCd86sQA/P5fe/R9
X-Google-Smtp-Source: AGHT+IGc4PtoBRWIabtZHT9NxlK06f5B+sPItVc6GiqKe1Pfr2RkH2u11V87N7o4qEv3ihUMf95H1A==
X-Received: by 2002:a05:6a00:2342:b0:706:284f:6a68 with SMTP id d2e1a72fcca58-71445e0e3a7mr9382632b3a.23.1724674488984;
        Mon, 26 Aug 2024 05:14:48 -0700 (PDT)
Received: from diogo-jahchan-ASUS-TUF-Gaming-A15-FA507RM-FA507RM.. ([200.4.98.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714342e10bfsm6862652b3a.121.2024.08.26.05.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 05:14:48 -0700 (PDT)
From: Diogo Jahchan Koike <djahchankoike@gmail.com>
To: davem@davemloft.net
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	andrew@lunn.ch,
	christophe.leroy@csgroup.eu,
	linux@treblig.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	syzkaller-bugs@googlegroups.com,
	Diogo Jahchan Koike <djahchankoike@gmail.com>,
	syzbot+c641161e97237326ea74@syzkaller.appspotmail.com
Subject: [PATCH] net: fix unreleased lock in ethnl_act_cable_test
Date: Mon, 26 Aug 2024 09:14:15 -0300
Message-ID: <20240826121435.88756-1-djahchankoike@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fix an unreleased lock in out_dev_put path and substitute
both labels (out_rtnl and out_dev_put) for a simpler out.

Reported-by: syzbot+c641161e97237326ea74@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c641161e97237326ea74
Fixes: 3688ff3077d3 ("net: ethtool: cable-test: Target the command to the requested PHY")
Signed-off-by: Diogo Jahchan Koike <djahchankoike@gmail.com>
---
 net/ethtool/cabletest.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/ethtool/cabletest.c b/net/ethtool/cabletest.c
index 01db8f394869..c1f0510eb465 100644
--- a/net/ethtool/cabletest.c
+++ b/net/ethtool/cabletest.c
@@ -77,18 +77,18 @@ int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info)
 				      info->extack);
 	if (IS_ERR_OR_NULL(phydev)) {
 		ret = -EOPNOTSUPP;
-		goto out_dev_put;
+		goto out;
 	}
 
 	ops = ethtool_phy_ops;
 	if (!ops || !ops->start_cable_test) {
 		ret = -EOPNOTSUPP;
-		goto out_rtnl;
+		goto out;
 	}
 
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
-		goto out_rtnl;
+		goto out;
 
 	ret = ops->start_cable_test(phydev, info->extack);
 
@@ -97,9 +97,8 @@ int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info)
 	if (!ret)
 		ethnl_cable_test_started(phydev, ETHTOOL_MSG_CABLE_TEST_NTF);
 
-out_rtnl:
+out:
 	rtnl_unlock();
-out_dev_put:
 	ethnl_parse_header_dev_put(&req_info);
 	return ret;
 }
-- 
2.43.0


