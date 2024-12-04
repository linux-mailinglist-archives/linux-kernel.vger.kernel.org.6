Return-Path: <linux-kernel+bounces-430437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287C69E30DC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 02:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE54DB26089
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 01:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3BB1A296;
	Wed,  4 Dec 2024 01:42:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC99179BF
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 01:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733276524; cv=none; b=Yxwqw34RJN37Ev1bpaRx08h+e6UKnVgifOXakZsH95FRGwq+YKdRBDBgD3rlxhSVk0fR1bK37Kx92NUOsvU+Qu+aQ4whfzuszjyZ0nhUhYbRMo7gviMHLO40B/FE3Ws+YWH5B8d455um0ruYu3VKV2ZI9BlS9fiLehy6vXnplvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733276524; c=relaxed/simple;
	bh=0IQSyeCIZXFVq1c4RZ7ti+MmEOnpVlNEuFUPdQmLSGA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Mul+fhBcl2bIR15j2b7qg06M0eLv1J6AIYwqgNkANEFTacD7XgwgdwmOJG7A6j1fUJq0rzgJxxcSVpq0G6y2wakw8scRdgvQ5Gf9faZCCp38Cs/spZEUbOD/nXu5cGIh42JPS1zf5dQFBk7VKfDX3/RifR8XrePZMBGIE5Ugtx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a77a808c27so73432895ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 17:42:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733276522; x=1733881322;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Dd1h7YPvVbCv8jzdjnPxoBMbhyGc757amvI8/ZS7WI=;
        b=l7xbOch1cZLbV4a58hLMkiphx6T0fSveI2ijswIyrfVdadXfKFZKEPO6zxVgYG8S48
         hOc37KIeEq6EQW4MgMI++APehzJDbRrhAWYM0gIdu8nvZnQms3SejzreF/dWuxnywCVy
         XG8jPkvHh6m8A3RS/cu6TMREvKicw4Mvb7jaYAiP7eZi9oOFoef8wx+akIKG6a8P8/BO
         FpZuhtG0j845m+SBNe9PxxVyCd8tQGqoGycbujTLZYh3PZbQLUKwKVnNQndavobX+xc2
         CB2kq0kksVcjtPXWbsK7lqklYzrNEJn09GXHdHBjGbfJmCRmP6+Sp7/WQVliPre02FJq
         fZyg==
X-Forwarded-Encrypted: i=1; AJvYcCVIrOgE/7rJI9OC/8DPrF+IYy+L2/f4ytp/Pwj3u6S2FGRIp3C6kckdRe2mIWxSo9k7cs4hQdB9bvgCWn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB+be814CyLnNJpKMZqbHEx6oUkTIvX8+Hc9IsKsVrSrZ5fiK+
	fES2H0zX9fjO57HTggfotBWgYdMD1U8A84itdIDvifUCLYJD7UNdMW8h3abKMTQNb+CjwX+z7mS
	mGvxGUc7+xIkLIapoorBTvMbOM/ZOYUWBiiaE0Mf8893IHBxLTg1SE20=
X-Google-Smtp-Source: AGHT+IF8Lbzr5AvQpD3cOoT2tBn7ukWAll9w1pRE5i7BrpDsU2c/i51P5bqx0058EnG3v6yIVkMb2h5ku04osRsCPhacsArv3IeS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a0b:b0:3a7:e047:733f with SMTP id
 e9e14a558f8ab-3a7f9a2a1d3mr62744165ab.1.1733276522327; Tue, 03 Dec 2024
 17:42:02 -0800 (PST)
Date: Tue, 03 Dec 2024 17:42:02 -0800
In-Reply-To: <20241203162849.UmsGp%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674fb36a.050a0220.17bd51.0056.GAE@google.com>
Subject: Re: [syzbot] [f2fs?] KMSAN: uninit-value in f2fs_new_node_page
From: syzbot <syzbot+5141f6db57a2f7614352@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5141f6db57a2f7614352@syzkaller.appspotmail.com
Tested-by: syzbot+5141f6db57a2f7614352@syzkaller.appspotmail.com

Tested on:

commit:         cdd30ebb module: Convert symbol namespace to string li..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11d50de8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=96ee18b6611821ab
dashboard link: https://syzkaller.appspot.com/bug?extid=5141f6db57a2f7614352
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=129bc0f8580000

Note: testing is done by a robot and is best-effort only.

