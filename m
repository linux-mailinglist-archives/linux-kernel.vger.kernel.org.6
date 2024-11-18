Return-Path: <linux-kernel+bounces-413517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E02379D1A43
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 22:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4BF3282555
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 21:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17D61E7C11;
	Mon, 18 Nov 2024 21:16:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D708B155312
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 21:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731964566; cv=none; b=Y871exdxVCIAoYU98AKTgt45Mi40sGKAfPrU3/xp5HYrlI0hvspLO7Er6pLC0fkIwFVuPsXC5rsLVJlkNMp0tImdmcjz0hwtzJLsCalcdGh9a8Iu7LYKEkQDs7O/LW/WVo4iAIFlfl+1iA9Vc4ROPgqnq2pgAWJxgy7vaBcbS14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731964566; c=relaxed/simple;
	bh=Yvbzap5GUns2E5E9yO5Z2P8Mk6Bcww+S4mM7sihaT1Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ecdn6BJJp12Q/BKMXb4M6furHFN4fIiWBefy9jzPtuP/N/Ti0Jzzb+oZfXpvf8y45j3qUNzTe/rD8LhPyzozlWdEVEBieeUxMkdt5DHFaB+pondjYfVJkGDR6QANkhreu5Hxh0hZO7JEtNbchUYa/g/IyFtHDB11uY75B/hK6Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a7162d1485so2811895ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 13:16:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731964564; x=1732569364;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dWyQ4VaAd+gfDclkQci7PLxjAOBd3WOZtaBU3RlnMwQ=;
        b=OGlM/WXccrWaLXuYhyIlfAYgU/VOowLj3WwQabYXSv9Ly/wnXC7aAD312ONnO70DlW
         ZEybdNzW57f7sHkXNr7rxd3KLcVPT6zGF7bLy7LqNy7YtecB+jLfKImpUuIGWnKqc8q4
         Bxa/cGn5+DvxYY5xtgvMf4rYQ+kT77ddcdOpnz1KBpuJ179r2J+JRcW5Qi1QK9iPUskw
         fPCI1Xu3H/kH8TLkkzllwP3Bv1tXeZArMAP/pm0EIDwNgr+aH5WFY62UnDF3SCsHsBjg
         y2AUMzv4PZQRebE5utuPYAPuG8BNtyOR2fGjg07AsLUAVrWyg0hZiGp+mEwhQpBNfX2A
         Y17A==
X-Forwarded-Encrypted: i=1; AJvYcCWxfvDVha+PnfOC1xmdAnD43u3Xi3ab85ze43caxyZKpmtUGbMLXmT1fOUI26LUalSzA0EZ4xC7tSHFyBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7z3or4C/mRhvookJ9RZSfrenLgF9JB21bwNV4Lh6eoMrwLzKR
	hiWvBvbNYwJO/dwmNcIKYTCZhGreoO2mm9cbRGydQnUF++T5oHj4EFzUyTsfn5Y/hpPwuBiQbHv
	arLCjT3nFoC1L3O7iwXzLHz22sGPnzxOg5DeavH31+GySBU42sG3Ppq0=
X-Google-Smtp-Source: AGHT+IE9CQk2sRP8pASvnozQPGwaKYk2aXALQtkAgaNI6SDi5oY9uYA4IP8fes48qRki3At1KbEI3eIXzOsbLK+59NdsW63ZA16A
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2169:b0:3a7:6792:60f with SMTP id
 e9e14a558f8ab-3a767920751mr48361945ab.4.1731964564134; Mon, 18 Nov 2024
 13:16:04 -0800 (PST)
Date: Mon, 18 Nov 2024 13:16:04 -0800
In-Reply-To: <CABBYNZ+=qNj8=Osdzxx2n0Yt0H0AjKtOAx__QkZw_Gk3a1ygbw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673bae94.050a0220.87769.005b.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in set_powered_sync
From: syzbot <syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com
Tested-by: syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com

Tested on:

commit:         d7ef9eee Merge branch 'am65-cpsw-rx-dscp-prio-map'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=111eeac0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9e1e43bf6b46a4d
dashboard link: https://syzkaller.appspot.com/bug?extid=03d6270b6425df1605bf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=120f4930580000

Note: testing is done by a robot and is best-effort only.

