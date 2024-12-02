Return-Path: <linux-kernel+bounces-427120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E65229DFCED
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB5122817A5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B921FA168;
	Mon,  2 Dec 2024 09:21:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244F41D6DB5
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 09:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733131264; cv=none; b=iLQlXabJsNSz1fEfCVm7dW/bCQwBFyM+/vUuQI++vxGnEv79KZ+ICIXGz/KkPkmDgJMbEmAyoJg/pWEAGc/Ml5J10CtT9xpGBqfXdbHqlRGR721sbYj1pd4BPGU6kas9Sj0yz6XDAO09MfZWd9NIjKLkH9nlvWI2NW0E60rdWCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733131264; c=relaxed/simple;
	bh=hk3ofQ+VnjPIPSzwtaWBI8J7kJo3EqbGJgxS0h1MBX0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=J22PFIEWswhWBF3NjluBRafKwBhLnM8HPtbY53dVNZ231oFsLgsQRZGOh5hMFkmlfpFZrpzqD7PaPPKndqGSa4LTxrJoM/h6TwxGg08rBGK21nJWv8e+6xOshQX1TQd6mw609e1VjK98BqHU0E90LO1ByY6koWwSQW/2pfw0q68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a77fad574cso35455215ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 01:21:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733131262; x=1733736062;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LzDw8DM1e5JwdgM7B/k/SQNvfZEhgyZklrKtQbYvppI=;
        b=CUyqF4evqn6k+2DUEaOrkveyqMRrUO80SzWOq2sPBqtR6V4rx6sQ1kVK13F9DBzbK9
         1AVchyRnPLAXqafv05S4zH2oQjgkaQNPxGCUkG4+i9zO9Rf7whMPGzlcXSEjZUxRsCQ7
         aT/0kZB+mN5CBfHTYd0CXAticQnNPKQLs07TGeLptVUZvMQyz0VDJD01LoEl56BBuYdG
         WbyYg20NZrQ67Sn0i2TZUt3jwByX39ngkxS1ly+NwnyITH5LR1U2tftDmepevqa7Vran
         N74E9P+dz0L500Z1PfUwe9nxCLL3JBTfw4t15HxSb3r5HXX/yZqiBsYTsdjwfbiCl/jj
         yO9A==
X-Forwarded-Encrypted: i=1; AJvYcCUFBmhEC0gIT/KWlqb3vAMIaummKwPTOVquKetaHRvBBwjMAAI1v54WqSlwTu5qjUMCH3hMqE9kdRN87fg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxaq7WNL0/dhiYTwyJlUr3GM2DR7JUZvHiGreLileAQWt+/YPzj
	4wF9XsfDAPGeRNCiXchYnYh3iQAwcMWQbQiTfeIgTTPbqJ3WJB2gzTY3LMRiE29QUIguKQeeRxF
	IUgp++D6B9wH5wc/vJNfpaKz4jWmwzkjoG7hDuT7TMGAGTKocvtBv+J8=
X-Google-Smtp-Source: AGHT+IEWsdMkgeludZAqK+WS8TKezaDbwJ87IWzZSdckStIIokLa5pxz/hPKqb/PkYoUnJ8SP9fuSeHiStuOex1g3L27yjw+93mV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1569:b0:3a7:c072:c69a with SMTP id
 e9e14a558f8ab-3a7c5524090mr275991275ab.3.1733131262381; Mon, 02 Dec 2024
 01:21:02 -0800 (PST)
Date: Mon, 02 Dec 2024 01:21:02 -0800
In-Reply-To: <20241202090100.qZXuh%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674d7bfe.050a0220.ad585.0049.GAE@google.com>
Subject: Re: [syzbot] [netfs?] kernel BUG in iov_iter_revert (2)
From: syzbot <syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com
Tested-by: syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com

Tested on:

commit:         e70140ba Get rid of 'remove_new' relic from platform d..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16fe50df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=58639d2215ba9a07
dashboard link: https://syzkaller.appspot.com/bug?extid=404b4b745080b6210c6c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=105217c0580000

Note: testing is done by a robot and is best-effort only.

