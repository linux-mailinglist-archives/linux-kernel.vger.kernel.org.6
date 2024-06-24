Return-Path: <linux-kernel+bounces-227206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B57914A39
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8325E1C2325A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 12:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577D01386DA;
	Mon, 24 Jun 2024 12:36:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768AD1E4AE
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 12:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719232564; cv=none; b=hJLUSLAqfbR20k8ZhaPQd+TwbVFy3tCabBGMSvBfSaAwsPkBoFaCJoYsQ7EIQK3ko4fbOD1b6vY2DIBoaExClYHFTRIypH0poQn9uU/0+DStKfAvfcDgQyACgQ+OC67oBnDqCw1czOVJ7M8EBf3Vui+YkUvp63XgyBCJlB+QKs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719232564; c=relaxed/simple;
	bh=iqIDiClByuVqkBA4g51VBdbPav7grUag4ByQdoYOMzc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kHUwzXguZmd0qCduMDdwruAVKWV15DFIOMyGl3lansIYCCOFwmR9OWt0hf1ANOmzjjCbty/8zGNkINfv/RcztYrUJI0vt51lrF7uVdhTcEhwEDJT+JDUGyAvxDnK+yqo4/qLKYH6uHXja7ueLPzl6j3NsblJue6dix4zdHVSggA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-376147797ddso57030425ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 05:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719232562; x=1719837362;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p0B/Ki26fhKoJG5UxZ8ax7yW7hmTYMampc0XRPoYdhc=;
        b=PpQUv3Ham6d3MpBfn2Cgb+egF6UN/YpyNFDNket9oxlUxA88aZYiqTsmiu3k+IqnbW
         xCd8BO+ZcdnUYyI2N0V6nhxy/8wlvVfF4roEh3tvA+7HLrxSQjRPeSmkrjv9tMqSTslH
         HNg07Hp/+Aqrt7NEXsvFdp5usutZuFiSZyhUgmvVrRDoJ1ylYywmD1UN0S6C0/uZXEQ2
         z1m/JdB7ME80lqd/JVyYs5LjJ1MVkOMDZx7oRLt9uCKer1C4xdg9HnMwWh0u2toGG+mE
         +10XdqgYRCPO1u3Z5xLGdTYEs1isc06lQ0acxgOyOBFUsPhRWH9JCkuAzSRSGgyNciGy
         b8ag==
X-Forwarded-Encrypted: i=1; AJvYcCXlKDYuX4VT0ghi+ISi8nNjAiDNGXZ5ly+OcvNwLjO8EGXJlo4QjUYgEZk23Ww/kvpv17FW+2zUhcTrr7klYGjgveGDiaF76r4DO24C
X-Gm-Message-State: AOJu0YxYHNxV15h/p4uVkZwXCz5AoswCz6Vca/0njnUxZaSn0aIsvpG9
	JYNlkfMpsfcd0ZXIP5t1J7gGuVLAAwQiSG+CvPFI93QebJH0IOy3TLLiJY68fmkj/Jt3g7nVuWa
	mYkv/OfzVwV+qvb0hJTXtytGydDaCl7D3BcbCo+szGwsJYeNgUgd3paw=
X-Google-Smtp-Source: AGHT+IEOlH6X7pBiqm6Csc25ROy8EIXw1ZS+3R89Der6tmBGpkeFvoP2bdnLdr0p7VA/tFBPID+UCFnwU4RDKdUouE+Fjmtcj+l+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d1a:b0:374:9a34:a16 with SMTP id
 e9e14a558f8ab-3763f73cb2amr4586405ab.5.1719232562440; Mon, 24 Jun 2024
 05:36:02 -0700 (PDT)
Date: Mon, 24 Jun 2024 05:36:02 -0700
In-Reply-To: <tencent_86BE4A6A74B1761566A83D5B36EC969C3609@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002bc49c061ba20634@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: invalid-free in hci_req_sync_complete
From: syzbot <syzbot+35ebc808442df6420eae@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+35ebc808442df6420eae@syzkaller.appspotmail.com

Tested on:

commit:         2ccbdf43 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=165c91b6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8786f381e62940f
dashboard link: https://syzkaller.appspot.com/bug?extid=35ebc808442df6420eae
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12d47071980000

Note: testing is done by a robot and is best-effort only.

