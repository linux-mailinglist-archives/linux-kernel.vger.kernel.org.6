Return-Path: <linux-kernel+bounces-335962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7B597ED30
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D9B21C212B4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 14:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C0D198E81;
	Mon, 23 Sep 2024 14:32:04 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CAC1392
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 14:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727101924; cv=none; b=plHBHY0V/gsf4z138UCq5hHEMsvjCenmM4SVN/6xD3x+pllpTE/t8en5lIojFmzkEEDH4JWpgx6nlfk/bF6Em7p4yRur86QU+D5Vkb/kg9EJtFyuWG8+udjCJJjGfCK7C/09SPUpw4fNu0i92g52qkN2ro2iIBpsKFTAYl5rjNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727101924; c=relaxed/simple;
	bh=KPlH+M1QNYQMjZRdvjSVxxxodzvT4Pfe7WzQer9rYHY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gHmYnGWErrv6pgZ/i3EEuYOVfC5B/TrhlPbd1ISY8MZDG9U12y0i10NMrKgjSOsQOrTDlUB38ntugadjfurysOyIwfdbirDOKy6ng3v17sJxw8jaseDrfPw92BfYo4/MXX0y07ayJMXuyXIIrZW5nkgLedi5k0joIBIAoOS4tzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82cda24c462so456872839f.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 07:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727101922; x=1727706722;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3E/19JOdnuHAtShY1CLrK2NlHMvBb8jLpklT15JwURk=;
        b=mQTCOFS4jySIZ1ET58NBRpDcFxf70fkxMW5uI+GcQVwsCY9yMlA34Di1UHT0UxNT9c
         eYfj50iSFFhKReEzWbdZcvg6bZdyJJwiyFcay/VIuiZI+GHkJVAZMMUUzNqMD+MEP3s1
         ZKvqbAPeSE8NMppK8wLHyuePja9o1ZaxxkRlr/SmVH7iMQP/pQRPeYbEjK5FiNgii7Hf
         evlxfMbPPu7Gciupyww8+kBAdWrLjfFvZ68CZIuCrwMBeRxq2/bRN1b+XEURGTmlk4ZD
         y6ZENeQErp3ys4+25hIDgdIA1+HLRrMHcPp6u9NMg8m9+TPUUTUZtl4KTr6nAiTj/+X0
         0sAw==
X-Gm-Message-State: AOJu0YxiP3JQIwxJER6bYJFHUHwN997diJ0CjAFAXKg5BM/kiYtxI8wu
	a7hkVxnRSEz/Wun0zbbV+FN5vhD4E7bsPtZheT7lb2kg6tnJRBZioNqwou83vf7W2b140KdaKUG
	vSuvtGYSWs73XPJIveMgkNnE05x8DRhuQ/DQOKll7A3efZR9aT1M9ZjE=
X-Google-Smtp-Source: AGHT+IFz6dWjjLfBu/w4oCzULmbh5Lo62QS6q7yiYB4ybP+zbVfGNT4GejyPGKV6qoHboqJ+YTm9JP03VQ0OZERKYSTeSy8jOdC6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d01:b0:3a0:ab86:9293 with SMTP id
 e9e14a558f8ab-3a0c8d7408fmr87292395ab.26.1727101922030; Mon, 23 Sep 2024
 07:32:02 -0700 (PDT)
Date: Mon, 23 Sep 2024 07:32:02 -0700
In-Reply-To: <CAHiZj8gEHCy5iSisnVkYWijSO2uP+VVuTA_dbaDCoTA2B8cFrg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f17be2.050a0220.3eed3.000f.GAE@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfs_iget
From: syzbot <syzbot+18dd03a3fcf0ffe27da0@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, surajsonawane0215@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+18dd03a3fcf0ffe27da0@syzkaller.appspotmail.com
Tested-by: syzbot+18dd03a3fcf0ffe27da0@syzkaller.appspotmail.com

Tested on:

commit:         de5cb0dc Merge branch 'address-masking'
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16a4619f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=547de13ee0a4d284
dashboard link: https://syzkaller.appspot.com/bug?extid=18dd03a3fcf0ffe27da0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=104f9c27980000

Note: testing is done by a robot and is best-effort only.

