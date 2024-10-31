Return-Path: <linux-kernel+bounces-390588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 776F39B7BD7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 14:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD7228235F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95BF19F130;
	Thu, 31 Oct 2024 13:38:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F6D19E7F9
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 13:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730381885; cv=none; b=FfaTKBfVBwMIZOTvOj/DCnutXZ8Rh1TBlaeOiYn3l4ANpMuB8QlirCnAIs6V6JNRgsY5oe/1vNroJp/9lIdu9SwIKq9v4xkFRHK9067euflBV+2WRzGsDERLVw4wWKHQbJyTXnoa2pqLV5muZwyylDDMw89P2TaNWppV2v6W4nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730381885; c=relaxed/simple;
	bh=m8js9PKWrGpGx/94c0m/t/kG4l17mJ472kJ3T9476rQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HHaCC1Gly4T1CCShFaBiFPsxRM1vX6iosneAiLXRl8N6QzePe9+UsLyMrPnP13NEWlmnmgc+JDJnRoWMCCzbmNf5qLr6++pmie4MH5GMUSAh7iknnbe3lF4q7alNKXtcfSagIsXT9mxZPLNHG4Z0A166zjskYzqvyRI1xKt9ErI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a4f3d7d13fso8417715ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 06:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730381882; x=1730986682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2wb21YsWwCYTNPoCuhRPi219SLTEoWZUiwx8XtsEeA=;
        b=TUHzHI2Y9/OzbYA/YXuVI3UzuR04IzCfUUFLTTyxQ3Tzlb5ANC7Rti2ZR0NR1JOvHU
         L5zGIYs4+wxscjQXWCOtC/xpKVbrms/yv9UQPaGV0AwKEgjEgJPU3u/eNPHnh6cZqaOs
         P0+yfxJEl3QOZdo5kEe890V4i8L+K9KYUXau/xqpEoOxrPZNSobvQCWstpOw47bT/c/l
         2r032X/LvfFXxmN8W+skvslsIsUpCRdHIAtFSJOmQJjTrk/8MNKJdW7seDQxObbLWk6x
         xKBnH+dj1s5NxjyGRM6oIz9gPWKplJonKz8Huu1tKLi2VgTi0dc/dz6oHQ0fs6Ec82ql
         uE0w==
X-Forwarded-Encrypted: i=1; AJvYcCUrbJqkaIlknD+6ImgwDGQ7ykzC3vjbi4JfVRM5UesVl3cqmcm8GYfsxYjA9/Jhk0yvG9KUI90YMr8lZTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwixrEmtIp0QYbm+HCpGwPoNf5S+QxudJ3E/tUS0X4g4SnnJvWR
	HxTa5/Q8kMRtk0ZPWpur1h/Ou3oi9agxtNdvVs+vChQyBoz9TMmH7UQU7EFjzsYQ/w+OwzF72Oa
	fkVcjXk/q8PrLqIqwV9dWMU1JX1qLmw7P1kjxuvV6H23nKTwCQ+AzJXc=
X-Google-Smtp-Source: AGHT+IE5AIK7chWjS9Qwruux0+MNbD0t873UJxKTJhPolIL7YKITplTj5kAbNAFrJUQcFTBg6qRbpSHAOE1fNivkZ+r2aqTjy8NZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa8:b0:3a3:f86f:2d0f with SMTP id
 e9e14a558f8ab-3a609a2add2mr39984325ab.3.1730381882619; Thu, 31 Oct 2024
 06:38:02 -0700 (PDT)
Date: Thu, 31 Oct 2024 06:38:02 -0700
In-Reply-To: <000000000000e6432a06046c96a5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6723883a.050a0220.35b515.015f.GAE@google.com>
Subject: Re: [syzbot] [fs] INFO: task hung in __fdget_pos (4)
From: syzbot <syzbot+e245f0516ee625aaa412@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, david@fromorbit.com, 
	djwong@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, llvm@lists.linux.dev, 
	mjguzik@gmail.com, nathan@kernel.org, ndesaulniers@google.com, 
	nogikh@google.com, syzkaller-bugs@googlegroups.com, trix@redhat.com, 
	tytso@mit.edu, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11fc5540580000
start commit:   3b47bc037bd4 Merge tag 'pinctrl-v6.7-2' of git://git.kerne..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c2c74446ab4f0028
dashboard link: https://syzkaller.appspot.com/bug?extid=e245f0516ee625aaa412
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11026e54e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

