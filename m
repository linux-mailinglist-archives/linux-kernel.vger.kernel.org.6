Return-Path: <linux-kernel+bounces-316160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4BA96CBF0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 02:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60A761F271DD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 00:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A380A748F;
	Thu,  5 Sep 2024 00:58:04 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA91A1C27
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 00:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725497884; cv=none; b=d7R3oHkkmzAuby9hWhlRR8gWCdj1dv03dSQvhPELrh1SdH5NR13jpmO5I4noETVw9FFdwu9oREIGOHrwbfcGhttEXUMmO+NawWI1wKDp4pm98InGrEEnMdnCAA6u7mXjDubjnENSDFWTidEiMOnDPo+Vqr7EUBXQa1yz100kToA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725497884; c=relaxed/simple;
	bh=/CKTM4kaa8II5li/dqw1AQYFfg9+TnNU8dZcYvGwwak=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PASaULl7fHJ+6rjsezBdkv1CbxwfvegoxAETC9xshFVoSLHCNQuQcwnL0LreIA4JyFDOOOvImAy7+dEMZekPHf5zXzLslVQOxeq6UXfC9/2cX4dHaRCuquXdQ+zDKkk5cBnDcS2TK4TDSQ3lLFTnTor8DkRnU9PBS2QiAQjoFVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82a55adf8dcso28601239f.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 17:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725497882; x=1726102682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZDdNCIFN4mGTaZwK+oYi0RgmIR7b2nHRUUiEY8+dg8=;
        b=O90VxNxV9gUfz9ogyroYUOdwZomN9MiVrp2IaYbn2bW7ysoO3PLBeU6wlZpnrl1m1m
         gmN2biQekUZsKQs+Z36GIV2D8gcX4NNoPXUJmbSl71TxXjKrVUSPAUFudw5b9QoPR/dB
         6Y3D+XEDGxCchSUVeq+rBy810WlEnTEYRUa2bihHyn8rEbEgIX4dVTmPpiFOze7MPotF
         dW3nkxlDxhQriFnZHbaXEpq/cv5hmwpHYv1X3fdUwjH9MTpPeyUGX5VdS+RefLphAZt/
         lgzcmZZVmzIUU+r9MPpYZ/B62npwBnfkvxGyEgn0WlRF2yGQ6VViBpfAlL/mqT6HYmar
         rgFA==
X-Forwarded-Encrypted: i=1; AJvYcCVtEsbha5fTWCBRa5Acwn+Br1FsH18IVGWLARCGvUXh7u28zCkRQbP3Z7uYnplDfVt7YK6a61xIZ1K20fI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5QEDMouHYs/lAivN2aYakLLk1uGJ/6XxYHG9ZnVVCweZpUeP9
	jzttm1vZMz0Hi3hFOpnWhi6bSTfgX7uULwU94lzH5XKv8Mo+gfLBgz1K1+mGBUEIYwCiYuJhBHq
	qS7ajm5ULvpzBQUbmUJ04eZjmrw+GkqZ9cMdt0phb74lxm1pnSw1JdGw=
X-Google-Smtp-Source: AGHT+IEnsLK2ZSau2MDDBqtNGuj6kmEoDr2dm7p6FqAqPj/l4NzWbC4jEKIwiF0glFEzdNW8Cov1pEHMHrFeSCUDKrFFq93SdJHc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3494:b0:4c0:a8a5:81cc with SMTP id
 8926c6da1cb9f-4d017e6f688mr1169419173.3.1725497882038; Wed, 04 Sep 2024
 17:58:02 -0700 (PDT)
Date: Wed, 04 Sep 2024 17:58:02 -0700
In-Reply-To: <20240904174339.7790-1-kuniyu@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000051e0ce062154c824@google.com>
Subject: Re: [syzbot] [can?] WARNING in remove_proc_entry (6)
From: syzbot <syzbot+0532ac7a06fb1a03187e@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, kuniyu@amazon.com, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mkl@pengutronix.de, netdev@vger.kernel.org, 
	pabeni@redhat.com, socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0532ac7a06fb1a03187e@syzkaller.appspotmail.com
Tested-by: syzbot+0532ac7a06fb1a03187e@syzkaller.appspotmail.com

Tested on:

commit:         bee2ef94 net: bridge: br_fdb_external_learn_add(): alw..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git HEAD
console output: https://syzkaller.appspot.com/x/log.txt?x=10b70e53980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=996585887acdadb3
dashboard link: https://syzkaller.appspot.com/bug?extid=0532ac7a06fb1a03187e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=156e82ab980000

Note: testing is done by a robot and is best-effort only.

