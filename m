Return-Path: <linux-kernel+bounces-342412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A99B988E98
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 10:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7931C282A72
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 08:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FB119D8B8;
	Sat, 28 Sep 2024 08:46:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684D714A96
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 08:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727513165; cv=none; b=IQZUlve7fjSXPJ5gWI3haTPoBUpK5MxtpbCuWaBlYqhZGWVK5A+Z19tbqUP6d1avsnv8/GJPoWN+MUKTNSGbJ6FWZp2ISyHIO1KxOw/JuEDvVzMlPr1t3OFWuprUM6OU82V1PMp5Yv59OQ/u1XLmNmzp/jgZBbEVjeMF/j5vPvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727513165; c=relaxed/simple;
	bh=dULr5vQvjZerTrNInDWoA8qB5iegQOAaBJWlaxAOgyQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eDw6B1KGyk8pVOeH/T7P4NTnDgL9poUSUUi0OhjkiVm1o6H3eUqeM04h42trxKJcEFNgNS8pAGFG8D9345X8vzDLJ5a7IzsqQGQtuxzWBjnvi9ifnM0LMLP/jpP5vm10j7I/0J0ykhek7UyQJkX80vCL3AQC6NsyB6zDMjvy/B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a1a6d8bb03so38635385ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 01:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727513163; x=1728117963;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ze3+Q+28oyVTxnA9JGjjLfFbpXomBkA4uygSWmmVPGw=;
        b=puMLMOLHHy3MBHUrFi16kaqMt8DsDWArgXv7YwznsqQ2/7fmiornrqPZgTHs7lz5F9
         KW+MW0jwAe8fh3hlR/1/yPJDuLMAPoU+RJWwiai9i5ImchD0r6u2f/co735QO4G54dA3
         /J4yUK/2teYnmvh1vKdtd9v63ROS+e2F7Zkl4M0dpeAnKjqgIFv8GVzObeYkdE2uEoku
         O7K6Uj3hxlS4utrOS6jdKtG9tj6NM3/FdfOzfvuIAIZCE/zxweGmZZ2kVTvfmf2Tv+3r
         sYvRwm8HgxGzfoixmgZyoiyWvF0Zyf/cf4PXA7cfJjRMyrI0WyXIka4nXPwrl2io1YfI
         8adQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCbR8RMzgp7iJb2Ei89Bt76UZTye4gUEfHe+0XghfAlQVWI/ZjlN+Un0vN9k8UbMs22kNkyHG5eMIYaBc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywiue6e+FNEQ2Y0JoCxanCh3dRQLjad6ULHJSnfMX3xBDgJePxU
	8vMLiVNg/2kseBYBgoDK9swSS5YYP57SY69hO/QxmOrdlhvWS7Bhq+LjwtJc39UURkXPuEVM06A
	OzIshZHYTQpF/ZiiXFAMNDy/e2vvDwh4a8w2U39+CD1017E8Csw6j28M=
X-Google-Smtp-Source: AGHT+IGci6gnS60gepj/GmKxMJniFciANPAciAYh8DUm6+1j9yOUEb7GrIs5TtUtViWm4nJve6Alw1fYoS/xtqyZ11uwDwr9OhIZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c269:0:b0:3a3:35f0:4c11 with SMTP id
 e9e14a558f8ab-3a345195357mr56482005ab.15.1727513163529; Sat, 28 Sep 2024
 01:46:03 -0700 (PDT)
Date: Sat, 28 Sep 2024 01:46:03 -0700
In-Reply-To: <tencent_8709932EFAAED0CCB0A7DEC6F592C9465306@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f7c24b.050a0220.4a974.0001.GAE@google.com>
Subject: Re: [syzbot] [integrity?] [lsm?] possible deadlock in
 process_measurement (4)
From: syzbot <syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com
Tested-by: syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com

Tested on:

commit:         ad46e8f9 Merge tag 'pm-6.12-rc1-2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=158d1e80580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ea7afcb1f5a67c
dashboard link: https://syzkaller.appspot.com/bug?extid=1cd571a672400ef3a930
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12a20d9f980000

Note: testing is done by a robot and is best-effort only.

