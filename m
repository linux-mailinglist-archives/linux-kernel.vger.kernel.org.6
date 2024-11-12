Return-Path: <linux-kernel+bounces-405265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB64D9C4F49
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 554F2B212C9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 07:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFF0207A14;
	Tue, 12 Nov 2024 07:19:08 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF9319EED4
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 07:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731395947; cv=none; b=V1bOZ98YiHegP6w+RdMsP37K/oxlCGQSHnbOfgDZRwxHpUDhjU0Wb3yJ4f7zca1aTWgpcC92aLwfQ9A4tZBvg1J9hYUpzRVnrWbVAzbaUamwsyjAbbaDr2yWNsPeiTl3XehObrEYNWxQF40R9xv1XxpErnvspZSPE3ApGA6fu5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731395947; c=relaxed/simple;
	bh=+4zF+I5UVkznq+MwkXTk3TvFz3Fj3uOIqamwDRxd6tg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Y2ns3a3uwXuWAWW8rJ/hSqmAP2qh3JVCYbbrIZPKZ6oIc/CrmIuiS6KW4o0uz2vShhcwj6hu2TX+uYxj7H/yvRVcjRRLz+6P152ojWKZD0h9uGOnVdgpjkWt9mdvQ7AvmhZyQrgo2OZBHL9esECPzCwRLF1VZFVk60mkuq/MVLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a4e80ccd1bso56681685ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 23:19:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731395945; x=1732000745;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2mpeObwQvE4CpcJBlgp4+m7ylk6uy6K6IVGUb1AoJuo=;
        b=AmjPmejWgE+W/w1/QRHV50D3dZYX2SXhm8i7aOrPGswEEjySI6Go8/siNy/ec/mWzd
         1H24RIz03pXVq2erIeQ5QSMSC8wEmDFkE64GPQg7rF7cL7GiHg5Xt9mJsEif3tVT3CnW
         BrJ0/v24rcbk8HEwKVuE699GHPNW4LCyOu6aB4GqNvsoQM3e8Vyd89DKl8KpCpSCWcv8
         s1A/smteAQxrpGZv4IVw21s2dpDicjOjiKUfcXarz2GVw/yaKgwrBDP0DcaGR4xdOTD6
         sQa0hkSG8ErKnfrFJrBK9mqVQxndkzChEyV2p5ULEOEnehT4ALktxTelAdZXolu386Mn
         Ah9w==
X-Forwarded-Encrypted: i=1; AJvYcCU2W5pr+a5Ql6/u8QXBA+tF+Zt1xZGzuBLnjlaCbTG4BR/irhv10Ku9hHQocitoAnnCSCYDJEtWZosVFv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF6u4UMQvmiBG3fTHoV0xbVMIlSDUwstKQFIOWHoTlhCpXivZX
	V7r8zQiKxLY5HCEnaidL8Z+g3beKDIv+LZrvItm2ahU/8VjMelDXgVsjFUsX3BQPx93XmaGRrk6
	5uhxZVPA59oJHmJpcSvk/2HpwFwccFV7qVQbF23S42J75Z87qC1AX0xk=
X-Google-Smtp-Source: AGHT+IGGdltFSF9otbWIiMMlwDZRPg2bZ543HSOG9b0hu+m8AfvpICqafwJCX0SRwAq4IQ+gFk0Z04zG3QIUqnXWi5iYX9w9RGz1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c244:0:b0:3a6:ab32:7417 with SMTP id
 e9e14a558f8ab-3a6f1994673mr133680085ab.1.1731395945502; Mon, 11 Nov 2024
 23:19:05 -0800 (PST)
Date: Mon, 11 Nov 2024 23:19:05 -0800
In-Reply-To: <20241112064621.uOkpD%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67330169.050a0220.5088e.0009.GAE@google.com>
Subject: Re: [syzbot] [wpan?] [usb?] BUG: corrupted list in ieee802154_if_remove
From: syzbot <syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com
Tested-by: syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com

Tested on:

commit:         2d5404ca Linux 6.12-rc7
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=134afea7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1503500c6f615d24
dashboard link: https://syzkaller.appspot.com/bug?extid=985f827280dc3a6e7e92
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17b1f4e8580000

Note: testing is done by a robot and is best-effort only.

