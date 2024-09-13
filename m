Return-Path: <linux-kernel+bounces-327480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCFC97768B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 03:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 073E7B22DB0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 01:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5D47489;
	Fri, 13 Sep 2024 01:51:58 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309C54A07
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 01:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726192317; cv=none; b=TLh20By0i4VK4lyvlVqRN9q68ZDR+JWdChy2TGZmJikRQ3J6shVzTlKQ5pdtUUG/eJPOBfLmOYEb/kCr9qnmhBePt7IBJ7d8pqZUM+ldqxXYsoNRy1fPXwcoEmoeN9R164KG3nC7WiIpyueKRl6DuBXHy2l/38ecHQo2NSVymK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726192317; c=relaxed/simple;
	bh=wpSaR+gWLgzORCfF93GYnxP0TqNF2Tqq6zmnXuA/rY4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OcqAH6nEiOX1pDYpuW908/RGclWI0l0HKrCii/xdbAYKWDUSFSaCXMcVrmNy94p4fd1i8cGjxCNLHqZoWEEa4QZ9g5jWsq/326IJKWcuH7bP5O+dwoMdtnozInbDdksEBQ1flrF5kzISQOwnttfSC4g7rJwGQcQkQOceYhGztEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82cdc7b7debso176591339f.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 18:51:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726192315; x=1726797115;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A7wu5hOELLqDh4okJLdPiUkga9NV76SG2i2dk/KzIjs=;
        b=ngWmaiZpBf9qsC73dzLqsxGflffopoIkqMlhBusKmHW3ZCF+Y+l1LnIuATf6mrngLJ
         KazeuA7NbRhcfyBmWDqmk2ITbDJQ9p4F8wJhObxQQlBUzkXQ2Zh0O11eaA1XyjnbF8bi
         iLApHyc0wEbAzUVjfmn1ucEb71hEU9YLpdaMOkGhifDIjSR768cF5IsmgN1A7lrUwzz4
         Y1XHXwHnK5SCxC1bVbuVDxlup4puB9BES3xg+yEjg7bd7/B+lwIUEjD5tekmYSnQ0+2z
         k7xxSVvec1iE3amr/Y05DSU/iCYIb1iSYXX0KVEgF95b1T8+EkNUFSHd2hRZ4Z4EKQ7i
         FXnw==
X-Gm-Message-State: AOJu0Yx7TL9FWJaLaqPJsfaTJaD5vkoV0AwyMulAT2wwVm20EovP3RLp
	B4jGEN+Vx7jPAr7XkYwBcCbNnJ8U71jagPkiejykXhGT0RjLRh/FuuUpap6o9HBBoNxAe83rp85
	WWHmngJPgwjh2JsjXKhrrOmSGSQryJoDXTGxYSWv3G80Ga6IZiPhL+8c=
X-Google-Smtp-Source: AGHT+IH0MPBR/0z5eWAuMSepuH0DBfmAB6iSDgbSg8FWTGRxlVdxfA9cLDmvED+FC4V4bdor+WemDFJa3EAeq5k747RXy/tSadSL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4d:b0:39b:3e01:cbd4 with SMTP id
 e9e14a558f8ab-3a0848fb071mr40978415ab.14.1726192315255; Thu, 12 Sep 2024
 18:51:55 -0700 (PDT)
Date: Thu, 12 Sep 2024 18:51:55 -0700
In-Reply-To: <000000000000d3bf150621d361a7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c3ec270621f6773f@google.com>
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
 
+	if (req_info.base.dev && !req_info.dev_start_doit)
+		req_info.dev_start_doit = 2;
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
+	if (ctx->phy_req_info->base.dev && ctx->phy_req_info->dev_start_doit == 1)
 		ethnl_parse_header_dev_put(&ctx->phy_req_info->base);
 
 	kfree(ctx->phy_req_info);

