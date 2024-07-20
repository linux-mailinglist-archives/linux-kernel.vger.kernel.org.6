Return-Path: <linux-kernel+bounces-257797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADE4937F08
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 07:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECB8CB21714
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 05:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DD4DDDF;
	Sat, 20 Jul 2024 05:25:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587B5D530
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 05:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721453105; cv=none; b=pc5lENzaeXOuVihOJuseoKUnllHpz3MH20qNGECB0dwzxoVWzTnWgxXadRkKOPL88b1+Ag7td2WajK+YkRbBID+ep2wV7NtSzp5Q77I61LAZLMIhdGnkCrCYaMVLwn/a94f4bPgpeaSUZa9gY6rEMlR/c8quppP57SKboi5RjYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721453105; c=relaxed/simple;
	bh=SuzpmbWAe5KeKC68zb3EPdHTpgrQkoQk27q3sZLJX4Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VSVf3hSJUDGQsMzhNWpN3NTmizJ8mXaI9L9cXHpR2Rb1qUXhTy2EVguDEZHp57jboE9C19M4/agcsCaIucq/0TwZkFhQNgsu7sJr8t/YAPC/bu5uBaAvr+Gu8v1tEMueABYQW0rdWZuuIM3H8t9OogaTLfjr6W0fTb20ZkysonE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3971269bf67so38406905ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 22:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721453103; x=1722057903;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XrmS/7B0Z6aO0trzQAJ4OE1RwudZG8JZE/MSeyskV7U=;
        b=TrV58Xwxvl8Up2VYjVzyOmVAc2yOsV/rx1lWVfXKg74ht+vIwUqa+Ep6X851MGHYCA
         7wSP+UM/qqcdo2+vKRx56DbmV/OplkfEsnVU+S0fQm5NP1hbctcDNXgRYSgb9EE059Dk
         Q+BbVRjekocqnFilb0IXuMO95W2R2VEQb/cRFab6Kzjt8BWzCXIfb/RF6ZOLM7dKGr+C
         v/xgWgOzEFbhB1Nhk3NWf4xIyV/tS9iKV89t7A1DrxlHffaPyfwkfmL8vhh8MhxduR0X
         PjOGuQHai+KylNYbEs0q+QZVjvDXYLsYmvO02+x0Ssr5SzWBRDSbKYMHJ3vSjFdAkxx+
         4hug==
X-Forwarded-Encrypted: i=1; AJvYcCUXpj73xcTmDQ/RURK5O0S4WzRBqXIZAK+qI0GQqOg9efijyCCW8UGEJmupFTapfnyVgg1pl+VAlkHGv9zPBY7h7gYZfyIJBIBLxEdp
X-Gm-Message-State: AOJu0Yz+3JpX+7gBhc3LHM75/uOJ/PPv/PiayMo1gobBn8MnVORo1lRr
	/YuAc8Cp6i7No8EKhnnkHu5S47AProUOkAJT7E1vI/oQ7NFscwIRyVX2iVvoYtwtuobnsFu1hrE
	YjbMQ4GBiTI90BTCCTdqz5oEDpabZu9rXyPb+gdUTRe+yzkj4CtH3IwM=
X-Google-Smtp-Source: AGHT+IGre9GS41oZAha5AYyE30t2ml0FywxivdTJzyeQxV+Ug+oLSqhWvbEfehFgHXacA4Rh0iy6QV/fClT2og19fV7cBZAerWJQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9b:b0:397:2946:c83c with SMTP id
 e9e14a558f8ab-398e7351f93mr1322765ab.4.1721453103457; Fri, 19 Jul 2024
 22:25:03 -0700 (PDT)
Date: Fri, 19 Jul 2024 22:25:03 -0700
In-Reply-To: <tencent_F6255BBAE6BB63335F9E6F1B6F4BDC1B1408@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bac03d061da7085a@google.com>
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in lapb_t1timer_expiry (2)
From: syzbot <syzbot+0ad4cda8077288e1b15d@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
no output from test machine



Tested on:

commit:         5e049755 Merge branch 'link_path_walk'
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11989349980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b459dd7449326b1f
dashboard link: https://syzkaller.appspot.com/bug?extid=0ad4cda8077288e1b15d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11710195980000


