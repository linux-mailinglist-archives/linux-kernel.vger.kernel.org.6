Return-Path: <linux-kernel+bounces-316277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 230D096CD68
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99195B24285
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 03:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4109B1487D6;
	Thu,  5 Sep 2024 03:36:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E5613D53F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 03:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725507365; cv=none; b=ohSQuvm72yFTyCYWCrQF9KVb2Tlmfo0EWXJY809+ju1yAI55/cJkvQr4BBdd9yVUbv6bz8Ullji+AEAsGwknL0QfxiNlpwlfAljBIsaY5afXEgC/JV6l3m0mK5/kV5ozZE/6C3gQ18yLvN6Fr23w1sMSLTVKrDw4qDuPpChwnYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725507365; c=relaxed/simple;
	bh=P/knbu6gM/mVmYyFtgTTjMJpSncSbpf1tzvjI6SCLjQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qXZTHshe6bGtGhbe3xWEJrHSLVQ6fQ7uVnv8D9VIoSSmNflmAKAFHVQ6cELxuFEFfhp9gN0WFQYZ7BV1mVRZuQmQxEJD9eMGgq2n7S4ZTUGr7517iW3gR+L45J8SWoaHhYXDXE/C2pWq8OpQxLwBKqNp5KcqdPuwTYWyqUWZZIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82a338f090eso39854339f.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 20:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725507363; x=1726112163;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lWC0ltEAXp0mtaOhR7JjRJQRO63ul804XOUVSx6FfIg=;
        b=ptenK93rN6+z+adFVLRCZzyE8hClf1IkCs8HqHY6VhmVxTJfZiP++P1a3YykoDzULe
         brQNrquQvaHWkTboZc2U+Dtc1egsr68trgsE7fdeOrbAkgJ3xAWV2dASnjt99b0+Rvsg
         NxHh8RhoZ35I8GQQzw8LoyLbrTC1Hy6RMsVjJN2JS90z12ZqMtweaWWxDAXKaz6Cbl8+
         ljQW87NnD5wo40Yl/UcG9+6jf02KweVmU+c0jLz5JZ7w78guv2yPTwlvTbAAlfUosulT
         w3NaXzl1316gjmwbaTXt6/4WtVt61HIHhNCEY+VxH5wWW+lcRYiyRCQjaNlSCA1q4Nan
         dbEA==
X-Forwarded-Encrypted: i=1; AJvYcCWccJO8HX4RhTMNFUkU/l0bTy95JDVAZQsc+opBS8kAOGMk9hR+cTNzxS1yskq+WuRCMUjEARRnkfRKPPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI5XNUtSpOe2Y+Js888XScgC4kthVy0LmYB4Z4+xmwdVpIrqMT
	w6uIzVEnUWFJcxhVTB2pEIpsOBeqKLjTJndh0N5INy8/gtHnLQ5yRd0IuFwM+CCUGLyXYdZP/yx
	tpX9Yk5CEWgtCsatiaMTtt6t2Yf2OxYytAizfil81J6fqCao2CoLwwOE=
X-Google-Smtp-Source: AGHT+IHuggzUQvgjXydkyLrL6SK4jj097SxIfk71LgRrMQGly6nNEvlpsA1RvKpPPJtTZE9P1kXsejCnetaJ2eW5VMvrRssuhHWJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24f:0:b0:397:9426:e7fc with SMTP id
 e9e14a558f8ab-39f40e21b22mr12075555ab.0.1725507363662; Wed, 04 Sep 2024
 20:36:03 -0700 (PDT)
Date: Wed, 04 Sep 2024 20:36:03 -0700
In-Reply-To: <80045cd0-338d-43c5-bea7-378504032006@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000077ff1f062156fd2e@google.com>
Subject: Re: [syzbot] [erofs?] INFO: task hung in z_erofs_runqueue
From: syzbot <syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com>
To: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com
Tested-by: syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com

Tested on:

commit:         e96d8572 erofs: handle overlapped pclusters out of cra..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
console output: https://syzkaller.appspot.com/x/log.txt?x=10d14e8f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=264b71bd0896c2bf
dashboard link: https://syzkaller.appspot.com/bug?extid=4fc98ed414ae63d1ada2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

