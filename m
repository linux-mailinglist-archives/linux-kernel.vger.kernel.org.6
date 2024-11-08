Return-Path: <linux-kernel+bounces-401348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E189C1920
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26F05285010
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72E41E009D;
	Fri,  8 Nov 2024 09:31:45 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E612F1C3F01
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 09:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731058305; cv=none; b=FLnlC+YrGQuSeZnwZWHsg7E9hkzrNbG356cULJCwlOAsdLbNQdxhM/ETlnwBe5Zm3EEZyGjqI5kzIFEn5e0ql4ATxT9If9UrY5PloTXdGkwVxf8gwR5kv5DyohYCk5kOEs3Dy/E/KZ6++GCI3MlvkWFlebmiF9GLANchBFzl42w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731058305; c=relaxed/simple;
	bh=f2eZkzt0K6IeztS4Cimx83IL/Xp6H6rm712UcddE51o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bEetUDIx5ymkEJHo49PEdTRsHtjFXslA+0i9GnHR6CgoRt1D9c76LgQqkqtvLO9eeyIXpfSKz/kumBH2oTnnWKlf5VKd57VffUfsykNABMpxy12Dio8+jrpirpN/DhsKKPnDCc+IXVG6l369lwoz+vDQv3sJKNO+FVBHNZLNoW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a6bf539ceaso26508135ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 01:31:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731058303; x=1731663103;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0tcNgegoo6ncsvOFtN0x5NMcojGXD6XLkdx81B1ReZQ=;
        b=SGUX+1fbRlsLK2u6pyvIsWIvm5v5sqGhDDLNkNFau1YbvdqIYZwnFD5XttfmHhlPKR
         WiBY1a7MwE7kQajDsPCtZgamZRKYnPZZ2Q7DoT7WdQXJGjcvrWxNzTW5tUKFusfFkxnI
         vrC3aVKluZxodNcJKAZRjeqozO2MYgePpVzAknePoyIoEIqayIDDwIDUhVYiK7o+2Ums
         scRE7dPT1pkElOunT+T/D0mET7z7BXxwwa7UWFJgt5gavLCHsPFWMQxWX5Va/PuKOFTy
         n0FAUBaukNy3iEnw/kTR0MljYg2lrQ4h+qFEMGLcON3PKsa166WNnOFKWwt3L1SEGV82
         zU0A==
X-Gm-Message-State: AOJu0Yww4A+aSzxzBrvbsPriEpcNFbXoDYW/e644mtAgy7IcaaUk7rQ8
	N16CEur6GDLff67Y4dyHLZRS08gqygGHAYC+TltHAcVSzw8s4r3kbnbSGUobwUeZ1LGEYgL/zc5
	1S+LhDPJfu86fWVWHC8agUCPHLkyUntIYNv64DEI5CpYZ87s8gsxFGW8=
X-Google-Smtp-Source: AGHT+IGNLrX/EWkqnWjv2Bsrj581IIWNc5IJf9AWMY5SxTr2rdAAHweHyFp9YH3tLHbKQbAcy52+0h/i8vYLaWHtJwizX6Ag/vLh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:f94:b0:3a6:aade:5644 with SMTP id
 e9e14a558f8ab-3a6f11698a7mr24058165ab.4.1731058303103; Fri, 08 Nov 2024
 01:31:43 -0800 (PST)
Date: Fri, 08 Nov 2024 01:31:43 -0800
In-Reply-To: <672b9f03.050a0220.350062.0276.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672dda7f.050a0220.3d9cb.000a.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [wpan?] [usb?] BUG: corrupted list in ieee802154_if_remove
From: syzbot <syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [wpan?] [usb?] BUG: corrupted list in ieee802154_if_remove
Author: lizhi.xu@windriver.com

net device has been unregistered ?

#syz test

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index c0e2da5072be..57de7ca7954b 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -683,6 +683,10 @@ void ieee802154_if_remove(struct ieee802154_sub_if_data *sdata)
 {
 	ASSERT_RTNL();
 
+	printk("sd: %p, sdl: %p, dev: %p, %s\n", sdata, sdata->list, sdata->dev, __func__);
+	if (sdata->dev->reg_state == NETREG_UNREGISTERING)
+		return;
+
 	mutex_lock(&sdata->local->iflist_mtx);
 	list_del_rcu(&sdata->list);
 	mutex_unlock(&sdata->local->iflist_mtx);
@@ -697,6 +701,7 @@ void ieee802154_remove_interfaces(struct ieee802154_local *local)
 
 	mutex_lock(&local->iflist_mtx);
 	list_for_each_entry_safe(sdata, tmp, &local->interfaces, list) {
+		printk("sd: %p, sdl: %p, dev: %p, %s\n", sdata, sdata->list, sdata->dev, __func__);
 		list_del(&sdata->list);
 
 		unregister_netdevice(sdata->dev);

