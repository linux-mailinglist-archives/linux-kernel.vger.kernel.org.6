Return-Path: <linux-kernel+bounces-399001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 702539BF921
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 23:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20F4A2822BF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 22:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B39B20CCF2;
	Wed,  6 Nov 2024 22:19:08 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9631620C008
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 22:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730931548; cv=none; b=j7V96sc2dprG0bWfIhGe7H6z+mayvDU58hFpHV07PZN9Ah4XfMqTXvA7L7XXW8ByHjh5rzUQ68xvi3zzxMEVt6ZonySmNhmqD5VhJz4UZocinw0//J1UmiHPp9iKeyiacEzUPkEVu0fwMK6GW3YUuYtpmidlgCxES3YKxXvU7ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730931548; c=relaxed/simple;
	bh=+gR57EeKwbw0Kwz6JIBh8JtZeP2pTiNAeaE8mY7cdLw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Sxi3LOP9/ncqA+DVNf6MzdcDmN3V2M5Don7dQkFVrUnCkYvlVDf39I/zFWZnagTYZlYbafdJ8yQI2z8KUcDOZD8rtgrNUA8VZJToV9MSln0xRXJYYVOfex15atGCzErkgELK+/3lU+MyEEJ5CBvhzzOTnaMgaKEfJvLHK+Rp8Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a6b9f3239dso4875285ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 14:19:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730931546; x=1731536346;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ko45KvLVsjg/SK8Ct5743fIEU/Eg1iBnoARTt6ua45s=;
        b=KhqNBDxmmHj3a5IGrWBzXa0VmpYKIjiKDrVYAbvRWFK9XvZHVz+unRFfYOTSQSR0LF
         HMuyZUdVlNkI1gupwxlJZA+H68c6L6qgm7xRWA7O1I3hCbAdWQKrBAXMBut4UhlvALOU
         5VKqhFVb/mFKnla1O9LyiQvkMsiYyFUF4kIQBjQilPzIKumr8G4uF+yZYqApBKTX/WtJ
         H7915DOGd/ykMWH9sx7NkzllJi0m0j2rufEqiCAqWKTc0fO10FZ6XaiDks/n1whF8mhE
         sCfxLmMOX7FVL8ah3tLDxsGpStp0aifF3VQZik7VJYTHEfz5+uLWaMVb0t1z+XsLyUd5
         EqoA==
X-Forwarded-Encrypted: i=1; AJvYcCX11kOg2eAlLlLIBZZEQu1DIV7cJuuUbGoAL6ByRTPS6BrPG8M3yj98gzuv8ng21ZaQmhn4WwUeO8h1fqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAWc+zErQeU60e0r57IZHkhHOcTl3sxNLDNlKA1sxXaO3JBqhY
	lzvSpJ+vC4wxcM54M1XLbNMPTios74RwFZcfrc+PmABsYoGp+P5/KmmLfx/a5pZaI7mRV4eRhzv
	7MDDXSBuKWwmO1jmM5QmmMWAn8axMst9AOaem8nIZxIL3m4R5qgstU6E=
X-Google-Smtp-Source: AGHT+IGPQH134goapcSY9eT7NLw6Ji7rELvx0NPPbitKv/F44WvkYOx798kePlkHETZ9gxFEXBaI83nx6N4GYR6QJDZ+E7jq1KF7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a48:b0:3a6:ad61:8006 with SMTP id
 e9e14a558f8ab-3a6b034b0edmr214369125ab.15.1730931545807; Wed, 06 Nov 2024
 14:19:05 -0800 (PST)
Date: Wed, 06 Nov 2024 14:19:05 -0800
In-Reply-To: <CANn89iJptb2gackja+KocyPYwf855EgZM34GSO3km4Z8tcwq1w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672beb59.050a0220.350062.027d.GAE@google.com>
Subject: Re: [syzbot] [net?] KMSAN: kernel-infoleak in __skb_datagram_iter (4)
From: syzbot <syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file include/uapi/linux/tc_act/tc_connmark.h
patch: **** malformed patch at line 11: diff --git a/include/uapi/linux/tc_act/tc_ife.h




Tested on:

commit:         f43b1569 Merge tag 'keys-next-6.12-rc7' of git://git.k..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fdf74cce377223b
dashboard link: https://syzkaller.appspot.com/bug?extid=0c85cae3350b7d486aee
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14119f40580000


