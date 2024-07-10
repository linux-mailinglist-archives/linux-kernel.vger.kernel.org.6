Return-Path: <linux-kernel+bounces-247655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C11EF92D29E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81B0E286B55
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 13:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6404B19306B;
	Wed, 10 Jul 2024 13:20:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAAA192B99
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720617605; cv=none; b=r136emkxX4E187s/yw9I7hDDTltElYAQ1cDmd6V3M9kUXLXsJgGvMfx6K35dhs15GZUHeOGZaoQ399bYu73GvZppA5RX2x97U60S9TwBiaIAE68UqfSKMynaXCdjPqVV7tX2zFSwoulojuPBqKAlTqYzL2a+sXWVqbKRYlFwAbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720617605; c=relaxed/simple;
	bh=UzccWqntR3Rp39PaFijwuBRKjFmhL6iCoFWN2E9ViRQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ubbEtE4ToP/Qawj2kejuKbKyU2mvzNRvdX+W0Zr9xHgVkoP7HjLMJUohuDs1Xw0DzCX4nBTQt1azTUHUGu+/AFCq7VJjFU4LDbfkZn5Z2ArJQ2PdUja80VG2qEZExfjL9mRLxtWo/Xlun2iIhlm8OrTQU2B/yz6Sse32l33VQmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-804825a316bso88449239f.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 06:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720617602; x=1721222402;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XP0E7kJ+vD2pN9mRIYuQjB4ae7HZ2ZJuN60VrPyPFqQ=;
        b=uKqCPokPaRXvuhoAl5ozA8AmE+CNLRMPz6mmTlVZnUqYgsHUuHq1wCqEg9r8wqlXVC
         S7W+DJSD2KzidAg/E66PQmwbHzbO916aOnpMAWCeR7csRtCANlP9eXDIykS4QuysTUlQ
         QPFcNqEPkTwgAD4q9ianRkjn8D53wFvI3UNpqbAenhqH0kYoHe/GLOdVLHXm4Tl5X7bz
         Mxa00nsJQCN6+ImbSnMbiVd+dL+dBQ3F25W+15QKRUycERjCk3zNuU7x7Own1A8vFpHh
         da6zk3rgL3lj4VoOSsE8wG0hK31ZYihIeM/cwuEf/hO/u0a+ysF76XzJIOSC/TCNIklj
         iUbA==
X-Forwarded-Encrypted: i=1; AJvYcCXpIAKjHEEEeASY1hUCuOpJc6S8zG0jCU2MehVERXpvsSAP/WtAMwalK6Yq+3UQxQC79T7ifYx37Cu+v199bqYkEyeY6iaGbx64PLAv
X-Gm-Message-State: AOJu0Yx7r9TY1jTlWlkQcfexMIk5qBqDfx+otFDEoGhKkmMJ8JBYXeH2
	J+tfg5/mUwQLg6JZSSMcT9ITjSn2/VVEerXGaIF0w6+9p/wtN4slJDFKSA7sLAe/JAjyXKfYI4x
	ZqmNy0JtBxLUR/gLIUIZMG9peYrDfAaXXd19tG/0aZfuh9JTSOlH7bjE=
X-Google-Smtp-Source: AGHT+IFQ1Z3Enb7LewbrFTOuyUiyugihGV8hcov9D7Em+4kvS80mREreE8zLRjF8bP71WGTJXobwJ7eSARmydY2yaFBGsJX/ImIG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2709:b0:4c0:9a3e:c263 with SMTP id
 8926c6da1cb9f-4c0b24abdb2mr377357173.0.1720617602680; Wed, 10 Jul 2024
 06:20:02 -0700 (PDT)
Date: Wed, 10 Jul 2024 06:20:02 -0700
In-Reply-To: <20240710125518.1083-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000000991d061ce481a0@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in l2tp_session_delete
From: syzbot <syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com

Tested on:

commit:         185d7211 net: xilinx: axienet: Enable multicast by def..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=143531e1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e78fc116033e0ab7
dashboard link: https://syzkaller.appspot.com/bug?extid=c041b4ce3a6dfd1e63e2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12732b76980000

Note: testing is done by a robot and is best-effort only.

