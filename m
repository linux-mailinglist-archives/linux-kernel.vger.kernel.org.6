Return-Path: <linux-kernel+bounces-342940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87918989503
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 13:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8A811C2175F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 11:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB50C1581EB;
	Sun, 29 Sep 2024 11:17:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B328566A
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 11:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727608625; cv=none; b=RVGyAOp74BjDhHDajDAk+ZiVgp58oN9iYNzHsI/lIpys8kGO0N7IrTZ85aLdwFYVGSkpnB8N4KEMZ0je/tCe8TD6+C61MA6TLSEtMrQgsVvDJ6cva6ednshkdLmp91Z717S87hqs+bYILjEVPJJCanUv7rk++DW+BiGI5mC4DSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727608625; c=relaxed/simple;
	bh=B8CsOq98Sm2WjfXpa/AySzjrdvpdJjFWkf0rA0/qnlI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=H6mdIG4VYbEVOi9yx5j0Lw4CtXHJcA866bwHqpsKQ2iPf/l5SrCaf/judsbGqMKdLYvSM+PBGHVZxEIny9NeolAYMv/1/+a9btXkOwbQE0wzHPUIYK1BgPpBotel7BgdsaytpRvgP1h8Kvwj49TWAKSHMpGLtDUzIjoHLS/Mq3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82ad9fca614so521871639f.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 04:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727608623; x=1728213423;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DDrppj245KSGWP0mAqmK8ZW754NeXqHUPX0tMJRPi8Q=;
        b=nOhos4C2MkKWXMpnQZ5djJGVY0IsCzEQzztqz7QxLHQzMZYEm9ZazPmafOIsh8BCtT
         bRnq8AiVRLJd3XP+YJxBMIdxFCAU1VH0i4E9NtIfiP2JJJ7g1OhEVIrRMi1pkYoY/6Mc
         0CaSzMI2aGvw4Jnx55E6iL/JKXPGsq2tnSGmcHI5hefqAg4RbgenvwwL5bkRphs5y+eD
         ZVegTQecuJVTE040wi0WiQE8Rwil3NWA/ZGS93c2Mfeh2+L3eejIt562t5uF1JSx+yC7
         7HWhabE4+v1EDgkFltHaqWQzNhzSkcP/SzUCKSvLYbEVU4enlEHU/uFsOm2EILQYzw1K
         dvDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZl0Z37RQOfkd6NrkSX2okWBVMJS8PRURhznJ4OZRYbLsqNtrj0xmZt79eFnjoGFgxkc19S4xzXF5SLFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSvr7iEPU0YFkETp+vECahjwh0ZmgGEwNvvTx8q8V9jZUZqtEZ
	jV8dr38X0AZ4RGGiGgXhJzjxJCOzTmQr+L89uRASFXvtd04r0ITGVTLS8Iv5PpNVHXFiTL0JZBK
	0vOe+JCk01aL0eT5vn7Ne+QlbqxD95fnJhNIdUyc5BF8mzBuTBow7zqk=
X-Google-Smtp-Source: AGHT+IE/qH4sYXWiczEV81uXsR/IfrGeLWj+WNZepLZe5DhstnrBt2dsruVVu++ariKv662rf+Oqti7oiDttknv/tj8fnGsAW1DE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188a:b0:3a3:41cf:f594 with SMTP id
 e9e14a558f8ab-3a345172981mr82407405ab.12.1727608623125; Sun, 29 Sep 2024
 04:17:03 -0700 (PDT)
Date: Sun, 29 Sep 2024 04:17:03 -0700
In-Reply-To: <20240929103859.1528-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f9372f.050a0220.aab67.001a.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
From: syzbot <syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
Tested-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com

Tested on:

commit:         61387b8d Merge tag 'for-6.9/dm-vdo' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10ac0ea9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=207dbbbe28068ef0
dashboard link: https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13c40ea9980000

Note: testing is done by a robot and is best-effort only.

