Return-Path: <linux-kernel+bounces-317962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 319DF96E624
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 01:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A86B2B23D89
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 23:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7FB1B86FB;
	Thu,  5 Sep 2024 23:17:04 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183361B81D7
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 23:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725578224; cv=none; b=AXV/GO8qvbQfLfCQYEYinCJpDIPDqujk1SN4UI8GF3HrCgq/9saXzmqOM24fGvYSB0vDR5M2bVGkBq0BDL0MfkCYfkHhEGHTzXENQJVHXVWItj23Gw7hz9pUCby8VwjFUDd2LNfw56iP2zn9aF8RExbuGiuOAb7F7EFTxEdrDr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725578224; c=relaxed/simple;
	bh=TU2g1r46tOkHirSoaBhuupLv40CHARU1G0WHso2xWb4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ttoPag7TxA4Y/LmicVzM9VEglRaDt2UOIA3h+HnOI/XugaP3Ybl2l1oV7cIjR/xMqE79MmO4pvXgFkiJpLM4/IYRg5QBUdoxLqwcAoQ7w2msIuCacUwQpuBmo1dzUCDTH2+LnXLX54kUwcNju6jpNfYmOFNPQ67sybQ3jH56JVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82a1fbaba4aso490696139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 16:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725578222; x=1726183022;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0mvoOSwrRXG78QWyXvjHcNKadITtrkSUJaHv2Ry6p6g=;
        b=ESsZ0LVnRLRljVoG8V+5U1/L3tI8zAinrLkFnmeYL13KxROniQcl0Qi1oJRI9Z3gQ5
         h9K9U+QpasrYGgrwtuuyss5rCJ2wC85N/bjG8gTGeHjzG1QayimIMFNilpjpuKm5LTln
         VtCX3P7HghZaLlwr2KKOCzOLCJGE5gMhcVxZBOjoKb52fQOTe6RjVwSTNCrzY+dFGEOW
         2iSckfz+9RHrLF1Ik1NcKUq2JV5CtYGpjIvDsdFYcLgOrYKnjppUXjWeJg+DwfjE77/H
         HHgkjajXu+pxwcjp6mt0C070ZgsQTsvF/cmWXGfBB+KjB5MeBr/LHuJbkMZoW62B9UUG
         yK2w==
X-Forwarded-Encrypted: i=1; AJvYcCUOolXEaqL5sL4ZVw1dUlIyj6k9AIW4tdvMSSDCA+zjNNFo0HegXJpuVEjlIXx+qpIbecAEa65Q0/9ayQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0P4SC0O0YSds1FM7ZmnAJ8QaMjV0qqd7EdCLpQGpYFeLBwgb8
	9Z82b+pQUQ3AupMcOni8EIfeSwHZK9lWt2WAEnl78OTunNWi/w2u6nRWM6nuP/8Ahv2gELPTXR/
	hXpkcfZG9VUdJC4aTd4Y3HeI83uj6EJa37Gin8yymL0K2+VN1oo4ok8o=
X-Google-Smtp-Source: AGHT+IEzhvvJlfVZk+qkrX0umZCd5Y+2KhfBXd8tvRJMV3al6qWFjPLUZVfIcOrrbIScCMHEu76TG4wre2hVgUPrgtHoKzAPhfIg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:6c8e:b0:4c2:31f5:3137 with SMTP id
 8926c6da1cb9f-4d084611002mr39376173.0.1725578222091; Thu, 05 Sep 2024
 16:17:02 -0700 (PDT)
Date: Thu, 05 Sep 2024 16:17:02 -0700
In-Reply-To: <20240905225030.2026-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f5d0460621677cbb@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in
 unix_stream_read_actor (2)
From: syzbot <syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com
Tested-by: syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com

Tested on:

commit:         22d6adac Merge branch 'add-driver-for-motorcomm-yt8821..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1133d5b7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b4222042d2d7e932
dashboard link: https://syzkaller.appspot.com/bug?extid=8811381d455e3e9ec788
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11f6b163980000

Note: testing is done by a robot and is best-effort only.

