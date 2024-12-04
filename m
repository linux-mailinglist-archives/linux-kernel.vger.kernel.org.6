Return-Path: <linux-kernel+bounces-430456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA64C9E3115
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 03:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84508167280
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 02:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C7D26AFC;
	Wed,  4 Dec 2024 02:04:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57219EAC7
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 02:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733277844; cv=none; b=pUUN/wpD7Iwf8+DNe3kQRLo7HqVbFdCi/U4hYqp2bt56WDJSFsHdvdUwgLaZQuPlVXXIXwPbUkkWmXy6uvXfHrskF6c+8yZCi58uikgufmsjOivXxeSBnZxhtN+QM8wawiZb28OKTyaR2D0e1Ovkg6c+lkGg3kRuDN3lfBCsC8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733277844; c=relaxed/simple;
	bh=OlDBonlqaQvSACghsmQzxzPu8/DPiMCakSpfBChEvLs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lJEcHm3Gafv5H+J53dx78G55FidG6w5N+mlD+Ndx0bJpHlOHLiDTxOITiQU6sHHrG3GAKUJkHPFCyjTvfb1MOAHn12V7wKuPTcholN2tEwZzGRkaFJ4r1HoHkQaJnsJPbZ8iq7hdZ3JzsRVhDrwyBtgO0bd2mnUwjAfQ4OH3mvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8419f8859f7so531738839f.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 18:04:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733277842; x=1733882642;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c9Ls9uVEwuObwnsAhBmRyunL/mVqcW24uiUwjjBopVM=;
        b=vS3MzQKR/DXKcmvh+ZviwsdvHbZyu72AfhgtwXSTPQG6Bk6BBQWd8ytyDcno1gybvX
         GDc1cYudUinF9X7zxtiFxuDQnksXJ+/tHrxZXvwJrcW2tRn6VzNx35kJP9ayJ7nLpEwu
         aIlXy5Vq/XGgfgcRfSCQBipuLPpTkMQ7myX4oHeDIDk0BwCIy/eIxhMCN/M9urYJJHAf
         ZJfdIX3zAhSeWAzMe3PntGF0GksfhxyfoxXpCr+CO8na8i1xQaTa1Zm9sNNtNoMcIh9x
         NsZbGUYuVGhIhw/GSQlzXjRNlJqraXnNUnNucgElpEHQWov1YyCLbRB5lHaiG2T02bEb
         SVzw==
X-Forwarded-Encrypted: i=1; AJvYcCWPq8Yq/OZWloVPBammB8ZQ3wSNs8FFtswEbtnrVMg1qc5yi1R9sNL1+DLZKJQu9+NQz3SzgRIUUjjDJaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf91W939ZRLuKWa5tTcVsUPRKn4fmyNZT1fkPhJv2H337n+fGn
	Z3YlFmEQQ3uCdAjHz5cp+VPQrQBXcbDurpUZzWkoc5082n1oCmvp1sKcDNXrtINezhgfGGdfTOo
	MjQvv7jUdOcHJ8XEHOAPKBXOnZajParYpdslrBiFjqvKChiELOxnVmfs=
X-Google-Smtp-Source: AGHT+IGxbTbdppfonyHhoQ7D5//U0U1nNOYQ7oQFgPr4U385SsxYeVJpLUnUxoAlXBsrI8r08bPAz8RuG9fBIPcwotXBgB1dD8M0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c567:0:b0:3a7:a69c:9692 with SMTP id
 e9e14a558f8ab-3a7f9ab1c56mr53842995ab.21.1733277842544; Tue, 03 Dec 2024
 18:04:02 -0800 (PST)
Date: Tue, 03 Dec 2024 18:04:02 -0800
In-Reply-To: <CABBYNZJeXf0Lbe-vwC1XX6-hRmw4iqgSRbTV=zCZHbT1hWZLoQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674fb892.050a0220.17bd51.005a.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] BUG: sleeping function called from invalid
 context in hci_le_create_big_complete_evt
From: syzbot <syzbot+2fb0835e0c9cefc34614@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, luiz.von.dentz@intel.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+2fb0835e0c9cefc34614@syzkaller.appspotmail.com
Tested-by: syzbot+2fb0835e0c9cefc34614@syzkaller.appspotmail.com

Tested on:

commit:         feffde68 Merge tag 'for-6.13-rc1-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10e708df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=773e6b07384b3087
dashboard link: https://syzkaller.appspot.com/bug?extid=2fb0835e0c9cefc34614
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=100c0de8580000

Note: testing is done by a robot and is best-effort only.

