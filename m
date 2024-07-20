Return-Path: <linux-kernel+bounces-258070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C6E9382E9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 23:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E00E8280F9B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 21:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6C5149007;
	Sat, 20 Jul 2024 21:26:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490EA12B83
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 21:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721510765; cv=none; b=iMlP9ZGQFZC5FK4SWt6aA/mN0vZM6WYaQtVd8CkzOiQqKhmY7zrm77DQPR1HqIQoZdGyU4l1QBhFnzNPP8M5djR5HC4N/SkPfLwH0/XUsVHTPUWbIdWGBKuMq7GzsHdNz+8Vam8Yh0w5dmtNB35RY5MGmVAxI+t4rfCx3A0FNYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721510765; c=relaxed/simple;
	bh=Jh7GbSSzpoLhE0yBdL+yraTkGtSkAMKNhPfifJWuvcc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hVs1cNb1Amxo9QokeSW4RI+Sn/SjAg8RQZ+OtmaQEb4wxlZebhocH+gcNLz3U1HC6ePXb5S/OVRLEglKY2ByRr8b5LRGIhIK+IgdNus6FCVfKyv1s1C/5XX+rzNFxuUCl6SGTD04RDH7uH30cN8W44K6lCr7rGDg5Y3OLHFoM1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8152f0c4837so452409139f.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 14:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721510763; x=1722115563;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rV3Jud4u6ISVkUf57AM/OWGABipbBpR33pvi9L9imf0=;
        b=rvP0VIeU0X42VM+YhKGiMc6riE6lDCnfCNzq+mO7LvGBCOz+Ptk2+ZbwwlhyWOVArY
         OCTj3khD5boSfTDJCgBUTipNGHZYUArZ5I+FsJIOhlqep59awILvf0eIkmxBMjGUH2w0
         cp3G9jMYjW1mXzexu+xH17MzbSmelO73xPkYZ8NXxTWYGvyVWzp7w4ZAKZ/VxZH85Bh1
         JXwESRp25eroCXalbYmX8pxvAfDtwwDpqrqQpAvPfLmq4/Ut6ZgkF4sLkn101qqM0g5h
         VIWFwhDjEPed8rmzRExJSW4VvEOBDgiSZxt7rPcoO1+ZLFM9kLQ4gxv446UF3sFvBwHw
         amxw==
X-Forwarded-Encrypted: i=1; AJvYcCUs2d09FIXFWAJhWmpEHKEY/xHHSc0xRxgVdBt6FV8cJ1hDBorGQ3VqsfMeK2rrzZp7zatg6W4a0zwubSZHulgbzyqx2PVOR6flp35o
X-Gm-Message-State: AOJu0YxgKc7dhE2X72yoG+sZMDyCo2Fpufk5HkI344aRPRlUuLvx9wV9
	KlgWKBOIzeLsgxveNQyeKVC5Pk8oUTc3YS4h96t9A9/qz36RVwuZxB1pwGmnsc6IS7aVOJD/DFq
	Qnm19uODKT6wOORMH9tOMzYHvvRD/LBsCYbq+EhNqsGQf1Iebt/haZIE=
X-Google-Smtp-Source: AGHT+IEQTiMIoVKahfKrJ2z1F12FLyLT6dj7lbMUMrda66T2tEwe1m8+YfPSpErFcBqj+DnHlbRP2XsslOt9r3MXMqKSQntflL1k
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5e:d509:0:b0:808:469:7077 with SMTP id
 ca18e2360f4ac-81aa7638413mr4755039f.3.1721510763376; Sat, 20 Jul 2024
 14:26:03 -0700 (PDT)
Date: Sat, 20 Jul 2024 14:26:03 -0700
In-Reply-To: <000000000000eb54bf061cfd666a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008750c8061db47514@google.com>
Subject: Re: [syzbot] [net?] BUG: sleeping function called from invalid
 context in synchronize_net
From: syzbot <syzbot+9b277e2c2076e2661f61@syzkaller.appspotmail.com>
To: andy@greyhouse.net, davem@davemloft.net, edumazet@google.com, 
	hdanton@sina.com, j.vosburgh@gmail.com, jhs@mojatatu.com, jiri@nvidia.com, 
	jiri@resnulli.us, johannes.berg@intel.com, jv@jvosburgh.net, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit facd15dfd69122042502d99ab8c9f888b48ee994
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Mon Dec 4 20:47:07 2023 +0000

    net: core: synchronize link-watch when carrier is queried

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=116d4a1d980000
start commit:   523b23f0bee3 Add linux-next specific files for 20240710
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=136d4a1d980000
console output: https://syzkaller.appspot.com/x/log.txt?x=156d4a1d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98dd8c4bab5cdce
dashboard link: https://syzkaller.appspot.com/bug?extid=9b277e2c2076e2661f61
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148611e1980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10ec9585980000

Reported-by: syzbot+9b277e2c2076e2661f61@syzkaller.appspotmail.com
Fixes: facd15dfd691 ("net: core: synchronize link-watch when carrier is queried")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

