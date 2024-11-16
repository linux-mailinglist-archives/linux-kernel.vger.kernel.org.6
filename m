Return-Path: <linux-kernel+bounces-411531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D16529CFB9A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 01:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87C80288221
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 00:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B05184E;
	Sat, 16 Nov 2024 00:18:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C411372
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 00:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731716287; cv=none; b=VFzA5O9iSHGOmItDNOhHWXSprXhavKvBytRPS9jfvm4uLSmEMN3vaZbxXl4eetT2nz4h493XiHZ4Ygl+f1bE52lDpWONJs3XBCMCZbbHFFZpR87EcPzdmo/hRIyauYI6rrsSk8lFPcP/Wl/9JMysPaBoR0mwPOTwOwodA5FDavI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731716287; c=relaxed/simple;
	bh=mFDWgdGeK/9+TtfMDQ2ASIpWKU2DDLnIqBQ+2ZUIjrA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=piriD3YS0GMkkbRkGw11YSeNSNtdDDSgvmi+hTlKUmje9L/rWt/PTkZUrvtE0/I0DZqFVd8cnYJ+6mbOOGXGZuy4p1PLa/2S8iXlo4K+PeBJ1AQOvi2aLxy+P0SqeckWwfAJlWhSgfa0ke4I7ls9bmRnyIT1wMNzizwCapp4594=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83abe8804a5so233216139f.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 16:18:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731716285; x=1732321085;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ca7XTW0kgTpUY9OnQOuVpXToi6KqMNQwLQ+YtGQVZKo=;
        b=tFUUTIo4r2RhmSbcHqvgEBtUhsmkyrdylB+PcBOeT942dEJknYm4PNEgTckmEgaNFR
         S+N7tiCrNfCF4OEjpEXJI6ft4bWo7CnTSAnBoShuYfaV7F7E3fCHBIC332QFUd5e75vf
         sv/zszNmbaHatfyKFcg8C12KBlQ0w9j6JBN9kY/hA6LA4i2q/qLlzGsdm7BmBIpyYoZ0
         cNQ3tQaNjJ2M4lg72uSSpcEXQEsD220ELOOAhz1UnzrHYDtWrvo5hxc1GmEnbiCXL4oe
         XVfroUs6tmPuynE6VPjirRUg3H9DANgVD0RCky290zsko607jshWm6Z1TcxUMh7avAPx
         JJnA==
X-Forwarded-Encrypted: i=1; AJvYcCWiPlYp+k3IOONSOZ14nIo5qy8rbKjQjqzre9K92tOlJtuiIhAivjfPR+eOgyy5y3U8mWGkdDH+ne6xxCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEMbm/brA7gy0uCJHc/NODfRYcyOP78C9+/3HzjvrbmtRXFZ1i
	NW80wW89vJiXLQQhoyavZ8UndXKMIZ8g1EcpHIhnUpbhEcLErRz3muE17CAoA3ki0zPI6F9n6R0
	5QnXeoQ9RA5LV6ilPGVcvjq2aaGIBrJDgGJRrkJ7SfXeD0GsqryG0CQ8=
X-Google-Smtp-Source: AGHT+IHNHdWUUb4Tydyj2HtfOR7qJMBM/ThSwEQBxVSQoHnln5ijpDIi0eTakmPbgbPCwL82mvvnDHMQYgV3vfY7z0r14IXLdGcS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3487:b0:3a7:47bb:bb81 with SMTP id
 e9e14a558f8ab-3a748094eb6mr60526675ab.20.1731716284991; Fri, 15 Nov 2024
 16:18:04 -0800 (PST)
Date: Fri, 15 Nov 2024 16:18:04 -0800
In-Reply-To: <20241115232117.3774-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6737e4bc.050a0220.85a0.0007.GAE@google.com>
Subject: Re: [syzbot] [kernel?] WARNING in posixtimer_send_sigqueue
From: syzbot <syzbot+852e935b899bde73626e@syzkaller.appspotmail.com>
To: frederic@kernel.org, hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+852e935b899bde73626e@syzkaller.appspotmail.com
Tested-by: syzbot+852e935b899bde73626e@syzkaller.appspotmail.com

Tested on:

commit:         228ad72e Merge tag 'timers-v6.13-rc1' of https://git.l..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
console output: https://syzkaller.appspot.com/x/log.txt?x=102f3cc0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a3e11aa0fc34acd5
dashboard link: https://syzkaller.appspot.com/bug?extid=852e935b899bde73626e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16b471a7980000

Note: testing is done by a robot and is best-effort only.

