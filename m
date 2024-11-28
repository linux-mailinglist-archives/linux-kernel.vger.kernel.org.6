Return-Path: <linux-kernel+bounces-424614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF899DB6F5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 12:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B349A162865
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC14719ADA4;
	Thu, 28 Nov 2024 11:55:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A11519ABCB
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 11:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732794904; cv=none; b=cClMGhmeA3Oxs/QWwwVtVmSi5mofOO3UZczO9PBNo4CkQxhluBRBz/GjFIz5QDpKbztLhrKcIbMfQMPvAbMmaaMIO1u0cZuq64VNPPNp3gU/pe4vBzvgSYG9Svu5VYpCSgKhBlYFAUtRpqUo9NxtxRcwl7jXVtmnX7WymLHFxYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732794904; c=relaxed/simple;
	bh=AxyQka0wjm4/heWS/qnVkxmZ4iBS8gdixhgOd55rAG0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uFKU4e+wQyG3KgRqJUtkH+9JXzj+KIoIYhv8ZRjnqzeXY19Wq5YARoLOKevqV81+DhbEmFM/zBZGdARo0iDLu1yO50j7uZB4+u+6CplldjYgRXAynQFRg9aK6N6cVPsOqW+lxvTywAw0wvIZH/bNTuq39LMYxCj/XRKNoLuIutc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83e5dd390bfso135545439f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 03:55:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732794902; x=1733399702;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x5bdoX8cMCdpTynC/0DK1ht6prXK1kPNU5DUurTGycA=;
        b=Y6E/1RwBP9/71VOiM8ewLKbJRXRAuWakzuOCvWJjEcVKXwnjJlW/1DULY3MKbI+Sku
         s4CYM422xznY9yPDouqGtfwRkpCxUYRPhBlUNC6WS9S65AF4/WOo7gmpNTGbjSbm8ZKn
         MkZXqw/VEVTovBudKaKDIbLknzHjIAzi9mQMbnrhIbJBTkg6BsspH4opZ08IA2auqqJ3
         YVPZRJ1z1mzvu+NF36+q6UGH8u2T5NpncWD7lbiJracXX3P5kKPHYA9AJJE27esVsXYw
         ntee0SY/XBrWdeXIYbYTc5GZBqYOuvmUJbEn9gFUZsptgWEU6DAPTYDV6c/PbmXDi0Qz
         MEvw==
X-Forwarded-Encrypted: i=1; AJvYcCWXx68yud8/Er/NviU0KvXVsTahvgMYfcE0ZEx77wMt5IGUNCmiVBeBNH+KMYEzYev/lbKpxeDQDAReXYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YycXby8Xzk7J0FBoEwTTfdNnskMaDUMxo+/wRuuk1YzTRn5gdVO
	UnP1AhDUxfmUHutrwPDOxTZKeIh5+/2uERHLBGvGPfec2XFBEdbygEtERNKTozJUexDVIv9O0tw
	REHG6Dpf5h2TBgTNxmRMUIcuJ+bR7nV8z6+hVg604fjVWcjbEnqziwhg=
X-Google-Smtp-Source: AGHT+IEFS/yYSIlkdGmOiiSCmlft5ilio7GA2ZX+b9gUXGGp7Tpd/cSD/CCFwrqIvNEG1KRCcy/yBtyERXtjnRJvAKZU6Y6lP+Mu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:348a:b0:3a7:cff5:16d6 with SMTP id
 e9e14a558f8ab-3a7cff517camr5923485ab.3.1732794902165; Thu, 28 Nov 2024
 03:55:02 -0800 (PST)
Date: Thu, 28 Nov 2024 03:55:02 -0800
In-Reply-To: <20241128112948.1850-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67485a16.050a0220.253251.0081.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in __timer_delete
From: syzbot <syzbot+9f9ccb1c9235f3d44d53@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9f9ccb1c9235f3d44d53@syzkaller.appspotmail.com
Tested-by: syzbot+9f9ccb1c9235f3d44d53@syzkaller.appspotmail.com

Tested on:

commit:         b86545e0 Merge tag 'acpi-6.13-rc1-2' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16ad200f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8e5d0648de624aa
dashboard link: https://syzkaller.appspot.com/bug?extid=9f9ccb1c9235f3d44d53
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13f5a3c0580000

Note: testing is done by a robot and is best-effort only.

