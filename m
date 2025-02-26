Return-Path: <linux-kernel+bounces-532921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06689A453BD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 04:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE03A189ED23
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 03:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719CC225A32;
	Wed, 26 Feb 2025 03:10:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932D1225792
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 03:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740539404; cv=none; b=nCSTzC64+8Q83FxkZDqeezskyW0PgK3EEMBRlYwvk2zZ4Ol2Lpfuw4vfyFNFrVzj9mEZtAXAwr7+H9n8PrzbLjXx+NGboI3Otz+IEPGqaAz8oXXDFiSznf20XVvkuqk9b1gLpiHghdnrr/+JuWa/rvGUW+rMUccRxOnKsuITvuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740539404; c=relaxed/simple;
	bh=obw1Sax1F2UAMmx1AGGj5gICIC2sjWZ9oZPNwJG9rfg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uW326bTqP2Lg+hjfBSqQTdbhTlsmf6Xfpws/BZZ4Gsg+ePc8wo9wjqqcxbp9hdlqteQOB6joRV14+qgrIcnIpzMv/yoaiVlRgAnCJBjRPXDbRY6K/p1QyUlj5BJfbov+hBXQDujT/Z5TLZkl6TJ1cgrPtyUWZOQxTM9zBCcbfwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ce8cdf1898so53482585ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 19:10:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740539401; x=1741144201;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pI5OF1BLxFeb9UKkgyFgef27z30POH6v7L/twCJv8dk=;
        b=kcFTdbMEE5ctEO+KCuhzNDSAjRqJJxolRhXiuDlauWOB4ZYPiA0eGwdUxsYtUUMst4
         v8jH6xCBl4nkDeltqiAknsdqZdHfm//066HlWnBNWNqBE0Au7vcv98e2wzAscZQw8xDu
         5iIlCIBTYhBDrxdqfqvQrl3MJRWYs0YuxlWE7K+vpNoEZXpSqlFN9o7Ffr2kOiU3bgld
         D89Rr0YiqyV9Bd4+Rcifj4x56dBspfiZ3wPh6hWxPYmbjd+qun/kIaySFAb4HsWncEmd
         lSEtE3b5xZDdPz0+S5QxoEte5L3HiWjvqqkbGVqFp3EIT7vUBA6iZxamfrCWIaMlWZLe
         HY1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWmDcbTJqez/tRUrSnwx+WN9uKnW85Y3Lk5w7C6a7FBZyE9u1+CCh5Exn24B5U7NG4BIP0KjPvU+O0ZKA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYDT9v2XZdhfY7FkasFMfwdEIieri+xQGjfG1ObxNzmtx0cZEK
	UOqJr7WJubAZFjYJiqXNO6rYn/9wYBxyMTTezA2XGZ89E4lVuvKOuRweHnPODKrOU0u7LHgMPiW
	Z5J+QJRHBxcCy02heYDnf30wk8zj0QjorjbtCnd9Gyqt7RjgZXDQnbPk=
X-Google-Smtp-Source: AGHT+IFnMGyYE6QlMavrFjUCDpJgSomAeZEaIsXHwmEdGE2tooAFABLuqmpirNOy8eiHcy3O++/DW6WQtKh7jTmkVkdyLUwNiJ++
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:368c:b0:3ce:6628:3c4 with SMTP id
 e9e14a558f8ab-3d2cb44f8cfmr179693375ab.6.1740539401708; Tue, 25 Feb 2025
 19:10:01 -0800 (PST)
Date: Tue, 25 Feb 2025 19:10:01 -0800
In-Reply-To: <000000000000c27c9e06197d59c3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67be8609.050a0220.38b081.0000.GAE@google.com>
Subject: Re: [syzbot] [usb?] [kernfs?] INFO: task hung in kernfs_add_one
From: syzbot <syzbot+e4804edf2708e8b7d2a5@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, stern@rowland.harvard.edu, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 5189df7b8088268012882c220d6aca4e64981348
Author: Alan Stern <stern@rowland.harvard.edu>
Date:   Wed Oct 16 15:44:45 2024 +0000

    USB: gadget: dummy-hcd: Fix "task hung" problem

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17ceffdf980000
start commit:   2ccbdf43d5e7 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa0ce06dcc735711
dashboard link: https://syzkaller.appspot.com/bug?extid=e4804edf2708e8b7d2a5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ea2012980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12ba6851980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: USB: gadget: dummy-hcd: Fix "task hung" problem

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

