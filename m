Return-Path: <linux-kernel+bounces-341250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CDC987D3E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 05:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E29AB22D16
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 03:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C34123CB;
	Fri, 27 Sep 2024 03:15:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE17D16DEB2
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 03:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727406907; cv=none; b=dW62Wgx69LVvZlIN2E8HH3kE56xp7QXn9gWuqR1J11rX7nAcch+aBlab5gl1QR4NudmQz4lwYTB+0l59g+/cIDURp9SJ8DiOaaIRlM++42x9QqQ9axwsT4kilNyIalvsw9xloaurIGjRc3C/aeKq2kwAmmdVvHjeRVwpsc7CXrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727406907; c=relaxed/simple;
	bh=IfVUnQzvsU3erRjtyBu275kBik322qL9HgyBtPj5+e0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iLDq/3H6RQSUXJ2i99dD9KuQ/7AztvPy0xv1qPQFnpLGmZWETPe5XRlYKkkZhApQTw5W+UH3NwTHSrOkyCK4+D6WFLUy67O+Yg4NFwb9x43SUlx6zj/2SdKd2FVx8047mObTy5azRHLlLBDhSj0yt53xK89ZDK7qct30RmCdxdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82ad9fca614so252852739f.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 20:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727406905; x=1728011705;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vtM/9D39coALiNrlEfJyi9fXiC+6RfG7FZwDHO74uRk=;
        b=SD51iOnrzPxXRKA6E3+wTE59HV0CdYGYJ3PLmT1clwW50Rc61yfUaSh7hxoPanqo6x
         n1A4uVD+POl+4xvy0W5E1YbcxYvsEb9b5aORdt37M1PL2hWnRN+FPHp8w+e4AgCDgtB3
         pgvS9pBeCJHu6IHyc/e3kh0qpW9CtazckrypINMWPd7Qt65ZDKac4gOUJKExRWUB1Rl6
         c5mMDbWb4iJ5rrHl5uZqAkr1X0QCEgJEFfpwbTRufxq1UF52VwxIfbKO7xkkPmdmp2ao
         wasRVVV+pnWYwNh6qNzgHpOpnY/8hhI4u/Z8vNWDDI9XfyKIhZfbAe4Liw3Md9lKroA9
         R7rw==
X-Forwarded-Encrypted: i=1; AJvYcCUXW0aYleuTIELVL8NF22a90GBfOTxyvuZTMcRrMcGK6qqt7HahF2oWxqXE9axBHzuN6ZHo7ZyN0eMgy/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO4xwkeYkD24EgJcz8e2y3RLoHlJCW/wxa7Y09GNq6kO3A0VQz
	M//RV+IONCYoNUF3qmcXrhkzUtnKhSe/v2gCV9TmcKf1yQq1pmGwMIeOJe8pzQA5Adx1f7CnheI
	LHtgHGbM5QPYMYLreTHtrXpHzhKg5jukGP9/6gQ/w9fXpnqndpfkhsNA=
X-Google-Smtp-Source: AGHT+IEGTqjsQ/oJn0hD8jsSMGmR0OsAiQuVDLHvFz7nHX7qFlEYhJSBTm3BXyVIJl2UHJPPKpQQN5NyVhSvM9iZaIEwTd+rMxZl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1582:b0:39f:5521:2cd4 with SMTP id
 e9e14a558f8ab-3a3452bf444mr15452985ab.26.1727406904713; Thu, 26 Sep 2024
 20:15:04 -0700 (PDT)
Date: Thu, 26 Sep 2024 20:15:04 -0700
In-Reply-To: <c3d3c52e-ec5b-4238-aac7-284a3838be90@126.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f62338.050a0220.46d20.0009.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in bch2_stripe_to_text
From: syzbot <syzbot+f8c98a50c323635be65d@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	zhaomzhao@126.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f8c98a50c323635be65d@syzkaller.appspotmail.com
Tested-by: syzbot+f8c98a50c323635be65d@syzkaller.appspotmail.com

Tested on:

commit:         1ec6d097 Merge tag 's390-6.12-1' of git://git.kernel.o..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13ffe59f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6265dd30e362bb47
dashboard link: https://syzkaller.appspot.com/bug?extid=f8c98a50c323635be65d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=151daaa9980000

Note: testing is done by a robot and is best-effort only.

