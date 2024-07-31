Return-Path: <linux-kernel+bounces-269265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B381942FF7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21BED1F2A58F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541071B0123;
	Wed, 31 Jul 2024 13:20:21 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D56A2233B
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722432020; cv=none; b=XHNZ/hl9jWgXxUrndKSMvPsl5znRDOZO8qBvyMYcN63t4Zj7r43uY31A/XKGTgNPvxffv3pUQ1LDnd9iIL0Rhd3zvcvZdHI95Pq3OVgz5JN1plwQm/oD5aYxfAlOTQanMEO91EuuMkWOMTZYPDeAJkYecV9CbZ+oJ5F6GB6LD48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722432020; c=relaxed/simple;
	bh=Yyk3RfgdYHJ6/dUApLu4twHH63rg2J5cdTUwqR9dwy0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=h3rNY5S0KchSOauMcsnBTlyJqvUKYP5gXRO1j/cegldXCD1euUOI13aBpPQyHrMWnvaWpnMSIqA87/rxoNRVlUvbCzXOxI5VbTCopWxjfYyG6YNqYrn10RnBAo6gjnaBRoI2aDO507Wi3jUM8q6nMoWqZml6Kj/YwfAgUOCOSWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-396c41de481so98475415ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 06:20:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722432018; x=1723036818;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CVHsxBOVR08fxxsU3c3HYsh8nIvqInLcXaNGPl3TN98=;
        b=i+uge0D9Sxuu2N0Hoi2D6RbuSD+c9d/Fi65ciSZjfi9M8ix790AOhX9WAKvGIg9iuU
         CzYwKQXC5Jb988RMPrSKG1RqTwcLUYc7f9p61GO+GkCe0oLvuNOUcgYowdmh6mOM/Lu3
         Dqyhj5tHVLz3Xxb3qt+cnXaxlwtzZnsnWpo92zfPDV07/3LETW3XBzxxqs2e91saTiyV
         T2VM8bMNzO7kanjSQZON48MWHsC/teHs6tHNrANQ6vY1qMIjL/fH3wF3WmHAT7xaw1c9
         rah5e6O9Up8pvWRrjMyfVN/JTaZO4kfRawg2WBshmXHc3TJ3kvDfsxgH0St33ipmFQKC
         i0Iw==
X-Gm-Message-State: AOJu0Ywt6Zefn0SqTMTYYmOOSi1sXVsYgeZYq4V2vjh83KaRK70mq6Jl
	bvThxOM+evdp8vIjKaFtypI+djAvTbcJqvEDmmbQRKyZ0ynZVVYh+hv5PQlOFBmjmauwCA2cRhU
	8wAsHaYQE7X9+27deRhcXaPf2TbaFM8J+tjnd888Bp6DmJoLSyKhfDwM=
X-Google-Smtp-Source: AGHT+IHaCwZ7Hd7NScP3NUy8rosK31lt1vdOjiXOfq8rPQ2c1JQdsXcK+Kq/VtJmYBp5HaGSh/AgLMsGZcb8jaWduQWJ8ypMt94w
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c8e:b0:397:9426:e7fc with SMTP id
 e9e14a558f8ab-39aec256983mr11380605ab.0.1722432018689; Wed, 31 Jul 2024
 06:20:18 -0700 (PDT)
Date: Wed, 31 Jul 2024 06:20:18 -0700
In-Reply-To: <0000000000004da3b0061808451e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009fc0ae061e8af445@google.com>
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
 net/core/rtnetlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 87e67194f240..dc9f9c4dcb49 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2903,7 +2903,7 @@ static int do_setlink(const struct sk_buff *skb,
 			goto errout;
 	}
 
-	if (tb[IFLA_MASTER]) {
+	if (tb[IFLA_MASTER] && !(dev->flags & IFF_UP)) {
 		err = do_set_master(dev, nla_get_u32(tb[IFLA_MASTER]), extack);
 		if (err)
 			goto errout;
--

