Return-Path: <linux-kernel+bounces-397263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6089BD98C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 00:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FF8DB228C9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 23:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824A7216214;
	Tue,  5 Nov 2024 23:16:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1B7215F4C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 23:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730848565; cv=none; b=IUX/f1yt2DSkqH7+EdYUGgnGaTTS9SQzga7DgHltPE4wkcESM9Qi6shQpFnAzFmV+w8Mh95sJK8ZGKVxRCtv5JA+jeC7aQG6NeDmjVNffPtbp+c0laj6zOmJyoJfBrrTfyYuKtZDOo5o21Tp4WSIobscX6dx0cdzbpTl+R7S9k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730848565; c=relaxed/simple;
	bh=dmQxO8OfdvP4S5/++MWziDEqqBDg7ePp8fhrgJWkz7o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SP4L16IuZEKLY5F4TICLc/iYS0MBGe3G2BZBPn4ohLpevr31xDK53/DUmMU5fzC8EiQkLkHMuiFFK8nYBjlX8jIKpGTYiCOwEDNPMHhWPEWDRJbzITQTeeDzllmjMO8AJBRsTq1pwyybfqvogMRKmQTNn4vZn3Xcc2BvNWqXjVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3c3ecaaabso75326785ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 15:16:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730848563; x=1731453363;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hp0NY24zUAY5UpSOJOg6xZiRX3DT8TdC+BNptJw8AmU=;
        b=mrNLvZosh6Ke9RsigeEeJoqeycvXa3LFRMCT2g2+v9OtDxhSbtPnq1HMZG0/vADVAO
         0FQazKym0kcAHCQHHE1Oo7vgxglll2UzXa6kSpmPajno03DJ9siUpd1ASe51HkFWIU+Z
         ItCeKBGle7KRwvkfFN1cdwzPkYuV4YmYEtP53rYpv0vIyiaVT7tz9AApMBjEW4+RCmzg
         cn86JUAMLYSpG+Eg0uB2/qZVgm93ZoINKcOG/voHPjGOLJT6hPeDvOkGV4g2o00gky08
         tnY265giZFzXnrvEEdWGeZHxQUSf3pH/HW9VCf3kY/5jeWuickR4/9ZZ1SfW656e6K+W
         8QGw==
X-Forwarded-Encrypted: i=1; AJvYcCUXU/UT5UQ2Xv7SIkrQC4MBuuWu/gwMUEF9Pw8lQ8rdWfU1Be6bEcrxnZzh6v3AJ2XMYounS5Fp1V3fppU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjCQfmZztqEsMQJ090WXCnW/mAQwsqvwOLoc5kckl51o8EnShY
	MbThY1mvV6647OiDHPwrLLDloZkIvKcKe+2Wy2CD3CP29zqFHjPbCMi0WYnTPuD1iyjvDuf5s1s
	AeprnbWJBcuGWyzX8chWnfMJ87YCaGChysZTcnrDdX0PneF7gmH+VvQQ=
X-Google-Smtp-Source: AGHT+IHUC4h1dx6/7A108sGTumZqI+RaqGH+Ti6SoVeG1AKe6c5rZnvsxrJj1jmYkS+E3ssIUC3Ozs/9tpOzJr6lVMpa/HyDWwPi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180f:b0:3a0:480c:6ac4 with SMTP id
 e9e14a558f8ab-3a5e262eaeamr309952905ab.22.1730848562795; Tue, 05 Nov 2024
 15:16:02 -0800 (PST)
Date: Tue, 05 Nov 2024 15:16:02 -0800
In-Reply-To: <20241105224648.3310-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672aa732.050a0220.2edce.1513.GAE@google.com>
Subject: Re: [syzbot] [block?] [trace?] possible deadlock in blk_trace_ioctl
From: syzbot <syzbot+a3c16289c8c99b02cac1@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a3c16289c8c99b02cac1@syzkaller.appspotmail.com
Tested-by: syzbot+a3c16289c8c99b02cac1@syzkaller.appspotmail.com

Tested on:

commit:         f9f24ca3 Add linux-next specific files for 20241031
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13f49d5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd0e833c188d474c
dashboard link: https://syzkaller.appspot.com/bug?extid=a3c16289c8c99b02cac1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15957587980000

Note: testing is done by a robot and is best-effort only.

