Return-Path: <linux-kernel+bounces-291342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 059F995610D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 04:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B16AE2816D7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 02:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FDD24B34;
	Mon, 19 Aug 2024 02:22:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093961BC3F
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 02:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724034126; cv=none; b=sgPgCs1GTDELpLHeNn82GR4hIBcmu6I/e6GJHvKoCSFHojFt6WJ7eQdI/jpOdItOahPxaxNFunx8pRu6g8Zm+yamw14tVFjovqmTZ+jWCoeZ8jY0q3sQWvQ4oxHlFZFzOWUon5DBdmCx1GY8WyYQsrvQDyS5/1PMGrb51jpM/Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724034126; c=relaxed/simple;
	bh=O7eYK2xy5MuuE/lM/lRPE1QcoM9vO86MaKObc7xAjLc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Tg4qbBqPUxzQvAK5jT+ZCjQE32ZB1SldagzX3/9rqyLAmk3FeUP4kP+CAWaGxKiqsXj5Y+X6+TABigchFmjt8sH6FUEAzg0cXCTTfGGchYrPExBZAF4/micS3vzMIkLDv6OtiVjsp7ky2wcFbfD5T4ryWskLBWp7P6HIY4+mFJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81d1b92b559so404108039f.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 19:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724034124; x=1724638924;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b1bliJKR9a3PGT860CpcL4kQOfOVTrrGgVMRmAohtas=;
        b=ngVEnhlIC4JJ3aBaCvEXu2lA1kVbUaLdJN9ObRFSTUyQRhjRlajiNhIXtsavKNNFkE
         F6dmofr6MPGk07vXjKGzZTnMETVE8f80EflY8uUCTIF1OZthTwJ4v285VoNbvpFWGFLz
         r+BuTFRSd/kjd94uyk2qZwOHKCkx+XSO6aUQESakCIvzhR4X/z5nRbSjv+awDtHCnIJj
         BP14kCPL5m2Igz9HHVHBkso/6srJjb5L4XmuxiGVTTSELc45zFNH/vbEEyuNGoIvnaNV
         zVkn/ORL2KBZklaeHUCobq0jTmwv4lfmF5MyoqLMMiup8IHjKp7bw6c056f7i88h9jy/
         BSrQ==
X-Gm-Message-State: AOJu0Yy1EyjxNKDhZ2A9N41uD0egoXpVhLM/cMVJiSREU5Z7NrSikPKB
	vRVHYi8FHflhstQdFzJAa5EFyNk7wAYhNjNtS9wANcHHysDsyhm9t6diGT0isp/XOM4QfC7opXA
	0YJ/4Gqp3ihdLfrjUV5J8Qhv+7EuNmueuVO/pKukFuXwxCjSpkA4B760=
X-Google-Smtp-Source: AGHT+IGZkgBsLzXHP/DH3oGTwqIH0BvGmyxBRRQJc/ML1qTQfb/kQoMqwrUpJAvTBHbhbn2XLnW70OW30C/ovJ87wTYXZmOhXFpp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:379f:b0:4bb:624c:5a7f with SMTP id
 8926c6da1cb9f-4cce15bec49mr365735173.1.1724034124074; Sun, 18 Aug 2024
 19:22:04 -0700 (PDT)
Date: Sun, 18 Aug 2024 19:22:04 -0700
In-Reply-To: <20240819020104.2157773-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008be49a061ffff99a@google.com>
Subject: Re: [syzbot] [ocfs2?] WARNING: bad unlock balance in ocfs2_read_blocks
From: syzbot <syzbot+ab134185af9ef88dfed5@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ab134185af9ef88dfed5@syzkaller.appspotmail.com
Tested-by: syzbot+ab134185af9ef88dfed5@syzkaller.appspotmail.com

Tested on:

commit:         c3f2d783 Merge tag 'mm-hotfixes-stable-2024-08-17-19-3..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10a60fcb980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7229118d88b4a71b
dashboard link: https://syzkaller.appspot.com/bug?extid=ab134185af9ef88dfed5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=121f77f3980000

Note: testing is done by a robot and is best-effort only.

