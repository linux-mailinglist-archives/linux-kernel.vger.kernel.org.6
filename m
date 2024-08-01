Return-Path: <linux-kernel+bounces-271051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BB49448E1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141ED28326F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278CB170A2A;
	Thu,  1 Aug 2024 09:57:45 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5611F15252D
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 09:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722506264; cv=none; b=gaXGtYYimd75kcshRU2MDwy+WfofCsFvNatD6eUehLBBuOLwDM2KfcQvhDd+4KxVdsz6+MJvJgJrh03QSk9f4YuBPIbHY0hmnz7CdiBHxANIXWugBQM6cyAXnRXPS+zZY+bQgftN7OwhtTP0STO62qCTeQ1+PtyTCeKCdTjro20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722506264; c=relaxed/simple;
	bh=scZ3m8zQZQJbabIKD1ggWyxyuvtO+cmp8BJhhiPB5sU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iSVVhEIMyd5MTcOLxrugvnP3mYV9b0FFQviHI1XwKFHN0xJJaM0g16FXqva2QOhOIJ6g9i5sHyVC0KAvKSnHDpmR3Ns9ih27uE9AsYn2iAZ82oZny4Q0D5WeRRGnMJ2BOIfhI3xbXVGHnKMk5QzXogQfbCtJr1mmnYbBl6m/EeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-397e0efded3so123783375ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 02:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722506262; x=1723111062;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vyc9inRCSlnA58cZmEv5yEkdEGZ7ogSL93LTJV6vBUk=;
        b=XaoBY65C5LGW5h49/5E+hW9/rx8CwZYyIJeJi2UT7Mr1iZuW2WvO7LVrgv0fmMweTp
         vVDvFhavNCHIfH0W409G9ckjeK9A0Y62zssWTzctOpvXnmvUuYeFnZ+h2MbIb5on4ddT
         25PdeSU2+GHH4EE2j/OGHw09FeK7MgL3YxRyZF4g8KU2ttGRlJkUAVVHC56K1PnLFWcO
         212+qxxrWTtKBYP1FlppO/iDUUU8ZO9HJVURTO/XjhryPjxk3LRUIlLd0WGPRYyBGCo3
         CQ9v5BN2A0mVPtXlJx1ffJbL+Y/cOGuW/sNBiCgSH9VkijTSOheqIqfOC3ja1p63WIDX
         Vzyw==
X-Gm-Message-State: AOJu0YzoBpGYcr/+V4zaIu0NPjPxqOaiIVtwiT0u4lKQpDCFSpmlAmzH
	P0MdCWpasNe6HM7NzPLMUUrf9TraD4jzeW73Ohca1vRxtzxyBZYumAYVlLTHLlxeM8O/DnnPXrl
	hqQtc668xOhW62Tjak+hiw3ZN7wAEYOkbmaBJEGx4UNAipftdUx/zY2s=
X-Google-Smtp-Source: AGHT+IGNfvw9NouxYdNlMpRZjadX7KNfPKXBD/Vf5W30AyX6n+tqFj5Td76Vc7hZSnhNeWrW/ftQ3fsqxHGS97O69zaZPa0fqoxd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1785:b0:39a:e91e:38e0 with SMTP id
 e9e14a558f8ab-39b183d6e48mr2118885ab.6.1722506262453; Thu, 01 Aug 2024
 02:57:42 -0700 (PDT)
Date: Thu, 01 Aug 2024 02:57:42 -0700
In-Reply-To: <0000000000004da3b0061808451e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e5b2a9061e9c3dc2@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] possible deadlock in
 team_device_event (3)
From: syzbot <syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [net?] possible deadlock in team_device_event (3)
Author: aha310510@gmail.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 drivers/net/team/team_core.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index ab1935a4aa2c..44c709015007 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -2946,10 +2946,22 @@ static void __team_port_change_port_removed(struct team_port *port)
 static void team_port_change_check(struct team_port *port, bool linkup)
 {
 	struct team *team = port->team;
+	bool flag = true;
 
-	mutex_lock(&team->lock);
+	if (mutex_is_locked(&team->lock)){
+		unsigned owner, curr = (unsigned long)current;
+		owner = atomic_long_read(&team->lock.owner);
+		if (owner != curr)
+			mutex_lock(&team->lock);
+		else
+			flag = false;
+	}
+	else{
+		mutex_lock(&team->lock);
+	}
 	__team_port_change_check(port, linkup);
-	mutex_unlock(&team->lock);
+	if (flag)
+		mutex_unlock(&team->lock);
 }
 
 
--

