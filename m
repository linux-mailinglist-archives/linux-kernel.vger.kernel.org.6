Return-Path: <linux-kernel+bounces-446939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 022009F2B30
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ED68166005
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 07:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C7B1FF60F;
	Mon, 16 Dec 2024 07:53:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C48433C8
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 07:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734335587; cv=none; b=M3PjdFgQvDG2yoVrN2QD4xCIYZCXGva2OvP6MTVJwscuy4Akpza7/H/q0BZ+OqwhO5iHhodRdqxEsCE1ntYaeCrtiFgGmtDbGhKzibHszBcqBcMjjW7o+AIb60RPJc3oOfHPnOBvo91YJS7djTolOplNPpUnqR56D6Ccsv3ZW80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734335587; c=relaxed/simple;
	bh=w54hLSFKxE5Ar8e0Cj66FprPlXsItKo6HWzpsL93LjQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=m8YUMPMyy5sr3KxwtMcduwm+xx327JdHS79TEqWq/ZEn3+II2kbQ66+9+5CUthvV5oTY6pkclZ1tFtkWHiHHfq0lNnlLfTAlnaMeVytJKISrg7TDlIPMLtqxSW3cYENNzXLKhRO5Vjib+ACB9boWY65ZFceoPptt+UY6JdYW/Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a7e39b48a2so84248955ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 23:53:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734335585; x=1734940385;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bWUFqE+SpM8lm+3qxnZkuLFqP8cGU32BOXiglbOYi2M=;
        b=QtJb1ER6t214c1oYRmPH3dFPps7HmeL8RBjTqZKFdRXP/EJRK/shPwy60KwLVdy3PA
         c9q+vHH8tlC5YzjO8pG4llh+MwMsBLX6cxUIHwvd+q0uR18hTQd/EufDKJm66J2zOzfZ
         TTwQ3C4/YBdFmbRZrEURKNDPfld3ITwdvRoE7O4Z+6yV1rVIv4Nk6RIoxj8BY5kgh0OS
         el9OwowMjVmToO2QSdeUngzHWHL+e34+y9BrarR/rd03Uw/JjuhAagfQMD/1OG/N4VAM
         9p1cmX3GZlKfcottuWQo2lJAiQICKOtTeDuilAjZw0EfkpjWkY0dI8zezUGWSLXH97Q1
         r9zw==
X-Gm-Message-State: AOJu0Yx/BpnSfiAG5t4oyv5ytXkykYdhTiqu7C2nBsTUFmRr6rEFOxgQ
	4y96bcUlW99IUPySMHS1yghf3wFUZRB3N2Ci9RMOlTI6I0CYVbMuYdAYaDRpaRDOEeYd2+4WW6r
	EOXygQsFe9vEeTe1afQfX4U5XCi+RX8FQMk91cJhLgDHgxbjH4xXwHCs=
X-Google-Smtp-Source: AGHT+IEM9PZUY19xBjksEavReGbu+7nrjWPyhitCqJFjkkUECyQELs4QSqJXhsTfRHqi7ulSR9JZvgDnR8Zoml4cHvAm6sfs9BxE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a44:b0:3a3:b5ba:bfba with SMTP id
 e9e14a558f8ab-3aff06828a5mr108096505ab.15.1734335584958; Sun, 15 Dec 2024
 23:53:04 -0800 (PST)
Date: Sun, 15 Dec 2024 23:53:04 -0800
In-Reply-To: <20241216072034.2513188-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675fdc60.050a0220.37aaf.011b.GAE@google.com>
Subject: Re: [syzbot] [tomoyo?] WARNING in tomoyo_write_control
From: syzbot <syzbot+7536f77535e5210a5c76@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7536f77535e5210a5c76@syzkaller.appspotmail.com
Tested-by: syzbot+7536f77535e5210a5c76@syzkaller.appspotmail.com

Tested on:

commit:         78d4f34e Linux 6.13-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14eafcdf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9cac7e24ceea492
dashboard link: https://syzkaller.appspot.com/bug?extid=7536f77535e5210a5c76
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=149947e8580000

Note: testing is done by a robot and is best-effort only.

