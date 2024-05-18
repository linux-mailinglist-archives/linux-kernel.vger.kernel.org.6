Return-Path: <linux-kernel+bounces-183004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CE18C9316
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 01:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF4361F21910
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 23:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EFD6CDCB;
	Sat, 18 May 2024 23:50:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213586A33A
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 23:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716076205; cv=none; b=fy4U9Ia5Aa5OrNnzt8wjHepyncpKYCAQXh+ZzDVcwcAiZe2HyYECs+J7VEggwbvLY/hMpfQEc3cRu+odlnqsP484OGrKEvSBOtHY7t9qkkdUPZh2SBl+c1XsFc8KpZ9gY1/HYV66QsRakRHvbQK+XIhq1lvVSbAQXsnoXmr/dwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716076205; c=relaxed/simple;
	bh=mwP/M14lZOGIO1TqTXJ3qoWjZmYh/ZOW/f9bPrgTrqk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Idh160kVrK6uh7eN7c7qQB+MZGOJCnLYRHTNL4OoF/+AOdoDAb+fcvxsmoaDtQLC3a3O2XUYSomLjzzU/r8IKX2woetsr15rhdFHYQvEqg/YDr5nMjdzPBNtqRePpaGm76rEGyVYv0RRhvzx0uZKbcxBXIdRdE7g0JPHByJUQkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7e17a8bed9eso1032076739f.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 16:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716076203; x=1716681003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iH0XCYrUnS6YPJOlGDx28Qx7hqQYGkSbXWYyUNaU6UU=;
        b=nZt3vNqomay7Ft+uXyMiK/HkFUqmI3hT/IVnVpCBwQ75UnYRIHCUrPnP3SZGx9WWKf
         b5XOxngraVHAO7fpDBzRdu5Ud/cbmFi65d5k/YAcrbGFakRXIIYQx91RcVZGuKRW8WEY
         P8pDoD+usE9hFwNoa1yNLvyUcQGwx4+lsSV4D/BIHyzV1R9HONwev3CFqU1+P8v4or5H
         js+vkDY0W5S5+d4dO9SCOeI/1E0cin7Yu8R5Qg8p/INgAgK1aWKAObrzk3SyhBly6Klp
         AoND+/zGHPp1/T7CZPkfUlzJ47/YeyFc6uE5Zm65Dmy0yM1+M1QkxCQ7+sExnzUlcSck
         KJhQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/++ab/2NglQCRoW9UiWdh7SnI183qMc495sqaOgxY48Spbjp5iUnxyApF9evN+oKAvSw8zZgqdMn0bWtvTT2t6jZOkSBiVa6YRdaT
X-Gm-Message-State: AOJu0YwXLeEWfdUNDVSsgiXg5WYYImgsyjiwIGRSPPuzkDwPjYV6IhR8
	VhG3JDflXrH47+AyfaN90kblDobE3Wcl6KISfdYLl+2joUAVMyfvmWdpFv9bS9HoFxYkMxdZGdp
	4JjjGR1o33qgIw4V+nPvXH/QTETZARRUGMlbBrp2+K5eg5LFBGOakdns=
X-Google-Smtp-Source: AGHT+IF2AEO03sVbn2S0C+C7IgY5YhkJ8uz9YEdgko3AQrH3sltR2e0MIOXyjxQXRkWre4y3vdtlFEDkYHir5hDYJEXQU4utu5ne
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8523:b0:488:5ceb:9533 with SMTP id
 8926c6da1cb9f-48957ec306dmr1581582173.0.1716076203076; Sat, 18 May 2024
 16:50:03 -0700 (PDT)
Date: Sat, 18 May 2024 16:50:03 -0700
In-Reply-To: <20240518230144.1856-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007dff750618c320c9@google.com>
Subject: Re: [syzbot] [input?] possible deadlock in evdev_cleanup (2)
From: syzbot <syzbot+77a2ec57108df22d5c63@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+77a2ec57108df22d5c63@syzkaller.appspotmail.com

Tested on:

commit:         fda5695d Merge branch 'for-next/core' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1507e5dc980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95dc1de8407c7270
dashboard link: https://syzkaller.appspot.com/bug?extid=77a2ec57108df22d5c63
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14a15634980000

Note: testing is done by a robot and is best-effort only.

