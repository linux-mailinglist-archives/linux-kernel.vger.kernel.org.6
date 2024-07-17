Return-Path: <linux-kernel+bounces-255714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C60E8934407
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 23:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 027921C21A0A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 21:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846C218733D;
	Wed, 17 Jul 2024 21:38:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEAA4688
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 21:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721252284; cv=none; b=mbgXhJB5jqr3p0Z1/dZ9O+J9/4gkntA4usdNVcNmtqSoAn4rolkN556CLGWR4q/heTnwzYHceheNAnVHIV1rjcTzvTQ6KNwBqaDXZzr15sNNnVMsfrY9RYzJnpRwPHQxQsq7qQCSMo0nN3viavW05U3DrnapYPwsSCmxY3tVFyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721252284; c=relaxed/simple;
	bh=Sik+6tAmRzrclf+8LNn5m1CpZ8K+Y1sk71P01Tq2yQw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RS9ZpKUsx15A9n9wEOL8ewXP9YDwlAZGngfiNKEWdLaMRUOpSQ0F6eVJ1Lu9AjCdjwRhYzyOYSs9fRUe4jzpkBlhKm6Qt+3jHxa79A2eXsGZZFQqIRXqU5RXNE6/w9YNRpb156H6SkaHEjwIl4fRd5e/FlBrCR6hFQGtXNT4+SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-380f4519f12so842325ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 14:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721252282; x=1721857082;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V0Lqwzlmn9UKlbkZNqzbktT7KX6QqzoYEoJrVa0njiE=;
        b=Fbc4MRmAJ9Q511XSl6dQRtrV6HyJEwNJZwMY3VlSGyY/bxUp3Vxcm/z/KZ9QYoUgjV
         JXiHkC8bgufTt9l9+tq+XwerP8Qhnrh+oUyCsMXEizDZMa1jYxfvQuDWX+qTw9EYqZuM
         8ArfiYSU8Vgn749QUTWELO0GGIgT1HzS7Tyy4c4S52yceWKhhT1WfH31ODIGtI6c5eto
         jghy4jMG+nL+mXnbe4PqTF7/TjVAw8ILhWdEIvr9fyS2ckwfCYzC3qKkLQbiimCR3JyQ
         vINaNkiK44ud7QTZSeDLlIh0pVyflwPqOc8D6LrCyL4whyQ7gmglOtddT0h5LjJU+zNR
         jhTQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4QRkvoAPk86ak/xcL/kV4MyfPVP+q+EpQQA11JqksQQQWZMjqEDLm1NSZEnloTURYwAS1beNQQZvrU1oj/pAXfhteMp+rhTiXWx/e
X-Gm-Message-State: AOJu0Ywm+B7E1u3HJ6+2c5/KNspR9maz7FyVmb0IdKp903qs8QqO+mkz
	gN8KY3cDp73/ZXGhnsXcrEO1RPRuug1r6OP6uv7DCrxNHkgcULS5q8sfXh+m6OQfft6NpZeLFiW
	nJvwDO3IS+bh9yIvqAKzfr+CL58a2X26jEPYzy1J+B397XlUJc05wbF8=
X-Google-Smtp-Source: AGHT+IGtxyKkfYOZOe3FoMTYSThYd28Xcx/c1MGKA3HgQwgoYVL+VM50LQR61BvnXKP+ZcTb2Dcay072LC7xX1mY2IAQe74j5Inq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:178d:b0:381:a6b6:2dbd with SMTP id
 e9e14a558f8ab-395577fe4a1mr2316135ab.4.1721252281865; Wed, 17 Jul 2024
 14:38:01 -0700 (PDT)
Date: Wed, 17 Jul 2024 14:38:01 -0700
In-Reply-To: <tencent_BBBACDEC79E66D882D916D6C9434E896EC0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d46b79061d784679@google.com>
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in lockref_get
From: syzbot <syzbot+d5dc2801166df6d34774@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d5dc2801166df6d34774@syzkaller.appspotmail.com
Tested-by: syzbot+d5dc2801166df6d34774@syzkaller.appspotmail.com

Tested on:

commit:         58f9416d Merge branch 'ice-support-to-dump-phy-config-..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13a8c72d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=db697e01efa9d1d7
dashboard link: https://syzkaller.appspot.com/bug?extid=d5dc2801166df6d34774
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=136131fd980000

Note: testing is done by a robot and is best-effort only.

