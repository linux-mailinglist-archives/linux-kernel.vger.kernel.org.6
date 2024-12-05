Return-Path: <linux-kernel+bounces-432844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0109E50F9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64D38167A4A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E63F1D5174;
	Thu,  5 Dec 2024 09:13:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887ED17B506
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733389985; cv=none; b=JTyiKnJILoKup/Ocjz7NK/msugMl69DEXEZsZqzA8KcR3bvyf3Es3+/LahYvWWdEhNrUHGGdvhqWGNEmxwC4FgXeVqihpjMamj72+iZkKZmX+70YZ2h5acR/5Xwa0RLkfpqTAksJ1nvrnNINJ1IAIuvBLjhkZ7O8N0vUXVtV/DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733389985; c=relaxed/simple;
	bh=CxD6dz7Kr2pAKJ6gXm95f9/VgivohVVqbkBsfqK3fpw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=D93+70HQKWZzhVtNC5z28Hb92YeQBpsV7ZmElswCjgB89bum7wjX3e6lpY2kA04NwkmN9K5oqfyMA/CoTKNySVbe893D2YOkDjy3HrsRaXRwbJTXlyYyIHVy+A1xuoq0wNl795NUIvaoWttGEGHAn93yc2uzAk2gOWAn/h7G4PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a7e0d5899bso13278175ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 01:13:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733389983; x=1733994783;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h/2llX/QyNZ7BYaI/Wpbyp8WlvVMIdkh3Io3SBK+8z4=;
        b=KWCoC+GUsJSGrqRW59c+Ao+fbRM21uL5/vl5oSvEMYvzHTijnNE1sOPS0iObISoLkh
         zO/bDFoYFR/79bJwEHP45lnUjSKj9zugI/Zb4V7yA1Z4oUFmzduIt6UtBo7EFH6wKfDn
         Qzj+PWOfqRNEhcN1Y6p1PKzIEv+6NdgA1ANj84WA2CCdcyVw3SDkoV52ikNFjJKIdA4n
         R/qnEDDdbykQpS7ry+HIi7xXOuHW+dJGWioWLMDtpEEPs0TRazyMyHeOOosaTKFsF0a/
         7eVieRmCHy1XN5aaoZVTIyzzyO5Kzx04uT08K7W6aPe05KrqKHXjXnFk1BiqheKm5GIb
         p6Bw==
X-Forwarded-Encrypted: i=1; AJvYcCX2myv5JRQmcC4G3eoeM4mj2f5yLSGYMM52BaOofUu5DUFXXhKgdYSyG+G8z7PV5XV+cSkcLL/BOng5joI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMXGgQxhW1ovyJi6L6KFtXbiSS9lXuTb3mRdOY2T6EF0pqHNCT
	43//rddXODfJTo5UBpnyTM5xC3LO8+dqV1bw6pmqW9plccqCWJ6bDMkPxPGAIoY7WHUG5vbw99G
	ZDedolzgjbCMfcqzhOL+4QkOb2fk4mPSqsiELSzio2MtnzCDsKFUQKOo=
X-Google-Smtp-Source: AGHT+IH5OMkDLOaBRQRTUieL6hNFIQlMc6T1t3IOAmfLA5nXD7aY0KWtw4vFG7k1cV6AV0LYTcTGXFmhRbtuKEYuU5thimMX6J0Q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:198a:b0:3a7:dd62:e954 with SMTP id
 e9e14a558f8ab-3a7feac1fe7mr72716615ab.0.1733389982814; Thu, 05 Dec 2024
 01:13:02 -0800 (PST)
Date: Thu, 05 Dec 2024 01:13:02 -0800
In-Reply-To: <de7743c9-1fd1-4dc3-9ed4-31c32a9118eb@kylinos.cn>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67516e9e.050a0220.17bd51.0094.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in mgmt_remove_adv_monitor_sync
From: syzbot <syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com>
To: 6751189a.050a0220.17bd51.0084.gae@google.com, linux-kernel@vger.kernel.org, 
	mazin@getstate.dev, syzkaller-bugs@googlegroups.com, xiaopei01@kylinos.cn
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/bluetooth/mgmt.c
patch: **** unexpected end of file in patch



Tested on:

commit:         4615855e Merge branch '100GbE' of git://git.kernel.org..
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=3891b550f14aea0f
dashboard link: https://syzkaller.appspot.com/bug?extid=479aff51bb361ef5aa18
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1368640f980000


