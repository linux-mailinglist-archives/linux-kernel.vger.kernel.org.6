Return-Path: <linux-kernel+bounces-443706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 268209EFADE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 336EE1637EB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2987A22332E;
	Thu, 12 Dec 2024 18:26:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD8F20ADD9
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734027964; cv=none; b=H7YlBikWegMaQEOFE+zOz59+UydtBF+UN4rpTA4ZX8Fr4pQ/OcjrQVLjG9biwtvi0UYH5N75N/Sn+6eIywVRWUWQIe4yM/yHgB8aBarpXlCluNAEjpQvu82wbZTXTqLf6ku6+Lw+p9aDwtCzfZr2HN2pNoy0IJ6DcZXztLJrSPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734027964; c=relaxed/simple;
	bh=XyuFjvp6r8PXeA4I0Pntfh8Y0Qo8ho8/scw5bsXH1Uc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JtkdVCa8clNcyq5XoHv5MnHowgrFaDt5yUuP3hY5QIJrhG0VRhU8Y1IvqQbHPn5FGV7KgtfLB70mq8Zg7a4Bh2OkS5/5ZvEh1/t9fX3o2LO9zlLHKWO/alYxNs5E1+uOX2tqCdOO+wfWAfjlVuNhN3NIhnggTvZ6VfnMLbURas8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a81570ea43so8181505ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:26:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734027962; x=1734632762;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sW+/lDTC0b8UZh2dxjnr8friPvPYb7EmJIjIeSxBdFA=;
        b=eUimfFENg06Xs4gfeOf6Phkz6YcZwcCwjwtxou0//Izf4fLKDkDzQxA4MieMWjy12y
         9lqpEkKHIwt5+bjdU8xUWedYw4p+E3GqDjrFwfr8UZWmDxCiCmyBPWN4jiW6mzctXGlf
         ssbBpuKGthr3N1mKYgiFYa8Rak0a4hiyY0yrvtBXh/jJcCnShKq6qTGDl7/VudogXfUx
         ZSU8fMEhx3Fv6jdPdwZ7FkH31a7DjCZNmwXGa0cZP0yOOp09dEejSEVah9rE+RZ4V/Tr
         32xktw3XuptOKF9s0AlFr8QvWHW/A6FqD6dqy3h4WZgj5wmPdUoSg+nvbCNe+qB3XX+2
         dytw==
X-Forwarded-Encrypted: i=1; AJvYcCW/FpPfFx6c7FDQRAfHEE0EJmvNhkCYSRmi8srzJXX/aTHPLm5NSq7V13r5XxHUncFvc1fSq5LYqCo3iTA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+VhZb2ZYAvgYLfToNhp/X22Re3kVB+phAx93WfKJEaalXuF42
	+QBMGtZfMWLb+fODbnjOL6813dshVWAy+czgFcbQhYMinX8yIxf0ryEb79qw14Z6DDtmCFO9Vy8
	50VqFB/2uRS474hJQG8Ic25E6+DqdVSMl3+dRwREf6BlrRxPSX/p9en0=
X-Google-Smtp-Source: AGHT+IExY+GpZhT4LY1EAoJc7FTkyW3lNRAXHgLAc83yB9ShBLWnBx/N0DdUllYOBN1IAvLkPGD6gu0VyXN0oTXaovqXjCyzOagt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160a:b0:3a7:8270:4050 with SMTP id
 e9e14a558f8ab-3ae57c14773mr12942005ab.18.1734027962569; Thu, 12 Dec 2024
 10:26:02 -0800 (PST)
Date: Thu, 12 Dec 2024 10:26:02 -0800
In-Reply-To: <2863838.1734026244@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675b2aba.050a0220.599f4.00b8.GAE@google.com>
Subject: Re: [syzbot] [net?] [afs?] WARNING in rxrpc_send_data
From: syzbot <syzbot+ff11be94dfcd7a5af8da@syzkaller.appspotmail.com>
To: davem@davemloft.net, dhowells@redhat.com, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-afs@lists.infradead.org, 
	linux-kernel@vger.kernel.org, marc.dionne@auristor.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ff11be94dfcd7a5af8da@syzkaller.appspotmail.com
Tested-by: syzbot+ff11be94dfcd7a5af8da@syzkaller.appspotmail.com

Tested on:

commit:         f3674384 Merge branch 'net-smc-two-features-for-smc-r'
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=13a34d44580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1362a5aee630ff34
dashboard link: https://syzkaller.appspot.com/bug?extid=ff11be94dfcd7a5af8da
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=169d4d44580000

Note: testing is done by a robot and is best-effort only.

