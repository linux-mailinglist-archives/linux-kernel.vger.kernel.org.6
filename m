Return-Path: <linux-kernel+bounces-273317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9E6946751
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 06:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 770E11F217EA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 04:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A545929414;
	Sat,  3 Aug 2024 04:09:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C001C6A7
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 04:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722658146; cv=none; b=fo3hrbLgsLIMBHOFeRzyuyE8me7NnAYXXR9cDLbzr8gbypXvvohzOrNdm5slauPpbUbq3CDyeRqcDXMYjXV8Z2vQLVH07HaCqll8JnBWPiTuUCH68c5YBrS2X3HKcmVIgj5Cy6CQFOpelXwbzJCBZ3hbj0mba4SzZtA98+SbYUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722658146; c=relaxed/simple;
	bh=G2QLznKCNxkfXNbVxecnOtA0jV19W52S8l/+aWl96ig=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HAdke/vuPKoLvGU6TkZ8UewGrO7PawiNjnDht7zBZDjWAHJN1O66eH3ZPsm9CsUnzH8hx1Yf8cfOdDWAEEqJY4qFSQtO4F65JJdA8x7T7T0N5/vlngYKFItYsm8ezFV/xrN/zwcTqu5eYpYUD1BectjMCeR1HsM8aRiACmyVnrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f9612b44fso1214029139f.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 21:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722658144; x=1723262944;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9kUejpJ8rapsm3foCfc6I1wyDAKziXGXRtittmfSojE=;
        b=wJRIOisysRos28h+pQ1HaBZWJONNptR/Z8vfcWgF5ikGrUoZRg5RPN9pF2EMMHfxKv
         bCNtqnFQlyQOxprmz3r3+o+QyMXA0+mYnMOCfjuMfKVnEnKTYLbnewPBfXgQMwImYzz7
         IzfOjEwmiDvd/MQmEqrN/X+r+f1SyTn5V5O7d5F3NKpLcZnmzfws0kWTTzj2aZdY+cft
         3jLRq358mGMrTAV0kBXTpKJ/pRkPPzYnT5Hp2LOJm4vC4DWNIK8AdG0NIpJGyXyFNay/
         YX+NgcIT/lRN2/xL0Up0ncyxROzaO6wFHcMmmv7+dkiJ3am/418RVQUBGkXup/xTg8Lf
         Pyjw==
X-Gm-Message-State: AOJu0YyvQLr07VHcPRziKQXdliuj35sJnCwXWcJDa0lA5GqEBexilacS
	yLt670Fzhe9749N8gdpzu2lRWLyLEs2SGGWn7Gfoy9zJgJ1xsDpLKClVWsLkSx9pl1WMoet/X3k
	f5rUI8VPSiXNAppjqdakzS6xkTLjEsH5DXOVuMPFdcgtTKG+vYBquc+E=
X-Google-Smtp-Source: AGHT+IHPBcc2NymRI2XTCrreWVBHhaBEZ4/Ewr5XcbmZ1PSl8rSrqj/ZFRWUe3Vdm7mo0f3nWeZ68ywgg1dXpQeYdkj5Pkr11eab
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154b:b0:397:95c7:6f72 with SMTP id
 e9e14a558f8ab-39b1fc8baecmr4190805ab.6.1722658143765; Fri, 02 Aug 2024
 21:09:03 -0700 (PDT)
Date: Fri, 02 Aug 2024 21:09:03 -0700
In-Reply-To: <20240803031347.1275196-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ba9969061ebf9ae7@google.com>
Subject: Re: [syzbot] [squashfs?] KMSAN: uninit-value in pick_link
From: syzbot <syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com
Tested-by: syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com

Tested on:

commit:         2f8c4f50 Merge tag 'auxdisplay-for-v6.11-tag1' of git:..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=157dce6d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea3a063e5f96c3d6
dashboard link: https://syzkaller.appspot.com/bug?extid=24ac24ff58dc5b0d26b9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15cbe1c9980000

Note: testing is done by a robot and is best-effort only.

