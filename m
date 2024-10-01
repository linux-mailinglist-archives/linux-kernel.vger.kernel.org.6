Return-Path: <linux-kernel+bounces-346409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 439D898C462
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D446282D5F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63601CBE88;
	Tue,  1 Oct 2024 17:22:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A5F1C9DC8
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 17:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727803326; cv=none; b=L/JnrlN+Nr/hKhOYw1vhGqP5y5kJtVnwh8jZx/Ub2Pc64tsB9DhlegIMzUw92jGhh2UTymOQXQxc4CWjZBJZ/3lgF2SFc0uNW4TmM3WI4/UC8j62/8OpYFNnSCGCI0MuUpcFd/HGV1ffvA5z8yxkgexNiw0w0udn4TQKRmlUcsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727803326; c=relaxed/simple;
	bh=o3d0hdAZf/irpw7oxAIgUO4CV15JImGZI5ckb+IJ07E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hJKZpQk6Z26G8xPoLyx1CvTqSdBJ0Mf/jXrhgKDGwff1nMg2BADU9i+ECT78+1f90CM8/+9Z2PdYj1mdPgtiIqDmCCG+5SS3u+ABafQvYT5Usm2/XriE9sfGXA+d3SDen1uIgwu06p80tpNs3f75U166oTJJ9lNCpa9cPzExTeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a0cadb1536so67599215ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 10:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727803324; x=1728408124;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1DtdhCG+8L1IQigBDd5DSf/JOs770e+ycLen0eSt3Yg=;
        b=NnNOrBnaM4fdkKsB+LxW9SBuPR02AL+Qst/8fGO6Ebbr2ThGrL+JHE1G/CcEvnHkok
         mWtEiNEDfu+VXNY99TScAFkvq6Pp1bk1x+MpbDfTtF1cY29yyW/jS29HLUdaiZpt8oxL
         SB6p5LSP+5Mvcnxv+1K9Js/cNtF+HgKtpkc+an4dIrEE6jrQm+CeYekLM5fFf71pg7H6
         LhbIxiNWoB8/bmueFOuEXEfCQk57nwHGOYw+PRhw9LWJmJ/gRH3U+9yQcTMpw6n3QzU8
         NUvviYD3BhEuV2CiTcR44ArdwNEf82cmTCw6z6WkCpcJNb+9mxfs3YqqJyJf6DD9dTJH
         WxdA==
X-Forwarded-Encrypted: i=1; AJvYcCUxNnxxmks9y9dcKhz3hrMoHocaDLX5QDcZ+rJf11Obk5LsMu99/drqpy0eWunxyAWT0JoB1xMJPImMjaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwPM3SazN/HP/my46FXaZYAUyx1IQCvo01rrQ52NMJ9qcZEq48
	ybrYwoIdBECNUOiUaNWkzO65KeqwIfYhtst4xS7Ym4dkA+SUafXOF0viD0d2wOOP3E6RWxBh4T3
	Uqd6i9h8YVYK/6e8S24VNDUl1vbnCjJASESH9/KV6nqCjXdkg8x6m3YE=
X-Google-Smtp-Source: AGHT+IHtbclfBMf5/RpPJXd6eXpS07wmFK4mRnqUEi9VMI8PBduQCpvu58rPIdnIpiYxXajDgxqUfHxhR/kmnwnygvhJLIWl/0lT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a63:b0:3a0:c88c:e674 with SMTP id
 e9e14a558f8ab-3a3659133e4mr2970675ab.1.1727803322800; Tue, 01 Oct 2024
 10:22:02 -0700 (PDT)
Date: Tue, 01 Oct 2024 10:22:02 -0700
In-Reply-To: <CABBYNZKKq3=RqD5Y2z=qy3Mv3Y8J53E+UEUi8bqWVAfx6CXGRQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fc2fba.050a0220.f28ec.04c0.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] WARNING in hci_conn_timeout
From: syzbot <syzbot+2446dd3cb07277388db6@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+2446dd3cb07277388db6@syzkaller.appspotmail.com
Tested-by: syzbot+2446dd3cb07277388db6@syzkaller.appspotmail.com

Tested on:

commit:         e32cde8d Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14d28927980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3fccdad3e2ebaa0c
dashboard link: https://syzkaller.appspot.com/bug?extid=2446dd3cb07277388db6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14060307980000

Note: testing is done by a robot and is best-effort only.

