Return-Path: <linux-kernel+bounces-370739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C487E9A3178
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 01:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CBCD1F22BCE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 23:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC3220E318;
	Thu, 17 Oct 2024 23:43:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B0420E311
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 23:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729208585; cv=none; b=ChLLvpd1glanl0pg61hN7KT8YV3zwEjMIIWMvrIE8EcVZ+hiun5gAhSMdibEFISvfHRc06KMXICan9ZPy/IDvvliGA+VDBMEGr4bWvBwvq0o5l3tWJUGcmj/vQ11lPHkDksALmg/FZd3dKaOmKCwMUuSb+aTS+JXhy2XVkAUFh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729208585; c=relaxed/simple;
	bh=E2dMRktNDX+t0NMBhEiJenTifkG+tyjRUWng08FC6BU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CJrhH7oCBVxF7YIwBzxDKmY9+h4COJSsdSQ7RTO2ePlbXKBB8SH1d3NzbkEd70HwneVwkClaxQfFup6TEerpEsPl/YWAkp2M6njwo0h1XSfsZLPpvfgR9194MulZfYp7Gps3Cbm5eqFJmYuSLAATc0Ts2xR2KWGt6D0xIRjjmRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3a5f6cb13so13372915ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729208583; x=1729813383;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1tXWCNv957RvVXn3wHfS0gRAYUoI98CS0sfz1+sPVc=;
        b=weXtQQPs7YwBPcKwiMEZ2lr+vqRK9XiI+SWp/6MY3QK95Ks1XPHCkK4PA/UV2xfFVw
         2A4wNUWZINtec9gobBwUKUPRE/EQQzk2jj0cSS/zKB1c0GzNuXJjM5efGyOBGdY3xZS8
         MVqQpTVuLmkeLA1nJYpTTRlD/CpmWQG6f7G02CbuU2gIDjT4lgKa1CPaIpAp0DQq+A8e
         Pkb0J5tpygsEl5WWW8m9CJgKY/QpzM/9D5QlAIznLqPW/osAInMO1AwlNOxgC3ohbv6e
         Nn0cRHA/DWO6J2d0qrl3FhIk8cjNB7bDKmhGSAeaO8K7H4xqzsIjLRhCHlhHzhYqHRUs
         Mv2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWi8IG/UhmZc4Hb/HrzQyordxiS+wkCpr2AJdsdw9OAoZrJdokh0mfp5+g7dB82Q+MbtlA6ZLkVe8p65h0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxU06eSezxOhh3Yb6XCW6/wuiuyjyX/iOeRxh5vMIGN6KaGSGI
	ESFLjofyxhRzGggv1FJexokEjVCcmo3bNX8cU9MxCIVxhHQFCmuI3h91z8X06Y659o8cHYNPrxh
	0wxRrsW3qPOyhD4lF9GTaNvQuBipPX82husKsoOA26QOL+8UxfXreQ1U=
X-Google-Smtp-Source: AGHT+IGuWkPl8Bga3DK+0RLXliAVKUVDQgIHOVdTeNtZLiLx8PvmnA928v3kp9GkTydqpR/Q/WflwJBxnDsmKGLUCOZVSv7/uZVm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c541:0:b0:39f:5abe:ec25 with SMTP id
 e9e14a558f8ab-3a3f40a84e5mr4257375ab.19.1729208583701; Thu, 17 Oct 2024
 16:43:03 -0700 (PDT)
Date: Thu, 17 Oct 2024 16:43:03 -0700
In-Reply-To: <CAGiJo8T=d7ANepVs3ExyrDEyRHcODqmOfvpy8TUsZSNzLxYYig@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6711a107.050a0220.1e4b4d.0006.GAE@google.com>
Subject: Re: [syzbot] [net?] KMSAN: kernel-infoleak in move_addr_to_user (7)
From: syzbot <syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com>
To: danielyangkang@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com
Tested-by: syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com

Tested on:

commit:         6efbea77 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11c49830580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5242e0e980477c72
dashboard link: https://syzkaller.appspot.com/bug?extid=346474e3bf0b26bd3090
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14889830580000

Note: testing is done by a robot and is best-effort only.

