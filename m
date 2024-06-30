Return-Path: <linux-kernel+bounces-235207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C369391D190
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 14:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 861BC28274B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 12:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C1213DBB7;
	Sun, 30 Jun 2024 12:05:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4645C13CFB8
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 12:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719749106; cv=none; b=dZ7lVY88kZdIwjxMaC/b4xs2pLhDM/GEWuVM1dblorj+vfMo6i1gReevoJygCKZQrkm78j54rSTv0+DPF7GFUlSje9Ao4y+AH34noBOcUQEX69RQGS7ewG8ChXmR3sfAthHvtef13RF3YEqsXSZLrJVXcf2kSfN415m/JBIzNuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719749106; c=relaxed/simple;
	bh=/h1aro0E0DJHiS6ZdDdK+e6Pu8N2VbnMMEqTZPbhweU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iC589CBFKmc3hxc/pnrA4NV9CUxpV7pX/kwbv1Zs/WTWgd3GAi3R5rGD0LuXizZV33KC07K0UpFHrKbQO5Iw1jvDvLShz9S2IcNkImMDz22mN/LAU60jNb0Z/balBA1xNqmv7GxVvIljUT6Q5wdqGNS2uG43w4JcNoYkM21AR1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-37597adfab4so22454475ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 05:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719749104; x=1720353904;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3jew60A5NBZeG8yNPAThYdyEEFX4DU5MGASV0Dzykb0=;
        b=Ahs5zwQuRAXuIrLnu8wjGTq5KZ2CcbcK8HChDrSOwcrgEp2Q28hQlzc/XO+U9b6u8F
         B2Bu98Y01XWSYB14JBlYb7SejFbHe7MZbm6F0AQtzbyTQL041yrl2q18MKRzLSKUaQtd
         DYNqlPDwpTFqoKLZb1rPZhjO5gtA17Doi1+5/jbjD91PU3oB9TJA6zn7mF35T3j7So/Z
         leg1g+NpgFdX0Y5tPkK3X0LNCrb5mtCJRhuUNsVOptbuFWxjqGKbMAeJk5eeDktCbgKt
         Ryqr6Qt1Pmb0FETydyjy9bYiWFCTXDa+37w6bjscrQzIvmAloLvxTVPyJUw2TfVK6QyA
         T5Ew==
X-Forwarded-Encrypted: i=1; AJvYcCWAv2yB7mDfaQkWwNuAplsxIyqO4soRN1HbnrkmXh2pXHIsIrKeCOd34vJBZDgVFY3lHKx9gLO2XbO5Llb3EuD5r8ahUPfJmxyk+Gu8
X-Gm-Message-State: AOJu0Yza0Qps7pNgHY2193oZuVhD4wUxFyWC63zrhD2bVoMh8R7PpRDe
	cD2OybPhhwyH6IzX07UnOQTVjaLHdaN5780izCfRSCuwvEb2urIihdG2MB0ufLzeKpgMWVhYGIO
	wdizgpJNhxC0Wi+0KcRIKnjjX06BY+fCdteY2HrQDGZjZ/nn6Mq9jUFg=
X-Google-Smtp-Source: AGHT+IHu16fGTuGCVa22QymdcP+WTQ/mB3fNdxLDEI0AlXakyOTw66vfHz1ZHKVjjTCT9a9lUgIXDz+TCKg9x7WgQ0N2IbAEw73L
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c7d0:0:b0:375:a3eb:bfb5 with SMTP id
 e9e14a558f8ab-37ccd9c0f36mr982655ab.0.1719749104354; Sun, 30 Jun 2024
 05:05:04 -0700 (PDT)
Date: Sun, 30 Jun 2024 05:05:04 -0700
In-Reply-To: <20240630112657.2567-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000077d66c061c1a4abc@google.com>
Subject: Re: [syzbot] [bcachefs?] INFO: task hung in journal_quiesce
From: syzbot <syzbot+1e1b380ef8d95b36f789@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+1e1b380ef8d95b36f789@syzkaller.appspotmail.com

Tested on:

commit:         8282d5af Merge tag 'nfs-for-6.10-3' of git://git.linux..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=161cf8b9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e40800950091403a
dashboard link: https://syzkaller.appspot.com/bug?extid=1e1b380ef8d95b36f789
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

