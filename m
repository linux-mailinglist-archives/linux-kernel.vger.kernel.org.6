Return-Path: <linux-kernel+bounces-342415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B9D988EB0
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 11:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A568A281F7A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 09:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA88119E962;
	Sat, 28 Sep 2024 09:08:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3914119DFBB
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 09:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727514487; cv=none; b=eX7od1rzD+bW2neC7FgBvBS72xcTWFacZYaURHB+Nw0E+/2HMzeSFL3STMIcbz6VzGt6UhNyNyDalTJyj/k1px6DBiyiF3aRU/lekOpJxijmn0QGzStaNAAIJpP7fKBsLtyQxfGjqHbEs+W6F/mncCJyrS+ef3360VuUNjPMXNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727514487; c=relaxed/simple;
	bh=i6f+ZtTuWVmq3IQd4UJQ0VhGEK782Zvnn6pPAtsRvEY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=e51Hu1ncDXpOMiOXjJ7B8Tpb0zjZefHLCV81s6KCsmhEt2OwIgO4NF+GdAPJ3xANHniBFzrQtfTu0zEJkxM+pb9abVhKkZ9lV1oT2CRqotWIKBID7OdjOAFHZhfG+uLuysGy7K/n4ITSANARErKQmSa9D+66HEdICxO8uVuzydI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a0cd6a028bso30694755ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 02:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727514485; x=1728119285;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jUwF+DOYOWwhUI48FQhB2+d1PUzlxud0cp5BnhMWsNE=;
        b=N1VID2av4reFQZDB34OQrRoVagtmMwkHGCJKXGga7YM2rXOuEskLTWotgsBmFs9HZa
         K+RwWfBuyX3eWDK1BIcStIUZaPz42i8rsiTHMrIPigw8j8s7HV5nu5IOJ6hK1mtuM6Y8
         zfk14M0Rb6nTAz6FzkY7Dpy3g2RorGTe98b8IrgwD39UN3xU+JIqDtdqzW2eDNxNwzuu
         IIe3egUPvepShiAZceBLjCzdjQQ8stS8NQ4Ffe1xQfPShODyI8f6+RMKSqXqC4IyjpnP
         O5r05j/ALF8aYyQsrmaCJSGxn2kf8K2N7hTIBySy8282riz/a9uKM39K12dck9Te07Hg
         aITA==
X-Forwarded-Encrypted: i=1; AJvYcCVzy8qrkVXiKPeWqjc4XeURT6jJCia868zsrKUJ4KazA3Vxtbr+Lpz/5sNkvKkKrtxUu8Gm4eREpxDTAKg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3cEtEHuBLHWxrvo5F4Oz0sG7fXUVB+vjRIxpIU8NqdplkEweh
	Bh+MmTX3dzI57fyZnWNmUavwYVPRsZBA06TY0KRuT407HM25M7AwOw4hXd5rVyD8euu8hhgax/H
	NVzIr0h/RXSDQPpDwGD0mBHPU8c5RoLFlxHJPlorKYfh4zUkpYMOyxts=
X-Google-Smtp-Source: AGHT+IHihBJ+GxY8eg5LzxWABRDhLublPolGwSEBg3jIrc63OS3ihXlj7Rhzorm2uoSOuoHFM7SsSCeUf/6w8BuEXWbwPC8sM9U5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154c:b0:3a1:a3bd:adcc with SMTP id
 e9e14a558f8ab-3a345168f6bmr45212345ab.6.1727514485432; Sat, 28 Sep 2024
 02:08:05 -0700 (PDT)
Date: Sat, 28 Sep 2024 02:08:05 -0700
In-Reply-To: <20240928082205.1318-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f7c775.050a0220.aab67.0000.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
From: syzbot <syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
Tested-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com

Tested on:

commit:         61387b8d Merge tag 'for-6.9/dm-vdo' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15ba0d9f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=207dbbbe28068ef0
dashboard link: https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13651e80580000

Note: testing is done by a robot and is best-effort only.

