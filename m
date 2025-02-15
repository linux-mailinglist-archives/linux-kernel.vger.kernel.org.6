Return-Path: <linux-kernel+bounces-516298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8215A36F72
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 17:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A8F73AF238
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 16:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5239E1EA7D4;
	Sat, 15 Feb 2025 16:22:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4E51624E8
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 16:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739636523; cv=none; b=KZDD0PTVf+4ZtgSJ9qtSmJVbfhpa2/+FTfiuuA3kxVxTU1abiMVo+6Q2QQvAZDBO4hsGU91uP2d5qnkFk1C+BZWVc9g+Sc+V5E6BEbFQ1jVB2dC1/2UjcIiUJLhlUQZnG69WHTF+odJyriH88xngRiPVQf6qQ6XtiNTW0/n1Szg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739636523; c=relaxed/simple;
	bh=IG/5jApV2sOSl8a3GEyu/nbUQiVzZuOltqY088VSr6s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kd8FssznRUnBTc51IeeOz6cjoz813QUU9+1vtNOeyXlnnbnAoRT/dlLlEa+j/BzTYnCM1nzXTm9wcjYL9D6j3EP7dYrw9we9rnCilLkHz/+hq1PACN+2R4uoCUpvhCmcXS1FPr7PRWMvc+XZl2OY40NOoCLB1SXJ69AOHu+AtXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8556ffa0a99so133528439f.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 08:22:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739636521; x=1740241321;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s0qTm4qCvLRYalG9z/HrHmtBGe5kHsJD0r/taF4MuuQ=;
        b=wMyAiGzOCrZx433RcfRPiNPRtju07ECJKTVWfwI/izU6QIf5oIaqkwUFGU09rvl0XJ
         XEpkd/8/oszzT5dQNskA2tWT48XxM7yDAa+bIsJlNe+Wtg47/oFElYRqQ8fvZDC/sQrC
         Xu7VPBl68EtNlCYE58MPAUcx3jZzYlhuFzXD7fVM8jqTyBOw/Fb0RQL6AmsnqqWn/xUo
         ZSgqtaaUTUGdQZRrIEiuxDqbnkWptlBJbKpgHLTD5/4z9gq+bOcnWOwAGlA8QSjm76pt
         X7uSqFgugM+OjoKESU7+FAaWMotzqbwv4gUw9YlbtvCpSEaxJj5oLALjP7W+u79McI50
         5mnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNVMQcjIGaQmfVACJwRfESy2886gttGCxgSSMDYPLHyh7E75NLa7hghFnb9p1aFWY8dFdplg/002PAy6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFatt6WvyT8M5RRdasxH1eHtolMYz4WcT8JUvE0/3mSjlJ0lqW
	SJ6/BbgM4zACws0tvLoM2LAFNEKTIgsjBrMnOXzHyvV/Weuf50HEAf6iLxFVEnMqv8TrI5gAqJZ
	6JqiEfdU6WuhQ+Az/xeclchN96EPkxeJmIYdjAHI91hgMezDSGONtldI=
X-Google-Smtp-Source: AGHT+IHRq8GM6tfXpOlFN58zTXBcLQBL4mQaH5rBniMTJZY2Z7rN/MmFFcpQeaxnOqe9pRomS/ZoliUh7/cmnvphsSIgdzUvAVrp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c3:b0:3d1:946c:e69b with SMTP id
 e9e14a558f8ab-3d28078ed3fmr19259425ab.8.1739636521714; Sat, 15 Feb 2025
 08:22:01 -0800 (PST)
Date: Sat, 15 Feb 2025 08:22:01 -0800
In-Reply-To: <67afa09f.050a0220.21dd3.0054.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b0bf29.050a0220.6f0b7.0010.GAE@google.com>
Subject: Re: [syzbot] [kernfs?] [bcachefs?] UBSAN: shift-out-of-bounds in radix_tree_delete_item
From: syzbot <syzbot+b581c7106aa616bb522c@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	gregkh@linuxfoundation.org, horms@kernel.org, kent.overstreet@linux.dev, 
	kuba@kernel.org, linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 14152654805256d760315ec24e414363bfa19a06
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Mon Nov 25 05:21:27 2024 +0000

    bcachefs: Bad btree roots are now autofix

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=152659a4580000
start commit:   09fbf3d50205 Merge tag 'tomoyo-pr-20250211' of git://git.c..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=172659a4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=132659a4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c516b1c112a81e77
dashboard link: https://syzkaller.appspot.com/bug?extid=b581c7106aa616bb522c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e449b0580000

Reported-by: syzbot+b581c7106aa616bb522c@syzkaller.appspotmail.com
Fixes: 141526548052 ("bcachefs: Bad btree roots are now autofix")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

