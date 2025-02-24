Return-Path: <linux-kernel+bounces-528932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B29EFA41E26
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00B7A42223F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989B024EF71;
	Mon, 24 Feb 2025 11:47:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999E624E4C3
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 11:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740397624; cv=none; b=m8bY08uA0GLkuwhe5h6Wfh1n9NDEUtMmJcPxCVr4eZmB2M4F0DaLSM3eNUurwMG4QvIXt1HZjLXqjWmU4PyKV/XFpXOtuZ33HPwu6pdT/I/k9E6U4d+Z1NkVnrmfJp2+ienkaHzNWuK5CegqJhNcDlWfMTK106+4ZEpWXJqpkiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740397624; c=relaxed/simple;
	bh=qMhJD93MB6m7F5/vhHS2rH6fbc59lopqI8m/DU0ZTuw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VFH/tDZatBG0vNaVnk8kOwtTt8GMETN/zVLfAM+5GJKGl6UtxSPuacivKB8x4iqNdyOZ3ueu2Ya+KI0Ida6OO1ffYVlup+48uCg6QFBo7saYVgtbr2TNmvjol0S4vL94C1BwwTfvDaA8sz+WEy/okcaROi9h+SzgginoQTEsdGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3cf64584097so39295155ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 03:47:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740397621; x=1741002421;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8vBnvyWUTLRdnh20gtkioj3OHULe3DHLQR21kaA1xAU=;
        b=G07cn7vux2HZD0BbxM/5w2u/IrokfNGbicS4caGVeeMnVGFoLIRxH3pKs3/27DN4o/
         swFBaJuP1M3KazeyQ2L02RckKT7p3oG72YPimbZ4/QvFKIWOEGiP2BkEGiQJiW2HMKjX
         nud6Bp3E6G4rJxhYOKHL5MK95XtY4zjNIAs+5RJgpFHBLonC2LsHEx0WKIKuhuIN5myz
         I7T6Rt1sysIXSz25sqLwT1AjnoDKdeMeMuyUstdA4NBaiReN12AE5aXDK3KP+x3F3Gy2
         xQd/9hf6z9s89W7CGlGPx94h5U17pTFO7I0oujL4znERJZ3b2TLoHElyNqnJeMglTvj8
         0d7w==
X-Forwarded-Encrypted: i=1; AJvYcCV75ehVUjsB+/qvpb0EwHCvUaYGCCMCkG3BIO8yC0FTe1mOAvHMUHZtXLCfrj++Sgx6P3WfEUI0Qvh8VLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP0DZL9CN3hF37nLTZQopjV6mMYah3AhnSp3cnyPEK5ziHY6ky
	g9MmMGGZs0e9ViQ/ZPGtDAGy612uAd2ZOYz3h7Al0XwInw+fUBSXzn0Ksgdp443rHGJLglEXxOI
	IZhFGX+gGMOF1wxiD9HLRoAQAu4AROCjRA1xja6KzevhQw3G/0jty8Tc=
X-Google-Smtp-Source: AGHT+IHxSHAqVsY2FQpH7PVXIJLyI1Hr4kiReE1jBdlnuisC2Ne3uSdGSkYhQDg+mQy5fwO33/qdAHiKfnD87GP4ogymBgl3Qmh7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170e:b0:3a7:87f2:b010 with SMTP id
 e9e14a558f8ab-3d2cae46bbcmr129782735ab.5.1740397621704; Mon, 24 Feb 2025
 03:47:01 -0800 (PST)
Date: Mon, 24 Feb 2025 03:47:01 -0800
In-Reply-To: <20250224104114.2781-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bc5c35.050a0220.bbfd1.0082.GAE@google.com>
Subject: Re: [syzbot] [input?] [usb?] KASAN: slab-use-after-free Read in steam_input_open
From: syzbot <syzbot+0154da2d403396b2bd59@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0154da2d403396b2bd59@syzkaller.appspotmail.com
Tested-by: syzbot+0154da2d403396b2bd59@syzkaller.appspotmail.com

Tested on:

commit:         d082ecbc Linux 6.14-rc4
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=164046e4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df3b9ace9c853c8d
dashboard link: https://syzkaller.appspot.com/bug?extid=0154da2d403396b2bd59
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=114b2db0580000

Note: testing is done by a robot and is best-effort only.

