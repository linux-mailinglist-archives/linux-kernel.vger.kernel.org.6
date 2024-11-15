Return-Path: <linux-kernel+bounces-410610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2229CDE01
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 13:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19AF6B27C83
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 12:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4761B6CEB;
	Fri, 15 Nov 2024 12:04:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6622AE77
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 12:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731672244; cv=none; b=L/+GflakEO46cNDKidq5tKmVdNaacgvPla0xRv2jwd9uq1tqfXupn2Fsw2h7YUzSZhAEHCdHBcTP16wmK4rzXQI2MlQhg841OXkNwX7VqbCmmFSN+LskE/VOgSj1E+/V80LG7elpzjMGT7yzXnfKUtfRUkwFCIjGtUdolJ29fDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731672244; c=relaxed/simple;
	bh=imz49qVmIpYNdCj67Yfa4mg25zzKMy5jk7DiVh6bm2s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BfeWO6wqdcksVUB8Q+vpQ52r3Jeny6gpUPwmO/DP/d5dyl5OF61SWFCc6nhyLtB17x7f1gmg2ldPppDPfThAdRImbLDZ/xS+XRTwdIkpBBCQqUg820UTtTaIDWtkQsWDe0uxcIPRcqVuICFDk6BSdx6eSVgWEhqCXt8xKadJrHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3fa97f09cso20083385ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 04:04:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731672242; x=1732277042;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9pah0ki5MLIYmabcITeBEMnCIwaCDw+o42JRXBY/OmQ=;
        b=GwkUD9DwTEvfpfu2n5xFEPYXGPnEOh9QLDgPDJWEOUeskxPEWBBN6cwWSoqbX5gkFJ
         HW92Cu4Hvr8HH3KW6T0cVff8KrzfjnYoegTkpoThUAoTiK35vHKWFW4mVosunCCvQ3vR
         ZOmHoCZzlRCjDeVOue3BucqTdsSv0TsopyyIo+sBXvXSOCVaPzakSQaDz2D4LPfNUIxQ
         XC7AxBpe3ZWkMmBos+M9sLKuFidWXzTr17DaYDRBZfXMFh5mqcQURUtuF3n8FWoXcCqL
         eiK0fcxY9kqxFj1d6fIHmoUBK7jOrY3eYxuH8+AR8HuyAjnpYiK8w0Kv62BdS0WVUGS7
         8j8A==
X-Forwarded-Encrypted: i=1; AJvYcCWcviFhKGtJCG3hr0XZCBs4hQN1qtbRKMZuB3XwXVUfwFhtbYCIUcVUtPHGgcXYW5ZozIJjfQkEmvjOYzE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6trNJqM3nARkqKyoVQ9gArTgA8UKgY3HfkAPfHm782utm4bed
	X7ReTViFhwyrH//A7LaLvwV3zPu5tHKkgClEuiQg42c/epiDKYAHkH7JUL4DGKxHvi83jqQNXPc
	kg4klcH9S64S2ClUJsrNQAsCtm+YpXVt9NmacqX8bAxjyXNL+7bZKU3o=
X-Google-Smtp-Source: AGHT+IFsS6mZZM1uHew9julXnvtdF8LfW1GkYQHzHZQuJWN6t731MEWh5+TeuvnzOHEhLMh2wQPqyGR7OkOnU7miUm5SDcUH+55/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8d:b0:3a4:da7a:15a2 with SMTP id
 e9e14a558f8ab-3a747ff9c5fmr27880305ab.5.1731672242390; Fri, 15 Nov 2024
 04:04:02 -0800 (PST)
Date: Fri, 15 Nov 2024 04:04:02 -0800
In-Reply-To: <20241115115401.3701-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673738b2.050a0220.1324f8.00ac.GAE@google.com>
Subject: Re: [syzbot] [kernel?] WARNING in posixtimer_send_sigqueue
From: syzbot <syzbot+852e935b899bde73626e@syzkaller.appspotmail.com>
To: frederic@kernel.org, hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

security/apparmor/domain.c:695:3: error: expected expression
security/apparmor/domain.c:697:3: error: use of undeclared identifier 'new_profile'
security/apparmor/domain.c:699:8: error: use of undeclared identifier 'new_profile'
security/apparmor/domain.c:704:11: error: use of undeclared identifier 'new_profile'


Tested on:

commit:         744cf71b Add linux-next specific files for 20241115
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=75175323f2078363
dashboard link: https://syzkaller.appspot.com/bug?extid=852e935b899bde73626e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17c582e8580000


