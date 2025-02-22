Return-Path: <linux-kernel+bounces-526940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9FFA40565
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 05:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A46C19C0B37
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 04:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FE11FFC65;
	Sat, 22 Feb 2025 04:04:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6910B78F4E
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 04:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740197044; cv=none; b=MQYAcV68xhuS4GWn5C28npe43sFzN597xPVgcMXnovucnY9ZqCo/YRRKeqrLevWUA9Q2zUM5BzNRFEXEJ5j8VCFIYRcwQfgDuGj9GRzd08yi6VD6N/Zq8JB8UazU9SdNUUKG9b2bsda+YluLjC/2UnChg/u1n+X5PmcjKcbMLh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740197044; c=relaxed/simple;
	bh=e9ZKIq01vlaqXK24skkwVVDNFBYSqe+RANpecLulJQA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eDGD7Zokaqb4Wo7PAEFF5DqrSf3JKcy4oHs2BZolbPhAZWrqURAMNmv5FzQ6LC0WJlKjrvQAWSln4C69E1AjuHiny1UaQ4OZ9mVPlC9C576dA0dkp9KVSH7KOYOe241THfbrZ+KpwXvAQ9isIFRP+LA9Pd1JxNrCsAPBf6nRB+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ce843b51c3so52149455ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 20:04:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740197042; x=1740801842;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4KvQ4LWAz+MvefW5BkmXzmZ76S8gawP0zD5LoAU9FTM=;
        b=QJEjJLybLRx8zvGysv3j0QZ7KgncorZPh7z63GacfUoWnpjzEBbJf3cV5LDP6OG7jk
         ZA0z1HVBaLRPTOuUWtp3dxiFJxfCWRXN7/rjz+ju20phd5gHwFnHxPoODJ4mLY4mi/GQ
         kzd8f9l5chiTwGu8D/Cs5LbcINgGkyblbHshR9s6Ih0QL73CCH+Dht25vzhLiXu738Bi
         wnjejw/xps/XAU9HJp/XQ05DejSEFE2B4fKoPJ68wxSt6jJsTBRIFyw8kDpUc4Ttnq9n
         5OMFzs4F/wLmi84obZ8PF/HikCLgVDcXO3O/TyGe9T6M+Y3UmwYxO0roiBeZxMAT5oie
         MWFw==
X-Forwarded-Encrypted: i=1; AJvYcCVPCgGetTNS7gpjfvurXpbtS1F11YF8A7otu44iRphuRi+9/DV0x7EnAetkkH0qzhkseb5nIrldX3uDXyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeXJhWWrb+zs3brTPR1EmnFZTPGSknsD46G/ekfLZeJ72CfD+w
	zu/esE09gRPbic5/JgqDqzsIkxMOCMifpgyFAqoRFRdiWTE7Rg9dRSc2F9mBsTckteqpBFxBEos
	+avghNWal66HXkwnBnSRBn863sz6Lat91IZ85YIKM+zW5xXcfHbTrTIA=
X-Google-Smtp-Source: AGHT+IGmE9OMW6udNuxsoUrPzdz7yl6KOlEE6cZ5I8YW8BwyQ4vOGaWWmMDCTHVGMkYVBLI5nikt8BjfgGuWsu+Ik/Flm7oNVttE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:138a:b0:3d2:b72d:a502 with SMTP id
 e9e14a558f8ab-3d2cb5450f2mr67597175ab.22.1740197042539; Fri, 21 Feb 2025
 20:04:02 -0800 (PST)
Date: Fri, 21 Feb 2025 20:04:02 -0800
In-Reply-To: <67b2ed82.050a0220.173698.0025.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b94cb2.050a0220.14d86d.059d.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] WARNING: locking bug in start_creating
From: syzbot <syzbot+d2f57500f15e9df86c90@syzkaller.appspotmail.com>
To: dakr@kernel.org, gregkh@linuxfoundation.org, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 14152654805256d760315ec24e414363bfa19a06
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Mon Nov 25 05:21:27 2024 +0000

    bcachefs: Bad btree roots are now autofix

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=115bbae4580000
start commit:   224e74511041 Merge tag 'kbuild-fixes-v6.14-2' of git://git..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=135bbae4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=155bbae4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e55cabe422b4fcaf
dashboard link: https://syzkaller.appspot.com/bug?extid=d2f57500f15e9df86c90
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10a6a898580000

Reported-by: syzbot+d2f57500f15e9df86c90@syzkaller.appspotmail.com
Fixes: 141526548052 ("bcachefs: Bad btree roots are now autofix")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

