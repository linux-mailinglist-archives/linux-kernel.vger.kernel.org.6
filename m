Return-Path: <linux-kernel+bounces-380905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D46129AF79A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 04:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BCEE1F22B1B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 02:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD3B18BBBE;
	Fri, 25 Oct 2024 02:44:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84B418BB9A
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 02:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729824247; cv=none; b=sOR3vA//ZxDHw9nEjGVrJQLU+AZqADHMJXSGs9oeFiMxJABGhyDKnKTtB2sWFgIpYnl8el5O2KytglpqNWywyALr6s3RbpFh4rt41mV2ySwxdrilnsHwlTPesA6k0PdXyoi3LeqiU+jaDNh8TnAHo3ygrgFGBkA9qjSAY8vPejI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729824247; c=relaxed/simple;
	bh=809b/Pdx9nZs4k99B4LNprT67d7N88aPd1zEAnaWSeM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=i3ZkhlDRnuuGoAsf+PwI3osBnOo/z95a1zJyq5y01ai7rNi93keCbM7FijTSiTZ6lHLmjkDVdaaf5JQgUydGe0Cc6GbTz6QvjEfqwq+rg6iWO/QoFE1JdQ5LQX2YzdE5gOw6jdO2gve18LfBqfj9oEzj3tD3B/FVSEf0+YNH71Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c9886eccso13830575ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 19:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729824244; x=1730429044;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rf1NB7CaiBqSkY3iCUMsw6mB4tHAKpKKf4qb08+kcVg=;
        b=eQa0YhOyADvaQrnSGiOGYopai/gNvkK+QyPdMiO1nMKVGnbkk0wBv2HLKZkyq3NZtm
         5rB3eh1eHjxZEoEvuZ2/bxdvcGji6purShJq4vc7mz//Xra0zUmIe18zh6oMYmrWdoiQ
         7AmmSHOzRzXb0gTWvrZdA7fyqvYJTw82pcIf2VwddWhGXKL+Kh3CWIdrDAdlNXAIgV5M
         HJ0TFgOficyb3zE9YHsn730NFGdcbjug2EdXybomU/o8hSe/uADjqKjEaWakHx979+TS
         4Gv8KuboeIqmcyChZJY8/QAusr+s+TfIbXWSdh6iMXTWiOquZ3i26NaNMELBDiJIctAO
         96IA==
X-Forwarded-Encrypted: i=1; AJvYcCUjWy/5RIgboRV34lMon3C11Ks/5gF6bpzmVF7ZmwcxYAhKpf9Wp8HBXuOQz1XOhlFg/J1MVLeCZ4qeD2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHK5JAAncStbegY0nhS+1bCruulVULb73GAghlRx2EFSU2cX0g
	mJCQGn15+uXO5FxThzWz2r96yLc8TuhDgAI3Zm/ZjxUCeliMUBJ35qHlLbInz56yA1aLVQMLk2E
	yzSWRVjg6+2ILp5pcBeHw+iXAidDU973glXKFkaarI6FQsS9fqr9Iq9U=
X-Google-Smtp-Source: AGHT+IF9vK7j9JaMv5meiucavo9afosGlNIjCvwwNTF/nwEV2vRqnoIc01V0snq23E6oX1pVIh37G7/2zYKHOOfDteVjrArRaevR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1569:b0:3a0:a070:b81 with SMTP id
 e9e14a558f8ab-3a4d59df6c9mr99235555ab.23.1729824243965; Thu, 24 Oct 2024
 19:44:03 -0700 (PDT)
Date: Thu, 24 Oct 2024 19:44:03 -0700
In-Reply-To: <20241025022348.1255662-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671b05f3.050a0220.381c35.0008.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] general protection fault in btrfs_search_slot
From: syzbot <syzbot+3030e17bd57a73d39bd7@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lizhi.xu@windriver.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3030e17bd57a73d39bd7@syzkaller.appspotmail.com
Tested-by: syzbot+3030e17bd57a73d39bd7@syzkaller.appspotmail.com

Tested on:

commit:         ae90f6a6 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11823287980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
dashboard link: https://syzkaller.appspot.com/bug?extid=3030e17bd57a73d39bd7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=169c3287980000

Note: testing is done by a robot and is best-effort only.

