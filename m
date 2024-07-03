Return-Path: <linux-kernel+bounces-239038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BB4925542
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B26D2284761
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 08:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C6413957B;
	Wed,  3 Jul 2024 08:21:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3139E78C80
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 08:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719994865; cv=none; b=mXj1vLCQCjSLEQVuuEt+T9CD+1DH8w2eW9ST7m0d5/eC6WABRIyN2wjZbP63t5D8H3PR9QnalBYf9q/WS95/EHLgZFGscZA3D8/exn48APfjHr+dpNvueUhzf3nRec11pSf5pVjvT6iHeP6NzXZkifpMOD1mWvOFQ8eBcrikvTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719994865; c=relaxed/simple;
	bh=5EeNLDbaCR0N6NdHgXDj5tI3C4XZ/bbEbRtbUxi5RjY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KiCqYJ+uigqio9hFdtLMQHMfDz0JVLwSkW+jcBbP5O5CFEOLdFpbBVOqpsJxQ78+DoHZeP+KTxaKGxRILEYE7qDOG0aa7BENtLo5DRQtIENX7v4Fd0EdbxRJCogAJ2U14iaZYTNEN71uRGQ9lzHrJKyPByFb9g7jE01N37GZlGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7ec0802fd0dso600739139f.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 01:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719994863; x=1720599663;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uv3JDPq7U0oHg4wZiNOE9tV+9SYe0QJ90WEQ1XWXnag=;
        b=Q1igxIaXRPUgGHVB6Pxrc9XC/BIVyMyuhw1/SSeN4hBt0MH5+NCtM4V8Ib+5CjeAT1
         3/sTe62xcIV8uD/V5G+hQRvfENiT4qaWpGtSd8tuHoXkzpyFtAG5boo6AspY6TS+LXTj
         EzEL8yjN/yuOLAKBN5knXa88nepbJXTCpQAjXXFkA1Sg6wEoNIpKZd3qC/7OmBOdIhRw
         I36P4oL4zAQgg7UlkRq6FjdtdSIlT2cd+Lak6ybgooNTKWrGeKRC67F948aQA+0WYfRg
         F5uyeXrL5rGVJvrDeqkDfW62/kN/W8kPvy5KIK1HAMVpxNwYsrgg9k6Ytx1JZ0kjGfZ8
         Rt2g==
X-Gm-Message-State: AOJu0YxFjxi6Bjb+QRoJkradJgo4kCUdLDH9/i0ztMSSOy+M4Ql44aui
	cfF8lzvVAmU+JJ6SbbU82WaeWGs66MFlEDO1pRQlgP8/lvlEdSlx0kA8+rD/hN0TWOZKi4npLfQ
	p0nGPoN0wgTVfapIfCP8XxscgnGT52HXBhF17pmXB9Uqv9/GKQ8CxMrA=
X-Google-Smtp-Source: AGHT+IFG83GtReZYvKh96dJgml71qunS/pxN7LvL7qe3EwIZu5r78Hnd9U9uopcVqagfOFq5iLMWgr813U8qHuLZ/RE2qialWvZN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c8f:b0:7f6:5c77:ce33 with SMTP id
 ca18e2360f4ac-7f65c77d27amr17086039f.0.1719994863354; Wed, 03 Jul 2024
 01:21:03 -0700 (PDT)
Date: Wed, 03 Jul 2024 01:21:03 -0700
In-Reply-To: <20240703073158.643823-2-radoslaw.zielonek@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d89405061c5382f2@google.com>
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in validate_mm (3)
From: syzbot <syzbot+a941018a091f1a1f9546@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, radoslaw.zielonek@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
SYZFAIL: write(/proc/sys/fs/binfmt_misc/register) failed

2024/07/03 08:20:07 parsed 1 programs
2024/07/03 08:20:07 [FATAL] failed to run ["./syz-executor" "setup" "fault" "binfmt_misc" "usb" "802154" "swap"]: exit status 67
mkdir(/syzcgroup) failed: 17
mount(binfmt_misc) failed: 16
write(/proc/sys/fs/binfmt_misc/register) failed: 17
SYZFAIL: write(/proc/sys/fs/binfmt_misc/register) failed
 (errno 17: File exists)


Tested on:

commit:         dccb07f2 Merge tag 'for-6.9-rc7-tag' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1657d115980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7144b4fe7fbf5900
dashboard link: https://syzkaller.appspot.com/bug?extid=a941018a091f1a1f9546
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10a5a915980000


