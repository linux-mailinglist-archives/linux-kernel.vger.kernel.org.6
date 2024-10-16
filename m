Return-Path: <linux-kernel+bounces-368276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DFE9A0D8D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81BBE1F24D1A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A494020E000;
	Wed, 16 Oct 2024 15:02:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3C2208D88
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 15:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729090927; cv=none; b=Utheq38Fu/wrNFct+fQdWGUavCTc2p6lansMAbUIpLkqCK7ddufscYHNeWTMVknBuX3CzokGvNK6oEqZF53rUERD+PSSDTx8yex9ssxyJ3CIgJluQcmVnkET0aU7+44LuglXMb5hJgioNs3hovxYU9LW8n2nglo2FbUf3xdIXY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729090927; c=relaxed/simple;
	bh=+KNXnCqiG7faN+ZcgUsLe7oMHjE1md1OEgScr2PZufM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ID5+Ik7Wpf+gI3KyFSlUEtgVPBAIEqv8k4iHV5e1cIfefAZdLbtGOeHKYM1T2aSr3TEHxyWZU+Aibwx6zXGXKuJeI3wQYCHHJLPohrf5jHv1AlarY5908W/DLunTOe8VTnOlsD8LFL4fwTqbqxlhSe4dzBoS/0kiumjM7FrOkr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3b4395dedso56620075ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:02:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729090925; x=1729695725;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jdv73cVXo3QjIFgT/fpIR2pi/lnO1Xr5ZnL+OJ6/H9A=;
        b=mYaxMrWLU5qNX1RSelrfJiWvILu17iyHDF9ZWTSYXgtyyxi3zo2lCr+Zso7Gs6Qfb3
         JVmLY17Tmx0N9cyEM3eO4cTn7XtoqLBRXMa0ykYvlJUZcGgIc27NlCjZuIL+ZIZWtTxx
         fd2YJ+zofVNWbYjRhLwJIPsxeGYc/Wx5Rs98mZTEgPyKTpfqXqIIp3cNWGV2IMgOtYjW
         wABaI5VZS75mcf4LBQYMmESydx79ckeQP8kI248wmvzrDRjSfvh9wpIivmQWlHzQGcKt
         qKaivSp0PL2c+UbXYArMYd5UxS71n7ThTha3HbA7NwWOmFC5GxZiCU6t1aocTevR5p6e
         TfFg==
X-Gm-Message-State: AOJu0Yzcy4w4wjQNukAhr63CPl07zhaxAgxo+Z6l666fD0BgYZ4IUIGj
	V428HYnKl1g2iNH7Jn0ECuSdOfM2Bco3i79WgGqmQ5YZfVCCYZOe3CBcdonWXJYkGX0UO5LNnV+
	+qX+zbCbzx+FyGE+TcEEV5qmE6i7xQcKhkjADLUN1SR/ft/Dh7JVQmlc=
X-Google-Smtp-Source: AGHT+IEmyMNANxH9qx+blsdqc8dzxZexz4DgF3i8l1KJD6Vkb/LaLByK/k0a/A9nm8d24pYZ2PcyGTJzMBlEIBVgt/dQfwr7SVpc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2d:b0:3a0:bb8c:bd0 with SMTP id
 e9e14a558f8ab-3a3b5fa179cmr167369525ab.12.1729090924850; Wed, 16 Oct 2024
 08:02:04 -0700 (PDT)
Date: Wed, 16 Oct 2024 08:02:04 -0700
In-Reply-To: <c1145389-2695-41d9-ac30-f8819c2ff679@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670fd56c.050a0220.d9b66.016d.GAE@google.com>
Subject: Re: [syzbot] [usb?] INFO: task hung in usb_port_suspend
From: syzbot <syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com
Tested-by: syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com

Tested on:

commit:         8e929cb5 Linux 6.12-rc3
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git v6.12-rc3
console output: https://syzkaller.appspot.com/x/log.txt?x=10a8545f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9878fe11046ea2c6
dashboard link: https://syzkaller.appspot.com/bug?extid=f342ea16c9d06d80b585
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12d0545f980000

Note: testing is done by a robot and is best-effort only.

