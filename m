Return-Path: <linux-kernel+bounces-401677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B729C1DCA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 500EF283786
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E621EABBE;
	Fri,  8 Nov 2024 13:21:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A011E8838
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 13:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731072066; cv=none; b=h1iKBpzT5f5RChMfgKrBsjGcdZuhua8sKBaMS5wal8TMCDBFHbXK8Bjn6glxhlEX8jdlspwOejrJRybMWnk2UDFYJD0wPWYU18YrwTck/7WkFo12GMKTIlBzjmiW5aCXDDbshjI8vcL9bloyAl9b6F2eByssyy0Ft1tsMQZNtpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731072066; c=relaxed/simple;
	bh=+QkkQE8s2Lkl3t5uuwqC7snoepy3oOL4YgaX2SZBGiI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CfzR1FNs3u90kg42zLKr5TTZQ+u7o4A200PxMa8jM3WYIZmtfTxDEmnsccC6bKJOGFzVZ6D6bzQo+cKNlqIvUO46CyEVsSo7s6hvIcki0Q+JrswWzsMqgb8dYcerWsCy/FkeVvSveqq7QR/qGdv/O70bYbhluIkOpecfbqFaunk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6c01d8df2so19750125ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 05:21:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731072064; x=1731676864;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VVfFeWIH7WxRN7UXiSAdVVInogJBslRak8y7/unS4LQ=;
        b=hiHxCj7iuG9VdY9Kx5Jf8X9Chfp2hlk/7lX3XkoIUTOT1YqEXb52hDwSxSu03agt10
         dOWwJmFSkv2uwD7dIYdespAhYqJWc+ZgZCHlOgWkXLo8zBhiSqgxz9Dn9S+2Wz6sacFp
         im0g9CBpCpTHSr+lfv5hYJmLOFjiWppkqG2N9IKTKHsShLiI5xTPMDjFchxxoRbQaY/w
         frDk2y4M/Uj0T7zgbWl2lerBxtSLBpS70cGjU+bh5ToVUEvYZtHFwERtPHV3BW0dT77K
         LWhQSnbvKtw8SMk/BmXIAXjdG++qtdXtuLLZC+YM821xNh29JgREKOwK8pi3i3pdwME2
         qitA==
X-Forwarded-Encrypted: i=1; AJvYcCXNDKFKm/h2lvxdhmg3PWK5tS8KIb7jSuHqqtMC4HFV7VsscYNi2fzbxVTqXv1TuZ7/QM7zlTHH6teq2P8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI6Yu4wyRUHdgDb0/o+di19Li/We2T0QCg8OqpupdlgD9YvL2s
	IyYxgNQHsQ0RESAu31abUqYI5b+9JxNyUvQDvdNfLzVpw3iE8DM2wzh35gPb9hXMy51ylOYZmR+
	dRLzoZgfhV0VFipNDkL3JnrWNEU6DYwnvbXLUBZvVLdhXet6ZLF1wzPM=
X-Google-Smtp-Source: AGHT+IGF7KSWqcyQ4DrtEXliH1vDsVo8eUa9+uqs3C8o3qDtjBATAlZ6KGfP3yET6iFxvRKBf/TXK5MdiScgXucrfISc2RwOySnl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:7308:0:b0:3a6:c6d1:8c4b with SMTP id
 e9e14a558f8ab-3a6f114b1e0mr27473065ab.3.1731072063607; Fri, 08 Nov 2024
 05:21:03 -0800 (PST)
Date: Fri, 08 Nov 2024 05:21:03 -0800
In-Reply-To: <20241108124351.Mp9aX%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672e103f.050a0220.69fce.0015.GAE@google.com>
Subject: Re: [syzbot] [wpan?] [usb?] BUG: corrupted list in ieee802154_if_remove
From: syzbot <syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com
Tested-by: syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com

Tested on:

commit:         906bd684 Merge tag 'spi-fix-v6.12-rc6' of git://git.ke..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=105020c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=347f0ef7656eeb41
dashboard link: https://syzkaller.appspot.com/bug?extid=985f827280dc3a6e7e92
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=158c835f980000

Note: testing is done by a robot and is best-effort only.

