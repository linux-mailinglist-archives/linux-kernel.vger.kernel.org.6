Return-Path: <linux-kernel+bounces-412804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B8C9D0F3C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC752B23DE5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2592B194A7C;
	Mon, 18 Nov 2024 11:05:49 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB7F19415E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 11:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731927948; cv=none; b=G6MB8/vas5Dos+RNJJwmB2iIHHbMRWkfZr+tSB4CAIXtqhINzRiMZhz6BkgQh9bmyLb7dHSQ1FksX1WUeTBzx0oDj7Ixa4XyTJ1nEY83qvuUUcW8f4zyPDFu3oHSwMw8F5ZlIi8OssIi7TkCQKN/uG6xNkQvKxw3JVa8QZ0VRWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731927948; c=relaxed/simple;
	bh=RYHZje3x9h9Tdct7seduRTy9T2Yn15HBq+tdRfX/wcc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iufUttcAbqQUOvy4xKRtpWzip2LsuUHlqggEbsZ5IY/I0p6tqxBcJHrDw2D3MAyNlRQBPFEPSproJq9gBWSXHxwXmp4QU5i1z8VnOiOJtXCSJ8MXpz4Mmz9jTGTrw/iXfsxvYrO0W6gSRzYEaEgoGMY+3mY6Dm8Yi5n0uQhtFyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3c4554d29so17209775ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 03:05:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731927946; x=1732532746;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9rqYtyPC3C7HTaxZYhL/Y9bHQwQ4NL5dy/tnDh2J6FU=;
        b=WRQ4SH5i6MQV9R+YpBjVq48ZrotBMAbhLsgXArwcVpJOydRM02F4aF1jioal89WKQL
         cM+D99TJRO4p4ETw/ykvyO48sMd321U/QUHwiCx5cTDtlowG49mxksx6I3Em1G5B5zVM
         zdzUhpaBkTnXAKKNhRgySbtvlu5u3Lw3N6+aodDM4bIeKzU/JuVI0kWouskxvPW3R0gd
         DecCkjSsWOmvO2I0hPb/HRfMGCm7IqVqMf9VJyrkl5UQKW6uz//0TaAXP1L4/6riazVi
         13zoJ6SvGTnxeKbFDQLFnE58LuFXu03tzyGizZbVqzVooDH54WtohwAUtxDeSDjcfbKk
         o67Q==
X-Gm-Message-State: AOJu0YwvdfEDpB6LiuFT4PO749u7Pyn/yedshYg2/keH7T1l2JpA/JFF
	e0sM/27Z4mMe19+ki+v2upksfri0O9iqovm8Zum2PZEcr3Z9i0cgxa3DxkQi1cqTA7fV4ZcMNGH
	AzoKt7Dzz/6Q91IiI74VSZDtrvV9IUElMMZAnu81xc455woi1nSGR/Ho=
X-Google-Smtp-Source: AGHT+IHpHioBuKHK5A14TW/qT0RBdls/d6Y4BdhORy+7Os0//zHiYCvmaHiM6o/4T+vS3HgCODlMBCBo94QouC2GZjO46HLzN/ZQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a0f:b0:3a7:635e:d36f with SMTP id
 e9e14a558f8ab-3a7635ed416mr36435905ab.2.1731927946005; Mon, 18 Nov 2024
 03:05:46 -0800 (PST)
Date: Mon, 18 Nov 2024 03:05:45 -0800
In-Reply-To: <0000000000000fc50405eb48a1be@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673b1f89.050a0220.87769.0033.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [ntfs3?] possible deadlock in ni_fiemap
From: syzbot <syzbot+c300ab283ba3bc072439@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [ntfs3?] possible deadlock in ni_fiemap
Author: jack@suse.cz

On Sun 17-11-24 22:58:02, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=120c0ac0580000
> start commit:   d537ae43f8a1 Merge tag 'gpio-fixes-for-v6.6-rc7' of git://..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=849fe52ba7c6d78a
> dashboard link: https://syzkaller.appspot.com/bug?extid=c300ab283ba3bc072439
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1056076d680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17093269680000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Makes sense.
 
#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

