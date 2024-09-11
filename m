Return-Path: <linux-kernel+bounces-324574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D54A0974E76
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1033A1C21745
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD100155398;
	Wed, 11 Sep 2024 09:27:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DB216DEA7
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726046826; cv=none; b=FcORFA5HYUpmVQTh4Q81e5ouoHfCi5+go+0euBpx9A608xuBjwYjfojh6j3SQMT+LImnWwJbZ4R1Y7RBUg2KXSZpygozirlCGMZOMkom++QsiCq+TbmRaa6HhN2WDsNNRudiJxUGqu2OjpLUBkTafoW99rgW5dWzi+xF5FPP2cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726046826; c=relaxed/simple;
	bh=GyWq/98TjEtVM/W1wAs9O1yLGESTt0kImb7E2rBHU+E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MUTAxCb5zSVAdRhbzt7ao6uDCtCgptDXmnFvQwOsRDwc8487NPbwH9VNa8Br6sXAmNekQUw5YsHGVhfeq9Y55G2TUZC4nYo/Z7zpUIX4phoFgeAZ7f7hI7YB/ZVThBd/Ol2x9DwS8a/VqgVe/7dHT+Q9WaAGXnRzb3SdmOYZOB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a04a91237dso27160235ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 02:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726046824; x=1726651624;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PQxVkx26ZzumOnlrOYUsyrJ7x6Xp+WsLa+JYdfrCMw0=;
        b=DincrE1HmAy19TBF+wiGYYnPUHL5M5ya1qAjhwpKD/6PmF2K0I0GX5LTDKVI+dzgCO
         g3bFSIwCZD8F8mOVhJ7qp2F2barQEYeRbUZ3rVWHTy/EATNlc2b6GRIhAauYfd1AfGZt
         0HuPY1+cZnbMTnUHpB35xog0Dj4bT/1ZwBgeCeqBtXSCy0wHDpQN/9k+yQwyV4YypGBk
         2yswrPfOMz5jUmMjNsnI8q9ZXL7SlaV45bpcuZdMa162InWU9jJWLoy8EUgDQb21xX7u
         PysscLME8EKmOPWGhbSb8Vo3Zyvh/4TeSgVsQ1SMxgHekISgHGdNovcEcMVwJ05X5A0L
         ycOQ==
X-Gm-Message-State: AOJu0Yy9kjD62CF01/zPG/D+bLB1rYpHWin1S/B2IngTGH2xsx7KEWk5
	XgvUNcXjk6zMoqT2SQnxGq7K960b4StiLRdWDi254pvo8eVuRHxVvjm1BhNz6219nvMJWnr3mct
	TpQe+BUpbkkDdk28knD8wR8/YaaeoA1IRB3N565zZvTT7VBKkBwSqv68=
X-Google-Smtp-Source: AGHT+IE4VldLLWN6bhbZLZOQgPzhE/VUqLjk7ZIIq9A/SorHWx0n9L1p/6kGh/kAVA9lzMkPQ0j/leN4cM/KZaqF+5v9MIdYYo7+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca05:0:b0:39b:3e01:cbd4 with SMTP id
 e9e14a558f8ab-3a0742302e7mr27823375ab.14.1726046824195; Wed, 11 Sep 2024
 02:27:04 -0700 (PDT)
Date: Wed, 11 Sep 2024 02:27:04 -0700
In-Reply-To: <20240911090609.339939-2-matttbe@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d273bb0621d497b1@google.com>
Subject: Re: [syzbot] [mptcp?] possible deadlock in sk_clone_lock (3)
From: syzbot <syzbot+f4aacdfef2c6a6529c3e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, matttbe@kernel.org, patches@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f4aacdfef2c6a6529c3e@syzkaller.appspotmail.com
Tested-by: syzbot+f4aacdfef2c6a6529c3e@syzkaller.appspotmail.com

Tested on:

commit:         8d8d276b Merge tag 'trace-v6.11-rc6' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b407c7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61d235cb8d15001c
dashboard link: https://syzkaller.appspot.com/bug?extid=f4aacdfef2c6a6529c3e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1292a49f980000

Note: testing is done by a robot and is best-effort only.

