Return-Path: <linux-kernel+bounces-270521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 214A3944145
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 04:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3111EB2CB23
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054531311AC;
	Thu,  1 Aug 2024 01:55:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086A31311A3
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 01:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722477305; cv=none; b=QzM1Se1pdjap3Y03VoZ9yTf4UaTsgvKQwlj9Wbdo20iEMIRACwK2BXN2XsoBGiI3jaWWQXDNK8rdgpSuRsEa+q9uppCh3XdNGNpToPypqH0depyTwR8iwWrfKJ5GhC4ihytttuqoSAFA3kTZH+xyKbmC8QmH+29lE3hWkeRqj4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722477305; c=relaxed/simple;
	bh=CpMu0DUzWE9XuIWxOMXo8S9G3ko2EdxbbdYu44aWpo8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kQRTwf3Mcz0dzyvC6bjLOeFljiMAoyzkymrPCDaO3VADXzeFaAbVVhBAA++c8P5/asnPIx46w3dm6KO9JZR03yRvwLTzHEIe0rul04gYJ2eNIcGSYDkxAHg3JEvrGYKHpXUQCzEHUtXfjkadD0IgrApnGeo6pp4dpzKjtEFLOlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f6218c0d68so1048590639f.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 18:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722477303; x=1723082103;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d65gmLVR4d5UGdr077ucBrgV5dq75eds7Czpf9pTxN4=;
        b=OYdRiJdlqKWz2TK+HRGvUfzJyy47miOEZVBmWETAZnuywtg0VRfOt2kgNPjzdNGsvO
         hMR80MvObc6PePUvklhDKAfiks1d4b7nmfxMlearfhZte60MZfjTbS0uI74gpzr0dTAO
         BFTSIJGgX5NSqZYDmxhRaKcvJBxMPS0AAijJVvy/MJDwhVbM805N/26QrFp+GdqGrvme
         4W2XD9XEUb0O1vUP2LNMedzKGD3g9NvlrBxVapA4pFTbB1sk8TaX8NHJ25CrhgfPxKmC
         HF2fJ20AOmHX0WtNsBu67GS/0I4AK6Xl58LAw0Diz7oCPB1c7bU1FAnj67S9Ls7IeXha
         N2og==
X-Gm-Message-State: AOJu0YxRecpplf3z2AZiwrwDz6qQBvN3BYKzT5VOyixPmQw+OuBWgoyx
	EghJ4K0kuGsoLRllemAHJ+7dVP9n+eaFjZOZD1YzBRWMY/HWGvaeVrHKXQQ7UAxhXrQkjHLiisn
	JR7vAMxPgcejd/uhtRUQK6nE0DtJBcQ9jCaMsIuqzViocAz5WyrjE9G8=
X-Google-Smtp-Source: AGHT+IEFm1MYpS86LM378EOvzEVv1GlJZIyg9f+Km6XwdVOJC24lDhWBWC5c91bSwMQAfN1O0LopSH1Gn1eRsDokJjh5pi/0O4JP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2583:b0:4be:d44b:de24 with SMTP id
 8926c6da1cb9f-4c8c9b1887fmr58881173.2.1722477303125; Wed, 31 Jul 2024
 18:55:03 -0700 (PDT)
Date: Wed, 31 Jul 2024 18:55:03 -0700
In-Reply-To: <20240801012343.412607-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c96749061e957f56@google.com>
Subject: Re: [syzbot] [squashfs?] KMSAN: uninit-value in pick_link
From: syzbot <syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com
Tested-by: syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com

Tested on:

commit:         2f8c4f50 Merge tag 'auxdisplay-for-v6.11-tag1' of git:..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=164d3703980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea3a063e5f96c3d6
dashboard link: https://syzkaller.appspot.com/bug?extid=24ac24ff58dc5b0d26b9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=124a1223980000

Note: testing is done by a robot and is best-effort only.

