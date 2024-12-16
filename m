Return-Path: <linux-kernel+bounces-446663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F0F9F27B8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 02:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AD3218869BB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 01:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00CB17C64;
	Mon, 16 Dec 2024 01:15:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FA111CA0
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 01:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734311704; cv=none; b=NxvpoSa6ySukZ9KTrQMP6ZILdOYSuWHvT26TuVFePBeGjele3nPEB6NSmj3RfOo6qxZbcrVZow6gCw8Ob3/AUOx9/eCeyWOZWCnyehHIoG70P9oUKetwerSUWFF8dnO3blDDSu4kMrs0ud9ekYzoaFuVY+njh/SZ1C0n911pbOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734311704; c=relaxed/simple;
	bh=IyqjuzTling46gE2TNQrIgb/gZ6mTrPPkWNMpdhvPgE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hdL9uLhqRZzUkaOcTuHXGmPArC+qoGw8oKcp3myhh6tvt7cKasmq0Qeo0/6nn7RwMYrnkfGvzd2Bmj7B8cmMZBKcvmZSZLlHNnKd15u4WBodO6YVFZziEg4KgOgf++UVPYNoK52Y4ByB2qBA0P6tcg16eyj1T0M4rQ2NmMgeOzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ae31bb8ee3so71269355ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 17:15:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734311702; x=1734916502;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=itZXTi3qbGDas9ZrdHCoAI4x+Ze2te3bnY6KY9F6F6Y=;
        b=TkoTk9X67byAVSrgJReVMU7JlAmQlYGJn3Ba8e8yHKUkq7C00fryft+1GD2WXW+rjs
         3+8lxCMjIjCXCl/KUCVyrcv9oAxeidUPAjlgI1EOCCNxFRKlUcbvypd54KFKJC64NGE1
         ghBqrzNJUhKogMO6FF2hLQ7QEK90yMUvphEgoQwVBRg3ErtxX/LC7Pwb/VT/FnUOHGh0
         OhF6IskC7f+HsS7loUXEZWA/UV1afhOvYy1zxZtomcXhTqXG+ez0AKN1ZX6u4QBbWSlA
         h+AdHJJV+McAngq1uRYO0p6Fe3IoxBE1rChL4Ss721bddUYzxYaCTnZ0GyGXNsjhfd4j
         vIbg==
X-Gm-Message-State: AOJu0YxVyXYmZ5hEkfJ7NQCXjcGRiYTc0W3IWK10D/WhNn+Wis81/3pX
	m6XxSF0M2Itnbi4o4zK5/3TJh/Wtij6eT7XhRBj0zUBvFV9Viq7ePhZyEOmx6zV1kiPnUypZDQg
	wWBIZQMvbnhc5D895xO9G1jhyZuX3LHa5MyQVfotkHGafw9ZNXLZDoj8=
X-Google-Smtp-Source: AGHT+IFJCZpczmgjx0fXzG67S+CjnHM8eubvTWG9BwLuRD/q4OFLXleDvSw2DO8AF9L8sCTbl4iPR7NhlX0NjPXK1LiEddoRQUQ3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd83:0:b0:3a7:6e97:9877 with SMTP id
 e9e14a558f8ab-3aff1303cd1mr117722115ab.24.1734311702046; Sun, 15 Dec 2024
 17:15:02 -0800 (PST)
Date: Sun, 15 Dec 2024 17:15:02 -0800
In-Reply-To: <20241216005533.1718335-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675f7f16.050a0220.37aaf.010c.GAE@google.com>
Subject: Re: [syzbot] [trace?] WARNING in bitmap_parse_user
From: syzbot <syzbot+0aecfd34fb878546f3fd@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0aecfd34fb878546f3fd@syzkaller.appspotmail.com
Tested-by: syzbot+0aecfd34fb878546f3fd@syzkaller.appspotmail.com

Tested on:

commit:         78d4f34e Linux 6.13-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14521730580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9cac7e24ceea492
dashboard link: https://syzkaller.appspot.com/bug?extid=0aecfd34fb878546f3fd
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17421730580000

Note: testing is done by a robot and is best-effort only.

