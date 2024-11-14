Return-Path: <linux-kernel+bounces-408725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 836449C82C9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 06:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C87B1B232FB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 05:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419AD1E9080;
	Thu, 14 Nov 2024 05:52:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2801E7C2A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 05:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731563526; cv=none; b=LdmAhDj3SXeL2cmWB2fN6HBcoNX3UY4H7aB2KdxQisLhknM82+Ke32iH/6+dxAGZDdZlAtuGty+jyaWSrXhYkMLSBsxA1DbICOQLSK49hADZm1hS+TrVhaRTJf2bwQM9x4dWHfLei2fxC9Y9UvJDJOaZSVdyTqdX2YmSUAKzS0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731563526; c=relaxed/simple;
	bh=7O9gfR0es3iI5P6jHi/Xi408OtxYV5gkwr3x6K1hDhQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EgQjf9OTiPPo5o2XHlXBRajjm0J6dbO0Ud80Ax9McG7SBs05jiBYXnK5MEGQm8lBfsqLDAif/59FDZb095+PF4xd5S6L/AA5nvgi/jgVwTF9MLGZkCUo+P46IkiyHMHWp7teHM1jLaOwNheRHjY8itQ+TZmMynOvzKRJN2AtP2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a7158d5c8aso3316195ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 21:52:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731563524; x=1732168324;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1IpFZEQgGIj9TjFRbdLUfNjQq3j1EQcFpxBuYCYzFUE=;
        b=E1YYA0YId4EH6Pwr4d4NtwASktvs92b6h9bOnWlWZNThvHQvh9H4/OlWNlH5WdFlsL
         RLv7iM+8Lk5n14iquCSb6uCeoleV3SOMwrMlt8Xo4LK6r1VNPayKC6hC4m6/EygJkjK1
         /5GcBk6L+qsUH0J0b3Szgh1yfJLXYjXOVlznfhh+zPNhjBVVGYfwexlCsgnYZpuWVzeL
         SE2KxoKdm3wt3Jby9BfFLISljLtuBGzL2x8HCCELPQh1EGTECOnRNz85+vdYAGAQYTSY
         qIrUX0t+FlPcNGqIWzI0GKuD8/VtQBbftR/t/hiRYwRFuSmzBOjQdXq2nMw8ea7Dkav7
         KL2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxegmzfPhxiEo0ORXw4mvmDrIP0sz8bTeWUcy/0eKVizloH66Vg5JmSA3S3M0Y6DU7lharzY7jGEyUWv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9hY2nR737c9Ipf0xvu0MJTpBVmsNPnaK5/hDnEDjByjajnlAS
	JopIKSRfzFETqz6CdfabGehjxDe4Wga2baNj1xJCmllCf500Vx2asbLGzpxMIryZSJlkztN1NNP
	naqR0oMkhkicNSwn5Lh88V/XKbSlc73oBcFKr+K/q7w2DI9RNb9MNp/k=
X-Google-Smtp-Source: AGHT+IEGC6y1/QUxLcKR4nU9hQrJNc0vXYAJaMCUbS301MOJxa+AGUS1nxL2+ypoL/jmba0RuTagI9xdLG5nigEMdFtsK2PT8Cmf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:388d:b0:3a6:aee2:1696 with SMTP id
 e9e14a558f8ab-3a71578db17mr60186115ab.21.1731563524569; Wed, 13 Nov 2024
 21:52:04 -0800 (PST)
Date: Wed, 13 Nov 2024 21:52:04 -0800
In-Reply-To: <e22f5b69-0462-41c6-b7a9-b3ae10fa6992@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67359004.050a0220.2a2fcc.005f.GAE@google.com>
Subject: Re: [syzbot] [fuse?] general protection fault in fuse_do_readpage
From: syzbot <syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com>
To: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com
Tested-by: syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com

Tested on:

commit:         779014de erofs: fix file-backed mounts over FUSE
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
console output: https://syzkaller.appspot.com/x/log.txt?x=155294c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2effb62852f5a821
dashboard link: https://syzkaller.appspot.com/bug?extid=0b1279812c46e48bb0c1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

