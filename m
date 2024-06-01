Return-Path: <linux-kernel+bounces-197673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E188D6DB0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 05:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18E52286067
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 03:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C404AD31;
	Sat,  1 Jun 2024 03:31:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCF27EF
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 03:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717212665; cv=none; b=DH/WbF9I9rYsNJoKkm0bM173FrQJoIRYUEFMi0ZWdzTWl7hYYyaXTmO1psYwIstW5JngFA4YfKm7V2QJqded4RCDyyi9C0FYsInHQt93lk7wFwHJuQ2CNpahXm1M27Axls0sr+k8lCuL+Mr+1vv6ZyBctUPg0hqLqSJSrl1ZnSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717212665; c=relaxed/simple;
	bh=vbtG9VHboHEtciKVfAs8sEeRuBsRAGplvzoBKpCSMQA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Up6/LSExctqk4NgDLmR7yIAp2kR/gttCJqj7jF2pVceCYRUsrYzUaoUPMNOD2DHLt4ygUHJz/2l1yKLB3Ux/Pe6MMBBD2cPnxyXmyIxqBDOzRPEA+OvVVoRZnSNE1Nj8dOXvO4kTLTDDIYYsNUlqVcQRKMs3u9TD6FQS+7sCmdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7e6e4a83282so322338939f.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 20:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717212663; x=1717817463;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sp4uO+jHSkMk5+ZppkJeRrr32I6pMzlw8EZ8yohF2bA=;
        b=aaCduDLS2bC+S21WPM79/ekzpABlR9EG0HDAMvOiuC1UQLA5FNyhkhmRWg5eV3cUag
         qKbLq7KaPRYewvs04rcBzTcOxyW3j9rXiIFteavf0N0kaPy3rbGe3lj2IgoXeIob34pE
         shyI03DRHSUQPS+aU2uU4DXesl37Mmzjd1nOQ99P7f47MoEoEOUknhKhtY4vFOR876kt
         uIukNvLvINb1f6NV8HcXZlxX8AHCuO8bnqJ7yfuqiLfiiEd4xYi6kkIkiN/fxIb9ciqf
         eVl+ag5oFw+5VxNIwhSPZ96GMYcsBkDMth/1FriWZ3kEOXazv7+/64pqugug6sV3TQYG
         e6RA==
X-Forwarded-Encrypted: i=1; AJvYcCXNCDlybu3X0Hl8gaHEscra7O5Ai1+tE4hQMHBQcEJTf6IrUfXD9vFPvC3j6r+mE9YLY0/bNjpepnd/x+P3Z5p37MqcYpT9PShdIOYD
X-Gm-Message-State: AOJu0YyTS8xs1h4Mu5Fex+wBNF8hnwEkL3Y+fcmvqWvBJY3LLllTQr51
	lkIRUDF/dshSe38V1l1QmfJENG2jFn4nr8AfXc/nnWADRlFS8bAIuvh5+nzP/iLasyQP6B3Jkwo
	jo8+vn67X/sLGN+WCH/6elXxU+oWMIZFJK6EY2POGC2yTzJ1mKFclUY0=
X-Google-Smtp-Source: AGHT+IEGxU454duOzQ5KQ2Jn8NIarcGj9H9JPS+Ryl2gA7c3363cfuVx6zNO66mKFRc4yiZVpxmmHy5Co2DN7YaSfrq08Ec5lNZA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:168c:b0:7e2:30a3:bd13 with SMTP id
 ca18e2360f4ac-7eafff67c45mr27062339f.4.1717212662814; Fri, 31 May 2024
 20:31:02 -0700 (PDT)
Date: Fri, 31 May 2024 20:31:02 -0700
In-Reply-To: <20240601030028.22250-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c56afe0619cbba6c@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in extAlloc (2)
From: syzbot <syzbot+13e8cd4926977f8337b6@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+13e8cd4926977f8337b6@syzkaller.appspotmail.com

Tested on:

commit:         cc8ed4d0 Merge tag 'drm-fixes-2024-06-01' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=139c8426980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9016f104992d69c
dashboard link: https://syzkaller.appspot.com/bug?extid=13e8cd4926977f8337b6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15851dd6980000

Note: testing is done by a robot and is best-effort only.

