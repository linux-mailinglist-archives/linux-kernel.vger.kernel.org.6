Return-Path: <linux-kernel+bounces-401180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4309C16F4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20362284176
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 07:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C7F1D12E5;
	Fri,  8 Nov 2024 07:18:27 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517D91D097F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 07:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731050306; cv=none; b=CqqKPR7o5yfdFk7DrGqSe1x3N7q6WQNGSyZ4c/rz6ciQs1yMaoL9httOaJN0T5uNvHurMmkyUhLSjAC7HmLgY1kGKJa33xPV2zxonElVu8W6HAt2Kf1gRnwaQZwVBBoNTc8U1OMkEy5EIbOgyf3LpFMMKX6fJm9BZgLj0YW7yB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731050306; c=relaxed/simple;
	bh=KuSYVvsJ0Wdnzwu1NGHTjSCAbjHfcUTVw3jLDVUqhq8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pSKwrk3zB5uPjBVbFUFLofVdAm24swXOU5FODPRLrJ/YTdEZ7i2C/0woUHiJmfJBv2BmcnpehREM0YzYPePhovLJok2yuvqIpJCEcyAwWw6DGeFLWwL8gS1GVEbTpbSZfZ89vONjqQCQk2sAAu6QfS6RZYSKEqYXkbbzzdwKIyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3e1ef9102so21490415ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 23:18:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731050304; x=1731655104;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hr2QECPoX1IHZifV8F+tUClmS/4lI+mfHpzlghuaylU=;
        b=Gwgf99TLr+Tn5QO9PxkseCRT0Ndo/6FulASYTJ/Cv63xY2ivQFa6I/omCtPpdOP6GW
         ttNTC5TqK31a2oI/V/DO9M/JXzJ76bfNWdte0kLSiqCeqGfwE/rawXV+9xvR1slK6p/4
         tGK1bxCB6/lJw60mSvzF9MhK0aI8aSEn3sJY9MD4G++eJV693+3ucnJq4jAepM+xMIJ4
         SgK6Xab0ya2Q7JZnvLwnut9lbXGPgZ9plt2gBVjb+D3mfsjhM6MUzQSG6QCwNZszNyqG
         KnDVqi9s6lymC5MaxqI0tjrSnsbzUD7WIEkgzAhGsmBjqR13pn8ShqOhoF1SQWq+mvzw
         1EJg==
X-Gm-Message-State: AOJu0Yx31w7rQ46fy2g3HyvA/LIsp/PAJUNuxZiQV0eAf8aETDhky2NN
	QCx5xy2Ac4+RC0pArXXLDFw/RVOW1acnxcePdZSBsXViG/xqrPC41DdPJHehcvhkvb6UVfpal4Z
	M6UlP/JiIar3rvdaB9VZN9x4ne0DUt8qcTrQkjLNXPyvfg+8GRedqH9o=
X-Google-Smtp-Source: AGHT+IEILUv3+1KFzG+u4iU7so4kOD6KrABKvsZ4hvQPNd55qR89sR80pQR4NKfHY5/9MfsYcxNHWewM3yP53G4Pk+JkvNMkxBTT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1789:b0:3a0:a070:b81 with SMTP id
 e9e14a558f8ab-3a6f1a59322mr21439955ab.23.1731050304445; Thu, 07 Nov 2024
 23:18:24 -0800 (PST)
Date: Thu, 07 Nov 2024 23:18:24 -0800
In-Reply-To: <672b9f03.050a0220.350062.0276.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672dbb40.050a0220.15a23d.01ad.GAE@google.com>
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
 
+	if (sdata->dev->reg_state == NETREG_UNREGISTERING)
+		return;
+
 	mutex_lock(&sdata->local->iflist_mtx);
 	list_del_rcu(&sdata->list);
 	mutex_unlock(&sdata->local->iflist_mtx);

