Return-Path: <linux-kernel+bounces-327683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BC597799A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 09:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A37A91F26A18
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 07:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4281BC089;
	Fri, 13 Sep 2024 07:27:48 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DE81B9B3E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 07:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726212468; cv=none; b=XmnyJ/bOWhB8roa1cNilztfjNmlDe0C2GhdGVCzoPDUCyshXlg/ERfkgZZQOUZPIgMgEsnGrw/VNVRQUjgXvuNiMKg/BK6CjctIOA4eaSjppecAxBBOguA/A3w5MTQYsQCL7n3V9PWi2jyKcYXmhJauDoMBVWQBwI2ag6BEBnbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726212468; c=relaxed/simple;
	bh=C4gIocm3QWi2fPeIbtwknZXmhIPL9DDJgblP9XfPXAU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RMQFOOdj5LtNCI7+IYlV6gUxporhKJ14qzRP1H4nZAsFlvtozYuCgQ4fNGrugrzUhT98OUkWDjqP8KJVPXHJuI1k4jEsfbVUT8f7mk9ip21cYeI+bz48izieIgsVfUJ4c1bUJuEdiLEq4bwhU9gtSgktVNVhqSPDcl/F4ptdq4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82aa499f938so314515739f.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 00:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726212466; x=1726817266;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4PxJn+UhPuaR3TBKTVzJcybwKeseG8dsygcJO7OPLZw=;
        b=twql2274l2M8eMIrtAm0ffk+t4VRWHI8NQMbkfdY9by+Nrv/zG1gEDl+378Ovu2gI6
         lezEaYyTU1J3uqX/ANBLS6ltZDV8UclqkM1fEaIon8h+XUGQyGbudroswvG2Th984jM8
         OotGXU5i/rsGyof8hoLbFVBsJ/cfNoFfFoFxiZu7DpqzppKHDuhruPWOGbTBHs8Fyq+6
         6WdSzJcG6n8ear3C2Dv/WLmFwNOIX45EVwNX52AzgwD5mI2GrNtVG+jx9P/p1Pg2i/ZQ
         pfHp2cJl5FIYFx7mlHmd/fEG0pwpZQS2uDchtw7HyduNNHb5bYZbDlcpBvRa6ZdkHPfU
         CuFQ==
X-Gm-Message-State: AOJu0Yz+rNQ4dZ1HgsI1jlffGahKc1GPbUV06nwsc7gwpjNBZ4vvNTOk
	sA43ChzuvioPXifD9/pTdy2CL0uueHbGuuEWze7xcmkMG6KmY9q160mkvHWpCYUqV1ItysQnt9C
	aJBZV8ADvpsgMExJh5niiZaEBgYyO4ZX9JYhhtS3jhsJGi3QcVAxYHL0=
X-Google-Smtp-Source: AGHT+IHZnI7itz5kYq3On9nvFbP8yD9YpY8PBXekhclZOErWjQjlFqy3rQfFzDauzQcimjV/ZIEBpCV1WAChryb98LFsYLodXAQI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1565:b0:39f:5783:fbbb with SMTP id
 e9e14a558f8ab-3a084611adamr44928325ab.3.1726212466382; Fri, 13 Sep 2024
 00:27:46 -0700 (PDT)
Date: Fri, 13 Sep 2024 00:27:46 -0700
In-Reply-To: <000000000000d3bf150621d361a7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ddaa900621fb28a2@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] WARNING: refcount bug in ethnl_phy_done
From: syzbot <syzbot+e9ed4e4368d450c8f9db@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [net?] WARNING: refcount bug in ethnl_phy_done
Author: lizhi.xu@windriver.com

Distinguish whether dev is initialized by phy start or phy doit

#syz test

diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
index 4ef7c6e32d10..fe11de6bddab 100644
--- a/net/ethtool/phy.c
+++ b/net/ethtool/phy.c
@@ -13,6 +13,7 @@
 struct phy_req_info {
 	struct ethnl_req_info		base;
 	struct phy_device_node		*pdn;
+	u8 dev_start_doit;
 };
 
 #define PHY_REQINFO(__req_base) \
@@ -157,6 +158,9 @@ int ethnl_phy_doit(struct sk_buff *skb, struct genl_info *info)
 	if (ret < 0)
 		return ret;
 
+	if (req_info.base.dev)
+		req_info.dev_start_doit = 0;
+
 	rtnl_lock();
 
 	ret = ethnl_phy_parse_request(&req_info.base, tb, info->extack);
@@ -223,10 +227,14 @@ int ethnl_phy_start(struct netlink_callback *cb)
 					 false);
 	ctx->ifindex = 0;
 	ctx->phy_index = 0;
+	ctx->phy_req_info->dev_start_doit = 0;
 
 	if (ret)
 		kfree(ctx->phy_req_info);
 
+	if (ctx->phy_req_info->base.dev)
+		ctx->phy_req_info->dev_start_doit = 1;
+
 	return ret;
 }
 
@@ -234,7 +242,7 @@ int ethnl_phy_done(struct netlink_callback *cb)
 {
 	struct ethnl_phy_dump_ctx *ctx = (void *)cb->ctx;
 
-	if (ctx->phy_req_info->base.dev)
+	if (ctx->phy_req_info->base.dev && ctx->phy_req_info->dev_start_doit)
 		ethnl_parse_header_dev_put(&ctx->phy_req_info->base);
 
 	kfree(ctx->phy_req_info);

