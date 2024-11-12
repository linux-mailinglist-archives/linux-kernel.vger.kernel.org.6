Return-Path: <linux-kernel+bounces-405900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 982CF9C5AFA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F1A3B279E7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A1013BAE2;
	Tue, 12 Nov 2024 13:11:50 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCAA70830
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 13:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731417109; cv=none; b=g0uChKjWjzUdRR3PW147iCdNiiGdIjfiTlw/Ysgxw1o10eNFDLBnuCf0c20UKyN0q6sZUO28dgsbdiwLetTxWy1V+hVIIE9exvQ4QCbaaVVAgxzQUqEF+Z2l52axFWaXO2JDMNgDySvzGhfPjifCEtzfH4Oxo9XGgxRH5MMOGAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731417109; c=relaxed/simple;
	bh=2PYHYjLp4KHlBdgADutQ7RkXw8pPJl16GVk4cd7tnBk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cBwVgJzA4/nZv9Mdf3YSW8s3OETsEGwOoDDkSd+FtoV/RjPhE20233MTCdh1NNlxkCNpt2VWamvc8IndR7GXeK78fDhkw3szxX9vtxdWRGQvo/jYqzx9LsllJ8w7kVY07PC34RZSJJVwziacNQhOZa2KO82cCzDGtQ3Ms54ydE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83aecd993faso568873039f.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 05:11:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731417107; x=1732021907;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lk0xfPNXPphQ0nfUKgSqJXWmAOdIT/K1cSorCiPLDfI=;
        b=K2hWTqbBGrVZu/m5M26ZsUTmB0bAdOxQS9XFgvIH69FWJh6yYnoqs0nPwLCp7akftu
         mTg+AkW+Ky0foccUwbnRIG0jnnQ5AZuSQofHS2zVCPl2XoingjVrAa5MwG8VcTPmnVvQ
         Ym1QoJ1f2RKe7VGDocsBwBYjd7OakDvrphxpFyWzOHgCYWLt7cgqrJzd8nyFoIojTr+2
         O7zoPkFmHt+zhuZSctpGRlhqs3tZKHB4w71c4twHNdQboOFFRD3PicAEZc/urkpfKL4D
         /tGCarRAi8ft+PgT2jZQkYHZwTqSFb63R21dNXg460UHob+oBdYDQjpqsue0yW6Hxrpr
         14yw==
X-Gm-Message-State: AOJu0YxNyEEl0IkmC54sMs/taWKezCxWVtSfTpjGBEtuU296tAeuPofK
	a+6y7VH52nhWJqvgFrNtAZGlxAlnddFGlN+dc7wtE+0XFQ2u10oMy2ycc5E88tBkUq/w4lwMVVE
	lf2HE2BGxqOv6jVHFk7IvjfnT0o5wMfH7CJY0sQCGvU/IzldBnBieTbo=
X-Google-Smtp-Source: AGHT+IE7KxGxtUCligeJxEW/9Iw6DW91kLeuX+fiqzie2eqvEG9IE55xEbGbmGYh4KteuTvfDzETd1T1P7LsAgJXq6yYwUCS7vVK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3a85:b0:3a6:abb0:59a0 with SMTP id
 e9e14a558f8ab-3a6f23b7163mr149792335ab.0.1731417107367; Tue, 12 Nov 2024
 05:11:47 -0800 (PST)
Date: Tue, 12 Nov 2024 05:11:47 -0800
In-Reply-To: <672b9f03.050a0220.350062.0276.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67335413.050a0220.a0661.041c.GAE@google.com>
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
index c0e2da5072be..9e4631fade90 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -684,6 +684,10 @@ void ieee802154_if_remove(struct ieee802154_sub_if_data *sdata)
 	ASSERT_RTNL();
 
 	mutex_lock(&sdata->local->iflist_mtx);
+	if (list_empty(&sdata->local->interfaces)) {
+		mutex_unlock(&sdata->local->iflist_mtx);
+		return;
+	}
 	list_del_rcu(&sdata->list);
 	mutex_unlock(&sdata->local->iflist_mtx);
 

