Return-Path: <linux-kernel+bounces-350580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1D6990702
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB08D1F228F8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DD51AA7AD;
	Fri,  4 Oct 2024 15:02:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCD5149E09
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728054125; cv=none; b=nCz8EmgCFg72J/ak9zp/YbA9HJLG2UET62Y6YTVxw9cKg6Qb108qn60PTnklcjUQ2+Ot4Zv3H7X3dC9/ECzutkPB6PfAaEIbrNyYkqSYJeTc6WwwCW46BP6GmPirgHr83fMdcp0/y9V+tn29sSmKjs2z1DuO05JCWJNjxAAfEWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728054125; c=relaxed/simple;
	bh=u/Hv7IzlLQ0DAD3tFz97LpF2eqHhYy+4MhBhhVE7Xq0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aZ7YqY2o+a8Aw8BOPE1+3HUDjXKGSPDvOY6NkASe+evXYV6U14yWG65vI7ecdOznRsLVwkXaTwBYX43C7+8vyEM51Sy5GuKNqMM0GGuO2b7KxC4e0KxfviRt1w0y/qfTG+DqVA5YxURYWxNrbgcYUyYm98Wxmlmq6+c0CF4Qhio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a342e872a7so25530995ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 08:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728054123; x=1728658923;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H3au9IqpNVzvsaJjx8Rca9XmYVoX4TZ9OJLcfCksJSs=;
        b=vtKyR63wT6XJTFk+R33uirrTkAQZkX4czKLTlIdh+1QFBjhds6Rrc7busMWTGe5eiE
         E2A9wKKOSTL6x0ZVYDlkmQ1xF02lk8bz3CsPpbT/6M4vaxhtcse4yaaYmqsFz+3ZuVEN
         JRYNQIOyXZ4Er9lwAcTY0E/5zum4d3UdO06xCopV/gaDe3BDiQTfV06UkTAF73kzVEZO
         bwcClCMyji8ExMG8k+UPCHj1A0vxTxcRJ2n5LqyTyx+scwWfBvYjhXmqqnWoFbG/Ih1N
         HZkn17tZH3u7QL4yLpNcjzcJ4TOVOJ/HmGJtNEuBBOr9vg0C1VoRnOiOxvcqpZXJIsh6
         NJNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMu1vzpuHW9jHZpMvbvwh5kgWLl+7khLDXOILwLoM1heG4LcekjX3ZMVqh2LlQGatkiudiMsgJAywkwDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeN8qHRjdw2BMALXOwqPHEf6dU1VVGUeCgIWyVUkUfGplFC653
	f3e9ezvbVQuEW7FGGLHh3A7dAnZht0JQofdQTJc7TGf+dyDigcgPRDzi3gIi/yaUzGH7bI0sImb
	yT52QDk7gsJwHhLege+HrCwqyc4ycMsFmeznHE/6I4p8y7sxpaWCtTzg=
X-Google-Smtp-Source: AGHT+IGUE7jYciAHVkCg0fpqqhNRxe9efaZT1U5l0nrC4sfbN8XL0dX0HX4w6hJbu9c3mfwKlODqdq0HXQ5a3GY65taRUn1VIqxA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16c9:b0:3a2:463f:fd9e with SMTP id
 e9e14a558f8ab-3a37599709amr29348915ab.6.1728054123323; Fri, 04 Oct 2024
 08:02:03 -0700 (PDT)
Date: Fri, 04 Oct 2024 08:02:03 -0700
In-Reply-To: <20241004135647.691343-1-dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6700036b.050a0220.49194.048c.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in set_powered_sync
From: syzbot <syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com
Tested-by: syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com

Tested on:

commit:         b63c755c appletalk: Remove deadcode
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15750d27980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f95955e3f7b5790c
dashboard link: https://syzkaller.appspot.com/bug?extid=03d6270b6425df1605bf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10648d80580000

Note: testing is done by a robot and is best-effort only.

