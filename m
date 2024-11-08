Return-Path: <linux-kernel+bounces-401179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBA49C16F3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B52E2840F5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 07:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6EF1D0F6C;
	Fri,  8 Nov 2024 07:17:57 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873461D079E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 07:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731050276; cv=none; b=fOPU8tnDwLq5uUXU5cYlW9OhMLHS+veYYY8Qpcm3+KnegMobqwDRnEaAxoeCENB+jSmKAzQYwgel+kdkUamrw1rXdkGqoeoTloW8XIYTUqMPqd+Aqc+ESgDncjML1TKG0MPli7iOgLexxu+FpymK5g0QZRXS7Nj9M8EQeC96LcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731050276; c=relaxed/simple;
	bh=Hw51lWECmaLzsrwQH+iT9kPgJUt6P0V+Ldcse9MiE18=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tTrgHJ5I3OZe2qTGFz10vzdA1YMVw+8xmDZrOXXA5zo3+B4Zkl5cb5RPdSFGNTUv6BwRPezmDk0fhRuxYaiZILi30dkdGirRcB/SICJgnnnISwvZ7zNzAMTXn/2t7xyCHUrRgvf3edVvJIrc1ZQ1PEtupb2GF62/PuPX+YT15Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a6bce8a678so20020385ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 23:17:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731050274; x=1731655074;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zz78uey3c8FoJS8cjwH+2Ptx2XXqGvRSvSk9BPeqgTM=;
        b=U7+H/skcW0ZXA0TCEXJYoLPhdgNbp330V9J/0Qlf4KIyhTbqyZkkH0UBgFM/M9vczb
         9yTVcuUCVl3GKGYwgP0njn6w4R1ijhrTphKuEj+B2+Iw2s9GYld+6ePvw6dxvMFNLsBB
         aPzal4XVkj5+qSBYjUBorwcLcrxCxQysktzHTkyILWZBUKPl29lv++nxdEnykYsedIpV
         Hw16IZsqiKnqLNpZNiQQlwq8FCxWmKIpIYVbiNmLyL7IGFRvIKoE85pecpMBdhgez0ti
         d97qmowP+tUL1vtID0qUvADzF8uFgH5RQ07DvgSzY71Aszd+scQUykZ+blEbEUotDzsL
         7H0w==
X-Gm-Message-State: AOJu0Yw1KSOGJTtT0CtJLvnzARWbDJVOiFvTaoTd2EfoUj698R0ba0Lw
	C7OdcnMupC/CmjfM/mbXi4U/rA1bfvXHByqRrRAaAr8GftlZDS4yXBij2wbUC6buvsywsPo9IB3
	517RZJbPTD0nyvVY24r/Vt+Fh2/mKAVzcKuKUHnf96bYWQaSju7ExoTA=
X-Google-Smtp-Source: AGHT+IGhmeASIJff7dMg4w6efT/Wg8vyHTWTFxIRfyuwingXGuUvmbmpkV0lA9LvtQgL2qpxubTY7TmdZ+9B4Z19r4EDGdeprNwf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:9b:b0:3a6:aee2:1696 with SMTP id
 e9e14a558f8ab-3a6f1a590aemr24613845ab.21.1731050274721; Thu, 07 Nov 2024
 23:17:54 -0800 (PST)
Date: Thu, 07 Nov 2024 23:17:54 -0800
In-Reply-To: <672b9f03.050a0220.350062.0276.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672dbb22.050a0220.0db4.01c1.GAE@google.com>
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
index c0e2da5072be..7a033e0f82d8 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -683,6 +683,9 @@ void ieee802154_if_remove(struct ieee802154_sub_if_data *sdata)
 {
 	ASSERT_RTNL();
 
+	if (sdata->dev->reg_state == NETREG_REGISTERED)
+		return;
+
 	mutex_lock(&sdata->local->iflist_mtx);
 	list_del_rcu(&sdata->list);
 	mutex_unlock(&sdata->local->iflist_mtx);

