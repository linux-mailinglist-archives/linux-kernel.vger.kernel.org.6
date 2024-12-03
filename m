Return-Path: <linux-kernel+bounces-429230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B05D9E192A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32437162353
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E281E1C04;
	Tue,  3 Dec 2024 10:24:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7565C2A1B8
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 10:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733221444; cv=none; b=nxI/6QfLJZQXKQaD6xcWRRXNEi1sST3Bf+UCeIJjtWRmpYxsjXl1o+5vvWEshA3i1f/ZpZ1dT3quMWkZTbh0Ti90IYBfwN6sNBeRn9GjcbM+exy3tq+qucdE4cGgz1juIO+15ggW4RrD05MlmFoftbuB0PRj9NGinfa6jUXKMEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733221444; c=relaxed/simple;
	bh=Xs2mbSOrRuLsod25ObonO027T0kX77dvwHQtUUoXdUA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KsrnJX4ODpe80r628B+vjr9HYwYPtTwUXE62GgXPjWUGSn1e0tlGp5sxAtiEgFg3dfI6tJ9ycwoa1Haq8bQexuFKmRh4jlaKg8e/gcpIj+1IMoKhWxftZj2s54YsmJSEqFeSzL8nSlBp5o+RVofeFV4hmNmTvrN84vvtzTg1WE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a7e0d7b804so40391345ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 02:24:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733221442; x=1733826242;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RSrCnTK4gpc74uP23a5NcOis3BRMNDyXkyMY1zX3xVM=;
        b=TSpO2x8qVJhe0hBrZbaZZd8AInABRWE+BFxPfxyPn8YdCDCtNGnSzIVN94IEahhq2s
         qft8XsJFcsNTUNybb4XB8ffPTFY+tWGnYxkN7PEyLHCR5gv/prP5haCGYzqFP0u8lpXx
         LLY273ZG7LNyRXU60sMTTA6JVZTk7UoeOghebP4+fli3OO8d9SxrylBk8pvjpKvOjhOi
         qC2rtBIbyY85cFqRtSqIVHFUFeMkTlwDU5XXBEfU+bPaTObWiqUMvG4dKHdEoGl/qd4F
         f54lYPKVdg7/OEfMscVgu4vhs9Gyc+NhP0vNxtMUXIlnnvHU5OHxs20lJ528SiI56GCC
         CmdA==
X-Forwarded-Encrypted: i=1; AJvYcCXjbQD5wTlppWdcjIJMId0UEDbMQa7CJVrYFoJbuN9pWGj1ZwD0t6IvdT2bSkcylqOAak7wros1uRj2ufo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxumKhH+rwwgHOUkIZSrLFtgUrhNLV8wVazqwcjvv56do/dwiKu
	65ebVt/Ua7/G3vLXZfbK4eCMzqTF5qfTrIybaD9qHd/1ZT4rJFmVsXvKeQdBDQnrADRSVUpbq14
	aL5csMQG5DWzjQqBe5fRsP+PTrfTkYHuyxqKVfFl9Y6/SRa8y6gegwbQ=
X-Google-Smtp-Source: AGHT+IGN2LsBQRfkUFR2Bv7jSkN1ZdBJ4hypW2nPRSe9IVBhLHRXmQQZG11Kk1yLJTJFu9+/ikgM/EGt2ujj71q8CofUnSoC1TiM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a81:b0:3a7:e67f:3c58 with SMTP id
 e9e14a558f8ab-3a7f9a2fb3emr28239895ab.3.1733221442598; Tue, 03 Dec 2024
 02:24:02 -0800 (PST)
Date: Tue, 03 Dec 2024 02:24:02 -0800
In-Reply-To: <tencent_DF670373896E43A6E4491760F77BA6CBB305@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674edc42.050a0220.48a03.0033.GAE@google.com>
Subject: Re: [syzbot] [jfs?] divide error in dbAllocAG
From: syzbot <syzbot+7c808908291a569281a9@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7c808908291a569281a9@syzkaller.appspotmail.com
Tested-by: syzbot+7c808908291a569281a9@syzkaller.appspotmail.com

Tested on:

commit:         842f896c jfs: check agwidth before calculating the con..
git tree:       https://github.com/ea1davis/linux jfs/syzv3
console output: https://syzkaller.appspot.com/x/log.txt?x=17ee75e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=18d90fa8ec96d8b0
dashboard link: https://syzkaller.appspot.com/bug?extid=7c808908291a569281a9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

