Return-Path: <linux-kernel+bounces-272070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F25C1945684
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 05:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CD7D1F238E6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 03:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D99C1C693;
	Fri,  2 Aug 2024 03:07:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2063D68
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 03:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722568025; cv=none; b=L0tPNkLS56KDQQEsj49RR/BRZ0w7te60JwbYOe10Ca2DT5pD+p8dQm9YehoAWwGmBfuPlkPWQReHbUhjSCvj+mvXlosXm3gECsmzAwCdmlYFIJgv/SKesx8dnn5/Mye2HHrJFct0yKuhDM2+2u4CRZzf9pxlOoWTeSqoRQ2gImc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722568025; c=relaxed/simple;
	bh=RUwrqmX0l9GAf+JSly2t6Exxmg2cCBjUJpKh+jB1EBY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hxTo1iAJziQO2tQUkiuhNRMBH0gIoKC3Oreh/cd5ANxmbji9YLX68sF7miJmGHkfb2eqFMUNhRvJHG9vaWqqiZAn+dikUeWfAyNFTkUZ3owQ/igzYueH+6W2M+iV8y3QI9VVDxZXyBV/e4Xhc1GP3V7T9G4fIJ2P7w4LAgbmklc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3962d4671c7so115574435ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 20:07:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722568023; x=1723172823;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6iarpPWqz1ZaUGeRZdSc+yAzZgQx7ljGnTBBS27DHiQ=;
        b=nz354vEcVSGTpP7/rs5NYIn6XPhaMuuAKc1lx48teWsiPOzeaSisk77yLf6WAYrSHr
         8Y17BnRVr2qFBg45BZDNHRZNICro6F0EDypaxDhs7DweT7sUVMuKpIzDl++X08GbKiXl
         L9dU+Te6EgkgZqrljwt7zikKywgGUzQC7SmL6Tz+RNrhwcKHI9IZ3Lg9PEwLv/Eif2Gn
         6nogPjNmaVhd320+uvYW4dDOXB+ExMl7vzTr8j+7fh2bXe0g+vtE2PzzKrPUgR8N4FUW
         JSQwlOCWn771x96Ta1G8ctvy+l42pHyYQaslhzAn6jKsHNle8M/yupt1ZBIBo6w0xLTd
         PzOg==
X-Forwarded-Encrypted: i=1; AJvYcCWp+yFMnFqaAn4C8nzeLxFEHc6JUItooIKXzImqDoMcL9/HatavpcCIXLPZxsy3tE+sxjeP4kzg6b1M/HWoSCRQUq8WWSyytrvHFT1q
X-Gm-Message-State: AOJu0YwRcZe/0BNNyQVpVOKHuTuwxx+1PSZCHKDjhvwhqaFKN83l+8DD
	gjWPCwfcibI9BCH1J56wnHhMN76BQCnkRLBVMWuIq9XcGaNxKcza0Nc8qtFhsCvS7JU+CaK3obV
	e/wq2ZtahTMlB+zxE8K9spl3ekmmS1FOKcmL+QFt2ixGmwea1m22DnU4=
X-Google-Smtp-Source: AGHT+IGHCE9WyYGwJuepC1LY73sOSUteUNZaC1d24A7b8MCTgPGXP204GF+KhW0/7oAgntidPGoXcdSJL20B7OOO+rdLEyGaI0G/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a83:b0:375:a55e:f5fc with SMTP id
 e9e14a558f8ab-39b1fb72b46mr1293145ab.1.1722568023461; Thu, 01 Aug 2024
 20:07:03 -0700 (PDT)
Date: Thu, 01 Aug 2024 20:07:03 -0700
In-Reply-To: <mailman.7002.1716464964.1888.tomoyo-dev-en@lists.osdn.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000023e800061eaa9fea@google.com>
Subject: Re: [syzbot] [tomoyo?] INFO: rcu detected stall in
 security_file_ioctl (8)
From: syzbot <syzbot+67defecaa74f7dd0a5d3@syzkaller.appspotmail.com>
To: edumazet@google.com, jmorris@namei.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	paul@paul-moore.com, penguin-kernel@I-love.SAKURA.ne.jp, 
	penguin-kernel@i-love.sakura.ne.jp, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp, 
	tomoyo-dev-en-owner@lists.osdn.me, tomoyo-dev-en@lists.osdn.me, 
	vladimir.oltean@nxp.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit e634134180885574d1fe7aa162777ba41e7fcd5b
Author: Vladimir Oltean <vladimir.oltean@nxp.com>
Date:   Mon May 27 15:39:54 2024 +0000

    net/sched: taprio: make q->picos_per_byte available to fill_sched_entry()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16a9066d980000
start commit:   0450d2083be6 Merge tag '6.10-rc-smb-fix' of git://git.samb..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=17ffd15f654c98ba
dashboard link: https://syzkaller.appspot.com/bug?extid=67defecaa74f7dd0a5d3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17109b3f180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10bcb2a4980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net/sched: taprio: make q->picos_per_byte available to fill_sched_entry()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

