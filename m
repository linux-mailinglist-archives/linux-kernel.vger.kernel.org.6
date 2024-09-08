Return-Path: <linux-kernel+bounces-320184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF56D970713
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 13:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7C231C20971
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 11:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1980157A41;
	Sun,  8 Sep 2024 11:49:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0096A14A4EA
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 11:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725796145; cv=none; b=t4QbxwOsrNpaapO0Yf84NJp3Y8dco1yNIC7yoPFa+ViPnSIzPncZOSWNrt0GU69yfbaJj7EQ2H8MEJJ+R/+7CsnkQFrah2a0kUuHcdMalMsc6CZEX3RrLqb42z8jrfHTnVVdJBRWpc1t4EDm/pRR2osQLb9FWrsL1b7bBg14oEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725796145; c=relaxed/simple;
	bh=FtPMUT7b/Xa1vZMVFvkbIZ50NPkPV7CUSaBBVdDPVUc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mbMwxWQMiIi6UOz49FjXhJyJYz8frHvHq7EiEP+yKfY0LGhmlcSd14HPt12Abz4ma+ZLS/42v+2TsfmC06bSWukqlxU1q8BzhYM4GAtsagEGvP9y0Pnw3Y0eEJH0K1N8z89TCG3Mxrqhoyaq1duouYpDDRlVSnDDxwBPd7thPYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a04c905651so49805825ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 04:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725796143; x=1726400943;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+/tq4xYQWvT5fiXjt0FlpRNOhj/9bXAIMHLy8sFrCA=;
        b=Xs69xJLbXZ2QhkjaNjamIqc/bUecKSy2tvHBNkEXm9xLBHc0WbnqC6d8YmYK+Jf/J8
         9ZUYZlUSmUEEZI95oTLqzEmTLC721oGtNPq6V3Rb3X7M4unWzQyOTVp+wPU/IQY64TPE
         J3Iy6PD+/fTlIctvV4x+xd1bDOjCoe592rQ/uPGGJ0YXHqgLtXormgp24y46uglTQukS
         i3T5MiabBBTybTXLkdqFTPHHDu1sXEatiaAFD3wsav1UCLf03GA9dTQbBKY6Tv4Mms1p
         OKHMLA7x7CNp4zD73PpN3Xlxl15wd/ebTtMYsIXZW9GFie0bY9nAAizzNBPcTffKWhUd
         JwaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUReqa4HUXUeMc3il/u9eB0YI/nDotMKvw1eLi9TkGNporm8qqq7VyBPzlSEqGMjLsbICjbVK4D8ta82iE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO2uDGr8ZFSadwWwg+9gp8TBbPC4j+dilqsogCnwxLbnM8HoQ/
	Y6Uxb6//aov5Sk4DJdYhLPDfrjEVOqz1xNAKWzX0s4alK7BaG6cwIclNvNm29iuM7tH2lxVWT0R
	DbbHuXCZzBfZDmf2gqzI2VZpeCuGYbTcQwlNZVtz/sRxoUec1pszim8s=
X-Google-Smtp-Source: AGHT+IELgGGBkCyTbxJsUVRTrcdR1K4Jc9RHV0wFwlsg8j2hxgA5FDD1hybQL1V2mAApFHrkdsSLwSk5indHCqn0whltBD2U/ALF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aaa:b0:39d:5203:1636 with SMTP id
 e9e14a558f8ab-3a04f0e232fmr101252065ab.24.1725796143160; Sun, 08 Sep 2024
 04:49:03 -0700 (PDT)
Date: Sun, 08 Sep 2024 04:49:03 -0700
In-Reply-To: <20240908113313.14315-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000011796d06219a3a94@google.com>
Subject: Re: [syzbot] [mm?] KCSAN: data-race in generic_fillattr / shmem_mknod (2)
From: syzbot <syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com
Tested-by: syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com

Tested on:

commit:         d1f2d51b Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=158e589f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e81d40b0108ea8fe
dashboard link: https://syzkaller.appspot.com/bug?extid=702361cf7e3d95758761
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12b6589f980000

Note: testing is done by a robot and is best-effort only.

