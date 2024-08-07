Return-Path: <linux-kernel+bounces-277224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A57949E2B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 05:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2EF1F234F2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 03:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D139E82863;
	Wed,  7 Aug 2024 03:11:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE281C27
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 03:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723000267; cv=none; b=LFcAkpAkx2CG4dreHEMtBwmjy4iSUNTouKPODe51hEnYtK6mBv8NQZdbHpZeOXclYGZyh4Lq8NJeGmGGABhLXTbSPClnl5WWMsajZS51zqXcVlXAylbc733Ui93fKlBZLim6+qWCnXYaaO8LulcPBop7dfxIHk+dtIVhZaXojhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723000267; c=relaxed/simple;
	bh=WS/UglrD0eEcv4pkCVN7Y88hWD8hhN2WN5Xh1VO6XVE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CjGl1DCEYc++8hyMQyV0yH6SRII4uivW5fI2cBvshV0R6jhlNtJc4XV9fUD7lCqvvb/HMr1ovqbnaFFGos8PMlLixz7QLQcWr74sm89eg8OxJ0YKNxz/i7S90Cs8fTWQ6V+Dqm5qHxCfcUCT+4k5czs7LXeU1Gru9mYzlLV4WOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39a1ba36524so22080505ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 20:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723000265; x=1723605065;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TQbeSF32RMHzkIrCLXURTd7yc4z9rN14COb7KPUmryo=;
        b=be+rqrUy7my/+pqDVw1UiHMa8Fcfs7KBq0MrUbRMQUXR97u/Q6NQKIv9yojOAS9qbF
         U34Oy9SID+JaMw1ifA286jPW32zGX+JrdzCwee3scCzVgXGuvDNTnWqaInPI34ZREwXe
         bxJm8SgyjasZ0FgIkC6UviXjYXpxTV7fgHRfm3sMKavPha/nDM43ATm/8rtfxEXJ6Wtx
         xZbW+d8YHqbYuKFfSgRIc/1orKTM0MdJDOW0IiEbKuA2J/4IDG0E2riiPElAh0jZZMBj
         KLRyCjaDGRETsg9rgDrRUH5gAFy9LQD6szmQzt4aZm6ApGcHsnwPXy8UiiJkJg5NfVAx
         GX4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlbdfFN/akkRe8pZ5Oi9ZCXsY64z23/nxfM31+/gg+k1ajoUvewl9QGgW4VwrV5tj521TTYgRfiPGKHGzbbBDUMcAiYnymJqbhLVLl
X-Gm-Message-State: AOJu0YxepwKZtr7GXIET2zcPBySeWqnGdzkpSGf2VBkWBZWTZ/pQY4UV
	25hfRdIaPk0u+QRTnNBOYACL+VqlnAeE7b/dvSY5ZIAGch0DSB8KbeZE2BrvqFBPXzSTINEyHWh
	O/0nUkxfIRA+3CgXLtHuquEffhSE9ImPImwNT2cPO5M/rH6d5lmCFfKI=
X-Google-Smtp-Source: AGHT+IGw/6joWBZzmJmULS1fHKIPqUXCNgA7LAQExvlemUb1uSOrdN7DEcdJDLwRXWUqIDC4PsG2swQFmrPcWBrEeGHKRNtlmEwL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c561:0:b0:381:c14:70cf with SMTP id
 e9e14a558f8ab-39b1fb6bed1mr14815035ab.1.1723000265106; Tue, 06 Aug 2024
 20:11:05 -0700 (PDT)
Date: Tue, 06 Aug 2024 20:11:05 -0700
In-Reply-To: <tencent_FADDBB192B4F958DFF25E68DEF920F5D8507@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c00202061f0f42f2@google.com>
Subject: Re: [syzbot] [can?] WARNING: refcount bug in j1939_session_put
From: syzbot <syzbot+ad601904231505ad6617@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ad601904231505ad6617@syzkaller.appspotmail.com
Tested-by: syzbot+ad601904231505ad6617@syzkaller.appspotmail.com

Tested on:

commit:         743ff021 ethtool: Don't check for NULL info in prepare..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16475ff1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5efb917b1462a973
dashboard link: https://syzkaller.appspot.com/bug?extid=ad601904231505ad6617
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17694f4b980000

Note: testing is done by a robot and is best-effort only.

