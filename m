Return-Path: <linux-kernel+bounces-222082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AE490FC9A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 734B0B21B3D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 06:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12ED2D05D;
	Thu, 20 Jun 2024 06:16:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB51C368
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 06:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718864165; cv=none; b=gLUSNvSRBhyg9++2GM8tkUGrcIk5rMA554UIpw+ak1cDbstLdfgQJAkY8ySK8/NfSpuypdYjyqAXxFnLhP+oJcNJT+JwIxvRG2ae+ygrk87ndI+341HCrSY5s8FlTVuOMd0yzYQ3iWXqTHKR3wyjwpaO5fh7eR37vZFHUDMiulY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718864165; c=relaxed/simple;
	bh=kNMQz9T7fIcSX+LiMHe9FHdHy1kFTypEU6F0wYpWGLc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=h34q9jJRTCMzZ6tkA1caaYghX2wNkKiqMttQ7YpF4IqsCzvHLSNl06J1cWW0znHyf0/QF9J49aPXxot7PqF9lcc1WrHksVTYvy8Mgr0AV+l9k40TlJwxWV3lAPKiA9zufMSP3WshqocG7zlhMPli7xO1sJkJi+JDKWYwMdpLQDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-374b2adee08so14793965ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 23:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718864163; x=1719468963;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z8764yuJbvNUEMryvKz5yvNM4195TRiAWbRuOnvDInk=;
        b=eP+F/ZmaoePf6f2unbpz5AUx3CPj82nv83DQmdc2fqlCnfiuBuOf7gdeDuF8Si1DiP
         XwJ3P9VEC/iOIv+CtvuF2sSVE9WniiSC+0bww83wNm45BkCu2fs1HoDDqOrDQ7zgc9DB
         aCWZmwysf9KMeQecUYNgaAQG4/c8fzc2roBBsm3Al/lLVVZOczuBklFowbQuv0Kj3ayx
         iAjodI+Sz1fH5B8jyPWp4i/lIewzRDFrgwF7grXDgL5k3E8vHCuZKaSN5zazed3GLflR
         XIrOowW2r6AaHsHIqsy1d39X+oYD+BKudvwMIbXPyD7+CiIjE283eJerZqDd0pfTyKTE
         t7Sg==
X-Gm-Message-State: AOJu0YzASw/76o6paJTI+I2G4qVHgJ2T8FDFdOc+Xi4fZzsMHXzdyhh9
	JNfYmj/emClVIZzBo/kwbEXPN4sNB3nBbBi/UNiZg/Wk6j75SSSI3Nyw0PGrLQWKNywdsZEtkQO
	LcnHpCHqsWQ726NHkJEslgwbDrf96oTwkSxVYc8+F/6znL4FEZ0M4wU4=
X-Google-Smtp-Source: AGHT+IExaBpMDq3dOZgoz2mmYPKq52hANmCErqQV6wBeGgIkhIDRZ4zsGt+TM7XX5sDusrC70INN84lP1klx9MibO+c+0M0qgwKO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d452:0:b0:375:e559:476a with SMTP id
 e9e14a558f8ab-3760936c225mr1343585ab.0.1718864163151; Wed, 19 Jun 2024
 23:16:03 -0700 (PDT)
Date: Wed, 19 Jun 2024 23:16:03 -0700
In-Reply-To: <PN2PR01MB4891F4EFEAE9CD9E25BBAA6DFCC82@PN2PR01MB4891.INDPRD01.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dcb17f061b4c3fff@google.com>
Subject: Re: [syzbot] [net?] [bpf?] KMSAN: uninit-value in sock_hash_delete_elem
From: syzbot <syzbot+c33bff5d5da1391df027@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	wojciech.gladysz@infogain.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://linux.googlesource.com/linux/kernel/git/torvalds/linux on commit 0daa6e5ed1ccdeb65e07d4884961a8bb288a0f54: failed to run ["git" "checkout" "0daa6e5ed1ccdeb65e07d4884961a8bb288a0f54"]: exit status 128
fatal: Cannot switch branch to a non-commit '0daa6e5ed1ccdeb65e07d4884961a8bb288a0f54'



Tested on:

commit:         [unknown 
git tree:       https://linux.googlesource.com/linux/kernel/git/torvalds/linux 0daa6e5ed1ccdeb65e07d4884961a8bb288a0f54
kernel config:  https://syzkaller.appspot.com/x/.config?x=13e7da432565d94c
dashboard link: https://syzkaller.appspot.com/bug?extid=c33bff5d5da1391df027
compiler:       

Note: no patches were applied.

