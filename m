Return-Path: <linux-kernel+bounces-405836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE3C9C57D5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 404222839A7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1B11CD21F;
	Tue, 12 Nov 2024 12:36:01 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D272AF1B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 12:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731414961; cv=none; b=YCz3LpeMZGhks/rSbZryTOeGvprKtXAtrlpBtT4koIasxaCUgF2oMX8n6OKtLH15tTCuY8TeCVXSTYYXn8e5fEBtjYtJNEEzHOSuaXP4giSFR2N3dw9Amxydqt4P3qPvQ8gJLn2f45MPgoICiii2BpperD6Vc/zv+Qhv9VTwpy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731414961; c=relaxed/simple;
	bh=TX6nXkG48NPAUvRTtP+52T9qR769R1a2oi79kkdWE8U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cybhiCx86nWP4sqAveEY5A0DjgErrib7xbCAITf4Y+AGT1U7Bt805XB2F0a31NMWOoHNkqlxCUQIWEMLVyYZ7Mo6UfMNRbIZF3fVWEo6xJd94bMYNFlC1cSV5gOtipdN7ERQGKFhdD3eiB8cFz6dAiJTifqSnk3YNabnMO2QRiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3c72d4ac4so62038335ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 04:35:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731414959; x=1732019759;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xntS/3Wne3S8rhOx2uZtXl5NplE/+EkZHaYPSmCvfC8=;
        b=oJxch1Y4oLcqLhTYn1WlVgDwwNy6rfyxcgnqEDdiE00CaDLXUcdODE4pbaKipe+rYh
         tEjFrlQ9KIM3xSpY8W13jIwnx772EuwmwOsrL1TIfIJUHFWHuuR6+RYM1ywFj+jUYlFI
         Xq/hj+w0F+IUDrATYEH4zDWHX84zex4P/tS/lm9/PR0cdjvtFwZ1yy2/rbRc3CA09d2v
         kX99BmLqoVTBv+DPWYJSz/HJ5AjHtdKFP2fg2Y3joRvUeModdnNq4C5dQGu5GDc1OBNz
         8BuDO129IyaHhHa2flVp6BGUjoqiTGs8i4uAYFo1lELa75RfPZUmZyZAvOYdCqq5SGQk
         jy/w==
X-Gm-Message-State: AOJu0YwG56gw66+kdqUFg2OLM2qipZHvBRar7Jzoq/X/T4++ykvYLMI5
	NL5Me8AZuGJ0oi/gx8ilxDgIcZpd2n51Q2WBj204jjGLKRtZ+iG0w/VRMphkxOMtBJ2okjL5EVz
	WXDTW5KUSwQBc46AM1q4C+LnJJKAcvAkn0Zp2GoASkihLBCXAz4DWafs=
X-Google-Smtp-Source: AGHT+IGYnQvZQCMk9n5Xo8czgabgVuLdt6H3PXSgPFrgzqL46TcUVxLY4sjO6/ilbD1x35BKLl033gvLwpddjcKYYeHpYVubFfJU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca2:b0:3a4:e62b:4dfd with SMTP id
 e9e14a558f8ab-3a70c80ee27mr24098545ab.7.1731414959223; Tue, 12 Nov 2024
 04:35:59 -0800 (PST)
Date: Tue, 12 Nov 2024 04:35:59 -0800
In-Reply-To: <672b9f03.050a0220.350062.0276.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67334baf.050a0220.a0661.041a.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [wpan?] [usb?] BUG: corrupted list in ieee802154_if_remove
From: syzbot <syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [wpan?] [usb?] BUG: corrupted list in ieee802154_if_remove
Author: lizhi.xu@windriver.com

net device has been unregistered, since the rcu grace period it must be run before ieee802154_if_remove

#syz test

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index c0e2da5072be..6f24f1760969 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -684,7 +684,8 @@ void ieee802154_if_remove(struct ieee802154_sub_if_data *sdata)
 	ASSERT_RTNL();
 
 	mutex_lock(&sdata->local->iflist_mtx);
-	list_del_rcu(&sdata->list);
+	if (!list_empty(&sdata->local->interfaces))
+		list_del_rcu(&sdata->list);
 	mutex_unlock(&sdata->local->iflist_mtx);
 
 	synchronize_rcu();

