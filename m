Return-Path: <linux-kernel+bounces-257469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76968937A7C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E811C20D59
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FE5149C6D;
	Fri, 19 Jul 2024 16:10:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1DF14659B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721405406; cv=none; b=B3hxGtc3ARZgup76kvhW0/9stqugyZxv3X8Nmqtrx3pbg90H8gMLFJprx+afhLip6mncxzz7GZGXmoFAobVhTq4cbAiYDtft54DDwpG0+fZaSCjmb/El/ZedCzzBImPnqn9r1CGY2c1aW7xEGRcLA47KhSfBuJ7MdgMervqEiHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721405406; c=relaxed/simple;
	bh=lDeEEMZ0Kpxwhyf4sKV3soVZgWPwvae7hyUqD0wr5PE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hmXkKbqzexsVW6WW6BHE0q5Z0BuSJv8i4CivBnOV+TkwLNt3h/7JOCZnNQ+gepcBl8rCa9szmmgxCdwvj3/t0gl8RTI6/xBnt2HXwVDB34Q/Wr6Xi9R53iVL82/ic6k7wSaKPEtr9x1lh8t/mV4KhQ79TaufS61jW7V5mwbLb6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3971269bf67so29104565ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721405403; x=1722010203;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OYTriKvCSORA6mjoEyZ/j31hod0+/l56TzyUyy7BS20=;
        b=EMyYx3+WbnGjrCzG4OASe4mIjNSbbuxFImP285Fn13T0w4J6a7kpdZFdJnHOdAronB
         HQHks6OUUEJGIHz/arNKont8nw21hSrF+2W1u0FKD3IMLEjwnW1NCaEXurTQ91oqXen6
         wx++vm7mrA+RRniTUWHwqmNDblFsQ7Qf+bhUacsPix20M5s951umzRwbzWts3ee4agby
         gLGREJ9CdTKRlN3jSNkXlPJl20UNbi+6dryc1Wv8+gjoeiCuxrUeMkOF0pA2aH3/IoDU
         dY2HpK/49dUuIRlpwH943fOEupI/BfgrAkFjpVU8+sY9/+Y0gJSEeFz2OPnzraEAg2g1
         I6cw==
X-Forwarded-Encrypted: i=1; AJvYcCXtvs/hzeiQSNYpXv/GPd5hCfARvShCfEZgcUyp4AKCnPiJu8HNRgVVtIJk9HxFQQA7oQg5EdJ9zaUoSE+H6d9KbUKljt/Ch0wAJMW3
X-Gm-Message-State: AOJu0YyTNe2tVXa1EN4IxK4nIDPNe0U2hzl6RdFBtoy+yzn5O1GTA5KQ
	o8Y1IaIyBmysE6FbRYbMm4B49iRYeqrKTgtnWSQiQ5yAth6MbWVHWUttBmfENro5dIDynjSzUSn
	znBejMOBJGXeU//sdCsVnapvvSJwJ77hcAhtnybyrpiMtVKYvln21bOw=
X-Google-Smtp-Source: AGHT+IF3rcbWSEZyq+y38uvz/jUhjKbV/qZgiis4/0Fdjga073/TguKJYLufFks68w9Ze6uaOVdbTrLSgYtww2YCW/AhXfz9pjBM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a0d:b0:380:c34a:df56 with SMTP id
 e9e14a558f8ab-398e81c7e16mr98865ab.6.1721405403495; Fri, 19 Jul 2024 09:10:03
 -0700 (PDT)
Date: Fri, 19 Jul 2024 09:10:03 -0700
In-Reply-To: <000000000000e4d9eb061d719657@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000097148b061d9bed31@google.com>
Subject: Re: [syzbot] [bcachefs?] general protection fault in bch2_checksum
From: syzbot <syzbot+dd3d9835055dacb66f35@syzkaller.appspotmail.com>
To: bfoster@redhat.com, cam.alvarez.i@gmail.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 03ef80b469d5d83530ce1ce15be78a40e5300f9b
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sat Sep 23 22:41:51 2023 +0000

    bcachefs: Ignore unknown mount options

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=118fe60d980000
start commit:   0434dbe32053 Merge tag 'linux_kselftest-next-6.11-rc1' of ..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=138fe60d980000
console output: https://syzkaller.appspot.com/x/log.txt?x=158fe60d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4b8bd5292e033239
dashboard link: https://syzkaller.appspot.com/bug?extid=dd3d9835055dacb66f35
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d9ccb5980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12633a79980000

Reported-by: syzbot+dd3d9835055dacb66f35@syzkaller.appspotmail.com
Fixes: 03ef80b469d5 ("bcachefs: Ignore unknown mount options")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

