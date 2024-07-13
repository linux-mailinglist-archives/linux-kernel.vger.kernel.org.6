Return-Path: <linux-kernel+bounces-251301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47906930329
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 04:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7630282A90
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 02:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D299511185;
	Sat, 13 Jul 2024 02:01:04 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5753D6B
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 02:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720836064; cv=none; b=a8XVU+lL0vCyvLNs3VEeoRCsT1xhnEc/uXDzxtXJDyY3OlK92TCE/vpVrcPcwBr4KiSQCXF1iJXOJ3bMVhQELpjfRkfHCyZZEN6rKs13a279C7XCQnhMkeIwa+PBLAAPNoyAmv38QvZiPJST/Ry3DEca4Jr8AAjNijTnQNT0cJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720836064; c=relaxed/simple;
	bh=8C7uohOlostzz5+UGk4IYvyLu/D6l2yNBbJdK025D3I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=E8J88Ytw8Ru6oVImIoHj8+2adErVOa4ko6M+x6TYt7pyS3gt161H/7HhFihmX5Inkx0zardny/bp4DmkMMB7361+jYQrBRHi9uqD1HM4Ouqk0ENXZu5+FPtzVVVOE/47sS9RKgfxRKKlhvY4Nb/qaMD+pjbAY4IEFwFMZ1Q0b58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8045e14c387so365518839f.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 19:01:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720836062; x=1721440862;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l3sjybt7XmUoM4lMDfHpYg/1Rda9g3OrqN4nnbEwRRk=;
        b=aBcndEStAsTr8LwO9RGwABQeYZgcTLq/nNCL8iIFGXGitdu/PrbXkBHAJRTdDaaHG4
         GpNfAUkUZ347kUZX+4Z6t3B6nQV0or23ItiP9gTx+kchDcUoGBlGaz+3JxZl4Sh8Cdp2
         gW9qGvBKGuSEV2EwWPyQ3ISMt92xP1niJl9vBLOkneSzoCnQxkvxyPO/vaSOo3VT+F1J
         cIDDYZ13tf+No/wey/jVD2Oag1qhkz7RHonENPuV+oUH/lcCFKYhpqaoQ6ovR6cVeqlq
         ywCk+BQFzObH2xkRut4EVgQvidNAbykUHpj8bcmwLbCZgrAQ98t1vUhiYuHDC/LBK+Rp
         BOsA==
X-Forwarded-Encrypted: i=1; AJvYcCX4eukS4tM4/gImeoF3zMo1+d/msCPNKcooTKqXS7O63ZwYamzN19L/DOAu9gbOwkZTxp2NZsv8gNZg5mZuwm8f3YIXsW+t/qokBWoJ
X-Gm-Message-State: AOJu0Yw50y1sGJPWrIO8kMCKYApN0y1agMLvKV+t3AJwgwwQcTxTphta
	s4WC2qW4f5ioAzh6oFBKZeT2ysrL9zrhGjrzucekoo/3kudJ+roUo5QoB+h/AXSkcDII9wJMga1
	axJANG8WhcQecVNcxFoXmQK6kYqblbFkQ5AzaFaBWR4taa/0YMU7lbrI=
X-Google-Smtp-Source: AGHT+IHXtqLP/hwBvQYYO0+uA2GDJiSe0XwhuawZwGXsidxWMyYRpOsoNTGR7hGKsUO/C1+hUIuu412SIeNP1ut3i9LRcRDLampm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3402:b0:7f6:1e9c:d6f4 with SMTP id
 ca18e2360f4ac-8000435faeamr48154839f.3.1720836062216; Fri, 12 Jul 2024
 19:01:02 -0700 (PDT)
Date: Fri, 12 Jul 2024 19:01:02 -0700
In-Reply-To: <20240713011317.1220-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000349146061d175ed1@google.com>
Subject: Re: [syzbot] [net?] BUG: sleeping function called from invalid
 context in synchronize_net
From: syzbot <syzbot+9b277e2c2076e2661f61@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+9b277e2c2076e2661f61@syzkaller.appspotmail.com

Tested on:

commit:         523b23f0 Add linux-next specific files for 20240710
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10241c2d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98dd8c4bab5cdce
dashboard link: https://syzkaller.appspot.com/bug?extid=9b277e2c2076e2661f61
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15cdcd9e980000

Note: testing is done by a robot and is best-effort only.

