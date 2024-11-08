Return-Path: <linux-kernel+bounces-400969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2926A9C1480
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD6D91F220EA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 03:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C951A5473E;
	Fri,  8 Nov 2024 03:21:24 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52813AC2B
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 03:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731036084; cv=none; b=F7FU/ySGD0LsdLWaOKpwRW7vRr9fFSNAIZ3bRWbJ+Xq3Cg+7BuAaF/wI7eoxvKJu4z9rE1IpBkviasgcTRI/ZIO3/Zn3QNiB7I7uHPLaZ9B5DpuStw8XD1HyjTHzwEBz41GdhNevMzBp29+CtBLvzAfbHMd4fW/MJzSMOh/3b/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731036084; c=relaxed/simple;
	bh=I8ZWVMbXdOCAnMhVFqzWalAfu8hk7zYS2lLGuqtu9kc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LCC/ozqIBNysjmDkxnqUt5CX9xcBlyll41wahHyiHsRkPdGQPkbKbQfm3wVjtNHcD1ButC1EKNn4kp3CZqe2buEW7rEQLuzhnEmud0kO80qtz0y4Ernq9J03erFjODi1QDbLpZusFpp42G1hksL9YrfMX8PK0GcVl2iDWpkWSpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3e1ef9102so19884945ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 19:21:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731036082; x=1731640882;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NbPhtWGffHaY8lZT0rLrtS02zuRE4KpaAMyDDzVNCjY=;
        b=wIjAKKPGlZjWhPBVdpcbidw1W+JIMQfzj4mKUra4bQF+QZRiK0L6vBz1rFXoLK2KNj
         7hbEYQAjNRnsNpGx35C5vTA5a0EhDourrTJb4tlzLmMReSOn/wn3XLBtBTRAxVdoDFZD
         J8QIoLUVkeDrqLBZlYpKNTmgD4p2iYwZllBqwVLRFi+wM+WIVG/qSLEw6kSfgmsZsvQk
         IhYpdTSXjiDnwBgzl52jUVbaCW0pFqbctlUm+QuhbEfKLn15lgkMrTksrBcDKJrZfDyD
         2oNamTwaKHbf6YD6zLE/KneEto8n72sN5EN+2xLrdqnyULqR+Q9XDni1qPEQW+HYkey7
         SfHQ==
X-Gm-Message-State: AOJu0YyJIcbIvLAngKFcqn+OqQlyufCR1u21K6tukhUfreIzEsKY9rb1
	GFdPsQbVERjPEWtj4GdHlDB+LqzVvqGZXb80Y4X6p0sZRF3kBUhldHuL/pEK0mVS3+HKVytCo+C
	Or8ynj+a2gYsJmKNIHNRWrFK8EfKzwgsPjebaPoMdh6KeyM8JTFX+pBE=
X-Google-Smtp-Source: AGHT+IGt5fOh5ITWsMsKFkQJ9VeArvlRGFbL2j1VRf7xhlUKc38LGaU+wrnD7ZfineVivEoWq5SC3nAGsNgsPQpnhbZ4hLa0lG4Q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1525:b0:3a6:c000:4443 with SMTP id
 e9e14a558f8ab-3a6f1a58d55mr21568105ab.20.1731036082164; Thu, 07 Nov 2024
 19:21:22 -0800 (PST)
Date: Thu, 07 Nov 2024 19:21:22 -0800
In-Reply-To: <671b3f75.050a0220.2eb763.00d8.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672d83b2.050a0220.0db4.01ba.GAE@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+b17df21b4d370f2dc330@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: Fix missing validation for bch_backpointer.level

