Return-Path: <linux-kernel+bounces-169838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 077CB8BCE67
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6531F22DE5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4C86DCF5;
	Mon,  6 May 2024 12:49:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AF94EB4C
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 12:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714999745; cv=none; b=SVXvTSWj3JOaM2RycxxR7YViYF1md69oaeJkIBhQNCdSRaQoroH0icitwXc1HQAGFlz9wReDrZz/x3Mo09yTikMLcHziiYrSSgf/jzYNB9/3jqFjGeXlxlzyVEA/XaOtk1u0OPzpV1VlIUcZx1czt3Z41w71Q7TQxdnD/udLmig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714999745; c=relaxed/simple;
	bh=VjB2u488WZHw90y1PLR4ye99A/PaYrwu0eueMeEUNeE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nP3NzPuuKO8vPj4bRLrMrljXgEXDc6c/g2LJTXlspcqGCPPbaUsW3YYjtKjxQ8INipcbeMRzAriC+4ypg5IUG8TVmfkad6ZndqZCq5rtQq7FEoGv5DN507lHyDO/rL6JscMgHf3IPE5ewGZIZ7FquXUnp1ahwRG7/nhpTp0L+Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36c5ff9964fso12368425ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 05:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714999743; x=1715604543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s+EhjnU0SNpEiQJuByA7SIjeuS8TgOhozIjm6fqpQVU=;
        b=p9S1+EXraEaVEQHyZfqROjvDIlkpgG97GlEVu8lzP9uKVc6uNFbiNPEx6hT5Jk4lC5
         dV4lbpNbp4LlFuklmOsvkv5d0zm0MUkfvQUzVwHEEdHGIgs6mmvi7SyoFaZoaaH31ITt
         0ZLOszeyrwlWf96bZz4cuIEzmFtzPGLTNTXrvQp05VE4AnqfLKXwHv9G7ZGvXDPY6sDN
         YPW5yy6mcloROnelFT6gSmbPvSYzHdGBOXfn+UW2nU1KktaOGpZyzEnoz+EhDWaEZ3jF
         3Lc/zcLAUwl+yz0boNNTVTXkYr2f+Vz68KdlTea4HvUV17S5H+VYeXCXu0FwkN63Nzd0
         80yA==
X-Forwarded-Encrypted: i=1; AJvYcCW9LLk39tSqeReLO4FunubxDR2OJa7mHxiEDqkFhV7U/m4oAM1khVK3ajv0wBYviJkodw+U5z6uEU7loMPCuQnjWIDqdTmO+nMEiVlX
X-Gm-Message-State: AOJu0YyM7DmBKNuJZmsxD93TNSyxlDQVMkbrMI93q5+mlZamqTnT8QKn
	9UCuRBlTkqU7VDP1fLS7yCM4mUvOEkXenOGyh5shynLwCOjFHNwYnaZOsgXnJYf69FRKCg9Wg1s
	fzReG5BAvTYX+LPdmLqQtrIbzjvCA1woVIX+bFuwOhWriHAiGuVTO+1w=
X-Google-Smtp-Source: AGHT+IHltGYYkCiN4Cume+iOfB70ZXjCZB4due3cfZJySDGbpEs19Pjqkx3h7BHcZlw6BtLOVJg/94mpI8hW4QlSzQon7mG19PkV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170f:b0:36c:88ca:4871 with SMTP id
 u15-20020a056e02170f00b0036c88ca4871mr461452ill.5.1714999743079; Mon, 06 May
 2024 05:49:03 -0700 (PDT)
Date: Mon, 06 May 2024 05:49:03 -0700
In-Reply-To: <tencent_52A96D03A9A44E1779F766C6CB5378436805@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000079f8bd0617c87e7e@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in dtReadFirst
From: syzbot <syzbot+65fa06e29859e41a83f3@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+65fa06e29859e41a83f3@syzkaller.appspotmail.com

Tested on:

commit:         5eb4573e Merge tag 'soc-fixes-6.9-2' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=145680d4980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3d46aa9d7a44f40d
dashboard link: https://syzkaller.appspot.com/bug?extid=65fa06e29859e41a83f3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12c6d86c980000

Note: testing is done by a robot and is best-effort only.

