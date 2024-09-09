Return-Path: <linux-kernel+bounces-321588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 381D5971C6E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA7812845AF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634931BA285;
	Mon,  9 Sep 2024 14:25:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978561B81AE
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 14:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725891905; cv=none; b=QtRSUMUSg+f45waXeyDNMhZ9vDrs1bX5ZC/pNr2X/OjDNUlUjHLQROKu43jVtZQLBub1MgEJaNGRFMHcWskLXWn41J4lmVQXKkEIaLpGm7xNyp4yWpeXqlmvOeiryugRSc5HGWpvZlfpaPhzBJftxY30qYSjnyPQR/0SZXuvvnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725891905; c=relaxed/simple;
	bh=rPE2CJB6MJ6ikRid/dP+oarhCWEMgOajniCRdONM9G8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=G3xwVjXuwd/CZZQx+hUCpO49MICJ/OXckNpLYIe7NbTkJLG3TnGWh3DBESn7lWFc9+/pD0ilnfXxD4ISYXqjMZZWoWZbkUChNlvWU77PHnOQMcrT1AkAVZv00Jd3ONU4VehM1XNvCcFI3Pselx1JoVS+M8OvfuKraoikPQMZpF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a04af50632so80474905ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 07:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725891903; x=1726496703;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Adq+B5GBvNNmL/xte6nmG1r6wi3JHJom46G+XwMIsPI=;
        b=wtzqAVhRv1ElwVdBNMQL1V4urzozDuDQXs/OyUwL0v/Mmab14+F7+dJN0XKk1oVZj0
         O70JZqIV4Zuh63VX2fA0Y6WpoTZ156dEYyDzoFcBgl56E8k+R+Jsta7a/j1aMXv35OET
         cdhl0z9rXUrERAEn693HQtdKc3rhoI072t2qZEOA/Ag4vQJYvr4yvNm9Dh7tMCZdYGA1
         +WQt2DCwC+ZnW+Oj33Toyp4XdthhONxrCdGFMd108tFtF0Y4gndCx3uqOmxo7s2Yrivh
         QUG8XkzdaDOLdg5H7+rNpKe3uCKpzz/Kz6oW22aRaqNFbmWrIaqiXsvY1yk61ErL+L3M
         CS1A==
X-Forwarded-Encrypted: i=1; AJvYcCVhE7Lc3sxQcpS/Gk+Yeg961Z8OSrqH9594isB9pvHTS+Vn2DIf/+hPCDB8Emk2/Fwv8muwLP/cA08qwno=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD2mwvMYY7Skk2sjct0A53MyBKEZfi3SPKQqoUmlvyQel26JlP
	kZTzyaiOwnrCTlHH0jlOvd7UcKcXTOgGHft+xd4xZRgO1uu8zWQ6H08FkP8AFYtRBJlUWD/SxLb
	ZrU+Tkmh+Qq+Y/sFuDPKW8SiEog8v5exisskga1kjbhO6I+eERRsaia4=
X-Google-Smtp-Source: AGHT+IHfZIhEnbX3RzUpft5NHwORi99VAh1cCynOj9QNOSAuXc21YCe2a6kjv4CNUI+U7ggDvCfzoucCexLNpTC/oMIieJ0MbyZN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2141:b0:39b:3b8f:d181 with SMTP id
 e9e14a558f8ab-3a04f0cb52dmr132176995ab.16.1725891902626; Mon, 09 Sep 2024
 07:25:02 -0700 (PDT)
Date: Mon, 09 Sep 2024 07:25:02 -0700
In-Reply-To: <2f736900-9642-4824-9e41-e304c250857a@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c6f1ba0621b085a1@google.com>
Subject: Re: [syzbot] [f2fs?] kernel BUG in new_curseg
From: syzbot <syzbot+341e5f32ebafbb46b81c@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+341e5f32ebafbb46b81c@syzkaller.appspotmail.com
Tested-by: syzbot+341e5f32ebafbb46b81c@syzkaller.appspotmail.com

Tested on:

commit:         1d2fe825 f2fs: fix to don't panic system for no free s..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git wip
console output: https://syzkaller.appspot.com/x/log.txt?x=1447849f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9388102cde845084
dashboard link: https://syzkaller.appspot.com/bug?extid=341e5f32ebafbb46b81c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

