Return-Path: <linux-kernel+bounces-242168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D228F928496
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 877331F22DB2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE6D14A4FF;
	Fri,  5 Jul 2024 09:02:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540A214A4C5
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 09:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720170124; cv=none; b=HSVHmoN8hoHzT369zU6r+urMJPKujeOalKXg7pBYk+wE9mDvDPvpZ6k7CA3/pJZs/dvP79OK/+24ykuGzVF1ChJj6g6jt3PDgykaw8ZAyKHQskP2YPig5OjeyLtFQGcAfchHX59KHhSV9LQkTfVNWMV9LrAI9BN2rbVOggoJ6tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720170124; c=relaxed/simple;
	bh=wwoG6Lpl9xZtxkYIagwDKoYnXMumsgi0K1nZQVQu0qM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JS95RWxNNrk3iO3HGTiXvCNTsSEFIXmTpN/qBrupVQuRwRtFXrz0po0FazhO12/l0hUMpWbzP3LCp8Mc7PUaZOuTpijIhjf8n8slQMQOn8i46Mg+Vu34uMponcUqkEvArDPhfkTA2h2jnuFywLp3x092WBLN+EZF7/pgQBUNgUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f639551768so186808939f.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 02:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720170122; x=1720774922;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qzTl7Q3LR/274B03FBxIgW0YDXP4HwIZSnQeLs9vxpU=;
        b=cBiDYXIu+hVZLbfdi1NWA+aNknUN4EXi5e/WgsVoZlW8MqAMgQEzBDvugKAuL4/O1j
         mbk17nzSeI78PMuUg8PMubyFnUmsKV2frgoFkQWrooh0C4hqGpzoRMbFcR9qLi2JBrq1
         aIA3ecQqGy88rs1IRPP5/074PtqK31WMyLArsEhc/wD2Bs+l6shn4U0GO9YFKsrGEQok
         8R117w0vQl/AiYJxk0DLFdunc1M2G86+vJVK2hLEKOjocClVZFWx8ocfQGVXF/4NDMVi
         3ePWo/AoYY5VW0UTsNvYcivbEwK8QMkrxOVFOb1qUHSL+lgj6fDbNP+s/bZQiG+t46To
         oQ3w==
X-Forwarded-Encrypted: i=1; AJvYcCWzvekvVXznAkJdnMEI7eD6B7Hy9amEM2Io/uzJPeaXJeQj4l8Z5MMR4BODaDhlXEG6Itf5f3NqKEkfiAGMCNo2jnp3QxKgnjV71gK1
X-Gm-Message-State: AOJu0Ywdpyp8WxazsY5JRv69PdY7c2UXU+eJVQGYmfdPH+z4KBHmbrZO
	QggzLHUixs/VLKlNMrmTXF4ArZvS6ZpdXAc+RXuIh1gAV8WqfZgCcZQ9Aj/eaISB8FOAM5zXGwF
	+2+tK0gEDhiwWA+AMSv0GvTW3N4reTkZej4F7VUBqbkeQ5xv71wUHVg4=
X-Google-Smtp-Source: AGHT+IELRk6XZwDyIRgtXLXp8PUm5XnDWTAcvpZglL3K3krXw22STFyjgdwXM5F/iCT0Di5uLC0KOviVojIrTXmCKvbDDKq+GoBZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1650:b0:4c0:8165:c391 with SMTP id
 8926c6da1cb9f-4c08165c540mr39237173.4.1720170122540; Fri, 05 Jul 2024
 02:02:02 -0700 (PDT)
Date: Fri, 05 Jul 2024 02:02:02 -0700
In-Reply-To: <000000000000ce42b9061c54d76a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001b8a1f061c7c512b@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in rate_control_rate_init (3)
From: syzbot <syzbot+9bdc0c5998ab45b05030@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes.berg@intel.com, 
	johannes@sipsolutions.net, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, miriam.rachel.korenblit@intel.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 03ecd745dde181f537bf84374caafb121463136b
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Wed Jun 5 10:57:18 2024 +0000

    wifi: mac80211: fix erroneous errors for STA changes

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16a5cd71980000
start commit:   aa77b1128016 net: dsa: microchip: lan937x: Add error handl..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15a5cd71980000
console output: https://syzkaller.appspot.com/x/log.txt?x=11a5cd71980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5264b58fdff6e881
dashboard link: https://syzkaller.appspot.com/bug?extid=9bdc0c5998ab45b05030
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e4644e980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=108cedc1980000

Reported-by: syzbot+9bdc0c5998ab45b05030@syzkaller.appspotmail.com
Fixes: 03ecd745dde1 ("wifi: mac80211: fix erroneous errors for STA changes")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

