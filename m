Return-Path: <linux-kernel+bounces-342911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB639894AB
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 12:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 911AC1F2170E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 10:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E671913D610;
	Sun, 29 Sep 2024 10:08:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E0813C90A
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 10:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727604485; cv=none; b=PohPKCpG+DpDSOXhW+6jNa8ZwMIwPNlHlLzWWIiW0AV7a6k/OREhmQb9jS4CTGzT2JpOcI7i6+ZYx1fsxlOh3lX/MepcUB9ZM5Psn00yaly0OZc3zeueQxkjSj7b6vuw9tfFDKWyAz+9uAcm7Ivr0Jutvff4Y/YDbn0O8uRAaJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727604485; c=relaxed/simple;
	bh=uyFFJuqyS6/q5DzCqh1VlPB2Nbj62Lp3JNvZ9XR61Lo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tW2cw7aPJCzPh3l26lXFf60no5YBx9ptg+XBh4kV1+xBLjCY9GpfVDSEU4KCAUg2hVm1rXO6sr9h7hIWAM7h3Uw2yP/a1lBBsD7cm6vg/HgCk4j6tm9rh59jhuUciif6TdimBvNBAt8XzGCFL5PH6vR54P2M554QCF9H8d4qUi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a344da7987so30705315ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 03:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727604483; x=1728209283;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PndFfLIYEEcEXuP3de+9M6uglSy+iPcQ9Zj70WP3j/A=;
        b=wDjYmGUXaTma8B3a8c8G5t5JO2GRJTLeow4XHU/pXi3JYJlCzTnxPBqXwsZpsps4B0
         vl2Hk5+IlY6gyNYUfmlG/BYRD/bM4L5JBFChTzCU7jLGHxe01hBbLHSisLWukmT+AIX/
         gG8V8Ss+gjsVJCcamRb+78CRa7VjpU1tKVGA0ByVxdqCRQng4+Wv4TdtF7jKIgXE8rVM
         2KXy8aps+zxEP1riUwqO/ckXo8bShSJi7o2+P9zLbijzrCcYayB3N4AvHuVdZOugOZAu
         1jWZccaKcFUK2dpAaQFlkTQkj6EqSQzB0eJrYlIRzLJZBWGYO0GeGjp7NgyevnK8Djiz
         o19Q==
X-Forwarded-Encrypted: i=1; AJvYcCV07Lc7ZWztBPyijzNFYO5HySN6AX0XuonHbGz37lp5ydEV/HC7UoZ9ZWFMcbU3bdH/FjF816aCr96FkL8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzeexd4UGt78JtduFIw9M/jcS77Kj8Ll90zgmm2lOxFCUdGvjcl
	clixWGeuJZmpYv9d+GfKVEHI2TF9LYXA2N2Sawux2EK9oD13dsAOtJoGxh0MYfG0wrSVilTjxnR
	L2VoOL+hZNVb7U1J9u1A0yBgpfmTOOx6QQFbwtS8ZFswh7h/jLyqcpzk=
X-Google-Smtp-Source: AGHT+IH+yAWkdToS5KkAQDi0e7SfrgfDQ9PrbkICb2G8U0wy49SJSaAdTGgQmi+bYRKNW+CeQ3D5GC71YXjKLqAC2+PRV8HdxTOz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca0c:0:b0:3a0:533e:3c0a with SMTP id
 e9e14a558f8ab-3a345165300mr79132255ab.7.1727604483187; Sun, 29 Sep 2024
 03:08:03 -0700 (PDT)
Date: Sun, 29 Sep 2024 03:08:03 -0700
In-Reply-To: <20240929092626.205369-1-dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f92703.050a0220.4a974.001e.GAE@google.com>
Subject: Re: [syzbot] [bpf?] [net?] WARNING in sock_map_destroy
From: syzbot <syzbot+f363afac6b0ace576f45@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f363afac6b0ace576f45@syzkaller.appspotmail.com
Tested-by: syzbot+f363afac6b0ace576f45@syzkaller.appspotmail.com

Tested on:

commit:         3efc5736 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14decd9f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c235b61c0f792dba
dashboard link: https://syzkaller.appspot.com/bug?extid=f363afac6b0ace576f45
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=107ff6a9980000

Note: testing is done by a robot and is best-effort only.

