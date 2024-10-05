Return-Path: <linux-kernel+bounces-351638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 852F3991418
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 05:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7A3D1C2249A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 03:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E66C1C2BD;
	Sat,  5 Oct 2024 03:36:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE2E17753
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 03:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728099364; cv=none; b=IbCTuDTzEk6j+FzBlpfM+zygl/j+JJDh9R8VYkvOpxakKNKz7nsMPDfejh6P3NKlpag465I21B9XQHntl/OWps+fu2b0pT0OjttHEZ3VWDfNYH5WWtPKAvtwUxdbdtUNlF3vh5Q1JN+lWNDYkT0eaMYMqDeXlQYlHRe0/QPtgg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728099364; c=relaxed/simple;
	bh=AObRqmaNymgcmWw1Ip62yJJtA0tsr8kIJFHBhWVE30M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qy38qfwPpncEPjhQEaHMJz5U8XlhoyEurdSi200pezIDooa4cGZ512TxR4ppTJ1G35lBVerFpPs2dDz7CejipEplFeexDtFXWS9+WlGuA8jKh92rH1NI8VPDsvMU5SzIsPOXqr4eNy3SndzhUJkQzn4d7pg41z3r9qu6RkOFEmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3479460f4so25634465ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 20:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728099362; x=1728704162;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IsdPvDKYEB2QyMzsxHZzApiQpGk//W+vqw/gbb9OsB0=;
        b=g4wDX5stwxQpZ6gcQDUhzhuFZh2ujIrMxsZK/MZ66sqkfpUxuqLQDwQnIhhFVYcHW+
         gIEjBr2z5+jWOKlWmmq7AkRd+Fa6wpJo4l/Fg9ofHs88Z56yVLYE1riFj40r0VzmtcBw
         9t8xIa9hbTUD1WVxDnAzxZqOqnC8gOPMYQ3cVNURjb6rpFSCmKw7Dp95uafIV9C8Ywpm
         fYymGbefZLwiHVdMs4iIV9qP0NhvA+QR3+ykjw6VJBF4jybJp7Uc4dXTO1w9zkDj+qS5
         SUiJTv9rfbUebj7yymtkiMFVeBkUwwIWLirRXyYrxdA3zA1V3cuHzkk2J/HfR2PeDilP
         pgkw==
X-Forwarded-Encrypted: i=1; AJvYcCX2tZnI1/rpOFAQsDa7yfui9Xw4pwDHl3BV+jpq0Ovd28eYcCzzDrHrm34M6hAf2Hec/XOM3Eify57YjLA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5LjjPpgHEl2KwTlzWiZsWMDAsRkAP+TWL60xCwWaAdywVFeeG
	xA2mEGDyXjZSpKt6/VYaVPQtz2HvqsQ1Xk2UoX38gb10zuyjWY3it/ahW0hrvDMoQA0w4cf6p4W
	sV+7QKmAobmuIrm2fTo5gQwYfhDqd3shGrfY2gjgrBa398ko92j8/+q8=
X-Google-Smtp-Source: AGHT+IFK+DSY9Pp7mxc2wU4rpKROVsGMn7zK0goHHaG8iDtHHfLn7xL9yrphLT+mvcldI7vyoF6VR/1dRY1ObOKTHY8bxfziXusv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca47:0:b0:3a3:449b:5989 with SMTP id
 e9e14a558f8ab-3a375bc688amr41409765ab.21.1728099361963; Fri, 04 Oct 2024
 20:36:01 -0700 (PDT)
Date: Fri, 04 Oct 2024 20:36:01 -0700
In-Reply-To: <CAGiJo8QbFa1ygs7e3T8uZbvRb+e-+Eu8UBef1k6ZLkr5eJ3x1Q@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6700b421.050a0220.49194.04b0.GAE@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in gtp_encap_enable_socket
From: syzbot <syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com>
To: danielyangkang@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com
Tested-by: syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com

Tested on:

commit:         d521db38 Merge branch 'net-switch-back-to-struct-platf..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=178f1bd0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f95955e3f7b5790c
dashboard link: https://syzkaller.appspot.com/bug?extid=e953a8f3071f5c0a28fd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17cb1bd0580000

Note: testing is done by a robot and is best-effort only.

